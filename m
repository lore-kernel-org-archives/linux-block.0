Received: from va-2-19.ptr.blmpb.com (va-2-19.ptr.blmpb.com [209.127.231.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951C038F624
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 05:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734988; cv=none; b=so3XkcCvtcKQ8nXz6h1afbrLoEfreBQPDOH1F1/nnrgenFum2z+cdlTs9duXihjgO+dcz06uc/shLxOFF8ZNjacoprGKZ6YFu1LMsyq+E8lvxl6aFcI+kU6kxs9MYBtBBI8CB8Nsx+UYBGD6vgUJFA4qgChgMYZt3ocA8uLWNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734988; c=relaxed/simple;
	bh=dyoyqsj+eOkgTGsz/UeO/4U0DhOjLi5FRzZXcY+CYm8=;
	h=To:Cc:Date:Content-Type:In-Reply-To:Message-Id:References:Subject:
	 Mime-Version:From; b=kDeHxC6tG5ljPTNxkXBhAMU+IFEaecrZ5DkgvmWn344R1S1fHyFPMfI3jtUbZGz+5x+Pr0aVspi9v70EoqQQv0u6eMKMIzkl0AOvP7Cyto+rtEmoTGsx35L5tj2k4pMHIY3LuYUX3jY8HBSxUorZmoEHjb9kYFfseAasHJkO31E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=g92Qq7M1; arc=none smtp.client-ip=209.127.231.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="g92Qq7M1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1785734980;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Ral+m31fntqDDJ+VtdD1GL/ppOgGBjRGSzR99QpzVUQ=;
 b=g92Qq7M1S/KxpoW8Z1wr2POkVfk31cCOaZGAtc96Hyyy8+In5UQx4lLm7JxEGPgwsXNh26
 GKIYNSHtDxZ4iQBqqgpHkwSAyF42PW9nKmz1d5UoeMXbvHCNzVpfE/erfKVrIBLqyk/zOC
 fjBWo9wkAQPEV2CqsedhTIsHAo3V/bnlwi+aRqq9Imbg9a5fMeYaW5eKrXaVx5S98u97Fj
 NBYz+0UwlMdIDehUPWlXyIj8/8Edo1A0JC7Z1//PkLSGarxuemHfRnqKnNaGKKD2wHOtnN
 1CfGWs37CrrmX5TQUAouJbPlVJiUoaMLq7SUFKIDBl2oXIt0fOc79njWs44i8A==
To: "Tao Cui" <cui.tao@linux.dev>, <axboe@kernel.dk>, 
	"yu kuai" <yukuai@fygo.io>
Cc: <tj@kernel.org>, <josef@toxicpanda.com>, <yukuai@fygo.io>, 
	<cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Tao Cui" <cuitao@kylinos.cn>
Date: Mon, 3 Aug 2026 13:29:35 +0800
Received: from [192.168.1.104] ([39.182.0.181]) by smtp.feishu.cn with ESMTPS; Mon, 03 Aug 2026 13:29:37 +0800
Reply-To: yukuai@fygo.io
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260802150413.29789-1-cui.tao@linux.dev>
User-Agent: Mozilla Thunderbird
Message-Id: <95905ed3-dc3f-410d-a530-e26724839d79@fnnas.com>
References: <20260802150413.29789-1-cui.tao@linux.dev>
Subject: Re: [PATCH] block/blk-cgroup-rwstat: use data_race() for online test
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a702742+68808b+vger.kernel.org+yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>

=E5=9C=A8 2026/8/2 23:04, Tao Cui =E5=86=99=E9=81=93:

> From: Tao Cui<cuitao@kylinos.cn>
>
> blkg_rwstat_recursive_sum() reads pos_blkg->online without the queue
> lock that its doc comment requires, since blkcg_print_blkgs() stopped
> holding it in 56cc24f59c14.  Concurrent blkg_create/destroy flips
> ->online, tripping KCSAN.  The race is harmless (RCU-protected, stale
> online only causes minor stat noise).  Use data_race() to annotate
> the intentional lockless read.
>
> Signed-off-by: Tao Cui<cuitao@kylinos.cn>
> ---
>   block/blk-cgroup-rwstat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thanks,
Kuai
