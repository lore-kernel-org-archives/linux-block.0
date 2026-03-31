Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A1A3CB2E0
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943037; cv=none; b=dgoNCC+jyTJLybW67JcZSXbxuVsYIIjwsnqvCkimAAMW6DTbc4PdKIf/sDibb5cRei9FqRKiExMS+7W3wVjnf0pWf6bzgZDfK4O5U3NcRCsDbwoIanssEsn8GyKgnVvZSxnYS/CHWM9JZ62TFsv0eEqAd1v05wrtxlT1jVAHpGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943037; c=relaxed/simple;
	bh=jFQvsevcayVXYtl/sFWG+TqQGSEexePIUgVtPFfw8vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+qZ8pHgF12gWvQ3OJbLkXM04PDuBK5h7N0sp8TTB2xOt0ZwcvML5034uj/sEYbkU9bJlgepIJ3CVeCUAvrXeOAXJoc+ZyxJOX6MLqjhvFoXT+30s2s/i5U3GCNnQVX2EbEiHutXyy/Uxc1/vYM3bjKCNAvDo0Amx5Y/SPAmGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h08oMQGr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h08oMQGr"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so762156a91.0
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 00:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774943036; x=1775547836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/HPNsO0wO1Iku537jEWkDij///y2pRJHFFd2ZBoCiuU=;
        b=h08oMQGr72Tf3ofm61fj2EHbV3KemWD8mD8g7kI4+pg8pVhlHHt6BI2t677jA47xDF
         XWBrrjgaMV7jAFJIMe0mDqNG4VTeMwgc2v6Mzdvq+o1R2yf7kwvcFK9tLhH2HpGOVCIi
         mmNUQ5u+9fvhTPmfGc8mrb98Eaa/3r47zNU/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774943036; x=1775547836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HPNsO0wO1Iku537jEWkDij///y2pRJHFFd2ZBoCiuU=;
        b=Dazj1eRSFyBEtV0D2NIoP8Oar3rCwYiTKbSY7K4S/J7WlDmFz9v9z0o5/TBiUQMOtC
         wjtI48bPXdbpCSBYq/WHsZt4Qf4l6fFgifFbqtd9WIgHHrWR/NzpGH9oPUlXBKFvnzjS
         N1aRzJw3jO+rCGfdFnabYUPMZlEBtg4r2ribRnWJ2mlbHm6pyg7a8AshjX+6dIOnZE8r
         67anSNaYOZjtJ0BYEbuMIeuZtvOWYeDbYKM2wAoVlhtahnazshNXHRxClhWJ1RaEVSg+
         er2bIIdpKo/XkoqnDmTgsG/k6d8nszS2fpLwMhGelJKt4PccsMgNWkQSV5iICl3nBKix
         Rp+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUe6cjGsn1RKTTD8GHmFG20s5A3Eux1r5b2604wZvAuVTBxz0vyUBfX5cXU/flOLv8FcNuaVWezbBfIxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Irag/dhTsNEvYUP1EwGyIivhxPWvyGZKxS9SlijEs3qbJOfl
	U48RFCm4uXfSDTeVZ7nzCikNCECXrHfRFpUFnY1iGKvMxakkgDRwOl00FssmOrwdMA==
X-Gm-Gg: ATEYQzzxBsiOXUE3OAWcu5Qm1zOBNXXGWgLPlXq/vV2xDgDdAHkMm3LrAXOHNKN+tzq
	7nO2/33KDkzhHBfIOJWCPdCGVUdFiXg50uLl17FcjMMX1neQH7epbGfhN/xia/5bK/R1yIx69di
	MNZmwFoIOxTiII42MwcRrc2nKMJTW3URjO1LEPbNH9H1k/ru/SmtZlVQbXt9z0EhEiruZ6FN/AD
	UbxBdWlGPzSpliWbAeT3ftL3X4EPQgiYJm52MnRHX8wrc/PnRO+hL0oRFOn8wOnxUcHDcRusY/U
	bSnUdyoTW/p+0u1RXRQKZTr9wE4Lu1380B6OMyEAaCzQvTGf8aFVqnkew1fSquIb+WAnZJj1lDR
	+yFkskTgV9wdga0F2BZ9beMLT+FyZlVn2vf/dYWG5YR2NDsn5IecCZ3qn+ZXrQ3oZ+j/K+rCvJ7
	dBKx+mgOUpX55pPKuZuDLk1nQGDbpkqVIi0zL2NzyHxI9+J+FXh5XREO8jfT0dvjw=
X-Received: by 2002:a17:902:cf10:b0:2b0:42fa:72eb with SMTP id d9443c01a7336-2b0cdd40321mr154096605ad.47.1774943036058;
        Tue, 31 Mar 2026 00:43:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:90ef:61f3:1679:56f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242795195sm106127485ad.61.2026.03.31.00.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:43:55 -0700 (PDT)
Date: Tue, 31 Mar 2026 16:43:50 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Brian Geffon <bgeffon@google.com>, linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] zram: do not forget to endio for partial discard
 requests
Message-ID: <act7DBWOwe42i38Z@google.com>
References: <20260331073737.774503-1-senozhatsky@chromium.org>
 <c2a593e1-cbde-46bb-a32a-c9db38c62801@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2a593e1-cbde-46bb-a32a-c9db38c62801@suse.com>

On (26/03/31 18:10), Qu Wenruo wrote:
> And forgot to mention, I'm just a messenger who also did the triage.
> 
> The original reporter is Avinesh Kumar <avinesh.kumar@suse.com>, who noticed
> a test failure from LTP runs.

Cc-ed Avinesh on the v3.
