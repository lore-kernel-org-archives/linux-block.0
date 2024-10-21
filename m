Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160381E3DED
	for <linux-block@vger.kernel.org>; Mon, 21 Oct 2024 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503344; cv=none; b=PYOQg01uIkeALZcwo1lU6KDgTay5nnPrn+Id9qC6Qc5q4mmOA2xpK5H0/ci1c0wg3MgC2qZCWztvp15T6Y9hDNdGgDLOuaEd4BybtR450IvNz4E0UZ04RcuTKDo5PyZ0o2ZY8dOo+jKK+O0+j9wbAc0LtgGKmAxRIU5KlrY5HJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503344; c=relaxed/simple;
	bh=/Aqo9WPzE2ID4oasxty3yzeeqaODshxgbd4TNFTtOyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iJNDOxfNaKBLe50BVjX4470EQE3Qw4OjjUy/hf1QKdNSnLh17RvMSMEhdOS8qOgUn6Guoje5oAqCuBGTzLJWD/C6jSwu+6wp0h4rss8Bi2/mi5gLDXnrIDzLRqNmcLT/3ZdlFwNDAsYmXX8pHJ+cBQXqp9mW1g3zeZz7g3Zuy48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OrF0ntAH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OrF0ntAH"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e5a62031aso2907346b3a.1
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2024 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729503341; x=1730108141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GsT+de8zLV+6IwIjpVLKGD78ddm4AlMrsbMhyzImO7o=;
        b=OrF0ntAHXefTfKyPQFjNqZ7pW+zyRV8NQ0n5VtijAlCa7OpI6lTTw67EVjkbI7GiXO
         45LbM66jWD/LnfhsWDJyPNYNOvrSUS9xk5oevHVgZGnD+nsbOoSeVFC4KATw7vnU50+p
         oRQWpHRyJGOUGHDy0IKRK5RzyAmKfBcwoFCXzHvFcSdoM69FUSYikEtFcJYbQWKB0gcD
         ii4vN9x5srn3KcUf6fgjV/GwyfHKI4PMcnB5TD3+U1IFeFoZl1bFxSjDsckmi1Ejuamu
         /gWENIhTFxsRUkhjqnv/RGOrKHOT0BjTl5ePPUrHOBuvA/x+0kL1Qdc5SMz06pxvPiTG
         0p8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729503341; x=1730108141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsT+de8zLV+6IwIjpVLKGD78ddm4AlMrsbMhyzImO7o=;
        b=o+4O3BwpEf4M3O+0Pk/RwqTJCXCgrL92sA7O/dNesSj17KsTsqreOfLnlu44yTyX8L
         +yFNb2g+XA3lwEUX/u6m9dT3UBm+f9SX8jg5szy5iuNOQmQG8dgsm4FPmdIle9duSkQ9
         c/vcLiRGdc/q16Hz8JthLyW1c2T0vhxFC4gec6/Cyc7zi/UfCwhSPyENLFnF0ESus4Xt
         /N+VOX5ZuUe960eSbgMRUIRB0+tfgfIzoz8Re0KJhpSttE2sHfwj8jY563TneprFIeRp
         kFrir5B2BchtyOaUeXzEGAKTPjYRNn7WTXkHW1s0QKfoih2W+yW/mPw8Zz9feIdTW2OG
         d1hw==
X-Forwarded-Encrypted: i=1; AJvYcCXNpFaN8OSXnntjRe/QU0xbFDpc0mQjGaKJge4xy07FWNqc3aouDwhOneu5tfzp9bE9p+yUI8DPFX1vZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLz2RfxTxfo2yQfzHTS/jvpgWrj4FB+gKRJP9Nahs6RAGUfPPH
	2xFGA1J3B8n39gQY2gYfktgyd1K9Koi1ptZ+TcS0xiRljQESLVK0USNloTHJHIo=
X-Google-Smtp-Source: AGHT+IFG92jte1IkPnhsjRpkj4LvK1CAKm+mAn9i576/YceM9UKswKVvkdfH3hCvGZ0NwGL/6YsT5Q==
X-Received: by 2002:a05:6a21:2d88:b0:1d6:97f2:5f72 with SMTP id adf61e73a8af0-1d92c49fc1emr14116941637.3.1729503340762;
        Mon, 21 Oct 2024 02:35:40 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1408916sm2427653b3a.199.2024.10.21.02.35.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Oct 2024 02:35:40 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk
Cc: josef@toxicpanda.com,
	oleg@redhat.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] block: remove redundant explicit memory barrier from rq_qos waiter and waker
Date: Mon, 21 Oct 2024 16:52:51 +0800
Message-Id: <20241021085251.73353-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory barriers in list_del_init_careful() and list_empty_careful()
in pairs already handle the proper ordering between data.got_token
and data.wq.entry. So remove the redundant explicit barriers. And also
change a "break" statement to "return" to avoid redundant calling of
finish_wait().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 block/blk-rq-qos.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index dc510f493ba57..9b0aa7dd6779f 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -218,7 +218,6 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
 		return -1;
 
 	data->got_token = true;
-	smp_wmb();
 	wake_up_process(data->task);
 	list_del_init_careful(&curr->entry);
 	return 1;
@@ -274,10 +273,9 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 			 * which means we now have two. Put our local token
 			 * and wake anyone else potentially waiting for one.
 			 */
-			smp_rmb();
 			if (data.got_token)
 				cleanup_cb(rqw, private_data);
-			break;
+			return;
 		}
 		io_schedule();
 		has_sleeper = true;
-- 
2.20.1

