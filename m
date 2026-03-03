Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4838F375AB7
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772506791; cv=none; b=k4u0L+CLvFNgJfHNhfl3nNWl8gCXP7/I3RA8k/Wqqo66p79KrKvNPUJ6dBmclCwU/cicj3/zKr5V25a2P1+H2Uaq3QMnmoamGlJvKWVTyKMhRrAFmB5uGUrhq9CrRbSYFAedLpu3dqO7/R5A08CWI+6Gk19RziYjaf91xrwQ/nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772506791; c=relaxed/simple;
	bh=PphUhGWbyrX/l7M64TMixNM6DTDCDGDlsOTYl6w8pqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9aopTwCPhMhwvlb5gEQxomDCBUZMzxNK0UI/Q3Jrcx957Vg334jYLRULQRdbM6+rX/gX/NdYhjP19w2YGwNJapC20t5a/fPO/UjfqHdKkZ52ybh3amB+tLhxPRKpkH7O1GI9LgQiSZNcVbZoCwMEK9eFCFl2tpCDX5/6iV7FuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CTdsEKvD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CTdsEKvD"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so4588571a91.1
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2026 18:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772506790; x=1773111590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BLlwYryI9nwoVTSN1bLvGrJJhFzGrsArbGvfJ+aDFLo=;
        b=CTdsEKvDcVZc/hwVO4fPC7L00N1RMj8ogy1kyRs+MRS0wfyjXBtPWB2+1E1Ms/v88v
         7gfY0Gpo97dsY0EmiJ/e99EMP7IuTnk4vLWYJhIHe1zEJiGCmvCuHxQq6zT0sMv62KSQ
         HwZuAnJtrIIpACnVuU45TnQuibSUxg0yOT5OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772506790; x=1773111590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLlwYryI9nwoVTSN1bLvGrJJhFzGrsArbGvfJ+aDFLo=;
        b=pwG3ZUwE1YwvSZu1vrxOgD/MeRrgspf+H7janPwoGEGSxkM8k59u6WXYaKcjOn1rKc
         pFKQGFE00cQS+/n6QynWSswkkCCXMvkkCsMGqAM/BI3sq6/U6tv6626180HBCyrbrqPe
         0j5h0WcI6lCMdxu9ETo0N9C1/WvMV52kFERqgf0ctmsJXsd6BwPin1iie48ez0S82EQC
         YbVz6VRdp8k93v/G80rfY1QQQvpaFj5c2tS0Jzx17Yxd5cTlyjfVsMK0qJJMb+Rs1QM+
         PM428Y1mjH+S6nRurP8+67aL8ZOo0u11dDWRT6z/ID6fDNeacK7EDmkzD9pJ9Flh6AWZ
         QRjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJlkEruZ3H/W6ApOQxwOWash6VQ9O4CDJVrA/hnYS7LaOI2Y6e7NW52QCTVMriCYzAtT5UbJvQnoW/Cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkkyjMIzdb9w7VFWTcC8fUhmVzAGdfVdAF9T7LWZm6uah4B8T3
	J5C8PIVNT4rjBCCP2oqFrYuA/F4jc0Hun5E9Y6issYFcI0ZBrgOQFR+pxXPhXqODWw==
X-Gm-Gg: ATEYQzyEh8nKEX/JokyUxTaTshgSnqE74jpcXJgCUKu5nXPs+sdOVmM09HBMTk/8UOK
	J201+5/9eCih+AEbQMuTY9EqNxLgliL9nkgH8ltq5WFK6mzId5rXblLx3Rfhn7ZrAzFip5Vu6m4
	2B54gEvZBFz4MywbQF8jhPoim9E0BDgxoWoNcl4xMlbczAHfzftEkrWJ+K5+tb7tMwb9qmmt08I
	Jfn3+wmb/3k01FIFP1HM/Jt8kYztCKQ8gSurExcdrOvrgU4RvJfvui3ki8DSF4s1ZqUUku0C3z/
	9HzEt+dwiTAXbcAYyqoxeHNHaxJuzz3CrY16kfg/cooiQoisFkeCGP51sDP4ndLYqs7mYSmUrJs
	KXlGawcSbhsqyxaVxgLCmznn7XaNUiHxQjLozaZkk6wecEy49awcTLqSuW8P5+VkuNSyoa0aZvi
	p0ABTNbMPrK8zL4ExlqRXaPC+eSFrHqgMFvs5+mZqLISjOjqYpQsYvgKnnFvZxppY=
X-Received: by 2002:a17:90b:57cc:b0:356:2872:9c5d with SMTP id 98e67ed59e1d1-35965cc5651mr14316591a91.24.1772506789686;
        Mon, 02 Mar 2026 18:59:49 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:25e4:df20:d043:afd2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82c531sm13254150a12.24.2026.03.02.18.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 18:59:49 -0800 (PST)
Date: Tue, 3 Mar 2026 11:59:45 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, Brian Geffon <bgeffon@google.com>
Subject: Re: [PATCH 1/5] zram: do not autocorrect bad recompression parameters
Message-ID: <bg7ivz7ajiuzdbpv3h6hbptxgmqk5fhwakw4rzk4sz3bczky5a@rde3y352n5ej>
References: <8a5d53d19a8dbd51d7d81d153676895163e0735e.1772180459.git.senozhatsky@chromium.org>
 <20260228120516.e5323a704d4a26bda041dd4e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228120516.e5323a704d4a26bda041dd4e@linux-foundation.org>

Sorry for the delay.

On (26/02/28 12:05), Andrew Morton wrote:
> On Fri, 27 Feb 2026 17:21:07 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> >
> 
> A nice [0/N] overview would be appropriate for a 5-patch series, please.

Well... I couldn't come up with a nice overview, let me try.


The series is based on internal discussions.  Minchan looked at
recompression recently and pointed out a few things that he thought
were confusing or unexpected/unintuitive, like the fact that zram
would autocorrect bad recompression priority parameter, or some
other assumptions that zram made.  I couldn't explain why it was
like that, and just agreed that it was confusing.  The final patch
in the series removes chained recompression, which also has some
unexpected behavior, so I just decided to simplify the code and
remove that feature.
