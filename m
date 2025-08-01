Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE618442C
	for <linux-block@vger.kernel.org>; Fri,  1 Aug 2025 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092069; cv=none; b=NyOk7TBIHSRVeepOcQsp4LC4uihR0RSj8szGCqjVDfuaE+usahvQldual1qyzNat0bWt57Ji+nVU62TgYSTZlMcx+AOa8tTJ15rEL3WconIXYkCL05bwxoTZ5aFxdsPW531kK4SI3sIaC5SL4n9dnhEegP5lgqHDvZSovJ4XkGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092069; c=relaxed/simple;
	bh=yawt4GLbtfkvbaUJZ5kOUtqrePnmOrCGb6Kso3LofT4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hVCeRWFiZeRnTxihSvjv/8A7yc3P4ZCojj9rEL8yQINoBXEzjCSXAzrMNQN3rOUI1DT2r9ua1YlSwwadfQyLohJ1SNUt+/dl2xyxMIwDvwhTEQLivzv73PL9uoK8gbDp2tVheXnAjv5eC7LB/xroN2DU/1uKvFIH3KuUokAh0F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FD+ChOYW; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FD+ChOYW"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571MmwJ5011331
	for <linux-block@vger.kernel.org>; Fri, 1 Aug 2025 16:47:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=G6dqwmMmZJ1kXj+Rc/
	2AKaMeSpGPdARz82Yt30s8+pQ=; b=FD+ChOYWqEK2YBnwRv07tSwOyB6n8eQqYY
	9Zox2wW1TdtC8sJ4BKDNjHMzybYm1PhkjQfMfH/YF8NCGhS5WxjSKyex3TnKV5Go
	7gbty3fLw4n1n2umEItsaGeEANZ5dszsFEh5KyTzZMQPISIto6ef3GjITGn0cZh6
	uhjMRxLM3iL/jNcJNPEy4j8z3qfs4iZyIMPNm6fVucHeAaHLoZV4ycBg/53CSRRN
	GWadbufG8EBo+Fb9MBn82PcqZMtu+XfGVxq8qN4WEaxGjHuYIgbJHh/YIdMUOTjv
	+yRal2IqRTw0zAYJScpWu317u8IVXATxbc1CVQNzBIlPXIvfwMoA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4896dc8ap0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 01 Aug 2025 16:47:46 -0700 (PDT)
Received: from twshared21625.15.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 23:47:45 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9C2BA3105E8; Fri,  1 Aug 2025 16:47:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/7] direct-io: even more flexible io vectors
Date: Fri, 1 Aug 2025 16:47:29 -0700
Message-ID: <20250801234736.1913170-1-kbusch@meta.com>
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
X-Proofpoint-GUID: 3aYCQcT0CvzfS0FP7MuwgJ3TWjy8uTc5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5MyBTYWx0ZWRfX1P/OXQUoEbmu EELyinxTrvKgETiiAWB9W0F4/8Ar8Qjx7sMJ0hJwKLonbP9WrvrH/vEtzlr6FJUkiuSN9+kqHtn 1uDNw8RCurQfLeNt2kQKEl4RL2gyQ9t2EbJ/OMbJDkNmbCXXmyNckxSsgfNtMJZk4+wsTfracP4
 FNAiub1hxo3FFHe6SEuU46chGq/WhYZt0d41Lv7pPz0xXIMPu56ZGe/M3WaVC3y2JLBdkNzREHJ vJrInoY2/A8XNZeUwj/5MbN3N3Al+epeV5sf8+F2j9N/VioaVaY0oz1TkNHI8PDhW22XLuCSJf6 7P+exrGWALwAeyBVb+fxGbpZLk0JRNES8N61MnW12zaaCKUWRDJSmJSjkmlGByHtw6Ns9U6rnp9
 89kL3CmiCdPw7K1XK6IfErNKW3py7rlyDkHXQmIcaJsfs6pxlwjGKqXnh3cY26SsuRLF9xA/
X-Authority-Analysis: v=2.4 cv=Ndzm13D4 c=1 sm=1 tr=0 ts=688d5222 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=TzghJXyiTW9mTth-5jUA:9
X-Proofpoint-ORIG-GUID: 3aYCQcT0CvzfS0FP7MuwgJ3TWjy8uTc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

In furthering direct IO use from user space buffers without bouncing to
align to unnecessary kernel software constraints, this series removes
the requirement that io vector lengths align to the logical block size.
The downside (if want to call it that) is that mis-aligned io vectors
are caught further down the block stack rather than closer to the
syscall.

This change also removes one walking of the io vector, so that's nice
too.

Keith Busch (7):
  block: check for valid bio while splitting
  block: align the bio after building it
  block: simplify direct io validity check
  iomap: simplify direct io validity check
  block: remove bdev_iter_is_aligned
  blk-integrity: use simpler alignment check
  iov_iter: remove iov_iter_is_aligned

 block/bio-integrity.c  |  4 +-
 block/bio.c            | 58 +++++++++++++++++---------
 block/blk-merge.c      |  5 +++
 block/fops.c           |  4 +-
 fs/iomap/direct-io.c   |  3 +-
 include/linux/blkdev.h |  7 ----
 include/linux/uio.h    |  2 -
 lib/iov_iter.c         | 95 ------------------------------------------
 8 files changed, 49 insertions(+), 129 deletions(-)

--=20
2.47.3

