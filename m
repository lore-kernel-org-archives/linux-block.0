Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3350C433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 14:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDB960F94
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 14:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhI0OKr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 10:10:47 -0400
Received: from condef-07.nifty.com ([202.248.20.72]:28931 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbhI0OKq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 10:10:46 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Sep 2021 10:10:45 EDT
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-07.nifty.com with ESMTP id 18RE16ag030845
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 23:01:07 +0900
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 18RE07Fv028280;
        Mon, 27 Sep 2021 23:00:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 18RE07Fv028280
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1632751208;
        bh=+Hloq7pOWn+uCkJoTRCg/87ciA9Hg53ptAbmWaWlSNI=;
        h=From:To:Cc:Subject:Date:From;
        b=rsMuJ8ftbFfHF2vWJhdb7xNenWQmLOEYRydU83zeYdXTr2nNvryEiBJUxFEkVuUx8
         rVFCFCFWAkyC+3JjV13cfUWgU5o7xlNy/OEMtc38cnhtt14pjNiYYeL+jyDZsxPC+S
         BpwVxnhojJd+DA83hKqHMdidPEGZA5N/rw6uD5ABy8HvfkFfSX9yyd3xbLkn0XQi/J
         /xZgu9AgZwsND/iM+wDqvvj3GadK+/VQkB9fkHc/D5wvd8ijOWCKAazbs9dv3QqVvF
         D9xT18IZbpg0xo6AQEeHKuP92zeekXTJUKd0+k0F1RnIg86gBzaV4tER6bUpQIZzET
         E6Aj3YyeWL/4w==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [RESEND PATCH 0/4] block: clean up Kconfig and Makefile
Date:   Mon, 27 Sep 2021 22:59:56 +0900
Message-Id: <20210927140000.866249-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


This is a resend of
https://lore.kernel.org/linux-block/20210528184435.252924-1-masahiroy@kernel.org/#t



Masahiro Yamada (4):
  block: remove redundant =y from BLK_CGROUP dependency
  block: simplify Kconfig files
  block: move menu "Partition type" to block/partitions/Kconfig
  block: move CONFIG_BLOCK guard to top Makefile

 Makefile                 |  3 ++-
 block/Kconfig            | 28 ++++++++++------------------
 block/Kconfig.iosched    |  4 ----
 block/Makefile           |  2 +-
 block/partitions/Kconfig |  4 ++++
 5 files changed, 17 insertions(+), 24 deletions(-)

-- 
2.30.2

