Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912BC290F
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432240; cv=none; b=ganjdcS+c25gT1BJgDURwDanUclhP2hn3BtscwU6QrgLGHtSMhaXI2zP7I0gSlf4HG1sWDq4Y4gnfndGHQ2MBbow4Wvv+ASny0CBCUwnjE+mnEQTsml9SjYLUafDZG2X3ggPBA2l2nzUwYgmSukVeM1lza7aeojGkeaHNx0kJk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432240; c=relaxed/simple;
	bh=HAhE1AD83wdqoRBDAiaKCKYh6ZJDcT/I9ng8cQ86JmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utqlZtBCfsJNTanDa/jiXXswcDdR1uUuinoKu0eC7xCG5QvuQNGi3FTE4q3E4Y1kPahJmz3z82GnD3ahBnTBdbsT7LvOOO5BfaTkgFJeJRZysTUNr3/Guf5ZVaxU61toCuRNkSgR3He5/A3BfDL5e37b+qLFmkOK8kWVdBFKSus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j73PAeno; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j73PAeno"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so1312320a91.3
        for <linux-block@vger.kernel.org>; Thu, 09 Jan 2025 06:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736432238; x=1737037038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeZi1HN9XgZY2RYtJxTtjcc5xHVEtKCTqeUFBHqXqM4=;
        b=j73PAenoZ1k7OWT3dLmz/o7hVeSf2oNH2KB7ZPbot09zMy1p3vSHmKZqfGXjh96i0w
         ThH3ub4SYLqF4vLOJTuhLb9N3E+TBt7pAexkq4TvU0IccK394BmrMV0d1HoNGxS7fBXk
         MhK4gtR/B8PaWIPkE+cWVoKsgisVVqkN2L1PZznFfqEb2EYGwY5liWh8pw6r6iWEQ9MC
         AlF1drgg8trDkJ7igoi5+5UvXIyjXivygbUM2uZQb+e0VOsyYqJzNidJWMTPH6LWU1xC
         HsgAylLqEHExL7XEsAgXixeYmQLL3n8Y2+Hbf7HSFzwdPI971ae0zXJ3fW5ym24bQVWP
         ynGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736432238; x=1737037038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeZi1HN9XgZY2RYtJxTtjcc5xHVEtKCTqeUFBHqXqM4=;
        b=SrILXWMgFZ9HRp0Hfr8LcGlCthxTDSZomOZfN1Tg72dXhbKdo8AII+vYSDbkeJSUu/
         Ma/vaGV01HdMbLYxD8fM9XEIjVCFHcvutx69Du/OgQcJfwNCDJEiGBPbHAxRciDkBJYY
         8zH2Ez44HQG0ryLhgPCKmwLhffqctiiAwsHy6OyhBZuNasQkxBO7j8AKqTPU7Syvwq+r
         iwCq8iXot8vNBFl2/2eBfMXQiX4rKEqKNt2C+K+i0mdhNM1b/TZ96OeHNH9UWszmHH18
         4YPYK46h/Usm7DE1zWP7Yxa56WbPvaWnMGSMPD+dnx6rPQHQLVNuDXgFbQHPSPGx8Iqc
         zG/w==
X-Gm-Message-State: AOJu0YwGzOHrU3TrwW2wCxcTIVw2mwrx96lt5g9wYvsWSjqnCVnXSyQd
	jL/t9DnEw6QhusOVeO9iMIU57UOzNetTiivrLsEWBcUZRLcOa0Wk8IKPbeFXgvxOQbMI378Xuxu
	9WeTZkNytHjH03j5dLONi2as99Qg=
X-Gm-Gg: ASbGncsCYZlp/1jGo6YaPBTtPscOw27IdoslRyMlsFNnOWP4eXfdKimN0gwz1wjHYzJ
	mmy0vgfsyQBqKeGqLnqxAgcVEdN+af1dwMShEpmY=
X-Google-Smtp-Source: AGHT+IH/zoFssunbUa/I62GF+1omygqIrLA/4t01uYb/cYV+9K9jhgTFBSjixqu/3JMnm9a49c7JYaAJMMq6lBRCz3w=
X-Received: by 2002:a17:90a:d648:b0:2ef:1134:e350 with SMTP id
 98e67ed59e1d1-2f548f4273amr10424729a91.35.1736432237556; Thu, 09 Jan 2025
 06:17:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOBGo4xx+88nZM=nqqgQU5RRiHP1QOqU4i2dDwXt7rF6K0gaUQ@mail.gmail.com>
 <20250109045743.GE1323402@mit.edu>
In-Reply-To: <20250109045743.GE1323402@mit.edu>
From: Travis Downs <travis.downs@gmail.com>
Date: Thu, 9 Jan 2025 11:16:41 -0300
X-Gm-Features: AbW1kvZmwsXAFazhkNdZ3ASGoMqtSmC5uaUo_xRtTP_haMS6ji30Uj6GC_VFbDY
Message-ID: <CAOBGo4w88v0tqDiTwAPP6OQLXHGdjx1oFKaB0oRY45dmC-D1_Q@mail.gmail.com>
Subject: Re: Semantics of racy O_DIRECT writes
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 1:57=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrote:
>
> Don't do that.  Really.
>
> First of all, your program might need to run on OS's other than Linux,
> such as Legacy Unix systems, Mac OS X, etc, and officially, there is
> zero guarantees about cache coherency between O_DIRECT writes and the
> page cache.  So if you use O_DIRECT I/O and buffered I/O or mmap
> access to a file.... all bet are off.

Thanks Theodore for your comprehensive reply. I probably was not very
clear in the way I posed my question. To clarify:

 - There is only one process involved here making all the writes
 - We do only O_DIRECT reads and writes, so I don't expect the page
   cache to be involved in the usual case (but we can't exclude it entirely=
).
 - So the question is large about the possible outcomes of doing a zero-
   copy O_DIRECT write (where the block driver will ultimately be reading
   directly from the pages allocated by and passed to the kernel by the
   userspace application) in the situation where a portion of the the passe=
d
   pages are modified in a racy way by the userspace application by a
   subsequent O_DIRECT write.

> By definition O_DIRECT I/O bypasses the page cache, so if there is a
> copy of the file's data block in the page cache, for some
> implementations of some OS's the page cache might contain the previous
> stale version of the block, so buffer reads might not have the updated
> copy reflected by the O_DIRECT write.  And if the page is mmap'ed into
> some process's address space, and the process dirties that page, that
> page will get written back to the disk, potentially overwriting
> O_DIRECT write.
>
> Linux will make best efforts to maintain cache coherency between
> O_DIRECT and the page cache.  It does that by writing out the page in
> the page cache if it is dirty, and then evicting the the page from the
> page cache.  In practice this will be good enough to keep programs
> like a database which locks the database so it can take a consistent
> snapshot, and then does the backup via buffered write, when the
> database normally uses O_DIRECT for its transactions, it will work ---
> since if the database wasn't locked while taking the backup, it would
> be completely a mess, and the O_DIRECT vs page cache coherency is the
> *least* of your worries.

Note that we run only on Linux and are heavily tied to the details of linux
AIO and io_uring, so an "Linux only" response is fine. I am quite sure that
after an O_DIRECT write completes, a subsequent read through any
Linux API is going to return the newly written value, not a stale value fro=
m
the page cache.

>
> But in general, don't mix bufered/mmap and O_DIRECT I/O to the same
> file.  Just don't.  It might work, but remember that raison d'etre for
> O_DIRECT is performance in support of databases and storage systems
> where developers Know What They Are Doing(tm) and Follow The
> Rules(tm).  Linux's cache coherency is best efforts only (and other
> OS's might not even bother), and database developers and sysadmins
> would be sad if we compromised O_DIRECT perforance just to make things
> 100% safe for people want to do things which are breaking the rules.

This is us, we know what we are doing and are writing a database-like
product. We are heavy users of AIO and in fact many of the discussions
of AIO and O_DIRECT behavior here on the LKML and elsewhere are
driven by users of the same framework we use (seastar), so you can
consider us expert users from that point of view.

>
> If you like breaking rules, don't use O_DIRECT.  You'll be happier for
> it, as will hapless future users of your programs.  :-)
>
> Remember, good programs are maintainable and portable.  What if some
> one attempts to take your programs and tries to make it work on MacOS?

Fair enough. In our case, we are writing a high-performance, clustered even=
t
store (Redpanda) which is a piece of infrastructure with very little demand
to run on anything other than Linux, except for "dev" scenarios, where
emulation is suitable. We make heavy use of aio (later, io_uring) and tune
for specific kernel features like RWF_NOWAIT, etc.

Thanks again,
Travis
