Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A95D325724
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539453; cv=none; b=lNuhNcCtA1IQT8mkMROhbMYNm5dtWTjs6GQd8K8Yt9Nfo/uAakQ27qxHbpk1nG1ZIg2LvQXG6znskeFQU4KLELJ3ITRd90GwenVDTvJHcunJGVwgJ8hTrvSqZRwP6Z5H+YhNd0zCVvxSUlUPmOrhKvp3cIuIboa3dqmpi/XPxWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539453; c=relaxed/simple;
	bh=OnMCBfabKStP5y5P+q+/nLbXAg305LkJvEN5H3jYcb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XWnrjBiTJImMwQPbq7pQtPyChfVtQoXQ3kl2aGYTitiacfi0o7+CjvG1qciKrclN3K+0QXs71YRBtBZCNt6G+loFd3QQsAHIelHTu9fxCtIROrcOpci9mZbHTCwYwk4tfcdMtdE4+lx7KosBWWu1/kNqjw4mSniBCPUD98ArrMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLPl6wkz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLPl6wkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A15C16AAE;
	Wed, 19 Nov 2025 08:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763539452;
	bh=OnMCBfabKStP5y5P+q+/nLbXAg305LkJvEN5H3jYcb8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=KLPl6wkzekHq3+H40vblPk1+zLu6yKT5pWlNEedDkjk5V16BDl0bj2purX5kutSTX
	 sfXPucvPZ3eKeP4G0EMFGvMdHSCOLzFkmTnUEFR8vTKR+kWc00L6kdQibsUdL0edHS
	 dNqiO98x/Arg5e8IfsJFlUmHnozkUydZgh9SMdHt7AgxTzdkBPS1itueBo5prwZnD6
	 NZG0OunrkQ3TLiVgRs5KC4jgbyMhc/M6WF/Gv6N6xjcd8SWonmteCwKXMT+JN/LWEi
	 +t+2yMF1z3Vr/WaCpLdovKoz0ZdqrPKkJwnZOVBhGD7i3GDze9OKQcjmGtdC+UWFJ9
	 HnlEsdiiaItTQ==
Message-ID: <79cd818f-42d2-4c08-89bd-da9dd3c84af8@kernel.org>
Date: Wed, 19 Nov 2025 17:04:10 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] MAINTAINERS: add missing block layer user API header
 files
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20251119030220.1611413-1-dlemoal@kernel.org>
 <20251119030220.1611413-2-dlemoal@kernel.org>
 <1bb72fb2-fd97-4d00-92a1-e4d7ade5a1f0@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1bb72fb2-fd97-4d00-92a1-e4d7ade5a1f0@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 16:56, Johannes Thumshirn wrote:
> On 11/19/25 4:06 AM, Damien Le Moal wrote:
>> list of matching file patterns for Jen's block layer entry.
> 
> Jens'

Arg. Did it again.
Jens, ,y apologies for the typo. Should I resend ?

> 
> 
> Otherwise,
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 


-- 
Damien Le Moal
Western Digital Research
