Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA1C4718C1
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393070; cv=none; b=Xc+6u905uc8FpVJpGVOhKu6pGRneHcA2uENHdq46yxBUdptEJh7b22DI1QZV1WS76l/BALHBHIg13lQybPzUNmr2oxEKqxZlR3ZQKFGBMKUBj+/nFD2OrOYTiyvz4VOn5ABAZ8qZGgEP7Gnl/IB5uuPmnBeSgBIBGFktfUv11So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393070; c=relaxed/simple;
	bh=1Lru7JP9GAuuZi6rTqk0Y4BTP/g8OZXnNQPKFszs/qE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oh6aSf3vaJEEJnSCVZ8UqMspFjyjXqqcmgazXlo0QldX9DAAC9SXcSWMrZzIG9iZnNO34kwhHvOIHM8B1KCVXgmzv8SYkWbbiGYUIcW3YT3I6guAfjtZJejwZE0+mcdxrX4oO8MB3wia09e8V3ciFCHKlWFModQ40rLHYZWICZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G3KAKFFn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gfqnnBj5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G3KAKFFn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gfqnnBj5"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0OL9607364
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 13:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=pklwXAAIq1Ig2ZvDmkN6OFjS+5G8VOhcNQA
	9piH/HrA=; b=G3KAKFFn+SKCOp3tbFd8NQO1uWzpf7CVF1srOEHkLsohE082pcu
	4mlaUs+SSOZ1k9jvHzroAljCURUhTioCa9Cc8o9RkPoYo1bxoPDY8xwtVJ+/sOxE
	N1GaZ0IY52s54Ud1Nxbu+JtcDljmM4KY6BfKBpIBOpodjfXcWr+4o65sNZ2tpuRc
	zSQA8R80/okc0UttlWzF/R1QBCZIjG7ID0+4+nQP5CPPaHwKXXIVxnsganEnt8eb
	xQFxaBwODSW5xY307lH055H++E/m3mCf1KNcvNmcS4CTbFUk5FeoFwEZ4aQ8o4xR
	z+/H+Xh6OAVsPtHPdVU9+FKkUpmHL0qa6jA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpg2krebj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 13:37:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d9057fab9eso55788795ad.1
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 06:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789393066; x=1789997866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pklwXAAIq1Ig2ZvDmkN6OFjS+5G8VOhcNQA9piH/HrA=;
        b=gfqnnBj5Tih1LGlFrL5lZVekoM9PngOg0BtAcyjjoDi+Y7Cqt8JovQBXosPb2rE8TK
         GQSSkMT+LTZ04TtMh5he9bPKYZcCVOFHpFw/UMe944SGDEIstiWqkUSauen+pWapMeLE
         dOuMP8HKmEVXRzIFD2sWOfjRw8qxoomENatvAew6jKsCZTkchb4LRwS0Kdym/EdX1iNw
         chKkfTnMmrkNOPPJYogbBwrRg1vUkCEI3zgDPAhoIQUcDpuLr6SZ0/mjH+V6ww6Cixtr
         vugIB62U6/DX2HgRCrc9jw1oUy5pn6AEMW+H8Ufxm0dIfqfBHs1Aa7p6Dt+gwzcgiO0C
         NW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789393066; x=1789997866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pklwXAAIq1Ig2ZvDmkN6OFjS+5G8VOhcNQA9piH/HrA=;
        b=cQSBsco/YKBYk0v6hUyRm1NtWQkPev9//UPQy4ig4TqzX1eeEEcNj9FmR99sOJ2oEW
         8M9onGWiOTc5KwdllbmOURhcpUxo1nAPWidm5JpsiF+EkgirudKrn3Qzll9wKrna7W0M
         YCPP6FyevqNcGx/BB3J2UNmLvprUnls+T7UomZHckZPSi0U/G1CgveRtiKud9Py/yhHg
         kyEc/0RYIVpfXHmgGDjgvrm+dqRs7WuR4g+YJQrsDc6noPPtrjZ4GaDUKokl0ybAzEdu
         Jme6k2TzrQjjPvx08QHzjxQNzlebk6vUOgWo0DlKh028vV7vKwSj1w9QxJwqcKPVZIiA
         Xv/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzIP4NLhvNuSug2c4UObnDP0c8cEEFpesGi3kxkds3eMJCxrMXZ/goQVhHuokv3slR8I4w1nb3SAk+qGQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lf3GHKUwhhBiecnh4z75xMHd93/iCH4iRUoN/pTod4V/DYu3GO
	5IaPxiGU00Hfxv5JmIb+G7UzqxS2VPBZxiNNtdleOLgpK50R5b5RO3OCuk+HfxFZsO5s+FRBNyD
	2meZUF/cpww5P0ohuyyufdNWk3/QLY3ZS3F8LPBMEiF4KX6qKmoAY8nKr2CqUFj+aBA==
X-Gm-Gg: AYBFou3kn3VYEmH33gUL/OMk36CNSJQNiHwaSPHbP882sDikOQr7b3mjZ1IgjexyCrE
	6495DcZ1u4q/sTk8wKM2QRSpax/9PagOg5lIsINSFxS5iU161uyEHCaCHHRGZPEPr1ZjHqsxJWj
	DGIPU3W+8Xo+IZfMdEYRo68haT+iNGPsajKMgSnit6HdcCT+gnXRmdmDWgyzBkATJXQ2pQZ3WGp
	5wxDzzmDJGfKvE51b3QTJBWqvwjTmIy+RLj5dSaNUsvvRuhg8dY9vhFj9VGW7g7oo2Ma/VNoWQb
	RfDhKY0uje3s2q70ZWQLWALrJzDwh3wvazMyjPzvD2Gu8++Y6Crw02MOD5ylodvJwJdw46r0bB2
	mHMFBw5O/IXMMbb93beeifzV92NDlLqCz5sKdktN/QbyvhSsnTJfq5+6dQho=
X-Received: by 2002:a17:902:e88c:b0:2d9:383a:30f1 with SMTP id d9443c01a7336-2dd6c5d0539mr51200065ad.4.1789393066279;
        Mon, 14 Sep 2026 06:37:46 -0700 (PDT)
X-Received: by 2002:a17:902:e88c:b0:2d9:383a:30f1 with SMTP id d9443c01a7336-2dd6c5d0539mr51199425ad.4.1789393065805;
        Mon, 14 Sep 2026 06:37:45 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd8c84sm49132685ad.62.2026.09.14.06.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:37:45 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: mst@redhat.com, jasowangio@gmail.com, axboe@kernel.dk, ebiggers@kernel.org,
        stefanha@redhat.com
Cc: pbonzini@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] FBE virtualization: inline encryption for virtio-blk guests
Date: Mon, 14 Sep 2026 06:37:19 -0700
Message-ID: <20260914133733.15429-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: anwq8XUmUv-4tNEMb5V2uey2dN9n6DUo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE5NCBTYWx0ZWRfXxsmAj4JKtDAO
 aDAHiyintx7eTM8BvKcIXpXlsCj3qVVUuaiJDy68dVfiTj5WFbNUglojZYH5lvaaDeLOMRcMzrz
 VE/RPXgPkXookUuaXWz9AlE+cx29BmJ6Ps7lkI9I+7v8Ev7FBhOeFgqb0zEtQO+Jq7zF6B9fsbR
 szV4YY42rz4GvmADnDPv0Wr7q1HXKWEpVAI/kREHp/HVoHdyNnC/pLvloB1DEq6CWdTy3aSqkuZ
 1kIMlSB/7KuPWxDhQTvEQ6xedWyb1Fqv5Ly4ab2P/W4vx5CYzdEFJckHdRh72hcK1Iig8X4kE8G
 4CfGRqL21UokhnNroIPOBzfn9XP3lT1FF0sM3psfkHbOgRfADZ2UMZ/xiSQsOzH/8a46/AUbTJb
 B8uTU0XtRZAmqWE7iopvkpg9wV9f/yI9d+liPNl40ydJdVkHdDSk1Gnd8abZ922g9npYzl7GvuC
 uAwQCX+xSXz89ES2aAA==
X-Proofpoint-GUID: anwq8XUmUv-4tNEMb5V2uey2dN9n6DUo
X-Authority-Analysis: v=2.4 cv=M7TYuCws c=1 sm=1 tr=0 ts=6aa7f8ab cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=kDXN7nACZjSVqT4r80IA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE5NCBTYWx0ZWRfX8JuTSLeBP6BJ
 We7UvOqGbdc5Ds2sOBNVd6UT+wXTKeMFTjwrJPCIAZzbVm+BcEXMxx5V/8B2RKGtq5Y7oxWgcAV
 +i6b9quHRlrcCZ22k+CUd/Wh7CHuIrU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140194

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

On the backend (blk-crypto-proxy, will be commited in another patch as
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
 drivers/block/virtio_blk.c      | 753 +++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_blk.h | 116 +++++
 3 files changed, 865 insertions(+), 16 deletions(-)

-- 
2.34.1

