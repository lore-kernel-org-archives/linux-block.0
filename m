Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D504DEC1B
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779966; cv=none; b=WXpjMZq/1uGGaAe9hAdry/1F0ZIpyYGWL7viQJNjwRARLXhVf1cMIhpQw035Ib1CI6nq2FhllxCbclm+7tpaKkBmcfLBBCkVuTVcmTmB/NW61GxRl+2//jDJZlIvygrufTLaMlCuDiBsb4Z43w+TbIFuxHvtscTT34VdMp/y0nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779966; c=relaxed/simple;
	bh=GLhqiOOG/ARARD1eN/kge/LRFSAxUT8726/4rLJXLbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qd4ZAmqftvNbYBGDT0NPdotmqncUi2lv2OiFOoh3/e1J50+PWCntpFb42FYg7H8xPKkHV286+iGsXBTfsGArDri+Yj1O91iDsmR8b6+hPBI1x5Pft9vaMUMNt3LqC4e9tNcwpiXuTlP7PZjpc7lELxFimGfvYXiFe1jMbRt6HBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hgUil/9F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LdatR44W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hgUil/9F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LdatR44W"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE04hr2970762
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 14:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FXnuFReb/aR
	g05c9O0/5RdoakU5qHY6jskp27DmHEHw=; b=hgUil/9FuJsiFNe7cCNkmqo0cNH
	AAdJSbiY+tmpI2V1RcP4UAr8FvcMPGzUiQDPZpnGfdMDaFh+XpltuHLIWdPEjsu3
	3YuKMKEkuEM3goiDNXYEtWEl9RzE37FmD/Tc+3oqjEmLYaHJZl6JtLxuxBxE9ulS
	dGY7C+1pgH9jCD+F1c0pIuM5ip8DAX37cT71xyT4tiUVBwal40iwEfx/BfETYILU
	6+lbzAm+9BkKNldJiygg9juGmanAZoFtD0Q2uyXu/AftZgBZ72L7MFCrVfrZ086l
	Gqt8baeifnEdtWr3ol+fzLuGk7twBcyY9FLAbFF2SMZ+AIWDGWw5eiwMBwg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rhekctq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 14:52:26 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33baaba6371so1545749eec.1
        for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790779945; x=1791384745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FXnuFReb/aRg05c9O0/5RdoakU5qHY6jskp27DmHEHw=;
        b=LdatR44WbQQ0chfKmD6OMVvnELFuX7hgHdd6qu0aw0MoUyhhpaW8ee2dlIxgveH70R
         AyzKlpmpaIZxGJGqoCHidzYihUA75Ne2Uhlujpd+lRqNKS9RMKWWqr7eqohkPnyRhYnD
         pVxQIOLKUSWBKPYovVMpotmJVhIB8Fzo6LAcULRSsus3RQtqB+un3SdKrzocnmY7VuBG
         Sf+Kcx4fxxy5HOR5sPSAHAb/rzdR+nN8ReVp5btZXebF6S3ObPSPMGoykVMXezFiLy0Q
         8MaKMILMMZBDymXW9AhDSAbxgaI8G/msACTaUOCDZRolY02dJvYs8Rbl5Etv5W/ozO7R
         CJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790779945; x=1791384745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FXnuFReb/aRg05c9O0/5RdoakU5qHY6jskp27DmHEHw=;
        b=LlKdHRuJyrPu5K6N1YknG407ajrDkquWZXGAIyMIugZZ5spEr34VwSkGJgxzQUaJE4
         L+dENopNtNwcLIPysa/mmpP7ex4+OksDMLapWvX/+ovaCaK6kqQp9rud0nMJ9Vt/ZN4t
         ZkBo0htJR421uHOE90CYY8nTo/ERqAhrVGXNDiNUwSsEN10VDO9XEpI1Eroa+OHMe3FH
         lnf1hs0jgBax25MkKHO9BJs/rz5n548QSOh+juUzvt2TdXRNtxHJmYaSjr5CjafPByeK
         Iv/ys18wL0ICQuqgLYpqUf/+N3MYotAHxVqQd8QdPnR6QMnkLpqegXTPDXdjF/2jFKlz
         uVhg==
X-Forwarded-Encrypted: i=1; AKwUvByYbTDrwAjkDm5bkZalSKANHxILamnh7tINAxAi0vM0cQYIFx5ZLBdz1pcS/BruloZO+E4hyjf0+kfenw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8NXIPhIBVvuTkO9i7LG8X8Ib3AmVGmPXoL0rX1mjv+rPmse4K
	ey7+Eszwx6p2feSToW0P5ezbMZnRRtSSZV05YzCuAYm2L1HZTivaTLjYHgOyaIfU8cP6QG1DKmW
	DlJtBJTk/mEEVaHjifFsNmp36fj6+p7yJZ2fR05vfvEf2dr2LU3CCYMhU/Vc/JsSx1w==
X-Gm-Gg: AYBFou0gW3iuPmWnCTHBLrU7WW4BglmZIyIjUMO0mnw7RNtvjClZ7t98jDR8V0+0EI1
	4vqnHwDYbUW3mucNv54D00LZ8u4rFlTf41ILnQ1az3TbNL2CvfMfry1aO9CQb590uyrFfxUq7Us
	bMKK+E2y/z3G7LT/UyZWRrsE5V9GTBiOZZV3MltGeb48tYC8ccXdT9AnMRv4mL2W8lYQBHNk/7j
	HsHII4DGQ19bU7KNOS3rode/0cyyXQeB4QKdut2F/uc1YUgZaD4atS/1YuiY6SVmohgWl6HGFRZ
	AGR8DUX5qbpm4M5gjMrwipOUNIed3mA0i9/hA5ukEbHxzgBqn6ggVnDRE5y+mIvc3JSxbbuNYxn
	PLI9URx6MiQhEMg4Dc9qEn/p3Lg4w9hVuTSmarqXCWrrf655z1QCwTII=
X-Received: by 2002:a05:7301:420c:b0:34d:9c6f:8af2 with SMTP id 5a478bee46e88-34d9c6f8d0bmr113714eec.40.1790779945417;
        Wed, 30 Sep 2026 07:52:25 -0700 (PDT)
X-Received: by 2002:a05:7301:420c:b0:34d:9c6f:8af2 with SMTP id 5a478bee46e88-34d9c6f8d0bmr113681eec.40.1790779944661;
        Wed, 30 Sep 2026 07:52:24 -0700 (PDT)
Received: from hu-c-gdjako-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5639339sm4524609eec.18.2026.09.30.07.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:52:24 -0700 (PDT)
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, senozhatsky@chromium.org
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [PATCH 5/6] soc: qcom: qpace: Add LLCC slice support
Date: Wed, 30 Sep 2026 07:52:14 -0700
Message-Id: <20260930145215.3380977-6-georgi.djakov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Htq2euS-fxiSDBG5iQdOqgHmAj2TvlV_
X-Proofpoint-ORIG-GUID: Htq2euS-fxiSDBG5iQdOqgHmAj2TvlV_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1OSBTYWx0ZWRfX4soL5G+WJOrd
 Qt/jbllaWc0qSRfkCyczN899wkwvWE8Fp8loXI4o90onllTlI8neJDxTuX98/rWywC0BuJnbUVk
 GUlc+sQMhlwIFjOHd9/S7OB1fzn+kYNnA07B1C4ebj49bW/6zpcu2bpqDoLZGyNCmu8bKUZlMrs
 wuJcx9FFzXsmluyy7InCykZEWcSV6trRidRaerjZzJmE5D5h87H4VWtOVLmp+k/J6jN8edxHmW8
 9IqHiuxWkZCn1QgJdjL83XG+SBFonzxQUiUVeVRemixfygvFLyMd0MOhNXHjj3G1DgSU9lDQhgM
 Vkd0Hsfcpf0lWYNvuVzhIXqSMc+V9W/33emiJCAyu2fDbcEx5PMXG900YbFUXHSg6JCN6VRpkZH
 8FEA2kWXQ6wDSa+5Z4pVACqGcncUtbUXLSqQGxdKwMicKwz/CeNOSqRxQiyH2b9NnVbVlsbOzar
 QuXsbrdkiiLYYWYySHQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1OSBTYWx0ZWRfX8quGACFiCQLK
 gXomVzdyHoZdWXAulJzvGodtOcZt898puYE5oPNv27nmRO4yTMWvQRSWcKjZBX4iSAJARVfEeog
 KGVIe4psyolsEn6N/VgOgGJm+jTWhmQ=
X-Authority-Analysis: v=2.4 cv=Tu1zFzXh c=1 sm=1 tr=0 ts=6abd222a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=dejIaLI6GUeI2fIgeLMA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300059

QPaCE can use dedicated LLCC slices for compression and decompression, but
the driver currently does not request or enable them. This leaves platforms
with QPaCE LLCC support running without the intended cache allocation.

Add the QPaCE LLCC slice IDs and make the driver request and activate the
slices.

Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
---
 drivers/soc/qcom/qpace.c           | 58 ++++++++++++++++++++++++++++--
 include/linux/soc/qcom/llcc-qcom.h |  2 ++
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/qpace.c b/drivers/soc/qcom/qpace.c
index f5b21ffbcbff..86a935ae2ca9 100644
--- a/drivers/soc/qcom/qpace.c
+++ b/drivers/soc/qcom/qpace.c
@@ -18,6 +18,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
+#include <linux/soc/qcom/llcc-qcom.h>
 #include <linux/soc/qcom/qpace.h>
 #include <linux/workqueue.h>
 
@@ -42,6 +43,8 @@ struct qpace_priv {
 
 	struct icc_path *interconnect;
 	struct pm_qos_request qos_req;
+	struct llcc_slice_desc *llc_comp;
+	struct llcc_slice_desc *llc_decomp;
 
 	int active_rings;
 	struct completion no_active_refs;
@@ -660,9 +663,35 @@ static int qpace_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to map QPaCE registers\n");
 
+	priv->llc_comp = llcc_slice_getd(LLCC_QPACE_COMPRESSION);
+	if (IS_ERR(priv->llc_comp))
+		return dev_err_probe(dev, PTR_ERR(priv->llc_comp),
+				     "failed to get compression LLCC slice\n");
+
+	priv->llc_decomp = llcc_slice_getd(LLCC_QPACE_DECOMPRESSION);
+	if (IS_ERR(priv->llc_decomp)) {
+		ret = dev_err_probe(dev, PTR_ERR(priv->llc_decomp),
+				    "failed to get decompression LLCC slice\n");
+		priv->llc_decomp = NULL;
+		goto llc_put_comp;
+	}
+
+	ret = llcc_slice_activate(priv->llc_comp);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to activate compression LLCC slice\n");
+		goto llc_put_decomp;
+	}
+
+	ret = llcc_slice_activate(priv->llc_decomp);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to activate decompression LLCC slice\n");
+		goto llc_deactivate_comp;
+	}
 	ret = qpace_power_on(dev);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to power on QPaCE\n");
+	if (ret) {
+		dev_err(dev, "failed to power on QPaCE\n");
+		goto llc_deactivate_decomp;
+	}
 
 	/* Get QPaCE HW version. */
 	qpace_priv->hw_version = qpace_read_gen(qpace_priv, QPACE_CORE_HW_VERSION_OFFSET);
@@ -691,6 +720,14 @@ static int qpace_probe(struct platform_device *pdev)
 
 power_off:
 	qpace_power_off(dev);
+llc_deactivate_decomp:
+	llcc_slice_deactivate(priv->llc_decomp);
+llc_deactivate_comp:
+	llcc_slice_deactivate(priv->llc_comp);
+llc_put_decomp:
+	llcc_slice_putd(priv->llc_decomp);
+llc_put_comp:
+	llcc_slice_putd(priv->llc_comp);
 
 	return ret;
 }
@@ -708,6 +745,10 @@ static void qpace_remove(struct platform_device *pdev)
 	/* No callers remain; tear down the hardware. */
 	cancel_work_sync(&qpace_priv->disable_work);
 	qpace_power_off(&pdev->dev);
+	llcc_slice_deactivate(qpace_priv->llc_decomp);
+	llcc_slice_deactivate(qpace_priv->llc_comp);
+	llcc_slice_putd(qpace_priv->llc_decomp);
+	llcc_slice_putd(qpace_priv->llc_comp);
 }
 
 static const struct of_device_id qpace_match_table[] = {
@@ -729,6 +770,9 @@ static int qpace_suspend(struct device *dev)
 		return -EBUSY;
 	}
 
+	llcc_slice_deactivate(qpace_priv->llc_comp);
+	llcc_slice_deactivate(qpace_priv->llc_decomp);
+
 	mutex_unlock(&qpace_ref_lock);
 	return 0;
 }
@@ -746,6 +790,16 @@ static int qpace_resume(struct device *dev)
 	if (ret)
 		goto out_unlock;
 
+	ret = llcc_slice_activate(qpace_priv->llc_comp);
+	if (ret)
+		goto out_unlock;
+
+	ret = llcc_slice_activate(qpace_priv->llc_decomp);
+	if (ret) {
+		llcc_slice_deactivate(qpace_priv->llc_comp);
+		goto out_unlock;
+	}
+
 	program_urg_command_contexts_v2();
 	program_decomp_core_cfg();
 
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index 713cb0221b14..feddbebf1183 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -85,6 +85,8 @@
 #define LLCC_CAM_IPE_STROV	 92
 #define LLCC_CAM_OFE_STROV	 93
 #define LLCC_CPUSS_HEU	 94
+#define LLCC_QPACE_COMPRESSION 95
+#define LLCC_QPACE_DECOMPRESSION 96
 #define LLCC_PCIE_TCU	 97
 #define LLCC_GPUHTW_LITTLE	 98
 #define LLCC_MDM_PNG_FIXED	 100
