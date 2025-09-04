Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F2E2877EE;
	Thu,  4 Sep 2025 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974309; cv=none; b=tMvF8ZjCDiaTMRmiwvUGX8DdaNfadj7JYhUDdERc7N5iuxYRuLDTVtozRv2PaD+wnxJAsugHkzyrhYiTIhdyE8diSidYRe1mhXSN29png79VL7ZbpfRjRqp5Cm29abuBXe+lHDrtZO+MTLOVEU0XH5Yyo6elgZkLYlvLKxq1J/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974309; c=relaxed/simple;
	bh=0w+xnx8GDzBkVH9MReXmk6GUPZ5qZuiT3Hfka7nZ3z4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rMsVfuoO+u0efE5MQn/CaEu2r+Q9F3AESA19VrvAd1nHlTOdtNeyyn0sP3iqLXRF8o7N1Omk2tv8pzX04ApsDbT1BffQ1eBPwy/ufw3IYwqQcxGgyCRv3nbh46WmsRhR6olrO5iJzsD91wc2D8onkisPUgnCTtobW2lGhs3/Gts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=a8WXWOTv; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="a8WXWOTv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756973995;
	bh=7DN0jn8EFbvGagtqyUaHOSQPeNSavR6C85ONmpAUNNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a8WXWOTvRijQdEPpl+JiVWZmXQWN+VosqIrCO8GJAuvis3J3WSZ1zmIBLEdYzwEi+
	 OdXqTSJyrCvej+/DNjqZurVkVziyLZ8Sx6ZzL2h+EEd9LE9ewMavLFfg2Sso85XFov
	 4PNx5bctctOCJksSzdwCC1/M3zklWSLoInNomowI=
Received: from SSOC3-SH.company.local ([58.33.109.195])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 4E5236EA; Thu, 04 Sep 2025 16:19:37 +0800
X-QQ-mid: xmsmtpt1756973977tsvxx6u76
Message-ID: <tencent_329AB29889A28A31719F322691C87E214C07@qq.com>
X-QQ-XMAILINFO: NZa67OCgpTu6oc+56M+ZfTWjVoMuYGJi2nW9nhd25uQ8uEJ0hgY8nnHyG8p8A2
	 AW3VIDJTXs7yDI7E2fjw5JORUw5U3Ic4t8lM10c/YEwxuCFKNaxVR9WptP33/bXb+buu0Hb3q9z6
	 WqXo5ifbVzcYHjjhNDLWec3DSYEdQ4cuYIyXvgahGy89UFw6mDBS+kcWkw9kSw4wgolstVj4QHl1
	 uQVyEhAdJCzZrnhi9hI1VU1w/Dbda5rPpMQsSpnUrAgJwkNmosTRSOXg73T4uLa9rwEVaTT/C2dW
	 0x73pjmTv2qe7vKZFSZ3HQ33QwSbTL4jIuVPV4EuaT4i3ypj96tWpyx9ZbEXQgwybO9ZhS2V4OKR
	 MTcNPfr6L7vTZzRuUERxMTjFFg25QCb7ts1TvQX2uG0vP8zOR+YA5A2B5fW8cvyl7UMTHVViFdMg
	 4NbvQsxa2yaa81+J988I7KGuON59H1q7jxhZKyfgIUMVSS3Wvvbq1aHd5NxFowXR/S0P/1KrA8ah
	 3Tw3Eb2fqcHdNIqT+6AM39JkmfLRUuP89lNqUe1xvbxbb4PSIm6ssQRVVJDqOVdiodYWkVz3JzLb
	 aZYrNU5miF6a2Xq9oOsR5+UqINfglG+2FlfnqWrZ3zudCQ8VzebYb2lAeS6Fw4IA4BMvkZXrs8Bw
	 2ObIlrp5Ax8Of+LOiHbH+mFO9VNvhUlsv/Q7ZXeqaqkRGN/+bCi9nliUhACdEd2j8kyEkHGL4Sx5
	 vdnOE4biva4Sw3bzhMvYi/wW1LYV+CkyM5Q6vB1RgePRTJ2Yk+t/l7ezAju26vIEh/6R61f0c3tz
	 hloXwzyjdlkWTP3AKVWy4m3boaKGdnLQ2FGmGhlGmd33vqYhoycQi5H4IMRRqRpGFvXfY/zMXZSa
	 4hKPn+Z8j5+tqaUxXS0pJU/qKzIGIzo24f1rEFrVUN+GbTZt5FLsrB6FOoHgfdX/QIGoncxSoM5l
	 gffXwPiQOKRayw3o3YgjxS8q8hMPR+EB1OeMqtprAUwndbTVQPGgvtNwcqUd14huCRZT9c90ysDr
	 8npCOtew==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Han Guangjiang <gj.han@foxmail.com>
To: yukuai1@huaweicloud.com
Cc: axboe@kernel.dk,
	fanggeng@lixiang.com,
	gj.han@foxmail.com,
	hanguangjiang@lixiang.com,
	liangjie@lixiang.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangchen11@lixiang.com
Subject: Re: [PATCH] blk-throttle: check policy bit in blk_throtl_activated()
Date: Thu,  4 Sep 2025 16:19:37 +0800
X-OQ-MSGID: <20250904081937.3979230-1-gj.han@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <59464ad0-856c-4ec3-b5b7-e7799c337a84@yukuai.org.cn>
References: <59464ad0-856c-4ec3-b5b7-e7799c337a84@yukuai.org.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

> Yes, however, this can be fixed very similar:
> 
> Set sq->parent_sq to NULL here, and add a helper parent_sq(q, sq):
> 
> if (sq->parent_sq)
>         return sq->parent_sq;
> 
> td_sq = &q->td->service_queue;
> return sq == td_sq ? NULL : td_sq;
> 
> And sq_to_tg() need to be changed as well. So far, I'm not sure how many
> code changes are required this way. We of course want a simple fix for
> stable backport, but we definitely still want this kind of fix in future
> release.

We preliminarily tried implementing this approach. But the changes are 
scattered and backport might be complex. So we provide a simple fix first.

> Meanwhile, please remove the comment about freeze queue, turns out it
> can't protect blk_throtl_bio() becasue q_usage_coutner is not grabbed
> yet while issuing bio.

As discussed before, we also removed some outdated comments in 
blk_should_throtl().

We just submitted v2 which includes the changes.

We look forward to your feedback and suggestions on the v2 patch.

Thanks,
Han Guangjiang

