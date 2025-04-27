Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80FA217730
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 04:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745729897; cv=none; b=BstakEBIpNuRX1kKMnbSgiZmBe0kW+oyvgidpWQ/1G0y9MgKlqWWpyZr54KEcemtYGb6DLvocIUZzHorAOZ9N04LuhtPCP0jpi49/9OhbZa15rZiBdeg6GYXFVrP0x96gl4Dr1k5T+eaDFPS0GVbvfd6OmrSPFDifExSoQN5Mkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745729897; c=relaxed/simple;
	bh=e0DW9foJVDShpIvls+GDptY3uu6gKpPgLM78CyCBh7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Go24PBDLLRoDmC8xmbBy+qlHt+sw7yrqcVWOXobmXVoN1s+j8RaWMEF1WIO/25+GiESp/Vr4bGqUduRozPwKDRyigf/s8Z35tyfY92HkrSh4Ci9AerU2u8AMxL+K39iahmMu2I9nMdB33p82/oP04ugCLfwRAdsZAnCdf1zfaK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=U7FClcDn; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="U7FClcDn"
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-6e8fa2d467fso6659176d6.2
        for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 21:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745729893; x=1746334693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mls8bi9oXwbtGuyG/ERF8Q73E3QOMn+krLNxxr48tQY=;
        b=U7FClcDnb8B6o72+/92dMwHYikh4zKrozljZEkk5W6uN21OwEQ5WBzlvZ1V8BDgVH3
         DNBnyVPB9klT5VLxYTT521ZaxK2Fr2AVnxCie83di6Y4UEW8GoVQaASw89k1Fz6WsnMP
         jNY6BcWwCH5dppfa4gENlYrhCX7/zFP31hU5pyjz+pxhF+xyxzA8N+z+gVfmOhUbq93Q
         f6eVX2fuWHui2Jsm4K71LsC8WRBbcfAdYrM2VEu9IOlrORdjGAs4lgO1OmoWyrxSuUPQ
         iKwf8OF3N4wyV6axinCRZy2m2EViAlVPgBB2btEShX29+zvLGGawn4cmf7DIXF3jrsQ0
         568Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745729893; x=1746334693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mls8bi9oXwbtGuyG/ERF8Q73E3QOMn+krLNxxr48tQY=;
        b=bFEsVjQh+j52w9xzvmLciDkYXIkTCA+ddi8Yb0l6Uf9DR0TGy+YoKwkmNukh1bDgI/
         8EkR5+h07edoEwx7g1GDSj+KrEk9P2HTe3h+8JD6zBAeprBQYpdBIDHVrmjZvgh1unnu
         COnQrAhIrc1QsBjyFKR/mmtOohyOZhJulPQ8SYNudmcydfja2R6w75MwHMf66w+U2qQf
         k9r08dBxFFFUG8WENgG6eoFjWcV9iNkW/8JvE9o+8YKW/G5deeVDGWUvOZUxwusRFp2G
         mYBBehgjtd/cV55A8b1gN5U+EJs/repTo7pIGzkGFdQOxajtH6nS1wajeCnQvmtLQzCF
         uWKA==
X-Forwarded-Encrypted: i=1; AJvYcCWj27HE2vqcvLhIXler15PeLEBoSccq1Xfm9lLr/g5YeZr/IS2dqSWOKRWCFt/ShXKBWW55Dp1egc3uTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2tj+ei/4XH5Zj2sFG+B4Zi+QPLxeTSo2gRP0x3Wp7wYTnz94
	VM55F0HmOY6uJ9reWVjTu2SyDm7qPhTElJwdeWKppw7g7+dXAxtwGdXOLnkgv4uW6bhk5/JUFq5
	tDB3Vhlco+b9n7zS7upBsFBNhmgQk5Yj2Xn580WkbJP+8fX0F
X-Gm-Gg: ASbGnctj+8XMRErkLr7uqFENZBy81YWMdAr3PqO00Z0eWzx9n7ASVzefkCITJjuSHBk
	84NDaoWVFF/vfc/ckIHhBzvctH0coR7CuBfG4T67jxivlMYM0iGIkJm6jDK2sbcEwdMRkYXgPAk
	JeRYcKEHWPsviWTrYVQqy6S8V73BemcWGp8OJesZhjhpmiAlHaujSmtiovC8oNADqK33GgQFSYl
	BY9D0T4VAhfteJ/1qW8XI3EdHgAyQ2mSk+KnNF+8niidpSYP4kEUVwdoIJoTSWksHnPOrj0+r3v
	5c1OFrQsr8hXbwT2l3MbnuMbCv+Bfw==
X-Google-Smtp-Source: AGHT+IHdNXBk1TNme4nkQxEWedva+R+7J2Qt1t7yuieBpvFMfs2uzzJQtHWXw+UwHKBEImovtWTlhJuV24zR
X-Received: by 2002:a05:6214:301e:b0:6e8:9c91:227a with SMTP id 6a1803df08f44-6f4cb9217admr52468306d6.0.1745729893518;
        Sat, 26 Apr 2025 21:58:13 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6f4c0a84a54sm5828916d6.50.2025.04.26.21.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 21:58:13 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DBB8334031E;
	Sat, 26 Apr 2025 22:58:12 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D965AE40C3E; Sat, 26 Apr 2025 22:58:12 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/8] ublk: fix "immepdately" typo in comment
Date: Sat, 26 Apr 2025 22:57:57 -0600
Message-ID: <20250427045803.772972-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250427045803.772972-1-csander@purestorage.com>
References: <20250427045803.772972-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looks like "immediately" was intended.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7809ed585e1c..44ba6c9d8929 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1180,11 +1180,11 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 	}
 
 	if (ublk_need_get_data(ubq) && ublk_need_map_req(req)) {
 		/*
 		 * We have not handled UBLK_IO_NEED_GET_DATA command yet,
-		 * so immepdately pass UBLK_IO_RES_NEED_GET_DATA to ublksrv
+		 * so immediately pass UBLK_IO_RES_NEED_GET_DATA to ublksrv
 		 * and notify it.
 		 */
 		if (!(io->flags & UBLK_IO_FLAG_NEED_GET_DATA)) {
 			io->flags |= UBLK_IO_FLAG_NEED_GET_DATA;
 			pr_devel("%s: need get data. op %d, qid %d tag %d io_flags %x\n",
-- 
2.45.2

