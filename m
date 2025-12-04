Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B791D9A54
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764864772; cv=none; b=MYShaZv4ajGW4CN+bQieYYQIoPX4kvqjgYfvJCwxqqEqu5RLpCmNlS4InULP10Erw5+xNLWmUd1y5JCOpKUlb1KDaX+dZ5A7zq0pgRoXmetGQ7YY714gYY/MS5vv//fWCOoBOCq8uGtoturNPI3zM0uE9YvJHn8jOuhNXkHd8zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764864772; c=relaxed/simple;
	bh=p/B5sgTdpUjigi2MfddrxQ5vVl4ZVZW2cdtiRMXCUGA=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To; b=VCyhJTtTGHvGHPS3Gfv0fv/72bUrpEKyksLTpwcM8wMKNmgSYz9WtiEhf85dm1s7gEzF+XFtxdOM+rj639hmpQsa2fX5O11r897FmPAlCqAwB+x2eurZlMvkqITvhGpyR7dFPgoiaf8J0my1Fda0ihNBtGx8F316//IXN5b7rPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGEvq6jz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGEvq6jz"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297dd95ffe4so10290905ad.3
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 08:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764864771; x=1765469571; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/B5sgTdpUjigi2MfddrxQ5vVl4ZVZW2cdtiRMXCUGA=;
        b=RGEvq6jz7CIeRN6qTSQa4ikzu4l2497jXqPVt8+bmRoLUmXfQin+E6w8I68BLzaOgX
         lM7VZ31alXWmRaF7zzJXnLg4TZ+S8DnMvAaOYdenE2NQNa6VsC0EryenVt53rAKPpNBJ
         2SAZZ1jNQ1mS1QGccOpR+1xPVTHUABrQ7DrhIa00rcKOcebip+Vb7uuCbVzHhiQZV1Uu
         OJ2eyemEcWBbgPJfknn+ehCrY8+87oCPTk/iPG68iAV2z2OG2nRq+vvrhtJBEp8CvCIf
         S6O6vAXc4fV+isyFfdD0aPGjIlZlqKI4HsvWWlBHwyz2dVX9eRrW4zmVx4jsdreNHj0b
         M3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764864771; x=1765469571;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/B5sgTdpUjigi2MfddrxQ5vVl4ZVZW2cdtiRMXCUGA=;
        b=DNZxSWJ85CtMdsnqKRnTsj/ebW4JS0EaKOOkEjHsIFzJ/C4R3LwlrtYkkTSTkj3aGr
         egCyKsiNsUyn4SXwFUICsjKLYz2twX3pZZsVs7gIYK/CQRiSQDYStWkMedH2U4Z5wl3J
         3ryjpA1CW34wk/Wi2490GyOSnsrW++FrnkdkUvUlGe63m4LjcZ66URolCiVRDuEYGm/6
         iLdXVHelLYeVBRkVd57eTE65fJAr9dAfsQKfeY+Qc6d53XQdVw67Jcud3I55ADQ0Zu3y
         05ZBmZXh+0zWD1/fdHg2O8GwIBquVdpppzW3JA1IjzyU4Jkg2ZHRBb3cmYwfTY5s+SKF
         mZxA==
X-Gm-Message-State: AOJu0Yy/AotpzZRKAXwQqOkJRIFciMJIuoFou71U0UlyGkZN7r0E2CSV
	pu33UPBccS7HcRyXVXn31MDtQ6uPleH8PKI8KSU/WxjdRK3jBGLN9ZHY
X-Gm-Gg: ASbGncu8yfT2VPwLnOZM3a7kkawuccMJ2quA8OIk8TM1yBP0+ZeSqGjXCVTwa6wCGww
	SeHDXPrlf0TyVXTJyzPG46fM9Zz9EhpdRcBMH8WPCYQc/KNGmrIDA1TAbhVsyFhb+8EtK6eMdGJ
	0nIRpt1HtQOzipxFSRAQkiJTQCTN/qnmj61quTi7C4QFv2/OFppSvu6Jchx0O1Dd2aqpR3CTCX1
	BC+RMZkTRwoziQ4AoxjsVa9E9HObL1BQNDEFBzrX2Glwx/sJlQSZNt/lVwvuq+gb3Vjs+rLWlGr
	L8i6q04HikvKMAJPmHcVl5cjJrNK9bVlqonJiCTcbSBRgaMSzUBQBxc0I6JMa6VV8oJG0l6WWZ8
	uYFXEdGl8I4vggHv7X8J5iOjyusYRTKlTvCyO5aKONk2NNWDETPJvSa8DaAXx1/AiV206h8VDM9
	YrvzA2jI6yY93UqAwTq9v0gIGXujzl1IG3agWdu8qqmPX5mbEEhL2xq0Yz
X-Google-Smtp-Source: AGHT+IEA6SOl6f/zesLElmAilIagnuW1Ox8X4XKe18bTG8d8KUEK34Lv+Xoivj7qGCPXo4R/ugerTw==
X-Received: by 2002:a17:902:f709:b0:298:efa:511f with SMTP id d9443c01a7336-29da1c88714mr42676335ad.39.1764864770549;
        Thu, 04 Dec 2025 08:12:50 -0800 (PST)
Received: from ?IPV6:2409:40c0:2d:d7a1:16aa:7b10:7b07:e18f? ([2409:40c0:2d:d7a1:16aa:7b10:7b07:e18f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cf996sm24426545ad.30.2025.12.04.08.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 08:12:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------crM85GH1eE00dp0YcxMkF7na"
Message-ID: <23fde58b-ef8f-4420-b0a8-5ae87dfe0bc4@gmail.com>
Date: Thu, 4 Dec 2025 21:42:38 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+527a7e48a3d3d315d862@syzkaller.appspotmail.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6931abe7.a70a0220.2ea503.00e0.GAE@google.com>
Subject: Re: [syzbot] [block?] [udf?] memory leak in __blkdev_issue_zero_pages
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <6931abe7.a70a0220.2ea503.00e0.GAE@google.com>

This is a multi-part message in MIME format.
--------------crM85GH1eE00dp0YcxMkF7na
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


--------------crM85GH1eE00dp0YcxMkF7na
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-block-fix-memory-leak-in-__blkdev_issue_zero_pages.patch"
Content-Disposition: attachment;
 filename*0="0001-block-fix-memory-leak-in-__blkdev_issue_zero_pages.patc";
 filename*1="h"
Content-Transfer-Encoding: base64

RnJvbSA3OWZlMDA1ZDA4ZjRmODFmNDIyYTM3MWZkN2Q0ZDNjZDI1ODBhNjVmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaGF1cnlhIFJhbmUgPHNzcmFuZV9iMjNAZWUudmp0
aS5hYy5pbj4KRGF0ZTogVGh1LCA0IERlYyAyMDI1IDIxOjM4OjUxICswNTMwClN1YmplY3Q6
IFtQQVRDSF0gYmxvY2s6IGZpeCBtZW1vcnkgbGVhayBpbiBfX2Jsa2Rldl9pc3N1ZV96ZXJv
X3BhZ2VzCgpNb3ZlIHRoZSBmYXRhbCBzaWduYWwgY2hlY2sgYmVmb3JlIGJpb19hbGxvYygp
IHRvIHByZXZlbnQgYSBtZW1vcnkKbGVhayB3aGVuIEJMS0RFVl9aRVJPX0tJTExBQkxFIGlz
IHNldCBhbmQgYSBmYXRhbCBzaWduYWwgaXMgcGVuZGluZy4KClByZXZpb3VzbHksIHRoZSBi
aW8gd2FzIGFsbG9jYXRlZCBiZWZvcmUgY2hlY2tpbmcgZm9yIGEgZmF0YWwgc2lnbmFsLgpJ
ZiBhIHNpZ25hbCB3YXMgcGVuZGluZywgdGhlIGNvZGUgd291bGQgYnJlYWsgb3V0IG9mIHRo
ZSBsb29wIHdpdGhvdXQKZnJlZWluZyBvciBjaGFpbmluZyB0aGUganVzdC1hbGxvY2F0ZWQg
YmlvLCBjYXVzaW5nIGEgbWVtb3J5IGxlYWsuCgpUaGlzIG1hdGNoZXMgdGhlIHBhdHRlcm4g
YWxyZWFkeSB1c2VkIGluIF9fYmxrZGV2X2lzc3VlX3dyaXRlX3plcm9lcygpCndoZXJlIHRo
ZSBzaWduYWwgY2hlY2sgcHJlY2VkZXMgdGhlIGFsbG9jYXRpb24uCgpTaWduZWQtb2ZmLWJ5
OiBTaGF1cnlhIFJhbmUgPHNzcmFuZV9iMjNAZWUudmp0aS5hYy5pbj4KLS0tCiBibG9jay9i
bGstbGliLmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ibG9jay9ibGstbGliLmMgYi9ibG9jay9i
bGstbGliLmMKaW5kZXggMzAzMGE3NzJkM2FhLi4zNTJlM2MwZjhhN2QgMTAwNjQ0Ci0tLSBh
L2Jsb2NrL2Jsay1saWIuYworKysgYi9ibG9jay9ibGstbGliLmMKQEAgLTIwMiwxMyArMjAy
LDEzIEBAIHN0YXRpYyB2b2lkIF9fYmxrZGV2X2lzc3VlX3plcm9fcGFnZXMoc3RydWN0IGJs
b2NrX2RldmljZSAqYmRldiwKIAkJdW5zaWduZWQgaW50IG5yX3ZlY3MgPSBfX2Jsa2Rldl9z
ZWN0b3JzX3RvX2Jpb19wYWdlcyhucl9zZWN0cyk7CiAJCXN0cnVjdCBiaW8gKmJpbzsKIAot
CQliaW8gPSBiaW9fYWxsb2MoYmRldiwgbnJfdmVjcywgUkVRX09QX1dSSVRFLCBnZnBfbWFz
ayk7Ci0JCWJpby0+YmlfaXRlci5iaV9zZWN0b3IgPSBzZWN0b3I7Ci0KIAkJaWYgKChmbGFn
cyAmIEJMS0RFVl9aRVJPX0tJTExBQkxFKSAmJgogCQkgICAgZmF0YWxfc2lnbmFsX3BlbmRp
bmcoY3VycmVudCkpCiAJCQlicmVhazsKIAorCQliaW8gPSBiaW9fYWxsb2MoYmRldiwgbnJf
dmVjcywgUkVRX09QX1dSSVRFLCBnZnBfbWFzayk7CisJCWJpby0+YmlfaXRlci5iaV9zZWN0
b3IgPSBzZWN0b3I7CisKIAkJZG8gewogCQkJdW5zaWduZWQgaW50IGxlbjsKIAotLSAKMi4z
NC4xCgo=

--------------crM85GH1eE00dp0YcxMkF7na--
