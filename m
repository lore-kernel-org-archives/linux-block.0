Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1F830C347;
	Fri,  5 Dec 2025 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919208; cv=none; b=d9vRm1sNBHVDCRtJcAHhft4rnj3Khbm0YPJV1V69WL1YTXe8rVnS4sR2jVYpTsWJQGtCYVtbZJVM8a9y8pu/2fyo38aXDtGhEjtEWYs1GzEEnNpqp1VERFTB94w73lt8JWOJ6dM6Hext/Tb9NFemDF9S6xqZTxnVb9LTUPhqBx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919208; c=relaxed/simple;
	bh=Nq6eF1vNPqQexxbO5CbSo0SEOxl3ixoZ4tUAk3fFOuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DWgzeuRYmR/BZttcwW47WTXOblR45Im3GK2To4eRQE+qj6cFBBBLoHKw8X6AJU0LBjS2ksTYOLC34esa3tQWborGAyS1MyawD7ar4f8awfG+Zeb7T2pBlnSJ31FRj+0gzwBSme90JofgytU1OYBS2pjqpslJfWvGncmo4i37Bpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-e2-6932876e6473
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yunseong.kim@ericsson.com,
	ysk@kzalloc.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	sumit.semwal@linaro.org,
	gustavo@padovan.org,
	christian.koenig@amd.com,
	andi.shyti@kernel.org,
	arnd@arndb.de,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	surenb@google.com,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	chuck.lever@oracle.com,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kees@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mark.rutland@arm.com,
	ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com,
	wangkefeng.wang@huawei.com,
	broonie@kernel.org,
	kevin.brodsky@arm.com,
	dwmw@amazon.co.uk,
	shakeel.butt@linux.dev,
	ast@kernel.org,
	ziy@nvidia.com,
	yuzhao@google.com,
	baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com,
	joel.granados@kernel.org,
	richard.weiyang@gmail.com,
	geert+renesas@glider.be,
	tim.c.chen@linux.intel.com,
	linux@treblig.org,
	alexander.shishkin@linux.intel.com,
	lillian@star-ark.net,
	chenhuacai@kernel.org,
	francesco@valla.it,
	guoweikang.kernel@gmail.com,
	link@vivo.com,
	jpoimboe@kernel.org,
	masahiroy@kernel.org,
	brauner@kernel.org,
	thomas.weissschuh@linutronix.de,
	oleg@redhat.com,
	mjguzik@gmail.com,
	andrii@kernel.org,
	wangfushuai@baidu.com,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	2407018371@qq.com,
	dakr@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	neilb@ownmail.net,
	bagasdotme@gmail.com,
	wsa+renesas@sang-engineering.com,
	dave.hansen@intel.com,
	geert@linux-m68k.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v18 16/42] dept: apply timeout consideration to wait_for_completion()/complete()
Date: Fri,  5 Dec 2025 16:18:29 +0900
Message-Id: <20251205071855.72743-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTH99znPvdeGmuulehVP+C6TM0W5GWoZ3MxaEy8+zA1mszELdEG
	LtJZihYEYZpQBSqdVNRQMmqVCSKzbKtFN0GYWBnOziLIW8EKOF0n7wMLKKizxezLyS/nnP//
	n5wcDivayWJOrU2VdFqVRsnIaNnwnO/DtYZodeSfI5+At/cJgQ59PQ0T/mM0HHN8R2BqxoIh
	p/o/Ggr1CDzNNzBUXtFT8Mz+moGifj0No+XHERT7LCx0Tg4heFJvQPDKvBfOna9iYND8LwMz
	7nsYxvv7EFxp7EHQcncQgdVyCoGvu44Cs9VBg83xOZgvLwRL0VEqUJ5S8FdFMQsvH0VBo+0f
	Fu70dBDovZ1L4NesPhbquj+E1pozDNyr+ZFA88l8AqdHfAgGJ8sxlE+MslAxVkTA155LwQ91
	bgYaSxbA1Rs5CNyWJgJe0wANbV3XEVQ5CjG4f3Gx4Jp2BUJNwyyMW18TsLUEDtAwicE+dpEB
	/bNeBNneVWBq2gTP7Y8JWP1RMFLgJ7Gx4lSOiRYrz1Yi0X/hKBZzCgJ0a2gUi9lV6aLrvCCW
	5U1T4kl3uFhd/JAVSxwHxOyGYSKW1vZTouNSHiMah9so0dtRy2x9b6fs03hJo06TdBHrdssS
	273deN9Z2cGygVyShfo4I+I4gY8RXKZIIwqZRau/iwoywy8XPJ4XOMih/FKhKt9HjEjGYb41
	TDC8MOGgdj6/W/jDlBHcofn3BVuDnQRZzq8WPCfy8VvPMMFmr5/lkEC/sHN6lhX8KuGccWrW
	U+BLQ4TSb6vZt4JFws0KD12A5CXonUtIodamJanUmpiViRla9cGVcclJDhR4tvLDL7+8hsab
	tzsRzyHlHHl9epRaQVRpKRlJTiRwWBkqH9JEqhXyeFVGpqRL3qU7oJFSnGgJRysXyqMn0+MV
	/B5VqrRXkvZJuv+nFBeyOAtFhM00uN9t2//4i7kPDXviO8dWZNWanx86k78tLHwi4eu4p7+1
	bt91Onq9Z6gr3OndOOjvSP15R/RH/qW3ceTfEQmhMccf7D8y76ur3zzoqUk+HLcodGxL7JI8
	fq05wXJh7uaP+z878ZOy9c6hsqYN9xv1v2/amHmqxZe5hjOsWXazZr2zeEBJpySqoj7AuhTV
	G6DboO1oAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+93XrqPFbQnd6o9qIUFQaWQcSHpA1CVIrH+ioHLYRa/OKZv5
	iKLpWpqlzcVmNl9ZrnJW01lmslxa9rCH02xW2qyWZVqLmpma2TT65/A55/s9X84fh8al9eR8
	WlCm8CqlXCGjxIQ4cq12uTJ7lRD61DAPcnRHoMfjJeFFppOAYX8OAcXXqimYMNeLIKe2iIQH
	7iwC2q9aEXiGcxCMjJtx0DVMEjBhaBWBf/S1CIyZCCYdrQhMLgMO3e1NOFTXZWLww/aHgsGW
	7wiMb70UFA5kEuCznERwtt8sgoF7W+CLp5GEyd6PGLh/DiGweP9g4HVmI5gwJUBZhT2wbvpG
	wfiTZzgUGtsRnHvbi8P3gT4Eda1vEDguZVHwQX8dh07vLHg+7KPgofEEBV9cxRh8tVFQnuUg
	wfV4EEGJ2YCg/5UDA+35axSYSmoJaOi7JQLX4G8MekwGDKy128Bj6SegTV+BBc4NuGrmgrlQ
	iwXKJwyMVxoxGLVUiTZUIm5El09wVfYbGKfrmKC46tJqxI2PGRDnr9TinE4faFuGfDh31J7G
	VbYNUdzYcBfFOX6WE9yjCpa7cHwM4wqeLOcazvaKojbuFkfs5xVCKq9auS5aHNfV8wpPLhWn
	X/h8jNSgPjoXBdEss5ot8b/EpphilrLd3aP4FAczi1h7Xj+Zi8Q0znQuZLNH8wMCTc9hotkH
	+RlTHoIJYa13beQUS5g1bPepPPxf5kLWanNOc1BgbnSPTbOUCWfLckdIPRKXoxlVKFhQpibK
	BUX4CnVCXIZSSF8Rk5RYiwLvZDn8u+Am8nduaUYMjWQzJc60MEFKylPVGYnNiKVxWbBkSBEq
	SCX75RkHeVXSPtUBBa9uRgtoQjZXsnUnHy1lYuUpfALPJ/Oq/ypGB83XIL0trT5kvXWv6ODH
	hiVr3Z8bYzwtJcW466L2pSYiZEfK7HTFndPG2aXqmDKNIdxZ0bQp4he2/Yz7+LLQPfGCfXuU
	72K0Ul30zk0cbvt12dcR39Vb5IsdrA+r/LGYVu1qr7kdaytnNGWTMasjD73XdXSYFiXd78pL
	Dt2rzzdt3kfLCHWcPGwZrlLL/wK3saJPSgMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 4 ++--
 kernel/sched/completion.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index bd2c207481d6..3200b741de28 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -41,9 +41,9 @@ do {							\
  */
 #define init_completion_map(x, m) init_completion(x)
 
-static inline void complete_acquire(struct completion *x)
+static inline void complete_acquire(struct completion *x, long timeout)
 {
-	sdt_might_sleep_start(&x->dmap);
+	sdt_might_sleep_start_timeout(&x->dmap, timeout);
 }
 
 static inline void complete_release(struct completion *x)
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 19ee702273c0..5e45a60ff7b3 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -115,7 +115,7 @@ __wait_for_common(struct completion *x,
 {
 	might_sleep();
 
-	complete_acquire(x);
+	complete_acquire(x, timeout);
 
 	raw_spin_lock_irq(&x->wait.lock);
 	timeout = do_wait_for_common(x, action, timeout, state);
-- 
2.17.1

