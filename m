Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5333E3C9EE6
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542773; cv=none; b=QUbCJbU5koV9GPaMdBEpqNWJKHeSaO5UBvhnnPL3ypS/VR79Q16uk9cJ+bWXznpGmkojNdqBTHFbpRAgmwxNImomxJ+/Arsks8UHY6Kxmte16lT7L0bMwouRE7ZNjeRgTvEAjGhehH6Ft5HhP+ldy+dBNTiIQZl5ZfaGXWVKvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542773; c=relaxed/simple;
	bh=CoANQFi/ZRSYrDmCfagNQeLYrej3VKmj01BVzyAA9A4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GziZ+pnaaQ4NLbHt2QLbaYHylO/ZEY4tgR8Ks1BlA40LvHLBbXu/n9O/XZ4IYNNit08KzQG5EGMhDWFBVT8OKUu2NUfbFRRHSnoScTq64huMWoMY37OjdhXc9pq7V2EaV+doRkb+OoJAL+zW9BFNOij1G891YLRz3t0KqQfIFP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=or/f1GzC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iLyYmzqb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="or/f1GzC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iLyYmzqb"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U7xjst3636534
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 09:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=x5dTUSOw7H9fc6JjoGNbvk
	QWENZ5Gggg4lfoTXgZBCs=; b=or/f1GzCqdGc/MQqLsCodCvWaTWfV6IuhnDLHD
	4S2Zf7Gd9Mg5Lup+8eWRqXr7SAim+HTnIx+PZLjevs7wVxhEnTyT20ky1WGsZw0F
	2oSb0E2Lqg+XRk8YTGwlNL5yl1DYIIecQr4WzUeKQiIzI54kuM+6N8VUP/ECBaXp
	9MyGjBz2usBz/rV3wx4OUJuou/a3dGbKIIOtFg+ZFAMFrifBb6v56gW9pdaLB4cP
	95g/dJ+xDH+M80Y7RqEsvNwcJM8h9EdJyfynNwbdVoLYuPuO714agRXrerQwyjJ8
	nwtLBVnsoiP2/e34zwwB1so9NrPY7wMAMexrzUTS2j/JPu7w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duv3q1x6v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 09:52:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso1263998eec.0
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 02:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777542770; x=1778147570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x5dTUSOw7H9fc6JjoGNbvkQWENZ5Gggg4lfoTXgZBCs=;
        b=iLyYmzqbs4YDt6raogDGx61cOVvvJ6kEZiOEIQz41dphW9A88Hay9V9nON7iRRRbN8
         AFVIuhtdXziApDM66pXvMOXxHhSAtV4B0um1vX0J2jerE0HRUM4nt0RYBrcQL11YbzC4
         sWz692iLw77Bn33A5lsrHA65Ns377As9+H7dsvcaBcKLTbwXRuEf1kohTKptKcAvy7iX
         DsRfrUaA9lDiFesy2SyxpGkiCLSp5oZUl357NlhMRBZAr1BoFnPnVy6pT+1lhyWTnMmu
         TuWygb7aXsF4TBw9cS3K1oNquPZIaGlgcUEKc+CQspSfWkQGgz2BWqmsai8GO/GQk78+
         Qx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777542770; x=1778147570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5dTUSOw7H9fc6JjoGNbvkQWENZ5Gggg4lfoTXgZBCs=;
        b=O9uwr2dhu+pPAeAUitEetgbodDhyqVLoohDFS1Dzeqb3dvOhs1spUD1pwwJvDMMs90
         BI9tZ4IDZK/Gvm35N+Z3ljhI6JOCaixyW0K0P0n0vo3G2u2bHVAIRsHNQ/eD1iVTJmV5
         10u3d13FSz3ErzKBWhYyqSCYaAl41i67Gakeoeczv7t+c3qP14EeVYUeU/rdT7xGdSLZ
         0r1OzfhOBqEtkCXSb+sCx6jDm5H+phivmdL4BjWtFGHuMJxoPmnHTcYtZUB7VL7/gYCo
         b6+4Gv53Ja+901EnFeyHEIAGqmPBhzZMDd3CsHySMjxQjDf/6n8qkA1jkWx+Lp6Qrqp+
         VQRA==
X-Gm-Message-State: AOJu0YypE0MCq6hjhRV8EmgeJMd/bUhG9KGKY3AT2je6ncdoGm/Qy+6G
	D+4ylnfkpp5zSP8zdCz7s+kZ7mKWL81dAUgNbXcYNBdrOWRycdMUIpSJoSQ36VsyTbi0yKQZim9
	nbM3Twf/c3MnaprHgtSV2q4U2uHHQjlS79ivsR0EwdbBT2UPyoMmh4zUjYLit//pz/bdkk1Q6sA
	==
X-Gm-Gg: AeBDiet+mnKDPnj4sAZRvOYLjT5F4HhRUqItZLVG3sB82CZtaXPLXB2UScamWzreytS
	lgvKtjWEvpHJUzlxNu6zgQuizaImrnvYJCme4QvDesV6S4rOXf4QuGjCMUuZsx5YJPudkgu2bjM
	0YMCTD1K8m44PsyxWxcLr/0FSOJ9ZztHV0ut9UnZ+xFxhKmJFRQqYemzE4bDwys6XwxKpihrjPT
	HeZFYzYr+DnZ3YsW36Tf1gm5gNoIfgZS29Jv28vLS3Yo7Ytay4TkXCP2Ix1ehtXxd/Z2d2HGBod
	I8C9+5CFwAxMLIC1smtVfPGFZoUERH7mMUBl1dex+L7fwPdn3HUeRNM24jQiB9D1eBEi7llO9vD
	XvSl8qxbm3V8wf6JX2joy6f0hYDRxI6+KQvw6RkV1IMeI3nrs733isxZcfHlsj9hCZwESAqXkNm
	6Mlfu4oI+GL5l9uD8=
X-Received: by 2002:a05:7301:5809:b0:2d9:6373:ad24 with SMTP id 5a478bee46e88-2ed3deabf15mr775198eec.26.1777542770233;
        Thu, 30 Apr 2026 02:52:50 -0700 (PDT)
X-Received: by 2002:a05:7301:5809:b0:2d9:6373:ad24 with SMTP id 5a478bee46e88-2ed3deabf15mr775189eec.26.1777542769667;
        Thu, 30 Apr 2026 02:52:49 -0700 (PDT)
Received: from u20-san1p10573.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c0d218dsm5885804eec.27.2026.04.30.02.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 02:52:49 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: linux-block@vger.kernel.org, ebiggers@kernel.org, mpatocka@redhat.com,
        gmazyland@gmail.com, bmarzins@redhat.com
Cc: linux-kernel@vger.kernel.org, adrianvovk@gmail.com,
        dm-devel@lists.linux.dev, quic_mdalam@quicinc.com, israelr@nvidia.com,
        hch@infradead.org, axboe@kernel.dk
Subject: [PATCH v3 0/3] dm-inlinecrypt: add target for inline block device encryption
Date: Thu, 30 Apr 2026 02:52:41 -0700
Message-Id: <20260430095244.3352446-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GpBio1gsFbIrTYtdPLkHxgUxI58FC-QQ
X-Authority-Analysis: v=2.4 cv=dOyWXuZb c=1 sm=1 tr=0 ts=69f32673 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=smb5OZ6KEkrD95H7haoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA5OSBTYWx0ZWRfX5nonmjku6C9n
 vSEvWYn7CxQuidMc9ADIumUAaTPF2yolJuep8gxN3LdyKT71pbVkEZqo/tXLNrs6T1mLaVmIuIC
 1hN0r0F3ES7gOHwy7WUal/5CCdySpDI13xqGgIx5t2e+XknkXO5usZ2t/ylLuna6LMIsYNNzwRX
 MA4UzflWdVH00gikftp6h9NhC6Bk5F4pSrmvNHYEbwJVO5rFJtKKF073YsYixCUyE2FuGeyf8Ek
 qB4SZyzsoijboAJY6aBcbJDhfTSIvlb2WkOuv85wj07Wm4H+lN8lUnvrUA0txAhpDm7t0/+4EJ4
 Jv5kJZteakVi8cK4zZD0Nc446lluokinf7TGoK9fBRrTma2KkL25EW40UC5ohf02XJg4/4+7hyP
 NkGFtu7eyv5dXNA8Ex7MhvxO8jXuqKFjOxlcsztAFvY1uuPBLNJFAHvkFHpe2L9aQOMFBQK8EQE
 PUpjIXOUm+i528qYXaw==
X-Proofpoint-ORIG-GUID: GpBio1gsFbIrTYtdPLkHxgUxI58FC-QQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_03,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300099

This patch series is based on Eric’s work posted at:
https://lore.kernel.org/all/ecbb7ea8-11f6-30c1-ad77-bd984c52ca33@quicinc.com/

Eric’s patches introduce a new dm target, dm-inlinecrypt, to support inline
block-device encryption. The implementation builds on the work previously done
in Android’s dm-default-key, but intentionally drops passthrough support,
as that functionality does not appear likely to be accepted upstream in the
near future. With this limitation, dm-inlinecrypt is positioned as a
practical replacement for dm-crypt, rather than a general passthrough
mechanism.

On top of Eric’s series, keyring key support is added in dm-inlinecrypt. Thus,
both keyring key and hex key are feasible for dm-inlinecrypt. In addition,
dm-inlinecrypt.rst is added as the user-guide of dm-inlinecrypt.

V2:
https://lore.kernel.org/all/20260410134031.2880675-1-linlin.zhang@oss.qualcomm.com/

V1:
https://lore.kernel.org/all/20260304121729.1532469-1-linlin.zhang@oss.qualcomm.com/

Eric Biggers (2):
  block: export blk-crypto symbols required by dm-inlinecrypt
  dm-inlinecrypt: add target for inline block device encryption

Linlin Zhang (1):
  dm: add documentation for dm-inlinecrypt target

 .../device-mapper/dm-inlinecrypt.rst          | 123 ++++
 block/blk-crypto.c                            |   3 +
 drivers/md/Kconfig                            |  11 +
 drivers/md/Makefile                           |   1 +
 drivers/md/dm-inlinecrypt.c                   | 596 ++++++++++++++++++
 5 files changed, 734 insertions(+)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-inlinecrypt.rst
 create mode 100644 drivers/md/dm-inlinecrypt.c

-- 
2.34.1

