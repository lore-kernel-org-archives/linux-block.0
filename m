Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F69363090;
	Tue, 14 Apr 2026 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160014; cv=none; b=g7weBXNuHzZAkpTmjIdgf3xrVUn7L1GNtEsBRnN+lTDcFF3hH31b74Kz8igebPxbBL3DOfY2OMIpAWWEUaHv2ORC8bZ41lq1Ox+F3YEl2V0j9AS+U1c+9XfM8IhHhvwZS04jg/jOXYvwJnHNmA0cSUVMMUYmy0sqkfzMQjd/+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160014; c=relaxed/simple;
	bh=V5nBQWo3cavGXvuTF32TYLX1UZIePz3B0xFyTcbttdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZ8FC8semumrSnrG76k5+Ak/ZDJHc2YkMNCqv6wCL4hoVE+RhBLnHQqgCRMKpEnVQhwcv056iQi40iBq3nNvY1YLKIy0FajKWu78asynhFQwrQpsaSe4BnXroGtK+CMzsJ2K36IXg3c1JJBflVm7t66PSampzIedXb9wEupjj1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkbKbR0b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkbKbR0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8229CC19425;
	Tue, 14 Apr 2026 09:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776160014;
	bh=V5nBQWo3cavGXvuTF32TYLX1UZIePz3B0xFyTcbttdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mkbKbR0bHxp7Mdl0VM8N0RmcqHFoofXRe80SWSjnZ7DwNKUXYoSxPAEQuExTVInLY
	 nSvyfT9gjhqFVsxTtMAkYsO4Imr6jIKL2iNbI1KpZlGoQ7AcwUYupd8bINWdI6zSIu
	 wHJ9OsopuVhMuhJ31VxVEFPeCGIK+K/lQvKu3pstoC+b/4scIlGWlEcNEpCZA5o2cA
	 U+yZKHa4eg8gaH/3TNK23l4W+bpWgPTJk+3han0qFDmCwLwRP3CRIM3ld4MfYDBLRC
	 mLVDeR5tyz0QrmrVFd1WJGp/L1AHpCDygFPvApbG33gaeODVtOoPuy2G5xqDDBlKIf
	 RKC4bt9gmJJQA==
From: Christian Brauner <brauner@kernel.org>
To: Wang Haoran <haoranwangsec@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Subject: Re: [PATCH] iov_iter: use kmemdup_array for dup_iter to harden against overflow
Date: Tue, 14 Apr 2026 11:46:43 +0200
Message-ID: <20260414-lockruf-frequentieren-a87539acb6ec@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260413060655.1139141-1-haoranwangsec@gmail.com>
References: <20260413060655.1139141-1-haoranwangsec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=brauner@kernel.org; h=from:subject:message-id; bh=V5nBQWo3cavGXvuTF32TYLX1UZIePz3B0xFyTcbttdg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTe4+W8lyioW3GpW25Jc+bNfol5Rxq5rCsq95oxemxS3 Va7eNHDjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImo6jH8YjJiD9x9IF9jVYhU j+U/py6zN7unhVzTNLnKY/U58q37dYbfbE/nh7OUbjq4Kijo+d2zty09vCZe/3Jx/6XdfvOEJa7 d4gMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 13 Apr 2026 14:06:55 +0800, Wang Haoran wrote:
> While auditing the Linux 7.0-rc2 kernel, I identified a potential security
> vulnerability in the iov_iter framework's memory allocation logic.
> 
> The dup_iter() function, which is exported via EXPORT_SYMBOL, currently
> uses kmemdup() with a raw multiplication to allocate the duplicate iovec array:
> 
> new->iov = kmemdup(from->iov, nr_segs * sizeof(struct iovec), gfp);
> 
> [...]

Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.misc

[1/1] iov_iter: use kmemdup_array for dup_iter to harden against overflow
      https://git.kernel.org/vfs/vfs/c/ea5efcc5c589
