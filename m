Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7B1F473D
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300580; cv=none; b=IV6H1dcKSn1dzWX52+cHJOW1RdsRJbRU1sRLTcXmJjLKOSmyGUg341UDQAMfSsSF14mGvWkqgawlp8fzTPDGJC6JZz9q9qQY2yjWX21PfUt0VlKwQJSY/Kw3af0BRsHc7g315JIR19geWwkRtebkqx9JrC9G7gxEDSQmRWxTPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300580; c=relaxed/simple;
	bh=qE11Z4ZcayaNexzrrIL10OuU9RI/lELHNPoaqycXFV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEOWTqjCg4EyuWrcVSiuZgknyryWGHiUrJLH8LeYlUwO584YMdJo6jIESz2XyyEcPb3sJmfaYxomtemDmmZ4qTf+ZXnW/lOEr+YHn97LIeSdWzDRvEqKqPVxGj/ygli1QPvr6dnVuXrz5PMa5l58wpmWNns+J9dmoRBQvPMbIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F88uPyGo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F88uPyGo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730300577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IeulUOpuuHlNiK5OU51MVC1gjeBWyqT+QrIDwtRA80w=;
	b=F88uPyGosmkSnV2Xb0/VQP9wu8foMa8n1TtXQpNa6PVo7WvkLxutp1VZUEZH1B22/CVmi/
	KkHf/8LyzFwL56TeBXkXiQsWp0JPmLgM1II9lgXIjbdgv6YnGucBbs7Dnu9RZH0Y96E/+B
	7AH5JY2J4mD9SyXiJFx/uIC4fRRNo3Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-wucivnOFPimaShIdfBBaEw-1; Wed,
 30 Oct 2024 11:02:53 -0400
X-MC-Unique: wucivnOFPimaShIdfBBaEw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61BDE1943CF5;
	Wed, 30 Oct 2024 15:02:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.34])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E264C300018D;
	Wed, 30 Oct 2024 15:02:47 +0000 (UTC)
Date: Wed, 30 Oct 2024 23:02:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 3/5] rbd: convert to blk_mq_freeze_queue_non_owner
Message-ID: <ZyJKklSnnSW9w8Tz@fedora>
References: <20241030124240.230610-1-ming.lei@redhat.com>
 <20241030124240.230610-4-ming.lei@redhat.com>
 <20241030144418.GB32043@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030144418.GB32043@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Oct 30, 2024 at 03:44:18PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 30, 2024 at 08:42:35PM +0800, Ming Lei wrote:
> > rbd just calls blk_mq_freeze_queue() only, and doesn't unfreeze queue in
> > current context, so convert to blk_mq_freeze_queue_non_owner().
> 
> I think the right fix here is to unfreeze after marking the disk
> dead.

Looks fine.


Thanks, 
Ming

