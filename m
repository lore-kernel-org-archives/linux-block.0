Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01322657AD
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519094; cv=none; b=o9akITHbZDqZiqJFvBy7tERTjJwILvn2vhoobbIQlKhb8DnLnja5+SrsloPZPc7aQCpArm3+iQ5iQl75cbfkvoLyzvuTlNBQCg5RCxm0Wr4ps/avaX1xuJvnKnz29YNBDDtgMtwqcWL8P1wQ0IRmgvpBwMdH3F7/i2OIhaeUbYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519094; c=relaxed/simple;
	bh=lC9g3Q594KLTMSraEusNcbzPtFT8LRjwkLKSxixf5g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUrAU0PA42B4GZtgl8qwHlXLoZAK12sMu0UE31E6hozum0XfEFoeH9bFqKSRVsVB5VHpdanyo11JKK9OzA+j87xApyTqtWAOcmCOzJ4aBwEQnCAPOHS8p9WGW2NTpjQXbcTrt6p0hBHFxrv6XkEGDQHaoREyD7PfgXRzgBah54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DrX4Ukxz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrX4Ukxz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708519091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WPbgK1mKGt/CTxr4PHDbY6IvHaXSxCJ0p+yLorKnFwo=;
	b=DrX4UkxzJrF9wLq0ob0c04kCkq8A/yHUM+bBoQb/4oqcTtwl2wx0ZyEWaVIwNxLArIRDia
	Du49kBCxq/nc/rkrUyM17dH9Do8+qa0deOlaqWtqK8iyTP187mtHSVM9IjWO1/BxDOsUtH
	9icdDYY/++B7f/8+MBUAM52JcpQjtqQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-akcIl5L1Nn2tV1Vly_oywQ-1; Wed, 21 Feb 2024 07:38:08 -0500
X-MC-Unique: akcIl5L1Nn2tV1Vly_oywQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C6D0185A784;
	Wed, 21 Feb 2024 12:38:07 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 33C721121306;
	Wed, 21 Feb 2024 12:38:07 +0000 (UTC)
Date: Wed, 21 Feb 2024 07:39:49 -0500
From: Brian Foster <bfoster@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, Tony Asleson <tasleson@redhat.com>,
	linux-bcachefs@vger.kernel.org, linux-block@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: kernel oops on bcachefs umount, 6.7 kernel
Message-ID: <ZdXvFT+Rl439kUMo@bfoster>
References: <CAPmdA5YK_RuKpAtnfFrfcgZZReR2p1Q+A_DOMnFFrYm1QvrYnQ@mail.gmail.com>
 <Zc5CH7rzhzbrLzyV@bfoster>
 <6ozksyyljs4hzwcbitk3pqu3pbqttai42hbghwwww2rgdbnxzy@iz3cqxjgkfmn>
 <20240216080017.GA11646@lst.de>
 <Zc9XwqqDk/NC2j4b@bfoster>
 <iv32eaej2g7fgkaaq4ghe7ekt52degs43vecwdsd56gvzwteyr@hhdjqokbki4o>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iv32eaej2g7fgkaaq4ghe7ekt52degs43vecwdsd56gvzwteyr@hhdjqokbki4o>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Fri, Feb 16, 2024 at 10:57:24AM -0500, Kent Overstreet wrote:
> On Fri, Feb 16, 2024 at 07:40:34AM -0500, Brian Foster wrote:
> > On Fri, Feb 16, 2024 at 09:00:17AM +0100, Christoph Hellwig wrote:
> > > On Thu, Feb 15, 2024 at 07:24:23PM -0500, Kent Overstreet wrote:
> > > > > It looks like the warning could be avoided in bcachefs by checking for
> > > > > whether the parent dir/node still exists at cleanup time, but I'm not
> > > > > familiar enough with kobj management to say whether that's the
> > > > > right/best solution. It also looks a little odd to me to see a
> > > > > /sys/block/<dev>/bcachefs dir when I've not seen any other fs or driver
> > > > > do such a thing in the block sysfs dir(s).
> > > > > 
> > > > > Any thoughts on this from the block subsystem folks? Is it reasonable to
> > > > > leave this link around and just fix the removal check, or is another
> > > > > behavior preferred? Thanks.
> > > 
> > > This is the general problem with random cross-subsystem sysfs reference,
> > > and why they are best avoided.  The block layer tears down all the sysfs
> > > objects at del_gendisk time as no one should start using the sysfs files
> > > at that point, but a mounted file system or other opener will of course
> > > keep the bdev itself alive.
> > > 
> > 
> > Yeah, makes sense. The fact that the dir goes away despite having the
> > bdev open is partly what made this seem a little odd to me.
> > 
> > > I'm not sure why bcachefs is doing this, but no one really should be
> > > using the block layer sysfs structures and pointers except for the block
> > > layer itself.  
> > > 
> > 
> > From Kent's comments it sounds like it was just some loose carryover
> > from old bcache stuff. I had poked around a bit for anything similar and
> > it looked to me that current bcache doesn't do this either, but I could
> > have missed something.
> > 
> > > > so there's an existing bd_holder mechanism that e.g. device mapper uses
> > > > for links between block devices. I think the "this block device is going
> > > > away" code knows how to clean those up.
> > > > 
> > > > We're not using that mechanism - and perhaps we should have been, I'd
> > > > need a time machine to ask myself why I did it that way 15 years back.
> > > 
> > > Well, at least Tejun had a very strong opinion that no one should be
> > > abusing sysfs symlinks for linking up subsystems at all, see commit
> > > 49731baa41df404c2c3f44555869ab387363af43, which is also why this code
> > > is marked deprecated and we've not added additional users.
> > > 
> > 
> > Thanks. I'll send a patch to remove this once I'm back from vacation.
> 
> No, we can't remove it - userspace needs to know this topology. When
> we've got one sysfs node with a direct relationship to another sysfs
> node, that needs to be reflected in syfs.
> 

Do you mean that some related userspace tool relies on this to function,
or generally disagreeing with the statement(s) above around links from
/sys/block/<dev>/?

Brian

> What I'm hoping for is that we can get filesystems in general to do this
> right, not just bcachefs, so that they finally start showing up in the
> tree lsblk reports.
> 

