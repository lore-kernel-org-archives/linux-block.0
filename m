Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437363D0926
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093137; cv=none; b=nkaedG4ku8maOfTP/2d2YK1g1JgL3e2GuEFtxxXg1+28lSHGgK+A/jARBSzj+UjsOkLvY5gpbS4nKey7zISMaDTQ9Li/VxV1xJdXxiCn4V+qNQUhzUjQhV7ZugoDwSr1Y+uhUkK9/nLUOpLavfHbBpRhgnIVT94Ru63S+JVa+nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093137; c=relaxed/simple;
	bh=Caoz15xueDbeL9nAkqBm7PpGrwSJjsT7uulOTHKxrcc=;
	h=Subject:Mime-Version:References:In-Reply-To:Content-Type:Date:To:
	 Cc:From:Message-Id; b=YLeYE2ft58u12NMgEuK2VcUY6Eb1kbnLqWJ6voFNxcQ+hFCZdwg60iFdaiedxPoN0+bQhL0TDb0LZNlCKLfFI8l2xkO2U+p6edTweYwim/C01dq0L39Y0jpa6vCiFpdBkPyO69fxiXdFgnjUCxJl9mmN4liNQv2xm5ngPgSaNPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QBhzScvu; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QBhzScvu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779093123; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Caoz15xueDbeL9nAkqBm7PpGrwSJjsT7uulOTHKxrcc=;
 b=QBhzScvubHMFL38iIlrDy6dEqTcmSGzYZon1eZb1FoZ6l7d8Anwf0eXoR9sLNjiajs4tIh
 QJKNTZUZEh4q1Jhnqg+8JYXepSqri2E0sC1jxNV+fVw42JpSGmt6nYk8bYkwH1Yg1rN0cq
 UdS7Mu2Wzr0Cli5b4XwZ/UMPOGRV24ES4nssJBb6qaiG3pVTrTBAhZ0qknKsPvf6DOfKug
 7v4gw38u2jl9tG9GFufbzTjipdqiLI47h45dimHz8cU+88q5/3AUHXwa6XsZ9a0KZc1U+g
 Zzg1WN3Fan5CNKhvFux6Aykgz6gIRUaVPLARglxit4aTpnH+wEw3LyI1yUXzuQ==
Subject: Re: [PATCH] block: fix pages array leak in bio_map_user_iov error path
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260509040119.1116544-1-yinxin.x@bytedance.com>
In-Reply-To: <20260509040119.1116544-1-yinxin.x@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 16:31:57 +0800
To: "Jens Axboe" <axboe@kernel.dk>, "dhowells" <dhowells@redhat.com>
Cc: "linux-block" <linux-block@vger.kernel.org>, 
	"linux-kernel" <linux-kernel@vger.kernel.org>, 
	"stable" <stable@vger.kernel.org>
From: =?utf-8?q?=E5=B0=B9=E6=AC=A3?= <yinxin.x@bytedance.com>
X-Lms-Return-Path: <lba+16a0ace81+6fb701+vger.kernel.org+yinxin.x@bytedance.com>
Message-Id: <b0a5d388d0b2cb320744535d7f9d8f59e469aa88.58c4717d.1c34.424e.88d9.43d76ef83dce@bytedance.com>


> From: "Xin Yin"<yinxin.x@bytedance.com>
> Date:=C2=A0 Sat, May 9, 2026, 12:23
> Subject:=C2=A0 [PATCH] block: fix pages array leak in bio_map_user_iov er=
ror path
> To: <axboe@kernel.dk>, <dhowells@redhat.com>
> Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Xin Y=
in"<yinxin.x@bytedance.com>, <stable@vger.kernel.org>
> In bio_map_user_iov(), when iov_iter_extract_pages() is called with pages
> set to NULL (because nr_vecs > UIO_FASTIOV), want_pages_array() internall=
y
> allocates a pages array via kvmalloc_array(). If iov_iter_extract_pages()
> subsequently returns bytes <=3D 0 (e.g., due to pin_user_pages_fast()
> failure), the code jumps to out_unmap without freeing the dynamically
> allocated pages array, causing a memory leak detectable by kmemleak.
>=C2=A0
> This can be triggered from userspace by issuing an SG_IO v4 ioctl on a
> bsg device with a large din_xfer_len and an invalid din_xferp (mapped
> PROT_NONE), which causes pin_user_pages_fast() to fail after the pages
> array has already been allocated by want_pages_array().
>=C2=A0
> The kmemleak backtrace looks like:
>=C2=A0
> =C2=A0 unreferenced object 0xffff... (size 2048):
> =C2=A0 =C2=A0 backtrace (crc 0):
> =C2=A0 =C2=A0 =C2=A0 kvmalloc_node+0x...
> =C2=A0 =C2=A0 =C2=A0 want_pages_array+0x...
> =C2=A0 =C2=A0 =C2=A0 iov_iter_extract_pages+0x...
> =C2=A0 =C2=A0 =C2=A0 bio_map_user_iov+0x...
> =C2=A0 =C2=A0 =C2=A0 blk_rq_map_user_iov+0x...
> =C2=A0 =C2=A0 =C2=A0 blk_rq_map_user+0x...
> =C2=A0 =C2=A0 =C2=A0 bsg_transport_sg_io_fn+0x...
>=C2=A0
> Fix this by freeing the dynamically allocated pages array (when it
> differs from the on-stack stack_pages) before jumping to the error path.
>=C2=A0
> Fixes: 403b6fb8dac1 ("block: convert bio_map_user_iov to use iov_iter_ext=
ract_pages")
> Cc: stable@vger.kernel.org # 6.5+
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
> =C2=A0block/blk-map.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=C2=A0
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 0aadbaf7a9ddd..5b9f14caad4f9 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -304,6 +304,8 @@ static int bio_map_user_iov(struct request *rq, struc=
t iov_iter *iter,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bytes =3D i=
ov_iter_extract_pages(iter, &pages, LONG_MAX,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 nr_vecs, extraction_flags, &offs);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikel=
y(bytes <=3D 0)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (pages !=3D stack_pages)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kvfree(pages);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ret =3D bytes ? bytes : -EFAULT;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0goto out_unmap;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> --=C2=A0
> 2.20.1
>
Hi Jens

Gentle ping on this patch.

This patch fixes a memory leak in bio_map_user_iov() that only affects
stable kernels (6.5+) carrying commit 403b6fb8dac1. Mainline resolved
this through a later refactoring that removed the affected code path
entirely, so there is no upstream commit to backport.

Could this be picked up for 6.6.y?

Thanks,
Xin Yin
