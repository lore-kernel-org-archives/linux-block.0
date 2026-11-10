Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328022;
	b=CtAQ6TQYRuihnZ8wqHAfW6wm/bCAowcLg04eekejCyQbrqI4z0Mpga8cYAH79SbDW856
	 F9zhem6z4orl99XH9rNwBENhb7g4jd9Ox4F7mGolPP0F26yfUmLp7abjG9JZWw7cvIMbi
	 TiMImqulG0KC2roLCDZDbg8qa/2KRCsBputJmVq4mDFoxBQhaXcE92hvBZRA2ZdxcXy9m
	 9y6lVp3G7T5T3o4EhjbUzX5ZGgKxkcmLifqo3b5Nw0D4APbQhpCyzOqEK5MQ1xlsvcJ8x
	 JXTDOH7zLvK1m40ammckfQ74UBeh5W9YnUbdTSJWTuwIHO+DVzbez/KNkCramwYRiug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DL3SGkmXNuX/inqHhwZXtYBUYPDB00j/1t9SWY3OyLk=;
	b=pjqqERZhoXk98cjv3ahqZOczz/+A1ASybGxPleeggBpL5mItl/S7Nyqi/CUMUCd1GidB
	 Tn8k/vfU6HoVYKTkmLKzTC0S/tne+VUmBvfazN5Pg3/lhCJORPRSFqNc0tJtd4buy4vHY
	 J5KjAK4/XbqysIfPfchCozsvSZSqAJBLDl/sqsQUoc76xcR8bhBYRMKcoOxnsFtaILl+y
	 huDjKtxf2sk9KgenmNDePL4WTKzE9UX/569NVEx6oC4QdJGB/Nais5QKh9zFvTRLpRDKp
	 hxkYzLLxPFPv2i42CXcHz3ThDZEy0rN1OB774xUsXpsmwn0e8caP4+0QF5q5TN3hg4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b="Y/XKMFZx";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D69606D7E5
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 16:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8D69606D7E5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=Y/XKMFZx
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so22442285e9.3
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 08:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1794328020; x=1794932820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DL3SGkmXNuX/inqHhwZXtYBUYPDB00j/1t9SWY3OyLk=;
        b=Y/XKMFZxqsGScS2hc4M3SVkWmL06+cQABu7mtHP8tAfOjoSqPy8FM3yd53wh3llS6R
         jqXTtOwi5BqvbBDcODXk6lZns99x5v5fRRf9nMSlkuknRSdUd54FNuHk/FJwT8aMPCW3
         3tAkn/jmdrJ0FH8YbD7rnQUXXPlDOV/e5QfXuLvud3lnOY9kCS8rYEExMGxFCIAtetDl
         pDNjF4imJS2IdPr2Ana2Hrh+OyocMjUNqm1UAxJe/e0mu58dgIQoUgXKJN13Dz6wBZIp
         O6qoR0RR6llLRtCtIWuTyfJXLL/ePPyvtkSa0NKudmpUI/9JphjHrKpFoibtVBDNJvZx
         7qKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328020; x=1794932820;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DL3SGkmXNuX/inqHhwZXtYBUYPDB00j/1t9SWY3OyLk=;
        b=bQ4ATmJlXEKjimu5LD48FyLAZadJsZ4dWY+i9swwAKY1iyULhDnrZISCPsg+Ntz9OU
         IovGL9ucFbHstLngfaBHWW/pd/Y5jfxaPc7MHKPmjuZTSPh9xmQqwHeHN/RIFsmIu+SP
         RUYx93/7xbMzgQjid3pbOI5QwbJmnjZ/+xjNeL2N2FqHQPvHnLxG1eCZ3itakpaC/PQC
         EHaUyZYZ/BMi6SN875HorRDF793yKhrdZdqvRlIJF7RHTW2PRYOZMQ7uPz2zsId0Fxjg
         xSDq1EX6QqBC7IdG4ghmDblZjN83O63CwZGRMBVzBBtP4HlJ4LqGwiCKGKEx70YCsfLE
         +NBw==
X-Forwarded-Encrypted: i=1; AL+hErFcfU0EvAJlOlLm02l0hlrfa7kZvLKqyTFeYgD6EFyGr7eddUOu4k4nczIgi+NObLmRH1yOYYxummKoGA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9A4RH1iDq7N5R+0uyPP40cFfKltwCWyLH/id8157xeqSKi9tNY
	FAImDmY83XUOqIRAGPtemW1BS7mtSaeUxRWTcwHSs16S0j3TkyOOaXr0T2iVTpv2Nvw=
X-Gm-Gg: AYBFou1c2/SNOMxOG0PYgdbCupyZGdvvQaC3aVhL4QeoO7kaujcDofMVncjn2UthE5l
	5AoPfhhCi+OZjGCft8WRxEDQaTFBedNT9cbrsmFZtRyBFZs0xSI9jpWXm5cN1H0Gf2V2UJUdcYY
	xoeZWPqSobmV+pcgrbZxcOL1MAhrn82I3XFrOduQHhcYYIc9fYWCEXdDG/znjXSjZ+hwN6mPTt6
	ShGeZiOxVG2Ki/EYDWw9sWHV5ogoyL0qHrXvMU7woFmqZV1HOQKhDqqv3enLVqFTXnzUTHxn4Ns
	MdSfcNB4OibRTTRvPcEpEq5IVubiUgAWhaaiJ6Y/iQKlzBwG6QJWgaVwoqFdznRvKMIMR0V3VAS
	c6IHM9MloVW7LwiTK0aayPcRCK5jWdzSvbPv8JvilKI1R6eYE8I+4OqMSeQtO5YFLyziBvGbkhB
	xa4oGad+1YlBOmMEn0xDBSVNNb5ncQnvYtrSaHU85y5Fwh0qU2s/jCM5wnGXUjRRrR7q7aCHcYB
	qLuuI+RjbOZFRVVyXnXUeq8dLN99UkN9NdtxUCeuOTAcsrhtdSsloPCPZe4W5T3hKPuiAp/JU0b
	XfsGxLjJ588HOIOMMW1UpFZiFbgaH95Q8PeN8ythA3EpSHhxgHv6f69y2rPlH9aP7Lxqk3HAyw=
	=
X-Received: by 2002:a05:600c:350c:b0:4a1:6517:ccf1 with SMTP id 5b1f17b1804b1-4ba0233ea4fmr53015075e9.9.1794328020191;
        Tue, 10 Nov 2026 08:27:00 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02345d22sm85050695e9.1.2026.11.10.08.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:26:59 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v3 03/20] drbd: introduce DRBD 9 on-disk metadata format
Date: Tue, 10 Nov 2026 17:26:28 +0100
Message-ID: <20261110162646.3028472-4-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110162646.3028472-1-christoph.boehmwalder@linbit.com>
References: <20261110162646.3028472-1-christoph.boehmwalder@linbit.com>
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
 drivers/block/drbd/drbd_meta_data.h | 170 ++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100644 drivers/block/drbd/drbd_meta_data.h

diff --git a/drivers/block/drbd/drbd_meta_data.h b/drivers/block/drbd/drbd_meta_data.h
new file mode 100644
index 000000000000..400803267c83
--- /dev/null
+++ b/drivers/block/drbd/drbd_meta_data.h
@@ -0,0 +1,170 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef DRBD_META_DATA_H
+#define DRBD_META_DATA_H
+
+#ifdef __KERNEL__
+#define be_u64 __be64
+#define be_s64 __be64
+#define be_u32 __be32
+#define be_s32 __be32
+#define be_u16 __be16
+#else
+#define be_u64 struct { uint64_t be; }
+#define be_s64 struct { int64_t be; }
+#define be_u32 struct { uint32_t be; }
+#define be_s32 struct { int32_t be; }
+#define be_u16 struct { uint16_t be; }
+#endif
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
+#undef be_u32
+#undef be_s32
+#undef be_u16
+
+#endif
-- 
2.56.0

