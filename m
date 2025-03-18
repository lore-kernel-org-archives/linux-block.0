Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C48191F92
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312707; cv=none; b=ry+x+OkWzqeT3MIQTQEqKOVvWcgK1ohcxMS0notaRUA8wXWtv+wTw4z6vpMt9wdNffyenDqMrxdWdoLwnxIF2sU0qNMLTI7M0DyFtzaSXTITNNm6xA23017mVDdkRg/49v2xkPtj2aT0QUZUrBUdIDyGUVFofiM5YBVt86h3rsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312707; c=relaxed/simple;
	bh=KWk/bN9ELEeFN2tK34OWgu3HJs0a/hjkYwJUU8LqA0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uT4Kh43CyFfkTvktmps/M/2+YXc9l1pAXVIX366Raads6PQnZ0E/nHqy2HZKeyV2rSAg36mnAtErotVe1pZMdZmS7Ms54R84veaNCEhan+HAO2LiT4yyMAS8+m++FqLo/in0B5UiVHylYLRTRm1vfG3J1/g/M1GlvigyXHMvoWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmlBCxzD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmlBCxzD"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac339f53df9so499383666b.1
        for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742312700; x=1742917500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qYvjyq4pU4tNrtVHaMUg2l6HN5kc1GZ86F6qK4ZHRg=;
        b=mmlBCxzDsAzlnGMQJHeYAuBYg7q5VBWJYJ9bejEainUZoC9mNTTMJv7G+Mr5C1uU2i
         ZrJOCI+k6ayAnQGvpTYgSihX7hi9GlsSyUTB5lP/pCvkJmQJtEuKXFkhrcdY1D5oMD2n
         dih3jmFdBhoYq8dazM8S72MpASehQsIOIAWEEPV3iJfI3hqVFLCwRIPYbdGB41Tc5njZ
         9M7JUXH016HVFp2nNXJweQmuVlZ6pUEo2zZJp+8N2m4ReVXUTqwYlIc8GmqgicGNubBL
         1iGg+1ffg9Jfcm83zO2o4YLRLZ0HxPz9DfAvmbbjvvHaQ6uAQr1kg+zbLBcQD3N6oczm
         0yAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312700; x=1742917500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qYvjyq4pU4tNrtVHaMUg2l6HN5kc1GZ86F6qK4ZHRg=;
        b=gQbd6ZG9mNaOp2GXWE7vEmbSrR9gz6ucKhT12FXKWewTESak4QdFmql+myb3GRmjAt
         TR58JC+gl0vr7R72nv5NwXFzk9BzP7ceB5cM7Mo9hU6Cc9dA5aYhQcAMaiJJv5oLN0Mc
         WccjNDesl6vwP5kMO1p5lr6hbdJxnH/IJCwASeHvH02fxVONiD8mLmI5BuLkqoIL/Nkw
         dv+4rHW5SFw1YJa0Wjva+f7OuIYSRQvdDXrSXa+PrZZDykncfbkK9IfuOCpCGfoPTjSO
         nt4/zGtDnSOm20m/IZzNLatsehDwQDVl6Yj5j6PHaUWX8B1Ho9zobnr2rzHhkHuBscl5
         rdxw==
X-Gm-Message-State: AOJu0YyS2m2eZVrFH4sbh64+F9y8EQ6RcIOaIJ69jhS6Curs+HAUOTBr
	as/FqA5cr6LD6pH/H1gk3AEz5UHqcefLVCGRvZiPtsCtqC9zBxIs9a6cserf
X-Gm-Gg: ASbGncv4txoVKpXdk1r+106Pzi/DP/pRyXuSnyZVV59xIqfNAojj8NWbQD56hC4EmCw
	4IJYEiKiaT4rA76HzIycUzSzj3cprNMchKkRSmoqHQIjwpNlMSsJ86nZy3fl3KgF+uMYHGraLgS
	vp1OyNPCL3/bJ/Z4XcbDWLdy3fIyyQxV/ft23zBDxpqRtvMbHUJwIjYm73766a16UK3eWZVH0J2
	s/uMllvGrLTYaXCMlSAF0IELNkdvFs9cxGmKiwe0MZ2U8K1TmrO8EY8eHPij+MXgq69OFKeh5Pl
	CLAnomBsSh/gzO05VmemN+V6vXX4oX632ifKCzRrQlqwp6NgTj49K9vvCg==
X-Google-Smtp-Source: AGHT+IEmYGy9R9GwCkCXnc51zX4MIzm41D1D3xF242VopRhmxZAj2QlbVB1aEbDpQqrHbot4Zt7RDg==
X-Received: by 2002:a17:907:d7c8:b0:ac3:8987:5ca9 with SMTP id a640c23a62f3a-ac389875d4dmr493086266b.19.1742312699481;
        Tue, 18 Mar 2025 08:44:59 -0700 (PDT)
Received: from syrah.fi.muni.cz (fosforos.fi.muni.cz. [2001:718:801:22a::6a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149ce9a9sm863710666b.110.2025.03.18.08.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:44:59 -0700 (PDT)
From: Milan Broz <gmazyland@gmail.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] docs: sysfs-block: Clarify integrity sysfs attributes
Date: Tue, 18 Mar 2025 16:44:47 +0100
Message-ID: <20250318154447.370786-1-gmazyland@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <yq1pliuoqek.fsf@ca-mkp.ca.oracle.com>
References: <yq1pliuoqek.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The /sys/block/<disk>/integrity fields are historically set
if T10 protection Information is enabled.

It is not set if some upper layer uses integrity metadata.
Document it.

Signed-off-by: Milan Broz <gmazyland@gmail.com>
Co-developed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 Documentation/ABI/stable/sysfs-block | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 0cceb2badc83..16e485c05d36 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -109,6 +109,10 @@ Contact:	Martin K. Petersen <martin.petersen@oracle.com>
 Description:
 		Indicates whether a storage device is capable of storing
 		integrity metadata. Set if the device is T10 PI-capable.
+		This flag is set to 1 if the storage media is formatted
+		with T10 Protection Information. If the storage media is
+		not formatted with T10 Protection Information, this flag
+		is set to 0.
 
 
 What:		/sys/block/<disk>/integrity/format
@@ -117,6 +121,13 @@ Contact:	Martin K. Petersen <martin.petersen@oracle.com>
 Description:
 		Metadata format for integrity capable block device.
 		E.g. T10-DIF-TYPE1-CRC.
+		This field describes the type of T10 Protection Information
+		that the block device can send and receive.
+		If the device can store application integrity metadata but
+		no T10 Protection Information profile is used, this field
+		contains "nop".
+		If the device does not support integrity metadata, this
+		field contains "none".
 
 
 What:		/sys/block/<disk>/integrity/protection_interval_bytes
@@ -142,7 +153,17 @@ Date:		June 2008
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
 Description:
 		Number of bytes of integrity tag space available per
-		512 bytes of data.
+		protection_interval_bytes, which is typically
+		the device's logical block size.
+		This field describes the size of the application tag
+		if the storage device is formatted with T10 Protection
+		Information and permits use of the application tag.
+		The tag_size is reported in bytes and indicates the
+		space available for adding an opaque tag to each block
+		(protection_interval_bytes).
+		If the device does not support T10 Protection Information
+		(even if the device provides application integrity
+		metadata space), this field is set to 0.
 
 
 What:		/sys/block/<disk>/integrity/write_generate
-- 
2.47.2

