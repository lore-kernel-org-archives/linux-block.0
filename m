Return-Path: <SRS0=Rbhm=YJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99A1FA372A
	for <linux-block@archiver.kernel.org>; Wed, 16 Oct 2019 12:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7AB20659
	for <linux-block@archiver.kernel.org>; Wed, 16 Oct 2019 12:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392808AbfJPMHq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:07:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392807AbfJPMHq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Oct 2019 08:07:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7F8618C4283;
        Wed, 16 Oct 2019 12:07:45 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2389F5C21F;
        Wed, 16 Oct 2019 12:07:38 +0000 (UTC)
Date:   Wed, 16 Oct 2019 20:07:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V4 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
Message-ID: <20191016120729.GB5515@ming.t460p>
References: <20191014015043.25029-1-ming.lei@redhat.com>
 <d30420d7-74d9-4417-1bbe-8113848e74fa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d30420d7-74d9-4417-1bbe-8113848e74fa@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Wed, 16 Oct 2019 12:07:45 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 16, 2019 at 09:58:27AM +0100, John Garry wrote:
> On 14/10/2019 02:50, Ming Lei wrote:
> > Hi,
> > 
> > Thomas mentioned:
> >     "
> >      That was the constraint of managed interrupts from the very beginning:
> > 
> >       The driver/subsystem has to quiesce the interrupt line and the associated
> >       queue _before_ it gets shutdown in CPU unplug and not fiddle with it
> >       until it's restarted by the core when the CPU is plugged in again.
> >     "
> > 
> > But no drivers or blk-mq do that before one hctx becomes dead(all
> > CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
> > to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
> > 
> > This patchset tries to address the issue by two stages:
> > 
> > 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
> > 
> > - mark the hctx as internal stopped, and drain all in-flight requests
> > if the hctx is going to be dead.
> > 
> > 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx becomes dead
> > 
> > - steal bios from the request, and resubmit them via generic_make_request(),
> > then these IO will be mapped to other live hctx for dispatch
> > 
> > Please comment & review, thanks!
> > 
> > John, I don't add your tested-by tag since V3 have some changes,
> > and I appreciate if you may run your test on V3.
> 
> Hi Ming,
> 
> So I got around to doing some testing. The good news is that issue which we
> were experiencing in v3 series seems to have has gone away - alot more
> stable.
> 
> However, unfortunately, I did notice some SCSI timeouts:
> 
> 15508.615074] CPU2: shutdown
> [15508.617778] psci: CPU2 killed.
> [15508.651220] CPU1: shutdown
> [15508.653924] psci: CPU1 killed.
> [15518.406229] sas: Enter sas_scsi_recover_host busy: 63 failed: 63
> Jobs: 1 (f=1): [R] [0.0% done] [0[15518.412239] sas: sas_scsi_find_task:
> aborting task 0x00000000a7159744
> KB/0KB/0KB /s] [0/0/0 iops] [eta [15518.421708] sas:
> sas_eh_handle_sas_errors: task 0x00000000a7159744 is done
> [15518.431266] sas: sas_scsi_find_task: aborting task 0x00000000d39731eb
> [15518.442539] sas: sas_eh_handle_sas_errors: task 0x00000000d39731eb is
> done
> [15518.449407] sas: sas_scsi_find_task: aborting task 0x000000009f77c9bd
> [15518.455899] sas: sas_eh_handle_sas_errors: task 0x000000009f77c9bd is
> done
> 
> A couple of things to note:
> - I added some debug prints in blk_mq_hctx_drain_inflight_rqs() for when
> inflights rqs !=0, and I don't see them for this timeout
> - 0 datarate reported from fio
> 
> I'll have a look...

What is the output of the following command?

(cd /sys/kernel/debug/block/$SAS_DISK && find . -type f -exec grep -aH . {} \;)

Thanks,
Ming
