Return-Path: <SRS0=GCUE=C3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE472C43463
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 07:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A97BE2176B
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 07:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="FyYDxlS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgIRHYO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Sep 2020 03:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIRHYN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Sep 2020 03:24:13 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59DEC06174A
        for <linux-block@vger.kernel.org>; Fri, 18 Sep 2020 00:24:12 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lo4so6715182ejb.8
        for <linux-block@vger.kernel.org>; Fri, 18 Sep 2020 00:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nn49EMKwoUXTVvg+SnbEDEZXy2/Hm4gqC83M8dg7Jls=;
        b=FyYDxlS+jvvESTkNk3flm3/fY76a0plFNUQKhMadD8N5wuMB+TLeqoIPe7d28KwgpG
         q9puDn81QNkbsFqyPdJ0Wc7HI+s7kEFLRWOOd6mhPvqj8oVYDKD4DP9sc2I2ow1hj6fR
         v7NnnFUGVeRK7fJjCLDxVkRNwGgbxxeJWjUqyqIoQDkm3UYvE+CIn4LWAhwAT0+o693Z
         1hZGUbssRSAnastEPj5E6HTYcWb3+3kvp6VpEzgxyki8VfEbhub8lCHpX1xZWpvWjKPR
         ajGqFt+vyzmqmp5vb1jQe3gp6qio8V1EIHHGJrgZOEJY3hNtP7/wH8iHlGbyw2127wsm
         lbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nn49EMKwoUXTVvg+SnbEDEZXy2/Hm4gqC83M8dg7Jls=;
        b=U4xUeEhEBjHTSxbKZ4gmaPQQwLSnHSwTMjxNY30P0Z5qfDZojomQ8UPRH4hFScCtqi
         MWRIKoBHjU1Wndl5d6NXgsGGFfcFPisxim70v1JVdIM722PYqjr0v0G65F1vmVb8ovee
         Q4/ojn6aXA4joXhQIwLnxJl+WqfG0EGV0zpIRtn27ulTlh7z7dhHUD7mUDw272BodB6i
         moBVoBzAu3PDKMGRTUMJ0gZ2BVgybWOm183Bn2fH5Tk4nmyCaE6C0opC6XMvrIYDWTbq
         7QGuHzikOWhZENtHADNgOvvoInjp1d6QAOIqH2lN2C6WinCf4Ez/6YwkVHk9eRORWhQR
         KLow==
X-Gm-Message-State: AOAM531rH5zxndDLPKMaOj3MP0H3lsR7NdioyEGuSgaKm08lO/xae/vB
        q5ozFqG0tW+ZEx8OugBrs71fZw==
X-Google-Smtp-Source: ABdhPJysTlRbno5j02weCD9U+lfpTJbiZWtDxrvZAlG6HtOSKCImZnKMbZHW4ksa+qjNcDpDJSs97Q==
X-Received: by 2002:a17:906:4046:: with SMTP id y6mr36177362ejj.148.1600413851437;
        Fri, 18 Sep 2020 00:24:11 -0700 (PDT)
Received: from gkim-laptop.pb.local ([2001:1438:4010:2558:95ba:ffd7:f2c1:4736])
        by smtp.googlemail.com with ESMTPSA id w11sm1518960edx.81.2020.09.18.00.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 00:24:11 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@cloud.ionos.com>
X-Google-Original-From: Gioh Kim <gi-oh.kim@clous.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH] block/rnbd: send_msg_close if any error occurs after send_msg_open
Date:   Fri, 18 Sep 2020 09:23:56 +0200
Message-Id: <20200918072356.10331-1-gi-oh.kim@clous.ionos.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

After send_msg_open is done, send_msg_close should be done
if any error occurs and it is necessary to recover
what has been done.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index cc6a4e2587ae..4a24603d5224 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1520,7 +1520,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 			      "map_device: Failed to configure device, err: %d\n",
 			      ret);
 		mutex_unlock(&dev->lock);
-		goto del_dev;
+		goto send_close;
 	}
 
 	rnbd_clt_info(dev,
@@ -1539,6 +1539,8 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 
 	return dev;
 
+send_close:
+	send_msg_close(dev, dev->device_id, WAIT);
 del_dev:
 	delete_dev(dev);
 put_dev:
-- 
2.20.1

