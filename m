Return-Path: <SRS0=s4v/=QY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6639BC43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Feb 2019 17:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CA7222ED
	for <linux-block@archiver.kernel.org>; Sun, 17 Feb 2019 17:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550424503;
	bh=C3SspDXNDgil2tAg1TW4o4r0CiFJGzI4gHouEijaq8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YOdXzv+YKyLEecdfiAcgjlBcsq6thdVrBTI83/5y1ky1BRkD4cHBVVX4A8gCwb6ii
	 pCBPzJZ8GlIZJay14r+IksMDE9Z3pJbY8ZDAFwdYk7ArfliJ5NSzE1Y6Fvw9ccC1/q
	 Z2sKyQaj2UETpLxy0toCBjegGFZYGKuwmO/UNx5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfBQR2W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Feb 2019 12:28:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfBQR2W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Feb 2019 12:28:22 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 173C221924;
        Sun, 17 Feb 2019 17:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550424501;
        bh=C3SspDXNDgil2tAg1TW4o4r0CiFJGzI4gHouEijaq8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n8I9iO+Q01OtivR/zVwNwPz0ACajXBPqSCD3kTEWHHfagBDFqOit/Bu/6CXcVZZ2g
         MQO60s79lVaPWGUVR6FerTOrfFPi0pmRgDgmByxkAP7YRk9Kp+BEv/s+OKhHIhlXU4
         Cppf0j1SzPx9lxLy1RYutagZceqLryPHD/X1bMew=
Date:   Sun, 17 Feb 2019 12:28:19 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Thibaut Sautereau <thibaut@sautereau.fr>
Cc:     stable@vger.kernel.org, Jianchao Wang <jianchao.w.wang@oracle.com>,
        m19@florianstecker.de, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: fix a hung issue when fsync
Message-ID: <20190217172819.GE10616@sasha-vm>
References: <1548838916-25051-1-git-send-email-jianchao.w.wang@oracle.com>
 <319fffef-2fa8-afff-8f93-1ce8fd721581@kernel.dk>
 <20190217153729.GA3835@gandi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190217153729.GA3835@gandi.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Feb 17, 2019 at 04:37:29PM +0100, Thibaut Sautereau wrote:
>On Wed, Jan 30, 2019 at 08:54:09AM -0700, Jens Axboe wrote:
>> On 1/30/19 2:01 AM, Jianchao Wang wrote:
>> > Florian reported a io hung issue when fsync(). It should be
>> > triggered by following race condition.
>> >
>> > data + post flush         a flush
>> >
>> > blk_flush_complete_seq
>> >   case REQ_FSEQ_DATA
>> >     blk_flush_queue_rq
>> >     issued to driver      blk_mq_dispatch_rq_list
>> >                             try to issue a flush req
>> >                             failed due to NON-NCQ command
>> >                             .queue_rq return BLK_STS_DEV_RESOURCE
>> >
>> > request completion
>> >   req->end_io // doesn't check RESTART
>> >   mq_flush_data_end_io
>> >     case REQ_FSEQ_POSTFLUSH
>> >       blk_kick_flush
>> >         do nothing because previous flush
>> >         has not been completed
>> >      blk_mq_run_hw_queue
>> >                               insert rq to hctx->dispatch
>> >                               due to RESTART is still set, do nothing
>> >
>> > To fix this, replace the blk_mq_run_hw_queue in mq_flush_data_end_io
>> > with blk_mq_sched_restart to check and clear the RESTART flag.
>>
>> Applied, thanks.
>>
>> --
>> Jens Axboe
>
>Can this be applied to stable kernels please?
>
>It's commit 85bd6e61f34dffa8ec2dc75ff3c02ee7b2f1cbce upstream.

I've queued it for 4.20, 4.19 and 4.14.

--
Thanks,
Sasha
