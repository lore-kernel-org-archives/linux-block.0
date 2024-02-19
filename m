Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5FD1CD38
	for <linux-block@vger.kernel.org>; Mon, 19 Feb 2024 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708324185; cv=none; b=lopPbh9vVVKci3buR7b72v56EuutxhUW34pa6bkWtiudxCktvp1b97gJorGkqxqhCAe4hMqcnNg9nv5ovFbc6WmzPSNy7cxSVrQVDFUz+eNIJbJ7PFurNGO8ZgOy3j7MvHd1EGDFv0KsfgUVoVRMeCLvYqGT9omEXV/7H1vHA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708324185; c=relaxed/simple;
	bh=qQ+AXsA5zZK0IabW1QjaPjpy83CGH+CQHIZj5cB0isA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RscfT4hkJ5h5V67UZpFsWDh9WwxNK0jU0LZ18kAaULzAXNmc+l7cMkq3OFpb2qeJBiAxcKzO1wKqvsdt7hV2IiBvxdsYzs9J881L96lh0xJVSMFDFIu+Rj3qN96V/LJnrQrhkyVXIn/QAQfuPwj4MA8v5O7X5POQFiQLpG0yeV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KFnFP6gL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KFnFP6gL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=madzTU67VDHTC8geuW7tI+ym9XXI8WJfOhrFVen5SOQ=; b=KFnFP6gLC7SvdmT9eVsNGFLahK
	uqmDdd+lJI5nzykt/ODeVCR+j4gcPZ02rhCgfiFretHfdKgT/xrs4mCGBlu3WOsww1jhT3pr/6I/Q
	67ILVcAbbjvXAPdz7m0UR99HT7Fu5Pc86KB1vsjm+Wo788QyOpzUNHzFjDqoVrEfZ/K/LCvF89/2y
	5xDSqjnngi5OCcOG7m2DbDS1aQ6Z9sBghxPgbZ3epooJUP3X+8JL0pP3DR/cCqAeDYSh3R0w6unXs
	buWcDJkQjelMl+Ck2CCuHqR42y4EzkO9peSWFvbjlk452fncLqIg0ESJhDBWrhKgWQYZ+kjuu2KHr
	ToZwQKXQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbx9r-00000009Fbx-3VZ9;
	Mon, 19 Feb 2024 06:29:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: drop bio mode from null_blk and convert it to atomic queue limits v2
Date: Mon, 19 Feb 2024 07:29:44 +0100
Message-Id: <20240219062949.3031759-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

this series drops the obsolete bio mode from the null_blk driver and
then converts the driver to pass the queue limits to blk_mq_alloc_disk.

Note: this series sits on top of the "pass queue_limits to blk_alloc_disk
for simple drivers" series now.

Changes since v1:
 - add an incremental from Damien to make sure the zoned tunable are
   properly taken into account

Diffstat:
 main.c     |  502 +++++++++++++++----------------------------------------------
 null_blk.h |   19 --
 trace.h    |    5 
 zoned.c    |   25 +--
 4 files changed, 139 insertions(+), 412 deletions(-)
