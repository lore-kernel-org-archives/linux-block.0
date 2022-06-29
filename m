Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6A6C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 14:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiF2OgJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 10:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiF2OgH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 10:36:07 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BEB2FFFE
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 07:36:05 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 9so15503304pgd.7
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Cg1pbA8vIKsss/kduipyHmYHYgUtQpcCeOfwW78IFgk=;
        b=GcMt/zaitMPYugutR+SZbG8M9T/N16kxs59mw5xfHrWn3wgmjtCps6KvZUculXB/zP
         BMNQHYek++ptp4nFdFap2MU2a/OQvy9lEtvJxjQjEvwj3DRP2+QE63Wzslc9YzV3aPnS
         s/E/AzNQsF+oHLGpZDQw5pnOZ5UBcngE7pQzWIfRrXvKSVfh9GawDvVB99rYE+wEhDDE
         ZNZBwV4f2if5FBySi+9K2gXfCZau0UND++tVj2U2t2OVAE7D3VxT8G2wAl+b2C88+UCU
         vBWpBhC+bNCptN0X+Q7TIIHyWf9wmpvfJVrC3ct08z2tjf57t+HZTAwwTyJSFNufpJDt
         s/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Cg1pbA8vIKsss/kduipyHmYHYgUtQpcCeOfwW78IFgk=;
        b=qRp/Nt0OhRvnWQjh4JchTwMHztyxfWOR9Ep3EOK8gVLF0tcGllst3Cg11JaXPdB6BC
         uRSTCCx9QUvdMCo1V2aVWwoIV/d1E1fFNaA/4WJcUfbiZxln9+9zlauwIHhmnKJ22P9C
         bn5HU7EAlTT47qnTDutqupy5gTUiFTywHaAA59DVggxrTKIInl9EaEQMYSbwOnLKzli4
         NugXWn4OuxkkcGotmtGnGPK2l7ko12nfCr/d/AS08SJ7IyZI7F2/uBfM/wpitIyQ3zn9
         BfBeZt/XaTOj4y+6OqbqpO/nrkFFatKrYml63gvM96idYdxDIBD9DvjMUGo9Jbrr9Zx3
         uy/Q==
X-Gm-Message-State: AJIora917BN9DHYr/Fb8H68gBohottfXFhj6kIqXkDbZdd0O3SEn3y0T
        Xx1/W5UFm+P9FW5toFATE5Gm8A==
X-Google-Smtp-Source: AGRyM1stm4fyWSf7REgYqTMd1NfRqcl//TAv1qlj6MdBpHhH4uFqSyO2ypVvwasYllN/edw/OpgRlg==
X-Received: by 2002:a05:6a00:1748:b0:525:4731:7f11 with SMTP id j8-20020a056a00174800b0052547317f11mr10798576pfc.72.1656513365429;
        Wed, 29 Jun 2022 07:36:05 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902f14400b0015e8d4eb2d1sm11335911plb.283.2022.06.29.07.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:36:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     sunying@nj.iscas.ac.cn
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220629062409.19458-1-sunying@nj.iscas.ac.cn>
References: <20220629062409.19458-1-sunying@nj.iscas.ac.cn>
Subject: Re: [PATCH] block: remove "select BLK_RQ_IO_DATA_LEN" from BLK_CGROUP_IOCOST dependency
Message-Id: <165651336468.5627.13656015345010304082.b4-ty@kernel.dk>
Date:   Wed, 29 Jun 2022 08:36:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 29 Jun 2022 14:24:09 +0800, sunying@nj.iscas.ac.cn wrote:
> From: Ying Sun <sunying@nj.iscas.ac.cn>
> 
> The configuration item BLK_RQ_IO_DATA_LEN is not declared in the kernel.
> Select BLK_RQ_IO_DATA_LEN is meaningless which could be removed.
> 
> 

Applied, thanks!

[1/1] block: remove "select BLK_RQ_IO_DATA_LEN" from BLK_CGROUP_IOCOST dependency
      commit: b9a1c179bdfa133d28ab8b7d30631b0accdc2057

Best regards,
-- 
Jens Axboe


