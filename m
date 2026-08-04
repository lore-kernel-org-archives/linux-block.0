Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E00A32C957
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 05:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785821531; cv=none; b=YeRn+gmhcYdkx5wM6qn7uI8zkYUMA6n4V8+Vziv5MmK2L7irzcfdgv9c4946j3mo8ccf5YwcKTC8AEq6uR1sMch4HPJGW/wP0cN38FhqyVj7Umf+uQFCWG2V7KrWN/M7d7TqoY9kVHAMBsHoE6P47SNG+PQN/48F5/b6x7gGoPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785821531; c=relaxed/simple;
	bh=IAA8nFUZpC/UPplaX0lplMjH/PVZvv2wQ41dchLY7OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBID4mADk9VWFAHyFQJhP5RrDUPQYWZnXCvT2pcipfGdQh9/lvDnsh7m0/w+407n9liD4vOIPJo6UOiTvBt1ltKH3aRq/BJWU069XqCoPFWDjcSyMbJ6E6YuLuXursjWl0fxoJA3DenRpShzD08F9uEM/Z8XHbXra0VtkidMitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WNEYCCst; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WNEYCCst"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2caf228a910so30828585ad.2
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 22:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785821530; x=1786426330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+B3M0tFqnJnc29FP5kYp7HH8DS15buEwgObTWQDsxOU=;
        b=WNEYCCstOc6FR/4rzM5giabmLGkghOcM3gEw+PneE1r2m0g9eHFH+KBjBcp3iGkJN2
         62krzBuhI4ffpyqkDAVwPeedacXFLZ99jpQTVdBaqgSE7AuHg6zGpH7qLVRKC/TiLkT1
         1YtOTipG26gxOxteSiMyPo2MB3C379iGKsNLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785821530; x=1786426330;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+B3M0tFqnJnc29FP5kYp7HH8DS15buEwgObTWQDsxOU=;
        b=hro/ut1TIy1GtZr/a5WJ3YBTRCaQpaWIT0OZ7dVqUNwlNTZY3Ndg/DXni6uL0UTqwA
         D3gcXkCLbOK4yxJ73sCAckdf+iahkEl/VzUCy4omm6za041oX/QJcIrtC3U/zn5qOYXo
         KH3vEpnWpNgmmhrNTTBSQGq5KObI7FdLDiab6aVlQDhbJV2fGX3lrdBi90dzWm753nFp
         5yFKoiQLjV4frrxR9wn7oH30p8lGk2qGvwE4+U9FYDFl+zuPb1lnypMSURVQkwGe3/xV
         1h99e88KwjyMPQqebAcCDSHMx3UbzYjkyYOhSZ48NBMVUkwJrwz9zVDB3WX1w9DDBAiW
         z3UQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpt9onzV/3rrYghzCYW514dVwE0oxA2HfeussmjiP7deyPGdtg7Iw9ZajJ7JlnuVfaROk2DuGiVONPbSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yypc0mqb8TA/HH4Rwtc5HQzGi4phOxZESs9KxfaxNH6USvNLIlf
	ZRN7WgxRI9sVdQVXPi6LM/GyXcwlFNgGqHBKIYuhQuW9EIEpdqMcLinhXpuEtCRNrWhNd+ZvHIg
	VynA=
X-Gm-Gg: AR+sD12MFy6Uo7RIeQ0/1Ow0W9WJReKtF0QCmarR9JT0FlGhfcqz8mlg63zb2D85Ms4
	sPZvfp/W5xOgXN+h2cH7iKxEgfU6UhS98mbh4xgaMEMrg8hA+Am3IACEVbZiWJnY4VqYuGP95Kn
	+Ol2gRC7ZqKCf+nY11yDrBaXrel0/le6MRFIqVbVhJvVGONDEDU8e22k5luHZpYhsHex5v6rQjC
	13vre4jgncKz91yxaUBvLb69i7uOU8j0wQa8VEPRItFgc+NOjDUiibkm2ZPxKjMqkbVDPq1dPQH
	WrUjD9DQW/tHHn7q3mf5A7holT6TXYCaYgb1vepqBwgSbTZf8p/wBPaUur2ByD3cDK7qKCXtF4L
	qS9gyVVSJYJ04XheUjNS0KX91oWMdCXhUtQew1AlvTuFcFuTZpxanhg2/Q/B6qIgmLM2aSs3hwD
	oPiyHRsitxeY9vio/SbASYbwFexItXr/f7IhQClis9RG7FvUnO/kejawwuBmm3N0EJ4sIrnHOv4
	hcKyfWTv0VU/Qy479WkkJb5ryze
X-Received: by 2002:a17:902:d98b:b0:2ca:20b1:3e0a with SMTP id d9443c01a7336-2d05219bb8fmr144584255ad.3.1785821529951;
        Mon, 03 Aug 2026 22:32:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fcb5:533d:198b:8d48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5ea02sm46456715ad.28.2026.08.03.22.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:32:09 -0700 (PDT)
Date: Tue, 4 Aug 2026 14:32:04 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v5 2/4] zram: reject zero-size dictionary
Message-ID: <anF4sw4jTDu5xUd9@google.com>
References: <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260803141256.60599-1-haoqinhuang7@gmail.com>
 <20260803141256.60599-3-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803141256.60599-3-haoqinhuang7@gmail.com>

On (26/08/03 22:12), Haoqin Huang wrote:
[..]
> @@ -1700,8 +1700,12 @@ static int comp_params_store(struct zram *zram, u32 prio, s32 level,
>  						INT_MAX,
>  						NULL,
>  						READING_POLICY);
> -		if (sz < 0)
> +		if (sz <= 0) {
> +			pr_err("failed to load dictionary %s (err=%zd)\n",
> +			       dict_path, sz);

So for empty file this will read

	"failed to load dictionary foo-bar (err=0)"

which might be confusing.  I wonder if we want to separate these two:

	if (sz < 0) {
		pr_err("failed to load dictionary %s (err=%zd)\n",
		       dict_path, sz);
		return sz;
	}
	if (sz == 0) {
		pr_err("failed to load dictionary %s (empty file)\n",
		       dict_path);
		return -EINVAL;
	}
