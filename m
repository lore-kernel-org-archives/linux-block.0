Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2D24B29
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751934096; cv=none; b=eNePWmrc9T+xd/1hlZVg/NgSGkgHv2WE7s+BZLsfcrUwP0tPXwJnQvnEkfTqzd2AyW9wgdTWSTcGAbmwmh34wJt8ppUPdU72PME250sqlkdT6EqGArH+KlhTxG5Auk/on4qSNjlyxlm74+6nc4nu/7SF6wbpCMXvkPQMnmZ8wxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751934096; c=relaxed/simple;
	bh=Q5/7b75vjuV8bEqfgE0riyVIQEz82/H/Uu34rZ0BkC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPTCdQtn+JE0PiBVYdY7x6+jeD4yFubVCTIS1y3V3crIgkJVfyxUQVDC6cIdt+qC/dGpAkfbVGQOqPoaRaWxobZKIt0f0zlJIhsrFd8heR9H8wSqAnblEGr4P8tbWGhbTKk17UU1fZh/NNK1i38Ai+LDhLcqWv6K67wRU4VT2Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=lA9y8OZr; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="lA9y8OZr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1751934087;
	bh=DW4AhCBbeiArax0m21d22MWOoGbYI1cZ1thox4sliRs=;
	h=From:Subject:Date:Message-ID;
	b=lA9y8OZrDz6D/vMD0pQzQeErWQJ82PtyJAiv6gGgGjLJvRvjafT059zt3E1pmWNDH
	 mEwKCvH3niq5VNmXh4J2N23wzWkh/NgWFGHg3I3vZ+F9WReC6C0Osq/dydBSPeD2tk
	 3zeKOIM3bSg59hWbxlzHbxEMlpgr+YK9BrViVvG0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 686C63F200003BF3; Tue, 8 Jul 2025 08:19:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1675456685312
X-SMAIL-UIID: C398EA41875643F785817AF7FB17703F-20250708-081900-1
From: Hillf Danton <hdanton@sina.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: axboe@kernel.dk,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org,
	syzbot <syzbot+3dbc6142c85cc77eaf04@syzkaller.appspotmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	linux-kernel@vger.kernel.org,
	nbd@other.debian.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nbd?] possible deadlock in nbd_queue_rq
Date: Tue,  8 Jul 2025 08:18:47 +0800
Message-ID: <20250708001848.2775-1-hdanton@sina.com>
In-Reply-To: <f6909d1f-0a53-447c-b3d0-369574d2d721@acm.org>
References: <20250707005946.2669-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 7 Jul 2025 10:39:44 -0700 Bart Van Assche wrote:
> On 7/6/25 5:59 PM, Hillf Danton wrote:
> > and given the second one, the report is false positive.
> 
> Whether or not this report is a false positive, the root cause should be
> fixed because lockdep disables itself after the first circular locking
> complaint. From print_usage_bug() in kernel/locking/lockdep.c:
> 
> 	if (!debug_locks_off() || debug_locks_silent)
> 		return;
> 
The root cause could be walked around for example by trying not to init
nbd more than once.

--- x/drivers/block/nbd.c
+++ y/drivers/block/nbd.c
@@ -2620,8 +2620,12 @@ static void nbd_dead_link_work(struct wo
 
 static int __init nbd_init(void)
 {
+	static int inited = 0;
 	int i;
 
+	if (inited)
+		return 0;
+	inited++;
 	BUILD_BUG_ON(sizeof(struct nbd_request) != 28);
 
 	if (max_part < 0) {
