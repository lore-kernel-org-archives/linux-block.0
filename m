Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75450381C4
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 06:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768458377; cv=none; b=JkNkb2Lk4d9AI8t2i6Kh9r9G3CesFNy6ZCcc6L0KbbV9ICb9trXuGzItAHXEkw76jjpPW1zFXMQYRwC7YfHb0HdHMj48TxNbG2gdIu8ClG2mvY6Oe/RCaWEKHs3yE71W50i6utsxWDdU2zkEEXp6tWSNG0W6kkLsLiNM0xscz40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768458377; c=relaxed/simple;
	bh=686tOCsbPJkCySgghQw6eP1wDKYNjzOCVd08P5J0xX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rral0CSzzzPJdsvyRfaYwPLWwtzTveU9ohqq1f5dhI3ZigVXQgAjVxNpX+p1C+XDHStfPuJlMxZSQcwe3VyDJEKYzZho6XfUrGo3SQzPZ4uSPcKjeUGjRN2bVKtKY1VRGTF14RyEeXLI8r8YUC/rYqYIpsHwLovusCP/gbc9gCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 48395227AA8; Thu, 15 Jan 2026 07:26:13 +0100 (CET)
Date: Thu, 15 Jan 2026 07:26:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/2] block: Annotate the queue limits functions
Message-ID: <20260115062613.GA9542@lst.de>
References: <20260114192803.4171847-1-bvanassche@acm.org> <20260114192803.4171847-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114192803.4171847-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

This is missing a commit log.  And not really telling what kind
of annotation you're adding.

