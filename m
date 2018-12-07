Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F76C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFAF2082B
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFAF2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeLGDow (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:44:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbeLGDow (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 22:44:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2B323004416;
        Fri,  7 Dec 2018 03:44:51 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 123F8103BAB9;
        Fri,  7 Dec 2018 03:44:44 +0000 (UTC)
Date:   Fri, 7 Dec 2018 11:44:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: fix corruption with direct issue
Message-ID: <20181207034437.GB22188@ming.t460p>
References: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
 <20181205013736.GD17845@ming.t460p>
 <37bf8821-c205-717a-df0d-96ecfb0f75aa@kernel.dk>
 <20181205022716.GE17845@ming.t460p>
 <227a40a3-6599-9fc0-ab58-674f063e9c3a@kernel.dk>
 <20181205025801.GF17845@ming.t460p>
 <20181205030300.GG17845@ming.t460p>
 <20181207024642.GA13460@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207024642.GA13460@thunk.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 07 Dec 2018 03:44:51 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06, 2018 at 09:46:42PM -0500, Theodore Y. Ts'o wrote:
> On Wed, Dec 05, 2018 at 11:03:01AM +0800, Ming Lei wrote:
> > 
> > But at that time, there isn't io scheduler for MQ, so in theory the
> > issue should be there since v4.11, especially 945ffb60c11d ("mq-deadline:
> > add blk-mq adaptation of the deadline IO scheduler").
> 
> Hi Ming,
> 
> How were serious you about this issue being there (theoretically) an
> issue since 4.11?  Can you talk about how it might get triggered, and
> how we can test for it?  The reason why I ask is because we're trying
> to track down a mysterious file system corruption problem on a 4.14.x
> stable kernel.  The symptoms are *very* eerily similar to kernel
> bugzilla #201685.

Hi Theodore,

It is just a theory analysis.

blk_mq_try_issue_directly() is called in two branches of blk_mq_make_request(),
both are on real MQ disks.

IO merge can be done on none or real io schedulers, so in theory there might
be the risk from v4.1, but IO merge on sw queue didn't work for a bit long,
especially it was fixed by ab42f35d9cb5ac49b5a2.

As Jens mentioned in bugzilla, there are several conditions required
for triggering the issue:

- MQ device

- queue busy can be triggered. It is hard to trigger in NVMe PCI,
  but may be possible on NVMe FC. However, it can be quite easy to
  trigger on SCSI devices. We know there are some MQ SCSI HBA,
  qlogic FC, megaraid_sas.

- IO merge is enabled. 

I have setup scsi_debug in the following way:

modprobe scsi_debug dev_size_mb=4096 clustering=1 \
		max_luns=1 submit_queues=2 max_queue=2

- submit_queues=2 may set this disk as MQ
- max_queue=4 may trigger the queue busy condition easily

and run some write IO on ext4 over the disk: fio, kernel building,... for
some time, but still can't trigger the data corruption once.

I should have created more LUN, so that queue may be easier to become
busy, will do that soon.

> 
> The problem is that the problem is super-rare --- roughly once a week
> out of a popuation of about 2500 systems.  The workload is NFS
> serving.  Unfortunately, the problem is since 4.14.63, we can no
> longer disable blk-mq for the virtio-scsi driver, thanks to the commit
> b5b6e8c8d3b4 ("scsi: virtio_scsi: fix IO hang caused by automatic irq
> vector affinity") getting backported into 4.14.63 as commit
> 70b522f163bbb32.

virtio_scsi supports multi-queue mode, if that is enabled in your
setting, you may try single queue and see if difference can be made.

If multi-queue mode isn't enabled, your problem should be different with
this one. I remember multi-queue mode isn't enabled on virtio-scsi in GCE.

> We're considering reverting this patch in our 4.14 LTS kernel, and
> seeing whether it makes the problem go away.  Is there any thing else
> you might suggest?

IO hang is only triggered on machine with special CPU topo, it should be
fine to revert b5b6e8c8d3b4 on normal VM.

No other suggestions yet.

Thanks,
Ming
