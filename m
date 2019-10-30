Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DCFCA9ECE
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 17:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD132173E
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 17:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eRcKcfVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfJ3Rci (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:32:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35843 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfJ3Rci (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 13:32:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so1301545plp.3
        for <linux-block@vger.kernel.org>; Wed, 30 Oct 2019 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MYCTZSX2r9WG5NddxwGb3h8C9h8C7Fe9LS3H+KqC+YY=;
        b=eRcKcfVzy9BEO7o4cxUrK74Ev46oc+78/sPax/2yQW7f6w5hKJQuBiluhzZ/BJM1BW
         iViC7Kpe6wZv/4lPvmwkVXnSWH314TS6xdBwqeBPJnJQGVuW/b5XiDUbJRKuf6Aweijm
         6NEOHUdWhcFykJaDs/7KRypDnVKN2GeAkinJRcEFyhVnUUolK9TgbV5t22GhJSk0BGk6
         2VhuojxR2yG6qEWiHfVuPqDkMGnl2eNUpWj5b11NDMtJ3ai/UYnjlPpKjpWXnRZGkkCl
         GpJvyaF0RHwmbwTY01jllon0tMTNFFfmoATH812Ggh0t4JEjW/8Q1oVURGsNz91BBUIO
         zQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MYCTZSX2r9WG5NddxwGb3h8C9h8C7Fe9LS3H+KqC+YY=;
        b=fcSNZXusnYAamAPOfj/g1pJ9IzvqanTa/L+xk+4eOfjY3ekaanbNDOppAiBvYjWJWY
         DMIyRYdKUtfAyM8vrwSYiOtRdy1hGO6DYQgr7Q4l5U3KsU2+rLMVMEfaxBfZc8JFDHU6
         OL6n3aMA6YtTvfMy05sT1JqlxKc8dPJOZzTfYDopWLui4jib9Z5IO6MgTCr90FsdiXDx
         sf2S/l8TrMchADiotwV0ZZwfPFaGW1gPBKPqr1qSOoOXna1WcB7YuHYqDjGFvMDzfpGh
         VysYin40prjThSViETOYJLJzYIrGjNHcfVjkW9N9gE0IIQ2OjPOXoFOB9vAhmucK9VZu
         Cg4A==
X-Gm-Message-State: APjAAAXkCDpVJWJCOlN4UuanZOfaHp0tJkDaprkhPS4Ue28kPZAVi4I2
        +NHe+aWR5ZADMI+On3NqdJAhz+7mxk7hYA==
X-Google-Smtp-Source: APXvYqzGOIEByo4DBeuufsICO6xS76D7ZDopdsQh9HeOMXxIpC36zGqo1urI4KUPWhsBi5VrtKWk2A==
X-Received: by 2002:a17:902:a584:: with SMTP id az4mr1238563plb.74.1572456755012;
        Wed, 30 Oct 2019 10:32:35 -0700 (PDT)
Received: from ?IPv6:2600:380:7747:124e:7432:50cb:43e0:cd75? ([2600:380:7747:124e:7432:50cb:43e0:cd75])
        by smtp.gmail.com with ESMTPSA id x14sm511925pfm.96.2019.10.30.10.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 10:32:33 -0700 (PDT)
Subject: Re: [RFC 0/2] io_uring: examine request result only after completion
From:   Jens Axboe <axboe@kernel.dk>
To:     Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Cc:     linux-block@vger.kernel.org
References: <1571908688-22488-1-git-send-email-bijan.mottahedeh@oracle.com>
 <201931df-ae22-c2fc-a9c7-496ceb87dff7@oracle.com>
 <90c23805-4b73-4ade-1b54-dc68010b54dd@kernel.dk>
 <fa82e9fc-caf7-a94a-ebff-536413e9ecce@oracle.com>
 <b7abb363-d665-b46a-9fb5-d01e7a6ce4d6@kernel.dk>
 <533409a8-6907-44d8-1b90-a10ec3483c2c@kernel.dk>
 <6adb9d2d-93f1-f915-7f20-5faa34b06398@kernel.dk>
 <cdaa2942-5f27-79f8-9933-1b947646f918@oracle.com>
 <34f483d9-2a97-30c3-9937-d3596649356c@oracle.com>
 <47b38d9d-04a3-99f6-c586-e82611d21655@kernel.dk>
 <c7b599e4-cf3d-5390-f6f4-360d4435ea43@oracle.com>
 <057bb6f9-29ec-1160-a1b1-00c57b610282@kernel.dk>
 <5d79122d-afcd-9340-df67-d81e1d94dd80@oracle.com>
 <e7d6ec39-1a1b-b4da-3944-8a1492c2c37e@kernel.dk>
 <3b71fff1-5b5e-3d33-b701-c7e1b3c9d8b9@oracle.com>
 <e334c317-e40a-f670-1d6e-220ddff05d64@kernel.dk>
 <07d23273-09e2-1a63-3f18-4d19af298a44@kernel.dk>
 <f5f647c4-2a6b-3678-1797-e40c89834149@oracle.com>
 <ff003ca8-e7d6-d3a8-9caa-311d55ef4319@kernel.dk>
Message-ID: <54061a1a-0d90-43ff-445b-efb3d057b1ee@kernel.dk>
Date:   Wed, 30 Oct 2019 11:32:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ff003ca8-e7d6-d3a8-9caa-311d55ef4319@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/30/19 8:18 AM, Jens Axboe wrote:
> On 10/30/19 8:02 AM, Bijan Mottahedeh wrote:
>>> OK, so I still don't quite see where the issue is. Your setup has more
>>> than one CPU per poll queue, and I can reproduce the issue quite easily
>>> here with a similar setup.
>>
>> That's probably why I couldn't reproduce this in a vm.  This time I set
>> up one poll queue in a 8 cpu vm and reproduced it.
> 
> You definitely do need poll queue sharing to hit this.
> 
>>> Below are some things that are given:
>>>
>>> 1) If we fail to submit the IO, io_complete_rw_iopoll() is ultimately
>>>       invoked _from_ the submission path. This means that the result is
>>>       readily available by the time we go and check:
>>>
>>>       if (req->result == -EAGAIN)
>>>
>>>       in __io_submit_sqe().
>>
>> Is that always true?
>>
>> Let's say the operation was __io_submit_sqe()->io_read()
>>
>> By "failing to submit the io", do you mean that
>> io_read()->call_read_iter() returned success or failure?  Are you saying
>> that req->result was set from kiocb_done() or later in the block layer?
> 
> By "failed to submit" I mean that req->result == -EAGAIN. We set that in
> io_complete_rw_iopoll(), which is called off bio_wouldblock_error() in
> the block layer. This is different from an ret != 0 return, which would
> have been some sort of other failure we encountered, failing to submit
> the request. For that error, we just end the request. For the
> bio_wouldblock_error(), we need to retry submission.
> 
>> Anyway I assume that io_read() would have to return success since
>> otherwise __io_submit_sqe() would immediately return and not check
>> req->result:
>>
>>            if (ret)
>>                    return ret;
> 
> Right, if ret != 0, then we have a fatal error for that request.
> ->result will not have been set at all for that case.
> 
>> So if io_read() did return success,  are we guaranteed that setting
>> req->result = -EAGAIN would always happen before the check?
> 
> Always, since it happens inline from when you attempt to issue the read.
> 
>> Also, is it possible that we can be preempted in __io_submit_sqe() after
>> the call to io_read() but before the -EAGAIN check?
> 
> Sure, we're not disabling preemption. But that shouldn't have any
> bearing on this case.
>>
>>> This is a submission time failure, not
>>>       something that should be happening from a completion path after the
>>>       IO has been submitted successfully.
>>>
>>> 2) If the succeed in submitting the request, given that we have other
>>>       tasks polling, the request can complete any time. It can very well be
>>>       complete by the time we call io_iopoll_req_issued(), and this is
>>>       perfectly fine. We know the request isn't going away, as we're
>>>       holding a reference to it. kiocb has the same lifetime, as it's
>>>       embedded in the io_kiocb request. Note that this isn't the same
>>>       io_ring_ctx at all, some other task with its own io_ring_ctx just
>>>       happens to find our request when doing polling on the same queue
>>>       itself.
>>
>> Ah yes, it's a different io_ring_ctx, different poll list etc. For my
> 
> Exactly
> 
>> own clarity, I assume all contexts are mapping the same actual sq/cq
>> rings?
> 
> The ring/context isn't mapped to a particular ring, a specific IO is
> mapped to a specific queue at the time it's being submitted. That
> depends on the IO type and where that task happens to be running at the
> time the IO is being submitted.

This might just do it, except it looks like there's a bug in sbitmap
where we don't always flush deferred clears. I'll look into that now.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index af1937d66aee..f3ca2ee44dbd 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1212,6 +1212,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 
 		kiocb->ki_flags |= IOCB_HIPRI;
 		kiocb->ki_complete = io_complete_rw_iopoll;
+		req->result = 0;
 	} else {
 		if (kiocb->ki_flags & IOCB_HIPRI)
 			return -EINVAL;

-- 
Jens Axboe

