Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEF349625
	for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743185090; cv=none; b=hCPqt7663dfiD5WVae0If4xegiMRgQ3q7LGphHhFvAaQ5jsgAbQ6g+tBU0x0WzKPy4IgnGlmn8U9O1+G7CEh7F45LnnTezRkGZHQQYv+euE0XUdfkLtGTYBdpUnu24V0LcjcsMuk1vKexKMorn9wwOfaQb/V6jy6byHSDeHjzMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743185090; c=relaxed/simple;
	bh=gcB0C5YqFqmhQQqyd62UolXkBK1cwcSf4o9DizoUDeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owQ6xB30R4m/1K7VXu1oM2NnyPFIG9OoBxoSI2bpnfMR2r5FWvOhHRTri7EFJYRwwQuXmn3eMWC9qj5nBeTe0XmPszLuuduYUmhoyO6SNfAy9l8FUuflqHSJrhNpjNjrD6266tGQlfoV/HVeHUT9+2HuseH9dcCYYQTYQiCUsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bpkw35Jp; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bpkw35Jp"
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-6e4231ae149so3039916d6.2
        for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743185087; x=1743789887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+QsHISAznmPuIeI6H2v/o6YzereVbQ7k5Q0Zm28d6I=;
        b=bpkw35JpI2ah3kX5nEIKvoQ9O9FIOQ76lvHlNCp5k1HWNyhUpI9g1dNQaIo2tMNoNd
         x6yuSmkYOaMKLaDdNYcrYgIygSyWr27fiwW8F9L/LI6lNU+LRpL8JPqMSU0AhdIivsO1
         Ot6Blz7lis5T6FvClgksstfNCON3pmzrRZhOCWTnA3DmutbAee0avs915fBuQhaevwxE
         eQQgpvP2HxR7Oljz0NaQhI1oEaoQ8O9CdjpPta8JFjQhUypI/Fh+UR5Ua5vVXnmcn+4r
         1uaWRR4mHhTwvD7XGCwhNWWL4eixRuaLOiIgzWEMyaHcvli1fp9R6bdnNqdPuI96f0SS
         KuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743185087; x=1743789887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+QsHISAznmPuIeI6H2v/o6YzereVbQ7k5Q0Zm28d6I=;
        b=ruIL6tczuKBoBnzWn7tHuxVYjgIVqgOXd58X3Xl1FnCo4w13b8nQhVL1W5LiMpfkmp
         MWR8h3bF4pHc7+JBLKbvB4xXLgRDrxcb7WVNGHgTwrgl7wxzjwuxcmkjky4U8YTIccmb
         +kB83KNNBhp7eSPnVDzMbWy4KvUj5+HAuvH0P5ynbb3INJAVGvSqEZwHrBUxbxkOgQI+
         mRyTNuljBGmj2AxNMXXNaL5b/29ZAr2rQ9ZPQ5+2t4GChmOuXwknv/Esa/Lxswg4et8w
         6XkjG6IBTWX9GX+nmnOGIE9etlmHJiau6aBSywk4Rot9Y+PDA06rqaJ+TLh7UitmIfmQ
         5t5g==
X-Gm-Message-State: AOJu0Yxopcrz9hmpjn9squOf3FRk5uKTNSg3J5Lagl5KmT3/LmIKpnVv
	U9eUxyCa0LYJD6uskAtDg0gbde8komajFc6mR2Tk1ZxDbUxv/DjmeYrBgqz/1cMkhJFSy1rJ6uW
	IzL9f02rwZ01shMG+xQNm8bBaY//Cu1NJflw9RC7HwYK7mDbJ
X-Gm-Gg: ASbGnctk0v8y/qxvyFhkRPqYWNZ5f058uDPURWrrAFa36Q8ENKMabDZrWUGGZpXZRi2
	Nl2O8NXrmj0rmRBbQs7YgRcRUkoiefuPOZz88WqSujPRW208dWrMRw7tlCl3hbgTT/dUDJaMj2c
	7OccAjiYnDBhMhc+jojrqxyA3GYMg9X/60gvVRGY1MG7w0hipv93EJ66JO/hzpU+6RIul7fqh4q
	UbWllePmm/ehHCJEmoPfjBfkCj50VDX4mNmlBKFDnJE0bsIsVbJpYofQxSsVnWAZe9jeDu1TPPl
	XdPFrio3UWH/UJjGWtvOmzRIYzr2MTeemg==
X-Google-Smtp-Source: AGHT+IGOaSWLBAClwcBn1yitLGGVmefsbpho4O3wbV/JCh+TajmhlWtEu3LwJSrjmgGjceg3yAOfQ85VCQdK
X-Received: by 2002:a05:620a:17a6:b0:7c0:bd67:7dd9 with SMTP id af79cd13be357-7c5eeafa472mr383002585a.11.1743185087021;
        Fri, 28 Mar 2025 11:04:47 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-7c5f777eac7sm17958185a.3.2025.03.28.11.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 11:04:47 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D13233403C5;
	Fri, 28 Mar 2025 12:04:45 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id CB90DE412FD; Fri, 28 Mar 2025 12:04:45 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/5] ublk: skip 1 NULL check in ublk_cmd_list_tw_cb() loop
Date: Fri, 28 Mar 2025 12:04:08 -0600
Message-ID: <20250328180411.2696494-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328180411.2696494-1-csander@purestorage.com>
References: <20250328180411.2696494-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_cmd_list_tw_cb() is always performed on a non-empty request list.
So don't check whether rq is NULL on the first iteration of the loop,
just on subsequent iterations.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 39efe443e235..8b9780c0feab 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1288,16 +1288,16 @@ static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct request *rq = pdu->req_list;
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
 	struct request *next;
 
-	while (rq) {
+	do {
 		next = rq->rq_next;
 		rq->rq_next = NULL;
 		ublk_dispatch_req(ubq, rq, issue_flags);
 		rq = next;
-	}
+	} while (rq);
 }
 
 static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
 {
 	struct request *rq = rq_list_peek(l);
-- 
2.45.2

