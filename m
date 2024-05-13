Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9010F84D3E
	for <linux-block@vger.kernel.org>; Mon, 13 May 2024 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640875; cv=none; b=g+szzmBrkWonQkbosFCOrBGFYxHKw4+ikFXSBtHnmtJ/BL5SM5emmdim/1P+WXfQKbMqyEeaF8QTuhSAASK/9LucBcE0fWBgfe0vu/bXmde0xW9N5G/GPpt1+4OuDtGiP0hZv2o2RdMOG9EandEYafEvbjEQvs+iR0kT4UZj6oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640875; c=relaxed/simple;
	bh=XAh+3+CTGGVkYISHkmm739KJkfOQWMn8Cnd1CdYSj9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oY6PWHoA12cka5DossjHxmcZDrziawTFsUyKza0NA21fO1xFgBoG2ImwuVkPFWsFPB/jzKFcXfk6WHnlWp44VUlZXIeHA5PVjdvmKFh7w8eqwqr2xOPh5d2fMzV2auXGoGnA0AwHZKXPMTQUMOHzjOI4ZOeRJWDeItU+0yWHGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.104])
	by sina.com (172.16.235.24) with ESMTP
	id 66429A1B00003C20; Mon, 14 May 2024 06:54:21 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 97074945089598
X-SMAIL-UIID: 552A54332FBE4E46BB076C39E75AF36F-20240514-065421-1
From: Hillf Danton <hdanton@sina.com>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	axboe@kernel.dk,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzkaller-bugs@googlegroups.com,
	xrivendell7@gmail.com
Subject: Re: [Linux kernel bug] INFO: task hung in blk_mq_get_tag
Date: Tue, 14 May 2024 06:54:09 +0800
Message-Id: <20240513225409.3025-1-hdanton@sina.com>
In-Reply-To: <CAEkJfYPxWBfEnuKeCGEsscVTYy8MrNxCJwdbxS=c2-B0H+HfTA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 May 2024 20:57:44 +0800 Sam Sun <samsun1006219@gmail.com>
> 
> I am happy to help testing patches. As

Thanks.

> for repro, I have a C repro available, but it is too long so that I
> attached it to the first email. Should I just paste repro with bug
> report?

Yes.

> I applied this patch and tried using the C repro, but it still crashed
> with the same task hang kernel dump log.

Oh low-hanging pear is sour, and try again seeing if there is missing
wakeup due to wake batch.

--- x/lib/sbitmap.c
+++ y/lib/sbitmap.c
@@ -579,6 +579,8 @@ void sbitmap_queue_wake_up(struct sbitma
 	unsigned int wake_batch = READ_ONCE(sbq->wake_batch);
 	unsigned int wakeups;
 
+	__sbitmap_queue_wake_up(sbq, nr);
+
 	if (!atomic_read(&sbq->ws_active))
 		return;
 
--
