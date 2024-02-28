Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7931534F4;
	Wed, 28 Feb 2024 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135731; cv=none; b=lZ6U9GGipMNLdbv21ZHhaqv1o5QCUvP0CHRpEiO5Hv1JA8AWIjOQsttNy3WYNly0/f7popEZFm0YHzu/2DR48BDLmr+vhktKXSbNVSSEuAUdqkL3zbPI3pmNnHVM/WHINnyVoOnNmPK0Q2QOAVU8KLmut1ebdlhMC4Iql3m6xBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135731; c=relaxed/simple;
	bh=oHzd8SNM6GlpSq+r4AmFE2P0EQTwNbbqy/bRczUH2RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukcZYv1hq6VgpIqcoZ7mcD6pbs9EDcXzu2gw1KzDOx6KcEnInJEieVKZWrGw7QzYatL1Q7LMMpQyLd2YbyVUCSh8mGfLEvweBsv5nQfrVzroSHdUwfq8rKlMDtKlfIp/GAiIBJfBKdxcCGSzQ0G5TIW/lnXZPJOa4SPAnBeB8mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo59Run7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo59Run7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D23BC433F1;
	Wed, 28 Feb 2024 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709135730;
	bh=oHzd8SNM6GlpSq+r4AmFE2P0EQTwNbbqy/bRczUH2RM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qo59Run7W6ZxLINr8E6/ZFUd3BBasTKj0fW4kKsfCCt2oNH8zlk+UK8n7bs4IyGsS
	 TrTj6P2m/tOIKs/xM0HV9EgWs3pJv0rysbIFoOGkBhBrYRljXk0BJ28+F6aSWWfU79
	 3bn+RxCNPlkwTOc+aW051ycS5NHEgDPHVYDpKAWYZ7Cm031vQELwf9YLquoBH6V+1J
	 9aC9tqsBxiW8UbQADGwBEc5ZSnQbDjzKT8fUzoxQ8b+iWiipC7JB28PFCLylmtu6WZ
	 lLp1O28dJlmK6CnIZqzrW/RlNaZTnQvzvQYS+m2vAGA9ydiw30CFnbpDkBA/9rHssz
	 J0FV2pv3z9ayQ==
Date: Wed, 28 Feb 2024 08:55:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Harald Dunkel <harald.dunkel@aixigo.com>, Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: RIP on discard, JMicron USB adaptor
Message-ID: <Zd9Xbz3L6JEvBHHT@kbusch-mbp>
References: <70bc51d7-c8a2-4b06-ab7a-e321d20db49a@aixigo.com>
 <62296d89-f7e6-4f54-add8-35b531dc657c@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62296d89-f7e6-4f54-add8-35b531dc657c@rowland.harvard.edu>

On Wed, Feb 28, 2024 at 10:46:39AM -0500, Alan Stern wrote:
> On Wed, Feb 28, 2024 at 01:22:12PM +0100, Harald Dunkel wrote:
> > [1400821.811585] ------------[ cut here ]------------
> > [1400821.811594] WARNING: CPU: 0 PID: 614303 at block/blk-lib.c:50 __blkdev_issue_discard+0x14b/0x180
> > [1400821.811868] CPU: 0 PID: 614303 Comm: blkdiscard Tainted: P           OE      6.1.0-18-amd64 #1  Debian 6.1.76-1
> > [1400821.811875] Hardware name: Gigabyte Technology Co., Ltd. Z790 GAMING X/Z790 GAMING X, BIOS F9b 11/10/2023
> > [1400821.811878] RIP: 0010:__blkdev_issue_discard+0x14b/0x180
> > [1400821.811887] Code: 48 39 d8 75 8b f7 da 89 d3 c1 eb 09 eb 85 48 8b 04 24 4c 89 20 48 83 c4 08 31 c0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc <0f> 0b 48 c7 c6 80 fd 0a a9 48 c7 c7 40 2c b9 a9 e8 60 45 4f 00 85
> > [1400821.811891] RSP: 0018:ffffb3d7a50d7d50 EFLAGS: 00010246
> > [1400821.811896] RAX: ffff9fb0cb248750 RBX: ffff9fbb794612c0 RCX: ffff9fb60167be80
> > [1400821.811899] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9fbb794612c0
> > [1400821.811902] RBP: 0000000000000cc0 R08: ffffb3d7a50d7d90 R09: fffff5f4d6f7efc0
> > [1400821.811904] R10: 000000000ee778ff R11: 0000000000000000 R12: 0000000000000000
> > [1400821.811907] R13: 00000000773bc800 R14: 000000ee77900000 R15: ffff9fbb794612c0
> > [1400821.811910] FS:  00007f2af0e95740(0000) GS:ffff9fbb7f200000(0000) knlGS:0000000000000000
> > [1400821.811914] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [1400821.811917] CR2: 00007ffc65eec170 CR3: 00000002dcf78000 CR4: 0000000000750ef0
> > [1400821.811920] PKRU: 55555554
> > [1400821.811923] Call Trace:
> > [1400821.811926]  <TASK>
> > [1400821.811931]  ? __warn+0x7d/0xc0
> > [1400821.811938]  ? __blkdev_issue_discard+0x14b/0x180
> > [1400821.811945]  ? report_bug+0xe2/0x150
> > [1400821.811955]  ? handle_bug+0x41/0x70
> > [1400821.811959]  ? exc_invalid_op+0x13/0x60
> > [1400821.811963]  ? asm_exc_invalid_op+0x16/0x20
> > [1400821.811974]  ? __blkdev_issue_discard+0x14b/0x180
> > [1400821.811982]  blkdev_issue_discard+0x7e/0xe0
> > [1400821.811990]  blkdev_common_ioctl+0x61f/0xa30
> > [1400821.811999]  blkdev_ioctl+0x104/0x270
> > [1400821.812006]  __x64_sys_ioctl+0x8d/0xd0
> > [1400821.812013]  do_syscall_64+0x58/0xc0
> > [1400821.812017]  ? do_user_addr_fault+0x1b0/0x580
> > [1400821.812023]  ? exit_to_user_mode_prepare+0x40/0x1e0
> > [1400821.812030]  entry_SYSCALL_64_after_hwframe+0x64/0xce
> > [1400821.812038] RIP: 0033:0x7f2af0f95c5b
> > [1400821.812042] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> > [1400821.812046] RSP: 002b:00007ffc65ecec40 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > [1400821.812051] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2af0f95c5b
> > [1400821.812054] RDX: 00007ffc65eced00 RSI: 0000000000001277 RDI: 0000000000000003
> > [1400821.812056] RBP: 0000000000000000 R08: 0000000000000007 R09: 0000563c2300a2f0
> > [1400821.812058] R10: 00007ffc65eec170 R11: 0000000000000246 R12: 000000ee77900000
> > [1400821.812061] R13: 0000000000000003 R14: 0000563c2300a2f0 R15: 0000000000000000
> > [1400821.812065]  </TASK>
> > [1400821.812067] ---[ end trace 0000000000000000 ]---
> > 
> > I tried a discard on a Samsung PM981 1TB SSD (m.2) using a JMicron USB adaptor.
> > 
> > udev rule:
> > 
> > ACTION=="add|change", ATTRS{idVendor}=="152d", ATTRS{idProduct}=="0583", SUBSYSTEM=="scsi_disk", ATTR{provisioning_mode}="unmap"
> > 
> > Probably I was too optimistic.
> 
> Notice that the USB layer does not show up at all in the stack dump 
> above, but the block layer figures prominently.  This strongly suggests 
> that the bug lies in the block layer.
> 
> CC'ing the appropriate mailing list and maintainer.

In the code comments above the WARN, this condition indicates "the
discard granularity isn't set by buggy device driver". The block layer
needs this set if your driver also sets the max_discard_sectors limit.
