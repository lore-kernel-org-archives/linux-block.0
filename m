Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.108.3.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442423;
	b=hBvWAbBW5kV9qooYG9s7n5rQiRBuc1XG3a+lLWjrezNqCn+fHu2mAmpgvbCvv9fHFwYR
	 rzLJ7nKkdRT5VFLvX3C97f+HMO7xvmqKGKEqqYXJpIrfecOPutckNqmAkZUAhpnhvFBgr
	 i2OYxpQOXNoKE87ueionaQpPfDAWU7N99KwZoToEFRZvibgx/kMfNqLj4I1DYEOiKitKR
	 zFZPp51v48/hlZCSzMlSMxJ7wk8RzodcB6cpRp4fhLb/MJGUGuQFMxGmx3oxmP6Cy61ts
	 Z9rvAantLM+vursQvhDVG/0MEDnbBQGJFq+ag8flCQOKQiNj9kTcVqir6oWQ69PF6Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442423;
	h=DMARC-Filter:DKIM-Signature:X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:
	 X-SMAIL-MID:X-SMAIL-UIID:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=D64g9BJ+4yZXICHv3vdK6fiAhMhXikQmmHwRmcMdR90=;
	b=bexvkp3fUUT1SHq0An1XAlIteEZTZ95rOFe2iYyc8oCN1lp4Ph3zBlgtSv0D7YcHbKgB
	 6eW86xfn8QfINeOk2684uVTJTs6N2jIMozf/yRDiu8zdVgdQ6wDq6V96XlXy9FUIsFCJ2
	 n9DNADPlRxLH7QAI+fvQWTp6Jgsw8Z4IjkRm2Hw5PlIaBWZktCsMQC+Qm8PBgmDt7JxlJ
	 Q765kOGto9N+4jMgEIsQlySJ/DUnQRmzDnBzDjUaNDfZy/NgJ2nqWnNledQ+3khYya6nF
	 Y9wI3ONc+10wf7Wd6Vdnjsnfa01dnevDKWw42HmVUjjphpM3q4qBsqS4wqkCVEtsVag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sina.com;
	spf=pass smtp.mailfrom=sina.com;
	dkim=pass header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=nWs8+lVQ;
	arc=none smtp.remote-ip=202.108.3.162
Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn [202.108.3.162])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CC0606A31C
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 00:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80CC0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=nWs8+lVQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1794442421;
	bh=D64g9BJ+4yZXICHv3vdK6fiAhMhXikQmmHwRmcMdR90=;
	h=From:Subject:Date:Message-ID;
	b=nWs8+lVQIUzNU0WcveGh1Cw3x8669exTaeGjNvjtSHCrfOhti80SUenEx9Vf1Mhmm
	 TK7DJSnGRQuzMWxBDgObKypnkulVLHJWRN0x8LzGsKQ65BqaloeGDr697XGsFZFXOt
	 VJwBUCPGQ1sa0iYqiHbgaKYRerLR7hNXiC2W105w=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.246.239.16])
	by sina.com (10.54.253.34) with ESMTP
	id 6AF504A900002169; Thu, 12 Nov 2026 08:13:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4742026292082
X-SMAIL-UIID: EB0B7AD7AF8746D584DAB56F33A6C72D-20261112-081332-1
From: Hillf Danton <hdanton@sina.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nbd@other.debian.org,
	syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: fix circular lock dependency
Date: Thu, 12 Nov 2026 08:13:18 +0800
Message-ID: <20261112001319.463-1-hdanton@sina.com>
In-Reply-To: <c2f4dbce-f8e0-4f04-8dee-3f8d413f4d0d@acm.org>
References: 
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 11 Nov 2026 09:13:45 -0800 Bart Van Assche wrote:
>On 11/11/26 3:38 AM, Guilherme Giacomo Simoes wrote:
> > After tested, how can I mention this in my patch?
>
>If syzbot confirms the fix, you can either:
>- Add a "Tested-by: syzbot..." tag if syzkaller provides one, or
>- Mention it below the "---" separator in your patch (in the changelog/notes
>   section), e.g.:
>   Tested against syzbot reproducer via #syz test: <link-to-syzbot-result>
>
> > What do you think now? We will call nbd_reclassify_socket() inside
> > nbd_get_socket() and call this only one time? Or is a better way call the
> > nbd_reclassify_socket() inside nbd_genl_reconnect_sock_cb() when we 
>have sure
> > that we will use the socket?
>
>Calling nbd_reclassify_socket(sock) directly inside
>nbd_genl_reconnect_sock_cb() (right after nbd_get_socket()) is definitely
>the best approach:
>1. It is a 1-line addition to nbd_genl_reconnect_sock_cb().
>2. It mirrors what nbd_add_socket() already does.
>3. No code needs to be moved around, keeping the git diff minimal and making
>    the fix trivial to review and backport to stable kernels.
>
> > What do you think:
> > ```
> > nbd: must reclassify socket when socket is created
> >
> > When we need to connect or reconnect a new socket, we need to call
> > nbd_reclassify_socket() to ensure that a false positive lock_dep
> > circular warning fires. [...]
> > ```
>
> Please use the imperative mood, e.g. as follows:
> 
> nbd: Reclassify sockets in the reconnect path
> 
> Commit d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular 
> dependency") introduced nbd_reclassify_socket() to prevent lockdep false 
> positives when NBD sockets are used in memory reclaim paths. While 
> nbd_add_socket() reclassifies newly added sockets, 
> nbd_genl_reconnect_sock_cb() omitted this call when replacing dead 
> sockets during reconnection. Consequently, reconnected sockets retain 
> the generic socket lockdep class and trigger false-positive lockdep reports.
> 
> Fix this by reclassifying the replacement socket in 
> nbd_genl_reconnect_sock_cb().
> 
> Fixes: d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular 
> dependency")
> Reported-by: syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com 
> Closes: https://syzkaller.appspot.com/bug?extid=d7d72f3d467710442af0
> 
FYI reclassifying sockets is also corrupting memory [11], so can you fix
the corrupter before reclassifying again?

[11] Subject: [syzbot] BUG: spinlock already unlocked in corrupted
https://lore.kernel.org/lkml/6aec63fd.5f5735a5.290c1c.0003.GAE@google.com/
