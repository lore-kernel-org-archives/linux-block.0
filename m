Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC83BE156
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154879; cv=none; b=E6rp8BqlLqozEVGrMJxo67EoLH+WZnQB2FElM1waybEejJU39S7aazpE1/P1j2z+QvlduSzSiyR1jGr4ITVOC9T2UK8GxPWdbDiEGfvvh9SgeDYIcWyhH4Cke9n4zCGmeJahnH5UZcbXFfLjGtEjyZPXCUh8e/4EtxjjAgqjD80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154879; c=relaxed/simple;
	bh=epCF3WAtVK+rHoAAfkpRXRa/RsXFmQXBbOeXNtNyprE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kfZtJRxKpjruxUOpLC3d3BfKDQSi5X8CqoEiGyaQ0yO2lDQ/PV9pA7veIN7qzz/6Vcd8FRNXtFU+ZjAbMT6iohKJ8vl6+Z4s8+SKfcUK+sdIfv6vf4jexIRl+Yp6BwnQ8/S3IkQaZh1K3Hy5+1vANZeKcY97FRSQwD/1wkJ0UGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=g50754wT; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="g50754wT"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-44caeb973b3so3611991fac.1
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 15:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784154875; x=1784759675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OMsKH9F+ormFI1Pys8jKczpMBx0PRFI2SBhZZ0ypZyA=;
        b=g50754wT3OirDsmAblB+hhBMkqxo4Peg/u97803yY5t2xqzH/385hrjeZ+dlg5P6tE
         5A3LfzlK+0q9Yg454PhlCQn+jOkK80KFm+3YbBVcXHRD0afc945bHTSz8c1FqdAnjV88
         rvkX6niE0g53fPovTvhJhmoIvEj2wrHaQs1iNcNtLfjVo/EVWWI54CLPVMs+906Bv1FO
         cDHStmT1DlZPe4x0zKWuA13EkT1m4nzoOEAlg4uGRov2gipCvTkTSTrJSdSeenfr9uyn
         4LMWJS3Or6h2d/0loGoLJ/ImA+1ZEaeseRqjCKZafF9Ec+5OYTdSHF93jyFMw6OxZMFp
         Dwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154875; x=1784759675;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OMsKH9F+ormFI1Pys8jKczpMBx0PRFI2SBhZZ0ypZyA=;
        b=HFGbka37mHgMuqPf1BKfg4+72PAtyAC9XjN27bddRiRIW/lRvrPzdB0BfmWd81wran
         6dbYNWy9KFUEg+w2oSTsjmqhB0W8HBAPmpWIMtLrETPcVM0i51FL5cgv8BVMo1yCSkK7
         P80nOhd35m0xH46t4XEJDhyn54yTj0uXfiMEH2KH0UXncGktAHJgKEGDBQDUCXvRP+lh
         DNNY3LmLF53xEF873vsclRYCd6co7yDgzaU9xPlSCOkuN+VtpE6aelaet7ASBdZTNmVr
         oPI9E3xQuUjm9rcppz8wLrLymzWQWmNw+jxPH52IX3hS66vx3RnWFHUU1cLRGFwt9L08
         GwyA==
X-Gm-Message-State: AOJu0Yz9lDntLNkTakM0iGw7P9LT6dqrSGZQxhCuiGLiOPHQopqkzLG5
	3PCulj8Ytq0Dfw5gtvRuVIxMklEM5OK1vAI7uq0qte3ZP4t8IwsmSNOzuDL/0pcauVg=
X-Gm-Gg: AfdE7cntEB0iHD0q3j2s1yFBffTugTw617JpISiAJ6I+53O+yh6X9LteW2TKUDoa4vl
	GF4AJoWtO1OuVOPs8t/wBSziX4NpMN47AaxxHu62+hc3pojgvPZAbSMk6cvcGIAQ9wfXCn0QfFf
	CMenrjI/b19LYOED5JaULKMVqcxbAmtxo66i3GTjYXTSArZJbvWcLxHqeARnJ5Ut2+FZL7fysnP
	msT5qWnh+FQ8pPwtvahrk8tmRtVhEWApAyK2Hli5AFLXQF0GbFgu/smSH5IPGs/0xWg6dBNI5mN
	91kZecr34cEycfT54twpX7oOStF7sr1SYtKA3i3MPmp14AU7Niri3NhXBPztSPLegjzdRfSyC6I
	PikXCy1HdhzVIu/tAik2KcKhPxIKaWxh7skcJUY40RvhfVQEuX03l6/s9oToPAxnhJ3ctcKsy6c
	ecKc6mDMHSdyzGxjdR442v+3Mt6ksqgm5ZTzT9iy9MCItBLaf8jYKKpyM=
X-Received: by 2002:a05:6870:65a9:b0:43b:637b:c33f with SMTP id 586e51a60fabf-455f7a2d10fmr5770132fac.6.1784154875484;
        Wed, 15 Jul 2026 15:34:35 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45200b7b4c5sm14362722fac.10.2026.07.15.15.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:34:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Usama Arif <usama.arif@linux.dev>, Mike Waychison <mike@waychison.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260715192950.2488921-1-mike@waychison.com>
References: <20260715192950.2488921-1-mike@waychison.com>
Subject: Re: [PATCH] block: fix race in blk_time_get_ns() returning 0
Message-Id: <178415487451.159585.8139693010371927224.b4-ty@b4>
Date: Wed, 15 Jul 2026 16:34:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 15 Jul 2026 15:29:50 -0400, Mike Waychison wrote:
> blk_time_get_ns() populates the per-plug cached timestamp and then
> returns it by re-reading the field:
> 
> 	if (!plug->cur_ktime) {
> 		plug->cur_ktime = ktime_get_ns();
> 		current->flags |= PF_BLOCK_TS;
> 	}
> 	return plug->cur_ktime;
> 
> [...]

Applied, thanks!

[1/1] block: fix race in blk_time_get_ns() returning 0
      commit: 691b052139c94ee6640ac39e0b764dd3867897c0

Best regards,
-- 
Jens Axboe



