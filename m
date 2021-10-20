Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097FDC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 13:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D521B61374
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 13:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhJTNUg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 09:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTNUg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 09:20:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03EDC06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 06:18:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g79-20020a1c2052000000b00323023159e1so1671459wmg.2
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dAHBCFm4RKad/F76iwwseDG/4ljKa9YGxn0tSJdxc3o=;
        b=ZSC31wTKRA/FAQOvFIpEj0CKvJoFmCd8Aw7wxpqDeVJtPVLlTVV5GKpMhLC9jYVtAg
         sbYBarJL9Ice14pQRCS0jGJoKOCgGmh2w/TqHsUvpOF4dZTn98Qrc+DBAklLU+CPRWfN
         gZooJYyazbsxTNaJViIdGH+7a5RUEvp2VcA/02XGYpRxp4Y/27dFS/PraSOMwRGN4w7Z
         39/F/Uekhzj7MXuUFd70IYDPIC1qkkCxNNSfOsTRiVEKKFlAQQ8vxSimqHpg9qcBoLWo
         NIN6Pmec92Fbt2tv+HfEKQUlV4NkTEOSGlFQdHq2d/q3az3v4SxqYjXDZiWMtHiZmblc
         8bHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dAHBCFm4RKad/F76iwwseDG/4ljKa9YGxn0tSJdxc3o=;
        b=oBY8oQHqHxv3Sn0bY6FB+giOwNDo3grHjwT1hWhxPDdYQBq9QsfSewfxaLnSNQwLEW
         EwgD/w+rfwnyJx4RJmS1k5aOVNr9OEWbROtksIBH+DVvgEwtmX2p3/EowUPV6/Us7Ris
         4D13mqGD8hZXQBObBzPBRKFvMZO48oSDXH6lbJw0Ve+UzoATue34C4jDSEM2Tb8Si0wQ
         2mybi7Z/EoV24haz5Au9yCRyKwMsMcAzHYZGuO9KhZHyJkb6Fu714i0XL4bJruyzZQEX
         /0kaXDWaPdSQoCHiSolum88ltNb1FCrxUIonIYXg2kfxfyONqYOgZXAnNTaxw8Sjbbz4
         Enlw==
X-Gm-Message-State: AOAM532I9UvVklyHhVzUZcKK075QQ0NkN2h2qMdTSymsUjfkbdZg833f
        xV1oavWxfpbyKdsPZCmRmvhn7q3Wjgw=
X-Google-Smtp-Source: ABdhPJwfoUbhaz8EG3LbP29H2TL6wAO1M0CxfXFtqkhlXaPhM/3Pue1gXl2M0XdP6sYmCgAZj4LRQg==
X-Received: by 2002:adf:a455:: with SMTP id e21mr50799411wra.232.1634735900149;
        Wed, 20 Oct 2021 06:18:20 -0700 (PDT)
Received: from [192.168.43.77] (82-132-229-137.dab.02.net. [82.132.229.137])
        by smtp.gmail.com with ESMTPSA id k10sm1985649wrh.64.2021.10.20.06.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 06:18:19 -0700 (PDT)
Message-ID: <d3092849-4361-e28d-4490-1d67e197035c@gmail.com>
Date:   Wed, 20 Oct 2021 14:18:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 07/16] blocK: move plug flush functions to blk-mq.c
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <bb6fe6de2fe6bd69ccf9bc8af049ffedcf52bda0.1634676157.git.asml.silence@gmail.com>
 <YW+0h4nARoKeonn2@infradead.org>
 <366c2f9b-c255-7140-a2e0-d93856017bf2@gmail.com>
 <YXANeFjY0Zw3e1vT@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YXANeFjY0Zw3e1vT@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 13:37, Christoph Hellwig wrote:
> On Wed, Oct 20, 2021 at 01:23:05PM +0100, Pavel Begunkov wrote:
>> How about leaving flush_plug_callbacks() in blk-core.c but moving
>> everything else?
> 
> That's at least a little better.  I'd still prefer to keep the wrappers
> out as well.  I've been wondering a bit if the whole callback handling
> needs a rework.  Let me thing about this a bit more, maybe I'll have
> patches later today.

Sure, I'll leave it to you. If you'll be changing parts around,
you can also fold in that part of 8/16 that avoids extra list init

-- 
Pavel Begunkov
