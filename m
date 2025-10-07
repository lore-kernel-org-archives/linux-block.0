Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C362E889C
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859606; cv=none; b=f2DSEOATH3kGC41mwCXSacKWWgFuO1TzWw6aXUQXn+Cht+o/VNS6A1i0t/qH603uu1X2zhp3cwUgXrmbM3j77HAIm8vJ8l8Iib3272fNw0hZWqeLlG3coH84AD7vuIp+zznd8x6wwsHuT2uej4448+nK/6WcumTf/eREquPMenM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859606; c=relaxed/simple;
	bh=qyQ69O9FPIQ/2fLg1OdSIlU4qOEFRUveC46KPIyPHgw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZXTH2E8TAzSME7lYzrL3MCDJA5EIBS8BR8CQlhOZeehtc1Usgw98BIZ0WoQgdF2P3ZVpmboOtWrdGRFA9gBNryIoqNdwz5kBmZ47WwURs8yrK/sL+iuJzm4ms7XtEiEIp2zKnSRx6xvTAMJiaP2yvzr2CEyzGOPdbMyGX1rLwws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Sw1e+Gl5; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Sw1e+Gl5"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 597FSQcG3665456
	for <linux-block@vger.kernel.org>; Tue, 7 Oct 2025 10:53:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=N+hNHTQnK6A8zF0Brm
	JylzXaFw/77S9mJ3a2IKnV200=; b=Sw1e+Gl5jE2har88tADSYc6lnl6Q2g/kAH
	f8MUgavWrAHpX9XfJGNrz+qkwgpXG7GmHBfnONaCut4/QjdE/trtP9rJ0yw/0BEh
	JJ93Uar58W24vP+c9mDOrLFLJJbldOttsMneuxBBaB+roZ/5fsNDwCe72nVMd8FO
	aaGS0TEFqb6AOiZeiOMCr83qd5Zwl63fSDRKM3VG9QtwIqcyja4BkfWAex4ozS2f
	VdTaCrymUXH7jcT/1lWdoqMAe1pa1l0TYUubO/ib+F5dfwt5OXqRViMEuJc7Lgfu
	ILP9yHF4uRIsAjrXRjZFdDhOs7K25qXL9sNXTQGo/0vOal8MGwSA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49mwg6ms78-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 07 Oct 2025 10:53:23 -0700 (PDT)
Received: from twshared25257.02.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 7 Oct 2025 17:53:03 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 0AE26278193A; Tue,  7 Oct 2025 10:52:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 0/2] block+nvme: removing virtual boundary mask reliance
Date: Tue, 7 Oct 2025 10:52:43 -0700
Message-ID: <20251007175245.3898972-1-kbusch@meta.com>
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
X-Proofpoint-GUID: RqFGQHw-IM2j3lJ9dO0lMLV_xg1dBe09
X-Proofpoint-ORIG-GUID: RqFGQHw-IM2j3lJ9dO0lMLV_xg1dBe09
X-Authority-Analysis: v=2.4 cv=PsSergM3 c=1 sm=1 tr=0 ts=68e55393 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=D3lQaUfW4OkPWDUkTUkA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE0MSBTYWx0ZWRfX+h9H1FGfjp8r
 13Jy333YIuzP6Y1kCQpshpfodcAbv7Ba4p8h1mgjncxkCX0+duhU9RYjNyhyguRC+RWWA/AuznC
 isjl0wDNWuqH2NI7uyC2e4hajo/rgQqHWvuCAdZ+ua7Yo2vFffThCGJrnh6HMBwMzuLpjCQN9eB
 FHCgrN8xAblbByFd2uE7VoJHpExh3gbUYLtcBFVbLSplo9c8AFmd+4LAeDveMzXEke9EcGw7CC/
 4gBfKBL0eSzgmHKnWw0mYorVT7R4ZWcxPYoJed3aqNghI+FSNzKBYpQczxafv4H6S6WfXFB8Ckg
 2y4CFwpLDwZ/RV1+GRZ87hfgSGgk994q8KVyf4IDzBLTeB6yjGJSAweQVnlr3nhgCPg1Uve3ied
 h/GuN84Ty6wu+UagR62V5/ilHjDCBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Previous version here:

  https://lore.kernel.org/linux-nvme/20250821204420.2267923-1-kbusch@meta=
.com/

The purpose is to allow optimization decisions to happen per IO, and
flexibility to utilize unaligned buffers for hardware that supports it.

The virtual boundary that NVMe uses provides specific guarantees about
the data alignment, but that might not be large enough for some CPU
architectures to take advantage of even if an applications uses aligned
data buffers that could use it.

At the same time, the virtual boundary prevents the driver from directly
using memory in ways the hardware may be capable of accessing. This
creates unnecessary needs on applications to double buffer their data
into a more restrictive virtually contiguous format.

This patch series provides an efficient way to track segment  boundary
gaps per-IO so that the optimizations can be decided per-IO. This
provides flexibility to use all hardware to their abilities beyond what
the virtual boundary mask can provide.

Note, abuse of this capability may result in worse performance compared
to the bounce buffer solutions. Sending a bunch of tiny vectors for one
IO incurs significant protocol overhead, so while this patch set allows
you to do that, I recommend that you don't. We can't enforce a minimum
size though because vectors may straddle pages with only a few words in
the first and/or last pages, which we do need to support.

Changes from v3:

 - More comments explaining what the new fields are for

 - A bit of refactoring to reuse the bvec gap code

 - Also count gaps for passthrough commands, as it's possible to send
   vectored IO through that interface too.

 - The nvme side has all the transport ops specify a callback to get the
   desired virtual boundary. PCI supports no boundary for SGL capable
   devices, while TCP and FC never needed it. RDMA and Apple continue to
   use current virtual boundary mask as it's not clear if its safe to
   remove it for those.

Keith Busch (2):
  block: accumulate memory segment gaps per bio
  nvme: remove virtual boundary for sgl capable devices

 block/bio.c                 |  1 +
 block/blk-map.c             |  3 +++
 block/blk-merge.c           | 39 ++++++++++++++++++++++++++++++++++---
 block/blk-mq-dma.c          |  3 +--
 block/blk-mq.c              | 10 ++++++++++
 block/blk.h                 |  9 +++++++--
 drivers/nvme/host/apple.c   |  1 +
 drivers/nvme/host/core.c    | 10 +++++-----
 drivers/nvme/host/fabrics.h |  6 ++++++
 drivers/nvme/host/fc.c      |  1 +
 drivers/nvme/host/nvme.h    |  7 +++++++
 drivers/nvme/host/pci.c     | 28 +++++++++++++++++++++++---
 drivers/nvme/host/rdma.c    |  1 +
 drivers/nvme/host/tcp.c     |  1 +
 drivers/nvme/target/loop.c  |  1 +
 include/linux/bio.h         |  2 ++
 include/linux/blk-mq.h      |  8 ++++++++
 include/linux/blk_types.h   | 12 ++++++++++++
 18 files changed, 128 insertions(+), 15 deletions(-)

--=20
2.47.3

