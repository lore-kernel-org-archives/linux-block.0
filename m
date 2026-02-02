Received: from sg-1-19.ptr.blmpb.com (sg-1-19.ptr.blmpb.com [118.26.132.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2151D29E115
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018576; cv=none; b=D3bZU7J4D6BRkXs0ayAEodg32h+RWRlP1z7nDTMUFTk2ncviauNH47AMrTFVLG7F0+quig/1o5Gw3xEnaSUbD23qJ5P78niC68kh+zaaF6N5xe30+JcKTutTT8POkafI9SyrVd0KO+NvE+6aZoq+CZf/DKvt43SQR6ALTt0PzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018576; c=relaxed/simple;
	bh=799aH8gm77DZrDBPaQbKno137uaHwnm7KFWKIVxc1MM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:Content-Type:
	 Message-Id:Mime-Version; b=qq7Nfx4RjI9DTlN5rGqmF2/+CMwdunuXUjyTwKX63nEV3UpVTo5ZcWFj2i7fNjZk6xjcNQND8vaMEqVEF+x6t0bpHCSQoinexNSBDrjxXzGzhJgAiY1PcNpHZA69Ndz5RweSIfT/rjqgBafC3koGsFFR2WKj6SRFmf/fIMW4ocA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=jxRgTYdq; arc=none smtp.client-ip=118.26.132.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="jxRgTYdq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1770018554;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=799aH8gm77DZrDBPaQbKno137uaHwnm7KFWKIVxc1MM=;
 b=jxRgTYdqIyQGdIsrVw+6Cy1MBuK05yT9VCbaVs7ze7z9F0Fzh45B/msDji9Zg1Zl1Y5DML
 pLtkAEOpgKlFKMe1LybADc0JTSXBDCxdyUAwI8ZHayDmz4mG04+aL8W4vCmXN5t3YoLQix
 fJP+Zi7LiqSqNgDu+3wglUC93+J9F6p6yDk5ZKzjWl2LHaPPtwIubZy4wA0qHX8kDQAJQK
 mVIjClrpmBw+fXMNljA7CxXpWY9PC570TGQ6QgGiJhCurM9+sDMeFCuWczZubtuhXGxSMV
 QqNMeQDeU50s1qtCVY8LIazltKtd7ulT984X5BUcalCHgaMMGDpwHTFNjBykjg==
Subject: Re: [PATCH 4/6] blk-cgroup: skip dying blkg in blkcg_activate_policy()
Received: from [192.168.1.104] ([39.182.0.137]) by smtp.feishu.cn with ESMTPS; Mon, 02 Feb 2026 15:49:10 +0800
Content-Language: en-US
Reply-To: yukuai@fnnas.com
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Mon, 2 Feb 2026 15:49:08 +0800
References: <20260115163818.162968-1-yukuai@fnnas.com> <20260115163818.162968-5-yukuai@fnnas.com> <e109f724-128c-4d67-a7b2-2165d6036962@huaweicloud.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
In-Reply-To: <e109f724-128c-4d67-a7b2-2165d6036962@huaweicloud.com>
X-Lms-Return-Path: <lba+2698056f7+b4ab2b+vger.kernel.org+yukuai@fnnas.com>
To: "Zheng Qixing" <zhengqixing@huaweicloud.com>
Cc: <mkoutny@suse.com>, <hch@infradead.org>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>, <tj@kernel.org>, <nilay@linux.ibm.com>, 
	<ming.lei@redhat.com>, "Zheng Qixing" <zhengqixing@huawei.com>, 
	<yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: base64
Message-Id: <d36ab8c2-01a5-4772-b2c7-3b68e5361758@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

SGksDQoNCuWcqCAyMDI2LzIvMiAxNDozOCwgWmhlbmcgUWl4aW5nIOWGmemBkzoNCj4gSGkgS3Vh
aSwNCj4+IGRpZmYgLS1naXQgYS9ibG9jay9ibGstY2dyb3VwLmMgYi9ibG9jay9ibGstY2dyb3Vw
LmMNCj4+IGluZGV4IGE2YWM2YmE5NDMwZC4uOGQ5MjczZjYxZGQ1IDEwMDY0NA0KPj4gLS0tIGEv
YmxvY2svYmxrLWNncm91cC5jDQo+PiArKysgYi9ibG9jay9ibGstY2dyb3VwLmMNCj4+IEBAIC0x
NjI1LDYgKzE2MjUsOCBAQCBpbnQgYmxrY2dfYWN0aXZhdGVfcG9saWN5KHN0cnVjdCBnZW5kaXNr
ICpkaXNrLCANCj4+IGNvbnN0IHN0cnVjdCBibGtjZ19wb2xpY3kgKnBvbCkNCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBHRlBfTk9XQUlUIGZhaWxlZC7CoCBGcmVlIHRoZSBleGlz
dGluZyBvbmUgYW5kDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogcHJlYWxsb2Mg
Zm9yIEBibGtnIHcvIEdGUF9LRVJORUwuDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICovDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaGxpc3RfdW5oYXNoZWQoJmJsa2ct
PmJsa2NnX25vZGUpKQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51
ZTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChwaW5uZWRfYmxrZykNCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmxrZ19wdXQocGlubmVkX2Jsa2cpOw0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmxrZ19nZXQoYmxrZyk7DQo+DQo+IFdlIGNh
biBjaGVjayBobGlzdF91bmhhc2hlZCgmYmxrZy0+YmxrY2dfbm9kZSkgZWFybGllciwgYmVmb3Jl
IGNhbGxpbmcNCj4gLT5wZF9hbGxvY19mbihHRlBfTk9XQUlULCAuLi4pLg0KPg0KWWVzLCB0aGlz
IGlzIGNvcnJlY3QuDQoNCg0KPiBMaWtlIHRoaXM6DQo+IGRpZmYgLS1naXQgYS9ibG9jay9ibGst
Y2dyb3VwLmMgYi9ibG9jay9ibGstY2dyb3VwLmMNCj4gaW5kZXggZGJkMThiNzVlYzkxLi5hYTU2
NmYwMzlmODggMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2Jsay1jZ3JvdXAuYw0KPiArKysgYi9ibG9j
ay9ibGstY2dyb3VwLmMNCj4gQEAgLTEzMzQsNiArMTMzNCw5IEBAIGludCBibGtjZ19hY3RpdmF0
ZV9wb2xpY3koc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsDQo+IMKgIMKgIMKgIMKgIGxpc3RfZm9y
X2VhY2hfZW50cnlfcmV2ZXJzZShibGtnLCAmcS0+YmxrZ19saXN0LCBxX25vZGUpIHsNCj4gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RydWN0IGJsa2dfcG9saWN5X2RhdGEgKnBkOw0KPg0KPiAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoaGxpc3RfdW5oYXNoZWQoJmJsa2ctPmJsa2NnX25v
ZGUpKQ0KPiArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb250aW51ZTsNCj4g
Kw0KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoYmxrZy0+cGRbcG9sLT5wbGlkXSkNCj4g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29udGludWU7DQo+DQo+DQo+IFRo
YW5rcywNCj4NCj4gUWl4aW5nDQo+DQo+DQotLSANClRoYW5zaywNCkt1YWk=
