Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6002236E5
	for <linux-block@vger.kernel.org>; Mon, 10 Feb 2025 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739192054; cv=none; b=M6fqap8jUKaskR4DJ0OYJ+QxAWZXF1GlOpi8WTWm5dg6n2qjX+U5bwHgvYhpyr9khikv1kRJQySrL+udGb6fGfrDlPCkSSvBv1rNLwnpinxUssiGiAWfbimmCCb3I7A9KG6dpNWGKlEr5ORyr09bVefzP1my2Y28Bdm3ydyT1vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739192054; c=relaxed/simple;
	bh=QGqalAQ1rnunlXro3KoB8sBbpOQlfMZWddKxwHfcwsQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aBaVOk2g/1dHoMcgG0X+jVVIxE2bV75Sk+zttTTOuITL1UXQilLOpPuYAPluUxZApDIjmI/O9VHrePfnHsBFZAKFpOaCq1H/mH30p3FoAbPw2GDxG7ZnuS9OUYDhJErdcRGVk5z+fhFzOKlC6Yytk6nzs9bjo0petXIeVG3SJRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMsgKyq8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMsgKyq8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739192052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YxRVDQx0KBoUs8EflhssFSPDwR4Afm5j1VwyYYrfOfs=;
	b=GMsgKyq8DHzOcYjfpZ1xS/meoesks260Wz+HXZoSlFC/1n5XC5Ll2+W7Leka/g7iZ+p/ph
	LJeS6oPFrw4WRoMPk6QXk6pN/MUwfYbdbZ3GQpy6w1/k3nJPMa3X/WpryeXTfrzrLNHKWu
	ej6Y9POJJGvVYHEn1InDw9Q25ibkfO0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-Zrrmm6oYP1ivFem4Io8wlw-1; Mon,
 10 Feb 2025 07:54:07 -0500
X-MC-Unique: Zrrmm6oYP1ivFem4Io8wlw-1
X-Mimecast-MFC-AGG-ID: Zrrmm6oYP1ivFem4Io8wlw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B5681800876;
	Mon, 10 Feb 2025 12:54:06 +0000 (UTC)
Received: from [10.45.225.131] (unknown [10.45.225.131])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83F46195608D;
	Mon, 10 Feb 2025 12:54:03 +0000 (UTC)
Date: Mon, 10 Feb 2025 13:54:00 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Zdenek Kabelac <zkabelac@redhat.com>, Milan Broz <gmazyland@gmail.com>, 
    linux-block@vger.kernel.org, dm-devel@lists.linux.dev
Subject: Re: [PATCH] blk-settings: round down io_opt to at least 4K
In-Reply-To: <yq1cyfxdsmz.fsf@ca-mkp.ca.oracle.com>
Message-ID: <52b66f23-d8c8-1344-6fd0-277dfa31ce84@redhat.com>
References: <81b399f6-55f5-4aa2-0f31-8b4f8a44e6a4@redhat.com> <Z5CMPdUFNj0SvzpE@infradead.org> <e53588c8-77f0-5751-ad27-d6a3c4f88634@redhat.com> <yq1cyfykgng.fsf@ca-mkp.ca.oracle.com> <28dcf41a-db7d-f8e7-d6b7-acef325c758c@redhat.com> <yq1bjviflwb.fsf@ca-mkp.ca.oracle.com>
 <00717ba6-0ce9-5ccd-d93d-ce5db89d85ff@redhat.com> <yq1cyfxdsmz.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On Tue, 4 Feb 2025, Martin K. Petersen wrote:

> 
> Mikulas,
> 
> > If there is some particular SSD that has more write IOPS for 8k requests 
> > than for 4k requests, I'd like to know about it - out of curiosity.
> 
> SSD blocks are getting bigger and bigger, some drives hide it better
> than others. Also look at all the efforts going on wrt. supporting
> larger block sizes in the kernel.
> 
> Can you send me the output of:
> 
> # sg_vpd -p bl /dev/sdN
> 
> and maybe hdparm -I too? I'd like to see if we can come up with a
> reasonable heuristic.
> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering

I don't have that USB-SATA bridge that reports optimal I/O size 65535 
sectors. Milan talked about it, but maybe he doesn't have it too. Some 
user reported that cryptsetup behaves badly with this particular bridge, 
so Milan wrote workaround for it in cryptsetup.

You can simulate it with "modprobe scsi_debug dev_size_mb=32 
sector_size=512 num_tgts=1 opt_blks=65535"

Mikulas

