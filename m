Received: from smtp.cecloud.com (unknown [1.203.97.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72AC1EF090;
	Wed, 12 Feb 2025 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353681; cv=none; b=KVVfPeYYUNhMYnDbh8M6+ii4nqrG1LKEDX5jI1E6E7hqiLIesfls9LJlcelyON4W9+qZyPc4Ky4Wgeq/zjuc6ODnfdrifPha/qIYix1LJxF+ov1Ho9CEXmYLoALQJPVSClF8P3wuDgDhbgK1RD+VCoGu6OJ0iYQzA60L49DPOlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353681; c=relaxed/simple;
	bh=xUQ30rhV40fcUwQmaBnExzYBwck0x6MjVWsXHWK2G7Y=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=CdOL2aPO3sio87N0Ja4qMODlrpBY8erdi0/4TVe1qcBf3rvnDtgMC7Q61Kuxp+NWrOQ7oYdrA4erl56azSDITkkW8IRl3z/yP6+yATj+DDdxk12vJxyJBlEIxy0ez1pHVnsTqHpPpivNtPlxLCvsmx5GC+9oE0bFpcjo5/s4RHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id B8A1490011B;
	Wed, 12 Feb 2025 17:47:47 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ABS-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from desktop-n31qu50 (unknown [39.156.73.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P3907749T281458761199984S1739353666453316_;
	Wed, 12 Feb 2025 17:47:47 +0800 (CST)
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
X-UNIQUE-TAG:<882da0001598ff412ba171defd5e7094>
X-System-Flag:0
Date: Wed, 12 Feb 2025 17:47:45 +0800
From: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>, 
	chunguang.xu <chunguang.xu@shopee.com>
Cc: mgurtovoy <mgurtovoy@nvidia.com>, 
	sagi <sagi@grimberg.me>, 
	kbusch <kbusch@kernel.org>, 
	sashal <sashal@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-nvme <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Subject: Re: Re: nvme-tcp: fix a possible UAF when failing to send request
References: <2025021015413817916143@cestc.cn>, 
	<D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>, 
	<3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>, 
	<D7OWXONOUZ1Y.19KIRCQDVRTKN@bsdbackstore.eu>, 
	<CAAO4dAWdsMjYMp9jdWXd_48aG0mTtVpRONqjJJ1scnc773tHzg@mail.gmail.com>, 
	<202502111604342976121@cestc.cn>, 
	<D7QBDBZMZTCI.1W40WVL5JJ3O7@bsdbackstore.eu>, 
	<D7QC8AQ7J89A.32TNPSFWV1VNX@bsdbackstore.eu>
X-Priority: 3
X-GUID: 9D028B37-D67E-4AA1-BFBF-FC2EAB062C63
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.331[cn]
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <202502121747455267343@cestc.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

wqDCoMKgwqBIaSwgVGhhbmtzLgrCoMKgwqDCoEkgd2lsbCB0ZXN0IHRoaXMgcGF0Y2gsIGJ1dCBJ
IGFtIHdvcnJpZWQgd2hldGhlciBpdCB3aWxsIGFmZmVjdCB0aGUgcGVyZm9ybWFuY2UuClNob3Vs
ZCB3ZSBhbHNvIGNvbnNpZGVyIG51bGwgcG9pbnRlciBwcm90ZWN0aW9uPwoKCnpoYW5nLmd1YW5n
aHVpQGNlc3RjLmNuCgoKCkZyb206wqBNYXVyaXppbyBMb21iYXJkaQoKCgpEYXRlOsKgMjAyNS0w
Mi0xMsKgMTY6NTIKCgoKVG86wqBNYXVyaXppbyBMb21iYXJkaTsgemhhbmcuZ3VhbmdodWlAY2Vz
dGMuY247IGNodW5ndWFuZy54dQoKCgpDQzrCoG1ndXJ0b3ZveTsgc2FnaTsga2J1c2NoOyBzYXNo
YWw7IGxpbnV4LWtlcm5lbDsgbGludXgtbnZtZTsgbGludXgtYmxvY2sKCgoKU3ViamVjdDrCoFJl
OiBudm1lLXRjcDogZml4IGEgcG9zc2libGUgVUFGIHdoZW4gZmFpbGluZyB0byBzZW5kIHJlcXVl
c3QKCgoKT24gV2VkIEZlYiAxMiwgMjAyNSBhdCA5OjExIEFNIENFVCwgTWF1cml6aW8gTG9tYmFy
ZGkgd3JvdGU6CgoKCj4gT24gVHVlIEZlYiAxMSwgMjAyNSBhdCA5OjA0IEFNIENFVCwgemhhbmcu
Z3VhbmdodWlAY2VzdGMuY24gd3JvdGU6CgoKCj4+IEhpwqAKCgoKPj4KCgoKPj4gwqAgwqAgVGhp
cyBpcyBhwqAgcmFjZSBpc3N1ZSzCoMKgSSBjYW4ndCByZXByb2R1Y2UgaXQgc3RhYmx5IHlldC4g
SSBoYXZlIG5vdCB0ZXN0ZWQgdGhlIGxhdGVzdCBrZXJuZWwuwqAgYnV0IGluIGZhY3QswqDCoEkn
dmUgc3luY2VkIHNvbWUgbnZtZS10Y3AgcGF0Y2hlcyBmcm9twqAgbGFzdGVzdCB1cHN0cmVhbSwK
CgoKPgoKCgo+IEhlbGxvLCBjb3VsZCB5b3UgdHJ5IHRoaXMgcGF0Y2g/CgoKCj4KCgoKPiBxdWV1
ZV9sb2NrIHNob3VsZCBwcm90ZWN0IGFnYWluc3QgY29uY3VycmVudCAiZXJyb3IgcmVjb3Zlcnki
LAoKCgo+ICsgbXV0ZXhfbG9jaygmcXVldWUtPnF1ZXVlX2xvY2spOwoKCgrCoAoKCgpVbmZvcnR1
bmF0ZWx5IEkndmUganVzdCByZWFsaXplZCB0aGF0IHF1ZXVlX2xvY2sgd29uJ3Qgc2F2ZSB1cwoK
Cgpmcm9tIHRoZSByYWNlIGFnYWluc3QgdGhlIGNvbnRyb2xsZXIgcmVzZXQsIGl0J3Mgc3RpbGwg
cG9zc2libGUKCgoKd2UgbG9jayBhIGRlc3Ryb3llZCBtdXRleC4gU28ganVzdCB0cnkgdGhpcwoK
CgpzaW1wbGlmaWVkIHBhdGNoLCBJIHdpbGwgdHJ5IHRvIGZpZ3VyZSBvdXQgc29tZXRoaW5nIGVs
c2U6CgoKCsKgCgoKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBiL2RyaXZl
cnMvbnZtZS9ob3N0L3RjcC5jCgoKCmluZGV4IDg0MTIzOGYzOGZkZC4uYjcxNGUxNjkxYzMwIDEw
MDY0NAoKCgotLS0gYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYwoKCgorKysgYi9kcml2ZXJzL252
bWUvaG9zdC90Y3AuYwoKCgpAQCAtMjY2MCw3ICsyNjYwLDEwIEBAIHN0YXRpYyBpbnQgbnZtZV90
Y3BfcG9sbChzdHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0eCwgc3RydWN0IGlvX2NvbXBfYmF0Y2gg
KmlvYikKCgoKc2V0X2JpdChOVk1FX1RDUF9RX1BPTExJTkcsICZxdWV1ZS0+ZmxhZ3MpOwoKCgpp
ZiAoc2tfY2FuX2J1c3lfbG9vcChzaykgJiYgc2tiX3F1ZXVlX2VtcHR5X2xvY2tsZXNzKCZzay0+
c2tfcmVjZWl2ZV9xdWV1ZSkpCgoKCnNrX2J1c3lfbG9vcChzaywgdHJ1ZSk7CgoKCisKCgoKKyBt
dXRleF9sb2NrKCZxdWV1ZS0+c2VuZF9tdXRleCk7CgoKCm52bWVfdGNwX3RyeV9yZWN2KHF1ZXVl
KTsKCgoKKyBtdXRleF91bmxvY2soJnF1ZXVlLT5zZW5kX211dGV4KTsKCgoKY2xlYXJfYml0KE5W
TUVfVENQX1FfUE9MTElORywgJnF1ZXVlLT5mbGFncyk7CgoKCnJldHVybiBxdWV1ZS0+bnJfY3Fl
OwoKCgp9CgoKCsKgCgoKCk1hdXJpemlvCgoKCsKgCgoKCsKgCgoK



