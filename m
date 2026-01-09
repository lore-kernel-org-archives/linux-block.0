Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2682E88B0
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 06:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767941414; cv=none; b=kxOJ1jeorysCXHVtwf7PRLuxIMx1eJ3nLdwiuIFel9zOBqFmuM8BGtss93ev/EEwt5u4xaEbA0coQnGmY/t1dKZzTZwq8mNgqSRUlaCx3UixFzISfaHINgGV/gzXDsqO4nDa2qASlvbc+nCZCKK08519B4NfrpX1hK+epPtuhnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767941414; c=relaxed/simple;
	bh=Wddd71YfgqBV61Mz3piu6HtOhpkWUJ3GcXZFH/9NaQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt7G/XEcu2+wZwZL3Jk9kgjXeOt508TKZqSMHGQiXbTkn4nEDYoyK3csVOQzU+NDHIpOY9ET4adDRtX44MQUUj8njcBLi+wNjZ7Xd3YtygFHTyDjA8wVl0yNGRl6CZA3l6joazazTzz8YR+kl2DNaOUtgWf8xVlvpnzPmfNNUT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdPZAyAN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdPZAyAN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767941411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GeB3Xq3xOpZZ0Hi1G5g7hUDKY44hDnBC9KWf8hZkWmk=;
	b=cdPZAyAN1KbU0obn8lGJl/0d6iribUOqzOG0FP31H3yKdUvc00NMhdNzeUeCMMyaUULiZV
	gXH2XJRkpT+SRqJSoHjEGRSnjbxEO114f3SV829i5XeO91kFAwEmdF6cFE64ei1DZ/fD2t
	6ZdjEubFClfEmP/CW3tT5CXael1QgI8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-rQU7WIl1NNCxGMqTTvr7mA-1; Fri,
 09 Jan 2026 01:50:08 -0500
X-MC-Unique: rQU7WIl1NNCxGMqTTvr7mA-1
X-Mimecast-MFC-AGG-ID: rQU7WIl1NNCxGMqTTvr7mA_1767941406
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC7CF195608F;
	Fri,  9 Jan 2026 06:50:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.172])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CE2930002D1;
	Fri,  9 Jan 2026 06:49:57 +0000 (UTC)
Date: Fri, 9 Jan 2026 14:49:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, James.Bottomley@hansenpartnership.com,
	leonro@nvidia.com, kch@nvidia.com,
	LKML <linux-kernel@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, riteshh@linux.ibm.com,
	ojaswin@linux.ibm.com
Subject: Re: [next-20260108]kernel BUG at drivers/scsi/scsi_lib.c:1173!
Message-ID: <aWClEA6KuLP6E1cP@fedora>
References: <9687cf2b-1f32-44e1-b58d-2492dc6e7185@linux.ibm.com>
 <aWCYl3I7GtsGXIG3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWCYl3I7GtsGXIG3@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Jan 08, 2026 at 09:56:39PM -0800, Christoph Hellwig wrote:
> I've seen the same when running xfstests on xfs, and bisected it to:
> 
> commit ee623c892aa59003fca173de0041abc2ccc2c72d
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Wed Dec 31 11:00:55 2025 +0800
> 
>     block: use bvec iterator helper for bio_may_need_split()
> 

Hi Christoph and Venkat Rao Bagalkote,

Unfortunately I can't duplicate the issue in my environment, can you test
the following patch?

diff --git a/block/blk.h b/block/blk.h
index 98f4dfd4ec75..980eef1f5690 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -380,7 +380,7 @@ static inline bool bio_may_need_split(struct bio *bio,
                return true;
 
        bv = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
-       if (bio->bi_iter.bi_size > bv->bv_len)
+       if (bio->bi_iter.bi_size > bv->bv_len - bio->bi_iter.bi_bvec_done)
                return true;
        return bv->bv_len + bv->bv_offset > lim->max_fast_segment_size;
 }


Thanks,
Ming

