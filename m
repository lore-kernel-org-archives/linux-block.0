Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68668134BC
	for <linux-block@vger.kernel.org>; Tue,  6 Feb 2024 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244294; cv=none; b=iRisSS+5l5aMIiExl94GD699d/iRPtYq2FtYPRKiMqrJLBp5zq5GoP+C4AE2L5ibeG2x8fpLs4VinmLaJ3AHV9Sg5RaNES1lFIoRYGDvVMjiZUgDZjIhyOfJ85+asBTcTEduxuF+u9UWNKpGNGsJdMeQiiJA1eaPQhIHeDPUF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244294; c=relaxed/simple;
	bh=0kjxM+ViB91xXvxqAbIvNHPS5TcW/T7UhB7ZDEeNPy4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TIN/C4R4BTgGgzfn5ewGOGr4G1nRdhDW1t/yoyIjWvZx/W/O2ldDHJPv4mv5YYCqGXqSP1kGKJIOeIYFCl62eZZ2rKCB4qBLfpIAoYhAYs0gG7s22LBjOuJW2vvKiUflPVJRhSFqNQJODwKy79gPPEBYkv+uyPCcco1hEihooYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EO/xiymP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EO/xiymP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707244290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KUSeU1JtmL/usiJfFWD5iHDLyBN+brhWHx1quLDkXuE=;
	b=EO/xiymPEtmhYpl3OU+WKpvlKUjF5R2AUDK1ligZEedv/ZHnFfLg5y/boXT3eRUigCDcJ5
	ER7G4lLAXFV8IcBqSE+yeT3MtbbGz6Vy6AOaEdn+ANHfi4Km0b93NUeufA0lKw+xEOM0ZZ
	nFVYZy1HDlK8pm2DC+SjBm48fwbrl1Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-q8ZLpiskMpO30eOg1VJSLw-1; Tue, 06 Feb 2024 13:31:28 -0500
X-MC-Unique: q8ZLpiskMpO30eOg1VJSLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89C3784C65B;
	Tue,  6 Feb 2024 18:31:27 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CACD2026D06;
	Tue,  6 Feb 2024 18:31:27 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id F104130C1B8F; Tue,  6 Feb 2024 18:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id ED1EF3FFC5;
	Tue,  6 Feb 2024 19:31:26 +0100 (CET)
Date: Tue, 6 Feb 2024 19:31:26 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
    Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
    Mark Wunderlich <mark.wunderlich@intel.com>, 
    "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
    Helge Deller <deller@gmx.de>, John David Anglin <dave.anglin@bell.net>, 
    linux-block@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH] block: use the __packed attribute only on architectures
 where it is efficient
In-Reply-To: <ZcI/o7Ky7dzSLK25@fedora>
Message-ID: <9651b7f-2dc5-efd7-77ca-455b4925f17b@redhat.com>
References: <78172b8-74bc-1177-6ac7-7a7e7a44d18@redhat.com> <ZcI/o7Ky7dzSLK25@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4



On Tue, 6 Feb 2024, Ming Lei wrote:

> On Tue, Feb 06, 2024 at 12:14:14PM +0100, Mikulas Patocka wrote:
> > The __packed macro (expanding to __attribute__((__packed__))) specifies
> > that the structure has an alignment of 1. Therefore, it may be arbitrarily
> > misaligned. On architectures that don't have hardware support for
> > unaligned accesses, gcc generates very inefficient code that accesses the
> > structure fields byte-by-byte and assembles the result using shifts and
> > ors.
> > 
> > For example, on PA-RISC, this function is compiled to 23 instructions with
> > the __packed attribute and only 2 instructions without the __packed
> > attribute.
> 
> Can you share user visible effects in this way? such as IOPS or CPU
> utilization effect when running typical workload on null_blk or NVMe.

The patch reduces total kernel size by 4096 bytes. The parisc machine 
doesn't have PCIe, so I can't test it with NVMe :)

> CPU is supposed to be super fast if the data is in single L1 cacheline,
> but removing '__packed' may introduce one extra L1 cacheline load for
> bio.

Saving the intruction cache is also important. Removing the __packed 
keyword increases the bio structure size by 8 bytes - that is, L1 data 
cache consumption will be increased with the probability 8/64. And it 
reduces L1 instruction cache consumption by 84 bytes - that is one or two 
cachelines.

Mikulas

