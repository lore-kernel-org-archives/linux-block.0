Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8658525A347;
	Tue,  5 Aug 2025 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754431408; cv=none; b=KnjommMloxM3ZksoXFpt+6Pwk1o5coQ6+cJOOiNkzgeJ6BtLaLoBT4SiyzpLde6k6MsIPtgkvxXE2GnYMDK3hZXCe2X9aLEbrzqvLjwRtY+v9Q/EMKTESEUo9qHzS04y+z8KTfY96hz2OUkE8UkAIE0SYhpeJBdPXJDBCXbfN8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754431408; c=relaxed/simple;
	bh=FO5xUEB5uGtxc4S6+rskg4Mjd03nXBKPKZAGJJ4sHpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/m33yqknBE3OSBgAkNYEvJ1o7Bw0dODYwrSoqPg8ShztvMLPQEoxhM1tAJjx1av9JMvRfeG67MzPF+pOYbOoN2wDEBNKkDxuzJVvkZNl5lnoTqEyGVl/xOz2fZRE8fqJgGR8ZDzqyNF+dZ4DGAIDYjd5y7+Y0gfilPRi5fxVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLorqD+d; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLorqD+d"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e346ab52e9so736132685a.2;
        Tue, 05 Aug 2025 15:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754431405; x=1755036205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mxdT7dCQITEO/j6y9CdlLdTPyXIPxbx8KMwgO0XzYhA=;
        b=KLorqD+dnuJfXNEp1hnC7FgFH+6FKXEyDqJPB1s2BHNta8bM1cWQ89fXyljprZIQBO
         uaBSXxM0svxlrd2fgeghL4zOrtHhfC/ynd61226HFCmvhBxbpj/x5dzUn/7ZAr+xDpFn
         2OLK2ak5h64V9KveCTtAk8qZHyNPU4slNk88Hf3gF/Qf+nf63W+0/d0lZDLUXUtPTUqH
         O23xOa2y2/OIoJMzLfak0nkD/h6Z6pbqP/9t4/wtDKu3Xhh9ItflU/PjXqr/6tGcAauP
         v9MwlfmdAZkyumP7S34MOdWsbg//2OxD8xFlDKrIrL/D8qMgfNyHMcHeYMd7l+yUeo4Y
         In6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754431405; x=1755036205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxdT7dCQITEO/j6y9CdlLdTPyXIPxbx8KMwgO0XzYhA=;
        b=EroZql8IEA3Z1Gz0DhiQID6tyyfjr4y9cPKutWtpUHKOQ+JX+5sjQbthGRUMl2gYEF
         3n3TUG9/hWs7NpZqn3SbDxTR2HXPoHCoL/KUloOUN2DL7QaZ2y+gjnxhTizZPmSS4J0p
         i2UzR7XDfd72KC6578a9l/JrSTabaYpAB2XwpjQTtvouYVkJTO5UNrz+g+d29A6tV96S
         Q6igp3W1GKYiI77oPawXS81POsaE4/JGPqr1Jbcewm7/qUXs4DVzOzVSDG2fP17702Ah
         UTRCeeaKKb66EKll45R+un585JKx6Z4f+oEclvVhyb50MlAitnP+9LAn0vO3hOcerqjX
         YjCw==
X-Forwarded-Encrypted: i=1; AJvYcCUo3T1DSYOVyvmDfI/g22ZR1JiK+hjE8fi1G3p7dECqqXI4ZRe0g37mofyfzrF3u9sAt3Tfs3HuR7xRXixR@vger.kernel.org, AJvYcCXdFu2B3ovEhIK+S+uCdJg5cXPHAUfPr87hH6U4ChpJpUW6A6EKb2aHRrocz3iB5FJHnj7zSzHojidn+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVpDYmNa+lJxYqj6Sud1MRPzNxVyh96nrxrVpc8iv8OFiG1XJU
	/T0vhS9o/LxmM29NbTcoN5MLqH62CIaWWyqtMeCLaWmZQcAGHx9+tyGuU7IXFjGr
X-Gm-Gg: ASbGncvtZf15ZaXHGAKTkzOybE/6zBFhRs26H+X+smSvsvXLif/8Yb/rm5aa5JhdUAD
	w6x9AOV1omgjyBpOjIFfGf9AWnEUu4VpETNM+curEEOpNUfK0Y+QcLRIAvQBnTt+aqTCI95nAp3
	uu/QsdoL0/VJwPK9tNgO0jpKVvmIY0DgoqjJkdRId93G2FFADMQp2Yu9/toQWiPm+Vdgt19e0Vk
	Nf8Xp/BuFyWemkR1vPYHVqQm9v+RryBw0wIZHbOPlxMF9UEa7kr/efCgLmfCHe7VsagwQAM7ssf
	Zi8J4eGd3DFgywQh2J+qtUCe0n2bSIwLRGDAH5osqZSMGVDfrOQLHriIpt6G0JoQkZO4yrQG450
	ABRyvZ+SyraJUUlEIvw==
X-Google-Smtp-Source: AGHT+IGqX9TQzH6W1sdQ4GFgP61BpjdilFz0pFKFvHFbe6PIVxMTCJQGw0f0LZrgIvETLX4weiZrGg==
X-Received: by 2002:a05:6214:4015:b0:6fa:ab49:4482 with SMTP id 6a1803df08f44-7097961d7bdmr13154546d6.35.1754431405083;
        Tue, 05 Aug 2025 15:03:25 -0700 (PDT)
Received: from localhost ([142.186.9.88])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7077ca61be3sm77407086d6.41.2025.08.05.15.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 15:03:24 -0700 (PDT)
Date: Tue, 5 Aug 2025 18:03:05 -0400
From: Seyediman Seyedarab <imandevel@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: minchan@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, syzbot+1a281a451fd8c0945d07@syzkaller.appspotmail.com
Subject: Re: [PATCH] zram: fix NULL pointer dereference in
 zcomp_available_show()
Message-ID: <elixwhbyatkcaw7djpzfa6nodhxh4b4hg263ito5o5ibzewamx@nuux3sfh2g4h>
References: <20250803062519.35712-1-ImanDevel@gmail.com>
 <d7gutildolj5jtx53l2tfkymxdctga3adabgn2cfqu3makx4le@3lfmk67haipn>
 <6hs2ou3giemh2j7lvaldr7akpmrwt56gdh3gjs7i5ouexljggp@2fpes7wzdu6l>
 <edvzxvoparhuqppuic5amgz5smfar54zmli73nhyojnj63nom4@kmqnjdl2af7u>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edvzxvoparhuqppuic5amgz5smfar54zmli73nhyojnj63nom4@kmqnjdl2af7u>

On 25/08/05 10:43AM, Seyediman Seyedarab wrote:
> On 25/08/05 09:38AM, Seyediman Seyedarab wrote:
> > On 25/08/05 07:22PM, Sergey Senozhatsky wrote:
> > > On (25/08/03 02:25), Seyediman Seyedarab wrote:
> > > > Temporarily add a NULL check in zcomp_available_show() to prevent the
> > > > crash. The use-after-free issue requires a more comprehensive fix using
> > > > proper reference counting to ensure the zram structure isn't freed while
> > > > still in use.
> > > 
> > > Not without a reproducer, sorry.  Per my limited experience, attempts
> > > to fix syzkaller reports w/o reproducers often lead to regressions or
> > > just more problems.
> > 
> > It can be reproduced with the following code:
> > #include <stdlib.h>
> > #include <stdio.h>
> > #include <fcntl.h>
> > #include <unistd.h>
> > 
> > int main()
> > {
> >     int hot_remove_fd, comp_alg_fd, disksize_fd;
> >     char buf[256];
> >     
> >     system("modprobe -r zram");
> >     system("modprobe zram");
> >     
> >     disksize_fd = open("/sys/block/zram0/disksize", O_WRONLY);
> >     if (disksize_fd >= 0) {
> >         write(disksize_fd, "1073741824", 10);
> >         close(disksize_fd);
> >     }
> > 
> >     hot_remove_fd = open("/sys/class/zram-control/hot_remove", O_WRONLY);
> >     comp_alg_fd = open("/sys/block/zram0/comp_algorithm", O_RDONLY);
> >     
> >     write(hot_remove_fd, "0", 1);
> >     
> >     for (int i = 0; i < 1000000; i++) {
> >         lseek(comp_alg_fd, 0, SEEK_SET);
> >         read(comp_alg_fd, buf, sizeof(buf));
> >         printf("comp_algorithm: %s", buf);
> >     }
> > }
> > 
> > Which produces corrupted output sometimes. (it's a race condition, so it
> > doesn't happen all the time...)
> 
> To clarify: the reproducer I provided shows only the use-after-free 
> issue where zram structure is freed while sysfs reads are ongoing.
> 
> The NULL dereference (which syzbot reported) has a much tighter race 
> window: it requires catching the brief moment during zram_reset_device() 
> where comp_algs[prio] is NULL between zram_destroy_comps() and 
> comp_algorithm_set(). This 'can' be triggered by racing concurrent:
> - writes to /sys/block/zram0/reset 
> - reads from /sys/block/zram0/comp_algorithm
> The window is only a few instructions wide under write lock, so it is 
> significantly harder to reproduce than the use-after-free.
> 
> Your patch [1] should fixes the NULL deref, but the use-after-free remains.
> 
> [1] https://lore.kernel.org/r/20250805101946.1774112-1-senozhatsky@chromium.org

I need to correct my previous statement about the use-after-free issue.

My reproducer was wrong. The garbage output I reported was actually from
an uninitialized buffer in  my test code, not from reading freed memory! 
When the device is removed, the kernel correctly returns -ENODEV
rather than accessing freed memory:

#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main()
{
	int hot_remove_fd, comp_alg_fd, disksize_fd;
	ssize_t nBytes = 0;
	char buf[256] = {0};

	system("modprobe -r zram");
	system("modprobe zram");

	disksize_fd = open("/sys/block/zram0/disksize", O_WRONLY);
	if (disksize_fd >= 0) {
		write(disksize_fd, "1G", 2);
		close(disksize_fd);
	}

	hot_remove_fd = open("/sys/class/zram-control/hot_remove", O_WRONLY);
	comp_alg_fd = open("/sys/block/zram0/comp_algorithm", O_RDONLY);

	write(hot_remove_fd, "0", 1);

	for (int i = 0; i < 1000000; i++) {
		lseek(comp_alg_fd, 0, SEEK_SET);
		nBytes = read(comp_alg_fd, buf, sizeof(buf));
		if (nBytes <= 0) {
			perror("read");
			break;
		}
		printf("comp_alg: %s", buf);
	}
}

Output:
read: No such device

The kernel properly protects against use-after-free in this path. I 
apologize for the confusion.

Kindest Regards,
Seyediman

