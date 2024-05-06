Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095F46439
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714977822; cv=none; b=UtNYAbdQC0n8xCM66zJvjXrZYvf1yll0T2g5ILSkorCEIDDzLMd7ckIfucOoJPudHKCZ7wwMJwhFjIUMg6UzQm6XJARn7xJAwpfG+tm6vEEJmS1XxtvvBC7RXFHGZ4KnZtjJo23xc3pctqRntIHT+o8ck7Im2T2kcE7qUeZ/UTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714977822; c=relaxed/simple;
	bh=TTtQyHcx8HkIEEBoI/wvFIf+0GYqPB/yGd00nQkF9Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlsV2ranDcKwYX0ALR74IPHIHsOy33fOZvCT1TWu1b6tRN2X+2vCnUyB+BgaX0El0unI1HIf4jCTz92Nahfkxk+8AqUZktvSQ8Ke9LxbsC+u92vXX6MNufbKDzpze5Y95d8zjAGGoFc3sXXBzyVJNHMy04XGA3CfrZeMGBrUPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RflGFmp+; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RflGFmp+"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so937026a12.0
        for <linux-block@vger.kernel.org>; Sun, 05 May 2024 23:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714977821; x=1715582621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Awh0YX9sFOZlmXGVWv7TrQyTmY6KwzUZh2FsqtFN28s=;
        b=RflGFmp+l+BXhk012uKZ6aGuTeT6YcCrQtXctXqH+GYKCsoFUkUu+ncgwY+ZsVSEPf
         Optz1qPMVDD6ozHGvn9LX7Vbec04BflDCvLwMgIJnuOo6N7bOWYZBSyKR8z6jaTMREwx
         jbKOWzJ+JqoF4pLVdtWNcOTcBDLi2H9zqMAT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714977821; x=1715582621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Awh0YX9sFOZlmXGVWv7TrQyTmY6KwzUZh2FsqtFN28s=;
        b=JbfrPP9wQygOlLd083O0sYgGohca3wTkzIDIIbuETI/3pxAZ/ub/Gb7vYhItJTj3jf
         /+JBucwLg6ukQPdHmct/4Wh/xFYtb1wN8G0FCeGDeQZLEzi9GZCo/LkvGfRxiGUDPHO0
         9QC/QWztuD8SHWokWRp5tpZUpO4pJCInweRWktD/HO70W78S4cWYD2mZmZE7ferZy1pp
         TWhMcAREOdAqYzP2WOMjoJ8biXVpDb/mWJSqEVMYmOCCBu8dWUGg8CLWd7PVuhaSVUjO
         OC/OwBAgEc6s+77D0q6yXqivoL34igmDBTScnktI3C2BciU9tysmvookIx+2YvIMt9ln
         EAGg==
X-Forwarded-Encrypted: i=1; AJvYcCVxbIq95f4AXOxgKWG0/sSgCRZzdwaBRsksiQEfTxBjtga9EPzGythNEAZBHtq7KGDK1vlr6M5HbmdxDI57EmKCFYnzqpX+fJPUWRs=
X-Gm-Message-State: AOJu0Yw1biad46XsNCEsar6s+anR2MPuMgI/l81FIZ5vuZYvuzXfY8b7
	H7jWzqND24E5HT06frp0/L+b0AvjYguf3af2gSp/faDtA8FdF432lBwZVZgb3g==
X-Google-Smtp-Source: AGHT+IH9/hiNrPAZgMq5yCe0qsmK1lm2LH0SwY8LB+Tn+zX2oS8PqcHxJee+fl5rH8OfTgRdDd1VYA==
X-Received: by 2002:a17:90b:124b:b0:2b0:763b:370e with SMTP id gx11-20020a17090b124b00b002b0763b370emr18238105pjb.18.1714977820818;
        Sun, 05 May 2024 23:43:40 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4e24:10c3:4b65:e126])
        by smtp.gmail.com with ESMTPSA id rr3-20020a17090b2b4300b002b113ad5f10sm9316590pjb.12.2024.05.05.23.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 23:43:40 -0700 (PDT)
Date: Mon, 6 May 2024 15:43:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kbuild@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Minchan Kim <minchan@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/14] zram: check that backends array has at least one
 backend
Message-ID: <20240506064335.GE8623@google.com>
References: <20240503091823.3616962-9-senozhatsky@chromium.org>
 <202405041440.UTBQZAaf-lkp@intel.com>
 <20240504071416.GH14947@google.com>
 <20240504161004.f5a0aab5e5aa1033d4696c20@linux-foundation.org>
 <20240505043957.GA8623@google.com>
 <20240505051305.GB8623@google.com>
 <20240505064832.GC8623@google.com>
 <20240506032207.GD8623@google.com>
 <CAK7LNARUBuR3gDtX6GfB7Zv6dydt1+qzBB_XT58wOg3WeCTVvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARUBuR3gDtX6GfB7Zv6dydt1+qzBB_XT58wOg3WeCTVvA@mail.gmail.com>

On (24/05/06 14:20), Masahiro Yamada wrote:
> config ZRAM_BACKEND_FORCE_LZO
>         def_bool !ZRAM_BACKEND_LZ4 && !ZRAM_BACKEND_LZ4HC && \
>                  !ZRAM_BACKEND_ZSTD && !ZRAM_BACKEND_DEFLATE
> 
> config ZRAM_BACKEND_LZO
>         bool "lzo and lzo-rle compression support" if !ZRAM_BACKEND_FORCE_LZO
>         depends on ZRAM
>         default ZRAM_BACKEND_FORCE_LZO
>         select LZO_COMPRESS
>         select LZO_DECOMPRESS

I'll take this one. Thank you.

> BTW, "default n" you are adding are redundant.

OK.
