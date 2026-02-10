Received: from sg-1-14.ptr.blmpb.com (sg-1-14.ptr.blmpb.com [118.26.132.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF08932B9AD
	for <linux-block@vger.kernel.org>; Tue, 10 Feb 2026 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770706792; cv=none; b=nESQ/+B/lxitEoXa8wJ7MtcADFYiJt4cFfNQ7sz3P266gF66UvNCbbyD0UnK8yV2gtjkwoxIWg6LWqjcytZxq0PuDqEEZzxgJ8gO6mtuzGhNJB76EEWJdKkk1KW580xvwpqcGB/Du1Q35xeXqneOWY9De0GMiUTjRwbWvziMHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770706792; c=relaxed/simple;
	bh=EjD+pRaHTolG3P0dFiBqPrhrRtG+Zz+PQwJlGziWUZ8=;
	h=Content-Type:To:From:Message-Id:Mime-Version:References:
	 In-Reply-To:Subject:Cc:Date; b=DHP/EgrCT4Dv/y8SkT26zCHLL4IB4etSaCQgmeOMaR+QPrBNAXHD4gH5G5l0oz8ta8E9nPBbquft5XYrJGl+NTapN48BE3obYKPQcDGsXfFVMN/yz2C4vVh/jbm62sGf2OrF0jUS1JcOZPH+x4yGKSHwJvlog13tBFUj5uF+q+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=ozVs0UXO; arc=none smtp.client-ip=118.26.132.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="ozVs0UXO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1770706777;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=EjD+pRaHTolG3P0dFiBqPrhrRtG+Zz+PQwJlGziWUZ8=;
 b=ozVs0UXOFBlEeE2cBk9Rw2e5fJAokY5WmKHFGqvTR2oGGrenp8IRHeek84EpSLAjuSJl7i
 FwZneB+jhpJQvl+5seJnAL8je83y2+pbb36AkWFYEZXkhAcv7lDwOZ8ypoorrlka6h8nlK
 d6NBY7lRD7KNlLplpzXTQC+H4TSGhk4nkWG48y6mpREx6RDHTbMPWAKgWsN/f9Lyt6SbQ0
 GKWtA3YUgPfTcPVp2pQ3XgmWt/zfRQtwfbYgVisYCmDFo/0/arFz0cD6lyyPdeJ3cTA7IL
 9EOCBzmL/KkLN0b5N6LZC328TcPIgQdngzM68hFiN4kl6zeHLp+JA1m99JNdzw==
Content-Type: text/plain; charset=UTF-8
To: "Bart Van Assche" <bvanassche@acm.org>, 
	"Keith Busch" <kbusch@kernel.org>
From: "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <a8cdbf1c-eaab-4ab2-be7c-df8fd0317df4@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.137]) by smtp.feishu.cn with ESMTPS; Tue, 10 Feb 2026 14:59:34 +0800
References: <20260209082953.3053721-1-yukuai@fnnas.com> <20260209082953.3053721-5-yukuai@fnnas.com> <6b18e0bc-efa7-4bd5-b12b-a313941d2ba1@acm.org> <aYoaWwI-sl5hK6s_@kbusch-mbp> <b2069052-ac7d-46f6-bdd5-a96533144f9c@acm.org>
In-Reply-To: <b2069052-ac7d-46f6-bdd5-a96533144f9c@acm.org>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+2698ad757+b97ba6+vger.kernel.org+yukuai@fnnas.com>
Subject: Re: [PATCH 4/4] blk-mq: use blk_queue_enter/exit to protect debugfs file creation
Content-Language: en-US
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Reply-To: yukuai@fnnas.com
Cc: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>, <sven@kernel.org>, 
	<j@jannau.net>, <linux-block@vger.kernel.org>, 
	<linux-nvme@lists.infradead.org>, <tj@kernel.org>, <nilay@linux.ibm.com>, 
	<ming.lei@redhat.com>, <neal@gompa.dev>, <asahi@lists.linux.dev>, 
	<linux-arm-kernel@lists.infradead.org>, <yukuai@fnnas.com>
Date: Tue, 10 Feb 2026 14:59:32 +0800
Content-Transfer-Encoding: quoted-printable

Hi,

=E5=9C=A8 2026/2/10 1:51, Bart Van Assche =E5=86=99=E9=81=93:
> On 2/9/26 9:33 AM, Keith Busch wrote:
>> I had to look up the original commit that introduced the WARN,
>> 65d466b629847. The commit message says "Creating new debugfs entries can
>> trigger fs reclaim", so that must be the path that enters back into the
>> block layer request_queue.
>
> Thanks Keith. It's probably a good idea to integrate this information in
> the source code comment above the blk_queue_enter() call.

Yeah, I'll add the information in the next version.

BTW, I'd like to add something. The original lockdep report is:

[REPORT] Possible circular locking dependency on 6.18-rc2 in=20
blkg_conf_open_bdev_frozen+0x80/0xa0 - David Wei <https://lore.kernel.org/a=
ll/63c97224-0e9a-4dd8-8706-38c10a1506e9@davidwei.uk/>

And we see there some contexts like wbt/nbd can freeze queue fist and then =
create debugfs
entries, and it's fixed by the thread:

[PATCH v9 0/8] blk-mq: fix possible deadlocks - Yu Kuai <https://lore.kerne=
l.org/all/20260202080523.3947504-1-yukuai@fnnas.com/>

And the warning is added in this thread.

>
> Bart.

--=20
Thansk,
Kuai
