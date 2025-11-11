Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAB22FB973
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 01:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823940; cv=none; b=jD0D98BNwRhF6GzI4ES1nokY4gGJmZZGuOp8aYbuZjlTZmKPbilfD7MAe9K5Yfr1WHa/viImsrjJNpCymfkBJmRZhg4NBenfCNLWXF5Df9Qlr/f/Oye72JYzgbGf7RHyO02tNvwohPwHQuasUfvkZzDkBB8/q3rPto0jx6x+lZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823940; c=relaxed/simple;
	bh=gVOCHcLd7vlaD45mmmeT2DbaDnluYLi6634DCgWvvug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnXZLNVay3QYKss4Gi+I6i1QLgdXbnqUPSvRJXvm0NFgdG5AhhuTGFk1dZnaHp2K7AFzM1rmBGbxNzDiBHEzIsa8Y+/pBRzHJrQvOmMWGW1aRzvTxAX0BDqIhk/0FQvHKglMJOYL/h3R1G2kRa1PeJHb7LM6icpx75NfVNUwm2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGBTbDkZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGBTbDkZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762823937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2FQUwSyyoVoVriZCBJzfpQK97TJampYcHK1ld/GSIw=;
	b=IGBTbDkZGaoFs9m/v8h2T8OIA6ZLG6mxlbybhhfW0PJxYKhBxezkOQK4iCQPSNuuZiwB/d
	oddyRQJOEiKgnn2S7sGAJw5KLcxfaAKFoStdMaO7z7aYsnPbYLJWZqsac2oFYgk5bO1c0u
	BskguIlVOLz6uwbkFpvP4KW0bCMxec0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-wLs83JxXNamULDwXnWUAYA-1; Mon,
 10 Nov 2025 20:18:54 -0500
X-MC-Unique: wLs83JxXNamULDwXnWUAYA-1
X-Mimecast-MFC-AGG-ID: wLs83JxXNamULDwXnWUAYA_1762823932
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E02F81956096;
	Tue, 11 Nov 2025 01:18:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.124])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67F6B30044E4;
	Tue, 11 Nov 2025 01:18:44 +0000 (UTC)
Date: Tue, 11 Nov 2025 09:18:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>,
	Martin Wilck <mwilck@suse.com>,
	Benjamin Marzinski <bmarzins@redhat.com>, stable@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v5] block: Remove queue freezing from several sysfs store
 callbacks
Message-ID: <aRKO8KbvokgBUPGB@fedora>
References: <20251110162418.2915157-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110162418.2915157-1-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Nov 10, 2025 at 08:24:18AM -0800, Bart Van Assche wrote:
> Freezing the request queue from inside sysfs store callbacks may cause a
> deadlock in combination with the dm-multipath driver and the
> queue_if_no_path option. Additionally, freezing the request queue slows
> down system boot on systems where sysfs attributes are set synchronously.
> 
> Fix this by removing the blk_mq_freeze_queue() / blk_mq_unfreeze_queue()
> calls from the store callbacks that do not strictly need these callbacks.
> This patch may cause a small delay in applying the new settings.
> 
> This patch affects the following sysfs attributes:
> * io_poll_delay
> * io_timeout
> * nomerges
> * read_ahead_kb
> * rq_affinity

I'd suggest to add words why freeze isn't needed, such as:

```
Intermediate value isn't possible, and either the old or new value is just fine to take
in io fast path.
```

otherwise this patch is good for me.


Thanks, 
Ming

