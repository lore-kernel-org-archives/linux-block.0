Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AD017A2F6
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 02:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754449136; cv=none; b=CMJV4qkRDGK6Y6+rVw866AI0lJ/KPRyfiSvIujSuBs3zio1gTeyYd0DxYaXbUHnfLC39+Iywha0XxS5y16W3jOpW6WGh/ARjmWnCvMnUFqKGqyxw0FyKguoVtlsc4WV9NIs9P+KhXYGslWOUTWbuV+MuhdAGpq4FuiwgpUrAOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754449136; c=relaxed/simple;
	bh=t96KIHl3o8o/01DWmztfbOb1bGxRH3j7rU9fQFrfzFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIq6O2PuUM3ttAbpISUfGHooxN1s6WnrAlj+uPYsyNI7SGwLgGtnqjUS3wRXaasBPhljrgxHeLMMWYP05Bgq1rRaYWfy2wXAATfZ83gv99LEGyt9pP4g/7XiqJr5VgC8+UnzX542AMOtQL2j7LXoZu6md8oLbfGH5A11bFm/yZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ia5yhXqX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ia5yhXqX"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31f3b54da19so4252352a91.1
        for <linux-block@vger.kernel.org>; Tue, 05 Aug 2025 19:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754449134; x=1755053934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dfI2/EUStwEeHLBjx/Qw57TggouFa/RBsyWtj84i+Do=;
        b=Ia5yhXqXKkNBxN+obQcORUNAkXjiYFV1Fq5qfF8G+dEht6MjEx13Wrok18m1ihpzwD
         gbUxaOjWcKQ/UoGBTaIO1ft6yWriOHGHIvoZ2J2zcKhB8JUvHDpdfse0QB2zhmY8bUax
         aMGAtOYFLFstM1E6/GzR8WlHlb9wHwxVmOouI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754449134; x=1755053934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfI2/EUStwEeHLBjx/Qw57TggouFa/RBsyWtj84i+Do=;
        b=griNUoSy8T4/xcnb0SbsqqY1/7PpeQoBAS3vZZdtaDFTmzssDH5s+WOd6c8bJ5Ygma
         LaOzjQwKRYGvUSuHGnhFv14asl4osQbPcdiSpbOM6/M4qTvXlVrGcAyah/wfJf276BOF
         YPZnjmqmffNG0X1jyxjFQtkiIm+jmEUgdSa8EGaoJjtdDV8PkfT3J1xtpMpErBE6SreF
         NcEJEnWGUcsezoxqZBJqj73DylabkGl2UefqEykFi+E03vbQh5GekoRzpKsOrYATTjqh
         V5PZ5fW8b/Va2tPPwEEaYwN/IqZidt4aAHvn/BYzfNRjNO7knnhvcH8hR1N0VJ7v5doA
         pLAg==
X-Forwarded-Encrypted: i=1; AJvYcCWLOxGw6GULd7VHlKA+PMepMJ0PpngeSO6cj3sgoN7UU4Nf1KsuglSWhF3EqnvP51vj8X1Biy9MWhNBfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeqFauaeezdaGZWXgCHma2wNBDcRvtxe9DJiM4Zyx3EeMJYyQ8
	1rBTTvyRYvBEiOZT4oyn+3YA1NAZq+h20TQBnvL5A8B4fXtvUgeP6PUt27w9fPhIMg==
X-Gm-Gg: ASbGncuB6gUJZ8in3swprGT2gbB3RnVT5U1NgXXeYu1Q+ddeC6qxMRePspNnLUTb3sH
	3mUl97z4SRGG4jVIjujRS9osM75QKRDGFo0KkW8PH0iAE27HNX7812LkvTq+ktNd2AasLdlKNSw
	9YhCYUVYySy03bNYLPdzJhHNQO3Io1mIcN9rU8H4upAeDeo2A9cWpaXCp1ALsEFzlyz0yVBTrQG
	/V+f7CDjLz1Civ2HiF/GWoOV1VR41wRdALl1gLO4+HcfuqtV9REi5Kd90yokApX9a4vnmUEizzO
	5tKVeRG2j0GDeL9arW9+4p74cUf//hYOR8Z2rYvTvM4EYWTgeUndO938qH8iq5BYmHAboMToSAu
	58TwC2zgaw1g8tdtNPcXQ8Jk=
X-Google-Smtp-Source: AGHT+IGw0u3Yt/rwI0EXQXBc2LWgvbdwvZIG23v14ikG4dlkYmTsPpd8+RNDzIsBOgy5fSED1HkM5Q==
X-Received: by 2002:a17:90b:2e51:b0:31f:6d6b:b453 with SMTP id 98e67ed59e1d1-32166cfc84amr1545302a91.30.1754449134450;
        Tue, 05 Aug 2025 19:58:54 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5a2c:a3e:b88a:14d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216129c8cfsm1438665a91.34.2025.08.05.19.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 19:58:54 -0700 (PDT)
Date: Wed, 6 Aug 2025 11:58:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Seyediman Seyedarab <imandevel@gmail.com>
Subject: Re: [PATCH] zram: protect recomp_algorithm_show() with ->init_lock
Message-ID: <fm5et2vgfl5npfmivdpwj7lb5ztrgmvst4kbvxccisdnudyhhx@5szzuwprhmgw>
References: <20250805101946.1774112-1-senozhatsky@chromium.org>
 <20250805150323.0f5615ec97de2cc5d50b0b6f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805150323.0f5615ec97de2cc5d50b0b6f@linux-foundation.org>

On (25/08/05 15:03), Andrew Morton wrote:
> On Tue,  5 Aug 2025 19:19:29 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> 
> > sysfs handlers should be called under ->init_lock and are not
> > supposed to unlock it until return, otherwise e.g. a concurrent
> > reset() can occur.  There is one handler that breaks that rule:
> > recomp_algorithm_show().
> > 
> > Move ->init_lock handling outside of __comp_algorithm_show()
> > (also drop it and call zcomp_available_show() directly) so that
> > the entire recomp_algorithm_show() loop is protected by the
> > lock, as opposed to protecting individual iterations.
> 
> As always, I'm wondering "does -stable need this".  But without knowing
> the runtime effects of the bug, I cannot know.
> 
> Providing this info in the changelog would answer this for everyone, please.

Sure, Andrew.

The patch does not need to go to -stable, as it does not fix any
runtime errors (at least I can't think of any).  It makes
recomp_algorithm_show() "atomic" w.r.t. zram reset() (just like
the rest of zram sysfs show() handlers), that's a pretty minor
change.

> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Reported-by: Seyediman Seyedarab <imandevel@gmail.com>
> 
> And including a Closes: for Seyediman's report (if it's publicly
> linkable) would be great too, thanks.
> 
> I'm guessing that a Fixes: isn't appropriate here because the
> bug has been there since day 1.

Yes, also there isn't really a public bug report there, I just noticed
that while looking at some things that Seyediman was looking at.  So I
wanted to give Seyediman some credit.  I suppose I probably should have
added
	Suggested-by: Seyediman Seyedarab <imandevel@gmail.com>

instead.  Should I send a v2?
