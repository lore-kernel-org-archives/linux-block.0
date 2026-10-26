Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052507;
	b=WYvsg3E9TYlbykPU3pbsj71w1N2E0ODcmMP23LorJ2whpGFt1W0tgYWwZ1JXFBdLw4Pa
	 lNtJ031bH6iUMnUDkHLGoVv6Fgt3wZiNf27l3rXhQJBCc+iyRr4/wWeGWyE7/4ZcIA4AV
	 0upmRr/2htaabioii3LD4N41xKt/hpwdYZcrDZJ0J2E3bUZROCo2hEesStxWPSyHGuQou
	 giYdrdXClgkq1DvUErxu81PlfAh1O8xwosTQJuxfvCWEkXHW22v6Vji/1VG1dlX0oRpu+
	 gz44aluT6KgK0lxfEME41EPH5qDpaUaA6nkDLXDKh9zEEJQTcMyVDK5uujQ8Ch8SEhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ObB1lr6nmuzaGD13yarlkwIHlaWMNgBmclG060dnLAg=;
	b=edBq/E3lqVmv+TFlgr5YONFodnuo3bt0i6B/OVHkPX2XXwgwLcOaBUx29SoQgHb8iFJo
	 y2SAUwc6skptmLngGMmbu0mmTzjmhY2b804cWeIC7aUfhcGPw3qFFS/2dLIPMMNJ4IjoP
	 TwTHfdGI4TOw0CBx2UNlYvFEF/nnqdx/Ix7kh2HT+QU5IPmDfvHfVFOlsJ+Az3dQ0n52Y
	 F5GrQesxENikbafKJJYKdrcljBO4XC25hTqzFj6dHIcpkEmK88s5LgM9Kmb2xZYpcbS6+
	 KocPqN8WOAll87yNovolxNxSR562Hrqaahogi6M3QZub0lxFCUplupuo7l7k1/RLeqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=philpotter.co.uk;
	spf=pass smtp.mailfrom=philpotter.co.uk;
	dkim=pass header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=wTQUYwsI;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0D1606A31E
	for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 22:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A0D1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=wTQUYwsI
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e0d885929so2335970f8f.3
        for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20251104.gappssmtp.com; s=20251104; t=1793052505; x=1793657305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ObB1lr6nmuzaGD13yarlkwIHlaWMNgBmclG060dnLAg=;
        b=wTQUYwsIHcxfHuUDbzF4w+ckzMrGkpCbRtUvQLlVwvoOuX2Qu5Kydi9YilfWnn5bVp
         +H+f9Ds3MDsd1KoN44dap+P+csNcyw3wBhfClk9hYmzcptInsWJZ+/OSwegLALxbczx+
         ZYdrPXlEnBYPo72lDj1CP0E+Nto7TMrcSXhNSVoKXICyrT9SewSJjfkO6rzN+w9VZ8yW
         hfWzBmVy40sPa3Zxgdk9x5P2vEOtGxPNecET90Yhr9XvRVfNaP01lpTKa0Z7SM+n5UYg
         sFaCeabA+sWeqcgT9shXcickkbJQqC2h4PAboihYrBhwDnMh+QEZRGK/Jnun177DwcvL
         LWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793052505; x=1793657305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ObB1lr6nmuzaGD13yarlkwIHlaWMNgBmclG060dnLAg=;
        b=SSl5y7oH0rdWCxlroxI6j9/9/9a0hZNvsyOP7btzK2zKwtiSsR41EgOVDC/xtdbZpw
         ZdlRRjY1azoKvoGA1RGNIJx6jPzf+bTfPAZZ8ynvTGv7v3AMMZR+OymL8HF6b5msM06F
         w6jEGf3KHDSlMwbUKowZiqIFsNpcUFODN4sH77SQAl8reGVen6u9vO3+f0HdQcmxKQ/i
         RtF44FQ54WhmXeX41o3xcF7jk30/QSEnznhlUCuCngcHQsJinem3PoGS7ztbe0Fgbew1
         ZTnZUByWbBBC5hMoD9OjmmvOZkcDFRueLNN6tts9sZ9BZW8MfrhXkZ9zNK3ldjzcXLtI
         lQKg==
X-Gm-Message-State: AFq9FYLAa7/bkI+PAWrA6WzAZKReDJYHFcXAFstZmTD79JzG6JUApZPt
	fbLNVmgEmWUD8Yi8y8KtCXjGjnKOuq/H47bYqc0z8UfwVwN1GahCb38xt/PzzEz7+/Q=
X-Gm-Gg: AYBFou3GGtNqSNQVk3Df2+bshQiUlEPLTAbDSftUXOOqYa3QJJWOOFkHPVaVgO/mMOo
	3bwMs1SFs4nGtWX74i5vwvPLwMPJcDtntMYsCmLBsVIXhlXR2s3OFPGiKPZbkHevVnnJ7c6LJeG
	NKqt+2B9OLQJQ+03UPdD7DU7aTzTYXUGfBG2HmkzTwa+LzeIacH8uTSpGDancuHnluIq1n1+psK
	3A4zQ5aO0uUDEzasrjxAioxl9yX5W6hJR4q+aX53DqJpL1fx0W83Y7X+h9J3cEuljdypV/rrc3V
	on5NTVsJtUsjwLZMB6rjjfM+zhum9BvMNiUMz75RVdO8tRHTJwjHrrOZ9Az/Q183HArgdsNjOrM
	a+jWLNKLs7AmjqrDFEkbaULOgWcLB5mfCIvT+xNVik9MwxdSQKN6Nm4OVcJMC8MhCAAupZSDU7p
	nJjjW/nA4UP2oyH8lD2Yj+fhFDdhbiJGEHKmoquIrKOVcEcNr/2444fqeI8Q5FZEj/M/XKJgoFw
	F4Jqo4OjKC6WSIlLtHKtLEkBo8=
X-Received: by 2002:a05:6000:1ac6:b0:487:27f9:844 with SMTP id ffacd0b85a97d-48e3ebbcf1cmr15111724f8f.57.1793052505576;
        Mon, 26 Oct 2026 15:08:25 -0700 (PDT)
Received: from KernelVM ([2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48e0sm19365996f8f.38.2026.10.26.15.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:08:25 -0700 (PDT)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	rdunlap@infradead.org
Subject: [PATCH 1/1] cdrom: drop linux/fs.h from cdrom.h
Date: Mon, 26 Oct 2026 22:08:23 +0000
Message-ID: <20261026220823.1162-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026220823.1162-1-phil@philpotter.co.uk>
References: <20261026220823.1162-1-phil@philpotter.co.uk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Randy Dunlap <rdunlap@infradead.org>

The comment "not really needed" has been there since the inception
of git history. I have done build testing of all files that use
<linux/cdrom.h> with no problems found.

<linux/libata.h> includes <linux/cdrom.h>. I have also build tested
99% of the files that use <linux/libata.h> with no build issues found.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 include/linux/cdrom.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 260d7968cf72..19e21a6cb762 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -11,7 +11,6 @@
 #ifndef	_LINUX_CDROM_H
 #define	_LINUX_CDROM_H
 
-#include <linux/fs.h>		/* not really needed, later.. */
 #include <linux/list.h>
 #include <linux/blkdev.h>
 #include <scsi/scsi_common.h>
-- 
2.56.0

