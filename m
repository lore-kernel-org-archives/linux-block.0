Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D87C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B094020851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wJP1SQ8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B094020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbeLMUKL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:10:11 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43128 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeLMUKK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 15:10:10 -0500
Received: by mail-io1-f65.google.com with SMTP id l3so2610129ioc.10
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 12:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fHszRcQD/Xo2QERAL0m1tRp8DU2FUA/4azDChFxDoGU=;
        b=wJP1SQ8ImzHtwUh0cjnLe7Dk8ufoQYVWa4WBiuA1Q1UDTjqC2eHMHWJIzJ71ZT90N+
         O+f4vVZxqMMST9jVOXUCJIsS8bk3k+z9nX1jb/DhOhF1xi318pufij+kPLR5HJMHHVTv
         lQWGLO9IogK6WHgondokFSd0iaHsFbA9O5EWrFa1nKO1AuOmUDbUqF5QTdlGk85Z+Ljl
         D6rKlD1DxeTYvoAS67buBkBlKOV70deiksigOln/m3RdCqABptRo5gggXiHpRjkfpCjr
         CwVRH3ZQnRRJQw+ZTCbX47jyXZWbJZ7cEgHmV0CAuM/84nFJf8weneRjJ1CyEZq+uisQ
         Lxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fHszRcQD/Xo2QERAL0m1tRp8DU2FUA/4azDChFxDoGU=;
        b=AmtRJ7NsAaVBz3EfduJQvkvFW2iJYGMbG76++yRGrgHoQaKrxUp0y3DRJ4srdbTzRs
         dPoDmtFxpdrTlRZdGG84/CKSx7s4118H96CItV8Ylk47p0kK3n4HYKNMWf917XyGMrXJ
         ei25Y4ZuIZLBV3s6EKUlPkJnqLGnsP1VHpkFknv6DvMkXFT+h+Xl2VeI5vt1NKG97Nj9
         +i9wXGmqQGCWiP3vLBZcx2GuOVr5AnNk5p3W53VGczVrz4/iuXdAyyAKQZYNvAMx9xgg
         dMfeF8EzbwTwzHngrcktiJO4FHu4FCo1gR/BcbWi3Hf6l1zBr6CpEyuby1/3CiM23zAn
         GFGw==
X-Gm-Message-State: AA+aEWa47uZ/lWSCHVTRy/xjiOEGAEYhpsz8W1RJbfSM91L6tpourwWI
        sDHmdBRhU+FhkM8IPB4POPg8Og==
X-Google-Smtp-Source: AFSGD/WbNT5vSYvjlwnUOjkduziJpXxxwiug1qSHDeh12QzNa2d+1SlqLyaEVpKR2s0I4J2sNZ2WsA==
X-Received: by 2002:a5d:9697:: with SMTP id m23mr139037ion.201.1544731809649;
        Thu, 13 Dec 2018 12:10:09 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k2sm1460678itk.35.2018.12.13.12.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 12:10:08 -0800 (PST)
Subject: Re: [PATCH v2] block: fix iolat timestamp and restore accounting
 semantics
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181211230114.65967-1-dennis@kernel.org>
 <59500829-10f5-fa83-b2db-fcfa4a1cd11d@kernel.dk>
 <20181213195208.qgvfeb5ilbf3ttsf@MacBook-Pro-91.local>
 <cbf1ca87-6a47-6c98-0c41-5cf495d6508b@kernel.dk>
 <20181213200358.e5zxe4tacrwylg32@MacBook-Pro-91.local>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <317a289a-5c0a-636b-70af-c3aaaf9b0d81@kernel.dk>
Date:   Thu, 13 Dec 2018 13:10:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213200358.e5zxe4tacrwylg32@MacBook-Pro-91.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/13/18 1:03 PM, Josef Bacik wrote:
> On Thu, Dec 13, 2018 at 12:59:03PM -0700, Jens Axboe wrote:
>> On 12/13/18 12:52 PM, Josef Bacik wrote:
>>> On Thu, Dec 13, 2018 at 12:48:11PM -0700, Jens Axboe wrote:
>>>> On 12/11/18 4:01 PM, Dennis Zhou wrote:
>>>>> The blk-iolatency controller measures the time from
>>>>> rq_qos_throttle() to rq_qos_done_bio() and attributes this time to
>>>>> the first bio that needs to create the request. This means if a bio
>>>>> is plug-mergeable or bio-mergeable, it gets to bypass the
>>>>> blk-iolatency controller.
>>>>>
>>>>> The recent series, to tag all bios w/ blkgs in [1] changed the
>>>>> timing incorrectly as well. First, the iolatency controller was
>>>>> tagging bios and using that information if it should process it in
>>>>> rq_qos_done_bio().  However, now that all bios are tagged, this
>>>>> caused the atomic_t for the struct rq_wait inflight count to
>>>>> underflow resulting in a stall. Second, now the timing was using the
>>>>> duration a bio from generic_make_request() rather than the timing
>>>>> mentioned above.
>>>>>
>>>>> This patch fixes these issues by reusing the BLK_QUEUE_ENTERED flag
>>>>> to determine if a bio has entered the request layer and is
>>>>> responsible for starting a request. Stacked drivers don't recurse
>>>>> through blk_mq_make_request(), so the overhead of using time between
>>>>> generic_make_request() and the blk_mq_get_request() should be
>>>>> minimal.  blk-iolatency now checks if this flag is set to determine
>>>>> if it should process the bio in rq_qos_done_bio().
>>>>
>>>> I'm having a hard time convincing myself that this is correct...
>>>> Maybe we should just add a new flag for this specific use case? Or
>>>> feel free to convince me otherwise.
>>>>
>>>
>>> I mean it'll work for now, but then when somebody else wants to do
>>> something similar *cough*io.weight*cough* it'll need a new flag.  I
>>> kind of hate adding a new flag for every controller, but then again
>>> it's not like there's thousands of these things.  I'm having a hard
>>> time coming up with a solution other than a per-tracker flag.  As for
>>> this specific version, I still think it needs to be in iolatency
>>> itself, trying to make it generic just means it'll get fucked up again
>>> later down the line.  Thanks,
>>
>> We definitely don't have that many flags, and I'd hate to add a
>> per-whatever flag for this.
>>
>> But do we need that? We really just need single flag for this, my main
>> worry was overloading ENTERED. Especially since we're adding different
>> clearing and setting for it. If we had a specific one, if it's set, we
>> would need to disallow merging for it, I guess.
>>
>> And there's already BIO_THROTTLED...
>>
> 
> Oh well I guess we only really want to know if we saw the BIO, which
> should be able to be shared by all the rq_qos implementations.  I
> think I'd rather just have a BIO_TRACKED to indicate it went through
> the normal rq_qos path.  Thanks,

Agree, so how about renaming BIO_THROTTLED to BIO_TRACKED and using
that?

-- 
Jens Axboe

