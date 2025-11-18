Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654222F7AAF
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763449240; cv=none; b=rrgQg7HtKF7ALL0f+vI55wE6gUB/gseDmPaFIoPUwbPlvYsvIskw4SmdRZ1qHyon+LBGN8GcOJsYirtTnZd89WYOeBfJVn/XCfgrbFvgrhehFA2Hf8rkpGn7XKMxS8TqB/yhbJU/7X+J6jfQx+0kzlSgHREVCH9s2zGwnLM1rIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763449240; c=relaxed/simple;
	bh=vgkyYqpeCoM4Jm/jLy4SLp/Z+mnc5up0isEwH+q7mVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+mJrgbszdizeb1kwk96YVtLrrBZQQXcAakFGiLWwrmcGItJXzUVNvv4Kdp5nXfxCw4VVXwvzMiNA5k4KVOGPIPn6rj+H3+nuzGtJAH+dr3oCzebmwOKfcXuV6e0d576/1ZhxT8+WMcaW0mPiO80VuzgDkPpFdYR0uB32jRMlb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hn+GgvdT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hn+GgvdT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2957850c63bso53184105ad.0
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 23:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763449239; x=1764054039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RmTt4bdcSxqSZRCTcBCbSzCGqQ66VU3Pz/goFqi2reY=;
        b=Hn+GgvdTk5wyjGV0frA1rFFpzt2QAnBOQWDFvW+gxs9hAZ7b2P+3l35qtyVLUtk8It
         RAxczaAMlrn3bYtabodtFwBBJb1XWvqKrDFJnitb7cvtuaNun11lZGGCkOjzj8Cml6m6
         JvLVv/vKDiMdgZrhfutR90YrCu/8tYF/bMT/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763449239; x=1764054039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmTt4bdcSxqSZRCTcBCbSzCGqQ66VU3Pz/goFqi2reY=;
        b=r/G3CQ1ZRtLNHhfunM4AH9J1Na7xbXCN4CtdDQpSPjvtmVT0YjCDvR0zs77mxk/wjP
         hOuMpH3sNOWiwXlO6A9KaT8jw63BNxMx47aLtIlSPAGqY0bW5dQXIdiiJ5VBb6s8eJr8
         VUqOqojiOY3UyXYWy93oO9Vw2TTuDB4IIUJHl3ry2pdJEO8WIHHbWYuofUYGmGGi8lBR
         nOGA8q3mzmbxaHG4a8bkqIDbQDPImUSj++RcmBFoakJPF3EeraGju9BkS3KybIA+n66d
         p4sy66J8rAQaxgAYo8UfWq+N9Pv3H3gMhwNklByMAFUwgCEmx3kKIiavinZV3fbW9bWH
         nSGw==
X-Forwarded-Encrypted: i=1; AJvYcCWuqzAo2sZ5mH6hCo9RRerTjtQSXSpa9fg/LSz+XMqHmWocc/KTQiHNE56uiEO1/haHEthUrUKU36rszQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTdZb0HxeZYu00fG1ayhN5dzNdVBbFR3BkosC8HlWFEXeYnhJD
	XdX3+UOd2hObArwpuQQz0czmJGkuCI3rHxltTSU7V4av3IHf7wtHBuQDUpLbKUoABQ==
X-Gm-Gg: ASbGncs+AE6c8oIJJLZvDEf/TiMI9rIF+eBWn19GPZAhlGgJQNTDXnttw+Qi8NlgLer
	Swz+DWa6S2XbdtTnC/FhFEmtGl5IYcydtrYDQbfYNRG7vr4v/Pp85WYR61hjldtY+RZbf2g5MnC
	ljNoxYH25KYZSJxrsCE9nG2jXq4qAEAPJJ8GakPKlquy6v0QEa4nTHIONKlTzla2d6KVsJLHywK
	/2JTsZYAz3rZ3VfqfYqVrUKnNNmk2YX67U+lWB9xF5SQHjnv8mM30SiNrv72w3orw5vV/iTZ+Kj
	94KxFHXqf5+z7SM3dvMHwtjDMKMUgnPu1ktBavomTKVReJMkDxkYklAKgOp7ZkLvtvbY5HN+VFf
	XyPIt8mE2WbWoHNl1grejE9WU3YXN/03CnEO1ejIIA26ax7nUV6Ms/s3U415uY8fVhBTpOVNKUI
	XZ6pyj
X-Google-Smtp-Source: AGHT+IF3GB3OuQkSGJQgjd6ndP7i9bypEbEprGds7oNMXJqRWrwJRSq9m+dsDKDeLD7REP6viKq7kw==
X-Received: by 2002:a17:903:3b88:b0:297:df84:bd18 with SMTP id d9443c01a7336-299f55b8153mr28585875ad.30.1763449238472;
        Mon, 17 Nov 2025 23:00:38 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:beba:22fc:d89b:ce14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c24941csm161791945ad.41.2025.11.17.23.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:00:37 -0800 (PST)
Date: Tue, 18 Nov 2025 16:00:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Yuwen Chen <ywen.chen@foxmail.com>, 
	Richard Chang <richardycc@google.com>, Brian Geffon <bgeffon@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, Minchan Kim <minchan@google.com>
Subject: Re: [PATCHv3 1/4] zram: introduce writeback bio batching support
Message-ID: <hbtjgtrba2elesgfxva63y6g2s3ycnwv5yhxlwknrfpulmljte@ghz2eudf3i7r>
References: <20251115023447.495417-1-senozhatsky@chromium.org>
 <20251115023447.495417-2-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115023447.495417-2-senozhatsky@chromium.org>

On (25/11/15 11:34), Sergey Senozhatsky wrote:
[..]
> +static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
> +{
> +	u32 index;
> +	int err;
> +
> +	index = req->pps->index;
> +	release_pp_slot(zram, req->pps);
> +	req->pps = NULL;

It's too early to release the pp_slot here.  Will fix in v4.
