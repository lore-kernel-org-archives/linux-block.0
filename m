Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE0C38B133
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427259; cv=none; b=Nz4EFdZZwW1XW6dUk1QhIFZFxYIIJLNoCPRnr8YGWWbSI3/0kX553XrqGUqkTRgeWUs9k3B2NOPZvDjdHNNfQ0i7f+H2/FxYJ7RNDR1UbM4elvfXl0X31hzdgdl3VyjyBaDxO740Z4w9G/rpXMpLsm4aX9AvIhA1e7nbhgjYTGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427259; c=relaxed/simple;
	bh=OvCoQyRpL0+LUj08qznL6Vpg7APY+bJUr7eTwyvn2XQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CN4OoHBKIuDYQOJyBJZTFUixGMg9FZfi9fkqq8Q1IOUtBu8Vpg1KN0zoQeS0j/kwsXuP7nluAAXXl2nY2fFQtalQUfEzkFyC5pBWXV8NcdrZOfll1IBdNEapFrBcO568xbg4fLr31+ZpyeLrzs19nrRNMfgaD3yjPv21CycdIxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dxeULNSL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CAFX24q1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dxeULNSL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CAFX24q1"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQpVZ1225738
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v9PMz+dnble1GdL5feeV7xmOmc+UN0QuRZbXG4cK1sc=; b=dxeULNSLUcRNcK9i
	MlZ9849Moe7IBN/zZB4WyHHUajMW4KVHBCd4FW3YxgDE0NsmY9kJUlZEtPVQUcZB
	j68kbNcmPEQ1eCvdAki3GxBSRLBXWp4v2hg48LRqTrK2RR2BizZ34wuhaa9xwFJX
	toQfxEaCnq69SBpIujR9AmX1qhiahCDP//gLTMQIgScSoszdg+zsf1xr5iyyUkKd
	EE2VC1HNWGg4tuHr1FPQ5x0E8IA/zG3DONT10tKWWFKBpcOv4iT/C+V3vsC3c6nS
	UKdMhdwayjtfgMkIUqnERhu4Urj+QmpJP73YI1o8rqST8EOnkE1EuA+cuqQ4ub4V
	FhlQtA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8kn0esj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:00:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1a9764f0so26966461cf.1
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 09:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427256; x=1786032056; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v9PMz+dnble1GdL5feeV7xmOmc+UN0QuRZbXG4cK1sc=;
        b=CAFX24q1Ot2i9gBeQjleegFJGhHkG+HBZhA9yiZYVycvzafC9KzMFOgZNN3uHP72NI
         P0V2RyqSgQ6lW0eBenXbQyyxCEDldVWn0oB4RzAsXNX+mgRditfH/9R/xNVFHP5ANKTB
         5rPPV8BnE0Sr2+REaHh8mmx1lLfqGXwrMXCUbK3BPCib1MM4ebyjCltiTi/MbamPEzJj
         lOHluqY4MLig3VslnS6f2TyENB7K2sEXeJ5unwU1jmHikPXRGsFvbSxszK0Ix3fgPBMP
         fXJAbFLGU6/8oNt+Uto+3p32x6wnRUVx5FFvy+cyURLRJGhXk8M0H8NM0oBo39aygy5F
         HYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427256; x=1786032056;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v9PMz+dnble1GdL5feeV7xmOmc+UN0QuRZbXG4cK1sc=;
        b=XLHE1TveFwTkSUGk4lDTgd0PItR99uz9OV6IcVlbtfnDCDrtSapuHHg7xJkqDIo0sv
         8bG23vdp3J0PxzIOH7mamgNHlj6VoxhGDo6hZMPmXuIpY+xvX6X5ZoTWULiE0mmvNPbo
         lf3EeSBcHP6jSti6sg4pjC+2CR2igtoV6FsiVj0SQ20xCPgvg84YxcRDxJD5/VtWHcxa
         jY/23AhPn/cF59Und+rrKFHM71t0Q2AXXRgs45ylYNuc/1R2oHvROZ3x1ILENJ5/uXze
         Q7j7ICE0FpqWcoKjUYeodUW6bLbPezt/z42r7+z1mN/ejumZTAQsAUn8WyAI1AP2w9Iv
         8sGg==
X-Forwarded-Encrypted: i=1; AHgh+RoDpIKHDvjE82BChEstkZW7jDF1IJ6PpKg81Gc6h/0RIfhzM2sOscMQcYkBEzA2mDOQeBkB5vqXiNGiUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQcF1tSA3HmXXPHlgXF8MzbAQWKpfVIkcLj3YrLN7xde49BtO
	K3yrIacvsLcYWMjmPkYsIYUnV6uotmreph+CxMavvSBz6qHwpBlkStULhbq3xps/6kNvtRiJF+P
	LGNpwKBVYW7VSYdv/anAWMznYo1d+UbjXBXbQtXGjh8x3K/+CU3EdS/ZfLKiUa5IFvQ==
X-Gm-Gg: AR+sD13ioxynrQQEP01glGoNh249DGRtXRL+FUy/Whk/mOP20YDcXZIC56HmoY8XqgG
	ZcM308EMrKCTHXG4Pyl34IWXQo0s6l1HLGZBqmojCNGrBllqQHYgq6D3wNLhtFF//dHFjjqyC1z
	UhijTFZeiz/YLU22CaTE9taALNYv7zsGJEIX4/0QmpnNczIhhdB+4MXngaWyMw5aVn0QtHig1R5
	c1XMO2wMh7wJ9HXJX8ePxfmeJa36Dl5Y0IRV8hkT4x3AbEGwvoAx+sqsxIsXf1aFsz1GJWjWrQ6
	BuCEXGUWG4ebBZWsRAU8AIFHcfUhsom343E6m8NJQIUYvIjwm9lwH+BDneypUJfeA0jIgLt6U8/
	E5tVwDR+lkR0khBanh0UQX3jPO5Balo9i4RjWJdIPiKXTjxg+OlQYZHJmqwxFopb3YOxcX2E4Xp
	XWocElHGo8v6jAfXekq9uo92lM3eagVwVvhT5ulji7S7OdUcunLV+4
X-Received: by 2002:a05:622a:591a:b0:527:7d0f:863b with SMTP id d75a77b69052e-52b385fee43mr34233621cf.12.1785427254949;
        Thu, 30 Jul 2026 09:00:54 -0700 (PDT)
X-Received: by 2002:a05:622a:591a:b0:527:7d0f:863b with SMTP id d75a77b69052e-52b385fee43mr34232291cf.12.1785427254055;
        Thu, 30 Jul 2026 09:00:54 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:00:53 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:35 +0200
Subject: [PATCH v9 05/10] block: partitions: of: Attach partition fwnode to
 the block device
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-5-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfXz+TGk5/7OiVd
 2Yf6VZNe1PhXOwTJzSTgkG7675KaVensbo6dxxZ/IEvEKOIUHcNX8ORITD83ye3955o0S6LL0o0
 e8WvS8i/8OOHHqbRD+MooxfV/8CumTs=
X-Proofpoint-GUID: FZ6OyYOEQysMt0508ot2mj8_bYFiMQrN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX6WhAnNACy38F
 YwUsZOyPGhUsD7UoYJiGmMOLlz5P0BpcVY+uEcc2A933VfKz8lrouOnmev8nIh5O7vAd2pWWnqp
 ejEnWwEgqnxHsHSAX6v/0Cqy7I6QoQkMcxZHNBBDzJiZ+Jc/zc7IZa0FURM9YY+5N5shlo2UXS1
 8XVTTaZqxQY1YctZMh5oFBbimAVAjVHjtaixzF7DAia2ZcWZQz/uuoqvAzT8ANMLzopHTEehA6k
 +gZS9+Yz5KQC3AIOZpjpqeYD8o9zvyslze2E8ypWLxOMslLLQJD0LYxRK+rNx3gF7F659BkXn9q
 OtkWagxRqjljBqP4cQBTbkNUD+gHTfz2oHqm1aC8zzxYKGlHmb0HWmAkn64zQnU50nD3UuJWXRp
 XCvo7c/qZXSGV0C+VyTiAz++yaeCJ7/jZAWtZjgyoxxGFoYeJ2I/S7lZh/g/5U0w3IF3tyVX5n+
 hAwzEzpYCrJE/quYykQ==
X-Authority-Analysis: v=2.4 cv=V7NNF+ni c=1 sm=1 tr=0 ts=6a6b7538 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=2ffTNAQyBkxXHBiWhEgA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: FZ6OyYOEQysMt0508ot2mj8_bYFiMQrN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120

The OF partition parser reads offset, size and label from each
"fixed-partitions" child node but does not associate that node with the
resulting partition block device. As a result a partition has no
of_node, unlike the whole-disk device which gets its firmware node via
add_disk_fwnode().

Carry the partition's device tree node through the parser and attach it
to the partition's block device with device_set_node(), mirroring the
whole-disk case. This lets consumers describe per-partition properties
in the device tree (for example an NVMEM layout on a partition node) and
look them up through the partition device.

No functional change for existing users, partitions without a matching
device tree node simply get a NULL fwnode.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/partitions/check.h |  1 +
 block/partitions/core.c  | 10 +++++++---
 block/partitions/of.c    |  3 +++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/partitions/check.h b/block/partitions/check.h
index b0997467b61a54a8a621b9c155c8329289649460..326081499d9a6be730dbd659c110449cfa06921f 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -17,6 +17,7 @@ struct parsed_partitions {
 		int flags;
 		bool has_info;
 		struct partition_meta_info info;
+		struct fwnode_handle *fwnode;
 	} *parts;
 	int next;
 	int limit;
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b5c59b79ca7cbb28d4d93478ee1c80908f76ee9f..72f435dfeffc63e897913571f319e5edd8e7ba88 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -11,6 +11,7 @@
 #include <linux/sysfs.h>
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
+#include <linux/property.h>
 #include <linux/raid/detect.h>
 #include "check.h"
 
@@ -247,6 +248,7 @@ static const struct attribute_group *part_attr_groups[] = {
 
 static void part_release(struct device *dev)
 {
+	fwnode_handle_put(dev_fwnode(dev));
 	put_disk(dev_to_bdev(dev)->bd_disk);
 	bdev_drop(dev_to_bdev(dev));
 }
@@ -294,7 +296,8 @@ static const DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
  */
 static struct block_device *add_partition(struct gendisk *disk, int partno,
 				sector_t start, sector_t len, int flags,
-				struct partition_meta_info *info)
+				struct partition_meta_info *info,
+				struct fwnode_handle *fwnode)
 {
 	dev_t devt = MKDEV(0, 0);
 	struct device *ddev = disk_to_dev(disk);
@@ -343,6 +346,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	pdev->class = &block_class;
 	pdev->type = &part_type;
 	pdev->parent = ddev;
+	device_set_node(pdev, fwnode);
 
 	/* in consecutive minor range? */
 	if (bdev_partno(bdev) < disk->minors) {
@@ -449,7 +453,7 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 	}
 
 	part = add_partition(disk, partno, start, length,
-			ADDPART_FLAG_NONE, NULL);
+			ADDPART_FLAG_NONE, NULL, NULL);
 	ret = PTR_ERR_OR_ZERO(part);
 out:
 	mutex_unlock(&disk->open_mutex);
@@ -564,7 +568,7 @@ static bool blk_add_partition(struct gendisk *disk,
 	}
 
 	part = add_partition(disk, p, from, size, state->parts[p].flags,
-			     &state->parts[p].info);
+			     &state->parts[p].info, state->parts[p].fwnode);
 	if (IS_ERR(part)) {
 		if (PTR_ERR(part) != -ENXIO) {
 			printk(KERN_ERR " %s: p%d could not be added: %pe\n",
diff --git a/block/partitions/of.c b/block/partitions/of.c
index dab36513eba336344c9558d486a8915624b0fca8..d4016f9b77ec078eb1adb32923107c012ca4a751 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -3,6 +3,7 @@
 #include <linux/blkdev.h>
 #include <linux/major.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/string.h>
 #include "check.h"
 
@@ -65,6 +66,8 @@ static void add_of_partition(struct parsed_partitions *state, int slot,
 		partname = of_get_property(np, "name", &len);
 	strscpy(info->volname, partname, sizeof(info->volname));
 
+	state->parts[slot].fwnode = fwnode_handle_get(of_fwnode_handle(np));
+
 	seq_buf_printf(&state->pp_buf, "(%s)", info->volname);
 }
 

-- 
2.34.1

