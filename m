Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C912DC433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 14:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345169AbiBBOvj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 09:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345174AbiBBOvi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 09:51:38 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7B2C06173D
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 06:51:38 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i186so16529892pfe.0
        for <linux-block@vger.kernel.org>; Wed, 02 Feb 2022 06:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=86/HaWRp2y/SbuutjnhnFgYLOj+BcaVRE8VVajIjfRc=;
        b=R/anZ7UkMnqaF3CW4Ump0dqYVUYUgaS4M/yiDIxTx2Cjcq+Qyd6YocKBZ8mPdRpPW+
         17FNI88k1C/BmVXl825aLA0miu2S5PPr8PsT0fMqN4dVJU17+9S6pjmTH6QbSeNecx9r
         0xP8jPO9Nw198zDO00TZswt+Ah25ZHBq+6KVkMYCNAEWgsPPHMXcAtmG4VsW3F3UiWKJ
         rSIzxvJZQrspkqWsoTGnJsSlKKFTTNT/fSLrJ2tAT5TU1bpU2aG1AoRBu+acTX1dmWiy
         dtFz/L7xjwsZ+s+MvP2INbmL3Bpln/WoZpGWMhz5gWzjqWyuCyzkWYcHCGIQZ7JI1y6B
         ls9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=86/HaWRp2y/SbuutjnhnFgYLOj+BcaVRE8VVajIjfRc=;
        b=1KnU1bBHPcZvwtwk+ewsSpcrCLvwosUPlZ+CuMAXK4SpziIyTEZRE4gbWvrALlI4dn
         fJu8Zm4ONnSU+MJbWHXpVCdPY4WOjiSGn3F7bLn7v63ADxXh2Mclfjc4Xt9///2k7eTl
         MEu0SscoyJVy3fsqpM6hj2NBVXI59gtSqJxMI3/FqGgA7zIQ+Sg+9Z00aegQWp/m8TyD
         X+YvKcV6MuzH9e7OzKJJ852kw01g0iGQPt1HrYf6WVg42cVc3s994XSNxQFCIH5v6IId
         iYsQMF6VIrqZlp7SbHOE2rjFtpu5wrwDN7Q1g35u3NYq+HewQiwFrE2J8XQzOMddGWsh
         lHGQ==
X-Gm-Message-State: AOAM5324G79q9g1OC4M2A/i8Fz8vsw1OSKtAVzKp97RgbN7XNs758oKr
        uF+zxb7eghN+Q3zSUdYetl4epfFLeYaWWQ==
X-Google-Smtp-Source: ABdhPJwHqMALF/wOLDrSj4nmDW1I8tHyhaX9IDucrRtcOQAvGP0sRohPCEugxsJxmQaoZ0g8bCyDQg==
X-Received: by 2002:a63:e206:: with SMTP id q6mr25071054pgh.165.1643813497682;
        Wed, 02 Feb 2022 06:51:37 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id 76sm28639747pge.93.2022.02.02.06.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 06:51:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20220128140922.GA29766@kili>
References: <20220128140922.GA29766@kili>
Subject: Re: [PATCH] fs/ntfs3: remove unnecessary NULL check
Message-Id: <164381349664.170858.13226820250070489302.b4-ty@kernel.dk>
Date:   Wed, 02 Feb 2022 07:51:36 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 28 Jan 2022 17:09:22 +0300, Dan Carpenter wrote:
> This code triggers a Smatch warning:
> 
>     fs/ntfs3/fsntfs.c:1606 ntfs_bio_fill_1()
>     warn: variable dereferenced before check 'bio' (see line 1591)
> 
> The "bio" pointer cannot be NULL so there is no need to check.
> Originally there was more extensive NULL checking but it was removed
> because bio_alloc() will never fail if it is allowed to sleep.
> 
> [...]

Applied, thanks!

[1/1] fs/ntfs3: remove unnecessary NULL check
      commit: 365ab499153cdb2007d54e7e62bcbf2c67f7ab8f

Best regards,
-- 
Jens Axboe


