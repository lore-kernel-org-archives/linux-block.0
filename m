Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0912C552
	for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540977; cv=none; b=m1h3dgZSqXOxmpbggI4hg196NAFSxryJy5gqDiVB0hNVtgMcBvozHwuj9KAVDgr5KII2VbmJSn5lh7+zkqK5McVDdlsTqevVOTz2BRTw6raIXZmOCznUqKg7rjAmW+PZJ2EUfFxBcezInpx0rC/+frtlBJT7wwvetm8i4suJ1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540977; c=relaxed/simple;
	bh=9Y6hny7Fqm89gQoRno25OblsD8PHFXcmc2vUPvLN3aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyrwYeC2ArP+UjRYLGtx/eakMlcESCinF1i4/VvemIhnA2L0/S93V7D5PQM8YoAJpRttSZhiPfxFGg0nJPmsvN2wN1tdWwRKtkIV1i3YzMYV/9ktJIcOYnWfPLZ3SlOmKuxav6+TdoVXBRupYgz1g800kVSxTn40nlqmm7GvZbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pApGdc65; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pApGdc65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E76DC433F1;
	Wed, 27 Mar 2024 12:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711540976;
	bh=9Y6hny7Fqm89gQoRno25OblsD8PHFXcmc2vUPvLN3aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pApGdc65Au7zBaaHsl0G6uGVAhh04W6UXb/umZMCMhbfKHhQ1chs1SSXJbPOQ+8Pa
	 cTh3YDQCBsFfz9+fiOdZGGozVwXQ7roIeLuud68dQySwQzWmhZrMqKLu/nzEIDw4Cq
	 b9kKKv/iKrFHwA1lDioO2S/sXE0rxdp+KL7BS/5bPJaw/5fMtlcJMNQK1LPyQQXRrf
	 7jS15wO1r26rSqTvld7IIf0O0bj79j6fP4FYxlxYR35ZLTR3pwBSbUiQWYscn0360B
	 VNmt3/J3m6IdatmqMtOwcedBckXKqwmGk1XSQI6w+TJVTcC+TrbfoyGec6dNZjeC6p
	 vlYJoPUlJ0ZZw==
From: Christian Brauner <brauner@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Date: Wed, 27 Mar 2024 13:01:30 +0100
Message-ID: <20240327-lichter-flutwelle-72ed40da1d48@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner> <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=brauner@kernel.org; h=from:subject:message-id; bh=9Y6hny7Fqm89gQoRno25OblsD8PHFXcmc2vUPvLN3aU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSxcL3YfV9oMsv6O8LcituuX1uha5xxas2ScxOjHa0Tb GZyfzzK0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR7i5Ghu9z2CuqQmX2Tk+/ v3pHnJDdreUO+xomxnc4bH9uWGu4fyUjw6ddv/mk1I7qbp3O7JW1XH/p1IsnZb9/ZTpc1ud7m1H BkhcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 23 Mar 2024 17:11:19 +0100, Christian Brauner wrote:
> Last kernel release we introduce CONFIG_BLK_DEV_WRITE_MOUNTED. By
> default this option is set. When it is set the long-standing behavior
> of being able to write to mounted block devices is enabled.
> 
> But in order to guard against unintended corruption by writing to the
> block device buffer cache CONFIG_BLK_DEV_WRITE_MOUNTED can be turned
> off. In that case it isn't possible to write to mounted block devices
> anymore.
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

[1/2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
      https://git.kernel.org/vfs/vfs/c/ddd65e19c601
[2/2] block: count BLK_OPEN_RESTRICT_WRITES openers
      https://git.kernel.org/vfs/vfs/c/3ff56e285de5
