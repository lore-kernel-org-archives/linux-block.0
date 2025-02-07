Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D95419F11B
	for <linux-block@vger.kernel.org>; Fri,  7 Feb 2025 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959223; cv=none; b=Nf7UnqhQoa1rp/eM+X7j7KfH5/tEABFvCnhuuhs27PGnaXMjoQTT1swsk3tgYdKXN5Xeu2GoSErbU9p3W9LeLfddzhm918+1ptlFT1SGvInbeBDT6V1nh/Ts3jyuWEn90UaMWfR1+mIYKKUZuoF0x1tc7ss4VyTcVS3sI3dtDjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959223; c=relaxed/simple;
	bh=uLUDHY/xQ22hJ9LRsrli76Ju7cNmHT2Dk172yvN8bqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNz5ECb8MgUlF5MpLXW9cS70EY83G+PCUPtOG0hu8Mr/3FoeWm3PLEkSV+u5PlIIiv5D3P1U5V36ed+10aVRYsYdK5T5gEWbwN1oT6D4+IJKD1ZPGEtDTJwLnZtMb6yBQW9eKVm4icXK2rt6ZKeLF+yldXF68FBuquqd6bXTcXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgJsWzet; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgJsWzet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94286C4CED1;
	Fri,  7 Feb 2025 20:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738959222;
	bh=uLUDHY/xQ22hJ9LRsrli76Ju7cNmHT2Dk172yvN8bqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kgJsWzetFnE7h3eCygcrTBgoZ5KZ+XfxU0PJA+0HB6jEDrrM20kWLsHXAk+dpHG11
	 6RW8W1Ha1FHiz7p/m/jT/8UWVgC76wozrwhoSMzKDlwnPGFsONWo7yVvZr1vSPyGzw
	 5mdtb5xruOJ4MrD0ClaKtXOFSv//VsplTl/4LHMrJEU/uRHZe6csxuvlVWZtN76IAo
	 PkYJQqhDD4bDBCOu4olA4/yxSZtGW0InZH1AIPmkDEfoL25tElxTJtWMoGj0S6V7dj
	 McfQydcfPEq8HVElPYIQ8wMY2ZDgWMD/nEOU73452iqsK8nuG0lOC/4KqxDSkMmsYj
	 G2sCNhbELjYwA==
Date: Fri, 7 Feb 2025 13:13:40 -0700
From: Keith Busch <kbusch@kernel.org>
To: Matthew Broomfield <mattysweeps@google.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: ublk: expose ublk device info in sysfs or support ioctls on
 ublk-control
Message-ID: <Z6ZpdKDo7Ao803NP@kbusch-mbp>
References: <CALEiSPxGXy5faNFiiPt_tOF=K2cS=02RVdjw1JGuokNV7JPHJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALEiSPxGXy5faNFiiPt_tOF=K2cS=02RVdjw1JGuokNV7JPHJw@mail.gmail.com>

On Fri, Feb 07, 2025 at 11:50:33AM -0800, Matthew Broomfield wrote:
> Hi all,
> 
> It would be great if there was a sysfs file which exposed "struct
> ublksrv_ctrl_dev_info" so programs written in languages without
> io_uring libraries (such as python) could easily read this information
> for management, testing, or record keeping. Ideally if possible this
> could be something like "/sys/block/ublkbX/ublk_info". Is this
> possible?
> 
> Alternatively, the "/dev/ublk-control" file could support ioctls which
> mimic the io_uring cmds such as UBLK_CMD_GET_DEV_INFO,
> UBLK_CMD_ADD_DEV, etc. This would be more powerful as the block device
> lifecycle management program could be completely independent of both
> io_uring and the program which handles the block IO. However I'm
> skeptical it's worth it in the long run to create a ioctl -> io_uring
> adapter. (As opposed to languages natively supporting io_uring)

It's really not that difficult to make an equivalent ioctl from an
existing uring_cmd.

I think it would be even easier if the ioctl was exposed on the
/dev/ublkcX device instead of the general purpose ublk-control. This way
you can just use the path of the device you want to query instead of
having to look up its dev_id.
