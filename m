Received: from smtp.cecloud.com (unknown [1.203.97.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8220C19CC33;
	Mon, 10 Feb 2025 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186203; cv=none; b=qEFXhuOgRTQfbMdW/tacpGQi8YQvUCA4CHQyrAbcq4Rp3RphhSTES39wj50eYDNurtot8Bq4AdWZmO9JXx6eZdiQ9bR06hWIJHULYRoqhr0+I2Nlfh264goZ+4x1UFMlRwVQzMbBKeajBHNNitOf7DcbvvwYr5WLyWzctQUhYFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186203; c=relaxed/simple;
	bh=K/M3xwLyDFX1jdGHBfkBVWkXShSQc4kdcR4d+8sm+2Q=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=Fc7/Wp6BjNKVv1ONDfPSBedGjQ3MTAoG0r909z2O5LSjWryM+QAnD4RLl/CUmA5XJWlyMn5n64PdkaM59Pk0zhWO1FfPoFkUwPtBb/uPafLzex36OHOSs/6mDEdiqnZ1Ru6x6k6NNc8BPKZcVwgW1RXwyLlezxlF1e1mwLqMEwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id E4DC2900113;
	Mon, 10 Feb 2025 19:16:35 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ABS-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from desktop-n31qu50 (unknown [39.156.73.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P3907749T281458761199984S1739186193855893_;
	Mon, 10 Feb 2025 19:16:35 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:zhang.guanghui@cestc.cn
X-SENDER:zhang.guanghui@cestc.cn
X-LOGIN-NAME:zhang.guanghui@cestc.cn
X-FST-TO:mgurtovoy@nvidia.com
X-RCPT-COUNT:9
X-LOCAL-RCPT-COUNT:0
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:39.156.73.12
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<32baf4031582f7392568210e34bd5fc1>
X-System-Flag:0
Date: Mon, 10 Feb 2025 19:16:33 +0800
From: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>
To: mgurtovoy <mgurtovoy@nvidia.com>, 
	"Maurizio Lombardi" <mlombard@bsdbackstore.eu>, 
	sagi <sagi@grimberg.me>, 
	kbusch <kbusch@kernel.org>, 
	sashal <sashal@kernel.org>, 
	chunguang.xu <chunguang.xu@shopee.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-nvme <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Subject: Re: Re: nvme-tcp: fix a possible UAF when failing to send request
References: <2025021015413817916143@cestc.cn>, 
	<D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>, 
	<3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>
X-Priority: 3
X-GUID: 9A19E205-D58F-4A37-8423-01B5D65BD1FD
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.331[cn]
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <2025021019163296203221@cestc.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGnvvIzCoAoKCgrCoCDCoMKgwqBUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuCgoKwqDCoMKgwqDC
oEluIG52bWUtcmRtYSB3ZSB1c2UgbnZtZV9ob3N0X3BhdGhfZXJyb3IocnEpwqAswqAgwqB0aGUg
cHJlcmVxdWlzaXRlcyBhcmUgLUVJTywgIGlnbm9yZSB0aGlzIGNvbmRpdGlvbj8gCsKgaW4gbnZt
ZS10Y3AgdGhpcyBqdWRnbWVudCBjb25kaXRpb24gaXMgZGlmZmVyZW50LCAgdXNlIHRoZSBmdW5j
dGlvbiBudm1lX2hvc3RfcGF0aF9lcnJvciAsIAppdCBzaG91bGQgYmUgcG9zc2libGUgdG8gZ28g
dG8gbnZtZV9jb21wbGV0ZV9ycSAtPiAgbnZtZV9yZXRyeV9yZXEgLS0gcmVxdWVzdC0+bXFfaGN0
eCBoYXZlIGJlZW4gZnJlZWQsIGlzIE5VTEwuICAgICAgICAgICAgCgoKCgp6aGFuZy5ndWFuZ2h1
aUBjZXN0Yy5jbgoKCgrCoAoKCgpGcm9tOsKgTWF4IEd1cnRvdm95CgoKCkRhdGU6wqAyMDI1LTAy
LTEwwqAxODoyNAoKCgpUbzrCoE1hdXJpemlvIExvbWJhcmRpOyB6aGFuZy5ndWFuZ2h1aUBjZXN0
Yy5jbjsgc2FnaTsga2J1c2NoOyBzYXNoYWw7IGNodW5ndWFuZy54dQoKCgpDQzrCoGxpbnV4LWtl
cm5lbDsgbGludXgtbnZtZTsgbGludXgtYmxvY2sKCgoKU3ViamVjdDrCoFJlOiBudm1lLXRjcDog
Zml4IGEgcG9zc2libGUgVUFGIHdoZW4gZmFpbGluZyB0byBzZW5kIHJlcXVlc3QKCgoKwqAKCgoK
T24gMTAvMDIvMjAyNSAxMjowMSwgTWF1cml6aW8gTG9tYmFyZGkgd3JvdGU6CgoKCj4gT24gTW9u
IEZlYiAxMCwgMjAyNSBhdCA4OjQxIEFNIENFVCwgemhhbmcuZ3VhbmdodWlAY2VzdGMuY24gd3Jv
dGU6CgoKCj4+IEhlbGxvCgoKCj4+CgoKCj4+CgoKCj4gSSBndWVzcyB5b3UgaGF2ZSB0byBmaXgg
eW91ciBtYWlsIGNsaWVudC4KCgoKPgoKCgo+PsKgIMKgIMKgwqBXaGVuIHVzaW5nIHRoZSBudm1l
LXRjcCBkcml2ZXIgaW4gYSBzdG9yYWdlIGNsdXN0ZXIsIHRoZSBkcml2ZXIgbWF5IHRyaWdnZXIg
YSBudWxsIHBvaW50ZXIgY2F1c2luZyB0aGUgaG9zdCB0byBjcmFzaCBzZXZlcmFsIHRpbWVzLgoK
Cgo+PiBCeSBhbmFseXppbmcgdGhlIHZtY29yZSwgd2Uga25vdyB0aGUgZGlyZWN0IGNhdXNlIGlz
IHRoYXTCoCB0aGUgcmVxdWVzdC0+bXFfaGN0eCB3YXMgdXNlZCBhZnRlciBmcmVlLgoKCgo+PgoK
Cgo+PgoKCgo+PiBDUFUxwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBDUFUyCgoKCj4+CgoKCj4+IG52bWVfdGNwX3BvbGzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBudm1lX3RjcF90cnlfc2VuZMKgIC0tZmFpbGVkIHRvIHNlbmQgcmVxcmVzdCAxMwoKCgo+
IFRoaXMgc2ltcGx5IGxvb2tzIGxpa2UgYSByYWNlIGNvbmRpdGlvbiBiZXR3ZWVuIG52bWVfdGNw
X3BvbGwoKSBhbmQgbnZtZV90Y3BfdHJ5X3NlbmQoKQoKCgo+IFBlcnNvbmFsbHksIEkgd291bGQg
dHJ5IHRvIGZpeCBpdCBpbnNpZGUgdGhlIG52bWUtdGNwIGRyaXZlciB3aXRob3V0CgoKCj4gdG91
Y2hpbmcgdGhlIGNvcmUgZnVuY3Rpb25zLgoKCgo+CgoKCj4gTWF5YmUgbnZtZV90Y3BfcG9sbCBz
aG91bGQganVzdCBlbnN1cmUgdGhhdCBpb193b3JrIGNvbXBsZXRlcyBiZWZvcmUKCgoKPiBjYWxs
aW5nIG52bWVfdGNwX3RyeV9yZWN2KCksIHRoZSBQT0xMSU5HIGZsYWcgc2hvdWxkIHRoZW4gcHJl
dmVudCBpb193b3JrCgoKCj4gZnJvbSBnZXR0aW5nIHJlc2NoZWR1bGVkIGJ5IHRoZSBudm1lX3Rj
cF9kYXRhX3JlYWR5KCkgY2FsbGJhY2suCgoKCj4KCgoKPgoKCgo+IE1hdXJpemlvCgoKCsKgCgoK
Ckl0IHNlZW1zIHRvIG1lIHRoYXQgdGhlIEhPU1RfUEFUSF9FUlJPUiBoYW5kbGluZyBjYW4gYmUg
aW1wcm92ZWQgaW4KCgoKbnZtZS10Y3AuCgoKCsKgCgoKCkluIG52bWUtcmRtYSB3ZSB1c2UgbnZt
ZV9ob3N0X3BhdGhfZXJyb3IocnEpIGFuZCBudm1lX2NsZWFudXBfY21kKHJxKSBpbgoKCgpjYXNl
IHdlIGZhaWwgdG8gc3VibWl0IGEgY29tbWFuZC4uCgoKCsKgCgoKCmNhbiB5b3UgdHJ5IHRvIHJl
cGxhY2luZyBudm1lX3RjcF9lbmRfcmVxdWVzdChibGtfbXFfcnFfZnJvbV9wZHUocmVxKSwKCgoK
TlZNRV9TQ19IT1NUX1BBVEhfRVJST1IpOyBjYWxsIHdpdGggdGhlIHNpbWlsYXIgbG9naWMgd2Ug
dXNlIGluCgoKCm52bWUtcmRtYSBmb3IgaG9zdCBwYXRoIGVycm9yIGhhbmRsaW5nID8KCgoKwqAK
CgoKwqAKCgoKwqAKCgoKwqAKCgo=



