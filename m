Received: from mta1.migadu.com (out-155.mta1.migadu.com [95.215.58.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7154AB1A3
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821055; cv=none; b=BrgK9w2IV2ccqeMAg6loYlh1SR0oWjGiqJWW2Xy368F+jscJs78Ml45y0LwUd1L6mjuQjXWpuUJJXmcr8GuhUphNymfxvKICdzUnVr9pmn6MIboeet+rUD5jQU8HBHXQ0p1QgTCmK1vlbBizJClahgsWKhsCz94d+qFMT3cAcqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821055; c=relaxed/simple;
	bh=2v1+d/J72fW/gR2wzEGQhtsLU3oAtt3xczGUdzI/RFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EW3xfQzZm5E5kkQHtRcWM8VnNUaVA73/XoS3n7VWGaPYrr9ydinIsdpui/iMyAcsMlAmi6rfkALrxFkCDndTOk/EgYw/x+XVClJgPW7Kea2btmxh5io6stbFsl7fkLSP3sVKOwTWK702KHosckoziGEre2GxMYpFqYLk9t9h+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vMVz0zux; arc=none smtp.client-ip=95.215.58.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vMVz0zux"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2v1+d/J72fW/gR2wzEGQhtsLU3oAtt3xczGUdzI/RFY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791821048; v=1; x=1792425848;
 b=vMVz0zuxd+ceBw6pJpU0SCtna3laSON+37kzK9Mae4wbWUc9q4kEAJvoLMutaiCpnDd9pzlz
 r1j7Z3nDW4W8VwJCmc8N/Guif7h26dm3fWq8Vp8c/LJ0XfCXLA1h6o9OZypO1Adgu6odIWXxouh
 zFzQUMaqn21gQsMyHma1rVqc=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 281f01c82cb28851;
	Mon, 12 Oct 2026 16:04:08 +0000
X-Mizu-Trace-ID: 281f01c82cb28851
X-Migadu-Flow: FLOW_OUT
Message-ID: <7d331842-5d6c-44e9-929d-2ac730a9cda7@linux.dev>
Date: Mon, 12 Oct 2026 17:04:03 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 4/4] block/052: add a torn atomic write test
 for block devices
To: Tal Zussman <tz2294@columbia.edu>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20261009-blkdev-fixes-tests-v2-0-fcb3599e47f7@columbia.edu>
 <20261009-blkdev-fixes-tests-v2-4-fcb3599e47f7@columbia.edu>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20261009-blkdev-fixes-tests-v2-4-fcb3599e47f7@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/26 00:53, Tal Zussman wrote:
> An atomic write is submitted as a single bio, so when its buffer can't
> be fully pinned, the direct I/O path has to fail the write rather than
> submit the pinned part. Otherwise, it submits what was pinned with
> REQ_ATOMIC set and leaves the rest to the buffered fallback, tearing the
> write at the pin boundary.
> 
> This is a regression test for that issue, fixed in the kernel patch
> "block: fail a short atomic pin in bio_iov_iter_get_pages()" [1].
> 
> Issue pwritev2() with RWF_ATOMIC to a scsi_debug device with atomic_wr=1
> from a buffer whose last page is PROT_NONE, so that pinning the buffer
> stops one page short, then read the range back with O_DIRECT and fail if
> it holds a mix of old and new data.
> 
> The write has to span at least two pages so that one can be left
> unpinnable, and the device has to support it atomically. Use the largest
> power of two up to 16K that the device's atomic write unit max allows,
> and skip the test if that is below two pages.
> 
> [1]: https://lore.kernel.org/linux-block/20261009-blkdev-fixes-v6-5-307939c387df@columbia.edu/
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   src/.gitignore          |   1 +
>   src/Makefile            |   1 +
>   src/atomic-write-torn.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/block/052         |  70 ++++++++++++++++++++++++++
>   tests/block/052.out     |   2 +
>   5 files changed, 205 insertions(+)
> 
> diff --git a/src/.gitignore b/src/.gitignore
> index 92c08d1..76a1c5e 100644
> --- a/src/.gitignore
> +++ b/src/.gitignore
> @@ -1,3 +1,4 @@
> +/atomic-write-torn
>   /bio-bounce-read
>   /bio-full-trim
>   /bio-trim-pin-leak
> diff --git a/src/Makefile b/src/Makefile
> index 0bdfd05..54335d9 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -14,6 +14,7 @@ HAVE_C_DEF = $(shell if printf '$(H)include <%s>\n$(H)ifdef %s\nHAVE_%s\n$(H)end
>   		then echo 1;else echo 0; fi)
>   
>   C_TARGETS := \
> +	atomic-write-torn \
>   	bio-bounce-read \
>   	bio-full-trim \
>   	bio-trim-pin-leak \
> diff --git a/src/atomic-write-torn.c b/src/atomic-write-torn.c
> new file mode 100644
> index 0000000..e8ebba3
> --- /dev/null
> +++ b/src/atomic-write-torn.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-3.0+
> +/*
> + * Copyright (C) 2026 Tal Zussman
> + *
> + * Check that a RWF_ATOMIC direct write to a block device is all or nothing
> + * when only part of its buffer can be pinned.
> + *
> + * Fill a range of the device with one byte value, then issue a pwritev2()
> + * with RWF_ATOMIC of a buffer holding another value whose last page is
> + * PROT_NONE, so that pinning the buffer stops one page short. The direct
> + * I/O path must fail the write outright rather than submit what it pinned.
> + *
> + * Read the range back with O_DIRECT and count the bytes of each value. A
> + * mix of old and new bytes means the write was torn.
> + *
> + * usage: atomic-write-torn <blockdev> <length>
> + *
> + * <length> is the size of the atomic write, a power of two of at least two
> + * pages that the device supports. The first <length> bytes of <blockdev>
> + * are overwritten.
> + *
> + * exit:  0 = the write was all or nothing
> + *        1 = setup error
> + *        2 = the write was torn
> + */
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/uio.h>
> +#include <unistd.h>
> +
> +#ifndef RWF_ATOMIC
> +#define RWF_ATOMIC	0x00000040
> +#endif
> +
> +#define EXIT_TORN	2
> +
> +#define OLD	'A'
> +#define NEW	'B'
> +
> +int main(int argc, char **argv)

This code should really test that the block device is atomically 
writable, ideally via statx.

> +{
> +	size_t old_bytes = 0, new_bytes = 0;
> +	size_t len, pgsz, i;
> +	struct iovec iov;
> +	char *buf, *check;
> +	ssize_t ret;
> +	int fd;
> +
> +	if (argc != 3) {
> +		fprintf(stderr, "usage: %s <blockdev> <length>\n", argv[0]);
> +		return 1;
> +	}
> +
> +	pgsz = sysconf(_SC_PAGESIZE);
> +	len = strtoul(argv[2], NULL, 0);
> +	if (len < 2 * pgsz || (len & (len - 1))) {
> +		fprintf(stderr, "length must be a power of two of at least two pages\n");
> +		return 1;
> +	}
> +
> +	fd = open(argv[1], O_RDWR | O_DIRECT);
> +	if (fd < 0) {
> +		perror("open");
> +		return 1;
> +	}
> +
> +	buf = mmap(NULL, len, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (buf == MAP_FAILED) {

Are you intentionally not handling close(fd)?

> +		perror("mmap");
> +		return 1;
> +	}
> +
> +	/* Write the old contents. */
> +	memset(buf, OLD, len);
> +	if (pwrite(fd, buf, len, 0) != (ssize_t)len) {
> +		perror("pwrite");
 > +		return 1;> +	}

I suppose that it would be total paranoia to re-read and test vs expected.

> +
> +	/* Fill in the new contents and make the last page unreadable. */
> +	memset(buf, NEW, len);
> +	if (mprotect(buf + len - pgsz, pgsz, PROT_NONE)) {
> +		perror("mprotect");
> +		return 1;
> +	}
> +
> +	iov.iov_base = buf;
> +	iov.iov_len = len;
> +	ret = pwritev2(fd, &iov, 1, 0, RWF_ATOMIC);
> +	if (ret < 0)
> +		printf("pwritev2(RWF_ATOMIC) failed: %s\n", strerror(errno));
> +	else
> +		printf("pwritev2(RWF_ATOMIC) returned %zd of %zu\n", ret, len);

As a sanity check we could test the error code is -EINVAL. That's always 
expected, right?

> +
> +	/* Read the range back past the page cache. */
> +	if (posix_memalign((void **)&check, pgsz, len)) {

Can you just re-use buf?

> +		perror("posix_memalign");
> +		return 1;
> +	}
> +	if (pread(fd, check, len, 0) != (ssize_t)len) {
> +		perror("pread");
> +		return 1;
> +	}
> +
> +	for (i = 0; i < len; i++) {
> +		if (check[i] == OLD)
> +			old_bytes++;
> +		else if (check[i] == NEW)
> +			new_bytes++;
> +	}
> +	printf("on disk: %zu old bytes, %zu new bytes, %zu other\n",
> +	       old_bytes, new_bytes, len - old_bytes - new_bytes);
> +
> +	free(check);
> +	munmap(buf, len);
> +	close(fd);
> +
> +	if (old_bytes != len) {
> +		printf("atomic write was torn: %zu of %zu bytes written\n",
> +		       new_bytes, len);

So what happens if we did write all the new bytes (even though it should 
not happen)? That's not a torn write. This really goes back to testing 
pwritev2() error code, above.

> +		return EXIT_TORN;
> +	}
> +	printf("atomic write was all or nothing\n");
> +	return 0;
> +}
> diff --git a/tests/block/052 b/tests/block/052
> new file mode 100755
> index 0000000..8ec115a
> --- /dev/null
> +++ b/tests/block/052
> @@ -0,0 +1,70 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Tal Zussman
> +#
> +# Issue a RWF_ATOMIC direct write to a block device from a buffer whose last
> +# page cannot be pinned and check that the write is all or nothing. An atomic
> +# write is submitted as a single bio, so the direct I/O path has to fail the
> +# write outright when pinning its buffer comes up short. Without that, it
> +# submits what was pinned with REQ_ATOMIC set and leaves the rest to the
> +# buffered fallback, tearing the write at the pin boundary.
> +#
> +# Regression test for patch "block: fail a short atomic pin in
> +# bio_iov_iter_get_pages()".

Please run shellcheck on this if not already done so. JFYI, the 
maintainer asks for this.

> +
> +. tests/block/rc
> +. common/scsi_debug
> +
> +DESCRIPTION="check that a partially pinned atomic write is not torn"
 > +QUICK=1
> +
> +requires() {
> +	_have_scsi_debug
> +	_have_module_param scsi_debug atomic_wr
> +	_have_src_program atomic-write-torn
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	local dev len page_size unit_max ret
> +
> +	if ! _configure_scsi_debug delay=0 atomic_wr=1 dev_size_mb=16; then

I think that delay defaults to zero now.

> +		echo "configuring scsi_debug failed"
> +		return 1
> +	fi
> +	dev="/dev/${SCSI_DEBUG_DEVICES[0]}"
> +
> +	# The largest power of two the device can write atomically, capped at
> +	# 16K. It has to span at least two pages so that one can be left
> +	# unpinnable.
> +	page_size=$(_get_page_size)
> +	unit_max=$(< "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/atomic_write_unit_max_bytes")
> +	len=16384
> +	while (( len > unit_max )); do
> +		len=$(( len / 2 ))
> +	done
> +	if (( len < 2 * page_size )); then
> +		SKIP_REASONS+=("atomic write unit max ${unit_max} is below two pages")

Can you set params for scsi_debug such that this does not happen?

> +		_exit_scsi_debug
> +		return
> +	fi
> +
> +	src/atomic-write-torn "${dev}" "${len}" >>"${FULL}" 2>&1
> +	ret=$?
> +
> +	_exit_scsi_debug
> +
> +	case $ret in
> +	0)
> +		;;
> +	2)
> +		echo "atomic write was torn"
> +		;;
> +	*)
> +		echo "atomic-write-torn helper failed"
> +		;;
> +	esac
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/block/052.out b/tests/block/052.out
> new file mode 100644
> index 0000000..71c1f0a
> --- /dev/null
> +++ b/tests/block/052.out
> @@ -0,0 +1,2 @@
> +Running block/052
> +Test complete
> 

