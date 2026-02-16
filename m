Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42EF2D9ED1
	for <linux-block@vger.kernel.org>; Mon, 16 Feb 2026 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771262510; cv=none; b=DJDagVPOTAFOYG4jfBQWqFJJ6zby8oAv5LcPe+NokTImAwnKIE2KXXhkChdPA8PoiwNPjmXmK3zrQ5jG20sxz1Y43tIj6HpOd7CQmAJvbHfUa/V1+i1V68j+8O+WQ+nAV9vanhmnIGZ7TqZdE2i5fA0qi+hkqpuUpgAAevDYr14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771262510; c=relaxed/simple;
	bh=irI6iv3P/TQovVrDbfpUft0UKQQLvoDcCG/7U032pOg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NY8VTvzZA8yUFjz0FjJygTuGUGX/OR/DK+onhDiGi8Am8JR19dGrGdoGdRWZErcx+v18JzZGT92fofSxK/ad77zaK8CDXTkWZ/RfVeD/mX2yKg83AN37iju8dDGRscqYi4zULf93coxqAzGSfPP1Sr9we2fvQkm9dfzr7SOzC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GdPrF8kX; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GdPrF8kX"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4138136f02eso288024fac.2
        for <linux-block@vger.kernel.org>; Mon, 16 Feb 2026 09:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771262507; x=1771867307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3T101hN9NEm3neDoNTWSMgO71Ca9QnzZNhrDcXRwOg=;
        b=GdPrF8kX7M6vfWSFhx1rvWgERi4tVgY0UQCxiBn9NRp5r0yx46fm0iVVPnx8nyrJuQ
         +ujxIs4ryMmxXJIqerUcVbzvxlEJuG+8VP+4GYk1x3ArKVByzuwqxWmkE0AiRMYkB6Eq
         JIQa1ja07ID5xpzHk9LNPYY5kP8fcKNb4u4hj3HRrF8ChhWmQT66oESCZkIb0MWAvpVV
         Y1xgbgwnNYknAxBca2ogLMuAl1xrOdTDpRgoXsJxPG4V8f42+DAHD22aGx5H6GTapSyX
         h03+++k2t2qB6bGueku85CHCH8mhwWABvX8+yp9ZihoSx3f2YpiTh+YL0LbWzqRJr0Gu
         QVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771262507; x=1771867307;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M3T101hN9NEm3neDoNTWSMgO71Ca9QnzZNhrDcXRwOg=;
        b=KQZQ71HlQ0qhti8hdUGtwi+MXD6whhUP57z6dvX3TXCY8bLSm5GF0Xrh5FU1eiJvfU
         988AmvsK5+QVa2SPuiYsDMllj93CS8P4GitJXDu6VJqpw2O6p72rQ0Cqcs0IzIgc0FaE
         x6gHGfC1xCc5yrbT2VGSBmBe+V1VxUwIu5YCiyH0so4gNIE6qFspj9kxxxthGsuxbxHu
         +eTmeITX37afE14gd14zEOlmytt0k/yT2tzsPw78d2tonztUF4ZXA/AG/omx3LkPSsY1
         GUMbuR+yFs76vOL89Cr36cXAuSiQwlOUxRYSloD3JRtyyAGpKFJe6s3d8gGq3CMfJ5/p
         XkiA==
X-Gm-Message-State: AOJu0YwG6HvhjrsnAJkzrsYFkY083zvHMQFFcT2/2PGmafpST2PVErTk
	yDG8Xrw63TQDbz5I0XyIL6QLMko+eUc6paxR706LFmz7R9ohX865+/Pk7luPGoclig47BMhZe2Q
	8qOdL
X-Gm-Gg: AZuq6aIXQP36jeRMZVRozPm+Qs6CQFN//QbTaPydv5v2rrTC840sBcpR33Qh4Dz0zGU
	ZExBdGxf8SVLb/f4n5blFsIr5p1YYXG/Hi+2E4EvkTxHxcKiVmjEiORASjJGidmBkl6TpyGa/fh
	SBxRWmvLrBEhpErNTGQJMaJZVtQ/nMUSXIz/N4NFYqf+bq30DmtvebLwYufrVsEnFfqhyZKv33j
	kMUSBWqmDUH84G2SqSJ6qe3CzZyaliKDVUryIWm4DMerv+X81RWNcjqldVGYthRhUvMxY0CAhmd
	zvCGu76cAq1m6m/qzz/zJlmOOrl9y1KvKEbRV2cohxp2BF7afiOae4Et7Eh0HWmK6AjrXDhWURy
	v96hb6ZRFAq2dRmpNicwHrmWiAtnRuCMb8OqqF1HpPjFktEfKJe5cSGcmUlKnTAvvTqQ4FI62ag
	Ksxbj2mJjlqt+SoR21ZkjxcAOuWzUO55HpnaHemkrfhaZcxLoW9G1h/gfrZIJiBTU9AX5P7yzra
	31i
X-Received: by 2002:a05:6870:c98b:b0:409:829f:f9f9 with SMTP id 586e51a60fabf-40ef3bae262mr5640228fac.17.1771262505821;
        Mon, 16 Feb 2026 09:21:45 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40ee90ba325sm11658295fac.8.2026.02.16.09.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 09:21:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <20260216052951.2744415-1-rdunlap@infradead.org>
References: <20260216052951.2744415-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] blk-stat: convert struct blk_stat_callback to
 kernel-doc
Message-Id: <177126250422.152457.15412219294500221010.b4-ty@kernel.dk>
Date: Mon, 16 Feb 2026 10:21:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 15 Feb 2026 21:29:51 -0800, Randy Dunlap wrote:
> Most of struct blk_stat_callback documentation is already in kernel-doc
> format. Convert the remaining struct members to kernel-doc to avoid
> kernel-doc warnings:
> 
> Warning: block/blk-stat.h:62 struct member 'list' not described
>  in 'blk_stat_callback'
> Warning: block/blk-stat.h:62 struct member 'timer_fn' not described
>  in 'blk_stat_callback'
> Warning: block/blk-stat.h:62 struct member 'rcu' not described
>  in 'blk_stat_callback'
> Warning: block/blk-stat.h:133 No description found for return value of
>  'blk_stat_is_active'
> 
> [...]

Applied, thanks!

[1/1] blk-stat: convert struct blk_stat_callback to kernel-doc
      commit: 3678a334a55e869b413e2fb4824e92200b149d73

Best regards,
-- 
Jens Axboe



