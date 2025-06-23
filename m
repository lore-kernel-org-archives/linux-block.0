Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBC8275AED
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691340; cv=none; b=LGulmk+coPJwl5MqcEyvSMqs8w28UuV4U+xDLox/q28CeKX2TcDDymygxEFEBiSNbb8p3n5jg684x6YpgM5cndMAmdd0/lYQY/XjKwSw1oR9YosNvejVlkueSlbC5FzysLSgLH7hrgJqhnPdF/7KLQUC+5pbmPsWuR8kyvByJjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691340; c=relaxed/simple;
	bh=WTLi4NhbtW53bfGC4bVmvYSJGLX6tkPNywywR7CkLZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F03N/nhpAGSk9vf6Oj/CyYRwGWkDEqyen14xeIuX44LH6UGlIJjfG/53w1bFqRjViEneBF0BU8l28xC7B2X3t660fK5Q2iZGhjaKS1NSnZTdb+sdrwOjyMXrJdEVlOcVPan2JhLGVn107XuCT0fa840Bflff/vxfkh+OHqOdLZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFEbk8Dh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFEbk8Dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C72C4CEEA;
	Mon, 23 Jun 2025 15:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750691339;
	bh=WTLi4NhbtW53bfGC4bVmvYSJGLX6tkPNywywR7CkLZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFEbk8Dh933EADKYtIasH6y3lFw9CE4hU1GcJkYAUp5vO8Ij0PfW1+1qPzJ5JG36O
	 iS0oKxQ+dsTZJIfOPTbqIg1O7hrul4pHDD6N59MN8T5W1x39d/OB82mqThauLk8SoI
	 qG/mN+GqWB1F0lmv2FRXEGAJxxsqxAXw8dPUlD3xOaEFHmE2NuUAc0fbU7aBgWsUE5
	 GusNrEFubdBfPKUekVjlSUIngY6GH6LQL2IrGvR01icayjFT8TifvDJH29QDW74OcL
	 +tK3F+SoXzkt6cEqqzzaRHJnMTz+3JeeP0/uJXf2kdBBkE5UUf1FzFsmP/OSoxdcpa
	 d1qyH0Ju9GBaA==
Date: Mon, 23 Jun 2025 09:08:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH] block: Add a workaround for the miss wakeup problem
Message-ID: <aFluCdqZ-QYXOKf_@kbusch-mbp>
References: <20250623111021.64094-1-changfengnan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623111021.64094-1-changfengnan@bytedance.com>

On Mon, Jun 23, 2025 at 07:10:21PM +0800, Fengnan Chang wrote:
> Some io hang problems are caused by miss wakeup, and these cases could

Wait a second, what's the cause of the missed wakeup? I don't think that
should ever happen, so let's get the details on that first.
