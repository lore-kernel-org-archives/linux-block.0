Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795437894;
	b=AJW5wscGVSDk5+iDySdWW2DcSWEw3WpwD3IU0TMZVacCDOeQVTtTGQAwbswaL00PO1Rt
	 dpmX5/AwRYocreqMLhQVyhlTaWPdvkkD7yCgJ0vnKCunqs+oaeyhOK7rdFTnsQKgIN7GB
	 Zz5Y8cIV3k9bWRXexGWIPI5B4qU3sP4ouQEIjBoWImZdLg4nvfMeZJGToe9J2tp1XkRn2
	 O4JROwGy/Eb7UaH5aHfSgHhSB/csrdIXKBmJM2MA3hox966RYh2NNNSlMiW3JILLD65/r
	 MKFk6mVotslkJ/WbFgvE37UmUCXbfglaWZ96dnZRERe/VzDc4Lw4S37Ke8oWNueJIog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437894;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=q2LLXgfqwD+xrLJorPVwTBLDULLlABEy70l/ShybkrI=;
	b=0xsfvMQofuzSP+uVguI1lFS1+GgL84i8a+EBLWyFlU0jxLhyoCAvNz+o+QirE9UX1syK
	 IMnmDlIY4lUwis3q5DtYQIgP69OtrDQgHDrSMdWyPWPmQ8l/ZBFJOp4SGnR6NSxiUghTT
	 b++j/cH+9H8quL5trXquqXk6U8GvOF/Oyhd78/V6mjjVDArVns1V87fU+TkkjgaebVsh9
	 cdoMtIMCJt7xCZBMo+KHwTTGw2EeKAHtaCSQ9sISp1bpCfnweNlnABMlJWpkr2C9ivKMd
	 DfuYumvhJDUPNPZHnasoUo2Q1XBXsn41XiI7T2aP8J299dkBbhCy8jrmylZFcGds4SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d4XbwIfa;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T3lNwRDm;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403E606A693
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 12:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D403E606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d4XbwIfa;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T3lNwRDm
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCFxKt1943641
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 12:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q2LLXgfqwD+xrLJorPVwTBLDULLlABEy70l/ShybkrI=; b=d4XbwIfaFgm/G8Dz
	xl/ht/3kCWRIcMd0XvU5QvDpv2xoviFpVh0bPMuS7EFpE9zcTSDPmdZih/S0RXoK
	T0Zlpg684HmOWajh+tFVV0lVtzpVf1xJXWcLnbc0zQn2zGBFaRV3eUTHyX5gGpjL
	8MHbnsq+62DhuP4Tjn2WCgrEE8Y5p8XRo4NhfLrSUf5fkr7l/4DTcccHoiRoPLLX
	3nSOnupI5viJsIA7rZ/uH3FRwhIMvE4HlBNHGJH+13cIbXkA/uQgxTnqces37Ijd
	5ewwLIJjXgd38wmlt7oBIjDdEmZZcxxJ/7fQeeQfyuHcKrEemjnycNQKqZLIYMcT
	et25Sw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy01dxm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 12:44:52 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-9213c7a506fso54569566d6.1
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 04:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795437892; x=1796042692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q2LLXgfqwD+xrLJorPVwTBLDULLlABEy70l/ShybkrI=;
        b=T3lNwRDmBv2qflit4U9ZHSCTKCxynVZBuAwDZVceY0ziElh45jpCiQXofXZrSvKPAi
         R/dHA1qXXnyZYbB6tyKUZu2xmoMdCbeFZl4y8A51VoKL8UjomXTcRmW+Lw+3KAv/mCV+
         Y5301PH/C+b5EDpuqcMYi0JLGiNBMp9d3wC6crGTXGPPe1YCLk6EDMQM4Q844evjfUxd
         j1SAVkgwD76pqW+TJL1lR/GFFG8klfcIJi6PdvqNhgZLow8VQdafRcvjRUTmEnIbJ5EF
         xAaMXFwLsUdRCUkDtdAUwlcWSWpCIRyh6DMhRNCrqUE6mhVdEGwRSk8wbThJCMM1QBKe
         pPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795437892; x=1796042692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q2LLXgfqwD+xrLJorPVwTBLDULLlABEy70l/ShybkrI=;
        b=FginIxERZprqhT60Cs8pjj6aUkSR/NULeMflsEmXTIJz8c3B3/xldseuB+i78W5OxA
         yCQEXjB8V6Pguv3skXuCUN6QoL378tfP5NaWB9JcDu5AR5Dmj1EA2/Ed/BQFv0V9FAL+
         KVMcDo+Kq3krt0E/sxequ3V43PGkHL5GmBlfZeABjg+gNPrZ08vrw8SynvqenA7p1h6O
         +eZtYUTtDHgYvfPfDWYcLcB+NZELQrD4kVRKNtWFMILrTrK8Z5BCRAXFCsS0y6NgUn99
         GVc4BZYr1ydqJuOqCcCMWtzmYFHyfLwKqljn6b9yE6S8wELCdK3gmHl8T1K6RtJembDV
         CteQ==
X-Forwarded-Encrypted: i=1; AL+hErFV+r5hWLttfhXEXVpfU795+1/VnGB1Qwa+FlPUK+NFcmjC1LOwktvAaX3slHPKQPlz0fyZU71oMV1vJQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+MQ9t5TTfxru0ZHXKoVQMRYLQwnQGJ2pUOQ8Rqfw+iD9gF/jxP
	rL5d3kRopHgHV+BF4y3yjd6gqcrWeal2PdwSsuj6+pKUv1FdNbK+4HQ0guKgJu/d6g7TqQ2eHBp
	aiEReWORlKWGme+hn/GHmAEWNoJhJNys1fiX9pxiFYlMCqAlT/MDeRkK7UamyJ8vB3jcisEfmC5
	e8
X-Gm-Gg: AZFdTZdl5D6b1AblaC5tmmlUckssIvfIcRGFKVhf/Ur0s7Omy1sNQFFTTnGrrUm9ryj
	UP+RelHNqcCGPdBLmcMCSY/eNvfqXG2MBzZJ3AtoA0z9xi51c4a2f0xyFWeZp0MrxlS+BtWhNpo
	xLzoYRdzkzb+or8FT8BNeWrvIF7RY2SwDuL3ME0zYhwgp/0ZDei7JNL3hwYarvgegHobP43tJUO
	FY3DoF5FH83DGhOC11pXPXk3o9Vi/OWkaVD1frjEff0DLLoFeZENFXg5B766ARpQ203Umcud9Oz
	dzHXyv7gCuX3le8ln2SSgJdIhc3T4Vrp5e+VsYgDlr6bZoUK2HbKJSSzBOVcCq++hdflegzmirv
	MKopFTDzHtUqDTwiKhbDg5H5j4bjr+rCtFln1Gj1ewj8Z/oAhZM72ttRlAbIwUVBSRNtbKKQeVC
	mFsEapjukq+iQtJorB+2oc263SggMFkDTEJBs5OrV7HkvSqYGgTjrBGEK+Ec02rg6Shexikk2CT
	Ro9myDJm3v5YVVt0YLL9TqSXigR
X-Received: by 2002:a05:620a:4493:b0:949:6530:816f with SMTP id af79cd13be357-949ba9fd6ebmr1899081985a.42.1795437891934;
        Mon, 23 Nov 2026 04:44:51 -0800 (PST)
X-Received: by 2002:a05:620a:4493:b0:949:6530:816f with SMTP id af79cd13be357-949ba9fd6ebmr1899077085a.42.1795437891451;
        Mon, 23 Nov 2026 04:44:51 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm649355875e9.4.2026.11.23.04.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 04:44:50 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 13:44:44 +0100
Subject: [PATCH v13 1/2] block: partitions: of: Attach partition fwnode to
 the block device
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-block-as-nvmem-v13-1-96ffe1f59332@oss.qualcomm.com>
References: <20261123-block-as-nvmem-v13-0-96ffe1f59332@oss.qualcomm.com>
In-Reply-To: <20261123-block-as-nvmem-v13-0-96ffe1f59332@oss.qualcomm.com>
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
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfX5l5/B2o//zRH
 jtYjTNh9nU0De6ZMV6xbG8ZGrp0Uc+mCzlDz1C9syaVCgr+VvRq1yhZfYtNyQXRqcp0rFfsPUrM
 C5D09UKYIe1GVi2MvQld7ZpEuvvB4Ly38fLT3tgGPD9u/66R3lMbbvwDsklAsKLnoA8C2LKY+zM
 yaSz+2b8kLPIW15weab8p875o1lhtMm/ZZQJA0/IAEc5oDH0bb9P/zO368wVRuyLZM01I9A2LAR
 sfZJyX27DrUFHgxexCJMaaOvpAYMAXW1lzmUG4iMx0qegUCSE4qMagWirxtbeywWWYfyN0xNwvP
 aSvUYd1rT2kLBOhNC9fMae7ZQnVtokUaUeT6dT+pCDNnX3rzDY0yhQGxPPdRfbPS8uu9lI9fyJY
 WU2miockD/SkOoQlt0bhSdN9jdECQedUnQb3wX3ZAKneaeW3eC5m/etg1ZQIoRiGECbLSC5NKI6
 oM0+z+hgrV6hClKejkQ==
X-Proofpoint-ORIG-GUID: eXY41OH41YtyisWDAesQoQSTiwwsc74Y
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b043544 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=_IYX2gaGVZBpxN60pRUA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: eXY41OH41YtyisWDAesQoQSTiwwsc74Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfX/bWRFsMpygEu
 Ao7hVbE5hK6OON68S9U7KBXMrupg7t4KcLOAA4wgZM7M0KKUonaEScw53m8xalD3+TqBgEIMpgv
 bNX5zXBf175G4ltXHNP2BoXOkmoOV80=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230050

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

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ulf Hansson <ulfh@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/partitions/check.h |  1 +
 block/partitions/core.c  | 20 +++++++++++++++++---
 block/partitions/of.c    |  3 +++
 3 files changed, 21 insertions(+), 3 deletions(-)

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
index b5c59b79ca7cbb28d4d93478ee1c80908f76ee9f..eee954df1ac6ef7dd4f02ad5c9d49aed778bf015 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -11,6 +11,7 @@
 #include <linux/sysfs.h>
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
+#include <linux/property.h>
 #include <linux/raid/detect.h>
 #include "check.h"
 
@@ -110,8 +111,17 @@ static struct parsed_partitions *allocate_partitions(struct gendisk *hd)
 	return state;
 }
 
+static void drop_partitions_fwnodes(struct parsed_partitions *state)
+{
+	for (int i = 0; i < state->limit; i++) {
+		fwnode_handle_put(state->parts[i].fwnode);
+		state->parts[i].fwnode = NULL;
+	}
+}
+
 static void free_partitions(struct parsed_partitions *state)
 {
+	drop_partitions_fwnodes(state);
 	vfree(state->parts);
 	kfree(state);
 }
@@ -139,6 +149,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 
 	i = res = err = 0;
 	while (!res && check_part[i]) {
+		drop_partitions_fwnodes(state);
 		memset(state->parts, 0, state->limit * sizeof(state->parts[0]));
 		res = check_part[i++](state);
 		if (res < 0) {
@@ -247,6 +258,7 @@ static const struct attribute_group *part_attr_groups[] = {
 
 static void part_release(struct device *dev)
 {
+	fwnode_handle_put(dev_fwnode(dev));
 	put_disk(dev_to_bdev(dev)->bd_disk);
 	bdev_drop(dev_to_bdev(dev));
 }
@@ -294,7 +306,8 @@ static const DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
  */
 static struct block_device *add_partition(struct gendisk *disk, int partno,
 				sector_t start, sector_t len, int flags,
-				struct partition_meta_info *info)
+				struct partition_meta_info *info,
+				struct fwnode_handle *fwnode)
 {
 	dev_t devt = MKDEV(0, 0);
 	struct device *ddev = disk_to_dev(disk);
@@ -343,6 +356,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	pdev->class = &block_class;
 	pdev->type = &part_type;
 	pdev->parent = ddev;
+	device_set_node(pdev, fwnode_handle_get(fwnode));
 
 	/* in consecutive minor range? */
 	if (bdev_partno(bdev) < disk->minors) {
@@ -449,7 +463,7 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 	}
 
 	part = add_partition(disk, partno, start, length,
-			ADDPART_FLAG_NONE, NULL);
+			ADDPART_FLAG_NONE, NULL, NULL);
 	ret = PTR_ERR_OR_ZERO(part);
 out:
 	mutex_unlock(&disk->open_mutex);
@@ -564,7 +578,7 @@ static bool blk_add_partition(struct gendisk *disk,
 	}
 
 	part = add_partition(disk, p, from, size, state->parts[p].flags,
-			     &state->parts[p].info);
+			     &state->parts[p].info, state->parts[p].fwnode);
 	if (IS_ERR(part)) {
 		if (PTR_ERR(part) != -ENXIO) {
 			printk(KERN_ERR " %s: p%d could not be added: %pe\n",
diff --git a/block/partitions/of.c b/block/partitions/of.c
index 53664ea06b6540e3d1155141adaafac7286f2d21..4fc7c80c407de42b2b31be2c82e0e6bc2a30c9e3 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -3,6 +3,7 @@
 #include <linux/blkdev.h>
 #include <linux/major.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/string.h>
 #include "check.h"
 
@@ -62,6 +63,8 @@ static void add_of_partition(struct parsed_partitions *state, int slot,
 		partname = of_get_property(np, "name", &len);
 	strscpy(info->volname, partname, sizeof(info->volname));
 
+	state->parts[slot].fwnode = fwnode_handle_get(of_fwnode_handle(np));
+
 	seq_buf_printf(&state->pp_buf, "(%s)", info->volname);
 }
 

-- 
2.34.1

