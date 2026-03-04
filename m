Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD66936606D
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626659; cv=none; b=XSj5yug7rYTo+2r4QXYhawlLFJiBsD8yqCunuZQSmsu3WPCF5tDILoAu5AyAlTIrFmird8BQXkDeHxLKsi3iCx1HNQOTTAad0PNTdZenXW7432hJq0MbPxa4NDbwlSO1fzMI3EqZkiof8bPr42AiRn5cSKmPADiXGCqDFZadmNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626659; c=relaxed/simple;
	bh=BITlx4Kwj5eBbWFc9rslpJa2+01NebOQNTaEdmYUQ24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=msDSYwMeMJhY5eCbi6Rfv+NB1appvdMT4tC5FcPOzVU5lfgqGFdfALKfItzr0HktWBDvYXAu4yIppvlITczLbcr+UhE/jLNU+y9XOv+vxuZLoyb33cBW/aeafQb45B3IfUXNlOuD3mD1gyur7e4MwZjExoI1FScqi4zMP9aUXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dTUyy5pL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A0GddL4C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dTUyy5pL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A0GddL4C"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SQVa152553
	for <linux-block@vger.kernel.org>; Wed, 4 Mar 2026 12:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uShH14l/dWy
	0o1Tl9pcZPJ74mlezSCjEKQRN2uJbI/U=; b=dTUyy5pL5dK3eS9CPhL4giyELS5
	cV7sxqB2c+oBOak+3ANLThm4WjU0Hx8IunPjFNxTIevTOIXAGVpBxzUjCafs3HiI
	KFyf+seIdc4WYxXRtT8ecqDcV1B777gDj1WuRLVTO27T0PjmFKTwGMh86aQJ/RU5
	peafPuQqcgSaBaCqiTzWLDxnO2c7iAd7lL0wWx+AfQ40CLukByJ2OEgzj8GHmUOD
	VPZ1JliZnuxPTiN/RpCGG+XsGiE0E/SvNwaiHWPyukJ6oOqTSuXjy0agmGy9MEpc
	CAD4Pb4gHnAiNnTioiY0N3kfMM0IxQibnP8n9HwXkqz1BSiXD7rf7IT+VBQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp3tvkj8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 12:17:38 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-12711ec96fbso107479821c88.0
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 04:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772626657; x=1773231457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uShH14l/dWy0o1Tl9pcZPJ74mlezSCjEKQRN2uJbI/U=;
        b=A0GddL4CavOOmpZ9Z1kg8vsHQlVAVk1Ui1oxBOf2ejGAAyKQnDzqkctDkDAseFgkIN
         7lbWL/ENohFKl8XPjhqwBbLQ4vmkjusE9TkPOYutqKtSEV7QTI/PbclVWB7zSS9myrKh
         gmZFJ6AR9yA2dWNudNeRv4lDRdb4a2EwkdqwRYuMJxGLyyaIfldpupq5GC2V2C7B+0ew
         1ghaTmWBdTL74teDYRUNsXxhfLQE5g5oN1bYXTaShgrhTS5uX2I85nNSheAlA9aAHVYi
         9cf3Bsub27K0e+LCY3TGgb9hxR2Cr5U0YTL3q0BU+rqjOFgO3fdURc7xJwBCcmjck0Tk
         79nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772626657; x=1773231457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uShH14l/dWy0o1Tl9pcZPJ74mlezSCjEKQRN2uJbI/U=;
        b=f1hFruhZBrAwPDsHNeqBbgM3QZPiUDf1Y9I5L3YqyAlfJWMi/siXfUFXZ0+2nJXQk4
         fNRyCiMQuaL5Cxs0dwjSDc0YIt3ofey8jx1YWXqaAflXP7o3yMBctSh5Tv13Osfv7x4l
         bOj4/WMnXn2tf98BAhljWZAk1WvaiCQW90wN4wp7hL7IRNdqHNq8PhfJPNtCLGxULbyZ
         GQQfzKyfAZ7aSafENb7uGDmRHNTX5bpr6n/J5Pp7wXkM7cop4KovD44SotXK+/IQtxED
         XaOXjO8tYkJ163UUy/2Knng+hAP8piqpJbg5FdME9nejl9Kt/SQyoP42mFEsSUU8JFQT
         pxWg==
X-Gm-Message-State: AOJu0YycjwkoBc8gFt7dGpFNr4ASQ5U58tpGvTHzsorXLM0IutMQi51E
	NkVGvx4o1herpjtDco3RczAiHcvEMTaIFNi1wi47eO/khh7rEex/2+EGwUXegeCxSITv5VHdAx3
	RwUawtMwHrnl63VfV82KEbrp98Hec+LjeRxMICYW56RoFC31B9ZmJAJTXdSP/Ewc4vGEya9gn0m
	zW
X-Gm-Gg: ATEYQzzgZCr5gwvr6TZicXR/dJJgwnWPNuOdiMNeybrheX8ojMVARe/V/rwZbMZoh91
	6EraYXlGH2+EVHszz4QbrFhlc5odU3ckliztcHjdWjSnlnVleHHLuBoURkiP95G3pg00XnXkSMU
	wkYj5KVVO2Vy37EMvWZZjyF2WxIKIvovwO2DBLJ416sAazTto5HzgF+17VBPy7pFWUQjQGd8CBV
	bJ2UQDAtI5n1/8eQDQSmq+OOUtRafvvuIwPY2K66N32QqQ2kco3ubVDD28QcFruMwip12/C1bdS
	mWhiinaVZF2nZjEHpdbC044i8reS7LCyU3lurIY5wOsKxE6pV0eNM7I87EaxdkidOCMnU0xsPmh
	lVa8wnG9nfgOlACae+aVoRB34pOGdeirM9DPbKMRqq2AwbcwnKc8TLeF4M3IgmcQ3KFKFpSkpCc
	DeVogz
X-Received: by 2002:a05:7022:789:b0:127:3480:7c9f with SMTP id a92af1059eb24-128b70824a3mr855149c88.10.1772626657167;
        Wed, 04 Mar 2026 04:17:37 -0800 (PST)
X-Received: by 2002:a05:7022:789:b0:127:3480:7c9f with SMTP id a92af1059eb24-128b70824a3mr855137c88.10.1772626656661;
        Wed, 04 Mar 2026 04:17:36 -0800 (PST)
Received: from u20-san1p10573.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899dfc47sm22171276c88.6.2026.03.04.04.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 04:17:36 -0800 (PST)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: linux-block@vger.kernel.org, ebiggers@kernel.org
Cc: linux-kernel@vger.kernel.org, adrianvovk@gmail.com,
        dm-devel@lists.linux.dev, quic_mdalam@quicinc.com, gmazyland@gmail.com,
        israelr@nvidia.com, mpatocka@redhat.com
Subject: [PATCH v1 1/3] block: export blk-crypto symbols required by dm-inlinecrypt
Date: Wed,  4 Mar 2026 04:17:26 -0800
Message-Id: <20260304121729.1532469-2-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260304121729.1532469-1-linlin.zhang@oss.qualcomm.com>
References: <20260304121729.1532469-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA5NyBTYWx0ZWRfXyuJ8DKqPKIw7
 JmfyKwlAW8RG6XRuelpBXc4hwoSDZdByXepsgqpgn9Aes9M65QiRiiRSwLT7SvQ4Y8xboZ4pYE3
 2e7Cn7gBYolzwbO3OS+gcGPX5eZeiiF/AwTdarHvju13Qb/LFe2rOr/mdH3lYi7Cu6rl6L538qR
 KhVkpELgSxskl4kk/jHHI0G0DoTmgECRWYgcx5gMxxp6fHWqfUSZwVR6QJk2xHOwxG9XbU3aocq
 s1eySGn5SCbF4GmMPDQmak4AeDdO0lM+i0QSZ1ZcU1mNx9bJ2R5DuBjNXz7DQvtkDYHl7cGVozm
 CZjIX49PEpI+FSHgcNIO9ThAF0ieZDIB3LLR3WeaZjqX5X3xI+XpL2p319c1TgFMbr3gat/Mt8k
 utB+dXZ1VuX4bkWurIo8w7t1Wpj702I/bDReEi66llGlnOVjY5A/2KtjDUnoanHslnjiRYVcSlZ
 DmY3TopE7VmEvYIAspw==
X-Authority-Analysis: v=2.4 cv=VYv6/Vp9 c=1 sm=1 tr=0 ts=69a822e2 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=1XWaLZrsAAAA:8
 a=pkKqxYWgxMMasECMkqIA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: KQDCcHt5Sn4Zb3SYaVtk8LymsyYjChIM
X-Proofpoint-ORIG-GUID: KQDCcHt5Sn4Zb3SYaVtk8LymsyYjChIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040097

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

