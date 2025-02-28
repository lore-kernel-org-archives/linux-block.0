Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6381DE887
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730276; cv=none; b=Erc2GqjXJuNd7pFUzMLeByndFGi3aVWgmEOoNNJ8ABGrVqH3nbPnrj9Pgz0MhKzoDzTnUUdCjI+2p6yPTcALLcAyzTLIrnQFujjTqDxW9tcu3SFQ9U5fYtDbSQCxpALEqW0Mr1dE498l4Q8RV7jSkK8VXZJaxNC8oEp5h/DsCJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730276; c=relaxed/simple;
	bh=BMB/Hdli/hpV54E+IrYEmKYG596SW/4RRLWDvGtQ5tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyYfcVA2uBj/vSwbRQPvks5QHEND2B3ebsTogrAFRLslR0uCRC69ZxcXvxU1gLgTDeZmamdd3kS6m8LBTHUTUZGZ31AuIGeTT/Rzq0Hq1EXA4V+03075jFLb8JMj9I2nGjwCwcq79Sw2BY4Ul4imjauR2Z0NWtWW/D3NFVBn6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tdst6Ibo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tdst6Ibo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740730273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6bYndnnhsKipQ6hxTRPQ/mbEwD8lnDV7Rugy7tX+s/I=;
	b=Tdst6Ibo9EoYMnCyFQgkcpbdH0XPluWqhlGxR/iM3y6sP+yDzpo2qenn2m95ty+4qbyKN6
	Ee7SvWIb6qY3rGZtz/f+LQfV8pTbuCXTvbwLdkdrTo0mJQg90r8z5oilZ/9VX/Yb/YYd4+
	YMo5h607RVQw6HWOdm0/x52+fnHulH0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-LWpd0YdXOKGwfvZYcMN0PQ-1; Fri,
 28 Feb 2025 03:11:09 -0500
X-MC-Unique: LWpd0YdXOKGwfvZYcMN0PQ-1
X-Mimecast-MFC-AGG-ID: LWpd0YdXOKGwfvZYcMN0PQ_1740730268
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96A9B1800879;
	Fri, 28 Feb 2025 08:11:07 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F343E19560AB;
	Fri, 28 Feb 2025 08:11:00 +0000 (UTC)
Date: Fri, 28 Feb 2025 16:10:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, asml.silence@gmail.com, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	csander@purestorage.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv8 1/6] io_uring/rw: move buffer_select outside generic
 prep
Message-ID: <Z8FvjnXq3RpX4eZ3@fedora>
References: <20250227223916.143006-1-kbusch@meta.com>
 <20250227223916.143006-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227223916.143006-2-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Feb 27, 2025 at 02:39:11PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Cleans up the generic rw prep to not require the do_import flag. Use a
> different prep function for callers that might need buffer select.
> 
> Based-on-a-patch-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming

