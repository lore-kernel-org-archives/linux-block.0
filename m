Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE29227EFEA;
	Fri, 11 Jul 2025 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228290; cv=none; b=NcZM8byFUW/o0ulhJYggF68wViUJtHWGs8RM0nJT8OYDTzOyFiRef6TM6hZg3HntgCkqZfZdBwLQJNjCqanjZlDVdnmRQCD7UZa/tgEIXYCyG97AnjdOjPxfEjvXB4JsYunZL+sri+6j7XTmU35k7gOzf51N/zrilJrxXyG63aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228290; c=relaxed/simple;
	bh=HA6odsRfvuXb37XCf1ZynNmgsx3zfWYCrcUWbP1YRUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRP1lRU9P82hZc8E2KuT4OEl4nOX+R2kGep+DZ+eLHcSIxsfD7b1AQQhDUusVkNs3tEzV+WKq1NiUH+spfdFM3vO/LFmyA8mrsf9EqARqef2LuRzEB0QqmxuB3zEhXBEBqC9O8OOqIZRUytLi9w+EL5y0XnGfG6G3lpJGqIx1Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pr6pZxYa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pr6pZxYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D35C4CEED;
	Fri, 11 Jul 2025 10:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752228289;
	bh=HA6odsRfvuXb37XCf1ZynNmgsx3zfWYCrcUWbP1YRUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pr6pZxYadE/l0QdMqbqEomQm0PiupYaiCFt8V7IYJq7YsOOILOastKQIxSsXfwrp7
	 ZUi6FrG/ZVD7//8/F6mx2QvRsYuzfOMFk0NA3n4rmf2AdbOAtXgRfRRgcvtw5BXBUf
	 Eb2QVl3nSNXbo4ORRpXoaUNTCQmVo4ClYZ5JgZP9RmlVwA24SJ6qKGR5vz4ntOOt8D
	 dBkjT9QtkwohylMQoLQduCnwUj3ZqXm3TsSTrtePH6f1V9y5XRxVpKm7dfBSuY1sps
	 IdrCG/LWcBDTf+G8O+FtoNw8mnEVZ5c5cus21ki/XGkjLAtI1+YFMjb5mQE/C6UYsN
	 sNPlH6rSWhwkg==
Date: Fri, 11 Jul 2025 12:04:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Anuj Gupta <anuj20.g@samsung.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Caleb Sander Mateos <csander@purestorage.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
Message-ID: <20250711-ohren-hebel-4790bafe4bb4@brauner>
References: <20250711084708.2714436-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711084708.2714436-1-arnd@kernel.org>

On Fri, Jul 11, 2025 at 10:46:51AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Anders and Naresh found that the addition of the FS_IOC_GETLBMD_CAP
> handling in the blockdev ioctl handler breaks all ioctls with
> _IOC_NR==2, as the new command is not added to the switch but only
> a few of the command bits are check.
> 
> Move the check into the blk_get_meta_cap() function itself and make
> it return -ENOIOCTLCMD for any unsupported command code, including
> those with a smaller size that previously returned -EINVAL.
> 
> For consistency this also drops the check for NULL 'arg' that
> is really useless, as any invalid pointer should return -EFAULT.
> 
> Fixes: 9eb22f7fedfc ("fs: add ioctl to query metadata and protection info capabilities")
> Link: https://lore.kernel.org/all/CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com/
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: add the check in blk-integrity.c instead of ioctl.c
> 
> I've left out the maximum-size check this time, as there was no
> consensus on whether there should be one, or what value.
> 
> We still need to come up with a better way of handling these in
> general, for now the patch just addresses the immediate regression
> that Naresh found.
> 
> I have also sent a handful of patches for other drivers that have
> variations of the same bug.

Arnd, let me know how I can help!
