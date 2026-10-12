Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51CB37AA7A;
	Mon, 12 Oct 2026 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830857; cv=none; b=RqwXE3x8Ya7QZC/Cj1egLevcj02avL91jF9IBfNz7MtVqDi1hw+0LdLKaGriR9+O5x6BRdEnNJXaUPiG4slDWlf0/snYjtAjh9CLQSC9JiGHR1lRVny1LsI6Nn8pC63/B74gJV2Y0FSLV6zL6b/IpV+OHuauCvH8kCkGDgPfAb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830857; c=relaxed/simple;
	bh=oJxczYoIKvDBQ5zFxN1/gdqdvoFLrbV/jwU4zAmYTjg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jnxHhmMiDVjcUSXe/FQn5ojBz4dDj/y1ivT/UZMFIGcZabwA4qRqPy1KGhIUpqw5RQyuADG4IeLKsXS5RxvUAScmFl/r9PxZSM/6hbHPfYGjIBlXzuqxbMbdY+77edHVQ3BdmGgpAzNXN8xKaIuZ3pGyhXQ8453AMHkNCY4/HYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C25FKYgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C25FKYgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A02D1F0089B;
	Mon, 12 Oct 2026 18:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791830856;
	bh=bjyexX5Mdmd10d+g2Q4Z6F7Ba1wqFyJ6CsFIlEzvwno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C25FKYgRTd8HDTeUE4QATnKIH6BgI3kaEbOkok2oKfioYrLjlMDvWu/40jLTGAIhy
	 +gMH7kAZGGc51e8eiJnCmpybltvMneWDrN62mIrWKh42QanHigxYq6RV82MxXV+Ppm
	 CMZ+3LeDD7FRYWUZwVDHJWVBP8YX/lKsBfCAag7Q=
Date: Mon, 12 Oct 2026 11:47:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iov_iter: validate first nonempty segment for bvec
 alignment
Message-Id: <20261012114735.896effbe08a5b8c03d1774fa@linux-foundation.org>
In-Reply-To: <20261012065520.1089147-1-4ncienth@gmail.com>
References: <20261012065520.1089147-1-4ncienth@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 15:55:20 +0900 Daehyeon Ko <4ncienth@gmail.com> wrote:

> iov_iter_extract_bvecs() checks the current IOVEC or KVEC segment against
> the block device's DMA alignment before extracting pages.  Empty segments
> are valid, but the check uses iter_iov_addr() and iter_iov_len() directly
> while first_iovec_segment(), used by the extraction path, skips them.
> 
> An aligned empty segment followed by a misaligned nonempty segment
> therefore passes the check and produces misaligned bvecs.  An unprivileged
> O_DIRECT preadv() reproduced this on a regular ext4 file above brd.  The
> equivalent nonempty-leading vector returned -EINVAL, while the
> empty-leading vector completed 4096 bytes.  This bypasses the validation
> added for CVE-2026-89584.
> 
> When the current segment is empty but the iterator still contains data, use
> first_iovec_segment() to select and validate the same segment that page
> extraction will use.  Keep the existing constant-time fast path for the
> normal nonempty case.

Thanks.

Sashiko:
	https://sashiko.dev/#/patchset/20261012065520.1089147-1-4ncienth@gmail.com

It looks like that issue is pre-existing, but could also be addressed
by altering your proposed change.

