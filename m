Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85435490C08
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846921; cv=none; b=a6j6i6OBVv1zBIkW/bdhGrT8mkOOElf3J1BC/cIeyiT19awhDsy4UcKX9J6r0nu5G51GR68bpoMhCDaCJ6A+DRN+GU8u+PckbszuajnZiUJqZXhIwrT9pUnpFI5qfkxaK6DCiD6CjVO4H3/KohdJsjJWOAy5DHeX8bPbOEKAguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846921; c=relaxed/simple;
	bh=XzVRSJskkXzsRQMCF0q2XHzItKnQaDkIqK2bV/uMi6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOqMKEMRGb2l9g40lQvJbzfjPi+oJcS0ykVIIAVklF2ZmHpOlJVFFt4RDJ0xcjcz/XjUNUgikwXtcL96slUUSjgK06hDJsTOmR4FKvjwddz6VV4xCDWS+9oVpg6RFI8L5OtkMDcFNivD7ceD8ntE3NV3pWW+dxNsZ1NEnvnN4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oFwTjd6O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AA3FoCeH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oFwTjd6O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AA3FoCeH"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RFbi67296987
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 16:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GQuf/V68eCT
	XXH2b/XlQO3XYqlyP/kTHk7utlZNkRig=; b=oFwTjd6O46+rn3wQuhLnjLfejRI
	JzlkxQSt3yFeu41vHuEDRwREWQb/MqlkNuVm1K7rXRrb1LnCdn7kasEpR73XcA4I
	0RUsK5WYrYHBR+ekT3kOuxUJTj9DvpOV7EJQJZ7kZTPydi9vTE5SM5FJFJaM4swO
	6cx951RiLv1XwxTtlcUdL7qyWC83c9a0lrDN9Ro7St3H1fkKn1PDPGNdgkyYf+n4
	0I05RdmD/c3T6KmB5Jo2tG6ZNq9g0uOiMJHwGomEX1zaxpZNwDz3WJFIzCPUKQC5
	VUHQzo0KHoD6lNydXTaSoa7h/p4k7EROq3txUc2+bYHsHO/xDvwP/N2vM7Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fh455-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 16:08:38 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so61064a12.1
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787846917; x=1788451717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GQuf/V68eCTXXH2b/XlQO3XYqlyP/kTHk7utlZNkRig=;
        b=AA3FoCeH7dxuQJ48+dwosFA+BhbwWawGmWUykTFGQBnzYWVC2BXXuYGCoMXzIdHMAd
         0O/krdfMjswvRM4U+AO20cSdc19SAEAzLJ+xIjSevpq2iApNamWMn2whspBAQTs8SuWt
         sgRFrXb1uQ9vV0hlxdzGe+2YnAMr1Z6X46wrwWGw4WVCJt2Y/prPiVz9TY0zHTAZFAgK
         LlMG+swC2MfVzfi0ZFLDucLt9PQWfsUtfMzvz+VXz/P5BlYj5qGkAnGtF1f+Blk2qtZy
         h2EIAo2rxky78sUCVI4/pmVuBU/3v8l90oQRugv1ILx0vQ5qG1caB+XZizNX50Ts7l0z
         KrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787846917; x=1788451717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GQuf/V68eCTXXH2b/XlQO3XYqlyP/kTHk7utlZNkRig=;
        b=U7h0xlw0/JNQ/vI6iYRBksTO10novgl/Nn5+u/OJi1mXRFJZM1lpsaldhPyYhiGCSL
         RIvua/kkNWFTSMu2TPaAF/tus4w55C4lnv5Dbat+YaRPtsVX77/f/78rwOtUIGoUddq6
         Uf8XKJKSrCtJiatZcjL4syZiCuyzlfm+pmwrIF3ZwVGZ5uqpG2MjcEpTS/9P5ertmepj
         SjfJEesDgQDK1q9WgqQQ4e9GlPvt7I+jKV7wCG2wKrqoDZZl5zUZkCDjJd6EiOQJLMny
         CXQEdrVF2YWHeQTqs3svWbyjuNMIXT3MDrP/xcV2YKzcNSiX3P+SX6Gq2rUf4X8Aq06u
         QOBQ==
X-Forwarded-Encrypted: i=1; AHgh+RoM+KQufA3Jl2dXoaYNLzmPXjCTn85cU274btDKWc5PjsWPLRZIiATDGGto/0zlQhmqFkqp30F+xbyPYQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nasALLPVARx74z0Gv7eZMH/qkNNoEdJxJzUIQgP7M2HP3X1th1
	KmxCUy42tJMfJJMtigRnWLCyO2qq8XDA8lrQ+DUeHJGlqw7omszfXjvnJnMriZ6rd3fBW8f+Y65
	rjZoBXMO/vcjyqoIwSeHdgHih/OqAlS29h3b+jJt3fR7F8i3xa0IqyiYpVMD9wxRMRw==
X-Gm-Gg: AR+sD13hInGgSckg5PYwkHczSQ/KRm019TrbzCE95CIq0GcCjrRsVJ0a3PI48l9IYs5
	pAzqhqxfSukPSNsCCF7bFEHeLIPRYoiKyA5qM4fZYok4y2sgKs+zodXidHO9Rn470fh8CpDH2Mc
	yyFdQbNFTSZfIha7+QGBBKefpFr4NQ61FkU6YS7TpDnZGXQEzq71gDlRJOHxczpPhdZlN9Q2vlR
	S6s/0bP5Sg8fl/XHVIwTkdPo7XxG7duBQyEQS2kaYfTlGv6WTBUoFFNUHj82ELTBxOQOk2YQrFl
	cS1tYE2boyUln2AUFCojnjxwNM+5HxqebYrshk91ldyQEvAacPWYTo64TMUoQndhVuvDftp9E1f
	4lXBPaQBjj/12xOGnyDi0osfrQ/eMHfkOYOiL+U2JadzpU9mKYHVHnoSAuKI=
X-Received: by 2002:a17:90b:51c7:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-396d0f52b2amr503472a91.15.1787846917375;
        Thu, 27 Aug 2026 09:08:37 -0700 (PDT)
X-Received: by 2002:a17:90b:51c7:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-396d0f52b2amr503276a91.15.1787846916655;
        Thu, 27 Aug 2026 09:08:36 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd9085sm3245892a91.12.2026.08.27.09.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:08:36 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: ebiggers@kernel.org, axboe@kernel.dk, mst@redhat.com, jasowangio@gmail.com,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: neeraj.soni@oss.qualcomm.com, gaurav.kashyap@oss.qualcomm.com,
        mani@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        bvanassche@acm.org, alim.akhtar@samsung.com, avri.altman@sandisk.com,
        stefanha@redhat.com, pbonzini@redhat.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/11] blk-crypto: move bio_crypt_dun_increment() to the public header
Date: Thu, 27 Aug 2026 09:07:16 -0700
Message-ID: <20260827160806.1295313-8-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
References: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX+V+3zm+6w9C8
 Y0TaUSNoDPk72AxWgbQ+3VK1pj2072IR1EJ3DfGSWwreAclzDsEU35aGBhJ1V5rfRbfP7QNddqm
 9M69fUXbA+g/0fxqvivBSLefqSmK59U=
X-Proofpoint-GUID: 8Gh9uiz5AwmNRo2mAcUokSH9iCpHRlgd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX9fsWs2xT0rb1
 xpWDGIksajEfoxAfoMoT//kBWOfDmjjNWJsHwk/EDGSGPGHfHkaQWGGlHGt2Wxq1VEO1ZmapQht
 sKSCaSk5F3t6wc1OJn6TNZMRvOz9U2Ic4xoXbuYrzCIMMze0KO+MyWnWLib9CpeGiEtlahHynDT
 zUpNc24WMuoaS50P0Rv9uIoQpH8+zJEuHrpvCsSu0l/Om4YEb8Q7s6ochnfRtTP09uEiVNavX37
 3X/7Jj35OqkW7AM3sg/mkWkaNnHvzIyzr1FnfKQ2X2eq9RUxyBCvnQNHVuLLirrHuurFOtxVGM3
 Pc3pPRTiy2gO6Sp4lOiHo+lhrDpHGd/aOSuaywf4WIHDbPs4DKYX/NnxO3fUitp/gx5Uap5ech+
 132wAys87QctrBLzOi3aRrEanrRi/HUTh+iephmwGk2CbKyw2aXlw2eQoN35utWPQtoHMVWnzIw
 +kBsNsfYnyE2B6n/0xA==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a906106 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Dog9NmGJ06mbJvtOeFoA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 8Gh9uiz5AwmNRo2mAcUokSH9iCpHRlgd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270136

From: linlzhan <linlin.zhang@oss.qualcomm.com>

bio_crypt_dun_increment() is currently declared only in
block/blk-crypto-internal.h, which is not accessible to code
outside of block/.  Drivers that manage inline-encrypted I/O
directly need to advance the DUN across bio_vecs within a bio,
or across multiple bios in a request, and have no other way
to call this function.

Move the declaration from block/blk-crypto-internal.h to
include/linux/blk-crypto.h alongside the existing
bio_crypt_dun_is_contiguous() and blk_crypto_init_key()
declarations. The implementation in block/blk-crypto.c is
unchanged.

Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
---
 block/blk-crypto-internal.h | 3 ---
 include/linux/blk-crypto.h  | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 04035d237f03..32c720aabba7 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -26,9 +26,6 @@ int blk_crypto_sysfs_register(struct gendisk *disk);
 
 void blk_crypto_sysfs_unregister(struct gendisk *disk);
 
-void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
-			     unsigned int inc);
-
 bool bio_crypt_rq_ctx_compatible(struct request *rq, struct bio *bio);
 
 bool bio_crypt_ctx_mergeable(struct bio_crypt_ctx *bc1, unsigned int bc1_bytes,
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 33ae52b77522..c9f436b6b2ef 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -181,6 +181,9 @@ bool bio_crypt_dun_is_contiguous(const struct bio_crypt_ctx *bc,
 				 unsigned int bytes,
 				 const u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE]);
 
+void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
+			     unsigned int inc);
+
 int blk_crypto_init_key(struct blk_crypto_key *blk_key,
 			const u8 *key_bytes, size_t key_size,
 			enum blk_crypto_key_type key_type,
-- 
2.34.1

