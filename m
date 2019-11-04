Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14EFCA9EB5
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 14:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5E721D71
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 14:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wHvf49pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfKDOBk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:01:40 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41848 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfKDOBk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 09:01:40 -0500
Received: by mail-io1-f66.google.com with SMTP id r144so18503276iod.8
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2019 06:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sif2sVDBigk80VOSIbDHJQK/86lz3qMxwcMcFfuFv4w=;
        b=wHvf49pwwMQ+3Nw/A2K/DGAGMblywBCF3YNSbrBMaU4cXZdOTcf16ZarePd66qSAWr
         XWhUo4+y5K1G3brNPLuRHWabRdMSqH+gRtQiczLwY0jP47Jv+zysx3vmEJUKjTNc6F4q
         PBPy4+HRW5pjssbHz/G+zZOjLENWpWqe4vTZ34jb6MvWYr7NahMG8j1YqUG2L82tcEd5
         V/9cR7ZB3UEkmncVq8zh/444G1HMlIfneHkA472VUgMm5Io2WjsLt+rhlMZrf7ZvQVx7
         FhSqXWkvnAPJPg0k7wNt6/5CnMp055EMJiGnG1VotG+6nWA2CnmJUMCwHbUZ+4Eu+uWN
         +57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sif2sVDBigk80VOSIbDHJQK/86lz3qMxwcMcFfuFv4w=;
        b=FYAuQnQSqCispOuMsr2TybGMchdkIcDIQCMDBZwHyGFOtZMpv/QovvMeNNT7b9ZXAt
         /oKskIJ1DmhmEEfHeC0OSUwj5lWEXcA4AC4k168cjnxnt5tCG6is9CIMfpM3Vbqn/RgC
         haTz9hP58PkS3r+4ZPs4fQIMVddMfhWKG/F+MVLcLiOz7tfW7yz+zsI61JyI138Hj83G
         kL5m7lc928kmMB/q8lQJycrxwL2I0rdkoyN9dgHWFZrVvSTxmuU7RXt0fY3Jp2icIoZJ
         e4ch+IxWL0W2Pxw6k8834BCpOH03vBrfBLBfYzUqT1AadpLuywnqssBVqCUMdaFKeapZ
         PKVA==
X-Gm-Message-State: APjAAAW6QztCfcTMXKFbILvArlpiXrmse1FWnjK3wRPsoHKDOJYex5An
        b6DAQL7vY0JH9hhJ9C3l1dESDQ==
X-Google-Smtp-Source: APXvYqzO0Qfj1MwL0EJ18S1x2n5g1OAke6Tbw6rrr0nOCfXLWdagq5vk6PnvWEzmCJC0eXBO2t9lOw==
X-Received: by 2002:a5d:9808:: with SMTP id a8mr18329322iol.2.1572876099702;
        Mon, 04 Nov 2019 06:01:39 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p19sm2444483ili.56.2019.11.04.06.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 06:01:38 -0800 (PST)
Subject: Re: [RFC] io_uring: stop only support read/write for ctx with
 IORING_SETUP_IOPOLL
To:     yangerkun <yangerkun@huawei.com>, Bob Liu <bob.liu@oracle.com>,
        linux-block@vger.kernel.org
Cc:     houtao1@huawei.com, yi.zhang@huawei.com
References: <20191104085608.44816-1-yangerkun@huawei.com>
 <a01cc299-69e7-daa2-6894-1c60aaa64e67@oracle.com>
 <3fd0dee1-52d6-4ea8-53d8-2c88b7fedce6@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <50de6a43-fc11-aada-40e6-f3fee6523d49@kernel.dk>
Date:   Mon, 4 Nov 2019 07:01:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3fd0dee1-52d6-4ea8-53d8-2c88b7fedce6@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/19 4:46 AM, yangerkun wrote:
> 
> 
> On 2019/11/4 18:09, Bob Liu wrote:
>> On 11/4/19 4:56 PM, yangerkun wrote:
>>> There is no problem to support other type request for the ctx with
>>> IORING_SETUP_IOPOLL.
>>
>> Could you describe the benefit of doing this?
> 
> Hi,
> 
> I am trying to replace libaio with io_uring in InnoDB/MariaDB(which
> build on xfs/nvme). And in order to simulate the timeout mechanism
> like io_getevents, firstly, to use the poll function of io_uring's fd
> has been selected and it really did work. But while trying to enable
> IORING_SETUP_IOPOLL since xfs has iopoll function interface, the
> mechanism will fail since io_uring_poll does check the cq.head between
> cached_cq_tail, which will not update until we call io_uring_enter and
> do the poll. So, instead, I decide to use timeout requests in
> io_uring but will return -EINVAL since we enable IORING_SETUP_IOPOLL
> at the same time. I think this combination is a normal scene so as
> the other combination descibed in this patch. I am not sure does it a
> good solution for this problem, and maybe there exists some better way.

I think we can support timeouts pretty easily with SETUP_IOPOLL, but we
can't mix and match everything. Pretty sure I've written at length about
that before, but the tldr is that for purely polled commands, we won't
have an IRQ event. That's the case for nvme if it's misconfigured, but
for an optimal setup where nvme is loaded with poll queues, there will
never be an interrupt for the command. This means that we can never wait
in io_cqring_wait(), we must always call the iopoll poller, because if
we wait we might very well be waiting for events that will never happen
unless we actively poll for them.

This could be supported if we accounted requests, but I don't want to
add that kind of overhead. Same with the lock+irqdisable you had to add
for this, it's not acceptable overhead.

Sounds like you just need timeout support for polling? If so, then that
is supportable as we know that these events will trigger an async event
when they happen. Either that, or it triggers when we poll for
completions. So it's safe to support, and we can definitely do that.

But don't mix polled IO with "normal" IO, it just won't work without
extra additions that I'm not willing to pay the cost of.


-- 
Jens Axboe

