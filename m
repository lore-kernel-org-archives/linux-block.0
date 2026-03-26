Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EAD334374
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 06:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506749; cv=none; b=LNFWwTSV3TsR9SEFFwWQK7vF9m9oW+FCRpYUO7ZBEc2lYn/Cz/Uw7bUbxkIF3gS4D9C3G1grgZDwwWzGdfEDEmlD6ojWdYfuPry4l5SHx2cecP1N7ul9XFGjm24p3ou91No5TompIiOaVNoRR82MEENyO1ZnSHYSx55UNdqlaBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506749; c=relaxed/simple;
	bh=b5rIo3qUGgtY9WhbsprLQQ+oHvNwzqC33CAGIyrLgeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+Ai4/VLsPtFXCuJHAD9r9kqrcZexa4h8x7415ZFbBnm/IM6KwZfk9dfc0aowTuYscJ7werDGwTmdNY27uvhDK5T/ZqYAZ87YUyjKI37yQUteDz4AckAOuMFVXMIFqDlnqDSKBXibYwzhln10PtlSpXUTc7cpZMnBSpuIxw1yQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C35E68B05; Thu, 26 Mar 2026 07:32:25 +0100 (CET)
Date: Thu, 26 Mar 2026 07:32:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 08/26] block/blk-mq-debugfs: Improve lock context
 annotations
Message-ID: <20260326063225.GI24071@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-9-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-9-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks fine, althought I'd still love to find a way to avoid all these
open coded dereferences of the private data pointers using casts.

