Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D766392837;
	Fri, 14 Aug 2026 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786707858; cv=none; b=FUQbHdPaFqYYbpOzCTmYGKK0HnfTkuaVnYJjtZm4oU4+xMITuKzmOns85ykwfJ+/rNY2KEbgc9+eZZYEJ9ezHR7YjXv01Etq8Gek1OK3LsoZI3xLjSbrla5Pt0dBldEDat8rInbEyztCrIBGWqXnwMZneC46/higYLtUknvYGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786707858; c=relaxed/simple;
	bh=oHgftpnqV7JM6TkaCLVM0eRe0m/6VSsR6lg6nVhtM0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzZjofQBGWC5BQqKqGWQSnswIKj7g81Lkuiz9bjpqdawsTMkyOIJyf2wayog2ja5XspUR25AeDBYUZ0jNjmDYEoZgaB2n3+1QgyU9jLzJxrlkCte9mlU0OqUz1FkD7dYFUwWtJTTkLLXb1HKmOqZUb70qcAb67/gGXwNvSCW+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddCMXPsf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddCMXPsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C165D1F000E9;
	Fri, 14 Aug 2026 11:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786707857;
	bh=7oBdgiC+X6yoDYdQ9mEURjJUPgGSYP0WD5aQmylB/7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ddCMXPsfT14LrBwqBLMkLRLCPBnpDFakvmbagb01NnnfPrjISX6c0lC1QvshAQnrO
	 CBcXCYsiINpK/5R56l3VycSPkTTi0zWkwwZvPL+N+pRKJYR+SVILSuEgthtY/6ivYI
	 yBeQ5vXjUU/91RTH/YJyqJ2fFc8/JBigjdXCGVHxENS91+25DMEgw9jXDDoZIoBDfa
	 7pmoCsQsiYAimas/CNfVPSSTlngQfDJ8BdnIi2koaOlkiL2tszt8yTnRdgBMFSS2P4
	 s9H2H7jbibBNcofB0y83Fn34s75PlrQ7wy1wU5b7vd0cbl0Y3DLCXQKip+OR8o0qwo
	 lScFAp6Od5R8w==
Date: Fri, 14 Aug 2026 13:44:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: syzbot <syzbot+abd6a8dca0f2b7726060@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	dlemoal@kernel.org
Subject: Re: [syzbot] [block?] UBSAN: shift-out-of-bounds in
 null_process_zoned_cmd
Message-ID: <an7_jZ5dqhSoLn4e@ryzen>
References: <6a74aa44.01d0871a.3a0d52.0028.GAE@google.com>
 <6a7db437.bc649fcc.f9e73.014c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7db437.bc649fcc.f9e73.014c.GAE@google.com>

On Thu, Aug 13, 2026 at 05:10:31AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    3d6d817622b0 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1767f479580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
> dashboard link: https://syzkaller.appspot.com/bug?extid=abd6a8dca0f2b7726060
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16038ac6580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+abd6a8dca0f2b7726060@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in drivers/block/null_blk/zoned.c:21:14
> shift exponent -1 is negative
> CPU: 0 UID: 0 PID: 6032 Comm: syz-executor192 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>  ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
>  __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
>  null_zone_no drivers/block/null_blk/zoned.c:21 [inline]

line 21:
return sect >> ilog2(dev->zone_size_sects);

ilog2() only return -1 when being supplied 0.

dev->zone_size_sects can only be 0 while dev->zoned == true,
if syzbot changed zone_size concurrently as null_add_dev() was
called.

Otherwise, the zone_size == 0 checks in null_validate_conf() and
null_init_zoned_dev() and blk_revalidate_disk_zones() would all have
returned an error.


So this suggests that it is the same problem as is solved by:
https://lore.kernel.org/linux-block/44c18098-a4ca-4c72-863e-9109251e965c@kernel.org/T/#t

Just that syzbot modified the 'zone_size' configfs attribute
concurrently as null_add_dev(), rather than 'zoned'.


Kind regards,
Niklas
