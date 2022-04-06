Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3E1C433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 22:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiDFWj5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 18:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbiDFWj4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 18:39:56 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBB1BC99
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 15:37:58 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 125so3360032pgc.11
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=898oZtU49x5Qm0CpxcvXo6MY6Axk2cKRFpUrygV+kwg=;
        b=fhhF+bMKOUw5/3ZHEoqCk4xhqBwNaSvetO+uQiDdsAeAZQMBiD+4OY4KxkT5haQLNB
         /Ogeh1aOjDihjBKWPX2lcBHCt2nkMUiAoe3s8+7SS9eCNZenDe37QliCuPQH4Yhv9adb
         t3zuvRDLyETvBNk97Ezip2jDBlP635hW4vPh2GJwA5H5zGGpVMA/Ytfrfaf+11vYacoZ
         AZ1PWidNLUNAwgYNK8GwcljRyEWi9NvciX9j6WpakbEnTsPgDVObFsOAtdluUzgBabO3
         s29iDlWPQdsb8wKAp1V8aHWI3N1l+kMyEwRbU9OSPXcs/QCzASpTIk0mGsdulQ4NsSd5
         5iBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=898oZtU49x5Qm0CpxcvXo6MY6Axk2cKRFpUrygV+kwg=;
        b=08rlGHr17Ftkz+4wu1QFASo87EDWU8W7Qmkp/whrj4lccWkNovFVZFDUbMq+YP89tN
         2qAzDsIO/x/uIDyplAhz6GqvgYjksDrB+sUabSh9g8bpXplnULyIowZAfO0fgZF/YyHb
         hzS61NLNIdriyfhQBMtxsz8kQPG1o4IWc9qLglZF6PdnNNn+TmPfw21Bm6ZEhYcgE2Ge
         R7j1UJ2twHTnv4EdTeJertht4QjdbClM9XMMlNTgYZt4nuwovh5wDmz0NL5Fpe3hWlm2
         mGn+maMUr0GOOGzPSjoz16BefD1AONKwXWicxolTQd4HbtQ6Z7PXqzNeZuiTEd4i3BGw
         va3g==
X-Gm-Message-State: AOAM530C5Ke1b9zG+AHtBI0ytFuQGcCrShKF3yO1d6tBmWYNWlAqa2ht
        5NdE1cRFtl2Wiz7lSX/R0r4rGg==
X-Google-Smtp-Source: ABdhPJxdFqHBRBIOp+Psd59OAmPDwQRlB8FtqtHsCvhe+79VLNJ1TnP7c1Kbd6L8u+McnjLHXs/lHw==
X-Received: by 2002:a63:1f55:0:b0:382:65eb:3073 with SMTP id q21-20020a631f55000000b0038265eb3073mr9073795pgm.624.1649284677698;
        Wed, 06 Apr 2022 15:37:57 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090a784c00b001c6bdafc995sm5586089pjl.3.2022.04.06.15.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 15:37:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     christoph.boehmwalder@linbit.com
Cc:     linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        lars.ellenberg@linbit.com, philipp.reisner@linbit.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
References: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 0/7] DRBD updates for 5.19
Message-Id: <164928467657.11110.6351742208734304925.b4-ty@kernel.dk>
Date:   Wed, 06 Apr 2022 16:37:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 6 Apr 2022 21:07:08 +0200, Christoph Böhmwalder wrote:
> Mostly cosmetic changes, bound for 5.19.
> 
> Arnd Bergmann (2):
>   drbd: fix duplicate array initializer
>   drbd: address enum mismatch warnings
> 
> Cai Huoqing (2):
>   drbd: Make use of PFN_UP helper macro
>   drbd: Replace "unsigned" with "unsigned int"
> 
> [...]

Applied, thanks!

[1/7] drbd: fix duplicate array initializer
      commit: adff355a6d6602d6be7be4c98e39d1d957a7e53f
[2/7] drbd: address enum mismatch warnings
      commit: a9cb5060fabb46187c8b00ac740bc30f045baa8e
[3/7] block: drbd: drbd_receiver: Remove redundant assignment to err
      commit: c8057a1ec541f972d0ca2ab14a77bd0f6a1919e3
[4/7] drbd: Make use of PFN_UP helper macro
      commit: 25dddd7771061c0d7176d396117244e19ce30858
[5/7] drbd: Replace "unsigned" with "unsigned int"
      commit: ad94e90806ac935c91dc6f048cec6c6ec4069cec
[6/7] drdb: Switch to kvfree_rcu() API
      commit: 40dad92d68aab52919d98524eb8aa87ed23596c8
[7/7] drbd: Return true/false (not 1/0) from bool functions
      commit: c0bf7a4c2313c46f2ba14b78a622a7e32bbbb2ac

Best regards,
-- 
Jens Axboe


