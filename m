Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524381E48A
	for <linux-block@vger.kernel.org>; Thu,  7 Aug 2025 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754569833; cv=none; b=sJI7/MGcm0eNMo49D98EdDTx//mtvpDE6BwrpZNNWGRwaOlJAsIPkgfee/knB3TQbmV29mX41Gf7zXrYsHDMspVvMo2QHd87KoqNPGqCpZ0q2r6P/laTQfrFUxRgzJdQ/yZjfLyxa6EZQl5wsltbYxpJWsVk+Xv8mS+rzrfVplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754569833; c=relaxed/simple;
	bh=4DvpSd4yVqHzHkwCXz3p0CQpoTy6HFJdk6xU1V+cQ/c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qZhlLIVv0rckKDjajbjMxrAkiVxaPxos86b8NQZW0WfUzxZkiFiTtC9GuYaqaYoXqqjRPniWc3yCqPG7tZ7bWxusaSqHzPaCzDn8+WD3Y5umduhZ1IdgxlqnegyIQX9KN91kSKeelkjuATjOEGrw4pD0VdS2+JhNQSBoTWA89h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nr415/Cj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nr415/Cj"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23fd91f2f8bso6578915ad.3
        for <linux-block@vger.kernel.org>; Thu, 07 Aug 2025 05:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754569831; x=1755174631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovNXJZdNjCqbBc/USCjaRDfQSVeVkoTTcWW5YVZuA4w=;
        b=Nr415/CjjA+wLNX5sPmQKACatXYXHhmze2+qS+GL3BQBqWtD66jev3FQ6836Uerb3K
         Mm8kJq/dTTgQrosWItRd10EYFOR6v6oxy5uv/C31/aV4BBwN9xetC4Jni2pMY7ojF66d
         QmmW7ZOnJYZvbIpl1SMpfZiTfxS2Gsf8kVw8UY/fuZassHqRp8NGz+IYZ8PRT+KBddPH
         oK3VgIWbABvL7HJi//QFsbejVrH5NTtU4c6QmquUP8mLOyiPOgvvYWskkaAagwOO0Szg
         TOuoRNscY45QqOUB2E9hHTvvaXvjMmG0zTLRCXeQmi/ymmtbzK4k2DnX7jlMZ6JX3SMJ
         Gqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754569831; x=1755174631;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovNXJZdNjCqbBc/USCjaRDfQSVeVkoTTcWW5YVZuA4w=;
        b=qcwZrJ1R7x5Rrw6ayzcnWLvWMTn/f3w6KodZB0Y9IxpX1hrDG6jxRq32c8TvJpRwKj
         qcyLVirvMr38Tpv0IWxeBhmpez9RaxXS9oYiQ2ueFFAmoEBrDzq8KIr5YujWMZCaRsja
         b8DIoliUhYLBcn8EmK6PnISeei330uKe7cj0mX9I1q7emQInmeTtc+8K715Qv7PxPMF8
         EBxCfpt3JI1BDnWtBFKn5f7L42UMvgsuW3vyJWU+puoN93VJNa8S7aOBYM5aaG5+p3gt
         GNBQldSn3tnIPbaaQLJ/mXAfvbyANUhffkGhxQi5VyTVGwUvsY/GzzkOSDqkCCB9qHk1
         j0Bw==
X-Gm-Message-State: AOJu0Yz5MPA0ygX9xFACWTpJtrDMQkdyhH5QrxjWdHPbQK/4InvyPDy+
	URu3u4R5FyAjBLJfdBft9iFpyH7+lyxz5FmMPGkPv8bS5ejNShPxJnQxNRuACV1oJRE=
X-Gm-Gg: ASbGncv7jErRxDQGkUMuNsfmmgaPVHhxZaQEJqwFgRAwR+VyxXEGhhxoXXTWGJI62mX
	ZNw0tKn5Esy/wbE2tk+kwBkCftdL1QJdmZRqMWmgM9rhz9zkhHYeLkBSUn6dVqZj3gIMVecGzD9
	PahPJDXUoL+yOcRTU0csaQKYGrWH9E5bubxzT7RILFlFczBu7H1vIqAKSafHYaapg7yihY77ZzG
	8LlfcI8nWooeM/oiKuWDexqGinPXs7XamlkZ/ENjy5YUJ5XebA4yH07qVpvghDPxwbGP73ZbYi3
	r0PZjiexZ4jzRJUvXATKtFV+M0xW7aujnk/sD23EowLusEyniFyAIhA8krhCdUyleBfmC6rVohL
	Cxd1YO9wDARQ0SPI=
X-Google-Smtp-Source: AGHT+IHUR1uGhPGD/KFM4lnMJmJdwThick9UHisL5mR7cOdeMkJI+5hsCEoLqQMvzDZh6FSLvmhIWQ==
X-Received: by 2002:a17:902:f543:b0:242:5f6c:6b4c with SMTP id d9443c01a7336-2429f32c718mr89263325ad.18.1754569831498;
        Thu, 07 Aug 2025 05:30:31 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976ca5sm184428645ad.100.2025.08.07.05.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:30:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: akpm@linux-foundation.org, jack@suse.cz, bvanassche@acm.org, 
 yang.yang@vivo.com, dlemoal@kernel.org, ming.lei@redhat.com, 
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250807032413.1469456-1-yukuai1@huaweicloud.com>
References: <20250807032413.1469456-1-yukuai1@huaweicloud.com>
Subject: Re: [patch v4 0/2] lib/sbitmap: convert shallow_depth from one
 word to the whole sbitmap
Message-Id: <175456983026.306211.17359385146553083669.b4-ty@kernel.dk>
Date: Thu, 07 Aug 2025 06:30:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 07 Aug 2025 11:24:11 +0800, Yu Kuai wrote:
> Changes from v3:
>  - fix do_div() compile error in patch 1;
>  - add review tag by Bart in patch 2;
> Changes from v2:
>  - split shallow_depth to each word in patch 1, suggested by Jan;
>  - add review tag by Jan in patch 2
> Changes from v1:
>  - fix some wording in patch 2
>  - add review tag by Damien in patch 2
> 
> [...]

Applied, thanks!

[1/2] lib/sbitmap: convert shallow_depth from one word to the whole sbitmap
      commit: 42e6c6ce03fd3e41e39a0f93f9b1a1d9fa664338
[2/2] lib/sbitmap: make sbitmap_get_shallow() internal
      commit: 45fa9f97e65231a9fd4f9429489cb74c10ccd0fd

Best regards,
-- 
Jens Axboe



