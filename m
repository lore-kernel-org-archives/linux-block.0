Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925DAC433ED
	for <linux-block@archiver.kernel.org>; Mon, 10 May 2021 15:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBDB611BE
	for <linux-block@archiver.kernel.org>; Mon, 10 May 2021 15:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhEJPcO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 May 2021 11:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhEJPb5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 May 2021 11:31:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DA7C06129F
        for <linux-block@vger.kernel.org>; Mon, 10 May 2021 08:26:29 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c17so13854706pfn.6
        for <linux-block@vger.kernel.org>; Mon, 10 May 2021 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LfuoQDxEqiRuhMiD6RbhQDkfT33pXtvKMQnNjfW8zZo=;
        b=VcM/8L24eRIoOK2XWoZy2Z0Vd5qh2F3C5X9SdTRsonDWeOzdO6/wI8KyR9h6gPpGA+
         ff5YCgowe7Vjgl49eizEG9lU+SlqzE1l2onXJaFHryR7LatuNJumbPagyfsnjIYCZKQR
         NdCB45AyxGHWv8NCkU0B4a++dKvtzFQHBOfpJhqu3Tw0Qb3ihPSLbZXDf9938f2/8fHb
         ZVvOZ2OWz4yJjv/qrEa3trZgC8orQv76A2GIRpc0t/iHaRIuEg5691HocOW+y0eexqwJ
         3H6yOoUymLH3tMLQSa+sUJHgBW1yqHwkhXy6RrvNNvJZkRAk0B8PRRCDVCZqrvG6LDHO
         ct/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LfuoQDxEqiRuhMiD6RbhQDkfT33pXtvKMQnNjfW8zZo=;
        b=XFNqNldZPA01WiiDI9uRyTFspuoIWOl1I6QLpaOQWlY15SJMXbvkPeF1zQYjD2Sifm
         t76sx8n1P1D2w46v5myxieUPjrNTLqTumYjiOnph02sG1K50DGWrncrOZukXt+VMgpph
         VtpBzUaxaMAmU0Ocr7owRYtO6b1D5tfgEPNDb4x9sSt7votxWi5Rx9Siq2uckOpOdQBg
         kol5CAXfF6rSkQl0xzrsS5Lvg3YuRDh4LBl60qOFx9RXSDPqJ0Gwy82ujEDneXYCParj
         9paCiL4XjIbbBKc7yKEdMVuaYvTS5v9SUprFYt1n65y4GKUaxy582bx1wOK8B37MDoBB
         XENg==
X-Gm-Message-State: AOAM532+QbUr0Ow8wI8qHF3J3+F+++D98gMgqjQ+yquCs1MIY4fI+tFk
        EXUDCZdt3bcpW1TsqbMIBWdGUg==
X-Google-Smtp-Source: ABdhPJyqCuoqCF57ok/YmAMwxq9NAXMRw1fujUMv7lCu0Jy9GI9q0jAMbmRlncNVTSKCDgVPExzFuw==
X-Received: by 2002:a63:e443:: with SMTP id i3mr25886226pgk.114.1620660389152;
        Mon, 10 May 2021 08:26:29 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id x9sm5997147pfr.175.2021.05.10.08.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 08:26:28 -0700 (PDT)
Subject: Re: [PATCH] block: uapi: fix comment about block device ioctl
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>
References: <20210509234806.3000-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c2974417-a403-b304-ed49-e21afaf712ae@kernel.dk>
Date:   Mon, 10 May 2021 09:26:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210509234806.3000-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/9/21 5:48 PM, Damien Le Moal wrote:
> Fix the comment mentioning ioctl command range used for zoned block
> devices to reflect the range of commands actually implemented.

Applied, thanks.

-- 
Jens Axboe

