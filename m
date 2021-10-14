Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBDDC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 18:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EEF660EBB
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 18:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhJNSQ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhJNSQ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 14:16:26 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AA9C061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 11:14:21 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id i189so4876774ioa.1
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0MwY1v5ZSmqBKQ8O9EGtEgre0QU8zFRnIK0sQTKuQS0=;
        b=DcLmD3x37VOFIiqRl/jMa56Re/8MLqratXK/fsrU4Jz5HCziRrtO9auIip9Md+pr12
         odKEeUl2RQEFPBgFPhbrB04pKBOisAFfp9hqMUxCgFtJMQ15lwwsHfzKNtk4usFmemN2
         IdkLTCCVgZwhpnlTLJusur1wn9+esS6aZ8SGLfULz64y8Dm20/aikDggZosh6NUADiet
         aNg1yt4NaZq3A2tjorxHDJYt1yr1DsAe8pbF49C/DbGbhTB5Qy7h+NSc5RRpnWtODjfa
         ydRQXEkzEFSelR1DJK3M0RtnMUaxIZml6icJMeR2UrEOryxPE3hLARv4QOEeaK3mCaCZ
         4g4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0MwY1v5ZSmqBKQ8O9EGtEgre0QU8zFRnIK0sQTKuQS0=;
        b=jryNwRf3kVA9ro6Eap6lLi4/xVHAtctKb3BXrxUI7kUqeDK1IsinJyX5WIYkcLw930
         7hgFkLRwW2Z+XLK9tVi6zi7p3t0UsTi1Y5dPJPJTTYmnkYs+5F7obuWbGxy3qxdYodV7
         XSSw1En2GWA9h1UHG5UH+3KrRuiDSVQkWZTcJlnWwO78pEJBpqdChWVah5LBq09vrjMl
         rmC96FFQkG5GccYdnbkYx1qKHx+ST5Ci0scQwJiwMo4Y/fFtTb5FPs+vViXbiIcPjWkU
         zM7aoDFjhBv46poN0qYo71ZfscpTQk6KbI3QRSKW+4dSiD8rM6QKL1t8+6AXsdjEYncL
         Oe0Q==
X-Gm-Message-State: AOAM532bEgN7D9QrFyzelQ44VFcuiznMUxmt4Wnvi9f2BLo92MCnjOX1
        5qd6149algtcvYktTy3+xPPhfXaP1HI2sQ==
X-Google-Smtp-Source: ABdhPJxLBLXTya2q8eLIRvC78NNS9F+snV4zKv18GS7QcB2DjxJj78PtSzZAm5WAr0fZ1WYuRtu1xw==
X-Received: by 2002:a5d:9d9c:: with SMTP id ay28mr381708iob.206.1634235260594;
        Thu, 14 Oct 2021 11:14:20 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x10sm1762427ill.38.2021.10.14.11.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 11:14:19 -0700 (PDT)
Subject: Re: [PATCH 8/9] io_uring: utilize the io_batch infrastructure for
 more efficient polled IO
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-9-axboe@kernel.dk> <YWfkVtB+pMpaG2T3@infradead.org>
 <7ed66f47-6f5a-39b2-7cd8-df7cf0952743@kernel.dk>
 <YWhWBt7kljI+BGbX@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c80263c8-f6d6-e3d9-058f-26d64c7e5acc@kernel.dk>
Date:   Thu, 14 Oct 2021 12:14:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWhWBt7kljI+BGbX@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/14/21 10:08 AM, Christoph Hellwig wrote:
> On Thu, Oct 14, 2021 at 09:45:38AM -0600, Jens Axboe wrote:
>> On 10/14/21 2:03 AM, Christoph Hellwig wrote:
>>> On Wed, Oct 13, 2021 at 10:54:15AM -0600, Jens Axboe wrote:
>>>> @@ -2404,6 +2406,11 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
>>>>  		struct kiocb *kiocb = &req->rw.kiocb;
>>>>  		int ret;
>>>>  
>>>> +		if (!file)
>>>> +			file = kiocb->ki_filp;
>>>> +		else if (file != kiocb->ki_filp)
>>>> +			break;
>>>> +
>>>
>>> Can you explain why we now can only poll for a single file (independent
>>> of the fact that batching is used)?
>>
>> Different file may be on a different backend, it's just playing it
>> safe and splitting it up. In practice it should not matter.
> 
> Well, with file systems even the same file can land on different
> devices.  Maybe we need a cookie?
> 
> Either way this should be commented as right now it looks pretty
> arbitrary.

I got rid of this and added a dev_id kind of cookie that gets matched
on batched addition.

-- 
Jens Axboe

