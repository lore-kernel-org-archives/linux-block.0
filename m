Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFCB225390
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763221906; cv=none; b=rSdiYRO3IhWkT4iUCQeO72PCmyiXfj25x6AUoCeRNrAdZ03CetIw20tRpirDpsFhNi+OZHynnt+EbupTSzN++ALb0uZFpAHg4LuO1qkzMQpi7+DB8FxK7nMb/WlpS7H2fbTP+/UKuHsDh5sds1k68YthWRUYPM7zo0DCGu0C00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763221906; c=relaxed/simple;
	bh=pzWPVQ8GdreVBO816k8UADkKSCD77YskIZrpvAC4HHg=;
	h=In-Reply-To:From:To:Cc:Message-Id:Content-Type:Subject:Date:
	 Mime-Version:References; b=LLeq0X68LwB2Yr3ox3CkNlsf15dbUfe75qeRZAkXn2k0XEBOK6MWkpIbfagWR70+LWFClD2V+iTqRQObhvgsW7d3+BwHQrR1VXD1VwIJA1aRprJ7AAMjT5sunJZXlO70kGY5gyWXmdM5eBrrPByalAJeBABOW2FaWMvIPQGr1vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=s5P3v6VJ; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="s5P3v6VJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763221892;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=eIVIqg5H76+/wW/OhmQAvmScyINJb7NcynmvVQrg6zM=;
 b=s5P3v6VJ2L/A5lonjj9bAClhcUYQWBr6uKrmSCsTxEhTBwNXLquwC7dGm6xQoMfjBt3//5
 g18Wxk85fDVC4QBnKQ5HWuoLk11jNfz2uup/giYuIuiatAzhI/+LcvCeC9kqg406f27FyV
 GVQZ/ISx5XVDZR2WZkkim2wqRJZnbO3a+ldsUUQi/MUvFmKX0Rewf79VfwQ/Hv+e2pzYYH
 xYf1NzsekRgja8B1JC13McIu5EXJF4pjyfwc3sAVLaJ8rGUu93M4EkqmudCgDcF3uWNyTI
 XF5rBKP0Rhwuf8hkvzV4RVvKkQe+JCfIN0YraFTW6T5b4ip4iGXYk6JzmEsoEg==
Content-Language: en-US
In-Reply-To: <20251114235434.2168072-2-khazhy@google.com>
X-Lms-Return-Path: <lba+26918a182+ea5146+vger.kernel.org+yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
X-Original-From: Yu Kuai <yukuai@fnnas.com>
To: "Khazhismel Kumykov" <khazhy@chromium.org>, "Tejun Heo" <tj@kernel.org>, 
	"Josef Bacik" <josef@toxicpanda.com>, "Jens Axboe" <axboe@kernel.dk>
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Guenter Roeck" <linux@roeck-us.net>, 
	"Yu Kuai" <yukuai@kernel.org>, "Khazhismel Kumykov" <khazhy@google.com>
Message-Id: <2d827b93-9ffa-4767-8409-88460e64a407@fnnas.com>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sat, 15 Nov 2025 23:51:29 +0800
Reply-To: yukuai@fnnas.com
Subject: Re: [PATCH v2 1/3] block/blk-throttle: Fix throttle slice time for SSDs
Date: Sat, 15 Nov 2025 23:51:27 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251114235434.2168072-1-khazhy@google.com> <20251114235434.2168072-2-khazhy@google.com>

=E5=9C=A8 2025/11/15 7:54, Khazhismel Kumykov =E5=86=99=E9=81=93:
> From: Guenter Roeck<linux@roeck-us.net>
>
> Commit d61fcfa4bb18 ("blk-throttle: choose a small throtl_slice for SSD")
> introduced device type specific throttle slices if BLK_DEV_THROTTLING_LOW
> was enabled. Commit bf20ab538c81 ("blk-throttle: remove
> CONFIG_BLK_DEV_THROTTLING_LOW") removed support for BLK_DEV_THROTTLING_LO=
W,
> but left the device type specific throttle slices in place. This
> effectively changed throttling behavior on systems with SSD which now use
> a different and non-configurable slice time compared to non-SSD devices.
> Practical impact is that throughput tests with low configured throttle
> values (65536 bps) experience less than expected throughput on SSDs,
> presumably due to rounding errors associated with the small throttle slic=
e
> time used for those devices. The same tests pass when setting the throttl=
e
> values to 65536 * 4 =3D 262144 bps.
>
> The original code sets the throttle slice time to DFL_THROTL_SLICE_HD if
> CONFIG_BLK_DEV_THROTTLING_LOW is disabled. Restore that code to fix the
> problem. With that, DFL_THROTL_SLICE_SSD is no longer necessary. Revert t=
o
> the original code and re-introduce DFL_THROTL_SLICE to replace both
> DFL_THROTL_SLICE_HD and DFL_THROTL_SLICE_SSD. This effectively reverts
> commit d61fcfa4bb18 ("blk-throttle: choose a small throtl_slice for SSD")=
.
>
> While at it, also remove MAX_THROTL_SLICE since it is not used anymore.
>
> Fixes: bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW"=
)
> Cc: Yu Kuai<yukuai@kernel.org>
> Cc: Tejun Heo<tj@kernel.org>
> Signed-off-by: Guenter Roeck<linux@roeck-us.net>
> Signed-off-by: Khazhismel Kumykov<khazhy@google.com>
> ---
>   block/blk-throttle.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)

LGTM
Reviewed-by: Yu Kuai <yukuai@fnnas.com>

--=20
Thanks
Kuai
