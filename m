Received: from mail-ot1-f103.google.com (mail-ot1-f103.google.com [209.85.210.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AFE1FF5E3
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 03:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765250078; cv=none; b=ZatC1E8pwHqpY9oTNpPdNltJt8r53HANP0ioKLeLE6xRr4t8XvxVSa3TmKYAAMEXra4uz0Y5rdlw8SZheamwCK/xgoFoaf1lKBQS18OOq5Z23w25it+ye0h3CHjtEpiQXzQEG1Grobp+gjj6XmQCLibjwcFhYdtj4Rncxwh2W9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765250078; c=relaxed/simple;
	bh=ZnZgBiNuPteatBPa3l+Ueno+E6tP+ZZkudlZjhS4WIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GiXr0FG7ORx3ZpcMunvPECpVhNRieNferzbsHdotF3bksWXZn9UFs7ie/X7gmDpuRyZl/MI3YsWWLXEN0pAVlmOXtZLlwSZ2aqPolZeyOZO4J58WFsh3M33us7GMby/K+1BgisfA2v7hUiAue/OnjxYvp+sWpowVNn0bLtH2Hh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ACE0LPCw; arc=none smtp.client-ip=209.85.210.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ACE0LPCw"
Received: by mail-ot1-f103.google.com with SMTP id 46e09a7af769-7c78003b948so863072a34.1
        for <linux-block@vger.kernel.org>; Mon, 08 Dec 2025 19:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765250075; x=1765854875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AhV7UuiRfziAgkz31PmGRqa1zi8I8b6M7zmhCcc5CHM=;
        b=ACE0LPCwAnq1W1t8kYGAVU648U/UlIghvjZgzwDNtZfNvz7Nb6H6/aA+7Q/xYaoLJG
         qbgjv4/61ACAIPJrL5Ll++njwlqHyvbnfmISUlWy+SO0zL4/mZT5gXAatx0TKva1YMeO
         S/itCVgd37Tp6j/GpO8ilrKeBUGe6sPkdNUrf7tn9hADXcoY715RyM2BahUoyUSyXSbJ
         O8VmBxki/Gq+R6HLGfuOC6+pByMOjCNNL/UiLAeXDMMO2bxLr6PQH7kOReOAWBDwusp7
         XHNmhWt1wM5CVpEF7jroLKTA1UPzmBzokDfL0elH6kQwYwQeGWaH+qh+yAgU6lRHBXx+
         OAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765250075; x=1765854875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhV7UuiRfziAgkz31PmGRqa1zi8I8b6M7zmhCcc5CHM=;
        b=Nu9V2KXm2ZD1+gqlywT6lal0+EDnIBy/pKbLxcWfrTehr2d42xx2SXELjqDuTvq9KU
         WpiOCQl7Kf4g7DV/dy42iyYSJ5Y/y94ehJtd4N2idfqYN//AH4VyhVSqebwGL7yDTORX
         n+C/smCe8pgOmMSBdy4cfvTOoQOMuovIO9ZXpMiou8lLtfp5ipJtHPjFRmmAupPTHViP
         ZcB/B4X20MR73bz1BxkscZbVog+cmx7IKl5u9wAvrr4nl9YHJ8da12S2SDj5iPF5yHoW
         09TnKsmtKyswYm/oHHmrFO7u1n1Lei6zk7D7RAgMuDJULL6PH7TD97xTPT3UW5yHV37+
         OSPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+KVDNdOiypu0dhcawGXdduTaDvklV2gmc+PBAmGiXen7UeRvgzr/A6XtJWhKTUGHkNAU8L093SjJcNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLYLV5lrYm66ArdfH03ehtPGs0oazxHZH4zwIg358b7OvRS809
	SikX3VialJfc0yjpnmZ4FpicCPhpxywyokSJcftp8mYqpeqHlrZprlbSuZl3EXH9C+tHH3m29qK
	yxz++x21cUaucJvdAvKvTz9MXKKB2U8vwnEScUgm0oc5v8WEt3m1O
X-Gm-Gg: ASbGncvyx2bJwvDFGWY3vWx+2ds5QEE6yM+ExqSUlH056tTzlGPLcptSbErNpBGnFAH
	m6y5maObv4bF+r/qfgIvo5gEizkTV6rLffKA1hTnJuS/BCwCmCzO1BqFz1Pt/8Wh30zzbFhK4Gd
	ZkDfsyXTgLIuEEV3t60FOCcmuZQkFGNpWozYTt0whSDgvu7wXDQ18HOA5qRNheKOhewQsVtQvQa
	NaleCjGkoA7wd4yZZaxgi3EiNsKWh6WrY+cyrMb9DDxkPcI6TMYJBWot9/AqNcogq1hu3l/zar/
	/XpkE46nggD5EDRi09kmexd4faXaBeZOin/7AJEtl0MC3qzVcylYNfP0XsYMr8aDFJrYLXqfvZ/
	1W47vh9jVabANrsjHEQQHa3Xv8xg=
X-Google-Smtp-Source: AGHT+IFTQjPQj7BCoxto1UVPYn30Ma8tJts2Mm6/SWho5u13K7FUjoDUE793VaJSpxPd4WWXgIhVohrddLSt
X-Received: by 2002:a05:6830:25d0:b0:7c7:59a1:48d1 with SMTP id 46e09a7af769-7cac1eddbecmr595381a34.1.1765250075291;
        Mon, 08 Dec 2025 19:14:35 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7c95ac65768sm2293758a34.5.2025.12.08.19.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 19:14:35 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3D9BC3400AF;
	Mon,  8 Dec 2025 20:14:34 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2ED0AE41461; Mon,  8 Dec 2025 20:14:34 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: don't mutate struct bio_vec in iteration
Date: Mon,  8 Dec 2025 20:14:23 -0700
Message-ID: <20251209031424.3412070-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__bio_for_each_segment() uses the returned struct bio_vec's bv_len field
to advance the struct bvec_iter at the end of each loop iteration. So
it's incorrect to modify it during the loop. Don't assign to bv_len (or
bv_offset, for that matter) in ublk_copy_user_pages().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: e87d66ab27ac ("ublk: use rq_for_each_segment() for user copy")
---
 drivers/block/ublk_drv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2c715df63f23..1e1a167d776d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -924,30 +924,30 @@ static size_t ublk_copy_user_pages(const struct request *req,
 	struct req_iterator iter;
 	struct bio_vec bv;
 	size_t done = 0;
 
 	rq_for_each_segment(bv, req, iter) {
+		unsigned len;
 		void *bv_buf;
 		size_t copied;
 
 		if (offset >= bv.bv_len) {
 			offset -= bv.bv_len;
 			continue;
 		}
 
-		bv.bv_offset += offset;
-		bv.bv_len -= offset;
-		bv_buf = bvec_kmap_local(&bv);
+		len = bv.bv_len - offset;
+		bv_buf = kmap_local_page(bv.bv_page) + bv.bv_offset + offset;
 		if (dir == ITER_DEST)
-			copied = copy_to_iter(bv_buf, bv.bv_len, uiter);
+			copied = copy_to_iter(bv_buf, len, uiter);
 		else
-			copied = copy_from_iter(bv_buf, bv.bv_len, uiter);
+			copied = copy_from_iter(bv_buf, len, uiter);
 
 		kunmap_local(bv_buf);
 
 		done += copied;
-		if (copied < bv.bv_len)
+		if (copied < len)
 			break;
 
 		offset = 0;
 	}
 	return done;
-- 
2.45.2

