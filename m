Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51F12B73;
	Fri,  1 Nov 2024 00:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730421102; cv=none; b=WYFT3PVpOfD0TPbL4J6xBd8wsGHoRzq9OvVP7x53jlqaX7JMwTL3vIfFsbKYWxFZhjG5IBfHwTss82DbwtMadTzZo2pX6pAbCvoJKrP04P75mrgK/2PqC1FPV+d0ayZ4fdDDQmARXforChubEET+Q3WFjkaeqqDrC3Vuee64YGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730421102; c=relaxed/simple;
	bh=ZYzfPKnXeqQKl2UoKwdex+ZdgecqpyO6d7Co5BOCub0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/NGmWREwlHd899+1x4E4TqCYvR953vOSu7RmSUPyM3ULtSIJ/7p82G3/EYIiahSYFu/Dyd3Maaptxb3ZtttuFQvi9uN0OIHjgMirtbQ3Yhbglcipz9d5Ka1591w8t4O/Gg0ma+qhtMRn2K1X6mJkd4tAmJVJA7P+UhMq3saOaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5SZVedO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5SZVedO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3AAC4CECF;
	Fri,  1 Nov 2024 00:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730421101;
	bh=ZYzfPKnXeqQKl2UoKwdex+ZdgecqpyO6d7Co5BOCub0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5SZVedO7uxnkhggwZtwe8fM+j03A2+S7QsYGx+4b4jVPJlREuuFy+eQ0d4UHNBxx
	 7Ok0EewzxVB7XDeeOQrhOem9pofzqgKwfiJugS8Qva2/1VwOHodbkhvnMXhyJSWld+
	 BIfpxKyIxDC2BTDqoXOARZK6gEmerc32gN62ni9k9IZW+GD0PaL5MJ1J60dwoygkfY
	 3gCvnArKZYsweL4e9eU8hfOBRN0l3u7uRfroGxtuOfTl85X7q+Qqq/MhPj+SzOLJqP
	 MFlP4VyxHMN1gjemaJGEGBHYyIvduDuL7TeVoqovwvIygkBRTBtuMyirwxbnPveVrr
	 4YLf6fqEDy72g==
Date: Thu, 31 Oct 2024 17:31:40 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Daniel Gomez <da.gomez@samsung.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>,
	Yang Erkun <yangerkun@huaweicloud.com>, linux-block@vger.kernel.org,
	yangerkun@huawei.com, axboe@kernel.dk, ulf.hansson@linaro.org,
	hch@lst.de, houtao1@huawei.com, "yukuai (C)" <yukuai3@huawei.com>,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH] brd: fix null pointer when modprobe brd
Message-ID: <ZyQhbHxDTRXTJgIx@bombadil.infradead.org>
References: <20241025070511.932879-1-yangerkun@huaweicloud.com>
 <a55c8d7e-cfd7-4ab9-ab45-bd7fdecaaf3c@I-love.SAKURA.ne.jp>
 <05915eac-e5c7-c293-d960-a781e91fd23d@huaweicloud.com>
 <62e97223-a508-4174-9ba0-6f897149a825@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62e97223-a508-4174-9ba0-6f897149a825@I-love.SAKURA.ne.jp>

On Sat, Oct 26, 2024 at 02:55:59PM +0900, Tetsuo Handa wrote:
> If bdev_open() can grab a reference before module's initialization phase
> completes is a problem,

Yes, that would indicate there's a bug and alas we have a regression.
Commit d1909c0221739 ("module: Don't ignore errors from
set_memory_XX()") merged on v6.9 introduced a regression, allowing
module init to start and later us failing module initialization to
complete. So to be clear, there's a possible transition from live to
not live right away.

This was discussed in this thread:

https://lore.kernel.org/all/Zuv0nmFblHUwuT8v@bombadil.infradead.org/T/#u

> I think that we can fix the problem with just
> 
>  int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
>  	      const struct blk_holder_ops *hops, struct file *bdev_file)
>  {
>  (...snipped...)
>  	ret = -ENXIO;
>  	if (!disk_live(disk))
>  		goto abort_claiming;
> -	if (!try_module_get(disk->fops->owner))
> +	if ((disk->fops->owner && module_is_coming(disk->fops->owner)) || !try_module_get(disk->fops->owner))
>  		goto abort_claiming;
>  	ret = -EBUSY;
>  	if (!bdev_may_open(bdev, mode))
>  (...snipped...)
>  }
> 
> change. It would be cleaner if we can do
> 
>  bool try_module_get(struct module *module)
>  {
>  	bool ret = true;
>  
>  	if (module) {
>  		/* Note: here, we can fail to get a reference */
> -		if (likely(module_is_live(module) &&
> +		if (likely(module_is_live(module) && !module_is_coming(module) &&
>  			   atomic_inc_not_zero(&module->refcnt) != 0))
>  			trace_module_get(module, _RET_IP_);
>  		else
>  			ret = false;
>  	}
>  	return ret;
>  }
> 
> but I don't know if this change breaks something.

As I see it, if we fix the above regression I can't see how a module
being live can transition into coming other than the regression above.

  Luis
