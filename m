Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5C611E
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306807; cv=none; b=VD2k/0JEmZc4JAkVBKHSwEBsf9wcaWUETnvokxvUqX3UjPQH9up+kPKjAVMVdNxaFyoPsETOeh1sJ1PdS8YnUy/VuVU6LnsY3uIuQDKkOOjG3xrF5k9BiXAykucDHTW1yR9Z8XSIDCo+pN3jFm8mtW3P4tFPeQ+gVlVbIZfQaRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306807; c=relaxed/simple;
	bh=DnowXPAoMdHQZ3Lh6FsBlSEhfoRCn3OFrKDHcSVWg1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lT6RkovBtEuDvmyzEfv2pdTppqU75cXlqsdBInsl4n6eeIwi54pM6jGyQUrmYncWzgcRZvnUX08PLHtSQVYkihcDh0qCldC3TZSJEW9pJyozUBX41PM90mamJhgpknx4U52VT/Vz09TALuBK5KRaqJvUYpTB5fyvYg/rhct93XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 82B3668D07; Fri,  5 Apr 2024 10:46:40 +0200 (CEST)
Date: Fri, 5 Apr 2024 10:46:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: Re: [PATCH 1/2] block: Call .limit_depth() after .hctx has been set
Message-ID: <20240405084640.GA12705@lst.de>
References: <20240403212354.523925-1-bvanassche@acm.org> <20240403212354.523925-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403212354.523925-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Calling limit_depth with the hctx set make sense, but the way it's done
looks odd.  Why not something like this?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b8dbfed8b28be1..88886fd93b1a9c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -448,6 +448,10 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
 
+retry:
+	data->ctx = blk_mq_get_ctx(q);
+	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
+
 	if (q->elevator) {
 		/*
 		 * All requests use scheduler tags when an I/O scheduler is
@@ -469,13 +473,9 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 			if (ops->limit_depth)
 				ops->limit_depth(data->cmd_flags, data);
 		}
-	}
-
-retry:
-	data->ctx = blk_mq_get_ctx(q);
-	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
-	if (!(data->rq_flags & RQF_SCHED_TAGS))
+	} else {
 		blk_mq_tag_busy(data->hctx);
+	}
 
 	if (data->flags & BLK_MQ_REQ_RESERVED)
 		data->rq_flags |= RQF_RESV;
