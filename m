Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F22D600
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318719; cv=none; b=p1WPfPjQIyv8CEjm/7dSk6Wi/GXhMl2f35fPI7gN4HbnPdP+E1rEkux1wi5ujA8ika68uvA3zxtUgr/dB5TC9QKk5aVVOBF50txz+A+P/sMx6PStIOig8NwYU9m/a1gwOLVcSzSmNBnY8q8aPtQ4DV03h1rr5WdlQEBdgBn5DGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318719; c=relaxed/simple;
	bh=m2RHOwNehHpqHHo8iTUQFAX2G1uH1oLG9AUA3ukXizo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJsX++r7+2UEoWPUtH1mTHRoWCmWaLE4xO+H3eXQiOhkOXPEMkRy0fs6xBCzf4glxHDtdPQS+9lPM6b0vTHgbmxa6ma+WWU7iAaR3Pto+Z2NXY248TGOY++Qw6ovz9BcI9w78G8796YJfemoQ8VjbIGP+pd0avQCY9VsOlQYqfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FlwJgQ+0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FlwJgQ+0"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2963dc379so736860666b.2
        for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 03:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1745318716; x=1745923516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m2RHOwNehHpqHHo8iTUQFAX2G1uH1oLG9AUA3ukXizo=;
        b=FlwJgQ+0d/7BWCpfHKy7fLb0o1MzFwHJoEWXh75Llt05G3TuYuwBqX7fPEXuW1Qq3U
         o2+LTyZ+MoXlXX+gsdLtraRKo3YOd7q/c4MmZ9QAsTE8Cafs7aj+B7jhZPDZZ98Jk2bO
         DJtamS589LLghamNAtzB3I0mg0+SLFdP0C/1kR6idJaU9I4ryI4870Xj7q8BEmcNvlRh
         kdcZgP+p68rnbeo1w4dRN27BvMFKufQpNnYTPIM46f7lFOZA6NVXDGWqS/uidotmkgDa
         ozq755AnwZeUBOuLwXG/zwT0J6C1/sHsr9PxSQmFvL3VUvlaYrexXX6pQ7DsV4SEm8kk
         CAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745318716; x=1745923516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2RHOwNehHpqHHo8iTUQFAX2G1uH1oLG9AUA3ukXizo=;
        b=k38enUvJHidpwsyrq2mgQHcM8HtzVBI2u+77TwYSehu/oJ//aIFEGXllGpgf5CJkgj
         55EEISCymWNvJ34T0IPG/h7FAFGkDZtkbk7GoEv3Tek7XzRYVrta0kAfsAjBdM3W9ia2
         30BXFfBi25YfLNtUdgnl6phfjdLlbzbP6VV9gk8pNaGtXEe8dLUWuBJf5u4mDZMJKGcc
         I05Xa7PsLF0kJvJaeGr2Qnw+w2xsBd5mmAd14SXBAx6V+EfsQ4t/iVtWr32sU7bwR6Ac
         B46jfibKSNqBi5UnzBYmao4fC1VVYMPI+pgU2Y7X/L/Hv9GJm/Zb9Zh8LxKoMToBYS0A
         M/IQ==
X-Forwarded-Encrypted: i=1; AJvYcCURoK1sJvlCq/VAkxBCSiL+cGtBkUEiSOLpTcERgqTsPjjMVEWlNTi82/i0aFu22thFuPntYShyU5UhTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtCyEMIHs2cMD1EavemN0uQ591Bp6wp0UmXHYXIYia89+zaagx
	gUZzRUzZYIclyia/AYxu1BBfdxE5Tbc3RBz/zBEzLjx+DM9EoL9CfXOf6r/voh8Hc6NIbQ36LeO
	/niNfpBc5Yb8WZFix6T7mbKETi2Wq85V7aCAMUg==
X-Gm-Gg: ASbGncsIW2o92u7BH2/kNt+/Y4PwXpLKd+mHrvTcT/sFkJRpRJTV4Hh+gLZchAMPYNB
	0nCsXg6YQv2bBbfaPF4kExbvOlm8EOjygli8hvxE4PQNTD7xPLeDENheL328rCYy9FT/PmGoZeT
	f3Hlm0EyMnTnf3/C3kW0iL+fQb3iQnv4ikLVBkwA==
X-Google-Smtp-Source: AGHT+IHx+3eNU+W1xgJPDHKdP9KuoPOiU85NmVMn/OQC3c3TyiEnbo5rA2WMCiD1pOnvJZdMuo/65psXoAv60jJaYi4=
X-Received: by 2002:a17:907:9450:b0:ac2:9c7d:e144 with SMTP id
 a640c23a62f3a-acb74dd546dmr1353350066b.40.1745318715647; Tue, 22 Apr 2025
 03:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
 <aAZiwGy1A7J4spDk@kbusch-mbp.dhcp.thefacebook.com> <ad67b397-9483-d3c3-203e-687cefb9e481@huaweicloud.com>
 <aAbzW1POQP9z5BWS@kbusch-mbp.dhcp.thefacebook.com> <98915ccf-4fe8-5d96-0b59-b3f3d5a66f81@huaweicloud.com>
In-Reply-To: <98915ccf-4fe8-5d96-0b59-b3f3d5a66f81@huaweicloud.com>
From: Matt Fleming <mfleming@cloudflare.com>
Date: Tue, 22 Apr 2025 11:45:04 +0100
X-Gm-Features: ATxdqUEU6a1Z9Pu86iXO3XxDIu9CG7yYHsljL0Nlj0AZhY84eugrTgGJsExwkc0
Message-ID: <CAGis_TV7gq1fHM0YFz798G91poeKQWYo2cZq0eEo7ydT1Qen+A@mail.gmail.com>
Subject: Re: 10x I/O await times in 6.12
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Apr 2025 at 04:03, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>
> So, either preempt takes a long time, or generate lots of bio to plug
> takes a long time can both results in larger iostat IO latency. I still
> think delay setting request start_time to blk_mq_flush_plug_list() might
> be a reasonable fix.

I'll try out your proposed fix also. Is it not possible for a task to
be preempted during a blk_mq_flush_plug_list() call, e.g. in the
driver layer?

I understand that you might not want to issue I/O on preempt, but
that's a distinct problem from clearing the cached ktime no? There is
no upper bound on the amount of time a task might be scheduled out due
to preempt which means there is no limit to the staleness of that
value. I would assume the only safe thing to do (like is done for
various other timestamps) is reset it when the task gets scheduled
out.
