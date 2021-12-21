Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C6FC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 16:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbhLUQcZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 11:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbhLUQcZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 11:32:25 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB84EC061574
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 08:32:24 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id q5so1874506ioj.7
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 08:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=OSYGbDYLABic1AwwbvsvU2yksM9gIU3mk5OiGF/FAM0=;
        b=dXA8WgvqYCLjtEq7bYxfJI70dPFik0m2LvpnvbmcmXs4FoOQZGQMqwCnuQxz1aaxzc
         oLqc1drt4Glzu+y/PWnGV6zGwGSFrP5iQy4kCW6VonXXeZZUogR7Ar6gkYD4NFtiBg8r
         89TAI9tE/jCA21qWcZxyYDCZOiwv2iG08QUQz3/KbTSPQsf57jfiY5PDDYzvePiOy3kL
         cVwKtijHHfxd73QvO4ZsRCkadA0mP+VPKFNIYen242b0hztoCwoGk4KFdUrJFlvwO2HY
         yaISMCHCvFipQwjZhtMGs+wAbq6zxtjv42GM47Ovro+15VCfSbUolbLtj8uUddT2GbXC
         wvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=OSYGbDYLABic1AwwbvsvU2yksM9gIU3mk5OiGF/FAM0=;
        b=tEN039SWa7kCMcUODeXAk3Ud0jcYeW3E7Z7nFyMzyHG95ZusNcG2nAK/L2u235Vo5X
         JKH1Ve2MQTlWtl2EcGW21pZaZqBljZT83/Fc2kyco0c26a5LgVVS+fTHuiO2veXjBk+W
         fyp9v4OFPnn5Lm0p47JR5SbhW6s0TYHs3MRdCYF66SK7c7DpQZM9elP+HHv4Vj0ng6dw
         c6gSfdyG1PqB5a5SyWSlGu24DpO3Av2WNUraoO4DWezp3DOJhQ8No9cj0PbrsVqsw2X8
         uaslXISDXDOMuv5Zx5QvNFeZTZUyPQvXRUEj6lgBvHzenwA1YYM0rP3Br/DjEG1uIU7P
         ucmw==
X-Gm-Message-State: AOAM532Cfl8THIEpWrBpkFpZi7zuMmhcmAbtF8Fy1jrZes2qhh8LcVzw
        cFvdsflnV7oGurJjH44LC2Fd1QxbbMsf6Q==
X-Google-Smtp-Source: ABdhPJw70w25fqXrv8T183SyRDOr7UNdKhDxiBXG8kgE9Y5JAXhiQ2oFpn9y7ZCFd30U/FqrnwcEBA==
X-Received: by 2002:a02:c90c:: with SMTP id t12mr2410629jao.247.1640104344400;
        Tue, 21 Dec 2021 08:32:24 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a5sm10826120ilb.76.2021.12.21.08.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 08:32:23 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     penguin-kernel@i-love.sakura.ne.jp,
        syzbot <syzbot+28a66a9fbc621c939000@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20211221161851.788424-1-hch@lst.de>
References: <20211221161851.788424-1-hch@lst.de>
Subject: Re: [PATCH] block: fix error unwinding in device_add_disk
Message-Id: <164010434373.606970.3230458552695453398.b4-ty@kernel.dk>
Date:   Tue, 21 Dec 2021 09:32:23 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 21 Dec 2021 17:18:51 +0100, Christoph Hellwig wrote:
> One device_add is called disk->ev will be freed by disk_release, so we
> should free it twice.  Fix this by allocating disk->ev after device_add
> so that the extra local unwinding can be removed entirely.
> 
> Based on an earlier patch from Tetsuo Handa.
> 
> 
> [...]

Applied, thanks!

[1/1] block: fix error unwinding in device_add_disk
      commit: 99d8690aae4b2f0d1d90075de355ac087f820a66

Best regards,
-- 
Jens Axboe


