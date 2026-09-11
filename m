Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52973C3F7D;
	Fri, 11 Sep 2026 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170894; cv=none; b=mghi2b3+tW1GcxaNd6YJ1r/qx86/UNErukKV/94tMkW0qDcn2GFxEra6GM2ledoIDySln1gkqucfpW7yIZJDuUKXwxVksjVe7WCMWUW0yhfzwLGRuf2bsOFYYMYyZd3Y/5Xi4mrvBYkc4df0uj9cVxqMz55WUNTZ46t7H+1tCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170894; c=relaxed/simple;
	bh=w7Il/r3fxJX3eElLw9gE1szRQycPaBFiM3D3/emL5S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBQpXkBwtXnm8kU1QiEYbVlJxIZqGTjqVkzCaJsBYWkgYXqnt4e6ui9Pl5094H0knrs473yNeUDygib7OQJ7sZgA02/v1KfLuufh7MBJJF19QnZo4jijledVN22pmerWd4AhqzwxqEoZoMQl1ZUDS9UXNFZ2lXcaHoQgVCuB99E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpt87xQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpt87xQZ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2AC8E1F000FF;
	Fri, 11 Sep 2026 23:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789170892;
	bh=0Ah6nDX+H6aEft6Xraj4xE0JoGU9OyYYiZe/wFZlXHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fpt87xQZ29bC2rNErR5EbgeXCO/6S7zKxmitINtIcbflxJP3zGd2ahlvz99YQhfnb
	 /Vxr0ZRejkx46apSQeAehipJ7F8fg4rbZ1D/NDpLyjXL2jqy8OXkKFt/WFXyDL+hei
	 4JzyZc700TtBr7FmE7OItJsM+dZW7/rWjGTmYmmWTqMFKxH6HGwma9IVEd7ZeKegja
	 sartZFsP8RWco7tVMCeslVvVl8b3NL97aAL7bc0qUyZcw7eJLqKV5m+w+2wZQA8djF
	 dgTroE6ohd9Wxb/KpIcK+PE942HfikOWH33mA/zqEIatZFS8eZDOBhFEg4LN/3fS7A
	 QJ5tQYWFXKNIQ==
Date: Fri, 11 Sep 2026 16:54:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix the thaw_bdev reference in bdev_freeze()
 kernel-doc
Message-ID: <20260911235451.GD6283@frogsfrogsfrogs>
References: <20260911233415.31271-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911233415.31271-1-kmehltretter@gmail.com>

On Sat, Sep 12, 2026 at 01:34:14AM +0200, Karl Mehltretter wrote:
> The kernel-doc comment of bdev_freeze() refers to thaw_bdev, which was
> renamed to bdev_thaw by commit 982c3b305843 ("bdev: rename freeze and
> thaw helpers"). Say bdev_thaw.
> 
> Fixes: 982c3b305843 ("bdev: rename freeze and thaw helpers")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Not sure why I'm on this, but this is correct so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  block/bdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index cd8323083740604da145563aa8e7b55c4f627467..fac74319e9fbacc9cf2bec4a4b043b837a9678ab 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -292,7 +292,7 @@ EXPORT_SYMBOL(sync_blockdev_range);
>   * The reference counter (bd_fsfreeze_count) guarantees that only the last
>   * unfreeze process can unfreeze the frozen filesystem actually when multiple
>   * freeze requests arrive simultaneously. It counts up in bdev_freeze() and
> - * count down in bdev_thaw(). When it becomes 0, thaw_bdev() will unfreeze
> + * count down in bdev_thaw(). When it becomes 0, bdev_thaw() will unfreeze
>   * actually.
>   *
>   * Return: On success zero is returned, negative error code on failure.
> -- 
> 2.39.5 (Apple Git-154)
> 
