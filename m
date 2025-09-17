Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84F918BC3B
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115676; cv=none; b=XWr4MDUCH8CKps3Ip7p7LrGOSGbQey8GRQMz27FtmqwlGPNGqfQpg2/azFhs7NQfh0NMRHmtk9cg7p+Jh2RUt9rL50mDG8+Yn51TfW8UsHJ6HxKU+NYV/WPcALl8lonuYrqZOIROTPF12WklBLQrcane8U5aendNQr4uoLdj3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115676; c=relaxed/simple;
	bh=M62rwCb3WpopXPBEr/TcsBpZz+0Rl4/4oOOAHyk9RDw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=drOlU6HSNMdMRljYctm5/BMlkRqx2DfloXaTRgTbWuNgIRWNMd7MspuvjzA+mx1/ymlsZ0b1Ns7OLK9dL9uqZe+t38Ko0X/qN4XyrARKKGLTN2d6RyUXDvQRvGlS5fdzNONuhT0fkWCSsRLUyCHMHL5QYjEVs1seSEXUvk4K4NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rW2uJWgm; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rW2uJWgm"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88c347db574so203075539f.0
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758115673; x=1758720473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7GZOzuObGtag5EoNFyxDUa3UQRVufAOUXVJL/ng3BY=;
        b=rW2uJWgm9RkT7sU7lJ6WTwko6WKw1X0irnKRN7chSnATbsi2S1SQQ2Lq/Y0pJ4EkP+
         MWwUaIe6JYCqrT4qZsrweJPfQbEzJqGBGFinwY23VhEUDFJNfWXn/gVmqVEcTyZ4dN6Q
         aLDvg7B2uZENuEt0oZ5S+OSQ7+hqcg6MmuOXh58sVWyNVIhfGrJJ0J+vICVp4dqw72kk
         urZWwoCWL58g+qidpl4CNb873QGKs1TsOTfjNiH0yI73QWDfqk0tBqsAgRag/jGocquH
         +rjEu/Gs8hrkoz19o6mgE5ajOYCLitLhXdmj6VxU22NgkEeC9m5mubtL6DAZz474okRY
         tKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115673; x=1758720473;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7GZOzuObGtag5EoNFyxDUa3UQRVufAOUXVJL/ng3BY=;
        b=EAkk54gupbdZLaojTq8WXDU9wWRgiSuaPR1nFDv41PTVM/WASpOyEnrEk2fSD8fF20
         27ujAKlRqGvrZrpzRjov+roKts9xH/TZMdcxgCXQgFZEt+928xsFNl58wCvfAhTELDHp
         dZ7k4/tKBdIgYVQMya32GwB0GVoMeHCt26+S2ZiIghTmuyOoU1IYxnCRqTGtFZlGb60l
         E8QZkzjpBKugTs0Oh6jFeXlNnU82UZtzdYh142Yk+qA+Gkbc2m7jWQG3GYr3HtFlt9C8
         TbGjG7K6Hk6MTTCt0eoG8DsWYSUQcpj1o/GJlEUSwmQn/X+nLplMdWsX8XHN3PG2oCN6
         7Vzg==
X-Forwarded-Encrypted: i=1; AJvYcCWKaQ+/tcFYt3BzgRt/roUUXUPSAoOGDCvcDBg1eWcfeqKm3I0R182PPckyzVB0WQbdi26x/ZdDNEfpng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMckDMpk4w5SYxYo59v98gll9oMyesXfacgMZKk977kNhPq+Iv
	zf1Z3paLRyBLvqs7Pet6tFadq2wXRFW1LpOw8OGqpUi99oBkvZyeMT76dhk+Z98c0Vv0sxPIQcQ
	7So2/
X-Gm-Gg: ASbGncvgcbmPaXr2+qn3OrL+SNtfBYHEZ2N31ms8Yenmtk8TQAC65CO4FJbjstPaG0T
	Oxt+8Z5RH5y+N1S8G2qI99VlUPaGFcTNF0T1BFNDrrv/zEzusyVUiRUaY+wTA+gHKVGX8iX4IYs
	tZrgSzxVE3CpLRaSa35AlkDp9ov1webzFvee9phwuefubKCms5Ix/u27jnglYzxmUEo0hIRU1vK
	4//qsE8m19Vqh3lAb3jQi+LC1+jzfE/fpOxdyLXIvvBHcDIYjsSiOV3ze3W8miuUcgY5HI1/mZJ
	smBfkOCOfAy6WzZU3xs2+QWnv5hJMkhais7nuiTEpHA8bO8+wrYyoOlylkvhx2dd114WJr6njHn
	8+IS8DhOclTIKhyObR2ammmG5
X-Google-Smtp-Source: AGHT+IFn/OaWveSG0AWC87YfzNDHOK3c2Lkvjfj2pXX0BCsm8FFh9R1/lMuhrdFs8NTkuH8A65JvwA==
X-Received: by 2002:a05:6e02:1a6f:b0:410:cae9:a083 with SMTP id e9e14a558f8ab-4241a4b998dmr29796965ab.3.1758115673240;
        Wed, 17 Sep 2025 06:27:53 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f3062bc3sm7216527173.47.2025.09.17.06.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:27:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: yi.zhang@redhat.com, tj@kernel.org, josef@toxicpanda.com, 
 hanguangjiang@lixiang.com, liangjie@lixiang.com, yukuai3@huawei.com, 
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250917075539.62003-1-yukuai1@huaweicloud.com>
References: <20250917075539.62003-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] blk-throttle: fix throtl_data leak during disk
 release
Message-Id: <175811567232.367585.6804225420415541020.b4-ty@kernel.dk>
Date: Wed, 17 Sep 2025 07:27:52 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 17 Sep 2025 15:55:39 +0800, Yu Kuai wrote:
> Tightening the throttle activation check in blk_throtl_activated() to
> require both q->td presence and policy bit set introduced a memory leak
> during disk release:
> 
> blkg_destroy_all() clears the policy bit first during queue deactivation,
> causing subsequent blk_throtl_exit() to skip throtl_data cleanup when
> blk_throtl_activated() fails policy check.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: fix throtl_data leak during disk release
      (no commit info)

Best regards,
-- 
Jens Axboe



