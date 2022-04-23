Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737A1C433F5
	for <linux-block@archiver.kernel.org>; Sat, 23 Apr 2022 13:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiDWNSp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Apr 2022 09:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbiDWNSn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Apr 2022 09:18:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7EE1F310F
        for <linux-block@vger.kernel.org>; Sat, 23 Apr 2022 06:15:46 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a15so10526720pfv.11
        for <linux-block@vger.kernel.org>; Sat, 23 Apr 2022 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=DkpznYvxl1/xMx0A04k/2Fl0ZC/HbF/iN3ydwHQpN/4=;
        b=4uaKF5hlFr8mNsqJ8TWB7F13SlhEEPo6NAAmtKTt7hIpuOSLzZWSskb28us+DcoQai
         09KbaV2Jk+l5ZnE7rzVymd9zCGCRy8hf4ZQquJgFVgtYVhmnJTTi9egqygeeC6Eau+0I
         k2CdEmIWlEgDev5uEE2Qlex6Z0WJIf2G0lkFBf3uql+/uYQ27+tlRpNSxJzb3FsIx0kR
         lKVexeAUZv+LP6mLjN3G/Hc1to0dpN6PfwdsZ+w/dkw6VE8StSH8H+kgWrMPLs8MvIFe
         O2soPkbclypAAE5smTL11bCHL13QTHaCSvsIKTgQh4ocExW52yAe45JL6xrsvJSjbrkY
         LtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=DkpznYvxl1/xMx0A04k/2Fl0ZC/HbF/iN3ydwHQpN/4=;
        b=WaquN+SGusPljUbg4grUxOjjxAG798UYqp6tDnpquQPRIXlQaPH2N9e4DVoIj+Z3XE
         s3WpaqJiHXB4yGSBkt42RuwZY833VFz1sK5W6D3odXJPnZRAXK0I/G2GuY7d0odGTyQ7
         AiYc2VFrygRKWOp7n/Xs4iPDnIcuFqh1izVxMFy7pxQYroYfsfH+ZCAMH3BoNS9rWGsA
         sJb7G0oO+TPZ92f71RQmhu7CJVfRITjN6A44AbyE1hgZGdhlHYwsAOr9tgnaConjLS7W
         0643TKRUfOwSZ1kkbNW53FZcgbSRPINQOSvhEkhD+bM1XvXRRh8hFzY8gNcr+Grwrhqg
         OyVg==
X-Gm-Message-State: AOAM531J6uxyS1Tpbt5NxzloWFlclmKZ3gvm/oUmtSMOjmGZUp4+IgUF
        Kkrr0M81SeIaxI9/36gxsnEcZw==
X-Google-Smtp-Source: ABdhPJzi//fAeVhht0V7uQhZj5Kv/AcBUYnzTjirTu0TP+mQl1OLLisyNtf8gYG/7eAbKd4x7ErVrQ==
X-Received: by 2002:a05:6a00:b52:b0:508:31e1:7d35 with SMTP id p18-20020a056a000b5200b0050831e17d35mr10083737pfo.33.1650719745503;
        Sat, 23 Apr 2022 06:15:45 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t66-20020a628145000000b0050ca37e60eesm5935627pfd.57.2022.04.23.06.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:15:45 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ndesaulniers@google.com, michalorzel.eng@gmail.com,
        trix@redhat.com, nathan@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
In-Reply-To: <20220423113811.13335-1-michalorzel.eng@gmail.com>
References: <20220423113811.13335-1-michalorzel.eng@gmail.com>
Subject: Re: [PATCH RESEND v2 1/5] block/badblocks: Remove redundant assignments
Message-Id: <165071974452.502130.12676791188164630002.b4-ty@kernel.dk>
Date:   Sat, 23 Apr 2022 07:15:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 23 Apr 2022 13:38:07 +0200, Michal Orzel wrote:
> Get rid of redundant assignments to a variable sectors from functions
> badblocks_check and badblocks_clear. This variable, that is a function
> parameter, is being assigned a value that is never read until the end of
> function.
> 
> Reported by clang-tidy [deadcode.DeadStores]
> 
> [...]

Applied, thanks!

[1/5] block/badblocks: Remove redundant assignments
      commit: 3de2e5f28cb133f1d9c1b2403079722d0e7b671e
[2/5] block/blk-map: Remove redundant assignment
      commit: 7ab89db979017255c2163880de5c63d8c9726aef
[3/5] block/partitions/acorn: Remove redundant assignments
      commit: 834726828b47c08e84df02f975e30c5c65bf316b
[4/5] block/partitions/atari: Remove redundant assignment
      commit: 87420fa94f6cdd2ae8aa3e1d8602bfa549794fac
[5/5] block/partitions/ldm: Remove redundant assignments
      commit: e233fe1aa02815f38588a5a965a197bbcabfb125

Best regards,
-- 
Jens Axboe


