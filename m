Received: from va-2-48.ptr.blmpb.com (va-2-48.ptr.blmpb.com [209.127.231.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DE338330C
	for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036464; cv=none; b=VgcURQ9RiYBMCEcV2w8af2JkZvk+gk5hTXjQuUKxcVFv+ZSNTlIldQBuBSa9FTLFYjOtvYcMolcygZJHGmKmui9Af/8q0xsqlPkNGFe900mH5q8Dch0vSkLakjV5i6NGLGO3FbN4FjVLFpPMJZJ+6iJ53VMHxavJCF+yqaiC0KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036464; c=relaxed/simple;
	bh=1q44HI+pBtTReG2KCA1C3fgOAqH9EIr+VV6d9IM89Y0=;
	h=Cc:Date:Message-Id:Mime-Version:References:To:In-Reply-To:
	 Content-Type:From:Subject; b=iUeU/2qAkUkbnT+d9T78N+vCSX8SS8qx0tt1XlbMum6BfLqc2+eYPeiXIVcjMs90MTU1Kc6bwMDOETDaKYcEfg65QvxSDlH8u+Nr/Z1shwq8czVQ2fQQSW4O7XiqyAIAU/0Sby9kqN2lFNoZsJrT9mijYipRbQosUGk6yIBtbZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=kLrQWmMe; arc=none smtp.client-ip=209.127.231.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="kLrQWmMe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1787036450;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=1FJeatMx7tWwetOlM2OLSFSr7Ao4qFJCjf9XJzxN788=;
 b=kLrQWmMeOMT5PP1OVAdy9P3GyiZy8FuncjTT5Rt8nnjivdV5Y04CqTQkIVY1INHL+ORNCP
 9Jv8a+UeAI860DZnAgor7t7343+zpwM5kIFefBzl7tFO/DqMaSrkpT80Z+dDD4ZkxK6lrj
 ubHZ//+7qKUjaXKqIXHvLCI2koVSj8vaTLmssWNgjG58oCgHRrJWuls2VGBielMmjpStMi
 lO0E24eQFzLvL9APNkUOAdqVN9ch5r8aAMwGujbLB0U3J89fNIezIy2wzD0ZH7h/GeDpwC
 F7RvImipvYVWSPRqIK9fPh6AmXM31pELZ/hP6L5PTCsR1a0Hj2lLYweP9pevoA==
X-Lms-Return-Path: <lba+26a840322+c25759+vger.kernel.org+yukuai@fygo.io>
Cc: <nbd@other.debian.org>, <linux-kernel@vger.kernel.org>, 
	<mchristi@redhat.com>, "Tao Cui" <cuitao@kylinos.cn>
Date: Tue, 18 Aug 2026 15:00:44 +0800
Message-Id: <525b4ca2-be43-4962-b7f0-573eb0b90f02@fygo.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817141027.48423-1-cui.tao@linux.dev>
To: "Tao Cui" <cui.tao@linux.dev>, <josef@toxicpanda.com>, <axboe@kernel.dk>, 
	<hch@lst.de>, <linux-block@vger.kernel.org>, "yu kuai" <yukuai@fygo.io>
In-Reply-To: <20260817141027.48423-1-cui.tao@linux.dev>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
From: "yu kuai" <yukuai@fygo.io>
Subject: Re: [PATCH] nbd: clamp the timeout before converting it to jiffies
Received: from [192.168.1.104] ([39.182.0.156]) by smtp.larksuite.com with ESMTPS; Tue, 18 Aug 2026 07:00:48 +0000
X-Original-From: yu kuai <yukuai@fygo.io>
Reply-To: yukuai@fygo.io

=E5=9C=A8 2026/8/17 22:10, Tao Cui =E5=86=99=E9=81=93:

> From: Tao Cui<cuitao@kylinos.cn>
>
> nbd_set_cmd_timeout() stores timeout * HZ into tag_set.timeout, an
> unsigned int, and passes the same product to blk_queue_rq_timeout()
> without any range check.  A large timeout (2^32 seconds, say)
> truncates to 0 instead of being a very long timeout.
>
> Clamp the timeout to UINT_MAX / HZ seconds first.
>
> Setting NBD_SET_TIMEOUT to 2^32 left the debugfs timeout at 0 before
> this change and at 4294967000 after it.
>
> Fixes: 55313e92bd17 ("nbd: add set cmd timeout helper")
> Signed-off-by: Tao Cui<cuitao@kylinos.cn>
> ---
>   drivers/block/nbd.c | 4 ++++
>   1 file changed, 4 insertions(+)
Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thanks,
Kuai
