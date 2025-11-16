Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392BEEC0
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763294601; cv=none; b=XMLq7TnzPIXB68bvxOWztZx1yIj7JecvgKpaxWJOA5/cFrdpVEaJ5Lk5Er8lh+ksu5XCrl758We2qvDIH8Ir2G5VzFpmVyPZENPZ4xdpXl5O83YXQ0tKltaAbzaBjCbXU/blnDpQbxXYU9EsHfFpwPOluTJVi3t+S3qPeOjJw6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763294601; c=relaxed/simple;
	bh=Hqr0LHCh9sw8xt3V5cPAiUfTXu/LViPzFR85c+7Y7/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzoQtWymxrKVclfAU7tP8SHl93/BFp4rL60d9e3k786GqwU0/ZlVsb1LRNkzGDFndLNQajiV7UN2yc2miwEFOHL+mADVmzA/7KUeEzCRadRqkJuLHKBQLfkkhzcd8mTuiTbO/pCW3meZwkvhFPMbf8c+AnobW8kyODpVsILlFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dz2Ym+tY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dz2Ym+tY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763294599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpus5/F5uCwbEvkteEztV2jVnSupDBdogvnGw/1ePxk=;
	b=Dz2Ym+tYgzpDWgFBqlvQmcphhhvwBL2Z1N0S+11alfb5nQVDx0lUG5CzBjoUUHBfoDM8wu
	J2rf9mydS8EmJh4OmloQi+aOjYebd9qdF57GwBd1F2bJFS60JvaRjpaa+bbXwH0L2ve1J1
	xMQ0YO/lWMBfALb2P8U0QnwQsdP4lOw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-M9cR7BuONc6p2zRRTFjJXQ-1; Sun,
 16 Nov 2025 07:03:17 -0500
X-MC-Unique: M9cR7BuONc6p2zRRTFjJXQ-1
X-Mimecast-MFC-AGG-ID: M9cR7BuONc6p2zRRTFjJXQ_1763294597
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B29D1956088;
	Sun, 16 Nov 2025 12:03:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.55])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5E8B3002D07;
	Sun, 16 Nov 2025 12:03:08 +0000 (UTC)
Date: Sun, 16 Nov 2025 20:02:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V3 08/27] ublk: prepare for not tracking task context for
 command batch
Message-ID: <aRm9cWlATHMl1Pb8@fedora>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
 <20251112093808.2134129-9-ming.lei@redhat.com>
 <CADUfDZoPLwNuxcBLbfLo-JF28Y1df6QL34PrHq8ijOKUw2jt+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoPLwNuxcBLbfLo-JF28Y1df6QL34PrHq8ijOKUw2jt+w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Nov 14, 2025 at 09:25:04PM -0800, Caleb Sander Mateos wrote:
> On Wed, Nov 12, 2025 at 1:39 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > batch io is designed to be independent of task context, and we will not
> > track task context for batch io feature.
> >
> > So warn on non-batch-io code paths.
> 
> I don't see any warning? Remove this sentence from the commit description?

Yeah, will remove it in next version.

> Other than that,
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>



Thanks,
Ming

