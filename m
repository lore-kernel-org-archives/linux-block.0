Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328022;
	b=buOSoYnXlJdE2iOE9ARteAHvgi/mU3IGIoKE6y6e06SOCpIxuKGCTmcJ4xK05jQLx61h
	 O++w94Z6j13wSuChJ6YgUfmlTnPDSP9+sWKtOrcAhIyaEx1+zpNmePStNVG64+FTyfKV/
	 N/H0sf7SC+7stj5tPG5ogxpZM/I+jGlwphgewGzMYJARxh4Xky/+JKEMYKq0s0vkii8aG
	 A0YNETkVH+D+qcpY9csCEXPjBzZdRYTTsIUIatMW1FYeqPp8jiAIHUr43GW7zKALokUCa
	 pU/LIwe2RhrkpNYPtTJqmWGCh2SI06peWCTWH20m4/qdbAa9FzVl0PSqOYD1xweS0aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=t281WVkaqfCCUVAtCy3n2fzat3mk/Qbr2YwW8bAhiDA=;
	b=bejSuo9pUJMnpsxTyvaI5M//KL4IRS8a/YV62KRQ16FFIfSpZS1ST5kOdjKoQRjbZIr8
	 79VmcheqGO/PKKiyJZ/5RpJsafID2dBK5JJtVx38+5c2GbvUJJBK+a0PzqqElR83GRvhR
	 8/XRKfXBdMP4e4kQjY9NrMKRomTIrMI2RJDI5qEB0fkjQcS8OegXb0AFRKDrC8gfn7UQn
	 st+386CKm6TXLSupiYoteLE4SWo6ADHozG2dYn5YZl06Sw0WTw1IvviG1CbMgjrAPRFEJ
	 i/2mMBw3/gWde6XfBdrJJacKjrr1vlQF5BKX7ml1qA6d94sBdUwvG7OpfzSrNi0bqEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b="W/kVOnwi";
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB397606D7D4
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 16:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB397606D7D4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=W/kVOnwi
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so20223805e9.1
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 08:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1794328019; x=1794932819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t281WVkaqfCCUVAtCy3n2fzat3mk/Qbr2YwW8bAhiDA=;
        b=W/kVOnwi2954YhYnqZtsc7+o2TSaeSx8hyqfydN9I/VQp65VOC4I55IO8oXCczH3J1
         5bnNL+99tL7wmcB+mZoj3vSa1Ot8cb63/9U/9jVrqVhyEzeL1qJ1j+G7t3KBrTHicTPM
         5E61Ntp5tud7l32fwFWqndDXbfKhmLJ8AeeZ0Tf+dQOu/vjSWjZCudHGK2Xl3orR1Y/e
         EnAXaxCU+w/+/O9OE5rkLAXC2tSSm58n/9cJ+4dUZIkdES4BWDnSenrGjh+Gn/M+lnEf
         OTFmX9+HYceYFdoyqtKup5pyX6yNLlEaAs9aZqQC3pHwQCaVBf6cVIpMYB/aJ/ndzkcO
         UT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328019; x=1794932819;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t281WVkaqfCCUVAtCy3n2fzat3mk/Qbr2YwW8bAhiDA=;
        b=w5HdqoOJAkJ2bnFz3xrKyJnL5HBOfw+SHvlPwIawjarKA/sDsA1NjAlf/KJyiYgqHt
         EXM2fMrzCrtYA01GTQjG/61yeBdPh0cNCvL+HxruJZRqr+CbNUEAULWo3KOBjtcswGqz
         +zCdutrdUquj9Ndza8W5fvoCbWlfcPme/e5ID9MyVlBveFp06MXSjoLcCrspyzL6s8fd
         PQIO2Pymduiw2/7ixQVdw3O/pLE3VIPZYTXeTeTFw0/JRmQHU/cGqTsAqKpYP1u0AECG
         hnuUOhRUpb8dvs20h64DW9Fl2Us7PJa5946o3B0eodK1rC/1/qmQwV948JkJwkRAgIXS
         hawg==
X-Forwarded-Encrypted: i=1; AL+hErFKTqQ4lBBFmIAxxF61MxyLk4Qh0PSjy5H3NiXdH+RwM1mAXPBoEYAXyPkqba/o13ioBAw+6ftveas/NQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Vjtee6PtJHShVK71/zkXSvv3F5jdXlUfkI6EFyGMntXEcA7Gv
	GZwyP0soXXbCWSdlKulQLGgYLhww+myX9GGx2Tg0Zbeo8PIycAK5N4vC11vWLvdd3l4=
X-Gm-Gg: AYBFou3PgRk3iCDlDQskKFRCwNLpbK21P75ng3bk+24aGmw7+9de7YUw5FLaQjnakPQ
	+u+Y56BPwOb6RV2hjwqV4Gll19Swvbmxd7h0z3f1/cKXSX6coqnglnngKziPrnVKkM6mL4sJ4UT
	vkmJwEviUiU3Ozea8YuDcdPZkV4/BxWQa/f9EEFGMMNxFWkmip4lphjelhF2MwfPVCuNkDClF/b
	XPm+Jd2UyQ7UlSpLQqDlDk4RqY3coX/QdX9nQwyFtcQ5yvjkGchjpMMfKLzmFQt1PuejfQu7/LI
	QiRokE/j4MscjSJyfqdbH+ELwQaa4USceWHcBaZWJ1HMG5ENwCaemNtSzgxqKLIYTDFlI5ebQpS
	W4CbH7viiPcN4ff7prS+VTwEiLUkiH4oEHq/t83WlxjjAXwCTYNxJwi03GnTEEO/h10eLVZkmN8
	q2hZjaGuWE60nPrDCQBrCG2As7A3VjZMZEeFhUCYbpv3F+xxOuHDzy3p6oqzsqeGy7Zlnk7f+Zn
	GAOGU/SCwnPlR9Lx5z/w9ZWsXEpzhD5VU2hPNpB4xAW/1XSFt8DZAQd4OyNl3+uRVXI9n/e7lQP
	H2MVCSbJ41wIfIFSnoBh8UYs2Z3odEtFONFOalHmiumhtNsisXYZAWu5DxejU1dNWMiV5l7IXA=
	=
X-Received: by 2002:a05:600c:a011:b0:4ab:cc03:7f60 with SMTP id 5b1f17b1804b1-4ba02344e51mr50467195e9.18.1794328018973;
        Tue, 10 Nov 2026 08:26:58 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02345d22sm85050695e9.1.2026.11.10.08.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:26:58 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Andreas Gruenbacher <agruen@linbit.com>,
	Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH v3 02/20] drbd: extend wire protocol definitions for DRBD 9
Date: Tue, 10 Nov 2026 17:26:27 +0100
Message-ID: <20261110162646.3028472-3-christoph.boehmwalder@linbit.com>
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

Extend drbd_protocol.h with the packet types and structures needed for
multi-peer operation.

Two-phase commit (2PC) messages coordinate distributed state changes
across all peers in a cluster.
Data-generation-tag (dagtag) messages order application writes relative
to resync IO, preventing stale overwrites during concurrent resync.
Peer-acknowledgement packets carry a node bitmask so each primary can
track which peers have persisted a write.

The connection-features handshake now carries sender and receiver node
IDs, establishing peer identity at the wire level.
New feature-flag bits advertise these capabilities during negotiation,
allowing DRBD to remain wire-compatible with 8.4 peers while enabling
the full DRBD 9 feature set when both ends support it.

Co-developed-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Co-developed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
Co-developed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_protocol.h | 614 +++++++++++++++++++++++------
 1 file changed, 484 insertions(+), 130 deletions(-)

diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
index be7dacac5a86..6c845f4934da 100644
--- a/drivers/block/drbd/drbd_protocol.h
+++ b/drivers/block/drbd/drbd_protocol.h
@@ -6,6 +6,17 @@
 #ifndef __DRBD_PROTOCOL_H
 #define __DRBD_PROTOCOL_H
 
+#ifdef __KERNEL__
+#include <linux/types.h>
+#else
+#include <stdint.h>
+#define u64 uint64_t
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#endif
+#endif
+#include <linux/drbd.h>
+
 enum drbd_packet {
 	/* receiver (data socket) */
 	P_DATA		      = 0x00,
@@ -28,12 +39,12 @@ enum drbd_packet {
 	P_AUTH_RESPONSE	      = 0x11,
 	P_STATE_CHG_REQ	      = 0x12,
 
-	/* (meta socket) */
+	/* asender (meta socket */
 	P_PING		      = 0x13,
 	P_PING_ACK	      = 0x14,
 	P_RECV_ACK	      = 0x15, /* Used in protocol B */
 	P_WRITE_ACK	      = 0x16, /* Used in protocol C */
-	P_RS_WRITE_ACK	      = 0x17, /* Is a P_WRITE_ACK, additionally call set_in_sync(). */
+	P_RS_WRITE_ACK	      = 0x17, /* Write ack for resync reply. */
 	P_SUPERSEDED	      = 0x18, /* Used in proto C, two-primaries conflict detection */
 	P_NEG_ACK	      = 0x19, /* Sent if local disk is unusable */
 	P_NEG_DREPLY	      = 0x1a, /* Local disk is broken... */
@@ -45,7 +56,7 @@ enum drbd_packet {
 
 	P_OV_REQUEST	      = 0x1e, /* data socket */
 	P_OV_REPLY	      = 0x1f,
-	P_OV_RESULT	      = 0x20, /* meta socket */
+	P_OV_RESULT	      = 0x20, /* meta sock: Protocol < 122 version of P_OV_RESULT_ID */
 	P_CSUM_RS_REQUEST     = 0x21, /* data socket */
 	P_RS_IS_IN_SYNC	      = 0x22, /* meta socket */
 	P_SYNC_PARAM89	      = 0x23, /* data socket, protocol version 89 replacement for P_SYNC_PARAM */
@@ -55,32 +66,84 @@ enum drbd_packet {
 	P_DELAY_PROBE         = 0x27, /* is used on BOTH sockets */
 	P_OUT_OF_SYNC         = 0x28, /* Mark as out of sync (Outrunning), data socket */
 	P_RS_CANCEL           = 0x29, /* meta: Used to cancel RS_DATA_REQUEST packet by SyncSource */
-	P_CONN_ST_CHG_REQ     = 0x2a, /* data sock: Connection wide state request */
-	P_CONN_ST_CHG_REPLY   = 0x2b, /* meta sock: Connection side state req reply */
-	P_RETRY_WRITE	      = 0x2c, /* Protocol C: retry conflicting write request */
+	P_CONN_ST_CHG_REQ     = 0x2a, /* data sock: state change request */
+	P_CONN_ST_CHG_REPLY   = 0x2b, /* meta sock: state change reply */
+	P_RETRY_WRITE	      = 0x2c, /* meta sock: Protocol C: peer did not process this write, retry it.
+				       * Was the 8.4 two-primaries conflict retry; reused, gated by
+				       * DRBD_FF_WRITE_POSTPONE, as the answer to a write a sync
+				       * target can not secure toward its sync source. */
 	P_PROTOCOL_UPDATE     = 0x2d, /* data sock: is used in established connections */
-        /* 0x2e to 0x30 reserved, used in drbd 9 */
+	P_TWOPC_PREPARE       = 0x2e, /* data sock: prepare state change */
+	P_TWOPC_ABORT         = 0x2f, /* data sock: abort state change */
 
-	/* REQ_OP_DISCARD. We used "discard" in different contexts before,
-	 * which is why I chose TRIM here, to disambiguate. */
+	P_DAGTAG	      = 0x30, /* data sock: set the current dagtag */
+
+	/*
+	 * REQ_DISCARD. We used "discard" in different contexts before,
+	 * which is why I chose TRIM here, to disambiguate.
+	 */
 	P_TRIM                = 0x31,
 
 	/* Only use these two if both support FF_THIN_RESYNC */
 	P_RS_THIN_REQ         = 0x32, /* Request a block for resync or reply P_RS_DEALLOCATED */
-	P_RS_DEALLOCATED      = 0x33, /* Contains only zeros on sync source node */
+	P_RS_DEALLOCATED      = 0x33, /* Protocol < 122 version of P_RS_DEALLOCATED_ID */
 
-	/* REQ_WRITE_SAME.
+	/*
+	 * REQ_WRITE_SAME.
 	 * On a receiving side without REQ_WRITE_SAME,
-	 * we may fall back to an opencoded loop instead. */
+	 * we may fall back to an opencoded loop instead.
+	 */
 	P_WSAME               = 0x34,
-
-	/* 0x35 already claimed in DRBD 9 */
+	P_TWOPC_PREP_RSZ      = 0x35, /* PREPARE a 2PC resize operation*/
 	P_ZEROES              = 0x36, /* data sock: zero-out, WRITE_ZEROES */
 
-	/* 0x40 .. 0x48 already claimed in DRBD 9 */
+	/*
+	 * place new packets for both 8.4 and 9 here,
+	 * place new packets for 9-only in the next gap.
+	 */
+
+	P_PEER_ACK            = 0x40, /* meta sock: tell which nodes have acked a request */
+	P_PEERS_IN_SYNC       = 0x41, /* data sock: Mark area as in sync */
+
+	P_UUIDS110	      = 0x42, /* data socket */
+	P_PEER_DAGTAG         = 0x43, /* data socket, used to trigger reconciliation resync */
+	P_CURRENT_UUID	      = 0x44, /* data socket */
+
+	P_TWOPC_YES           = 0x45, /* meta sock: allow two-phase commit */
+	P_TWOPC_NO            = 0x46, /* meta sock: reject two-phase commit */
+	P_TWOPC_COMMIT        = 0x47, /* data sock: commit state change */
+	P_TWOPC_RETRY         = 0x48, /* meta sock: retry two-phase commit */
+
+	P_CONFIRM_STABLE      = 0x49, /* meta sock: similar to an unsolicited partial barrier ack */
+	/* protocol version 115,
+	 * meta: cancel RS_DATA_REQUEST packet if already Ahead again,
+	 *       tell peer to stop sending resync requests...
+	 */
+	P_RS_CANCEL_AHEAD     = 0x4a,
+	P_DISCONNECT          = 0x4b, /* data sock: Disconnect and stop connection attempts */
+
+	P_RS_DAGTAG_REQ       = 0x4c, /* data sock: Request a block for resync, with dagtag dependency */
+	P_RS_CSUM_DAGTAG_REQ  = 0x4d, /* data sock: Request a block for resync if checksum differs, with dagtag dependency */
+	P_RS_THIN_DAGTAG_REQ  = 0x4e, /* data sock: Request a block for resync or reply P_RS_DEALLOCATED, with dagtag dependency */
+	P_OV_DAGTAG_REQ       = 0x4f, /* data sock: Request a checksum for online verify, with dagtag dependency */
+	P_OV_DAGTAG_REPLY     = 0x50, /* data sock: Reply with a checksum for online verify, with dagtag dependency */
+
+	P_WRITE_ACK_IN_SYNC   = 0x51, /* meta sock: Application write ack setting bits in sync. */
+	P_RS_NEG_ACK          = 0x52, /* meta sock: Local disk is unusable writing resync reply. */
+	P_OV_RESULT_ID        = 0x53, /* meta sock: Online verify result with block ID. */
+	P_RS_DEALLOCATED_ID   = 0x54, /* data sock: Contains only zeros on sync source node. */
+
+	P_FLUSH_REQUESTS      = 0x55, /* data sock: Flush prior requests then send ack and/or forward */
+	P_FLUSH_FORWARD       = 0x56, /* meta sock: Send ack after sending P_OUT_OF_SYNC for prior P_PEER_ACK */
+	P_FLUSH_REQUESTS_ACK  = 0x57, /* data sock: Response to initiator of P_FLUSH_REQUESTS */
+	P_ENABLE_REPLICATION_NEXT = 0x58, /* data sock: whether to start replication on next resync start */
+	P_ENABLE_REPLICATION  = 0x59, /* data sock: enable or disable replication during resync */
+
+	P_RS_DAGTAG_WAIT_REQ  = 0x5a, /* data sock: Wait for the dagtag dependency only, answer without data */
+	P_RS_DAGTAG_REACHED   = 0x5b, /* meta sock: The dagtag dependency of this request is reached. */
+	P_RS_DAGTAG_UNREACHABLE = 0x5c, /* meta sock: Can not reach the dagtag this request depends on. */
 
 	P_MAY_IGNORE	      = 0x100, /* Flag to test if (cmd > P_MAY_IGNORE) ... */
-	P_MAX_OPT_CMD	      = 0x101,
 
 	/* special command ids for handshake */
 
@@ -105,24 +168,24 @@ enum drbd_packet {
  * regardless of 32 or 64 bit arch!
  */
 struct p_header80 {
-	u32	  magic;
-	u16	  command;
-	u16	  length;	/* bytes of data after this header */
+	uint32_t magic;
+	uint16_t command;
+	uint16_t length;	/* bytes of data after this header */
 } __packed;
 
 /* Header for big packets, Used for data packets exceeding 64kB */
 struct p_header95 {
-	u16	  magic;	/* use DRBD_MAGIC_BIG here */
-	u16	  command;
-	u32	  length;
+	uint16_t magic;	/* use DRBD_MAGIC_BIG here */
+	uint16_t command;
+	uint32_t length;
 } __packed;
 
 struct p_header100 {
-	u32	  magic;
-	u16	  volume;
-	u16	  command;
-	u32	  length;
-	u32	  pad;
+	uint32_t magic;
+	uint16_t volume;
+	uint16_t command;
+	uint32_t length;
+	uint32_t pad;
 } __packed;
 
 /* These defines must not be changed without changing the protocol version.
@@ -132,10 +195,10 @@ struct p_header100 {
 #define DP_HARDBARRIER	      1 /* no longer used */
 #define DP_RW_SYNC	      2 /* equals REQ_SYNC    */
 #define DP_MAY_SET_IN_SYNC    4
-#define DP_UNPLUG             8 /* not used anymore   */
+#define DP_UNPLUG             8 /* equals REQ_UNPLUG (compat) */
 #define DP_FUA               16 /* equals REQ_FUA     */
 #define DP_FLUSH             32 /* equals REQ_PREFLUSH   */
-#define DP_DISCARD           64 /* equals REQ_OP_DISCARD */
+#define DP_DISCARD           64 /* equals REQ_DISCARD */
 #define DP_SEND_RECEIVE_ACK 128 /* This is a proto B write request */
 #define DP_SEND_WRITE_ACK   256 /* This is a proto C write request */
 #define DP_WSAME            512 /* equiv. REQ_WRITE_SAME */
@@ -147,58 +210,114 @@ struct p_header100 {
  */
 
 struct p_data {
-	u64	    sector;    /* 64 bits sector number */
-	u64	    block_id;  /* to identify the request in protocol B&C */
-	u32	    seq_num;
-	u32	    dp_flags;
+	uint64_t sector;    /* 64 bits sector number */
+	uint64_t block_id;  /* to identify the request in protocol B&C */
+	uint32_t seq_num;
+	uint32_t dp_flags;
 } __packed;
 
 struct p_trim {
 	struct p_data p_data;
-	u32	    size;	/* == bio->bi_size */
+	uint32_t size;	/* == bio->bi_size */
 } __packed;
 
 struct p_wsame {
 	struct p_data p_data;
-	u32           size;     /* == bio->bi_size */
+	uint32_t size;     /* == bio->bi_size */
 } __packed;
 
 /*
- * commands which share a struct:
- *  p_block_ack:
- *   P_RECV_ACK (proto B), P_WRITE_ACK (proto C),
+ * struct p_block_ack shared by commands:
+ *   P_RECV_ACK (proto B)
+ *   P_WRITE_ACK (proto C),
+ *   P_WRITE_ACK_IN_SYNC,
  *   P_SUPERSEDED (proto C, two-primaries conflict detection)
- *  p_block_req:
- *   P_DATA_REQUEST, P_RS_DATA_REQUEST
+ *   P_RS_WRITE_ACK
+ *   P_NEG_ACK
+ *   P_NEG_DREPLY
+ *   P_NEG_RS_DREPLY
+ *   P_RS_NEG_ACK
+ *   P_OV_RESULT
+ *   P_RS_IS_IN_SYNC
+ *   P_RS_CANCEL
+ *   P_RS_DEALLOCATED_ID
+ *   P_RS_CANCEL_AHEAD
+ *   P_RS_DAGTAG_REACHED
+ *   P_RS_DAGTAG_UNREACHABLE
  */
 struct p_block_ack {
-	u64	    sector;
-	u64	    block_id;
-	u32	    blksize;
-	u32	    seq_num;
+	uint64_t sector;
+	uint64_t block_id;
+	uint32_t blksize;
+	uint32_t seq_num;
+} __packed;
+
+/* For P_OV_RESULT_ID. */
+struct p_ov_result {
+	uint64_t sector;
+	uint64_t block_id;
+	uint32_t blksize;
+	uint32_t seq_num;
+	uint32_t result;
+	uint32_t pad;
 } __packed;
 
+enum ov_result {
+	OV_RESULT_SKIP = 0,
+	OV_RESULT_IN_SYNC = 1,
+	OV_RESULT_OUT_OF_SYNC = 2,
+};
+
+struct p_block_req_common {
+	uint64_t sector;
+	uint64_t block_id;
+	uint32_t blksize;
+} __packed;
+
+/*
+ * struct p_block_req shared by commands:
+ *   P_DATA_REQUEST
+ *   P_RS_DATA_REQUEST
+ *   P_OV_REQUEST
+ *   P_OV_REPLY
+ *   P_CSUM_RS_REQUEST
+ *   P_RS_THIN_REQ
+ */
 struct p_block_req {
-	u64 sector;
-	u64 block_id;
-	u32 blksize;
-	u32 pad;	/* to multiple of 8 Byte */
+	/* Allow fields to be addressed directly or via req_common. */
+	union {
+		struct {
+			uint64_t sector;
+			uint64_t block_id;
+			uint32_t blksize;
+		} __packed;
+		struct p_block_req_common req_common;
+	};
+	uint32_t pad;	/* to multiple of 8 Byte */
 } __packed;
 
 /*
- * commands with their own struct for additional fields:
- *   P_CONNECTION_FEATURES
- *   P_BARRIER
- *   P_BARRIER_ACK
- *   P_SYNC_PARAM
- *   ReportParams
+ * struct p_rs_req shared by commands:
+ *   P_RS_DAGTAG_REQ
+ *   P_RS_CSUM_DAGTAG_REQ
+ *   P_RS_THIN_DAGTAG_REQ
+ *   P_OV_DAGTAG_REQ
+ *   P_OV_DAGTAG_REPLY
+ *   P_RS_DAGTAG_WAIT_REQ
  */
+struct p_rs_req {
+	struct p_block_req_common req_common;
+	uint32_t dagtag_node_id;
+	uint64_t dagtag;
+} __packed;
 
 /* supports TRIM/DISCARD on the "wire" protocol */
 #define DRBD_FF_TRIM 1
 
-/* Detect all-zeros during resync, and rather TRIM/UNMAP/DISCARD those blocks
- * instead of fully allocate a supposedly thin volume on initial resync */
+/*
+ * Detect all-zeros during resync, and rather TRIM/UNMAP/DISCARD those blocks
+ * instead of fully allocate a supposedly thin volume on initial resync
+ */
 #define DRBD_FF_THIN_RESYNC 2
 
 /* supports REQ_WRITE_SAME on the "wire" protocol.
@@ -247,54 +366,117 @@ struct p_block_req {
  */
 #define DRBD_FF_WZEROES 8
 
+/* Supports synchronization of application and resync IO using data generation
+ * tags (dagtags). See Documentation/application-resync-synchronization.rst for
+ * details.
+ */
+#define DRBD_FF_RESYNC_DAGTAG 16
+
+/* V2 of p_twopc_request has a 32 bit flag field and the two fields for node
+ * Ids are reduced to 8 bit instead of 32 bits.
+ *
+ * The flag TWOPC_HAS_RECHABLE indicates that in the commit phase
+ * (P_TWOPC_COMMIT) the reachable_nodes mask is set.
+ *
+ * The old behavior sends the primary_nodes mask, mask, and val in
+ * phase 2 (P_TWOPC_COMMIT), where mask and val are the same values as
+ * in phase 1 (P_TWOPC_PREPARE).
+ */
+#define DRBD_FF_2PC_V2 32
+
+/* Starting with drbd-9.1.15, a node with a backing disk sends the new
+ * current-uuid also to diskless nodes when the initial resync is
+ * skipped.
+ *
+ * The peer needs to know about this detail to apply the necessary
+ * strictness regarding downgrading its view of the partner's disk
+ * state.
+ */
+#define DRBD_FF_RS_SKIP_UUID 64
+
+/* Support for resync_without_replication.
+ */
+#define DRBD_FF_RESYNC_WITHOUT_REPLICATION 128
+
+/* Support for bitmap block size != 4k. If you connect peers with
+ * different bitmap block sizes, the resync becomes more
+ * interesting, and we need to communicate the bitmap block size.
+ */
+#define DRBD_FF_BM_BLOCK_SHIFT 256
+
+/* Starting with drbd-9.2.19 a new kind of reconciliation resync
+ */
+#define DRBD_FF_RECONCILE_RECONNECT 512
+
+/* A sync target that received a write in a range the sync source is still to
+ * resync does not acknowledge it before the source holds that write too: it
+ * asks with P_RS_DAGTAG_WAIT_REQ, naming the write's position in the writer's
+ * stream, and the source answers P_RS_DAGTAG_REACHED once its copy of that
+ * stream has reached the position, or P_RS_DAGTAG_UNREACHABLE when it has
+ * lost the writer. In the unreachable case the target answers the writer
+ * P_RETRY_WRITE: the write counts as not processed, and the writer retries
+ * it once the cluster can order it again.
+ *
+ * Advertised by every node that answers dagtag wait requests, serves a resync
+ * to a target that secures its writes, sends the postpone answer, and retries
+ * a postponed write.
+ */
+#define DRBD_FF_WRITE_POSTPONE 1024
 
 struct p_connection_features {
-	u32 protocol_min;
-	u32 feature_flags;
-	u32 protocol_max;
+	uint32_t protocol_min;
+	uint32_t feature_flags;
+	uint32_t protocol_max;
+	uint32_t sender_node_id;
+	uint32_t receiver_node_id;
 
 	/* should be more than enough for future enhancements
 	 * for now, feature_flags and the reserved array shall be zero.
 	 */
 
-	u32 _pad;
-	u64 reserved[7];
+	uint32_t _pad;
+	uint64_t reserved[6];
 } __packed;
 
 struct p_barrier {
-	u32 barrier;	/* barrier number _handle_ only */
-	u32 pad;	/* to multiple of 8 Byte */
+	uint32_t barrier;	/* barrier number _handle_ only */
+	uint32_t pad;	/* to multiple of 8 Byte */
 } __packed;
 
 struct p_barrier_ack {
-	u32 barrier;
-	u32 set_size;
+	uint32_t barrier;
+	uint32_t set_size;
+} __packed;
+
+struct p_confirm_stable {
+	uint64_t oldest_block_id;
+	uint64_t youngest_block_id;
+	uint32_t set_size;
+	uint32_t pad; /* to multiple of 8 Byte */
 } __packed;
 
 struct p_rs_param {
-	u32 resync_rate;
+	uint32_t resync_rate;
 
 	      /* Since protocol version 88 and higher. */
 	char verify_alg[];
 } __packed;
 
 struct p_rs_param_89 {
-	u32 resync_rate;
+	uint32_t resync_rate;
 	/* protocol version 89: */
 	char verify_alg[SHARED_SECRET_MAX];
 	char csums_alg[SHARED_SECRET_MAX];
 } __packed;
 
 struct p_rs_param_95 {
-	u32 resync_rate;
-	struct_group(algs,
-		char verify_alg[SHARED_SECRET_MAX];
-		char csums_alg[SHARED_SECRET_MAX];
-	);
-	u32 c_plan_ahead;
-	u32 c_delay_target;
-	u32 c_fill_target;
-	u32 c_max_rate;
+	uint32_t resync_rate;
+	char verify_alg[SHARED_SECRET_MAX];
+	char csums_alg[SHARED_SECRET_MAX];
+	uint32_t c_plan_ahead;
+	uint32_t c_delay_target;
+	uint32_t c_fill_target;
+	uint32_t c_max_rate;
 } __packed;
 
 enum drbd_conn_flags {
@@ -303,35 +485,90 @@ enum drbd_conn_flags {
 };
 
 struct p_protocol {
-	u32 protocol;
-	u32 after_sb_0p;
-	u32 after_sb_1p;
-	u32 after_sb_2p;
-	u32 conn_flags;
-	u32 two_primaries;
+	uint32_t protocol;
+	uint32_t after_sb_0p;
+	uint32_t after_sb_1p;
+	uint32_t after_sb_2p;
+	uint32_t conn_flags;
+	uint32_t two_primaries;
 
 	/* Since protocol version 87 and higher. */
 	char integrity_alg[];
 
 } __packed;
 
+#define UUID_FLAG_DISCARD_MY_DATA     ((u64)1 << 0)
+#define UUID_FLAG_CRASHED_PRIMARY     ((u64)1 << 1)
+#define UUID_FLAG_INCONSISTENT        ((u64)1 << 2)
+#define UUID_FLAG_SKIP_INITIAL_SYNC   ((u64)1 << 3)
+
+#define UUID_FLAG_MASK_COMPAT_84 \
+	(UUID_FLAG_DISCARD_MY_DATA|\
+	 UUID_FLAG_CRASHED_PRIMARY|\
+	 UUID_FLAG_INCONSISTENT|\
+	 UUID_FLAG_SKIP_INITIAL_SYNC)
+
+#define UUID_FLAG_NEW_DATAGEN         ((u64)1 << 4)
+#define UUID_FLAG_STABLE              ((u64)1 << 5)
+#define UUID_FLAG_GOT_STABLE          ((u64)1 << 6) /* send UUIDs */
+#define UUID_FLAG_RESYNC              ((u64)1 << 7) /* compare UUIDs and eventually start resync */
+#define UUID_FLAG_RECONNECT           ((u64)1 << 8)
+#define UUID_FLAG_DISKLESS_PRIMARY    ((u64)1 << 9) /* Use with UUID_FLAG_RESYNC if a diskless primary is the reason */
+#define UUID_FLAG_PRIMARY_LOST_QUORUM ((u64)1 << 10)
+#define UUID_FLAG_SYNC_TARGET         ((u64)1 << 11) /* currently L_SYNC_TARGET to some peer */
+#define UUID_FLAG_HAS_UNALLOC         ((u64)1 << 12) /* highest byte contains index of not allocated bitmap uuid */
+#define UUID_FLAG_BITMAP_AUTHORITATIVE ((u64)1 << 13) /* my out-of-sync bits toward you were set for blocks you lack, not by a resync or an invalidate; protocol 125 */
+
+#define UUID_FLAG_UNALLOC_SHIFT       56
+#define UUID_FLAG_UNALLOC_MASK        ((u64)0xff << UUID_FLAG_UNALLOC_SHIFT)
+
 struct p_uuids {
-	u64 uuid[UI_EXTENDED_SIZE];
+	uint64_t current_uuid;
+	uint64_t bitmap_uuid;
+	uint64_t history_uuids[HISTORY_UUIDS_V08];
+	uint64_t dirty_bits;
+	uint64_t uuid_flags;
+} __packed;
+
+struct p_uuids110 {
+	uint64_t current_uuid;
+	uint64_t dirty_bits;
+	uint64_t uuid_flags;
+	uint64_t node_mask;
+	/* weak_nodes when UUID_FLAG_NEW_DATAGEN is set;
+	 * authoritative nodes when UUID_FLAG_STABLE not set
+	 */
+
+	uint64_t bitmap_uuids_mask; /* non zero bitmap UUIDS for these nodes */
+	uint64_t other_uuids[];
+	/* the first hweight(bitmap_uuids_mask) slots carry bitmap uuids.
+	 * The node with the lowest node_id first.
+	 * The remaining slots carry history uuids
+	 */
 } __packed;
 
-struct p_rs_uuid {
-	u64	    uuid;
+struct p_current_uuid {
+	uint64_t uuid;
+	uint64_t weak_nodes;
 } __packed;
 
-/* optional queue_limits if (agreed_features & DRBD_FF_WSAME)
- * see also struct queue_limits, as of late 2015 */
+struct p_uuid {
+	uint64_t uuid;
+} __packed;
+
+/*
+ * optional queue_limits if (agreed_features & DRBD_FF_WSAME)
+ * see also struct queue_limits, as of late 2015
+ */
 struct o_qlim {
 	/* we don't need it yet, but we may as well communicate it now */
-	u32 physical_block_size;
+	uint32_t physical_block_size;
 
-	/* so the original in struct queue_limits is unsigned short,
-	 * but I'd have to put in padding anyways. */
-	u32 logical_block_size;
+	/*
+	 * so the original in struct queue_limits is unsigned short,
+	 * but I'd have to put in padding anyways.
+	 */
+	uint32_t logical_block_size;
 
 	/* One incoming bio becomes one DRBD request,
 	 * which may be translated to several bio on the receiving side.
@@ -339,88 +576,205 @@ struct o_qlim {
 	 */
 
 	/* various IO hints may be useful with "diskless client" setups */
-	u32 alignment_offset;
-	u32 io_min;
-	u32 io_opt;
+	uint32_t alignment_offset;
+	uint32_t io_min;
+	uint32_t io_opt;
 
-	/* We may need to communicate integrity stuff at some point,
-	 * but let's not get ahead of ourselves. */
+	/*
+	 * We may need to communicate integrity stuff at some point,
+	 * but let's not get ahead of ourselves.
+	 */
 
-	/* Backend discard capabilities.
+	/*
+	 * Backend discard capabilities.
 	 * Receiving side uses "blkdev_issue_discard()", no need to communicate
 	 * more specifics.  If the backend cannot do discards, the DRBD peer
 	 * may fall back to blkdev_issue_zeroout().
 	 */
-	u8 discard_enabled;
-	u8 discard_zeroes_data;
-	u8 write_same_capable;
-	u8 _pad;
+	uint8_t discard_enabled;
+	uint8_t discard_zeroes_data;
+	uint8_t write_same_capable;
+
+	/* Bitmap block shift relative to 4k. If peers have differnt bitmap
+	 * granularity, any resync related request needs to be aligned to the
+	 * larger granularity: we can not clear partial bits.
+	 * 0 to 8 to represent 4k to 1M.
+	 * If DRBD_FF_BM_BLOCK_SHIFT is agreed on.
+	 */
+	uint8_t bm_block_shift_minus_12;
 } __packed;
 
 struct p_sizes {
-	u64	    d_size;  /* size of disk */
-	u64	    u_size;  /* user requested size */
-	u64	    c_size;  /* current exported size */
-	u32	    max_bio_size;  /* Maximal size of a BIO */
-	u16	    queue_order_type;  /* not yet implemented in DRBD*/
-	u16	    dds_flags; /* use enum dds_flags here. */
+	uint64_t d_size;  /* size of disk */
+	uint64_t u_size;  /* user requested size */
+	uint64_t c_size;  /* current exported size */
+	uint32_t max_bio_size;  /* Maximal size of a BIO */
+	uint16_t queue_order_type;  /* not yet implemented in DRBD*/
+	uint16_t dds_flags; /* use enum dds_flags here. */
 
 	/* optional queue_limits if (agreed_features & DRBD_FF_WSAME) */
 	struct o_qlim qlim[];
 } __packed;
 
 struct p_state {
-	u32	    state;
+	uint32_t state;
 } __packed;
 
 struct p_req_state {
-	u32	    mask;
-	u32	    val;
+	uint32_t mask;
+	uint32_t val;
 } __packed;
 
 struct p_req_state_reply {
-	u32	    retcode;
+	uint32_t retcode;
+} __packed;
+
+struct p_twopc_request {
+	uint32_t tid;  /* transaction identifier */
+	union {
+		struct { /* when DRBD_FF_2PC_V2 is set */
+			uint32_t flags;
+			uint16_t _pad;
+			int8_t  s8_initiator_node_id;  /* initiator of the transaction */
+			int8_t  s8_target_node_id;  /* target of the transaction (or -1) */
+		};
+		struct { /* original packet version */
+			uint32_t u32_initiator_node_id;  /* initiator of the transaction */
+			uint32_t u32_target_node_id;  /* target of the transaction (or -1) */
+		};
+	};
+	uint64_t nodes_to_reach;
+	union {
+		union { /* TWOPC_STATE_CHANGE */
+			struct {    /* P_TWOPC_PREPARE */
+				uint64_t _compat_pad;
+				uint32_t mask;
+				uint32_t val;
+			};
+			struct { /* P_TWOPC_COMMIT */
+				uint64_t primary_nodes;
+				uint64_t reachable_nodes; /* when TWOPC_HAS_RECHABLE flag is set */
+			};
+		};
+		union {	 /* TWOPC_RESIZE */
+			struct {    /* P_TWOPC_PREP_RSZ */
+				uint64_t user_size;
+				uint16_t dds_flags;
+			};
+			struct {    /* P_TWOPC_COMMIT	*/
+				uint64_t diskful_primary_nodes;
+				uint64_t exposed_size;
+			};
+		};
+	};
+} __packed;
+
+#define TWOPC_HAS_FLAGS     0x80000000 /* For packet dissectors */
+#define TWOPC_HAS_REACHABLE 0x40000000 /* The reachable_nodes field is valid */
+#define TWOPC_PRI_INCAPABLE 0x20000000 /* The primary has no access to data */
+
+struct p_twopc_reply {
+	uint32_t tid;  /* transaction identifier */
+	uint32_t initiator_node_id;  /* initiator of the transaction */
+	uint64_t reachable_nodes;
+
+	union {
+		struct { /* TWOPC_STATE_CHANGE */
+			uint64_t primary_nodes;
+			uint64_t weak_nodes;
+		};
+		struct { /* TWOPC_RESIZE */
+			uint64_t diskful_primary_nodes;
+			uint64_t max_possible_size;
+		};
+	};
 } __packed;
 
 struct p_drbd06_param {
-	u64	  size;
-	u32	  state;
-	u32	  blksize;
-	u32	  protocol;
-	u32	  version;
-	u32	  gen_cnt[5];
-	u32	  bit_map_gen[5];
+	uint64_t size;
+	uint32_t state;
+	uint32_t blksize;
+	uint32_t protocol;
+	uint32_t version;
+	uint32_t gen_cnt[5];
+	uint32_t bit_map_gen[5];
 } __packed;
 
 struct p_block_desc {
-	u64 sector;
-	u32 blksize;
-	u32 pad;	/* to multiple of 8 Byte */
+	uint64_t sector;
+	uint32_t blksize;
+	uint32_t pad;	/* to multiple of 8 Byte */
 } __packed;
 
-/* Valid values for the encoding field.
- * Bump proto version when changing this. */
+/*
+ * Valid values for the encoding field.
+ * Bump proto version when changing this.
+ */
 enum drbd_bitmap_code {
-	/* RLE_VLI_Bytes = 0,
+	/*
+	 * RLE_VLI_Bytes = 0,
 	 * and other bit variants had been defined during
-	 * algorithm evaluation. */
+	 * algorithm evaluation.
+	 */
 	RLE_VLI_Bits = 2,
 };
 
 struct p_compressed_bm {
-	/* (encoding & 0x0f): actual encoding, see enum drbd_bitmap_code
+	/*
+	 * (encoding & 0x0f): actual encoding, see enum drbd_bitmap_code
 	 * (encoding & 0x80): polarity (set/unset) of first runlength
 	 * ((encoding >> 4) & 0x07): pad_bits, number of trailing zero bits
 	 * used to pad up to head.length bytes
 	 */
-	u8 encoding;
+	uint8_t encoding;
 
-	u8 code[];
+	uint8_t code[];
 } __packed;
 
 struct p_delay_probe93 {
-	u32     seq_num; /* sequence number to match the two probe packets */
-	u32     offset;  /* usecs the probe got sent after the reference time point */
+	uint32_t seq_num; /* sequence number to match the two probe packets */
+	uint32_t offset;  /* usecs the probe got sent after the reference time point */
+} __packed;
+
+struct p_dagtag {
+	uint64_t dagtag;
+} __packed;
+
+struct p_peer_ack {
+	uint64_t mask;
+	uint64_t dagtag;
+} __packed;
+
+struct p_peer_block_desc {
+	uint64_t sector;
+	uint64_t mask;
+	uint32_t size;
+	uint32_t pad;	/* to multiple of 8 Byte */
+} __packed;
+
+struct p_peer_dagtag {
+	uint64_t dagtag;
+	uint32_t node_id;
+} __packed;
+
+struct p_flush_requests {
+	uint64_t flush_sequence;
+} __packed;
+
+struct p_flush_forward {
+	uint64_t flush_sequence;
+	uint32_t initiator_node_id;
+} __packed;
+
+struct p_flush_ack {
+	uint64_t flush_sequence;
+	uint32_t primary_node_id;
+} __packed;
+
+struct p_enable_replication {
+	uint8_t enable;
+	uint8_t _pad1;
+	uint16_t _pad2;
 } __packed;
 
 /*
-- 
2.56.0

