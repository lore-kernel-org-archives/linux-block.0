Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C975331218
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938872; cv=none; b=a0rEtrNOZ++CRa39vo8DDHqAt+6M6pDvkOs79TCOBFjUFBath9YbqYcb1Jv8u9a8sE2SoJtTd0IZabp+aYubFMdMYjp8ajAThK4X49og8NswDj/R9yIt/txl2FRSzGSkPCURqo19j53eurCRGNT+FTZtsRm6yWBUjZ3J/3EGU+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938872; c=relaxed/simple;
	bh=5SSPz2SLDwoONCWBZv9zOIYgjOhMjDjio63D3lzTC/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYy/AtLiH6gHGhKpCSeLl0NniJrX1ZNr/gUjbdoB//PyJrTRN49Eh/sl93KQ8KzYG7jKA6RYxB8BlfVKSIoMTbisSIVlagA2/V90sPyffHqDfgOec6eCC9ggUQTx2+eE3qJm3bo7FPaaa0YqYDKW0lEWFTA4c+RgTemtLfouIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dggGbubS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dggGbubS"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2b78d45bso984734f8f.0
        for <linux-block@vger.kernel.org>; Fri, 05 Dec 2025 04:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1764938861; x=1765543661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saho5eSDILZ2ExK/DCzZE5yuBnal9crTCSPX6cuFxv8=;
        b=dggGbubSP5EKQJEWHvx0yIRAqxkQCvIfr9OE6W+TXWGyNvCbLjZH6sWjCTlXRB2r/M
         q5h5fJd7lh2pltPxJMT/4LSHAErnW/FWrc4BSrCLtW3yARSOdhjPn56xulWZuH4r+zoY
         WvMBrUmmScNzgtfpLzw0Z9s1a+PC+mVacOrXFEDYQ6O94qFjJcCkFV1UALdq72eEpPjZ
         NqCWEXaEno6wSdl7F8W9jDte1kVtlaQmI/wulkrMdo/Z8sjyyiOMdQXlguQwTHFaefdo
         U8N3mbAIlzHdwbWbcg6GyDUsb4TtdJWJFTBWaM3rIwQctQIrzb+krqGa6QBZAFEL98nx
         qWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764938861; x=1765543661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=saho5eSDILZ2ExK/DCzZE5yuBnal9crTCSPX6cuFxv8=;
        b=P49Z9OmEKOuKu6ixJGw3d73T2F+O0Vx+lkqELsxcGkCJ8ZFhzr+YMATddSY1I93V1J
         zYmvpn1OwbeM3cs2j5T3eM/1eM7oDvImpNZSNY2AMT9qwsxwvlZqsYXK4LAOvkOHEExu
         zGKtG89tTWBUhLpakcs+KAGsrA0LS5B/DwGSuQZK7byUlDm4IdAF/VOjH2ZxN9kxoFf/
         qRUOvJIqm10pZt/++XIobxiunDXOFN4W4DLobyCYc61e6CBCBYnCs81sSor2Wp5U9K5a
         5cQrc1TOkOAnCLSkcERZfbDAwGLJoUAEymm9ZQhae4rOaoZX7j9vq528MBGXG0iCo9Mc
         o1AQ==
X-Gm-Message-State: AOJu0YzR9vM6zqBqn47/Z4E9xWmbbvifuxXNTDF9vsxe+UztJZLfKreT
	KBYd960I1yzc6+6iig7L3wcMk+PYPCN4U2ANoQsGBJxegRuUaTunypYBZUVrEk4Hr0QUhBQhlfN
	rmPvu
X-Gm-Gg: ASbGnct4gyLrGyBuIHCzgLdfRTqmlmWrCB8gr5jHqk7P/cZqN10IaX4tyU0ARa+N68B
	UtrbM2i/ouvpXyYd+urm0ovU0mCKtTYqlwKHgN6nQE0qt91BrwBZcSabzFyEqwiVA2c/Ylq5rMW
	XtY4cfIZ/kKAytTpdyXH7hrcuElNwX8t+vI71QmlX8z2vyRblphicYDVPAGgdTyf/fifPzaWyOp
	x51Udz+of4DFyO4Zg9wMcGoQKNLd7B91roqUmuOYWIENMnS6K+tL+SveZgs/fULrwQlejHTcO/Z
	zg2jFqY4nCnzrEwbOEtL/55elXzFkeLT8MZhl4Fyi8/fXZmwP5ON23iTCnrr3IpgEQNZx7sJ6ri
	aXpw2i24gc/+RiNTqITZscY7qDpPuWX/5W3MK7DK4vRBauFAgThNiWYR7A/R8B+C2vAr1zcbl3Y
	bkHG1zlX8rNOtKY6m/l/WCPAdJhvtuLAAUOczHVhjRCtRYcsERA9pIbEmPt3256NFgsm42HxnOC
	0iRNXa6/jUo7A==
X-Google-Smtp-Source: AGHT+IFKD5rQKG1QNWrLIOn87LBIz2QWD6fQdwSUYI2UO04V8XOnLQnvvvpQqe5W2CEmVpdt2Fm2gg==
X-Received: by 2002:adf:f211:0:b0:429:ca7f:8d5a with SMTP id ffacd0b85a97d-42f731a4e3dmr8578214f8f.37.1764938861422;
        Fri, 05 Dec 2025 04:47:41 -0800 (PST)
Received: from lb03189.speedport.ip (p200300f00f28af70a31ee45bb042915f.dip0.t-ipconnect.de. [2003:f0:f28:af70:a31e:e45b:b042:915f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee66sm8540037f8f.11.2025.12.05.04.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 04:47:41 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	bvanassche@acm.org,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com
Subject: [PATCH 4/6] rnbd-srv: fix the trace format for flags
Date: Fri,  5 Dec 2025 13:47:31 +0100
Message-ID: <20251205124733.26358-5-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205124733.26358-1-haris.iqbal@ionos.com>
References: <20251205124733.26358-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wang <jinpu.wang@ionos.com>

The __print_flags helper meant for bitmask, while the rnbd_rw_flags is
mixed with bitmask and enum, to avoid confusion, just print the data
as it is.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/block/rnbd/rnbd-srv-trace.h | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv-trace.h b/drivers/block/rnbd/rnbd-srv-trace.h
index 89d0bcb17195..18ae2ed5537a 100644
--- a/drivers/block/rnbd/rnbd-srv-trace.h
+++ b/drivers/block/rnbd/rnbd-srv-trace.h
@@ -44,24 +44,6 @@ DEFINE_EVENT(rnbd_srv_link_class, name, \
 DEFINE_LINK_EVENT(create_sess);
 DEFINE_LINK_EVENT(destroy_sess);
 
-TRACE_DEFINE_ENUM(RNBD_OP_READ);
-TRACE_DEFINE_ENUM(RNBD_OP_WRITE);
-TRACE_DEFINE_ENUM(RNBD_OP_FLUSH);
-TRACE_DEFINE_ENUM(RNBD_OP_DISCARD);
-TRACE_DEFINE_ENUM(RNBD_OP_SECURE_ERASE);
-TRACE_DEFINE_ENUM(RNBD_F_SYNC);
-TRACE_DEFINE_ENUM(RNBD_F_FUA);
-
-#define show_rnbd_rw_flags(x) \
-	__print_flags(x, "|", \
-		{ RNBD_OP_READ,		"READ" }, \
-		{ RNBD_OP_WRITE,	"WRITE" }, \
-		{ RNBD_OP_FLUSH,	"FLUSH" }, \
-		{ RNBD_OP_DISCARD,	"DISCARD" }, \
-		{ RNBD_OP_SECURE_ERASE,	"SECURE_ERASE" }, \
-		{ RNBD_F_SYNC,		"SYNC" }, \
-		{ RNBD_F_FUA,		"FUA" })
-
 TRACE_EVENT(process_rdma,
 	TP_PROTO(struct rnbd_srv_session *srv,
 		 const struct rnbd_msg_io *msg,
@@ -97,7 +79,7 @@ TRACE_EVENT(process_rdma,
 		__entry->usrlen = usrlen;
 	),
 
-	TP_printk("I/O req: sess: %s, type: %s, ver: %d, devid: %u, sector: %llu, bsize: %u, flags: %s, ioprio: %d, datalen: %u, usrlen: %zu",
+	TP_printk("I/O req: sess: %s, type: %s, ver: %d, devid: %u, sector: %llu, bsize: %u, flags: %u, ioprio: %d, datalen: %u, usrlen: %zu",
 		   __get_str(sessname),
 		   __print_symbolic(__entry->dir,
 			 { READ,  "READ" },
@@ -106,7 +88,7 @@ TRACE_EVENT(process_rdma,
 		   __entry->device_id,
 		   __entry->sector,
 		   __entry->bi_size,
-		   show_rnbd_rw_flags(__entry->flags),
+		   __entry->flags,
 		   __entry->ioprio,
 		   __entry->datalen,
 		   __entry->usrlen
-- 
2.43.0

