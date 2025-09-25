Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC8827D77D
	for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 01:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758762867; cv=none; b=dGJxaGPvfb0lgvb55FzxdVxb4KsedswpAqxy3QJSgtza6eYZadCZ2yT9PjxOB9xhWfLkDk7LTWmnUUfDgRYmKqKzznearjeper4iV3gc7DcaCJvpLmw5D9HoAe9O3zlW6wu0/cCkWC154HuMqNANXf0POQ8CY3UuN8FzdbzebwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758762867; c=relaxed/simple;
	bh=CmJEc8PuIKQeVF/j4Q0UrN5IUEGXQ70xxORlJFMbhVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOnYqyYs0+nbrL6r2mmtOTXrJcVA15NwFQUg8n8oh+0IwaNGqJP87x99IBEBhPipgChJhuNe3jEK98yDtffcZlh/SCMADnaoFjaWNJ8rNYloexxlRGk8m/6iky13XcoYNfSaGcw4GrS5HzTay9EFKEBNw7Q7yqvwiimVAil8bCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnDr83f4; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnDr83f4"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-58075580105so66676e87.3
        for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 18:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758762864; x=1759367664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmJEc8PuIKQeVF/j4Q0UrN5IUEGXQ70xxORlJFMbhVQ=;
        b=fnDr83f48auqbjRYF4Y6KvqdmvKbB3cs6dlVIm7KiM7j1eJ06N3ArCQ4yTz+h07KlU
         PpVRoYfHeRy9rRVTIK3e/l75MB72N7diH348vv1nUicM4Rh3TQrLTbroojQrQc9zpXsA
         r0ZqA6bmPTKq82T1TUsmPpMvRhLH6DmN+UXKw7yYf8nh4RQ8ej4AItHW+e9bBVUyoG1m
         1jBWjQZblmG1lnXWYMKQFlAta+N1FEGPSbiCsrsA0n5k2XfizgjB1k79Kjg4X3JBs6VG
         5/laSI7st20twiB76eeYzQ2yiETRHiibcN7FoqZvEbVzvCJWp7v8mdgOFw2Gi55MvzhT
         YNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758762864; x=1759367664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmJEc8PuIKQeVF/j4Q0UrN5IUEGXQ70xxORlJFMbhVQ=;
        b=xVB9M+XPoLkyEPxbOG/zW61ReiBr+8pyQtUyrjzAghIleI6otaF9yac+gsSueNPmkf
         K1PnBhDrpAcsUEvC5jieW3LwQ2y3nmiPlSNWZO9Xl6LE+j55PfSZ7Bzj8vIi5X2bln/R
         VOIy58OZ0etbuuYJ9WZNJUSp4yConkoB5wINyEP1dlIL1JDEJHCDKxUb0J/FUnz7oJxk
         LZl1w1fgsh9cE7XseF2SG2z7cwXpDbE2DbGHJKDmNkrv175zX4FlmVXB7LFZ0q5oU2ug
         Bh2MhoAs5ubWHDQbuh6Vq2LNwMZcO9GVSfCXEH5SeArkVCHC8Q2FRHWAVd8dH+y4hjRg
         nVvw==
X-Forwarded-Encrypted: i=1; AJvYcCWHrsfhktFjbYcGY+n9blNCPd3sP1AYdPDtQk+R6newMRqZIbj/J/9gz7bKMxsU0otbnzvyfU9N0ab8RQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqYS9EpAmUl4v52TAXX5Iu9n8Dcobml5C9r+K1UbdROLtGnr7j
	ZySrdHwaJh0qHwK/RpEK+NRb4PepMS09jfBeHv/BaecD3OUBaXuEGFPCDXjTGS3iqqJkB1X1NcG
	hc5t9ywts73Y1PWtlRH2utaKoYvWAhyw=
X-Gm-Gg: ASbGncsNzDXIIMmLUn3uTh4pAnSLaY3M0Cc1jwtWldnml3+OsnXOJy4Ghey1fZ6IYX9
	BEVrtbRRZZn2Br1c0S82MKcU36W377iwxer9u8hPqyKmRDDYX4RvdPcln3SdfMOZ+VQe5P8hbeJ
	P7tsog2m1Q/QtjPU5bbXVEluU+cgiLkJWU1n+xTWbHsSHyjNyOjSapsAdhEe7Xm1apEtMTzPQtb
	z1DEZgv
X-Google-Smtp-Source: AGHT+IEDxOEhug5hAKaoFRD60f715RVpOz3j3GIYEQmZZCl+PN792xxfVmyqR8cZcVtXVUn2rZBzgNmHAva7CXKAXjw=
X-Received: by 2002:a05:651c:41c5:10b0:365:4fd1:a15b with SMTP id
 38308e7fff4ca-36f7ff189f4mr1625801fa.7.1758762863690; Wed, 24 Sep 2025
 18:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922032915.3924368-1-zhaoyang.huang@unisoc.com>
 <aNGQ66CD9F82BFP-@infradead.org> <CAGWkznGf1eN-iszG21jGNq13C9yz8S0PW03hLc40Gjhn6LRp0Q@mail.gmail.com>
 <31091c95-1d0c-4e5a-a53b-929529bf0996@acm.org> <CAGWkznGv3jwTLW2nkBds9NrUeNQ1GHK=2kijDotH=DN762PyEQ@mail.gmail.com>
 <CAFj5m9K4yv4wkX2bhXSOf141dY9O96WdNfjMMYXCOoyM_Fdndg@mail.gmail.com>
In-Reply-To: <CAFj5m9K4yv4wkX2bhXSOf141dY9O96WdNfjMMYXCOoyM_Fdndg@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 25 Sep 2025 09:14:12 +0800
X-Gm-Features: AS18NWBK4dJcK_-7IGtI0VoZd54sZXtNSb7uUlofZ2Iu7nxMDq9z6uDViCFW05A
Message-ID: <CAGWkznFe4W0M4NE_ZjiSC6+28tHqJoah6dmP+X1aP6oCCTTe2Q@mail.gmail.com>
Subject: Re: [RFC PATCH] driver: loop: introduce synchronized read for loop driver
To: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Suren Baghdasaryan <surenb@google.com>, Todd Kjos <tkjos@android.com>, 
	Christoph Hellwig <hch@infradead.org>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com, 
	Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 6:05=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Wed, Sep 24, 2025 at 5:13=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gma=
il.com> wrote:
> >
> > loop google kernel team. When active_depth of the cgroupv2 is set to
> > 3, the loop device's request I2C will be affected by schedule latency
> > which is introduced by huge numbers of kworker thread corresponding to
> > blkcg for each. What's your opinion on this RFC patch?
>
> There are some issues on this RFC patch:
>
> - current->plug can't be touched by driver, cause there can be request
> from other devices
>
> - you can't sleep in loop_queue_rq()
>
> The following patchset should address your issue, and I can rebase & rese=
nd
> if no one objects.
>
> https://lore.kernel.org/linux-block/20250322012617.354222-1-ming.lei@redh=
at.com/
Thanks for the patch, that is what I want.
>
> Thanks,
>
>
> >
> > On Wed, Sep 24, 2025 at 12:30=E2=80=AFAM Bart Van Assche <bvanassche@ac=
m.org> wrote:
> > >
> > > On 9/22/25 8:50 PM, Zhaoyang Huang wrote:
> > > > Yes, we have tried to solve this case from the above perspective. A=
s
> > > > to the scheduler, packing small tasks to one core(Big core in ARM)
> > > > instead of spreading them is desired for power-saving reasons. To t=
he
> > > > number of kworker threads, it is upon current design which will cre=
ate
> > > > new work for each blkcg. According to ANDROID's current approach, e=
ach
> > > > PID takes one cgroup and correspondingly a kworker thread which
> > > > actually induces this scenario.
> > >
> > > More cgroups means more overhead from cgroup-internal tasks, e.g.
> > > accumulating statistics. How about requesting to the Android core tea=
m
> > > to review the approach of associating one cgroup with each PID? I'm
> > > wondering whether the approach of one cgroup per aggregate profile
> > > (SCHED_SP_BACKGROUND, SCHED_SP_FOREGROUND, ...) would work.
> > >
> > > Thanks,
> > >
> > > Bart.
> >
>
