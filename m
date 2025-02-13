Received: from smtp.cecloud.com (unknown [1.203.97.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB9D35967;
	Thu, 13 Feb 2025 02:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412262; cv=none; b=BRiJQGmAVACGcXg9VbniNhoHCBRoEdy3WHJjcK3R0KIaBdocezPd30BbZyIRotPJAt01pE/zmbQWnyI/QjTjDxp8tUQoYcq/j7ylpB7n4t4Ep1TzTvjYOMw9NiZC6cslguklPWBC14VifcWnDEE8TlyDvCtpBhKA5/PbNsiSgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412262; c=relaxed/simple;
	bh=NSDRTuga0MkO0W08CvcqI1raHoXXbW7VQYz2Z9EBuow=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=DBJ4HXB8SESidm13+tjB16naM2Tnm+FOMZNdmEQ2rZpwUzpKb9+EqS1jdHbjBhh6ytBfLRNTzyfdwEW9LJwlyOXYqDmu3tW6OS5ZjeOSqMgBLaCYGPT1vt6i0IEf8/EoJDJaQ2x6FkyzuINsWRL3IgrO1CPUExozJAoArvBXjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 75D37900112;
	Thu, 13 Feb 2025 10:04:14 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ABS-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from desktop-n31qu50 (unknown [39.156.73.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P3907749T281457503039856S1739412253345638_;
	Thu, 13 Feb 2025 10:04:13 +0800 (CST)
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
X-UNIQUE-TAG:<02ea9cf93b2237e61f342787f67686eb>
X-System-Flag:0
Date: Thu, 13 Feb 2025 10:04:12 +0800
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
	<D7QKRU1EXDXJ.K6ZXC4V4ZD68@bsdbackstore.eu>, 
	<D7QLI3PYQ877.1KH6K8K08P2IP@bsdbackstore.eu>
X-Priority: 3
X-GUID: 6C6F996D-3B8B-4E53-B9DA-DE2606B99DCC
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.331[cn]
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <2025021310041218941132@cestc.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

CkhpIArCoMKgwqDCoCBpbnQgZmFjdCwgIHRoZSBjb21taXQgYWVhY2ZjZWZhMjE4ZjRlZDExZGE0
NzhlOWI3OTE1YTM3ZDFhZmFmZiAgaGFzIGJlZW4gc3luY2hyb25pemVkLCBidXQgdGhlIGlzc3Vl
IHN0aWxsIG9jY3Vycy4KCsKgwqDCoMKgSSB0aGluayBzbywgd2hlbiB0aGUgaG9zdCBmYWlsaW5n
IHRvIHNlbmQgcmVxdWVzdCAtMTMsICAgbWF5YmUgb25seSBwYXJ0IG9mIHRoZSBjb21tYW5kIGhh
cyBiZWVuIHNlbnQgb3IgIHRoZSBjb250cm9sbGVyIGhhcyByZWNldmVkICBhIGNvbXBsZXRlIGNv
bW1hbmQuCmJ1dCB0aGUgY29udHJvbGxlciBtYXkgc2VuZCBudm1lX3RjcF9yc3AgIGFuZCAgQzJI
VGVybVJlcSBjb25zZWN1dGl2ZWx5LiAgTm93IEkgYW0gYW5hbHl6aW5nIHRoZSBjb250cm9sbGVy
IHNwZGsgcHJvY2Vzc2luZyBsb2dpYy4gCndoZW4gdGhlIGhvc3QgdXNlcyBudm1lX3RjcF9wb2xs
LCAgaXQgcmVjZWl2ZXMgbnZtZV90Y3BfcnNwIGFuZCBoYW5kbGVzIGl0IGZpcnN0bHksICAgIAp0
aGVuIHRoZSBob3N0ICBoYXZlIGEgVUFGIGFuZCBjcmFzaGVkLiAgIAoKCgoKemhhbmcuZ3Vhbmdo
dWlAY2VzdGMuY24KCgoKwqAKCgoKRnJvbTrCoE1hdXJpemlvIExvbWJhcmRpCgoKCkRhdGU6wqAy
MDI1LTAyLTEzwqAwMDowNwoKCgpUbzrCoE1hdXJpemlvIExvbWJhcmRpOyB6aGFuZy5ndWFuZ2h1
aUBjZXN0Yy5jbjsgc2FnaTsgbWd1cnRvdm95OyBrYnVzY2g7IHNhc2hhbDsgY2h1bmd1YW5nLnh1
CgoKCkNDOsKgbGludXgta2VybmVsOyBsaW51eC1udm1lOyBsaW51eC1ibG9jawoKCgpTdWJqZWN0
OsKgUmU6IG52bWUtdGNwOiBmaXggYSBwb3NzaWJsZSBVQUYgd2hlbiBmYWlsaW5nIHRvIHNlbmQg
cmVxdWVzdAoKCgpPbiBXZWQgRmViIDEyLCAyMDI1IGF0IDQ6MzMgUE0gQ0VULCBNYXVyaXppbyBM
b21iYXJkaSB3cm90ZToKCgoKPgoKCgo+IFRha2luZyBhIHN0ZXAgYmFjay4gTGV0J3MgdGFrZSBh
IGRpZmZlcmVudCBhcHByb2FjaCBhbmQgdHJ5IHRvIGF2b2lkIHRoZQoKCgo+IGRvdWJsZSBjb21w
bGV0aW9uLgoKCgo+CgoKCj4gVGhlIHByb2JsZW0gaGVyZSBpcyB0aGF0IGFwcGFyZW50bHkgd2Ug
cmVjZWl2ZWQgYSBudm1lX3RjcF9yc3AgY2Fwc3VsZQoKCgo+IGZyb20gdGhlIHRhcmdldCwgbWVh
bmluZyB0aGF0IHRoZSBjb21tYW5kIGhhcyBiZWVuIHByb2Nlc3NlZCAoSSBndWVzcwoKCgo+IHRo
ZSBjYXBzdWxlIGhhcyBhbiBlcnJvciBzdGF0dXM/KQoKCgo+CgoKCj4gU28gbWF5YmUgb25seSBw
YXJ0IG9mIHRoZSBjb21tYW5kIGhhcyBiZWVuIHNlbnQ/CgoKCj4gV2h5IHdlIHJlY2VpdmUgdGhl
IHJzcCBjYXBzdWxlIGF0IGFsbD8gU2hvdWxkbid0IHRoaXMgYmUgdHJlYXRlZCBhcyBhIGZhdGFs
CgoKCj4gZXJyb3IgYnkgdGhlIGNvbnRyb2xsZXI/ICAKCi0tCgoKwqAKCgoKwqAKCgoKPiBUaGUg
TlZNZS9UQ1Agc3BlY2lmaWNhdGlvbiBzYXlzCgoKCsKgCgoKCioqKioqKgoKCgpXaGVuIGEgY29u
dHJvbGxlciBkZXRlY3RzIGEgZmF0YWwgZXJyb3IsIHRoYXQgY29udHJvbGxlciBzaGFsbDoKCgoK
wqAgMS4gc3RvcCBwcm9jZXNzaW5nIGFueSBQRFVzIHRoYXQgYXJyaXZlIG9uIHRoZSBjb25uZWN0
aW9uOyBhbmQKCgoKwqAgMi4gc2VuZCBhIEMySFRlcm1SZXEgUERVCgoKCioqKioqKgoKCgrCoAoK
CgpBbmQgaW5kZWVkIEkgc2VlIGluIHRoZSBkbWVzZyB0aGlzOgoKCgrCoAoKCgpudm1lIG52bWUy
OiB1bnN1cHBvcnRlZCBwZHUgdHlwZSAoMykKCgoKwqAKCgoKVGhpcyBtZWFucyB0aGUgY29udHJv
bGxlciBkZXRlY3RlZCB0aGUgcHJvYmxlbSBhbmQgc2VudCB0byB0aGUgaG9zdCB0aGUKCgoKQzJI
VGVybVJlcSBjb21tYW5kLiBVcG9uIHJlY2VpdmluZyB0aGlzIGNvbW1hbmQsIHRoZSBob3N0IGlz
IHN1cHBvc2VkIHRvCgoKCmNsb3NlIHRoZSBjb25uZWN0aW9uLgoKCgrCoAoKCgpOb3cgSSBnZXQg
aXQuCgoKCsKgCgoKClpoYW5nLCBkbyB5b3UgaGF2ZSBjb21taXQgYWVhY2ZjZWZhMjE4ZjRlZDEx
ZGE0NzhlOWI3OTE1YTM3ZDFhZmFmZiBpbgoKCgp5b3VyIGtlcm5lbCwgSSBndWVzcyB5b3UgYXJl
IG1pc3NpbmcgaXQuIENoZWNrIGl0IHBsZWFzZS4KCgoKwqAKCgoKTWF1cml6aW8KCgoKwqAKCgoK
wqAKCgoKwqAKCgo=



