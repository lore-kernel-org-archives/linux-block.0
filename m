Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329326;
	b=AXjnJPBhhvMVhs3q+e7VhUT9aw1cn86JRzZBJcmuocmXetMWF8p3GhyH5xeRLKZMOd/s
	 iz5pnNLBUDjT1tcTvX2PVTzepa3eY28kxI75u565FlfVQW6jQWSH3C8VHjje7HZfzTJJf
	 vI7iA505mvEk2I8DHAsXijclHncFBqUrW3w/9EhmucegIvdNaT7/XlXBJp+ShJL7P/gq5
	 5/HmnJIH73vzHK9XqLSj/occgkOz1hkNWlcJ1lBVU/FI4flQeXZzOj7ZfBxfjneKYWSBp
	 xqgA4/diqUVr1M4CoiHNd2HHiWZBp42BH+P1dS5eq4YMbwE46s3z+NWHJ950ERJZ/1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329326;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qyPBZSpQjOcOhJDdOO7H9HvPVzvgTK2UU66TCKWXkQw=;
	b=FI8HwAMWH2xK4zvyYVBC41aa2rVyjOrTpnW8qUzSepmeXgjeHD3Dh8FpRcCoqR1237sH
	 LXt6fZD9DIGuhjWTyT+FAOW8qWLi7ymgw8EFIH+M+zRnZOrKj73cexFw88fsvS8QWqau6
	 Fe6hjwNWSMeISk5J0+pnc4xXFCMDoz7tyn/4tFz7LhmRm2Mel7m5YEGVBgfC/REVeYWD2
	 ThaILPi09O34G0goYjqpL/b65hAybfOz3vq4b3Gsd6dsUZS1BYKNNTAbE8ffc2y4tK83o
	 i7rlneuyoiuH90vBjOawmV8hFGRkWGnsecK0TGrIb+HlifVZ7beUNjKOwJJcUGTOkkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=zdj2gBbg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B739606A32C;
	Fri, 30 Oct 2026 03:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=zdj2gBbg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EB71F000C1;
	Fri, 30 Oct 2026 03:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793329326;
	bh=qyPBZSpQjOcOhJDdOO7H9HvPVzvgTK2UU66TCKWXkQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=zdj2gBbgAeReQfQjHbzuJ2hwH63lWKUM1c+KbxLLeEGWR2HOmjFYCMF0vXph8C5tO
	 5e5h7NSPT4i09TJ14R00Ciyd9pYL0RIuLhuR+M1Pq1pJijuTHuYivUwu8GN4GDwVpv
	 uMZCL8Atee0JiF1xV9AfslSy3V7BCAXlWy727VTY=
Date: Thu, 29 Oct 2026 20:02:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Brian Geffon <bgeffon@google.com>, Barry Song <baohua@kernel.org>, Bo
 Zhang <zhangbo0325@gmail.com>, Minchan Kim <minchan@kernel.org>, Richard
 Chang <richardycc@google.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 00/15] zram: redesign zcomp and rework backends
Message-Id: <20261029200205.ee2a4788b8fdba4a75c2edd9@linux-foundation.org>
In-Reply-To: <20261025021839.1542805-1-senozhatsky@chromium.org>
References: <20261025021839.1542805-1-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Oct 2026 11:18:16 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> The series has a number of memory usage optimisations and fixes
> that result in savings from double digits KB to triple digits
> KB per-context/per-CPU, depending on backend and its configuration.
> More details are in the corresponding commit messages.

Thanks, I'll queue this.

>  drivers/block/zram/backend_842.c     |   6 +-
>  drivers/block/zram/backend_deflate.c |  98 +++++----
>  drivers/block/zram/backend_lz4.c     |  85 ++------
>  drivers/block/zram/backend_lz4hc.c   | 105 ++++------
>  drivers/block/zram/backend_lzo.c     |   6 +-
>  drivers/block/zram/backend_lzorle.c  |   6 +-
>  drivers/block/zram/backend_zstd.c    | 133 +++++++-----
>  drivers/block/zram/zcomp.c           | 298 +++++++++++++++++++++++----
>  drivers/block/zram/zcomp.h           |  53 ++++-
>  drivers/block/zram/zram_drv.c        |  71 ++++---
>  10 files changed, 546 insertions(+), 315 deletions(-)

I've always put zram material into mm.git's mm-unstable/mm-stable branch. 
Because "ram", I guess.

But it's a blockdev, so I'll henceforth carry it in mm.git's
mm-nonmm-unstable/mm-nonmm-stable branches.

