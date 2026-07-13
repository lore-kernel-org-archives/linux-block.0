Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn [202.108.3.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A7217F33
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911953; cv=none; b=YQKHbjE4dVCsyRbvH2SLpHDFX3WoUAYGBfp28tXgOPop/UWOFOC+6LJhoHfLYxWmZu/QEumgVryQxF+aGP811CporRVl08MouCigEfZNz6zFo3JZoJGy7RG/gcrRw89B50IyyMxBkeAp+3CWuUsvweIJS2pKmL/OPB3XnBg0uyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911953; c=relaxed/simple;
	bh=Pv+LBAjHx+e0svserdON7aVODJ9fwdFBpaKTs+Xf+v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbmugsfkASDN0gczyPIvAhUX3eRSwyBaPW9aA+BreTY1ovs0lfRiqeJOrQpqbhWG4ztCjnW82w2R/+vSJJKcPM69cVOX32cXb1VPR7PuTfd1MyL3xxa1a0Jm5idPTgZaqZlZAZ9CDWXMwVYjP10S6IZx2nVetVTbprIiVUO63Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=uHBJ2cDQ; arc=none smtp.client-ip=202.108.3.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="uHBJ2cDQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1783911950;
	bh=nVJzKby/G5AmshXcEdP8+6rNTCGrx28NhnamHmi4dPE=;
	h=From:Subject:Date:Message-ID;
	b=uHBJ2cDQbEi22i9P04WN+BW9JmirPlA4wD86uhb+K1LZGX6TqiedBiemW9cObavM3
	 A2YxI8KbTmpkDxz7r9ka6L494aGOlarNB+N8SBDdcrbHrSLyR8+/XP6uWmY6Jeu2V6
	 UoaTGpbfnkWTWZbSDaB1QEc5YdpFoh6VdbGYkC0s=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.34) with ESMTP
	id 6A5455E500002458; Mon, 13 Jul 2026 11:05:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8363806291824
X-SMAIL-UIID: 3B6D08DD9F0A42A5A94235520E043545-20260713-110511-1
From: Hillf Danton <hdanton@sina.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4] loop: Fix NULL pointer dereference in lo_rw_aio()
Date: Mon, 13 Jul 2026 11:04:59 +0800
Message-ID: <20260713030500.538-1-hdanton@sina.com>
In-Reply-To: <20260609175013.GH2636677@ZenIV>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 9 Jun 2026 18:50:13 +0100 Al Viro wrote:
>On Sun, Jun 07, 2026 at 07:54:58PM +0900, Tetsuo Handa wrote:
>> syzbot is reporting NULL pointer dereference in lo_rw_aio() [1][2].
>> An analysis by the Gemini AI collaborator [3] considers that this problem
>> is caused by a timing shift primarily exposed by commit 65565ca5f99b
>> ("block: unify the synchronous bi_end_io callbacks"), along with helper
>> refactorings like commit 92c3737a2473 ("block: add a bio_submit_or_kill
>> helper").
>> 
>> But due to difficulty of reproducing this race, discussion about what is
>> happening and how to fix this problem is stalling. Also, we haven't
>> identified how many filesystems are subjected to this problem.
>> 
>> Therefore, this patch introduces a grace period for flushing pending I/O
>> requests (which should be a good thing from the perspective of defensive
>> programming) so that we won't hit NULL pointer dereference problem, and
>> also emits BUG: message in order to help filesystem developers identify
>> the caller of an I/O request that failed to wait for completion so that
>> filesystem developers can fix such caller to wait for completion.
>> 
>> Note that emitting BUG: message is enabled only if CONFIG_KCOV=y, for
>> this check is a waste of computation resources for almost all users.
>
> Still breaks xfs/259, same as the version in next-20260605...
>
And syzbot report [1]

[1] https://lore.kernel.org/lkml/6a54399f.278cdcd2.e885.0023.GAE@google.com/
