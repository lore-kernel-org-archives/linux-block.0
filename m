Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D08E34AAF2
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875764; cv=none; b=rwQ2X3kq5XXdbof/TwBTTU23lqGuniX7O8MMB2/RXb5eNhCsWQxI/p0Jtf2IQbCSWgyUNN2t/YuOsKt++jlai5N4v2s2nbZtOd1lFqUrHpWrpHPVcl6gYm6KjBKvveBqkW/LzV2/r3U6/UXD6yN6Vx12/RbQrsl6EMgW9F5SYCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875764; c=relaxed/simple;
	bh=OxhFoBGi01waxqMKpBMnR3ERuXNDrUBwYulYDxQVSR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsMq7Km5+ejq0aMOG4jfuljyGuLeY/ezHUSEyrSg3ZyvXp1WkDV8DhcKB/3zDYMiUjgClKfyggE5p1/zmT2FFLPsWK9RaBgS9lADQF94ZvdT9NndqejsLVDFi/SJiTmvXrve0wpIqaVaMCSeZyTSe0m4onKqgET0SW/VKzMlao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=H6hP2H7M; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="H6hP2H7M"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso2277527a12.1
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 11:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764875759; x=1765480559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jQN2fEgrBkhsowinCilKqYK0evmlbFzMR5NLRS9YTE4=;
        b=H6hP2H7MTLmfvfOkZKth+ZhTrai1escvlth5S6BvCtk7qYAUoHaO5wrL+Z6evDmJK8
         57v8CTiz3nkjQw9CzrOQ/71U2MaqPxeQdlh+c9MGFSzbckcCDreob4S/gOpozpYIatbm
         rf26n51oNvmu4nzYxsm0Yt+cw2OxKCgdnsXcpnbi84djt6X62JszSAJbAuCXXQsZAARH
         dscCqvs4r6MCWnh0FDF7qaUNQZ/tFlUExPW5miQkSoOvs3Qirwo0Vf41kk/a+irdPcXE
         TjINQ09k716NWePwlqMXjwukD0Q59FO6f2Y23u+AQKzVCHzxI7PbL4U2benk1CxZAx2F
         QFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764875759; x=1765480559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQN2fEgrBkhsowinCilKqYK0evmlbFzMR5NLRS9YTE4=;
        b=TfIKFrmuxhinX0UiQfVy8APOrnCSM/+ROZ2hgiYMLPfYN9mybptcCs1K0sBpLMVNAY
         ZtBadPeLZxw60okcTtQSTWIfLoCSVMBjziKqo5LHr5bcI5wiIWB4m51ZGZTEDTzvvcgU
         VU2e2m3Ju9Z88pqNdWPcagDExX/CWHwJGr0iIH/lG3UWbVXw4vws8fnFaF1i26eZSSgT
         h1sLWVRvZpso+RnsaTRr62qQlMJz/uW4jIpzYvS0fWxgWwzPpz3APa/Bw2ms1t5GbRX6
         DbsA+dKolTsZ9PXexQECEZvLhqgHYCvrMFumU+gkQ6ecOWY14cwu5AGYrGec1+7E1pMH
         rHpg==
X-Forwarded-Encrypted: i=1; AJvYcCXVqAq0k15c4A0zuu4SD08jjMt0igh948vsYgesflFE4uUXseX3YSZk/d6kvPVlFDMuPtZ1lwxIz61QzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMA6kdcKvVnG2nmVR8RZnXVxUbwzCnM7kmz8vuFtLF8z9SNNme
	tZkI9epKVzFBJkftnTWyF7ASBuVPp0fdxtXh+FjxEiF+agr4WS/bVVPelazC5SUOADY=
X-Gm-Gg: ASbGncuJtjI+PrIhP22eBw7cK2sRASDoUWjzHlLvhTKgstwCHBP5f1dPVwL9dLUCcDA
	cAr4FFU/2sQzXpvZV7jXQXbR/7Td6lv06jMY1iTo5+ld9T4EuPZ24jMbj1ac0qh8c9Nrw1pE2Yz
	0vuicXKvt28F3Q99mqNXV4EBHgV7z3hTOBdWoiYAtGYJR8G+OR+yEeir7x696JReUlDwqkuhoxs
	oesRInZpqlTunD+0wCWfRvetX44ic6pL0SZKtiamXp6QkavEA3T1DdpKt68zXW9H4LvAF6UjjC9
	VOBW96k7mVZD8RFezyAnGuo5nmqWhX3rl9Nuzb21gOYA2FewK3quIfyfAoojX3rCf+F3+Bz+ENe
	U8ACn3F0Wpc3brha/fMwYap9IUGnJaPw41g6o2OFSYzDx9Lb4PgHNMKMjRo/4L5QErkdqc9QB62
	78kk9c1+CBlQ/X4Cjfzjk95nO8GHGVJAU=
X-Google-Smtp-Source: AGHT+IHL6tGdhWSxZOBpGzxYkgMsvc9YA0cw/P9oR/fGekUj57QPqKqoOkBbrrdnfzqv0m64xMgyoQ==
X-Received: by 2002:a05:6402:1ecc:b0:645:c6b1:5f9d with SMTP id 4fb4d7f45d1cf-6479c4720f4mr6210793a12.5.1764875759172;
        Thu, 04 Dec 2025 11:15:59 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 4fb4d7f45d1cf-647b2eda768sm1887014a12.8.2025.12.04.11.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 11:15:58 -0800 (PST)
Date: Thu, 4 Dec 2025 11:15:55 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-ID: <20251204191555.GB337106-mkhalfella@purestorage.com>
References: <20251204181212.1484066-1-mkhalfella@purestorage.com>
 <20251204181212.1484066-2-mkhalfella@purestorage.com>
 <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
 <20251204184243.GZ337106-mkhalfella@purestorage.com>
 <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>

On Thu 2025-12-04 09:06:47 -1000, Bart Van Assche wrote:
> On 12/4/25 8:42 AM, Mohamed Khalfella wrote:
> > Is blk_mq_del_queue_tag_set() performance sensitive such that it can not
> > take synchronize_rcu()? It is not in IO codepath, right?
> 
> Introducing a new synchronize_rcu() call almost always slows down some 
> workload so it should be avoided if possible.
> 
>  > I can not think of an easy way to do that. Suggestions are welcomed.
> 
> I can't find the implementation of nvme_dev_disable_locked(). What
> kernel tree does your patch apply to?
> 
> $ git grep -w nvme_dev_disable_locked axboe-block/for-next | wc -l
> 0

The stacktraces are from old 6.6.9 kernel. However, the issue is still
applicable to recent kernels. This is an example from 6.13 kernel.

Oct  1 15:19:30 hostname kernel: INFO: task kworker/151:1H:2442 blocked for more than 122 seconds.
Oct  1 15:19:30 hostname kernel:      Tainted: G            E       6.13.2-ge5f37b497f62 #1
Oct  1 15:19:30 hostname kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct  1 15:19:30 hostname kernel: task:kworker/151:1H  state:D stack:0     pid:2442  tgid:2442  ppid:2      flags:0x00004000
Oct  1 15:19:30 hostname kernel: Workqueue: kblockd blk_mq_timeout_work
Oct  1 15:19:30 hostname kernel: Call Trace:
Oct  1 15:19:30 hostname kernel: <TASK>
Oct  1 15:19:30 hostname kernel: __schedule+0x47c/0xbb0
Oct  1 15:19:30 hostname kernel: ? timerqueue_add+0x66/0xb0
Oct  1 15:19:30 hostname kernel: schedule+0x1c/0xa0
Oct  1 15:19:30 hostname kernel: schedule_preempt_disabled+0xa/0x10
Oct  1 15:19:30 hostname kernel: __mutex_lock.constprop.0+0x271/0x600
Oct  1 15:19:30 hostname kernel: blk_mq_quiesce_tagset+0x25/0xc0
Oct  1 15:19:30 hostname kernel: nvme_dev_disable+0x9c/0x250
Oct  1 15:19:30 hostname kernel: nvme_timeout+0x1fc/0x520
Oct  1 15:19:30 hostname kernel: blk_mq_handle_expired+0x5c/0x90
Oct  1 15:19:30 hostname kernel: bt_iter+0x7e/0x90
Oct  1 15:19:30 hostname kernel: blk_mq_queue_tag_busy_iter+0x27e/0x550
Oct  1 15:19:30 hostname kernel: ? __blk_mq_complete_request_remote+0x10/0x10
Oct  1 15:19:30 hostname kernel: ? __blk_mq_complete_request_remote+0x10/0x10
Oct  1 15:19:30 hostname kernel: ? __call_rcu_common.constprop.0+0x1c0/0x210
Oct  1 15:19:30 hostname kernel: blk_mq_timeout_work+0x12d/0x170
Oct  1 15:19:30 hostname kernel: process_one_work+0x12e/0x2d0
Oct  1 15:19:30 hostname kernel: worker_thread+0x288/0x3a0
Oct  1 15:19:30 hostname kernel: ? rescuer_thread+0x480/0x480
Oct  1 15:19:30 hostname kernel: kthread+0xb8/0xe0
Oct  1 15:19:30 hostname kernel: ? kthread_park+0x80/0x80
Oct  1 15:19:30 hostname kernel: ret_from_fork+0x2d/0x50
Oct  1 15:19:30 hostname kernel: ? kthread_park+0x80/0x80
Oct  1 15:19:30 hostname kernel: ret_from_fork_asm+0x11/0x20
Oct  1 15:19:30 hostname kernel: </TASK>
Oct  1 15:19:30 hostname kernel: INFO: task python:37330 blocked for more than 122 seconds.
Oct  1 15:19:30 hostname kernel:      Tainted: G            E       6.13.2-ge5f37b497f62 #1
Oct  1 15:19:30 hostname kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct  1 15:19:30 hostname kernel: task:python          state:D stack:0     pid:37330 tgid:37330 ppid:37329  flags:0x00004002
Oct  1 15:19:30 hostname kernel: Call Trace:
Oct  1 15:19:30 hostname kernel: <TASK>
Oct  1 15:19:30 hostname kernel: __schedule+0x47c/0xbb0
Oct  1 15:19:30 hostname kernel: ? xas_find+0x161/0x1a0
Oct  1 15:19:30 hostname kernel: schedule+0x1c/0xa0
Oct  1 15:19:30 hostname kernel: blk_mq_freeze_queue_wait+0x3d/0x70
Oct  1 15:19:30 hostname kernel: ? destroy_sched_domains_rcu+0x30/0x30
Oct  1 15:19:30 hostname kernel: blk_mq_update_tag_set_shared+0x44/0x80
Oct  1 15:19:30 hostname kernel: blk_mq_exit_queue+0x141/0x150
Oct  1 15:19:30 hostname kernel: del_gendisk+0x25a/0x2d0
Oct  1 15:19:30 hostname kernel: nvme_ns_remove+0xc9/0x170
Oct  1 15:19:30 hostname kernel: nvme_remove_namespaces+0xc7/0x100
Oct  1 15:19:30 hostname kernel: nvme_remove+0x62/0x150
Oct  1 15:19:30 hostname kernel: pci_device_remove+0x23/0x60
Oct  1 15:19:30 hostname kernel: device_release_driver_internal+0x159/0x200
Oct  1 15:19:30 hostname kernel: unbind_store+0x99/0xa0
Oct  1 15:19:30 hostname kernel: kernfs_fop_write_iter+0x112/0x1e0
Oct  1 15:19:30 hostname kernel: vfs_write+0x2b1/0x3d0
Oct  1 15:19:30 hostname kernel: ksys_write+0x4e/0xb0
Oct  1 15:19:30 hostname kernel: do_syscall_64+0x5b/0x160
Oct  1 15:19:30 hostname kernel: entry_SYSCALL_64_after_hwframe+0x4b/0x53
Oct  1 15:19:30 hostname kernel: RIP: 0033:0x7f12cf2fe02f
Oct  1 15:19:30 hostname kernel: RSP: 002b:00007f12311f78e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
Oct  1 15:19:30 hostname kernel: RAX: ffffffffffffffda RBX: 00007f12311ff5c8 RCX: 00007f12cf2fe02f
Oct  1 15:19:30 hostname kernel: RDX: 000000000000000c RSI: 00007f12081c19a0 RDI: 000000000000003b
Oct  1 15:19:30 hostname kernel: RBP: 000000000000000c R08: 0000000000000000 R09: 0000000000000002
Oct  1 15:19:30 hostname kernel: R10: 0000000000000002 R11: 0000000000000293 R12: 00007f12cae00700
Oct  1 15:19:30 hostname kernel: R13: 00007f12081c19a0 R14: 000000000000003b R15: 00007f1220219990
Oct  1 15:19:30 hostname kernel: </TASK>

> 
> Thanks,
> 
> Bart.
