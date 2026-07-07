Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA426C3B0
	for <linux-block@vger.kernel.org>; Tue,  7 Jul 2026 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443361; cv=none; b=Cd6I2SDQyykEUHr+LftB4LWl7ceL8Gyqffpmd5paRomq7SJ5oIvSW2Hvp+FdVJwLvxrnLvFnt/mAX0G17yd+ZLfV4m/tWvCyKQacptVKktjyTCGPZ4bd3hEejFhCRgzvTIKTgoA6hJczqRtywUiRoEQ97Prl7xcimr4OEw2F3Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443361; c=relaxed/simple;
	bh=MQCaaBdGpSSUxjZ5c3zYCltYJ2V3psVckYkezzM9+bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssOLCJu2vmMyWKDMXbBDbiXEMuzlP3z55bcDDtQu2WgO193T23uqyz94EeDhdxexXrG3QKI/B2naEQLSSueXWR0QVEHnydfOSDyCn3kE3SeLhNmG2wIKi1CytsOPN3ktMWtXCtway9r5kJKVpw795G6MOISFjVwwG+Wia82fYDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KO/mChme; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KO/mChme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D440C1F000E9;
	Tue,  7 Jul 2026 16:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783443360;
	bh=2RXcs1wiop+oFWXF+1STAvZWJay6nE/NUSels7clCNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KO/mChme42psN/dRmEWOAEK5Tktifb5zUqEs8NrUzKBQl6jcn0WXgWr3dv8zdMSuD
	 lacV7IoA7/aEG1AAH64d1mQxw51uTH2N/dr2GA/QCz6yQY53R4sHB1xjpydp8K3N+4
	 hPVAVdMm5K0Vz9k8nYtF8cFhMCnlnQXp91TDi0Vw0wh3jON0CBz8DAvsQXhsVfohra
	 7v/u3yMFvgjZVcbTKYAhcByYBB0Fak0t1RR5VglkDqxu7x2firJVNLYv7+8iidu3ga
	 aZUjx3NS7aNqR9rwGTjQ7g285/B7nuHSeAj/vQhFw7mhKunK93JVvOfSmDLjNtpreb
	 GB04xyRKT8PPQ==
Date: Tue, 7 Jul 2026 10:55:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>, Ming Lei <tom.leiming@gmail.com>,
	Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	John Pittman <jpittman@redhat.com>
Subject: Re: blktests: call for agreement to relicense GPL-2.0 files
Message-ID: <ak0vnlWkLq_RVnR_@kbusch-mbp>
References: <akyeX0hlcrnOC0nT@shinmob>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akyeX0hlcrnOC0nT@shinmob>

On Tue, Jul 07, 2026 at 03:38:51PM +0900, Shin'ichiro Kawasaki wrote:
> 5) block/042
>     Author: Keith Busch <kbusch@kernel.org>
>     Contributors: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 		  John Pittman <jpittman@redhat.com>
> 
> 6) block/043
>     Author: Keith Busch <kbusch@kernel.org>
>     Contributors: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> 7) src/dio-offsets.c
>     Author: Keith Busch <kbusch@kernel.org>
>     Contributors: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 		  Bart Van Assche <bvanassche@acm.org>

Ack for switching to GPL-3.0+
