Received: from smtp.cecloud.com (unknown [1.203.97.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4411A12C7FD;
	Fri, 28 Mar 2025 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743153874; cv=none; b=N0ONlGj0jwXZVliYgJF6O/LsWMK5CupXBtqPdOiTflVAFk6lhobVH47X8BJOVjzNOWVganXmAMcdLo4DsEXLoRBRwu+LUDWsWqLolw4MYjt956MAFnABoWiOX2xoNs8zyapztWwBRjUuU4iMZt5Ocp9ersRY1rteiWNI2t/E+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743153874; c=relaxed/simple;
	bh=vbOcQua1kJoV003LNZEFGlJzdO/VYTvOPAg2h3oTidQ=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=I5lUcfc/PMnYUeeLx5IuK/2moz4TwIwFHRYqVLeYqkfc3MLM6FPvtSF2X65YiMLGHPBURZXcdU96GWolHzBFFCq5Yc5asgR8z9cpVeyrJE02lDa9fRq+U9G7ccvw78r3KRf0JIQNfeyCjuN5uz0d6O4FKD25tdKcVJrOXZeYDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 7EEF8900144;
	Fri, 28 Mar 2025 17:24:21 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ABS-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from desktop-n31qu50 (unknown [39.156.73.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P3907749T281458215874928S1743153860161413_;
	Fri, 28 Mar 2025 17:24:20 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:zhang.guanghui@cestc.cn
X-SENDER:zhang.guanghui@cestc.cn
X-LOGIN-NAME:zhang.guanghui@cestc.cn
X-FST-TO:mlombard@bsdbackstore.eu
X-RCPT-COUNT:9
X-LOCAL-RCPT-COUNT:0
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:39.156.73.12
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<d482b18df017b0e78a61940e0cc6a21d>
X-System-Flag:0
Date: Fri, 28 Mar 2025 17:24:19 +0800
From: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>, 
	sagi <sagi@grimberg.me>, 
	mgurtovoy <mgurtovoy@nvidia.com>, 
	kbusch <kbusch@kernel.org>, 
	sashal <sashal@kernel.org>, 
	chunguang.xu <chunguang.xu@shopee.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-nvme <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Subject: Re: Re: nvme-tcp: fix a possible UAF when failing to send request
References: <2025021015413817916143@cestc.cn>, 
	<aed9dde7-3271-4b97-9632-8380d37505d9@grimberg.me>, 
	<202503071810452687957@cestc.cn>, 
	<D8DDP6LIPOKB.2ACTHLE9FPI2A@bsdbackstore.eu>
X-Priority: 3
X-GUID: B902EF6A-813E-44A3-BD2F-D196D9A9356B
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.374[cn]
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <2025032817241899538928@cestc.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGksIAoKICAgICAgU28gZmFyLCAgdGhlIFVBRiBpc3N1ZSBoYXZlIG5vdCBiZWVuIG9jY2N1cnJl
ZCBkdXJpbmcgdGVzdGluZyB0aGlzIHBhdGNoIGluIHRoZSBzYW1lIHNpdHVhdGlvbi4gCkFkZGl0
aW9uYWxseSwgdGhlIHBhdGNoIHRyaWdnZXJzIGEgY29tcGlsYXRpb24gd2FybmluZywgIG52bWVf
dGNwX2ZhaWxfcmVxdWVzdCBpcyBkZWNsYXJlZCBidXQgbm90IGRlZmluZWQsIHBsZWFzZSBhbHNv
IHJldmlldy4gIAoKVGhhbmtzIAoKCgoKemhhbmcuZ3VhbmdodWlAY2VzdGMuY24KCgoKwqAKCgoK
5Y+R5Lu25Lq677yawqBNYXVyaXppbyBMb21iYXJkaQoKCgrlj5HpgIHml7bpl7TvvJrCoDIwMjUt
MDMtMTHCoDE4OjUyCgoKCuaUtuS7tuS6uu+8msKgemhhbmcuZ3VhbmdodWlAY2VzdGMuY247IHNh
Z2k7IG1ndXJ0b3ZveTsga2J1c2NoOyBzYXNoYWw7IGNodW5ndWFuZy54dQoKCgrmioTpgIHvvJrC
oGxpbnV4LWtlcm5lbDsgbGludXgtbnZtZTsgbGludXgtYmxvY2sKCgoK5Li76aKY77yawqBSZTog
bnZtZS10Y3A6IGZpeCBhIHBvc3NpYmxlIFVBRiB3aGVuIGZhaWxpbmcgdG8gc2VuZCByZXF1ZXN0
44CQ6K+35rOo5oSP77yM6YKu5Lu255Sxc2FnaWdyaW1AZ21haWwuY29t5Luj5Y+R44CRCgoKCk9u
IEZyaSBNYXIgNywgMjAyNSBhdCAxMToxMCBBTSBDRVQsIHpoYW5nLmd1YW5naHVpQGNlc3RjLmNu
IHdyb3RlOgoKCgo+CgoKCj4gSGkKCgoKPgoKCgo+wqDCoMKgwqDCoMKgwqDCoCBBZnRlciB0ZXN0
aW5nIHRoaXMgcGF0Y2gswqDCoCBzZW5kaW5nIHJlcXVlc3QgZmFpbHVyZSBvY2N1cnJlZCzCoMKg
IHVuZm9ydHVuYXRlbHksIHRoZSBpc3N1ZSBzdGlsbCBwZXJzaXN0cy4KCgoKwqAKCgoKTWF5YmUg
SSBhbSBjb21wbGV0ZWx5IHdyb25nIGJ1dCBJIGFtIHN0aWxsIHF1aXRlIGNvbnZpbmNlZCB0aGF0
IHRoZSBwcm9ibGVtIGhlcmUKCgoKaXMgdGhhdCwgZGVzcGl0ZSB0aGUgbnZtZV90Y3BfdHJ5X3Nl
bmQoKSBmYWlsdXJlLCB0aGUgdGFyZ2V0IHNlbmRzIGEgcmVzcG9uc2UgY2Fwc3VsZQoKCgpmb3Ig
dGhlIGNvbW1hbmQsIGxlYWRpbmcgdG8gYSBkb3VibGUtY29tcGxldGlvbiBpbiB0aGUgaG9zdC4K
CgoKwqAKCgoKU2FnaSwgd2hhdCBhYm91dCB0YWtpbmcgdGhpcyBwYXRjaDogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtbnZtZS8yMDI1MDMwNjE2MDMyMi4xMzcwMzAwLTItbWxvbWJhcmRA
cmVkaGF0LmNvbS9ULyN1CgoKCmFuZCBkbyBhIHN0ZXAgZnVydGhlciBieSBub3QgY29tcGxldGlu
ZyB0aGUgcmVxdWVzdCwgbGVhdmluZyB0aGUgZXJyb3IKCgoKcmVjb3ZlcnkgaGFuZGxlciB0aGUg
dGFzayBvZiBjbGVhbmluZyBldmVyeXRoaW5nIHVwPwoKCgrCoAoKCgrCoAoKCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYwoKCgpp
bmRleCAzMjdmM2YyZjUzOTkuLjcyYzFkNzk0ODM4NiAxMDA2NDQKCgoKLS0tIGEvZHJpdmVycy9u
dm1lL2hvc3QvdGNwLmMKCgoKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMKCgoKQEAgLTEz
MjgsOCArMTMyOCw4IEBAIHN0YXRpYyBpbnQgbnZtZV90Y3BfdHJ5X3NlbmQoc3RydWN0IG52bWVf
dGNwX3F1ZXVlICpxdWV1ZSkKCgoKfSBlbHNlIGlmIChyZXQgPCAwKSB7CgoKCmRldl9lcnIocXVl
dWUtPmN0cmwtPmN0cmwuZGV2aWNlLAoKCgoiZmFpbGVkIHRvIHNlbmQgcmVxdWVzdCAlZFxuIiwg
cmV0KTsKCgoKLSBudm1lX3RjcF9mYWlsX3JlcXVlc3QocXVldWUtPnJlcXVlc3QpOwoKCgpudm1l
X3RjcF9kb25lX3NlbmRfcmVxKHF1ZXVlKTsKCgoKKyBudm1lX3RjcF9lcnJvcl9yZWNvdmVyeSgm
cXVldWUtPmN0cmwtPmN0cmwpOwoKCgp9CgoKCm91dDoKCgoKbWVtYWxsb2Nfbm9yZWNsYWltX3Jl
c3RvcmUobm9yZWNsYWltX2ZsYWcpOwoKCgrCoAoKCgrCoAoKCgpNYXVyaXppbwoKCgrCoAoKCgrC
oAoKCg==



