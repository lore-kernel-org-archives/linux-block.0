Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD41C433F5
	for <linux-block@archiver.kernel.org>; Sun, 15 May 2022 20:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiEOU6j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 16:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiEOU6i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 16:58:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8727A2C108
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 13:58:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w4so18050221wrg.12
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 13:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZjW+cu9gNic3DXhYu0fnSojGWu00ohKV4jtFet5Mj/I=;
        b=gzhY5ER5NmYm8JS3F0lR3f5PpeZ1AZ4nBTeB6S5BK6ZxJXU7ChEqNnL9IR7qoCi7xB
         L9JJ3VSB/QghtaSIjk0NnbYcWVFCJLYp8FSLnNUF9zMlB3ztztqfTPlOsMNzMh6uQkQZ
         xFmC+MjgmhqGvH5uWNBzvbA5IzsbAo0qlgdEjxix6F63cxGvbGO53UWP/WoQrnF6QdRE
         b19AQ9yBbAJrZ0AdErfqjQjwHZfdna3zTxP+TRnIsOb4QcQn4+AV9uarXKN289peWkgT
         okQVaO4Ukcr8w++q5v5M4kBA3Xrsrqy873r7KkEhTAxTxZ4PKlnoouaUQfNj3sDXXaiB
         qU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZjW+cu9gNic3DXhYu0fnSojGWu00ohKV4jtFet5Mj/I=;
        b=JL/ki1Lg/wUhtaHEvompbnzpTzP4JqrZ5hNBZyZXIuUYR0rZ79BUY+KUgIznizeYSp
         buZH4OyFVQ2udhUUw+y+5iDyOn6Dr10HDwKQefo5AFDr7ztgvfmNWzH5s0n6ahcbZQN4
         vR7xaVDs0C0GUC9ZP50txQjpADDVj+RRPO9lIOz5JMB5C0MApI/VZ1/vMTuCLSYXvYO0
         Idzic9lH71oTvrCwV4/UHxB7ZYI0LwbmsvCVnQxQvcPfG8gQf2U2gGSQ/3oVTShAMBxn
         DBjJsmpRJ17aK06aJX1xCLM52EiiMaSq1rovL9SrjaN1Fj9kuKjRB+OU7CG4csJvCZjL
         1ZOg==
X-Gm-Message-State: AOAM533RM7OHFukLgbCJkwO4QJGvsvTrqfnLJ4SCyeUlXzW2h8YpFBgm
        8rrpWSylYzInMcfHIn7Izxj6Pg==
X-Google-Smtp-Source: ABdhPJwfDb1RJiu2T8CSba8iYadg/KUjWOQswGqvg0ninL6jf853cEDd4egYqPpXuOc9WLyrKOkBew==
X-Received: by 2002:a5d:4a86:0:b0:20c:c5e4:11f0 with SMTP id o6-20020a5d4a86000000b0020cc5e411f0mr11244252wrq.454.1652648316046;
        Sun, 15 May 2022 13:58:36 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id r17-20020adfbb11000000b0020c5253d920sm8922074wrg.108.2022.05.15.13.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:58:35 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/5] cdrom: make EXPORT_SYMBOL follow exported function
Date:   Sun, 15 May 2022 21:58:29 +0100
Message-Id: <20220515205833.944139-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220515205833.944139-1-phil@philpotter.co.uk>
References: <20220515205833.944139-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Enze Li <lienze@kylinos.cn>

Currently, some EXPORT_SYMBOL declarations do not follow the exported
function, which affects the readability of the code.  To maintain
consistency, move these EXPORT_SYMBOL declarations to the correct
position to improve the readability of the code.

Signed-off-by: Enze Li <lienze@kylinos.cn>
Link: https://lore.kernel.org/all/20220406090337.1116708-1-lienze@kylinos.cn
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/cdrom/cdrom.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 2dc9da683a13..7e2174f597f3 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -648,6 +648,7 @@ int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
 	mutex_unlock(&cdrom_mutex);
 	return 0;
 }
+EXPORT_SYMBOL(register_cdrom);
 #undef ENSURE
 
 void unregister_cdrom(struct cdrom_device_info *cdi)
@@ -663,6 +664,7 @@ void unregister_cdrom(struct cdrom_device_info *cdi)
 
 	cd_dbg(CD_REG_UNREG, "drive \"/dev/%s\" unregistered\n", cdi->name);
 }
+EXPORT_SYMBOL(unregister_cdrom);
 
 int cdrom_get_media_event(struct cdrom_device_info *cdi,
 			  struct media_event_desc *med)
@@ -690,6 +692,7 @@ int cdrom_get_media_event(struct cdrom_device_info *cdi,
 	memcpy(med, &buffer[sizeof(*eh)], sizeof(*med));
 	return 0;
 }
+EXPORT_SYMBOL(cdrom_get_media_event);
 
 static int cdrom_get_random_writable(struct cdrom_device_info *cdi,
 			      struct rwrt_feature_desc *rfd)
@@ -1206,6 +1209,7 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 	cdi->use_count--;
 	return ret;
 }
+EXPORT_SYMBOL(cdrom_open);
 
 /* This code is similar to that in open_for_data. The routine is called
    whenever an audio play operation is requested.
@@ -1301,6 +1305,7 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
 			cdo->tray_move(cdi, 1);
 	}
 }
+EXPORT_SYMBOL(cdrom_release);
 
 static int cdrom_read_mech_status(struct cdrom_device_info *cdi, 
 				  struct cdrom_changer_info *buf)
@@ -1382,6 +1387,7 @@ int cdrom_number_of_slots(struct cdrom_device_info *cdi)
 	kfree(info);
 	return nslots;
 }
+EXPORT_SYMBOL(cdrom_number_of_slots);
 
 
 /* If SLOT < 0, unload the current slot.  Otherwise, try to load SLOT. */
@@ -1581,6 +1587,7 @@ void init_cdrom_command(struct packet_command *cgc, void *buf, int len,
 	cgc->data_direction = type;
 	cgc->timeout = CDROM_DEF_TIMEOUT;
 }
+EXPORT_SYMBOL(init_cdrom_command);
 
 /* DVD handling */
 
@@ -1999,6 +2006,7 @@ int cdrom_mode_sense(struct cdrom_device_info *cdi,
 	cgc->data_direction = CGC_DATA_READ;
 	return cdo->generic_packet(cdi, cgc);
 }
+EXPORT_SYMBOL(cdrom_mode_sense);
 
 int cdrom_mode_select(struct cdrom_device_info *cdi,
 		      struct packet_command *cgc)
@@ -2014,6 +2022,7 @@ int cdrom_mode_select(struct cdrom_device_info *cdi,
 	cgc->data_direction = CGC_DATA_WRITE;
 	return cdo->generic_packet(cdi, cgc);
 }
+EXPORT_SYMBOL(cdrom_mode_select);
 
 static int cdrom_read_subchannel(struct cdrom_device_info *cdi,
 				 struct cdrom_subchnl *subchnl, int mcn)
@@ -2892,6 +2901,7 @@ int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written)
 	*last_written = toc.cdte_addr.lba;
 	return 0;
 }
+EXPORT_SYMBOL(cdrom_get_last_written);
 
 /* return the next writable block. also for udf file system. */
 static int cdrom_get_next_writable(struct cdrom_device_info *cdi,
@@ -3429,18 +3439,7 @@ int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
 
 	return -ENOSYS;
 }
-
-EXPORT_SYMBOL(cdrom_get_last_written);
-EXPORT_SYMBOL(register_cdrom);
-EXPORT_SYMBOL(unregister_cdrom);
-EXPORT_SYMBOL(cdrom_open);
-EXPORT_SYMBOL(cdrom_release);
 EXPORT_SYMBOL(cdrom_ioctl);
-EXPORT_SYMBOL(cdrom_number_of_slots);
-EXPORT_SYMBOL(cdrom_mode_select);
-EXPORT_SYMBOL(cdrom_mode_sense);
-EXPORT_SYMBOL(init_cdrom_command);
-EXPORT_SYMBOL(cdrom_get_media_event);
 
 #ifdef CONFIG_SYSCTL
 
-- 
2.35.3

