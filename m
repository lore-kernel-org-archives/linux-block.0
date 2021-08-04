Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F490C4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 17:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD65361004
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 17:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbhHDRPv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 13:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239695AbhHDRPu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 13:15:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E983BC0613D5
        for <linux-block@vger.kernel.org>; Wed,  4 Aug 2021 10:15:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ca5so3951830pjb.5
        for <linux-block@vger.kernel.org>; Wed, 04 Aug 2021 10:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KZrBFJk7+fSvi9acM1VqWv6+RFPRIgc+heCnSimljaE=;
        b=vSIIEfCJsKvKkDIVEkwISGOnMS7pasIDB+FSS1nR5zTcXTXeQUzIXpiTfQFITdDgq4
         N9SlmyYHya82KGjxw9UfbsZsMXR0xrKi4dukgUVeJK+beu4hTcl3IchaOnMdcbnMkjeD
         7j8Yot/ITXvJ3uFIx5YRhmRilMOF15hxIGezhRbR46Ldx1vHGJHVJak53xOfdtukE7Uq
         VddjUkg1dtrPiVbi4NFMA3YrbNOk92mebweEvRkHMGx7JI0hwWFECLkA0JED4lwRvIQL
         H4nG38oMqAcwLZg9Aq3ypWC6hMVDFZe5qG3dffYV/dn8X/rHjOt2OL3ag1Cy3hG30eqC
         G1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KZrBFJk7+fSvi9acM1VqWv6+RFPRIgc+heCnSimljaE=;
        b=Q51TOZ3rPP3f9vnwUpRKNxvU1PlN4NkomsrBK7nRj1I2QXKcda8jC1+AvWpD2Mav+X
         +C6lp7Rg1YUulxAcKm2STgBDmeFWFbSiaP9yfWBP38mVoC7MQIcmdvoG5Y++ripFVDIf
         3WsS75TQhZQc4pISIVWt2ssktmxquFuRiPI7YkuaUmIfK2g1DsRK9fh0nlWPpfYlKZov
         0gtLAs7M1UM4LM0AlzAwaVW1hVa6wwd1p7e64FmGcQuYW8BNivdXWbeVIFOYsd34Opgo
         6CrGkXLvNvoVYxFnrHKkAtxOZyDoi3L+a6oKyx4Hp+y+IfFUJJj4sO1TgZNBX21goJkM
         YpXg==
X-Gm-Message-State: AOAM530JZdfrJBiChulqLhcs/bC6N6BhpQetcW711R2JCiFAh7z0VUc8
        5PmyFcY/QAzT7lJ+g1G8WEpRNaI55VD4jlfc
X-Google-Smtp-Source: ABdhPJy/sYpxr9XWnnigHZIvwUsTYNJdbu2+LxwvGJVSp6vsrj0NldHjUQ3KuBMYneYFQHUhUd0A4w==
X-Received: by 2002:aa7:870e:0:b029:3c2:f326:468b with SMTP id b14-20020aa7870e0000b02903c2f326468bmr681482pfo.53.1628097337274;
        Wed, 04 Aug 2021 10:15:37 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id l6sm3587987pff.74.2021.08.04.10.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 10:15:36 -0700 (PDT)
Subject: Re: [PATCH] n64cart: fix the dma address in n64cart_do_bvec
To:     Christoph Hellwig <hch@lst.de>, cand@gmx.com
Cc:     linux-block@vger.kernel.org
References: <20210804094958.460298-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f72eabd-2048-8f8d-7972-db1bbf70425a@kernel.dk>
Date:   Wed, 4 Aug 2021 11:15:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804094958.460298-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/4/21 3:49 AM, Christoph Hellwig wrote:
> dma_map_bvec already takes bv_offset into account.

Applied, thanks.

-- 
Jens Axboe

