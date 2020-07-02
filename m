Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D31C433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 19:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD6C20EDD
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 19:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Vx4RHPKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgGBTII (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGBTII (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 15:08:08 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA547C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 12:08:07 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g67so13015255pgc.8
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T063m9V2yS56gyo7MUGiVgmVZxOeUawi6FvQ+wuuUt8=;
        b=Vx4RHPKFkeCP91/449fJQrch0rvaky1THr+GN+1q3SvkfFsGwdKgqOLRXGFkIiRS/p
         C22jvy78qu6ZB+V8f2CuN5sp/lyCKe6jFxvuhOWwLHgUvXDuDaSwbtAEgUBNmk0MPbR8
         UDkleOrJz/pqDZsKfBhNItSht1KD+EzzXdJ57HFmmBoTAPvVlk6q1PEZ9YRbngKjd4Cy
         Wl08Ii1psxfY3HnjY76GYBdyKYyboa/gtuhzOKAmba8Sdv5Axjfie47hh5WgSV8Xo8Yz
         SmIw32wFCHCDCd1UfkJDOMvRQqLVboEbpPaoDp1FWoDlIhp7f1MR7E8RN2Lf/cmQnC2n
         0Cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T063m9V2yS56gyo7MUGiVgmVZxOeUawi6FvQ+wuuUt8=;
        b=cqxtRxmysgJDdBeD4q/Me9+opbCIm2KgU2Jc3020EKsMnQXBEgNNK5AlFQdiKeSTcd
         IGkeGm2L0p/g5O1vF5FaeO2S/bP0MAG8aNN0joWZKScWA5nRjIASJ8oHy2VYxBbBobtF
         5BgETcgwZKEu4t/lUBxfbBG3P83wSiLaNP0Ss7L1QIMbwABgdUOWNiAvzL+NnzX/XrrF
         qPLPBxGGDTyxM2q9VYFKG1sRCaU5QysaNbmL6Mo0vR2w0owiFpYVaK59I4+4y2u4GJ1A
         QMuRZBFC5Hfvl/YaI7/7KRA6n0OZEuHuLXHaGhXioIa7DQ9y37rTRFz2jbtTqKIWY0ep
         JGEQ==
X-Gm-Message-State: AOAM532GRpjQaSRo6N1Tze5TR5BSdi5jrFGxCHL/2cM8WNYzqy5ecGB9
        Tzz2zu0RpYCRU+BfuEZifMhxs8CREaS1kQ==
X-Google-Smtp-Source: ABdhPJzFgbYJORwbhbgwrWPY6LTSD3aFe4fjq5QguQy+UpG9mqxMltIP34kkQij67kIyobH/AcII6A==
X-Received: by 2002:a63:dd09:: with SMTP id t9mr25316501pgg.41.1593716887180;
        Thu, 02 Jul 2020 12:08:07 -0700 (PDT)
Received: from [10.174.189.217] ([204.156.180.104])
        by smtp.gmail.com with ESMTPSA id x66sm8303305pgb.12.2020.07.02.12.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 12:08:06 -0700 (PDT)
Subject: Re: [PATCH -next v2] block: remove unused but set variable 'hctx'
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20200702053635.29386-1-weiyongjun1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b9a36992-ab1e-2f45-0959-3e88d7367f30@kernel.dk>
Date:   Thu, 2 Jul 2020 13:08:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702053635.29386-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/20 11:36 PM, Wei Yongjun wrote:
> After commit 37f4a24c2469 ("blk-mq: centralise related handling
> into blk_mq_get_driver_tag"), 'hctx' is never be used. Gcc report
> build warning:
> 
> block/blk-flush.c:222:24: warning:
>  variable hctx set but not used [-Wunused-but-set-variable]
>   222 |  struct blk_mq_hw_ctx *hctx;
>       |                        ^~~~
> 
> Just removing it to avoid build warning.

I reverted that patch that introduced this issue, so I'm expecting
this one to just be folded in with a resubmission.

-- 
Jens Axboe

