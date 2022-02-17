Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5630C433F5
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 02:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiBQCnJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 21:43:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiBQCnI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 21:43:08 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23BC13777A
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 18:42:55 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id i10so3521153plr.2
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 18:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=CmFv591RVziOMGyva7CK1OyY1reRY+ksBkQCUtve7MI=;
        b=B9iTA73G3WKqtsBDfVmPpqdkIpWzEGwkMOGMyBBBBPIsyyB5EV1mkLR/8ZmKHbhf1q
         qbyWm72tgPqj4nvMbryaKZQHHemjYaoXBN5n2K9CTjDwt4Mj44sMVu8O9u60H5wwoBgn
         +Y4RpPZr8NpFcQ+N1Cj7VHDZSQueXJNLvDPJFl4NyFsvw1yikCgJxbUupImORW4++g+U
         /WxrBkkU3c67AMKnqUNHc4iZIlx7OwAEG7AxePV4PtH8sYEbkLvyd9EJTpVQyK7j1zVd
         ArLtaMnq+F8jCoFacglSum72wqdEZ8nso5+sijpAy4iEkGpbshY1JVUJjBMAP2y5mfUr
         x75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=CmFv591RVziOMGyva7CK1OyY1reRY+ksBkQCUtve7MI=;
        b=I0znKY0G39foXuBCQmN4V4pQSsRrMuwtgW/NG5+q+XQdb2rXx7r/dh1E7oyLMtGIkC
         6xiiccgGtzjsgb36l4g/dV0M2EK97aVkkBGitCx2Wnz58fMtLzs8zO2SPHhCxs71aOEh
         QmhosWvV+Nc6DRsDOGavNfGKHQvecy7IyPUBU9Adj6VRm1elnVV+cFOsCn3PCTxGfXyH
         /IACag4An21BXLzGM7V2I7Ga7wraFQVkAJJZzuhJZf5AkSnPS1jgd5+sFcG9TUgZs6CV
         ArfSebbceEu0oYKkmrjQx2sxGILSWPQLVQoO2j/fF4VUlLJmg8NkOoeePL3Mp5M26Wxh
         6QZQ==
X-Gm-Message-State: AOAM533dlNz3Ac1pNRBM+vjElNa+p/Cno6tw/EcqLzChpqxjPt+bhkCS
        Wubsif7gSeJPkKV1ukVnJBpIDMBeaPh5Wg==
X-Google-Smtp-Source: ABdhPJzlykE4+SAFU1gpwDr/UNFiIZYwYI7bsZDh05zSQgMPY40FMvKe252PStCUrN3oPvIuvV/27Q==
X-Received: by 2002:a17:90b:1b0f:b0:1b9:f5ac:ae53 with SMTP id nu15-20020a17090b1b0f00b001b9f5acae53mr851369pjb.71.1645065775131;
        Wed, 16 Feb 2022 18:42:55 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g4sm45051723pfv.63.2022.02.16.18.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 18:42:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Haimin Zhang <tcs.kernel@gmail.com>, linux-block@vger.kernel.org
In-Reply-To: <20220216084038.15635-1-tcs.kernel@gmail.com>
References: <20220216084038.15635-1-tcs.kernel@gmail.com>
Subject: Re: [PATCH] block-map: add __GFP_ZERO flag for alloc_page in function bio_copy_kern
Message-Id: <164506577414.47948.12838599291497895748.b4-ty@kernel.dk>
Date:   Wed, 16 Feb 2022 19:42:54 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 16 Feb 2022 16:40:38 +0800, Haimin Zhang wrote:
> Add __GFP_ZERO flag for alloc_page in function bio_copy_kern to initialize
> the buffer of a bio.
> 
> 

Applied, thanks!

[1/1] block-map: add __GFP_ZERO flag for alloc_page in function bio_copy_kern
      (no commit info)

Best regards,
-- 
Jens Axboe


