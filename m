Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B94C278779;
	Tue,  5 Aug 2025 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754405050; cv=none; b=nLl19H3vIIpWUWRYUPGViHCXQSe+8HrTprf0X2Agi9L7PLdJRqRY9F9eh0IxBT5APf68WktHDtqX66H1JZmJGoY8W5k8CVEJVfEHqZBfyyL0K6nUzCxx4tof5kUNOb1/X5n/AL5kdcJ4LlqtlCfCu/+1YTBfiOAbEFAcexgL0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754405050; c=relaxed/simple;
	bh=3RCrq3Y4kwStmaBt0vPdSor2V1wAA1qG9IHltv+940U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fT6NfosXosR+Ui8jv48f2vrw2EmyQjgZxSZMZQfMdrNtoheXYKkdCl/HM2zW4czszlrT2Ntyz/qVLQJ97t1xvDg83IspGc7tq+ttu0IWIC3bmsPjpssvhNIdG5PBCUqyDnEjBFdLkUckO1xWV85CdFmh0ubKQcAMO3J3QU6LhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOUyu0sI; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOUyu0sI"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e278d8345aso460607785a.0;
        Tue, 05 Aug 2025 07:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754405048; x=1755009848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EC8FmgDuAlbX3oC0spWweNiEFLh02XkzDeaF4Z04SHU=;
        b=VOUyu0sIsDpLsvE2rZouEPxJs+29nbGXRjxQsh1dVWevbrXAACpcsNaERiB0ukmckp
         11uFZw9kD9yBYSWf04wCSTzSo1+aro3NwIPTVgiLFVtrY2AvFk+71AfEse9lyx3axEzt
         yT5qWgS7hL3VVP2J1RXkwQKKXaHhSYcILef1/ICIRhQ/HAbn6wJMhyYO5AJVqnP/338I
         NS7NrtxL69FnQ5yNgIATJvYjhRkyV2qkJkj8cRZHaDojpAluz0E9DGzwPROG/6yI0+7k
         Dcqfv5q6/13pZet/0rzc3dMAQAQfO5lFqXB4ynSJT12VnOH2SGQawui++JTgGg3tjq2m
         CcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754405048; x=1755009848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EC8FmgDuAlbX3oC0spWweNiEFLh02XkzDeaF4Z04SHU=;
        b=b0GAQJVGvTJBPHGImlbKrPtz0xOOFKYrEFKjZm5sHC5gLlXBugv5KvwObc0sGhKsUm
         gL8uey1X0qXQFjyLQjGT7Z7NVsZRpMX0k9bDvqYXwtQpThe25JpDiJc13VcWX+yI4cIw
         xu34twus+GImRFyeOghrq46rgF4wQP8vgqfc8PNz12TJ9qjmE1VcuKjEPVRe3/ac2uP7
         XvGhNRIL8NaOLUh7pCH6GkOBt+IyJr7sqfUAYel60mFakrgiBh+XHkPK9o/cBMTj6U3x
         t3yg1HTNuQkq/K+rnN8m+8slJglJ7/6Wb4mvpdnTWXIOKOMyGgDS4+To4LqaUzl9bO9O
         SFEA==
X-Forwarded-Encrypted: i=1; AJvYcCUx3xOsd6v1a+vh1kMwDXNimH1rKKC+Z5mvbapkIr2x6kVtBLWvt4rgdBUbpV5npA+i22rv8QbpauXhsMbK@vger.kernel.org, AJvYcCX8KV0muweyR96PAbeCMniWk172wu2PxXzy27MPo/9x/O77IUvkBtO9GfNH2II2GxqvGy4KeSml6cKc2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4se0lDi1nagx8vDoZ4P9YW+g+M3kA6rOeyaCIk1gZFkD8Un8
	YUera5tCcbt39Nk81iG2eczNtDI13l3gqEuXam38xkJMdVdyLUot6AEP
X-Gm-Gg: ASbGnctwilz/DSjXcArvkGiKqFS94w2x+LNn2DeDL0Pk83FBV8PSXcZtwSzIGgSOj4A
	Fg5tjHjWKKPCpnzC65t1EOYTAtcAs9NAa/uKLcBZ6bHIFq5m0tl/ocBFypkqdDDQrIb/oJPK+ji
	+fgMWv30IodSNulN+Hk9LSc/wUbmWp1CsVHEb3d0DUxernCQbOR0I4ExolDKnFJ4BfNi7EAgGv2
	5ZfbEpEV6YDuvMki8XqC71w9xrR74n1a5f7ttqY7Jgxu3qN9sLUIJiVRZZOx9hqwwCpvBkQU+5l
	syCIu+CroEHJlA110AQgh/GYesnkHFmgQSFmU8deeuSvgtD4zwdENCdNSZCB5M+7mSUnBazAr5w
	8ubsUN+3WX2MIhPyGAQ==
X-Google-Smtp-Source: AGHT+IFwmlbuQDVchtVefbBplOAKLwEtdkx9EJTnqYGtfQCgHXCgzzlYEM8hrigmvqRVm4hUzJlRwQ==
X-Received: by 2002:a05:620a:19a0:b0:7e7:fc71:74c5 with SMTP id af79cd13be357-7e7fc717a8fmr1348883585a.61.1754405048067;
        Tue, 05 Aug 2025 07:44:08 -0700 (PDT)
Received: from localhost ([142.186.9.88])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e8091a0dc9sm155392985a.19.2025.08.05.07.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:44:07 -0700 (PDT)
Date: Tue, 5 Aug 2025 10:43:50 -0400
From: Seyediman Seyedarab <imandevel@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: minchan@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, syzbot+1a281a451fd8c0945d07@syzkaller.appspotmail.com
Subject: Re: [PATCH] zram: fix NULL pointer dereference in
 zcomp_available_show()
Message-ID: <edvzxvoparhuqppuic5amgz5smfar54zmli73nhyojnj63nom4@kmqnjdl2af7u>
References: <20250803062519.35712-1-ImanDevel@gmail.com>
 <d7gutildolj5jtx53l2tfkymxdctga3adabgn2cfqu3makx4le@3lfmk67haipn>
 <6hs2ou3giemh2j7lvaldr7akpmrwt56gdh3gjs7i5ouexljggp@2fpes7wzdu6l>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6hs2ou3giemh2j7lvaldr7akpmrwt56gdh3gjs7i5ouexljggp@2fpes7wzdu6l>

On 25/08/05 09:38AM, Seyediman Seyedarab wrote:
> On 25/08/05 07:22PM, Sergey Senozhatsky wrote:
> > On (25/08/03 02:25), Seyediman Seyedarab wrote:
> > > Temporarily add a NULL check in zcomp_available_show() to prevent the
> > > crash. The use-after-free issue requires a more comprehensive fix using
> > > proper reference counting to ensure the zram structure isn't freed while
> > > still in use.
> > 
> > Not without a reproducer, sorry.  Per my limited experience, attempts
> > to fix syzkaller reports w/o reproducers often lead to regressions or
> > just more problems.
> 
> It can be reproduced with the following code:
> #include <stdlib.h>
> #include <stdio.h>
> #include <fcntl.h>
> #include <unistd.h>
> 
> int main()
> {
>     int hot_remove_fd, comp_alg_fd, disksize_fd;
>     char buf[256];
>     
>     system("modprobe -r zram");
>     system("modprobe zram");
>     
>     disksize_fd = open("/sys/block/zram0/disksize", O_WRONLY);
>     if (disksize_fd >= 0) {
>         write(disksize_fd, "1073741824", 10);
>         close(disksize_fd);
>     }
> 
>     hot_remove_fd = open("/sys/class/zram-control/hot_remove", O_WRONLY);
>     comp_alg_fd = open("/sys/block/zram0/comp_algorithm", O_RDONLY);
>     
>     write(hot_remove_fd, "0", 1);
>     
>     for (int i = 0; i < 1000000; i++) {
>         lseek(comp_alg_fd, 0, SEEK_SET);
>         read(comp_alg_fd, buf, sizeof(buf));
>         printf("comp_algorithm: %s", buf);
>     }
> }
> 
> Which produces corrupted output sometimes. (it's a race condition, so it
> doesn't happen all the time...)

To clarify: the reproducer I provided shows only the use-after-free 
issue where zram structure is freed while sysfs reads are ongoing.

The NULL dereference (which syzbot reported) has a much tighter race 
window: it requires catching the brief moment during zram_reset_device() 
where comp_algs[prio] is NULL between zram_destroy_comps() and 
comp_algorithm_set(). This 'can' be triggered by racing concurrent:
- writes to /sys/block/zram0/reset 
- reads from /sys/block/zram0/comp_algorithm
The window is only a few instructions wide under write lock, so it is 
significantly harder to reproduce than the use-after-free.

Your patch [1] should fixes the NULL deref, but the use-after-free remains.

[1] https://lore.kernel.org/r/20250805101946.1774112-1-senozhatsky@chromium.org
