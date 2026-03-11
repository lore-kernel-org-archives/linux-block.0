Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B6299A84;
	Wed, 11 Mar 2026 02:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773197793; cv=none; b=cfmSSigbYsuJeDSRQEticRmn7dbdZyqqoCQ+vepf4xK0etnDrBEdsVZFQwQtlzDqiTdOk5YowFJDqKlzwJ3S4zNYg13yyoT1Q6Qgr8npo5K6tIpzF2DissEvhxDEHjPzLwWpr9ajtc6PeOKoXBi7v6kY3U8Vf/CRNd5Sy9iloxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773197793; c=relaxed/simple;
	bh=Q9aBZxjFu39QyPUFT9Sh/900eb15M3zE+ILF77QF2X8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ElJtNe5vHnc7u7HqRB3DWmpjMt/WKIq+J8lBidU1E3/lAnhH4rK9HqgNsKmK2swjcax7hrPJu3OdGGKCfYrZt4QgXHmXoA8IxmSkDFSHoPmcedbNqhdTssJOvBMahwRLAStTKTgMHLiOZNQIZD6q25KJYz0ZXyI2v9pkMOs3zcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4fVwKg4XZXzYlGxF;
	Wed, 11 Mar 2026 10:53:11 +0800 (CST)
Received: from a004.hihonor.com (10.68.27.131) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Wed, 11 Mar
 2026 10:56:29 +0800
Received: from a008.hihonor.com (10.68.30.56) by a004.hihonor.com
 (10.68.27.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Wed, 11 Mar
 2026 10:56:29 +0800
Received: from a008.hihonor.com ([fe80::b6bf:fc6a:207:6851]) by
 a008.hihonor.com ([fe80::b6bf:fc6a:207:6851%6]) with mapi id 15.02.2562.027;
 Wed, 11 Mar 2026 10:56:29 +0800
From: gao xu <gaoxu2@honor.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, "surenb@google.com" <surenb@google.com>,
	zhouxiaolong <zhouxiaolong9@honor.com>
Subject: RE: zram: Optimize LZ4 dictionary compression performance
Thread-Topic: zram: Optimize LZ4 dictionary compression performance
Thread-Index: AdywM2pDLIO0gp5TQXuJ4OQmnHDBWQAf200AABPs2tA=
Date: Wed, 11 Mar 2026 02:56:28 +0000
Message-ID: <7a3f025cd5e24b21a31453ab95145657@honor.com>
References: <ae51966c3cb445e9983230243bb6a5b2@honor.com>
 <abDEHBAYV7F7jX2n@google.com>
In-Reply-To: <abDEHBAYV7F7jX2n@google.com>
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

PiBPbiAoMjYvMDMvMTAgMDI6NTQpLCBnYW8geHUgd3JvdGU6DQo+ID4NCj4gPiBUaGlzIG9wdGlt
aXphdGlvbiBpbXByb3ZlcyBMWjQgZGljdGlvbmFyeSBjb21wcmVzc2lvbiBwZXJmb3JtYW5jZSBi
eQ0KPiA+IG92ZXIgNTAlIGluIFpyYW0gSS9PIHRlc3RzLg0KPiANCj4gQ2FuIHlvdSBhbHNvIGFk
ZCBhIGxpdHRsZSBtb3JlIGRldGFpbHMgaGVyZT8gIFdoYXQgdHlwZSBvZiBhIHRlc3QsIGFjdHVh
bCBJTw0KPiBudW1iZXJzIG1heWJlLCBldGMuDQpSZWNlaXZlZCwgQWRkIGl0IGluIHYyLg0K
