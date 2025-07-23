Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446D433A6
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 01:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753232645; cv=none; b=NCipB2oI21DRYN/+Pf9zrp2+WdZh4HacsYSZ3vPvluIgQjfUrtIKZieBXBMCdr4Dac5xtHMkk+AdYDfVe7U2+7j0vFK8DI2B3uvgClRHgQ9SwTp5DQ6OW85PT8wr7WATRxgzf6oPORipsgKYI4L/esCftzhYLLhNXAc9VXNJLRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753232645; c=relaxed/simple;
	bh=uSar9xHTnGUQj7iYqiDRlLrJCkeSSB2Ouf2GH3Pr1+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgI9LIR5v0UZz2jH9mnt+D1DwJ+5nCqtqlDo+uhI864+1RxD4oo2u1t2oUwta4NsxYkeM1K6IDuc4tWe+T4YMpPFkJyQF7LBuxIly20AmdEDIt4np/Vp8x8XBy0Vcv68ZuKPIMHAqskbilJ0fb421bimOLQQlb/wk/5Ov8azvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=clgkFyNV; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="clgkFyNV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753232640;
	bh=xV1mGKNcZIdCI/Yqy+MW7AgI9iRp29g0Rl6VzIV3Dek=;
	h=From:Subject:Date:Message-ID;
	b=clgkFyNVjQG5T2w1MWhLLhtsSjCV5T1Cn4/YeEmgXj4kNN7Gm4/d3WK6qtz33FKB6
	 UjD1S2M5A5FL6pv6hXNDhIzQKQ7+Ls4SFRJMgOU2/qCEu3bj5lcyWlWE8R4nearfq/
	 jiaLTo45e25PDL+Ptc4lc/iahoRDDNRi/mS56gK4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 688034F200000F1B; Wed, 23 Jul 2025 09:03:50 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1175294456963
X-SMAIL-UIID: FB494A7CF96241028F43B38BAFEACAE8-20250723-090350-1
From: Hillf Danton <hdanton@sina.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: thomas.hellstrom@linux.intel.com,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	regressions@lists.linux.dev
Subject: Re: 6.15/regression/bisected - lockdep warning: circular locking dependency detected when plugging USB stick after ffa1e7ada456
Date: Wed, 23 Jul 2025 09:03:34 +0800
Message-ID: <20250723010336.2793-1-hdanton@sina.com>
In-Reply-To: <CABXGCsO5mFu9fOq8oKwByZaAjJrCB_V0hKgOsLLJJ4x3PmHr1g@mail.gmail.com>
References: <CABXGCsPgCBahYRtEZUZiAZtkX51gDE_XZQqK=apuhZ_fOK=Dkg@mail.gmail.com> <20250722005125.2765-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 22 Jul 2025 12:11:36 +0500 Mikhail Gavrilov wrote:
> On Tue, Jul 22, 2025 at 5:51 AM Hillf Danton <hdanton@sina.com> wrote:
> >
> > Try the diff that serializes elevator_change() with q->elevator_lock if
> > reproducer is available.
> >
> > --- x/block/elevator.c
> > +++ y/block/elevator.c
> > @@ -661,6 +661,7 @@ static int elevator_change(struct reques
> >         unsigned int memflags;
> >         int ret = 0;
> >
> > +       /* updaters should be serialized */
> >         lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
> >
> >         memflags = blk_mq_freeze_queue(q);
> > @@ -674,11 +675,11 @@ static int elevator_change(struct reques
> >          * Disk isn't added yet, so verifying queue lock only manually.
> >          */
> >         blk_mq_cancel_work_sync(q);
> > +       blk_mq_unfreeze_queue(q, memflags);
> >         mutex_lock(&q->elevator_lock);
> >         if (!(q->elevator && elevator_match(q->elevator->type, ctx->name)))
> >                 ret = elevator_switch(q, ctx);
> >         mutex_unlock(&q->elevator_lock);
> > -       blk_mq_unfreeze_queue(q, memflags);
> >         if (!ret)
> >                 ret = elevator_change_done(q, ctx);
> >
> 
> Hi Hillf,
> 
> Thanks for the patch.
> 
> I tested your proposed diff that serializes elevator_change() with
> q->elevator_lock. Unfortunately, instead of the previous lockdep
> warning, I'm now seeing a soft lockup warning.
> 
> Here is the relevant excerpt from the kernel log:
> 
> [   78.573292] sd 6:0:0:0: [sda] Assuming drive cache: write through
> [   78.581496] ------------[ cut here ]------------
> [   78.581507] WARNING: CPU: 7 PID: 300 at block/elevator.c:578
> elevator_switch+0x512/0x630
> 
> This happens after plugging in a USB flash stick (sd 6:0:0:0) with the
> patched kernel.
> 
> Full dmesg trace is attached below.
> 
> Let me know if you'd like me to try additional debugging or patches.
> 
> Thanks for looking into this!

In order to cure the deadlock, queue is thawed before switching elevator,
so lets see what comes out with that warning ignored.

--- x/block/elevator.c
+++ y/block/elevator.c
@@ -575,7 +575,6 @@ static int elevator_switch(struct reques
 	struct elevator_type *new_e = NULL;
 	int ret = 0;
 
-	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
 
 	if (strncmp(ctx->name, "none", 4)) {
@@ -661,6 +660,7 @@ static int elevator_change(struct reques
 	unsigned int memflags;
 	int ret = 0;
 
+	/* updaters should be serialized */
 	lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
 
 	memflags = blk_mq_freeze_queue(q);
@@ -674,11 +674,11 @@ static int elevator_change(struct reques
 	 * Disk isn't added yet, so verifying queue lock only manually.
 	 */
 	blk_mq_cancel_work_sync(q);
+	blk_mq_unfreeze_queue(q, memflags);
 	mutex_lock(&q->elevator_lock);
 	if (!(q->elevator && elevator_match(q->elevator->type, ctx->name)))
 		ret = elevator_switch(q, ctx);
 	mutex_unlock(&q->elevator_lock);
-	blk_mq_unfreeze_queue(q, memflags);
 	if (!ret)
 		ret = elevator_change_done(q, ctx);
 
--
