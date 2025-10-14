Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C1D2EA721
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479181; cv=none; b=V3W5svPyDqQtUZXeWMfBVCLkXmENQAmY8uH59pPT+oI9SoFEQdH/MtSpvNKjpJ6Kzmwbe7TnVV0FG9gYBxvC+PNBaWAActhxvtAiCWqW8dU1KrvlEdfZCElh8P2ZbuilftWt/7YeXQPUKLP0or+L/D9y3WcI/rvUpKsKilH0OZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479181; c=relaxed/simple;
	bh=QM3zdySrGhZmJEu8ZKJnO7jYikvGc/g10gAUYSwccn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6wtZ6m/mGErdIfjYaedyV/A/tjjCf7ktZwzwDCkj2Lr7naadIpPzPjf9hwueSVqUhfQDHV/zD2xUacjp2VLK+50hdzJWDUpVIp9k095dlle7/KN3Ok/kIyE864T20d88RkqLdMJbwav58cBQwbdv40zHq/KQaKTPgzZTjFGgbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0n9loqp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0n9loqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F240C4CEE7;
	Tue, 14 Oct 2025 21:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760479180;
	bh=QM3zdySrGhZmJEu8ZKJnO7jYikvGc/g10gAUYSwccn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0n9loqp/0qIsTucfoKQj8BfEYrK21MTZrFclkhiTTWoW2V1bWb2jCSsRuBT73EXT
	 QoWAv7v/AMk1GyIhdp7Ktdq0EbZ9CHfiylVGdUESmOC9wFy9hlg9Hhc2WM6EoTb9+z
	 rwwHNdktu9f9HlOYYxuxLqmTaNRjHjVXMno87R61cBNHGtRg3rVb8NLxRsiQO2WuxV
	 2kNsq3UCp0yQE/jpuSHBhL5MCRvgH77vy9zKHuEBHJkPKcKU3aUe99Cx9RydSR35ee
	 pxo8vKxv4MI+atJVkcHG+I+k9Sg/3Kb3QPFFabGXL4Li/FXV5V200yyHr+tu/oiLct
	 RusSe6L0DKXvQ==
Date: Tue, 14 Oct 2025 15:59:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH blktests] create a test for direct io offsets
Message-ID: <aO7HyvtEXv6h37PI@kbusch-mbp>
References: <20251014205420.941424-1-kbusch@meta.com>
 <ac0c15bb-7679-490a-93aa-ffdc7635ec3f@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac0c15bb-7679-490a-93aa-ffdc7635ec3f@acm.org>

On Tue, Oct 14, 2025 at 02:21:20PM -0700, Bart Van Assche wrote:
> On 10/14/25 1:54 PM, Keith Busch wrote:
> > +static void find_mount_point(const char *filepath, char *mount_point,
> > +			     size_t mp_len)
> > +{
> > +	char path[PATH_MAX - 1], abs_path[PATH_MAX], *pos;
> > +	struct stat file_stat, mp_stat, parent_stat;
> 
> Why C instead of C++? Any code that manipulates strings is usually
> significantly easier to write in C++ rather than C.

The only reason I have is that I'm not a very good C++ coder.
 
> > +	strncpy(mount_point, path, mp_len - 1);
> > +	mount_point[mp_len - 1] = '\0';
> 
> Why strncpy() instead of strdup()?

I'm just using stack strings here, avoiding any heap allocations.

> > +	else if (len >= 4 && p > base && p < base + len - 1) {
> > +		if ((strncmp(base, "sd", 2) == 0 ||
> > +		     strncmp(base, "hd", 2) == 0 ||
> > +		     strncmp(base, "vd", 2) == 0) &&
> > +		     (*p >= 'a' && *p <= 'z'))
> > +			*(p + 1) = '\0';
> > +	}
> 
> Deriving the disk name from a partition name by stripping a suffix is
> fragile.

Completely agree.

> A better way is to iterate over /sys/class/block/*/*. See also
> the PartitionParent() function in https://cs.android.com/android/platform/superproject/main/+/main:system/core/fs_mgr/blockdev.cpp.

Thanks for the pointer.

> > +static void read_sysfs_attr(char *path, unsigned long *value)
> > +{
> > +	FILE *f;
> > +	int ret;
> > +
> > +	f = fopen(path, "r");
> > +	if (!f)
> > +		err(ENOENT, "%s", path);
> > +
> > +	ret = fscanf(f, "%lu", value);
> > +	fclose(f);
> > +	if (ret != 1)
> > +		err(ENOENT, "%s", basename(path));
> > +}
> 
> Why is the result stored in a pointer argument instead of returning it
> as return value?

No particular reason.
 
> > +static void read_queue_attrs(const char *path)
> > +{
> > +	char attr[PATH_MAX];
> > +
> > +	if (snprintf(attr, sizeof(attr), "%s/max_segments", path) < 0)
> > +		err(errno, "max_segments");
> > +	read_sysfs_attr(attr, &max_segments);
> 
> Has it been considered to make read_sysfs_attr() accept a format string
> + arguments? I think that would make the code in this function more
> compact.

That sounds good to me.

Though all the comments are about the boiler plate parameter extraction.
That was supposed to be the least interesting part about this patch :)
