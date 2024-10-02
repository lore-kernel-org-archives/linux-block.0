Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396712141BA
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727900053; cv=none; b=XWqM7RKPrsPA1KK2RCib5OJtaEMJgqKb/cNkgCMJPknJozdNHdyc3EDJT1vqyN4msU/Y8iqqWJPXmgydkypNfRpJfPALthzDWYtawna75ExH5vQNfO5awj4627q7+7oJy5tj85YB3+Z949Ew3MyD6DUaKY51H98xPcdnCc3ao54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727900053; c=relaxed/simple;
	bh=nVUSjpMmJw3twag4PvHHz+ORoKqB82N+aRoF2mFN1Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffeNgdELROMz6ZUm4ZXW2BpNZKh1Qk96xAPWkmyM1ZXaYJtvsGi4reVQ+7Wns7xAcWxE1kjZN9x07+N+eOoSM0yzq6BTPmMPdzmA8xMKGL+i8ycTW28/lad1cXhvKhmlEIdKTa4W8lodbkQX3LnE8wABvtCC/AujX+Sq3LNyWBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0uuiR3F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0uuiR3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8677CC4CEC2;
	Wed,  2 Oct 2024 20:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727900052;
	bh=nVUSjpMmJw3twag4PvHHz+ORoKqB82N+aRoF2mFN1Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0uuiR3F+dTRr/CgWA7Rx/gl06To7tC++qDOpw1FyozVFNNpcT0HL7iPuEvYWAvrU
	 TfQsuMfU1IJS9gzBXoRZQRVa/gcPtEMLcJ7YIC0Pfgw2dShdRkaSYrNMRiD0vUseV1
	 ANYaw0EvL7bxcADyeQ2okL/yDAYvDFlgFzfpA9qgjgTc06AKE9NN66HriuOQ+15z12
	 vT4YKO7Hgh2vdga4fm9iHeDBBdJ3obwNTOOGAbFgXQw8sdf5Rs0FWTRzNuHNG0F35P
	 oM98XRVXHZWdGkhpOh/WCnnovyGi4x0TmikGDv7rtoI+rUlrJGBBYUpdHP6pCGUsU0
	 tuSQGgiMhzshw==
Date: Wed, 2 Oct 2024 14:14:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: remove redundant passthrough check in
 blk_mq_need_time_stamp()
Message-ID: <Zv2pkuK-AWKP75GD@kbusch-mbp.dhcp.thefacebook.com>
References: <2aae722e-e815-4fe9-8321-86b062f517b3@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aae722e-e815-4fe9-8321-86b062f517b3@kernel.dk>

On Wed, Oct 02, 2024 at 02:11:07PM -0600, Jens Axboe wrote:
> Simply checking the rq_flags is enough to determine if accounting is
> being done for this request.

Yep, rq_flags do not get set if request is a passthrough, so checking
both is redundant.

Reviewed-by: Keith Busch <kbusch@kernel.org>
