Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604663BBFD8;
	Thu, 10 Sep 2026 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024849; cv=none; b=gIC3LQTPtiSRsWCga8GABg8jJr7kHtmy3gi0XiLR+RqQl7WO+jRdexKIRJWyvrhb8p+Z2nqi2aWEM5/IFsS//MIRm8zjU4RFe/HUrGA+IeL5A9AUaeW14piWgAjuGMSJ4ORgoDPnGSmtfbCUsyqJRQa5M28pvQ5HuiPAbcL9QGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024849; c=relaxed/simple;
	bh=95lB2rqAT8/9fbrzrWPi9ojqqwpDHL3D7Fj0mykqOXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X9ONvKDtjaWf2nJlKY9pAtI/kqguLwajytQ+E10ywHNb4ZKtfJgpgcHCfhjtHvXV0Afe3lqM9Z3dnlgcLS2fDvdsLlGuHrBkoIdhlz7SyXN23ekI+I5OXgmvoOyIL+Jt8oGm1ITuLTa46ulTfFtYjMxthPl0Irid6rmbtqlfzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ6bYg3M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ6bYg3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE251F000FF;
	Thu, 10 Sep 2026 07:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789024848;
	bh=8TX6RG6eAzR9OAyzBYFZrl4ztTDV71rgf3sUqmarc+k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IQ6bYg3MnkXyDuyDbI64Liip8nHYaBMzMu/UIorsLWaoZy6Le/8DvWXPDVkxl08Lx
	 QbfWxcxpQ/FdEo1sSKVaH/ho6IVF2lDjmAHwfuiZ8jwnzWG7rvOqCxVHrrh+llmvl7
	 BevH/YuqiCJO8bKfEjvPCtejPbFK6ZJ2PUp7pcIBZDg2r3lqtm/jcWZCIAtM0xIxOe
	 MGjur0/6GvJIDZR8m+o7b/knQ0EBAHL5fNUiWh1uYJSfbijounF7pq8MnP16I2lzMm
	 nxksftyLDB572CLWjHzNHVK4ZQqL+fKvaYOxeqyLquhkI76MsnD4GvUTYm/6u69f6L
	 wqbht1m1Ge4Jg==
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <1667275.1788941191@warthog.procyon.org.uk>
References: <1667275.1788941191@warthog.procyon.org.uk>
Subject: Re: [PATCH v4] block: Fix start and length check added to
 iov_iter_extract_bvecs()
Message-Id: <20260910-bison-unpolitisch-ritualisieren-46a638e9d310@brauner>
Date: Thu, 10 Sep 2026 09:20:40 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; i=brauner@kernel.org;
 h=from:subject:message-id; bh=95lB2rqAT8/9fbrzrWPi9ojqqwpDHL3D7Fj0mykqOXo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtivI+Z9MY45fC9mN+qU/P3qJ9ZvJhcvKv6sVfPVx8b
 nXj2mObO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSu5Xhv/PVWVnvL5hVTXvv
 XxK09M8Sz4y4/b0tW1i67nxu/z3V0o7hn43W7IZdzxnX25tfktn56HuIqa5n+62AVO6wJbkVxTm
 ZbAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 09 Sep 2026 09:06:31 +0100, David Howells wrote:
> block: Fix start and length check added to iov_iter_extract_bvecs()

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

[1/1] block: Fix start and length check added to iov_iter_extract_bvecs()
      https://git.kernel.org/vfs/vfs/c/57a78ad2305f

