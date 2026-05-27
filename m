Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E58F17B425
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846728; cv=none; b=UJCpZKMCKJULnjaQeNYfl67hL/RFiuADizUzL2GpOKl5fI83GIBeYc5TDXdGftk3gQWbjyuBBk0WUlnd5hM+eUnWy/wgYODIVi2vnyINv6r5MsaqUAf6w7YSYQM1Y7DTDvJqw/rizDNpHopN1UtrpSEpKa00sfs+oQ0usp36hfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846728; c=relaxed/simple;
	bh=uG85Oty3N4KqJ4aexJ1wEXmQ6nUhwJtzsM0QQJ37Clk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=gy757N94ERuzw0myg5hxVxOPUNOkN05HLSN7xR9W8JcfepZptB7loo/n42BrNl8lRhuMvgNBZTM+NDwjeRFR4iqDKcG3GbghKvmD48L5a/yyrPEPCXYKB/0jEApO9Mo6bOTyfmiQbQivWtp/UIjvzCgqBoRzMCpY2mNCJ1IPjsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64R1q4sx028535;
	Wed, 27 May 2026 10:52:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64R1q4xm028532
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 27 May 2026 10:52:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d38e4600-3c32-491f-aa49-905f4fad1bfb@I-love.SAKURA.ne.jp>
Date: Wed, 27 May 2026 10:52:02 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Should the "loop" driver reject using pseudo files as backing file?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp

I noticed that /dev/loopX accepts pseudo files, for currently
loop_validate_file() does

	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
		return -EINVAL;

and pseudo files are treated as S_ISREG().

Reading pseudo files via /dev/loopX causes bogus results (tries to
repeatedly read the entire content up to the size visible to "ls"
command). I think that allowing such usage will confuse userspace
programs.

[root@localhost ~]# ls -l /sys/power/pm_test
-rw-r--r-- 1 root root 4096 May 26 22:14 /sys/power/pm_test
[root@localhost ~]# cat /sys/power/pm_test | wc
      1       6      48
[root@localhost ~]# cat $(losetup -f --show /sys/power/pm_test) | wc
     85     513    4096

Writing to pseudo files via /dev/loopX seems to work (at least works for
/sys/power/pm_test ), but can/should we forbid binding to pseudo files?

[root@localhost ~]# echo none > /sys/power/pm_test
[root@localhost ~]# echo none > $(losetup -f --show /sys/power/pm_test)

F.Y.I. An analysis by Google AI mode (expires in 7 days) is at https://share.google/aimode/prhETTZMQEzsw5HV9 .
