Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D2C1993B2;
	Thu, 31 Oct 2024 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383968; cv=none; b=F5Lld9QQBkYZ3icJMz+Dnuf0XFU6VyAhk+p/MbLmGWybw99B0yQZIZy2OiESTQDCqjj/XloZlXg/eXvGdM0oycEL9jmvY+bb86DgIx6O36v3Y050KIVeda+ASM1rGmIAM3nzdPeAsy+AvhKwfkhdoDe/XB3WY1l7b4EWrDp9vVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383968; c=relaxed/simple;
	bh=ZBxXT6yqiTiK4rpdSgTpaZMBXpgDcFgXwOMVCui9Tes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUV/NvMxw87QXAMtfnTjSrilfCcbEotQ+HFeKtjBD44flqwct8TPU4mX/kNo06KoDleitXPnPdfd0cp7M9NzRCWezGK0BNJwKxo0eYb+Cndv08JkCHjupZNY4vxsJKho62EQM5NZH5IIzD8FBYH0EMxmGIEWGjtWGwIong1IKQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyiZT4Ya; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyiZT4Ya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE616C4CED6;
	Thu, 31 Oct 2024 14:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730383968;
	bh=ZBxXT6yqiTiK4rpdSgTpaZMBXpgDcFgXwOMVCui9Tes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyiZT4Ya10y2A4ctvcIen2W3fK0LLMEUuTbrBiHkkOjXjukzGm/EBezbZENmE3vNv
	 USSyTQrgjWsiuMJJGZoEAMGE3Trug3Lr2U4ZoV8Zx9t78F/RF5UwbaPZIMUAxUT5O3
	 SZ4teg0Jqk1DcxldPj2RWneUcS2R3LW27kSZ3m1knM9m7fyG6jDd+ojpjNUD3RILtN
	 rqeJySriFx/JbVxaHGAlnoBD5F5lFtoCBCmrZeRoeEgAVxMTus39BjH0IRwNQU/Y2C
	 pxuofxo6lRQrGeSj1RDY00lAH4EdgII9Jj2lFOZZSqQ/0kC1HDtIDoiPZzt12mdLBb
	 AaY3LoeEazIyw==
Date: Thu, 31 Oct 2024 15:12:43 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, yangxingui <yangxingui@huawei.com>,
	axboe@kernel.dk, John Garry <john.g.garry@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	James.Bottomley@hansenpartnership.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"yukuai (C)" <yukuai3@huawei.com>,
	"yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [bug report] block: Non-NCQ commands will never be executed
 while fio is continuously running
Message-ID: <ZyOQWyyai2JkKyzy@ryzen>
References: <eef1e927-c9b2-c61d-7f48-92e65d8b0418@huawei.com>
 <922e3d52-9567-4371-9a43-6d51f716a370@kernel.org>
 <129e1e4b-426f-3d5b-b95c-d386c90cfe06@huawei.com>
 <5b4a15be-1cb2-4477-8f17-b808612d10d5@kernel.org>
 <0e78cce0-3f4c-3ddf-4d5b-ee2b5c8d7e1a@huawei.com>
 <ZuAtLK5jIPEjhXmU@ryzen.lan>
 <7f179f49-a57b-45bf-92f0-f577aa0b8565@kernel.org>
 <04cf3f31-4bd8-3ce9-867a-41628e56e861@huaweicloud.com>
 <e1ff5ccc-8204-44d8-ba62-84c8bd204fa0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1ff5ccc-8204-44d8-ba62-84c8bd204fa0@kernel.org>

On Thu, Sep 19, 2024 at 04:14:15PM +0200, Damien Le Moal wrote:
> On 2024/09/19 14:26, Yu Kuai wrote:
> > 
> > Does libata return a specific value in this case? If so, maybe we can
> > stop other hctx untill this IO is handled.
> > 
> > For now, I think libata should use single hctx, it just doesn't support
> > multiple hctx yet.
> 
> libata does not care/know about hctx. It only issues commands to ATA devices,
> which always are single queue. And pure SATA adapters like AHCI are always
> single queue.
> 
> The issue at hand can happen only for libsas based SAS HBAs that have multiple
> command submission queues (with a shared tag set). Commands for the same device
> may end up being submitted through different queues, and when the submitted
> commands include a mix of NCQ and non-NCQ commands, the problem happens without
> libata being able to easily do anything about it, and not possible control
> possible at the scsi layer either since the commands submitted are SCSI (not yet
> translated to ATA commands) which do not have any NCQ/non-NCQ exclusion
> knowledge at all. NCQ is an ATA concept unknown to the scsi and block layer.
> 
> We (Niklas and I) are trying to find a solution, but that may not be within
> libata itself. It may need changes to libsas as well. Not sure yet. Still exploring.

Hello Xingui,

I send a proposed solution to this problem here:
https://lore.kernel.org/linux-ide/20241031140731.224589-4-cassel@kernel.org/

Please test and see if it addresses your problem.


Kind regards,
Niklas
