Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF18A16F277
	for <linux-block@vger.kernel.org>; Thu,  9 May 2024 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269518; cv=none; b=mW8vGI2VY04mdTzfF8MA3G0J1ZVCc6JnhNLILFGz77jvPqhUmnuyGF/Fnnth5s0SgrYx8z5Z2N2mIIIf9HhsnMw/+9+TKoCSgD34JI6OsOjupdF2Osf24drrWkzK4gCMznSwCSyQnQSFbNw1tW9u5OqDiVI/eiCZ6IAG8qpq8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269518; c=relaxed/simple;
	bh=DZNYdSr3PQT2Ytv6yKADnFDz0/6OYvMONIsLOfnnwGs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OhzQk4Q9ivqImV7nXamTIvL+7MXNnIyJUHK5Ft4cuKx34BWpnOxqQtdMvMHlwY5rKFrF17Y6rgpZXEOFLE+Yjb7Sj/Qud5YQhdZS04D5tWBjuVKUOHtWLdbtHtb1rYKWvFCCPBaDKhm56zFN8/ThonKclNl0JFpdD/BEeHrj3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=voXvVGm9; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="voXvVGm9"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d9d591e660so3357839f.2
        for <linux-block@vger.kernel.org>; Thu, 09 May 2024 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715269516; x=1715874316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gUCh8FY7gsl2h4E/kN2GFyVm9t1B96kSbiEPvae8u0=;
        b=voXvVGm9DxyhKNpswr3aTjHPpm7BA4skpcAlucDP/KtSdxGEdDPyL3Qcp56FU6CmBm
         XZZxBgORT6zm9Pw/DtGJrbf/4Q3rk1oJ52ZqJD83ILZF1C96Dsp0WOjOhUy8pDXbIzlu
         +y+9Ctw8VFDJLF8w4u0Tgbg+FW9qHIgGEB4HnxlIxP9LTiqs8MCCSz3unRnqYSsnznLA
         LURo9WWxwoaUb5QHSV+x5quV0diNqOIxmFrWBq3oLJm4Z//vdHfqY0jDuT0MUwuThWFp
         DOSgfAu1TFLNX7knZayA5ADJSEf02dBObEMJ0pHAZ+CjHPQeWAU9S6vXWkiote5Ul5+B
         AHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715269516; x=1715874316;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gUCh8FY7gsl2h4E/kN2GFyVm9t1B96kSbiEPvae8u0=;
        b=Em2GAi6ScEtGOsJKubhr3YrWBvO+NF+Q4fqQ0VJvC9k0NXFDLvG0bZSiTFWHYTv/QN
         Zzwq1vsQT5NqJk+cOUDYdYyB8fG28atjIc2SKQcGAraSOuoZ4DrVTba3qMg37LK97iax
         hzhDc2rSHco5qLnScn33iz/kk+y8Lar2ZvTtLiGnACLq6QIdjJoPTIDvwKbEj8VOZsi7
         zQPKq6PSoMEIWv+Uxkzx6quF7MS18lFBGTvI2hicFnW0Z/xQTPEf6Ptaj8Vep1pqhADV
         OxrHgZaSDrJTHZjnoXjdxDBOQRHHfAWn9ryiOtOaQhBxWkOcjOhoOS1eXtMp6XIG0x3D
         +LEQ==
X-Gm-Message-State: AOJu0Ywst1CCsm+Zy3JMdCsn69TajhZ/cqBlYBBtq1iw2jtB5bFY4T2w
	jzLsl5DOkxagUL/M6T8iPY6XFjLdafVETa3OLUjvoub96+Ir1I6u2gsjlXAYyOw=
X-Google-Smtp-Source: AGHT+IEonISz5k6S+QhuL+vpC60UupW6zWwKsP/6j7LitGl0JXGDRiQ702VSRrcsV4zjn3bncreQ3Q==
X-Received: by 2002:a6b:d101:0:b0:7e1:86e1:cd46 with SMTP id ca18e2360f4ac-7e1b520b2f8mr8525739f.2.1715269514443;
        Thu, 09 May 2024 08:45:14 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376de473sm416106173.154.2024.05.09.08.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 08:45:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: chenhuacai@kernel.org, tj@kernel.org, josef@toxicpanda.com, 
 victor@mojatatu.com, raven@themaw.net, yukuai3@huawei.com, 
 twoerner@gmail.com, zhaotianrui@loongson.cn, svenjoac@gmx.de, 
 jhs@mojatatu.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, cgroups@vger.kernel.org, yi.zhang@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20240509121107.3195568-1-yukuai1@huaweicloud.com>
References: <20240509121107.3195568-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH for-6.10/block 0/2] blk-throtl: delete throtl low and
 lay initialization
Message-Id: <171526951316.85538.15766009475504777468.b4-ty@kernel.dk>
Date: Thu, 09 May 2024 09:45:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 09 May 2024 20:11:05 +0800, Yu Kuai wrote:
> Tested with the new blktests:
> 
> https://lore.kernel.org/all/20240420084505.3624763-1-yukuai1@huaweicloud.com/
> 
> Changes from RFC:
>  - remove patches to support build blk-throtl as module;
>  - add ack tag for patch 1, also rebase on the top of for-6.10/block;
>  - some small changes for patch 2;
> 
> [...]

Applied, thanks!

[1/2] blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW
      commit: bf20ab538c81bb32edab86f503fc0c55d8243bbc
[2/2] blk-throttle: delay initialization until configuration
      commit: a3166c51702bb00b8f8b84022090cbab8f37be1a

Best regards,
-- 
Jens Axboe



