Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1309446055
	for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907139; cv=none; b=rY3t2CwvNgbG4/KzydmroiIdSU10ItsqjnQ5fEdK3MLlPaMyCEmmr4AN0GY3Nsmt8oiwodS4dkS+vI+W6XYz17KjEbu9lWBFVa/x6O5jpVkeqlqy2f/I9fuyQJuU+LsVACrDMsQCp3CjqDSFMe9kc2sgi3FZsbDupk+cpItJ+Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907139; c=relaxed/simple;
	bh=9ys3681p32APqj6Z88pRcCV7fPw5mjcOa7rsGo8U5ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vCyeOdjozvjccoajN5pb9HXaenuu1DMHtZQePzmpFtR0njSAXd+avRXnkbav+5Afr4PgjMte0tpyYM4WaKD70vaLYRRQmS+ZrMtwfml8w6nPw6IITMSx2pfxN8lTGnriIbNh6zopbKuCeYvjChFf7Cc/TRksijY4/i/AarWHQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=INB501Xm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KnrgkcUP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="INB501Xm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KnrgkcUP"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68KBnjvP3444336
	for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 12:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=nHGqvNi0X1PSleAmas4B81l/3KNqRkeiVL8
	aUDF2Tt4=; b=INB501XmUi1cS4dB9XVFh2i0kPwkEouV/hwHE1MOXGc7wyjC95j
	MlhrxBIekXsN3RGomAUacgzRgFqLHgMWFpBgoae6l4KSCuL+cfK+QsqcbAV683xf
	isFz4g/1wDqKYPvSP75ao5SfDWePyU97jFoUR6bjBDX0WkRkOAY9nUBGoOErxPy0
	007nSfu88b5d1qA+J8IDBKt/buA0yEJd/w/8boLWO6m13RBDsaUAWuwAlTUclCps
	3nJWvQgJs2kpfpDWOPHudNbgwYcr1m/AeULUzL37FEvrATEGLxgx0wCsEZCxitaS
	HSzT8bb0XssSEhK1TwsQtzhgzdea1gZhoSw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsg3f39tb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 12:24:57 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6f80c76e6so44236365ad.3
        for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 05:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789907097; x=1790511897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nHGqvNi0X1PSleAmas4B81l/3KNqRkeiVL8aUDF2Tt4=;
        b=KnrgkcUPe5B+TFpWhXEL3PFgIMbpJhlEDFWFz3ANGhmZh74RS2WPumEhvgdOZsyYKc
         QLalKv8NYERFKyM7L96fF+MjB/qsFomYfIHLoEtf9WhuHTFMkJIInclXwdEFb9MRjzdZ
         pvBBUzxipjDNowvuU6mtwBUc4W6LMu7VqAMBxgiqsV52pEwKoqps/qJUH3wQthTDAcps
         Rb7LJEgVpWUmIHo+nUl2v+uWX4DRjydHtX8+1d7WhgA+zFIze+asXcHvVDuLGmGrtF+6
         r7TYXGMnT/IjQSIZxdZzmVn6K5G8WwIOKSskrajF2NgnfqsE1gPmsp8jO56pD+/TEMa1
         Ehag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789907097; x=1790511897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nHGqvNi0X1PSleAmas4B81l/3KNqRkeiVL8aUDF2Tt4=;
        b=wih/3kbY9Ju8v2D2Z41gutN1/7PoGw2s6UR6rIJja5qmYxvnU0qcC/wy2OE0t0s3uc
         9feDl+9L5bD1eu9Hd2Z8bbXTB+P3Ma9eq7h5TSsaRfIS1fL4QK/v9JbxQC+GDbN3Hrq/
         ak0nH9woqULVJEpRFSPs+dujABizbRsEGRWI0HTCCXZEF5iHZlnTATjCE6HJAde4W75z
         uCRQClfIOXo7L+jEVUfwZJN9AfXPuemoiAzjlVWUnWtOavQt+aoT+T1v5Z/+1Z2Ilduy
         ovgtLbSxMyNMMf86zcaYZDOhE5uTtB2d45bcWAzQuIalKlGFJa9BN5wSFyK5vUoEU0U4
         MhDQ==
X-Forwarded-Encrypted: i=1; AKwUvByE1GI3MQDCjpRKOsK6ADkztUFFwD3tEWSuEfv4YnFPn+jgqX60FTFuAFXwoWEqpJaoIw+Xp+g/k+uXkQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m2H9J4jrXTG3OOUthlO/BlRUb1xOLFkl+Z+BZJcKhZzgBw1Ngg
	fVxTRltCP8R60MAHDESvyp+qHVZsxQIejUwkBn5USoS4RPnUyZK2oBoXpLRGBIyY/1IaxcdYU5I
	IpeP06slEVEiNVyCjJfZPajTHV7Doadxxp168IIoDTFnbfDG3oXkbnIajConbBaJAYA==
X-Gm-Gg: AYBFou2uU/YkJDIjsPBx0BNhA3MGtIJKTGeD3efHytWBq3sKYhWK561Mq2C6vU34Wcg
	tvsd81bhBqu0G4AqR54h5Kf6pAox/qlobJ0K1w1JsOeT7A+zPFfjlPzVc1aJ/g2DUX+2t37YHT4
	WJbCn1UfLWe829S/+dLGUNIp+nK1lKEdgs2YsUpF+gEwQCwLn11OqZZF6hAjDaatpgbHHjxCUN3
	lemRclo2Yr5Ujs6ZzEPtt3xg/mrteNZPuqocXoJl2YG++D89J1y2Y5waKFhmSPxJoQNaBzur09L
	i9GBFdAF+e1uDbXqc93O09/5C6Hc1lZUh1XbYb+xH5v68ePV4gd2OrO/ZG3rksvFEd/LgzIDLWu
	MTBnC2H7xpINEpUM2EKMQ/Hv0GoqLjxLqZ1Rc6Y7Xb6EEFHoBXjg/mwmjEA==
X-Received: by 2002:a17:903:46c6:b0:2dd:ad73:5b67 with SMTP id d9443c01a7336-2ddb1c196d2mr119168895ad.23.1789907096578;
        Sun, 20 Sep 2026 05:24:56 -0700 (PDT)
X-Received: by 2002:a17:903:46c6:b0:2dd:ad73:5b67 with SMTP id d9443c01a7336-2ddb1c196d2mr119168665ad.23.1789907096095;
        Sun, 20 Sep 2026 05:24:56 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331aef9bsm12007386eec.25.2026.09.20.05.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:24:55 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: mst@redhat.com, jasowangio@gmail.com, axboe@kernel.dk, ebiggers@kernel.org,
        stefanha@redhat.com
Cc: pbonzini@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] FBE virtualization: inline encryption for virtio-blk guests
Date: Sun, 20 Sep 2026 05:24:30 -0700
Message-ID: <20260920122444.2549493-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDE4MCBTYWx0ZWRfX6YsZ1bYRc4Su
 api2qevFJxWvRCd7hAgfgJLWLXGqHbV2QvYwZE90GZ3DE295R+k/GTfLJtjXh0UXf5r17cxPYcQ
 fTBHkLmNamzFiDBBncwHbwDop5BjOTQ=
X-Proofpoint-ORIG-GUID: MyaSp8j4mvPHClRNBr_aAWilT2hRXhbQ
X-Proofpoint-GUID: MyaSp8j4mvPHClRNBr_aAWilT2hRXhbQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDE4MCBTYWx0ZWRfX30/PbQoujYbc
 xjMNLEsJ1HzbCAp1s8FC+1wglbTv3gLjKs0T4z8yZnEnz9Bt0Io3SgFkMd1Px4nEp6jp1258AcF
 CSbLBkxw0zgtam7DMaIj7dw858SuwIxu17Sw3zz9tTct5xBwGCqQbtu16tT9RehWgKMhsCF0EFc
 fYXILK0thpvPLwdQAQ/jrhLJbPISPNEONC8MlOxNSx4DTD0UZHn+LDOFpVeIjkSgN/2F6YlnMhI
 uLz8QfVe7ao71kT/lzcL+OsZD9xniZGnWHxALeYCLF6QxVIVb8RZDorndn5hzgsVJTokPVpCsyQ
 sBz5b61rATBydqZqzUVMACSjxO+zMEmSGD+q0ZFNdUjYprepCNNeuaUZUrApVET/nkqvqJNHTaY
 bYVbVbO8KjHnNbZJnnCXupPRrObm551BSEI0TDC3Oa1DPJpadzVcg5VHIPUaeureQWuV2UEYwos
 lhgMaiPvzIfOwmbuXQw==
X-Authority-Analysis: v=2.4 cv=N6S8hG9B c=1 sm=1 tr=0 ts=6aafd099 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=82hO2hxRqmGPxkN32ysA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609200180

From: linlzhan <linlin.zhang@oss.qualcomm.com>

The virtio-blk driver currently does not preserve blk-crypto metadata when
dispatching encrypted bios to the virtio queue. As a result, inline
encryption cannot be used for virtio block devices.

This series enables inline encryption for guest VMs on platforms where the
Inline Crypto Engine (ICE) is owned by the host or another virtual machine.
It extends virtio-blk with a crypto control virtqueue and carries the
required encryption metadata with data requests.

The series consists of:

  1. Add control virtqueue support.
     This allows the guest to exchange key management requests with the
     virtio-blk backend without mixing them with regular I/O requests.

  2. Add inline encryption support.
     The driver advertises the device encryption capabilities through a
     struct blk_crypto_profile and carries encryption metadata, including
     the virtual keyslot and data unit number (DUN), in virtio requests.

On the backend (blk-crypto-proxy, will be committed in another patch as
suggested.), the key table mapping virtual slot to the block crypto
key is maintained, so that the request metadata can be used to resolve
the guest keyslot to the corresponding block crypto key and to reconstruct
the blk-crypto context before submitting the bio to the underlying block
device. 

This keeps the guest integrated with the existing blk-crypto and filesystem
encryption frameworks while preserving inline-encryption semantics across
the virtualization boundary.

This is compatible for the virtio SPEC update which is under review:
https://lore.kernel.org/all/20260913161628.368484-1-linlin.zhang@oss.qualcomm.com/

Known limitations:
  - Virtio block inline encryption depends on the new control virtqueue
  - Inline encryption is mutually exclusive with VIRTIO_BLK_F_ZONED.

Testing:
Compilation pass on Linux-next.
End-to-end FBE virtualization with wrapped key enabled was validated
on top of gunyah hypervisor.  wrapped_key_test is a local utility to
get wrapped key and ephemeral wrapped key via storage ioctl interfaces.
  - /data/wrapped_key_test /dev/block/userdata generate
  - /data/wrapped_key_test /dev/block/userdata prepare /data/lt_key.bin
  - /data/fscryptctl insert_wrapped_key < /data/eph_key.bin
  - /data/fscryptctl set_policy --identifier=20f553802e64e36b43469211266a5f1c /data/testing
  - echo "data" > /data/testing/file.txt
  - sync and reboot
  - /data/wrapped_key_test /dev/block/userdata prepare /data/lt_key.bin
  - /data/fscryptctl insert_wrapped_key < /data/eph_key_2.bin
  - /data/fscryptctl set_policy --identifier=d8ca51d6d2094b73b2dae5ee7e3a10b6 /data/testing
  - cat /data/testing/file.txt

---
Changes Changes v2 => v3:
  - Fix issues reported by sashiko-bot
    - Change to the pointer of struct completion in the control-queue
      request to avoid DMA cacheline sharing
    - Submit a control-queue request with a timeout monitor
    - Freeze the data plane before marking the control queue as dead
    - Transmit the kernel blk-crypto-mod-num and key_type to those
      defined by virtio SPEC
    - Replace GFP_KERNEL with GFP_NOIO when allocating the memory for
      control-queue request in the key program/evict flow
    - Move the check of inline encryption support to a independent
      conditional branch.
v2: https://lore.kernel.org/all/20260914133733.15429-1-linlin.zhang@oss.qualcomm.com/

Changes v1 => v2:
  - Use control virtqueue to perform key management requests
  - Extend virtio_blk_crypto_msg::dun from a single __virtio64 to a
    four-element __virtio64 array to support larger DUN sizes.
  - Remove data_unit_size_bit in virtio_blk_crypto_msg struct
v1: https://lore.kernel.org/all/20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com/

linlzhan (2):
  virtio_blk: Add control virtqueue support
  virtio_blk: add inline encryption support

 drivers/block/Kconfig           |  12 +
 drivers/block/virtio_blk.c      | 907 +++++++++++++++++++++++++++++++-
 include/linux/virtio_blk.h      |  87 +++
 include/uapi/linux/virtio_blk.h | 124 ++++-
 4 files changed, 1111 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/virtio_blk.h

-- 
2.34.1

