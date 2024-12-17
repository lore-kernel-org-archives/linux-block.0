Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B467315D5B6
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419976; cv=none; b=jZil9u+nyZPmH4fDk2+318IF8h/F6D/f8h8HBi1bmHfXxa48K/7L0mt0AXt3934uljXwvrgHEDDDp6mqb1UyANhy+smjpWbKM0vqQqsHcqLTyJzmk5bzWaTGzS0+JB2cEvVF8Y0P8Zwrljj4bo0xFBFprKxOXvm6Zbzi3yJKLWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419976; c=relaxed/simple;
	bh=Dy7IxYeTgY3Xiu2sxDyJnSuWu1xbP6LV48dAnIoBhvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIaaiFXVFzzxBX+Idw7to8OIunu+wDVyIN/en0/A3PL3Ef2HAs7bkebPl8FFvOEhEl8KbekCcbC+ewikCSB/bQrOqRe4ixZgusYGs9bxtbFPyBaBsRJqPgP2qRHKnYTzzNSl4oQypeqBfcR1ShVIz2dEpuo7B2bJlyz+DsZ6o7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1B94D68B05; Tue, 17 Dec 2024 08:19:29 +0100 (CET)
Date: Tue, 17 Dec 2024 08:19:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs
 for atomic update queue limits
Message-ID: <20241217071928.GA19884@lst.de>
References: <20241216080206.2850773-1-ming.lei@redhat.com> <20241216080206.2850773-2-ming.lei@redhat.com> <20241216154901.GA23786@lst.de> <Z2DZc1cVzonHfMIe@fedora> <20241217044056.GA15764@lst.de> <Z2EizLh58zjrGUOw@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2EizLh58zjrGUOw@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 17, 2024 at 03:05:48PM +0800, Ming Lei wrote:
> On Tue, Dec 17, 2024 at 05:40:56AM +0100, Christoph Hellwig wrote:
> > On Tue, Dec 17, 2024 at 09:52:51AM +0800, Ming Lei wrote:
> > > The local copy can be updated in any way with any data, so does another
> > > concurrent update on q->limits really matter?
> > 
> > Yes, because that means one of the updates get lost even if it is
> > for entirely separate fields.
> 
> Right, but the limits are still valid anytime.
> 
> Any suggestion for fixing this deadlock?

What is "this deadlock"?

