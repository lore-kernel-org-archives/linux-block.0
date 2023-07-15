Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EF8C0015E
	for <linux-block@archiver.kernel.org>; Sat, 15 Jul 2023 15:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGOPug (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Jul 2023 11:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGOPug (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Jul 2023 11:50:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F99C2691
        for <linux-block@vger.kernel.org>; Sat, 15 Jul 2023 08:50:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-682b1768a0bso749613b3a.0
        for <linux-block@vger.kernel.org>; Sat, 15 Jul 2023 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689436235; x=1692028235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=viRF83/9E8yMhnLxGklSJSnZzAPuw2fcP7Wt8WOYpf0=;
        b=Qq7Df1Jjn+F0xZPWGHz38dvOGuQyt0QYLLfEcr9IPQNwaoEeVwUF2M2bYVZ/Ov6wBp
         dmQwuh0+lOvzkNgOAgDHB5+7GlS24+pP6r0miMLPOKjdEww958jC1chGZo9KVmn8aaYy
         atzN1uhDR6HXyPRvnV4K3TAZbwXSGyK+X8/rJ809Gv4Grb7yD5mDqNMxY4xd9Rh3Z+z0
         f67lQPUPzu5rG922aYXqeAtp4K3gL7VYruq6I7g8V2uOYWHj/rnal411+J6XZ+7RRkw9
         z6vdGDMS5ZH7/0R26KxGbTNIrwxzOVR9cqidMmW93ugN9qiY9RsY7+8jsCzIH4QnSx6/
         ZbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689436235; x=1692028235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viRF83/9E8yMhnLxGklSJSnZzAPuw2fcP7Wt8WOYpf0=;
        b=gotozo7AEU09LupwXhf/qe2FaKA2Jnt5jlc3VjHGzpQQTHpJ/O23qO9i8+DWoW9DBm
         aXZHIuSZaSPuaLB6xOwExvJtyMYC1MS/BHnh4rwq874WhqDJOP0RxIT8mjEZoKdxXlye
         99aEWhwcpyhJUzE9TGd9l0cfMnDTyyvArD95BwE4eZ2gtXJJmNPFvu3MdshRgacf3C6n
         eG11rHrWYs5mnu3Axsr6uHU0hJGuR5etqBjEozuEywtcv3SlRDSVDpOAJUeyuCMAY91v
         f65YOySrm1436hN6SiXfXkzruSgIw7cVgAzPWdRjO3oIxE3tA1Wi5clTVldmhkxsH2Vl
         4Zog==
X-Gm-Message-State: ABy/qLYk759b06yBxuLL/OqEHUL5O+Q/ge4Dzp3ZSoEcvaQPjRvnycX4
        ZBze88RZQF0PIuWQwpCh6aWJ9oO0+iHbed9hzM8=
X-Google-Smtp-Source: APBJJlHqtmXr2msJpXcbmI1N7JaX9U47XULXWgKOJ8PwpoWSnEEiuick4/e02lD4ykQyy5IKL4An9A==
X-Received: by 2002:a17:902:c945:b0:1b1:9272:55e2 with SMTP id i5-20020a170902c94500b001b1927255e2mr2673250pla.3.1689436234708;
        Sat, 15 Jul 2023 08:50:34 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n13-20020a17090a928d00b00262d9b4b527sm2604748pjo.52.2023.07.15.08.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 08:50:33 -0700 (PDT)
Message-ID: <631beb86-7bb2-29e7-44a1-515bd0dd9571@kernel.dk>
Date:   Sat, 15 Jul 2023 09:50:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: don't allow enabling a write back cache on devices that don't
 support it
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20230707094239.107968-1-hch@lst.de>
 <20230713134303.GA25950@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230713134303.GA25950@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/13/23 7:43?AM, Christoph Hellwig wrote:
> Jens, does this make sense to you?  Without this we can deliver
> flush requests to drivers not supporting them, which is a bit nasty
> even if it's not exploitable without root-equivalent access.

Yeah I think so, I'll queue it up for 6.6.

-- 
Jens Axboe

