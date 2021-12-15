Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED00EC433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Dec 2021 00:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbhLOADA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Dec 2021 19:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbhLOAC7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Dec 2021 19:02:59 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84F5C061574
        for <linux-block@vger.kernel.org>; Tue, 14 Dec 2021 16:02:59 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id u80so19150420pfc.9
        for <linux-block@vger.kernel.org>; Tue, 14 Dec 2021 16:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=HAPVBLWQutdfCAWmP5jiMp1cQ9xrsbBKvjLN2TIcVmM=;
        b=ah/q081tmAxNsTSzdmXFmoadN1g/5JDEcNXHrxLlUJ+GPepAi+qP3b3ofs48rbVoo4
         tm7Y8Lh5+eD+I6ea6/I8R2eRRSM54OSR5pn+LuZA7RxoFk9XeCkyuz6GZP4pjWG29i91
         IN8FjO0XDj5Qr0WCMDS4bGCrKR5T8+us2hbSB4XZTDYZ+G3KHOaU+xTDiRZCAdKx7KlA
         mZvq164+lmHC/KcxwQhCg3MWYtdX5+Sdvxxx1kmkPpiUuXlcv+6SZCxjiDB67Tun6crV
         0/KAtekWXPRSD1shV1P4G3gVg1G8pwMnroJR0Izg2D6DQ1NbEA4FUlSd/P3Hmfj07skv
         8vXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=HAPVBLWQutdfCAWmP5jiMp1cQ9xrsbBKvjLN2TIcVmM=;
        b=aCUIpp/N8k9ac0G7j9SVDwqvwftFTtne6fMidLt+ip0PDlDCzVN+T0i/SzLpDPcUgw
         rDLZCssruphaBpyIFuYWSkN701OK61ZO8EHPd357ZomUUqDMzBMR316P5G4C2tNU0miT
         Z/g8fqv162upg1sPGP4kv4VHpshh6oX48N3PiUrUn9mNLXTA5QhBnclXPudPzWspDn90
         E6chYD+5aSHJqAfE5ofcdC3lrBd4KOhCzWULFtR9MeXbtBEKubS/FGDhrdAYg33o291F
         8Nhx97RvlkWHL5a/DIKqWZ792iTkPRMlGPTKv/6hZTktdAHVMzz/RRXvO7dHHBqsBTOs
         9vHw==
X-Gm-Message-State: AOAM533qqR5/utMJcZeWPsTohDEzJHm8VSWZ8b3CeHOn6Sj2Ecm9aA9o
        ItkznYpLin7o6x+jPlTT8VYzTlPt8h7AWQ==
X-Google-Smtp-Source: ABdhPJxQj/XRKPNK1IVA/EmxHXvfau0hnd5YtSQtwBfjkn13rI7g7RiaaYXP4CJOJyt+yyRd02J3gg==
X-Received: by 2002:a63:1951:: with SMTP id 17mr5889617pgz.568.1639526578998;
        Tue, 14 Dec 2021 16:02:58 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21d6::19f1? ([2620:10d:c090:400::5:a3af])
        by smtp.gmail.com with ESMTPSA id oj11sm3505270pjb.46.2021.12.14.16.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 16:02:58 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Omar Sandoval <osandov@osandov.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: make queue stat accounting a reference
Message-ID: <d6819554-8632-e707-3037-773a6ee904cb@kernel.dk>
Date:   Tue, 14 Dec 2021 17:02:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

kyber turns on IO statistics when it is loaded on a queue, which means
that even if kyber is then later unloaded, we're still stuck with stats
enabled on the queue.

Change the account enabled from a bool to an int, and pair the enable call
with the equivalent disable call. This ensures that stats gets turned off
again appropriately.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-stat.c b/block/blk-stat.c
index efb2a80db906..2ea01b5c1aca 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -15,7 +15,7 @@
 struct blk_queue_stats {
 	struct list_head callbacks;
 	spinlock_t lock;
-	bool enable_accounting;
+	int accounting;
 };
 
 void blk_rq_stat_init(struct blk_rq_stat *stat)
@@ -161,7 +161,7 @@ void blk_stat_remove_callback(struct request_queue *q,
 
 	spin_lock_irqsave(&q->stats->lock, flags);
 	list_del_rcu(&cb->list);
-	if (list_empty(&q->stats->callbacks) && !q->stats->enable_accounting)
+	if (list_empty(&q->stats->callbacks) && !q->stats->accounting)
 		blk_queue_flag_clear(QUEUE_FLAG_STATS, q);
 	spin_unlock_irqrestore(&q->stats->lock, flags);
 
@@ -184,13 +184,24 @@ void blk_stat_free_callback(struct blk_stat_callback *cb)
 		call_rcu(&cb->rcu, blk_stat_free_callback_rcu);
 }
 
+void blk_stat_disable_accounting(struct request_queue *q)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->stats->lock, flags);
+	if (!--q->stats->accounting)
+		blk_queue_flag_clear(QUEUE_FLAG_STATS, q);
+	spin_unlock_irqrestore(&q->stats->lock, flags);
+}
+EXPORT_SYMBOL_GPL(blk_stat_disable_accounting);
+
 void blk_stat_enable_accounting(struct request_queue *q)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&q->stats->lock, flags);
-	q->stats->enable_accounting = true;
-	blk_queue_flag_set(QUEUE_FLAG_STATS, q);
+	if (!q->stats->accounting++)
+		blk_queue_flag_set(QUEUE_FLAG_STATS, q);
 	spin_unlock_irqrestore(&q->stats->lock, flags);
 }
 EXPORT_SYMBOL_GPL(blk_stat_enable_accounting);
@@ -205,7 +216,7 @@ struct blk_queue_stats *blk_alloc_queue_stats(void)
 
 	INIT_LIST_HEAD(&stats->callbacks);
 	spin_lock_init(&stats->lock);
-	stats->enable_accounting = false;
+	stats->accounting = 0;
 
 	return stats;
 }
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 58f029af49e5..17e1eb4ec7e2 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -70,6 +70,7 @@ void blk_stat_add(struct request *rq, u64 now);
 
 /* record time/size info in request but not add a callback */
 void blk_stat_enable_accounting(struct request_queue *q);
+void blk_stat_disable_accounting(struct request_queue *q);
 
 /**
  * blk_stat_alloc_callback() - Allocate a block statistics callback.
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index fdd74a4df56f..70ff2a599ef6 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -433,6 +433,7 @@ static void kyber_exit_sched(struct elevator_queue *e)
 	int i;
 
 	del_timer_sync(&kqd->timer);
+	blk_stat_disable_accounting(kqd->q);
 
 	for (i = 0; i < KYBER_NUM_DOMAINS; i++)
 		sbitmap_queue_free(&kqd->domain_tokens[i]);

-- 
Jens Axboe

