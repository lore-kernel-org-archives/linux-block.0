Received: from mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0344C50F
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140842; cv=none; b=J1JZPXmB/NcCO9t/mWwv6oIrE7Mec1j6kD+Y/11nClMBscfdvaejamPAAU3HQs9W2vqwoMy471Um+XFWqFFpLtiYcK6Y5EYt2G5UaZ/J2trJcJvIAprB1aMnKGX3bFjPiy7MEfnwkpRc2C0vokt2JtdWJEEZT60wh1wrLs7jiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140842; c=relaxed/simple;
	bh=O6cq8jJ3qbtdwUdhhsrN6kPyHFWO2kPsF1jU3TrxXNM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=J9AfU3LAg2xfPN4mxl/a5DY/gqUtb6UT2+xiBSKIoAj/kkt0f6Uppe0F/b2rsrmloG7Ay3tEgcWbCBJy6HHVHYghOvyUIvVkBMUvoapqwB2f8nFe9sFBTyZk5LDPX1bGA/BEDaD5XK3brRGV3ixLKCgq6gX1qanc0rTPLp0d9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kpw9zrIa; arc=none smtp.client-ip=91.218.175.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kpw9zrIa"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O6cq8jJ3qbtdwUdhhsrN6kPyHFWO2kPsF1jU3TrxXNM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792140832; v=1; x=1792745632;
 b=kpw9zrIajylJQ8X5GuDJXSD84KVxiwlWiyhEHMIZj+DNX+Wr0GXzFwkWfAilmWZPWXb391PE
 5d6CPyZUhdAHKlqREqmLby76ey0lJPWRBuchN2D5T5rbjRkCBDNLr9YTptbPGenGI5fmQYToxQ2
 cT7WbM/JMX1QWSrsgGeFLf8Q=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 0852ad72b7d4d602;
	Fri, 16 Oct 2026 08:53:50 +0000
X-Mizu-Trace-ID: 0852ad72b7d4d602
X-Migadu-Flow: FLOW_OUT
Message-ID: <8fff4ba1-1b19-4974-bbd1-16686c8b5bd2@linux.dev>
Date: Fri, 16 Oct 2026 09:53:48 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John Garry <john.garry@linux.dev>
Subject: Re: [PATCH blktests v3 4/4] block/053: add a torn atomic write test
 for block devices
To: Tal Zussman <tz2294@columbia.edu>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20261015-blkdev-fixes-tests-v3-0-b6ffa6410514@columbia.edu>
 <20261015-blkdev-fixes-tests-v3-4-b6ffa6410514@columbia.edu>
Content-Language: en-US
In-Reply-To: <20261015-blkdev-fixes-tests-v3-4-b6ffa6410514@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/26 17:29, Tal Zussman wrote:

thanks, just some more comments

> A block device atomic write is a hardware atomic write, submitted as a
> single bio, so when its buffer can't be fully pinned, the direct I/O
> path has to fail the write rather than submit the pinned part.
> Otherwise, it submits what was pinned with REQ_ATOMIC set and leaves
> the rest to the buffered fallback, tearing the write at the pin
> boundary.
> 
> This is a regression test for that issue, fixed in the kernel patch
> "block: fail a short atomic pin in bio_iov_iter_get_pages()" [1].
> 
> Issue a two-page pwritev2() with RWF_ATOMIC to a scsi_debug device with
> atomic_wr=1 from a buffer whose last page is PROT_NONE, so that pinning
> the buffer stops one page short. Check with statx() that the device
> supports an atomic write of that size, then check that the write fails
> with EINVAL and that the range still reads back as the old data.
> 
> Two pages is the smallest write that leaves one page unpinnable, and
> atomic_wr_max_length=256 raises the atomic write unit max to 128K so
> that two pages fit for any page size up to 64K.
> 
> [1]: https://lore.kernel.org/linux-block/20261009-blkdev-fixes-v6-5-307939c387df@columbia.edu/
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   src/.gitignore          |   1 +
>   src/Makefile            |   1 +
>   src/atomic-write-torn.c | 233 ++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/block/053         |  60 +++++++++++++
>   tests/block/053.out     |   2 +
>   5 files changed, 297 insertions(+)
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
> index f3f338b..b244405 100644
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

We are testing that the atomic write is untorn really (which it should 
be), so please rename to atomic-write-untorn.c

> new file mode 100644
> index 0000000..f6f3ccf
> --- /dev/null
> +++ b/src/atomic-write-torn.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-3.0+
> +/*
> + * Copyright (C) 2026 Tal Zussman
> + *
> + * Check that a RWF_ATOMIC direct write to a block device is all or nothing
> + * when only part of its buffer can be pinned.
> + *
> + * Fill two pages of the device with one byte value, then issue a pwritev2()
> + * with RWF_ATOMIC of a two-page buffer holding another value whose last page
> + * is PROT_NONE, so that pinning the buffer stops one page short. The direct
> + * I/O path must fail the write with EINVAL rather than submit what it pinned.
> + *
> + * Read the range back with O_DIRECT and count the bytes of each value, once
> + * before the atomic write to check the baseline and once after it. The write
> + * has to fail with EINVAL and leave only old bytes on the device.
> + *
> + * The device has to support atomic writes of two pages, which is checked
> + * with statx(). The first two pages of <blockdev> are overwritten.

I think that you can condense this description, as the functionality is 
not too complex

> + *
> + * usage: atomic-write-torn <blockdev>
> + *
> + * exit:  0 = the write failed with EINVAL and the device is unchanged
> + *        1 = setup error
> + *        2 = the write was torn
> + *        3 = the write did not fail with EINVAL, or went through
> + */
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +#include <sys/uio.h>
> +#include <unistd.h>
> +
> +#ifndef RWF_ATOMIC
> +#define RWF_ATOMIC	0x00000040
> +#endif
> +
> +#ifndef STATX_WRITE_ATOMIC
> +#define STATX_WRITE_ATOMIC	0x00010000U
> +#endif
> +#ifndef STATX_ATTR_WRITE_ATOMIC
> +#define STATX_ATTR_WRITE_ATOMIC	0x00400000
> +#endif
> +

Do we still really need these? Surely a test machine will be installing 
the latest headers along with the new kernel, no?

> +/*
> + * The atomic write fields of struct statx are only in glibc 2.43 and later,
> + * so use a local copy of the kernel's layout and call the syscall directly.
> + */
> +struct atomic_statx {
> +	uint32_t stx_mask;
> +	uint32_t stx_blksize;
> +	uint64_t stx_attributes;
> +	uint32_t stx_nlink;
> +	uint32_t stx_uid;
> +	uint32_t stx_gid;
> +	uint16_t stx_mode;
> +	uint16_t __spare0[1];
> +	uint64_t stx_ino;
> +	uint64_t stx_size;
> +	uint64_t stx_blocks;
> +	uint64_t stx_attributes_mask;
> +	uint64_t stx_times[8];	/* stx_atime, stx_btime, stx_ctime, stx_mtime */
> +	uint32_t stx_rdev_major;
> +	uint32_t stx_rdev_minor;
> +	uint32_t stx_dev_major;
> +	uint32_t stx_dev_minor;
> +	uint64_t stx_mnt_id;
> +	uint32_t stx_dio_mem_align;
> +	uint32_t stx_dio_offset_align;
> +	uint64_t stx_subvol;
> +	uint32_t stx_atomic_write_unit_min;
> +	uint32_t stx_atomic_write_unit_max;
> +	uint32_t stx_atomic_write_segments_max;
> +	uint32_t stx_dio_read_offset_align;
> +	uint32_t stx_atomic_write_unit_max_opt;
> +	uint32_t __spare2[1];
> +	uint64_t __spare3[8];
> +};

or this.

> +
> +_Static_assert(sizeof(struct atomic_statx) == 256, "struct statx is 256 bytes");
> +
> +#define EXIT_TORN	2
> +#define EXIT_UNEXPECTED	3

EXIT_FAILURE and EXIT_SUCCESS could be used here, no?

> +
> +#define OLD	'A'
> +#define NEW	'B'
> +
> +/* Does the device support an atomic write of len bytes? */
> +static bool can_write_atomically(int fd, size_t len)

bdev_can_atomic_write_for_length() would be a better name and functionality

> +{
> +	struct atomic_statx stx = { 0 };
> +
> +	if (syscall(SYS_statx, fd, "", AT_EMPTY_PATH, STATX_WRITE_ATOMIC,
> +		    &stx)) {
> +		perror("statx");
> +		return false;
> +	}
> +	if (!(stx.stx_mask & STATX_WRITE_ATOMIC) ||
> +	    !(stx.stx_attributes & STATX_ATTR_WRITE_ATOMIC)) {
> +		fprintf(stderr, "device does not support atomic writes\n");
> +		return false;
> +	}
> +	printf("atomic write unit min %u, max %u\n",
> +	       stx.stx_atomic_write_unit_min, stx.stx_atomic_write_unit_max);
> +	if (len < stx.stx_atomic_write_unit_min ||
> +	    len > stx.stx_atomic_write_unit_max) {
> +		fprintf(stderr, "device cannot write %zu bytes atomically\n",
> +			len);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +/* Read the range back past the page cache and count the bytes of each value. */
> +static int count_bytes(int fd, char *buf, size_t len, size_t *old_bytes,
> +		       size_t *new_bytes)

compare_bytes() may be a better name

> +{
> +	size_t i;
> +
> +	if (pread(fd, buf, len, 0) != (ssize_t)len) {
> +		perror("pread");
> +		return -1;
> +	}
> +
> +	*old_bytes = *new_bytes = 0;
> +	for (i = 0; i < len; i++) {
> +		if (buf[i] == OLD)
> +			(*old_bytes)++;
> +		else if (buf[i] == NEW)
> +			(*new_bytes)++;
> +	}
> +	printf("on disk: %zu old bytes, %zu new bytes, %zu other\n",
> +	       *old_bytes, *new_bytes, len - *old_bytes - *new_bytes);

Do we really need all these non-error messages? I just wonder if they 
can be obvious and useful to someone examining the log.

> +	return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	size_t old_bytes, new_bytes;
> +	size_t len, pgsz;
> +	struct iovec iov;
> +	char *buf;
> +	ssize_t ret;
> +	int fd, err, status = 1;

status = 1 seems a bit magic to me

> +
> +	if (argc != 2) {
> +		fprintf(stderr, "usage: %s <blockdev>\n", argv[0]);
> +		return 1;
> +	}
> +
> +	pgsz = sysconf(_SC_PAGESIZE);
> +	len = 2 * pgsz;
> +
> +	fd = open(argv[1], O_RDWR | O_DIRECT);
> +	if (fd < 0) {
> +		perror("open");
> +		return 1;
> +	}
> +
> +	if (!can_write_atomically(fd, len))
> +		goto out_close;
> +
> +	buf = mmap(NULL, len, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (buf == MAP_FAILED) {
> +		perror("mmap");
> +		goto out_close;
> +	}
> +
> +	/* Write the old contents and check that they read back. */
> +	memset(buf, OLD, len);
> +	if (pwrite(fd, buf, len, 0) != (ssize_t)len) {
> +		perror("pwrite");
> +		goto out_unmap;
> +	}
> +	if (count_bytes(fd, buf, len, &old_bytes, &new_bytes))
> +		goto out_unmap;
> +	if (old_bytes != len) {
> +		fprintf(stderr, "old contents did not read back\n");
> +		goto out_unmap;
> +	}

Can all this functionality (count_bytes() and length compare) be 
combined into a single function?

> +
> +	/* Fill in the new contents and make the last page unreadable. */
> +	memset(buf, NEW, len);
> +	if (mprotect(buf + len - pgsz, pgsz, PROT_NONE)) {
> +		perror("mprotect");
> +		goto out_unmap;
> +	}
> +
> +	iov.iov_base = buf;
> +	iov.iov_len = len;
> +	ret = pwritev2(fd, &iov, 1, 0, RWF_ATOMIC);
> +	err = errno;
> +	if (ret < 0)
> +		printf("pwritev2(RWF_ATOMIC) failed: %s\n", strerror(err));
> +	else
> +		printf("pwritev2(RWF_ATOMIC) returned %zd of %zu\n", ret, len);

The message does not really make sense, specifically "returned %zd of %zu"

> +
> +	/* Make the last page readable again and reuse the buffer. */

Comments like "reuse the buffer" are a bit verbose

> +	if (mprotect(buf + len - pgsz, pgsz, PROT_READ | PROT_WRITE)) {
> +		perror("mprotect");
> +		goto out_unmap;
> +	}
> +	if (count_bytes(fd, buf, len, &old_bytes, &new_bytes))
> +		goto out_unmap;
> +
> +	if (old_bytes != len && new_bytes != len) {
> +		printf("atomic write was torn: %zu of %zu bytes written\n",
> +		       new_bytes, len);
> +		status = EXIT_TORN;
> +	} else if (ret >= 0 || err != EINVAL) {
> +		printf("atomic write did not fail with EINVAL\n");
> +		status = EXIT_UNEXPECTED;
> +	} else if (new_bytes) {
> +		printf("atomic write went through despite the unreadable page\n");
> +		status = EXIT_UNEXPECTED;
> +	} else {
> +		printf("atomic write failed with EINVAL and left the device unchanged\n");

maybe, "atomic write failed with EINVAL and left the device unchanged, 
as expected"


> +		status = 0;
> +	}
> +
> +out_unmap:
> +	munmap(buf, len);
> +out_close:
> +	close(fd);
> +	return status;
> +}
> diff --git a/tests/block/053 b/tests/block/053
> new file mode 100755
> index 0000000..c7a24b4
> --- /dev/null
> +++ b/tests/block/053
> @@ -0,0 +1,60 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Tal Zussman
> +#
> +# Issue a RWF_ATOMIC direct write to a block device from a buffer whose last
> +# page cannot be pinned and check that the write is all or nothing. A block
> +# device atomic write is a hardware atomic write, submitted as a single bio,
> +# so the direct I/O path has to fail the write outright when pinning its
> +# buffer comes up short. Without that, it submits what was pinned with
> +# REQ_ATOMIC set and leaves the rest to the buffered fallback, tearing the
> +# write at the pin boundary.

This seems to repeat the comments from the C code

> +#
> +# Regression test for patch "block: fail a short atomic pin in
> +# bio_iov_iter_get_pages()".
> +
> +. tests/block/rc
> +. common/scsi_debug
> +
> +DESCRIPTION="check that a partially pinned atomic write is not torn"
> +QUICK=1
> +
> +requires() {
> +	_have_scsi_debug && _have_module_param scsi_debug atomic_wr
> +	_have_src_program atomic-write-torn
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	local ret
> +
> +	# The helper writes two pages atomically. An atomic write unit max of
> +	# 256 blocks, 128K, covers page sizes up to 64K.
> +	if ! _configure_scsi_debug delay=0 atomic_wr=1 atomic_wr_max_length=256 \
> +	     dev_size_mb=16; then
> +		echo "configuring scsi_debug failed"
> +		return 1
> +	fi
> +
> +	src/atomic-write-torn "/dev/${SCSI_DEBUG_DEVICES[0]}" >>"${FULL}" 2>&1
> +	ret=$?
> +
> +	_exit_scsi_debug
> +
> +	case $ret in
> +	0)
> +		;;
> +	2)
> +		echo "atomic write was torn"
 > +		;;> +	3)
> +		echo "atomic write did not fail cleanly"
> +		;;
> +	*)
> +		echo "atomic-write-torn helper failed"
> +		;;

"atomic write did not fail cleanly" won't" help a tester much. If the 
errors from the C code are logged, then that should help the tester know 
know the issue.

> +	esac
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/block/053.out b/tests/block/053.out
> new file mode 100644
> index 0000000..43d1b4b
> --- /dev/null
> +++ b/tests/block/053.out
> @@ -0,0 +1,2 @@
> +Running block/053
> +Test complete>

