Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1A6C6FA83
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 17:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiI0RyW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 13:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiI0RyV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 13:54:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057426B8EC
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 10:54:21 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id w2so10398391pfb.0
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=QOxXX6PZWjuFQYw1PKwJzistcbBPVeQ6lf3m7m3pTKE=;
        b=UY4EpIG/HoUih0UhL/Bb8u/2u45Ex9YCb5owwPUjENHnMUeBhAZyuz8mS8rpPrFdG+
         K76t7sh/ilI74s0ZRD+5OJXfqR8v/M/96gXDWJO3l9GPLz1+FM29gi008YTBnf0kogUG
         108fmN1NKh4mcj0qgYiyRolLh5it/3TCVFvhwWM6SdYpwxCjt/V+7SZdTWqwgoavR0SF
         Wp3vds4IL9ltYA/PxJipuswR64ApcFEVeZMMfhUGiupVWa8lN3pO6mgK7OhA4oZ9ac7d
         SYLHcau86UwrLAbbwU7/exsaJ0lSVgM59HyGhw4Cro7aKk5zf9micj/FA9T/vPgGHhTr
         3BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QOxXX6PZWjuFQYw1PKwJzistcbBPVeQ6lf3m7m3pTKE=;
        b=3U5dzHazxha1lJK6F6K5stJpIGgs6eVX5YaO0eNYzZi1hYdxb/+H5jDX/5/zRTktSK
         T5RI/nOQRBv/5MOdVXzANqr7y3g78/cp5kuF7EKbuSWQt7B4mhcLxdmtK6zMGOELWikW
         BmY6Rh9dvKrFWM/uhprxaIvo0vsY19JqARdRa6J+S8NbrTYacypimVyKth1byNkQhATM
         JFqM5u8exaqO2CUK9YmpZC3Jeh8fNMT8MTdNPtzeOdM/fV+9MRonfMZTVvxcI5F2YytU
         vlBJG2brorZb33ei4KrygI7lmCHnNyVvqNt6Vdnx9dIWUJVX8hL0f9ROPlb/55RjRegj
         s2mg==
X-Gm-Message-State: ACrzQf2X9+D3S7Zy2YtFsS8jcIKWpcJY0g12qE/Rbu8cuevAwVIRWtuv
        vfPxBpwCOjXDWzdyvOXx4TYiSo3LOA35OQ==
X-Google-Smtp-Source: AMsMyM6YrV9Y2HvBfB0U4vkt5dr/7KCXjyhJuoV5Ge3xhya8J+VLbq5AGH1ujko0JvmRYBr77U2FgQ==
X-Received: by 2002:a63:d54b:0:b0:42c:299e:255 with SMTP id v11-20020a63d54b000000b0042c299e0255mr25258890pgi.282.1664301260263;
        Tue, 27 Sep 2022 10:54:20 -0700 (PDT)
Received: from [127.0.0.1] ([2620:10d:c090:400::5:de02])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b0016d5b7fb02esm739675pli.60.2022.09.27.10.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:54:19 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     tj@kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220927065425.257876-1-hch@lst.de>
References: <20220927065425.257876-1-hch@lst.de>
Subject: Re: [PATCH] blk-cgroup: don't update the blkg lookup hint in blkg_conf_prep
Message-Id: <166430125928.156260.5625074206407475452.b4-ty@kernel.dk>
Date:   Tue, 27 Sep 2022 11:54:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 27 Sep 2022 08:54:25 +0200, Christoph Hellwig wrote:
> blkg_conf_prep just creates a new blkg structure, there is no real
> need to update the lookup hint which should only be done on a
> successful lookup in the I/O path.
> 
> 

Applied, thanks!

[1/1] blk-cgroup: don't update the blkg lookup hint in blkg_conf_prep
      commit: 5765033cf77c54897848df683420bb62b6cc3d05

Best regards,
-- 
Jens Axboe


