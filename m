Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1E52D2C9
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792002983; cv=none; b=AQSEk/lu8x46gLs572aYsSWtA8zhE9tx11Lc8V9QBCnan9QXXhTPf7ESRJ9VPxpIZfnU9lqKL5n7LmF6Xnibzn4FXLH6b8eLSovu5LivQgENkJKXtLQMmYln01foVolbu5f3TJcqOhrzxZSi69YuDCSoDddgAW1QszfCu4Qoujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792002983; c=relaxed/simple;
	bh=JqX/4rWBAWRkkJ1ibnwV2TI+w0hJgHxKMlG/5iG7Hk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gno1S87/vxaxfGsFZMT8lssjilPMjl8sUdh0xeZ6eeFyRDU2JXvsmYOXSgnqrczjAVxybbakPGk+iNtLOSpksfK6Tf2w5Hb/wCFb7ZT4OHaeHyeg4wb8wLRz5txWfZuA52FFF9IAjtyg7u2MS7BvMFSjFbhb3PMwhR1KyCbXUHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=b7tY3P+o; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=B4L+qXKj; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="b7tY3P+o";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="B4L+qXKj"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EIZ2hJ2403742
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 14:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=qShl
	71klrvhMXJTjw+WGnu4XieCHafO9I7dfJpSx0tU=; b=b7tY3P+osPryF1c3hO2J
	TPcq73TF77bvrn6zy9Afl7qhTlVA/HUNhvvYiqGMx4/SoBysd2wHTkUCK396nrKs
	TGhtX+nD2TYEH7KyoHenyeN+M5Hu3O44hyleu/GyI/Ep/ftqS4G0p4i2c2m32IVf
	CLPhaLGA2WR9VVVjnmx43B+GgJl2+eMxGU5aRyayJxW3I8yDVqTRi6RZVAcrd/YI
	/RWuYpz5wmJNCf8ht6I5Qj4lpDbt93z5siWRymZudSYJoG397fNKxb376T1KROIU
	YFVf2GMX52dN8P8eNF4HQWSNN+g8xxPtt48dy81W2oPFOwRIhPBc01RODyB2svSH
	iA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4ha7mu4c3s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 14:36:11 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5337ed1ba44so96209511cf.3
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792002970; x=1792607770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qShl71klrvhMXJTjw+WGnu4XieCHafO9I7dfJpSx0tU=;
        b=B4L+qXKjO3dbDqh1pklcXJQxfmb/ax1CxRGkpTcNanZI8epwvYBvfzF/fyCkmG9+r6
         Q7E/WYq5N7l8dMVcZrSD0J9OdLKNhGdzN4feZ9CWcTG5TznpA7UzWv5JGFcT7uLvXspy
         eKBk4QjGqoCNeGH5r85dmziGL7CLKymNPhqDSxNLea6WNKV+UP965a5QFJNQPswCcfB2
         t/PgGFv6T3Lidu1zoDJAmS6JuMNSvuIcdzMWNG+6e140LF8D2lUqXCP8Dkj6ZehKTX43
         PmrLViv86uiCHBp1WTpqjleIAkuWd3y90aZAsXvCQzesLk+nU0i3Sr2SYSJCw87rGr6m
         0wPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792002970; x=1792607770;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qShl71klrvhMXJTjw+WGnu4XieCHafO9I7dfJpSx0tU=;
        b=ziqWlKAXiNDLG+41W5NXR2BI5O/CJVTqh652vPf88Ak1N1HzH5RRRpU5j5b1FtxiEM
         HZK8LqvmoNpF7B8WLI1C56vhMM+uqsrz66M4YKhHFMbNLNm2ktavOW+w29tPoSM8LUp0
         D7S7mFc/KSbFLeK0OLd3kHr4/mot712yj8VoiuznORERW1sXIgVSwRfUkoJ53RZFqYe1
         4j8vSurTDpyG1lGC7Cwcz6eA0mh+1I1y+DWmAy2ZDIO4/DKvdRSfEaoWYwiSmI288aj0
         LRsLexCNxB0MWKYmJwkYxf6u/Kq6vlKzsq6w2ChMVSWHZchIvwX9PoYI96QiviiZLSg7
         2jZA==
X-Forwarded-Encrypted: i=1; AKwUvBzQWep9n8Iy0bpACyFrVGav16QfLleZ/Hy4c1UznkrKmuapvebvmNQZlyfx0iFq87XGWQgBW8RI2KTmTg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5dQrDREWfRERCELPl6PuDmYQgDlOTdHMri9WrfNqpGXKplvHa
	FpA1BxInIjD1PieOF34ZQxO0bG3IqPfMrYaPNCXKpBQnkKizI/AEcQOObALfj7EFps9maFR8+aO
	yEbfqq6oSEhbgdvBtFFyb26NmGTHsS3pXL/a9IhiCXKK19rTNc2unpmjI2jcklbp3XW+5
X-Gm-Gg: AYBFou0XX//tQySUuyr+rmC1qiFUojPoTmYne7gtp9yyuAOGcl7ZENfNjcvDovETwsU
	8Vm4qKK66KIU8oFZaplQbLElcNLsCrdkqMwFABGb+iesMKudV/AoHmf522gvkoPx84xhXJqns7M
	gcjDkf1T5ddoR8zEXgN4N1nrqbhBt+NpcnGyPxYRcpdOYKb2puSM3/rfxLPfxqYne5nnZBzRfKz
	MzpObOeNH7lu8Eci0KP5mdZzFAFGzGFqntm/eycw5B85r0UTpJkjdW5t0W3ILXEdr3S4bYrZRd9
	aAd44pb3CEeRXFLlqe4HrZk9E4yBNki0UuuZqpBCyJuPOhs+MYOY2821qgSrzBZRXYQX6mTePBO
	mjl65tEC+ptnytRI5KHq7kM9UwLoC0qozxfjP7ha8D8dCZhtU
X-Received: by 2002:ac8:7f41:0:b0:535:180a:fd05 with SMTP id d75a77b69052e-5359fb46bf4mr268187731cf.35.1792002970378;
        Wed, 14 Oct 2026 11:36:10 -0700 (PDT)
X-Received: by 2002:ac8:7f41:0:b0:535:180a:fd05 with SMTP id d75a77b69052e-5359fb46bf4mr268187331cf.35.1792002969688;
        Wed, 14 Oct 2026 11:36:09 -0700 (PDT)
Received: from [10.207.9.0] (nat-128-59-176-148.net.columbia.edu. [128.59.176.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536127f6869sm3839911cf.20.2026.10.14.11.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 11:36:09 -0700 (PDT)
Message-ID: <5a8da067-d81a-4f1b-9d74-11b022ec429c@columbia.edu>
Date: Wed, 14 Oct 2026 14:36:08 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 4/4] block/052: add a torn atomic write test
 for block devices
To: John Garry <john.garry@linux.dev>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20261009-blkdev-fixes-tests-v2-0-fcb3599e47f7@columbia.edu>
 <20261009-blkdev-fixes-tests-v2-4-fcb3599e47f7@columbia.edu>
 <7d331842-5d6c-44e9-929d-2ac730a9cda7@linux.dev>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <7d331842-5d6c-44e9-929d-2ac730a9cda7@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX9yANI0tjQzwq
 98kNYeVIjBpV01DUljcabwHUTivVlJyxb99YnCh2BP1mhNOFo0IPFlCIZbFx7H6LVtj3i6dY655
 bmQRC9ajK0ii/MW6o7a74AMrofWWjxaAx2XFTfsuWhL8pOMXkepE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX7uc9iyRsqQfR
 i1K5KCDIxBHNmSEkcbKn1/PLZqFg9nwgMC2jQRs7PH50iFKu58smcjausiJ3xUnkpCOwYFmKmUo
 NFkx4wt9t9RmlvBBpfJU6Zj/nxHV/LRNrzqNKpiJ/pXIzQJKKPfDncR0A1bDLxrQZ3uul4MDEeD
 zFhPTL/pm03ZBcuB1r/0o3+aJCest0B0qx9ukn/ysUMGULfVvvjdQQxJzm2UQKlxdoSlK8tIu72
 HUejqV46lD5hr0Fsb5zK6MNvIFx1DZHSBEktJpPmWP76wF+M9RpI8S3hsIrM9qnfoEAj1rwZRmW
 eRT744Gern4mMrXSVN+PZi8v0KF9pHR0tWdqoFOqf2L+ZN0c4eilt+VHDyQpE0AEh84hcuQ4I5u
 O5d9d7iXaAFLEwyb4uqpoU3fxupYHpEUeQR93SPJ3RgpaSKl+n5XyDTZM5WbHZdkTv3hsRg5ysy
 d7qmUtRuXpJ6Ri7Hqwg==
X-Proofpoint-ORIG-GUID: h1XQvALvX9gjZoZUA7zexpRm2fxAaZb_
X-Authority-Analysis: v=2.4 cv=RO8mjIi+ c=1 sm=1 tr=0 ts=6acfcb9b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=dxtdfZqDOO0kCslK4e47hQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=sD-2fMmjga_c2vxoO_AA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: h1XQvALvX9gjZoZUA7zexpRm2fxAaZb_
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11935
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 phishscore=0 malwarescore=0 lowpriorityscore=10
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 bulkscore=10
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140073

On 10/12/26 12:04 PM, John Garry wrote:
> On 10/10/26 00:53, Tal Zussman wrote:

...

>> diff --git a/src/atomic-write-torn.c b/src/atomic-write-torn.c
>> new file mode 100644
>> index 0000000..e8ebba3
>> --- /dev/null
>> +++ b/src/atomic-write-torn.c
>> @@ -0,0 +1,131 @@
>> +// SPDX-License-Identifier: GPL-3.0+
>> +/*
>> + * Copyright (C) 2026 Tal Zussman
>> + *
>> + * Check that a RWF_ATOMIC direct write to a block device is all or nothing
>> + * when only part of its buffer can be pinned.
>> + *
>> + * Fill a range of the device with one byte value, then issue a pwritev2()
>> + * with RWF_ATOMIC of a buffer holding another value whose last page is
>> + * PROT_NONE, so that pinning the buffer stops one page short. The direct
>> + * I/O path must fail the write outright rather than submit what it pinned.
>> + *
>> + * Read the range back with O_DIRECT and count the bytes of each value. A
>> + * mix of old and new bytes means the write was torn.
>> + *
>> + * usage: atomic-write-torn <blockdev> <length>
>> + *
>> + * <length> is the size of the atomic write, a power of two of at least two
>> + * pages that the device supports. The first <length> bytes of <blockdev>
>> + * are overwritten.
>> + *
>> + * exit:  0 = the write was all or nothing
>> + *        1 = setup error
>> + *        2 = the write was torn
>> + */
>> +#define _GNU_SOURCE
>> +#include <errno.h>
>> +#include <fcntl.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <sys/mman.h>
>> +#include <sys/uio.h>
>> +#include <unistd.h>
>> +
>> +#ifndef RWF_ATOMIC
>> +#define RWF_ATOMIC	0x00000040
>> +#endif
>> +
>> +#define EXIT_TORN	2
>> +
>> +#define OLD	'A'
>> +#define NEW	'B'
>> +
>> +int main(int argc, char **argv)
> 
> This code should really test that the block device is atomically
> writable, ideally via statx.
> 

Will do. I think I just need to define the struct manually like src/metadata.c
does for its UAPI components, in case libc doesn't define the relevant items
(libc on my machine does not).

>> +{
>> +	size_t old_bytes = 0, new_bytes = 0;
>> +	size_t len, pgsz, i;
>> +	struct iovec iov;
>> +	char *buf, *check;
>> +	ssize_t ret;
>> +	int fd;
>> +
>> +	if (argc != 3) {
>> +		fprintf(stderr, "usage: %s <blockdev> <length>\n", argv[0]);
>> +		return 1;
>> +	}
>> +
>> +	pgsz = sysconf(_SC_PAGESIZE);
>> +	len = strtoul(argv[2], NULL, 0);
>> +	if (len < 2 * pgsz || (len & (len - 1))) {
>> +		fprintf(stderr, "length must be a power of two of at least two pages\n");
>> +		return 1;
>> +	}
>> +
>> +	fd = open(argv[1], O_RDWR | O_DIRECT);
>> +	if (fd < 0) {
>> +		perror("open");
>> +		return 1;
>> +	}
>> +
>> +	buf = mmap(NULL, len, PROT_READ | PROT_WRITE,
>> +		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> +	if (buf == MAP_FAILED) {
> 
> Are you intentionally not handling close(fd)?
> 

Other programs in src/ also "leak" fds, but I can clean these up.

>> +		perror("mmap");
>> +		return 1;
>> +	}
>> +
>> +	/* Write the old contents. */
>> +	memset(buf, OLD, len);
>> +	if (pwrite(fd, buf, len, 0) != (ssize_t)len) {
>> +		perror("pwrite");
>   > +		return 1;> +	}
> 
> I suppose that it would be total paranoia to re-read and test vs expected.
> 

I don't think it hurts. I can add this in.

>> +
>> +	/* Fill in the new contents and make the last page unreadable. */
>> +	memset(buf, NEW, len);
>> +	if (mprotect(buf + len - pgsz, pgsz, PROT_NONE)) {
>> +		perror("mprotect");
>> +		return 1;
>> +	}
>> +
>> +	iov.iov_base = buf;
>> +	iov.iov_len = len;
>> +	ret = pwritev2(fd, &iov, 1, 0, RWF_ATOMIC);
>> +	if (ret < 0)
>> +		printf("pwritev2(RWF_ATOMIC) failed: %s\n", strerror(errno));
>> +	else
>> +		printf("pwritev2(RWF_ATOMIC) returned %zd of %zu\n", ret, len);
> 
> As a sanity check we could test the error code is -EINVAL. That's always
> expected, right?
> 

Will add.

>> +
>> +	/* Read the range back past the page cache. */
>> +	if (posix_memalign((void **)&check, pgsz, len)) {
> 
> Can you just re-use buf?
> 

Will do.

>> +		perror("posix_memalign");
>> +		return 1;
>> +	}
>> +	if (pread(fd, check, len, 0) != (ssize_t)len) {
>> +		perror("pread");
>> +		return 1;
>> +	}
>> +
>> +	for (i = 0; i < len; i++) {
>> +		if (check[i] == OLD)
>> +			old_bytes++;
>> +		else if (check[i] == NEW)
>> +			new_bytes++;
>> +	}
>> +	printf("on disk: %zu old bytes, %zu new bytes, %zu other\n",
>> +	       old_bytes, new_bytes, len - old_bytes - new_bytes);
>> +
>> +	free(check);
>> +	munmap(buf, len);
>> +	close(fd);
>> +
>> +	if (old_bytes != len) {
>> +		printf("atomic write was torn: %zu of %zu bytes written\n",
>> +		       new_bytes, len);
> 
> So what happens if we did write all the new bytes (even though it should
> not happen)? That's not a torn write. This really goes back to testing
> pwritev2() error code, above.
> 

Yeah, I'll rework this to distinguish the cases.

>> +		return EXIT_TORN;
>> +	}
>> +	printf("atomic write was all or nothing\n");
>> +	return 0;
>> +}
>> diff --git a/tests/block/052 b/tests/block/052
>> new file mode 100755
>> index 0000000..8ec115a
>> --- /dev/null
>> +++ b/tests/block/052
>> @@ -0,0 +1,70 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2026 Tal Zussman
>> +#
>> +# Issue a RWF_ATOMIC direct write to a block device from a buffer whose last
>> +# page cannot be pinned and check that the write is all or nothing. An atomic
>> +# write is submitted as a single bio, so the direct I/O path has to fail the
>> +# write outright when pinning its buffer comes up short. Without that, it
>> +# submits what was pinned with REQ_ATOMIC set and leaves the rest to the
>> +# buffered fallback, tearing the write at the pin boundary.
>> +#
>> +# Regression test for patch "block: fail a short atomic pin in
>> +# bio_iov_iter_get_pages()".
> 
> Please run shellcheck on this if not already done so. JFYI, the
> maintainer asks for this.
> 

I ran shellcheck and it was clean. Was there something in particular that stood
out?

>> +
>> +. tests/block/rc
>> +. common/scsi_debug
>> +
>> +DESCRIPTION="check that a partially pinned atomic write is not torn"
>   > +QUICK=1
>> +
>> +requires() {
>> +	_have_scsi_debug
>> +	_have_module_param scsi_debug atomic_wr
>> +	_have_src_program atomic-write-torn
>> +}
>> +
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	local dev len page_size unit_max ret
>> +
>> +	if ! _configure_scsi_debug delay=0 atomic_wr=1 dev_size_mb=16; then
> 
> I think that delay defaults to zero now.
> 

It looks like the default is 1 (DEF_JDELAY), so I'm tempted to leave it. But
I don't think it matters much.

>> +		echo "configuring scsi_debug failed"
>> +		return 1
>> +	fi
>> +	dev="/dev/${SCSI_DEBUG_DEVICES[0]}"
>> +
>> +	# The largest power of two the device can write atomically, capped at
>> +	# 16K. It has to span at least two pages so that one can be left
>> +	# unpinnable.
>> +	page_size=$(_get_page_size)
>> +	unit_max=$(< "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/atomic_write_unit_max_bytes")
>> +	len=16384
>> +	while (( len > unit_max )); do
>> +		len=$(( len / 2 ))
>> +	done
>> +	if (( len < 2 * page_size )); then
>> +		SKIP_REASONS+=("atomic write unit max ${unit_max} is below two pages")
> 
> Can you set params for scsi_debug such that this does not happen?
> 

I think so, will do.

>> +		_exit_scsi_debug
>> +		return
>> +	fi
>> +
>> +	src/atomic-write-torn "${dev}" "${len}" >>"${FULL}" 2>&1
>> +	ret=$?
>> +
>> +	_exit_scsi_debug
>> +
>> +	case $ret in
>> +	0)
>> +		;;
>> +	2)
>> +		echo "atomic write was torn"
>> +		;;
>> +	*)
>> +		echo "atomic-write-torn helper failed"
>> +		;;
>> +	esac
>> +
>> +	echo "Test complete"
>> +}
>> diff --git a/tests/block/052.out b/tests/block/052.out
>> new file mode 100644
>> index 0000000..71c1f0a
>> --- /dev/null
>> +++ b/tests/block/052.out
>> @@ -0,0 +1,2 @@
>> +Running block/052
>> +Test complete
>> 
> 

