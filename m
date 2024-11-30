Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53188468;
	Sat, 30 Nov 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732986048; cv=none; b=swYEiAAatamOo8fTn9svCvxaIt8NuwZVP1b5l9u0QtS4sdwP32WsgfmMrSUgLK8XQtv3cmZwnFXDT8RxlmlpfLCr8W0jAfwj2L70+mqqkwnuOegAHiX9loSJktFqHhIdSqhbV3pC6/EwIeRxsYg+sbH6Tf3lF+/I+RVnU+wngS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732986048; c=relaxed/simple;
	bh=Mex2PmB+lb1e6ar9mx92l20Ruaz93Dtf08qL0dt5sVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=hS4LMY3CIKF0/5AmdaQ+Smh1VAVxg2f06V7B5f09g8amgStkn5ddNUtHaTKRP35x+e19l+oZpbIVLiGk7ztmlX1pjweyXc60MH1+dBvAS0QoDLOwT/6uEcjlrmxv8BfdTQGtjcbICPCj0jbkgIUsb+MxQkE7SCpQGh2b+J6+jFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=VpsFLVa6 reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="VpsFLVa6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=na6BrjzcVfZyNtqJpP0Qfw+RMkb2Q5lrEVXf1+Vsfss=; b=V
	psFLVa6s+tEzpmw/940rrbzqECzmJbVqwLbtVTWKb/Pp+vncKwSOQ42CntLoLT24
	mDMqcsWGpqsCnWMAI1GTRZ44sfmUeVh0nBzdscleIOHvcRdNL/4oCwM8GAguDXzo
	7P4un3hpNofC16pQ4BYmsN82sbV+zNQK5sAGiUwYmo=
Received: from 00107082$163.com ( [111.35.188.140] ) by
 ajax-webmail-wmsvr-40-121 (Coremail) ; Sun, 1 Dec 2024 00:59:45 +0800 (CST)
Date: Sun, 1 Dec 2024 00:59:45 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Jens Axboe" <axboe@kernel.dk>
Cc: chris.bainbridge@gmail.com, bvanassche@acm.org, hch@lst.de, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, semen.protsenko@linaro.org
Subject: Re: [REGRESSION] ioprio performance hangs, bisected
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <09db95ba-b396-4734-9ff0-9331579c92b7@kernel.dk>
References: <CAP-bSRZehc2BxRC_z5MXKQ6qHNPXPgZoOQTtkiK_CFd494D_Fg@mail.gmail.com>
 <20241130060949.122381-1-00107082@163.com>
 <09db95ba-b396-4734-9ff0-9331579c92b7@kernel.dk>
X-NTES-SC: AL_Qu2YAPWTukEj4yGQYOkXn0oTju85XMCzuv8j3YJeN500kiTuyDE8bG5ZHEnH/PmCOyCmoQmnSDptzMZCd5BjXpPiisEkb4hIt4eeUdsJzlGJ
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3a051f26.3be2.1937e0398a5.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eSgvCgDnv_mCREtnOeszAA--.32805W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0hKnqmdLIM0JDgACsJ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMTItMDEgMDA6MDA6MjAsICJKZW5zIEF4Ym9lIiA8YXhib2VAa2VybmVsLmRrPiB3
cm90ZToKPk9uIDExLzI5LzI0IDExOjA5IFBNLCBEYXZpZCBXYW5nIHdyb3RlOgo+PiBXb3VsZCBm
aXgvcmV2ZXJ0IHJlYWNoIDYuMTMtcmMxPyBJIHRoaW5rIHRoaXMgcmVncmVzc2lvbiBoYXMKPj4g
c2lnbmlmaWNhbnQgbmFnYXRpdmUgaW1wYWN0IG9uIGRhaWx5IHVzYWdlLiBGcm9tIHRpbWUgdG8g
dGltZSwKPj4gbXkgc3lzdGVtIHdvdWxkICpzdHVjayogZm9yIHNlY29uZHMsIHNvbWV0aW1lcyBl
dmVuIHdoZW4KPj4gIGp1c3QgYGNhdGAgc29tZSBzbWFsbCBmaWxlIGl0IHdvdWxkIHRha2Ugc2Vj
b25kcywgYW5kIG9uY2UsCj4+IG15IGRlc2t0b3AgZmFpbGVkIHRvIHJlc3VtZSBmcm9tIGEgc3Vz
cGVuZCwgSSBoYWQgdG8gcG93ZXIgY3ljbGUgdGhlIHN5c3RlbTsKPj4gUG9sbGluZyAvcHJvYy9k
aXNrc3RhdHMsICBJIG5vdGljZWQgQmxvY2stSU8gcmVhZCBsYXRlbmN5LAo+PiBkZWx0YSgjIG9m
IG1pbGxpc2Vjb25kcyBzcGVudCByZWFkaW5nKS9kZWx0YSgjIG9mIHJlYWRzIGNvbXBsZXRlZCks
Cj4+IGlzIHZlcnkgaGlnaCwgfjIwMG1zIGF2ZXJhZ2UsIGFuZCBmcmVxdWVudGx5IHJlYWNoZXMg
MTBzLgo+PiAgKFN0cmFuZ2VseSBibG9jay1pbyB3cml0ZSBsYXRlbmN5IHNlZW1zIG5vcm1hbC4p
Cj4+IE15IGJpc2VjdCBhbHNvIGxhbmQgb24gdGhpcyBjb21taXQsIHJldmVydCBvciBhcHBseSB0
aGlzIHBhdGNoIHdvdWxkCj4+IGZpeCBpdC4KPj4gCj4+IEtpbmQgb2YgdGhpbmsgdGhhdCA2LjEz
LXJjMSB3b3VsZCBiZSB2ZXJ5IHVucGxlc2VhbnQgdG8gdXNlIHdpdGhvdXQKPj4gYSBmaXgvcmV2
ZXJ0IGZvciB0aGlzLgo+Cj5UaGUgcHVsbCBpbmNsdWRpbmcgdGhpcyBmaXggaGFzIGJlZW4gc2Vu
dCBvZmYgdG8gTGludXMgeWVzdGVyZGF5LAo+aXQgc2hvdWxkIG1ha2UgLXJjMS4KPgo+LS0gCj5K
ZW5zIEF4Ym9lCgpHb29kIHRvIGtub3d+CgpUaGFua3MKRGF2aWQ=
