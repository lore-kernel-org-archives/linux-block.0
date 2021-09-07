Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B847C433FE
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 17:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C60C610CD
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 17:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345654AbhIGRRy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 13:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhIGRRy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 13:17:54 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49CEC061575
        for <linux-block@vger.kernel.org>; Tue,  7 Sep 2021 10:16:47 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id l10so10817450ilh.8
        for <linux-block@vger.kernel.org>; Tue, 07 Sep 2021 10:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wTw03npSpZV5D2bz9PjB05Ha/wja1cr8lpTCy5wETK0=;
        b=RyeWP3+9sHYBZSWBRUbnWvoQh0fSSK/gWboO04UTyXePFITAuIa+6TVRFAQXcZ3Wfu
         VLz1zHyKnRPr61q/DghfEG66sc/F4cKAiyAkA5sTkrjhByLb9kAs7CjAm4SlbnNoYFbN
         DAfTQiYolQW1RfB41qRnmlmT0cph2d/m+/r2sneiZtzlSNTQWwHFw7dNCfjA6aq4RRvf
         FLjkRLm2zTC7SL2gRUHJ8346E43BHgJw2v++4drAAwntbr0YzTTLAWYH32skIE5pfRKJ
         PoIXvfbM1C2ywNUrPtL7AuI8LAaMrpAhl8r+q2vCyYf6sgj8EydP0kTwdCIUT4mOgleI
         ZflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wTw03npSpZV5D2bz9PjB05Ha/wja1cr8lpTCy5wETK0=;
        b=Z2RyBZXRepIz2KNJEo12ugYQhEHDcqMmBsaB9S/c+o3vPu98a/yLfLNPfDaLrXkbtm
         Nv1fjLYpXD2U1dKTKwtrmZxlC41t1cvlMGBkNtuiHmqaGlsypkCpDLX6ADK0/McZGbps
         jnt5WCdKL1hP8tB6t3ICYGY/VeOJXf51FEym5qbQtnaig0Vj8Aeb0wgI9OS7cz++/J1U
         ntNVdg0aZqVlbuVZIxv5tA9gswmv8+jBROsGEExm+EnLtw7VZxYMYudffUXAgU2zjIBr
         Z487xCdJPmHPOlH4CXBeAUny1DbkCtM9hYgFbFz8Cs+iLZy7yygshpfujwGD0MsYC6Km
         ldDA==
X-Gm-Message-State: AOAM532HBx3FYRZF4xXjl9rDf1oFRHwRzgYUkNIeOuV/RiJJ8YAMggbr
        13SGCD26M00sO6h0wtaYbtFidUeHnxp7Hg==
X-Google-Smtp-Source: ABdhPJwPvWZhoJX8Aivwk2201tCKn9HMxapMxc/KJhnLStvBZaZyUhkb2QL8xjBJjQYA3AvH+O25zQ==
X-Received: by 2002:a05:6e02:f44:: with SMTP id y4mr12769757ilj.257.1631035006568;
        Tue, 07 Sep 2021 10:16:46 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a4sm7032069ioe.19.2021.09.07.10.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 10:16:44 -0700 (PDT)
Subject: Re: [PATCH] block: genhd: don't call blkdev_show() with
 major_names_lock held
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>
References: <18a02da2-0bf3-550e-b071-2b4ab13c49f0@i-love.sakura.ne.jp>
 <75efddd1-726c-4065-709c-0c88c03c38ed@kernel.dk>
 <0123937a-2e94-a1f8-110a-ecd0d3d7f0c6@i-love.sakura.ne.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c9f4f443-4aac-6ffb-530a-7cb687c54305@kernel.dk>
Date:   Tue, 7 Sep 2021 11:16:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0123937a-2e94-a1f8-110a-ecd0d3d7f0c6@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/21 8:42 AM, Tetsuo Handa wrote:
> On 2021/09/07 23:36, Jens Axboe wrote:
>> On 9/7/21 5:52 AM, Tetsuo Handa wrote:
>>> The simplest fix is to call probe function without holding
>>> major_names_lock [1], but Christoph Hellwig does not like such idea.
>>> Therefore, instead of holding major_names_lock in blkdev_show(),
>>> introduce a different lock for blkdev_show() in order to break
>>> "sb_writers#$N => &p->lock => major_names_lock" dependency chain.
>>
>> Agree, that's probably the easiest fix here. Applied, thanks.
>>
> 
> Sorry, can you update the patch title to:
> 
> block: genhd: don't hold major_names_lock in blkdev_show()

I already have a number of patches (and a pull) sitting on top
of it...

-- 
Jens Axboe

