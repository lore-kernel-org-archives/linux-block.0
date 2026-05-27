Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1574442849C
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894660; cv=none; b=YjCg0GyuZytz/d3T4O+no5nx62Jsk6CEPHDrFjlV9u2zUPRrSNTobcFIPJvnFHfFRDLaPwa3ViFTv3Nip7uTUwgfyvdT+QsNFJOfN+wbMZr7URKKU3yyKyCWQaJCIMgZvBHVwW1PYpTmaXL53fZfW3epBcbcfsYAnxvGS3LZXwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894660; c=relaxed/simple;
	bh=bywijsy69ckxU0bPWjPAxJ7LdF+5uxn+cb9eNBm1FCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ODT33mzkEp5aLr2xE2EHTS7YvoMlYK26QUNrG7A8h81eAMp/hqKn0VstWNXiwQnzQRnELJqY73BvXDVvDR5gRDXMHt/dEq9ssNeycc5xCNCCoS0sZ78BEiOgZ4SlQE0Jwqpw9OiXwX5I3aRTSuIBF/IU+uA1KCPod0ChUTKUdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pJTU4L5Q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pJTU4L5Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Ab2HJ8Za032F8Qytnn6DKP9PrueMPVV04mFMTh1CmjM=; b=pJTU4L5QlCGjx/I1msaYSjMTRM
	98E9rvFcXX/KjXqE4sg29/S1GFzY7jFWyOudJuSy+Xj4ExS/dqlHBgFP2gHpC/zozlTAeu2bPxfHP
	VvumxdiXhBX+kzBJKWxkpH0NvZwA0G9yfZffNt1BaUfsqZBNZb05zW3Ucs8XjTXoTzv/4eMFJbKCp
	ZH+0+tQoobuX/6pjHDyOzFRpQmhmj5ddfEMTg8gt14cWtBGEFboo7ZkNIWtfa9zUOLI2BTqU7vHa5
	cGx6hzaUwqO0MlEDu6ivzmy5bEXXSWn4yWldWU4DoLAVODEPpaBxFrwbpDq1BJNdts4exh7ubxLl0
	oU3wSUgA==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFuB-00000004NYP-1aYb;
	Wed, 27 May 2026 15:10:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: clean up bvec iter helpers
Date: Wed, 27 May 2026 17:10:19 +0200
Message-ID: <20260527151043.2349900-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series converts the bvec_iter helpers from macros to inline
functions, and to facilitate that cleans up a little bit of code
in the loop and nvme-tcp drivers first.

Diffstat:
 drivers/block/loop.c    |   24 ++++-------
 drivers/nvme/host/tcp.c |   27 ++++--------
 include/linux/bvec.h    |  101 ++++++++++++++++++++++++++++++------------------
 3 files changed, 84 insertions(+), 68 deletions(-)
