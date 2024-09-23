Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FDF8172A
	for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106465; cv=none; b=nwVgtuAT3M9lgufA3GIDYBKmf0wkC7mry8a01T6Ph64ZICjnJ94od701sh4nBkR3docaJOkDzoasevK4uq+UnyXrKTJDyjQLyMS7UFRlslx7cJB8eQ04sc+jMowrPBOouWZucXy98zoheKCQDpNf0yW589YoROZqs1Dvs1gR9Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106465; c=relaxed/simple;
	bh=6tBsekOVEbL/u8BkiyRDO7LBWxHubMJp54aDy0+CCIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htWELVu4Qe7NgDLu/PFIw2mdkpscvPbgWWYkNp4LTP3TbBmQC5mAGG+hEutYf5B7smUm2lvWDIYAJs9WvUF6rZkag4sW0qlHYEoWxqe8HrprL/Avn1MelXxYRCbJ/30RHMBLYcIDL/Nyk8wOmCke7oa2N3X6cj4AtD9S8H/WCeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S8XXLT/U; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S8XXLT/U"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20570b42f24so48865605ad.1
        for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 08:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727106463; x=1727711263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQvRJDTU5M/Q7YFtH2baTOj185sy5Qo5fxlt2UwlPLs=;
        b=S8XXLT/UDhfNEiKrS46JgCZVy5zEy4YniOJ+lmNOsla5rm/ZVFQqaePzBkZvrb+zRu
         3EpPhD1wiEwnPwnEzN0vD5QyTSPsq8TDYq3am4E5FmcFIDDEp3N53lBSPn5U6x/Usrn8
         /aB7VhcwPaI1NDPOQZkjqj/LEq/aB07pd0mf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727106463; x=1727711263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQvRJDTU5M/Q7YFtH2baTOj185sy5Qo5fxlt2UwlPLs=;
        b=M2ODotYTMzL5HNLCxDE+ZdkEowGXLTAPUxduOpouCNBlBzn0QN0OQFUNRnKDFfW2we
         5yOgPI/ZcLJwYYSWmbMYx2YoDSRraUt19O7WfMD7HmMu1znHrAfUuzemNVQOFfP1X2Vc
         QvDV2rUe00nxpsQPx5iAERELbMPO/84yXFtkvtZoAx1Fefw7F825buB1TCk58o0rwXRQ
         WrzGaFl15RKcGVe0MFaYhv9tT5+KxgGBJCko4hy/90qP5lGkoJKru+B8qZImld96dU9x
         CXyv8PjJuzQSlVVRskDcNXz9m6akVbnCSjRukO9rNSmHCHwxhPw3x1Yc4yVRuQS59hJE
         LCDw==
X-Forwarded-Encrypted: i=1; AJvYcCW293eEd7+ECjhy5vuDn04PqxIF2lCq8mXDyWkKTfTU8mNlR+V6+SU+Ki8UtLo8sG8px055s1HrS8ZvHg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7IfOpijpT/qI1a34tTH38nW3/0g33XMC/6MWCxPjnn+ZV0QIB
	aAV0jqplNDs8RYFT16cKfrZuvh2VT4ZEOL0hhTt+YAc3SDAEN49nrWbHgRIZVQ==
X-Google-Smtp-Source: AGHT+IGUc2twRnaEQXb08Noipu97AHfEkG7UmGX3BFwRhuwwWRnJvapkHauas0XeVKCV6OmcnBRp7w==
X-Received: by 2002:a17:902:f650:b0:205:3bdb:553b with SMTP id d9443c01a7336-208d833d0d0mr198432615ad.16.1727106462945;
        Mon, 23 Sep 2024 08:47:42 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fd63:e1cf:ea96:b4b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d1554sm134149685ad.144.2024.09.23.08.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:47:42 -0700 (PDT)
Date: Tue, 24 Sep 2024 00:47:38 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zram: don't free statically defined names
Message-ID: <20240923154738.GE38742@google.com>
References: <20240923080211.820185-1-andrej.skvortzov@gmail.com>
 <20240923153449.GC38742@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923153449.GC38742@google.com>

** Re-sending properly, somehow I managed to badly mess up
   the headers the first time, sorry ***


On (24/09/24 00:34), Sergey Senozhatsky wrote:
> On (24/09/23 11:02), Andrey Skvortsov wrote:
> >     for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> > -           kfree(zram->comp_algs[prio]);
> > +           /* Do not free statically defined compression algorithms */
>
> We probably don't really need this comment.
>
> > +           if (zram->comp_algs[prio] != default_compressor)
> > +                   kfree(zram->comp_algs[prio]);
> >             zram->comp_algs[prio] = NULL;
> >     }
>
> OK, so... I wonder how do you get a `default_compressor` on a
> non-ZRAM_PRIMARY_COMP prio.  May I ask what's your reproducer?
>
> I didn't expect `default_compressor` on ZRAM_SECONDARY_COMP
> and below.  As far as I can tell, we only do this:
>
>       comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
>
> in zram_reset_device() and zram_add().  So, how does it end up in
> ZRAM_SECONDARY_COMP...

Ugh, I know what's happening.  You don't have CONFIG_ZRAM_MULTI_COMP
so that ZRAM_PRIMARY_COMP and ZRAM_SECONDARY_COMP are the same thing.
Yeah, that all makes sense now, I haven't thought about it.

Can you please send v2 (with the feedback resolved).
