Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66805374183
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160918; cv=none; b=nHPq7/+NvrncwmiAYJUpVI1D9x7z0PThVsLY6ASiVJNTe98a0l8Bfk7hh3V3lmLk19EEFX3yf7deEhO15haToIj+85UVDc+pToUfH7P9lUK3X56ScJhtKQs7EPPHOxO2ytL4l3w3hWmLd4ME5bsWiCxBpGGK+qYWVCYQtSoD558=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160918; c=relaxed/simple;
	bh=HUDExN3lnnesXXgTgOZLlsoxX5V8SQadHshH92kBxYw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bh5wvIa1NmtEqN7/XVsec7lPR7XcGaBVmQSO4Ss3roAK5E2zRpfLYKNuiZxWKyxTznMbrnp2iI11xRb7dJjT5f/PKCXM+6tDGkSrG2sXhuLdKAh8XbRsJLUABPu74AfXM9PV5INHClr2MvR9ibI3KfS5Kt5zyREQpJMOy/Wzo/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=eGTkRS/9; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="eGTkRS/9"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3535a54bed9so4884098eec.1
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792160916; x=1792765716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XCmVsxrmgZ8pEfg7Qw32h+8bf370YAvLf7Ni1e9gfE8=;
        b=eGTkRS/96QFF7yVAVOedV3E2Xi7Bg/T33N4Xux5QEx637bkhvXvByfMLP+kffeAPHX
         COWK/tTbVleP/gsieO8fT04PAZwa8nhHdOT/Y+oF+PXmguh0VVH72xPgk+mavuMYxoJV
         x2Txm9CcfGf/kz9lkz6pLsKE2DcHozo2paAVqNFNtE8/P19FqhxViSFNvnvZo38XEmS1
         HHPGm6CIn/7f0u1181qMhMWlwxobF7t5xE3fjwnjHXg6d6TbgZlc5vV/oM4/IDeUPOZg
         Q+cHFRJB/bIa+nk3QqJgsSTzXeQmTAgRb6g9NEV7lB4TLjxlPu2AY/2Wcj9Zn6FuRTFS
         JezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792160916; x=1792765716;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XCmVsxrmgZ8pEfg7Qw32h+8bf370YAvLf7Ni1e9gfE8=;
        b=cGv3FiPReyrWncv40h+5xPmXc4ny8HPxBFTXTV8oOth6FzBdb5olxRuUjJOC33kbpE
         53NgnnEfTt/hfKwZhrVJ5aqWOE+WI9y+fHYL7YxLxpg4b6oWlu9x8lAB0RDdc2+3xcZ/
         zP4Pr70lpFJxIGxYCKD/S4S/glInBrbN1VXSdjEYO7xm9WV1Imiy3h3Ky/c4X06aq9hA
         tuRXvGwq9wIh7Bxm/e2S62RsmzaHsV9dzYM/S7hM9hDs4VpHknP/A34FTZMATAHvAFRM
         oodIAoI/b36GCPi0GIbXOiX+/cgWhl1Lc2NIH2mCCmuQpFm+X2dAkXBdhDvnisxhCosl
         /Gbw==
X-Forwarded-Encrypted: i=1; AKwUvBwcetESAhQhwhsA119Bzjjkb5EtH1yuAqfpF75Wb74k04h1zxx8iOauecEGflmQyihaFxz9ONJWqzVdIw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKfjFHmX09yFV4Rq2fOgIJ1kIIFTO6XdSPejSLhbEwq5rQuaRC8
	WVB8wGIYYEHfl7AUZOAf7mTrE4igNswe1tC9FUC3ZYq0OxzZOCMzHflMzlVJZz5Ub7E=
X-Gm-Gg: AYBFou2orgW+Onu9TacDKl25Plm3ommWANMg5mc02bwW92pAQmaUsdQFycaafh1ZLwh
	lbWghxoD7cqqd6QbqWrBkSTNU/I5WZIAejgLCwbm0fqgYfZToxYJqVpOGud0YqST2js0fPjn+2C
	EoXy19w7+TB1cg3icI8lilP0v8fRLJsF7ic7+2HypIROupMbhQZrmfVHhVCPooiB6msgULyyiPl
	2M5OfZWqJsWV2odc3kSaNNpQS5eZEK+tLWfcuBSHDjzunK+7mjrczwXUw7oK38s+wm274EMRZo9
	fPA4ozGUImw/M9lICBJYqTc3bNy9BngzakcZs56dh+QUPYVuYllx8hX6WZpfehW//leJFnubfeP
	n2XP7MNmyRuv7sKJ0JDs04V/LHRYv7ZaR8OeYVvWD9HMHJtjnCmNpeGXibEWn7TulF/8gP2HnpB
	JTdShUKjrOVOHoKl8oKcS0T9a8aPCfV+jFpDfZ9BDMsOXjzWPP8PFLb8HnEwLkqvKrSPqkBX9u6
	ojqToo71E8tILMkGKlhaMDBOSJMUmUWItlboCgDEb/cXlra/alWtpHrbg==
X-Received: by 2002:a05:7300:c00c:10b0:35a:22a4:12a with SMTP id 5a478bee46e88-35a22a420demr23834016eec.18.1792160900544;
        Fri, 16 Oct 2026 07:28:20 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081bafa7asm7150945eec.14.2026.10.16.07.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:28:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, Qiliang Yuan <odys.yuan@gmail.com>
Cc: Yu Kuai <yukuai@fygo.io>, Hannes Reinecke <hare@suse.de>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261001-bug-blk-mq-global-tags-srcu-v1-0-e8415da10d1b@gmail.com>
References: <20261001-bug-blk-mq-global-tags-srcu-v1-0-e8415da10d1b@gmail.com>
Subject: Re: [PATCH 0/2] blk-mq: stop waiting for an SRCU grace period when
 freeing a tag set
Message-Id: <179216089963.2070939.15710192231611954920.b4-ty@b4>
Date: Fri, 16 Oct 2026 08:28:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 01 Oct 2026 17:17:49 +0800, Qiliang Yuan wrote:
> blk_mq_free_tag_set() calls srcu_barrier() on the tag set's own
> tags_srcu before cleaning it up. That costs a full SRCU grace period,
> 1-3 ms, on every tag set teardown. When the free happens under a lock,
> the cost multiplies. ublk drops its last device reference under the
> global ublk_ctl_mutex, which caps 16-thread deletion of 4000 devices at
> 19 s on 7.3-rc5.
> 
> [...]

Applied, thanks!

[1/2] blk-mq: share one tags_srcu instance across all tag sets
      commit: e1c51edd6a575ba3b6fc5acb57ed2fec6951a910
[2/2] blk-mq: drop the tag_set argument from blk_mq_free_rq_map/tags
      commit: 5f702d4bd61be29f11d07dc1c4a6953d39b28f9f

Best regards,
-- 
Jens Axboe



