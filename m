Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620921;
	b=vBLptFXUwRmB8YYDMcQZy8sx8KuP13h3Xe2DBIQfhKiQiMsYFg5L3zoh+PfJikmYLfZ1
	 7vc6ARMHRPFtXSFywVOT6k2g50rmzYtL4ocpggHTmmADUSew7cFK1TUdbY1rUtZZdbctj
	 erNpS8Sr/TxEG5TIr+oh6F5WyKxW8HnuGMVMJZHC0WTNpHwQbCSuMw4gP5xf0aNAI5CNz
	 WBzIDNW2si3FUzQJ+ijupg+bbI13l3HhWyXzhy9iFP7DnXcXaOtllU8rjBTTU7wYwSzsU
	 sQvsV0d9sX1XpRKAmQaND8kRvEfSt+LPIuESIh65myw9jFa+f51SskJSo43GwaGwV+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jSktlNSabOFTde557bn7gPpS3UAsNJINOi7TnGKiOII=;
	b=P2LM4kfWCr5/rp7Y8YHVYdakOOUCATazcUt9DL74O0IXWLXl3TH/WUFBvwLg0wNLnKP5
	 WuajgpTN+mkMQNat/5F16/KP3+pdN9kGhrOQw+Ujjs+3bT0pCZoYOMB4c+XxmaNGt4BGS
	 wG8+3/HXx4eETK/St1zdUKJgcXOS1ewOk0b8ITE8o7B2++toLYmjrR/DO5dUwb9azpdxp
	 RkpjCnouBTMCzsHFlq1Ua4eVmLxM6fdZyRJnArd/WXFkr8VeAqQ2kebZzKDnuf3YJq9bx
	 puHv22xM6kiqthPvlgUD2cdd56R3xV2C4hYck7vC2sTy/2NqN1hH+spKoHYd7Zs606Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=jTnOku1r;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42581606A680
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 15:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42581606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=jTnOku1r
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-497614c95f0so3389456f8f.1
        for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 07:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795620919; x=1796225719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jSktlNSabOFTde557bn7gPpS3UAsNJINOi7TnGKiOII=;
        b=jTnOku1rqYjPBmJMkExy3mNracstRtRc4T9DMU8ty1uwM/bE3Yyb7moOO03owF7C+V
         OMx7WzBrNaYy2qGvMyTcZx99PmJGS35PEBF7mv8GlPCw5q8PvVBQxjciZfsXY+TveppN
         ElLmmGU+AKCT7ejLFufQnegmYjtJSQkw+5z9g4hfjeGLwnMATtzh59Tnsw4m7BvEGZ7F
         OIHy6I5OzKiLCmtjEg3tJmRT9rf2I2oyXz8udWgblWkqPImnHL+9E8IBWoimW9Q2kzEf
         OOtbqHAchqq0sX0e+lcmcbIh1CFX2yaqkwzJ5lxtFvZqbf53DOQANG30Kn4r9pxDWeZ0
         dGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620919; x=1796225719;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jSktlNSabOFTde557bn7gPpS3UAsNJINOi7TnGKiOII=;
        b=OxhE4vowS/kzVs4mbtzya3AFMLtskFwf7JQStrFy50OIe67OGcY2RsSra2D3ZcUSTf
         BCmJWnHm8vFIfp42q+WAmmvHiIVQw/6QH3ogY4xADBymiobAVd8PnBByDJ+k9+OrPuvg
         qD3DC6whsrQx5CkiNpOYuBnnnx+L9nTyW4HPzN2g7yDrsBcja1UjpPFm9wteOssIHxme
         bfn46sb8CPOg1WXLXmH8H34OiAVKa8CALyLFY/WvrsYAIeOyhoNc64zSLRNiwc5xD6SZ
         +u3Emvw9fWIf4h8lbhd8VV0iAWOS83J1sPuD8ugOt6kbgjGgPvoX741SFp5/Mud6yTXk
         peuQ==
X-Forwarded-Encrypted: i=1; AL+hErHdg+dBXI0wLKGnysOJ8htQEPSS0cB10urftU74/AIp6JyUAZusAmXq4e06zEJGlSk6UxpHG+MSy7Iv1A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9izoEPU8RDXVx+lUOnRwJWkqDigKg6N1ONaW3fGZFpf2rUA1D0
	BseZU233W+xUS2Ub3QwjHk7GhkdzaE9XyaoFtS02RplRKqzS+woPdUCD9d4wFlUwEws=
X-Gm-Gg: AZFdTZdGmG3hKbJi3cpkF54YqGTUAzMMB210Cxom8GEeYCruZcjOPCPTbMwgc5m299+
	ND4GuJY5nlsxnc9rgsy84WwG42tRKFULQPE5QHbhqBC1MkDK5cE6NfgJNvI2STxrld/AS96D3sE
	G/8Fisz7HKJt6RCxXGI6dow0j6/anrsOM06RXDGEl3MPQqvyUydzaAA8cSOUl0vlDwU0+URyRjg
	J+XmTWKHjkPy0lrvAI90w3jATFIuFehTwnB/kPG1X4/cSX7cYm0ABSOpH3qhtFAh3PCpwSqKOva
	cXvS4jY4uO+599cFnRycW//VFewtae6H+PMueZlShy+NpfsXxWvdMN2N7cOdUXrWtIhXeEP1wys
	DPtEnt/ci7tzvHCBRgPWrgXHimzTKrfDYUBGqNWRYMQEqFBfDRhCxoPKYomNLCYGYAHLBBgzCwq
	DxY1UTF7DZFnmCaqBvBGm3G1tts7UKXNeUqZZF3RUGsHabn6pRjI8NYSiOmlPwIeMRZ0PFm3ihc
	mhApoJXwDbdR9HPOQRQsrs9eC05n1k3r4CWyvJGdDVyDkd5kzzaZrwuZg0EBogQTnC4N0ocMsxr
	v1iwCDiH1G65zidZJHTB69yVkqJY1e7ROdiRKVs3z5DxD7KVggrv3b2PJibpDz1HWeEfi+kLGw=
	=
X-Received: by 2002:a05:6000:1863:b0:48d:b940:af7a with SMTP id ffacd0b85a97d-4abb665167bmr43936314f8f.55.1795620918663;
        Wed, 25 Nov 2026 07:35:18 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm35816275f8f.3.2026.11.25.07.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:35:18 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v4 03/21] drbd: introduce DRBD 9 on-disk metadata format
Date: Wed, 25 Nov 2026 16:34:53 +0100
Message-ID: <20261125153511.3060599-4-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125153511.3060599-1-christoph.boehmwalder@linbit.com>
References: <20261125153511.3060599-1-christoph.boehmwalder@linbit.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new header that captures the DRBD 9 on-disk metadata layout,
enabling state tracking for multiple peers.
It includes the per-device superblock and per-peer slot structures
needed to track bitmap UUIDs and sync state for each peer.

Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_meta_data.h | 163 ++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 drivers/block/drbd/drbd_meta_data.h

diff --git a/drivers/block/drbd/drbd_meta_data.h b/drivers/block/drbd/drbd_meta_data.h
new file mode 100644
index 000000000000..06014d8c84a7
--- /dev/null
+++ b/drivers/block/drbd/drbd_meta_data.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef DRBD_META_DATA_H
+#define DRBD_META_DATA_H
+
+#define be_u64 __be64
+#define be_s64 __be64
+#define be_u32 __be32
+#define be_s32 __be32
+#define be_u16 __be16
+
+/* how I came up with this magic?
+ * base64 decode "actlog==" ;)
+ */
+#define DRBD_AL_MAGIC 0x69cb65a2
+
+#define BM_BLOCK_SHIFT_4k	12			 /* 4k per bit */
+#define BM_BLOCK_SHIFT_MIN	BM_BLOCK_SHIFT_4k
+#define BM_BLOCK_SHIFT_MAX	20
+#define BM_BLOCK_SIZE_4k	4096
+#define BM_BLOCK_SIZE_MIN	(1<<BM_BLOCK_SHIFT_MIN)
+#define BM_BLOCK_SIZE_MAX	(1<<BM_BLOCK_SHIFT_MAX)
+
+struct peer_dev_md_on_disk_9 {
+	be_u64 bitmap_uuid;
+	be_u64 bitmap_dagtag;
+	be_u32 flags;
+	be_s32 bitmap_index;
+	be_u32 reserved_u32[2];
+} __packed;
+
+/* Changed block tracking: one bitmap slot, not owned by a peer, records every
+ * write to the backing device since the bookmark "id". Valid only with
+ * DRBD_MDFF_CBT in the features.
+ */
+struct cbt_bookmark_on_disk_9 {
+	be_u64 id;		/* the slot records changes since this bookmark */
+	be_u64 bitmap_uuid;	/* current UUID at cbt-start */
+	be_u64 bitmap_dagtag;	/* the Primary's dagtag at cbt-start */
+	be_s64 since;		/* time of cbt-start, seconds since the epoch */
+	be_u32 flags;		/* CBT_BOOKMARK_* */
+	be_s32 bitmap_index;
+} __packed;
+
+struct meta_data_on_disk_9 {
+	be_u64 effective_size;    /* last agreed size */
+	be_u64 current_uuid;
+	be_u64 members;		/* only if MDF_HAVE_MEMBERS_MASK is in the flags */
+	/* Feature flags. Values prefixed with "DRBD_MDFF".
+	 * Separate from "flags": Unknown features bits are cleared; unknown flags bits are kept.
+	 */
+	be_u64 features;
+	be_u64 reserved_u64[2];   /* to have the magic at the same position as in v07, and v08 */
+	be_u64 device_uuid;
+	be_u32 flags;             /* MDF */
+	be_u32 magic;
+	be_u32 md_size_sect;
+	be_u32 al_offset;         /* offset to this block */
+	be_u32 al_nr_extents;     /* important for restoring the AL */
+	be_u32 bm_offset;         /* offset to the bitmap, from here */
+	be_u32 bm_bytes_per_bit;  /* BM_BLOCK_SIZE */
+	be_u32 la_peer_max_bio_size;   /* last peer max_bio_size */
+	be_u32 bm_max_peers;
+	be_s32 node_id;
+
+	/* see al_tr_number_to_on_disk_sector() */
+	be_u32 al_stripes;
+	be_u32 al_stripe_size_4k;
+
+	be_u32 reserved_u32[2];
+
+	struct peer_dev_md_on_disk_9 peers[DRBD_PEERS_MAX];
+	be_u64 history_uuids[HISTORY_UUIDS];
+	struct cbt_bookmark_on_disk_9 cbt_bookmark;
+
+	unsigned char padding_start[0];
+	unsigned char padding_end[0] __attribute__((aligned(4096)));
+} __packed;
+
+/* Attention, these two are defined in drbd_int.h as well! */
+#define AL_UPDATES_PER_TRANSACTION 64
+#define AL_CONTEXT_PER_TRANSACTION 919
+
+enum al_transaction_types {
+	AL_TR_UPDATE = 0,
+	AL_TR_INITIALIZED = 0xffff
+};
+/* all fields on disc in big endian */
+struct __packed al_transaction_on_disk {
+	/* don't we all like magic */
+	be_u32	magic;
+
+	/* to identify the most recent transaction block
+	 * in the on disk ring buffer
+	 */
+	be_u32	tr_number;
+
+	/* checksum on the full 4k block, with this field set to 0. */
+	be_u32	crc32c;
+
+	/* type of transaction, special transaction types like:
+	 * purge-all, set-all-idle, set-all-active, ... to-be-defined
+	 * see also enum al_transaction_types
+	 */
+	be_u16	transaction_type;
+
+	/* we currently allow only a few thousand extents,
+	 * so 16bit will be enough for the slot number.
+	 */
+
+	/* how many updates in this transaction */
+	be_u16	n_updates;
+
+	/* maximum slot number, "al-extents" in drbd.conf speak.
+	 * Having this in each transaction should make reconfiguration
+	 * of that parameter easier.
+	 */
+	be_u16	context_size;
+
+	/* slot number the context starts with */
+	be_u16	context_start_slot_nr;
+
+	/* Some reserved bytes.  Expected usage is a 64bit counter of
+	 * sectors-written since device creation, and other data generation tag
+	 * supporting usage
+	 */
+	be_u32	__reserved[4];
+
+	/* --- 36 byte used --- */
+
+	/* Reserve space for up to AL_UPDATES_PER_TRANSACTION changes
+	 * in one transaction, then use the remaining byte in the 4k block for
+	 * context information.  "Flexible" number of updates per transaction
+	 * does not help, as we have to account for the case when all update
+	 * slots are used anyways, so it would only complicate code without
+	 * additional benefit.
+	 */
+	be_u16	update_slot_nr[AL_UPDATES_PER_TRANSACTION];
+
+	/* but the extent number is 32bit, which at an extent size of 4 MiB
+	 * allows to cover device sizes of up to 2**54 Byte (16 PiB)
+	 */
+	be_u32	update_extent_nr[AL_UPDATES_PER_TRANSACTION];
+
+	/* --- 420 bytes used (36 + 64*6) --- */
+
+	/* 4096 - 420 = 3676 = 919 * 4 */
+	be_u32	context[AL_CONTEXT_PER_TRANSACTION];
+};
+
+#define DRBD_AL_PMEM_MAGIC 0x6aa667a6 /* "al==pmem" */
+
+struct __packed al_on_pmem {
+	be_u32 magic;
+	be_u32 slots[];
+};
+
+#undef be_u64
+#undef be_s64
+#undef be_u32
+#undef be_s32
+#undef be_u16
+
+#endif
-- 
2.56.0

