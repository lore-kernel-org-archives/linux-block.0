Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484D399039
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542778; cv=none; b=TAz3KYNbgyaEqEaV8AR2TgznU1Mh4WYGZkLPRgBuCyicm6FlKHUwLMUne5/wtqS2/a5uFBjKyzTQzJzDWuNB2F+gEzUcah3DiwHrz7GwulDyQda+vlqoqUMIkCDgxhT4SuLDKDG89XTnK8BM1LPp+j9qAmVmYlOL7+VTKx3RudU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542778; c=relaxed/simple;
	bh=oKEFlZ7j+cKtRBji8SO0Ip/DJfA6is5IIdXwt6HGb2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RbdrUc4BziUBQQCl0/uCC5rdPu+8lnPVOJITfZdJrBnIEj/m/nxymOQQN0NXlrad/nGeGgetcmjJyz3PfujIHt2dXJneU+39TmOROG2BpM7hJ2FODWJQduObKrg2umDUau+qj/N3PAYEHrWIREUIVxU1DtSGNUu5hmbxuBLCMLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eEbBPJFd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBpgCoiF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eEbBPJFd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBpgCoiF"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U44aCg2099612
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 09:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lrYikL+96ns
	dg6Sdr1h2bfcZxEJEZfN5XyHVJwCmeaM=; b=eEbBPJFdhlNimEoeJIrVXbHT+Al
	G6aIO1ekVqLK8bATQY4QQJh9Zi20Gjzfzd7UI/MeiirMCdlUzSJDGG4QfvIDp8DP
	5m96YMAn3GluzA7tz0Xc5UkIfF19vsKvVUNs8zMXT23G6uR8h+Y0YWPNkDpOzeBp
	Ieg5OsSHnY3uw9F/DAPMRksGVdsLr9Jjpa3xlsNZhmzVmQ4UPQrE1zJJxkObPmC+
	pGFW2pIaYFE9vfSKtyxVFOU+P4d+Q0pv/p1vwhbTvJrjWcu9y8Qj7qIP+41TyLx2
	+KtWujVXEal1ZNc3KFRR0kqX6ykp5GZTsEvieNWHyvVezSd8d99xKObFwdw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duyr416k5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 09:52:54 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so1070958eec.1
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 02:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777542773; x=1778147573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrYikL+96nsdg6Sdr1h2bfcZxEJEZfN5XyHVJwCmeaM=;
        b=QBpgCoiF3jS4JJYmmEhh4msWsEsySVCRvJflrESAJS69EoDEqBKlOQYwxJCPgrw5r9
         0EdbOPy0J5Q47N9HGuj+DCWFKXJ+FlGpS5em4M4uwoHpfuCnAv49nr/o46rr1MSYJeaF
         LrFdLiejYRH4xA/Dm7QOLMGiy5u847SFLM6097XSTpP74dbrAVjYOewFaLqLGxYO0m1k
         9aS2vnV5y04FBY4/80b83SUSXGLkuKZCi2RvznzL5S0jq2zqzGLXfoYP8WxqgxCgchtt
         KimLnT6jdEg8FRcG2vl1p/juaD9g8YBzICSkWHeOOI5khk1DLwpgTkMZSNhegkPxs1eL
         hA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777542773; x=1778147573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lrYikL+96nsdg6Sdr1h2bfcZxEJEZfN5XyHVJwCmeaM=;
        b=XuSJJc0LA2BC3pmqelSLhgPD2k50Chzha20XeMlj9ou78XjLLQTerhdLRIT6SWLF6S
         nMEgayZ06X9a/yO0CNVkgzPv/CtfvFvVuClHmkWQP90VW0F7lk10gpjRPQx/v5005fSt
         NL8XfYl0V/5eoTVaKfuSykdb88sDcMZRLtP8OtB/GMUYlYrUatpDMa/7W4Px6KVlzCpM
         A8KKLU2mgkCgcDvV1KCFum49bFm0dv2cfsRlSnoeS6E7o0xKycsUBgemqRFlyuTgqs6z
         mPB+MFX0a04b4REa0QwCYrbcDsU0au9NGpR6o1dT9eBwOjlG9TRAx0xT+zNy7Bh4itOa
         2PrQ==
X-Gm-Message-State: AOJu0Ywv3y/4EXde4LrLomyg9rhzBqx+D+2QwLTCaF3XmqaH/8Ay8s5G
	p7DemmygtcoaQ928fnaN1bqNVCt/5OyxeObsrwzckPVSTA0v3h/ZJGvijEcS0QP4mqirfgUfGwd
	6AWyE66GydtROk8rMr8gsIAE9a2tQldFcV+W0z7NgGMVe9aVFuYmQcKv/UiVjgd0wGli27tuO+w
	==
X-Gm-Gg: AeBDievG7wjzr7DDW95VJS9jISltTBb3kv3hzSez0Y1fE4w7m/OynsJGVHbn2GgrJdE
	VfsFpoSrS4PzkqCzLJ3E2lt3wX8kLvtS2QbTPCzCSZh74xgC9/y4q49XdI2iwNqAZjdLYYOW+1t
	fbrFI7fLPf+sg+FcqJOis5BMN/Td4z/eNZ3Zrl9dsZ/Ko2OTryfoUb0/bjwKquLxcxKzq3zzTKT
	Bnh5JcqA3UhpLtBCbQV7SEQF4Lqp01fZKyZqFBf9yHd2R0sbKxaSssb8eeqDH9WC2XT/FvjWaCM
	MFIGB1MhThLcQVajdhpvBuWQk+Fj+iAuvgqk5sIC3Ye1QGSSUvt7BubHalWbG2TpBR19Bk11klB
	5IMPzBuXPdRGUu5EsvxHTxAZCqWnlrKlv73M8WonKQEPEu0uCA9C5IzIQ0CFJIZzPr8xFxhk8ye
	PAizd9v1bLyXePFio=
X-Received: by 2002:a05:7301:168f:b0:2c1:7793:7bbb with SMTP id 5a478bee46e88-2ed3e67f82dmr848278eec.27.1777542773043;
        Thu, 30 Apr 2026 02:52:53 -0700 (PDT)
X-Received: by 2002:a05:7301:168f:b0:2c1:7793:7bbb with SMTP id 5a478bee46e88-2ed3e67f82dmr848258eec.27.1777542772331;
        Thu, 30 Apr 2026 02:52:52 -0700 (PDT)
Received: from u20-san1p10573.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c0d218dsm5885804eec.27.2026.04.30.02.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 02:52:52 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: linux-block@vger.kernel.org, ebiggers@kernel.org, mpatocka@redhat.com,
        gmazyland@gmail.com, bmarzins@redhat.com
Cc: linux-kernel@vger.kernel.org, adrianvovk@gmail.com,
        dm-devel@lists.linux.dev, quic_mdalam@quicinc.com, israelr@nvidia.com,
        hch@infradead.org, axboe@kernel.dk
Subject: [PATCH v3 3/3] dm: add documentation for dm-inlinecrypt target
Date: Thu, 30 Apr 2026 02:52:44 -0700
Message-Id: <20260430095244.3352446-4-linlin.zhang@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=bJcm5v+Z c=1 sm=1 tr=0 ts=69f32676 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=r5tAstHzX-DRmjCks68A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA5OSBTYWx0ZWRfXxOkh2SsWJb87
 1cPjjbSefWC8X06X1P6B9281G1knAOGX/1AC/eWkiqL3zSX9fYiX0GPhvB/NCAGfIUEtiUAO/h3
 +9anJq3+ArGCzD5MQAxHAMRduWWCWlmL9pFUVLMQzberIVNQSyEzqLo0cPGm2iS+w3QKquuiiF8
 psfuk6ELcAi8xTUcIJIFircu9xdU3U7GDtjZ483QQ8bhVC067HSOUXey7t19PAFe/C07zTUbtbJ
 Xke3y6Z3d4eNn7fXFpZGxM6oGit+Fsde+XJt0dp68HH91NuoQO0IjTauVtiSttXjI3Neilwps4C
 Sq8puQ1gzc6LrD5+fZpVgEZ6uqI1eYFNOO7ALovFMpzwfCGXqm/pedieclfXfBSws+vdYyXKtu3
 EYj4iKrs0+OhInXBEUxcok6clDsuH5JGu/0KrzYBD65VfT08b+p1QJVuWDIDewlFj7ubdt1o8zT
 3EyAujDRett5xNZHMgQ==
X-Proofpoint-GUID: 2CGwBdhwl-tzqybuozldV2hgi0jmKTPv
X-Proofpoint-ORIG-GUID: 2CGwBdhwl-tzqybuozldV2hgi0jmKTPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_03,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300099

This adds the admin-guide documentation for dm-inlinecrypt.

dm-inlinecrypt.rst is the guide to using dm-inlinecrypt.

Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
---
 .../device-mapper/dm-inlinecrypt.rst          | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-inlinecrypt.rst

diff --git a/Documentation/admin-guide/device-mapper/dm-inlinecrypt.rst b/Documentation/admin-guide/device-mapper/dm-inlinecrypt.rst
new file mode 100644
index 000000000000..c71e600efb76
--- /dev/null
+++ b/Documentation/admin-guide/device-mapper/dm-inlinecrypt.rst
@@ -0,0 +1,123 @@
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
+    The cipher type corresponds to the encryption modes supported by
+    inline crypto in the block layer. Currently, only
+    BLK_ENCRYPTION_MODE_AES_256_XTS (i.e. aes-xts-plain64) is supported.
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
+    Use <sector_size>-based sector numbers for IV generation instead of
+    512-byte sectors.
+
+    For dm-inlinecrypt, this flag must be specified when <sector_size>
+    is larger than 512 bytes. The legacy 512-byte-based IV behavior is
+    not supported.
+
+    When specified, if <sector_size> is 4096 bytes, plain64 IV for the
+    second sector will be 1, and <iv_offset> must be a multiple of
+    <sector_size> (in 512-byte units).
+
+Example scripts
+===============
+Currently, dm-inlinecrypt devices must be set up directly using dmsetup.
+There is no userspace support yet to integrate dm-inlinecrypt with LUKS
+or cryptsetup. In particular, cryptsetup currently only supports
+dm-crypt, and cannot be used to create dm-inlinecrypt mappings.
+
+The following examples demonstrate how to create dm-inlinecrypt devices
+using dmsetup
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
-- 
2.34.1

