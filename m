Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D934D1DF96B;
	Wed,  9 Oct 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488397; cv=none; b=TJEy+xH0K8++fz2FeCYNF5X9CddwmrLXQ+wzLeOCW54H9ACwcbWqvcYCfu1uQXOHWqalRA8g0FJiKarDqcgWMU8ItwFXuTZ99NQbqJvnFKmfUq1dVRnWpxdedLo9OrJ3vxAjqvja/kN5Tabjs9aZtoiK1zdaDspIQMVmD8vBR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488397; c=relaxed/simple;
	bh=wU/oslILGgn2F02+9wwryHYoFa/vr8Fs/rJ85NNedk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gy7Ab7sFxVzsa6T54KC34mP0D25EUjAJufNFQnUEajD8FRDOZOtyWzcLAw7//Qwe6Gg8j7Rc3CnY/0lVmAWhHYk/jrzYxGKKYcUMvOcTY3ZXTOecPBnSJBHcMeXjmJnH0HOCrXisQCC7Tl4h4YFDNLlkuAIR9uJTEgmXv7u99NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9V768yk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9V768yk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB765C4CEC3;
	Wed,  9 Oct 2024 15:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728488397;
	bh=wU/oslILGgn2F02+9wwryHYoFa/vr8Fs/rJ85NNedk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9V768ykh3aN7rPScVW+4Bs8j6jHHeBrn6xA4l+k6uQPIpyQ2iA550JFNvRzG5YvL
	 L/HXrfJsoZqfAYBzxtrnLm9r0f3nqmjlTy6J0yCU4O0McvZbfe3lnxpS+stNUzArXH
	 hvkkeycnx5TOAqOm0lRTN/JaLNj5AouPWYx+qYGkfzBJOK7u6iPkyX3EwapqgRXn2x
	 pvTTK3DFRHSTx8fjne9RL2cSyUjtQniny+1kj2/3N5nM8kPPJT3nIxRP4PsO1pxbqL
	 UhIkskcnZxWlwPAd8FXHMPajsocgQ7j2NAKrwON0fxevk0ztvTmhiQkZvri5JwqY7Z
	 4v2g/lF81nF4Q==
Date: Wed, 9 Oct 2024 09:39:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>, dlemoal@kernel.org,
	cassel@kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
	Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: [PATCH 0/2] nvme: add rotational support
Message-ID: <ZwajykF81QLOkObY@kbusch-mbp>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241009074355.GA16181@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241009074355.GA16181@lst.de>

On Wed, Oct 09, 2024 at 09:43:55AM +0200, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 04:55:01PM +0200, Matias Bjørling wrote:
> > From: Matias Bjørling <matias.bjorling@wdc.com>
> > 
> > Enable support for NVMe devices that identifies as rotational.
> > 
> > Thanks to Keith, Damien, and Niklas for their feedback on the patchset.
> 
> Hmm, the only previous version I've seen was the the RFCs from
> Wang Yugui, last seen in August.

Oops, that slipped by me as well. I think the right thing to do is bring
that one forward and retain the original credit. I agree with Matias
that we ought to be able to query the independent identification without
relying on CRWMS, though.
