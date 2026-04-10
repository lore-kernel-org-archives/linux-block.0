Received: from mail-m1973173.qiye.163.com (mail-m1973173.qiye.163.com [220.197.31.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA7F4A3E;
	Fri, 10 Apr 2026 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836321; cv=none; b=gtt8vmWIuEy2Wk9OOFj9X+AOWvXGHz2mxAayGigDqJIFDOzXFvWKKqto4+kJdla15Unb16eixeHZCR/40XyLwhoo1kfmoTG4bqSguXVYEDLFJEMvGnotFF4sYfqsTadx6yUBgiJBOAFSTU8mAcrUL0ylRLQxZSK/iDRvTivqhRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836321; c=relaxed/simple;
	bh=DaSOOne3MZ6RXz5zv8K5Y50bmoWVSFyXSN3ib7MuYSc=;
	h=Content-Type:Message-ID:To:Cc:Subject:MIME-Version:From:Date; b=L6ZTbwM6+GPGhgb37XuEoZ57bhqZ7MpnLoPW4nY26jKnrX0ah9TRor52TVguE+kmkFXtZp0c9KTQje1hsMwSsFRnz0RaOziTQ850sJBBSRC4gHHPeKz+SckdstrbODkmTTYJaZrVFe62Iji3dlsUcUJKpglzIV0VzXKtlPjEtmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=co5cHlJr; arc=none smtp.client-ip=220.197.31.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="co5cHlJr"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ANIA6QDpKJDgGvi6bWi53Krz.1.1775836309095.Hmail.2023000929@ruc.edu.cn>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: axboe@kernel.dk, ojeda@kernel.org, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, bjorn3_gh@protonmail.com, 
	aliceryhl@google.com, lossin@kernel.org, boqun@kernel.org, 
	dakr@kernel.org, gary@garyguo.net, sunke@kylinos.cn, 
	tmgross@umich.edu, linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtSRkMgUEFUQ0ggMC8yXSBydXN0IGJsb2NrLW1xIFRhZ1NldCBmbGFncyBwbHVtYmluZyBhbmQgcm51bGwgYmxvY2tpbmcgd2lyaW5n?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 2023000929@ruc.edu.cn( [18.182.34.76] ) by ajax-webmail ( [127.0.0.1] ) ; Fri, 10 Apr 2026 23:51:49 +0800 (GMT+08:00)
From: wenzhaoliao <wenzhaoliao@ruc.edu.cn>
Date: Fri, 10 Apr 2026 23:51:49 +0800 (GMT+08:00)
X-HM-Tid: 0a9d78173f9c09bdkunm0c220953dc9c
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMf2U5gprSpllrVBCJYClE3duRf49djg1aYGfsM
	uZDiMwtzOTgseqkTCl3w8jN398Giy5ocFzHtsEG3i/9zKX/w+B4dupYrmbpLz4+h6H8iRUtrMUW8
	kE5tJbiPSQpaUu4EuWxVBaR/AKTYFMShDXN+Q=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTE1PVkxLQxgZHR5DQ0lKQlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKQ1VKQ0lVSE9VTE1ZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0pVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=co5cHlJr+5F7F/iDz5o3Zmo+ZMRcK6XMyxUEkrtQ0j6K1Q0olubQB/4QACe+abFJQZ0ZYUMJJe+7xXCtXlbZ187L61iOMFGAL/MUJ6ciCTU/rBsxuUle5IdVuHlrx3Or70sE5zOjNKNMl6fLQs4rpmYj+0RdEphjW2k6+sGHcAc=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=DaSOOne3MZ6RXz5zv8K5Y50bmoWVSFyXSN3ib7MuYSc=;
	h=date:mime-version:subject:message-id:from;

CgoKSGkgQW5kcmVhcywKCgpUaGFua3MgZm9yIHBvaW50aW5nIG1lIHRvIHRoYXQgcGF0Y2ggc2Vy
aWVzISBJIHdpbGwgZGVmaW5pdGVseSB0YWtlIGEgY2xvc2VyIGxvb2sgYW5kIGhlbHAgdGVzdC9y
ZXZpZXcgdGhlIHBhdGNoZXMgb3ZlciB0aGVyZSB0byBzdXBwb3J0IGdldHRpbmcgdGhpcyBmdW5j
dGlvbmFsaXR5IG1lcmdlZC4KCgpKdXN0IHRvIG1ha2Ugc3VyZSB3ZSBkb24ndCBkdXBsaWNhdGUg
YW55IG90aGVyIG9uZ29pbmcgd29yaywgZG9lcyB0aGF0IHNlcmllcyAob3IgYW55IG9mIHlvdXIg
cGVuZGluZyBicmFuY2hlcykgYWxyZWFkeSBjb3ZlciB0aGUgYmxrX21xX29wcy0+dGltZW91dCBi
bG9jayBkZXZpY2UgY2FsbGJhY2sgYW5kIHRoZSBlbnVtIGJsa19laF90aW1lcl9yZXR1cm4gYWJz
dHJhY3Rpb24/IElmIG5vdCwgd2UgdGhvdWdodCB0aGF0IG1pZ2h0IGJlIGEgZ29vZCBuZXh0IGNh
bmRpZGF0ZSB0byB0YWNrbGUuCgoKT24gYSBicm9hZGVyIG5vdGUsIENvdWxkIHlvdSByZWNvbW1l
bmQgYW55IHNwZWNpZmljIG1pc3NpbmcgYWJzdHJhY3Rpb25z4oCUZWl0aGVyIGluIHRoZSBibG9j
ayBzdWJzeXN0ZW0sIGNvbmZpZ2ZzLCBvciBlbHNld2hlcmXigJR0aGF0IHRoZSBSRkwgcHJvamVj
dCBjdXJyZW50bHkgbmVlZHM/IEFsdGVybmF0aXZlbHksIGlzIHRoZXJlIGEgc3BlY2lmaWMgVE9E
TyBsaXN0IG9yIHRyYWNraW5nIHJlcG9zaXRvcnkgeW91IHdvdWxkIHJlY29tbWVuZCB1cyB0byBs
b29rIGF0IHNvIHdlIGNhbiBwaWNrIHVwIHRoZSByaWdodCB0YXNrcyB3aXRob3V0IHN0ZXBwaW5n
IG9uIGFueW9uZSdzIHRvZXM/CgoKVGhhbmtzIGFnYWluIGZvciB5b3VyIHRpbWUgYW5kIGd1aWRh
bmNlIQoKCkJlc3QgcmVnYXJkcywKV2VuemhhbyBMaWFv
