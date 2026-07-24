Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1F736F905
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784863882; cv=none; b=CBXs7qvxzEslN6AExrpciZO2+WUpjWEaj1TgJRq9pB32X47eq16gFRW9dEiY12Qry+isKkYmtAZR2ZvY4uxiQbNW8asSQSeySYlAWOAgKUv/AcuUFYTeBpIx9ehcphz7RwOk+XbxqbQyTWf6ngDbF6GQKpiME3eZhb8MHg0p81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784863882; c=relaxed/simple;
	bh=TL+k6fgFuceMeoCCkLnBe84J5DcfmOGs9dlGjrg9wvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+9HISBdK9W1kbG2FzgvUppzD5YkXrwzphLc1A4+yS8T6pWWZVaA4+NGbBGYAOcAPiVX56dfxS3XAd5l1WKyYOXnFDLJMGiIbPACkPknaYoSN+vetyfofGilLEihJPwdplVsmK8jV4q6dYFCNNQhBo/yApl1jUfhT51Nhi8adFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gBEjKEOI; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gBEjKEOI"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso4086a12.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 20:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784863880; x=1785468680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bYxXZo7D4pD82e+g4mcEFIIpBXSWHuVTRzeFebMt6IM=;
        b=gBEjKEOIJep34rQ9UcMaFuXf+h8u2gqeDib2lpqotWhYXrLDn+mRoLILtkBlqqoeXv
         q65vlSriQLWKehBfLKKrsCf5oPXYsjZDOmE6+CuSNboHqhnoOguIpSp8Pyj7o4kXTvNs
         TYPoCmYHFJAmbsQKuMpurVbx+H0SPfLaowVsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784863880; x=1785468680;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYxXZo7D4pD82e+g4mcEFIIpBXSWHuVTRzeFebMt6IM=;
        b=BJm5KMYcW4J4IRqmfwEISgD0Xhc0mqH3Dz0R7Lr2/ucFRs/vSVcWkCHtdQ/SfI0/h7
         sK42ElZlScyFwgg5rvYtGil2Fpi9s/yUMVdcuUt2y9CttVhslxTs82dmQTNxCeHqYqha
         nX4HbTEe/hxZb9VMgQQT/i6UjprfeCyZjXH2HhWuVqAXFJzUFHz/1aAjtsnsJxStsGOk
         58Ss3tsoZEqB2fRHEDoJj4A+4/S1ygYYhuJUQudTb0XTwRoCeH2yCt4lPGYWPkWqx9TX
         ZeOBtGzIBbHrCeQrE9Ojf5bn6Qwdp3hI6Qd2A4qIMxHaFdQSR3jkBoVmMqt8MwAMhtwe
         TQhw==
X-Forwarded-Encrypted: i=1; AHgh+RrX1SLa4Wmrm0QPzEn1jPgLBK/bUY1CXQwYKbVxn9rx63RXWHb1lCo1l8mlNPFfxsz+UXYZRwi+USyc4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsySF+io3agF3Sy+esTySHivULg7bkKMZmxy+nLtvdI2wavdVH
	Sj2wXvZXrt4ztBXpxYk3McRaJQD3tlhqHHRH/j4wT1BCdyQwj8vKqADgCTGKJpm76Q==
X-Gm-Gg: AR+sD11kqbC4eO4MV1qUT0oWQdzANdAmVvW03XgOgPMElXAsArYkZ1A4zuxO/WSziNh
	rhLefS+yCCaYUGyiL9+zVeO1oQoQMM6yqJSEL+M8ectt4suhhsENXvShXT8PNr922aiyUS2N2Xx
	iyVNtNmWz6mxrpWBH5Su1sGfbgBrJYVczCxmjlm7JU1/8tccN0zi97yrSRTtAaPi1RnAALnx1F1
	2hYA8Bgax2BonrcIcB2a3jzlFKiotJkIewceKl6K6yf7Ny36kU7yfErAigHg+I7KK462gjxWfpB
	PhQZ1iw7ZVraOFowkj8VuOVY75d3jYtX3HrB37wBLbcfwf0g273va1hL9JovbNIfFJ38TVoAy0c
	FWbqHMLgfEs20eETDcQkHYevcsLmK1FoK5vclNfjQoGq+I5mmS1nHuWVGTcpN9d+8NW9rHOkvAm
	8F+56kYkHlZ7b49B+YQUy8Hr9Rwb6O7beHjzJWaas4LvWJJWvly/DB
X-Received: by 2002:a17:903:24c:b0:2c9:aae1:a61a with SMTP id d9443c01a7336-2cfa71dc76emr72514665ad.14.1784863880123;
        Thu, 23 Jul 2026 20:31:20 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:c102:f12d:5168:6be5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd88f7sm43696025ad.22.2026.07.23.20.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 20:31:19 -0700 (PDT)
Date: Fri, 24 Jul 2026 12:31:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] zram: lockmap tweaks
Message-ID: <amLbxpYGMbqMI3fU@google.com>
References: <20260714141300.3945672-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714141300.3945672-1-bigeasy@linutronix.de>

On (26/07/14 16:12), Sebastian Andrzej Siewior wrote:
> Sergey, this should be a follow up on 
> 	https://lore.kernel.org/all/akza1qtgHm7zbjMW@google.com/
> 
> Could you try if this does what I claimed it does?
> 
> Sebastian Andrzej Siewior (2):
>   zram: Move lockmap to be per-zram instead per table
>   zram: Use a custom key for each zram object.

Seems that Sebastian is out-of-office (until Aug 13).

Andrew, can you please pick up these patches?  Patch 2 has a minor
commit message "issue" - missing word "swap".  As for unique name
for lockdep map comment - I will send a followup patch once this
series is in your tree.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
