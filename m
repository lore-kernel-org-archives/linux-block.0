Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664873FE650
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542774; cv=none; b=ExMbVNH05zL5tCrdgSp01ebEuRDhaJ8v8ZuG1tXr+zA2G2hfQlZBZx21+bNURAtbBgEiMMlLfp7+yHO29mR9K7coKrJbATZ5ieqOXUSKlM9h+9ImbkQX0EQdShch4ITK7p0OTMwCA3gwnYUeYdLgodKQxI0h37WF2miqkqfsT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542774; c=relaxed/simple;
	bh=BITlx4Kwj5eBbWFc9rslpJa2+01NebOQNTaEdmYUQ24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FG40yJ1unVw1mmIRNrAUwQd3i+ehJutoI+WUCHOv56K7rKbM94uwAydOshTQHSV1ZHyVzpNkHKx0mLQ7dfeXp20b+S6R6MpLg/yTfIHIgcaLzO6G8gqrF/11lETiXbFIt1MsTc0QmC36HE9rD5B91t2pg8P+XGNfA5StpicVX5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oSbuh1pA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xoi8ekw4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oSbuh1pA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xoi8ekw4"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U6AhFS2533827
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 09:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uShH14l/dWy
	0o1Tl9pcZPJ74mlezSCjEKQRN2uJbI/U=; b=oSbuh1pAGJ91dHqjDfdkld745fk
	rJ4pwOX/oiny1ZzD4IXWlYfluSgA1pF4Q5mFM3L9Tt0HSeokdiHs2e/2SbAcXoJe
	+fCh6ZZxdFzMx4RpQ0XkG4nPMDV08lTngW4b9nOg8sEcwaNI2dKYaPMV2e+ctWOt
	aVn52BulA0gMpQa8A3F9/P4f5YNA4LZKloEY8IKjN9do5IAiOFMdT1wBsnevATy6
	zudetqWzgAaNi91otASJJvpg1OvxzONFfwWE4IbHFQaLaBo3Iq08aJR+AriRcjqv
	4vozA2t8vM504AGBHfgJunANPyWpPVHiTdOGkjb7rcl6C5o28JwGOXaIb6w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dupe932ga-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 09:52:52 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bdd327d970so480539eec.1
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777542771; x=1778147571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uShH14l/dWy0o1Tl9pcZPJ74mlezSCjEKQRN2uJbI/U=;
        b=Xoi8ekw4Rmb0e1+QBVKQnKhqTQpscrKk8g/6EbqqaF4gfinPgCwv0SXjGjsPOE3Abu
         GA++/0oOCL/loYxan6E1Dzn+Vbf5vrR0N9wfJtjJ26L2Bdd4zTcqQTWxX0idUBEpBAue
         BhWwPs74raY1qRzK5SFTZwh8s6KvxOoOqhgCJ/QNQL75Ck+U6a5Z/0veEevRZY+j6OR3
         kziCA30b3EkYGVjx7yJVctOF3ixLnavTnE3xApMsG4fFxmov8D1h7kbBfDJcbbQ1cWlL
         olGPsZkdZ6DPCAaBQNMd9r3vb77388WKvZoqMiaIS5SzqIgYKtC6HP87bZ0f8Cx0yXHW
         b2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777542771; x=1778147571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uShH14l/dWy0o1Tl9pcZPJ74mlezSCjEKQRN2uJbI/U=;
        b=Y+QMojita5/1Pm/8MN+A2AzL0vsKsytE2Gtj08r8sw0zSRGx/Dk06SJ7LNIBsUIwp6
         iCWrsqFwMqCwVOQIsDVpHnUNUg0zEm2ZbbsqIBq8s/VJ5jwJhsAHveRBd3q4fWiX3k3V
         6vs6O2ATwt22UjouOpCKN2ZiPA0/JDZACdcURLYe9KggRjpvuFn5pouccAiOYWPg0JiK
         X09wj+mdO9Hs7UBFXsbhm73TizPzm3yOIDPEkY77xRgBqmY8uboehsIbk4HmdGHatTYa
         Yv80h47iI3/IR0Wv2XuVpDAFx1MNDJaLjaOpI9BuoJt+OAygXCOUVxUfyhpqDe7WJls8
         5iGg==
X-Gm-Message-State: AOJu0YzUEfcPhU2Tvo/YBAYKXoC1dRORll/+A+LKs2n1CKRN6p7AACZO
	ObiPaBEzW/7F+ctrUH4RcTc/4GNvpHYxUBepnlfVhTpamP1WEFqo9FXUi+bpO1xIWp0fSkC3aae
	faKVHoCF0d3mBVz1pW/0RopD2MUtgcQ6cDSiB7z2Fg7k1kY8uWGOA0P40+auQpHzfc6ZnSfXndw
	==
X-Gm-Gg: AeBDies1SM2Kl/zji03ZcP2JIQOaatFGx7OwNUM9r3NHaRsmoK+syjSz4/4MNVXOL11
	08z6FGfmBgRgbb2Iyigg1qRyjVRPUO/7LGig9ZJybBBJoJDRcIy+gXjDSlZQMidQDfnEFm05W4B
	fdnGXSpcHsVu0j64dLFDchuPgV3Cfelel4arVTfILaVDhIhyjPVnoEjqYhV4bXczUaljnBQLIIM
	uh0dUCTRQWzwFLNU/RsWfBIZli2yU+Avx0aw4ZwYO3h9S2UrQiV/7ju7jPctCmW+OPX4TIQzPxY
	lkazg37SgUchJBNp7qx+XAlBHgVmU9r6v6Jx8bUuISg0ch984f9hMFn8GrR6DsdDp/SmcREJBlX
	wn5zwJxzrqzLZRwOuEylvtDPko32HpLnesuO1zSb/UbPdBoY9HDRYsX/5G0nE+0zQ3Rv/8b3iQ4
	gi4Gm68sFFjImEmlQ=
X-Received: by 2002:a05:7301:3c0c:b0:2ed:e16:6b38 with SMTP id 5a478bee46e88-2ed4f2e650cmr704631eec.16.1777542771168;
        Thu, 30 Apr 2026 02:52:51 -0700 (PDT)
X-Received: by 2002:a05:7301:3c0c:b0:2ed:e16:6b38 with SMTP id 5a478bee46e88-2ed4f2e650cmr704612eec.16.1777542770669;
        Thu, 30 Apr 2026 02:52:50 -0700 (PDT)
Received: from u20-san1p10573.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c0d218dsm5885804eec.27.2026.04.30.02.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 02:52:50 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: linux-block@vger.kernel.org, ebiggers@kernel.org, mpatocka@redhat.com,
        gmazyland@gmail.com, bmarzins@redhat.com
Cc: linux-kernel@vger.kernel.org, adrianvovk@gmail.com,
        dm-devel@lists.linux.dev, quic_mdalam@quicinc.com, israelr@nvidia.com,
        hch@infradead.org, axboe@kernel.dk
Subject: [PATCH v3 1/3] block: export blk-crypto symbols required by dm-inlinecrypt
Date: Thu, 30 Apr 2026 02:52:42 -0700
Message-Id: <20260430095244.3352446-2-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260430095244.3352446-1-linlin.zhang@oss.qualcomm.com>
References: <20260430095244.3352446-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2gtTcdtikC3If5ABDTYjaJPQGAFlpCAW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA5OSBTYWx0ZWRfX0kVPkBvCU0vX
 UsNsVOnRWXy3WoNAbQt8xYdqIOpJJFNxr7iZqlNGnWnL88v7Yq8Tkmul20IWJ+sLEe2IO7VObAj
 D4gxm6HHcouXiGyc3Ef/5Q5COjZVeOGVJG7TWUbGsqkFZLr6B+g+X7axNbY3H+2HiBXQZnldY3/
 GQigzAdWE6SM5lgL99UFkpXfjlJuHhBFnWcPAE0oou7EbAh/D3fOrF8PE9UL3GjKwX/i4l99yb2
 ky3YgoXOYXEqIdj3EaEt1Z6csnB7ClwTnkR2ha3hxI7Y6piLW6W0lltbFGAkKvmZczhha5SgRBU
 HJQNTcmGYcyaIQpya0/zKY8sNsFiFp7ZCFdsHyoax1dJaft/kisrooyaV/F6dKRkBDy9lFG7Ci+
 bYIHnUfJdZiwYHdKV6KZIBwx1kZRIkJ6B/SR/HwHy16Csk0mVvKk/5NM7QiEOqR0FLGqrTzS/1o
 rNborXQ2ZvafDlD9NPA==
X-Proofpoint-ORIG-GUID: 2gtTcdtikC3If5ABDTYjaJPQGAFlpCAW
X-Authority-Analysis: v=2.4 cv=PvmjqQM3 c=1 sm=1 tr=0 ts=69f32674 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=1XWaLZrsAAAA:8
 a=pkKqxYWgxMMasECMkqIA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_03,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300099

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

