Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005778;
	b=rWnlGJTqwjL9Q1NsTr85hU8oWj3b46ieUShw3pJij3JAmDCNQhJVinPHzggeC51hc/EH
	 GaYCT4goqJU5T4EgbLhnjIiUNoDToYi6cWo5WnJ22G97i2evt13T+A40guqWUOzRi9YrF
	 sGj1/x3FeXPTN+QCjQWmW/uD2IRBa+9d2QffLmBbGoM/qBNDG+zR/yMkKbelSUngOsRqj
	 ykIL1d5zRr4bRQNWGdoinFAou0PMZzMqbY9be9Yf7DSBt9vbq3svyEru5noYKX5rOyl9S
	 eqoPR5M0Mc8xtqBRHij3SxUQIP50VG7/NuMMtOnAUD54cj4K74p+q9Xbj6OOajvmVhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005778;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Khwy/yV0Mv8WqGQMzg9B3NGN7aah+zLdU5pxnPjCEGo=;
	b=EKHGIG3z6XnrDTjvzENQfH7GKphk26HxQpdXJ5yJaKvbS7ZSrKSnq+VjC7FVR+Uh4m9k
	 oUJqNZPyLrucSgVwoKlcR6PKcQv5KOQtzePgkDxQdpKHBYxJrTvKW6+db8x2aGdRxklEf
	 1/bfVspdeTWXUFa+qbCJW7vW+8xRt8/+DU1qiYExebIhsZOT0wTBCoJQgQ8yDMGSMR2tF
	 2ffUB44evKjo0++AoMIxaDhsbQAHxmI821UboUBjJ1fbs6MyFANGNgeEVwnn6EQ6U+xpg
	 YNVIeDbJgO8006T6RDRBP12aZzkvdBY3mkjG+B3e3HIuBz8FfzsakHFDxKLAWsJm/5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RbEXUMN2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD4E60A2604;
	Wed, 18 Nov 2026 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RbEXUMN2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7091F000C6;
	Wed, 18 Nov 2026 12:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005778;
	bh=Khwy/yV0Mv8WqGQMzg9B3NGN7aah+zLdU5pxnPjCEGo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RbEXUMN2CMj/iwKw3KsDByucdw2jK8cqH2KcHvaUURp3yqvXGBnWWoNucez3Ai6K3
	 3OT1sReVM8CY1JkqHkEqL5gEM+LLpqDq9amlKgLHrndHAHf7FrVCEgxLMd9ndZf6nW
	 Rqye2n/o1vJhcVBLPAWiQcUykvI+/i4SE0+RY2TfAffyoyUARJm088RBU3jgyRFgSa
	 +QW8zobXdY/bs2vvxrVOlw+uAzrM079O4JjtBIarVhugkZDpOTSLEku0/n8uNKzxjA
	 okxNff9bovPlrXsYmwt2gwZdZUMMMZCbFcDq65DaRfgmDG9kyFGWIWu5PNVRRCWXG2
	 kiKfUQWi2ynJg==
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Hengyu Liang <hengyul@cs.unc.edu>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@linux.dev>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261112174805.1200379-1-hengyul@cs.unc.edu>
References: <20261112174805.1200379-1-hengyul@cs.unc.edu>
Subject: Re: [PATCH] bdev: do not report a statx block size below the block
 size
Message-Id: <20261118-bierdeckel-auffahren-zeche-1be876b46ef9@brauner>
Date: Wed, 18 Nov 2026 13:42:53 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-04696

On Thu, 12 Nov 2026 12:48:05 -0500, Hengyu Liang wrote:
> Commit 425fbcd62d2e ("bdev: use bdev_io_min() for statx block size")
> made stat() report the minimum I/O size of a block device as
> st_blksize, so that devices with a large minimum I/O size get large
> enough I/O. Commit 777d0961ff95 ("fs: move the bdex_statx call to
> vfs_getattr_nosec") did the same for fstat().
> 
> However, the minimum I/O size of most disks is 512 bytes, and
> st_blksize was 4096 for them before. As of now, programs that size
> their buffer by st_blksize, such as stdio, write to these disks 512
> bytes at a time. Each write that covers only part of a block makes the
> kernel read the block from the disk first.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] bdev: do not report a statx block size below the block size
      https://git.kernel.org/vfs/vfs/c/085dfb5a71d7

