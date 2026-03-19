Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EB440DFDD
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949398; cv=none; b=gKzu8x32jxybcRMCK3siNP+OO+mYkO49pFTTtn8TXS73fyzfy+3krXJi8gpwR8Jc//aIqUoxi7Y3ESwA901i0rllFc0TXcORZcYdvHeDswDuURB7kLBV9vQlrOmm4OEe8/Mip05KIxbrBrN+quQ8qJGRMHgrcCKNt9C1D2o1G20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949398; c=relaxed/simple;
	bh=qFUNBaFcauqJNkia+FJ9ooLZtYVwfF0oiSXnhIQtmuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3/WiYXS6mt3s6O2zPDb6NdbbRjWccnlHeG0kysyK3gw/8gKbjZOi4ixtCR2eX9TgvL90+lNvBxZgW0cMzzqMqvU4teHzyTC3QQMqKL49HDr/Gz47xD40zCSh2PbFXdVbwbCU1XLBpsVfnM1hL9LO1aiUL9jZRiZG7aoiwKqHf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLZMn7KA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLZMn7KA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B01C19424;
	Thu, 19 Mar 2026 19:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773949398;
	bh=qFUNBaFcauqJNkia+FJ9ooLZtYVwfF0oiSXnhIQtmuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uLZMn7KA++G0+Wly/p3EpL9zqxKe0qYTayOo+i7GlkAbp6El+s8w5g6j50qRIrzsB
	 NkYFV0FK9f+79Kwz7dUXZr3STxNt5tUWMW6dq2PHEnf5xMBp23MmsxaVCGiCXzZBAh
	 BPZE9ukoxmE0oFJs0649LDIW8p/c9gV26lJ6zB0oyHIoU94AmQkwKqVibLnI7BFNHs
	 dVynjwklYnOFd51/LcSdDtWwK7k+hxUyMZqO2SO9KzG+Z6bJKIX/ePnDWYu0mV3V01
	 beLgsDaB37hJvQwaKJqq4PS62EwPUOrYwkr8HsflP1mT0Mv6NQ1d7TZ4YVxQ3Z/phR
	 TO3qHn/VTYYxw==
Date: Thu, 19 Mar 2026 12:43:16 -0700
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Brian Geffon <bgeffon@google.com>,
	Richard Chang <richardycc@google.com>, linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] zram: do not slot_free() written-back slots
Message-ID: <abxR1Pm-JksGZYly@google.com>
References: <20260319034912.1894770-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319034912.1894770-1-senozhatsky@chromium.org>

On Thu, Mar 19, 2026 at 12:44:56PM +0900, Sergey Senozhatsky wrote:
> slot_free() basically completely resets the slots by clearing
> all of its flags and attributes.  While zram_writeback_complete()
> restores some of flags back (those that are necessary for async
> read decompression) we still lose a lot of slot's metadata.  For
> example, slot's ac-time, or ZRAM_INCOMPRESSIBLE.
> 
> Do not slot_free() on writeback, instead clear only those
> flags/attrs that we need to clear.
> 
> Fixes: d38fab605c667 ("zram: introduce compressed data writeback")
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Minchan Kim <minchan@kernel.org>

With small nit about the description in previous comment,
