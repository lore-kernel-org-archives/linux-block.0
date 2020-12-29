Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0733C4332E
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 08:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B79208BA
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 08:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgL2I4w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Dec 2020 03:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgL2I4v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 03:56:51 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32923C0617A2
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 00:55:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k7so22676848ybm.13
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 00:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=r1uNbK6vumQ2S39nZ29dwK/wuBEGW5LyLS9BAyhIDUk=;
        b=CJKxr1tVDbYCd2gmA9SkBlYMe/ogzmzQaqOpt1dUZGkoIDBPIu1TyahgJ7yLlRVXEI
         LVG0HbaYzdac4yPQ0G7ui2cqw5sX7rYggjiQqRykh65ZunCCnZyDAzGWeltD30dZhlnr
         LYa7svxRhbbIWLHyOdX7ITnNIGogLwGFr8srfk0KQfhLFA/n4ArBGyaXSVrXR0gDzcH6
         lBL6XUo1JLCrndsuJfcsi/VGUEWbZMw7epOZDz1iVnkIC+kngniOvW8ZjOkezb8XPvKV
         w1/0aWTrOtjLGLST7ViOHYpgtbAjURTsyQtYnbECoCKcxDM4J7/vvMgVvziWklqD85JT
         XqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r1uNbK6vumQ2S39nZ29dwK/wuBEGW5LyLS9BAyhIDUk=;
        b=tNqUKqGhX3y9YKa8uxqFc5VSuAYsx3Se1zfkWpMISfX4zOkcncMU1gXBEituadt5Ou
         fHMryQ5el9FTjFXeQu0PdYZUL//ttsrMNA4v+0Gz73lN0p26VdCNbASIldUt2df+Vckw
         ezLJpXOgCAbnsMKkEEr0yZyhADqtOnyUAq51M1UDxtFp7ni+/ARDrj1s+n2sXuWvjbuB
         qop6Enll9c9SMdaSq4vh3HqMy3a5ECF6Scp3vBi1Uw3Lx5VDXZnmInNvP3/x5pOe878U
         Cb1eyL/eYUrm+C/R9D7GhxiTZiG+9lOtDLTgtA/l3U365p7z07Yw0HAguh9ZyeNg0Bk6
         fjvg==
X-Gm-Message-State: AOAM533ieo+oGA3PlK8nvkHxtuKvRAJKywbTpFMVZmR33hlx6L2w/gSe
        KJEtRyAlAr117tfwRxNyzCfPWiXzQBe3qFowpf59lkYpZucuTtAZLSKbFtu+Kft8OLT/fP+P+kM
        BTooGHoCrBqafzb9AO+bNUSxVEAMiHhEtnbLIGRQu8VxjnzyENCtrRXSryzZGQxXn+ABl
X-Google-Smtp-Source: ABdhPJwAOebr5YmlpPKNLl4A1ee+wOmB1Pjbxc5UpF9vjNQ+t39UJhcZfwlSIs9MpPG+YVcV9uIsQgPy5Q0=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:aa91:: with SMTP id t17mr63938387ybi.394.1609232137422;
 Tue, 29 Dec 2020 00:55:37 -0800 (PST)
Date:   Tue, 29 Dec 2020 08:55:22 +0000
In-Reply-To: <20201229085524.2795331-1-satyat@google.com>
Message-Id: <20201229085524.2795331-5-satyat@google.com>
Mime-Version: 1.0
References: <20201229085524.2795331-1-satyat@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v3 4/6] dm: Support key eviction from keyslot managers of
 underlying devices
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that device mapper supports inline encryption, add the ability to
evict keys from all underlying devices. When an upper layer requests
a key eviction, we simply iterate through all underlying devices
and evict that key from each device.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto.c |  1 +
 drivers/md/dm.c    | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 5da43f0973b4..c2be8f15006c 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -409,3 +409,4 @@ int blk_crypto_evict_key(struct request_queue *q,
 	 */
 	return blk_crypto_fallback_evict_key(key);
 }
+EXPORT_SYMBOL_GPL(blk_crypto_evict_key);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 13b9c8e2e21b..b8844171d8e4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1949,6 +1949,58 @@ struct dm_keyslot_manager {
 	struct mapped_device *md;
 };
 
+struct dm_keyslot_evict_args {
+	const struct blk_crypto_key *key;
+	int err;
+};
+
+static int dm_keyslot_evict_callback(struct dm_target *ti, struct dm_dev *dev,
+				     sector_t start, sector_t len, void *data)
+{
+	struct dm_keyslot_evict_args *args = data;
+	int err;
+
+	err = blk_crypto_evict_key(bdev_get_queue(dev->bdev), args->key);
+	if (!args->err)
+		args->err = err;
+	/* Always try to evict the key from all devices. */
+	return 0;
+}
+
+/*
+ * When an inline encryption key is evicted from a device-mapper device, evict
+ * it from all the underlying devices.
+ */
+static int dm_keyslot_evict(struct blk_keyslot_manager *ksm,
+			    const struct blk_crypto_key *key, unsigned int slot)
+{
+	struct dm_keyslot_manager *dksm = container_of(ksm,
+						       struct dm_keyslot_manager,
+						       ksm);
+	struct mapped_device *md = dksm->md;
+	struct dm_keyslot_evict_args args = { key };
+	struct dm_table *t;
+	int srcu_idx;
+	int i;
+	struct dm_target *ti;
+
+	t = dm_get_live_table(md, &srcu_idx);
+	if (!t)
+		return 0;
+	for (i = 0; i < dm_table_get_num_targets(t); i++) {
+		ti = dm_table_get_target(t, i);
+		if (!ti->type->iterate_devices)
+			continue;
+		ti->type->iterate_devices(ti, dm_keyslot_evict_callback, &args);
+	}
+	dm_put_live_table(md, srcu_idx);
+	return args.err;
+}
+
+static struct blk_ksm_ll_ops dm_ksm_ll_ops = {
+	.keyslot_evict = dm_keyslot_evict,
+};
+
 static int device_intersect_crypto_modes(struct dm_target *ti,
 					 struct dm_dev *dev, sector_t start,
 					 sector_t len, void *data)
@@ -1998,6 +2050,7 @@ dm_construct_keyslot_manager(struct mapped_device *md, struct dm_table *t)
 
 	ksm = &dksm->ksm;
 	blk_ksm_init_passthrough(ksm);
+	ksm->ksm_ll_ops = dm_ksm_ll_ops;
 	ksm->max_dun_bytes_supported = UINT_MAX;
 	memset(ksm->crypto_modes_supported, 0xFF,
 	       sizeof(ksm->crypto_modes_supported));
-- 
2.29.2.729.g45daf8777d-goog

