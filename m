Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED572C0261
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 05:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782453575; cv=none; b=sdt3eF1QrB7IeezIgitGQEP9LusMWlkKaUw9ardPcT0zVghGuIxZ/DOobd2nANl4ACZsreU00uQldf9pM7lNRbL+kCymsICkF7TThpejecBQDAJQowk1FPihjE+gOpXkDZtYvHiRpeJxrfdm2RjpNgfJ2OlOV46wSyc1x53qc2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782453575; c=relaxed/simple;
	bh=21H+XhKne5mzFF89acbgvI42XhlwdfacywwU4nmj9hQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=OEXXENu7UmpyosHxK3kgxKoOGJIW3Ew3srVo7fhzvkY2f4teJftFhHPse6fezvOL/60DTvHUooiZtZh1rTZuSXv1agnnrZLvYL8Ne+zOkqMBgDdNcZza5nyLI7mBCJ8Sl8tLBh20H6KLUqRpgTcLz/PKH5uraevCMXALsIYgeMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=A1zyYTqh; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A1zyYTqh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=21H+XhKne5mzFF89acbgvI42XhlwdfacywwU4nmj9hQ=; b=A
	1zyYTqh8aJEsAEVT0QFfLH85SLGZC4f2XP7UdCe27FTvHMNpFTGIbBaejoHQWZV1
	nJCAhUFfVMnIO+CuBGuvY+11jiuzOl4bZ9i3DyjN/hZlfPzowU9obQLEh1k5DoPR
	W3vgz2Q6hZHpA6tewUc9HshmF46+8s4nOhqoBtoaFw=
Received: from dayou5941$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-130 (Coremail) ; Fri, 26 Jun 2026 13:58:57 +0800
 (CST)
Date: Fri, 26 Jun 2026 13:58:57 +0800 (CST)
From: =?GBK?B?wO7T07roIA==?= <dayou5941@163.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, liyouhong@kylinos.cn,
	"Christoph Hellwig" <hch@infradead.org>
Subject: Re:Re: [PATCH] block: use blk_validate_byte_range() for BLKZEROOUT
 and BLKSECDISCARD
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <ah033gO9mMlbCwKn@infradead.org>
References: <20260529065618.3091286-1-dayou5941@163.com>
 <ah033gO9mMlbCwKn@infradead.org>
X-NTES-SC: AL_Qu2TAPievE0o4SGZZekckk4Wjug8Wcexufwj34NTc8EFnSHVwDErWFBsOn302fq3CQCorBO9USF36Nxfc6l3dE4udD3sI2apS0DNidTLxQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6d058860.47f8.19f0282895e.Coremail.dayou5941@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gigvCgDXPzwhFT5qRFoRAA--.1338W
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+QF3Jmo+FSE4xAAA31
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCkF0IDIwMjYtMDYtMDEgMTU6NDI6MjIsICJDaHJpc3RvcGggSGVsbHdpZyIgPGhjaEBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPkxvb2tzIGdvb2Q6Cj4KCj5SZXZpZXdlZC1ieTogQ2hyaXN0
b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+CgoKCgoKCkhpLAoKCgpGcmllbmRseSBwaW5nIG9uIHRo
aXMgcGF0Y2ggYmVsb3cgoaogcGxlYXNlIGxldCBtZSBrbm93IGlmIGFueXRoaW5nCgplbHNlIGlz
IG5lZWRlZCBmcm9tIG15IHNpZGUuCgoKClRoYW5rcywKCkxpeW91aG9uZw==
