Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43487263B
	for <linux-block@vger.kernel.org>; Sat, 24 Jan 2026 01:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769216727; cv=none; b=jYLpghsvcJxUqbPM+NTa4egPmobszq7RlIzbNXO0U6tMz9RsVvFSC6ZTa2N/O5kHKTsPj60AxjM3W+Y8y8cPFyljMDNn0gilGvWd8qSExyqdViqt8cFCuOto/uN/Q2Mt5nPsZFEwWnTVd4bHZnY9cHOtQqmhx700wjrNmVGoZoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769216727; c=relaxed/simple;
	bh=FBpBzxHpRotxgyhVKzM4cRSWd1Zr1PykX1UhxtqsxDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXfPxtY1NR5QfAu28s9qzbeSem0Wggdm8ooZDWPj/gcpcn+iTa3nSHB6XPh0i1C+OP68CQUnlFDj67cqFvcRUIAo/dDhCcYJ/cvHs+3h0zZR9X3xKAkewDp+6V+S80ebbI7q/QPGo3LoGhX8S4FIqcp4rNpRj51QCwsQEpNea8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbII4y3y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbII4y3y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769216724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBTkPYq+fbgMdkRaPKujxvUupz8ohw1JAJ/cEkXDT7Q=;
	b=IbII4y3yApR7BColoOQmX/eujrCV6BjPIN6QJypUBVIE5IZkojuctESJqAsjv14Delceww
	RFtCRUGE7J8dWJZDdr2jh36TRcqUTTVTPbUTdJVEA1wWHG4ZnGJrp2oJIDUH3YhOFy0+39
	KrtfZPjsSRUrtue6Rpl+NRtRTZiPQ4A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-swGyZUX5OZC0d7_4auN4FQ-1; Fri,
 23 Jan 2026 20:03:58 -0500
X-MC-Unique: swGyZUX5OZC0d7_4auN4FQ-1
X-Mimecast-MFC-AGG-ID: swGyZUX5OZC0d7_4auN4FQ_1769216637
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDD011956089;
	Sat, 24 Jan 2026 01:03:56 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEA6918004D8;
	Sat, 24 Jan 2026 01:03:52 +0000 (UTC)
Date: Sat, 24 Jan 2026 09:03:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 0/2] ublk: auto buffer helpers rename & document io
 reference
Message-ID: <aXQadDz91PAYliwI@fedora>
References: <20260123135205.2202474-1-ming.lei@redhat.com>
 <176919561293.731063.8947763808975933270.b4-ty@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176919561293.731063.8947763808975933270.b4-ty@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Jan 23, 2026 at 12:13:32PM -0700, Jens Axboe wrote:
> 
> On Fri, 23 Jan 2026 21:51:57 +0800, Ming Lei wrote:
> > The 1st patch improves auto buffer helpers naming, and improve
> > documentation.
> > 
> > The 2nd patch documents ublk io reference counting design, given it isn't
> > very straightforward.
> > 
> > Thanks,
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/2] ublk: rename auto buffer registration helpers
>       commit: f50af896932f5edb1ff7b407753ecfa285c30b7a
> [2/2] ublk: document IO reference counting design
>       commit: 420bcbf67b4575d6455a4fa0de06695d98d340b1

Hi Jens,

I'd address Caleb's comment on the 2nd patch, so can you drop it?

Thanks,
Ming

