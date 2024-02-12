Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC663C6BC
	for <linux-block@vger.kernel.org>; Mon, 12 Feb 2024 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752659; cv=none; b=U6AUC2BlhYPxonBY8kmFOkXE3OJIAqy8spMxKxNNWYjsUI2LWyWaL0wvwmn22GvqwRtFRaNpiKol2hfZ5qLd/mzP09HI/m7liNkvzaGV+nwilXnssWb6GE41ZlZyFX9G88ih+cWRGYJSKI8eI0RtQvtcs6g6AcSBFqdonqSB0VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752659; c=relaxed/simple;
	bh=ZDe6P1NJwcYGTVi4MU3/axwoNA8u0Y9YY2Q47CpJGm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ookcsas2tFedNQAlcp3Tpvf5SOEBHXDwYQuLmiwto4CR/0FBtYSylG0rh6TYLvPu+Hl9lZ0244Hu02txYXZj+rpV2XHR8pqgghDeWEEob12xPUaUNvB1x1gchSDBFA3Nz18FQ9F4vwU1nYmKHNOg0hbLAlu6occoOadwXCornic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4732F227A87; Mon, 12 Feb 2024 16:44:11 +0100 (CET)
Date: Mon, 12 Feb 2024 16:44:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Saranya Muruganandam <saranyamohan@google.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, Jens Axboe <axboe@kernel.dk>,
	sashal@kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: regression on BLKRRPART ioctl for EIO
Message-ID: <20240212154411.GA28927@lst.de>
References: <CAP9s-SrvNZROseNkpSL-p-qsO0RT6H+81xX4gg-TV71gQ_UbYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP9s-SrvNZROseNkpSL-p-qsO0RT6H+81xX4gg-TV71gQ_UbYA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

What scenario are you looking at?
