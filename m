Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB13E2D249E
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428640; cv=none; b=g5sIta5g6rrB46X/wpFkndTcK281Upuxiy3k7kVolUuQ4yr2XMBkjYf8/EvQPZz1QSYlqZfSGDzzGJeqosFqbkf2vNrZlrod7AhFB1OweXp07CL2l2TZ1hqtrUHG1/l8NK4TbN3TjD/W2TSFxY5U93+QAkp7pIXMxR+mDBOE89Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428640; c=relaxed/simple;
	bh=qji7ndBGGf1F0cddUdpok5dBFQOGDW0OUwxCJi94E2s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tFIOswR1ZfL5vx/NRm7ZE6+qs5nEd53FvdR1/rBbFEcmMG8smsm7rAOyZwTMU1LCHSsw2c5ILenBOE6xNxaUGlBkdCXkvhX/Ql5QjLUiFRq5OLMJaLs1O2SzJsUIFT0b7kNX6YnRF4kG1GmnQTtISUnYQ+yAV8mFjtCYzI0fceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eR9ss5Cy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eR9ss5Cy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757428637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OgPu/DKnX2K31+MoLiSGUSH5PiwbvH1FPLjG+9pe2/Q=;
	b=eR9ss5CyxG/nYtEQ1W/tG04wr8Ix1TSq5uEE6NKb06RFHhSF/nPcDVP5l87PbXdJlunuDY
	Xt74t16RXyDEW3AKjdbzbz3XRrek6fVVGW63HYwUXOJBkn6IZwmD9roJAHaNziXO20zoaP
	r4dzvj/wAsX97NWxaofNAHDVybk+m8A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-g66fT2hGNAGRUk42xgT7SQ-1; Tue,
 09 Sep 2025 10:37:16 -0400
X-MC-Unique: g66fT2hGNAGRUk42xgT7SQ-1
X-Mimecast-MFC-AGG-ID: g66fT2hGNAGRUk42xgT7SQ_1757428635
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 180E61955F3D;
	Tue,  9 Sep 2025 14:37:15 +0000 (UTC)
Received: from [10.44.32.12] (unknown [10.44.32.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AF4E18003FC;
	Tue,  9 Sep 2025 14:37:13 +0000 (UTC)
Date: Tue, 9 Sep 2025 16:37:09 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Robert Beckett <bob.beckett@collabora.com>
cc: dm-devel <dm-devel@lists.linux.dev>, 
    linux-block <linux-block@vger.kernel.org>, kernel <kernel@collabora.com>
Subject: Re: deadlock when swapping to encrypted swapfile
In-Reply-To: <1992a9545eb.1ec14bf0659281.6434647558731823661@collabora.com>
Message-ID: <2d517844-b7bf-3930-e811-e073ec347d4a@redhat.com>
References: <1992a9545eb.1ec14bf0659281.6434647558731823661@collabora.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On Mon, 8 Sep 2025, Robert Beckett wrote:

> Hi,
> 
> While testing resiliency of encrypted swap using dmcrypt we encounter easily reproducible deadlocks.
> The setup is a simple 1GB encrypted swap file [1] with a little mem chewer program [2] to consume all ram.
> 
> [1] Swap file setup
> ```
> $ swapoff /home/swapfile
> $ echo 'swap /home/swapfile /dev/urandom swap,cipher=aes-cbc-essiv:sha256,size=256' >> /etc/crypttab
> $ systemctl daemon-reload
> $ systemctl start systemd-cryptsetup@swap.service
> $ swapon /dev/mapper/swap
> ```

I have tried to swap on encrypted block device and it worked for me.

I've just realized that you are swapping to a file with the loopback 
driver on the top of it and with the dm-crypt device on the top of the 
loopback device.

This can't work in principle - the problem is that the filesystem needs to 
allocate memory when you write to it, so it deadlocks when the machine 
runs out of memory and needs to write back some pages. There is no easy 
fix - fixing this would require major rewrite of the VFS layer.

When you swap to a file directly, the kernel bypasses the filesystem, so 
it should work - but when you put encryption on the top of a file, there 
is no way how to bypass the filesystem.

So, I suggest to create a partition or a logical volume for swap and put 
dm-crypt on the top of it.

Mikulas

