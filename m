Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B5046EF9D
	for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244577; cv=none; b=YzukgYKfAjKBL/qZF/Qs+5jaR7nBHH32xwWSA7DNxTdMDQj27EwXrlsvlnb5Vmq8qTWDTUFTMTy3Z8L4dgkECEnKx54uD/YxqgVhuommzZGh6tkN09VuWn7WbKAwZiFrzanJnGb5sTkdHCooRE3lzTQ7WT2iGp6eQDAG3eaeSrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244577; c=relaxed/simple;
	bh=jILoZbJ+my7bWI2B+7FewLVJxay0NSGO5ePWDhd1TUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXguvbfxR63Xql8gwlzmbT4/9tYvkiVXiO50/qdoxg39mp6qqdXAScXUJlhC1mcg2NN1/O0Pvfji38E104o8mAQJzNPTZozHBk1uqS0ppKTNo0QErpFE33PedhC4c68f15n7V66nrY5iIZUI5PYsscDKwsYYyHHQFUKxG2Mzsfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cd3lEOhd; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cd3lEOhd"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba91so967372a91.1
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 03:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790244564; x=1790849364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xbp5TiM82eBTMnFo2jw9yYRLjU2bFsj3L5CkfeZk11g=;
        b=cd3lEOhd7J/+N0R6VooheTjMS77DwxxLsVC6KX0Y4Fw47Q3tWYXbFN++ti4y8U31se
         r10SFVxXyXAL7UdTJoBw5J6qwRtCNQTV23fMW9Ze4zkez4uuS7OPtVVy6kYypH4hChzl
         9FroHS5ofjie1zk3VJ7IIHnX0Ev2L5v8BrTv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244564; x=1790849364;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xbp5TiM82eBTMnFo2jw9yYRLjU2bFsj3L5CkfeZk11g=;
        b=zsxtwsl85OG8UYPma8Ar2Gq23bf8MitSDqVdtOrJ0d8F6ts1rYC+iN0dXUzrJR2l7h
         5IPWh4hls/rZZvhIhw7ypA6gj7a72n8BTh7/agNUJRk9Uu9SRQ12MftiI0GtCWSa61Iq
         bFbAe7TXdu6fZfSTHZVB+EKoeZia6jBXSxow/7uCMJHc1LfUDrwvPgeh8B7d4qWz1o0v
         vqidmJY/XW7nFeJZHSaCfjoDWHu1Nny82JQs2UpR2vz+m2qxc01uyb8FNA+CSKNtLkwA
         3ZqNV8QIYSETOUYpEtnUSehHjRiwFaozn477ZMpnEYFMOf2wg0Vsp9QzBJaCnmi4QsGF
         9UQA==
X-Forwarded-Encrypted: i=1; AKwUvBzvQVotIE1/FlFzWZibeonfpmWILA9McWEclyaow44FlTKOWPk/jyCUNlaQQ9Ki0qnaNiDcFJSY/0yTqw==@vger.kernel.org
X-Gm-Message-State: AFuF++lJsT9nJtcmGCai6udBL8ZlxjcVGvQu5MnmXZze33CrDRSJJtEm
	ezyymyXLUSdQUvS+NUxL05iWOTLLfXjHaMy5zI6X37sGtWAhuu8Q77llu45tiyZgzA==
X-Gm-Gg: AYBFou1ukASvM5IUsDAQjFdUlBkcE4J8rLFCvPkb56O2QfQqU3SiAFuuLCp4uBny7Ac
	AUWVFhkUE+JQX1B0/dPou9jqM3sxyLKFN3Mm2BZ4yNsR933Jn65a3tDcia+QXIu9dZyjRNi8hQF
	L/CbzI6deKzhxGRLMJYByX9uPxh/VZdK3J5HIgwyrg+S1loKAeGZWt3rtwyPfjUaIn8YHJG7Apj
	lWNFOEhseMbfPeQZu92SrYMLw7j63MJCLcubS8/xLDQDtHDpUQsaa0uDzf4trySw/3zc+j8fvN7
	rh55Z/xNhlhzT3rrPxMJ0pIoHScp9GahalOkBig/ie6/q/11JJAuASc7/Yt2B2XUhmXPDxuLsRK
	gPCv2l3VI58iHT9mnI6d6fbvKj80zzrLc2puQ0eggj8gyQtJa6ZH0T/kLDhueAVe505X8grA9JW
	ZiRb9Z7MpN0VsxThsZMTxCfcRt+HlP+OpRSWb6hGro8aeEYFNlsgQmaH7ZHNcds3/2Y+a2Fd7FH
	iosmpIKGykgOoZnf35dayrtEqaVJ3nVBiOftA==
X-Received: by 2002:a17:90a:e50:b0:3a0:9aa4:f9fd with SMTP id 98e67ed59e1d1-3a09aa51430mr1029898a91.12.1790244563742;
        Thu, 24 Sep 2026 03:09:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:564:f2fc:acc1:e4c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a082872cfasm3159170a91.2.2026.09.24.03.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:09:23 -0700 (PDT)
Date: Thu, 24 Sep 2026 19:09:19 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: syzbot <syzbot+fb23651a7efbea8868ed@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, minchan@kernel.org, senozhatsky@chromium.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] WARNING: zero-size vmalloc in disksize_store
Message-ID: <arT1HxFd0q8Kdz47@google.com>
References: <6ab152fc.71f81b7d.15fa6d.0031.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab152fc.71f81b7d.15fa6d.0031.GAE@google.com>

On (26/09/21 08:53), syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    73ae59e97596 Merge tag 'erofs-for-7.3-rc1-2' of git://git...
> git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux master
> console output: https://syzkaller.appspot.com/x/log.txt?x=11d5d525580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c35e49327a11721f
> dashboard link: https://syzkaller.appspot.com/bug?extid=fb23651a7efbea8868ed
> compiler:       aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175514c9580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123b1005580000

#syz fix: zram: switch to unsigned long indexing
