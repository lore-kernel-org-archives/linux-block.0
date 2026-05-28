Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690230F543
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 03:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779939585; cv=none; b=HJS4DEM8/x4+cMzGiuqVVMaPTWaUSFcGolQL83EO0ZLCGWgE6B/5Mmx8/NR++/acqLwD9uQwVVvAOOwTuNbQNWabJXjBYu4SM/7RwWSx+PLpKMCD6MJXq4e3Q7mGnuH3kaDEO2kefMr+tsJ6wYBDVE5DTj/Ij4TgVi8RBNiKQ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779939585; c=relaxed/simple;
	bh=cqBG7sHpo/h2U1kUXPYd/Xt+WwVnnnIJeg8k7+GkvVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADKHO4fxfksm3NatBKuDAX5qNVUtHs677C+Yzv6X4Big1c7+e24lmBacUk/3UPnS1AsIK/lMkw7hwLjL7KTIuqoL9Nc1gO7eKvn5xO/KsR8Ou7qW/tRy9gUNj//LmHYJk5TnC4xPos87kGAQoSFo/vaHTOUqSUxNGHQdNSsSkzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnqZyvYV; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnqZyvYV"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9102e90bcbeso1257981985a.1
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 20:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779939577; x=1780544377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjVsOQMWJ/idl7592wbOBDSCnbZK2DbV+SpTbRF46gk=;
        b=NnqZyvYVcjVruohtumg+AOiE1GXFeoltkdmUoR4OjQrf8ooqxKm1sDZL7e6kPupaYN
         6nlJ8m/ROX9XWj95wUezu6pU3iaaAfyAhRmlUlaXxIQCwWNP4mBvQk6nXa7sBgiMusib
         WV/KBIAvBH3LYnwV44Y0jDiF//O68Y9b73L3ZGcojYSV0st5IKsR1HP5sHCsDt+lX/Cb
         23mIZ3s6h2eY1tnvFEBQBOyEgdlJBO50NNxvdxxmg3CLL4seu/hEWIdVb9P6lHMgmW1N
         Lsig3r2KFxwssVFKNEJ7iDPgMaQZY61Ciqs0Qmzfzf7IS97G8ZU1lJq5b4k+uiQz0M7R
         4Nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779939577; x=1780544377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjVsOQMWJ/idl7592wbOBDSCnbZK2DbV+SpTbRF46gk=;
        b=HtOPU96GbbcX9dfB/ZpzCa8LbBlXx/6dIMhjThyx/5KuIeV58i/IDIjmLHrcuYOw7e
         N977PXm29Eb8OQvQ6o1SUnxQKt6VV2XIWIJSpeCb6eXoII7jZyBUNWNpQ7NPqEP9eGTa
         qPA8p0JoNb+92tMpTxHWoFtkTugEXGZhFRtQDieWxFaur0+bFzQ8D4lY9QrPO2Pb+wM5
         ECFDPEYLg9S4Gw5RmUCoApAHVbT+YNUebn2adL0G++EU+/iGP/uzijXabVfEHf5OO/Cb
         FJqtwejFBKCaA+/8cb3VXLuoKitW6V/NRxLJjzOycbL4Rnux0MzW9HgfzPwEqnIhPXwo
         8PGg==
X-Forwarded-Encrypted: i=1; AFNElJ8NiHORxDOFjQ/flH+k/cwnpy9y2bl9K1muwYUXDh1TO8PE85s1yNfgBpow3iQwqit6+J68or74oJgbBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzex5QA2Oj1ELV0a11odC4EukGk/LVXE0QlAlQAfMOZZp2MNnSc
	In5DJv+jePM8XP2u8cNRwResksmM3v4WwPS2df3p9qtcB0aK7H4sFXJp
X-Gm-Gg: Acq92OF5xreIzcD2bKQ8WPVh23oeBswH62f08wS79hgF9VbDlys1pe9iv8rdLV100Cs
	z6+OT33CPtx7fmlc+0+X5Y/VfxiSvZmUuOhbLbZO3iuWNOjxL+FqmQ1OQ0wW4MhRUvN3K/1WfIh
	ZEzIuqOWefBj+Pp2Aads7q0LZvCa+VFv/b2EhPGUX4MuS2arIT26ppUisaRtvnxNIsT0iorqtIn
	f3pWGFoaxPiPp9K4TsutcLwtCzLxZgsEnw7PpPdwIZu2H52d/5ozg8d3i6Z6eXxJtXoQD7Zp+ec
	izF8xrc9dR9lejcILfaYCUoPTatZzuN8KPDQXb1Ldy9etL1UpkhtJGmCikYhPy/ozpJ2rZ8tEYW
	uLMDcqIOxDMjCdes+nFFDpUkCjl0h4E9Jv4N3UhC1NUnmv0tQMXbeqxVMCrFc/YiPNCtQCF9a/h
	wV523Hw5K7KJXf1hFUAJedxN56zGZ5Qe/tIg0XY6jkhOf/PXM4oYRQFmB5Fn5sWMKpX1Q9us2MI
	nPnYk+Ur7nvrUjIGa4f3unOuYXYY7OE
X-Received: by 2002:a05:620a:45a4:b0:913:7bc8:79b4 with SMTP id af79cd13be357-914b49f711dmr3672366385a.51.1779939577133;
        Wed, 27 May 2026 20:39:37 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80ffca70sm187161236d6.22.2026.05.27.20.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 20:39:36 -0700 (PDT)
Date: Wed, 27 May 2026 22:39:30 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-tcp: cleanup nvme_tcp_init_iter
Message-ID: <ahe48vG0zzOifp4e@fedora>
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
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks, 
Ming
