Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC06AC43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 17:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97B4206DF
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 17:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfCLRd5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:33:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729587AbfCLRd4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 13:33:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E70281DF1;
        Tue, 12 Mar 2019 17:33:56 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67E084C3;
        Tue, 12 Mar 2019 17:33:53 +0000 (UTC)
Date:   Tue, 12 Mar 2019 18:33:51 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     <virtualization@lists.linux-foundation.org>,
        <linux-block@vger.kernel.org>, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, mst@redhat.com
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
Message-ID: <20190312183351.74764f4f.cohuck@redhat.com>
In-Reply-To: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 12 Mar 2019 17:33:56 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 12 Mar 2019 10:22:46 -0700 (PDT)
Dongli Zhang <dongli.zhang@oracle.com> wrote:

> I observed that there is one msix vector for config and one shared vector
> for all queues in below qemu cmdline, when the num-queues for virtio-blk
> is more than the number of possible cpus:
> 
> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=6"
> 
> # cat /proc/interrupts 
>            CPU0       CPU1       CPU2       CPU3
> ... ...
>  24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
>  25:          0          0          0         59   PCI-MSI 65537-edge      virtio0-virtqueues
> ... ...
> 
> 
> However, when num-queues is the same as number of possible cpus:
> 
> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=4"
> 
> # cat /proc/interrupts 
>            CPU0       CPU1       CPU2       CPU3
> ... ... 
>  24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
>  25:          2          0          0          0   PCI-MSI 65537-edge      virtio0-req.0
>  26:          0         35          0          0   PCI-MSI 65538-edge      virtio0-req.1
>  27:          0          0         32          0   PCI-MSI 65539-edge      virtio0-req.2
>  28:          0          0          0          0   PCI-MSI 65540-edge      virtio0-req.3
> ... ...
> 
> In above case, there is one msix vector per queue.

Please note that this is pci-specific...

> 
> 
> This is because the max number of queues is not limited by the number of
> possible cpus.
> 
> By default, nvme (regardless about write_queues and poll_queues) and
> xen-blkfront limit the number of queues with num_possible_cpus().

...and these are probably pci-specific as well.

> 
> 
> Is this by design on purpose, or can we fix with below?
> 
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 4bc083b..df95ce3 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -513,6 +513,8 @@ static int init_vq(struct virtio_blk *vblk)
>  	if (err)
>  		num_vqs = 1;
>  
> +	num_vqs = min(num_possible_cpus(), num_vqs);
> +
>  	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
>  	if (!vblk->vqs)
>  		return -ENOMEM;

virtio-blk, however, is not pci-specific.

If we are using the ccw transport on s390, a completely different
interrupt mechanism is in use ('floating' interrupts, which are not
per-cpu). A check like that should therefore not go into the generic
driver.
