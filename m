Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7922BD5B5
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653609; cv=none; b=tJw47SOfepCRcFjQ52VxDaY7dtY78tQAfWclIO5W9FXjaGGhvbRjyD7a/ChYtyrYA2m+V9ZHdc7F68Md5zXH0LQunVHxXZXagOi307PtDbAqr5wAX0Q5kfY3Lw4BGjm22paaDQ3qyocjzmH4iUyglE7MwmE2lKwFP6Y8ZJzKp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653609; c=relaxed/simple;
	bh=RMlv+KrFQeSUOi2OSy+jtJ8cgFIfVxy/pPU3YkPH1/A=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=lnmexhgApSzKqzDBTVwLae2O+btwm7eFEcPqPr6vlmj8jdkSAtsXPLV2lgQpr3bvJP45xIuaWCGggCV52A/cPAnc8TJVAPyrJ7PMCJAYVuqyXUI2SDnMKdxLu7kjU52l18zI1+WpNlvv889w5IRo9mlAzFtwsuqrIc/tVYP/vAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qbfJYrHu; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qbfJYrHu"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-86d01686196so221049539f.1
        for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749653605; x=1750258405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hnhndwa3pp6FsFwtdq+zPEpSdT6ImvwjieyrRxL05q8=;
        b=qbfJYrHu9x91B53Q1e1IiSumB63VGh7+utMGw32mziPNw/gnuSOdPpnMnjxzOLE8ia
         CUyWKjC4PjpAk0h+CUemo0KCrNYJXxWvyEsX68rW7PhUZy6XkkiIRkAP1b5ThN2samja
         +I8VS3CxzHdNqJF8kZSgBScD2Q1mri2GIEcRjNkNB4DjdC7aah6Evt+vilkWWzNdPQIW
         lhplJzjiX2lglRoc1S/qvQoS6y3VvGjUuILKXghM2xmlkY8xmAy1pRSz1VKQtBecS5LN
         KOMqkkZ3FCRCWwIj6VlynP/ZIJXvXbWMvMnH/wAJBENUKjeC43bPRpi9PpkGsGkm2ycz
         uGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749653605; x=1750258405;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hnhndwa3pp6FsFwtdq+zPEpSdT6ImvwjieyrRxL05q8=;
        b=HknPDuuEKBJqB7MM3tViTIj4gJU72OELs/Dg+2T86LnscFwVNxVByjYV+Sb7TWRCzU
         h1IXycCuLLnlEDmJ9kN0K76TxuLPUlugQod/FoBQ5bdYGfc+XJzigBI/v3oDzMJ+f7wK
         fsA4t9nfTcuII3sTQKyebSxqg6q1uqWjPgwXJeOGO7eJjMAJSD0xrAwXoLQ+t4EYOPKl
         ASpzr2TdI+nPuc5qAGTDVHAAUgriKQH3p/kZpIu6LCk/U7QPovRTeO/+uDW41wBdfXiU
         4fs4jLOjb6rg7rVDNLnXBfSwwfeX/lvcIcxpZnuf417+eAXZySJZFsyil15dZMoLzO9o
         YpnA==
X-Gm-Message-State: AOJu0Yx64j8t1Oldqb3vCxN1Hq3gRONoz+aPHBSV879r5EfwqvRfdZck
	EmWtBLNvowPT3UPd4AeZufDZykJ8Ts1uS1Gxp6Y05xiF2UXeLdkipy7tfyqYM1KdEMkvqdUKhVg
	Z3nyo
X-Gm-Gg: ASbGnctiKxTVLzMSPsIxCoY4GL0o0SFAyWcMYaMpi6HawOv1zFvntHAJpZLaFYpjCdU
	wvK9YcMQIRhzwyhgyFgmV1qc/O3XLvRRR8u5H1JY2Qoy4oJt6ISz5ABaSZuxfTDkFt7U9b1T0VG
	sQvnLhUVYgEGOKgENmXil34Y5xwmFhzazJq6geEJpfjRMWuvzDmP4fdk5hahQ50y8QpGaacLfUn
	U43bm6NZ76oBNHv+fq4M9s9747cfKYGneA5DHoa5sOspQ7nvtbr30rDWcxwXPxPT9AAwprGSKue
	XzgzA9nxPviclUUqXF5QDOxbNKtMXGJtBa1Ghf8Y10HgQ5iHaZfVJxQ4Dw==
X-Google-Smtp-Source: AGHT+IEgmb6zbWwhrxFZY8ztzak+9rbHcL/pt00wrMvp3VAhovubEB0W9O8w10W0m5vXMx/vrCcKAA==
X-Received: by 2002:a05:6602:3a17:b0:86c:f30b:1f53 with SMTP id ca18e2360f4ac-875bc485e0dmr380313239f.13.1749653604693;
        Wed, 11 Jun 2025 07:53:24 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5012aaf58d2sm414800173.140.2025.06.11.07.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 07:53:23 -0700 (PDT)
Message-ID: <4856d1fc-543d-4622-9872-6ca66e8e7352@kernel.dk>
Date: Wed, 11 Jun 2025 08:53:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: use plug request list tail for one-shot backmerge
 attempt
Cc: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Previously, the block layer stored the requests in the plug list in
LIFO order. For this reason, blk_attempt_plug_merge() would check
just the head entry for a back merge attempt, and abort after that
unless requests for multiple queues existed in the plug list. If more
than one request is present in the plug list, this makes the one-shot
back merging less useful than before, as it'll always fail to find a
quick merge candidate.

Use the tail entry for the one-shot merge attempt, which is the last
added request in the list. If that fails, abort immediately unless
there are multiple queues available. If multiple queues are available,
then scan the list. Ideally the latter scan would be a backwards scan
of the list, but as it currently stands, the plug list is singly linked
and hence this isn't easily feasible.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-block/20250611121626.7252-1-abuehaze@amazon.com/
Reported-by: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Fixes: e70c301faece ("block: don't reorder requests in blk_add_rq_to_plug")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3af1d284add5..70d704615be5 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -998,20 +998,20 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	if (!plug || rq_list_empty(&plug->mq_list))
 		return false;
 
-	rq_list_for_each(&plug->mq_list, rq) {
-		if (rq->q == q) {
-			if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
-			    BIO_MERGE_OK)
-				return true;
-			break;
-		}
+	rq = plug->mq_list.tail;
+	if (rq->q == q)
+		return blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
+			BIO_MERGE_OK;
+	else if (!plug->multiple_queues)
+		return false;
 
-		/*
-		 * Only keep iterating plug list for merges if we have multiple
-		 * queues
-		 */
-		if (!plug->multiple_queues)
-			break;
+	rq_list_for_each(&plug->mq_list, rq) {
+		if (rq->q != q)
+			continue;
+		if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
+		    BIO_MERGE_OK)
+			return true;
+		break;
 	}
 	return false;
 }

-- 
Jens Axboe

