Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7020C472
	for <linux-block@vger.kernel.org>; Mon,  3 Feb 2025 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608418; cv=none; b=g6EZQxNldAtR5qvi9vnsb+eNXEtselBzJTi9B6Q8sIT68YLNuS26fenKGsJs4ibrothIOsSgLeZTSJFNbeiZWJVHaYzfpR9UwRp2mZSxd4LhAIvYArO2do/XKKemCFq40OK/u7dBoqHviSY+4QbSHu+YLOrzuK3kuZpKwjhNSIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608418; c=relaxed/simple;
	bh=cHfJqU+8fT1AgHs/sOlci9bbUY6q0mUJ2fCUPGBBiQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVh0vBwELNua2uEmD8siPcbg1K1SEKaG8juFUwE+Oy+eMZn7UoZayhorZ7NnYXBkF3D/SCnUXzsqtOvkyHcqCPgWV65a11yltIO9D1+HoLlCTheZbZADgWfnJtVM63QOiMgZbqBvPV6euN2cGLOZoOlbdxOw/kqrFTPLweUy/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SACofaZ8; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SACofaZ8"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513IHnAd023598
	for <linux-block@vger.kernel.org>; Mon, 3 Feb 2025 10:46:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=ofkRPdTjKg7ts9Ihi7aIUWTO3ybxkoz6ifoQjAbWOYI=; b=SACofaZ8osAl
	ouCN04Tz5Vklhq7fleFAb9b5osRyNJMDn0HgLf2l8CjFqVBXRhu5gCPrhqat8HE5
	TMgYwXEvo1FD/TVIA29O3EHEvyPkLujPBT+uyJcLn4ax6LpKz0uY6iGsyOcA63yc
	JKgqkUqHe1kL+IZg7XOxIKd/5zzA+lasv562L6kKSClRCadA8Omyvxb/Lha9ACpl
	FEnk8x0MN31BQJQSbrnFP3VE/YWFqTO+eacVGUHQda3GiTVP3+U0ZjxHydv5yliZ
	DQNWzly0mD7FCi02fmseW/9SA52XSaIconyWPmqz4NmLJw3ayekON/szSQt/9NJ5
	hyHxQ+cc2A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44k2muge55-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 03 Feb 2025 10:46:56 -0800 (PST)
Received: from twshared7122.08.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 3 Feb 2025 18:46:49 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id F0B45179C2621; Mon,  3 Feb 2025 10:41:33 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <io-uring@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <asml.silence@gmail.com>,
        <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        Hannes Reinecke
	<hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 01/11] fs: add a write stream field to the kiocb
Date: Mon, 3 Feb 2025 10:41:19 -0800
Message-ID: <20250203184129.1829324-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250203184129.1829324-1-kbusch@meta.com>
References: <20250203184129.1829324-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ljmWMCHxsTs9g20CmSOUrxX0Y-0rF87I
X-Proofpoint-GUID: ljmWMCHxsTs9g20CmSOUrxX0Y-0rF87I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_08,2025-01-31_02,2024-11-22_01

From: Christoph Hellwig <hch@lst.de>

Prepare for io_uring passthrough of write streams. The write stream
field in the kiocb structure fits into an existing 2-byte hole, so its
size is not changed.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index be3ad155ec9f7..e9ec7afa5d5f8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -408,6 +408,7 @@ struct kiocb {
 	void			*private;
 	int			ki_flags;
 	u16			ki_ioprio; /* See linux/ioprio.h */
+	u8			ki_write_stream;
 	union {
 		/*
 		 * Only used for async buffered reads, where it denotes the
--=20
2.43.5

