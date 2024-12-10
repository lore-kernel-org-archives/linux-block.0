Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E793578F40
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827829; cv=none; b=juGYVIZNvFO7y10p5FtekQdM85q5ElAhpoCrjGFDisoNB8m65NTkA30wzv+1Gyrq9Nbz5Yaqy9uzbRLO9pYYJT3cY7e2UxZ5EICd9Og+l5E02EIOohRPdhA8P8lJQ2wOZOZY7mKYLZjbUpfAUGEZxkascXm1zz3VJ1GmZhO96hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827829; c=relaxed/simple;
	bh=xyDY9P9e64Gb89JU9S5lSpXhlR4GxzUM1qNPx7vgQR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T5iXL0TzvMDQvg6WgAO3+V9oBIDvB7FjLR7/6OCXIMKuCzr/tbQN9csrRs7psjd1L55zlNjGsG2rg0cHgZQ1kFoSVF536yVyaYmPkQvrFBV3RrzPQ5f979lx4PtUow4RX8HBjucEeGXiW1VEy7f/74PuU59BQ47Q8j9TrNSjPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.2])
	by sina.com (10.185.250.21) with ESMTP
	id 67581B9F00006332; Tue, 10 Dec 2024 18:44:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9175433408030
X-SMAIL-UIID: CA4A6274C05B459DAF365F7B45EA8373-20241210-184452-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5218c85078236fc46227@syzkaller.appspotmail.com>
Cc: boqun.feng@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ming.lei@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_submit_bio
Date: Tue, 10 Dec 2024 18:44:39 +0800
Message-Id: <20241210104439.1770-1-hdanton@sina.com>
In-Reply-To: <675742b5.050a0220.2477f.0054.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 09 Dec 2024 11:19:17 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    fac04efc5c79 Linux 6.13-rc2
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147528f8580000

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git   for-6.14/block
