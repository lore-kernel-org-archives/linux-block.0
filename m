Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21692C282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 06:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0142D24DFC
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 06:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFDG4O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:56:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbfFDG4N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Jun 2019 02:56:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49F773078AB6;
        Tue,  4 Jun 2019 06:56:13 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AB3110013D9;
        Tue,  4 Jun 2019 06:56:03 +0000 (UTC)
Date:   Tue, 4 Jun 2019 14:55:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH V4 3/3] scsi: core: avoid to pre-allocate big chunk for
 sg list
Message-ID: <20190604065558.GA6059@ming.t460p>
References: <20190428073932.9898-1-ming.lei@redhat.com>
 <20190428073932.9898-4-ming.lei@redhat.com>
 <20190603204422.GA7240@roeck-us.net>
 <20190604010002.GA24432@ming.t460p>
 <cdf94e43-79a7-078e-676d-dfc736eec286@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdf94e43-79a7-078e-676d-dfc736eec286@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 04 Jun 2019 06:56:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 03, 2019 at 08:49:10PM -0700, Guenter Roeck wrote:
> On 6/3/19 6:00 PM, Ming Lei wrote:
> > On Mon, Jun 03, 2019 at 01:44:22PM -0700, Guenter Roeck wrote:
> > > On Sun, Apr 28, 2019 at 03:39:32PM +0800, Ming Lei wrote:
> > > > Now scsi_mq_setup_tags() pre-allocates a big buffer for IO sg list,
> > > > and the buffer size is scsi_mq_sgl_size() which depends on smaller
> > > > value between shost->sg_tablesize and SG_CHUNK_SIZE.
> > > > 
> > > > Modern HBA's DMA is often capable of deadling with very big segment
> > > > number, so scsi_mq_sgl_size() is often big. Suppose the max sg number
> > > > of SG_CHUNK_SIZE is taken, scsi_mq_sgl_size() will be 4KB.
> > > > 
> > > > Then if one HBA has lots of queues, and each hw queue's depth is
> > > > high, pre-allocation for sg list can consume huge memory.
> > > > For example of lpfc, nr_hw_queues can be 70, each queue's depth
> > > > can be 3781, so the pre-allocation for data sg list is 70*3781*2k
> > > > =517MB for single HBA.
> > > > 
> > > > There is Red Hat internal report that scsi_debug based tests can't
> > > > be run any more since legacy io path is killed because too big
> > > > pre-allocation.
> > > > 
> > > > So switch to runtime allocation for sg list, meantime pre-allocate 2
> > > > inline sg entries. This way has been applied to NVMe PCI for a while,
> > > > so it should be fine for SCSI too. Also runtime sg entries allocation
> > > > has verified and run always in the original legacy io path.
> > > > 
> > > > Not see performance effect in my big BS test on scsi_debug.
> > > > 
> > > 
> > > This patch causes a variety of boot failures in -next. Typical failure
> > > pattern is scsi hangs or failure to find a root file system. For example,
> > > on alpha, trying to boot from usb:
> > 
> > I guess it is because alpha doesn't support sg chaining, and
> > CONFIG_ARCH_NO_SG_CHAIN is enabled. ARCHs not supporting sg chaining
> > can only be arm, alpha and parisc.
> > 
> 
> I don't think it is that simple. I do see the problem on x86 (32 and 64 bit)
> sparc, ppc, and m68k as well, and possibly others (I didn't check all because
> -next is in terrible shape right now). Error log is always a bit different
> but similar.
> 
> On sparc:
> 
> scsi host0: Data transfer overflow.
> scsi host0: cur_residue[0] tot_residue[-181604017] len[8192]
> scsi host0: DMA length is zero!
> scsi host0: cur adr[f000f000] len[00000000]
> scsi host0: Data transfer overflow.
> scsi host0: cur_residue[0] tot_residue[-181604017] len[8192]
> scsi host0: DMA length is zero!
> 
> On ppc:
> 
> scsi host0: DMA length is zero!
> scsi host0: cur adr[0fd21000] len[00000000]
> scsi host0: Aborting command [(ptrval):28]
> scsi host0: Current command [(ptrval):28]
> scsi host0:  Active command [(ptrval):28]
> 
> On x86, x86_64 (after reverting a different crash-causing patch):
> 
> [   20.226809] scsi host0: DMA length is zero!
> [   20.227459] scsi host0: cur adr[00000000] len[00000000]
> [   50.588814] scsi host0: Aborting command [(____ptrval____):28]
> [   50.589210] scsi host0: Current command [(____ptrval____):28]
> [   50.589447] scsi host0:  Active command [(____ptrval____):28]
> [   50.589674] scsi host0: Dumping command log
> 
> On m68k there is a crash.
> 
> Unable to handle kernel NULL pointer dereference at virtual address (ptrval)
> Oops: 00000000
> Modules linked in:
> PC: [<00203a9e>] esp_maybe_execute_command+0x31e/0x46c
> SR: 2704  SP: (ptrval)  a2: 07c1ea20
> d0: 00000002    d1: 00000400    d2: 00000000    d3: 00002000
> d4: 00000000    d5: 00000000    a0: 07db753c    a1: 00000000
> Process kworker/0:0H (pid: 4, task=(ptrval))
> Frame format=7 eff addr=00000020 ssw=0505 faddr=00000020
> wb 1 stat/addr/data: 0000 00000000 00000000
> wb 2 stat/addr/data: 0000 00000000 00000000
> wb 3 stat/addr/data: 0000 00000020 00000000
> push data: 00000000 00000000 00000000 00000000
> Stack from 07c2be08:
> ...
> Call Trace: [<00002000>] _start+0x0/0x8
>  [<001f65ca>] scsi_mq_done+0x0/0x2c
>  [<001887fe>] blk_mq_get_driver_tag+0x0/0xba
>  [<00188800>] blk_mq_get_driver_tag+0x2/0xba
>  [<00025aec>] create_worker+0x0/0x14e
>  [<00203f64>] esp_queuecommand+0x9c/0xa2
>  [<00203f3a>] esp_queuecommand+0x72/0xa2
>  [<001f7fd4>] scsi_queue_rq+0x54e/0x5ba
>  [<00188b4a>] blk_mq_dispatch_rq_list+0x292/0x38a
>  [<00188656>] blk_mq_dequeue_from_ctx+0x0/0x1a8
>  [<001888b8>] blk_mq_dispatch_rq_list+0x0/0x38a
>  [<00025aec>] create_worker+0x0/0x14e
> ...
> 
> All those problems are fixed by reverting this patch.

All above problem is esp_scsi specific, and esp_scsi does not support
sg chain.

I will try to figure out one patch to cover all.

esp_map_dma():
        if (esp->flags & ESP_FLAG_NO_DMA_MAP) {
                /*
                 * For pseudo DMA and PIO we need the virtual address instead of
                 * a dma address, so perform an identity mapping.
                 */
                spriv->num_sg = scsi_sg_count(cmd);
                for (i = 0; i < spriv->num_sg; i++) {
                        sg[i].dma_address = (uintptr_t)sg_virt(&sg[i]);
                        total += sg_dma_len(&sg[i]);
                }
        } else {
                spriv->num_sg = scsi_dma_map(cmd);
                for (i = 0; i < spriv->num_sg; i++)
                        total += sg_dma_len(&sg[i]);
        }

esp_advance_dma():
	p->cur_sg++;

esp_msgin_process():
	spriv->cur_sg--;

Thanks,
Ming
