Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA42921218E;
	Thu,  7 Nov 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987114; cv=none; b=cV872FKHBeoMI7HMI2J7drStIfeXXuPnEDdePUalrDxRH3VWtHQiPNsXYhILgokDFVaZIouH8dQFIOxHp05EnTfDK6KNUW2NESdZaVssNvaluxDXxwAijutYRGHvR1HFR015jKyA0yWRXdXMj1+Z1PRu3DsMaE8GNxg9HKgQtMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987114; c=relaxed/simple;
	bh=zD1rnn+Rel7gHYP8+RKof8tStONNoBRxxc9ADR3yfXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BejItLMgkDordBeQVCUt75N2e0MpDgowdBp4CXPzGDgpGqGbr3bYj5WWMxB0/EHB8owAUatQ0DuzwBy4laVS8Ku1sRlCRrCWQiPgoU0gImmBXZerPbYdoBWFSLzaCwi06prYNbLTKgup6j+Kd9sJYL4ru+0vMUwBJ1zhCj9QX9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F19D5227A87; Thu,  7 Nov 2024 14:45:03 +0100 (CET)
Date: Thu, 7 Nov 2024 14:45:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: zhangguopeng <zhangguopeng@kylinos.cn>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de,
	ming.lei@redhat.com, yukuai3@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: Replace sprintf() with sysfs_emit()
Message-ID: <20241107134502.GA14814@lst.de>
References: <20241107104258.29742-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107104258.29742-1-zhangguopeng@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 07, 2024 at 06:42:58PM +0800, zhangguopeng wrote:
> Per Documentation/filesystems/sysfs.rst, show() should only use
> sysfs_emit() or sysfs_emit_at() when formatting the value to be
> returned to user space.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

