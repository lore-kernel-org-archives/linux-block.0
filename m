Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A04803
	for <linux-block@vger.kernel.org>; Mon,  8 Jul 2024 03:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720407817; cv=none; b=fi6PgY4UiU4fKTYrT9JEWIrtk3T67f2+ebRhvagK9bfhZrPzkk21KBXnxnZ4s9o+DxTuAIF+mbNQtUwU+bIL2bsu0JIV5BjdFLfvBhvgwwcyqNqA/xwVQLlZB07MKCr9WbQD8OEUNr8GGCb6ET9dshXHMRfGGJ8AlEhmD6m3c6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720407817; c=relaxed/simple;
	bh=aHIrpcLG9ZGSgOStVeCA6IlxQzwGrCJ/ze2oZFMAcwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZxbf9NUuZzF3T3OJKai/gfGilr/fLX1dlgq3IRuHUlLhiNvHJsbYVr/NVC/BVOjl1hTGqD28rKe1siPwWN6DrDguvBJHOBvcjg+auVwhG+kiPQtqTY5yuT9Q6dTSQrdPn40BRXC0AfeXQ63qz7r2nHQOLVeEtFf7LQzOWGcG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W1Ni2oe1; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W1Ni2oe1"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7035d9edcd9so1212649a34.1
        for <linux-block@vger.kernel.org>; Sun, 07 Jul 2024 20:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720407815; x=1721012615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nyybtaZVEV2Z5gr/Xj5boxxbelx9NExLhjriH8Vzh8o=;
        b=W1Ni2oe1VUI5IBB5YL/M5xlF7SALeQHBUsxk07jHQ/0oMU+krcT79PJfenuw+sfgwe
         Imrz8HSpNG3x3MeZTy1qe9BwN40zPWy0l2mR9C6fBoXmKA+9i+/4f0CellhtgEZYyyyi
         BcpqoklQtBPCOUR2tPGcypnvr9Pk6XqUKgSyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720407815; x=1721012615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyybtaZVEV2Z5gr/Xj5boxxbelx9NExLhjriH8Vzh8o=;
        b=nMjcWBYocAKiQYVOQvahoeTd4wiEyf7Yu1uL8CMcOaOa+LXfzySkwxSggpcDWoc0wb
         7X8uzw6v/bPoLO8Fu60+MTdtAeg6dY7tq0UxwFQiJrxSvDrlgCinknFMU12nekB8PN+g
         lXJSRmkY1sgkkTFa4MlHdHVYZZ16HXAOwh4MxW01YL6UpCsWAErlNhQBnVJlyWhuYcHj
         DdgU3fnZni1VoICBdTE8O94sNb20i6A42BYXdAE06tEFofybAlKD0MvNHzhLt7wODdNj
         YhYKH3aIGWHWVDZkVxOR4cy7saqltwBBQu8fl/2UzJBVuqNW0bXmKwVBYXr+rRvR4NG2
         UxIw==
X-Forwarded-Encrypted: i=1; AJvYcCVuOjagfzYNPUxABdWzwA8Nx/6q4zDH39PnX8uuf9pSH3PYbAajfAGejRrxgcyDfrV/F/jQiaRsXFO84hy3FUPFbS7mM/euBYILWhM=
X-Gm-Message-State: AOJu0YynFGX04cNLDAvL/QIXXNxzbrLn3qZPldSbdPGkGuK+8ze+vcp0
	pxyeHHU3LTSphWnaVLR3hP5rgGvqiRjJ3irLyyY3J3nrFwP379pcBwla9zAmpg==
X-Google-Smtp-Source: AGHT+IHkEqHP1B60srwbfsajdtk+7QXJojhM6E/s4AcD68sCwHx0psDiOmN7r1Vd47jUyzvqlJcdpw==
X-Received: by 2002:a05:6830:1d7:b0:703:651b:382f with SMTP id 46e09a7af769-703651b3c18mr4473264a34.3.1720407814861;
        Sun, 07 Jul 2024 20:03:34 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:eda0:6e46:c522:d0b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b28c63ad5sm1794184b3a.27.2024.07.07.20.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 20:03:34 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:03:30 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH v2 1/3] zram: Replace bit spinlocks with a spinlock_t.
Message-ID: <20240708030330.GA797471@google.com>
References: <20240620153556.777272-1-bigeasy@linutronix.de>
 <20240620153556.777272-2-bigeasy@linutronix.de>
 <27fb4f62-d656-449c-9f3c-5d0b61a88cca@intel.com>
 <20240704121908.GjH4p40u@linutronix.de>
 <801cac51-1bd3-4f79-8474-251a7a81ca08@intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <801cac51-1bd3-4f79-8474-251a7a81ca08@intel.com>

On (24/07/05 14:02), Alexander Lobakin wrote:
> > On 2024-07-04 13:38:04 [+0200], Alexander Lobakin wrote:
[..]
> >>> +static void zram_meta_init_table_locks(struct zram *zram, size_t num_pages)
> >>> +{
> >>> +	size_t index;
> >>> +
> >>> +	for (index = 0; index < num_pages; index++)
> >>
> >> Maybe declare @index right here?
> > 
> > But why? Declarations at the top followed by code. 
> 
> I meant
> 
> 	for (size_t index = 0; index < num_pages; index++)
> 
> It's allowed and even recommended for a couple years already.

I wonder since when?  Do gcc 5.1 and clang 13.0.1 support this?
