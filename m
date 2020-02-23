Return-Path: <SRS0=+Si7=4L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A021DC35670
	for <linux-block@archiver.kernel.org>; Sun, 23 Feb 2020 23:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7846F20880
	for <linux-block@archiver.kernel.org>; Sun, 23 Feb 2020 23:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVJ/1ZoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgBWXSt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:18:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35696 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgBWXSb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Feb 2020 18:18:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so8248235wrt.2;
        Sun, 23 Feb 2020 15:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VIsEnufW5UKiFaauxUQT7cROwH9cIkz3iDWaRKI6faU=;
        b=vVJ/1ZoC5W11oiU8xaXPGb2BttMijboDlcCe99BzGqHqsV5OgpSYi+MGa7KOM2K2WJ
         f3hdCsFLbL87Em61UqceVR2Wl6nGyiztoQhvA45ou6MDTErJNYO7S0asPSD5QEYTyw4c
         FuHBQFj3gEP1qvivLa6FJndDyTuh4/UAEpbHlaMBUnqlbVw/Aev+FZHl94NurooxzyaF
         KOpfNlLa1tu4liqGURow94/5huQgUBY5+ZIjYFIx6I2m1k6TYqmfUyX02tMGmt/b83ao
         42zudGsv88wWTYe/j6WiVCm2VoSpFCWUGUEaLXkrSuDa5l00LgTNVaHxFZM9DH7mql2h
         3/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VIsEnufW5UKiFaauxUQT7cROwH9cIkz3iDWaRKI6faU=;
        b=L7DHUGZ2wSkvBnhcm8CfAgwgzr0SY9kJQt7M7P31dbQqWj+kBjvmqTGToiBCWN/NsO
         MaGOaMYoHIIKWYuan6FNaV/CfOw5Cb9KSuJJaWpVJ83bWh3Oru/qfC6BZpvYV22vQfbz
         H5VMec4bJXYIsum/cY+wqcvl1KcrCsMWDS+tTSOa1AE6GZOlGR9p25h/VE14NNT6kkXM
         oVxB2qDxk87ulnZzBj2wwuPp5jq72ZYakODYEWPDjz/nJx5LbsmnQSsZbsc+g6bFnFOL
         zj13jBStZCIw4elVTNj85o3Yhc58wkQEfuACZYUBu9qHBa9Rj8xV6l1vWBxYEHVTOT7h
         xiXQ==
X-Gm-Message-State: APjAAAUWSnxyFR2k8KhaSuw9LC8jk5KIQ3d00GazfqTg/7VqKt6JMSTA
        739N3L1inIFWPX15hS0O7g==
X-Google-Smtp-Source: APXvYqxhQ3xChQpv+UIaFNjtHAytoGoVwAcvACgY7yAnrN2B/LuuwUlxxFBrwvrwTLl5nJKb2d/9qw==
X-Received: by 2002:adf:e602:: with SMTP id p2mr57070948wrm.388.1582499908754;
        Sun, 23 Feb 2020 15:18:28 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:18:28 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Subject: [PATCH 26/30] zram: Add missing annotatin for zram_slot_unlock()
Date:   Sun, 23 Feb 2020 23:17:07 +0000
Message-Id: <20200223231711.157699-27-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223231711.157699-1-jbi.octave@gmail.com>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sparse reports a warning at zram_slot_unlock()
warning: context imbalance in zram_slot_unlock() - unexpected unlock
The root cause is the missing annotation at zram_slot_unlock()
Add the missing  __releases(ZRAM_LOCK) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/block/zram/zram_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1462b1bfec11..a38725452966 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -68,6 +68,7 @@ static void zram_slot_lock(struct zram *zram, u32 index)
 }
 
 static void zram_slot_unlock(struct zram *zram, u32 index)
+	__releases(ZRAM_LOCK)
 {
 	bit_spin_unlock(ZRAM_LOCK, &zram->table[index].flags);
 }
-- 
2.24.1

