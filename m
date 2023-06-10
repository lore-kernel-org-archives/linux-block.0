Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D616FC7EE2E
	for <linux-block@archiver.kernel.org>; Sat, 10 Jun 2023 06:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjFJGMv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 10 Jun 2023 02:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjFJGMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Jun 2023 02:12:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E1F3AB1
        for <linux-block@vger.kernel.org>; Fri,  9 Jun 2023 23:12:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B82E637E0
        for <linux-block@vger.kernel.org>; Sat, 10 Jun 2023 06:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF09C433D2;
        Sat, 10 Jun 2023 06:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686377568;
        bh=guscGVwpchzS/VJ1rxF1Dy2enAsS8VWD6D/L308iSpQ=;
        h=From:To:Cc:Subject:Date:From;
        b=f0J/uKrj9CdGj+RKO8wIAWxwc+UQEek5L56BCMjQ8/nLpdrKJkaYcjqkdfzeWSEQd
         6nMVycjRtuROkYbRxqLh9TWv9zPsegb18BJE6Sfv7itD/cuxqXS8xFSw5qUxR4e9zE
         V2BgZH1nUsg3xwNfvsz7irDI4oChbAwr3JYwpq9tvDt4vtCP9kqEUikERbI3EUvVn5
         4IYBEbMT/2F7bXs1sgJicxp2joCxbf2ai8PEWbm7oXhLD15BPNYIOA38NqDkhUrnZE
         Ugr6J6nJUmPtv0JMYecGAI/lhjKmLlK06KaOMNFBjlZ/iGfVtjJh/AnRDnZ1zTttOm
         XEpAlc8MPqKvQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     dm-devel@redhat.com, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] blk-crypto: use dynamic lock class for blk_crypto_profile::lock
Date:   Fri,  9 Jun 2023 23:11:39 -0700
Message-Id: <20230610061139.212085-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When a device-mapper device is passing through the inline encryption
support of an underlying device, calls to blk_crypto_evict_key() take
the blk_crypto_profile::lock of the device-mapper device, then take the
blk_crypto_profile::lock of the underlying device (nested).  This isn't
a real deadlock, but it causes a lockdep report because there is only
one lock class for all instances of this lock.

Lockdep subclasses don't really work here because the hierarchy of block
devices is dynamic and could have more than 2 levels.

Instead, register a dynamic lock class for each blk_crypto_profile, and
associate that with the lock.

This avoids false-positive lockdep reports like the following:

    ============================================
    WARNING: possible recursive locking detected
    6.4.0-rc5 #2 Not tainted
    --------------------------------------------
    fscryptctl/1421 is trying to acquire lock:
    ffffff80829ca418 (&profile->lock){++++}-{3:3}, at: __blk_crypto_evict_key+0x44/0x1c0

                   but task is already holding lock:
    ffffff8086b68ca8 (&profile->lock){++++}-{3:3}, at: __blk_crypto_evict_key+0xc8/0x1c0

                   other info that might help us debug this:
     Possible unsafe locking scenario:

           CPU0
           ----
      lock(&profile->lock);
      lock(&profile->lock);

                    *** DEADLOCK ***

     May be due to missing lock nesting notation

Fixes: 1b2628397058 ("block: Keyslot Manager for Inline Encryption")
Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-crypto-profile.c         | 12 ++++++++++--
 include/linux/blk-crypto-profile.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 2a67d3fb63e5c..7fabc883e39f1 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -79,7 +79,14 @@ int blk_crypto_profile_init(struct blk_crypto_profile *profile,
 	unsigned int slot_hashtable_size;
 
 	memset(profile, 0, sizeof(*profile));
-	init_rwsem(&profile->lock);
+
+	/*
+	 * profile->lock of an underlying device can nest inside profile->lock
+	 * of a device-mapper device, so use a dynamic lock class to avoid
+	 * false-positive lockdep reports.
+	 */
+	lockdep_register_key(&profile->lockdep_key);
+	__init_rwsem(&profile->lock, "&profile->lock", &profile->lockdep_key);
 
 	if (num_slots == 0)
 		return 0;
@@ -89,7 +96,7 @@ int blk_crypto_profile_init(struct blk_crypto_profile *profile,
 	profile->slots = kvcalloc(num_slots, sizeof(profile->slots[0]),
 				  GFP_KERNEL);
 	if (!profile->slots)
-		return -ENOMEM;
+		goto err_destroy;
 
 	profile->num_slots = num_slots;
 
@@ -435,6 +442,7 @@ void blk_crypto_profile_destroy(struct blk_crypto_profile *profile)
 {
 	if (!profile)
 		return;
+	lockdep_unregister_key(&profile->lockdep_key);
 	kvfree(profile->slot_hashtable);
 	kvfree_sensitive(profile->slots,
 			 sizeof(profile->slots[0]) * profile->num_slots);
diff --git a/include/linux/blk-crypto-profile.h b/include/linux/blk-crypto-profile.h
index e6802b69cdd64..90ab33cb5d0ef 100644
--- a/include/linux/blk-crypto-profile.h
+++ b/include/linux/blk-crypto-profile.h
@@ -111,6 +111,7 @@ struct blk_crypto_profile {
 	 * keyslots while ensuring that they can't be changed concurrently.
 	 */
 	struct rw_semaphore lock;
+	struct lock_class_key lockdep_key;
 
 	/* List of idle slots, with least recently used slot at front */
 	wait_queue_head_t idle_slots_wait_queue;

base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
-- 
2.40.1

