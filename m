Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1089A433A9
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895815; cv=none; b=cIdsp5q1fN8QqD/k4T12XF+zvOQVyQ1Vubzu9FLQnkmvBXXaic0K8Ss1fI7310ETVXRZdWuCMaDqrYnwzkBq54DFcxnOK3yhWzelKaG5Jnmz1VoS4XbzAiuRbppNO9i9+gZRIX/DIinK0pkzO8vag8iyxUU0LRk/QOqyho8UY+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895815; c=relaxed/simple;
	bh=ivJ/YB2na97I6sxcIuZ04DCGKAUOEt+H0rOR5JnwONE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P57M6sor7U5zXLJFrZe1sS/Lj925gw3dshBkuY1HnAA79sXKbD6p7K0YcRPyBZleBzKALGa1ZoDOSOvrmjcFySSo1uqn0I2ClZmEQy+ajvI7QQR0eMHXh3IPnSmtRomk8jey/rX7bOkMoEtiCnc8Gm61GDgcWrZfU5Qwar3pi84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AX4EJ9nD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AX4EJ9nD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12EBC4CEC2;
	Wed,  2 Oct 2024 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727895810;
	bh=ivJ/YB2na97I6sxcIuZ04DCGKAUOEt+H0rOR5JnwONE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AX4EJ9nDVj3EQaDNWeq9QH/5fZuQj/NbHFRFqFuvaOsY+6LhwHerC4SADt9bq7+pD
	 iDwaC5+4gcsvPQDwQ7jbFXGs2viu0OnqqYLB8ytVKFQWVm7jKHi4WX/mayWyMQ8oaU
	 JUgsMdxVPtVpB/5rp2YwlKY5q7pOBIGzwgvo7Zq0LvKwOc6c92H/uvLhjE22Hpuf/h
	 g4X5SEHwRMYjWP0IG8XvmIdj/9jQNWBXzAtV4tUFzKxvyEHcwdwc7HWwyvMsnWVb1r
	 mWMfL27HAD4rTiREyFMc3ecprhmTIb/AcPTTF66aIsGGsx46Lq2ED55BuNvAZRfoM1
	 mDAceQDArW1Gw==
Date: Wed, 2 Oct 2024 13:03:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Chinmay Gameti <c.gameti@samsung.com>
Subject: Re: [PATCH v2 2/3] block: support PI at non-zero offset within
 metadata
Message-ID: <Zv2Y_4w5DHqjGU6m@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d@epcas5p1.samsung.com>
 <20240201130126.211402-3-joshi.k@samsung.com>
 <ZvV4uCUXp9_4x5ct@kbusch-mbp>
 <8ed2637b-559e-3f27-3d1f-84a4718475fb@samsung.com>
 <ZvWSFvI-OJ2NP_m0@kbusch-mbp>
 <165deefb-a8b3-594e-9bfb-b3bcd588d23f@samsung.com>
 <yq1ttdx81ub.fsf@ca-mkp.ca.oracle.com>
 <20241001072708.tgdmbi56vofjkluc@ArmHalley.local>
 <ZvwXN5n1XyqRoH9H@kbusch-mbp.mynextlight.net>
 <yq1v7ya4hgc.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1v7ya4hgc.fsf@ca-mkp.ca.oracle.com>

On Wed, Oct 02, 2024 at 12:18:37PM -0400, Martin K. Petersen wrote:
> I'm not sure there's a good fix. Other than as a passthrough user, the
> burden is on you to ensure that things can be read by somebody else.
> Could be backup applications, virus scanners, system firmware, etc.

Maybe we should disable device side guard checks on read commands. NVMe
spec allows us to do that. This way the host would always be able to
read data, and the host can optionally validate the guard on its side if
it wants to.
