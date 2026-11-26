Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.160
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688832;
	b=mZHm5bLd2uExvM6n+l4QxwTqjWDAvq6KsHBweTzzQXSDxGq/QSZkWBguRjomQs16ww2D
	 nUN2/oSQHAyXqcIs0Gz9iM87RPPgkjPWr7WCiFCKjvEf2I4W2WHZclgwEjBXiKNIqLGZ1
	 eF3t+lCF5bV5JU1GTOD7zW8Kn/HNUXdKzdfsBEn4GLkrZRdYya9EO6zoUARPDjF7Mr+k8
	 4tY2qo2pmO3+Vn4hnshlbn39+oXtCsLkHX79J5Kv2qX6xXJ6n+exsGiwm3fs3niLjwnhi
	 Mk7HfmyZH57KadvUIg3+SIQzTYDBs93M6DnmO8z/lNmmPRPgncBxbGthhwrWpsMuRcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688832;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:
	 Message-ID:Date:MIME-Version:User-Agent:Content-Language:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=ajcqIqoxhXjAZt6mEuD6G9Qzl1LusZwmoIaRBj11Qfc=;
	b=kZYJ/nUQnwv1hfKZ0PBj1S+hMkTOXjB+l9PCvORF+0gUw0fFBQETgF9t63aXaOLNcrP/
	 oAozKYdWcLvIX87WJfRhPGbno+bC1jzdr56u2YO3jmb6JzYoSuDaysQYpoFjooV3WtmAY
	 f7DHluw9kcVIVLe8LG3yi6tyLQGo1gURDQ/aIOl0pEhW6GNPZ80da70ySQ575Z812D/pp
	 lhxe7aC73ijE8b4/ZQZoY6lbqFcflp8zGxbK7vDP0IxVsxT9f1tnvogRLAdO5V6AuCeCl
	 XXYN+DFLAgfh3eKXzOXajO3aJDgrpLViczfCpUwI1/nZGP6u7o1h3sq65p77HNC1iEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=scst.dev;
	spf=pass smtp.mailfrom=scst.dev;
	dkim=pass header.d=scst.dev header.i=@scst.dev header.a=rsa-sha256 header.s=mail header.b="L/32Uvbg";
	arc=none smtp.remote-ip=51.250.60.160
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [51.250.60.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F7606A31E
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 10:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D61F7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scst.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scst.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=scst.dev header.i=@scst.dev header.a=rsa-sha256 header.s=mail header.b=L/32Uvbg
Received: from mail-nwsmtp-smtp-production-main-73 (mail-nwsmtp-smtp-production-main-73.yp-c.yandex.net)
	by forward100d.mail.yandex.net (postfix) with ESMTPS id C0DE5C7C5B;
	Thu, 26 Nov 2026 13:27:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73 with ESMTPSA id 0RfnbXOXBKo0-atMXYEg2;
	Thu, 26 Nov 2026 13:27:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scst.dev; s=mail;
	t=1795688821; bh=ajcqIqoxhXjAZt6mEuD6G9Qzl1LusZwmoIaRBj11Qfc=;
	h=Subject:From:Cc:To:Date:Message-ID;
	b=L/32UvbgHgEdVeubNlccR26W5mWhQbi4DM8LFJUpr2fWyM1itA/TX9OG172/GmXpp
	 VmsSidrvKT32sOVRvkMcLEVIk35dwSC2os+UJSnrTRPOL1W3rJqKXNYE8IfUIQ3hpg
	 iUOBiRyAkbDB5iJwpI3jYb+PM0+iXPcUUvbjgoSY=
Authentication-Results: mail-nwsmtp-smtp-production-main-73; dkim=pass header.i=@scst.dev
Message-ID: <b520c362-c26f-4796-847e-b982383582b0@scst.dev>
Date: Thu, 26 Nov 2026 13:27:00 +0300
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>
From: Gleb Chesnokov <gleb.chesnokov@scst.dev>
Subject: [PATCH] block: drop the claim on a rejected write open by path
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

bdev_file_open_by_path() checks whether the device is read-only after
bdev_file_open_by_dev() has already claimed it for the caller's holder.
On this error path, fput() can defer ->release() until after the caller
gets -EACCES. A different holder can still get -EBUSY, and the block
layer can still call ->mark_dead() after the caller has freed its holder
state. The caller receives no file with which to release the claim.

Use bdev_fput() to drop the claim acquired by this open before returning
-EACCES. The final file release can still be deferred.

Fixes: f3a608827d1f ("bdev: open block device as files")
Signed-off-by: Gleb Chesnokov <gleb.chesnokov@scst.dev>
---
Tested in QEMU with two back-to-back opens of a read-only RAM disk from
the same task. The read/write open returned -EACCES on both kernels.
The read open with a different holder returned -EBUSY before the fix
and succeeded with it.

OpenAI Codex assisted with testing.

 block/bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index f20f91b3176e..add1a69f2f4a 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1127,7 +1127,7 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 	file = bdev_file_open_by_dev(dev, mode, holder, hops);
 	if (!IS_ERR(file) && (mode & BLK_OPEN_WRITE)) {
 		if (bdev_read_only(file_bdev(file))) {
-			fput(file);
+			bdev_fput(file);
 			file = ERR_PTR(-EACCES);
 		}
 	}

base-commit: 25faec9ce61c01fb45abf812a222c5b43c3cd5c5
-- 
2.56.1
