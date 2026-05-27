Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1B642B72C
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895251; cv=none; b=YNNPTaXJO6mgcEWoLdiKadyJSBh0qzmF9fYCIMOlx77skIQSlHLeuVbxxkJxuMaqtJbL69QJvokt2Es+kSbCrU1oBdsihQjGAOI+5bhaNQShfADmqoYLHd+S9r6pXCHnCrr5pvlHBR9h+6T9nPCbIkZNwQavbJ+U0N6PblB1v18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895251; c=relaxed/simple;
	bh=Vb+tCAEGGp9CKLCP4+TEPTorA2wZHQbIqYVhyjopU+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNdq+u0fu3DV4O+5SSdUtjUNvxI0RBrJKqcPCG0jmWin+pMICC4amQSL+6V22uvzFh0ZBOtiDmV30qYtIvoorB8X+iEfflJOGkccqxsDq6gNeDhLQVn68R7XB6UImq+fwn22bpL6L0je6Vi4Lh6mFx7KBXnSUnd9+DQN3w0tEso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3bWFTpn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3bWFTpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2721F000E9;
	Wed, 27 May 2026 15:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779895250;
	bh=JqunHVGlVBqMaATOn6iDaIT42FlufPZ9asX0RZl6olw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k3bWFTpnQZhd7YBZfDdmiWqjYZxjQglXekQz0hQuwuoDp6MdC5P9E1+zj9X1TO7FE
	 axu00FWMpZbH9Zzbu7A53sOhQINjMrXxmb/1sPLWRCFb9MGWlWEVw7XCypwm6N0WJE
	 hDgQIVwGWrAgKEvYDzSi3ujNvMQTlVLDeMb2JjxJMMX7xR5add0vn/rMlRL+wEcc37
	 KJ4mmOi7V0lNfBN44qlu46Xp1niORQmAECOaijmFZRSXKe/q4Dy2g1ISdTLPDnPXTB
	 pC92+gfumImcRzaVBCw8Abil/+FJ727wvzLltumB4VYstUtOw2L5+nilaKPiWgyByq
	 AFcTYP5rhmrXg==
Date: Wed, 27 May 2026 09:20:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-tcp: cleanup nvme_tcp_init_iter
Message-ID: <ahcL0Mj2c2kOM9a4@kbusch-mbp>
References: <20260527151043.2349900-1-hch@lst.de>
 <20260527151043.2349900-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527151043.2349900-3-hch@lst.de>

On Wed, May 27, 2026 at 05:10:21PM +0200, Christoph Hellwig wrote:
> Split the two init cases based on code in the zloop driver.  This
> simplifies the code and makes it easier to follow.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
