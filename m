Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AE329E116
	for <linux-block@vger.kernel.org>; Sat, 29 Aug 2026 02:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787969625; cv=none; b=PYHs7qB0c1PbQjpIhwVmsso1kbJ9StUUA0KdEWn0yx5NmuwxBEMdYGlAoQ64bQ+KEwhGI3fNsYAiBmY8aPLg6ZXy0Fm546E1wTCrIt1LCl2CrnoQn4JFz7obclK/afVNdM9g2kKdihQ0SY6V/dwIVN6D+ReAYshswSQM0z7QNBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787969625; c=relaxed/simple;
	bh=3bn9nfKrFnynX3L361IeA7SkPPLZeSBoNKVXABaJAMk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Wm7eGhrKoCWJnIj6tMipDyF+E7JpWAIGlMgoCAgsf99Qy8JCW3w4NzzAL9FCu1aEHxvXw/t5mJr0utC7/fJF1gFMP1NlWMWV5diYNBj7koHvAXpm4AK8U3+mL7ouyg2wyVYtNg7bFXmb+sJrYl/qz6Nq2vG83rvvpOAvXXGrYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mhs1xfaI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mhs1xfaI"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so1281309a12.0
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 19:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787969624; x=1788574424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3sLbIgmRC2vdoqzM1soIxVMiMdV7lkHCoeOY4VG/jB4=;
        b=Mhs1xfaIbtngKZU+tFWXRIfEEfjOckHkO19TYUogzuIHzeN+BstSnblKGUa5XTw97p
         thE/49P01HpWiMARA85pEugvj+syAyZ1+ag9JnselOTFRkuhUiS8CZpQ9Z6WmCRnZYYU
         PDT/PD6HFnsTtgeTsRkoJX7/HItYg3EXaOXgLtK0ARdsLxyEgtzO7HQ5Qg9JcWZakblS
         CNVMzUdOx71ME7P+6K7zh5kxp3PrYLcZXm+Pl9pW4LsRjQstseWGXbs7E0IqXbmLSpjr
         OWQMG8NNEseY6g38XmpvsJVAvkFcOdMqz0vGIcPTmc/TsW+ooOCVd24wthNiqHPnONxj
         +dXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787969624; x=1788574424;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3sLbIgmRC2vdoqzM1soIxVMiMdV7lkHCoeOY4VG/jB4=;
        b=iPpnOU+94b0ntSWR3H7zxUAiGU8mxOR0pbxcKBqTfwpa4f4ySL8pc21nzXAYyzTE09
         eSmCoKi4ilbtkvcQFIABVAsimRzjUs5BHrDXnt2Ziiwf2AH2DqsWCWz9IFbOuTl0RFca
         heZmixFozetkbADLNx+itUqtbwK/GsuLW1DlJDFDi4+dhQj+I4oPFgJKscFrgoNWPUMV
         1IK/tdL4N0vOus86IunrGaAEm07ZM4TnBUYdt78PBY41yOJDNDuI/sReiWE4JTl/x6A+
         MaiDDWvTL6KC3iurOAJc5YekkhBv+B1aGzWCYjLaYQSBmUvozglZEuaVA/LfYxubtm8w
         VczA==
X-Gm-Message-State: AFuF++kOEPbzewFXrnFD5aox8LWO07udo20JMYRXGLXK/tSstoqkNVnM
	2HSj9IfsZ8q954oxsqZQ4vKY0qMcSxofdGwTcSxW8aW1A9Z2Y0D7kRDnM31yMfqnEa0=
X-Gm-Gg: AR+sD101ROJ8sGOAj+OacV3ak2Y42M0+1m66cBbrM78zbEmhPY5SGf0J3pi0AuXSFvK
	D+Gg/GF8Eh5yACPAR8LjWDrcL6P4pmDkxsrBOC5ZacK25q1AB7o7P4jFrUDS5ZagRcrLh/PEGno
	tBaPKiRFlZ/68BbzRxpECbbJnGBh6rRRDCHDNt64XD9zJh6cW98NHgmMNgHBBs8cAemt677Mifb
	/chytOlpXwfC+ig5y6ebbjqvLvMjjXqha2lSqvS/pXXmlzl3SdfEDn2KBt5txZAxc71cCJvvSwE
	HKjZrxPk3fghTWV1LS9/n14rmviC7wbUn8KTMfO6fWImxqRQq2QVJVpqEmVQYXWvaDae4iY2cjI
	dgBZ7WZQougalcO14GpocLDpqC5v8YfDTBqDuGsnCKHo2rra76kq9BfqPVcrSvnVefUdLqqysfd
	ImakraD65AVhJYuPRhHc3YmPEI5mtHD/6onIYLdbv70kJc50TcjhSSHbOzdAM936aFFUTwRngGR
	zuPfa79XJQ=
X-Received: by 2002:a05:6a20:3c89:b0:3d3:ae40:51e2 with SMTP id adf61e73a8af0-3d3ae40571bmr5788214637.22.1787969623788;
        Fri, 28 Aug 2026 19:13:43 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([148.222.209.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f995e60sm10164143eec.22.2026.08.28.19.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 19:13:43 -0700 (PDT)
Message-ID: <6a924057.e22746c9.8f0fc.bf96@mx.google.com>
X-Google-Original-Message-ID: <20260828223002.ramshared-v1-kconfig>
From: emersonbusson <emersonbusson@gmail.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	emersonbusson <emersonbusson@gmail.com>
Subject: [RFC PATCH v1 2/2] drivers/block: integrate ramshared driver into build system
Date: Fri, 28 Aug 2026 23:13:32 -0300
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828223000.ramshared-v1-cover>
References: <20260828223000.ramshared-v1-cover>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connect drivers/block/ramshared to drivers/block/Kconfig and drivers/block/Makefile
under the CONFIG_BLK_DEV_RAMSHARED symbol.

Signed-off-by: emersonbusson <emersonbusson@gmail.com>
---
 drivers/block/Kconfig  | 2 ++
 drivers/block/Makefile | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 8e49b12..d3a5e81 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -375,3 +375,5 @@ config BLK_DEV_ZONED_LOOP
 	  If unsure, say N.
 
+source "drivers/block/ramshared/Kconfig"
+
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 28cb489..f895c11 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -41,3 +41,4 @@ obj- += zloop.o
 
+obj-	+= ramshared/
 
 swim_mod-y	:= swim.o swim_asm.o
