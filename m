Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6173D299;
	Tue, 18 Jun 2024 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673224; cv=none; b=leqIL742VS7jpGw6aSZQygX3sL+rysjFdukV+uH8lEpImPTQju4XuIwfxaZfT5wxtN+r2ijtMdLR4LzKesDa6fcpat/FLyGTnARSo9zwERapQgblR1/iVh0R35SfYxqM+ma9BovLYC1g4mYHS3u7C/NiQOT1Lq8TUprBlqWpDkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673224; c=relaxed/simple;
	bh=V6WzLH4EcKoHU+2H6sTyjWFZ3bg4omy+yF0hlneJHYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iDXkFZ8quHgoegtlnQEBcOHZGYGRF6s+0YnjcARc1Vj/Z3eCALa9SCuG1ZvtqJ2Y0xdTm03WjqhlecaHstQdyJKMgaFH1YWlNNHi1syYkk8rcooZo/zwmeXnB8Qj60jDh/ih7pfNKTqFvs5C8B/pYp6SF5yB6uZrkdJhQ8hgHqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XRI9/vAB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XRI9/vAB"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HI3M9I004505;
	Tue, 18 Jun 2024 01:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6oDHP2XWRmmVtWbK3BwBQFZ19d6h5vleAUN6WDJSFJA=; b=XRI9/vABIHKjCuOO
	piQMR9M94gAEQGIIZ4DRwjnWKmhi1WfvKB0ybvVVhAyXCpu6q6SUEpZdWME8K3Dx
	vA4Tb566mW4VtqKRtHcpQ5tr0iKGEeYQsSH/PjchWqWwnwe0P+bMZa3peoC1+eIF
	Sl+TJhrHKJYafUJTm1bzi1vj/D62EYtEHuuyPtmDbsy9W0xlT8otAnnYl7CDelHQ
	MtuXAR7kLtjvtbEozg5lEN3KYcYNYR28MUucDQpWmCKHZA1bcVUFwF66jD/H8Fr6
	csVzU61z5qNM9brHJA15/4lwY3H9jXgs0Hd1/kC/TiNH9BAP6OxbV81oWiSstKMy
	Br9GMw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytt378s1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 01:13:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45I1DeXB028902
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 01:13:40 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 18:13:39 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 17 Jun 2024 18:13:32 -0700
Subject: [PATCH 1/3] amiflop: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-md-m68k-drivers-block-v1-1-b200599a315e@quicinc.com>
References: <20240617-md-m68k-drivers-block-v1-0-b200599a315e@quicinc.com>
In-Reply-To: <20240617-md-m68k-drivers-block-v1-0-b200599a315e@quicinc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UO9t44Uehjpnys40IhVzw3LW6A7tWLN7
X-Proofpoint-GUID: UO9t44Uehjpnys40IhVzw3LW6A7tWLN7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=774 adultscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180006

With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/amiflop.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/block/amiflop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index a25414228e47..310254c994aa 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -232,6 +232,7 @@ static DEFINE_MUTEX(amiflop_mutex);
 static unsigned long int fd_def_df0 = FD_DD_3;     /* default for df0 if it doesn't identify */
 
 module_param(fd_def_df0, ulong, 0);
+MODULE_DESCRIPTION("Amiga floppy driver");
 MODULE_LICENSE("GPL");
 
 /*

-- 
2.42.0

