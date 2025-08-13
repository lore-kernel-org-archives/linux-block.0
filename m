Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20441F17EB;
	Wed, 13 Aug 2025 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755114774; cv=none; b=b1aFvrxlESJQfJODgPRUpssv1ipyDlyBjrZ72wyZN9YYA4LKwpxFM5/EiXX6doCRh31OVpUk08doXE2JkGDoaGTsekVRnIZ86s+xp4fxVqSWOIjkTALd5OKacnZbacdUMH9e0Ahk9krhHV+5HoCvis2eOg3RUF9hfqdNmcx8Foo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755114774; c=relaxed/simple;
	bh=yYtFjSCM+O/oZ00ZBkr9ugpWe+eY7AOSVd2HICf9vgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c1En2fREcKM9M5UlXGkFXL1fQwYrsfP4v9YSgPXvTrpmBmqbjOWeRiLs2YMtd7fnfVdTCW/LlDynkmpUPgeT37T5gB0uTld8xFcKHWbw8YtzyrkA+u+ABHZsI37PeWdyy0ssqEU5njdFVFQseVbBlSqok+tE0hgcrcCZfhCvnUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=maBEYEsN; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="maBEYEsN"
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DFX440026955;
	Wed, 13 Aug 2025 19:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=p4+g9A7O95AFAWmdt56Cs3TlyQSWP4D8Zc+B5
	wBXTpk=; b=maBEYEsN5+OHMm6cEaq75k5pChCN/8vGUq7Dx553GbW8NrOmHztL3
	evzLym0HSe/UCGLNtdYm7pncUV2wekWNdGobH4cch2ltFNRRFite5j+XMw7zWCtE
	V322tqFa9BoF8tpgzwd9831J1sWwvqy3MZFvGx4WI6rZEeIhTWg7LXKoeTFzcpg4
	jpBmypI9KxUXYxXYJcykzM5zCxMsIsanmdVaua3dOgfrzZXyeGDXVXJZdffOxcZR
	Yn5jKNmk/HN3F79lu8gTyNDN942VXigs4B5vxJnh/l2/rL7ghkxZntGZxg2zvvQq
	6vm5c5Z6V8mKvZJpOgvL96Fjw3/CLyepw==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48gjd78h90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 19:52:33 +0000 (GMT)
Received: from test-build-fcntl.hpe.com (unknown [192.58.206.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 5D544805E1D;
	Wed, 13 Aug 2025 19:52:32 +0000 (UTC)
Received: by test-build-fcntl.hpe.com (Postfix, from userid 1000)
	id 39DE0883AC57; Wed, 13 Aug 2025 19:52:30 +0000 (UTC)
From: Rajeev Mishra <rajeevm@hpe.com>
To: axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajeev Mishra <rajeevm@hpe.com>
Subject: [PATCH v4 0/2] review of v3 loop: use vfs_getattr_nosec() 
Date: Wed, 13 Aug 2025 19:52:25 +0000
Message-ID: <20250813195228.12021-1-rajeevm@hpe.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jRoJWYptiSbw3elBb9cO8FT7tZ1E0Gxt
X-Proofpoint-GUID: jRoJWYptiSbw3elBb9cO8FT7tZ1E0Gxt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE4NCBTYWx0ZWRfXwRi+ou8DwWUX
 NBoLpbQI6z3K3T3R5mMTx6lFXGoxrS8L7J2vKKabWV9JNXD1Nyn/IDgwR1j7byQiDZhk+J80wJt
 jbgv32umhgTidaEcWr4c3LnrVQ3oRLr4QPQxhYoZyOCnZMRYuR/QzfBCmz2/neQ7gG8V7FfOMCb
 PPbbYCv1bRzYXeNfGG/aFaQ7D/6HaBjeHOUNq28RJgwjRI3mrL6b9VB4sCYEgT1cZQBh1ngly09
 SHle/XNiLCbacO1/BaSrSTYKgFXf9ljgCLzhR9JnARpL+OSrO2FSkRArXOesJP5KfgQdfa0IK7n
 tZf/31ENScM9zX17u/U3/SZYAGPIQlm6abjTD49mY+B3U7IBnXVJ1T4aTzKmeQ4lTxFY1A5Qtms
 nsRlgI+fBf16Ow9DA/9B1XJ3T19W6gP7uQzT2DvzseHXZUOh6axVy36HVhw834SrGGLYjj8w
X-Authority-Analysis: v=2.4 cv=JuLxrN4C c=1 sm=1 tr=0 ts=689ced01 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=2OwXVqhp2XgA:10 a=ob3-ybBPVN92v31_HL0A:9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 mlxlogscore=402 impostorscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508130184

> This commit includes the following changes:
>   1. Renamed get_size to lo_calculate_size.
>   2. Merged the functionality of get_size and
>      get_loop_size into lo_calculate_size.
>   3  Updated callers of the above functions
>      to use lo_calculate_size.
>   4. Replaced i_size_read with vfs_getattr_nosec()
>      to obtain a more accurate file size for
>       network filesystems where cached metadata may be stale
>
Please split 1-3 to a seperate patch.
removed header also

Rajeev Mishra (2):
  loop: Rename and merge get_size/get_loop_size to lo_calculate_size
  loop: use vfs_getattr_nosec for accurate file size

 drivers/block/loop.c | 61 +++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

-- 
2.43.7

