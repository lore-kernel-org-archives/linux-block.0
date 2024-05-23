Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2454F17583
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479334; cv=none; b=oCQbCjG8ht5i9dcfrxRTOBfNtB0j7YX/dYB3wPu1srbHaGempWHWSob+seByAXWLtCtwsjqf0pNqV0Jmw92ROrzWUV+/VVZdnlutt019b3Cs1wdzn1WkCrvD28eMrFzAtN6p3CDytHUBdy0XNvbDvuz+w9EY7fvmUTpzMvkSfz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479334; c=relaxed/simple;
	bh=jC0aG3EkzcKZdjr+fP2C64RYCMwKnxXtn8lfl+S1K9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mh9vMFdQgE1ql65SD3Xi5ZFbx/HKqA6YXRz2LTieOIg5rviN1ccGz8wIHLOMmpmalndcGlJ7SPqCGwYYYElQNOitlzAVTw8+YMwDDrnbi+eaX28h3TyYX0kQsy9wyS9w4L+cGDh3sBGkgZ5tva+bHA8pKJIVd5A4RLRCi1wy8Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-803156ef0bfso668374241.2
        for <linux-block@vger.kernel.org>; Thu, 23 May 2024 08:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479332; x=1717084132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5+s+v+Kaz3Sa2swWlssFa+au8LNzsklBiXuB2DuE8Y=;
        b=TZAxZst0ivI7MClSHd+UsdnqTM2WPcJTHWW9h/ltnp25nbxf4KRehbVZO71ezeEjLO
         aOuBBEImuF0fZ/ylQFLmQ4lMcQKB8e8JdJir4xwcOkmFhRXmA8FPLIrhNLvcfY9D65PB
         oQO3SNoxN5BPu6Dz2qOT2A5QBZq+kJE4qlXmcpRbZkdE21GSe7c49HGVfEgUDXSamZCb
         YYm6FoRqyKe29DmQ4XMZnltWuapoBFihDc67Ph3hOcQNhstD5k0APumvGtsi7/alZqmU
         hY+mf4EflTt0/eW6bmihWQigRIh8Up+jc/BmuFWg4LBuWP5XH6Mm6ih78BMu7Ug2aLwF
         FKbg==
X-Forwarded-Encrypted: i=1; AJvYcCWUsWGECWqYrLmhln8bDaWTldI6m1d6PscDU7B6zZkJ4UkovLsgIrXFXQ6YJIWyDgr4GHalInOnXvYaxVHv0wb5k3g3n+CGbnAUkv4=
X-Gm-Message-State: AOJu0Yz+KleBJAPl3wAIUw5K3PfJ+ORMqZq/IHKbkShfs4EMA9j7G8F3
	UQ+TiQOWcoX6FavGjw7KNkjfgcI+cy4LXXeMBkskiWp31HTlDYEKKajcrT87bh0=
X-Google-Smtp-Source: AGHT+IFnQTuSDpB+iXcIQzp9C6VddK7XK5I10n5kKiU1npfJRVtTmmVFoX2dLZUvEHgiCelrQmnMHg==
X-Received: by 2002:a05:6122:1684:b0:4da:9aa1:dd5e with SMTP id 71dfb90a1353d-4e2185b2452mr5729898e0c.10.1716479332059;
        Thu, 23 May 2024 08:48:52 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab84cd6d93sm15947186d6.127.2024.05.23.08.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:48:51 -0700 (PDT)
Date: Thu, 23 May 2024 11:48:50 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Marco Patalano <mpatalan@redhat.com>,
	Ewan Milne <emilne@redhat.com>, linux-raid@vger.kernel.org
Subject: Re: [PATCH for-6.10-rc1] block: fix blk_validate_limits() to
 properly handle stacked devices
Message-ID: <Zk9lYpthswuegMhn@kernel.org>
References: <20240522025117.75568-1-snitzer@kernel.org>
 <20240522142458.GB7502@lst.de>
 <Zk4h-6f2M0XmraJV@kernel.org>
 <Zk6haNVa5JXxlOf1@fedora>
 <Zk9i7V2GRoHxBPRu@kernel.org>
 <20240523154435.GA1783@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523154435.GA1783@lst.de>

On Thu, May 23, 2024 at 05:44:35PM +0200, Christoph Hellwig wrote:
> On Thu, May 23, 2024 at 11:38:21AM -0400, Mike Snitzer wrote:
> > Sure, we could elevate it to blk_validate_limits (and callers) but
> > adding a 'stacking' parameter is more intrusive on an API level.
> > 
> > Best to just update blk_set_stacking_limits() to set a new 'stacking'
> > flag in struct queue_limits, and update blk_stack_limits() to stack
> > that flag up.
> > 
> > I've verified this commit to work and have staged it in linux-next via
> > linux-dm.git's 'for-next', see:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=for-next&id=cedc03d697ff255dd5b600146521434e2e921815
> > 
> > Jens (and obviously: Christoph, Ming and others), I'm happy to send
> > this to Linus tomorrow morning if you could please provide your
> > Reviewed-by or Acked-by.  I'd prefer to keep the intermediate DM fix
> > just to "show the work and testing".
> 
> A stacking flag in the limits is fundamentally wrong, please don't
> do this.

Um, how so?  It serves as a hint to how the limits were constructed.

Reality is, we have stacking block devices that regularly are _not_
accounted for when people make changes to block core queue_limits
code.  That is a serious problem.

Happy to see the need for the 'stacking' flag to go away in time but I
fail to see why it is "fundamentally wrong".

Mike
