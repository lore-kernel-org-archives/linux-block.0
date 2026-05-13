Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6CD3B0AE1
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707143; cv=none; b=sJJqULKoNx42Mtk/EaclVPh/ieoRro+pr7pqPm7ok3R+r9ooPYB5K7soms0DqGKRhIDV3woKY4iM0zC+1qyGWGtieAHctU3HY2OY4u3Cj9seEF7WZgPUvD6xCPmOHTQQB1jtq6CFqxtNEJLjFWdEnG5WRuoaN6FE+POVTq3oAPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707143; c=relaxed/simple;
	bh=kGs2WnbC6y0yqjyWpEWDsbi6xUYHXc/nXh53NKQFFBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpigpmeZJLMdS/hr6Dha0eS5ii5qXohNoMpGtHlANbqNsYdawf/7GgVhH+iTuCB534yCl1jGY+ScsKnLW8vYNV+GMCDLXetSdl0GO56t9rTTwA+dvDH64PurEl39fikgxtQMeYGcCxJdc6x+GzclkPaQVRIW5gGMS59HOuohM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YuoSDRPd; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YuoSDRPd"
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-50e5e241feaso11169381cf.2
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778707140; x=1779311940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3GgPB/qY/ZnxxAx67/XgeDITrY4cObzikz91xtmMpg=;
        b=YuoSDRPdYvGeqKWBWyipO0rriA1+FBwq0SUqsrX/w9zc+3K7dT7goIvwJ4BvKcd5Rz
         LrOvEkFeANs+RcFafvKKx9xpiJNon1jJrkCB6GV8eVGA5sxrF22WpJSsqbTA5opT4CD4
         l0hH+Ku/e0eF/hf9xE8nke/JXtzfWHRbyGMWN5zpRy0baWJsLcAc6z4y8kts2iO+CNpM
         iPUfRnNkkoAX4MPC6BX8m8eafLpMl9sOkZkxETeKuPKzx7THqI8OJ1Lv3p9nTbSZAn9s
         ElJ6+/AVgOb8TmmvlS8IPeHjYSkrCvUB/OWU1F2lQ1FFRU1OTDzrc681h9TLqE+7WASN
         oEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707140; x=1779311940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f3GgPB/qY/ZnxxAx67/XgeDITrY4cObzikz91xtmMpg=;
        b=oztwh9NKsJ9pnWjh95jU5qrTuG+OYxLy715/09o48NK3ICwugUOH2hyhTqie5mLzj0
         y3BfdJSHkK7UJ7zpxseShZ6Rp2QR9NwnS0TZmmZfZA1ldkX/bK4zuAwYp2qDfugCrT+o
         u/mK6lHrgKFw2EDGVk9QbJD3vhtBKomMrwak6Mg6OYLfTRXMhc0DUEV9Der9VAMA5pjS
         YNe+L2uPlbZWxLc3ssaZSsEEPtudG6xl2o0Cy3/lf+GOxl5rvQOh1sJwSp/1FxrIa/Yj
         GH/v00Ja8vjjU82OGxXRhY2tQ2UIwxLByrqEASkJ5AFsYwl2ozFoqX19eskjPGFrH5pE
         gCtQ==
X-Gm-Message-State: AOJu0Yxkw8pjoiaNHGBH1UC0a+/OQAHSa7U/xbrvhjaXCC0088I4uQen
	ewf1caFDM4BWw6fh97t+6vIAZlnCG6nborn4OjGvlYZKCswfOdW8BzHg5GpmPBhyqDeAwYC10ig
	jHQ8nbU9QJ1qrffa36cu5bngbFpU2uivgkEF5QOIlzaH2BaCQNVYe
X-Gm-Gg: Acq92OF1c6+nLcoK2S6qvyuh+yAlhOUVahOocjAWqIM1d9e/Ha1Odv67DtuM0UWdle9
	2ggxIWkLdAaQxL0b6XBFtkTClmzu09uhaH7DSNrrEzcoSXdTUC0k8yixe1qCeIbomBEYHO4bMdb
	rivLOxBNSuvxRCbHVusmmDxoPQYAn3pGW3DHGNDyPpvWSV9Ptm3byV1HfFwsSgFBC92nlqHXI2N
	qZXIdH5D8iMquLk5ou1DtBUS60e77G9l1H/N7Ap+LUnf2hfqpSzKm8LoaVCPuNhVP3iYrO8cPLW
	i4gkxhP1VPUZ36ooJJysgrujoKOY5WTRLMnh35AtLOpCH016MgUSmIBgVy4l6zL2sy2G8uYwXN1
	NjKBREoRV+o1uTXJVBet1DpjEBGnBdlgOwEaFnL4=
X-Received: by 2002:ac8:5a4f:0:b0:50b:3489:5495 with SMTP id d75a77b69052e-5162f6d5c6bmr46107531cf.8.1778707139566;
        Wed, 13 May 2026 14:18:59 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-51645861bb5sm3171cf.29.2026.05.13.14.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:18:59 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.46.22])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id EDE32340C58;
	Wed, 13 May 2026 15:18:58 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E8D62E41188; Wed, 13 May 2026 15:18:58 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 7.2 1/2] blk-mq: introduce blk_rq_has_data()
Date: Wed, 13 May 2026 15:18:45 -0600
Message-ID: <20260513211846.1956810-2-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513211846.1956810-1-csander@purestorage.com>
References: <20260513211846.1956810-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add blk_rq_has_data(), an analogue of bio_has_data() for struct request.
This skips one dereference relative to bio_has_data(rq->bio).

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/blk-mq.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581..4349aefdbc87 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1102,10 +1102,11 @@ struct req_iterator {
 		 bio_iter_last(bvec, _iter.iter))
 
 /*
  * blk_rq_pos()			: the current sector
  * blk_rq_bytes()		: bytes left in the entire request
+ * blk_rq_has_data()		: whether the request carries data
  * blk_rq_cur_bytes()		: bytes left in the current segment
  * blk_rq_sectors()		: sectors left in the entire request
  * blk_rq_cur_sectors()		: sectors left in the current segment
  * blk_rq_stats_sectors()	: sectors of the entire request used for stats
  */
@@ -1117,10 +1118,18 @@ static inline sector_t blk_rq_pos(const struct request *rq)
 static inline unsigned int blk_rq_bytes(const struct request *rq)
 {
 	return rq->__data_len;
 }
 
+static inline bool blk_rq_has_data(const struct request *rq)
+{
+	return blk_rq_bytes(rq) &&
+	       req_op(rq) != REQ_OP_DISCARD &&
+	       req_op(rq) != REQ_OP_SECURE_ERASE &&
+	       req_op(rq) != REQ_OP_WRITE_ZEROES;
+}
+
 static inline int blk_rq_cur_bytes(const struct request *rq)
 {
 	if (!rq->bio)
 		return 0;
 	if (!bio_has_data(rq->bio))	/* dataless requests such as discard */
-- 
2.54.0

