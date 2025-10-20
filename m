Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA64285CB6
	for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977243; cv=none; b=QK2byS6UNwBReFzaYNSHEImXg/9PGW9ga6EC6jXN2xhWzbZKH/6LSuKuIyDMoeqYrSKoMJfKK25uXzT9FiaijUBjVOuWqbBHl6FrHie0RB+MTc3gUJgYtpNNQG1jQE2nN/bDGjwRZF+fETZNHUWIDz89RvefJTcsFZ+k55/E69Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977243; c=relaxed/simple;
	bh=hMr806873o0kzbH5+IOkn8xrl0zD+/mkq1kZh5X9kQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cW5nwRiY0C8VnAqySQS+LzUugFpgRxXU0I2V2U0POTNOryea1/j+NnIskuzjxb0ZeOHqLtSdWU3B48+3m2TVs5g18o5UjquFtyNBNewcLdwjz3uISiMBuX7Q2QFTVLggShNdALAmbE5zpnLLrAfFSexn7nypyFiE7MMzO29l6e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/1+Yx/t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/1+Yx/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B2FC4CEF9;
	Mon, 20 Oct 2025 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977242;
	bh=hMr806873o0kzbH5+IOkn8xrl0zD+/mkq1kZh5X9kQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/1+Yx/tP3Yh1lGtKAf7DFDKi3foiH/pztuHjBi0K4GF0+ynrI9ni5z8pUyTuWyzS
	 6pvPZEglKBiW5Q8b4C8hLJKC5BTHf54dgyr+vBI4Bgxd+GZogUCtUwS7TuwX3M2EQp
	 QRWSh+6c2sGBzRVAWt3lra+GTIsWTVruOouEjacKgqkBMzX+FQj1BaaQiUWemKHDKA
	 bmvIOJ+I+gJdk6qM+aroLorhcShljS9z9pDY9eaMRuJizUsr6U1UWGnZAnQ/7zYpbZ
	 BF6u+z81Bs+9Ojfo/zyO15iwPwuh4MZEYEBnMs5jpcj2NMuXIPohmoeBXq+4STMben
	 Xj2RaA/foqExQ==
Date: Mon, 20 Oct 2025 10:20:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH blktests] create a test for direct io offsets
Message-ID: <aPZhWIokZf0K-Ma9@kbusch-mbp>
References: <20251014205420.941424-1-kbusch@meta.com>
 <aPIk3Ng8JXs-3Pye@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPIk3Ng8JXs-3Pye@infradead.org>

On Fri, Oct 17, 2025 at 04:13:32AM -0700, Christoph Hellwig wrote:
> > +static void init_kernel_version()
> > +{
> > +	struct utsname buffer;
> > +	char *major_version_str;
> > +	char *minor_version_str;
> > +	if (uname(&buffer) != 0)
> > +		err(errno, "uname");
> > +
> > +	major_version_str = strtok(buffer.release, ".");
> > +	minor_version_str = strtok(NULL, ".");
> > +
> > +	kernel_major = strtol(major_version_str, NULL, 0);
> > +	kernel_minor = strtol(minor_version_str, NULL, 0);
> > +}
> 
> Testing for specific kernel versions is probably going to fall
> flat when this stuff gets backported..  I just realize that maybe
> we just need a statx / fsxattr flag to report that this is supported
> to make everyones life easier?  statx probably won't make Christian
> happy, but now that the fsxattr stuff is in common code that seems
> like an easy enough option to rush into 6.18 still.

In addition to a flag to say direct-io can use block data split among
multiple vectors, there's two currently unreported attributes you need
to know in order to successfuly use direct-io like this: max sectors and
virtual boundary mask. The max sectors attribute is needed to know
exactly how many vectors you can insert before the total length needs to
add up to a block size.

Adding these to statx or fsxattr will help remove a ton of crap from
this test since I could remove all the stuff extracting it out of sysfs
from any given file.
