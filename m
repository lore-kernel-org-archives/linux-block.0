Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9072868D
	for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729343377; cv=none; b=cA1y5PC3g/vwS/79sfIGAhvY9r/zEXVPklvzvD3NRPsRkj6tuVXVukXkX4ktt4R1KqiwCIUmRsVl+2jn+p3VMVM2MWqKS0N2RxW8vFQWoZGOqgTZWRjRyeaqP8ilCYHLn04fBAQ4oCSr3J2ENDcz+iSXpNzW/V10jviMyE/WV5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729343377; c=relaxed/simple;
	bh=4wHzKQLTQjiCgy2M5B0fUCCBQmuY5EeGYQhBGWboKPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWi1MlltXskRtL7pSlyLqr/B4kZvBoBZZkEsbTK9iF1eoiDgmnXa5l4BhvmKLHp6I7td6X52yoL+AH2I3TzLwIG656VtZJML9kGur5BP/HYWd0FbeNmEbpyPlgFo1aLvAkSAOeGjePzRqYwtz3ksyZCGoB+T+1pAYkGoAqaEwVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNbLliS4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNbLliS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729343374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SU4ou3NrhAzx5b4iXhmbs5u+Q3qnP+HrPnEn5Qhxk6g=;
	b=RNbLliS4g/zbHW7NH+m+g19S2pYSRHO0zwP1Uk1ls7BAa/32m4fp2/23q3TAhl3ykvXOD9
	2mWW/s197F39Y+iiETUsODqoYkei9aAqRJ/VDHGPiMqNqaGCZbxbyGOXMp/kBYYZ4nRitr
	Sf/N8jFzX6h5IqBf41HKwl+3Q14qmsU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-KPtuVjfTPZODfnQg22m-pA-1; Sat,
 19 Oct 2024 09:09:30 -0400
X-MC-Unique: KPtuVjfTPZODfnQg22m-pA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1B46195608A;
	Sat, 19 Oct 2024 13:09:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7604619560A2;
	Sat, 19 Oct 2024 13:09:23 +0000 (UTC)
Date: Sat, 19 Oct 2024 21:09:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <ZxOvfpI6vgH5oXjg@fedora>
References: <20241009113831.557606-1-hch@lst.de>
 <20241009113831.557606-2-hch@lst.de>
 <Zw_BBgrVAJrxrfpe@fedora>
 <20241019012541.GD1279924@google.com>
 <ZxOmzVLWj0X10_3G@fedora>
 <20241019123727.GE1279924@google.com>
 <ZxOrGeZnI52LcGWF@fedora>
 <20241019125804.GF1279924@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019125804.GF1279924@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Oct 19, 2024 at 09:58:04PM +0900, Sergey Senozhatsky wrote:
> On (24/10/19 20:50), Ming Lei wrote:
> > On Sat, Oct 19, 2024 at 09:37:27PM +0900, Sergey Senozhatsky wrote:
> > > On (24/10/19 20:32), Ming Lei wrote:
> > > [..]
> > > Unfortunately I don't have a device to repro this, but it happens to a
> > > number of our customers (using different peripheral devices, but, as far
> > > as I'm concerned, all running 6.6 kernel).
> > 
> > I can understand the issue on v6.6 because it doesn't have commit
> > 7e04da2dc701 ("block: fix deadlock between sd_remove & sd_release").
> 
> We have that one in 6.6, as far as I can tell
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/block/genhd.c?h=v6.6.57#n663

Then we need to root-cause it first.

If you can reproduce it, please provide dmesg log, and deadlock related
process stack trace log collected via sysrq control.


thanks,
Ming

