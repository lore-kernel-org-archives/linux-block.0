Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620712FF76
	for <linux-block@vger.kernel.org>; Tue,  6 Feb 2024 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229109; cv=none; b=HSi/jZgm/+B4421qYrE03KqMW086AxE0zHfv8PB8UN3dhsIOd4H0cCMBDV6Yqdlss3zluNlcdH4GEds22WcCZdmHoqIiQbsc2AttecX5yLbXhLaz3QnKIb82H0CyP/OQM7fWLowKaRKt7FTeOh0nMT8pceYGqEeMX+nH99WEG0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229109; c=relaxed/simple;
	bh=i5hWfBzBGWc6JdgTIVVmoC1HBlo5T2lXEZwAIrxu52A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMOB9DINhlXiMRSoNofY+KIIlv+aJ2Eo/Tak7pU04lLQrPoqhbOdc7hjZHBq3YX1bi3EjMbO0whuFmEOsieMpWU5CsW3OCg24sWP9GfXvS4M/IU0eFZKC8pJT4Gflo+G/XSiyRWxoo7ZUG/sMSKsQ3Guvm2iHXIO7NEES9BLzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0UuAm6n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0UuAm6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707229104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0v440p7K82Ojm3b41LiM1FvwX6/X0UnVpBN+B8mNJg=;
	b=Y0UuAm6nTnQjF74PVJr0yy0119u02kp0Ri0E5dCIavA+0kdEH+oz58nuKTX+xD+E8IrMlB
	C4v/N5e/PusPL5ROH5tZ295h0F9kMW5YZ8gHZ/quC4ECUeJXJJT/Esfq/+jolTU0JA3BcN
	Azy4gInoRqMBpmcY/4MZCi/ng82HNwM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-NuFWjUBlPu-iyMh6hDECAw-1; Tue,
 06 Feb 2024 09:18:21 -0500
X-MC-Unique: NuFWjUBlPu-iyMh6hDECAw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD99A2815E27;
	Tue,  6 Feb 2024 14:18:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A163D492BC7;
	Tue,  6 Feb 2024 14:18:15 +0000 (UTC)
Date: Tue, 6 Feb 2024 22:18:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Mark Wunderlich <mark.wunderlich@intel.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	John David Anglin <dave.anglin@bell.net>,
	linux-block@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH] block: use the __packed attribute only on architectures
 where it is efficient
Message-ID: <ZcI/o7Ky7dzSLK25@fedora>
References: <78172b8-74bc-1177-6ac7-7a7e7a44d18@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78172b8-74bc-1177-6ac7-7a7e7a44d18@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Tue, Feb 06, 2024 at 12:14:14PM +0100, Mikulas Patocka wrote:
> The __packed macro (expanding to __attribute__((__packed__))) specifies
> that the structure has an alignment of 1. Therefore, it may be arbitrarily
> misaligned. On architectures that don't have hardware support for
> unaligned accesses, gcc generates very inefficient code that accesses the
> structure fields byte-by-byte and assembles the result using shifts and
> ors.
> 
> For example, on PA-RISC, this function is compiled to 23 instructions with
> the __packed attribute and only 2 instructions without the __packed
> attribute.

Can you share user visible effects in this way? such as IOPS or CPU
utilization effect when running typical workload on null_blk or NVMe.

CPU is supposed to be super fast if the data is in single L1 cacheline,
but removing '__packed' may introduce one extra L1 cacheline load for
bio.


thanks,
Ming

