Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28F5C433FE
	for <linux-block@archiver.kernel.org>; Thu, 13 Jan 2022 20:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiAMUAj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jan 2022 15:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiAMUAh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jan 2022 15:00:37 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A256FC06161C
        for <linux-block@vger.kernel.org>; Thu, 13 Jan 2022 12:00:37 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id v1so9824572ioj.10
        for <linux-block@vger.kernel.org>; Thu, 13 Jan 2022 12:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=zpxRDMDpjP0eyt7BG8eM1po5m9+B41KQmJKORqe0L/s=;
        b=TjiTCQj2jJ7CoQ8GnN2iLukX9BxHsjzpLEYpz6iZ8+YquZUwRx6w7Vu0FMHHioZotw
         yDBEcF+ZPmiDEqdk94DCGJ8rkkVXDfdkugYUFtIOAWYI84MmArCHsdM40U/JWzuec3xi
         Nmn0DIz5szn0lGVn+2q+HySl2RCTv4z4/jnlMz48nGfth4S2qFbWQefRebpO+RHhNNBg
         0DE5cTCgccLLLgWfF9asCn4aX8ndeNhFVb7MSW8eieDk4nF/SfWU1xwkxSVIZd3P+6TP
         91BeYao6JNv2FN74KGaflTpdVzsK0qW4fYozPSqPKdcsn4AkbkPWpFTKNGkXTC42hqiC
         KbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=zpxRDMDpjP0eyt7BG8eM1po5m9+B41KQmJKORqe0L/s=;
        b=c94CwhHwxY1S1xykVfiM5spRpZJLo5S2eW5b+DkeWkYea4DtGJbXIxm6FxoloUgYS3
         UDLFeob4R8jpoErx4GaSPwSMLSIqVm+Nn3k8UVOdfoWwgMG6KjJ8DxrAHGjsGwPhmyvE
         ZSdCgxx12RVpU4CpXwH5foLzVAB/Onw08x7ge24u7y3XDa0B25lnQZWxJdTJF8iOEzab
         egLmcCJ1jNsoZkZ5k5kFyr8VtES3hjS6k3KXkmZKX7YQrZq8L/ACtlim+dKDfvBSx5GF
         +f0K9xOs13f3V6GHZRVlRRbzcJNh/5SrpYGJHRs3hGN2nYa1jihGRaBqZeybU+JjLrRu
         UN3g==
X-Gm-Message-State: AOAM533QpNWIhElKqptJY9UCpZqCRhjcswVzD53h6yyurtlHJSmrBlaV
        EPW0cKfQNlF1QgVRWPFyMtFRDg==
X-Google-Smtp-Source: ABdhPJy93FHoGOJVPE1DdunyieZI/cMIH71wQsT32PPznbncX4AFfK4i6YqaBGZuoilCs5lGW3zZmw==
X-Received: by 2002:a05:6602:2f0e:: with SMTP id q14mr2974399iow.75.1642104037044;
        Thu, 13 Jan 2022 12:00:37 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s6sm3483277ild.5.2022.01.13.12.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 12:00:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20220113001432.1331871-1-colin.i.king@gmail.com>
References: <20220113001432.1331871-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] loop: remove redundant initialization of pointer node
Message-Id: <164210403642.172421.8237866191152253472.b4-ty@kernel.dk>
Date:   Thu, 13 Jan 2022 13:00:36 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 13 Jan 2022 00:14:32 +0000, Colin Ian King wrote:
> The pointer node is being initialized with a value that is never
> read, it is being re-assigned the same value a little futher on.
> Remove the redundant initialization. Cleans up clang scan warning:
> 
> drivers/block/loop.c:823:19: warning: Value stored to 'node' during
> its initialization is never read [deadcode.DeadStores]
> 
> [...]

Applied, thanks!

[1/1] loop: remove redundant initialization of pointer node
      commit: 413ec8057bc3d368574abd05dd27e747063b2f59

Best regards,
-- 
Jens Axboe


