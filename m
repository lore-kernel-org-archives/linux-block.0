Return-Path: <SRS0=jW7Q=YD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67390C10F14
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 10:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B7A21929
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 10:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfJJKa3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:30:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfJJKa3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 06:30:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D0E22CE90A;
        Thu, 10 Oct 2019 10:30:29 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C0005C22C;
        Thu, 10 Oct 2019 10:30:22 +0000 (UTC)
Date:   Thu, 10 Oct 2019 18:30:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V3 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
Message-ID: <20191010103016.GA22976@ming.t460p>
References: <20191008041821.2782-1-ming.lei@redhat.com>
 <bf9687ef-4a90-73f7-3028-4c5d56c8d66b@huawei.com>
 <549bf046-f617-4c4f-5bf1-17603cc5f832@huawei.com>
 <20191009083930.GE10549@ming.t460p>
 <a30f6b45-0b89-7950-1e44-240630d89264@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a30f6b45-0b89-7950-1e44-240630d89264@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 10 Oct 2019 10:30:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 09, 2019 at 09:49:35AM +0100, John Garry wrote:
> > > > > - steal bios from the request, and resubmit them via
> > > > > generic_make_request(),
> > > > > then these IO will be mapped to other live hctx for dispatch
> > > > > 
> > > > > Please comment & review, thanks!
> > > > > 
> > > > > John, I don't add your tested-by tag since V3 have some changes,
> > > > > and I appreciate if you may run your test on V3.
> > > > > 
> > > > 
> > > > Will do, Thanks
> > > 
> > > Hi Ming,
> > > 
> > > I got this warning once:
> > > 
> > > [  162.558185] CPU10: shutdown
> > > [  162.560994] psci: CPU10 killed.
> > > [  162.593939] CPU9: shutdown
> > > [  162.596645] psci: CPU9 killed.
> > > [  162.625838] CPU8: shutdown
> > > [  162.628550] psci: CPU8 killed.
> > > [  162.685790] CPU7: shutdown
> > > [  162.688496] psci: CPU7 killed.
> > > [  162.725771] CPU6: shutdown
> > > [  162.728486] psci: CPU6 killed.
> > > [  162.753884] CPU5: shutdown
> > > [  162.756591] psci: CPU5 killed.
> > > [  162.785584] irq_shutdown
> > > [  162.788277] IRQ 800: no longer affine to CPU4
> > > [  162.793267] CPU4: shutdown
> > > [  162.795975] psci: CPU4 killed.
> > > [  162.849680] run queue from wrong CPU 13, hctx active
> > > [  162.849692] CPU3: shutdown
> > > [  162.854649] CPU: 13 PID: 874 Comm: kworker/3:2H Not tainted
> > > 5.4.0-rc1-00012-gad025dd3d001 #1098
> > > [  162.854653] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0 -
> > > V1.16.01 03/15/2019
> > > [  162.857362] psci: CPU3 killed.
> > > [  162.866039] Workqueue: kblockd blk_mq_run_work_fn
> > > [  162.882281] Call trace:
> > > [  162.884716]  dump_backtrace+0x0/0x150
> > > [  162.888365]  show_stack+0x14/0x20
> > > [  162.891668]  dump_stack+0xb0/0xf8
> > > [  162.894970]  __blk_mq_run_hw_queue+0x11c/0x128
> > > [  162.899400]  blk_mq_run_work_fn+0x1c/0x28
> > > [  162.903397]  process_one_work+0x1e0/0x358
> > > [  162.907393]  worker_thread+0x40/0x488
> > > [  162.911042]  kthread+0x118/0x120
> > > [  162.914257]  ret_from_fork+0x10/0x18
> > 
> > What is the HBA? If it is Hisilicon SAS, it isn't strange, because
> > this patch can't fix single hw queue with multiple private reply queue
> > yet, that can be one follow-up job of this patchset.
> > 
> 
> Yes, hisi_sas. So, right, it is single queue today on mainline, but I
> manually made it multiqueue on my dev branch just to test this series.
> Otherwise I could not test it for that driver.
> 
> My dev branch is here, if interested:
> https://github.com/hisilicon/kernel-dev/commits/private-topic-sas-5.4-mq

Your conversion shouldn't work given you do not change .can_queue in the
patch of 'hisi_sas_v3: multiqueue support'.

As discussed before, tags of hisilicon V3 is HBA wide. If you switch
to real hw queue, each hw queue has to own its independent tags.
However, that isn't supported by V3 hardware.

See previous discussion:

https://marc.info/?t=155928863000001&r=1&w=2


Thanks,
Ming
