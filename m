Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F2C21B9F7
	for <linux-block@vger.kernel.org>; Mon, 17 Mar 2025 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201597; cv=none; b=j3PMNOnunIcKSa1skXGMsakeB2mAyzFpKluv/Ml7eXAUFzxDiLjViVtnDswNsJNbz+LgzFO6FxFQoKscpbfHxOt2NFGAVPWAtydibk8PPhZKTEMtojEUoqpChMsB1rrfwpd9ZxEK92rmFm5Z/c5fZt1HcBztpR9sTDWOyFIOltI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201597; c=relaxed/simple;
	bh=tFJw00okqHKKsGfJxHoPxrMJkP0QQnMaYDTrmvxXoHI=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=ZBJj27jgJaVwyu+dVPx/QVQk7WN9C89KK1DeY4f7QWB/Jt8JK8166fHhsNZnH8vWjjDufSgKfig/MS3avB+vDCGccCsO0QExeteci5ZckbXtIi31xp0E81WZz+HcZwuD0a3LLDKozObZl/KBexPTXj6YGoFO9uhlDdCVz1WuhUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=wRLYGqOm; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="wRLYGqOm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1742201542;
	bh=tFJw00okqHKKsGfJxHoPxrMJkP0QQnMaYDTrmvxXoHI=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=wRLYGqOmCHSWIwS6mp5c+CiRA7eXJmVcJErBCVp3AeDitKSu63sXMk4tptUYO8+4s
	 eUnCF+05qmnUdgAay1a4MEAb5XMf55jIqtg9w/ab1PTu2SfsH8vWbjKSkt+l//BZbx
	 RIX63PbCT/k7YTVQ3gPfoE0fv0JVMFxlyq+qLDcQ=
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqSkbJnBC3Go5WhTJdwF7gCdiqErWB6iJVM=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: mEqWNvuR5DulHQvGmFhrQCe3sua6KE+mZ9oIG+AgXLEgrqdJvMN33KbNONuNIdIMSg6RL6b85VH9cy1Z4Qn07w==
X-QQ-STYLE: 
X-QQ-mid: v3sz3a-5t1742201537t7233606
From: "=?utf-8?B?6IOh54Sc?=" <huk23@m.fudan.edu.cn>
To: "=?utf-8?B?TWluZyBMZWk=?=" <ming.lei@redhat.com>, "=?utf-8?B?bGludXgtYmxvY2s=?=" <linux-block@vger.kernel.org>
Cc: "=?utf-8?B?TWluZyBMZWk=?=" <ming.lei@redhat.com>, "=?utf-8?B?Q2hyaXN0b3BoIEhlbGx3aWc=?=" <hch@infradead.org>, "=?utf-8?B?6KaD5L2z5Z+6?=" <jjtan24@m.fudan.edu.cn>
Subject: Re:[PATCH] loop: move vfs_fsync() out of loop_update_dio()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 17 Mar 2025 16:52:16 +0800
X-Priority: 3
Message-ID: <tencent_569A521D2FECE6C55D795124@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20250113120644.811886-1-ming.lei@redhat.com>
In-Reply-To: <20250113120644.811886-1-ming.lei@redhat.com>
X-QQ-ReplyHash: 4242201015
X-BIZMAIL-ID: 15391694218121939298
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Mon, 17 Mar 2025 16:52:18 +0800 (CST)
Feedback-ID: v:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: M0vknKB9I1DpjNAFawBYqEH1NTd+k+kw3Xe+K9SbDujdZl45rQJPEone
	SkThQ4qyMB7UT0U2CGrAKKMt1ldYiF3oj/59xNdMKlqH2sDgDMah0T79910p6rlLj4Q963p
	Jneo3JsPhnMbEoRFbEY5IOXXqOpWCF9Gl85gNOwtwaxyRxjuvcnqTlC6eBtjoOzR5NX9SLi
	4nB4t80l9LwVabWlCMV6HbSfjJunIFcVmhiJs+u8YLES1u+N9LT89lZFCBCWftwdVAZ2K2F
	uHF1GZQkK4FMJlc0mds9oPOGJZinOVTV3JNZs8xdGKDprTe1hRT4gaKd/xfZ9BQgi/uj633
	d6hj3egb7xEfQJfviS2aKL1SlPEGQhOchAMlRc6+S41Wtaa6lH5V//cOmhZdB9mkoqnakgw
	GTf6uXQO19tJHI7U5aa1rP9TcnR2rFCKgDRA+AExfgE2oxTImr9iZtkeICPoe/X/IjtWSyP
	OdhgflIKSKR+Y+6VKYJW3IEQFiOWP/85vRCURQxBaB47rN03MIPHRfKUyDq/oa7ophk8vL5
	Xgvifw0gfdUucUTXBML7Jz9I244/CWwJJC7zNNIM0PpSZ+n6nScXxR40IFT+COjsmEHsSWA
	mJXqoijlWhff6bg4igoUCTuZParJKtJ4k16UTY7VqFfbiqkF532IqR2GYd/z2AkXuy5+ETR
	iML/0g2oLTsOMsD7I++/s/yNcm1xTHylXArmoZ4xm3DiCJnIZC3MzOR0SYrqrtwvwl47KHm
	Lc7uaTN7JTeOn37N83qMbX30qZm4sIJ81YydeRvB/czlYdS2POSIF0q94crOvRy5RYgHUnY
	15I1hdoj4QNiOqx9KAlprAVbt9AOQ71qM3KJB4HcPKIhI0T2ongrEUKyqcUR/4Sb29fO4uy
	S1PIbKrMBnsUunErdKtT5g+oWzOrejOaIpyrxKMCjQICTwin03t5Yh+3Fu4OhrJDsnsRRaA
	oyg2h2UlQXZqTw2wUOJh8QOcZ1Nqy1wKpj+k=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

PiBkcml2ZXJzL2Jsb2NrL2xvb3AuYyB8IDEyICsrKysrKy0tLS0tLQ0KPiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2Jsb2NrL2xvb3AuYyBiL2RyaXZlcnMvYmxvY2svbG9vcC5jDQo+IGluZGV4
IDFlYzc0MTdjN2YwMC4uYmU3ZTIwMDY0NDI3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Js
b2NrL2xvb3AuYw0KPiArKysgYi9kcml2ZXJzL2Jsb2NrL2xvb3AuYw0KPiBAQCAtMjA1LDgg
KzIwNSw2IEBAIHN0YXRpYyBib29sIGxvX2Nhbl91c2VfZGlvKHN0cnVjdCBsb29wX2Rldmlj
ZSAqbG8pDQo+ICovDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgbG9vcF91cGRhdGVfZGlvKHN0
cnVjdCBsb29wX2RldmljZSAqbG8pDQo+ICB7DQo+IC0gYm9vbCBkaW9faW5fdXNlID0gbG8t
PmxvX2ZsYWdzICYgTE9fRkxBR1NfRElSRUNUX0lPOw0KPiAtDQo+ICAgbG9ja2RlcF9hc3Nl
cnRfaGVsZCgmbG8tPmxvX211dGV4KTsNCj4gICBXQVJOX09OX09OQ0UobG8tPmxvX3N0YXRl
ID09IExvX2JvdW5kICYmDQo+ICAgICAgICBsby0+bG9fcXVldWUtPm1xX2ZyZWV6ZV9kZXB0
aCA9PSAwKTsNCj4gQEAgLTIxNSwxMCArMjEzLDYgQEAgc3RhdGljIGlubGluZSB2b2lkIGxv
b3BfdXBkYXRlX2RpbyhzdHJ1Y3QgbG9vcF9kZXZpY2UgKmxvKQ0KPiAgIGxvLT5sb19mbGFn
cyB8PSBMT19GTEFHU19ESVJFQ1RfSU87DQo+ICAgaWYgKChsby0+bG9fZmxhZ3MgJiBMT19G
TEFHU19ESVJFQ1RfSU8pICYmICFsb19jYW5fdXNlX2RpbyhsbykpDQo+ICAgbG8tPmxvX2Zs
YWdzICY9IH5MT19GTEFHU19ESVJFQ1RfSU87DQo+IC0NCj4gLSAvKiBmbHVzaCBkaXJ0eSBw
YWdlcyBiZWZvcmUgc3RhcnRpbmcgdG8gaXNzdWUgZGlyZWN0IEkvTyAqLw0KPiAtIGlmICgo
bG8tPmxvX2ZsYWdzICYgTE9fRkxBR1NfRElSRUNUX0lPKSAmJiAhZGlvX2luX3VzZSkNCj4g
LSB2ZnNfZnN5bmMobG8tPmxvX2JhY2tpbmdfZmlsZSwgMCk7DQo+ICB9DQo+ICANCj4gIC8q
Kg0KPiBAQCAtNjIxLDYgKzYxNSw5IEBAIHN0YXRpYyBpbnQgbG9vcF9jaGFuZ2VfZmQoc3Ry
dWN0IGxvb3BfZGV2aWNlICpsbywgc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwNCj4gICBp
ZiAoZ2V0X2xvb3Bfc2l6ZShsbywgZmlsZSkgIT0gZ2V0X2xvb3Bfc2l6ZShsbywgb2xkX2Zp
bGUpKQ0KPiAgZ290byBvdXRfZXJyOw0KIA0KPiArIC8qIG1heSB3b3JrIGluIGRpbywgc28g
Zmx1c2ggcGFnZSBjYWNoZSBmb3IgYXZvaWRpbmcgcmFjZSAqLw0KPiArIHZmc19mc3luYyhm
aWxlLCAwKTsNCj4gKw0KPiAgIC8qIGFuZCAuLi4gc3dpdGNoICovDQo+ICAgZGlza19mb3Jj
ZV9tZWRpYV9jaGFuZ2UobG8tPmxvX2Rpc2spOw0KPiAgIGJsa19tcV9mcmVlemVfcXVldWUo
bG8tPmxvX3F1ZXVlKTsNCj4gQEAgLTEwOTgsNiArMTA5NSw5IEBAIHN0YXRpYyBpbnQgbG9v
cF9jb25maWd1cmUoc3RydWN0IGxvb3BfZGV2aWNlICpsbywgYmxrX21vZGVfdCBtb2RlLA0K
PiAgIGlmIChlcnJvcikNCj4gICBnb3RvIG91dF91bmxvY2s7DQogDQo+ICsgLyogbWF5IHdv
cmsgaW4gZGlvLCBzbyBmbHVzaCBwYWdlIGNhY2hlIGZvciBhdm9pZGluZyByYWNlICovDQo+
ICsgdmZzX2ZzeW5jKGZpbGUsIDApOw0KPiArDQo+ICAgbG9vcF91cGRhdGVfZGlvKGxvKTsN
Cj4gICBsb29wX3N5c2ZzX2luaXQobG8pOw0KPiAgDQo+IC0tDQo+IDIuNDQuMA0KDQoNCkhl
bGxvIE1pbmcsDQoNCkkgd291bGQgbGlrZSB0byBkb3VibGUgY2hlY2sgdGhhdCB0aGlzIGZp
eCBkb2Vzbid0IHNlZW0gdG8gaGF2ZSBiZWVuIG1lcmdlZCBpbnRvIHRoZSBtYWluIHRocmVh
ZCwgd2lsbCB0aGlzIHZlcnNpb24gc3RpbGwgYmUgbWVyZ2VkIGludG8gbWFpbmxpbmUga2Vy
bmVsIHRyZWU/DQoNClRoYW5rcywNCkt1bg==

