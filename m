Return-Path: <SRS0=t6Xx=AJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D51AC433E0
	for <linux-block@archiver.kernel.org>; Sun, 28 Jun 2020 14:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6826720738
	for <linux-block@archiver.kernel.org>; Sun, 28 Jun 2020 14:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="covjbB2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgF1OLo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Jun 2020 10:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgF1OLo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Jun 2020 10:11:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFD1C061794
        for <linux-block@vger.kernel.org>; Sun, 28 Jun 2020 07:11:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x11so6082290plo.7
        for <linux-block@vger.kernel.org>; Sun, 28 Jun 2020 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dpCodjoW4gNcN9nM1FHUfv8KPym8Ogbq+jieMFg8N74=;
        b=covjbB2xcC2zskF5ENENnKpmxzRGEmAGynQTIZo7W5nzFlX62Y/vRrapvvknrTb7Iv
         940m5OhKxBJiLdmiGXsyxGNlBosNkqj5mj0MhMKG5lo9uZE5Ts8P0LjMK/p5KFQKFNEj
         abe/3p6a1PG19Aqu5R5Y/oumyfRVMeNOLjymLLd6KuaAYUI9UxXkPszOg5A8j7jKPiw3
         e7BOjg83lb6GAXuCDir5Xs1cQVZl4WoS1FIuVCnx8zO4RG/pSPkoKBXBh4oJo9IYRfB6
         TvQgYrKr1QSPVl+CN2RM2lqNu9/hvk29J1QriEEa4v4iv7r2Qk8quUSkcr/2EPYbfroh
         tDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dpCodjoW4gNcN9nM1FHUfv8KPym8Ogbq+jieMFg8N74=;
        b=UtorN3OxmSKDeNxvYak7ctVZQzs+ITYEY6/jc5CODWsqFRgmIbrKwfOYMBbAxLGhxQ
         nyWeKmBiv7J8St55alErsPhfD1ddOgpCSeZRn0pIgnx1AAqKmrRhgl74xmSqm/1y5exk
         e5uBwMY9RSkY9x52JGmTQWM5zOGqahjIcGjSCrnpVkmCzh0jVeCKal5WQRmBFWFurALV
         8xsktV4Z2zNBEPbIVkzi8BxmkPNnBK3+rm/vqEqOQB+15D8L4CqT0sBlrD/W4aNbHomq
         /zlvJJyuCwhHjvpbe1FhlATRN9MfJnzsXsz49OGOVlpeOt2Bj7jZN8CK3MEA+BtF/7F8
         mTzA==
X-Gm-Message-State: AOAM533NqRcnpAB/6ZcctK4L9YzDSe6BZ/xAPG7ELcitZ+/VvKt1g3Kp
        dyd4kmgs10MkFaNMi0CPnk2AIg==
X-Google-Smtp-Source: ABdhPJxD5LRHOtd+5KcTgu/zxTNBJmRvG6jE9vBLgER/pqiL0Vp3zHAkoU1m6DUA59sZGlWWRkHxHg==
X-Received: by 2002:a17:90a:9b82:: with SMTP id g2mr12167278pjp.187.1593353503732;
        Sun, 28 Jun 2020 07:11:43 -0700 (PDT)
Received: from [192.168.86.197] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id q29sm9573545pfl.77.2020.06.28.07.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2020 07:11:42 -0700 (PDT)
Subject: Re: [PATCH v2] blk-rq-qos: remove redundant finish_wait to
 rq_qos_wait.
To:     Guo Xuenan <guoxuenan@huawei.com>, linux-block@vger.kernel.org
Cc:     wangli74@huawei.com, fangwei1@huawei.com
References: <20200628135625.3396636-1-guoxuenan@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3c60f824-3579-1e8a-7cc5-f411b022952a@kernel.dk>
Date:   Sun, 28 Jun 2020 08:11:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200628135625.3396636-1-guoxuenan@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/28/20 7:56 AM, Guo Xuenan wrote:
> It is no need do finish_wait twice after acquiring inflight.

Thanks, applied.

-- 
Jens Axboe

