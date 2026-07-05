Received: from va-2-54.ptr.blmpb.com (va-2-54.ptr.blmpb.com [209.127.231.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083BA382380
	for <linux-block@vger.kernel.org>; Sun,  5 Jul 2026 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783266981; cv=none; b=YhbDQgjjr8xmfi+g9tFArzrz+ZzwWfXkcndTDgorTX1wuZNqUgVt5jZ8kneBDaGTr2USlMOKB2nFrO3Na4fxdDQmBSV0dMAc6Bahb3lIsuS+kUW+jfLHMbjaX+v5TzdLvAcyyQ0ZtIJxLwiLK8zI/9lJbfsTfmjJ3Tl0yTF3/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783266981; c=relaxed/simple;
	bh=j/wcPS8f7rqMiknLCq0LHaBmKpRTCklDKW2ebTK7iJw=;
	h=To:Message-Id:In-Reply-To:From:References:Mime-Version:Subject:
	 Date:Content-Type:Cc; b=njh+ZXLXd+T/1smupT8TUaTCAu91jeDhcetiw3UK3qEK2RZpZA7/SfKgM5X8ZUmtXREdHwYKZG55pEgTrZXNqALXGZ+MMwC2diQDLa90FggTaAn59fhv0h764Y5mK316Yz5RZFDiB1UilWzWUBVyrbBqhKz0J03GkjA3Jcj8l+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=eMAXjv7i; arc=none smtp.client-ip=209.127.231.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="eMAXjv7i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1783266972;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=cytcHvExyWJLLYT7BP4F1smnTra0QyeLSWqMsXI7UM8=;
 b=eMAXjv7iEpnDCKaOUbF9d5sxdzNscUy1r+gTryGqH8XymTCOlj6p6cIZva3UF/5rg0FyVc
 mf0AjvZdRGpmbNlK1CU1uKU13+D/Y53Z75JaZ9VEtpruPza8ZiD9dZUYJaGSKYvKwu5IdP
 sgQxCuzBi+EcT74BIetPjrmbT9X7uxZt7swt19S+D8LbCUkybgXtGB6gnxrIwo2V2tJtJj
 Yg/nZ3o0b2D80a0kBpSPDBpQy9HXNRX2z4W30jFNMpNp0iCFHH45XGUXH+ggkC1vCDVX6L
 CYK8etpmYz+exSJDaNZWtFJ6ARhUrnDgu7w5MGVjClGLygCNuBWbXaScso9Umw==
To: "Zizhi Wo" <wozizhi@huaweicloud.com>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>
X-Lms-Return-Path: <lba+26a4a7e9c+440373+vger.kernel.org+yukuai@fygo.io>
Reply-To: yukuai@fygo.io
Message-Id: <7ad5ca8a-0943-42b0-b75d-c661e7f7faab@fygo.io>
User-Agent: Mozilla Thunderbird
In-Reply-To: <20260704073942.3760597-1-wozizhi@huaweicloud.com>
From: "yu kuai" <yukuai@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
Content-Transfer-Encoding: quoted-printable
Received: from [192.168.1.104] ([39.182.0.144]) by smtp.larksuite.com with ESMTPS; Sun, 05 Jul 2026 15:56:11 +0000
References: <20260704073942.3760597-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] block: fix BLKSECDISCARD zero-length range causing page cache invalidation
Date: Sun, 5 Jul 2026 23:56:07 +0800
Content-Type: text/plain; charset=UTF-8
Cc: <linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>, 
	<chengzhihao1@huawei.com>, <wozizhi@huawei.com>, <yukuai@fygo.io>

=E5=9C=A8 2026/7/4 15:39, Zizhi Wo =E5=86=99=E9=81=93:

> From: Zizhi Wo<wozizhi@huawei.com>
>
> Commit 697ba0b6ec4a ("block: fix integer overflow in BLKSECDISCARD") fixe=
d
> the start+len overflow via check_add_overflow() but did not handle the
> start=3D0, len=3D0 case. There, start + len =3D 0, so end =3D 0 passes al=
l checks,
> and truncate_bdev_range()->truncate_inode_pages_range() is then called wi=
th
> lend=3DUINT64_MAX, whitch is the "truncate to the end of file" sentinel, =
so
> the entire page cache is invalidated.
>
> Fix this by replacing the validation with blk_validate_byte_range(), whic=
h
> already rejects a zero-length range and is what BLKDISCARD uses. This als=
o
> switches the alignment check from a hardcoded 512 to
> bdev_logical_block_size().
>
> Signed-off-by: Zizhi Wo<wozizhi@huawei.com>
> ---
>   block/ioctl.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)

Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thanks,
Kuai
