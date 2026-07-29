Received: from mail-lf1-f98.google.com (mail-lf1-f98.google.com [209.85.167.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BBD42C506
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345049; cv=none; b=m1vz31ARDpYSaNNFEEK314RDVSAUk9fh6qHOJd0hHQUrBcZjVccfeePmwh4A5kNYGsOb9UKIzpnIOcNYWYzGyW0qMzuADh3YUi5KdhATlx9iZxmCatMhl2QQOXXcqSWCaNwKfD4JfQbbp+96619tQBdAE+yBZ8XXF0636bHyskI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345049; c=relaxed/simple;
	bh=cNsm9srFKdcxh4Hu4o49svdqGrknL6dwkH/kWJZbx3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEZNgRbYXLZRJsj0RJ06yBb1muYVUkDyAlAC++SpAE93QX/LM9/WZoMiFkLxUo6jDH+oxGg/Nkrsxoj8IxzH0LAR9h1KCOc3QaTMuv4ts4ssL7HkhDgwbVLAkeOp0ciB5KMDf0gUsu+i9kCW0f7/2CWlC27kjg6bN79cZPLQlr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Vx+fgW5p; arc=none smtp.client-ip=209.85.167.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Vx+fgW5p"
Received: by mail-lf1-f98.google.com with SMTP id 2adb3069b0e04-5b2a73d5fc3so114065e87.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785345045; x=1785949845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MUVXONXXewungYBAriez9R2lFijUHBs599t/+Ybt3RM=;
        b=Vx+fgW5p7uDdBzuHKIIZFqpMOof768Tk52EViJP7NmwgtdypxctrSr3rfIfTr+QLmV
         QoWMpV3zeBFQETZwcqwethbt1oOhkyjtgIEAyXJy0sypSI5SgfyKPo6qo2f+DfhD9qvs
         kUNtbWrH5gwTAseFubJ2Cbx+oV4ba3AWXk6kZ/pKMS4zZi9Ave/HNKUwuwl7nmikN07b
         1oneY0trhXZgv74ti4nUxV8e8ahToiTTr/RZ631ixhG5kLGroQTfvYoPj0cchU+Iwz2r
         D+0ETt0FoP8AAhBM2JQw4zC4oktg5R0/E1dfbtoiObsLKZn9sgELbaQrqL3pH+SrKoBs
         W7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785345045; x=1785949845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MUVXONXXewungYBAriez9R2lFijUHBs599t/+Ybt3RM=;
        b=la7S9hdVb0qsoMIK+tHgMuE5sQ8vC/ukYMeF/5VJsIm4v/EoJqvrHhZxYgIHKXucaA
         wxPWKKHQbX0lMhXozTFnc4EToOk1ky+KyV/rwJ0m+XvGSFagTs0pggqKool4IAzszd8b
         bWr7mdWJ90Q07OixCr9bsClGLlIwcRhkLl8qLhsI2K8oJnw8dwNAPYZZHcAxwH8vf5XJ
         ZHqoczI/yJAKlKxjfyUkkNJbTuFmsWC3URmYr88r6qT55lHaoK/ygJX8kPB3PvCo7Tfz
         fCws6IHkBZMQy97ASstJqULr0KnP5HQzbNOg5IiZZRqAZLV5NXPqh47sL66usrhI5jIM
         PRfA==
X-Gm-Message-State: AOJu0YwyJZ7YPPs7hLwyhrBkqRXaUBG/gyLngZEQpo9qZqkoVZrUX2gZ
	W/dVw5h5LLEAo9stB52t2o80TFPSwuwHobMvcnsHZ60TK2yv+HNqljpcscUC6mtv6MTZ3uiKX1U
	PDh7c0b27xmfrPqnPwmGmBw+su9xNy+ZDWLRrHqtGemzZEKepPTWD
X-Gm-Gg: AR+sD11uACtGnF5vMDEniluj/fjFr4uSnEV8HxMLKCUDqOIlv2HZioFxzpUFLcjNuZX
	MF6NI99Aqa3Dc5ZHWmURJ63EUYrIUx60Z91PDghIaPqANYcxIhlr/xKeVCF0amMcYdqR2hZFvhx
	el7QhaxZE50sYjeKRAMGzU0aqiebPxWA2N0q35RGM5aNfEj8teXKHE42lzhuWiPyXNsI2ftrzIq
	KWVM7b7d1memOIA/+fi+whSqmIaVi2IFfG4ImmeyW+s891K3y9zRYmrPcZH+tYga4ELCVHW3veb
	vpaZbK2aL+3UYxn/4hEbWQJrldJKcvitHzhzVDYjJkamGH0eZ0cl+IIt4IN5HHEZ1A4IbJUoKg4
	P6ERcNQfXxQo+Jmf4Sg==
X-Received: by 2002:a05:6512:6cc:b0:5b1:4fde:61a with SMTP id 2adb3069b0e04-5b2d0247dc8mr1433984e87.2.1785345045371;
        Wed, 29 Jul 2026 10:10:45 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5b2d76efb56sm281541e87.30.2026.07.29.10.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:10:45 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id AEF9A401D5;
	Wed, 29 Jul 2026 11:10:43 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id ACB04E4017C; Wed, 29 Jul 2026 11:10:43 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/3] ublk: check import_ubuf() return value
Date: Wed, 29 Jul 2026 11:10:39 -0600
Message-ID: <20260729171041.45061-2-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729171041.45061-1-csander@purestorage.com>
References: <20260729171041.45061-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

import_ubuf() can fail if the address range (provided by the userspace
ublk server) is outside the allowed user address space. Return that 0
bytes were copied if import_ubuf() fails rather than passing an
uninitialized struct iov_iter to ublk_copy_user_pages().

Fixes: 981f95a571e3 ("ublk: cleanup ublk_copy_user_pages")
Reported-by: Ming Lei <tom.leiming@gmail.com>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4ca6ec738c93..098e046505ad 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1473,11 +1473,14 @@ static unsigned int ublk_map_io(const struct ublk_queue *ubq,
 	 */
 	if (ublk_need_map_req(req)) {
 		struct iov_iter iter;
 		const int dir = ITER_DEST;
 
-		import_ubuf(dir, u64_to_user_ptr(io->buf.addr), rq_bytes, &iter);
+		if (import_ubuf(dir, u64_to_user_ptr(io->buf.addr), rq_bytes,
+				&iter) < 0)
+			return 0;
+
 		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
 }
 
@@ -1494,11 +1497,14 @@ static unsigned int ublk_unmap_io(bool need_map,
 		struct iov_iter iter;
 		const int dir = ITER_SOURCE;
 
 		WARN_ON_ONCE(io->res > rq_bytes);
 
-		import_ubuf(dir, u64_to_user_ptr(io->buf.addr), io->res, &iter);
+		if (import_ubuf(dir, u64_to_user_ptr(io->buf.addr), io->res,
+				&iter) < 0)
+			return 0;
+
 		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
 }
 
-- 
2.54.0

