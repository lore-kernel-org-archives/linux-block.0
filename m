Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926B1DDEE
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726498; cv=none; b=RW/FF1GHCiMSL9oySwziorxH85X4Tp9uts7bG0Yp471RKx6FzdBomzhzE9YhxQywFpizV/zqAU5YN4BuIzOnPwYB+ID1fGR5j9NTlB/8XhAQY317gJNXtTpzrKF74Nmy2TxR5jmH0Wobfxs8FeCRQzpDhW4hbVbYREPXjihAtEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726498; c=relaxed/simple;
	bh=wTowMFQeP+s8VNwXEh3brReMvOID0bPlrW7RzXlCHF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kk7z1LFqiZYvUBqozKWD5RpIKAh42CQzqDw4Qg7T+wxqvFuWgG+oDQdpWjom+Wk7+8OmXu3wFT8exgTpd4X5jEKC/vyICuvT984wLOFZFZ1Qf07FNd24MBSjZ3dF4IrANqFwwNjdPGx5SodorNllMQxgsdw/pOjVYbsKKxzFZjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.224])
	by sina.com (172.16.235.25) with ESMTP
	id 6643E89700004537; Tue, 15 May 2024 06:41:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8668234210443
X-SMAIL-UIID: 1733999AA79743E18E1F2194E8D4C6E7-20240515-064130-1
From: Hillf Danton <hdanton@sina.com>
To: Sam Sun <samsun1006219@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	axboe@kernel.dk,
	syzkaller-bugs@googlegroups.com,
	xrivendell7@gmail.com
Subject: Re: [Linux kernel bug] INFO: task hung in blk_mq_get_tag
Date: Wed, 15 May 2024 06:41:17 +0800
Message-Id: <20240514224117.3191-1-hdanton@sina.com>
In-Reply-To: <CAEkJfYPH3SJ6J3kLSjMGqkWOzgbgKZV_f2Hq05cpZZv7RmhvOg@mail.gmail.com>
References: <CAEkJfYMhv8AxxHSVdPT9bCX1cJZXw39+bMFh=2N9uNOB4Hcr=w@mail.gmail.com> <20240514103742.3137-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 May 2024 20:07:34 +0800 Sam Sun <samsun1006219@gmail.com>
> 
> I tried to run
> 
> # echo 0 > /proc/sys/kernel/hung_task_all_cpu_backtrace
> 
> before running the reproducer, the kernel stops panic. But still, even
> if I terminate the execution of the reproducer, kernel continues
> dumping task hung logs. After setting bung_task_all_cpu_backtrace back
> to 1, it panic immediately during next dump. So I guess it is still a
> task hung instead of general protection fault.

Given kworker/u10:2:53 blocked for more than 143 seconds, or the subject
line, how could it trigger gpf?
