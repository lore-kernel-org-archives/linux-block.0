Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DCDC433EF
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 01:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiERBcT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 21:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiERBcS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 21:32:18 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCD8338BB
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 18:32:16 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g184so814830pgc.1
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 18:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=xNnxAHcC3RUWM23wBpMAK8Y3L4EOTebAASEZluO85cE=;
        b=k2hnY/uiyT6WSSX6lxbaW0qn5bcT12bgoL8VXXked6tMGBGzLgQJs7Oe7Ys2h5K7Xf
         YEszS+nJLBhHDEwuXYcLnFJzch8DPZjWPY9KpBzu6Koq7N/fI8jXZQ79Qn8byopnFSmF
         1n2nhjhBwPqGgZjKgZYdpYRz1zPMlZwSvDmrXFXrhnDDPUQKtieYV2cOV7bGifIpJEez
         +pENNh/hdzYuWIFMlS/432DXZoE+hoqz+NKM2fEFmmAvZ6e98hrtoQYalbDp5llI91p1
         aOt8wgtCo/kWgg6DOOSx6Yw7WdvNHHC9bPkFPK9qa4B6H4POMyPPmkgIEuNtxlrisPLQ
         fAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=xNnxAHcC3RUWM23wBpMAK8Y3L4EOTebAASEZluO85cE=;
        b=0rDJ7uFrk/NBl61c30YDozOGkM26n1CHPq1zv+TiGkOtqY8Kj6nz7CynJtJZunkXjk
         0klVJ6H+sbNwl+URF6stAEQgqq/JiKF+9rr1NG62/rrHsVGPsPTPK9W6925JxdP/8xQh
         2fLH4YlUHe1esXYXgwfR03kz5a3QWkDdEel2lGk24LD/M7J7TNtd9ZcGLHPabCWnJjl1
         sPE1COsy6ijV2KoAHrqDDBfkf/VfbXn7x/uDRcZxtvK6LbTcneGUi0zuaQnRJFVRyx/j
         wvEJF2tsg/o//WTNpfSmYsiv+RlqRn1KLxY+RjqH30QMNsu7rdivjQhccB9s67QPYswi
         SBvg==
X-Gm-Message-State: AOAM533PLKF0RD6HBkjYgeCKQu37lvCXpcgj62uGmf6ybwlB6mMx2fJz
        A5MINc2v5/fThDA7055YsiGFfw==
X-Google-Smtp-Source: ABdhPJyyDuelEUIgMnKTcepZxWuBNvDevo2UbPMfYVCqGTACvkXJz5NUXazb0suHLh1CYjIKrN/Iqw==
X-Received: by 2002:a63:dd14:0:b0:3d8:204c:2f29 with SMTP id t20-20020a63dd14000000b003d8204c2f29mr21542866pgg.512.1652837536250;
        Tue, 17 May 2022 18:32:16 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902ee5400b00161946a7104sm253558plo.86.2022.05.17.18.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 18:32:15 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, qiulaibin@huawei.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220301123919.2381579-1-qiulaibin@huawei.com>
References: <20220301123919.2381579-1-qiulaibin@huawei.com>
Subject: Re: [PATCH -next v2] blk-throttle: Set BIO_THROTTLED when bio has been throttled
Message-Id: <165283753506.124778.6326413719734024023.b4-ty@kernel.dk>
Date:   Tue, 17 May 2022 19:32:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 1 Mar 2022 20:39:19 +0800, Laibin Qiu wrote:
> 1.In current process, all bio will set the BIO_THROTTLED flag
> after __blk_throtl_bio().
> 
> 2.If bio needs to be throttled, it will start the timer and
> stop submit bio directly. Bio will submit in
> blk_throtl_dispatch_work_fn() when the timer expires.But in
> the current process, if bio is throttled. The BIO_THROTTLED
> will be set to bio after timer start. If the bio has been
> completed, it may cause use-after-free blow.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: Set BIO_THROTTLED when bio has been throttled
      commit: 5a011f889b4832aa80c2a872a5aade5c48d2756f

Best regards,
-- 
Jens Axboe


