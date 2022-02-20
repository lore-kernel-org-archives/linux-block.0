Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A38EC433F5
	for <linux-block@archiver.kernel.org>; Sun, 20 Feb 2022 04:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbiBTEiv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Feb 2022 23:38:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiBTEit (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Feb 2022 23:38:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EB037BEE
        for <linux-block@vger.kernel.org>; Sat, 19 Feb 2022 20:38:28 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso12192282pjl.4
        for <linux-block@vger.kernel.org>; Sat, 19 Feb 2022 20:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rarLEeWl7Jkzp0L5XhsI/l0oWNo+x0Oo6ZRlLhAli98=;
        b=G+XAmvW7rWg3IDRbr77eU/EpbCKWve+wFVhQeOMiLasFu+J9wt4XNMXmxHt8mif4OA
         7Ek6rHVPPTmvQ/1rAU6UTZQzHBJbSlQ/Bqi1/bOPJMNSjNbKYdXdNDBq0bLabc1MwtUk
         uIGirQNSuS6XRTNjZPZUMjw3evXQ+PbiOZwm7PbjdSfUzKtOCCGMDB2wGAmSVHaAWbuB
         d4sMEXutZlpRvqa9WQd/UiPqXGmazcbvOGL6ng1GrJAbLPsaMzDcgzVs6uZYdhTbNQ3E
         nM3ZU4hA3Z9KNfD4XyafklCN+fVy85hIw5zJ7A6e2eA8qJj5gDCO0N7jMkIhuRBxixWM
         SH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rarLEeWl7Jkzp0L5XhsI/l0oWNo+x0Oo6ZRlLhAli98=;
        b=62lo/a7g/8i+I80Qov9873dLEkmuddjECSHQOckNx96y7h07jXBLKDLSnD4qBMapZK
         9Ql8wlyKVXYr6F4d+hz1uEi7faVJ22nkSiWad08yxNLumtEPikWiqvmMcQ4RGAugAUyg
         pWaO14iCaHwhRxg6lYJZem/vIuL823HGI05AIu6Q0zC1vThOTrnmm9vqaIcjSQflW6LQ
         3EJW1zAwNd3p17+zKmrcFQ1Zsrav7W8HH/0FgKsTaH5JIfA+ufoZqvHPzalbKaL1FfMk
         BUHEcqkPgYJSdkQfdFqihGQevTT4ZkQdP6IMJSziMaAttr1EaweWUZaKKjkcCl5Yi6hX
         sVGQ==
X-Gm-Message-State: AOAM531+uRRgeZDx1kOkLt+sgeoMZU23vHTGdT8DeP4ORGx1knPbKLuC
        EO5Z6UPb9Jw4QEJI1UlHgv1EVw==
X-Google-Smtp-Source: ABdhPJygf81+/wTX7gIEiPky2GmcZv4lalJOOWE6ow+ArFj4YwChbKqz+Cq5frhGuT0O1l4v9JL6hQ==
X-Received: by 2002:a17:90a:5794:b0:1b9:8932:d475 with SMTP id g20-20020a17090a579400b001b98932d475mr15462773pji.24.1645331908402;
        Sat, 19 Feb 2022 20:38:28 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b16sm8114248pfv.192.2022.02.19.20.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 20:38:27 -0800 (PST)
Message-ID: <7b2b2a34-601a-e62e-3e89-e19954dc965c@kernel.dk>
Date:   Sat, 19 Feb 2022 21:38:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 04/13] fs: split off __alloc_page_buffers function
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Stefan Roesch <shr@fb.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
References: <20220218195739.585044-1-shr@fb.com>
 <20220218195739.585044-5-shr@fb.com> <YhCdruAyTmLyVp8z@infradead.org>
 <YhHCVnTYNPrtbu08@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YhHCVnTYNPrtbu08@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/19/22 9:23 PM, Matthew Wilcox wrote:
> On Fri, Feb 18, 2022 at 11:35:10PM -0800, Christoph Hellwig wrote:
>> Err, hell no.  Please do not add any new functionality to the legacy
>> buffer head code.  If you want new features do that on the
>> non-bufferhead iomap code path only please.
> 
> I think "first convert the block device code from buffer_heads to
> iomap" might be a bit much of a prerequisite.  I think running ext4 on
> top of a

Yes, that's exactly what Christoph was trying to say, but failing to
state in an appropriate manner. And we did actually discuss that, I'm
not against doing something like that.

> block device still requires buffer_heads, for example (I tried to convert
> the block device to use mpage in order to avoid creating buffer_heads
> when possible, and ext4 stopped working.  I didn't try too hard to debug
> it as it was a bit of a distraction at the time).

That's one of the main reasons why I didn't push this particular path,
as it is a bit fraught with weirdness and legacy buffer_head code which
isn't that easy to tackle...

-- 
Jens Axboe

