Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA37207DF7
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791519479; cv=none; b=bNCNdRnhv5u5GNbdkxCek7lu4592womS02yI/euFQV0YVs1oZwyssa8+XCbOBDAqBgeAz2Ku3vBHeCLD/wvQZH+INi++MEq4YEFtq1Sk03j8f2VltT0P0lmSM1zNgozVYxBNCJ66NwM1N5OEJ4udykEVkzZOJORexl3J0m1LCSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791519479; c=relaxed/simple;
	bh=ArEt6J4Pz8BVaQ9V7RnYbDwPTSPD+73G/AbZIcIZ0Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XCWaoJZlU0W6H/ll2CisrX9baIB9Q6bDy0QyuvGPTYPsf6poW57MGo/mgDALxFoz4E3DNwYxHx2hQ8mjb2hoUonJyzScMSDlkRZiYn6GEkKDEzAbnFjghdNHqrcZhusjBG4iBaA4qh8ml1zbu8CufP3BAy83Dipafl+XfcKrULQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iI1ecwke; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LcujA8Cn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iI1ecwke";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LcujA8Cn"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HnXe251167
	for <linux-block@vger.kernel.org>; Fri, 9 Oct 2026 04:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=f9f6qB3zTnDkNrHuwUp0Is
	PSkh9MuBPmByN8qEMV7MU=; b=iI1ecwkeD589xH4UrosQzwlg2VPuWufTAITGru
	lDtLglYp9tN4rP1Z5mG7NROf0kxRdtVNB5cLK4crawvcoc73pimeoNY5/3pG1d/6
	/GJwsj4J15Xr4xqh7nC8jz4i6DY7OMwluoJl/BUaPYxgtH8FEWfq6D3qrnR30b3m
	udzusKFKXD6vZtJngo4JBRahVA4WZXsVOh4WK4opYM3oXHGQ++31Gfu5B69UK7CC
	0cEI2MjOxkWgQ8igG+AV5no5JlOi3cRJrehtSv9IDzsgIzsWCn0NbCJ/55BSeZms
	7CT52ukKXwQFsZhC0aycDkK8BjDFouv2C06A8UjB9qi/tOXg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fmqsxkk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 04:17:42 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3515266f6eeso3365176eec.0
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 21:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791519461; x=1792124261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9f6qB3zTnDkNrHuwUp0IsPSkh9MuBPmByN8qEMV7MU=;
        b=LcujA8CnleoRGe7SDODPMuh37RamsXalpZnYCV0nUrIRYWjIaNl8xsZNTisk80O0WX
         zCndtDNXNd2JjXh5oNKrig1vZtebKbFbgzU5PnBLgS14K3ZzJDIcNWOuk5oNxAg2NPET
         g3eYM2BYNdqZk6xTB+JGlJ3NtQtepEn93bb94lAvA6Yu70Qoyps1bRF5vbJm9wBJC9q1
         uRLZjzOcTcLP37KuODPpvaQcSUMOVhYdEaoSJXiXFtZeJHcaC+YEb14VbnwYkQuFSJMD
         EM6rO/3ukQrPh0rxh8BeQVQBGPAexfyKgOlgVi1PvQaKaiy6bLOUMeDydfvRsNJqm9AW
         IteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791519461; x=1792124261;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f9f6qB3zTnDkNrHuwUp0IsPSkh9MuBPmByN8qEMV7MU=;
        b=joLHUDDT6ZtnB6CrKlfx75NTNau4TQU86Oh91wnZJdt7/ZMDETMRGt/t0bxG5Y0pn/
         uwfnG7oU3CBUQuItkXZD4K9HlSgO9QGRdkvpOJbKxeHpBehdZfPz40FBhihb+73Ha2Hl
         c+jwY6ioGLl3b5wOKqSQAu/LIRNoOebX1OZ2yNJTOg3Bm/66NUJMGq7PcZ4VQKZdVooO
         8Ujl/l3Yk5GK6OQ7Zb23UUEOJO8+DXjHooLzBtGupO+t/usgcS7its3lqhaGykRag3Ob
         N2PAVJ1J3R5KDInzguvflDkKX7Zy4yHboLuLFdf7/RxSv7I3/Q6nhGPm3SEiDuDf9gl3
         gR2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwgni90z5uZrm30hRfjjPO9bcTzNn/g3GabXrzBu2Eq9j04nVgXIXHK2DgTWu7jcKnlh29jTAhwjpkdLQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lHF9lS/VdhYFy4Tle5ATFcswQsf2cm6yAuh5HCVar4jVR5xlSY
	hjt2KLGetP4JZ8j2dvk4Lj1WB+Rj2u2It/mfHNvQRdt3B5xy/4t1XGVgAr+WDKNcWGfDEEYKqET
	SapzAUbaP6uqtVGRXUbpHU0isSVqak6FAg+GG6sOEEGKwa7zsZNpw6CZ7vRcjb7+loQ==
X-Gm-Gg: AYBFou351wIiemuKGdTzzYb02lG2V/YI+fz3MvdzIxA3KJ4TBNxVHpAroLZQ9x0IEaF
	FB1PeOLuYHeokzGnYrySqAXqDZtVULrxXb9/TpDRgHo67Uif9UjtWCrScDxSlgWhYDpb5ri05NC
	A2PvQR87vsAA10+p6ajLC4YcFXZCj55oAd5QJSld0JNuEEhN8IPbHV9Sqg57OpxQa94dpIOFCOf
	WlsvXQ24/qnA8aOQ8dQpFDrFCgEFU+HeMqAhN/KgfQYYgZLU0700suXvLS5JcLlFFyvEXIu2VZT
	GMSpUfg8wBKC97xzTJXKXQdT4JEFk/q1uLuANYokr7890IZPiR+hfY7y1vjpSQooqnGMK/cgTQS
	d+TGksT7h2BxErAJ2YV5RQi1StZ40hLAvtS/qzYr80929g0QCvdCisIDXgg==
X-Received: by 2002:a05:7022:b055:10b0:148:4d6c:201e with SMTP id a92af1059eb24-16a5faa6965mr894906c88.23.1791519461148;
        Thu, 08 Oct 2026 21:17:41 -0700 (PDT)
X-Received: by 2002:a05:7022:b055:10b0:148:4d6c:201e with SMTP id a92af1059eb24-16a5faa6965mr894816c88.23.1791519458813;
        Thu, 08 Oct 2026 21:17:38 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c61eaa0sm3530749eec.0.2026.10.08.21.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 21:17:38 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: mst@redhat.com, jasowangio@gmail.com, axboe@kernel.dk, ebiggers@kernel.org,
        stefanha@redhat.com
Cc: pbonzini@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] FBE virtualization: inline encryption for virtio-blk guests
Date: Thu,  8 Oct 2026 21:17:12 -0700
Message-ID: <20261009041727.3170811-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAxNiBTYWx0ZWRfX3OhGWJFdUIpj
 I6JSdqRZA+29E/NpHX+btWRa6tkTDiazfDlMLdStYgGmxCLC7sItqyy+L7uidVmu28/X2au+EmY
 UKE1oTra+KUzTv4Y/F5zqQTLG5Cj5/0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAxNiBTYWx0ZWRfX/VH369PrxTmp
 4YCXx7kCfaqwZ+CfbhN0vIzQ1txOXGjFE9kKe4UXRBRgeE8xi37DSBCzu86tCa14osvzWr2eCHS
 BSW+zg9L6HIg6ZozQu6hl0A7iVhS0LX5/jUUQiacbqJH494pcNaSk7AU6P32FjrJB1E3AdfBcNf
 m1oPfITACHnp+W7szSMvTypPr3jGNeILDVZm7EC9OITiTFZXTf3V6YAHSAXeVhu6TJf9epJXGFq
 XaFv/EUpz4ZcZWTX0/Enp1TjDME+CGk7418BWBeqRCj4fS8D9lP63yPS1hIU1ajRGIfw3VHKszo
 b5msZe91+7aK68d8rx2g5/xwf7vaU1o89/P0XaB49GKjhiEJVbgjHRjseEhpt5e5lJEG5i86QGg
 yBHCpHvSnON3yUpLt6lnPDEN6X/VEclHw2aKehc/0ih0JZXyOEMD2p0EXM9vtAVU+gcZKeXUZvW
 ZJSWE6MwTXRYLbdmSSQ==
X-Proofpoint-GUID: 58WoOsZe2KZM2gnb9_6prKYnPRwiBXml
X-Proofpoint-ORIG-GUID: 58WoOsZe2KZM2gnb9_6prKYnPRwiBXml
X-Authority-Analysis: v=2.4 cv=IqCL47/g c=1 sm=1 tr=0 ts=6ac86ae6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=82hO2hxRqmGPxkN32ysA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090016

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
Changes v3 => v4:
  - Fix issues reported by sashiko-bot
    - Move struct completion and bool abandoned in the control-queue
      request into a pointer to avoid DMA cacheline sharing
    - Lock the control virtqueue when virtio block driver handles the
      response from the virtio device or forces stopping the control
      request due to timeout
    - Use kfree_sensitive() to free the creq buffer containing the
      plaintext or wrapped key descriptor， instead of kfree()
      defined by virtio SPEC
    - Replace GFP_KERNEL with GFP_NOIO when allocating the memory for
      control-queue request in the key derive_sw_secret/generate/
      import/prepare flow
v3: https://lore.kernel.org/all/20260920122444.2549493-1-linlin.zhang@oss.qualcomm.com/

Changes v2 => v3:
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

Linlin Zhang (2):
  virtio_blk: Add control virtqueue support
  virtio_blk: add inline encryption support

 drivers/block/Kconfig           |  12 +
 drivers/block/virtio_blk.c      | 918 +++++++++++++++++++++++++++++++-
 include/linux/virtio_blk.h      |  87 +++
 include/uapi/linux/virtio_blk.h | 124 ++++-
 4 files changed, 1122 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/virtio_blk.h

-- 
2.34.1

