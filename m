Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03686267F59;
	Tue, 19 Aug 2025 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603803; cv=none; b=HPEcohL/PYUBHwKI+Dcqx086rIvLYEqNup8OVC1v9HUT5MVADl+BsCJo32mHLmrinyrHLFQfbfrCZDf7sigIQH7KsTHnrg4eukF7qtNv1DLau7X+LTHbcYIy+HmpuWvLbGs47i+EZPjWKtxEAhuIDM6iIB/hrbuboDuqaV4fWT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603803; c=relaxed/simple;
	bh=JiaX+chiYZeepIBBGjvMW+7ODLMHhs8b6gcQLfgqphc=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=YgIScCiysrqa7+iaKso1au+BUTijpzh8GeSYkqj8UBm16rZXxCFbgOwrjH7maFU8CvC15ufVmMHR913hj5us3/SR3wU7OpbIoe9W/FMsx039cdtDiDq+ptx7Gb5yLh0ENDLX/2hPudz9gz7wnGQXmTHhiJ5Z3nNLkRTa4WcF3E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=whu.edu.cn; spf=pass smtp.mailfrom=whu.edu.cn; dkim=fail (0-bit key) header.d=whu.edu.cn header.i=@whu.edu.cn header.b=kpH/i8+U reason="key not found in DNS"; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=whu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=whu.edu.cn header.i=@whu.edu.cn header.b="kpH/i8+U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=whu.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID;
	bh=Fbxx8rZphRZwJMtsXDignq/U2qpn/MwMmrlwN1c0DPo=; b=kpH/i8+UrfUMB
	ZzxvyMD7QajhfAFMU3xAt5yNEizgFB9rGqNh4aIr+pSb37CLrVGGKJBnfrF5/tIF
	LJnyiSwoi95AeciG/33J7jRNqWMh5l+14Xpnz2fRxd+wJ2OKlW6xInpNmbevvokM
	C9Wva0h0zi5JIomui0RSYGQQJ/zWdw=
Received: from 2023302111378$whu.edu.cn ( [111.48.77.137] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 19 Aug 2025 19:43:06 +0800 (GMT+08:00)
Date: Tue, 19 Aug 2025 19:43:06 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?54mb5rW356iL?= <2023302111378@whu.edu.cn>
To: minchan@kernel.org
Cc: ngupta@vflare.org, sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH/RFC] Zram: Improved Compression with PID/VMA-aware Grouping
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT6 build
 20240807(4bc564b9) Copyright (c) 2002-2025 www.mailtech.cn whu
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1709a150.2340.198c223db7a.Coremail.2023302111378@whu.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:Bw4BCgAHYbVLY6RoeOYWAA--.4981W
X-CM-SenderInfo: ysqsjjyqsriiqtxyq4lkxovvfxof0/1tbiAQcTBWijTF4oAgAAsj
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

RGVhciBMaW51eCBLZXJuZWwgWnJhbSBNYWludGFpbmVycywKCkkgYW0gYW4gb3Blbi1zb3VyY2Ug
ZGV2ZWxvcGVyIGFuZCBoYXZlIGJlZW4gd29ya2luZyBvbiBzb21lIHBvdGVudGlhbCBpbXByb3Zl
bWVudHMgdG8gdGhlIFpyYW0gbW9kdWxlLCBmb2N1c2luZyBvbiBvcHRpbWl6aW5nIGNvbXByZXNz
aW9uIHJhdGVzLk15IHdvcmsgaXMgYmFzZWQgb24gdGhlIExpbnV4IGtlcm5lbCB2ZXJzaW9uIDUu
MTAuMjQwLgoKTXkgcmVjZW50IHdvcmsgaW50cm9kdWNlcyB0aGUgZm9sbG93aW5nIGNoYW5nZXM6
CgoxLlBJRCBhbmQgVmlydHVhbCBBZGRyZXNzIFRyYWNraW5nOiBEdXJpbmcgcGFnZSBzd2FwLWlu
IG9wZXJhdGlvbnMgYXQgdGhlIHN3YXAgbGF5ZXIsIEkndmUgaW1wbGVtZW50ZWQgYSBtZWNoYW5p
c20gdG8gcmVjb3JkIHRoZSBQcm9jZXNzIElEIChQSUQpIGFuZCB0aGUgY29ycmVzcG9uZGluZyB2
aXJ0dWFsIGFkZHJlc3Mgb2YgdGhlIHBhZ2UuCjIuUElELWF3YXJlIEdyb3VwaW5nIGFuZCBWTUEg
TWVyZ2luZyBpbiBacmFtOiBXaXRoaW4gdGhlIFpyYW0gbGF5ZXIsIHBhZ2VzIGFyZSBub3cgZ3Jv
dXBlZCBiYXNlZCBvbiB0aGVpciByZWNvcmRlZCBQSURzLiBGb2xsb3dpbmcgdGhpcyBncm91cGlu
ZywgcGFnZXMgd2l0aCBzaW1pbGFyIG9yIGNvbnRpZ3VvdXMgdmlydHVhbCBhZGRyZXNzZXMgd2l0
aGluIGVhY2ggUElEIGdyb3VwIGFyZSBtZXJnZWQgYmVmb3JlIGNvbXByZXNzaW9uLiBUaGUgcmF0
aW9uYWxlIGJlaGluZCB0aGlzIGlzIHRoYXQgcGFnZXMgYmVsb25naW5nIHRvIHRoZSBzYW1lIHBy
b2Nlc3MgYW5kIGxvY2F0ZWQgYWRqYWNlbnRseSBpbiB2aXJ0dWFsIG1lbW9yeSBhcmUgbGlrZWx5
IHRvIGNvbnRhaW4gcmVsYXRlZCBkYXRhLCB3aGljaCBjb3VsZCBsZWFkIHRvIGJldHRlciBjb21w
cmVzc2lvbiByYXRpb3Mgd2hlbiBwcm9jZXNzZWQgdG9nZXRoZXIuCgpQcmVsaW1pbmFyeSBleHBl
cmltZW50cyB1c2luZyB0aGlzIGFwcHJvYWNoIGhhdmUgc2hvd24gcHJvbWlzaW5nIHJlc3VsdHM6
CgpXaXRoIHRoZSBMWjQgY29tcHJlc3Npb24gYWxnb3JpdGhtLCB3ZSBvYnNlcnZlZCBhbiBhcHBy
b3hpbWF0ZSAzJSBpbmNyZWFzZSBpbiB0aGUgb3ZlcmFsbCBjb21wcmVzc2lvbiByYXRlLgpXaXRo
IHRoZSBaU1REIGNvbXByZXNzaW9uIGFsZ29yaXRobSwgdGhlIGltcHJvdmVtZW50IHdhcyBldmVu
IG1vcmUgc2lnbmlmaWNhbnQsIHJlYWNoaW5nIGFuIGFwcHJveGltYXRlIDQlIGluY3JlYXNlIGlu
IHRoZSBvdmVyYWxsIGNvbXByZXNzaW9uIHJhdGUuCgpJIGFtIHdyaXRpbmcgdG8gaW5xdWlyZSBp
ZiB5b3UgYmVsaWV2ZSB0aGlzIGFwcHJvYWNoIGFuZCBpdHMgb2JzZXJ2ZWQgYmVuZWZpdHMgYXJl
IHNpZ25pZmljYW50IGVub3VnaCB0byB3YXJyYW50IGZ1cnRoZXIgY29uc2lkZXJhdGlvbiBmb3Ig
dXBzdHJlYW1pbmcgaW50byB0aGUgbWFpbiBMaW51eCBrZXJuZWwuIEkgd291bGQgZ3JlYXRseSBh
cHByZWNpYXRlIHlvdXIgdGhvdWdodHMgb24gdGhlIHV0aWxpdHkgYW5kIHBvdGVudGlhbCBpbXBs
aWNhdGlvbnMgb2YgdGhlc2UgY2hhbmdlcywgYXMgd2VsbCBhcyBhbnkgZ3VpZGFuY2Ugb24gaG93
IHRvIHByb2NlZWQgd2l0aCBmdXJ0aGVyIGRldmVsb3BtZW50IG9yIGZvcm1hbCBzdWJtaXNzaW9u
LgoKVGhhbmsgeW91IGZvciB5b3VyIHRpbWUgYW5kIGNvbnNpZGVyYXRpb24uCkJlc3QgcmVnYXJk
cywKSGFpY2hlbmcgTml1
