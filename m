Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6C1248874
	for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667590; cv=none; b=sP23PewnJDZE+Smd96TOh5FnAQkUnK7iwzMFkAXtk3tHdBoyvxNIsttMJt18pXeLFA6YclXcxkrNsrJW17ElGD66Fb5QfBfFCl210PupFOBHOiSFANELXr2SasysRLO4/UXmerjaPnQw9MM7S1m5/yezNJ/FzCojKoSEOLPiIKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667590; c=relaxed/simple;
	bh=/WzRNava1wGbrF+euis7IhRCW967BKae9ei0XMNzKJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPhoKBz/TNomm0HKK7fGwcFEe0AXk0ieH0D75WJwv/m3A6hADnLMbTnNY6lRuEIGl559Uxv5tsNv/I8WAecQtwL0RIUjOhFYbWSbRJxqp06Bb4mqKM8zUkWTKp+BHKaXloDIPBHtMsXzYQ4H0waQDm6UtXDLDev0DZ5H20Eqij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8//aom9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8//aom9"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso1695847a12.3
        for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 06:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740667587; x=1741272387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiRoTscXGtX3cCVM3ed5pfYsHD1AeCyjRBViPb7jDh4=;
        b=V8//aom9crJbin6YuUJqyiu9/LhLfbWcbaxef+j1CvDPHMD+LCDvKmDXd36UMEwsNg
         wqSHw/gH33UDz0vge5760F4Ir1OZ0B2puNKLZOHbECwVQAk40jGwhP2C5ZFF0xdeXf1I
         jEToL2+MYQc8ywRmbSD/+nBqIiXeg3vT/GjTzzbE3fuGbpwujPJ/rK3fwSGt16spvXp1
         6uMKwtq83TV/639L1RU5l7Mbifm2g+XRRI56KWjfsfQKxffRHhYVLO+MpdRKGl7HwO1g
         sS0LUYGhmh4UmxkjIkXUkpReyF+wGAw1FQ8/qg7t53lW13Mc6FDxotSphJKLITDTPSLv
         Tshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740667587; x=1741272387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiRoTscXGtX3cCVM3ed5pfYsHD1AeCyjRBViPb7jDh4=;
        b=uLCgylZSpt70bSc3dd16gh+2d9XvnYwTxPMIv6frmzVEuSjj3nT7qkd4U4ULaYtV84
         Qyc+c2yXlrMnTyaz3MBFnacLXkeaSBiHzgmmgGRFIr2jjYTkeNLpz8NdbeOeHiOnAiZt
         RC4ZOkdGMmbK4JsZQU7E+XpEfA1YdlCgvyemQxkA0pUU3zm6pOTcOEG7ZVpEOcEsqmdA
         knRJLCJt6ls8tHBi5RVRUn6GtPpAL62NJ6jTbNh3ZepplBu0YE3AKkM5HlJ0Nf5FiAKj
         SfUmwxvPws01twn/hoXSASOZd1TKZ61wAFsMVPsSJ4fP91yCKajBCO/bs7fD/F8EhTM/
         csdg==
X-Gm-Message-State: AOJu0Yw469c6VBIo0x9VUIQgtW0ufOtLdSMFDW02yMZ1gNWswD0onXA2
	r/iX8NaMEZZYxrDGrQYR6wR4PeevRAzD0o+yd7PqmrOdP1+AynkJJFHmGk3/
X-Gm-Gg: ASbGncvX3A7+j1iaYFpLZABbblWDU01QOl0xYObz9VA9W/l5VXXjACCJlTbeGbu29/T
	YubvjFmJaJYOLk6iXMay6dfuAbYWSzCkTTqYEoH5A5pENDRBAUQh5/Tvorg2RbGm7NN/eheCr5C
	JGWCS3KazKWwH0s0Q9E9QQk/SAnFIkz7clRkZbUwae9pMWEVEFET6i85Si9LokkW0cVc/clW8IJ
	eM2XCeiOQuCJj+B874VkBtsMhqZmY6KU/res8MAbju0sVquT5jbM7oWZLxk8Pw45a4VdZEgj/Rq
	QRaD+X7psjgbzvPchN9lY59maxls0FVV
X-Google-Smtp-Source: AGHT+IGyzPFFiycDeXpjpKZWMIhyJjYsg40cJNtBh1oPPODtSImXEGJkxZK5AwXVFTgZUUtpYR1VkQ==
X-Received: by 2002:a17:907:c29:b0:ab7:86ae:4bb8 with SMTP id a640c23a62f3a-abc09a0bc37mr2779186466b.23.1740667586768;
        Thu, 27 Feb 2025 06:46:26 -0800 (PST)
Received: from syrah.fi.muni.cz ([2001:718:801:22c:1369:c402:50e6:7236])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6ee70fsm132310866b.116.2025.02.27.06.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 06:46:26 -0800 (PST)
From: Milan Broz <gmazyland@gmail.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@infradead.org,
	Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] docs: sysfs-block: Clarify integrity sysfs attributes for non-PI metadata
Date: Thu, 27 Feb 2025 15:46:09 +0100
Message-ID: <20250227144609.35568-1-gmazyland@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <Z73kDfIkgu4v-c9W@infradead.org>
References: <Z73kDfIkgu4v-c9W@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The /sys/block/<disk>/integrity fields are historically set if PI
is enabled. It is not set if some upper layer uses integrity metadata
for non-PI format.
Document it.

Signed-off-by: Milan Broz <gmazyland@gmail.com>
---
 Documentation/ABI/stable/sysfs-block | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 0cceb2badc83..f67fd46f15b6 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -109,6 +109,8 @@ Contact:	Martin K. Petersen <martin.petersen@oracle.com>
 Description:
 		Indicates whether a storage device is capable of storing
 		integrity metadata. Set if the device is T10 PI-capable.
+		This flag is set if a PI profile is enabled.
+		It is not set when non-PI metadata are used.
 
 
 What:		/sys/block/<disk>/integrity/format
@@ -117,6 +119,8 @@ Contact:	Martin K. Petersen <martin.petersen@oracle.com>
 Description:
 		Metadata format for integrity capable block device.
 		E.g. T10-DIF-TYPE1-CRC.
+		If the storage device supports metadata but no PI
+		is used, this field will contain "nop".
 
 
 What:		/sys/block/<disk>/integrity/protection_interval_bytes
@@ -142,7 +146,10 @@ Date:		June 2008
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
 Description:
 		Number of bytes of integrity tag space available per
-		512 bytes of data.
+		protection_interval_bytes, which is typically
+		the device's logical block size.
+		If the storage device supports metadata but no PI
+		is used, this field will contain 0.
 
 
 What:		/sys/block/<disk>/integrity/write_generate
-- 
2.47.2

