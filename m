Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A223FC5DA
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895237; cv=none; b=qSdqhdfZwBItI2bhXrsuPatSUE2iFZ4y5wmYdFMm9fH29Uu1X7rRbGbRF4Eyms1XUNEYbyK5oAUtX9Xhg7s7xYZd3HPiI5/23DWEe+xgeyaBDUvRgrvnxyCPQNd1Ne/IzgNPLGw7MNjwcC1R6mmQjomk2GxIQDIy3C/Mbtw/yIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895237; c=relaxed/simple;
	bh=gtMbEACI0FSXdSB2mStVMSHaZssO9ACkRp6yY8ka/54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWGEydKr0KZVepMYfrK9JLn5ICIqh3AIxp4hrPcgnbKkM4J7nXF8J4fNmEsa9gHs06ig/ZTJPQAcCOK6N/ZvFh7+pv3qYvFIshCp/S3H9AwS/iQg4UkZgvTAqZJpkr4H1R11AhwPdz81wNCLire+koxN8MBQ3kO/1c602SEP1CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7+pJC4c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7+pJC4c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5479B1F00A3F;
	Wed, 27 May 2026 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779895235;
	bh=gtMbEACI0FSXdSB2mStVMSHaZssO9ACkRp6yY8ka/54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L7+pJC4c4p+BU/ekrD3caIlg6XizLFajQc9aE5MentzrQ6pIlm+4q8nTAKilLQwUq
	 hkP/WKb2TrL7aLImiBvrywffRwhZsdNIfIFJshE7viSiqKq40K7J9O7D5tSohr84it
	 VEp7YCm8nGgDn/Yg1aB35VjbHDYG8oqf/GLWYEBq+KcQ7H04eVnnUi1ffg2a4Cb5j3
	 pfMjUgdNi7eEcq6WRDvW/jURzkVE1PzTnjG1Yrh3M6op+yqnrBewIhcHpSx1jePNqI
	 X1b/NpptcWZRMbvqOOQSXgH1pJOd/OJsT3DAcOnyftS1hIzy+uAKDjIl/sfk6GTDQ9
	 1E6p+xjGBRZAA==
Date: Wed, 27 May 2026 09:20:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] loop: cleanup lo_rw_aio
Message-ID: <ahcLwXbqL3a4Vp9U@kbusch-mbp>
References: <20260527151043.2349900-1-hch@lst.de>
 <20260527151043.2349900-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527151043.2349900-2-hch@lst.de>

On Wed, May 27, 2026 at 05:10:20PM +0200, Christoph Hellwig wrote:
> Port over the changes from the zloop driver to remove the need for
> the local bio, bvec and offset variables and clean up the code by
> that.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
