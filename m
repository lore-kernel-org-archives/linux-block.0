Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B263A63E4
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626662; cv=none; b=acNsQSgU27gySbCtg+xMM7wvEtEmz2n6q7LpJvtUnlBSBnGDWd90bqEZq8cK2SsLCOlJqR8WJ84oVkDEwtnxcHpiehhaG883zc+pIOqjr2vV07FVnLccj+kd4O9oIu8wtjwLlqQCtNsWX7NUCPx2R9TEf1mdCYqj2hbySXeAkvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626662; c=relaxed/simple;
	bh=fTkFRABeWhqpHqR3fBTMOr/wX+GQmnvqFLFQIRi2PB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xcpn1ROH6xZcL4ZZm9hx669EitsqTyrArzc4Pe2gOzqpCJpDtge21ril/lZHwz442GsZsAZ3SQ/srFdTbsltvElSanoqoWQQEtiayKqFMI3IaSGQImVj1ibBpNczlItFb23awB9pUthmeGGRiUwFdkpU/w1E9gshKY34uL0HfLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EgHDJTQG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R4UNetfh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EgHDJTQG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R4UNetfh"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SQVb152553
	for <linux-block@vger.kernel.org>; Wed, 4 Mar 2026 12:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Uhi/pQDgQxc
	huJE4VRIyJvYlAizoY9xEMiE9yI+hg3Y=; b=EgHDJTQG50btnRIpcc8KC9VRvmU
	XTgncO8NzLwx+ak/YN+75UrSgd8fL3olG5w8/YXNWcHIcs6ScZKxUYhIaxKERXY1
	X3uTidXt2R+p0rzyoLP5mXHUsu/NUuYHNMq3OSTwB0UiB5PZxzC9cA8etIgohAUR
	ALECvAHdt3TLByv3jI/juHt4E0ak7bvic42cZra5ld5bISzOt3eZL/yvGNTHLBq4
	LcsAEmKCAXvtzHrANLGP+tvRPRsZE8GUrIkM07g1lBeELOwmlVRuT7M5Jc6AQVGT
	BYL7EAcvCkSJeRLwwePxxrs9nkNSj1vAoeN5wJ8eSWxOtg7kxaME282GxQw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp3tvkj8t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 12:17:40 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1273886efc6so6641627c88.1
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 04:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772626660; x=1773231460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uhi/pQDgQxchuJE4VRIyJvYlAizoY9xEMiE9yI+hg3Y=;
        b=R4UNetfhtsGnCLonM84Me93C3yG03WA4nVwuH0r5YpxjssOSxqp4tQvY/ZF6GwsEAV
         BU4UiQASOtwgzvkV7e0pQ/dDOI62vdvLpRomgoelaHn8kgqXMm9BPvGozwr2QKS5YQ1G
         nfkL3w9kfMqSSEkyi9ECUWZDlN8PpHKr+StKO+P5rsPLaw5KzBradb2Q+MyTxV7vparw
         WTBEx3JTUx4m/VZ0qMC1byeuKe07vq7JwgcMJYn4WCHRB/suc0oBuwgBJq8JOjw6hmGH
         0jtHripDo+PqhE32NUjgdeLkwIKTHOyYWKDWrddjDCKWUIiIaVVSn6sFEViH3FtMYJoy
         Simg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772626660; x=1773231460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uhi/pQDgQxchuJE4VRIyJvYlAizoY9xEMiE9yI+hg3Y=;
        b=Mn5cZRD+/zLYPKAQYSuldWbE+PKZSV7a0reQGtD/un8IlEo/lpABPEYDzQxjEjs7Zx
         PPORcVv4tq49bUwmoL9tBePplm7EHYGqbhptJVMhTs5OGs2rsUmGbzxjo002Ikp2NEDv
         UckOJcVVryexz4rPj6VAy6NWI0zQDQhsL/rEfxcrUySU0iBh6eIl0YV+r6xWJUmEia0e
         5voE8OWxm1uAE1DbYeIAMsS6+4493GUdB7UK4N93eEDUy/bWPZ2GnsdYiR4KX0MqR0jK
         a7sic6mKDEnwCVuAIqdh6CrSaHwmBPRwGPT8Gvb3aIf+XWH3c/ttloJnrT6gUAcUoqes
         Il1Q==
X-Gm-Message-State: AOJu0YxUMFD693Z+s2eNEXMKUa4hOvlah4E8Dp61Rc/8/8d3RVsJg0IM
	xnOMm0KdYHp2dtmx0OG1EvCLoXVU5TcRW7q/K4EJVQrUMAnrW4em1OJbLCPlBdpbg1PgH8X4GTW
	6aI60aOmxexF95DmC94UC9Z70N+7oVVZDcZVim8He+d938Qfgp56PaFqqzoxl5Zyf3SUpFPIOIp
	VB
X-Gm-Gg: ATEYQzw7z+o5URfpzGx8YYtkxB6+UG59C3UlFJo7ocQvAJh8oY3Y/XW7Wg5K9SdrE9N
	9we27MqxvFaDbdfERzmoJBaAl1SYKnL9mAb9thY8pkU8I9/ETbvg9aY9Y3zDoFnXvI4fI9Idp/3
	PoP7f0REyEQVZVpmHntGAKCblc3sxY4rYOR1uSxBZuNyCvW7K+BH7TvhUJVh9SyfYJthRYR6vMr
	ZAn1iMoUrKy90cuKIAnYb3b/SsqLBt8bDVXi4XYu3leIbp7s9J4nvzeXooAfqscOtp/TXZSrXAs
	secdIdPX+uQkPVbH9JhsdLWKAbcgVtyI6Z3i5Pg3WIDNPglWY9sVpRW2kXWGJzL9PeMN4mMsUOY
	b3CpTvuafEq4Pc1q908D93ut2fsQiSH4z9J2JvgziZ9vv+c0Wl5xh0JIzbVROnbyXcqoPcccRNO
	YhurJm
X-Received: by 2002:a05:7022:a9c:b0:11a:37a7:3d2f with SMTP id a92af1059eb24-128b70edff0mr571788c88.37.1772626659726;
        Wed, 04 Mar 2026 04:17:39 -0800 (PST)
X-Received: by 2002:a05:7022:a9c:b0:11a:37a7:3d2f with SMTP id a92af1059eb24-128b70edff0mr571774c88.37.1772626659165;
        Wed, 04 Mar 2026 04:17:39 -0800 (PST)
Received: from u20-san1p10573.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899dfc47sm22171276c88.6.2026.03.04.04.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 04:17:38 -0800 (PST)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: linux-block@vger.kernel.org, ebiggers@kernel.org
Cc: linux-kernel@vger.kernel.org, adrianvovk@gmail.com,
        dm-devel@lists.linux.dev, quic_mdalam@quicinc.com, gmazyland@gmail.com,
        israelr@nvidia.com, mpatocka@redhat.com
Subject: [PATCH v1 3/3] dm-inlinecrypt: Expose inline crypto caps to the device
Date: Wed,  4 Mar 2026 04:17:28 -0800
Message-Id: <20260304121729.1532469-4-linlin.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA5NyBTYWx0ZWRfX6mvd7LY62jg1
 uvY/aKMpHNpGE5dxN9llQ42ZB1JYvsjpmYHpXYIxQdJ8MkH3q4eKWalZXOfhGxGlPivGt7LxOJc
 YkwNhq0K2/kyFSqSp8vlYEi6wkBZJhPSkgXAx8PvHz85E29I8ssosSa2IqaT5ME62ffKMVuj/o1
 dLUXgoq6rDObf9YTQZVr/JXaMIgxyUCLbXvtX5FXXFyNBKRLyIqCgQGiyrYjjEd4fzilvCJ2Qju
 rXBdc86JqHYIMms9yhl0W88Y1xz78yV76mKn0DiIlIOGMNrbgZpUzu3y3pJZD2cfJNvLD+9w6QK
 qekEgOXm77NAJlQfcLfZ0oqsfPB+5n4/jrbLtWJu5kQRE1b5lSylfDpqmhzlwzjJClUR14vb0vX
 T+KZ474nTEroCYQmeISnjILLZopGtDEOMs2ijDctj3Q5qD1+V/ayP5a7Qm5OWc1zDjrBQ64ZL/o
 u/1Q5qdFhd2aqtB3wSQ==
X-Authority-Analysis: v=2.4 cv=VYv6/Vp9 c=1 sm=1 tr=0 ts=69a822e4 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=3zJYx2Ns6XLEkWF3d8kA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: bNmhXziUdL7X3SFdMSlkBm9iAPBhD302
X-Proofpoint-ORIG-GUID: bNmhXziUdL7X3SFdMSlkBm9iAPBhD302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040097

Add a new DM flag, which means the inline crypto capabilities
from underlying devices can be exposed to the DM device, and
the DM device consumes these capabilities, rather pass through
them to the upper layer.

Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
---
 drivers/md/dm-inlinecrypt.c   | 2 +-
 drivers/md/dm-table.c         | 3 ++-
 include/linux/device-mapper.h | 7 +++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-inlinecrypt.c b/drivers/md/dm-inlinecrypt.c
index 251760da9f7e..eda56893d430 100644
--- a/drivers/md/dm-inlinecrypt.c
+++ b/drivers/md/dm-inlinecrypt.c
@@ -396,7 +396,7 @@ static struct target_type inlinecrypt_target = {
 	 * Do not set DM_TARGET_PASSES_CRYPTO, since dm-inlinecrypt consumes the
 	 * crypto capability itself.
 	 */
-	.features		= DM_TARGET_ZONED_HM,
+	.features		= DM_TARGET_CONSUME_CRYPTO | DM_TARGET_ZONED_HM,
 	.module			= THIS_MODULE,
 	.ctr			= inlinecrypt_ctr,
 	.dtr			= inlinecrypt_dtr,
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 7be1d8dc8bdd..f0580935394a 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1407,7 +1407,8 @@ static int dm_table_construct_crypto_profile(struct dm_table *t)
 	for (i = 0; i < t->num_targets; i++) {
 		struct dm_target *ti = dm_table_get_target(t, i);
 
-		if (!dm_target_passes_crypto(ti->type)) {
+		if (!dm_target_passes_crypto(ti->type)
+				&& !dm_target_consume_crypto(ti->type)) {
 			blk_crypto_intersect_capabilities(profile, NULL);
 			break;
 		}
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 38f625af6ab4..6abd1b4fcb76 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -306,6 +306,13 @@ struct target_type {
 #define dm_target_supports_mixed_zoned_model(type) (false)
 #endif
 
+/*
+ * A target consumes inline crypto capabilities itself and doesn't support
+ * passing through inline crypto support.
+ */
+#define DM_TARGET_CONSUME_CRYPTO		0x00000300
+#define dm_target_consume_crypto(type) ((type)->features & DM_TARGET_CONSUME_CRYPTO)
+
 #define DM_TARGET_ATOMIC_WRITES		0x00000400
 #define dm_target_supports_atomic_writes(type) ((type)->features & DM_TARGET_ATOMIC_WRITES)
 
-- 
2.34.1

