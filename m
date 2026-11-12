Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514050;
	b=potDoxcwnswFTHoztNEyc8yQylKyZJ+vrYmygYV5w+ERXmB2euEW9q/J+Zezc6CjFfmf
	 pREMzPXplK/O+dcNlVJNIH8CkyICIpjxWSQR5xECMw53aCP6AEuTMQ8GrRT8ISXBAtxpu
	 +yH+UWMm9+ZdhfpC5a9KwofnQrVB3oEbvJN83I10lGNNycMGN9zDFoFKmkls8jrYNL8/V
	 24PMb6GLR61Ul+ct6Wp5WhojLgqGF/nlFPo/mrVX1lbr44v1LiWFlNz54cTziHZSNzRjQ
	 4KZ60O9+Dw6iEwmwZl+8fiZRTK+taIiIFlCAert3HFzicnTow62prfcks5WMjEzvT4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514050;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=vnkYRJDeOO+OAFyuayyOJPGaMExrjFe9lq1WMD+1AoBWeBuTPsD1J0zq/0FISZHSFprW
	 KFNrKzlnYdWb6mhSd6BVi3ftCd195B+ocyvdAM4i99N72gD4hbEfdEwuVjrPlQScdyPM5
	 WwIvL5ufQrVJbwe8brb9wkUADuV9RXm3/mDiU130V150N1Cu0Y2pWLpfCsdJHVC68rGlJ
	 kGzVS2Iz3y3ZBMw3sn26/xXbaa5utjTS+cHB/7GPZ/RG2ABg6/gJtf5ToizcPdCHUHAfZ
	 jxOCwmvZdLzJu9EE4uQV47SB5rI0BzS1uEvEW66/Yk+fRpPd8H6dXHCNUlEAfz1ndOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCC8606A31C;
	Thu, 12 Nov 2026 20:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CCC8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9909E6732A; Thu, 12 Nov 2026 21:07:24 +0100 (CET)
Date: Thu, 12 Nov 2026 21:07:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	John Garry <john.garry@linux.dev>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bdev: do not report a statx block size below the block
 size
Message-ID: <20261112200724.GA10274@lst.de>
References: <20261112174805.1200379-1-hengyul@cs.unc.edu>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112174805.1200379-1-hengyul@cs.unc.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

