Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205872;
	b=NJsqOjbSHKYGRAqJzbVdTVIJNPvR+1Jz0LnzqJE3UBnKBrcEhrD4lo0fBXnj0xG0eK4c
	 tUhTEtJRZxSwwdZ6889bviPp59ja1RJ6Z+y5l3Z9ZIbdTqxS6lwi0/umePf0Q3/1E7Twk
	 fVyCUiq254wLfEeCyBUS6bBrjxX9HpLl6552FIS8IzYBKvvZaKS57ZbA9C1XlBICPQHWf
	 OPpPavoS2MWcr5Phmu/yPgpkAzylusPlxHiZF9NgbPgo6VvEa/xkD3YL0eELP1+JhsESe
	 3LWNPfNUwueXnETTUJLSjhqGEsxnU1a3Pr/KYVrhvfszYIvCn8jlsCSxn/d7EM5X8ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DNsU2rr6evMq6kv1i6+3lVmoeET+moz23by1MknrvSI=;
	b=MyL1IS7PWojf/Y6iK33JWEArpFxFnZAXrHJG7SI+ZbJjlQ8ZR0qUJvL6To8ctHqUDWS6
	 iTSz02VQxE9CtKUh/1fLiFWBqKczeJ/a5reK/pajVG5+nSm+d68lWL6ZylnTBHjNYorBT
	 NV95mWBsKBiCEvYcgcOcV8j8nM108EHW22/NjEKCEQsA2QQYaQ6w3l6wCCgWN8ELFEV6L
	 7aQKCDTB+fKqzTjH+BBokctymYfNOzkKNRvHCKhmUi2s6rl4Mp52urju0UnK1YZytTPHV
	 aUIcFpJGZ5Ij5CCJ9CyD5Qd8PbRyv/FV8Rw1S2DMkK6DqFLubGLg5Fxx07XLTCHY08Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iArEnJ+J;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26533606A321
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26533606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iArEnJ+J
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f48c750afcso826884a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205871; x=1793810671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DNsU2rr6evMq6kv1i6+3lVmoeET+moz23by1MknrvSI=;
        b=iArEnJ+JWWaoBS9xophF7ocSkSo0UyepTsuhnl+QH3yI/AymOdM91GvVPYRilgeflw
         u2y++zOGaVmK5XG+SeuTZWsc11UvUA/wnWdLF5J9KasHBOyY/17QJOWpj8WzQU2O7x1w
         1Kd3EgMES9G18kD4RX7BbBDjmTFgUTZKDBSBcS/YIwEyWOYMA+Au6adlWXkae0gmoUiN
         Gfr3o7bjwoREWru3s9XSXjsHEiWfyHw/ZTqgmae6bBM2+0r6t72Gx/pGupfHVCzAmcp2
         0q9nW2/sbJ1SOE74YcbEeyVRfXrrRgBQJeMmqVcwuPJ2I32Ua4aUUIG5qiBz6Zs/yl/h
         Wpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205871; x=1793810671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DNsU2rr6evMq6kv1i6+3lVmoeET+moz23by1MknrvSI=;
        b=d1D/D6378Xtbjmop5KiWFFJSVlG61rVRNQR+H5uXwohA8z/gi/OIvXqEJJl/OISRbZ
         ytB/IdgHKf87K0biq+ajaqDWXkVFY7lGuNgWJWkuxPxP+YXW2kCeRQK3x7Py+5n5l2ng
         J8XGUGR/dQiGXTS8OaiyZj678UqHIvWs7EOAtJF5UP0KSH9TR5q/UlkT2h16bUpuXbRs
         TPmvhz8MpYC/NcxDQy2MU/2Y9+jQWhWuv1wrmBllOQliO6pKBUPQLZd9VjLzDq+JBdKD
         8cTEyY3zLvqodFao5ynnT907LyB9mFMsbHnTo6ayMNlViDIH8W9Yzb7t+2oQkfZFba/w
         sPBg==
X-Gm-Message-State: AFq9FYLuyEptYDxkn2EvnniJr6V4HvxQ1nKD5/e0kqNNBT+HYmwhZf0Z
	MK4BdilnaIh4Vh4xxy4Z4aOaAwDuevOi8eIv3eSEHxPcLbV8RLDwDwuRdJdL1B4oaFg/+ABmJLO
	tvVDc/8g=
X-Gm-Gg: AYBFou2+sGjruo+HKHAi68gwTZlj7kdxoLcDX3Ai8m3vWJhcNvPlfOyJtN5IRWN0bpW
	bCTp8DGmWJ4RXSirwtv2LbtjZwPy4ysp2Gicu0OXSDbGLVgYg6Oby2wmnHiHgR77H41/DWaSFhg
	AIkpJywA6PZE+yjoPotz5HXhVXjZRO3Ok4hX5XVScIv3HwCjn36d4ZyDMwMNwueFnYt3Fj3pPOm
	HR1DFEng/y/KEabY4f65rrFKoe5bwS7BN5RKdSmEBjRpTlnbd+QOQYg0zZ6nbHzkLW1cyMe2O7C
	hGFJ8QzmBcYBLvDHLR+i7eQBhGmkdVlwN0APYhQwBRN7jD6DSyguOYV6ZvjEg/1Tc3wrNqYZjrm
	vFkEuU0+I0a8Iy4/wsuoyU6Q+Ke3KvrvdpTIIIZBBG2Zu8Jg83aX1sgo5GMYkTne6aT0KlekMto
	jQyjMviN4kFT1zk7q2fzZUVlUGDLJlv1vcVntPALEoToLeMQ5deyscmBmIV/cSQm/1NFWaEKeLK
	wY+C3arR7vhFswRz1iSqjCdBRWSY9WoAsbGl1YPM4fq+ReNK50bsRVURbioAhHXH7D0khopqkmy
	1eCaM/OmTjUAHrnlXkK5H/x+0QLmeuOH7HmIbrISzg5Q+rTw/m1+Q2vwg9Heq7Uf+g9MsHRWsQ=
	=
X-Received: by 2002:a05:6830:3d8f:b0:844:d1b5:df47 with SMTP id 46e09a7af769-85ac070710dmr2756868a34.19.1793205871132;
        Wed, 28 Oct 2026 09:44:31 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/98] block: don't unplug a zone under a failed write
Date: Wed, 28 Oct 2026 10:41:13 -0600
Message-ID: <20261028164415.1262013-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

Since commit 552c1149af7a disk_zone_wplug_abort() clears
BLK_ZONE_WPLUG_PLUGGED. For a failed write that happens in bio_endio(),
before the request reaches blk_zone_write_plug_finish_request(). The
issuer can reset the zone and submit a new write in between, which is
issued unplugged, and when the old request is finished it clears the
flag under that one, so the next write goes out alongside it.

Preserve the flag across the abort, the unplug of the failed write
clears it. The exception is QUEUE_FLAG_ZONED_QD1_WRITES, where the abort
takes the plug off the worker's list and nobody is left to clear it.

Fixes: 552c1149af7a ("block: Clear BLK_ZONE_WPLUG_PLUGGED when aborting plugged BIOs")
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-zoned.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 882d07a7c80a..7f405dce2fcb 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1871,9 +1871,20 @@ void blk_zone_write_plug_bio_endio(struct bio *bio)
 	 * needing a write pointer update.
 	 */
 	if (bio->bi_status != BLK_STS_OK) {
+		unsigned int plugged = 0;
+
 		spin_lock_irqsave(&zwplug->lock, flags);
+		/*
+		 * The abort unplugs the zone. But the flag still belongs to a
+		 * write in flight (this one, until its request is finished) or
+		 * to the BIO work, and they clear it when they are done. The
+		 * zone write plugs worker does not rely on the flag to issue
+		 * one write at a time and forgets the plug with the abort.
+		 */
+		if (!blk_queue_zoned_qd1_writes(disk->queue))
+			plugged = zwplug->flags & BLK_ZONE_WPLUG_PLUGGED;
 		disk_zone_wplug_abort(zwplug);
-		zwplug->flags |= BLK_ZONE_WPLUG_NEED_WP_UPDATE;
+		zwplug->flags |= BLK_ZONE_WPLUG_NEED_WP_UPDATE | plugged;
 		spin_unlock_irqrestore(&zwplug->lock, flags);
 	}
 
-- 
2.56.0

