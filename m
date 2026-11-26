Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691097;
	b=RunnG10CjVuJrd2v8852JW2UdtWH0xxAn4gS0AJPwEWbmJFI90tEMlVvdzNgfHMbcyeh
	 z9EWpbH8As+K+EZBW6Nl7sySvs4petp8twGt3CvCYqRxZoHEuLn8foXDAC80VzpJfyZfO
	 CxZmt+muVaVoJDVWeOz4/6ur4U/5RvzREmpqiogiayK4fBGcM/oYQFpRDk9TaIKZos/uG
	 YFbDbooq+RcoT8aw2YoWzvNi9HAGyTAZkEQFe1rX8Yp2L40htC/Vpqzv1Hz8dDczSO1IY
	 A4r+JJwx0h8TYlQAAiWyNa5a2HrHxd2zaJJWcMKDXAIuyTtypdrFqnAERHCMzxmx2ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691097;
	h=DMARC-Filter:Received:Received:X-Originating-IP:Date:
	 X-CM-HeaderCharset:From:To:Cc:Subject:X-Priority:X-Mailer:In-Reply-To:
	 References:Content-Transfer-Encoding:X-CM-CTRLDATA:Content-Type:
	 MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=7WZrC5amErdAZUKH3zA00f9ty+dy4dlRNgU1aieOoRU=;
	b=EV0EsMFzZGuwkK83jHawFIj/tiA+X1LzGmzTOdOcePtAkP+q0U7avZBKWvtrwv8esfqj
	 B9S/GC3X38c1sXKhT6BKKfFWJ5K+6oWCTI9/g0qDL60LoSZncpM8/elDhdd/iSN9VFD0c
	 C+gvkpSKcTwt+n419l9oFurKK4lOw+Q62N1BozBEfYcLcnIMIGqd4IHuI4Zzu51cwFR4Q
	 54t2XDfuZkaGKI6UpcmxGIy5Ddd5jYbCXX7SHiVLTmr82gC6W+q50HsTEnKIusMiA37uy
	 sBFBTllNdFVEJGfzYl4MMEnUznUvvTdGqEdDP38zMtTRqpWQ9ov96Lh6ZApD5AQWvrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phytium.com.cn;
	spf=pass smtp.mailfrom=phytium.com.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C1D606A31C;
	Thu, 26 Nov 2026 11:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60C1D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwBXXqZTEghrctX5Bg--.11306S2;
	Thu, 26 Nov 2026 19:04:51 +0800 (CST)
Received: from yangyizhen3198$phytium.com.cn ( [218.76.62.144] ) by
 ajax-webmail-mail (Coremail) ; Thu, 26 Nov 2026 19:04:50 +0800 (GMT+08:00)
Date: Thu, 26 Nov 2026 19:04:50 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2o6L2255SE?= <yangyizhen3198@phytium.com.cn>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Jens Axboe" <axboe@kernel.dk>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Jan Kara" <jack@suse.cz>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [RFC PATCH 0/1] block: long udev open waits during cache
 teardown
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250512(e7b47ee3) Copyright (c) 2002-2026 www.mailtech.cn OP_ICM_ICMVM
In-Reply-To: <20261120-hassliebe-arena-kaufvertrag-3ac58fd0483a@brauner>
References: <20261117105107.14236-1-yangyizhen3198@phytium.com.cn>
 <20261120-hassliebe-arena-kaufvertrag-3ac58fd0483a@brauner>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: Lc7SY2Zvb3Rlcl90eHQ9MTM4NzozODM=
Content-Type: text/plain; charset=UTF-8
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <4effe3b8.6085.1a217879319.Coremail.yangyizhen3198@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAf8Dw8nVSEghrOBUAAQ--.52298W
X-CM-SenderInfo: 51dqw5pl2kv0atrzmqxsk13x1xpou0fpof0/1tbiAQALDWsHN0wEe
	QABss
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=yangyizhen
	3198@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZw4xXr18Zr4rAF1xtrWkWFg_yoWrXryUp3
	W8t3W8Aw1UGw17G3ySgw18ZryUC3yUGr47Ja10y3sFywnrJrnIqrnxKFW8J3WjgFyYyrWD
	tw17Z398Xr1UtrUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

SGkgQ2hyaXN0aWFuLAoKPiBJZiB0aGF0IHN0aWxsIHJlcHJvZHVjZXMgb24gbWFpbmxpbmUgaXQn
cyBhIHF1ZXN0aW9uCj4gYWJvdXQgdGhlIGJkZXYgcmVsZWFzZSBsb2NraW5nLgoKSSByZXByb2R1
Y2VkIHRoZSBsb25nIHVkZXYgb3BlbiB3YWl0IG9uIHVwc3RyZWFtIExpbnV4IHY2LjYgYW5kIG9u
CkxpbnV4IHY3LjAuMTQuIE9uIGJvdGgga2VybmVscywgdWRldiBibG9ja2VkIHdoaWxlIHRyeWlu
ZyB0byBvcGVuIHRoZQpkZXZpY2UgYXMgbWtmcy5udGZzIHdhcyBjbG9zaW5nIGl0IGFmdGVyIGEg
ZnVsbCBmb3JtYXQuCgpUaGFua3MgZm9yIHBvaW50aW5nIG91dCB0aGUgaW1wYWN0IG9uIG90aGVy
IG9wZW5lcnMuIEkgYWdyZWUgdGhhdCBhCnVkZXYgcHJvYmUgY2xvc2luZyBpdHMgb3duIGZpbGUg
Y291bGQgdHJpZ2dlciB3cml0ZWJhY2sgYW5kIGV2aWN0CmNhY2hlIHRoYXQgYW5vdGhlciBvcGVu
ZXIgaXMgc3RpbGwgdXNpbmcuIEknbGwgZHJvcCB0aGUgX19mcHV0KCkKcHJvcG9zYWwuCgpJJ2Qg
bGlrZSB0byB1bmRlcnN0YW5kIHRoZSBsb2NraW5nIHJlcXVpcmVtZW50cyBpbiB0aGUgYmxvY2sg
ZGV2aWNlCmxhc3QtY2xvc2UgcGF0aC4gSW4gcGFydGljdWxhciwgd2h5IGRvZXMga2lsbF9iZGV2
KCkgbmVlZCB0byBjb21wbGV0ZQp3aGlsZSBvcGVuX211dGV4IGlzIGhlbGQ/IFdoYXQgc3RhdGUg
YW5kIG9yZGVyaW5nIHJlcXVpcmVtZW50cyBkb2VzCnRoZSBsb2NrIHByb3RlY3QgZHVyaW5nIHRo
aXMgY2xlYW51cD8KCkknbSBhc2tpbmcgYmVjYXVzZSB0aGUgZGV2aWNlIG1hcHBpbmcgY2FuIHN0
aWxsIGNvbnRhaW4gYSBsYXJnZQphbW91bnQgb2YgY2xlYW4gcGFnZSBjYWNoZSBhZnRlciB0aGUg
ZWFybHkgc3luYy4gSW4gbXkgdGVzdHMgb24gdGhlCnZlbmRvciA2LjYga2VybmVsLCBhYm91dCA4
MDUgR2lCIHJlbWFpbmVkIGF0IGZpbmFsIHRlYXJkb3duLCBhbmQKdGhlIHRydW5jYXRlIHRvb2sg
cm91Z2hseSBzZXZlbiBtaW51dGVzIHdoaWxlIHVkZXYgd2FzIHdhaXRpbmcuCkNvdWxkIHRoZSBy
ZWxlYXNlIHBhdGggYmUgY2hhbmdlZCB0byByZWR1Y2UgdGhlIHRpbWUgb3Blbl9tdXRleCBpcwpo
ZWxkIHdoaWxlIHByZXNlcnZpbmcgdGhvc2UgcmVxdWlyZW1lbnRzPwoKPiBBbmQgbWtmcyBjYW4g
anVzdCBmc3luYygpIGFuZCBQT1NJWF9GQURWX0RPTlRORUVEIHRoZSBkZXZpY2UgaXRzZWxmCj4g
YmVmb3JlIGl0IGNsb3NlcyBpdC4KCkkndmUgc3VibWl0dGVkIGEgcGF0Y2ggdG8gdGhlIG50ZnMt
M2cgcHJvamVjdCB0aGF0IGNhbGxzIGZzeW5jKCkKYW5kIHRoZW4gcG9zaXhfZmFkdmlzZSguLi4s
IFBPU0lYX0ZBRFZfRE9OVE5FRUQpIGluIHVzZXJzcGFjZQpiZWZvcmUgY2xvc2luZyB0aGUgZGV2
aWNlLgoKVGhhbmtzLApFdGhhbg0KDQrkv6Hmga/lronlhajlo7DmmI7vvJrmnKzpgq7ku7bljIXl
kKvkv6Hmga/lvZLlj5Hku7bkurrmiYDlnKjnu4Tnu4fmiYDmnIks5Y+R5Lu25Lq65omA5Zyo57uE
57uH5a+56K+l6YKu5Lu25oul5pyJ5omA5pyJ5p2D5Yip44CC6K+35o6l5pS26ICF5rOo5oSP5L+d
5a+GLOacque7j+WPkeS7tuS6uuS5pumdouiuuOWPryzkuI3lvpflkJHku7vkvZXnrKzkuInmlrnn
u4Tnu4flkozkuKrkurrpgI/pnLLmnKzpgq7ku7bmiYDlkKvkv6Hmga/jgIINCkluZm9ybWF0aW9u
IFNlY3VyaXR5IE5vdGljZTogVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIG1haWwg
aXMgc29sZWx5IHByb3BlcnR5IG9mIHRoZSBzZW5kZXIncyBvcmdhbml6YXRpb24uVGhpcyBtYWls
IGNvbW11bmljYXRpb24gaXMgY29uZmlkZW50aWFsLlJlY2lwaWVudHMgbmFtZWQgYWJvdmUgYXJl
IG9ibGlnYXRlZCB0byBtYWludGFpbiBzZWNyZWN5IGFuZCBhcmUgbm90IHBlcm1pdHRlZCB0byBk
aXNjbG9zZSB0aGUgY29udGVudHMgb2YgdGhpcyBjb21tdW5pY2F0aW9uIHRvIG90aGVycy4=

