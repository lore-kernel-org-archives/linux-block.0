Received: from smtp.cecloud.com (unknown [1.203.97.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC013179BD;
	Thu, 13 Mar 2025 01:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741830552; cv=none; b=WN5541CDc08x1HYYFCsDZjOUArGXeuIT4VMH237QPSjiptD5X4XhhpiMYaIclucJMR+J3SP4qBT01gsAaXclwFIg5mgny1/7A9IE6rytIvfPNOSaGezB1G9YwWQAZHDF6ZRiAHXAnignoKYWJbJsR2JZKAU2yMe3A6rI8LVw0dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741830552; c=relaxed/simple;
	bh=6sY/7FdgPMrB92rg3PJECrh/+gGW3ra+PU0Lugn9eMY=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=U8YyuwpqftStmyP0QVw9ZjdFLqc+5c2BBt9KP1bkMgAMbiYLD39jRP8OW7XbbZv+IU3JIb2ongJk2KC7cV7Ag5tdhMcUqqWbUT394JdqMf9nuzH1USe6E1/hI2r7R4hwUi2iYF5fyD4FFT+UzzxWA5qEUqWaUx+GXYJuXDyNFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 85B3C900113;
	Thu, 13 Mar 2025 09:48:59 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ABS-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from desktop-n31qu50 (unknown [39.156.73.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P3907749T281458922156400S1741830538431531_;
	Thu, 13 Mar 2025 09:48:58 +0800 (CST)
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
X-UNIQUE-TAG:<04ac8a49813e1ceebe4a332c09420545>
X-System-Flag:0
Date: Thu, 13 Mar 2025 09:48:57 +0800
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
Subject: =?UTF-8?B?UmU6IFJlOiBudm1lLXRjcDogZml4IGEgcG9zc2libGUgVUFGIHdoZW4gZmFpbGluZyB0byBzZW5kIHJlcXVlc3TjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFzYWdpZ3JpbUBnbWFpbC5jb23ku6Plj5HjgJE=?=
References: <2025021015413817916143@cestc.cn>, 
	<aed9dde7-3271-4b97-9632-8380d37505d9@grimberg.me>, 
	<202503071810452687957@cestc.cn>, 
	<D8DDP6LIPOKB.2ACTHLE9FPI2A@bsdbackstore.eu>
X-Priority: 3
X-GUID: FF449562-DD47-4AB7-B4CD-D0CF3D8BDFE0
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.331[cn]
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <2025031309485746586710@cestc.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

WWVzLCB0aGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQsICBkZXNwaXRlIHRoZSBudm1lX3RjcF90cnlf
c2VuZCgpIGZhaWx1cmUsIHRoZSB0YXJnZXQgc2VuZHMgYSByZXNwb25zZSBjYXBzdWxlIGZvciB0
aGUgY29tbWFuZCwgbGVhZGluZyB0byBhIFVBRiBpbiB0aGUgaG9zdC4gCgpJcyBpdCBtb3JlIHJl
YXNvbmFibGUgdG8gZGlzYWJsZSBxdWV1ZS0+cmRfZW5hYmxlZCB0byBwcmV2ZW50IHJlY2Vpdmlu
Zy4gVGhhbmtzIAogCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBiL2RyaXZl
cnMvbnZtZS9ob3N0L3RjcC5jCmluZGV4IGJlMDRjNWYzODU2ZC4uMTc0MDdlYjEyYWQ5IDEwMDY0
NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC90
Y3AuYwpAQCAtMTIwMyw4ICsxMjAzLDkgQEAgc3RhdGljIGludCBudm1lX3RjcF90cnlfc2VuZChz
dHJ1Y3QgbnZtZV90Y3BfcXVldWUgKnF1ZXVlKQogICAgICAgIH0gZWxzZSBpZiAocmV0IDwgMCkg
ewogICAgICAgICAgICAgICAgZGV2X2VycihxdWV1ZS0+Y3RybC0+Y3RybC5kZXZpY2UsCiAgICAg
ICAgICAgICAgICAgICAgICAgICJmYWlsZWQgdG8gc2VuZCByZXF1ZXN0ICVkXG4iLCByZXQpOwot
ICAgICAgICAgICAgICAgbnZtZV90Y3BfZmFpbF9yZXF1ZXN0KHF1ZXVlLT5yZXF1ZXN0KTsKICAg
ICAgICAgICAgICAgIG52bWVfdGNwX2RvbmVfc2VuZF9yZXEocXVldWUpOworICAgICAgICAgICAg
ICBxdWV1ZS0+cmRfZW5hYmxlZCA9IGZhbHNlOworICAgICAgICAgICAgICBudm1lX3RjcF9lcnJv
cl9yZWNvdmVyeSgmcXVldWUtPmN0cmwtPmN0cmwpOwogICAgICAgIH0KIG91dDoKICAgICAgICBt
ZW1hbGxvY19ub3JlY2xhaW1fcmVzdG9yZShub3JlY2xhaW1fZmxhZyk7CgoKCgp6aGFuZy5ndWFu
Z2h1aUBjZXN0Yy5jbgoKCgrlj5Hku7bkurrvvJrCoE1hdXJpemlvIExvbWJhcmRpCgoKCuWPkemA
geaXtumXtO+8msKgMjAyNS0wMy0xMcKgMTg6NTIKCgoK5pS25Lu25Lq677yawqB6aGFuZy5ndWFu
Z2h1aUBjZXN0Yy5jbjsgc2FnaTsgbWd1cnRvdm95OyBrYnVzY2g7IHNhc2hhbDsgY2h1bmd1YW5n
Lnh1CgoKCuaKhOmAge+8msKgbGludXgta2VybmVsOyBsaW51eC1udm1lOyBsaW51eC1ibG9jawoK
CgrkuLvpopjvvJrCoFJlOiBudm1lLXRjcDogZml4IGEgcG9zc2libGUgVUFGIHdoZW4gZmFpbGlu
ZyB0byBzZW5kIHJlcXVlc3TjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFzYWdpZ3JpbUBnbWFpbC5j
b23ku6Plj5HjgJEKCgoKT24gRnJpIE1hciA3LCAyMDI1IGF0IDExOjEwIEFNIENFVCwgemhhbmcu
Z3VhbmdodWlAY2VzdGMuY24gd3JvdGU6CgoKCj4KCgoKPiBIaQoKCgo+CgoKCj7CoMKgwqDCoMKg
wqDCoMKgIEFmdGVyIHRlc3RpbmcgdGhpcyBwYXRjaCzCoMKgIHNlbmRpbmcgcmVxdWVzdCBmYWls
dXJlIG9jY3VycmVkLMKgwqAgdW5mb3J0dW5hdGVseSwgdGhlIGlzc3VlIHN0aWxsIHBlcnNpc3Rz
LgoKCgrCoAoKCgpNYXliZSBJIGFtIGNvbXBsZXRlbHkgd3JvbmcgYnV0IEkgYW0gc3RpbGwgcXVp
dGUgY29udmluY2VkIHRoYXQgdGhlIHByb2JsZW0gaGVyZQoKCgppcyB0aGF0LCBkZXNwaXRlIHRo
ZSBudm1lX3RjcF90cnlfc2VuZCgpIGZhaWx1cmUsIHRoZSB0YXJnZXQgc2VuZHMgYSByZXNwb25z
ZSBjYXBzdWxlCgoKCmZvciB0aGUgY29tbWFuZCwgbGVhZGluZyB0byBhIGRvdWJsZS1jb21wbGV0
aW9uIGluIHRoZSBob3N0LgoKCgrCoAoKCgpTYWdpLCB3aGF0IGFib3V0IHRha2luZyB0aGlzIHBh
dGNoOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1udm1lLzIwMjUwMzA2MTYwMzIyLjEz
NzAzMDAtMi1tbG9tYmFyZEByZWRoYXQuY29tL1QvI3UKCgoKYW5kIGRvIGEgc3RlcCBmdXJ0aGVy
IGJ5IG5vdCBjb21wbGV0aW5nIHRoZSByZXF1ZXN0LCBsZWF2aW5nIHRoZSBlcnJvcgoKCgpyZWNv
dmVyeSBoYW5kbGVyIHRoZSB0YXNrIG9mIGNsZWFuaW5nIGV2ZXJ5dGhpbmcgdXA/CgoKCsKgCgoK
CsKgCgoKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L3RjcC5jCgoKCmluZGV4IDMyN2YzZjJmNTM5OS4uNzJjMWQ3OTQ4Mzg2IDEwMDY0NAoK
CgotLS0gYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYwoKCgorKysgYi9kcml2ZXJzL252bWUvaG9z
dC90Y3AuYwoKCgpAQCAtMTMyOCw4ICsxMzI4LDggQEAgc3RhdGljIGludCBudm1lX3RjcF90cnlf
c2VuZChzdHJ1Y3QgbnZtZV90Y3BfcXVldWUgKnF1ZXVlKQoKCgp9IGVsc2UgaWYgKHJldCA8IDAp
IHsKCgoKZGV2X2VycihxdWV1ZS0+Y3RybC0+Y3RybC5kZXZpY2UsCgoKCiJmYWlsZWQgdG8gc2Vu
ZCByZXF1ZXN0ICVkXG4iLCByZXQpOwoKCgotIG52bWVfdGNwX2ZhaWxfcmVxdWVzdChxdWV1ZS0+
cmVxdWVzdCk7CgoKCm52bWVfdGNwX2RvbmVfc2VuZF9yZXEocXVldWUpOwoKCgorIG52bWVfdGNw
X2Vycm9yX3JlY292ZXJ5KCZxdWV1ZS0+Y3RybC0+Y3RybCk7CgoKCn0KCgoKb3V0OgoKCgptZW1h
bGxvY19ub3JlY2xhaW1fcmVzdG9yZShub3JlY2xhaW1fZmxhZyk7CgoKCsKgCgoKCsKgCgoKCk1h
dXJpemlvCgoKCsKgCgoKCsKgCgoK



