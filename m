Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB7436208B
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928007; cv=none; b=KLa4BrM7/CW+5uEC6L7yA8S/0bHuNDTkbX8W8hX1OhRt8M2Na4X2V5wT3RNWNSd9zwZ0qq7NFPT/zdkPGIdHEKq19UIWdo+QWx87Fq0W0/xNckhj9Qo/uCvVfFJmo7RsAPRdkpCjbJqadntr/pO1pAX21W+iLMXZEBzXRcoryb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928007; c=relaxed/simple;
	bh=cO9512ycspHo+f8P6n4xqITmwA8nbkaOPitRCMvA7ZI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IwU5npTtp4eq9dVN6CFnf5ExpT4XAV4Qdf8zcdBBOK6lwcxsZWbtfiJ6bMoz2ZvFtA5tSG490r3xE6sFdPBVxI2EHMQZae64quqnO1FE/UIOOt2HuRo7xfHkfZmCpTcMkGP3u/GgrYjSYpb4vHY6H7b65OYUkLfKxysMgbYZ+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KHcGxk8O; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KHcGxk8O"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 583J8AKs3661896
	for <linux-block@vger.kernel.org>; Wed, 3 Sep 2025 12:33:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=kNigbhOw5104cTDxar
	UDCQp3n+YBPouop4Xjq6Ecb60=; b=KHcGxk8OquEGHQ4MbJAbYuwkNkoA1P6uvu
	ViIuHK0yLS2citSvNNtigRT7LS88/wCdul1afW1c7mhE5WGLuj4OU3JTvyXgQ5/B
	O2fFbcoO0OZG+yqfI7sr9W2Qbsr+LaUd9wmAFNbCoMFO+yR0q0Ka1ylN/cQsCVqZ
	gPQG/MqRkfNMBbC8UIhVNA8Epl0bzux9VwuwJKVNTlSEwAhMIitrJJXxbM4P3FfN
	HEoZOArzjHNIyajL7jJUqNkgmOT2VdkBEeIrvuLCE0jnUIW2taY4mEmffJriqpPg
	yAnC0mD2Rh5Xf+FSPoDy3Ul6SA7q+M8laDSftd61haNU/MTpY9FQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48xqt7jdpc-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 03 Sep 2025 12:33:24 -0700 (PDT)
Received: from twshared21625.15.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 3 Sep 2025 19:33:21 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C71E914CE620; Wed,  3 Sep 2025 12:33:17 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <martin.petersen@oracle.com>,
        <jgg@nvidia.com>, <leon@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/2] blk-mq-dma: p2p cleanups and integrity fixup
Date: Wed, 3 Sep 2025 12:33:15 -0700
Message-ID: <20250903193317.3185435-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE5NiBTYWx0ZWRfX7GJJ2WcXuqQf
 vez7tvbuWIM5QSQrni09S+y05BaerMrN8iCtJrJTWS+IIEULCXyCoav52Tu/LowY49VEtTP4osL
 QaSrfuGA66+YqE3XOupKBjIklhSV0BaiCpKXAUS8n5yxJYBuIs/7/pjdnQKKkKcaymo6O6kSeDI
 KE9kWJUektwFSYAlA+U64qrYLxs+tX3TQRodVtW42tuOgJMuWjCFwW0ju/ZKcDHGoFqhngIpQM3
 jg4x9KWkYXulnMpnDPcqIGC6Cd5GVsRhRr/32oUiG+OqzJ6pILL0KYkgQo8GHqvCMOMgTDvuzSd
 uv1K+LtPAk5D5pNR9WJUqV3F7NatcbfmpoL47RTM/VNa4TwmxZkrPh0TEBeJcs=
X-Authority-Analysis: v=2.4 cv=LZ886ifi c=1 sm=1 tr=0 ts=68b89804 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=DmgYukzzZP0S0QPcof4A:9
X-Proofpoint-GUID: nXbUK3ldDJTbdKM_XsZm905JExcwsyf3
X-Proofpoint-ORIG-GUID: nXbUK3ldDJTbdKM_XsZm905JExcwsyf3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

This series moves the p2p dma tracking from the caller to the block
layer, and makes it possible to actually use p2p for metadata payloads.

v2 had a mistake when CONFIG_BLK_DEV_INTEGRITY was not enabled, and this
update fixes that.

Keith Busch (2):
  blk-integrity: enable p2p source and destination
  blk-mq-dma: bring back p2p request flags

 block/bio-integrity.c         | 21 +++++++++++++++++----
 block/blk-mq-dma.c            |  4 ++++
 drivers/nvme/host/pci.c       | 21 ++++-----------------
 include/linux/bio-integrity.h |  1 +
 include/linux/blk-integrity.h | 15 +++++++++++++++
 include/linux/blk-mq-dma.h    | 11 +++++++++--
 include/linux/blk_types.h     |  2 ++
 7 files changed, 52 insertions(+), 23 deletions(-)

--=20
2.47.3

