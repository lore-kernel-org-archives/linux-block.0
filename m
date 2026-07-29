Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DAD280331
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292812; cv=none; b=Ktpazqfi8HyyWEFIEfk2axICgDdT1fKK9h3t9P+OQe05g0+RR4Sl+yhJsbmdOEn3c/ob2YEc+vc5U69RryS/xZX7I6xRrDvEpDl2oTKO03cJvseuSLcHLgDTpQCNFKMXzMrNtKfvXJV2Rlu+jUTJBXLvb+tEcjINv15pvQFp0ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292812; c=relaxed/simple;
	bh=W47tBJsm8KTWyFRuAQHTbl11rw7tbI1SHoCjffBQTlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHraR7szlaWKF2FcmUhJJCWp1MHwYgr3vCR0LfkqSzpPliGnU8bRaw9dkSZKGk3h1GsQXNdqUw3Ive094Ncr72My7jzW3agXWJwOLDoiuuDXKsYWrcrvMgE7f0C/kqFD5MGYKNy/u7fjRvPlmgcIRF1pNS0i+tYl1QWLpxyoshg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JlPmLHas; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JlPmLHas"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cacf197759so7754785ad.2
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 19:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785292810; x=1785897610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7okMcUbTsNOWs/LigT8sbtd8tH0zmA1XO+97WONW/5o=;
        b=JlPmLHaslERIPvqAJHcYigX1Ya8cQOqcoD5ZB5Cr0twdQ7LRXBMJydFp5Kos3JUNOZ
         59fnSo9xxFxlGDlTQcmJasKNBPY21/0XrSW3jJshcnTL31SZoT6bkE4KpUIRBxMIrFpQ
         6Fj2VttHOh+thlk6ygWaWctcftGvo+GJSl8t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785292810; x=1785897610;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7okMcUbTsNOWs/LigT8sbtd8tH0zmA1XO+97WONW/5o=;
        b=nA/9isLpRr20YD7S2feJSD5k317BHIeoR09oAHAxtnvH5XHCig8Rm3heKocz0dOL9d
         euAuky5Fc295n7kDkwDTegprpbQ9lKgk+GKbRMc7GVmD3i1ZJX26+IFw4tTk/w7nO4KX
         JYnXez+y7B/j/gijFTTnvA1qjcPdxe7zQSwltjgjSBth5ASSxZkg4Sl/95p6ZO5uBpe5
         UMKRUbivvc7xh/paGqLZ9GA7f+H6r62cSZjUeh/K/e/JYZEP+cUOEvrd3YKXtBjGejK1
         1aD7CykJ+q0i40ORkJ7kJ8qiUqOwItDStqdWDCRYz4Xl77MO7uGwZVpomqCFQb7ctDvU
         2z+g==
X-Forwarded-Encrypted: i=1; AHgh+Rqm7GIZVWgtEO4QmGJk3h5xIRVIWYcCyW0p+TGH2TpK0u3xyeVj+KUNnfZ5rXkcNEpWn/yiCA4b94GiAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoZzCkZEn3JVLL7SFGa68pzjLlvmwyVV+ECJd3+FrfnuZ8Kb1T
	8WFJ/euyRNNq5IGUZhi028X/hBceRlwABbL/uQsvMxgl6uwQdATLlqd01CGDkEphmg==
X-Gm-Gg: AR+sD10jtGpDN36KnQS5uq/25FF0oLdWH3thtSM/thHDkgcaxc5orr5zMHyZzWAL2K1
	dQ/MO2dzUAFCx8FpzREvtSJqlIWVxuqBXnURKOotw2rXrOkbeWlyAq34IJNqg5IlyuZJXItFjyD
	CIW41RHqU4mOCN/x3qgWfi9j8N3uAcyYM2aH5pdVVqsXTIcelz2gGN2kalOHsUAJQyTbJEwVLO0
	7YUXgpezEJkKs0nMQDiy+tvb6maxrADJxHy9QtwkE3qk0rr1U85IOToWpQ5+OBmzNdZNHsUyuKs
	c76g6oCuo5Abtf4K48q9tHO1kiQIifSpZmVDnwB9ON3H0Q0rdfjgt5TfAMGfOF/1i4HRckAwTiy
	QcWF+uOGa/rKvic9TuHUneqLKbpTRTLXp4+nT2T3uBAwhaXuNCIdkcpMZ6vH5mlziDpVaNonV1Q
	DUKrSfg0irZEYY51KeE8L+tv5qyeN1xNPAZiyzNQ/EdPn3wzfzVjUiFMD0NfZHIgFn610UDtugh
	tEbvocVQwm44rGXKIX6YPW/RvTk
X-Received: by 2002:a17:903:3c68:b0:2cc:ffa6:4622 with SMTP id d9443c01a7336-2d016052725mr66443795ad.41.1785292810075;
        Tue, 28 Jul 2026 19:40:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:65c1:52a3:f6d3:37dc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a7e333sm4114045ad.36.2026.07.28.19.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 19:40:09 -0700 (PDT)
Date: Wed, 29 Jul 2026 11:40:05 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v2 1/5] zram: fix early release of global cdict/ddict in
 per-CPU error path
Message-ID: <amlnQeLou0MTwGh8@google.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728092935.31139-1-haoqinhuang7@gmail.com>

On (26/07/28 17:29), Haoqin Huang wrote:
> Subject: [PATCH v2 1/5] zram: fix early release of global cdict/ddict in per-CPU error path

Let's rename it to something like
	"zram: do not release zstd params in per-CPU error path"
