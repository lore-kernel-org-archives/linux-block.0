Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B9HAq6lN"
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB9A19AB
	for <linux-block@vger.kernel.org>; Tue, 28 Nov 2023 20:19:31 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5be30d543c4so4502190a12.2
        for <linux-block@vger.kernel.org>; Tue, 28 Nov 2023 20:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701231571; x=1701836371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8sF8sEE2ZTc9ObiMO1OzkZ6Z6YbCekFkAXIm79+6W8w=;
        b=B9HAq6lN0gqBdKxxHzl+TumZYBizeRB4Y+R95Z4D9KVI0E93DusuRsTkn6MqqXJtMS
         vQHlMKtoJ6vMvgoAvxPlrJOwDbETcHzxkqmLpPLG7YMc4JUBjxylAjr4/440smXLwcK1
         90fdEhqowCCAqWxaikGJMxYrhyxEOk9gF6tL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701231571; x=1701836371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sF8sEE2ZTc9ObiMO1OzkZ6Z6YbCekFkAXIm79+6W8w=;
        b=YUoN3YvWp8vKVVuUQggy0FAyOpwzHgDK+6m7iw6bWcreS1Ph3dRTKjZs2ZC9omb8Nn
         NAfBqjdShKGZ8HwchDg0OwC232UsehyFim6s/niJhbRyPthLcOkJ8GNJQ4dW5anZoET6
         T4sMR6+4qx7SE0Pyf87rD3E64v0hJoY7bevNdVn+B6la6MPZpiu187QFWRtZNrDOak/E
         pctclMuGcc6Sz2Aw86ZOI8cwQoINEwDnpyoFhdtwv23sBe7oTAmBnkDbM4tj40nNE4Xw
         +GisDk3yqIz5kJRykVPmqXGtgZZbnHpLXtHpV55JsgmaypoFFeIrEUNjJl4W6ge/kzGY
         HN1Q==
X-Gm-Message-State: AOJu0YzHh3LX9lCtYr4U6Z7NaSgmEp5y1A+we3NeRJsU5UEC0+56SuEd
	WPwoFwlzMYeieFgeA5aZ5ixUVJT+kH3kIFKNA68=
X-Google-Smtp-Source: AGHT+IGVsQS2WwOQK7A6U+gxRY2q9is6X8IKCeex3/lpav2fyxkdHoMlkRmgWIkOH2QxX/hvMIDhKA==
X-Received: by 2002:a05:6a21:7886:b0:17f:d42e:202c with SMTP id bf6-20020a056a21788600b0017fd42e202cmr19782814pzc.49.1701231571187;
        Tue, 28 Nov 2023 20:19:31 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902edc200b001cfb573674fsm7337050plk.30.2023.11.28.20.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 20:19:30 -0800 (PST)
Date: Wed, 29 Nov 2023 13:19:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: Use kmap_local_page()
Message-ID: <20231129041926.GC6525@google.com>
References: <20231128083845.848008-1-senozhatsky@chromium.org>
 <ZWZ_W3tkw9tBqdvE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWZ_W3tkw9tBqdvE@google.com>

On (23/11/28 16:01), Minchan Kim wrote:
> On Tue, Nov 28, 2023 at 05:22:07PM +0900, Sergey Senozhatsky wrote:
> > Use kmap_local_page() instead of kmap_atomic() which has been
> > deprecated.
> > 
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Acked-by: Minchan Kim <minchan@kernel.org>

Thanks.

> I didn't know that the kmap_atomic was deprecated.

Me neither, figured it out recently (via checkpatch warning).
https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/

We need to take a look at zsmalloc, the conversion can be a little more
difficult than zram's.
