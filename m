Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF958D2E0
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aER4jRTv"
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CF410D5
	for <linux-block@vger.kernel.org>; Mon,  6 Nov 2023 23:23:41 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5af6c445e9eso63226887b3.0
        for <linux-block@vger.kernel.org>; Mon, 06 Nov 2023 23:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699341820; x=1699946620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OWNGndg7wx7UsmLs5D+Rq7iYTC+ge2DYU9RXrsS94No=;
        b=aER4jRTvNq1DiEPODWXkjaHRDaYlsm/IbQsKYfxeD8SQJ/74Lyd8VvZkSRx3BN4VX1
         ME/yDikGKqE7Co5rMVu+6krJNdqAuXm9CBZssKsWnnIRsPs+ieranJZee5cuuiWpu9B+
         VRKR3bIdF4sXYRgjhnyUFKFEhtZHZdidJtXtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699341820; x=1699946620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWNGndg7wx7UsmLs5D+Rq7iYTC+ge2DYU9RXrsS94No=;
        b=gQXLFiM6qicZk90d/bdhzYKoTG4h+W+eWLi4/EhzDtkKzhR9wFzz6rs0M22wa7VAqU
         r1HB5YcWJepzWC8hs+3KySI3w7FeWAeFChXpN+/YYkjz2KCDbbQ052jS5mUXo4QOXFl6
         w4ngJvdb5guLeGCvHlKpvVX/wksvDfKrELY7mTtPk6U4532+G0fEWxkGRwy4Wz5uFckm
         2dc0vMONGPmq2C45ulZCuivsKPoS3BtWUo+q66XmeHKicHEQkdht80XBTjcxP0ro2NOt
         1sd90lrIdYmN6Ryd81KY06xP6l8ZspOsbkMoNvrXw0RN5oJOvp3amtsNUdIUBNm8RAhZ
         scJA==
X-Gm-Message-State: AOJu0YzLFkCcA4M/P+1J/s8uTAnkbD3xIOdX4AferrLgb5gsyGMz1z3l
	wbtP09LApr5wbOf+Os4KmM9SF4cQ+nNGy2aMvmc=
X-Google-Smtp-Source: AGHT+IEF1P8WPg9mrCIYC35ojAXg98l7Ku77fGg3/ZA9CByuTMWybwPkdQXraU0BM0N0EwyTIrFmpQ==
X-Received: by 2002:a25:f828:0:b0:d9a:3d72:bfab with SMTP id u40-20020a25f828000000b00d9a3d72bfabmr27321209ybd.40.1699341820257;
        Mon, 06 Nov 2023 23:23:40 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:7d66:31e7:94a6:e6a9])
        by smtp.gmail.com with ESMTPSA id k125-20020a632483000000b005bd3f34b10dsm825837pgk.24.2023.11.06.23.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 23:23:39 -0800 (PST)
Date: Tue, 7 Nov 2023 16:23:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Vasily Averin <vasily.averin@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-block@vger.kernel.org
Subject: Re: zram: zram_free_page calls in zram_meta_free
Message-ID: <20231107072335.GA11577@google.com>
References: <ebd87e1e-f941-498a-870e-15743ca3fb1f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebd87e1e-f941-498a-870e-15743ca3fb1f@linux.dev>

On (23/11/06 23:42), Vasily Averin wrote:
> The only place where content of zram entry is accessed and even changed without taken zran lock is
> zram_free_page() calls from zram_meta_free().
> 
> It does not look like problem because zram should not have any users at this point,
> however I still do not understand why this is required?

It's simply pointless. Reset is performed under write init_lock,
which is an upper level per-device lock.
