Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F292EB87F;
	Mon,  6 Jul 2026 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318879; cv=none; b=Kz8IMZsa0PWVYamidDXvcl7qFh0koH0u8t70U4UMY1ZrnErMBfkAiwkgFhtxmnUt/3N6sXg3X/fQDOm7MvEDRZmOjPfmCnNc+xs9rRd5S8ZRpD7EtCg+RwsPOajE6B9EiZe/Q2BViHnLTBUgP8S6xxodl2W1jGrwBj5lU0XQquY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318879; c=relaxed/simple;
	bh=uG3xryX72/VrJ5xN0YK0iTHXuo6Y0vSJs70jtDbKz5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uZeIBGLiORT9aPM/EXeslsV0HUMpKSjwaTM1aHMNq7BdOc4i0JMa8JgGPqje1Wb43ZoBnniq74obz+ZGsMFgRm7+8A42w6YafaKoHhZFZRkwikFGgcdK8gCgDPONhCXqubt9yaUzEiXHk79qw7SUtGgLOj8HN4rRhGwMS5NRDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-9e-6a4b490083a4
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: max.byungchul.park@gmail.com,
	kernel_team@skhynix.com,
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
Subject: [PATCH v19 20/40] dept: apply timeout consideration to dma fence wait
Date: Mon,  6 Jul 2026 15:19:08 +0900
Message-Id: <20260706061928.66713-21-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260706061928.66713-1-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTZxzGfc/lPYfGLieV4BGz6LpMNxSGiOZvpga/zNexuOk+TeOlkZNR
	KGCKMjDZUpcRkduwDdVQq0ViJXigWFQUbYJVEGK4KApELLEWykgFNpQiUmBcsm+/PM+T36eH
	p1U9bCSvTT8h6dM1OjVWMIqR5eXR1J7ElFhvzRa46JAxTE5baHg/1cfBnKsZgXzzNAXvamcx
	jNkLEcx5hiiwD8xSMNB4BsGMORUC5n8wTLd10HC+tBNBuddDg6vyDwyDJbdoeD4xhqG1tACD
	1WJEYLY6GXgaCFHwymyk4Pwwhil7FQdvKss4CHk3wZwtA2pGOlgI+I0Y6g2vOZAL/fPGlxsg
	b+Y9gn55jgWDZZKFJ80tDHQ0VLNwtecpBb0lgwiqR69gMI36EQSCdhrsE2McNNsiwOgf5+DM
	3/cwtFnaWXjkqKfA4X9Iw1CZlQLTMxuGj547LHQbL8/TtSYEb4pHOBi3zrJQGsrDUJBrZuBW
	0yQH0x8uYihu3w0fan0sWJr6uYQEMplbzBD5koyIK2hjyLm2aHK3zMMRm/MkqauMIhX3hyny
	MrCDOKvOYuIcN3JktL2dIy0Xphly17uNlBtKaXKpdd+Pqw8otidJOm2WpP9651FFcn9jLTru
	5rP7bvRgA7Jw+SiMF4V40eGS6XzEL3Lhn58uxFhYL/b2TtELHC6sFeuK/Gw+UvC00LVGLLQX
	MQvFCmGveNbrW2RG+EKcKDBRC6wUtor/Fnjwkn+NeL22cVEUNp/XhKyLG5WwRewbe8wsbSrC
	REMgdolXiQ8qe5kSpLShZVVIpU3PStNodfExyTnp2uyYYxlpTjR/N/tvoYN30HjnT24k8Ei9
	XAkJ36WoWE1WZk6aG4k8rQ5XrvsyMUWlTNLknJL0GUf0J3VSphut5hn1SmVc8NcklfCL5oSU
	KknHJf3/LcWHRRpQfFyR75zrm++7Irs/P1DTPRx6vmqgOqZuhShfiXEf1m9L/ZYUrXcmT20s
	/+Sz4AZdnOJ6ovroY/su/ML8w9Deqw0ljol1T/Ke/d4aldDi2X/7q2P7d+YqfBVvfSbVZuw7
	tEzOzo08pBoMNoBzppOJHe4zJXX9Fft2888Rl4fI7o89aiYzWbMpitZnav4D5K0reGoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTcRTG/d97d3cdri5L6qKVMcii0GZkHKjE8ENXI4k+WPmlVl1yOjW2
	mhpIvg1fC11tUnNlpiN8KdvK0liJ5XuSZqXkW9JciTNNN0Xdsin05fA753nOw/lwKFz0kudH
	yZKucookqVxMCghB9KHsIK/I4/GSIbsQ8tQ3YHjMyoOvmc0EOB15BJQ9rSXBrX/JhzzTXR50
	DGQR0PukBsGYMw/B4ooeB3XjKgFuTRsfHEtDfNBmIli1tCHQ9WlwGOx9i0Pt80wM5uv/kjD1
	bg6BdtxKQulkJgEzxiIE92x6Pky2HoPpsdc8WB35icHAgh2B0foXA2tzLgK3LgEeVJg967pZ
	ElZ6PuJQqu1F8HB8BIe5ye8InreNIrA8ziJhovgFDv3WDfDZOUNCp7aQhOm+Mgx+15NQnmXh
	Qd+HKQQGvQaB7ZsFg+xHT0nQGUwENH5v4kPflAuDYZ0GgxrTCRgz2gjoLq7APOd6XM+2gL40
	G/OUXxho615jsGSs5odXIXZRfYtgq80NGKv+5CbZ2vu1iF1Z1iDWUZWNs+piT/vOPoOzOeYU
	tqrbTrLLzi8ka1koJ9iuCoatzF/G2JKeILbx3gj/5NFYweFLnFym4hT7ws4L4kab69GVFip1
	6NkAmYH0/AJEUQx9gCnK2VaAvCmS3sUMDi7ha+xL72DMN228AiSgcLo/gCky3iTWhE10NJM/
	/mOdCXon4yy8ja2xkD7I/CkcIdeYoQOYmvrm9SBvz/yJy7DuEdGhzNBMO1GMBOXIqxr5ypJU
	iVKZPDRYmRCXliRLDb6YnGhCnncyprtKXiFH/7EWRFNI7COE8Kh4EU+qUqYltiCGwsW+wsDd
	x+NFwkvStOucIvmc4pqcU7Ygf4oQbxFGnebOi+jL0qtcAsdd4RT/VYzy9stAHf3BnRMbG8os
	e832tuWm9sCFriZDTOvmif3zDRkqn5AISeAZVVNybpeY8Xeafjnzj368LA/pif3htp1uOKJ/
	Izn5wCU72xUUERwzrkuX7Ke3ihqn0COv+YW7F+4c0kZHSlzhH3inZt/7mO/7bo+rdESEpchj
	VlPrYvPrug2CSjGhjJOG7MEVSuk/SRws0EoDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to dma fence wait.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/dma-buf/dma-fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index f7498c770035..b75b7b9c445a 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -823,7 +823,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 	cb.task = current;
 	list_add(&cb.base.node, &fence->cb_list);
 
-	sdt_might_sleep_start(NULL);
+	sdt_might_sleep_start_timeout(NULL, timeout);
 	while (!dma_fence_test_signaled_flag(fence) && ret > 0) {
 		if (intr)
 			__set_current_state(TASK_INTERRUPTIBLE);
@@ -927,7 +927,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		}
 	}
 
-	sdt_might_sleep_start(NULL);
+	sdt_might_sleep_start_timeout(NULL, timeout);
 	while (ret > 0) {
 		if (intr)
 			set_current_state(TASK_INTERRUPTIBLE);
-- 
2.17.1

