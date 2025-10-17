Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25966340D9C
	for <linux-block@vger.kernel.org>; Fri, 17 Oct 2025 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699616; cv=none; b=T5zszaZwGU1/kjys7X6VA4KgNwddTXkDvG7kDaS1glYXVqH9++AsOsDFk7h4dEmLsaF1teT5g8NiK+zHqnQbu4jZ4FSh/H2/accX7M9JVFMmM4R1GijpSN9Sj1jv0bpmOsulnmqqeYVgr6oKttblaELsjrgBbZFxone3Zg2LZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699616; c=relaxed/simple;
	bh=+WJ/9OJPmc+hPEHm8wSsTYnPF3JXQKHX+ZFF9M2Xe1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOuLHJdm5vGla5T+uAEoJPuLXD0YvlJmexaOH5d8BIgnzhkDbJXJw3HPQAhCc996fp1AXaMfOYU/ZNx1Pb4PXWBLhVoBgln+rC98Fd5PU/zlEr81fyugFAWOvhWGZUnDFwj/vUNmeCNXDK2jsUQi0+MhaAqqZaPxKh2Ek//t1nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eQ3K2gKB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eQ3K2gKB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=22VuUOveu5Gg+2TfY24/26ZiEUCfRQ0vbQQnEdzRkQE=; b=eQ3K2gKBQeqP2cU6xvK8KTXXcC
	nxL+xswCC5KeVmMvE6GTTC0gi0iKVBtHd8RZufI+LcGptue6KifRcJc9HH0YAiV+zUyiDzqLhNTdU
	xJbZPO94nh3jKrnRE1FqBuH3Tr8HBHpf6iDXODGls++R9vP1NWNJ2PmObiJrHu3b1EW+pmqk2uNwg
	1LOuP3ssnaTrQeft7g92Gsi3r/xbLWwtmKfRBljc9KB0jWf0SEVi6WJTOFMxL2QmEANBG63fWwooB
	B0xmeDYMWr/dl84A/HckvR3ORME5EQzPyYMJ32Ri17B4sNsKXlxIFK3IqVENVh4JyTPCJwcmifxIs
	nvICtvlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9iOq-00000007dqc-1VEj;
	Fri, 17 Oct 2025 11:13:32 +0000
Date: Fri, 17 Oct 2025 04:13:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests] create a test for direct io offsets
Message-ID: <aPIk3Ng8JXs-3Pye@infradead.org>
References: <20251014205420.941424-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014205420.941424-1-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +static void init_kernel_version()
> +{
> +	struct utsname buffer;
> +	char *major_version_str;
> +	char *minor_version_str;
> +	if (uname(&buffer) != 0)
> +		err(errno, "uname");
> +
> +	major_version_str = strtok(buffer.release, ".");
> +	minor_version_str = strtok(NULL, ".");
> +
> +	kernel_major = strtol(major_version_str, NULL, 0);
> +	kernel_minor = strtol(minor_version_str, NULL, 0);
> +}

Testing for specific kernel versions is probably going to fall
flat when this stuff gets backported..  I just realize that maybe
we just need a statx / fsxattr flag to report that this is supported
to make everyones life easier?  statx probably won't make Christian
happy, but now that the fsxattr stuff is in common code that seems
like an easy enough option to rush into 6.18 still.

I.e., we should find a way to remove all the need to find the kernel
version, mount point and bdev from mountpoint.  Especially as the
latter won't work for multi-device configurations like btrfs or
the XFS rtdev.  My rule of thumb for new I/O path features is that
the application should be able to discover everything it needs just
using the FD used for I/O as that is a huge differenciator for
usability.

