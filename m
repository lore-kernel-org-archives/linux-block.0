Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D38C35E95F
	for <linux-block@vger.kernel.org>; Thu, 21 May 2026 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356655; cv=none; b=WtI5HL/m4t7weaqpNz7+hhjFmop3/p36/jwO+JAxX/3YwpZhlQaJBmJ6RmQkz3GR73NV+c1qcwxRATVg/XudRq6djH4vboS8Ql+EvaqYexvoA685ZlO1R+XP+GVSbJRIybkRaXEgMEl4V/yAsSJcVN+0VjofYjMpNAAGd7wotd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356655; c=relaxed/simple;
	bh=9HEUyvv9OsJhJY9co8XKFJooiMT5u9qY5HI6gln70Ts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=gLBRHXaw3WJovLJWg8+p1zPu1WQQGBZ2yWaDolfLRqoZMXSlfAZoMmI9vRRRxN6VaAZMT0DHg4p2eqIGBs0nlblO+VIOImUllNya2MeM070F48HYjJbA75Wn5gflc0tiixE3OoddsGyBncmmksYZw5j9J+MKJ0PJ5VvTatCiBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ay5hS3ch; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ay5hS3ch"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=9HEUyvv9OsJhJY9co8XKFJooiMT5u9qY5HI6gln70Ts=; b=a
	y5hS3chzo7khOOxxb1OZ3txu/wru4EEiZkDSTMmKAE9DBdBp41I/WLuPGyQ22Mkj
	IGzSRfinY5lfK736Ut8vhIGqkra/17BUu3TXGRv0VbdbMZApZCXno+w+9m7b+XKR
	zdgUofzm1GwFGVal6k1893D4CqExmrLnryIaMtaGuw=
Received: from dayou5941$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-143 (Coremail) ; Thu, 21 May 2026 17:43:50 +0800
 (CST)
Date: Thu, 21 May 2026 17:43:50 +0800 (CST)
From: =?GBK?B?wO7T07roIA==?= <dayou5941@163.com>
To: yukuai@fygo.io
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, liyouhong@kylinos.cn
Subject: Re:Re: [PATCH] block, bfq: skip dispatch when selected queue has no
 next_rq
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <f0c0ed75-0858-4464-b22f-d64a6e3048cd@fygo.io>
References: <20260520095024.685338-1-dayou5941@163.com>
 <f0c0ed75-0858-4464-b22f-d64a6e3048cd@fygo.io>
X-NTES-SC: AL_Qu2cC/+euU4o5iibYekcmEsSg+02Wsq5u/si1YVec+4GuyvKwB8BcnlRBErK3uKjDiGutCWRdCdExuV8ZYJncNnS6UMCmVt4rWdUskgq4A==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3446c150.87ac.19e49eb7f3f.Coremail.dayou5941@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jygvCgDXf0jX0w5qeAOpAA--.1265W
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+hdI9moO09dV1QAA3z
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKCgoKCgoKCgpBdCAyMDI2LTA1LTIxIDE3OjI3OjI4LCAiWXUgS3VhaSIgPHl1a3Vh
aUBmbm5hcy5jb20+IHdyb3RlOgo+SGksCj4KPtTaIDIwMjYvNS8yMCAxNzo1MCwgZGF5b3U1OTQx
QDE2My5jb20g0LS1wDoKPj4gRnJvbTogbGl5b3Vob25nIDxsaXlvdWhvbmdAa3lsaW5vcy5jbj4K
Pj4KPj4gYmZxX2Rpc3BhdGNoX3JxX2Zyb21fYmZxcSgpIGRpc3BhdGNoZXMgYmZxcS0+bmV4dF9y
cSBkaXJlY3RseS4gQWRkIGEKPj4gZ3VhcmQgaW4gX19iZnFfZGlzcGF0Y2hfcmVxdWVzdCgpIHNv
IHRoYXQgZGlzcGF0Y2ggaXMgc2tpcHBlZCBpZiB0aGUKPj4gc2VsZWN0ZWQgcXVldWUgdW5leHBl
Y3RlZGx5IGhhcyBubyBuZXh0IHJlcXVlc3QuCj4+Cj4+IFRoaXMga2VlcHMgYmVoYXZpb3IgdW5j
aGFuZ2VkIGluIG5vcm1hbCBwYXRocyB3aGlsZSBhdm9pZGluZyBlbnRlcmluZwo+PiB0aGUgZGlz
cGF0Y2ggaGVscGVyIHdpdGggYSBtaXNzaW5nIG5leHRfcnEuCj4KPkNhbiB5b3UgZXhwbGFuIGlu
IHdoaWNoIGNhc2UgYmZxcSBjYW4gYmUgcmV0dXJuZWQgZnJvbSBiZnFfc2VsZWN0X3F1ZXVlCj53
aXRoIG5leHRfcnEgc2V0IHRvIE5VTEw/IEkgZGlkbid0IGZpbmQgaXQgd2l0aCBhIHF1aWNrIHJl
dmlldy4KPgo+VGFrZSBhIGxvb2sgYXQgYmZxX2Rpc3BhdGNoX3JxX2Zyb21fYmZxcSgpLCBiZnFx
LT5uZXh0X3JxIHdpbGwgYmUgZGVyZWZlcmVuY2VkCj51bmNvbmRpdGlvbmFsbHksIHdoaWNoIHNo
b3VsZCBsZWFkIHRvIGtlcm5lbCBjcmFzaCBiZWZvcmUgdGhpcyBwYXRjaCBpZgo+bmV4dF9ycSBj
YW4gYmUgTlVMTC4KCj4KClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uCgpJIGFncmVlIHRo
ZXJlIGlzIG5vIGRlbW9uc3RyYXRlZCBwYXRoIGZvciBgbmV4dF9ycSA9PSBOVUxMYCBoZXJlLCBz
byBJJ2xsIGRyb3AKdGhpcyBwYXRjaC4KCk9uZSBmb2xsb3ctdXAgcXVlc3Rpb246IGlmIGBuZXh0
X3JxYCBpcyBndWFyYW50ZWVkIG5vbi1OVUxMIGFmdGVyCmBiZnFfc2VsZWN0X3F1ZXVlKClgLCB3
b3VsZCB5b3UgY29uc2lkZXIgdGhlIGBpZiAocnEpYCBjaGVjayBhZnRlcgpgYmZxX2Rpc3BhdGNo
X3JxX2Zyb21fYmZxcSgpYCByZWR1bmRhbnQgZm9yIHRoYXQgcGF0aD8KClRoYW5rcywKbGl5b3Vo
b25nCg==
