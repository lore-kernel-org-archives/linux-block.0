Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D862C11E3
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772052673; cv=none; b=vC+ldLsE9twhW6L4jTeN4i40zIQ2TV/JsKP5LZ/qimDoODj/3lh5XPNuYMA164elbRnqnPtTbT/wJuThYx5EmqFMKLa609dh/NwL1ac1JkE6EliVZWLgmmRtL0EWo8swZW8mDRhm9gH/tU4nG2a5+lHBj1PLxMpMdVaV2z7pHag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772052673; c=relaxed/simple;
	bh=HL65B5GgQUboZJtHo4MpUp4u8DWjZM2AlPwyRW/PXnM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Byt6fnEtDclXCYvwW/5xUY7lKZ5rhAFdK6vCVeG69577/WhoILv+det5yHG7YCVSYyc4KTsMx3Iy+cfd7Zpt35u/EBaX9mP6v0OPERIRXR2iyU7lrGHD4I/vHWk1VrUK7pfO22lXLClukHU50QxEX+74MLYYJIVzlvbohiFI+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQm0FKlv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQm0FKlv"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2adba04421eso5014845ad.3
        for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 12:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772052670; x=1772657470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kET1qZja2VQ0oY2kfrX3Nkg2vtG6dogTO5sBP79DSVI=;
        b=gQm0FKlv5YHU+cruwL9BCG4hGk/rwQGtMVKaN9LxNVB+6XOk1Hj4nBjTqG4ceD1yfu
         3Q3Av3C6mKmmvaKBxACAhVVCZOuch6wbOqcVET8IZg+QY1PWxXsLL6i/0ODawGeBbVtM
         n6jQM/6DSqaC47qP4QGXqArBN9qc/8i5Xsqe4QKYnxuUN8XS98ZV5hWk6Ay+dwrUFVm7
         AUuWS95k9U0g0vklZ73tT9AAgR9E8UGlPE2Nddej1jbN/CKvZZu67wI4uEX8WjWjoCup
         LCnHrYL64sazHbR/5h377xnA2uH5PPJyiXz2Q089rh4g94+H0MiKNHB/GT64+9y8KI6C
         URlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772052670; x=1772657470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kET1qZja2VQ0oY2kfrX3Nkg2vtG6dogTO5sBP79DSVI=;
        b=EOZZsV1sXlRqjri3Vq5gIjbxs4WYLG4lFvlBFCsQyFO9hr0kGSr0ffCGGtbai1zuSI
         A+TMEROXJXOVMqukv+mb269ydnaZHY95DnD/TOY+XljDocZ1ZOayVvDWo8lZt1kzUhWG
         LcPGS9dhQJ4jiqfZFdHolWwJXs39ufRqWKKuNyyohxCNYoTB75xvmTv3fT1a4ucUMUv6
         pQHTrFJdWTRmToqJW14bh+M4kIBtTsdqSNIQ20GrhpR6W7ATB3lpVVK357nOd0XGHzkp
         NtWKubc1yLYBbZTPC45l5HtTcXP1xkUH48ztLMGn8+IVeURky+d4zfy+nwmPj+lxsShn
         FSww==
X-Forwarded-Encrypted: i=1; AJvYcCUX3pNJFF6egUsuuUtNyTcEP4KsbY6/2qtlkIzZIW/xywKLvcpb+WSuO+Cc8ZDQZLyBdySvdc0Z8QUUQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbyQyPEjvMDj7eDCTKWm3A3sVD3GuGerPt0LhEr79oEw3adc64
	E+iCFOoYsJddtRzfS+kZDWGnZ4qUG45qOxcI/rstJcpsVRr0Mw3EcKWuiJjTeCDOjK3Be46RWtG
	p
X-Received: from plct20.prod.google.com ([2002:a17:902:d294:b0:2a1:5235:1502])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b44:b0:2aa:f2f3:bcab
 with SMTP id d9443c01a7336-2ad7453c33dmr158986925ad.47.1772052670067; Wed, 25
 Feb 2026 12:51:10 -0800 (PST)
Date: Wed, 25 Feb 2026 20:51:05 +0000
In-Reply-To: <20260219004940.2594201-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219004940.2594201-1-morbo@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260225205107.2837665-1-morbo@google.com>
Subject: [PATCH v2] blkdev: Annotate struct request_queue with __counted_by_ptr
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, Daniel Wagner <dwagner@suse.de>, Jens Axboe <axboe@kernel.dk>, 
	Kees Cook <kees@kernel.org>, Gogul Balakrishnan <bgogul@google.com>, 
	Arman Hasanzadeh <armanihm@google.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The queue_hw_ctx field in struct request_queue is an array of pointers to
struct blk_mq_hw_ctx. The number of elements in this array is tracked by
the nr_hw_queues field.

The array is allocated in __blk_mq_realloc_hw_ctxs() using kcalloc_node()
with set->nr_hw_queues elements. q->nr_hw_queues is subsequently updated
to set->nr_hw_queues.

When growing the array, the new array is assigned to queue_hw_ctx before
nr_hw_queues is updated. This is safe because nr_hw_queues (the old
smaller count) is used for bounds checking, which is within the new
larger allocation.

When shrinking the array, nr_hw_queues is updated to the smaller value,
while queue_hw_ctx retains the larger allocation. This is also safe as
the count is within the allocation bounds.

Annotating queue_hw_ctx with __counted_by_ptr(nr_hw_queues) allows the
compiler (with kSAN) to verify that accesses to queue_hw_ctx are within
the valid range defined by nr_hw_queues.

This patch was generated by CodeMender and reviewed by Bill Wendling.
Tested by running blktests.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Bill Wendling <morbo@google.com>
---
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Kees Cook <kees@kernel.org>
Cc: Gogul Balakrishnan <bgogul@google.com>
Cc: Arman Hasanzadeh <armanihm@google.com>
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
v2 - Reworded the commit message to better indicate the AI agent involved and
     how it was tested.
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d463b9b5a0a5..540c2c6c9afd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -502,7 +502,7 @@ struct request_queue {
 
 	/* hw dispatch queues */
 	unsigned int		nr_hw_queues;
-	struct blk_mq_hw_ctx * __rcu *queue_hw_ctx;
+	struct blk_mq_hw_ctx * __rcu *queue_hw_ctx __counted_by_ptr(nr_hw_queues);
 
 	struct percpu_ref	q_usage_counter;
 	struct lock_class_key	io_lock_cls_key;
-- 
2.43.0

