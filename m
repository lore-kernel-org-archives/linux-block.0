Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3A835DA41
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217681; cv=none; b=CAJIT8/zhkyUJ+vXBFr4uW89VtapZ9EdTkmZwGzswqE7BHHTvwmRjx1YC2vlaNsH499MLugY5RM0B/4Ha/bClqPsgrpms7gImYfqEhuo9QtB3YkOei901JBKBWUqMPYHu+OsPd84B2n6vT5W5Itn+9oGJt4ajjjgjY/j3llQvs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217681; c=relaxed/simple;
	bh=sWdrF0eRbhdl2REFs09EqW8uYT/2IgoIrHD0nhv4fkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFkURPpe7S3IgerhvkhMgjKOYRHGzfn3y4nxiXnJyj+Kzc3tFl21eKqdzzfs3o+iLL/HuVDzS8DdHUTHnlSq6/WsCnGQjmTNbtNIy/Tios01Nk/hp8SrzwXSX+cueF9dwRUktV5Bnr7MzgyeFbm9bMcVoI6HkEvsRI5wTVovzMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LQt98G3x; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LQt98G3x"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3599019ae92so5771442a91.0
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 01:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773217678; x=1773822478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wb54AwpsvRCk6MTGz8qZOYDRcryKsG+hshWt3zYfQ00=;
        b=LQt98G3xDm6TsBmZ+oYj7SLloe+iAfF6FeaYM5GmmWGTFQcF02DXiYnAJcx9QSDJ+Q
         vl8qDgfEopcfMr+hr3Lc/pxB0H/x+vu6SDFxgThPaUuHQg8ssCRCmWwhUrO70mo55/c3
         ljdqI7rALHSFqf++xbMHHukviSvgD3MSLLIGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773217678; x=1773822478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wb54AwpsvRCk6MTGz8qZOYDRcryKsG+hshWt3zYfQ00=;
        b=T7odmFll937eVn1X1+9I32KTIKmKU/VDhkbZMRBaU1G0h/c5nmlPDcccufb5wT953G
         NTKRqSX94XL74tOgLyWMFwTar5GZ7j/oGKbWeWy/34QjqjS6DTvMi8URc6gjDsMZpfvf
         vyRDw0HG7h3k+K/REqu9isVAVQFA5vVi7KaXu/zsK6H0Mn/jY2z6sYEqnbOvHjzWrTJk
         Uv50Qh5gBsYep5/DlonBCmtEmZ0ZjmapmVDEKs1as4zO3VcdiC2WQZLRjgGXnlYLoH+B
         7np6ROe9OkoNNWapeJQh4yoHnTdHm9bkA1ng/FTgop4AdiGyXY8NUjklIQCxZE47sovS
         velg==
X-Forwarded-Encrypted: i=1; AJvYcCUdAQ11uA9Swf1RYgID/Rxr7Gu8AORWb31JWowVYBdJ2oygN4o0yPMuCij+jkT020o7c8eBo3iL56UAJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBKFy2Scp7/TLXTBar3y7VWComJqTpBbr1eckI073ZI+CZ8wOx
	NUpgGkkzRKxl5FDklPlfGYvhq3ILlxuoPq70/escqnWo3emb/U0B8QqCWeVH2MJJTw==
X-Gm-Gg: ATEYQzzniHcK3OHV6HXbYVIiIn0hixs7klwUN5TVEVEYfNz3fJ4rH6nukiy2k4ZS4J5
	3we2rqqva8GNdF7GD/ea44qDIlkUMM0e7cCWuIR5ZLeM9/lgNlKNb6CnHsimDZrPLZHtdliWGGQ
	QUe7U9qIXZ9ywvulf66ivIqXom74HTM/7RdENkJ6/cQ69QpuLKucxA5fYDYqjTUbCJ81gbJlRXA
	AaN/D6Zjjsc5N2aggiZ/DXatNL4VwKv+80kHmWhi7L+Nd3YOz/ldduoxmkku/7zyhXjpVDsow6T
	Fd6UkdPXFym5neUTRc+iRqlJfTsfjx638CwJOFsK5J+bdHqJbXQ+dK9YWfaIn2KEzHvga24cKXa
	c+Pv7U5N76aloc3xEAjTTgR/mtwdnpturzHViLbkq6lNiBLOdgtzCE+gBHwgVqu3r4K3YCVGq6+
	wqe6u4N1gRpeNvI0l7m3z9kvuaUu3EBfHP9vH9VfhRBNOUyMnyHd5TpV5Y6OnBIdI=
X-Received: by 2002:a17:90b:4ec8:b0:356:23be:7ecb with SMTP id 98e67ed59e1d1-35a012cce45mr1850888a91.12.1773217678148;
        Wed, 11 Mar 2026 01:27:58 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:93a4:8281:fe98:426a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02e19708sm1947257a91.3.2026.03.11.01.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:27:57 -0700 (PDT)
Date: Wed, 11 Mar 2026 17:27:54 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, gao xu <gaoxu2@honor.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zram: do not permit params change after init
Message-ID: <abEnBEPQDpF6Sgpv@google.com>
References: <20260310060407.1133800-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310060407.1133800-1-senozhatsky@chromium.org>

On (26/03/10 15:01), Sergey Senozhatsky wrote:
> First, algorithm_params_store(), like any sysfs handler,
> should grab device init lock.
> 
> Second, like any write() sysfs handler, it should grab
> device init lock in exclusive mode.
> 
> Third, it should not permit change of algos' parameters
> after device init, as this doesn't make sense - we cannot
> compress with one C/D dict and then just change C/D dict
> to a different one, for example.
> 
> Fixes: 4eac932103a5d ("zram: introduce algorithm_params device attribute")
> Cc: gao xu <gaoxu2@honor.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Andrew, I will include this patch into v2 of the zram fixups,
can you please drop it for now?

We need to protect algo lookup path as well, which accesses
->comp_algs.  I'll fix that in v2.
