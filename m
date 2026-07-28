Received: from mail3-167.sinamail.sina.com.cn (mail3-167.sinamail.sina.com.cn [202.108.3.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED4A33AD8C
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 04:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785214447; cv=none; b=SpH5rzRJIA0LhyRMjB8UToUHRfYJmJI7Nxuhm3IEVByZKN72J1CrpyFk2b0g4FDc4TEZvQnTxbM7Fxy+0SPMMt3cMwKbQHfR22pl8REzaehwPhh1H877vVGv0tv8p1HDWBy/VJtJjmrlB5RwWgn1/gp4v7vPsHsKmO2sv4YiTJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785214447; c=relaxed/simple;
	bh=m6CGW9ZE/p64raJg1vOQIcv5Jr0yJYZmLgzGqrGrqtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKKqMom/GJaSBNvvTp5PS94CFFd9lr1vaOxRHKJQQHVXkRz4YSgqoOxAF05EQlormChiKoa+iVBTYcZIqd7+sqoAFohReoV4NGZnpQEHUpXITWzzL7GVFAxfXG1HNZ4GrlYyyZRRkTR8Jt61DJCAs/OMDyfts/RfQVTi2hngFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=tYcC0Iin; arc=none smtp.client-ip=202.108.3.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="tYcC0Iin"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1785214443;
	bh=m6CGW9ZE/p64raJg1vOQIcv5Jr0yJYZmLgzGqrGrqtM=;
	h=From:Subject:Date:Message-ID;
	b=tYcC0IinOm/IDsOsPGHLpUlqImQk7h3semYtybWR7evsG+o0yDM/K4ETTwWxMzvmd
	 rWsBSt0zFPO87bApKzsP5ckX8qnF7frABQVLkqJwhEJwdsvutohdnihvU6I/JEyIO0
	 M2A8+TbeLDoKPpGB4msa4Q/3n35RYMUt5oF0rRnk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([221.216.154.155])
	by sina.com (10.54.253.33) with ESMTP
	id 6A6835DE00006836; Tue, 28 Jul 2026 12:53:53 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5323806685043
X-SMAIL-UIID: BB9CE6761F7C43FCACEEA51D45CFAC9D-20260728-125353-1
From: Hillf Danton <hdanton@sina.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
Date: Tue, 28 Jul 2026 12:53:37 +0800
Message-ID: <20260728045340.770-1-hdanton@sina.com>
In-Reply-To: <20260720023920.610-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 20 Jul 2026 10:39:17 +0800 Hillf Danton wrote:
>On Mon, 20 Jul 2026 10:23:43 +0800 Hillf Danton wrote:
>>On Sun, Jun 28, 2026 at 10:29 PM Hillf Danton <hdanton@sina.com> wrote:
>>> For archive purpose, syzbot report [1] where udp was not invovled defies
>>> what is fixed in d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep
>>> circular dependency") -- "Since the UDP socket and the NBD TCP/TLS socket
>>> are different, this is a false positive."
>>>
>>>
>>> [1] Subject: [syzbot] [net?] possible deadlock in inet_shutdown (3)
>>> https://lore.kernel.org/lkml/69c37e6a.a70a0220.234938.0045.GAE@google.com/
>>>
>>For archive purpose, syzbot report [2] shows deadlock without either udp or
>>tcp invovled. But it sounds false positive because kernfs node is removed
>>while the filesystem is filling super block.
>>
>>[2] Subject: [syzbot] [kernfs?] possible deadlock in kernfs_remove_by_name_ns (2)
>>https://lore.kernel.org/lkml/6a5ca0b7.f1649fcc.2a4208.03f3.GAE@google.com/
>>
>For archive purpose, syzbot reports [3,4] show deadlock without either udp or
>tcp invovled.
>
>[3] Subject: [syzbot] [kernfs?] possible deadlock in kernfs_iop_permission (2)
>https://lore.kernel.org/lkml/6a5d14b8.42649fcc.6186.0078.GAE@google.com/
>
>[4] Subject: [syzbot] [kernel?] possible deadlock in netif_reset_xps_queues_gt (3)
>https://lore.kernel.org/lkml/6a5d14b9.42649fcc.6186.0079.GAE@google.com/
>
For archive purpose, syzbot report [5] shows deadlock without lock_sock invovled.

[5] Subject: [syzbot] [pm?] possible deadlock in thermal_zone_device_set_mode
https://lore.kernel.org/lkml/6a676313.073198cf.94f0f.0033.GAE@google.com/
