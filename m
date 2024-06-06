Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C561BDC8
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 05:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717652350; cv=none; b=ixmgUQhu9en7bVKWsPLAFXWcUCV09mvFo8uODmG46ZJFJOPoH8d1kOwoaxXGJ5+eXM3pp8rb4Bc0MMa7oDNT57WvQNUBhxPVMuaQW1BnKWFhARJbgp2ObSwfTr2XTq+yaWuNcVIESSmIob6jJDxp+HG6YE0Ef4IhchOu3bkW7qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717652350; c=relaxed/simple;
	bh=svjModLVnI1yufrwqFpNUxqrD8dE/7njjysqdrXLSds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9lyHj2s23Do+r/0AKa66Jlq4x/l74cryFXpHCC480aaUVsz6zU6bCAT2so9n/I0K4NDNUPTFmIe9o71Mo0rYLEXunUH6eQqYBJqVh3Ens6YKlGsLGNIi5bLxZ4sO6vWfsS0fRe0uv9vGzPWcpw279cMvElwA5AuNwO/uSwlDak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9DBFC68CFE; Thu,  6 Jun 2024 07:39:04 +0200 (CEST)
Date: Thu, 6 Jun 2024 07:39:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3] nbd: Remove __force casts
Message-ID: <20240606053904.GA9123@lst.de>
References: <20240604221531.327131-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604221531.327131-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 04, 2024 at 04:15:31PM -0600, Bart Van Assche wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Make it again possible for sparse to verify that blk_status_t and Unix
> error codes are used in the proper context by making nbd_send_cmd()
> return a blk_status_t instead of an integer.
> 
> No functionality has been changed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [ bvanassche: added description and made two small formatting changes ]
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

I didn't actually add a signoff before, but feel free to keep it.

