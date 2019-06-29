Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A468C4321A
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 15:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EA12063F
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 15:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0wixtZoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfF2PsQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 11:48:16 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:43244 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfF2PsQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 11:48:16 -0400
Received: by mail-io1-f54.google.com with SMTP id k20so19001050ios.10
        for <linux-block@vger.kernel.org>; Sat, 29 Jun 2019 08:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2665xxAu0xc/EySVnYJeUrf9EBLmh5u0ASfFzsrcyRU=;
        b=0wixtZoeaOTCM0sOnV1nLUCAPVlILakuBLQ/zQeGJtIenOgSz+zvFJrVVW8O6bjFm1
         FQwhtScH1bnqHFowBwuJ/IZwfFwuDkjTuinRuIFzE0zKsnjrfkf8pkWBCtX20hpWVYsH
         8sXYkO+uMxXtEg9Gh2lyamxy7IzeBtvp1kTopwAlsVODKFUQ4YdUQ2+QF0M+BihPVMf1
         bwUpQGn6B88LSyxqM5LOCxE64jhT5HLByV6ddh8TWLhhepPl3pNEkyVMSvzdGRF0e8UQ
         tdW7mYIZL6IesK6mkdh3A5toRxkCRtdc2YKdzgiDPXjjxR8WgTS2fUX4kSBAlhsfbXqP
         fN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2665xxAu0xc/EySVnYJeUrf9EBLmh5u0ASfFzsrcyRU=;
        b=SQfudY8e62AYL9b0BDe0OXLi50dNNatqqAF++18tTAGPylujKZD3vRGRLBu/mAIlDb
         imDErIascmQ4kZ5BZcSbr9kiPUpUu1ITQ4aOmmeRnfdvgiqBwXiKjguRVI2gFXew9HS/
         Pggw36eQICcw68vVQibpuVI3E3cz1qxRyvUhwEa2tjWTNva7yOHiyZwOjOlKOGjK7lGE
         lszfaIOX6bpHYQZ/h94TrG5fvjliac4jgIE2M8LuvSn3wRTbKxYzdMzvioSp9vXStIna
         L7Sg5l7QGyQmkY7WVKWdBdApnJsc9+tEQsE9NOs7jGqDToEC9+tu+WsopglSvG5h+goV
         xinQ==
X-Gm-Message-State: APjAAAUHWMhTwbifRGwalWOoMt8zXCbLNxWwmOsMHN9ID+wx2zLxjR3Z
        4h39Lbye3OwO054zSeFwzC84+YE/W79GDA==
X-Google-Smtp-Source: APXvYqzXb/wj3KXBuc5anoBUclmoqRTtY61BAar4ezA4t6A2JFlU7at/XzBSru4s6ilTVUFN7H69bA==
X-Received: by 2002:a5e:8704:: with SMTP id y4mr1093113ioj.135.1561823295031;
        Sat, 29 Jun 2019 08:48:15 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b14sm5465824iod.33.2019.06.29.08.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 08:48:14 -0700 (PDT)
Subject: Re: cleanup bio page releasing
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20190626134928.7988-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5106ab69-b57f-f82f-b2e8-324bec4284f5@kernel.dk>
Date:   Sat, 29 Jun 2019 09:48:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190626134928.7988-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/26/19 7:49 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up the various direct I/O and pass through
> routines by switching them over to common bio helpers.
> 
> The last patch just unconditionally applies the no page ref
> behavior for bvec iters.  I looked at all the callers, and
> there is none that drops the pre-required references before
> completing the request.

Nice cleanup, applied.

-- 
Jens Axboe

