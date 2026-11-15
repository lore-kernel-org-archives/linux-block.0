Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.128.148.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794753694;
	b=G2wgA0PTzMohQgnnxpfLCn8s42Zh2go4qBoE1dOmbGnhgsM4qXr9VKg9aqVuwjZvQQdM
	 j4BoTDAsrfX4S54h82b50KiCHRGFiD4UIpNBSeEaWppa1yyplO0Lq8cu1arLeMFE7tevc
	 3kGx5oqK8S9GmhaAkU52b9dIpaZpzQzPeKCvRo75moe08vr3qijYw1s5/9rFbWIEF2JAn
	 +Mn9oVFw+uQN8GFF+LW0tpkxUICKGWHtBFfjDrmDx+e63ohzXbzg58tmcu+xd42fGd9TK
	 Lz7x23NLZsvlzhlbiQOmcUexyKVVvApvC0zAWmLaY98zX0F9X/C1PgcOXrjHO7v3Z5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794753694;
	h=DMARC-Filter:From:DKIM-Signature:To:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=e1bgO6Fj3CxlMe7EFyu5MVBDrIMFpF1oc9kKBs8zGgw=;
	b=GWAKSw/cohtKFBrqZXgESVF5P8zfrALAIFvcir8ZJv+BPq/VdfQAWoobIgyLjUmByCyP
	 Au7k/PYKu8qyZM0RWgAZlZ7Z8xrod+U82zkhYZwAMxr/bWw6juBiHpt0plNs1KHkRfQ2X
	 tnqmXj+VL5zB8OalDnTxcSNza2SPQKPsK0sUd8rDQbmlr30uOZQuoOZFkda5XCswV0HS0
	 a4NL9zOFtQIMtEqZUI6/E+qmoX+y4EIou99+PUU5i9uNPckHJZ5ZoR7KXpqsaTeDSkrIz
	 kVG4NCtBE2SxrW3JTHn8N5dY9uRrEVWVhmK0jOpobZadOySjmWh+B5VDcb5IaZZMEng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eversole.co;
	spf=pass smtp.mailfrom=eversole.co;
	dkim=pass header.d=eversole.co header.i=@eversole.co header.a=rsa-sha256 header.s=mail header.b=ZtXFBZKo;
	arc=none smtp.remote-ip=216.128.148.134
Received: from mail.taqjiao.com (mail.taqjiao.com [216.128.148.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85720606A31F
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 14:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85720606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eversole.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eversole.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eversole.co header.i=@eversole.co header.a=rsa-sha256 header.s=mail header.b=ZtXFBZKo
From: James Eversole <james@eversole.co>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eversole.co; s=mail;
	t=1794753686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1bgO6Fj3CxlMe7EFyu5MVBDrIMFpF1oc9kKBs8zGgw=;
	b=ZtXFBZKoK/NOaH8lAwQIERjSU1zd5sLDPwBwphbZ9ItCW1TdtjYIusifEQMGbhqoN/IrMG
	erGxnHKfumYQ+O+aMM5k611cgDxrTBpDm1t1IM0lrBUY1S41jLAJyhBBSQcrE3pFx5wGl+
	FXVqgQy36w+vP7YPkk+B4I50aAShCD0=
To:
 Ye Bin <yebin@huaweicloud.com>, axboe@kernel.dk, linux-block@vger.kernel.org
Subject:
 Re: [PATCH v2] blk-flush: fix possible deadlock when process nvme_timeout()
Date: Sun, 15 Nov 2026 08:41:24 -0600
Message-ID: <179475368487.107480.2931723348388347514@eversole.co>
In-Reply-To: <20261112135019.3290131-1-yebin@huaweicloud.com>
References: <20261112135019.3290131-1-yebin@huaweicloud.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Cc: ming.lei@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ye,

On November 15, 2026, I hit what looks like the same deadlock on Linux
6.18.56 (NixOS), using a Kingston NV2 2TB with firmware SBK00104 as the
root disk.

A FLUSH request on QID 4 timed out, then timed out again 30 seconds later,
triggering a controller reset. Recovery remained stuck for over 100
minutes with this stack:

  msleep
  blk_mq_tagset_wait_completed_request
  nvme_dev_disable
  nvme_timeout
  blk_mq_handle_expired
  bt_iter
  blk_mq_queue_tag_busy_iter
  blk_mq_timeout_work

The controller remained in "resetting". Debugfs showed one busy request:
FLUSH tag 171, state=complete.

A read-only BPF probe in blk_mq_tagset_count_completed_rqs(), filtered to
the stuck worker, recorded:

  tag=171 state=2 ref=2 end_io=flush_end_io

The kernel and systemd were still running, but root filesystem I/O was
blocked.

I haven't tested your patch yet, but wanted to report this independent
occurrence. I have the netconsole logs, task stacks, and probe output
available if useful.

James Eversole
