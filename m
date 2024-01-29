Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E934C3CD;
	Mon, 29 Jan 2024 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509032; cv=none; b=dAJ4uji56TKvZ5klD8lstjgl3lfd2g7J+n6QhWCN0SlnirL000uZe5w1uOujX9DPdpR4zct0E1/PbdRjefdxUZkw927pf33JAU9anSVWlOeQvG5spgSoaeZUw9Lnri20Edm1+1Kk7KXkj0fk1sntx5TUzQlkJWXVUI+nZSK2uUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509032; c=relaxed/simple;
	bh=UC/TDx35jrjhL4weQPdctjqBjDeY67/KpTBr75QNiX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tjlw4g0pzaeHS433TYHW+nAfmRS6HGc5BTqXNVgvUqjcqiirqKH2x1i7YlW9Px4Kgh9QrjZ3lw7i8RLCyzEUoCUoFHK+Mq+kmw0ub1ZMuwnFTZe8UEFiTs7/zfGCrfpFCa7bzqCMC+it8PP2dRYEBo/QzWJifgXlyuQ6MDpfaQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC29468B05; Mon, 29 Jan 2024 07:17:07 +0100 (CET)
Date: Mon, 29 Jan 2024 07:17:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 00/34] Open block devices as files
Message-ID: <20240129061707.GC19581@lst.de>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Do you have a git tree for this series? 
