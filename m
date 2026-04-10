Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3917A586
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775828441; cv=none; b=j1lD74vgKgCb+LYpxuEGwspiZMTm7PKuLIM4x/VXcvq6hjoAA8IJvOld4m6WMN1P+QsrefAtTkYX4ivkDmaqdX/waoTnFk8sbG7gt3JIarTmmZDjzOGLR/P7U4Nvr9Hzv4nLXN4NoTXWwCYs6p3Tc1L20mRxDhzb1Fulo1W78J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775828441; c=relaxed/simple;
	bh=BITlx4Kwj5eBbWFc9rslpJa2+01NebOQNTaEdmYUQ24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FFUEVQrlwHa5yXeQJZhmm7+rQ+eBz18fIIlpUXvD6Vx7lAjEwLk02b/n32gH3uT4Kdtclp5MkvIJ8oXWfikIUSCn4laGPGIr1NH/FSiXu6kKGijAJU4NgCz6HiNEJm+FwF0cEMfYh+55eON2C5p7RH45WafYisK5Pr+q0VKk+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MI9z31Du; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RIS2QA3T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MI9z31Du";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RIS2QA3T"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63AB11XF438809
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 13:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uShH14l/dWy
	0o1Tl9pcZPJ74mlezSCjEKQRN2uJbI/U=; b=MI9z31Du8GgqqxsCNQuO1t9PaAe
	/fgKqdjai0WTBUGZu/eJCet2S7i7AUL4Si6JgL/sAJqJGLYui+NRYkaQIX4+pIoG
	HSa/xt1sO6UtvNmy4GbC27EAgydOBCBANQXYzy3TzOEsCcs4dO2NNLhAha+CupgC
	EWUriLOIMjqw2pIg70Y3kCaZ3mUhx00d/znj+WRKqszUoTYUwsZYneLd8w5nhilS
	7IgHdO/SNz3x+ZnoHjDGCg2tLl6EoGcWR3rh436LcytXLIOnnhGcr/B+WczuzlGR
	iF86DuHJ3Py/RwcJyEQwj7tPf3HSfpqX09Aj3MIsY/YoFm7lucfooXcjvKw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deyy9rf65-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 13:40:39 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2d51aed14bcso4055650eec.1
        for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775828439; x=1776433239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uShH14l/dWy0o1Tl9pcZPJ74mlezSCjEKQRN2uJbI/U=;
        b=RIS2QA3T6pgzj0ZjrHteZ8Jo9QQ9Yfv86NhWQmNtqWmhD0YDyuDnpbJX7XqAvAbxbG
         hrxYgvoVWscETlvTk/7j3OZ6Wos0nTUajFXxlkO7i9TqmrlrE0HZVn4DTr3jALN/bW1S
         sdH02lKwNXYaCM+WtvfDib8cmenvHLBTRlj0uNtvPXViKtqK0mAm2wGDalRJhNi1YDse
         tV2orPnsgVhQkv3ZEluj+nxnWEvKaSc3jM464biCkNh4kZitqKr6p0Lk4uEt4SVVmM6F
         GI/cdggjbw9iVw8nuLQXEBM2/MuCcymsKDGlsYwnDpSVo1JlLDJua68DOKgryFMwMBaR
         k7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775828439; x=1776433239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uShH14l/dWy0o1Tl9pcZPJ74mlezSCjEKQRN2uJbI/U=;
        b=SLyQlI8vyYn8sowhgWLAMEme+S3Cp7YUpd/Irxrp/VfH9cPCvajsQWypWhsuEiAtr/
         1HY0ukMn2C8Nhr6thhsO30/+10r1jr1ac5CwjFu3pHtUWIBGHWLJgAfKd8PtT7G9nVLM
         fd1dJAAPEaLTxcvN+MnHCJbFwWjMLvbv1ooBCD2j1osZwXwEINilqQ/Ptou/i6XehoLb
         TTq91GqF4sgP3l9OR7KEUFCgoDsD5dFJO/vm+oTzQT1+GUCBsWyQVa7iK/6sQcTssHT9
         E8LiRbDUu8dCL8DcAhzyii5RBpHdZ/XtQO4GQg5BKbmtmQHYe1U5JqSvegAzIeu91ezv
         95Vw==
X-Gm-Message-State: AOJu0Yx92xXoVddU8Z0O3lm8Jcn+kDIaxr9ukCeDsUXKJoRnRS3Wtkch
	4eCczQBhfPdzOfcLtCgXUSaInXmo0PvkPFYrByAffOy9NykJJ7JaOdG+cvtwrUUR/pyQlu1I5YK
	WfO8lRJeZuiDdqOdmI8N30Rxu03aZmhphQWlag+pZGEvMjWgS7u7FHN0/TRaKCghdsLtQ5qEOMH
	oA
X-Gm-Gg: AeBDieu02TLR58uyMQtYoK7L50Xu50KVU1tymZgQzwrv+z1rPS6RDgjcKnYyuyli8IR
	P8MGqqk0eTP5EuF5+8IC2jfGSRwkWlQplsh9oCD8WrhsIGBE0vgCM89c2aB/5WPmRnhagWiHHrl
	c3DpojFf9kWbn9hVKuVyjOTIcY7a0tKXN4cYH+/53s99GNOv3YIbwnWwhfblqtCX9uYseyOm5XQ
	EUu0Dhd+ynnD39l0PFF5iRsxCkZndRXMRaJEsj/a/g4c8UfLqpre8XK29apoAXBG8JNdKv1W4Nv
	3hKWzTdPQbDoZf8necFl2yNedekVgN/YPABxviYgPCC+ah9yfPhVgA28pNXdeOeGyEKtz+/T1lR
	tgQuaTNy9XELTZWk4FR0QJk62jfMJ00KcmPzlLtKIC8wcOwwnF7+ddg1rblEq8EHuPXEilfr+90
	VG+4pn
X-Received: by 2002:a05:7301:1f10:b0:2d1:d434:d005 with SMTP id 5a478bee46e88-2d5899a3b93mr2129265eec.20.1775828438761;
        Fri, 10 Apr 2026 06:40:38 -0700 (PDT)
X-Received: by 2002:a05:7301:1f10:b0:2d1:d434:d005 with SMTP id 5a478bee46e88-2d5899a3b93mr2129237eec.20.1775828438212;
        Fri, 10 Apr 2026 06:40:38 -0700 (PDT)
Received: from u20-san1p10573.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561bde70csm5172631eec.15.2026.04.10.06.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 06:40:37 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: linux-block@vger.kernel.org, ebiggers@kernel.org, mpatocka@redhat.com,
        gmazyland@gmail.com
Cc: linux-kernel@vger.kernel.org, adrianvovk@gmail.com,
        dm-devel@lists.linux.dev, quic_mdalam@quicinc.com, israelr@nvidia.com,
        hch@infradead.org, axboe@kernel.dk
Subject: [PATCH v2 1/3] block: export blk-crypto symbols required by dm-inlinecrypt
Date: Fri, 10 Apr 2026 06:40:29 -0700
Message-Id: <20260410134031.2880675-2-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260410134031.2880675-1-linlin.zhang@oss.qualcomm.com>
References: <20260410134031.2880675-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEyOCBTYWx0ZWRfX17RiC3L2qAX1
 3ZR5TmmhDn6u2BAP325lZqETXJp2PXiwKg5vYzFRmjA5qMqHjA4arKq4ZBbAp0bXqgmy/PCYJ+i
 zj9N6tC4nYeQFll+PlReTKFv/lo3HXuhF37QeeC5cg1GaFPGjimhFedSDoeHSX7VtbufZrYkzO6
 aTb4aS4pG0BwZ1RiliPsdQwocuPeRbMMYBQPGmvHcYiDHR5Vu0Y0lqQgplxha4bSOM2ShWHolP1
 MVQAP6tXPXo+5led5ErgRxU3YgIuucRhwc8zIqV9biSHCwJlrpwpmwqt8oF3knLHh7lPHPLnsko
 RFJuemMQIVjBhiywg+jGUDBRY3+zNbyMJyZfakVGcl0E8gWK8e0kZHd2F9C9Vku4VRv4HxYfyvi
 vE44BGCBJ4QTg8vMKnbsaWW7isc3yxjoR7Wx5EEtYTIveGEj0n3L/QRkeRBxZsAgEWXU42pp21M
 zYMLC3xeDdr/nKovaDA==
X-Proofpoint-GUID: i8zKpuzv7-f4VWLJ66AYtV1On6bxYwEH
X-Authority-Analysis: v=2.4 cv=d6fFDxjE c=1 sm=1 tr=0 ts=69d8fdd7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=1XWaLZrsAAAA:8
 a=pkKqxYWgxMMasECMkqIA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: i8zKpuzv7-f4VWLJ66AYtV1On6bxYwEH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100128

From: Eric Biggers <ebiggers@google.com>

bio_crypt_set_ctx(), blk_crypto_init_key(), and
blk_crypto_start_using_key() are needed to use inline encryption; see
Documentation/block/inline-encryption.rst.  Export them so that
dm-inlinecrypt can use them.  The only reason these weren't exported
before was that inline encryption was previously used only by fs/crypto/
which is built-in code.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-crypto.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 856d3c5b1fa0..40a99a859748 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -116,6 +116,7 @@ void bio_crypt_set_ctx(struct bio *bio, const struct blk_crypto_key *key,
 
 	bio->bi_crypt_context = bc;
 }
+EXPORT_SYMBOL_GPL(bio_crypt_set_ctx);
 
 void __bio_crypt_free_ctx(struct bio *bio)
 {
@@ -349,6 +350,7 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(blk_crypto_init_key);
 
 bool blk_crypto_config_supported_natively(struct block_device *bdev,
 					  const struct blk_crypto_config *cfg)
@@ -399,6 +401,7 @@ int blk_crypto_start_using_key(struct block_device *bdev,
 	}
 	return blk_crypto_fallback_start_using_mode(key->crypto_cfg.crypto_mode);
 }
+EXPORT_SYMBOL_GPL(blk_crypto_start_using_key);
 
 /**
  * blk_crypto_evict_key() - Evict a blk_crypto_key from a block_device
-- 
2.34.1

