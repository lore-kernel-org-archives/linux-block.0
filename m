Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB75C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 19:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AF820685
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 19:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Mcb05bIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfCYTFc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:05:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42487 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYTFb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 15:05:31 -0400
Received: by mail-io1-f67.google.com with SMTP id c4so8571045ioh.9
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 12:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6tLE6KyM/oNZrA916j3wWSms/8UVU5eT1rV8+Gba4sQ=;
        b=Mcb05bIvcXRKEZrYX8MNOdLdw3MGsPsL67HPj3qpBr0YF39vJlxkuQBRNAuNG0Iydc
         A711vpisINU12+9v64/0+Zed0DSvi14hElsMjK6TA8MAI06zlnFttOgpu9E9cXLxiUeP
         vUM1fcmEmMIV2bPvgOHc63bGSP0b+i1xpPBbgLEhRpfHUMp5hCov+P6Pw9392MyPAMzO
         xBm/6rZrs5JWqu/Gq3sxHuvMPddfkHRJahqJ42ALx641GPsgRq8efRRR6mysrUuONaZ2
         46jxGOwFqA7UGkQARkLC0hO16GemDv4iAoffhwfR+ubLewx/0m+LTff/RlG9p0UfpcS9
         wlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6tLE6KyM/oNZrA916j3wWSms/8UVU5eT1rV8+Gba4sQ=;
        b=oMdszKJQx7JY5+IguvhyIN6/pSVV4Ed7Pfv3wAbfAzSxNhfFKU0KWNT3FliTtyG8qQ
         9NpcdHZZiJtIM6daPrJ1e89RTSV2BW8MEE3/m4m8rvoi6O3T6msc+7EI2I14K2RvSbOK
         MN4dqT1OXNMhJbdUdWUmJAlEBYi5IMlPChbqliLD7bVRdo8N7EHRQ3SihiygkPGoA+nB
         0+rHeAqJ3IX6QUjFg9RBi9kbQSJWB68Ub96XMyTvOVaiMvqIlylO2BM9dTNOp54ebJ9v
         QBI+SF5lKMGYcYqw/emGhzErqj5HIj8Di5DRTPjL9PxnEgr3uDX5CPAiZfKoCaUsW2e5
         NH1A==
X-Gm-Message-State: APjAAAWO/SaFbdYg0ZhmylU+BGOMQvofa2Zh1E+iV6g0BVuA1cAnL/78
        3caBxQrHYx9Z5c2fJqLfua2UBQ==
X-Google-Smtp-Source: APXvYqwmeAFRfQBQ/hWAVUqPS46RTQGxosgUJQmdH29KS6uKqXWxg2puuxRg1fZr5CnlSiyCbB6k7w==
X-Received: by 2002:a5e:d717:: with SMTP id v23mr19781551iom.66.1553540730913;
        Mon, 25 Mar 2019 12:05:30 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o141sm6188302ito.14.2019.03.25.12.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 12:05:29 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: fix sbitmap ws_active for shared tags
To:     Omar Sandoval <osandov@osandov.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
References: <c0d3f0c8-a5d7-19dd-7b7f-1d4f860c425b@kernel.dk>
 <20190325185635.GF5826@vader>
 <5ed3aa61-e12d-2dc4-2a8d-e9cc02788371@kernel.dk>
 <20190325190441.GG5826@vader>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <467b32b6-28e6-701b-b724-6c1d9008b03c@kernel.dk>
Date:   Mon, 25 Mar 2019 13:05:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325190441.GG5826@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/19 1:04 PM, Omar Sandoval wrote:
> On Mon, Mar 25, 2019 at 12:58:47PM -0600, Jens Axboe wrote:
>> On 3/25/19 12:56 PM, Omar Sandoval wrote:
>>> On Mon, Mar 25, 2019 at 10:22:50AM -0600, Jens Axboe wrote:
>>>> We now wrap sbitmap waitqueues in an active counter, so we can avoid
>>>> iterating wakeups unless we have waiters there. This works as long as
>>>> everyone that's manipulating the waitqueues use the proper helpers. For
>>>> the tag wait case for shared tags, however, we add ourselves to the
>>>> waitqueue without incrementing/decrementing the ->ws_active count. This
>>>> means that wakeups can take a long time to happen.
>>>>
>>>> Fix this by manually doing the inc/dec as needed for the wait queue
>>>> handling.
>>>>
>>>> Fixes: 5d2ee7122c73 ("sbitmap: optimize wakeup check")
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> Can this use the helpers we added in 9f6b7ef6c3eb ("sbitmap: add helpers
>>> for add/del wait queue handling")?
>>
>> I don't think so without adding more, which seems kind of silly for this
>> very specialized use case of openly manipulating the wait queues. The
>> blk-mq setup there is very special cased.
> 
> Yup, I see. Assuming it fixes the issue,
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>

Thanks - it does fix the issue, the original reporter has since tested and
confirmed that his abysmally slow raid5 now works at full speed again.

-- 
Jens Axboe

