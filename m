Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800AC81AC7
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532883; cv=none; b=VopVQS/P1lcdQe8+j0hBckshkRkNIMcCuHgtF2B7HhxytVR/A2NNTxvKsUjU9ihf6os3ChiyNnzq8eCherFRNpC6mat4DpQB/0zA93FkeULyHy5tL465ucstO9sB/ooHGXGO4TYTxIZoPGUPTjjFk3Sbsj39B7ZcqBH2OI+ecCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532883; c=relaxed/simple;
	bh=gd0xKyCg1NfubwCEgtc+pYRQUB0PufeZD9HbkUdTJcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHb9ESKjWKcvx2zqixhc33fJlWCUUQlkERm9RWFSmNXkDdyIT/juT/CkmRvPoeg5mGZfYwUq/WhNtMiZ7zeieQAN2UCHJz6LmZCNdurTsWdlCdOPjmDLkV/45EGM1n9d8sWlzEUWzFk2wzNzwk3biFhT4EK6xljof4l5tlB9vtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYc7+I8Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYc7+I8Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5C5C433F1;
	Wed, 21 Feb 2024 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532883;
	bh=gd0xKyCg1NfubwCEgtc+pYRQUB0PufeZD9HbkUdTJcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYc7+I8YIZMxKollKdR9BJyBOL6Kr49c1o3Z+E0yUFyfvXwOVW29IXlIrnhTPTtXO
	 WIBJ6wB3GBgJVOwL+fHh4Dx2URu4rJSo2dQV0jxgGI1vSljtFQ5GV3fxQ+9r1MVf1v
	 Fd5hxzWDf4Iw9WbI0KbbcCvjpA3Ig0GehAeLGlFWMnV+nLmLvTc/1Qd6HsdxTKjwuU
	 b2JAjYkMewHnbYHECmpHMb2LeyeXn+27lGwaC5uVzShz/O31ifdeluwKX0B3Q2nMeJ
	 CJjpwiNfFLF3vxoI0fzvY4J1g41nSmuB5o3bbr5umsNOJCQAxdKCiuZCbNnDqY/t7p
	 qjpIR911fBonA==
Date: Wed, 21 Feb 2024 09:27:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.org
Subject: Re: [PATCH] blk-lib: let user kill a zereout process
Message-ID: <ZdYkj2YfKCpdIhGx@kbusch-mbp>
References: <20240220204127.1937085-1-kbusch@meta.com>
 <1599adf2-3099-457d-a194-3be0057d344e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599adf2-3099-457d-a194-3be0057d344e@linux.ibm.com>

On Wed, Feb 21, 2024 at 02:16:23PM +0530, Nilay Shroff wrote:
> On 2/21/24 02:11, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> 
> # time blkdiscard -z /dev/nvme0n1 
> 
> real	10m27.514s
> user	0m0.000s
> sys	0m0.369s
> 
> So shouldn't we need to add the same code (allowing user to kill the process) under 
> __blkdev_issue_write_zeroes()? I think even though a drive supports "write zero offload", if
> drive has a very large capacity then it would take up a lot of time to zero out the complete drive. 
> Yes the time required may not be in hours in this case but it could be in tens of minutes depending 
> on the drive capacity.

Yeah, that's long enough to change your mind and not want to wait around
for it to proceed anyway. Between that and the filesystem usage, looks
like I have more things to consider for v2.
