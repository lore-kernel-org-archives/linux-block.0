Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D51A3179
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764561394; cv=none; b=j2g4a21hvlJQ3K6JTq8G57gXpPoOQJyaMnd1F0NA3DR4h4BEVOu4A6KOy8Qd340L2gY3l9ROnHTeZvBx8FInAUA3AiRkoWToNo6R3TU0FCMdg39I1wWMLB3bXwqC5/HPeJm94GYnPpZfPT8vBxROwhEcNKjfyu/mEg/+0/zLShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764561394; c=relaxed/simple;
	bh=McOQTipQ2vTbXjA++68RW1XSamDCymkjaiQI9zBUL6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdOK7fAWAUYPzyyuZud3grG/XR0aKgvE/vwLI6k8cOJdJU5bbJxYD8Lc+GDoZi/VDv9Ov53LrlBTELlzCwoVDLanlH5JqPn0ChczeYrT0S38EDt/ap93Ex8I7LvB0r+V3e/MaQlpfwnDQONmFOgVhRPiMy5oh/QJg3j77Ig6eu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KA+2EXoi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KA+2EXoi"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29844c68068so41848325ad.2
        for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 19:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764561392; x=1765166192; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qB+a+p4MqPixn1RqoqUzTdFtWB/99ITR4DTLW8S81nM=;
        b=KA+2EXoiv0vcoRjBg18xuiaEdyO55JHQLhQw3hfQPXUQlyzJ3ec/sOySAmCVvNXWF9
         6kNTrKIafAU7nHKBV1pEQ9ITrXOk1miYX5eHAmAJuDhyILVWQ78mFD6ehAOWKMmzxAoN
         sBPCtaJ9hFcx+dJzf69S195fpBwAhAz8Tsu8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764561392; x=1765166192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qB+a+p4MqPixn1RqoqUzTdFtWB/99ITR4DTLW8S81nM=;
        b=trgf3TRoKHAIy4ZzOKPgH/1R3OJREMz8suf5MSWpCndRPr8d3PkFjZruk+HnDjDiom
         CmQtwGYXJZvI0/8GCQIQvwQogK4cwtCScgY/ZP0S3OZRMmOJc7IfQbPoT8+Fd4qMNUH+
         L6pLudc4wRO8Y+0XW6UClgcwHaV3wxaQ7a64IUJVzjC77nc+tzIoOQAMf9oyTOKpMVPp
         e3J7R6VJnt3+36as4fvwn7u5UvMoxMMn81cdL1X7Dx4EZjZ8EaOaT3+ZFNL9RmhgThYa
         vllCiyJIjFmuXnHwqKKEmeCm/SYxUedZUokpQh5w4oMqx4BABVQfaO3voei/T4e82om/
         qloA==
X-Forwarded-Encrypted: i=1; AJvYcCWUV5dPy67UGciKP1VfW/y8I0Sgf85kY1bMYUkf1YUsA68Y67vSWV8/t/McePxEQnCR+/ne9aqJu1rRJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUe3jbLQ/51SDqcL1TxQZPWIooYcQjlfR/beJ+N6/ubz2LPkK
	5WyA9QV+18LyhoctkHOC1FmMac3e86y3sQDPNHw7+XPClgnhdNBlZ97x2g2CMRRfbw==
X-Gm-Gg: ASbGncsiwwOaLQDAu6OLZoXMZ02Nke5j6oBma9zMidUPc+mnW2rXs7h6OH8zxOJcWu+
	g3RJBJG8w6shobvzw4vqn4M+AklB++5nZ2s5yfxEMPhpRfashAzhd26/ZvySX8DPPPF7gBxUxyK
	7q3m7KhCHhsuPm271NJGsKbQ8ZwoM9TDuDt8up8pj+u+rx53l94mzIYLnV7cCDpvZvVUqMuwM9G
	URW+zVRwDijEniJb9zp18GCQeW7vY8j55C2gp/G+ClvUQp9s2I0NBPuUiFJWNsRBSIEPNMwOn/5
	+Jt7Nm67nowzBHYJ3zSyZqgK6CDJ2Zst39vbo/E8W8ZiD3I1A8u5vwUD5TvQPRkM2v/keN61tv7
	hCYH7KHJKTua8ugAtbOT7o0AI6CagceD9RJCXPPfYScJRTq1A/cflnUO0lkDSUm3cZBVpctXNx4
	2K14sHaTfDtObvwC/oG5uZSHCTfPoZoI240aGo++uddodffw3oJe4=
X-Google-Smtp-Source: AGHT+IGKqD632RpKl5VzEYBMQpnYan4XzgzGuzvbee48YOC0K/yn1Egh3tF2peeJh4TbkCddTQ/sWA==
X-Received: by 2002:a17:902:ef07:b0:294:cc1d:e2b6 with SMTP id d9443c01a7336-29b6bf9c727mr383590675ad.59.1764561391784;
        Sun, 30 Nov 2025 19:56:31 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:943c:f651:f00f:2459])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb450cfsm106014465ad.74.2025.11.30.19.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 19:56:31 -0800 (PST)
Date: Mon, 1 Dec 2025 12:56:25 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Richard Chang <richardycc@google.com>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org, Minchan Kim <minchan@google.com>
Subject: Re: [PATCH 1/2] zram: introduce compressed data writeback
Message-ID: <hgk3zp5hwlcxo6ufiqasvte3hoksy2wb2kta3fime5rprq4org@xaprrqdabvgh>
References: <20251128170442.2988502-1-senozhatsky@chromium.org>
 <20251128170442.2988502-2-senozhatsky@chromium.org>
 <CAGsJ_4yUAw_tzX7z8iizToMB8SDJPNOhFRZNXva_ae46q5vRwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4yUAw_tzX7z8iizToMB8SDJPNOhFRZNXva_ae46q5vRwg@mail.gmail.com>

Hi Barry,

On (25/11/29 17:55), Barry Song wrote:
> On Sat, Nov 29, 2025 at 1:06 AM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > From: Richard Chang <richardycc@google.com>
> >
> 
> Hi Richard, Sergey,
> 
> Thanks a lot for developing this. For years, people have been looking for
> compressed data writeback to reduce I/O, such as compacting multiple compressed
> blocks into a single page on block devices. I guess this patchset hasn’t reached
> that point yet, right?

Right.

> > zram stores all written back slots raw, which implies that
> > during writeback zram first has to decompress slots (except
> > for ZRAM_HUGE slots, which are raw already).  The problem
> > with this approach is that not every written back page gets
> > read back (either via read() or via page-fault), which means
> > that zram basically wastes CPU cycles and battery decompressing
> > such slots.  This changes with introduction of decompression
> 
> If a page is swapped out and never read again, does that actually indicate
> a memory leak in userspace?

No, it just means that there is no page-fault on that page.  E.g. we
swapped out an unused browser tab and never come back to it within the
session: e.g. user closed the tab/app, or logged out of session, or
rebooted the device, or simply powered off (desktop/laptop).
