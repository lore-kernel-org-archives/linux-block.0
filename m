Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0485D2D8367;
	Fri, 14 Nov 2025 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143283; cv=none; b=ALZh0JpQUPIHGDqIW/Iv0x5Us4gp8fq8+vh/HYaFyT3Yo8r6qadBhSl89YxmW2PXMf2Z+G69vi+BW00GIRWFTXl5ytJEdX7BLGAANAsRNIRpZFjMjP4E8giFyQXeymG+jkDl+lGTiAfK05hq0Dz/HMMNLY8uh49PdiYszufWCP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143283; c=relaxed/simple;
	bh=Fc6XFo1eRgc9gqbUlcDDupKx6Xr/bFHChyeM4U3ZVws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nr0X19zoC8XLzQE/A8IUh83ZLv3cmD8sR+WIUYfVD+qi7ZgM6vU/PNHPrgDUhXhqoC74Z2ifpAP+dQXTWbHmR2yALJC7WSkAeftG2IQCyJV+ma2GTqXiTxZMzIFSPIiYIytvQaj9krVfHZbnMjzVzBB81RlP5BPhkXaRzCCbBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBWKU6Rl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBWKU6Rl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AA8C19421;
	Fri, 14 Nov 2025 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763143282;
	bh=Fc6XFo1eRgc9gqbUlcDDupKx6Xr/bFHChyeM4U3ZVws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBWKU6Rl5qPHwL3mWY9XhSIcRQyynYllASv/vunf1lhbsNqf9/Mt79PbI17oMokmx
	 md1TB8zqziHw/SyxtxClZ6GnZDV4kzjsXZFSDIVo0Y3ugnVf0QDmnLlatuiE49AG4R
	 b985OTUBtpoMuFkzNiWWVDF7gXEN1YL5DjKl5z2B0GEgreUEyd8H9rOxYw0nxeZaLZ
	 WRBVLFtIFVyLAmrlgxIOXQkvl3tFDvI7Vx82CRjPvq2qyQNLr4tx8Lam2lY5cXN0/Z
	 phywvmxXRY3PdGb5q2HHKnzkMrTZmYIUJsefHw02zuHOVld6gGYnMFwC8Muwy0bE7I
	 9arbgKozbeA9w==
Date: Fri, 14 Nov 2025 11:01:20 -0700
From: Keith Busch <kbusch@kernel.org>
To: syzbot <syzbot+8df17e797225d69050d4@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] general protection fault in bio_seg_gap
Message-ID: <aRducE3vsSWcznMs@kbusch-mbp>
References: <6916bd0e.a70a0220.3124cb.0046.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6916bd0e.a70a0220.3124cb.0046.GAE@google.com>

On Thu, Nov 13, 2025 at 09:24:30PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ab40c92c74c6 Add linux-next specific files for 20251110
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12e2317c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b4c0e7075df4bf51
> dashboard link: https://syzkaller.appspot.com/bug?extid=8df17e797225d69050d4
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11527084580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e1b412580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/63d584f3f4ab/disk-ab40c92c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4bb564de81d2/vmlinux-ab40c92c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/704d37065029/bzImage-ab40c92c.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/c9f9c8e46d00/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=14ec87cd980000)
> 
> The issue was bisected to:
> 
> commit 2f6b2565d43cdb5087cac23d530cca84aa3d897e
> Author: Keith Busch <kbusch@kernel.org>
> Date:   Tue Oct 14 15:04:55 2025 +0000
> 
>     block: accumulate memory segment gaps per bio

#syz fix: block: fix merging data-less bios
