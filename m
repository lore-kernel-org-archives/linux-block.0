Received: from smtp153-166.sina.com.cn (smtp153-166.sina.com.cn [61.135.153.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF2382381
	for <linux-block@vger.kernel.org>; Sun,  2 Aug 2026 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785658825; cv=none; b=S38Fri/vO2PFl5RUHEuE0862pvw2AVmYWHB9DIXGFcC1PfdEGuAnHVQnTOWK82Coz55dvbaD5+xurc16kvYN92rv5tzFkS9u6UrMq/iachW2TB7DQ0hh/HpAHw8dBC55mqznwd9xgnIne5EgjZ+leBCW9jkju4rXSS4Qiugpwbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785658825; c=relaxed/simple;
	bh=aLJiJecCJ7atov2VSjRLjPtXXK8Ip7dbtwDYnPEY4Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4QfyUZtKJlrIrQLMh7ciL6VE/uzcDK8YxhLYm7XsJXcqHTrW+E8fMGcuhCRkkwCPsQ6iAtGpgs+wC1eXtrRCTkgZvIblQBT4wdIjPS4dN7fsARiLGzMrRJPp2Re9Wm9xD7/nFYmHjjhRV2DQDYxvGZ83tXZkmTnLFILMA380H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=CQNfXUeo; arc=none smtp.client-ip=61.135.153.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="CQNfXUeo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1785658820;
	bh=aLJiJecCJ7atov2VSjRLjPtXXK8Ip7dbtwDYnPEY4Io=;
	h=From:Subject:Date:Message-ID;
	b=CQNfXUeouzMtO7eCTrqVWvRRJbw4bN+cWpvziQiVwnJ2Wc6NHFDvTdLm2zp3AI+SV
	 vsv7vBqklCreeRbBIjtT5CuizhxEXpfaKXeZVq89Ik4g5gJFc3KzZygLQe77p3ulVy
	 u/Xrh+D2Bm12ls14I7Zn6D1tlDZg4+Sx1+MoU3Jk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([221.216.154.155])
	by sina.com (10.54.253.33) with ESMTP
	id 6A6EFD930000654E; Sun, 2 Aug 2026 16:19:34 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 461466685505
X-SMAIL-UIID: E9AF4BED424341229E17DB1745947D0B-20260802-161934-1
From: Hillf Danton <hdanton@sina.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
Date: Sun,  2 Aug 2026 16:19:20 +0800
Message-ID: <20260802081922.840-1-hdanton@sina.com>
In-Reply-To: <20260728045340.770-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 12:53:37 +0800 Hillf Danton wrote:
>On Mon, 20 Jul 2026 10:39:17 +0800 Hillf Danton wrote:
>>On Mon, 20 Jul 2026 10:23:43 +0800 Hillf Danton wrote:
>>>On Sun, Jun 28, 2026 at 10:29 PM Hillf Danton <hdanton@sina.com> wrote:
>>>> For archive purpose, syzbot report [1] where udp was not invovled defies
>>>> what is fixed in d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep
>>>> circular dependency") -- "Since the UDP socket and the NBD TCP/TLS socket
>>>> are different, this is a false positive."
>>>>
>>>>
>>>> [1] Subject: [syzbot] [net?] possible deadlock in inet_shutdown (3)
>>>> https://lore.kernel.org/lkml/69c37e6a.a70a0220.234938.0045.GAE@google.com/
>>>>
>>>For archive purpose, syzbot report [2] shows deadlock without either udp or
>>>tcp invovled. But it sounds false positive because kernfs node is removed
>>>while the filesystem is filling super block.
>>>
>>>[2] Subject: [syzbot] [kernfs?] possible deadlock in kernfs_remove_by_name_ns (2)
>>>https://lore.kernel.org/lkml/6a5ca0b7.f1649fcc.2a4208.03f3.GAE@google.com/
>>>
>>For archive purpose, syzbot reports [3,4] show deadlock without either udp or
>>tcp invovled.
>>
>>[3] Subject: [syzbot] [kernfs?] possible deadlock in kernfs_iop_permission (2)
>>https://lore.kernel.org/lkml/6a5d14b8.42649fcc.6186.0078.GAE@google.com/
>>
>>[4] Subject: [syzbot] [kernel?] possible deadlock in netif_reset_xps_queues_gt (3)
>>https://lore.kernel.org/lkml/6a5d14b9.42649fcc.6186.0079.GAE@google.com/
>>
>For archive purpose, syzbot report [5] shows deadlock without lock_sock invovled.
>
>[5] Subject: [syzbot] [pm?] possible deadlock in thermal_zone_device_set_mode
>https://lore.kernel.org/lkml/6a676313.073198cf.94f0f.0033.GAE@google.com/
>
For archive purpose, syzbot report [6] shows deadlock without nbd invovled.

[6] Subject: [syzbot] [block?] [cgroups?] possible deadlock in blkcg_deactivate_policy (2)
https://lore.kernel.org/lkml/6a6e8a06.6ce73036.24301b.0015.GAE@google.com/

BTW Eric do you see how difficult it is to fix the fking deadlock?
