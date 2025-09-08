Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A3C214A64;
	Mon,  8 Sep 2025 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325575; cv=none; b=m9N6it0t1rZ6DeMyesUUXSWi+SmeGxZ5L28zBE0MdPGP9ddjiNYRF6HxDaLULZDI3RMj97A9Lr4EUhAXrJuwo8qtSr2b3sfQ7tYoEKT8JcXC0p2iJGgVgiCF4P1QQXY5Jzjomk+yL3udGFKP6vMYBDACGZX1PuMLY8yydfLyL88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325575; c=relaxed/simple;
	bh=RQ5nnNREJlpXGOY6Wb1YQ35hR0TcbY0REiVLtNzBlCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Xi5RPWPe8n03od7TRUD71VjfMYuixTn9zgEmtM3JPGMhZP6fHec8UVzV1PiR/v3x0LiWwjeXN4QfuK+nIrjiioKvoV14/eycIYV8EQR2tKFlHd0RUrnCrMPRhJagM9hm9MbWg1GbulvhiizDPlVtJ/fqwPpXQ2glecwULR9vR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=O12XNp3B; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="O12XNp3B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=RQ5nnNREJlpXGOY6Wb1YQ35hR0TcbY0REiVLtNzBlCU=; b=O
	12XNp3BvR1+mNvbSOq1pP0+luRQdQeugXkGI1Ue6W8yWrxy9oASxiQMTUa/SK161
	Zb8/ef0jE4LU0bmh8QnQJkfR7h1cuYbAdsqB4x+5BAl84BpOb9h0eNBLomtuUzIp
	7WCx1ZztM9uQ2sOrQTaJK5UPFU+PGnmliP6ukjU4xw=
Received: from zhanggenjian$126.com ( [116.128.244.171] ) by
 ajax-webmail-wmsvr-41-112 (Coremail) ; Mon, 8 Sep 2025 17:58:24 +0800 (CST)
Date: Mon, 8 Sep 2025 17:58:24 +0800 (CST)
From: "genjian zhang" <zhanggenjian@126.com>
To: axboe@kernel.dk, dlemoal@kernel.org, shinichiro.kawasaki@wdc.com,
	johannes.thumshirn@wdc.com, kch@nvidia.com, zhengqixing@huawei.com,
	willy@infradead.org, namcao@linutronix.de, vincent.fu@samsung.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Genjian Zhang" <zhanggenjian@kylinos.cn>, zhanggenjian@126.com
Subject: Re:[PATCH v2] null_blk: Fix the description of the cache_size
 module argument
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 126com
In-Reply-To: <20250815090732.1813343-1-zhanggenjian@126.com>
References: <20250815090732.1813343-1-zhanggenjian@126.com>
X-NTES-SC: AL_Qu2eBf+Zuk0r4imRZOkfmUgQhec8W8ewvfsh2IFXOJl8jArj6z8BV0F9AnL21P+lBT+yrimFdhxE5vt1XLt8Q6EpKFmVUHC8mEblRKSlztO0Rg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2baa9d5f.86c7.19928c331e3.Coremail.zhanggenjian@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cCkvCgD3VyTCqL5oRZopAA--.20777W
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiHh-Cfmi+mUOgxwACsU
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNS0wOC0xNSAxNzowNzozMiwgIkdlbmppYW4iIDx6aGFuZ2dlbmppYW5AMTI2LmNvbT4g
d3JvdGU6Cj5Gcm9tOiBHZW5qaWFuIFpoYW5nIDx6aGFuZ2dlbmppYW5Aa3lsaW5vcy5jbj4KPgo+
V2hlbiBleGVjdXRpbmcgbW9kaW5mbyBudWxsX2JsaywgdGhlcmUgaXMgYW4gZXJyb3IgaW4gdGhl
IGRlc2NyaXB0aW9uCj5vZiBtb2R1bGUgcGFyYW1ldGVyIG1icHMsIGFuZCB0aGUgb3V0cHV0IGlu
Zm9ybWF0aW9uIG9mIGNhY2hlX3NpemUgaXMKPmluY29tcGxldGUuVGhlIG91dHB1dCBvZiBtb2Rp
bmZvIGJlZm9yZSBhbmQgYWZ0ZXIgYXBwbHlpbmcgdGhpcyBwYXRjaAo+aXMgYXMgZm9sbG93czoK
Pgo+QmVmb3JlOgo+Wy4uLl0KPnBhcm06ICAgICAgICAgICBjYWNoZV9zaXplOnVsb25nCj5bLi4u
XQo+cGFybTogICAgICAgICAgIG1icHM6Q2FjaGUgc2l6ZSBpbiBNaUIgZm9yIG1lbW9yeS1iYWNr
ZWQgZGV2aWNlLgo+CQlEZWZhdWx0OiAwIChub25lKSAodWludCkKPlsuLi5dCj4KPkFmdGVyOgo+
Wy4uLl0KPnBhcm06ICAgICAgICAgICBjYWNoZV9zaXplOkNhY2hlIHNpemUgaW4gTWlCIGZvciBt
ZW1vcnktYmFja2VkIGRldmljZS4KPgkJRGVmYXVsdDogMCAobm9uZSkgKHVsb25nKQo+Wy4uLl0K
PnBhcm06ICAgICAgICAgICBtYnBzOkxpbWl0IG1heGltdW0gYmFuZHdpZHRoIChpbiBNaUIvcyku
Cj4JCURlZmF1bHQ6IDAgKG5vIGxpbWl0KSAodWludCkKPlsuLi5dCj4KPkZpeGVzOiAwNThlZmUw
MDBiMzEgKCJudWxsX2JsazogYWRkIG1vZHVsZSBwYXJhbWV0ZXJzIGZvciA0IG9wdGlvbnMiKQo+
U2lnbmVkLW9mZi1ieTogR2VuamlhbiBaaGFuZyA8emhhbmdnZW5qaWFuQGt5bGlub3MuY24+Cj5S
ZXZpZXdlZC1ieTogRGFtaWVuIExlIE1vYWwgPGRsZW1vYWxAa2VybmVsLm9yZz4KPi0tLQo+IGRy
aXZlcnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jIHwgMiArLQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay9u
dWxsX2Jsay9tYWluLmMgYi9kcml2ZXJzL2Jsb2NrL251bGxfYmxrL21haW4uYwo+aW5kZXggOTE2
NDJjOWEzYjI5Li5mOTgyMDI3ZThjODUgMTAwNjQ0Cj4tLS0gYS9kcml2ZXJzL2Jsb2NrL251bGxf
YmxrL21haW4uYwo+KysrIGIvZHJpdmVycy9ibG9jay9udWxsX2Jsay9tYWluLmMKPkBAIC0yMjMs
NyArMjIzLDcgQEAgTU9EVUxFX1BBUk1fREVTQyhkaXNjYXJkLCAiU3VwcG9ydCBkaXNjYXJkIG9w
ZXJhdGlvbnMgKHJlcXVpcmVzIG1lbW9yeS1iYWNrZWQgbnUKPiAKPiBzdGF0aWMgdW5zaWduZWQg
bG9uZyBnX2NhY2hlX3NpemU7Cj4gbW9kdWxlX3BhcmFtX25hbWVkKGNhY2hlX3NpemUsIGdfY2Fj
aGVfc2l6ZSwgdWxvbmcsIDA0NDQpOwo+LU1PRFVMRV9QQVJNX0RFU0MobWJwcywgIkNhY2hlIHNp
emUgaW4gTWlCIGZvciBtZW1vcnktYmFja2VkIGRldmljZS4gRGVmYXVsdDogMCAobm9uZSkiKTsK
PitNT0RVTEVfUEFSTV9ERVNDKGNhY2hlX3NpemUsICJDYWNoZSBzaXplIGluIE1pQiBmb3IgbWVt
b3J5LWJhY2tlZCBkZXZpY2UuIERlZmF1bHQ6IDAgKG5vbmUpIik7Cj4gCj4gc3RhdGljIGJvb2wg
Z19mdWEgPSB0cnVlOwo+IG1vZHVsZV9wYXJhbV9uYW1lZChmdWEsIGdfZnVhLCBib29sLCAwNDQ0
KTsKPi0tIAo+Mi4yNS4xCgpDaGFuZ2VzIGluIHYyOgogLSBBZGp1c3RlZCB0aGUgcGF0Y2ggdGl0
bGUuCiAtIFJlbW92ZWQgcmVkdW5kYW50IGJsYW5rIGxpbmVzLgogLSBMaW5rIHRvIHYxOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMzA0NDVjNmEuNjkyMC4xOThhY2VmOGYyNC5Db3JlbWFp
bC56aGFuZ2dlbmppYW5AMTI2LmNvbS8KCkdlbnRsZSBwaW5nLgoKVGhhbmtzCi1HZW5qaWFuCgo=

