Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E05B3E9F76;
	Mon,  6 Jul 2026 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318897; cv=none; b=V05sNCRX7YtW2FskqmQ1D2Kn8WmNAqMVlyCK+sG47RQsMbrs6BhBlphkkBnMnMs24sdGFNSMjLA3/WIkTuzrM5zyhdFj6zKdh91k61YS0wZDDVzhdQZG6pEmjVqPO/P/EsBDiYYkO77ErWphm1nox2IBHubA0MP3vlAad1a5xBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318897; c=relaxed/simple;
	bh=zDQdYdTFavgacMtdiXy3/hskR9xaYH1DaF21getAMWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GNSkDN98Cvnd6admLCwwFiAcLGxwLcSPLuy/p+GsZj7X3Mokkn4dZfl5ELX90cE/3PRmyVKDTvq/yORLCYFvFqNnalrdx7v4O6PuQyCUvIVy73YIi0H6Ceie96I2gCDLjhi4vjVivQC0f2b1CtJKbeBwd7oXwInIqPVQDcF267A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-2e-6a4b4905a985
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
Subject: [PATCH v19 33/40] dept: call dept_hardirqs_off() in local_irq_*() regardless of irq state
Date: Mon,  6 Jul 2026 15:19:21 +0900
Message-Id: <20260706061928.66713-34-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260706061928.66713-1-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxTG9977vvdeKt1uOjKuuMSlmdPgB5PhchIXhu4P7uayzJkZP6Ku
	GzejfBRWFGTBhG6WgSukcWubwdAyRltrN7G1RjeJCkEDGRW/Zhm6wlYbq5QGKFTkYysY/3vy
	nOf8zvPH4WjFAEnj1Jr9klajKlIyMiyLJLesZd/dUvD6becbcDcQJDAZq8VQ6/6BQGCyFoH+
	/H8Y5o5eYSE2PciCv/8iDa4zOgom2ucZeNQ1jsA0HGQgajMgiAR+J3BnagSBLThPQfDSNwjm
	zIVw/CcPAxZTP4KW4Xs0jIeHENw3emnoMX3LgPWrDgLmZjeGgC2EwRJmwHw6FZosDyiYtjlZ
	+MfRyELgag0B90A3ApchREPHX6uhpeZnDBc6ehJ952IIqpviBNruXKdgeMhPwDYZZUF3uRWD
	Y8xC4Ir1JfBe1COomZgn0NfkI3C34SGGU6EuGtocEQJdkyMUeNwmGp7YE2f6zvayoDdMs2Ca
	rWXA2x1noX3MzsDM4x8ZaPDlQnNsPYwaYyQnR4zrG7CovzHHiK5jLiTOPDmKxFjb17R42FMh
	dkxZsXi+8R4rWt0HRI8jXWy9EKZEt7OOEUd9PlYM3rJQ4rGerWJrw3fkw7RdsrfypCJ1uaTN
	yP5Elv/gTz0p1b1wMOSCahRZcgQlcQKfJfTdGMXP9LUzukXN8CsFv3+aXtAp/CuCpz5EjiAZ
	R/M3lwsGW/1i6EX+U8Ec+TsR4jjMrxDqb5Uu2HL+TcF21kg9ZS4XTrZfWuQkJfxfZ5sXfQW/
	QRiMXsULTIG3JwkmZy95urBUuOzwYyOSW9FzTqRQa8qLVeqirHX5lRr1wXWflRS7UeLhbIdm
	d59D4/3bOhHPIWWyHHLeK1AQVXlZZXEnEjhamSJ/bdWWAoU8T1X5paQt2ac9UCSVdaJlHFam
	yjOnKvIU/Oeq/VKhJJVK2mdTiktKq0abM1B0p8abvGlAtuTf4Y3vxP3ebWu4cKHui4k/nk/P
	zvw+87F6a+Wy6Ksph8PQVqWo2FNRFZhfvbZqZm92/OMNOz7I8FXNbu/+Tf92Vu6hXzbZZR8N
	vryj8aTavHvv0veLedo7lNtTZ08NnzPTdRljdb1+leHEyJ6StL4wNnqVmwuVuCxftT6d1pap
	/gdoHahobAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xScRTH+90XV5K6Ec07bdlYT0urle30WPbmmus129r6p6juEgUzKItW
	SyCmPWxEgUs0zZI1pTIflDWWs2UPa0n2cOWjB1FOiVZY+UBDW/+cfc/nfM93549D42InGUkr
	0vfz6nS5UkoJCeGGJYZYMjEpde4JxxzIMR6D1g4PCa91dQT0BHIIKLjhoCBouyWAnMoLJDx6
	oyeg6Xo5go6eHAS/+204GGuHCAiaGwQQ6H0nAIsOwZCrAYHVbcahpekeDo5qHQY/KwYp6Lr/
	A4Hlg4eCvE4dAX77aQT5XpsAOh/IwNdxl4Shti8YvPnVjcDuGcTAU5eNIGhNg6KSqtC69TsF
	/c+e45BnaUJw6UMbDj863yOobmhH4Lqqp+CzqQaHZs8YeNnjp+Cx5RQFPncBBt8qKCjWu0hw
	P+1CUGgzI/C+dWFguHyDAmthJQG17+8IwN01gEGr1YxBeeV66LB7CWg0lWChc0OumxFgyzNg
	ofIVA8u1uxj02ssEy0sR99t4huDKqpwYZ3wRpDjHRQfi+vvMiAuUGnDOaAq197v9OHe86iBX
	2thNcX09ryjO9auY4J6UsNyVE30Yd/ZZLFeb3ybYtGKbcOluXqnI5NVzlu0Qpnx9bSQzdGMP
	eR2QhXyjT6IwmmUWsM+rdcSwppjpbEtLLz6sJcxktirXS55EQhpnmqPZ0/bcEdN4Zidr9bWH
	TDRNMFPZ3JcZw1jELGTtThP2LzOaLa+oG8kJC/HrA4UjXMzEs+/8DwkTEhajUWVIokjPVMkV
	yvg4TVqKNl1xKG7XXlUlCn2T/ejA2dso0CyrRwyNpOEiWL4uVUzKMzVaVT1iaVwqEU2bkZQq
	Fu2Waw/z6r3b1QeUvKYeRdGENEK0biu/Q8zske/n03g+g1f/n2J0WGQWulWTrfRLuFFrHdPu
	zIjJ7t066WPUqnPYlORA8Jg2fO30yT7JlVUDWRPVTnf827hZ81dPiNJGvpiavCjxJlqcXIav
	UanOxSQcWR3VvuXy5i/hR/cl/BkXiNZr/Pol9bNlO396Z9ZuDPTrGrelnTl/QC4rkh3+HPuA
	SJj/9NPKmsEVW45ICU2KfF4MrtbI/wIjatboSQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

For dept to function properly, dept_task()->hardirqs_enabled must be set
correctly.  If it fails to set this value to false, for example, dept
may mistakenly think irq is still enabled even when it's not.

Do dept_hardirqs_off() regardless of irq state not to miss any
unexpected cases by any chance e.g. changes of the state by asm code.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/irqflags.h | 14 ++++++++++++++
 kernel/dependency/dept.c |  1 +
 2 files changed, 15 insertions(+)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index d8b9cf093f83..586f5bad4da7 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -214,6 +214,13 @@ extern void warn_bogus_irq_restore(void);
 		raw_local_irq_disable();		\
 		if (!was_disabled)			\
 			trace_hardirqs_off();		\
+		/*					\
+		 * Just in case that C code has missed	\
+		 * trace_hardirqs_off() at the first	\
+		 * place e.g. disabling irq at asm code.\
+		 */					\
+		else					\
+			dept_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_save(flags)				\
@@ -221,6 +228,13 @@ extern void warn_bogus_irq_restore(void);
 		raw_local_irq_save(flags);		\
 		if (!raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_off();		\
+		/*					\
+		 * Just in case that C code has missed	\
+		 * trace_hardirqs_off() at the first	\
+		 * place e.g. disabling irq at asm code.\
+		 */					\
+		else					\
+			dept_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_restore(flags)			\
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 007e1bc7d201..35a3667ac8b3 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -2095,6 +2095,7 @@ void noinstr dept_hardirqs_off(void)
 	 */
 	dept_task()->hardirqs_enabled = false;
 }
+EXPORT_SYMBOL_GPL(dept_hardirqs_off);
 
 void noinstr dept_update_cxt(void)
 {
-- 
2.17.1

