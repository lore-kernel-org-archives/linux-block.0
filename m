Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20146CA6B
	for <linux-block@vger.kernel.org>; Wed, 29 Jan 2025 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738154821; cv=none; b=theFrw+ZGeGb1pZ8JWIm7NSaFZvkdderJFXQtjXwqGOsCvOk3nFwQUFUPCtS/rcd+8/Cd6LsWQgXFudvY5LICKKod6M7nrVZCNXCLciLjz7nSIxZPD9TKD9KdPPL4706SpgiT51UmUpCivFS0PeKxBb0PcFHYKuYmajxwLHPgJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738154821; c=relaxed/simple;
	bh=hQ31YCpSsOSVS74PwJKnqBm95ikXGbSt66Y0Z4IrEIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eLNNSv0WBaSWn5Ud4tDm2BDzJFZu+dbr6WFIk769xfQ+LORfJ0fyF/3volVTplq3F4xZriz2XjPsesninbfUv7l6jPnU/MahGUKQlZjA/Ol4T55ADm+v2uVihGRZx4e/FBmYx0+6EEba5zsv/vqxqesotSW8cn8gtB8KJd/34tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 31E1B68B05; Wed, 29 Jan 2025 13:46:48 +0100 (CET)
Date: Wed, 29 Jan 2025 13:46:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: in-kernel verification of user PI?
Message-ID: <20250129124648.GA24891@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi all,

I've recently been reviewing the just merged io_uring support for
passing PI and metadata from userspace and reconciling it with my
fs PI design notes and prototype.

One thing that I noticed is that for PI passed form userspace the
kernel never verifies that the guard and ref tag match what we'd
expect.  I.e. if userspace passes incorrect information it can trigger
a command failure and thus the driver error handler, which is something
we don't usually allow for "regular" I/O.  Definitively not on files
but in general also not on the block device special files.  Also a
"random" reftag could cause some interesting integer overflows when
partition (or later file offset) remapping.

Shouldn't the kernel do verification of the guard/ref tags on writes
with PI data?

Also another thing is that right now the holder of a path or fd has no
idea what metadata it is supposed to pass.  For block device special
files find the right sysfs directory is relatively straight forward
(but still annoying), but one a file is on a file systems that becomes
impossible.  I think we'll need an ioctl that exposes the equivalent
of the integrity sysfs directory to make this usable by applications.
