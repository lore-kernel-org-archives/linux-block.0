Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D3F3C10B1;
	Mon,  6 Jul 2026 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318789; cv=none; b=BbHKOERIUFvWxWuNqqVShr5+xebavPY/yA8HEgaB+LHtMgPPHNq6g5HpomrKydYT4TF0gaZ9Sd34H2MiVcrIx9A8Sfa5XhZd/VyyzBISanwS8Ba7H712kRGtgTmGQT0uiFm4XnxwXafhn1Eo/53/VZIxze25xl7WWMNVS9t0MAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318789; c=relaxed/simple;
	bh=UPgrUdj2zJuIcM2CRwF3Ndg48wh45GAuitrkG1THTag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jkSZsqwq3KOcIo+nG2DY3c78pT2SGusdPlt1ky1k6rrhcmbZzn0OEEaXlbqrOoUQ4rYAzotogI59gwGJVu1XjHJQlQxzrewqm13lmzILx90ky+i/9z1TZLPnbBaZ1Tqg9/h0jwfOU5K74MZBIw/OdmgXvUdIN8ZX2SBIi/TGbuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-74-6a4b48fbbe23
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
Subject: [PATCH v19 02/40] dept: add single event dependency tracker APIs
Date: Mon,  6 Jul 2026 15:18:50 +0900
Message-Id: <20260706061928.66713-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260706061928.66713-1-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxTG/d/7v7cvo3pTjf7nPrjUMXwJSg1bzodF3avXqYnLvmwjThu5
	kSKgKQh2CQmgIAhIwQARUKBgrbRC0zpFQn1BrUFRQDRBZ5ESqHYdIoUyYQV2i/HLyZPzPM8v
	OcmR0srnzEqpNiVN0KVoklSsHMtHI+qjQ/yOxJj7VZ9BcDIfw2z1VQnk288w0NNsQfAymI+g
	PBvBvNOFoKK3jAbr5WwKJmxzLPhvB0TTM8xCpS8bg+/uNph3v6LANDxHwfDNEwhmKw5CrdEh
	RiveiqnyHgT1HjcNAd8ggsuuAQROcw4LfcOLobO8kIW6HCcDvV1+BC8qyih4YDBSIpuF6srX
	IjYrEqof9jEwZK6SQMijBndJOYbm0W4G/N4yFl7ey2PgatagBCafeCiwFnlpyG8LYnA+Xw/1
	eY0YXK1DFPS11bBQZPuTgQHrPAOPLT0YOqsuYuhuuySeXVrMQL9hBMHpN14E/ikTDc8q/5GA
	KTgmgexbDRjM45UMeJ/mUXDR+ZDdGs//m3sK89ZzVsTnGsRx3JHBzwSfsrxzqg7z942EbyyY
	ofhrVW4JX2c/wh+/M8rwDvM6vqHdR/H1gSDD25sKWN4eKJPsjvpN/lW8kKRNF3QbN++TJ0z0
	ttCHu8hR44ANZyHH0pNIJiVcLKkJ9KIPusk4z4Q1y0WR/v5pOqyXcZ8SR7FX3MulNNe3ihSZ
	inHYWMptJ2OuwoUy5iLJu87bC2UF9wWxtZxi30NXEYvt5gJIxn1JmkNnqbBWipm/xu7hMJRw
	DTJiufAeSriPyS1zPzYgRR1a1ISU2pT0ZI02KXZDgj5Fe3TD/kPJdiR+nCkzFNeKAj0/dyBO
	ilQRCtj6Y6KS0aSn6pM7EJHSqmWKz9fsSFQq4jX6PwTdob26I0lCagf6RIpVKxSbpjLildwB
	TZpwUBAOC7oPLiWVrcxCZ+0xBvXaJyXf2gu+2ad3TXiPrR9588N49Iw7Rtl6oy2WmZ6bPgHX
	487URjddGDe2Zy4/cGXzpkcxP/0e13Kdjvg+I3c2tGuPbWJJace7wLWdsleWj8a7Tg5Yoo7t
	Vdf4favP07+m+fY05rxof/RL5uu/m//jvvt6S67PUzyktz9WF15S4dQEjXodrUvV/A9MRKa5
	bQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxScRTG+997+YMs2h1Z3upDja2XuWkvyzpbL6svddPVauttfSnKO0XR
	DMyy1RKNsrJSFrgCiyhZqQWBltYo09IMXRK9uNS0jSjTwqFQvqBBrS9nv3Oe5zw7H46AFNfy
	ZgtkmdmcIlMql2AhJdyyqiBujE1KWxIsmgWF6pPQ1ePhwXtVPQWB4UIKDJYqDCH9Qz4U2q7w
	4OWHfAra71Ui6AkUIvg1pidBXTdJQUjTxIfhkU4+aFUIJh1NCHQuDQkd7U9JqKpWETBkncDQ
	3+hHoP3swVDap6LAZy5CcNWr50Pfi43wo+cxDya7vxLwITiAwOyZIMBTfwZBSJcO10328Lpu
	EMNY22sSSrXtCG587ibB39eLoLrpEwLH7XwMX4prSHB7psHbgA9Di/Y8hh8uAwE/rRiM+Q4e
	uFr7EZTpNQi8Hx0EFNy0YNCV2Sio633EB1f/OAFdOg0BlbbN0GP2UuAsNhHhc8Ou+zGgLy0g
	wuUbAdq7jwkYMVfw15Uj9pf6IsVW2B8QrPpNCLNV16oQOzaqQexweQHJqovDbeOAj2RP2Y+w
	5c4BzI4G3mHWETRS7CsTw946O0qwJW1xbN3Vbv7W9XuEq5M5uSyHUyxeu0+YOuSykFmtzFHT
	JyuVh+zTz6EoAUMvZypMk7wIY3oh09ExQkY4mp7H2C94w3OhgKTdc5ki8wUqIkynNzG+pvMo
	whQ9n/nd0vh3WUQnMFbLRfwvdC5Taa3/GxRFr2DujZcRERaHPZ2+ZqoYCY1oSgWKlmXmZEhl
	8oR4ZXpqbqbsaPyBgxk2FP4n84nxklo07N7YgGgBkkwVwbrENDFPmqPMzWhAjICURIsWLEpK
	E4uSpbnHOMXBvYrDck7ZgOYIKEmMKHEXt09Mp0izuXSOy+IU/1VCEDU7D3Xaj89KnrdXbV05
	Ur2+y/lkPJCVYnoR2BlcozXGv1dZyiZmHLlksGVf2e3/vv1pL13y3Hi5xXnYPbNX5RxKEnkH
	WxubkXzwWTA2b7Vkx6PEUMPrmQr/0il32uI2ZONLK7OWSbfXusUPa1TfmjNU+22n6wwf/R0J
	WsO2E19wzKEJCaVMlS6NJRVK6R9hxjY0SwMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Wrapped the base APIs for easier annotation on wait and event.  Start
with supporting waiters on each single event.  More general support for
multiple events is a future work.  Do more when the need arises.

How to annotate:

1. Initaialize a map for the interesting wait.

   /*
    * Place along with the wait instance.
    */
   struct dept_map my_wait;

   /*
    * Place in the initialization code.
    */
   sdt_map_init(&my_wait);

2. Place the following at the wait code.

   sdt_wait(&my_wait);

3. Place the following at the event code.

   sdt_event(&my_wait);

That's it!

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept_sdt.h | 65 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 include/linux/dept_sdt.h

diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
new file mode 100644
index 000000000000..0535f763b21b
--- /dev/null
+++ b/include/linux/dept_sdt.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Single-event Dependency Tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ *  Copyright (c) 2024 SK hynix, Inc., Byungchul Park
+ */
+
+#ifndef __LINUX_DEPT_SDT_H
+#define __LINUX_DEPT_SDT_H
+
+#include <linux/kernel.h>
+#include <linux/dept.h>
+
+#ifdef CONFIG_DEPT
+#define sdt_map_init(m)							\
+	do {								\
+		static struct dept_key __key;				\
+		dept_map_init(m, &__key, 0, #m);			\
+	} while (0)
+
+#define sdt_map_init_key(m, k)		dept_map_init(m, k, 0, #m)
+
+#define sdt_wait(m)							\
+	do {								\
+		dept_request_event(m);					\
+		dept_wait(m, 1UL, _THIS_IP_, __func__, 0);		\
+	} while (0)
+
+/*
+ * sdt_might_sleep() and its family will be committed in __schedule()
+ * when it actually gets to __schedule(). Both dept_request_event() and
+ * dept_wait() will be performed on the commit.
+ */
+
+/*
+ * Use the code location as the class key if an explicit map is not used.
+ */
+#define sdt_might_sleep_start(m)					\
+	do {								\
+		struct dept_map *__m = m;				\
+		static struct dept_key __key;				\
+		dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__);\
+	} while (0)
+
+#define sdt_might_sleep_end()		dept_clean_stage()
+
+#define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
+#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__)
+#define sdt_ecxt_exit(m)		dept_ecxt_exit(m, 1UL, _THIS_IP_)
+#define sdt_request_event(m)		dept_request_event(m)
+#else /* !CONFIG_DEPT */
+#define sdt_map_init(m)			do { } while (0)
+#define sdt_map_init_key(m, k)		do { (void)(k); } while (0)
+#define sdt_wait(m)			do { } while (0)
+#define sdt_might_sleep_start(m)	do { } while (0)
+#define sdt_might_sleep_end()		do { } while (0)
+#define sdt_ecxt_enter(m)		do { } while (0)
+#define sdt_event(m)			do { } while (0)
+#define sdt_ecxt_exit(m)		do { } while (0)
+#define sdt_request_event(m)		do { } while (0)
+#endif
+#endif /* __LINUX_DEPT_SDT_H */
-- 
2.17.1

