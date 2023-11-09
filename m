Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5BD304
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hm6qqJKb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60F4210A
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 00:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699518525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/z5iPKrCnCEKsP01FKp/PX5tEJxYT0G9pz0h1C4LTmM=;
	b=hm6qqJKb3pHdRe4WZp49t/jCJdb8Ns9ZSWo8yzj1JqKEQ5JPRqrGeroAQj124bOHbmCVOL
	B+YFeH+zNXy3zTocXlphtxiOUxWrYj0szbhXtG1eHsCK3+OC/P4Dh/tuHwPdSMaI8442IL
	r5APvXcvwo8BCEbfCF308vDhQAuUAv8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-cLGjDNsRMfWB7WioJ4rWLw-1; Thu,
 09 Nov 2023 03:28:41 -0500
X-MC-Unique: cLGjDNsRMfWB7WioJ4rWLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E74C129AA3A5;
	Thu,  9 Nov 2023 08:28:40 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AF5021C060AE;
	Thu,  9 Nov 2023 08:28:39 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ed Tsai <ed.tsai@mediatek.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/2] block: try to make aligned bio in case of big chunk IO
Date: Thu,  9 Nov 2023 16:28:19 +0800
Message-ID: <20231109082827.2276696-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Hello,

The 1st adds check to avoid to call into iov_iter_revert() with zero
'unroll'.

The 2nd patch improves big chunk sequential IO performance by aligning
bio with max io size.

V2:
	- add patch 1/2
	- add 'max_size' hint to iov_iter_extract_pages() so that bio/iov
	  iter revert can be minimized, as suggested by Christoph

BTW, the check on 'bio->bi_bdev' isn't removed because there are more
such patterns(P2PDMA, block size check) in __bio_iov_iter_get_pages(),
and we need to audit that bio->bi_bdev is really non-NULL first, so it
shouldn't be part of this patchset

Ming Lei (2):
  block: don't call into iov_iter_revert if nothing is left
  block: try to make aligned bio in case of big chunk IO

 block/bio.c            | 126 +++++++++++++++++++++++++++++++++++++++--
 include/linux/blkdev.h |   5 ++
 2 files changed, 125 insertions(+), 6 deletions(-)

-- 
2.41.0

