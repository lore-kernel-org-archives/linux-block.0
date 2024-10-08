Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E43F9FB
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 04:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361213; cv=none; b=bUhuL47eTLsbEYiyzSntPwTQxIYgG9CuZytz3Iy+toAwhg++PR3S6GtK3UzsnSj+/8KNmi4DsPRyOe34vBpW0RuvaPeDDDDH9ZQqxJcvkOiVHbhNLI3HjsrgT/7gRqxVzlR0fkCvjBW91SRy3iUQzsChO/1bYiN4dKSJ2qFcfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361213; c=relaxed/simple;
	bh=D9EX5++oqDB6R+KSLX3lTU9RTFrpuhJCPPuScYDA+pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY4FO1j+RtfK7qUM0FZlYsY0Ia9ABM9stD+JxrR/WIz1z1YH6sA0JGzGdg/Q/Jf2YSogJX6zh/ZeR6I5ZWKZHvvhDbfCe9KIRMruuEEFq4aTq06WmPZA31otrOBU6wuLoxc4oS3cT+A8txoYWMmdfKWuTMrO+dEEp4cs0iQBfd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 02685227A88; Tue,  8 Oct 2024 06:20:06 +0200 (CEST)
Date: Tue, 8 Oct 2024 06:20:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Ming Lei <ming.lei@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
	Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2] block: Fix elv_iosched_local_module handling of
 "none" scheduler
Message-ID: <20241008042005.GA20982@lst.de>
References: <20240917133231.134806-1-dlemoal@kernel.org> <87ed4snq2h.fsf@kernel.org> <ee7bcfc3-ce25-4cdd-95c0-c96585128424@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee7bcfc3-ce25-4cdd-95c0-c96585128424@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 08, 2024 at 07:48:10AM +0900, Damien Le Moal wrote:
> Yes, ->load_module() should return 0 on success and negative error code on
> error. Otherwise, a positive error may be interpreted by user space as a success
> write to the sysfs attribute. Adding a comment for that will be good too.
> 
> Care to send a patch ?

It should not return anything at all as alreaday said last round.
Jens just asked for that to be sent layer, so I guess I'll do it now.

