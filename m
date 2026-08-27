Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF07486B8A
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846906; cv=none; b=jwplOIJX/kM7H8E/IoqbuDJkGXILuDFLFe5YkWeUrhm9rUtTG2F5pO4wKoKXk+/P68nlgcmD0YtGFhLstF3wzg5VQZ72NcZ6FjEI5bDTI611gDIYY7soIktDPYcWtKDJlr3KIjJ47IemIsC9OTWTGo2WHGkpA69kQpCgW+h8KV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846906; c=relaxed/simple;
	bh=InJBi1ft2hBbaFKieY6YZqUXPU/gfk8w7Fh7r9+bQPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IgZACVxIfwpzXGQXgvBKGR57uMprFQvrZixfPu2wox822ZjmK/9wpGk1T+IfQrjg471IAz160HId1o394LSh9dXlgOwHRc+k7KeE6E6Sst6FG2cfrFTosVzGtBu8sUUDzE+iApmn9iyJ7aY4zJ0q30MHJI5v3eqWfaB0ePSTVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y4uq6JlM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L6v82jSf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y4uq6JlM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L6v82jSf"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RG4Lqm342318
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 16:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=atRu9g3ecGR/Ax5Jg8bJIB
	651HizDXONPJoQtisnwWc=; b=Y4uq6JlMpmj0npdFeC57HIRdcXHvB1w2M6L9O9
	PwLZ2U/E0etX95l5S3QazbFxtQ84dSCpFhs45XMhhNr3ykMBlc1XAe08rxWKIf93
	ISwIavbNkpr3MlFveW/yD//12y0VEiu3W4O4nTwolGa++uMHbVVNsr38aOU7Ccob
	nAAhMKFTAbbbRqXqxz0wW2chDr7MQ4aF8D7HsMFFWPhL78MCVYcgmQe7N9Jv2Aks
	dANs4IPALWTMepSN4Eu5YdlOwWxdhvCJ5Fo/H19ieoRURWH+ZGvNlorRanqW5mN7
	JP7f9tVZZ3N/9OpCUX+Y6KR5kKq6jRemzqPyb59O9qxQdGMQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garee00p9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 16:08:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so191910a91.0
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787846902; x=1788451702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=atRu9g3ecGR/Ax5Jg8bJIB651HizDXONPJoQtisnwWc=;
        b=L6v82jSfM9aJZjTp3UZ2dl5aZxX1oO4ujg+g20YtUV2JOpeZKTqRXxDS9q6qY1ONjl
         HkUOofpZYh4xH78QAVZZidOcV1yuNQihWN+ksHQeYepFzjYLXqIzaoFrjT37Uj2Jct0L
         cI93cgJwgNw2bfFaAG6Gy+EPsMAx/53/ezGZvWw4PLqh6G09RuVvx+5rm1ZMhOst409L
         jtsCEHZcb9v7q2tFzVQJ9ReOdptj3iu4bIwYi4UNNMH5puvvWSXd6sLdXgVeLlpRzGdE
         nDxu+bI15MnF0OiXfGd1LmbGLHe7Ym5HAnqoNGV7dYWvvcHDwQ98Ffdtzc7iVNLH/G7y
         Kr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787846902; x=1788451702;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=atRu9g3ecGR/Ax5Jg8bJIB651HizDXONPJoQtisnwWc=;
        b=F8C/rVw88QhyP6OpKAFcJAuyEC/XHIeIjQwRagTbfo/45pCgtHdYJGteWQT0BKPEcX
         CvuYbto4zUkzi4qGTE1wpCoTf8uurK4iZHgmATph2JBkHEBon4IOFNrioz51VCPyhH7X
         VpgrKGyz3uUhk5rnIPx29dn1NEedQd0nDF3F0kIgHJwVnaFsKrsEAMDmhomFZdru15AB
         b3VO5LkSQem+2rwhyw5cd1wNGTSWrA43ZTTHKtPQRg4WVrmdooLxLrgpZHpKWnwffjyj
         ZkpU36s9tCvpr+W2KA90eNQ9N95rsskUIBYnvmhnrLedCeo5k2T4jPrtOs01YvpMd2DG
         XNtA==
X-Forwarded-Encrypted: i=1; AHgh+RpV/Xqzmk5mytlV8cvswfqu1JWBpnROtfGGbo65a82cc/dyDohqKQ+Hg7B0BLtfs57pPRUTy5iRzfAVkQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mAqWfF7XatgsyrhL2G2wfZevztA0CjBZXQ2X3MSckuF5WgtIfF
	cOyMXkTrHk9qxqiqF+P0tNqwxQRSM9EXW19nemxbSLxc94DIjfs7bUjAGKQ8n8CI0tpnZzF8Pp4
	MfRfDG0Lsq6gSsVzJ5LMYkESInuV94ixx37i2wSzwCQXA+dSUIpvGkfPZ80LbgkWBCg==
X-Gm-Gg: AR+sD12g/CiuQrPy1i6Qu9Ut3Qn68dqbw02kmhIL2H7z1384eDWCyOp/mn30w824WUI
	u89aFnzS1sWHbd8N6LHi+WGhXHI4QUxVCqlg5TVw3Mtv4Gw1dQTGf205MmG4R3R2XsBQxogzhz1
	daRoZtuuLOx0WeLYX+AAT4CIEvpEQhRnFknD+ThECaPMN16eSlCbBkm5XSj5hJLeDGCg/0j+gJA
	Bqy7ifsJBEQvAMSZ1x1hGgab2/P5lKIIAsJXmcxcZ+PvGdiE9MSezdPQnwQFY053AWVQHp0ywYP
	yijBrIf5xuK5iTFfvOG0pRugvXa9nW5ztwpqY+wO2rUezNeyGfQrFJ8wjLtZfJpfo+ehMxcWoA0
	U+ACqd2zwPlXqVPFJMfHUCWlJlrYtMg2VMgDzm4/lo89pUqusTrRQiKBqZWA=
X-Received: by 2002:a17:90b:3c8a:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-396d10076e9mr459894a91.13.1787846901404;
        Thu, 27 Aug 2026 09:08:21 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8a:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-396d10076e9mr459325a91.13.1787846899408;
        Thu, 27 Aug 2026 09:08:19 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd9085sm3245892a91.12.2026.08.27.09.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:08:18 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: ebiggers@kernel.org, axboe@kernel.dk, mst@redhat.com, jasowangio@gmail.com,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: neeraj.soni@oss.qualcomm.com, gaurav.kashyap@oss.qualcomm.com,
        mani@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        bvanassche@acm.org, alim.akhtar@samsung.com, avri.altman@sandisk.com,
        stefanha@redhat.com, pbonzini@redhat.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/11] FBE virtualization: inline encryption for virtio-blk guests
Date: Thu, 27 Aug 2026 09:07:09 -0700
Message-ID: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX3/z6iVd6dHEh
 aOUqWGNNbZWfZRx0WyuxEOAlY3CEqUjpY0dhuv3pG1YthKE9ES5JFyQSpdg6bB1HpK2vov3rGDh
 pqTQSJoNUpaFIWcbGX0vUsKM6bDmf8ap1IvMBSet6KlDbTXuw+Te6hu+hXqnZhBs5iu9PIUGDq2
 8ZPITmmGscSe+3wf5frm8bPcw3vIXj4wewVtFEM562qXGcKF4EQLogqOWCY2qJPw3LPveG2dwW1
 R92QBjtx6UYAov+lfllzhj02nUSENftLfND45Ku/ifa+hQRu2/90GGkkt+Wjun2nbaUF+3+KfCh
 pWYjW2S1jWChtZ5c6rBAlA222Q7cRHyS+0A4/OqzXe2sCh481oGb8c8qoGzTFnCr5hIG8bfCE8Q
 EOs4aactR6PsAhV2tbHKoJ5XpgIyijZXTfuOv0WAR1o0f/jH5BuOta2ItfG8YNmFkUbCyuelm90
 DaojNJhpOQKFR5HIb9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX+I/6NxDE5sGb
 VXRceczR+fTHc5Fd6YQO3r8dRL9BIeg4dTMq4pHfBHtKzHV2UO4nMGK3MnfmZW02kfF8MSl9wW7
 J1OJhOQaK9Jo1rUA/lYYzERm30JkoMs=
X-Proofpoint-ORIG-GUID: XnWXPS8UI5na5eAKwlyupU580E8fhzpy
X-Proofpoint-GUID: XnWXPS8UI5na5eAKwlyupU580E8fhzpy
X-Authority-Analysis: v=2.4 cv=e8E2j6p/ c=1 sm=1 tr=0 ts=6a9060f6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bZYwddHGPv9KEr_TRj0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270136

From: linlzhan <linlin.zhang@oss.qualcomm.com>

Current virtio-blk does not provide a mechanism for a guest to
program hardware keys or submit encrypted I/O using pre-programmed
keyslots.  It drops the crypto context when issuing a bio request
to the virtio-blk queue, preventing inline-encryption-based FBE
on virtio block devices.

This series enables File-Based Encryption in guest VMs on Qualcomm
GVM platforms where the ICE inline encryption hardware is shared
between the host and guests.  In this environment the guest kernel
has no access to the ICE hardware directly; it supplies a virtual
keyslot index and data unit number with each encrypted I/O request
via VIRTIO_BLK_F_INLINE_ENCRYPTION, and the host must translate the
virtual slot to a physical ICE keyslot and submit the bio — without
transferring raw key material across the VM boundary.

             +----------------------------------------------------------------+   
             |                                                                |   
             |               LA GVM                                           |   
             |                                                                |   
             |                                                       |        |   
             |                                                       |        |   
             |                                                       |        |   
             |                                                +------v------+ |   
             |                               +----y-----------+   blk-mq    | |   
             |                               |                +-------+-----+ |   
             |                               |                        |       |   
             |                               |                        |       |   
             |                    +----------v-----------+            |       |   
             |                    |blk-crypto-profile    +------------v       |   
             |                    +----------------------+            |       |   
             |                                                        |       |   
             |                                                        |       |   
             |            Control path:                               |       |   
             |            generate/import/prepare key                 |       |   
             |            program/evict/derive_sw_secret key          |       |   
+----------+ |                                                        |       |   
|          | |+-------------+     +-----------------------+     +-----v-----+ |   
|Trust Zone| || crypto-virt <-----+ virtio-blk-crypto-ext <-----+virtio-blk | |   
|          | |+------+------+     +-----------------------+     +-----+-----+ |   
|          | |       |                                         Data path: I/O |   
+-------^--+ +-------+------------------------------------------------+-------+   
        |         SMC|call                                (virt_slot, DUN, DUSize)
        |            |                                    appended in virtblk_req 
    +---+------------v------------------------------------------------v----------+
    |  +--------------+                             +--------------------------+ |
    |  | SMC trap     |                  Hypervisor | MMIO trap/VIRQ injection | |
    +--+--------------+-----------------------------+--------------------------+ +

    +--------------------------------------------------------------------------------------------+
    |                                                                    PVM                     |
    |                                                                                            |
    | Crypto IO    +--------------+                                                              |
  +-+-------------->  QEMU/Crosvm +-------+                                                      |
  | |              +--------------+  IO data                                                     |
  | |                             virt_slot, DUN, DUSize                                         |
  | |                                     |                                                      |
  | |+----------------+       +--------- -v-----+                                                |
  | ||  blk-crypto    <-------+ blk-crypto-proxy+-------------+----------------------+           |
  | |+----------------+       +-----------+-----+             |                      |           |
  | |                             slot path based             |                      |           |
  | |                               bio_crypt_ctx             |                      |           |
  | |+-----------------------+       +--- v----+              |                      |           |
  | || blk-crypto-profile    <---x---+  blk-mq |      bcp_hypervisor_ops             |           |
  | |+-----------------------+       +----+----+              |                      |           |
  | |                                     |                   |             bcp_slot_virt_ops    |
  | |                         +-----------v-----+             |                      |           |
  | |                         |         SCSI    |             |                      |           |
  | |                         +-----------+-----+             |                      |           |
  | |                                     |                   |                      |           |
  | |                 crypto msg in UTRD  |                   |                      |           |
  | |+----------------------+        +----v-----+  +----------v-- ---------+ +-------v--- ------+|
  | ||    ufs crypto        <--------+ ufs-core |  |blk-crypto-hyp-backend | | keyslot-partition||
  | |+----------------------+        +-----+----+  +-----------------------+ +------------------+|
  | +--------------------------------------+-----------------------------------------------------+
  |                                        |                                                      
  |                                        |                                                      
+-----------------------------------+   +--v---+-----------+                                      
| +------------------------+        |   |  ICE |    UFS    |                                      
||MMIO trap/VIRQ injection |  HYP   |   +------+-----------+                                      
+ +------------------------+--------+                                                             

Patches 1-3 land in the guest kernel.  Patch 1 negotiates
VIRTIO_BLK_F_INLINE_ENCRYPTION and wires it into blk-crypto.
Patches 2-3 add the Qualcomm GVM-side crypto backend, which routes
key programming and software-secret derivation through SCM calls to
TrustZone.  These patches are sent for review; the virtio-blk inline
encryption protocol is also under review (see
https://lore.kernel.org/all/20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com/).
These patches and the virtio-spec depend on each other.  They must be
kept consistent for upstream merging.

Patch 4 adds the dt-binding for the Qualcomm crypto-virt node used by
the guest-side backend.

Patch 5 introduces a "slot path" in blk-crypto that lets a bio carry
a pre-programmed physical ICE keyslot index in bc_slot rather than a
blk_crypto_key pointer (bc_key == NULL).  This is needed on the host
side where the hypervisor has already programmed the keyslot; the host
kernel has no access to the raw key.  Patch 6 extends
ufshcd_prepare_lrbp_crypto() to handle this path.  Patch 7 moves
bio_crypt_dun_increment() to the public header so it can be called
from drivers/block/.

Patch 8 adds /dev/blk-crypto-proxy, a misc character device for
userspace virtio-blk backends.  The interface is three ioctls:
BCP_BIND_CONTEXT binds a host block device fd and a hypervisor VM fd;
BCP_GET_CRYPTO_CAPS queries the device's inline-crypto capabilities
and the VM's ICE keyslot allocation; BCP_SUBMIT_IO_BY_VSLOT resolves
a guest virtual slot to a physical ICE keyslot and submits the
inline-encrypted bio synchronously.  The driver is
hypervisor-agnostic and storage-vendor-agnostic, using two pluggable
op-sets registered by platform drivers at runtime.

Patch 9 implements bcp_slot_virt_ops for Qualcomm platforms: it parses
a qcom,ice-keyslot-map device-tree node that maps each guest_id to a
contiguous physical keyslot range.  Patch 10 adds slot_offset to struct
blk_crypto_profile so that blk_crypto_keyslot_index() returns the
correct physical slot number when the host's ICE range does not start
at slot 0.  Patch 11 extends ufs-qcom to read the host's own slot
reservation from the same DT node and initialize the
blk_crypto_profile accordingly.

Patches 1-4 are technically ready for review.  However, since they
depend on the proposed virtio-blk inline encryption protocol, progress
on these patches is expected to follow consensus on the protocol design.
Feedback on the overall architecture is therefore particularly valuable,
as it will also help advance the associated virtio-spec work.

Patches 5-8 implement the core host-side infrastructure and are
believed ready for review.

Patches 9-11 do not depend on any hypervisor-specific code.  Of them,
patches 9 and 11 provide the Qualcomm platform implementation based
on a static device-tree keyslot mapping; this may be revised in a future
version to use a TZ SCM query interface.

The kernel-internal header declares bcp_hypervisor_ops, which
translates a hypervisor VM fd to an opaque guest_id.  No upstream
implementation is included in this series because the series was
validated on a downstream Qualcomm GVM platform using the Gunyah
hypervisor, which provides a stable per-VM identifier but is not
yet upstream.  KVM does not currently expose an externally-visible
per-VM identifier that a kernel module could use for this purpose.
Input from KVM maintainers on whether and how such an interface
could be added, or whether an alternative identity mechanism is
preferred, would be welcome.

Known limitations
-------
  - Only AES-256-XTS has been tested.
  - virtio_blk_crypto_msg.dun is a fixed __virtio64; the driver refuses
    to enable inline crypto if the device advertises max_dun_bytes > 8 to
    prevent silent IV truncation and reuse.
  - Inline encryption is mutually exclusive with VIRTIO_BLK_F_ZONED.
  - The qcom_ice_slots driver uses a
    global singleton and ignores the blk_crypto_profile argument to its
    callbacks, so multiple storage controllers sharing a single slot table
    are not yet supported.
  - BCP_SUBMIT_IO_BY_VSLOT submits each bio synchronously with
    submit_bio_wait(); concurrent in-flight bios from multiple threads
    sharing one fd are not supported.

Testing
-------
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


linlzhan (11):
  virtio_blk: add inline encryption support
  soc: qcom: add crypto_virt backend for virtio-blk inline crypto
  soc: qcom: crypto_virt: add support for create, prepare and import
    keys
  dt-bindings: soc: qcom: add binding for qcom,crypto-virt
  blk-crypto: add slot-based inline encryption path
  scsi: ufs: core: add slot path to ufshcd_prepare_lrbp_crypto
  blk-crypto: move bio_crypt_dun_increment() to the public header
  block: add /dev/blk-crypto-proxy for host-side virtio-blk inline
    encryption
  soc: qcom: add ICE keyslot partitioning driver for guest VMs
  blk-crypto: add slot_offset to blk_crypto_profile
  scsi: ufs: ufs-qcom: support ICE keyslot partitioning for guest VMs

 .../bindings/soc/qcom/qcom,crypto-virt.yaml   |  39 +
 block/blk-crypto-internal.h                   |   5 +-
 block/blk-crypto-profile.c                    |   7 +-
 block/blk-crypto.c                            |  57 +-
 drivers/block/Kconfig                         |  28 +
 drivers/block/Makefile                        |   3 +
 drivers/block/blk-crypto-proxy.c              | 667 ++++++++++++++++++
 drivers/block/virtio_blk.c                    | 199 +++++-
 drivers/block/virtio_blk_crypto_ext.c         | 283 ++++++++
 drivers/soc/qcom/Kconfig                      |  30 +
 drivers/soc/qcom/Makefile                     |   2 +
 drivers/soc/qcom/crypto_virt.c                | 197 ++++++
 drivers/soc/qcom/qcom_ice_slots.c             | 232 ++++++
 drivers/ufs/core/ufshcd-crypto.h              |  14 +-
 drivers/ufs/host/ufs-qcom.c                   |  91 ++-
 include/linux/blk-crypto-profile.h            |   9 +
 include/linux/blk-crypto-proxy.h              | 100 +++
 include/linux/blk-crypto.h                    |  28 +
 include/linux/virtio_blk_crypto_ext.h         |  78 ++
 include/uapi/linux/blk-crypto-proxy.h         | 122 ++++
 include/uapi/linux/virtio_blk.h               |  62 ++
 21 files changed, 2224 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml
 create mode 100644 drivers/block/blk-crypto-proxy.c
 create mode 100644 drivers/block/virtio_blk_crypto_ext.c
 create mode 100644 drivers/soc/qcom/crypto_virt.c
 create mode 100644 drivers/soc/qcom/qcom_ice_slots.c
 create mode 100644 include/linux/blk-crypto-proxy.h
 create mode 100644 include/linux/virtio_blk_crypto_ext.h
 create mode 100644 include/uapi/linux/blk-crypto-proxy.h

-- 
2.34.1

