Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C3E329C57
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475164; cv=none; b=pqhbmCSKr3C0oSZ04U++ZCkVxxoA6RHxHYlndTTO46MIpPukuS0qrvIEnWL7AttWibZsLmVR++KxemiM15ahkoI/WKvdHFo0Znp7IBnm8cT4uzx2CodMgcej4GDp9hUYK9v63NtfSEOGMCtH7z31VHEbXt3lcGeYyDQh8BXzlMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475164; c=relaxed/simple;
	bh=k7L4UigFG9RtH8rF3fSiua0sdY9POVY5hNPSfcW3jsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McW3Ep5a7DCOsFZnRekqo9yiRv0WhkFOkh4EZ3r1dQx4jk9U3yFdud/sghzLm5LLQJmrVdB2uP06cmjGd9AIrZhNVfGjb8W3h7dZuAvdDXcj0qanKay7etzJjQRQaZ/LyfmkhRfMe3GYOsLpoESV/q1fBfss9eIGd4AWg7V1Ck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vw8BfOHU; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vw8BfOHU"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0pL6fs3zlgy4t;
	Wed, 25 Mar 2026 21:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475160; x=1777067161; bh=6NbH4
	rNgGbE+WQFo+E01o3eAWSCIvVjj2EdAsH8xE2o=; b=vw8BfOHUasJRPG7XBIpjr
	+33SydQwWODHbg8uslmoiABxNiZ16UWUqPjXT5c4HPFGCe4+FwYsvANRj6o6SMg/
	teLG1CWBQZTgML+VRw/OtXYh6p6Z4jUkFD5g1BMWSAsxCbr5dN7x89Xrhmi1Lfwo
	XV7KYXyVUt3qL5Ap0Z5kBEUWVGP3/WBW7Gm+MDBS5+q32j1XacJhZ0KsdNa7U/PS
	nxjNdpYJNjf/t0Z3XsCyWFNmCO/ZCMWPPGEldBO3NC0l4ICx/p4WQrDAV5ygBiyl
	Ftm9C9TSiRvAnrJXUIuNQ4VTpspeqsb48SSgAeI4dLqtS8X254FeMuq2t2ASivAa
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Qts58nxJg4j3; Wed, 25 Mar 2026 21:46:00 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0pG60mxzlgwN4;
	Wed, 25 Mar 2026 21:45:58 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 13/26] block: Enable lock context analysis
Date: Wed, 25 Mar 2026 14:44:54 -0700
Message-ID: <20260325214518.2854494-14-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that all block/*.c files have been annotated, enable lock context
analysis for all these source files.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/Makefile b/block/Makefile
index 7dce2e44276c..54130faacc21 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the kernel block layer
 #
=20
+CONTEXT_ANALYSIS :=3D y
+
 obj-y		:=3D bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-flush.o blk-settings.o blk-ioc.o blk-map.o \
 			blk-merge.o blk-timeout.o blk-lib.o blk-mq.o \
