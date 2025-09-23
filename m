Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A509D2641EE
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642777; cv=none; b=bjtEbVoL5Cp9cp7kJzLeeIaBSiSD6SjTzbj489/aX5E2qet/UkvIaR6TDK0QkL1SmKbf7mjUCMNu8uF5GZTkkkTR3okDVNMk4FxaDxptMgyUKESQcfHbVsP7ZbUJ9EuePh8vixS99A2tB+/61VtmJEyidYBZF+g6zZX1aqmh9lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642777; c=relaxed/simple;
	bh=uAKJ5YIXpok4J2HO9I+jHEc/uFeWy79q0BkxKhz4i14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1xUhERBpkTthXjeqTTdfiO9m+lsHZ+tyx8oZbih4zLdymTxWTr6LI2IJEgdasLWKYbfPBZkIAYNxRd2R9HINzZvwLSOUBuH8qNIML3C67MuNyIFTzdxr4/gicDuaXHMfZBkrpE1BhTrTUoiGTGPgjJZzbSpCd09vi1T+rDQ/c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QhCEAk9A; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QhCEAk9A"
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-3f472ca07c3so2928595ab.1
        for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758642775; x=1759247575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hr2andr6If2MhR9CesjDbJLb+O0VNW92c+JnTqVvT0g=;
        b=QhCEAk9Agc5GwnTTK1rpkLqjWDIke11C7rceIsE6V+n1ef2yO1zXPU/zmGa8bddV/t
         gK/N7JI8GFR0YMLGPmfg/HKv3wpkmMe7SviOBXYtK0YN7tkrGor04UNFtEXEEvDXRP0e
         2VP5CXfVaLayK19pJ2fhqEm/MyuESRMaqLsZfXSIj/AgykSq3pNjVUmIokJB1BeucJ3w
         vvLEsJYXWHOgnDT2kNMAmoNOjOby+86RCPOBSfxhVNAgjS6KO/2f33DXPnP+5VjAhiSJ
         lmFWEg8XIk6nwRGuE4lUpGTeMfYtV4/sXkAm92S2glGVzojoXWmPmfaqgTI2g9ngvrhZ
         Ez+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642775; x=1759247575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hr2andr6If2MhR9CesjDbJLb+O0VNW92c+JnTqVvT0g=;
        b=rhCYamxB3KDSEAzcLmQDAOZryAXbParA5zuay5scMEBTaxS0FlUsgcga7fN+qsmucC
         x5TfQcWGL9AjzunMIi6pHzhGQp37QpbCrBotsJfFtyab3fm+UWHZaBVlCaNADxOCPnJs
         Tfh1eluwP8/qBE8yBD+sle/Ff/qE5bV7qAwElfzM9BlTZFeG1Yk+TbNYuFp9y3Lg6rjc
         cOCEXGmKLgcqYXPb61Ylxdj7XBtR2+6+mCBNglYE7JvUF1sOFpMEcTGGkxMyYl3zYaQM
         GRt27UIGI+ceQM/DtRpDBCmYt8LgZtg7yklV5uyUkT9rHb3gqSsYfmzFO9F1Cp3nAYYK
         v3SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhTOyfQ1C+IDhAYKnvgPTTznBJ7wKVnjLZyggniGmFPQjRR731BRbuX+EerCZSEZ6gyoAgqtwGAKbdmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP6C1afclJuifZvn5wlbY1jgzmxcZAgg0p/yV50eLmCIiLc2kH
	0QrMkBh4nj/hYJzINUc1tuDfU8hGdOvjmq0Xqs3VTKTml6imAEupZhHWP05ozxO61ZprLKDC01U
	z6WYR/P7rDqoqbzrrH6mkOskHCd5gve7Viezi
X-Gm-Gg: ASbGnctv3X4debFzT6Jn3uJc0kRFGIDZLcdW7161PcNrNiChlUmNVx3ufMlw24SmPjR
	yKPvr9AidGfVfKlT1l4LbaWI0g8yQntczMfIzVpvwdmxILqmF0TXeVzuYf69AiHzU47OLeAJx9+
	WaAMjrN/YjPSiOR5oIy8rs5kfxB4OGYc+JB6dvkGF7yv3x0cO7RN/R3MJ2eXy9d67jhaPs8EWNw
	nBm/c8sVxoIsY00M9oWfKy41E6Lskqii+FYtLmAPYlbAwUP9cRslGHnfzpEmzTJAJBTX+JYR/gM
	U7Hr3yu1MqOzqPkSq1h23vfQGSOPsK1/MryvSrQXlP5jH0v9UWR7W+XAbwjE8DGVcRIX0pCT
X-Google-Smtp-Source: AGHT+IEWTzAV4+l++tX2sIXCcXNEeWjLQ9JCB3xpPjwbjd5Z+dIR2mwEOpQQxTO5cYBdtzV5UuM+Ty87VSEF
X-Received: by 2002:a05:6e02:12ef:b0:405:face:641b with SMTP id e9e14a558f8ab-42581eb0769mr19692455ab.6.1758642774589;
        Tue, 23 Sep 2025 08:52:54 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4244a369a9dsm10025335ab.8.2025.09.23.08.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:52:54 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3B9A53401CC;
	Tue, 23 Sep 2025 09:52:54 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 36094E41BAF; Tue, 23 Sep 2025 09:52:54 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: remove redundant zone op check in ublk_setup_iod()
Date: Tue, 23 Sep 2025 09:52:48 -0600
Message-ID: <20250923155249.2891305-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_setup_iod() checks first whether the request is a zoned operation
issued to a device without zoned support and returns BLK_STS_IOERR if
so. However, such a request would already hit the default case in the
subsequent switch statement and fail the ublk_queue_is_zoned() check,
which also results in a return of BLK_STS_IOERR. So remove the redundant
early check for unsupported zone ops.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5ab7ff5f03f4..fcc8b3868137 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1103,17 +1103,12 @@ static inline unsigned int ublk_req_build_flags(struct request *req)
 
 static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 {
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
 	struct ublk_io *io = &ubq->ios[req->tag];
-	enum req_op op = req_op(req);
 	u32 ublk_op;
 
-	if (!ublk_queue_is_zoned(ubq) &&
-	    (op_is_zone_mgmt(op) || op == REQ_OP_ZONE_APPEND))
-		return BLK_STS_IOERR;
-
 	switch (req_op(req)) {
 	case REQ_OP_READ:
 		ublk_op = UBLK_IO_OP_READ;
 		break;
 	case REQ_OP_WRITE:
-- 
2.45.2

