Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB87C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 20:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92FC217FA
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 20:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="1ErJuzd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfBKUIc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:08:32 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:37435 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfBKUIb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 15:08:31 -0500
Received: by mail-pl1-f170.google.com with SMTP id b5so76807plr.4
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 12:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CgKmuNLHySyo6WC+PSY7NZ1hSB4C1/nIn7zZ6pHdVBo=;
        b=1ErJuzd1EYdkYSINNrydbzUTRvf9AgsrXmagRMd40ojgrQKacoVk2nrDBTwHkJ3/xa
         sgv7toXgT1rCCAUnOgri/YDPlRFtLqh9mMPLRaf6fB/9hpUGGISkxblK+NgNTo54RNl0
         paw46k9wYmPuB8LSlP1GF1vvgcEcFQTp4eSSjD1sgmdXQ8BWi8bMR8MvBrVqTYdxpLTD
         Hb2mXb6Z82EwOtHQPgK9f/I5y+N0K/kwTcZSHtoRSWigLs5wveCK//VXZjSSANN+U55n
         wXgikuI2/u3Wv6TBXDNKmpJ0DfUgAVdmAH5L2fyDRrqXUQ7FiZJOR9wu6dCxpJjSv5S6
         ymHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CgKmuNLHySyo6WC+PSY7NZ1hSB4C1/nIn7zZ6pHdVBo=;
        b=rILFEvR8Eq/RDhTZoQiwhAkxjDca+ZLlQep0ae+nlA0OoU+UIpYwkWuBxSPUDQOd4B
         imGCbKBP+d5Nmsx+Mol3ZcmGvSYWBNUj/Ni3p3jCd8XbV2Hd/e/rbd28/7hyoaBEgEHW
         tAT7GOdWqPNQOoAyOmzYQTZkjzgsJIbOHQY2p2yOUpPGO5bhrSfnqL9BxccW3zqoxtTw
         17oumkz7ZEZqzQN6gwNczjiKKwLfeh85k3F7fBXjmFn4ZykWe6f5dUjZsCv8brQJ093C
         LgOadKLvY7qRoCoFHL+jxUUrec404jlEoN+g+V8ttU3m+ofXR58xXsHooUtpYDnOgqWx
         +U/A==
X-Gm-Message-State: AHQUAuYG/MmCy2I8sWHgQ73swFr1Y8G9saqmJxLak2h/CL1D7JzYV8Rf
        h2Zcmwe+1A+R+ySR2DNShHODZ2O5uww=
X-Google-Smtp-Source: AHgI3IZ2NxS6J6yvizqW4FX3KYCRditq/x+j05DdseQrAzEkMZQgVQpCqAonbosU0bFdXNiaJs0wwQ==
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr38258517plb.198.1549915710819;
        Mon, 11 Feb 2019 12:08:30 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id b2sm13599008pgg.87.2019.02.11.12.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 12:08:30 -0800 (PST)
Date:   Mon, 11 Feb 2019 12:08:29 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org
Subject: [LSF/MM ATTEND] blktests, misc block layer and filesystem topics
Message-ID: <20190211200829.GA28773@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I'd like to attend LSF/MM to discuss:

- Blktests (see Chaitanya's topic proposal [1], which we hope to present
  together).
- Core block layer work.
- Filesystem topics, especially relating to Btrfs.

Thanks!

1: https://www.spinics.net/lists/linux-block/msg36761.html
