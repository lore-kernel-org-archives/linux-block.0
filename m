Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFEB36B07C
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870263; cv=none; b=asTMZOCfnr7mnmvdES9JIFeCMV379wZHfIngPwKy1atmn2PT4pak2XhRpIA8yS1WXJWeSUAwpBryNqdvs1tVLWKlJvEtnqCOnWv2ETuTStD1rS3fzpDJVR71UrxcftZJyNNpx5lwkYXwOrevxU/mtISxvupC3f8r8dhljLMRCNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870263; c=relaxed/simple;
	bh=cnmLRwqhZ7jPzODlxI+gjG7xRflVr6cVqDj4bUvfKFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VL3Tvb1p3JPcqtvGRqWQbO82weh5L5Ui67nTrnUhpP145aXt3awWRzGNoV09LqVMnAUMy78+03s842L6cc+jqCyZ5Wt82b3BujSyBx+ZRea7kSylWQOjG4kF/XIGUtTBnIqm36klgrl9GQt8dh1suYj/oSdlXGLCRW3dZEM/yHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QIDNIoUB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QIDNIoUB"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cad4170e8eso812845ad.3
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 22:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784870262; x=1785475062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ntnajWJ6p85rD0cr4ir+e1iCPNlwNbliu2B8JzUfLjc=;
        b=QIDNIoUBhZUfjOGKxiXr1n/BIxRMPQ3IcSRWnRfGeONmjOnahDFBmUim3V3WbDw0c+
         gmq1PvY9+S0RDP/JPmRXsgXvoK00/po+ec6AZNWdo4C/fbtH+09eWrvKFuceBnWDg+NU
         fWP2m6KvZFD6lnAfRz+QAK5BzgPLsDysuJSCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784870262; x=1785475062;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ntnajWJ6p85rD0cr4ir+e1iCPNlwNbliu2B8JzUfLjc=;
        b=lVF3OuTvpD93W/T8n9LikUg6yWsU5TxLdvL+fGqNRK27bUJRh+SGQOJtk6jUaFVDIZ
         7IZmcGdvD+UXQms1YsKWhVcsink7zMpEYcZej3y3NAi7JjQubePvGhaMkOBXKYwRMsF1
         aLHD23wgAHdFXA9PCZJDc44JpYP8RraSarK/b694w4ShxRG6g1F6ZPc6xAIkT54QtNHT
         PCFWZZollLxctruSBD0bU5ecL+g4E3GaTqtfAwKhShWgjbX4a3ocIfbwkEkQDNasFI5K
         M0c4jMtN0mE+Oqj2nMl0yeX9tQMNMaa/1vbnjemhJkK3Erb/pjjkJxVMjGBqKmxXN7Wb
         yb9A==
X-Forwarded-Encrypted: i=1; AHgh+RqnhJ+TmCd70ABBQuKMx5DnC9g0Lws69IKl8fgScxUE64teymyUEtoj1f+eqHJwy+GsfaZg5MLWgV5dqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+YYOo22970wRWmThma06u6j4cRKzyM6Fe0xxO7YPwgpTnNQl
	e+F7O6GObtPCyuXriCFa5/8PeIeAw+zR39DThQViMSftWq1AJ/nX/9OincAyFBrTdA==
X-Gm-Gg: AR+sD12ZiuqXuxcvaNWH8BSKzlu45fmPCA5CcyI7O44JqU3lahxNJDc5J9wUMxZqr4C
	1raST1I1u3g6Z9AivoPQD8qX5SwhBNozWy6zZBRTUt33YChqOVjXxoa2f2pvbvaj2cvShuZStvc
	kfrJiSlSG4U7QpOOHM5TS3kThA6iominSUOZMyDNQ6xYXVgFQLGDvWJToNgaFAVrKFwilDAl3Cm
	GGjFZn55zKJADtGhg4hj9uniGtj0uz2NGfcFeYsqtu3YsjoHHo2n5rSI6Hfql025CazYjylNZlQ
	YhT9p+bNclMKeVwGgs8k/h0T7NWbLgHU8jCEqektVhdYVyP20rNY2hKNv3Z/IvuOhlCyGuO/ett
	MmRqaqE5ExMjmnZC/3hYA2Wq8cMpUOUBcgxDs3icO2vL0QEprqE/M1diqNLBjs7TCwjaEYEeOpa
	2UXcW7LcAlUAdWRN5ka0OSRSrwyzj/zqncRZJW8KigHw==
X-Received: by 2002:a17:903:1250:b0:2c8:25c8:85a6 with SMTP id d9443c01a7336-2cfa6a43936mr74219335ad.2.1784870261655;
        Thu, 23 Jul 2026 22:17:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:c102:f12d:5168:6be5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f00a6f5sm45045945ad.37.2026.07.23.22.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 22:17:41 -0700 (PDT)
Date: Fri, 24 Jul 2026 14:17:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	terrelln@fb.com, dsterba@suse.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, rongwei.wrw@gmail.com, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH 1/3] zram: fix zstd dict use-after-free on per-CPU error
 path
Message-ID: <amL0Mb8NN4DhPgKm@google.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627070216.13511-1-haoqinhuang7@gmail.com>

On (26/06/27 15:02), Haoqin Huang wrote:
> zstd_setup_params() creates global cdict and ddict stored in
> params->drv_data, shared across all per-CPU contexts. When a
> per-CPU zstd_create() failed, its error path called
> zstd_release_params() which freed those shared objects while
> other per-CPU contexts might already hold references to them.

zstd_release_params() sets ->drv_data to NULL so we can free params
only once.  In addition, "while other per-CPU contexts might
already hold references to them" -- other CPUs cannot do anything
with those params, the device is not setup and we cannot handle any
IO requests, right?  There is no double-free nor UAF there as far
as I can tell.

> Remove the premature zstd_release_params() from the per-CPU
> error path, the global cdict/ddict are properly released later
> by zstd_release_params(), called from zcomp_init()'s cleanup
> or from zcomp_destroy().
> 
> Fixes: 6a559ecd6e7e ("zram: add dictionary support to zstd backend")

What exactly does this fix?
