Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7D4A43EE
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636041; cv=none; b=KixaZM8jSw4YuUwfd3TFo0JgFGbh/3AT7nmGV96NsP+bHcnp77VprypvfM2ymxeCdjDxj/cJUaeTuELL+vU6ONT3wDIdnT232ghvHMA4QT9f/CBMKhkDMy4RaAUx+FRKgyN2FOi+0Ry7KuDyxtrHTsOlFHYHw8LR8drNqzLzgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636041; c=relaxed/simple;
	bh=4VYAgGnCoLccnThsi6FGyu7dWH9CoLPORdAqvgX6CSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XyAyNEUKeOOBND6eTtjvjZqyz1kV1BadvDkCZF8VADAeDACRnl0r7PGq77htOY8ztCnNlNeYBkhwA6Fij3/H9YzbJAyk1uI8HSzNycqaITMBMcAXd5QOEQqgH90eiWm4fLQ8oAKUJARvOG4sDM+1V6/ycdaAWs4v+56tBb6B+7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0r4xj3Q; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0r4xj3Q"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6063d7daaso867028a12.1
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 02:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789636038; x=1790240838; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=11XG6GHVaKbsTYUnnB/fk0WT0cIpei9Z8XfJe+BSC78=;
        b=A0r4xj3QNwAAw62cs9wWPGv7Oa1AR6vFxFL1JZ/AW4UM8QE1jqJrJrGujM4kbFtZVM
         Hr/PRDs3Sgwh55dfNItyEGYJmsmAVEjV9ssdmpNJp1TTCMkM0VYtwP5b3L3ISwy5k7OF
         0I969s2KAVqA8swHFBHVqykZyOPfhEXg71Sw+Ca0XQBdakhZfviAdFolwVnq5D28akod
         GybY1gWkdmbN5+IAhHitrzNw35+SRZSv4/iUUJND7zZY9SKTHMG0rx0ROMsHrQXD91MZ
         fGWF6GhJN9Gd5wgadMF/CP6BT/hJ59pPX4F02aGAjmbDOk3q0c+grJkpi1h6phzn3UPL
         JNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789636038; x=1790240838;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=11XG6GHVaKbsTYUnnB/fk0WT0cIpei9Z8XfJe+BSC78=;
        b=nRWswwMT0ZSuE8OKxzQtopEHTAWgwXJJW2IvkfxTaQEEfSzAREMyGDI9iBS2VEqNEb
         hUbvUokxMCrPlSJcJS1VNn1vBfRlpRJ5jXHWB/lrfGoqPod34R0kWyRR/y0gf/MBdlr8
         SJp667Grpp6X81ssKt7+4rE3lzdD754dHAkl04lyXvIgxcZ5RQWKRlfRZgpHmEkqoPX5
         wFob4+ZWdRPbmGoYXLS/06GP68GxvHafOa6j7W60L99vc7gI7Li1IvqaZ2k+ZudzS+GX
         wvFMl3g/bxY0d/nSah4NjTDKe5UDHViZ8UM4p0Vxwi9mW3pXTP2D8rXX3CQBdLeGu6ow
         V5zA==
X-Gm-Message-State: AFuF++lq2W8imivuxFC9v1VdERm8RCMuB0V01Oymd39bR2NGDakhfA5L
	WLoe5eSO0U6+s6qNLHqjnn3TSs18TzD8ImorYTwY8LK1CB3mD/wdXOQEbiGE5Q2R
X-Gm-Gg: AYBFou1NPJpB4kEiTUVaI8WaxdigxYrHHb4cZdFm+oE0TQAMc/2tDed3VK4tNWe/6GI
	k6NbA15jGuxqsDwcwW+GK6Ao/j+4SNhBFHrUbhaxjNI2+3+1wQOY/Fkc4YNkMdruYTYSZFfM6xQ
	K/wZ7fPj6Da68BEbdIZTQ9mpauSnR/lIi6yUj9BwuJ/bWZSBZ8eX3WcuNxwloEv/QiAJt1abA4I
	7aNfF/G6RiCTgof6aL+KeMHRD8r9R5MWt8/yRKW3JmtYkJjfhoS4vU+vtwuCo6HcNy7aZtP9FmQ
	tN6/TEJ6Pi85eGO1k5oOZEjv34ekQhyCTmjHZWS0nO3Fiz95JJNi7n1s/1pyzqeSL6uV8Xt0PZQ
	OrqN+zJQKlOv6KsuA2nFY+D8kFjOzpm2hHl3V2i9nPRyYPBwgdx/P1RPRNJOjUqvNXexxMGzyL4
	utify3nlDt2MCR62BVDuPxNFodt51bcUfAUCHp6+f2nw2Yg0QO2cSIx5IsGEC3c4Db+31EMNcUr
	N5g8YaCPBiLxp/344X+Lmc2iMxSkeWHuf25gAP5RSySJMZe/LstqoZVos9msFdc9cS+nC5R
X-Received: by 2002:a05:6402:52d6:b0:6a9:ae73:2b59 with SMTP id 4fb4d7f45d1cf-6aa224041a1mr7540556a12.13.1789636038039;
        Thu, 17 Sep 2026 02:07:18 -0700 (PDT)
Received: from [127.0.0.2] (0x3ec686fb.mobile.telia.dk. [62.198.134.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d2ab4ebsm3286953a12.30.2026.09.17.02.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 02:07:16 -0700 (PDT)
From: Malte Wechter <maltewechter@gmail.com>
Date: Thu, 17 Sep 2026 11:07:13 +0200
Subject: [PATCH] rnull: configfs: add power to configfs features
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-upstream-v7-3-rc3-v1-1-d0b620bf82c9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMCtq2oC/yXMTQqDQAxA4atI1gZGhyrTqxQX85NqBK0kKoJ4d
 6ft8lu8d4KSMCk8ixOEdlb+zBlVWUAc/NwTcsqG2tSNcVWL26KrkJ9wb9GiRIsmhUfjXPLBGsj
 dIvTm4/d8dX/rFkaK63cE13UDOZh5a3UAAAA=
X-Change-ID: 20260917-upstream-v7-3-rc3-0db5699dab30
To: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Malte Wechter <maltewechter@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789636035; l=1119;
 i=maltewechter@gmail.com; s=20260812; h=from:subject:message-id;
 bh=4VYAgGnCoLccnThsi6FGyu7dWH9CoLPORdAqvgX6CSE=;
 b=L3IqiNeupBg1A7BEFeHM7SaRg1I52yfOds1Jaj3LJfHoEFNA1x5jLDRU03mrjIZbe1BAvnwfl
 v3I6WrIC9pFASH5OI3K+kUjNBgOK90ezsjrhRRa1iLXHJikIuJQ+9CY
X-Developer-Key: i=maltewechter@gmail.com; a=ed25519;
 pk=Ta/JQQMOW0Cbxp+yEwWqWFEyKFRyuQeSoYicwD7yvWI=

features displayed by configfs for rnull was inconsistent with the
actual features available. This correctly exposes `power` as a feature,
which is also consistent with the C null_blk driver.

Signed-off-by: Malte Wechter <maltewechter@gmail.com>
---
 drivers/block/rnull/configfs.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 32c10c3f4d0fd..5f1cdd54cf48a 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -35,7 +35,7 @@ impl AttributeOperations<0> for Config {
 
     fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
         let mut writer = kernel::str::Formatter::new(page);
-        writer.write_str("blocksize,size,rotational,irqmode\n")?;
+        writer.write_str("blocksize,size,rotational,irqmode,power\n")?;
         Ok(writer.bytes_written())
     }
 }

---
base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
change-id: 20260917-upstream-v7-3-rc3-0db5699dab30

Best regards,
--  
Malte Wechter <maltewechter@gmail.com>

