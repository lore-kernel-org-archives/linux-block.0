Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B02C433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 11:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC7E61205
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 11:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhKDLsc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 07:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhKDLs3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 07:48:29 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1029EC061203
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 04:45:52 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id f10so5862537ilu.5
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 04:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=S1qFS1jMjwj/T0yJQwZvrrHWJoJ7Nzy4g0iaJHKu/8U=;
        b=Kd3s6O7ChYxD9JC6o9s9ReXrYG1jiSKr+18sYKuUvK89lUyVpf0eG7b+uSXK34Gjf7
         h1WOCyJp3hLuBR6JE4DrkqZ+l+SJdVtnPtx7iTdRTdzeQAHoU+ZV0RuzzA/0MhcP5Lqb
         oihE40aHorH9SIPFZQThFxbYXzQbwzfBCD9gnA4z9aXbbIMQNf/A3rG83aPprvRbGGGY
         KCsWxxH6Jlb2I0cGChxp2trAmEFOmfDJSMH/1RGdUSh4WeQJBAZy1nVnhcmGLHUoTdnk
         qFASVJhNjRtKqYiVmmTyVo5llX2i0tNIwn2jkZNMHA5nny/1Kb4ohSFFph+Qy1R7uvuu
         kDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=S1qFS1jMjwj/T0yJQwZvrrHWJoJ7Nzy4g0iaJHKu/8U=;
        b=jGn5GRTGGZztPA9Mb1MZoZwEHdfCF4bKbXejsiZf7DNwI7NNfxX1XpU+Ak5v+bx+4J
         pgvQl9n8u4HjVXhWAyCfZaAe/kwWrXdUBFD4fPUHYwDrGNDkt62Y47p58Ue8pPXOFYCY
         bspeVVwbsLMDSO3EcOkX2WI1xV7M43oDa1RWRKRyHpM273Xnzhi1bSJSnCgBJ3i2Nprs
         umWHJbWmB/BummolspGjNzc6V3MjtUSlYsNPrkoAKCBL7O9h2U1bRuoxvTlui9xj/oWG
         lHHEMYrvB1AB3VDPDVAaWI/mQgjg6rODAG8UKR+zkUYQowKPKW+4M3Y8DDrzVDxQuLCY
         Ic4g==
X-Gm-Message-State: AOAM530DU6iMUxme1GfGcqjyeWfq/TR8JVQ2+oBY/2l9mzB8jVZtjrqH
        4IfVTkM/DWfQej9+NG/YOVWRFA==
X-Google-Smtp-Source: ABdhPJyl8OV+Jv4v6fXzPNd9zMbs4veLJQA2Z1RiJSGD2iP94vwTsc+5cbT4GjalzBM1M8ol8RVTOQ==
X-Received: by 2002:a05:6e02:1646:: with SMTP id v6mr36447239ilu.282.1636026351484;
        Thu, 04 Nov 2021 04:45:51 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id c4sm2395231ioo.48.2021.11.04.04.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 04:45:51 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     lars.ellenberg@linbit.com, Wu Bo <wubo40@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        linfeilong@huawei.com, linux-block@vger.kernel.org
In-Reply-To: <1636013229-26309-1-git-send-email-wubo40@huawei.com>
References: <1636013229-26309-1-git-send-email-wubo40@huawei.com>
Subject: Re: [PATCH] drbd: Fix double free problem in drbd_create_device
Message-Id: <163602635079.21562.17386310945369487784.b4-ty@kernel.dk>
Date:   Thu, 04 Nov 2021 05:45:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 4 Nov 2021 16:07:09 +0800, Wu Bo wrote:
> In drbd_create_device(), the 'out_no_io_page' lable has called
> blk_cleanup_disk() when return failed.
> 
> So remove the 'out_cleanup_disk' lable to avoid double free the
> disk pointer.
> 
> 
> [...]

Applied, thanks!

[1/1] drbd: Fix double free problem in drbd_create_device
      commit: 27548088ac628109f70eb0b1eb521d035844dba8

Best regards,
-- 
Jens Axboe


