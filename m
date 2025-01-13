Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B0233159
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760526; cv=none; b=gZk5w5UAsQsmsJWrm+lt1rCklwXQUDqCXRdmkJAJ4Ixg0uXRAttrWtwi1TdFTKM31Vkxui3WgfPUuxpGXCC0nfnEkjXT9isjOac8Ahntyk+MKEyQyT8uYevon0bzRJ3YTmY2x1c1L10Z2bPyprms1tZxJJy+iqLvEdja940/RdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760526; c=relaxed/simple;
	bh=QZdBMPM5gE7A4xcm4/E0u3Ds8TUZV9SKMYXnkMLJw44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVNz0HuKjd1b1prNG2MAo3QUgeXqteTWCXY/9sUG3JqPL/9Z5kNq8o4J01yOnMkluchYN7KcU7dDNbMgwEYC72U2tvmUAtqqa7huwUyahy5V7lw5jyowgHTSJnEvttK3P73uc7Lyi91WRkRJ8AH5OQn7+ldz9kUvUfpcgE2vG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K82CtdQJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K82CtdQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736760523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYAUwXWXxT0+yArqrVVNOzN2etcn6eMyuQ5mwPl+MMQ=;
	b=K82CtdQJz5ViQ+7pmLIkOs5KYy5/eeZC2KYko0AKw/Xq+4ENCjCOYPyC02CIT9c7S6I5UO
	IlIpFuQfT+N9AxzyRjr34VAZ+DEk/weAOGK9x8n7Vc/LVRRFmoh/gsDoA4KWVaFXXRET5a
	HkPRH8NBPNE6fNW/jxQYkp3vOIeE+7c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-QK2CxJMpMIWNjSJlJqCgmA-1; Mon,
 13 Jan 2025 04:28:38 -0500
X-MC-Unique: QK2CxJMpMIWNjSJlJqCgmA-1
X-Mimecast-MFC-AGG-ID: QK2CxJMpMIWNjSJlJqCgmA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62A991956050;
	Mon, 13 Jan 2025 09:28:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 064131956056;
	Mon, 13 Jan 2025 09:28:33 +0000 (UTC)
Date: Mon, 13 Jan 2025 17:28:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org
Subject: Re: Blockdev 6.13-rc lockdep splat regressions
Message-ID: <Z4TcvNCBXcLJV3vs@fedora>
References: <65a8ef7321bf905ab27c383395016fe299f6dfd9.camel@linux.intel.com>
 <Z4EO6YMM__e6nLNr@fedora>
 <7017f6bf8df5bbd8824f9f69e627c3f33b9aa7cd.camel@linux.intel.com>
 <Z4HgDJjMRv4s5phx@fedora>
 <ead7c5ce5138912c1f3179d62370b84a64014a38.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ead7c5ce5138912c1f3179d62370b84a64014a38.camel@linux.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sun, Jan 12, 2025 at 12:33:13PM +0100, Thomas Hellström wrote:
> On Sat, 2025-01-11 at 11:05 +0800, Ming Lei wrote:
> > On Fri, Jan 10, 2025 at 03:36:44PM +0100, Thomas Hellström wrote:
> > > On Fri, 2025-01-10 at 20:13 +0800, Ming Lei wrote:
> > > > On Fri, Jan 10, 2025 at 11:12:58AM +0100, Thomas Hellström wrote:
> > > > > Ming, Others
> > > > > 
> 
> #2:
> [    5.595482] ======================================================
> [    5.596353] WARNING: possible circular locking dependency detected
> [    5.597231] 6.13.0-rc6+ #122 Tainted: G     U            
> [    5.598182] ------------------------------------------------------
> [    5.599149] (udev-worker)/867 is trying to acquire lock:
> [    5.600075] ffff9211c02f7948 (&root->kernfs_rwsem){++++}-{4:4}, at:
> kernfs_remove+0x31/0x50
> [    5.600987] 
>                but task is already holding lock:
> [    5.603025] ffff9211e86f41a0 (&q->q_usage_counter(io)#3){++++}-
> {0:0}, at: blk_mq_freeze_queue+0x12/0x20
> [    5.603033] 
>                which lock already depends on the new lock.
> 
> [    5.603034] 
>                the existing dependency chain (in reverse order) is:
> [    5.603035] 
>                -> #2 (&q->q_usage_counter(io)#3){++++}-{0:0}:
> [    5.603038]        blk_alloc_queue+0x319/0x350
> [    5.603041]        blk_mq_alloc_queue+0x63/0xd0

The above one is solved in for-6.14/block of block tree:

	block: track queue dying state automatically for modeling queue freeze lockdep

q->q_usage_counter(io) is killed because disk isn't up yet.

If you apply the noio patch against for-6.1/block, the two splats should
have disappeared. If not, please post lockdep log.

Thanks,
Ming

