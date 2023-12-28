Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553D6AA4;
	Thu, 28 Dec 2023 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tlm1zSZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB01C433C7;
	Thu, 28 Dec 2023 10:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703760542;
	bh=kXdM8l6YBnsY84eHi4eZAnWpfsxkw1Psni5CMD4xugU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tlm1zSZAF9rDDu6xZHygpQ0OabYcZcvyfgPyltQddupRJkvBFHn68a0hm/WTVa4xe
	 EeSWlnBIwp38QleElX+ZcxO/E1+y8IJboF7iO72KeGY7HNJ3LZzq+VYn10u89BPXt0
	 YluU2jfAVGMlJ43d3121Y/Fg4Vkzh7jwzmSPEtC9iYc75kbfZvCtDI/A4IXHbW8Vwa
	 oBfqnd20y8uh6t2DwINznlxneOxlLrJXfNmXZdacJA3joCH6R33suHv8E9m7gSmM2c
	 oCIJPl7Cs3Jl7i5o5BOgBrk+P1qUhVZ1IJr4MBZJXBhhLwWsym8a5caEKG5hWZBn1Y
	 IKQ2xyPX7ekAA==
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Fix a memory leak in bdev_open_by_dev()
Date: Thu, 28 Dec 2023 11:48:37 +0100
Message-ID: <20231228-marmorieren-frisch-f6677dbebc8c@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To:  <8eaec334781e695810aaa383b55de00ca4ab1352.1703439383.git.christophe.jaillet@wanadoo.fr>
References:  <8eaec334781e695810aaa383b55de00ca4ab1352.1703439383.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=brauner@kernel.org; h=from:subject:message-id; bh=Ax77AMZlSmHKwfAhMNiE2q9swju9T0TiGdasEacnqp0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT2BrUwaytwyK/ZMLcn7JzuL8fJH1Oiex7vD5h0wj7l0 Ip26TMPO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSPo3hf+r5Jj9nrzcSre2M h6z/duwqVC+TvZ1dmDZvw9/rCu4quxgZDvjcNXiWyhj5af2vqyrN8fW3Fqlt2Rte1vtFhcGCR/E nEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 24 Dec 2023 18:36:42 +0100, Christophe JAILLET wrote:
> If we early exit here, 'handle' needs to be freed, or some memory leaks.
> 
> 

Applied to the vfs.super branch of the vfs/vfs.git tree.
Patches in the vfs.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.super

[1/1] block: Fix a memory leak in bdev_open_by_dev()
      https://git.kernel.org/vfs/vfs/c/8ff363ade395
