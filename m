Received: from va-2-39.ptr.blmpb.com (va-2-39.ptr.blmpb.com [209.127.231.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F83B8D7D
	for <linux-block@vger.kernel.org>; Sun, 14 Dec 2025 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765706194; cv=none; b=GqhY76UVxBNb7SyCkVJBq9AUy2F8XlqQRlMYtNib4oBU/ARXxMq9mFoO5ZDy30xZx88WqD6sIsHpGErHnEVa/NL/QNrJ1kX9dphSjQ0mEVzAN8bK9A+eb+LEZ4vjj0ri/BNZnhk1G546b8dKRy986KRhz7R+IpiVIopQADL1brg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765706194; c=relaxed/simple;
	bh=C1/rDVGwABrCPcgbZgvCqAKfxSR8McVRppRCltcF0lw=;
	h=To:Subject:Message-Id:Content-Type:Date:From:References:
	 Mime-Version:In-Reply-To; b=bYpOqah+q67cFd3c/AXjgnkzuLnGj2aDWd4milzGB0JT4lL42dk7Vb8vIh8sVClazP8spDCKoP3mHpokkqkYLL27yL1nCOBkSrj7crpAkHdtIOiC9p1CuqOpf8mNcxNRfS7ay9nGxJ2kTHA36xRy9VxwAr44jfOPJkCc8Vf8wnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=2aRWqnWs; arc=none smtp.client-ip=209.127.231.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="2aRWqnWs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1765706142;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=C1/rDVGwABrCPcgbZgvCqAKfxSR8McVRppRCltcF0lw=;
 b=2aRWqnWsYuWEGKn0zy6fTiuK86Z5qE7ttrqp+6zoqid310lDjoD5RHD7hBN+gFmKV+ZSip
 8eLmwiVvwLcPLBtjScIp1r8o6zBDCyil/sM4wRXoKwULqaLsU/+mGms+QnsoVI2TzvPj+M
 ggHiVdbgTetieL/PTK585cnYHuCXrclpg9u0SHCKnQw00PUkXG8CiNRqf5su72OV9UcfP9
 jRNtwUaw/WL3U3L2ZzWTXTmBiIcN60WFWXGW0Cna8wqkWiaJDmfVQ6Ep5rIxywxCoFeE2u
 BfJNi/5Qybs0D7KwM0p/mgk7HIs8mHUt2XNSudHyMY1FvD/PzhVYdIm6LDXGIw==
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+2693e899d+72908d+vger.kernel.org+yukuai@fnnas.com>
To: "Nilay Shroff" <nilay@linux.ibm.com>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>, <tj@kernel.org>, <ming.lei@redhat.com>, 
	<bvanassche@acm.org>, <yukuai@fnnas.com>
Subject: Re: [PATCH v4 08/12] blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue
Message-Id: <51649b8c-79ad-46a2-ba76-4efda21e4ba4@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Dec 2025 17:55:35 +0800
Content-Language: en-US
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@fnnas.com
From: "Yu Kuai" <yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.136]) by smtp.feishu.cn with ESMTPS; Sun, 14 Dec 2025 17:55:40 +0800
References: <20251201083415.2407888-1-yukuai@fnnas.com> <20251201083415.2407888-9-yukuai@fnnas.com> <3c088265-f6d8-4a91-b6a0-972d45afa056@linux.ibm.com> <88a61575-9750-4b9a-9186-3df7bf1bd208@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <88a61575-9750-4b9a-9186-3df7bf1bd208@fnnas.com>

Hi,

=E5=9C=A8 2025/12/8 11:19, Yu Kuai =E5=86=99=E9=81=93:
>> Moving ->freeze_lock out of rq_qos_add() and moving it here before
>> calling wbt_init() makes sense, however this change now causes
>> the below lockdep splat while running blktests throtl/001. Looking
>> at the below splat, it seems blk_throtl_init() should run under
>> GFP_NOIO scope.
> Looks correct, thanks for the test! I'll fix this in the next version.

BTW, I'll just convert to use GFP_NOIO in the next version, and in the new
set to convert blkcg spin lock to mutex, I'll make queue frozen for all blk=
cg
configuration path.

Thanks,
Kuai
