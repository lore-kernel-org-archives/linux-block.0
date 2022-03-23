Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E104C433F5
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 15:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiCWPoO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Mar 2022 11:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiCWPoN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 11:44:13 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7B55643E
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 08:42:44 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id n16so1252293ile.11
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 08:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Q+QWIODRunL1kZDxkGcjubr7xZYCTkjXBoQ6GHBjdng=;
        b=rKJPBrT/fwB5RPRTSrN7oyA4l4lLXNdlw8m1cbxtLtf/aCb6lmXP8ecNKCnz5QvAzG
         6yTZ8Bo/YzAFHSjxWer0zagiDNtTWGTMTX+idSWuwknAEoSzUj8u2byB+1gGo7TNCYlz
         IAuM0KmU/X+jYN1uLNNhaJJCuIizwT5ZvWFPraeHsWW4PBy+iJaaRKA7pjdjm4l315II
         AOqidbWncNwJby8i51Y2uYKAC16/Rl8Phw4gEnMqf7wOlgJmzpO8eXdnAL9FfJ4Z9PPZ
         PbGgP1JQyZbuaLHRYYS9G7urf6o/8Ehts8d4jLY9UVkrNLpxAWRaCJ4hfyox2NkPvmkS
         bm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Q+QWIODRunL1kZDxkGcjubr7xZYCTkjXBoQ6GHBjdng=;
        b=p5H7DgrDSViEl9a0eyt4TyCd2Sb3/yTWBKXygwomhNQXXmfiXot9vU5GGDY5m5ey9c
         eLbeQL7aKN9kIK4oY1RKyeijCiFKYLoLbobnXZnDRicf5lAVaPFgbc3PFR8dxUDnhs25
         1Z1Uvz0AHCVXU6Ro5+dMFsr+W3aJvyHpoafHNgT9ZZ01s+5Ak9yqOniYuRjEp6/o1Qbl
         ME/5Xzc/7OMffV0gvS8kGAp1+45aaiUQ80cjZJk3diKENSwirvsDzlGfOi7oOPGEqtFl
         FEIxUFOhxNA5WzZBkYjjuy5jyiY/N6PapTWnolAeO1ZkcbdigWjJCSmrhJi8iPf874En
         AYiQ==
X-Gm-Message-State: AOAM533fsfGk4248OgLy0W+qrOLPHHgrusLtWEyMXJO01SVAdPxgeYf5
        nCtGqVmUQY0xPLa6uGVpLcSgowTkS86jJBlc
X-Google-Smtp-Source: ABdhPJw1zXcF2NHArvdixZyJ6ySe9N67vs6A+LOFqBlJhkit10ZNhV9WGnkHqlxliaasGuo/R8ooyw==
X-Received: by 2002:a05:6e02:1c0a:b0:2c7:75de:d84 with SMTP id l10-20020a056e021c0a00b002c775de0d84mr337284ilh.186.1648050163113;
        Wed, 23 Mar 2022 08:42:43 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c15-20020a056e020ccf00b002c865ea7babsm192178ilj.51.2022.03.23.08.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 08:42:42 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220323153952.1418560-1-hch@lst.de>
References: <20220323153952.1418560-1-hch@lst.de>
Subject: Re: [PATCH] fs: do not pass __GFP_HIGHMEM to bio_alloc in do_mpage_readpage
Message-Id: <164805016256.144972.11275037637375213496.b4-ty@kernel.dk>
Date:   Wed, 23 Mar 2022 09:42:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 23 Mar 2022 16:39:52 +0100, Christoph Hellwig wrote:
> The mpage bio alloc cleanup accidentally removed clearing ~GFP_KERNEL
> bits from the mask passed to bio_alloc.  Fix this up in a slightly
> less obsfucated way that mirrors what iomap does in its readpage code.
> 
> 

Applied, thanks!

[1/1] fs: do not pass __GFP_HIGHMEM to bio_alloc in do_mpage_readpage
      commit: 61285ff72ae59e1603f908b13363e99883d67e09

Best regards,
-- 
Jens Axboe


