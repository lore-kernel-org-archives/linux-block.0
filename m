Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD63242D7;
	Fri, 20 Mar 2026 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012707; cv=none; b=OFEqSpexlpGXJM71FnPb6MYDyXduBWBaiGNXtOfn49GVhlbBC/XvGMC/k+vE/FmE4lqUbP2/LEtc7uyYmKvbiB5Sc96lR6RhDnGLUSCEG8dWAtvnACbNuQee19QAkKkOwUxcTN6CQt0m/ddHfxELlGfSD8xNvWUHhpC1lFhEY/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012707; c=relaxed/simple;
	bh=4sPTUfoxE3kV/qz5USHCE4h36wm3p31ori5Q7svJuiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bj0GLHyUcZkoqJOCxY6elrSVpz3/mUgKvMfZd+H+yZyiGkVHsqeKgbq8Twa9APZgLL2v+tDltsM5vMiZrS9I2vohHKp0fkMnWWXsmD4kZVUgzapSnmadoJ5lQQGYoeA8RI1cQAELLAy5oR4AJI090rhvZoTIRUbff49ipEoOMBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SK04WNMO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SK04WNMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA85C4CEF7;
	Fri, 20 Mar 2026 13:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774012706;
	bh=4sPTUfoxE3kV/qz5USHCE4h36wm3p31ori5Q7svJuiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SK04WNMOxU0BJz6pG1T1XWcuxKAjFQD/Vw33sQX4Bx+seRSDmd1IdFNWR43L6Xivn
	 ysIVMD2CnrgS6HDectcsGxjDnLJiiJ/RXhnGLJHjPP/Of5HQQ574kqSxeVZsAnHIB3
	 h+kPaSqDT35WRIUejHR/lp9AUbj0iVVP8iQ6qGHk/2Bhi7BfS6YGAv6WcOL0omRyKy
	 UsjQRgqCJl4dbMFOPHHrEnzxbrS6YD76PvG6QqxcxUCJxfNC8VHGNPss9ksuLhhzVM
	 fsmhDdIzkm2N9px5S1XJ3MCbbwNedHxCh4KFwjNJ4LA14t58DETpRW9Fp2OXgAiz+f
	 MaJ/cA6sHKlkA==
From: Christian Brauner <brauner@kernel.org>
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] fs: remove stale and duplicate forward declarations
Date: Fri, 20 Mar 2026 14:18:14 +0100
Message-ID: <20260320-garen-radeln-63a7183a08bd@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226201857.27310-2-ytohnuki@amazon.com>
References: <20260226201857.27310-2-ytohnuki@amazon.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=brauner@kernel.org; h=from:subject:message-id; bh=4sPTUfoxE3kV/qz5USHCE4h36wm3p31ori5Q7svJuiY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTu9ZR1FuMo1fQqLa5atffFVscr4nuWp+6cs4/5rWPr+ 39JpxQMOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZiKsTIcOdxizS3g9rGT0fF 7UMEpL6nPr54Y/LBFdEv7nnN7Vu0cSfDP721849vfsd84gXbWmOPj0/TspU+mvEoW9ZqJh47qbL uPhcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 26 Feb 2026 20:18:58 +0000, Yuto Ohnuki wrote:
> Remove the following unnecessary forward declarations from fs.h, which
> improves maintainability.
> 
> - struct hd_geometry: became unused in fs.h when
>   block_device_operations was moved to blkdev.h in commit 08f858512151
>   ("[PATCH] move block_device_operations to blkdev.h"). The forward
>   declaration is now added to blkdev.h where it is actually used.
> 
> [...]

Applied to the vfs-7.1.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.misc

[1/1] fs: remove stale and duplicate forward declarations
      https://git.kernel.org/vfs/vfs/c/3d6bb84f6bb3
