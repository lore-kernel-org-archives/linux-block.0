Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EBF29DB65
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489797; cv=none; b=WLax0lCHXTgLWvwamiMJPFBLMdaHFlVr15mvPxBfkkCAaJTr6ox/uXMG2YXobZ7Talr5Ot9kBH6fGierS0VptAO/g5MjCYeZlNuru2iUNE0fDMQzx7im+rKc3rYtxWOhNwE5QdrGh0FaYiB+r/KMkLDuOC1Sg12pGYmANmvHt9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489797; c=relaxed/simple;
	bh=ZXkQ3kPe7AT5UT2l2UWSViuerymT1NythTEpwa8wHAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXRShrRDXxjwGBJ9ERUEVQRn51P10VD2QhB/VeeoZ4G7EQs95sMGWvVt6qvL12ySea7o+V1ss+A3fQRBl3/bXPApj7xyZ2aYGqkoRRwVO+Itq07/QnWpKhVPT1krHLhHRjgweOyOWnzKgn9PjMU9JpDnCo9cFUVdeJOpdqLKyKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJg7LSBD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJg7LSBD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iNv0pqSHRfXuYShbyhGgq8zNuj162daZJfAUfy98etc=;
	b=CJg7LSBDNq2ItNOJU0sDd0bdziKt2SUparhnqtzJ95y8j6DOLCeDueAJwpDO/2aEGdfJgN
	msdcyDgXAm/KCvlJdtY+Uep2DPCf4htHghMJe6b1Bz8mLvKSQtcmykuDaXDMItYu1qrDBl
	8yMZjia8+x4b7ytH0Pj4lJ1n7RLmtb8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-KnqTUGjFOuaMYKkdq5qUGA-1; Tue,
 18 Nov 2025 13:16:29 -0500
X-MC-Unique: KnqTUGjFOuaMYKkdq5qUGA-1
X-Mimecast-MFC-AGG-ID: KnqTUGjFOuaMYKkdq5qUGA_1763489787
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A1431800250;
	Tue, 18 Nov 2025 18:16:26 +0000 (UTC)
Received: from localhost (unknown [10.44.32.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAB87195419F;
	Tue, 18 Nov 2025 18:16:24 +0000 (UTC)
Date: Tue, 18 Nov 2025 18:16:23 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Eric Dumazet <edumazet@google.com>, Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>,
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com,
	Mike Christie <mchristi@redhat.com>,
	Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
Message-ID: <20251118181623.GK1427@redhat.com>
References: <20250909132243.1327024-1-edumazet@google.com>
 <aRyzUc/WndKJBAz0@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRyzUc/WndKJBAz0@duo.ucw.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Nov 18, 2025 at 06:56:33PM +0100, Pavel Machek wrote:
> Hi!
> 
> > Recently, syzbot started to abuse NBD with all kinds of sockets.
> > 
> > Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
> > made sure the socket supported a shutdown() method.
> > 
> > Explicitely accept TCP and UNIX stream sockets.
> 
> Note that running nbd server and client on same machine is not safe in
> read-write mode. It may deadlock under low memory conditions.
> 
> Thus I'm not sure if we should accept UNIX sockets.

Both nbd-client and nbdkit have modes where they can mlock themselves
into RAM.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

