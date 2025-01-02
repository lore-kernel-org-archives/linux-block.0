Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B611AC458
	for <linux-block@vger.kernel.org>; Thu,  2 Jan 2025 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735813755; cv=none; b=I/jhYWJYbuxxFeraC7w1YOn9JWhjKChn9bs9iEofU9ZoBS1vMLQVcTY9bUdn4hswJ1AX+Wn7N/L9nfu1ifC41In0RrPfy53+NPRxPitBvDZft81OCjSWd/pcqguxpw1htF9SIhiIg9y/XMJ1ZggYIrLlwyWleC8vFtiwKLpGIA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735813755; c=relaxed/simple;
	bh=Vx5GO7PyIWzEGTIeSdDqDqz7LuV7VBS9VwqozIFlvAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2TVFueMHksXfe0u9n4QcABQz44RDnqhqxum1DOC/bHaGU0/8VpDYjrpd1lpuKpDAiKev6iL5Wq0Xe8Odnevyypz1EocGNw7J0iBFgjnjerd49oS1KKp7we3WSHKsCviQL82fYSj4HAudOEQO7jPcT78Hk9fgY/qZjOaQFcOPKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.128])
	by sina.com (10.185.250.22) with ESMTP
	id 67766A4A00003252; Thu, 2 Jan 2025 18:28:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6959147602503
X-SMAIL-UIID: 5DD46E63FE364BF6A7A4FFFE105F2AFC-20250102-182828-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+566d48f3784973a22771@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [scsi?] possible deadlock in sd_remove
Date: Thu,  2 Jan 2025 18:28:15 +0800
Message-ID: <20250102102816.1261-1-hdanton@sina.com>
In-Reply-To: <6773a494.050a0220.2f3838.04da.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 31 Dec 2024 00:00:20 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    573067a5a685 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a09818580000

#syz test: https://github.com/ming1/linux v6.13/block-fix
