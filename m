Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1314D8DAF;
	Tue, 14 Jul 2026 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047499; cv=none; b=cpUOxQXaIAQjbEP/Tpaj2Q/Z1zyt972YbX2vjgDU1LUzQ6BiDDl2hPqmapNJIcIBzUW42Mjsdd/FPHrekcR2TVaz/pjU5w0k5ZI6CGc2H+8mRMvZukm5xJQ39mTVLiWl9YFzMpc+4YDIIpepgNIxqNEszB67tLZKW//LEGtNLvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047499; c=relaxed/simple;
	bh=DHGm2Qfzwm84OlDLpfh8Xo72wOd3mBg9DrHTldR0aY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7bPengixjZCC4omyt8+p4J6KLvhUz3YswLA9ZOh03YY7zIM8Obm0LczNvkoHmvOts4CTW2xnwTVa9M0aU/b2u0L9Gbcz4DzIg2Y2VBw5Oq12XbHIiiQL1JphJVc4wSdC3r04nFWP+6yvKGjFe2/dvLSlBossq2ZoWzZbYVKNTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe6OXbDR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe6OXbDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA34C1F000E9;
	Tue, 14 Jul 2026 16:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784047498;
	bh=J/pSVVQie+9lfBzmScbPH/JsQAlWpVXJTP4uahRa8Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pe6OXbDRkOZfDXqXLft1MgvD+cRopnNfVpDCjCBL0Z+B9ujTdOhDzItc5DbOjkb8I
	 JfqxxW6bvTKcsDWyw79JurfGZYP+3vtxdF81onojyfHx8fKpjEJ36IbgXhhlok/EPW
	 KnK7TjskGfVWJ+n9kII4TRCQGHnLaOseBbFRIA/kZoF7AB2s/iCybjUM7CfQn3dvRd
	 N13xRNAW0r9Nbd8XGn57ju1JEe0p9rRywtZFUsaJ+uU/B38ZXtwTB2ri3P340PTXhG
	 cYqwppmeBjzMFRPr0uO9RApC5T09hTbXMSIU6hUA2xjqiQVwV4irdNU8gU1//qeBeS
	 gqo5KzDyH4oOQ==
Date: Tue, 14 Jul 2026 10:44:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, Qu Wenruo <wqu@suse.com>,
	Neptune <z1281552865@gmail.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] block,iov_iter: move bio_iov_iter_align_down into
 iov_iter_extract_bvecs
Message-ID: <alZniKpsda_UJtj1@kbusch-mbp>
References: <20260714131318.2670042-1-hch@lst.de>
 <20260714131318.2670042-4-hch@lst.de>
 <alZHF1wZY58JSU7N@kbusch-mbp>
 <20260714145026.GA2213@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714145026.GA2213@lst.de>

On Tue, Jul 14, 2026 at 04:50:26PM +0200, Christoph Hellwig wrote:
> Yeah, we need to support that.  Kinda interesting that xfstests did
> not hit it, though.  So back to the previous version.

Here's a simple test for this case if you want to try. This should work
for any file or raw disk with nvme backing storage.

It prints "Success" before this series, and "Bad Address" after.

virt-discontig-prp-test.c:
---
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif

#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/uio.h>

int main(int argc, char **argv)
{
	struct iovec iov[3];
	void *buf;
	int fd;

	if (argc < 2)
		errx(EINVAL, "usage: %s <file>", argv[0]);

	fd = open(argv[1], O_RDWR | O_TRUNC | O_DIRECT);
	if (fd < 0)
		err(EXIT_FAILURE, "failed to open %s", argv[1]);

	if (posix_memalign((void **)&buf, 4096, 8 * 4096))
		err(EXIT_FAILURE, "failed to allocate buffer");

	iov[0].iov_base = buf + (4096 - 256);
	iov[0].iov_len = 256;

	iov[1].iov_base = buf + 8192;
	iov[1].iov_len = 8192;

	iov[2].iov_base = buf + 20480;
	iov[2].iov_len = 4096 - 256;

	preadv(fd, iov, 3, 0);
	perror("preadv");
	return errno;
}
--
