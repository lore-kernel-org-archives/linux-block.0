Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094AD58AAC
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyfXVZCo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705011789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2zfHUkRNp3fZPTZ3mOwSzA0d9Az8XbdXtc3kTjxtdsc=;
	b=FyfXVZCowRf5sWwiDgJ+r7mANMtg/FRMOH2DltG/cOXM5xVLp9H/TwxPxMjxO2vXROdXHu
	7P3C9zwR1OsnCmIcIzCVaNhHpv+Dv/313gMPDkitlBqfDpSIMkYrODEZmipP+S2nWmc5d7
	KhH4fTec69kysmACK0wVCjC3sdSVs78=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-LPoPVscXMrKQVuaTJdnfFQ-1; Thu,
 11 Jan 2024 17:23:06 -0500
X-MC-Unique: LPoPVscXMrKQVuaTJdnfFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 062E0283780F;
	Thu, 11 Jan 2024 22:23:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 87E9B1121313;
	Thu, 11 Jan 2024 22:23:03 +0000 (UTC)
Date: Fri, 12 Jan 2024 06:22:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter reference is held
 when splitting bios
Message-ID: <ZaBqQ0jX6ovHITQo@fedora>
References: <20240111135705.2155518-1-hch@lst.de>
 <20240111135705.2155518-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111135705.2155518-3-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Thu, Jan 11, 2024 at 02:57:05PM +0100, Christoph Hellwig wrote:
> q_usage_counter is the only thing preventing us from the limits changing
> under us in __bio_split_to_limits, but blk_mq_submit_bio doesn't hold it.

Can you share why the limits change matters wrt. split? If queue is
live, both new and old one are supposed to work, such as, we don't
freeze queue when changing `max_sectors_kb` via sysfs.

> 
> Change __submit_bio to always acquire the q_usage_counter counter before
> branching out into bio vs request based helper, and let blk_mq_submit_bio
> tell it if it consumed the reference by handing it off to the request.
> 
> Fixes: 9d497e2941c3 ("block: don't protect submit_bio_checks by q_usage_counter")

The above tag looks wrong, the logic change is actually from commit

900e08075202 ("block: move queue enter logic into blk_mq_submit_bio()")

And commit 9d497e2941c3 doesn't move q_usage_counter from
blk_mq_submit_bio() or bio split.

Thanks, 
Ming

