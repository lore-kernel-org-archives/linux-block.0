Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BDCC433F5
	for <linux-block@archiver.kernel.org>; Mon,  2 May 2022 16:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbiEBQK2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 May 2022 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiEBQK1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 May 2022 12:10:27 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A8C1144
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 09:06:58 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id l203so15692949oif.0
        for <linux-block@vger.kernel.org>; Mon, 02 May 2022 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ui3aWkiCD+9FXe1bbSjIpz7THk3VqRrcCpcoKECg2HQ=;
        b=Dz9Nny4Otenyg8ciuTEaXafd50IX5gplC+n5O/otti8+slh6C4907oOVUSxrYU72MO
         W6GH4vtDNfF990pCOvy8xRZLDwmErEaNVTWbadOihMkQywxWQI81wyQAJ+N8dvRjJfK+
         DSumUGwRCf8L9KD8Tzcq1E663nUGQw6LS3NO2In7XIIhJGDPyT+O7KhTGO8rXa4IHgNR
         qJohKgbrX2xHGoA4k+3FORCXpWFkkVVdL+XcNmeSDriKorJq4YMioXpIvFVdcB6UDwSY
         venhCu952QNmH2rDteCtyJZbEmsir8ZjfnHL47DCvAHG+wWsC0cWdbyx+R1Az8EC1NCK
         jFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ui3aWkiCD+9FXe1bbSjIpz7THk3VqRrcCpcoKECg2HQ=;
        b=xVMsFBU+yy9zdxzSX57cQXE7SVJJdjodUyKj3cJipczAWcrfpU59i3Ynv5KDl90Rxj
         9qzf1qpvXloFoB2VdrfZ5yWCcFdfym3J0qkywQ0YdCX0hvaum7TN1tJYZD10wRptM+aV
         nAPvPKFgW6vnxhdpt2UZfniBOCXxqORxxf1iiqxF8HYKkzUtOkoiNNtXspMK1pr0bN8/
         R6GYKkWIZRNys9a0mkBleN7nYZJn5xSYDxAtPo4NGlU9WOMTpOU9WpazN8CWwJIgQXq9
         AonAC/LSNQ7ViTfTyOHRiXbMoGcEKncFeQrnAqdP3NiZRaKJqQnnfxd9FGGbLZ/TuAY1
         pvfA==
X-Gm-Message-State: AOAM530mw7Rg49mAGRiWvHYJhKwv6QGTcRyPEwrlNFLA0v4agk60lcE4
        LxC30eNlXm/AnPKN4VHepfLaJ9Nw2N+zOA==
X-Google-Smtp-Source: ABdhPJyKZspZlowLgzr0hDoV46ogMH4rWX98aTrQ17H7PPOMp0d3iIxiwU/aVWkZaw7fWUHRbgcx6Q==
X-Received: by 2002:a05:6808:f89:b0:322:6f53:9a1 with SMTP id o9-20020a0568080f8900b003226f5309a1mr7502762oiw.96.1651507616971;
        Mon, 02 May 2022 09:06:56 -0700 (PDT)
Received: from [127.0.1.1] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id d9-20020a05680813c900b00325cda1ffaesm2500200oiw.45.2022.05.02.09.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 09:06:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220426024936.3321341-1-ming.lei@redhat.com>
References: <20220426024936.3321341-1-ming.lei@redhat.com>
Subject: Re: [PATCH] Revert "block: release rq qos structures for queue without disk"
Message-Id: <165150761619.3642.4281559612749679868.b4-ty@kernel.dk>
Date:   Mon, 02 May 2022 10:06:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 26 Apr 2022 10:49:36 +0800, Ming Lei wrote:
> This reverts commit daaca3522a8e67c46e39ef09c1d542e866f85f3b.
> 
> Commit daaca3522a8e ("block: release rq qos structures for queue without
> disk") is only needed for v5.15~v5.17, and isn't needed for v5.18, so
> revert it.
> 
> 
> [...]

Applied, thanks!

[1/1] Revert "block: release rq qos structures for queue without disk"
      commit: 285d5731a0cb2dd3a12ddf34d67be4e4965e64da

Best regards,
-- 
Jens Axboe


