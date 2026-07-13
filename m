Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D9D25B0B3;
	Mon, 13 Jul 2026 03:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913801; cv=none; b=Hps71Y7xLQfxf0sQb3B24jDdVu3hMLqVQ+AKbH8FvX38fdPugXLRo1OlfEB3L7Bdxb44XvecA8g4wu7W3uEsuxy/DvuzZ/c8mR6nlFC1y21kKWGG8mPrqj73b+QCqc6Pc3SA6zdR2G8duILZAaRJCyLrMiG1m4XvdJLOzxrLnbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913801; c=relaxed/simple;
	bh=/M9QIh4BDhVbOh90sNI83T2LK3a7Bga3WuACDOoWjts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJdOWW07FlHvhRpYiEK2ytkir90nqsAz1jDXkz/tOiEy8dQCwMZeyCdsZSYOo1xE6QGrWfK46tAOJpTLgNcnFqGPuHYlikcFMkhsTFWMuD8SAGfy5CZev44/9MzoGBKT3eNj+7lJIn+9oMWFeuayvmS4eUBVmjsbRvDGEDf48vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-f9-6a545d3c324c
Date: Mon, 13 Jul 2026 12:36:23 +0900
From: Byungchul Park <byungchul@sk.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, linux-kernel@vger.kernel.org,
	max.byungchul.park@gmail.com, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
	tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
	sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
	ngupta@vflare.org, linux-block@vger.kernel.org,
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
	djwong@kernel.org, dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, harry.yoo@oracle.com,
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
	boqun.feng@gmail.com, longman@redhat.com, yunseong.kim@ericsson.com,
	ysk@kzalloc.com, yeoreum.yun@arm.com, netdev@vger.kernel.org,
	matthew.brost@intel.com, her0gyugyu@gmail.com, corbet@lwn.net,
	catalin.marinas@arm.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org,
	gustavo@padovan.org, christian.koenig@amd.com,
	andi.shyti@kernel.org, arnd@arndb.de, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
	mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
	samitolvanen@google.com, paulmck@kernel.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, urezki@gmail.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	chuck.lever@oracle.com, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, mark.rutland@arm.com, ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com, wangkefeng.wang@huawei.com,
	broonie@kernel.org, kevin.brodsky@arm.com, dwmw@amazon.co.uk,
	shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com,
	yuzhao@google.com, baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com, joel.granados@kernel.org,
	richard.weiyang@gmail.com, geert+renesas@glider.be,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	alexander.shishkin@linux.intel.com, lillian@star-ark.net,
	chenhuacai@kernel.org, francesco@valla.it,
	guoweikang.kernel@gmail.com, link@vivo.com, jpoimboe@kernel.org,
	masahiroy@kernel.org, brauner@kernel.org,
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com,
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, 2407018371@qq.com, dakr@kernel.org,
	neilb@ownmail.net, bagasdotme@gmail.com,
	wsa+renesas@sang-engineering.com, dave.hansen@intel.com,
	geert@linux-m68k.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v19 39/40] rust: completion: Add __rust_helper to
 rust_helper_wait_for_completion()
Message-ID: <20260713033623.GA79338@system.software.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-40-byungchul@sk.com>
 <CANiq72kEo=bGcHNaSA9JZhv4iuE+YDvu0kN+Z7aopVp3=2C+Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kEo=bGcHNaSA9JZhv4iuE+YDvu0kN+Z7aopVp3=2C+Wg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0wTdxjH87u73l0bm1w7F35AxkwNWcKCHcQlj8u28MqdL9xmXELioluR
	c9RB0VY7MVlCxW5uQ+zq2oZWXC1QSmlAccifrUsFLW5YB8QITjYnqWUIVFcKWyeDHXVmvPvm
	+3yf7+d58bCkspfOYrW6Q4JepylX0TJKNrfOk//a7nf2vzTbhuGWKUTBP65uBobb2xAkU3cY
	WAmGEdhHrCTMDCQQOKZNFDz01iKYvvoGjC3OIvBGlwmIhj5FMGN/RMPjyE8kOGzDCL4J/4og
	6DtGw31LFwlzI2cIcB8LSqDBZUXQ+1sfAxN2KwFDFg8hFtNgv5ABLkcNAdcbJyjwVudCuG2K
	gZmYlYbkzXsEBGpjJJzoW6Ag+POLEO6ZJKBjalxsCF+j4E7kFAPNYyMEnI7HxGMWvSTcdswy
	MBpyE9AajNDQ+nULAmsswUCiaZGCwZMhAj5pukDAlY5uApp9cxKYcjYQMLAwS8DfLVcRJBqW
	JWCuTTHwhdlOwfk/Wmgwzd9FcHziZUi2+WmIW5KSoiLef/ESwQfOBhCfbK4h+R89mP8yks/3
	On9heHfnYf74lTkJf9GXxzd+N03w5xILEr7T/xnNn3v8O8nHb9xg+N57W/joTQfxds4u2aul
	QrnWKOjVr78vKzOt1JEHXNSRyfpOVI0ayc+RlMXcZrzk9kieattQHVrVFJeLT4xeo1Y1zb2A
	x8dT6fx6rhDfGvpW9GUsydlysOfhmfTCM5wWT1mC6ZCcA3w/tZL2lVwrws6Zoie+Av9QH02X
	kmLp0tlRMc+KOhu3LLNP7OdxTZcrXSPlduDGUIRe1c9yG3Ho0iCxysVcXIo9p8P/HZ2JL/vG
	KQtSONcgnGsQzv8RzjUIN6L8SKnVGSs02vLNm8qqdNojm/ZWVnQi8aG9Hy+924MSwzv7Ecci
	1Tr5ecPO/UqJxmioquhHmCVV6+UF2aIlL9VUHRX0le/pD5cLhn6UzVKqDHnh4kelSu4DzSHh
	Q0E4IOifTglWmlWNqp/b9mCvk9u1b3tgbDBorrf5i40DxVl75gs2xnL1IffW+Z7Jg+bbNQoq
	Z8ujg9vZ7zfk9nk8rQ/azdNUypjRLqgV6q7oUVNeXjDQ0545snB9d9PdP980+qXa7pIdb6mz
	ZLa/9vm2mepKdB2Vl9Unw8uFW0eLT5X4Fa9syI9/lamiDGWagjxSb9D8C1H9KO/MAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTVxjHPffenl6a1VwRw4lkc3bqlhl1bmKeRLJp/MDN3qJjZsuWRTq5
	WWsBsVUmJoqldtbNNKWm7WgrMBhVsUNWsA6hGYGIVUbkZUNUEFgqjoGACJjyVi81y/hy8j+/
	839+eT4clo6145WsOvOQoM1UpiuwjJF9vM2wIemrT/e/FR5ZByZjLnT3hiTQqa9nYHLCxID7
	shfDnOuqFEy+AgkE7+Qx0FpxCUHvpAnBsxkXDcaaCANz1iYpTITvS8GmRxAJNCGwt1lp6Gr9
	nQZvtZ6Cp5XzGIYaxxHY+kMYHIN6BkY9ZxA4B1xSGLyeDI97ayUQ6XlEwZ2pYQSe0DwFofpT
	CObsGigqqRLH7WMYZlpu0+CwtSL4qb+HhvHBPgTVTQ8QBC7kYXhouUJDR2gp/Dk5iuGm7QcM
	j9vcFIxUYijOC0ig7Y8hBOdcVgQD9wIUGEovY7Cf8zFQ03dNCm1DsxR0260UXPJ9BL2eAQaa
	LSWUuK7Y+jUeXA4DJR7/UGD7pZaCsKdcur0M8c+MZoYvr/JTvLF9DvPeQi/iZ6atiJ8oM9C8
	0SJeG4dHaf5k1bd8WfMw5qcn/8J8YKqY4W+VEP7n09MUn9+yga9x9kh37fhClpQmpKuzBe2m
	d1NlKn3ETGe5mCN/F/jQCVRKf49iWMJtIbZmM1rIDLeWmNqDzELG3Oukqysc7cRxb5PO5lqR
	y1ias71CSkbd0YHlnJo8sgSiJTkH5GE4EuWx3EVEnEPbX/Bl5GZBKCqlRelsYbvYZ8WcQM7P
	sy/wKmK44opqYrjdpLS+BS/kFdxrpN5/g7Kgpc5FJucik/N/k3ORqRgx5ShOnZmdoVSnJ27U
	aVQ5meojG/cdyPAh8bd6js3m/4YmOpIbEMcixUvySl3K/liJMluXk9GACEsr4uSbE0QkT1Pm
	HBW0B/ZqD6cLugaUwDKKePn7nwmpsdw3ykOCRhCyBO1/rxQbs/IECn4i+NHaiuu55j1nD75x
	xvDBj/1POnFa4a01n+s0I1/Ghf9d0mcz5j5ReOMTHRcHXnWM95UuyavcYZ66sDfl6tfF608X
	jfEpLTfcSauPyxP9yp1jsxXBdzSdyVtXn7x/+7vhuvOkruNe1ofBs1t1iZ6RIr9K1Z2ldj/N
	r3j5vWXCg7sKRqdSbn6T1uqUzwG4/G81qQMAAA==
X-CFilter-Loop: Reflected

On Sat, Jul 11, 2026 at 02:13:05PM +0200, Miguel Ojeda wrote:
> On Mon, Jul 6, 2026 at 8:22 AM Byungchul Park <byungchul@sk.com> wrote:
> >
> > This is needed to inline these helpers into Rust code, which is required
> > for DEPT to play with wait_for_completion().
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> 
> Apart from what Gary said -- why did you need to do this in a separate
> patch in the same series?

Not necessary.  I will make them into one patch.  Thanks.

	Byungchul
> 
> Cheers,
> Miguel
