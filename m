Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2306369974;
	Mon, 16 Mar 2026 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701043; cv=none; b=ACpOhhtSTT+hs2Lvt81i0SCCtU1E7zVYrSqbIeQt+VfWMNX3UBeFwpcYiHC75Nl7/d7zz8TqeAEZR9e7tc3eRl48ch7GGlzJBPhRfmtVWjOYFWZbMnf4ESs7CsDPwTd9clW0cXHtGMtHBlAAKiG7Qpmr7ICoNk+2mCKAGAKiIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701043; c=relaxed/simple;
	bh=o4M9xO7cBkHyf5v4N4x3te1GCWb5dWMJ3kwvnEezD1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p9RoJP0g1Z4ovvCYQBhr2H5Sm8EXZLS6vWWX4pvUwk+dd7aTYjFnaU15UIqHCXBcqeWuf/hjM5TdqkyIF+qYX810PnuZJjaWRHgUP7PLq1mEMx6qUhwuoJb0+iJj2U54GoWuXpYNc2IJluQ3tcbjE2LIvufcu9asXJtsjV84QYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VR5mMNxU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VR5mMNxU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1773701039;
	bh=o4M9xO7cBkHyf5v4N4x3te1GCWb5dWMJ3kwvnEezD1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VR5mMNxU+nLxNb99nIgaB8JHhNpb81aLssiPIjfjom/m0uikWC4HpN1e/xXBA2ryT
	 fxVwpV3D0L48qiTyKNkwKhNgCkSvV43Pn2lsWTGdWFC6EsHVoBvzbuLaerGjDxy/zu
	 rXjeqb6R9i/Uv+NBxCPnO1atLhyJlWZJztJIk5Hg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Mar 2026 23:43:53 +0100
Subject: [PATCH 3/4] blk-crypto: make blk_crypto_attr instances const
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260316-b4-sysfs-const-attr-block-v1-3-a35d73b986b0@weissschuh.net>
References: <20260316-b4-sysfs-const-attr-block-v1-0-a35d73b986b0@weissschuh.net>
In-Reply-To: <20260316-b4-sysfs-const-attr-block-v1-0-a35d73b986b0@weissschuh.net>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773701039; l=5779;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=o4M9xO7cBkHyf5v4N4x3te1GCWb5dWMJ3kwvnEezD1A=;
 b=TspxzsaFQQ0opLhmofh7vV2DScE5xs9TZz2jADAR97nMw8aYr6PlM33eFoOUg0L1COQ/y9lsN
 dcqzdwgisxXC9qkinAA1G4Vb2Yb9Ma+3vmHCE2YOY+1XcRvnuTMjCrK
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The blk_crypto_attrs structures are never modified, mark them as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/blk-crypto-sysfs.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/block/blk-crypto-sysfs.c b/block/blk-crypto-sysfs.c
index ea7a0b85a46f..b069c418b6cc 100644
--- a/block/blk-crypto-sysfs.c
+++ b/block/blk-crypto-sysfs.c
@@ -18,7 +18,7 @@ struct blk_crypto_kobj {
 struct blk_crypto_attr {
 	struct attribute attr;
 	ssize_t (*show)(struct blk_crypto_profile *profile,
-			struct blk_crypto_attr *attr, char *page);
+			const struct blk_crypto_attr *attr, char *page);
 };
 
 static struct blk_crypto_profile *kobj_to_crypto_profile(struct kobject *kobj)
@@ -26,39 +26,39 @@ static struct blk_crypto_profile *kobj_to_crypto_profile(struct kobject *kobj)
 	return container_of(kobj, struct blk_crypto_kobj, kobj)->profile;
 }
 
-static struct blk_crypto_attr *attr_to_crypto_attr(struct attribute *attr)
+static const struct blk_crypto_attr *attr_to_crypto_attr(const struct attribute *attr)
 {
-	return container_of(attr, struct blk_crypto_attr, attr);
+	return container_of_const(attr, struct blk_crypto_attr, attr);
 }
 
 static ssize_t hw_wrapped_keys_show(struct blk_crypto_profile *profile,
-				    struct blk_crypto_attr *attr, char *page)
+				    const struct blk_crypto_attr *attr, char *page)
 {
 	/* Always show supported, since the file doesn't exist otherwise. */
 	return sysfs_emit(page, "supported\n");
 }
 
 static ssize_t max_dun_bits_show(struct blk_crypto_profile *profile,
-				 struct blk_crypto_attr *attr, char *page)
+				 const struct blk_crypto_attr *attr, char *page)
 {
 	return sysfs_emit(page, "%u\n", 8 * profile->max_dun_bytes_supported);
 }
 
 static ssize_t num_keyslots_show(struct blk_crypto_profile *profile,
-				 struct blk_crypto_attr *attr, char *page)
+				 const struct blk_crypto_attr *attr, char *page)
 {
 	return sysfs_emit(page, "%u\n", profile->num_slots);
 }
 
 static ssize_t raw_keys_show(struct blk_crypto_profile *profile,
-			     struct blk_crypto_attr *attr, char *page)
+			     const struct blk_crypto_attr *attr, char *page)
 {
 	/* Always show supported, since the file doesn't exist otherwise. */
 	return sysfs_emit(page, "supported\n");
 }
 
 #define BLK_CRYPTO_RO_ATTR(_name) \
-	static struct blk_crypto_attr _name##_attr = __ATTR_RO(_name)
+	static const struct blk_crypto_attr _name##_attr = __ATTR_RO(_name)
 
 BLK_CRYPTO_RO_ATTR(hw_wrapped_keys);
 BLK_CRYPTO_RO_ATTR(max_dun_bits);
@@ -66,10 +66,10 @@ BLK_CRYPTO_RO_ATTR(num_keyslots);
 BLK_CRYPTO_RO_ATTR(raw_keys);
 
 static umode_t blk_crypto_is_visible(struct kobject *kobj,
-				     struct attribute *attr, int n)
+				     const struct attribute *attr, int n)
 {
 	struct blk_crypto_profile *profile = kobj_to_crypto_profile(kobj);
-	struct blk_crypto_attr *a = attr_to_crypto_attr(attr);
+	const struct blk_crypto_attr *a = attr_to_crypto_attr(attr);
 
 	if (a == &hw_wrapped_keys_attr &&
 	    !(profile->key_types_supported & BLK_CRYPTO_KEY_TYPE_HW_WRAPPED))
@@ -81,7 +81,7 @@ static umode_t blk_crypto_is_visible(struct kobject *kobj,
 	return 0444;
 }
 
-static struct attribute *blk_crypto_attrs[] = {
+static const struct attribute *const blk_crypto_attrs[] = {
 	&hw_wrapped_keys_attr.attr,
 	&max_dun_bits_attr.attr,
 	&num_keyslots_attr.attr,
@@ -90,8 +90,8 @@ static struct attribute *blk_crypto_attrs[] = {
 };
 
 static const struct attribute_group blk_crypto_attr_group = {
-	.attrs = blk_crypto_attrs,
-	.is_visible = blk_crypto_is_visible,
+	.attrs_const = blk_crypto_attrs,
+	.is_visible_const = blk_crypto_is_visible,
 };
 
 /*
@@ -99,13 +99,13 @@ static const struct attribute_group blk_crypto_attr_group = {
  * modes, these are initialized at boot time by blk_crypto_sysfs_init().
  */
 static struct blk_crypto_attr __blk_crypto_mode_attrs[BLK_ENCRYPTION_MODE_MAX];
-static struct attribute *blk_crypto_mode_attrs[BLK_ENCRYPTION_MODE_MAX + 1];
+static const struct attribute *blk_crypto_mode_attrs[BLK_ENCRYPTION_MODE_MAX + 1];
 
 static umode_t blk_crypto_mode_is_visible(struct kobject *kobj,
-					  struct attribute *attr, int n)
+					  const struct attribute *attr, int n)
 {
 	struct blk_crypto_profile *profile = kobj_to_crypto_profile(kobj);
-	struct blk_crypto_attr *a = attr_to_crypto_attr(attr);
+	const struct blk_crypto_attr *a = attr_to_crypto_attr(attr);
 	int mode_num = a - __blk_crypto_mode_attrs;
 
 	if (profile->modes_supported[mode_num])
@@ -114,7 +114,7 @@ static umode_t blk_crypto_mode_is_visible(struct kobject *kobj,
 }
 
 static ssize_t blk_crypto_mode_show(struct blk_crypto_profile *profile,
-				    struct blk_crypto_attr *attr, char *page)
+				    const struct blk_crypto_attr *attr, char *page)
 {
 	int mode_num = attr - __blk_crypto_mode_attrs;
 
@@ -123,8 +123,8 @@ static ssize_t blk_crypto_mode_show(struct blk_crypto_profile *profile,
 
 static const struct attribute_group blk_crypto_modes_attr_group = {
 	.name = "modes",
-	.attrs = blk_crypto_mode_attrs,
-	.is_visible = blk_crypto_mode_is_visible,
+	.attrs_const = blk_crypto_mode_attrs,
+	.is_visible_const = blk_crypto_mode_is_visible,
 };
 
 static const struct attribute_group *blk_crypto_attr_groups[] = {
@@ -137,7 +137,7 @@ static ssize_t blk_crypto_attr_show(struct kobject *kobj,
 				    struct attribute *attr, char *page)
 {
 	struct blk_crypto_profile *profile = kobj_to_crypto_profile(kobj);
-	struct blk_crypto_attr *a = attr_to_crypto_attr(attr);
+	const struct blk_crypto_attr *a = attr_to_crypto_attr(attr);
 
 	return a->show(profile, a, page);
 }

-- 
2.53.0

