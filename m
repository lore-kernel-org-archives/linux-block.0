Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11CC4F472E
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779953; cv=none; b=HuwiykafeOBTUZzMPkEAnZnBrKZ1Rm8DBRjwXl4ePMRfrBEfP+KhF8O525FkrGEcIGnr5Z3W5lz7JjQhkuJrGHDm4gwCvLuzuejSH9Y8YuxPnn6WfyI0wZAKjTfBU6/luvjnHTHnXiODIh3ysjAjRg9QFAFsMLA7nYTG8NI7Pew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779953; c=relaxed/simple;
	bh=9cXLQQHKl6yEKaTCBAgfXYVQ5NuyFBWmetQmFW80k6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RMA7iIwFGwLJ/+fOn3SBoi0cJzZ0HJnImM3SnhN4AKlSTfTh36xmodREMcaUiyvMrh5UwBc6uVqTyVwMNjlJsOBZNsDo5qu3k6z2KEKSC5+fx/skx3I60n6+RDAEwJJH70+r9hJm/qH2VaVgF4k68m+VAhRTMrfAOaDg62hd2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g4vmgpR+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PlV9kU1i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g4vmgpR+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PlV9kU1i"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE08v84178859
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 14:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Xm8ZEn8ghmOcAG3oNkRt/e9q/WbJ/MPAnge
	ljbhU5zk=; b=g4vmgpR+Wv07QF4yjUx3TTAZx5u3STyLEcb+kOa7MSOFCac/7mS
	PBph/bxk3J8/oY00Is2fhhNR7Zk2JKpHWvQ3uE85tVrNvM8CfFKkT89kOhdf/xKv
	ORFvzE4LkDRydyo/LoN4hI44GNmZcriByZHEEI3LsfqRb+JPhn7ol8we51zLukeV
	w2q7Xt6P7OUlNufe2GoXgbNEiOINH78xsHsavpU1r2w9Ks8tmH9tACzJxm5w7GpD
	1RIA+aS/kQq7ExbmuroVz/tZ9CiD/h8Q04nHETLEOm4sa/o9V1IN22pOb6lTH5OK
	a/2RtiCDrlSYOhj3/meKR1niJOq3NgPwG4Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0nm3m02a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 14:52:21 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so6677191eec.1
        for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790779940; x=1791384740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xm8ZEn8ghmOcAG3oNkRt/e9q/WbJ/MPAngeljbhU5zk=;
        b=PlV9kU1iaBRQesYC3WrtcmAV+VXaPFJJaIwVSv+uKHVIm0AWhTSAwaXMw+szEb97le
         2V6ayCRnR83Z855T4PHPiw7WfhfAwnvr0FV4O2xlw1E4qqA69B16XRVzReIpicnVHMho
         vVcKCa3EH1sPMioNGkyWg+VIngy+tttk+Aow6zNshpRE3pumtlLXpI9f0XqSuEv45Y/E
         pt87MOpcFc6UpDvQHKoPBfTD/hOvv/n9t69gRNXA+J2Laq1a+sbefeMbXf9z/4BkPRV3
         E27ZUaZJ6bZUCDeJ1oC3SNMjQZ62Ta/M07O8TZy/fYmZyt7IJXv49VWtbxSqJ4y+BDdA
         T+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790779940; x=1791384740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xm8ZEn8ghmOcAG3oNkRt/e9q/WbJ/MPAngeljbhU5zk=;
        b=z1tUfwFgNb7S/+v0yOQA7UGyWOKRkWspqqYoJbyGsfZBpZDQtSGau1DmLRjRg+NtZE
         8T5mp5CVlwn86Cyn2cU+BVxAO4Qhv5Ca5evPg/CMDOl9arlT56DZJh9f2QwkAuNb9pF0
         eS+7ORTjJLgNMMNQcMOaNJe0sBKnrJ+oLbrA7dkmw+iEg2WiNRNcSWPqNHPHW1FaButQ
         A2hSOGRpFstC/gLfM/J+eMqCTBjlFIs9tepr5ATdeYRb8Jss1GLO/nkWUEJMR5sKtGun
         5aS/9bXczCzXuNC7zpLINDuiocS/Po05wvRNF2X7ZqTOhQl55y5yZER/uV3StlMrtQPb
         O3jg==
X-Forwarded-Encrypted: i=1; AKwUvBzgTAcrlrk3a9LlxMCURCGvefWUxGUb1/io7jeb/zhQWjyVEJP+eDigw/O71K+e1ENc96QYNcAP3TJ7ZA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKsMUWknzh+cFeqVDozDpUQswZ1QUbi48HMwN1/5DvnRIsQ9ugz
	KPl20N6p17kt49suclhsyEz5GcqU7/VomeR4f0Ock7mWXfBmLFzIY3NMpYt543Y1XB4ANlWnwPV
	j8/UmjkyQm1apCQgYkzZNUr32Jq4xRYV2vUdF+nWCDntZUZru6ujp1afETOma7XU4W7tE+C7rSk
	Rj
X-Gm-Gg: AYBFou1KJfLhBg3I4vPlrkPrfCa5MwF0TSHNiQHSaQORrGmwWwi0JVgjamJML/dHPzc
	2pwvqEXt0AI6weqp1cJe05kYc4zO+peoX/QHgySVKduOlU1WfEeX6pmSZuG595MdvzgB3Jus8tb
	yyX7hr0C2iOaE3IFRJiWQ8mZaQZ5rPHBA5p5TWWczWzdEtssxTcMflcSoIqOtsDkgrbUM7CaQxo
	r0rjTAmQP19CVtjXrWcPcAjqdDHwwBh8d+1RzciIuEXRGoEiuzShT+TJuDJ2SpSq+ODBXuhhDJ9
	/EVOsnhI8Vc8o1+w3onyLugg5UJm2BVgoqjg02iaF6xgYFFMtJQk4HV3UCtUcyksuRQwd9QKdg+
	lm4zq+YBsXMGq+m3vUR89Xz5j3oy+uoY6YcQuoFwwo9qGLj9tEYMw9IU=
X-Received: by 2002:a05:7301:fc84:b0:34b:a328:c28 with SMTP id 5a478bee46e88-34cd9177b73mr1684538eec.5.1790779939765;
        Wed, 30 Sep 2026 07:52:19 -0700 (PDT)
X-Received: by 2002:a05:7301:fc84:b0:34b:a328:c28 with SMTP id 5a478bee46e88-34cd9177b73mr1684502eec.5.1790779939129;
        Wed, 30 Sep 2026 07:52:19 -0700 (PDT)
Received: from hu-c-gdjako-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5639339sm4524609eec.18.2026.09.30.07.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:52:18 -0700 (PDT)
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, senozhatsky@chromium.org
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [PATCH 0/6] soc: qcom: Add Qualcomm Page Compression Engine (QPaCE) driver
Date: Wed, 30 Sep 2026 07:52:09 -0700
Message-Id: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DcjpKk49yluYE5JtyN27e7hcQ4uxdggp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1OSBTYWx0ZWRfX6g6VovGkutr/
 nRioH4lkx9WsCKWBcjiR3yh360eMyvJSXCSVESiGYdljyvR8Fg4G7DK381Nd7NX2QE9YZQxrS5p
 8D1qwfZNcBdM7nd7+T+C5QPV5TQOcLL6NEjHDfeAWrT9b187OSef4932Od1mCFkuYI95ozHEI2x
 9NTZTvGDtr81byNZj2wSN3EBhAj6SieaxQh9p9pTgW1vYCYQj8ngCvAjII5MtsC9i50F3a1ySNh
 WZhgiKMuhASYiNw0mC98bhTwSro5LDKq2WOlUB8pituNzSV6ysczasTx++mh0BgbmyxflK4JD7r
 ph8vjGcoZKtLd/N1s3nf59iCJ6YoCTW+SqrALIjql+jEiBQGqOzCw4/dEnOz5xyloidXW/HNvH2
 V8kNai8zokk2k+Hrtk/gzVYtCfgXG9ghOR82YVxCzkKhh30fNYd/sbgK2r3BU6gei5xXzKhQa9R
 w9T2h3Mu3Ris2qGAi9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1OSBTYWx0ZWRfXw4uKbxE4kC8C
 YTg3XgGZCobMxSwXPBR33BvE1Zoc1o4xA4LTv0b+N8yBwlOEAmCDc8xUyraS79pVfNHQ9XuEA7M
 4O5iEXtnTkXazGNB2ES1wyoUtLP5IMY=
X-Proofpoint-GUID: DcjpKk49yluYE5JtyN27e7hcQ4uxdggp
X-Authority-Analysis: v=2.4 cv=fqxJ914f c=1 sm=1 tr=0 ts=6abd2225 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=oM0TwoE6PClt58MffhQA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300059

QPaCE (Qualcomm Page Compression Engine) is a hardware block found on
Qualcomm SoCs that accelerates page compression and decompression for
use with the zram block device. It is composed of multiple compression,
decompression, and copy engines.

This series uses QPaCE's "urgent" (synchronous) path, intended for low-
latency single-page operations. A command is issued by writing the
source and destination DMA addresses to one of several per-CPU urgent
command registers with a single store; completion is then detected by
polling the command's status register.

The hardware also provides a ring-based (asynchronous) path for high-
throughput batched compression, where transfer and event rings allow
multiple descriptors to be queued and submitted with a single doorbell
write, with completion signalled via an interrupt. This path is not
implemented in this series.

The driver integrates with zram through a new "qpace-lz4" zcomp backend.
Both compression and decompression are performed by the QPaCE hardware
via the urgent synchronous path: each request DMA-maps the source and
destination buffers, issues a blocking hardware command, and returns the
result size.

The driver also integrates with the Qualcomm Last Level Cache Controller
(LLCC) to activate dedicated cache slices for compression and decompression
data.

This is validated on next-20260929 with the following patch applied on
top to allow booting completely to the serial console:
https://lore.kernel.org/all/20260911-rsc_read-v2-1-98675c248278@oss.qualcomm.com/

Georgi Djakov (6):
  dt-bindings: soc: qcom: Add QPaCE binding
  soc: qcom: qpace: Add Qualcomm Page Compression Engine driver
  trace: qpace: Add tracepoints for QPaCE operations
  zram: Add QPaCE zcomp backend
  soc: qcom: qpace: Add LLCC slice support
  arm64: dts: qcom: hawi: Add QPaCE DT node

 .../bindings/soc/qcom/qcom,hawi-qpace.yaml    |  94 ++
 arch/arm64/boot/dts/qcom/hawi.dtsi            |  17 +
 drivers/block/zram/Kconfig                    |  11 +
 drivers/block/zram/Makefile                   |   1 +
 drivers/block/zram/backend_qpace.c            | 134 +++
 drivers/block/zram/backend_qpace.h            |  13 +
 drivers/block/zram/zcomp.c                    |  11 +-
 drivers/soc/qcom/Kconfig                      |  14 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/qpace.c                      | 830 ++++++++++++++++++
 drivers/soc/qcom/qpace_internal.h             |  84 ++
 include/linux/soc/qcom/llcc-qcom.h            |   2 +
 include/linux/soc/qcom/qpace.h                | 154 ++++
 include/trace/events/qpace.h                  |  99 +++
 14 files changed, 1463 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,hawi-qpace.yaml
 create mode 100644 drivers/block/zram/backend_qpace.c
 create mode 100644 drivers/block/zram/backend_qpace.h
 create mode 100644 drivers/soc/qcom/qpace.c
 create mode 100644 drivers/soc/qcom/qpace_internal.h
 create mode 100644 include/linux/soc/qcom/qpace.h
 create mode 100644 include/trace/events/qpace.h

