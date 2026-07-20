Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894CD261B9B
	for <linux-block@vger.kernel.org>; Mon, 20 Jul 2026 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784515215; cv=none; b=Sc74QNaaMkiqjEgWdxKQJhDsYD3Qfd6zv6KACTdFK0MrR4PHRyxuiuoglrw/w6yXv9ji/cYRpFUgF+EeIeUw2J4ZKrs753yaAbU9//oPeaMsYwf+g4yo7b38m9dGOTFmVqySzOj8bfn1hL4qoKKmqrcWB8yUtnlReIAeoHTwy90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784515215; c=relaxed/simple;
	bh=q5DwP2w3Ycy7+QOWEodQw81/gWZpBAketNsClq+WL3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxiGE7pEFGRzw5otxIWypSb/IUfaoMb0/yDIYF1mqoNACX1xZ7sj7SyGLX5+So7jRaxGMYhFDQ4ErSB2ow5lsdWFjoNvD7KLrO1hGRjM6K+Zf0Mz18RlZZZI4Oaopa4CoCgMFBkrZpPL4LmUiu73unazhkTtg2PbE72z5MA3TM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=ZwB63Hxp; arc=none smtp.client-ip=202.108.3.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="ZwB63Hxp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1784515211;
	bh=q5DwP2w3Ycy7+QOWEodQw81/gWZpBAketNsClq+WL3Q=;
	h=From:Subject:Date:Message-ID;
	b=ZwB63HxpMGgJUZ39ox5N+Av60ecfXzcwzDX8sdfZroiK+xyuD1knuyUUrIIfPSL88
	 UWpXnSsM1dPlaCRbM7TsBv5YJ4eZes81GU2x5WkIIRrCuwCgZBZkJlln7zNfBFem0Y
	 xZyS626hRzW03stD08CeXyZvqM04LAJOn64A+ZwY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([221.216.152.105])
	by sina.com (10.54.253.31) with ESMTP
	id 6A5D8A61000072A3; Mon, 20 Jul 2026 10:39:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7620056816670
X-SMAIL-UIID: FAA3C2EFFCF447D385DFB927C753F413-20260720-103931-1
From: Hillf Danton <hdanton@sina.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
Date: Mon, 20 Jul 2026 10:39:17 +0800
Message-ID: <20260720023920.610-1-hdanton@sina.com>
In-Reply-To: <20260720022345.593-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 20 Jul 2026 10:23:43 +0800 Hillf Danton wrote:
>On Sun, Jun 28, 2026 at 10:29 PM Hillf Danton <hdanton@sina.com> wrote:
>> For archive purpose, syzbot report [1] where udp was not invovled defies
>> what is fixed in d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep
>> circular dependency") -- "Since the UDP socket and the NBD TCP/TLS socket
>> are different, this is a false positive."
>>
>>
>> [1] Subject: [syzbot] [net?] possible deadlock in inet_shutdown (3)
>> https://lore.kernel.org/lkml/69c37e6a.a70a0220.234938.0045.GAE@google.com/
>>
>For archive purpose, syzbot report [2] shows deadlock without either udp or
>tcp invovled. But it sounds false positive because kernfs node is removed
>while the filesystem is filling super block.
>
>[2] Subject: [syzbot] [kernfs?] possible deadlock in kernfs_remove_by_name_ns (2)
>https://lore.kernel.org/lkml/6a5ca0b7.f1649fcc.2a4208.03f3.GAE@google.com/
>
For archive purpose, syzbot reports [3,4] show deadlock without either udp or
tcp invovled.

[3] Subject: [syzbot] [kernfs?] possible deadlock in kernfs_iop_permission (2)
https://lore.kernel.org/lkml/6a5d14b8.42649fcc.6186.0078.GAE@google.com/

[4] Subject: [syzbot] [kernel?] possible deadlock in netif_reset_xps_queues_gt (3)
https://lore.kernel.org/lkml/6a5d14b9.42649fcc.6186.0079.GAE@google.com/
