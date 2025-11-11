Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A477D262FF6;
	Tue, 11 Nov 2025 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852082; cv=none; b=doBUN/EVst0epL7F/VpsnmOeakz/ZNf0YXAs2KFKMLHj5mI3kwZdec1JsgwmVQqTaWYN2vVNWtVIzT7gdKaJFROqalz/cTMrov6FNrZ3s8da1wbwBfIL9wg1AztoYCLRH0Uhe1lOO6i4RmPgy9seYOchPOFhVO0GAFvJDdsnMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852082; c=relaxed/simple;
	bh=Lmi2eGQkXjkJdidhTSjSgdOyPwktGhHkIJ7zsFjLmx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtSMLARJGIbUSWmNDV4A1QffHb5oKrgZr2YdmepswbhwXeZ8xp+NGzXUlSsr6C/d/gQwm3fLCwLzVeopXPuU0pIXE3SmgATQpn8U8/7SYKq2ffhyyRQYmO656+3W6tOwVueKZdlQwsdMhjj/Ghln54u+/m+9tVtgCHyS/htPEk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0EC55227A87; Tue, 11 Nov 2025 10:07:56 +0100 (CET)
Date: Tue, 11 Nov 2025 10:07:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] zloop: use blk_rq_nr_phys_segments() instead of
 iterating bvecs
Message-ID: <20251111090755.GA12545@lst.de>
References: <20251108230101.4187106-1-csander@purestorage.com> <20251108230101.4187106-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108230101.4187106-3-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 08, 2025 at 04:01:01PM -0700, Caleb Sander Mateos wrote:
> The number of bvecs can be obtained directly from struct request's
> nr_phys_segments field via blk_rq_nr_phys_segments(), so use that
> instead of iterating over the bvecs an extra time.

Same reason this doesn't work as Ming explained for ublk.

Maybe we should lift this code from loop/zloop into a well documented
common helper to make it more obvious?

