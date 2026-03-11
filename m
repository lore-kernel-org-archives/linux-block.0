Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A3335066;
	Wed, 11 Mar 2026 02:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773197725; cv=none; b=mZt4JKjnFKsyFRF3GJs8dsFV2IPAIR5jZV7nSLsIe37EluxXElvvs7HYej23mIbu2xP5JRf8jhhMZNhUM/n3Zd1Vkb5ftsNZwA/IOMrMmnIVshG0rDFxU1VVPNXOsih03AXu40LtbuJktlQAxgfsrXsonJ15JNCVSk0ojkyC7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773197725; c=relaxed/simple;
	bh=4u3+gtEUib012v7YC5cXu34H8aOXDqAtRK36fKhKaAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dYcFETB+Z5/GBsD2j8eaU6H2ZzJZA3Nk57HNqxBCx3lBkRdn7Y57H6QidKry0GqQPU6vm/EOjVvH00KlBPyyFYce2woIBUoR8Ne74b621BG+TBuPzm9LFw7gbYEneaJi0iaDSD9lkgaSSWrXysnQrUVwufwUp76i00i4b/cV9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=h/4Ufi4n; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="h/4Ufi4n"
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=4u3+gtEUib012v7YC5cXu34H8aOXDqAtRK36fKhKaAs=;
	b=h/4Ufi4ncFAj7TI6MSKev942d2qNpBe+wC1y/OiVwx7hf94TVMEZBgFBJNMcbfWPDENW61GJq
	L7D6+7cMcnn0z+aBNF040pVSLwjrDCoVXchtLWv189S6ToMBTAZ2n9zyJ/QMXhpMoka6Z/2QSLs
	cKTyhqxog2HPNPIyZzAj540=
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4fVwJ04bYbzYqDFp;
	Wed, 11 Mar 2026 10:51:44 +0800 (CST)
Received: from a003.hihonor.com (10.68.18.8) by w003.hihonor.com (10.68.17.88)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Wed, 11 Mar
 2026 10:55:14 +0800
Received: from a008.hihonor.com (10.68.30.56) by a003.hihonor.com (10.68.18.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Wed, 11 Mar
 2026 10:55:14 +0800
Received: from a008.hihonor.com ([fe80::b6bf:fc6a:207:6851]) by
 a008.hihonor.com ([fe80::b6bf:fc6a:207:6851%6]) with mapi id 15.02.2562.027;
 Wed, 11 Mar 2026 10:55:14 +0800
From: gao xu <gaoxu2@honor.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, "surenb@google.com" <surenb@google.com>,
	zhouxiaolong <zhouxiaolong9@honor.com>
Subject: RE: zram: Optimize LZ4 dictionary compression performance
Thread-Topic: zram: Optimize LZ4 dictionary compression performance
Thread-Index: AdywM2pDLIO0gp5TQXuJ4OQmnHDBWf//vSSA//9WTwCAAeqcAP//Yn0Q
Date: Wed, 11 Mar 2026 02:55:14 +0000
Message-ID: <fd276bd5162e4c5bb09e00cddb0cf8f7@honor.com>
References: <ae51966c3cb445e9983230243bb6a5b2@honor.com>
 <aa-1iKEWKNB0zDwj@google.com> <234ad9d53124461185f60b9cd2f1603e@honor.com>
 <abDDhHV4y68ORzr9@google.com>
In-Reply-To: <abDDhHV4y68ORzr9@google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBPbiAoMjYvMDMvMTAgMDg6MzIpLCBnYW8geHUgd3JvdGU6DQo+ID4gK3N0YXRpYyBpbnQgbHo0
X2NyZWF0ZV9jc3RyZWFtKHN0cnVjdCB6Y29tcF9wYXJhbXMgKnBhcmFtcykgew0KPiA+ICsJaW50
IHJldDsNCj4gPiArDQo+ID4gKwlpZiAoIXBhcmFtcy0+ZGljdCB8fCAhcGFyYW1zLT5kaWN0X3N6
KQ0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsNCj4gPiArCXBhcmFtcy0+ZHJ2X2RhdGEgPSBremFs
bG9jKHNpemVvZihMWjRfc3RyZWFtX3QpLCBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghcGFyYW1z
LT5kcnZfZGF0YSkNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKwlyZXQgPSBM
WjRfbG9hZERpY3QoKExaNF9zdHJlYW1fdCAqKXBhcmFtcy0+ZHJ2X2RhdGEsDQo+ID4gKwkJCSAg
IHBhcmFtcy0+ZGljdCwgcGFyYW1zLT5kaWN0X3N6KTsNCj4gPiArCWlmIChyZXQgIT0gcGFyYW1z
LT5kaWN0X3N6KSB7DQo+ID4gKwkJa2ZyZWUocGFyYW1zLT5kcnZfZGF0YSk7DQo+ID4gKwkJcmV0
dXJuIC1FSU5WQUw7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4g
Pg0KPiA+IHN0YXRpYyBpbnQgbHo0X3NldHVwX3BhcmFtcyhzdHJ1Y3QgemNvbXBfcGFyYW1zICpw
YXJhbXMpIHsNCj4gPiAJaWYgKHBhcmFtcy0+bGV2ZWwgPT0gWkNPTVBfUEFSQU1fTk9fTEVWRUwp
DQo+ID4gCQlwYXJhbXMtPmxldmVsID0gTFo0X0FDQ0VMRVJBVElPTl9ERUZBVUxUOw0KPiA+DQo+
ID4gLSAgIHJldHVybiAwOw0KPiA+ICsJcmV0dXJuIGx6NF9jcmVhdGVfY3N0cmVhbShwYXJhbXMp
Ow0KPiA+IH0NCj4gDQo+IFsuLl0NCj4gDQo+ID4gU2hvdWxkIEkgbW9kaWZ5IGl0IGxpa2UgdGhp
cz8NCj4gDQo+IERvIHlvdSBuZWVkIGx6NF9jcmVhdGVfY3N0cmVhbSgpIGFzIGEgc2VwYXJhdGUg
ZnVuY3Rpb24/IElmIG5vdCwgeW91IGNhbiBqdXN0DQo+IG1vdmUgdGhlIGNvZGUgaW50byBsejRf
c2V0dXBfcGFyYW1zKCkgYW5kIHJlbW92ZSBsejRfY3JlYXRlX2NzdHJlYW0oKT8NCmx6NF9jcmVh
dGVfY3N0cmVhbSgpIGlzIG5vdCBuZWVkZWQgYXMgYSBzZXBhcmF0ZSBmdW5jdGlvbi4gSSB3aWxs
IGFkZHJlc3MgdGhpcyBpbiB2Mi4NCg0K
