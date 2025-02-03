Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1099205AC6
	for <linux-block@vger.kernel.org>; Mon,  3 Feb 2025 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589919; cv=none; b=XAT1r+ZCki0/FqfZIYIm8O6iRHPZbxI5scOr7uRHHizCGv6PbTJPJYD1J3Z/8960gKesvyMvTSl0qBtaqK8znJoyewGeo2NkSv8OYZNgl0jIQj1s+co8pki3QwkBCGQ2GjFJdouGr3vn3jrEiACZPRrxkD9ZVMyRFR2gSpCGICg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589919; c=relaxed/simple;
	bh=JmoSXhZKl18gKkcpKWHbIC7imMHq5vDMBziyeBWL/78=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=g3bPrvSjnK8Mkdnl5ZfUz86wz1G1dzP3FQK5EIl7L5Hi0jarLVwz/apKLUv9AItbxgdOTTYE5OZrkB/W/gkF2EwKXnSIUMQzx7cShyXshsXMzh2l1XspN3KBMzOaaJjVZpJneIfTiNxKxtKYQ9cQAdXTueYg4DAWKP6ZZ+mniCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ebTSSyc7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebTSSyc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738589916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B3hMPCAExxL2lkQIcpTzpMGKzmgm/K+sKSyNYBMLngY=;
	b=ebTSSyc7vW7g+yrX57Zck/W0Uy6DhHBF1l1Yl/9jjFPaZFodsvttjCN9/xLoSDcfOgFJS9
	QsProXvpvovFYt792/eB4rGrAfH0IMRR2c5afrsIkk9V9VN4i6sH5AqqFdfideiSnL6dri
	h+gWBoRzA9nf5btoTSfOY3izNM6yOaA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-prbtqgnIMcWbPMRa9Oek7g-1; Mon,
 03 Feb 2025 08:38:33 -0500
X-MC-Unique: prbtqgnIMcWbPMRa9Oek7g-1
X-Mimecast-MFC-AGG-ID: prbtqgnIMcWbPMRa9Oek7g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9D5D195608A;
	Mon,  3 Feb 2025 13:38:31 +0000 (UTC)
Received: from [10.45.224.44] (unknown [10.45.224.44])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA97D1956094;
	Mon,  3 Feb 2025 13:38:28 +0000 (UTC)
Date: Mon, 3 Feb 2025 14:38:25 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>, 
    Mike Snitzer <snitzer@kernel.org>, Zdenek Kabelac <zkabelac@redhat.com>, 
    Milan Broz <gmazyland@gmail.com>, linux-block@vger.kernel.org, 
    dm-devel@lists.linux.dev
Subject: Re: [PATCH] blk-settings: round down io_opt to at least 4K
In-Reply-To: <Z5CMPdUFNj0SvzpE@infradead.org>
Message-ID: <e53588c8-77f0-5751-ad27-d6a3c4f88634@redhat.com>
References: <81b399f6-55f5-4aa2-0f31-8b4f8a44e6a4@redhat.com> <Z5CMPdUFNj0SvzpE@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On Tue, 21 Jan 2025, Christoph Hellwig wrote:

> On Mon, Jan 20, 2025 at 04:16:26PM +0100, Mikulas Patocka wrote:
> > Some SATA SSDs and most NVMe SSDs report physical block size 512 bytes,
> > but they use 4K remapping table internally and they do slow
> > read-modify-write cycle for requests that are not aligned on 4K boundary.
> > Therefore, io_opt should be aligned on 4K.
> 
> Not really.  I mean it's always smart to not do tiny unaligned I/O
> unless you have to.  So we're not just going to cap an exported value
> to a magic number because of something.

The purpose of this patch is to avoid doing I/O not aligned on 4k 
boundary.

The 512-byte value that some SSDs report is just lie.

> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Fixes: a23634644afc ("block: take io_opt and io_min into account for max_sectors")
> > Fixes: 9c0ba14828d6 ("blk-settings: round down io_opt to physical_block_size")
> 
> Please explain how this actually is a fix.

Some USB-SATA bridges report optimal I/O size 33553920 bytes (that is 
512*65535). If you connect a SATA SSD that reports 512-bytes physical 
sector size to this kind of USB-SATA bridge, the kernel will believe that 
the value 33553920 is valid optimal I/O size and it will attempt to align 
I/O to this boundary - the result will be that most of the I/O will not be 
aligned on 4k, causing performance degradation.

Optimal I/O size 33553920 may also confuse userspace tools (lvm, 
cryptsetup) to align logical volumes on 33553920-byte boundary.

Mikulas

