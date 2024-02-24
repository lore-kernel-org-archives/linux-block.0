Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C7481A5
	for <linux-block@vger.kernel.org>; Sat, 24 Feb 2024 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708805803; cv=none; b=NsUZyV4jNEmV/TfkyHdU6+9SLpU70p8M7XEmIzalAFl9J/YElKFrZmvbnqAhsFDOA9aWGrVF1p7pvKFZKoWUU8jb3vN0VPAwRSe/uLNAl9D0HF/d6CbEOC0Tulutk6x1Q4hNhkpmDeriVlYGR5Kn9VtIOMWNVC0KHEnR/sFVCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708805803; c=relaxed/simple;
	bh=58rI6Lh5A3zmVIcZXAoo36bnf+BziOp//zU0TJUV+lo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UnIbHbCcYxGtnYHBEmGBAppI9yFT+hMRrnRNRjIBlmzLUE/eu2yn8GJCHkZyQ6B0GmehhWi3JaCCZTYz3u78msG96fxterk75zQNZpbXg89p/fJymP7JZYAAcLZMqIFEzfKNF3tSCShTxiEDuklJrYACs2Ov78PJOUF60fjN9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xFrxbTiv; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xFrxbTiv"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so810294a12.0
        for <linux-block@vger.kernel.org>; Sat, 24 Feb 2024 12:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708805800; x=1709410600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox3kbDdE+VVlFfRSV4KRbxjd8Vtf638HvV83l5cQ8zw=;
        b=xFrxbTivycoPaFT57zcw1LA+QUnoPtUv24FCLXEbGcJsEjK5mm3uh7wFZ9ZdchyYav
         Aai2J+HrSGvM9bvupIJEQ4xR/e9B9kYQfA9dInE0wx1/VUeDEqZfiXXVQzu0N41wAONh
         EudoanuqZo0759HiKiL4R6i9b6a9qo4NPybPKkC2qLA/+72acRN2OP9MCKSvFoZohjle
         DlunLEZCALes3dbFaDzfxo0imo5szoI+g9lZaFdi9sRWKCY8edBhrtGF79ez8PvgI0Bi
         MCVnDZb9p0fFxix5LOzmiIWeYssGQGHMw0bBm/evEFLGNmG/lk75OVUJTo2Gt9hMN0BY
         GH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708805800; x=1709410600;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox3kbDdE+VVlFfRSV4KRbxjd8Vtf638HvV83l5cQ8zw=;
        b=DhHiNvpy+DK5ZTIZKFFAkQBe5Ido3XD0knlydmrtsi1MPE+/gv/Ip0um2AhAoRnOFN
         evLsyN7UI3ZUWq9sqEazaSAXhzyyoNOg3wtOQ3a9JoExOnv9P/DqoInPL4gfOnCkL5rD
         3RzPLwldr6DYzeQ7+QXRQ62+lY8llTsQfH9PiXsCzz15UmpAeENEG9hmuWLwQNa5+tkz
         4DvZNEHZQvIpfI7w41W/xlRTmik38j+/RIWmNwjqo7C0+Q5XYtHV92G8Sjow/jiOYv4R
         azVGiOArFpsADTJpnAcAR5TQdSXX32Vh1Lj2OWMtYWkWy8MFHkzevP8L2+6d8t0VBJtO
         PgLw==
X-Gm-Message-State: AOJu0YzO+DdGlh0OSerReTtLxcd1F8RPoILpDOA9oNW6F2liNtQ3ZZpI
	+PV71T8iiyowPVzdAQ/f/mxqP4PCWnOTjpnJilRVztzihoHo9LOPA0/1Z4u0/NN8eWkB+M+XQqs
	Z
X-Google-Smtp-Source: AGHT+IHAqqPQV7N8XB40psZopiUBgLNcHzyDcaUPaIezq1Iy+VTdgSYeS2XJGE1v3VAia/J5jEvp2w==
X-Received: by 2002:a17:90a:5e08:b0:299:6b94:4165 with SMTP id w8-20020a17090a5e0800b002996b944165mr2478612pjf.3.1708805800372;
        Sat, 24 Feb 2024 12:16:40 -0800 (PST)
Received: from [127.0.0.1] ([2600:380:7472:2249:6d10:d981:9c6f:5d24])
        by smtp.gmail.com with ESMTPSA id n15-20020a17090ade8f00b002995e9aca72sm1598967pjv.29.2024.02.24.12.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 12:16:39 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: chengming.zhou@linux.dev
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, vbabka@suse.cz, roman.gushchin@linux.dev, 
 Xiongwei.Song@windriver.com, Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240224134646.829105-1-chengming.zhou@linux.dev>
References: <20240224134646.829105-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH] bdev: remove SLAB_MEM_SPREAD flag usage
Message-Id: <170880579918.88310.13620256646819841520.b4-ty@kernel.dk>
Date: Sat, 24 Feb 2024 13:16:39 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sat, 24 Feb 2024 13:46:46 +0000, chengming.zhou@linux.dev wrote:
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> 

Applied, thanks!

[1/1] bdev: remove SLAB_MEM_SPREAD flag usage
      commit: 82c6515d8a970f471eeb8a5ceeaa04c3e5e1b45c

Best regards,
-- 
Jens Axboe



