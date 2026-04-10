Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8093C5DA5
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775828446; cv=none; b=nD5swCyQG58WEsNsPwCe3g7msaRdBzrCYzjVape7ZzlmszZxq3I1ksquu5YmR0FHH4iHId2+arqF90dkEezFhpeHObSyF/0d+v2vWPVB/d/Jf8ac99eUuQd7L5SngRKkSoZ7ePJffQeOzdOqbwysJT6dOie1jWzXA1d6Tsc1EU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775828446; c=relaxed/simple;
	bh=ZzD48c6YNqTNTxvog2KhjcUYavGruY/dRo31R1J745I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PolDCVqRRsJkLUYHZPMa2Xo5zuxpLf0WAieTu1Ct4vH9szEJX7y9L2kZ7EBeF9/aGuZAY6dOTyMpstpDCsUUeMNl+I6mkOYrQM64us34kUX976ZMcSC+kih6Pxtd3+4vk5OU5M+i81DAqFcP1SEoPXL6iZx85ZpC1lXKOxW/6Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GISwSpW9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G/yC+bFh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GISwSpW9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G/yC+bFh"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A8bGon115435
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 13:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4/G7uDRt/NN
	5uhqO8B7jr/VAfO0+XnKeOAa+4ruW6IA=; b=GISwSpW9PL/WB+EIKDmDd5ONuKn
	Oz2E254irHMF71/LzvvEz3+ZhGBZmNcSUC0ywboTcfQC1yQGkCB0BcZp1M80OlQz
	K+W4ds/tueKzDQbPt4Y5GY7EXFythgbht49+MLaucVo2CuLPVrn5IL0rqV4l3osa
	2G/h1BRtKFuLSx79Ifwr1BaQ/pkuTi8hMVgiY8YwAPnRv+ZWzQ+pRgGt1Kquz4f8
	jKWqZA9n8l+j6ie8egkI6R5fet9eLFmaYs4/fPSwjt/aXl+7yVRfh4KKL8nzd9X5
	Qd2fHES4XslHPKNs/EiYlxMZb4tfRiEDM6VoAdJCI2/zMMHzyZxS9CoWhTw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dee8xc1q8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 13:40:42 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12c28353912so847776c88.1
        for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775828441; x=1776433241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/G7uDRt/NN5uhqO8B7jr/VAfO0+XnKeOAa+4ruW6IA=;
        b=G/yC+bFhpy2alp4Kz1DU/eWAhCK+Ff/NX8ksFMSz9yz7UOYN3jYCdJT9tqlmtNoZTC
         wD5chhp64+KLvA7u4bHh1pqQWDJIemSw3wHp1sBX3RPNNs/wMDsn/wsUt/RFxuHLrua3
         6Qsbd7O4ciflOqc35dIRoSUWb55JE6tv1c0N8imZVRG78ZtZf0m2DrGTroLOCzyNPB69
         pHuCZ4CQVKH0pXGd7+8wGK9ZtBNF8YkwISOhiWa/1UZ4uu9+XzSDrAwRdDPf9Q+YI6FU
         H51HBI7Rq1JWQyrcX7c1EKr7NRtZ740miIrzTWwCif93dQHrjMjJ2H/zuD+ys9Z91jDp
         eq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775828441; x=1776433241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4/G7uDRt/NN5uhqO8B7jr/VAfO0+XnKeOAa+4ruW6IA=;
        b=NB4naosSiMffsP0dHZrwj8/WWBpZHoPMmIDXeZKf+lmj8W+ghGRjzCNbxwj5ZmHnAw
         1msrWHahoIuFqG4WeKPnme1BTh63gCzlvC7AOYzYb5FfhPP1vLbIiUPDhCjxoACSzMD5
         FAbD/KKT/eX9pzy1Y9Uz+exezRQTyF3oC+Uf0Aw5t0EiV+u65szfCt9VrQQ20UxzIqyj
         L4mBqWrIn6tmlEK8uIJGApyIMd2cvrKCcF30zBlXuTWme7tTyaHbmtBL4+fmVX7fxFot
         e+dRYUQlRphfCAcgMljZCBocAY09ZFSLb0GtvSbnDfgvxuQY0muSoapIao0fyJlT+hyy
         IVcQ==
X-Gm-Message-State: AOJu0YyimSaJuN4HOBQcXc/7Pyh6aiEKduczvntvuUlXrfMVXmY0ZBW5
	/3xM3QUZk+1qfUzihwjBQLOWA2lpMK6Ng31xGK2PQR0szBv1E4BPI57H3PmAaUDf23Se5WYjrh0
	Hmxuf8Fi1vZq+gLTWNb599wWgQiGKi9eN49XDvQx4tdwLAW+nGbJ3W5OPFaSE7HaE1BNNOJTG3B
	Zm
X-Gm-Gg: AeBDievrgyyAomDa0DPworUsx7NdAP8v8/lnXO2s4RVRnk6z3iS3D/CrMhiwWuVaDU3
	BwNE7OTMt1WF3MZuBHyl/0dZqQdmwhrT/XVbHCd6nE/eTowHX4UR4YuI9eUOA37qKQ98BiEvlYY
	HUHkdmG1/QNMzNjljJVhc2fugsUIR4IiotT3Q5lNBftBc+Db3yqU0XRwrNXoCk1DMuN3cQu5PVw
	uTkUfF5YWMgZRaNNSB1ISepVbN42/wgdJPEkQ/wvPbWNb9EBWt8ehFS2aQ7Y/X5LBDakBSQ4m9b
	AlzgPi1rLkWAVuncfpHpjsAXu0q7AFkoQw23iFfn9wsrxe2EAGqnkPt6AJFIFVZfwBVVib9RsIK
	MhMyyqirx0irypw+fGkozymfPyBJclUPoqI/8bhJMS6y5ewRjg21wFwVuL9sAQvBXS2Vf70dPjS
	sVi3OL
X-Received: by 2002:a05:7022:790:b0:11b:b179:6e17 with SMTP id a92af1059eb24-12c34f07ce4mr1827743c88.34.1775828440749;
        Fri, 10 Apr 2026 06:40:40 -0700 (PDT)
X-Received: by 2002:a05:7022:790:b0:11b:b179:6e17 with SMTP id a92af1059eb24-12c34f07ce4mr1827703c88.34.1775828439906;
        Fri, 10 Apr 2026 06:40:39 -0700 (PDT)
Received: from u20-san1p10573.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561bde70csm5172631eec.15.2026.04.10.06.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 06:40:39 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: linux-block@vger.kernel.org, ebiggers@kernel.org, mpatocka@redhat.com,
        gmazyland@gmail.com
Cc: linux-kernel@vger.kernel.org, adrianvovk@gmail.com,
        dm-devel@lists.linux.dev, quic_mdalam@quicinc.com, israelr@nvidia.com,
        hch@infradead.org, axboe@kernel.dk
Subject: [PATCH v2 3/3] dm: add documentation for dm-inlinecrypt target
Date: Fri, 10 Apr 2026 06:40:31 -0700
Message-Id: <20260410134031.2880675-4-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260410134031.2880675-1-linlin.zhang@oss.qualcomm.com>
References: <20260410134031.2880675-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEyOCBTYWx0ZWRfX7+UM8LoBBx7H
 FPkZAUqZsJb4//Mw462LHeor+mL/8WrvyKjldCMlLQ/CSy5lb3QkIf0uQFfdmDUrmQWfezx1p02
 SX1tlV1v8XY6k8uhOpKPgJi36rMbeqLkNf53KdriTSvKuPxZu1CaKHsdtB6rV8+9eEvgPyox3f/
 NLt9G1RmgTlND8Qn35K4k4d6LPKLIRxqlGChRALUdhY54fOb34dvPVuNQY/hCNLLCvef8pu+DvG
 2nT3yjwV6pRH/2nYZBZGsECqKFbV3lEaZKVHNXJfacJ+gB0Z76jQGNupt6PxgRjd2er6UgnZpku
 AHpvXzyR9Eav7sKY8kFB52/Kw3PebHRRjL8hbDKjM+YEO+0URWXbIP5Jn3z4gRZDMF+irQwxJrc
 +TDV8P34odcvgHc+chJq7jUfoF1AkW7sL8JT1jZbWikC427jEGBBeZEzQh5Xm11QF9ruNwwI6dU
 m/M+SFYlvsnyokwqWqg==
X-Proofpoint-GUID: n5k64rEg3Rykm3p2gaLho_QV6kMXJFHN
X-Proofpoint-ORIG-GUID: n5k64rEg3Rykm3p2gaLho_QV6kMXJFHN
X-Authority-Analysis: v=2.4 cv=O7YJeh9W c=1 sm=1 tr=0 ts=69d8fdda cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=r5tAstHzX-DRmjCks68A:9
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100128

This adds the admin-guide documentation for dm-inlinecrypt.

dm-inlinecrypt.rst is the guide to using dm-inlinecrypt.

Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
---
 .../device-mapper/dm-inlinecrypt.rst          | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-inlinecrypt.rst

diff --git a/Documentation/admin-guide/device-mapper/dm-inlinecrypt.rst b/Documentation/admin-guide/device-mapper/dm-inlinecrypt.rst
new file mode 100644
index 000000000000..c302ba73fc38
--- /dev/null
+++ b/Documentation/admin-guide/device-mapper/dm-inlinecrypt.rst
@@ -0,0 +1,122 @@
+========
+dm-inlinecrypt
+========
+
+Device-Mapper's "inlinecrypt" target provides transparent encryption of block devices
+using the inline encryption hardware.
+
+For a more detailed description of inline encryption, see:
+https://docs.kernel.org/block/inline-encryption.html
+
+Parameters::
+
+	      <cipher> <key> <iv_offset> <device path> \
+	      <offset> [<#opt_params> <opt_params>]
+
+<cipher>
+    Encryption cipher type.
+
+    The cipher specifications format is::
+
+       cipher
+
+    Examples::
+
+       aes-xts-plain64
+
+    The cipher type is correspond one-to-one with encryption modes. For
+    instance, the corresponding crypto mode of aes-xts-plain64 is
+    BLK_ENCRYPTION_MODE_AES_256_XTS.
+
+<key>
+    Key used for encryption. It is encoded either as a hexadecimal number
+    or it can be passed as <key_string> prefixed with single colon
+    character (':') for keys residing in kernel keyring service.
+    You can only use key sizes that are valid for the selected cipher.
+    Note that the size in bytes of a valid key must be in bellow range.
+
+        [BLK_CRYPTO_KEY_TYPE_RAW, BLK_CRYPTO_KEY_TYPE_HW_WRAPPED]
+
+<key_string>
+    The kernel keyring key is identified by string in following format:
+    <key_size>:<key_type>:<key_description>.
+
+<key_size>
+    The encryption key size in bytes. The kernel key payload size must match
+    the value passed in <key_size>.
+
+<key_type>
+    Either 'logon', or 'trusted' kernel key type.
+
+<key_description>
+    The kernel keyring key description inlinecrypt target should look for
+    when loading key of <key_type>.
+
+<iv_offset>
+    The IV offset is a sector count that is added to the sector number
+    before creating the IV.
+
+<device path>
+    This is the device that is going to be used as backend and contains the
+    encrypted data.  You can specify it as a path like /dev/xxx or a device
+    number <major>:<minor>.
+
+<offset>
+    Starting sector within the device where the encrypted data begins.
+
+<#opt_params>
+    Number of optional parameters. If there are no optional parameters,
+    the optional parameters section can be skipped or #opt_params can be zero.
+    Otherwise #opt_params is the number of following arguments.
+
+    Example of optional parameters section:
+        allow_discards sector_size:4096 iv_large_sectors
+
+allow_discards
+    Block discard requests (a.k.a. TRIM) are passed through the inlinecrypt
+    device. The default is to ignore discard requests.
+
+    WARNING: Assess the specific security risks carefully before enabling this
+    option.  For example, allowing discards on encrypted devices may lead to
+    the leak of information about the ciphertext device (filesystem type,
+    used space etc.) if the discarded blocks can be located easily on the
+    device later.
+
+sector_size:<bytes>
+    Use <bytes> as the encryption unit instead of 512 bytes sectors.
+    This option can be in range 512 - 4096 bytes and must be power of two.
+    Virtual device will announce this size as a minimal IO and logical sector.
+
+iv_large_sectors
+   IV generators will use sector number counted in <sector_size> units
+   instead of default 512 bytes sectors.
+
+   For example, if <sector_size> is 4096 bytes, plain64 IV for the second
+   sector will be 8 (without flag) and 1 if iv_large_sectors is present.
+   The <iv_offset> must be multiple of <sector_size> (in 512 bytes units)
+   if this flag is specified.
+
+Example scripts
+===============
+LUKS (Linux Unified Key Setup) is now the preferred way to set up disk
+encryption with dm-inlinecrypt using the 'cryptsetup' utility, see
+https://gitlab.com/cryptsetup/cryptsetup
+
+::
+
+	#!/bin/sh
+	# Create a inlinecrypt device using dmsetup
+	dmsetup create inlinecrypt1 --table "0 `blockdev --getsz $1` inlinecrypt aes-xts-plain64 babebabebabebabebabebabebabebabebabebabebabebabebabebabebabebabe 0 $1 0"
+
+::
+
+	#!/bin/sh
+	# Create a inlinecrypt device using dmsetup when encryption key is stored in keyring service
+	dmsetup create inlinecrypt2 --table "0 `blockdev --getsz $1` inlinecrypt aes-xts-plain64 :64:logon:fde:dminlinecrypt_test_key 0 $1 0"
+
+::
+
+	#!/bin/sh
+	# Create a inlinecrypt device using cryptsetup and LUKS header with default cipher
+	cryptsetup luksFormat $1
+	cryptsetup luksOpen $1 inlinecrypt1
-- 
2.34.1

