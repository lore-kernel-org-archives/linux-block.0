Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A5114386D
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 02:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743648892; cv=none; b=Tn8qo4xhX1A0HOh1lhxtMhOMpMk5G6TTjHDo7T07QQ5fGae13elJcjQXDesuWzEAE6SINYte43mU+kCrYGgriW8SELdjoD/6lH8ggVRlc8nDTIBE/po6W8pJzdJIJSrybTzq6sNsz220qfQR0nrhYJkOIY0PM8mUpAAgY0dJSPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743648892; c=relaxed/simple;
	bh=co0ZqHyeZYqY6ysV04/+bQm8kMeNhD71NM/HvIN9Fas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd2MxnW1QTAbPXwzxXYz4wwpj/9slIGkQKGTOWa54DjTysDoo91NL7QCnDc1s2kL3ylfvx69YbG5imykA/vCSJfvCOWNn2sa7jetDtg4mFLe8nxnevb6R80v7qRGJKIEj5+J57c4GDz3lqvskt6CTX9xPq69gJAj9q9RJmq8KpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dD0VRPA1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dD0VRPA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743648889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87x4mFxvzbD9B39A/jzDT8JGVG7M9KU2SK5Nm9bAFXk=;
	b=dD0VRPA10hfuZU3pxWK40VXU0Y2vD7fnnljpzlTArhZN7h8SyiThhLuJwC4IlDBv1FGkS3
	Fw1o3Wfl4JK/Nvi+Cabg2YChN4i1xNHJnosOfwSTpSzwiOF0pwYmWuiiiv7xCm6WI9gY+2
	/TdAQ7okaiYOdi+nXcDmZajojO1L/cM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-hsKnii3fMuSQ1vk8QKEiHQ-1; Wed,
 02 Apr 2025 22:54:46 -0400
X-MC-Unique: hsKnii3fMuSQ1vk8QKEiHQ-1
X-Mimecast-MFC-AGG-ID: hsKnii3fMuSQ1vk8QKEiHQ_1743648885
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C59A1801A00;
	Thu,  3 Apr 2025 02:54:45 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41C1B180176A;
	Thu,  3 Apr 2025 02:54:39 +0000 (UTC)
Date: Thu, 3 Apr 2025 10:54:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	Christoph Hellwig <hch@lst.de>,
	syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
Subject: Re: [PATCH 3/3] block: use blk_mq_no_io() for avoiding lock
 dependency
Message-ID: <Z-34as5GCEtdYsOy@fedora>
References: <20250402043851.946498-1-ming.lei@redhat.com>
 <20250402043851.946498-4-ming.lei@redhat.com>
 <089a8cf5-bc01-468f-ab96-f04448e034ae@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <089a8cf5-bc01-468f-ab96-f04448e034ae@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Apr 02, 2025 at 07:13:56PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/2/25 10:08 AM, Ming Lei wrote:
> > Use blk_mq_no_io() to prevent IO from entering queue for avoiding lock
> > dependency between freeze lock and elevator lock, and we have got many
> > such reports:
> > 
> > Reported-by: syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/linux-block/67e6b425.050a0220.2f068f.007b.GAE@google.com/
> > Reported-by: Valdis Klētnieks <valdis.kletnieks@vt.edu>
> > Closes: https://lore.kernel.org/linux-block/7755.1743228130@turing-police/#t
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> I tested this series on my system and this works well as we cut dependency
> between ->elevator_lock and ->freeze_lock. However don't we plan to now 
> model blk_mq_enter_no_io and blk_mq_exit_no_io as lock/unlock for supporting 
> lockdep? Maybe we don't.

Good point!

> 
> Overall changes looks good to me:
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

Thanks for the review!

lockdep modeling for blk_mq_enter_no_io and blk_mq_exit_no_io has been
added in V2.


Thanks, 
Ming

