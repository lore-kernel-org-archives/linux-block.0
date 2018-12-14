Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87780C43387
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 19:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672772080F
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 19:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BbRf1Q0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbeLNTyM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:54:12 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:42177 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730686AbeLNTyM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 14:54:12 -0500
Received: by mail-io1-f47.google.com with SMTP id x6so5360461ioa.9
        for <linux-block@vger.kernel.org>; Fri, 14 Dec 2018 11:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0hLTtx5xf90aZLKm7IbGGdJWi9njZpvtG22Bc9xGbGw=;
        b=BbRf1Q0odKTO0NXeTE6PlR9T78G8bpD6agshlD46cQ3Pe3bVwd6W/cu+oskCuQBC/w
         Mu/NFGhLeJ1w9uGYD4SXueYxXZsmuXtSBMy57JIEPUnpk28+tLFUHtXZ4ZgSBwi4h8XD
         s+2sUN+jl1L+yjWKsesCTgkMph/bJ5DJwfwuzEkeGjQQuumTRXuodi5GA/Os1nLZ881t
         Lj6PztQ34taQeJZnjZsK+JcTnz1whcZJsLHxoltUwr8lGktFPWKQ8iqGNm9cvAGLWQpA
         V1tQJoGoEsGCMS3cJxf2gy1BVexW3G2tuXDaFOZXX563kKSVmQAysjIquDpQ8Kn1Cnwi
         LWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0hLTtx5xf90aZLKm7IbGGdJWi9njZpvtG22Bc9xGbGw=;
        b=UAZVrsPoNXV5jvlN+z9cj44CdgaNZJHcjtkWq0WesKVdFb+YVZgCagMTCuJMkuozJo
         +qHTYwV6ce6h04A1H5L9MjeQWYqKpoE26B4ewVbhUmdOpLJw9AMZlMq0Twy9ujAT0WBD
         TTGEdznYVpC/YezSNUmNdNiLEVPoWgrdn9IQqj9dVY8cIebp7UaNvLDb+HTMnWw2cgLU
         5EHhHiOWZFAp83oHo49c32hIxDS0hGbFjJMklLfH+uSc/fQxaGfCkCt2yNk9KDCEO+/5
         j7KYVzuFyzDFFHcdd0WjI/+2gkn+LsimyHAhgdvTZfymAbOQTebEJlQSCpjxumgxRKr0
         9YMw==
X-Gm-Message-State: AA+aEWb/ECge/0/5mUYSlIjqvDr4kdWPlt6eLkchC0EmsIiE8l7gphxT
        LsThbk9YFpzIZmPJRIRBudgx6b7idN7YTw==
X-Google-Smtp-Source: AFSGD/VKQv/5OINrZwaRZiSGbCXCGNMWe8LmmpZXDdwa+b+vET5rxX0TLozncEb8AXc6FO/VOuMYhg==
X-Received: by 2002:a6b:1741:: with SMTP id 62mr3720387iox.251.1544817251110;
        Fri, 14 Dec 2018 11:54:11 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c3sm2399013ioi.2.2018.12.14.11.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 11:54:10 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Storage fixes for 4.20-rc6
Message-ID: <2dd937be-804a-7524-d088-83da7e405ed0@kernel.dk>
Date:   Fri, 14 Dec 2018 12:54:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Three small fixes for this week. This pull request contains:

- spectre indexing fix for aio (Jeff)

- Fix for the previous zeroing bio fix, we don't need it for user mapped
  pages, and in fact it breaks some applications if we do (Keith)

- Allocation failure fix for null_blk with zoned (Shin'ichiro)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20181214


----------------------------------------------------------------
Jeff Moyer (1):
      aio: fix spectre gadget in lookup_ioctx

Keith Busch (1):
      block/bio: Do not zero user pages

Shin'ichiro Kawasaki (1):
      block: Fix null_blk_zoned creation failure with small number of zones

 block/bio.c       | 3 ++-
 block/blk-zoned.c | 2 +-
 fs/aio.c          | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
Jens Axboe

