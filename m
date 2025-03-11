Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778DA1DF728
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741656089; cv=none; b=ByeKufxyPtnr5aowZvKA6Ze8vXuVOOlm/mQX6FeBa6MpN9y4Z/fUrcv5nTKaS7wkRZCPymqOHi/d4XRBU6Oqz1jnNvf3Y7b81nCQbwB9Ri4TQCCEFCMtkCUvp1XZXrkQE/Hom6Ggmy1C0+nJr4tNJLrXTDeId19nzRGv/2S35Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741656089; c=relaxed/simple;
	bh=GY8n61vMsILgE40kTRFUvYW15jLLcokTQRLUvXoH4RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rhz7Q7y9RzBOl/NrikYBbKj8Usk/EGESsD0DZRm+W3s28mA5lubbEfy941gqxsyyP0vF7Wuy8j6AkeKC8q7HVO3T0fmRC0VWZSuetqpuzhJIX+Zp3jC5L2HqL0xJSY0H9dhfUIlfjN+yGpTgvFluEOW5ggoi6TShIts7hLDD8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFH8KPSS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFH8KPSS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741656086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iEdovEdPYwOF2FlSw1ITze8hyRDWG+E9vciuNNbetkA=;
	b=UFH8KPSSlKIHZ0V5rczDtSsoRgnHUKZPafrMcPRCwVlzoqfllnrczpNahyzidrzwGfZkvw
	M1exuQlEbtUyCBb5ILw1IO8XtEOwak81WlAZiSaN3U0S782dxhpn8VqDiTmOFj+snb7nuv
	hLn5YLioD4o0uWXnuxRY6/ICIDmc/A8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-pgDY5OiGM2uV_JttYCTGtA-1; Mon,
 10 Mar 2025 21:21:24 -0400
X-MC-Unique: pgDY5OiGM2uV_JttYCTGtA-1
X-Mimecast-MFC-AGG-ID: pgDY5OiGM2uV_JttYCTGtA_1741656083
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89E3C180034D;
	Tue, 11 Mar 2025 01:21:23 +0000 (UTC)
Received: from fedora (unknown [10.72.120.11])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB2C819560AB;
	Tue, 11 Mar 2025 01:21:19 +0000 (UTC)
Date: Tue, 11 Mar 2025 09:21:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [RESEND PATCH 3/5] loop: add helper loop_queue_work_prep
Message-ID: <Z8-QCgotmHgsGNWB@fedora>
References: <20250308162312.1640828-1-ming.lei@redhat.com>
 <20250308162312.1640828-4-ming.lei@redhat.com>
 <Z87I2C-J6YxojQ6h@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z87I2C-J6YxojQ6h@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Mar 10, 2025 at 12:11:20PM +0100, Christoph Hellwig wrote:
> On Sun, Mar 09, 2025 at 12:23:07AM +0800, Ming Lei wrote:
> > Add helper loop_queue_work_prep() for making loop_queue_rq() more
> > readable.
> 
> Looking at this and the finaly result I don't really see any advantage
> over just moving the code into loop_queue_work.

loop_queue_work() is required for handling -EAGAIN, that is why I move
loop_queue_work_prep() into loop_queue_work().


Thanks,
Ming

