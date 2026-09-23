Received: from mail-wr2-f14.google.com (mail-wr2-f14.google.com [74.125.225.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB553B601
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172414; cv=none; b=gnneRdpFboQHFdNVUDB579wkNPX5DF260E6KAohS9Svo3N+5vD4KP9SJKI6XGc+TD8IxRvzDaqjuVyfZlZYLhmjV2CjEmQv0F08Yux5klmneuYhmN33VQvKEybN2Qc86CW1wPttuIPSBaDywi9rxRVlN+RJpOkD5Zb/dMSq38as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172414; c=relaxed/simple;
	bh=QECkCCtFgmexVFOQEBEMUMlJ5mdLy8sLeezmjSt0bC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHKVzErf4bf2eeBAN4ZFsuZ8HVMCZR1KEOCR/koz3FqlILgrIoaW1fxS8gq05yGkB/66tE7MRFclqJqfKxpEEc5kP8kjh5IUIbbMrZ7gm4Cx4KDgfI/kGgAcrqumeInyxhWQAIc9hdOC0C9OrVHMqy1ju8tJDRjjl+pHsfqZEzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=tDLYEirA; arc=none smtp.client-ip=74.125.225.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="tDLYEirA"
Received: by mail-wr2-f14.google.com with SMTP id ffacd0b85a97d-482f6350f88so713166f8f.2
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 07:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790172408; x=1790777208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HjDgwYC7WS+fns6snJ5SpMXxfL8DgMKhiYl1lDgWvSQ=;
        b=tDLYEirAUwBWE5zpLgmnqhGNHsLiFyrJM51W5NTAqqpdgcvUZ19YP5/a1YV9NwmuDi
         oECQQbe8KeHzCoXyeCmLADyB6EXScEuMTo0xe71UgTpT8xtMmuE7vYb0xz/oE8bvAEtD
         hE5eyHegIXHGQol/9QDdMtCuEakzV01LZk5TnYZ2sN2tC6lfAJQ34OKuW4GFxALR2H4d
         syfC7KntZpVN329HQ3T8b+P+fgwHw/nrVocYRFaKitlkHE64M6NGi2gq0RNaoUTzSFUM
         kFqBTekihxzNThvMdna1qgqjFEehjMTuzlZXeINCdUNdm27oI7GXLLTy3Q/YRd42llyS
         t89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172408; x=1790777208;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HjDgwYC7WS+fns6snJ5SpMXxfL8DgMKhiYl1lDgWvSQ=;
        b=Jm2Ji2vunfGtyUiW8TuxVikXJ/WxYHXrbCq1Yduw/Xc7zUwozkblR7eD4j3tvNe/Q7
         G1KrEyIrsAyba8hWHeLnVdhlPnEcAGXAGbNhZ92ZemQ626xy6mahM9Xgt9r/v+E43aKG
         Yrn9fRCebCyX0MEQAtLtV1KO4cydhySKlV/+TCxHXzRnbUBPPRHE0hLBs/YrjY9bh8Xm
         lOryLf5WTkzNUUxPX/8uUCLzFx2T6vGD/YufLE73FQcW4sTNnXH14ggLeUbrb4IS1fJd
         OWpAjfooUdTOQwYTk2fdDYWCmyyLHS+CCtoGtNmEo/45HrV0dpdbyH/3PX5WTa3pqnxU
         EqIA==
X-Forwarded-Encrypted: i=1; AKwUvBwUaMk6RPox1gnYUqyRNXN+7Fly8guyejpxkvyAoi/+wDsS9Pp24O7//Bmghh6QDt6Ng0sTpGH1O7G3pw==@vger.kernel.org
X-Gm-Message-State: AFuF++n8eYfFCmzQ3SL0ZL1o2sWK2F867HdiUu2x3y0wjD3UQ5V7Z7T5
	JVq9pEtfRzfN+RbTQO6yAgADLaEoDJBeb329tOZhbEWCemv2DWrbCqo9ZLxUVXsW/8Elx0GCE9s
	aYuDO9nY=
X-Gm-Gg: AYBFou06JTFWsUquUYqVYzxbJXw7OxwwQpv6i/jiX8wiOF/sj5q0LvrYIUnM4dmytm2
	IwnqPho8VrU6v6VjvDk0dKy5vHGBKj5Jugd8WEjLPJ3SozmZM/5/LQ2QodTnYEWg7w3MgE7KpgH
	8daN2MJD7fnmJAPDRzjAPGW0Jv8Gxb3P2V7h4IUCUoiub4ULVClh1HpR6r1kDLNEo3TUn2L0CDy
	ttVz+hr9RfzS0f+l4KuPqD/MtRboPZSe/rdNIeS6U1R9CEGxmWSDmxvT/a35H5/+o5A1Dc/zWXs
	KwrkjQqGPQRCOOTqk+Mq8SA/E4+bOd1SVF/oeNIOo54YrAmHFxHJjwRlbTxL7PbhYXTzXxYQMwu
	TN9e4ynxC5Bj1I2XJ9yso4IRQ61URSioaocqiGXhRofLF5Bznzjm79+5RtUOw6e4/iOqxOhhuNg
	hpz8NMyn9ddC1Ej1fofUnZSlsReb+LGIe/66fdgKNWge7K15mCrWPdlIBokEE0+8ZyW1qEWhpm/
	ATkjDRJpm35giP0LNJ6YK/BHn+u0Mc=
X-Received: by 2002:a05:600c:8b53:b0:49f:cbae:3414 with SMTP id 5b1f17b1804b1-49fe4ad6cffmr6974335e9.4.1790172407660;
        Wed, 23 Sep 2026 07:06:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b01f:2334:39d8:9506:1776:f780])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde18a8a0sm78087455e9.5.2026.09.23.07.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:06:47 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 6/7] drbd: move the packet name table to drbd_strings.c
Date: Wed, 23 Sep 2026 16:06:07 +0200
Message-ID: <20260923140608.1116713-7-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
References: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The string tables for the state enums live in drbd_strings.c, but the
one for the wire protocol commands is a static array hidden inside
cmdname() in drbd_main.c. Move it next to the others as
drbd_packet_name(), and use the enum names themselves as the strings,
so a log message names exactly the constant a reader will grep for.

While at it, describe each table by a struct state_names, and make the
lookup helpers uniform: every one of them range-checks against the
table size and returns "?" for an index without a name, instead of
three different "TOO_LARGE"/"TOO_SMALL" strings.

This is the layout drbd_strings.[ch] have in DRBD 9.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |   1 -
 drivers/block/drbd/drbd_main.c     |  74 -----------------
 drivers/block/drbd/drbd_receiver.c |  18 ++---
 drivers/block/drbd/drbd_strings.c  | 126 ++++++++++++++++++++++++++---
 drivers/block/drbd/drbd_strings.h  |  23 +++++-
 5 files changed, 142 insertions(+), 100 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index d3ca2b730a11..297deac20f7e 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -104,7 +104,6 @@ extern struct ratelimit_state drbd_ratelimit_state;
 extern struct idr drbd_devices; /* RCU, updates: genl_lock() */
 extern struct list_head drbd_resources; /* RCU, updates: genl_lock() */
 
-extern const char *cmdname(enum drbd_packet cmd);
 
 /* for sending/receiving the bitmap,
  * possibly in some encoding scheme */
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 09e42706c83e..fc674acf8bd4 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3560,80 +3560,6 @@ static void md_sync_timer_fn(struct timer_list *t)
 	drbd_device_post_work(device, MD_SYNC);
 }
 
-const char *cmdname(enum drbd_packet cmd)
-{
-	/* THINK may need to become several global tables
-	 * when we want to support more than
-	 * one PRO_VERSION */
-	static const char *cmdnames[] = {
-
-		[P_DATA]	        = "Data",
-		[P_DATA_REPLY]	        = "DataReply",
-		[P_RS_DATA_REPLY]	= "RSDataReply",
-		[P_BARRIER]	        = "Barrier",
-		[P_BITMAP]	        = "ReportBitMap",
-		[P_BECOME_SYNC_TARGET]  = "BecomeSyncTarget",
-		[P_BECOME_SYNC_SOURCE]  = "BecomeSyncSource",
-		[P_UNPLUG_REMOTE]	= "UnplugRemote",
-		[P_DATA_REQUEST]	= "DataRequest",
-		[P_RS_DATA_REQUEST]     = "RSDataRequest",
-		[P_SYNC_PARAM]	        = "SyncParam",
-		[P_PROTOCOL]            = "ReportProtocol",
-		[P_UUIDS]	        = "ReportUUIDs",
-		[P_SIZES]	        = "ReportSizes",
-		[P_STATE]	        = "ReportState",
-		[P_SYNC_UUID]           = "ReportSyncUUID",
-		[P_AUTH_CHALLENGE]      = "AuthChallenge",
-		[P_AUTH_RESPONSE]	= "AuthResponse",
-		[P_STATE_CHG_REQ]       = "StateChgRequest",
-		[P_PING]		= "Ping",
-		[P_PING_ACK]	        = "PingAck",
-		[P_RECV_ACK]	        = "RecvAck",
-		[P_WRITE_ACK]	        = "WriteAck",
-		[P_RS_WRITE_ACK]	= "RSWriteAck",
-		[P_SUPERSEDED]          = "Superseded",
-		[P_NEG_ACK]	        = "NegAck",
-		[P_NEG_DREPLY]	        = "NegDReply",
-		[P_NEG_RS_DREPLY]	= "NegRSDReply",
-		[P_BARRIER_ACK]	        = "BarrierAck",
-		[P_STATE_CHG_REPLY]     = "StateChgReply",
-		[P_OV_REQUEST]          = "OVRequest",
-		[P_OV_REPLY]            = "OVReply",
-		[P_OV_RESULT]           = "OVResult",
-		[P_CSUM_RS_REQUEST]     = "CsumRSRequest",
-		[P_RS_IS_IN_SYNC]	= "CsumRSIsInSync",
-		[P_SYNC_PARAM89]	= "SyncParam89",
-		[P_COMPRESSED_BITMAP]   = "CBitmap",
-		[P_DELAY_PROBE]         = "DelayProbe",
-		[P_OUT_OF_SYNC]		= "OutOfSync",
-		[P_RS_CANCEL]		= "RSCancel",
-		[P_CONN_ST_CHG_REQ]	= "conn_st_chg_req",
-		[P_CONN_ST_CHG_REPLY]	= "conn_st_chg_reply",
-		[P_PROTOCOL_UPDATE]	= "protocol_update",
-		[P_TRIM]	        = "Trim",
-		[P_RS_THIN_REQ]         = "rs_thin_req",
-		[P_RS_DEALLOCATED]      = "rs_deallocated",
-		[P_WSAME]	        = "WriteSame",
-		[P_ZEROES]		= "Zeroes",
-
-		/* enum drbd_packet, but not commands - obsoleted flags:
-		 *	P_MAY_IGNORE
-		 *	P_MAX_OPT_CMD
-		 */
-	};
-
-	/* too big for the array: 0xfffX */
-	if (cmd == P_INITIAL_META)
-		return "InitialMeta";
-	if (cmd == P_INITIAL_DATA)
-		return "InitialData";
-	if (cmd == P_CONNECTION_FEATURES)
-		return "ConnectionFeatures";
-	if (cmd >= ARRAY_SIZE(cmdnames))
-		return "Unknown";
-	return cmdnames[cmd];
-}
-
 /**
  * drbd_wait_misc  -  wait for a request to make progress
  * @device:	device associated with the request
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 3ebe18535fcf..fa87cbba756b 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3655,7 +3655,7 @@ static int ignore_remaining_packet(struct drbd_connection *connection, struct pa
 static int config_unknown_volume(struct drbd_connection *connection, struct packet_info *pi)
 {
 	drbd_warn(connection, "%s packet received for volume %u, which is not configured locally\n",
-		  cmdname(pi->cmd), pi->vnr);
+		  drbd_packet_name(pi->cmd), pi->vnr);
 	return ignore_remaining_packet(connection, pi);
 }
 
@@ -4887,7 +4887,7 @@ static void drbdd(struct drbd_connection *connection)
 		cmd = &drbd_cmd_handler[pi.cmd];
 		if (unlikely(pi.cmd >= ARRAY_SIZE(drbd_cmd_handler) || !cmd->fn)) {
 			drbd_err(connection, "Unexpected data packet %s (0x%04x)",
-				 cmdname(pi.cmd), pi.cmd);
+				 drbd_packet_name(pi.cmd), pi.cmd);
 			goto err_out;
 		}
 
@@ -4896,12 +4896,12 @@ static void drbdd(struct drbd_connection *connection)
 			shs += sizeof(struct o_qlim);
 		if (pi.size > shs && !cmd->expect_payload) {
 			drbd_err(connection, "No payload expected %s l:%d\n",
-				 cmdname(pi.cmd), pi.size);
+				 drbd_packet_name(pi.cmd), pi.size);
 			goto err_out;
 		}
 		if (pi.size < shs) {
 			drbd_err(connection, "%s: unexpected packet size, expected:%d received:%d\n",
-				 cmdname(pi.cmd), (int)shs, pi.size);
+				 drbd_packet_name(pi.cmd), (int)shs, pi.size);
 			goto err_out;
 		}
 
@@ -4917,7 +4917,7 @@ static void drbdd(struct drbd_connection *connection)
 		err = cmd->fn(connection, &pi);
 		if (err) {
 			drbd_err(connection, "error receiving %s, e: %d l: %d!\n",
-				 cmdname(pi.cmd), err, pi.size);
+				 drbd_packet_name(pi.cmd), err, pi.size);
 			goto err_out;
 		}
 	}
@@ -5110,7 +5110,7 @@ static int drbd_do_features(struct drbd_connection *connection)
 
 	if (pi.cmd != P_CONNECTION_FEATURES) {
 		drbd_err(connection, "expected ConnectionFeatures packet, received: %s (0x%04x)\n",
-			 cmdname(pi.cmd), pi.cmd);
+			 drbd_packet_name(pi.cmd), pi.cmd);
 		return -1;
 	}
 
@@ -5233,7 +5233,7 @@ static int drbd_do_auth(struct drbd_connection *connection)
 
 	if (pi.cmd != P_AUTH_CHALLENGE) {
 		drbd_err(connection, "expected AuthChallenge packet, received: %s (0x%04x)\n",
-			 cmdname(pi.cmd), pi.cmd);
+			 drbd_packet_name(pi.cmd), pi.cmd);
 		rv = -1;
 		goto fail;
 	}
@@ -5299,7 +5299,7 @@ static int drbd_do_auth(struct drbd_connection *connection)
 
 	if (pi.cmd != P_AUTH_RESPONSE) {
 		drbd_err(connection, "expected AuthResponse packet, received: %s (0x%04x)\n",
-			 cmdname(pi.cmd), pi.cmd);
+			 drbd_packet_name(pi.cmd), pi.cmd);
 		rv = 0;
 		goto fail;
 	}
@@ -5859,7 +5859,7 @@ int drbd_ack_receiver(struct drbd_thread *thi)
 			cmd = &ack_receiver_tbl[pi.cmd];
 			if (pi.cmd >= ARRAY_SIZE(ack_receiver_tbl) || !cmd->fn) {
 				drbd_err(connection, "Unexpected meta packet %s (0x%04x)\n",
-					 cmdname(pi.cmd), pi.cmd);
+					 drbd_packet_name(pi.cmd), pi.cmd);
 				goto disconnect;
 			}
 			expect = header_size + cmd->pkt_size;
diff --git a/drivers/block/drbd/drbd_strings.c b/drivers/block/drbd/drbd_strings.c
index a35ff87a93b1..f9fde9defedb 100644
--- a/drivers/block/drbd/drbd_strings.c
+++ b/drivers/block/drbd/drbd_strings.c
@@ -3,10 +3,12 @@
  * Copyright (C) 2014, LINBIT HA-Solutions GmbH.
  */
 
+#include <linux/kernel.h>
 #include <linux/drbd.h>
 #include "drbd_strings.h"
+#include "drbd_protocol.h"
 
-static const char * const drbd_conn_s_names[] = {
+static const char * const __conn_state_names[] = {
 	[C_STANDALONE]       = "StandAlone",
 	[C_DISCONNECTING]    = "Disconnecting",
 	[C_UNCONNECTED]      = "Unconnected",
@@ -33,13 +35,23 @@ static const char * const drbd_conn_s_names[] = {
 	[C_BEHIND]           = "Behind",
 };
 
-static const char * const drbd_role_s_names[] = {
+struct state_names drbd_conn_state_names = {
+	.names = __conn_state_names,
+	.size = ARRAY_SIZE(__conn_state_names),
+};
+
+static const char * const __role_state_names[] = {
+	[R_UNKNOWN]   = "Unknown",
 	[R_PRIMARY]   = "Primary",
 	[R_SECONDARY] = "Secondary",
-	[R_UNKNOWN]   = "Unknown"
 };
 
-static const char * const drbd_disk_s_names[] = {
+struct state_names drbd_role_state_names = {
+	.names = __role_state_names,
+	.size = ARRAY_SIZE(__role_state_names),
+};
+
+static const char * const __disk_state_names[] = {
 	[D_DISKLESS]     = "Diskless",
 	[D_ATTACHING]    = "Attaching",
 	[D_FAILED]       = "Failed",
@@ -51,7 +63,12 @@ static const char * const drbd_disk_s_names[] = {
 	[D_UP_TO_DATE]   = "UpToDate",
 };
 
-static const char * const drbd_state_sw_errors[] = {
+struct state_names drbd_disk_state_names = {
+	.names = __disk_state_names,
+	.size = ARRAY_SIZE(__disk_state_names),
+};
+
+static const char * const __error_messages[] = {
 	[-SS_TWO_PRIMARIES] = "Multiple primaries not allowed by config",
 	[-SS_NO_UP_TO_DATE_DISK] = "Need access to UpToDate data",
 	[-SS_NO_LOCAL_DISK] = "Can not resync without local disk",
@@ -74,25 +91,110 @@ static const char * const drbd_state_sw_errors[] = {
 	[-SS_O_VOL_PEER_PRI] = "Other vol primary on peer not allowed by config",
 };
 
+struct state_names drbd_error_messages = {
+	.names = __error_messages,
+	.size = ARRAY_SIZE(__error_messages),
+};
+
+static const char * const __packet_names[] = {
+	[P_DATA]	        = "P_DATA",
+	[P_WSAME]               = "P_WSAME",
+	[P_TRIM]                = "P_TRIM",
+	[P_DATA_REPLY]	        = "P_DATA_REPLY",
+	[P_RS_DATA_REPLY]	= "P_RS_DATA_REPLY",
+	[P_BARRIER]	        = "P_BARRIER",
+	[P_BITMAP]	        = "P_BITMAP",
+	[P_BECOME_SYNC_TARGET]  = "P_BECOME_SYNC_TARGET",
+	[P_BECOME_SYNC_SOURCE]  = "P_BECOME_SYNC_SOURCE",
+	[P_UNPLUG_REMOTE]	= "P_UNPLUG_REMOTE",
+	[P_DATA_REQUEST]	= "P_DATA_REQUEST",
+	[P_RS_DATA_REQUEST]     = "P_RS_DATA_REQUEST",
+	[P_SYNC_PARAM]	        = "P_SYNC_PARAM",
+	[P_SYNC_PARAM89]	= "P_SYNC_PARAM89",
+	[P_PROTOCOL]            = "P_PROTOCOL",
+	[P_UUIDS]	        = "P_UUIDS",
+	[P_SIZES]	        = "P_SIZES",
+	[P_STATE]	        = "P_STATE",
+	[P_SYNC_UUID]           = "P_SYNC_UUID",
+	[P_AUTH_CHALLENGE]      = "P_AUTH_CHALLENGE",
+	[P_AUTH_RESPONSE]	= "P_AUTH_RESPONSE",
+	[P_PING]		= "P_PING",
+	[P_PING_ACK]	        = "P_PING_ACK",
+	[P_RECV_ACK]	        = "P_RECV_ACK",
+	[P_WRITE_ACK]	        = "P_WRITE_ACK",
+	[P_RS_WRITE_ACK]	= "P_RS_WRITE_ACK",
+	[P_SUPERSEDED]		= "P_SUPERSEDED",
+	[P_NEG_ACK]	        = "P_NEG_ACK",
+	[P_NEG_DREPLY]	        = "P_NEG_DREPLY",
+	[P_NEG_RS_DREPLY]	= "P_NEG_RS_DREPLY",
+	[P_BARRIER_ACK]	        = "P_BARRIER_ACK",
+	[P_STATE_CHG_REQ]       = "P_STATE_CHG_REQ",
+	[P_STATE_CHG_REPLY]     = "P_STATE_CHG_REPLY",
+	[P_OV_REQUEST]          = "P_OV_REQUEST",
+	[P_OV_REPLY]            = "P_OV_REPLY",
+	[P_OV_RESULT]           = "P_OV_RESULT",
+	[P_CSUM_RS_REQUEST]     = "P_CSUM_RS_REQUEST",
+	[P_RS_IS_IN_SYNC]	= "P_RS_IS_IN_SYNC",
+	[P_COMPRESSED_BITMAP]   = "P_COMPRESSED_BITMAP",
+	[P_DELAY_PROBE]         = "P_DELAY_PROBE",
+	[P_OUT_OF_SYNC]		= "P_OUT_OF_SYNC",
+	[P_RETRY_WRITE]		= "P_RETRY_WRITE",
+	[P_RS_CANCEL]		= "P_RS_CANCEL",
+	[P_CONN_ST_CHG_REQ]	= "P_CONN_ST_CHG_REQ",
+	[P_CONN_ST_CHG_REPLY]	= "P_CONN_ST_CHG_REPLY",
+	[P_PROTOCOL_UPDATE]	= "P_PROTOCOL_UPDATE",
+	[P_RS_THIN_REQ]         = "P_RS_THIN_REQ",
+	[P_RS_DEALLOCATED]      = "P_RS_DEALLOCATED",
+	[P_ZEROES]              = "P_ZEROES",
+	/* enum drbd_packet, but not commands - obsoleted flags:
+	 *	P_MAY_IGNORE
+	 *	P_MAX_OPT_CMD
+	 */
+};
+
+struct state_names drbd_packet_names = {
+	.names = __packet_names,
+	.size = ARRAY_SIZE(__packet_names),
+};
+
 const char *drbd_conn_str(enum drbd_conns s)
 {
-	/* enums are unsigned... */
-	return s > C_BEHIND ? "TOO_LARGE" : drbd_conn_s_names[s];
+	return (s < 0 || s >= drbd_conn_state_names.size ||
+		!drbd_conn_state_names.names[s]) ?
+	       "?" : drbd_conn_state_names.names[s];
 }
 
 const char *drbd_role_str(enum drbd_role s)
 {
-	return s > R_SECONDARY   ? "TOO_LARGE" : drbd_role_s_names[s];
+	return (s < 0 || s >= drbd_role_state_names.size ||
+		!drbd_role_state_names.names[s]) ?
+	       "?" : drbd_role_state_names.names[s];
 }
 
 const char *drbd_disk_str(enum drbd_disk_state s)
 {
-	return s > D_UP_TO_DATE    ? "TOO_LARGE" : drbd_disk_s_names[s];
+	return (s < 0 || s >= drbd_disk_state_names.size ||
+		!drbd_disk_state_names.names[s]) ?
+	       "?" : drbd_disk_state_names.names[s];
 }
 
 const char *drbd_set_st_err_str(enum drbd_state_rv err)
 {
-	return err <= SS_AFTER_LAST_ERROR ? "TOO_SMALL" :
-	       err > SS_TWO_PRIMARIES ? "TOO_LARGE"
-			: drbd_state_sw_errors[-err];
+	return (-err < 0 || -err >= drbd_error_messages.size ||
+		!drbd_error_messages.names[-err]) ?
+	       "?" : drbd_error_messages.names[-err];
+}
+
+const char *drbd_packet_name(enum drbd_packet cmd)
+{
+	/* too big for the array: 0xfffX */
+	if (cmd == P_INITIAL_META)
+		return "InitialMeta";
+	if (cmd == P_INITIAL_DATA)
+		return "InitialData";
+	if (cmd == P_CONNECTION_FEATURES)
+		return "ConnectionFeatures";
+	return (cmd < 0 || cmd >= ARRAY_SIZE(__packet_names) ||
+		!__packet_names[cmd]) ?
+	       "?" : __packet_names[cmd];
 }
diff --git a/drivers/block/drbd/drbd_strings.h b/drivers/block/drbd/drbd_strings.h
index 397c2eb9b666..a66d9f5fe4d5 100644
--- a/drivers/block/drbd/drbd_strings.h
+++ b/drivers/block/drbd/drbd_strings.h
@@ -6,9 +6,24 @@
 #ifndef __DRBD_STRINGS_H
 #define __DRBD_STRINGS_H
 
-extern const char *drbd_conn_str(enum drbd_conns);
-extern const char *drbd_role_str(enum drbd_role);
-extern const char *drbd_disk_str(enum drbd_disk_state);
-extern const char *drbd_set_st_err_str(enum drbd_state_rv);
+struct state_names {
+	const char * const *names;
+	unsigned int size;
+};
+
+extern struct state_names drbd_conn_state_names;
+extern struct state_names drbd_role_state_names;
+extern struct state_names drbd_disk_state_names;
+extern struct state_names drbd_error_messages;
+extern struct state_names drbd_packet_names;
+
+enum drbd_packet;
+
+const char *drbd_conn_str(enum drbd_conns s);
+const char *drbd_role_str(enum drbd_role s);
+const char *drbd_disk_str(enum drbd_disk_state s);
+const char *drbd_set_st_err_str(enum drbd_state_rv err);
+const char *drbd_packet_name(enum drbd_packet cmd);
+
 
 #endif  /* __DRBD_STRINGS_H */
-- 
2.55.0

