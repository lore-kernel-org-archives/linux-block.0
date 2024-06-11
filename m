Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC85174EC9;
	Tue, 11 Jun 2024 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115845; cv=none; b=HdQQNg5SKAtSw0HkjSySQgKFlXf0Lrswg/42bTUCvQKmKvFUQHxC1geUbZNZlhTJZm04/0ALRcZe527beJXKVKIp39/ZxQ/+X+rgy6yjNgK0PPsi814F9IMNfjVtO3uH8hhs71yaIBgTczOoFdDszsDbMKzZpiEIsMVtRt1iDCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115845; c=relaxed/simple;
	bh=HQTvWBn7mIOw13b3k/z/rr/G6016XCcqCgFHAJfi/Ws=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fz5fl02HA7Lsp34L0DPHQPgIoLMAoj2OLKHtMn5ePcsm46hJXXy/DyOmsK+tePnH900f/e1AhbtsRdIV8DK0T/Ohn77uJ1Jv3sLKgXBXceITtGhING9+yFzpf9nFm//8EREOjrJpK4RpLy1ZB79Q2a1jiU1d//lkde8Y65CBtFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msexch01.omp.ru (10.188.4.12) by msexch02.omp.ru (10.188.4.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 11 Jun
 2024 17:23:48 +0300
Received: from msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753]) by
 msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753%5]) with mapi id 15.02.1258.012;
 Tue, 11 Jun 2024 17:23:48 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: "axboe@kernel.dk" <axboe@kernel.dk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Karina Yankevich <k.yankevich@omp.ru>, "lvc-patches@linuxtesting.org"
	<lvc-patches@linuxtesting.org>, Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [bug report] block: integer overflow in __bvec_gap_to_prev()
Thread-Topic: [bug report] block: integer overflow in __bvec_gap_to_prev()
Thread-Index: AQHavAr58l5gsx+jFUKOz/Vibcz91g==
Date: Tue, 11 Jun 2024 14:23:48 +0000
Message-ID: <9d8ac82ab63a64583f753878dd03e3503c68ffbe.camel@omp.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: msexch02.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 6/11/2024 10:46:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="utf-8"
Content-ID: <158CCA59EAA81C45B9E45B96D7FCE8F4@omp.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVsbG8uDQoNClRoZXJlIGlzIGEgY2FzZSBvZiBpbnRlZ2VyIG92ZXJmbG93IGluIF9fYnZlY19n
YXBfdG9fcHJldigpOg0KDQoJKChicHJ2LT5idl9vZmZzZXQgKyBicHJ2LT5idl9sZW4pICYgbGlt
LT52aXJ0X2JvdW5kYXJ5X21hc2spOw0KDQpiaW9fdmVjIGNhbiBjcm9zcyBtdWx0aXBsZSBwYWdl
czoNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE5MDIxNTExMTMyNC4zMDEyOS0x
LW1pbmcubGVpQHJlZGhhdC5jb20vdC8NCg0KU28sIGluIGNhc2UgYmlvIGhhcyBvbmUgYmlvX3Zl
YyBidl9sZW4gY2FuIGhhdmUgYSBtYXhpbXVtIHZhbHVlIG9mIFVJTlRfTUFYLg0KVGhlIGNoZWNr
IGhhcHBlbnMgaW4gYmlvX2Z1bGwoKS4gSW4gdGhlIGNhc2Ugd2hlbiBidl9sZW4gaXMgZXF1YWwg
dG8NClVJTlRfTUFYIGFuZCBidl9vZmZzZXQgaXMgZ3JlYXRlciB0aGFuIHplcm8sIGFuIG92ZXJm
bG93IG1heSBvY2N1ci4NCg0KRm91bmQgYnkgTGludXggVmVyaWZpY2F0aW9uIENlbnRlciAobGlu
dXh0ZXN0aW5nLm9yZykgd2l0aCBTdmFjZS4NCg==
