Received: from mail3-165.sinamail.sina.com.cn (mail3-165.sinamail.sina.com.cn [202.108.3.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C5D37F333
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845004; cv=none; b=GVrZpAdlK8NiqDk+x0lcQ/SCt6Rb1RLv7ejCAnS+sWGEVGuGPVgD8BaUeI+8Ic1gl4Qn4TYt4Bqx+jJc9R21OQkdR7P2wUKW5rlLvckBm1w0nrGqxHD7BVkT1gS04/OIDRdmmis50Zp7LGsnlU66eAo8mWKR+qi/Ua1WNGFdW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845004; c=relaxed/simple;
	bh=TWlS5zFIu289frGRky4GN2nfYmKi3GQnzV49j8uW/fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pa2g/1kCHr3feTj6cePXeWF3vhTdm3tbAJok0oluFfh6lrUkprlkfEZm5mbrWi3et//caiVq6d3xEGz2FRA0ed/kj5P822uVCf4dibBLwLNq/mM16rs5uqdmN1XYDaQBo42TjXQ1AK/mu4PskwkHtdanSSoFR5JADr4vETW8I54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=aLqUal54; arc=none smtp.client-ip=202.108.3.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="aLqUal54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1786845001;
	bh=I9ZB69rxpG5yGVVd1SwS1so5aS1ZT3ZSsmnetbYFDSQ=;
	h=From:Subject:Date:Message-ID;
	b=aLqUal54i9hw0tER0kwK+t9UxQaIv9SI4l/2NwitBBKnydaLfFHUD4uxgsEAeXBzL
	 DqUS1fMLtmjWLXflqvpc/LlA7PEgREaRZeHF3tXIvlXw5Yi0EOL7Jh/kZQ2Jzvq/K1
	 nsmRGUhmHlNOZ6CZhcLPhS0GWaVFZRn/h21aLVj4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([221.216.154.155])
	by sina.com (10.54.253.33) with ESMTP
	id 6A81171900005780; Sun, 16 Aug 2026 09:49:16 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1283266685140
X-SMAIL-UIID: CC96787B58FF46BCBA5FADAB203329A0-20260816-094916-1
From: Hillf Danton <hdanton@sina.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
Date: Sun, 16 Aug 2026 09:49:04 +0800
Message-ID: <20260816014906.1149-1-hdanton@sina.com>
In-Reply-To: <20260802081922.840-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun,  2 Aug 2026 16:19:20 +0800 Hillf Danton wrote:
>On Tue, 28 Jul 2026 12:53:37 +0800 Hillf Danton wrote:
>>On Mon, 20 Jul 2026 10:39:17 +0800 Hillf Danton wrote:
>>>On Mon, 20 Jul 2026 10:23:43 +0800 Hillf Danton wrote:
>>>>On Sun, Jun 28, 2026 at 10:29 PM Hillf Danton <hdanton@sina.com> wrote:
>>>>> For archive purpose, syzbot report [1] where udp was not invovled defies
>>>>> what is fixed in d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep
>>>>> circular dependency") -- "Since the UDP socket and the NBD TCP/TLS socket
>>>>> are different, this is a false positive."
>>>>>
>>>>>
>>>>> [1] Subject: [syzbot] [net?] possible deadlock in inet_shutdown (3)
>>>>> https://lore.kernel.org/lkml/69c37e6a.a70a0220.234938.0045.GAE@google.com/
>>>>>
>>>>For archive purpose, syzbot report [2] shows deadlock without either udp or
>>>>tcp invovled. But it sounds false positive because kernfs node is removed
>>>>while the filesystem is filling super block.
>>>>
>>>>[2] Subject: [syzbot] [kernfs?] possible deadlock in kernfs_remove_by_name_ns (2)
>>>>https://lore.kernel.org/lkml/6a5ca0b7.f1649fcc.2a4208.03f3.GAE@google.com/
>>>>
>>>For archive purpose, syzbot reports [3,4] show deadlock without either udp or
>>>tcp invovled.
>>>
>>>[3] Subject: [syzbot] [kernfs?] possible deadlock in kernfs_iop_permission (2)
>>>https://lore.kernel.org/lkml/6a5d14b8.42649fcc.6186.0078.GAE@google.com/
>>>
>>>[4] Subject: [syzbot] [kernel?] possible deadlock in netif_reset_xps_queues_gt (3)
>>>https://lore.kernel.org/lkml/6a5d14b9.42649fcc.6186.0079.GAE@google.com/
>>>
>>For archive purpose, syzbot report [5] shows deadlock without lock_sock invovled.
>>
>>[5] Subject: [syzbot] [pm?] possible deadlock in thermal_zone_device_set_mode
>>https://lore.kernel.org/lkml/6a676313.073198cf.94f0f.0033.GAE@google.com/
>>
>For archive purpose, syzbot report [6] shows deadlock without nbd invovled.
>
>[6] Subject: [syzbot] [block?] [cgroups?] possible deadlock in blkcg_deactivate_policy (2)
>https://lore.kernel.org/lkml/6a6e8a06.6ce73036.24301b.0015.GAE@google.com/
>
For archive purpose, syzbot report [7] shows deadlock without socket invovled.

[7] Subject: [syzbot] [block?] [cgroups?] possible deadlock in blkg_conf_prep
https://lore.kernel.org/lkml/6a807bfd.f7a79266.2f965f.0008.GAE@google.com/

BTW do you still have any interest/minute fixing it Eric?
