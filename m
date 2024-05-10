Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23693149C79
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 04:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715316235; cv=none; b=qZEkfi33edb1lG58p0Pg6Jw0nGn4PU5/BnBBRnK+P6AUIGnJOHdsDnDmqTW+XLSA8+jQCiF0GRaMxORTzseJHyndX3KGvH97iBxrq5WL3fZUuJOQO4uL548hklDA6YB2DMvZ712AMmFNGus6U3YUOvKnlv18eGgCWr65o+79ZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715316235; c=relaxed/simple;
	bh=z4P8poNID1QixqleCdlEz4j1Zi5VUgmbCvuKBT0R4ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7g1P9Vj+BJqpn7eX2245DOYnhfKlCHATJtmqZHt/1o5f15eW+DXZTCkclSmgsDiuQYM7yLvTsa/rHwY48bUENgN5TqfwHnCzoeyOdjQZUk8Dgf0rgpKNOP8DvLlDbFJXEN4Tu88reEr265WvUWjKCXwWRujHI9XLMgR8ip1D2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B/GsW2st; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B/GsW2st"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f449ea8e37so1399875b3a.3
        for <linux-block@vger.kernel.org>; Thu, 09 May 2024 21:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715316233; x=1715921033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu3HPM/W0RS8LZ8fQfn9wykBlJaEHYXothWbxQj42GI=;
        b=B/GsW2stMrB5N8Rh9Ja/zp9UC2rx8TSiNRsOpZSXnRJrAs3wVljGzjFQUTkbd7MDpH
         6BqbQ+GF7EUFbvMP0TN35IkKxqWZb3z/a53tK+B3xWBbRuXlyjUHeU89CxA/uy3sU17i
         XtARgMI9FDhJ5k2nWj1LKxWL9wsP9BMxAcZBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715316233; x=1715921033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu3HPM/W0RS8LZ8fQfn9wykBlJaEHYXothWbxQj42GI=;
        b=JTW817YlDNwsfYTI5GhMl3NZFZ1kP9V8yw3fQ3ZoBLbVvDAPWhNbNnZlxTTCAy5TNv
         yLAmNmY4Z2K6LCN6TJKayfQRGjkN7E7W5oh3e8AdENfd8tgRLmbuZ6kABXQhrYABuh6h
         z/34SLaRNr2OI+w9G9ysTAwC7hEO48uf8SrTwMPWl5JdgwsoHYLK9EMX5E0QaNvGdZID
         71Sf/Hn9Hh7PV9dTVQ1ZlI17tu9kzJF+vmj9ulUV+cl50zGLeDKr2wU8CssIqX+/JQll
         iRbtHGfp5GBBoZ5iVxBV96W3incF2m7V2EoEn3/s/AB0Q/R4F0OO5lWXtGb8mlKChKa2
         VeAA==
X-Forwarded-Encrypted: i=1; AJvYcCVbgYQhtm/HQvuiwnBVXYrD4xWkWPdh72y4HmECfHAtk2seb3nAjz5LYbSUaIjfSj5MA/MdIG44kAzPXCUoetKHfJP7L0O+8OZF1Ak=
X-Gm-Message-State: AOJu0YwO43Jby8h/fsl5XntrhQN3HTZbdt4o5IoIMJaP/0td4UuAMv2b
	quUMMgf6ciUDSMugFp03LQoVvYtyt+IhaeHtqTqgZIhacjIhFR1M45WT6ohgJw==
X-Google-Smtp-Source: AGHT+IG9paMfNeMGyt7l4SrK42bMcIO2btSx/oYAt/Ksr7aEaKMP5XAI4AxSZ0vspBbwncjhvS+E4w==
X-Received: by 2002:a05:6a21:81af:b0:1ad:999b:de34 with SMTP id adf61e73a8af0-1afde197857mr2011928637.38.1715316233419;
        Thu, 09 May 2024 21:43:53 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:de58:3aa6:b644:b8e9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca5109sm4192104a91.38.2024.05.09.21.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 21:43:52 -0700 (PDT)
Date: Fri, 10 May 2024 13:43:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv3 08/19] zram: add 842 compression backend support
Message-ID: <20240510044349.GH8623@google.com>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
 <20240508074223.652784-9-senozhatsky@chromium.org>
 <ZjzEnbHGO_hYQN11@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjzEnbHGO_hYQN11@infradead.org>

On (24/05/09 05:42), Christoph Hellwig wrote:
> On Wed, May 08, 2024 at 04:42:01PM +0900, Sergey Senozhatsky wrote:
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> Not a very useful commit message, made worse by the magic '842'
> name.  How is anyone stumbling over git-blame or looking at git
> logs supposed to make sense of this?

I can probably add something to the commit message:

	This adds s/w 842 compression support

Not sure if that's significantly more informative, but maybe.
