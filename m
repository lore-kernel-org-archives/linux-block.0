Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E87A409DE5;
	Mon, 18 May 2026 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107166; cv=none; b=DXGMyMvjLo8shGkec0bmoMIoBrssYoEahfyEeWUdHnR6cD58bx3Llhy5H6NT3KYwAwK3/fpN2WORYXmqwLHALajI0Ht2DaUhFAKZmhEdPv2RNU0fGKQIduRBbVMck+2uaB+I6X2jxOsqIKXyv4r22WyCZwexlFQWXwQQUru3X7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107166; c=relaxed/simple;
	bh=pmHJAGq2duZdT1DTLbIqMdCRhTLaNQ4nvhTZW38ZARU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=db9lEetHNVuCyfzXvoXlEjcB5QkP1TE5Fm6t+Uz32H7ltDGEL5YdhtgcIbJxwMXljyU6NvmHl2VdcwCouRn6GS+wpNZdMIl8Bmgfc/ZSVG6gevABwYj75nTRDAnkH//lqNg4hZXEv0eodD38g5Pi2lhjZVG1+VOGEdJAyN2E7H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWK53YXH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWK53YXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007A1C2BCB8;
	Mon, 18 May 2026 12:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779107166;
	bh=pmHJAGq2duZdT1DTLbIqMdCRhTLaNQ4nvhTZW38ZARU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWK53YXHj2/EQNAB918rSkJUAKY79WuMUZT23vfjpj08hewp5jgPtB5Daf0MV7I/f
	 QqvNyBIxPD11WvdM2ZQ1NlsU/Ovuzj4UvZ12H4qdhJiGOxJN4ZCemyVCOHE7YoC5Xu
	 xtngOREeDM00L9/9uD4xjX07S/qluAI+ThxpGWqPyimy1q1t7K+E8gnTQcc3VAmyX/
	 PxEQSadhPXapuQLIAXFs4yu17g+H5BiKwrctSQg/TUkfzc6blRvOHc9vS49bJJPvDb
	 kRKlC68nNM5CW49J0Squ4mRXByu3vWrJNYJtJupfha1Nz1p6OUvktNJoidpvSP8MKS
	 vWcF616vCnqDg==
Date: Mon, 18 May 2026 14:26:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] direct-io: remove IOCB_NOWAIT support
Message-ID: <20260518-fakten-bohrmaschine-6876827e54e7@brauner>
References: <20260518063336.507369-1-hch@lst.de>
 <20260518063336.507369-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260518063336.507369-2-hch@lst.de>

On Mon, May 18, 2026 at 08:33:29AM +0200, Christoph Hellwig wrote:
> None of the file systems using the legacy direct I/O code actually sets
> FMODE_NOWAIT, and if they did this would not work, as the write locking
> could not handle the retry.  Remove this dead code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
