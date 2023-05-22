Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B581C77B73
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 02:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjEVCH3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 May 2023 22:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjEVCH2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 May 2023 22:07:28 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED573EA
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 19:07:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d2f3dd990so354954b3a.0
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 19:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684721246; x=1687313246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIvjJ9k7RGzxUzRxHmV1AICYtqmfJoyTp6is0V2D0eg=;
        b=5qeMdcQj96UF8uDG2SkOHpn/2lI81svkq43d+Hz3BwFQybPixy51r1B+u3dzBnROKq
         mVhRjiJ4tSn0AZ3/fzVXuztA7/KhUw9Tfz7IpKWJXPPRy8qOeRd3qWmz0dYJWVhQC/jI
         PMvexGN/LZgSFlcRJM0dFodg3r7rM2c3mxebSGLlnyF4NOOs/ku5W/EY2G1btohM6YMO
         UHNhKbExoVNv28XI1LlL0GZELXE7VnMe4cFoVZuWO5GR/CIJ07PEHlEslmz45OtRTZs/
         Yzk221Zhn6VyVw9B7yR0n1QRI6ijj4D3xYgC8/o5sEDeJmhA6es/UZwQ2/bNyWMioMr2
         IWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684721246; x=1687313246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIvjJ9k7RGzxUzRxHmV1AICYtqmfJoyTp6is0V2D0eg=;
        b=jQwlnZZAuN8ida1mvRJWzxYyKnVFBjuIM7g1YMI1iEmdfBMIFyHeyU89xzJlXpTOIB
         TP9AHIRmvzXIZnz9a3QxGS4pwFkcLxpMjgjF+lAPz9Schtlqd77IyIaA1Wx1LgJwKffC
         uZ5BbIAxLEpug7aZ9fKVpbWghZiGiI1sCT2gH6fzwgRkZ0Yap7/KvHlrk0vv0NB5+jxf
         YKiB2HjArf3oDrcmWjQ+MkRnzDwCDwmSHPrCo/JxBNWfxQbpbNaSdkxUx7U2i04PmboI
         LwUIxtL56zFnqkCnIigF40tAgqc89wMPhJ0yeyjWMAlNFkj1PC5CcpY0t84CeXqbJGG4
         z5PQ==
X-Gm-Message-State: AC+VfDyW1EV0qrMLsdtZYXphvQsEA8Mqei0YcNVNYbuUy+hZEyyQLwl0
        9aKb/mq6CEGcgg7rvVGERIDJEiT+7+LFr1mWhto=
X-Google-Smtp-Source: ACHHUZ6u79ZeAGbFmUZvFwphejs9VcoymOR8RqgVz6RZPt2hNRR3Htdq5zhdmDgK/5tUtMvVRt4Ykg==
X-Received: by 2002:a05:6a20:440d:b0:106:dfc8:6f3d with SMTP id ce13-20020a056a20440d00b00106dfc86f3dmr10443417pzb.3.1684721246363;
        Sun, 21 May 2023 19:07:26 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f18-20020a63dc52000000b005307501cfe4sm3349003pgj.44.2023.05.21.19.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 19:07:25 -0700 (PDT)
Message-ID: <41bdbb09-4a05-1624-6433-49c7cbc6ff48@kernel.dk>
Date:   Sun, 21 May 2023 20:07:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] blk-mq: fix race condition in active queue accounting
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc:     Tian Lan <tilan7663@gmail.com>, linux-block@vger.kernel.org,
        Tian Lan <tian.lan@twosigma.com>
References: <20230522004328.760024-1-tilan7663@gmail.com>
 <694813ca-690d-4852-0066-cee6833ad8c4@kernel.org>
 <ZGrEJRrZcjYtlMpV@ovpn-8-16.pek2.redhat.com>
 <c8d2e8dc-285d-9675-d915-be3b5b6d6248@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c8d2e8dc-285d-9675-d915-be3b5b6d6248@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/21/23 7:29?PM, Damien Le Moal wrote:
> On 5/22/23 10:23, Ming Lei wrote:
>> On Mon, May 22, 2023 at 10:15:22AM +0900, Damien Le Moal wrote:
>>> On 5/22/23 09:43, Tian Lan wrote:
>>>> From: Tian Lan <tian.lan@twosigma.com>
>>>>
>>>> If multiple CPUs are sharing the same hardware queue, it can
>>>> cause leak in the active queue counter tracking when __blk_mq_tag_busy()
>>>> is executed simultaneously.
>>>>
>>>> Fixes: ee78ec1077d3 ("blk-mq: blk_mq_tag_busy is no need to return a value")
>>>> Signed-off-by: Tian Lan <tian.lan@twosigma.com>
>>>> ---
>>>>  block/blk-mq-tag.c | 10 ++++++----
>>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>>> index d6af9d431dc6..07372032238a 100644
>>>> --- a/block/blk-mq-tag.c
>>>> +++ b/block/blk-mq-tag.c
>>>> @@ -42,13 +42,15 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>>>>  	if (blk_mq_is_shared_tags(hctx->flags)) {
>>>>  		struct request_queue *q = hctx->queue;
>>>>  
>>>> -		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
>>>> +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
>>>> +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
>>>
>>> This is weird. test_and_set_bit() returns the bit old value, so shouldn't this be:
>>>
>>> 		if (test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
>>> 			return;
>>>
>>> ?
>>
>> It is one micro optimization since test_and_set_bit is much heavier than
>> test_bit, so test_and_set_bit() is just needed in the 1st time.
> 
> But having the 2 calls test_bit + test_and_set_bit creates a race,
> doesn't it ? What if another cpu clears the bit between these 2 calls
> ?

How so? If the bit is already set or you're racing with it being set or
cleared, that race already exists before. This simply prevent
unnecessary dirtying of that cacheline.

-- 
Jens Axboe

