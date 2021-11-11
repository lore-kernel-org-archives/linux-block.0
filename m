Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB0BC433F5
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 18:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E5760F9E
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 18:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhKKSzr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 13:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhKKSzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 13:55:46 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23713C061766
        for <linux-block@vger.kernel.org>; Thu, 11 Nov 2021 10:52:57 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id s15so6752234ild.9
        for <linux-block@vger.kernel.org>; Thu, 11 Nov 2021 10:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Wd7+ISKhRHkVIy0iWvui08izGmH+yaUgI6Pj/FEu6T4=;
        b=H+vh65aPghYoU5fJodskTYw7ASXOIyyTglFen2427ySHs3jdXJrxEzYjUCbMizp9nh
         Vm9YLXBfCPltAVrDUH3XjMvalLlz/HTGfzyaIFLb30/UdVnOUkctSYLOnbXKuP5RajKw
         aVyNtnd7DbASIiO9oOz0yDEdVEN2wRmRbj3tps2E8/O+bJDuPYdzEDN5TuhUX+o2zfZI
         y+JG111S8IWlTVEeyDylldpKfU8JrtKsI1R4GayZfseBbSC6fs7L5M7e8YVzUIARSq4S
         rKJ7tH9KkX9hvPB/sJD4lB8olvxblv5saWGVlBOF8AM4Q06tFReOCsoN0vaVG5jHMMTd
         q6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Wd7+ISKhRHkVIy0iWvui08izGmH+yaUgI6Pj/FEu6T4=;
        b=LKnsOFKQo2gPP1hjY0aH2ksXz3byMDrmhyR7eLC+BtkjJV0VH9YWKXefVJfEO3XE56
         /OZ4e4MjvXHpHREnI81oSDx/XKTqho6Hb5OZ8Rq6GsokANEsDJXW3ED8qChssDZLiG09
         RZXMb+LFIbkBgfaHByQ6u9gH1UF2/okZMGXAE2qF87xAVTZGWM9V5ARi3bWrPnKbwieQ
         cW3Nx7IyguZTyK22NmotlA6srlTSxyxXFkMCIQdQyOTA/Pes5/IPL8IA3pRzFGgqA1qR
         VWmNYjrLvZNjLkKo1wEPcVnh0DG7u4rs2abDsnI7/9fBkwMOOgl5hvUOCpXUDaQke2fg
         9Euw==
X-Gm-Message-State: AOAM5322h9/6WMjriyS9M75S+NzA/uMs1mvKTLIJKlPMlgD5pB3ZrWcG
        WxM5Bs2CZrgQn7/KzxZN67lzftFwlJfBBup/
X-Google-Smtp-Source: ABdhPJzMW2Ekx/NCXLrkHVXL5DiZVXmsWi8brnFbm3HI7uZ2Kh2MJXFrG2J82dPhB02xBdGBr78I7g==
X-Received: by 2002:a92:2903:: with SMTP id l3mr5525020ilg.35.1636656776538;
        Thu, 11 Nov 2021 10:52:56 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w12sm2716005ilu.45.2021.11.11.10.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 10:52:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
In-Reply-To: <20211111085238.942492-1-shinichiro.kawasaki@wdc.com>
References: <20211111085238.942492-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] block: Hold invalidate_lock in BLKRESETZONE ioctl
Message-Id: <163665677590.27561.12255817873521828001.b4-ty@kernel.dk>
Date:   Thu, 11 Nov 2021 11:52:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 11 Nov 2021 17:52:38 +0900, Shin'ichiro Kawasaki wrote:
> When BLKRESETZONE ioctl and data read race, the data read leaves stale
> page cache. The commit e5113505904e ("block: Discard page cache of zone
> reset target range") added page cache truncation to avoid stale page
> cache after the ioctl. However, the stale page cache still can be read
> during the reset zone operation for the ioctl. To avoid the stale page
> cache completely, hold invalidate_lock of the block device file mapping.
> 
> [...]

Applied, thanks!

[1/1] block: Hold invalidate_lock in BLKRESETZONE ioctl
      commit: 86399ea071099ec8ee0a83ac9ad67f7df96a50ad

Best regards,
-- 
Jens Axboe


