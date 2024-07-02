Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BE61BA067
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931737; cv=none; b=msq0Nsc6i4hgpQ6hbIgHt2F9Red74sjZYpS46Kb+FqZRhrc/9YVnQL3cLHKxd1WtYmyWbKDMQSoUCkq/BGnflieY5PXOXkfdIsPf38+x3se3G/vg95gNve1HQZeZKtUEn/tZW4Jg4ckBhe2g9vc1brHZE8wzwStiAThp1/6ebiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931737; c=relaxed/simple;
	bh=pPl3S4AWXA8O4LcN4bVo88mfkzn27iXY9OELuXrnGzg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tP0u1v0ipJBdpZdt8W7n5Y/j6O2B2LuzcibHTec103aulXOkhRQT1P5hCdRyFJyyC1XM2Kg6qgpITJY52v1n9pMIvCTxxgQgjxocxzrcRFMU/68fBOa/I+bYjnxKAdelJFJZqeNzn5xRHHR35TAKN7a1OHk9THfMb2EK6dzuiDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=drUXIlBb; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="drUXIlBb"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d62fc85d6cso128376b6e.3
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2024 07:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719931732; x=1720536532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3l+LBXCTol6JGz+55J1LFZ/qEAbK3KSLhxsv0ZDDH0=;
        b=drUXIlBbSrUOYvsrY8TKBFknLMXU22uClMC7yIEi6mS61ANxhZ/Rn9wfBwRgUDdg1k
         jTIG35ydVmAfIEWmUGmL0yg1hpLj6qT91fjoj1ehD5FImkLxmwPHKz83op0cND1RUCNl
         9mmO+qMoOCMUhcwV6+/fLM0ChyCAyeYltxyNvOqx0Iv6nxHTHMq1bejxANx4c+nGWqL3
         4JNT1qlOMYn600DN+Yb1z1Gp599dwElwWTPOCnuPb/yOwXj3tG29ZQxM1BjdR99WittB
         N6EuiJXZ++QdeqzEo42u2YKs3lH2yWyCVG/NE/B6purJvf8Qv+9uPNeryC1fcN/ZFS2a
         kM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719931732; x=1720536532;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3l+LBXCTol6JGz+55J1LFZ/qEAbK3KSLhxsv0ZDDH0=;
        b=o+qf0mYsXrE6nkPdHlEIk035bbvSdNiql8G9WbwDUJ41aelz5v9s4K4S+Ox5rq8rdv
         9bGA0Tg45O2Ltgkd3zL+agsesfWjuiXMow7M/WbdgwZ4ccyu7uzxo8tMisaarcGWQh1y
         psuhoTRhYUdEaAXYsB+/RTyEc0DpsL1jEZ9qHsbedGl+o3QNsqNvwkHCyzsnTldZEO31
         WLiGW+4tuuNUhX3CpM5iHtldCdTRP1xA8BB2tTdbcOzqPtRVhrwikWWKzitMwQTy0NSC
         7A9RYPfJVVri/jXjQUmLDyzXNUbvAMhSn0/Q1Qp7VMsfBQ2GnncodYEaYjTEQu6xPuj8
         Qf/w==
X-Gm-Message-State: AOJu0Yxu0GPNLB55+hQzUO8rzdnc6RdIM+1X5anQi81VjOjxQDX3ZXeP
	TePLfnIYblDvoPAUuEi3u4+V8SWWLkm+X8ZIhap5Wu9TXkO+myU40InK9PuqT86TXcUWpkG8myz
	A/d8=
X-Google-Smtp-Source: AGHT+IH77fOlmz3AC7xuDdlL/stTFbWeChuo3g/0hUdImM/13k1flMKgEMywwmVpkszbRPIV+EDvhw==
X-Received: by 2002:a05:6808:2187:b0:3d6:2dd2:80a with SMTP id 5614622812f47-3d6b5e3ddadmr9948415b6e.5.1719931732095;
        Tue, 02 Jul 2024 07:48:52 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d62f9b9029sm1743041b6e.5.2024.07.02.07.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:48:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20240509170149.7639-1-bvanassche@acm.org>
References: <20240509170149.7639-1-bvanassche@acm.org>
Subject: Re: [PATCH v2 0/2] Fix the mq-deadline async_depth implementation
Message-Id: <171993173102.106736.3773541970780391323.b4-ty@kernel.dk>
Date: Tue, 02 Jul 2024 08:48:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Thu, 09 May 2024 10:01:47 -0700, Bart Van Assche wrote:
> The mq-deadline 'async_depth' sysfs attribute doesn't behave as intended. This
> patch series fixes the implementation of that attribute.
> 
> Please consider this patch series for the next merge window.
> 
> Thanks,
> 
> [...]

Applied, thanks!

[1/2] block: Call .limit_depth() after .hctx has been set
      commit: 6259151c04d4e0085e00d2dcb471ebdd1778e72e
[2/2] block/mq-deadline: Fix the tag reservation code
      commit: 39823b47bbd40502632ffba90ebb34fff7c8b5e8

Best regards,
-- 
Jens Axboe



