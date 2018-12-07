Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B39C04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 02:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECFD2064D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 02:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="X3Wa8mIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECFD2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbeLGCqr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:46:47 -0500
Received: from imap.thunk.org ([74.207.234.97]:58854 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGCqr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 21:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DCqeDt/QCvbWvooGnA9q0txdNvhJtW13MMHwCyxjDV0=; b=X3Wa8mIy+IB6npsWXWKaCCu64p
        6eYNjv19knercG1OgxAsr/5grNAHkgXa9clz+A3J12WMQwv0MSLuxNelRe91vgS64JYeBWXH68W+5
        lX1FKASU7iSktq0uXwWZ8GTfopt/i+5RX9Va9jF+Q6prVIXuF85h3uBHfAYa9150EPEA=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gV6A8-0003Sp-6K; Fri, 07 Dec 2018 02:46:44 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E7D037A47B4; Thu,  6 Dec 2018 21:46:42 -0500 (EST)
Date:   Thu, 6 Dec 2018 21:46:42 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: fix corruption with direct issue
Message-ID: <20181207024642.GA13460@thunk.org>
References: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
 <20181205013736.GD17845@ming.t460p>
 <37bf8821-c205-717a-df0d-96ecfb0f75aa@kernel.dk>
 <20181205022716.GE17845@ming.t460p>
 <227a40a3-6599-9fc0-ab58-674f063e9c3a@kernel.dk>
 <20181205025801.GF17845@ming.t460p>
 <20181205030300.GG17845@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205030300.GG17845@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 05, 2018 at 11:03:01AM +0800, Ming Lei wrote:
> 
> But at that time, there isn't io scheduler for MQ, so in theory the
> issue should be there since v4.11, especially 945ffb60c11d ("mq-deadline:
> add blk-mq adaptation of the deadline IO scheduler").

Hi Ming,

How were serious you about this issue being there (theoretically) an
issue since 4.11?  Can you talk about how it might get triggered, and
how we can test for it?  The reason why I ask is because we're trying
to track down a mysterious file system corruption problem on a 4.14.x
stable kernel.  The symptoms are *very* eerily similar to kernel
bugzilla #201685.

The problem is that the problem is super-rare --- roughly once a week
out of a popuation of about 2500 systems.  The workload is NFS
serving.  Unfortunately, the problem is since 4.14.63, we can no
longer disable blk-mq for the virtio-scsi driver, thanks to the commit
b5b6e8c8d3b4 ("scsi: virtio_scsi: fix IO hang caused by automatic irq
vector affinity") getting backported into 4.14.63 as commit
70b522f163bbb32.

We're considering reverting this patch in our 4.14 LTS kernel, and
seeing whether it makes the problem go away.  Is there any thing else
you might suggest?

Thanks,

						- Ted

P.S.  Unlike the repro's that users were seeing in #201685, we *did*
have an I/O scheduler enabled --- it was mq-deadline.  But right now,
given your comments, and the corruptions that we're seeing, I'm not
feeling very warm and fuzzy about block-mq.  :-( :-( :-(
