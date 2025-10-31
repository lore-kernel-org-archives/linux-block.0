Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123319992C
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 02:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879276; cv=none; b=nQCgeHeGsymdxCWK6UOUgnfz9KS+Qrpui2ZrCrEHJAijjTx/mkCzUq45NGZtFxlhJFKwNOz5XU/5WKpyp2CgExVE5TyyqEizr/FhwNXEHSZaXnU4kg8eove5tQWNlGecFyEt9Y0dCf9ywrI24kCfiJuhzVCWAjqSkSmY88KCTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879276; c=relaxed/simple;
	bh=DgaHiyKRdYU74VsMGhz5XY8gecCA7Rt5sxTvv8wAZpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwJTWn7dJzfaNVKQuC9/L9T9N9CbyeIDOVU3hN3dJOHbkW2NHEJupFw0VSowK6R/zifdDJU3DirRT0qepBIEJgHxT2lxM7BC7cl9PCjhuZD2DwKkdFgNy2bv1InHxWU4F2A0f01hWA/2SpspcF/K+Z2CM4FU0yO8mdFc3aooYCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grr5rAdY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grr5rAdY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C34C113D0;
	Fri, 31 Oct 2025 02:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761879276;
	bh=DgaHiyKRdYU74VsMGhz5XY8gecCA7Rt5sxTvv8wAZpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=grr5rAdYEq7b6KZM9PFaJcgYOZ+IQyOBEI1Uu3q6h/YKGKsK/aLDVvMykktf3vbwb
	 EgEk6k+kmEMc8ul3gaaH7FceRJHsHdkB6cHhLT1BiNbBLpRrab+vvk+PjyUf1836ce
	 9Pxn5V3cMnFKhIM9Smn7iLvrLahJ7XeFNZ0F8SroqeEtrxs6gBkX9RdlhoexsRRvnQ
	 cWZSTYIVp7D9IL69d4J8vEWSe1+vMW7fJqwg6vt9GKjF4ut8DUx637TLDXYUcBI2AS
	 QlGE0w8jugpwW1chVfJkKw5lDjgP20jo9y788DY0lfZP3LjPbYVysECnAETQTNzkWh
	 duqchz5rx1JFg==
Date: Thu, 30 Oct 2025 20:54:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Casey Chen <cachen@purestorage.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yzhong@purestorage.com" <yzhong@purestorage.com>,
	"sconnor@purestorage.com" <sconnor@purestorage.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"mkhalfella@purestorage.com" <mkhalfella@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale
 pointer
Message-ID: <aQQk6nWYeB71PBK_@kbusch-mbp>
References: <20251029210853.20768-1-cachen@purestorage.com>
 <20251029210853.20768-2-cachen@purestorage.com>
 <aQKzxpJp98Po_pch@kbusch-mbp>
 <9669f8a9-11ad-4911-9e03-00758e1d9957@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9669f8a9-11ad-4911-9e03-00758e1d9957@nvidia.com>

On Thu, Oct 30, 2025 at 08:12:53AM +0000, Chaitanya Kulkarni wrote:
> On 10/29/25 17:39, Keith Busch wrote:
> I've added required comments that are very much needed here,
> totally untested :-

Honestly that seems a bit verbose. The code mostly speaks for itself
with this move: the controller's request_queue reference remains active
as long as there's an active controller reference.
