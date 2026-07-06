Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60B83C10B7;
	Mon,  6 Jul 2026 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318948; cv=none; b=sLPELSbBidgKaK/O3lSCBnAnH94sTam70V+7OcepkhRJRue+B+FAcj8xRkjRhfhDhOr6wCDDpFW/p38EpD0W4J3n3/Nm1mhgBK5ZvOZpo8SLRjaAT4eWfqCxLeGkQqV7i59Qo+1XxorY65tUCqG85BZyOW1zAsQnuy2dou1Fx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318948; c=relaxed/simple;
	bh=4COXvF59c/1DTqwH8B+Ve+9eXwb29DTJEmWnDMVF5Ls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SHosDzCKTJ8bYcTYkqijC4K7EHj4gx6eIr6mfJsqU3VSHAOCjfV/dbGQzzDIRr/FOfRKXOIJXg5F7kgh43mFswY47OwTfenmJ6IEYFN3rbBD69h6h+HV8LMaskLmSyKwqE46Afjq2OErt7jETGlI5EuZLuSBQYCvIxn4fRXddP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-5e-6a4b49848897
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
Subject: [PATCH v19 39/40] rust: completion: Add __rust_helper to rust_helper_wait_for_completion()
Date: Mon,  6 Jul 2026 15:19:27 +0900
Message-Id: <20260706061928.66713-40-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260706061928.66713-1-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTdxSH/b93Kk3eVJK9ygdc4w0QBk63k2EcMTN5HVuC2ZfFS7SBN6PI
	xRRbZckW6EDQWVcwBUctlBBbaAtoC4oXHMOJFOU21lKwOsSuuHEThBoJGFvMvpw853fyez4d
	BpeMkBsYec5JQZEjy5JSIkI0HV4bV7Q/JTNhdnYHuAs7CCi1/0rCQJMVga4QQcVgOQ6T9+aD
	2zMfBVV+PQ3DgSkEJt9bDHwdJQhWKo5De72agn+0rTg4dT9TYFS3k2DQlyP4qa6Zgptjt2jQ
	V77AQNd4G4M3JgsNj+q8BOh7h0hYfpYIXdYJGpqm+0mY9JdTcKNgjAb7yH0EtvN+HOzP3SS0
	j8ZC6coCgq62cQyGbl2m4E/rAAHNEx4MHnZ1E+CsaiDgyvAgBoELkTBQpiHh4owfwWTAhMNI
	5RQNftcZDBpqzAgeaDowKHlxm4K7pWMYTFQZMLi3OIWBw67DYelJGwm913to6FnqwcA6SEDr
	/dc0FL76G0GRdxcYFhKhccWNYEa7QCYn87ZqG+KLtcGxtOii+LLeOP5m1ROaL7o7SvNGu5Iv
	+mOa5B31MXzdnX8x3m45S/EzfX007/urEuNrC3Q4X+08wP9msNGpUQdFu9OFLLlKUHy055go
	o8XSgE48J0+PlpWgArRInENhDMfu5Eo1k0FmVlntVYZiit3KeTxv8BBHsBs5h8ZPnkMiBmeH
	orjzJs1qdx2bxlW7+lGICXYzV9MyR4ZYzH7C9elvkO/9UZz1aseqKCyYNy0bsBBL2F3c49kH
	REjKsc1hnN4+Tr0vrOd+r/cQWiQ2ojUWJJHnqLJl8qyd8Rn5OfLT8Wm52XYUfDjTD8uH2tD8
	wDediGWQNFwMyV9mSkiZKi8/uxNxDC6NEG/ZlpIpEafL8r8XFLlHFcosIa8TRTKE9APxjsCp
	dAn7neykcFwQTgiK/68YE7ahAB3jWq7ZzO4kl+Uz7Z1Z7+fmvfv6fU+9qT0x6lhznzv84mFn
	9H+PHz11VHfHXYqekCcZA7nDexO2GFO+8EhdBz8+9fLTSFfC0SSzSi/fVOFcPz59aaWlsLtY
	SWqyv9Kmnp2aP/Lt0rYP1xZHJHga1aZf2hzbv1bG/jgXfblGNfcw/oKUyMuQJcbgijzZOxo5
	Q0hsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTdxTHd3730UtjzbWSeONMMDXoYoLTKOM4NwT8gzuNZv8Qk02ijd5A
	eVTTKsqI0VKqFdBAl7bRykOURoEptp2IpJFAxAc+6OqDKIhoxRFQFKnIo2JL4j8nn3O+3/PN
	+eNwlLKJWchptHslnVado2LltHzLOmNc0W+bslbePcKj2XQIe/oCDD42tNIYHDPTePpSA4sh
	R5MMza6TDN56Ukhj18V6wL6gGXB8ykGhqXmGxpClQ4ZjE89kaDUAzng7AG0+C4XdXdcpbPAY
	CH5s/MLiUPsooLU/wKJ90EDjiLMU8NSAQ4aDN1LxbV8LgzO9bwg++TQM6Ax8IRhoPQoYsmVj
	VY07vG57z+LUvQcU2q1dgGf6eykcHXwB6Ol4Dug9X8ji67J/KfQH5uLD4AiLt60lLL71nSb4
	rpHF6kIvg767Q4AVDgvgwFMvQePZSyzaKlw0Nr+4JkPf0DTBHpuFYL1rM/Y5B2jsLKsh4XPD
	rssL0GE3knD5n6D1nxaCE846WVItiOOmE7RY575CRNN/IVZsqGwAcWrSAuJYrZESTWXhtn14
	hBKL3PvF2s5hVpwMPmJF76dqWrxTI4jnjk0SsfxenNh8qlf2e/If8l92STmaPEn3Y+IOeaan
	7gLsecUceFp+FA5DkC4GjhP4NUJhz75iiOJYfpnQ3T1BRTiaXyy4jw8wxSDnKN4fI5Q6j9MR
	YT6/U6h89AAiTPOxQpXnAxNhBf+TcN/RNMsCHyPUN7bOBkWF5xenK0iElXy88GzkJl0G8mr4
	rg6iNdq8XLUmJ36FPjszX6s5sGLn7lwXhN/JeXC6/CqM+VPbgOdANUeBSRuzlIw6T5+f2wYC
	R6miFUt/2JSlVOxS5/8l6XZv1+3LkfRt8D1HqxYoNm6Vdij5DPVeKVuS9ki6byrhohYehvqC
	DKLasP/XReN/Dh46WzRn9Lb6zSuDv+qdN5ZUzqR0HCxWOSfiStakGVlH8/qUgrypto/zRy9P
	O6t+Ftv7l23zJLjnhtITEpNal7xcLs9f70uJeZjcuTW+Pe36Z+32tavdab3xiRb/vG0JUbX9
	LvffZ+al39QXbEi3HzN32hWTBSpan6letZzS6dVfAdgyZ0pKAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

This is needed to inline these helpers into Rust code, which is required
for DEPT to play with wait_for_completion().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 rust/helpers/completion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/helpers/completion.c b/rust/helpers/completion.c
index 5ea2eef74abc..7b55c960fe22 100644
--- a/rust/helpers/completion.c
+++ b/rust/helpers/completion.c
@@ -7,7 +7,7 @@ __rust_helper void rust_helper_init_completion(struct completion *x)
 	init_completion(x);
 }
 
-void rust_helper_wait_for_completion(struct completion *x)
+__rust_helper void rust_helper_wait_for_completion(struct completion *x)
 {
 	wait_for_completion(x);
 }
-- 
2.17.1

