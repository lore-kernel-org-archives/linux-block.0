Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7A2287258
	for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705221; cv=none; b=ucgJctqOKWaIGhfDgsBxyL6rVOv9JmkHkrht+I/R+VA50LOqMAHMZ1DdC2IiAxVuqW60z6/sPhmKrY7HQZdAjXOItDvaXeGRNyQ8XbytAaQwt8UlcuB7fdYWC5MHnrDn7+1Ybpg4eXMI4C8HiTdmZR5K8q5msvJkB2eHo8ukpmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705221; c=relaxed/simple;
	bh=Af4Ct/KfBWF7p2rMZKnvJgS35hmQrVUjUNoUpz5WfU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O64Lus3Qflr2pQeJIFnKDtx+THZJBwoP9gkZqmXBhG/VbqZgcAUSXiZ9DSUsZnqlfjpCj6aceq/7zxmVkRik6KdaZANcroouUrOuC+EJCXdSTiajNtjckizgDsrGKW0TaIDRLMWhGKvUoO6poNvIpFNDIG867oYtX4rauUg0ERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI7/qzD/; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI7/qzD/"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57a8b00108fso995532e87.3
        for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758705217; x=1759310017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Af4Ct/KfBWF7p2rMZKnvJgS35hmQrVUjUNoUpz5WfU8=;
        b=BI7/qzD/A89JjyNVqj6KS9aMFeToLqqSQ2ht6XbUIiIwvTbJp01H74rteHxlWqfBQY
         0Ajr1xWyC8r6zdx8MGd93IefYjXWvzRCVBxYUfqs3uVqh1F258MYyXPKAHRMAWywDFPY
         7b5t5tFmSM4+RUwdwOk+a9al9LBi/TlvZSltN1cJb5Fh9UsvL5ML9iCt9/LH2JQLjuOH
         6JKsZ4o5oD8aJcgrj8vmgOMyM96kPnW8PKoPwXYtMKoMb//Zk124IBfhWzp/c2DgLhL9
         8yFfM2vlU0ZPN6gIAzyKqLYUzKB2HkvdmM4kVwuowQJ/brAoI84febJEwCW2XfVYQa8W
         NWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758705217; x=1759310017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Af4Ct/KfBWF7p2rMZKnvJgS35hmQrVUjUNoUpz5WfU8=;
        b=XlVaSrMDeK60g+R6ZVIPTvLe8x3v6JDckyShOGAfbLQh5egGb0et7M8XM4uBNilpbj
         3Xk9GqHp08HfwuG9h1I8DWRxH4u4U6nQDGExTg/J6StCKZ6iKv2cZg1PVruVr1bEUpY/
         n4fdRFaQ7vtMV7nZ/gAAgLx/ub1HVjTw38+eHNoOjUOAcYRwlkCrwrfU0QjUXWygJupA
         9tgKDXFq6deFXbTLb85PGi72JaAZNIgbiTL1MseNVVQFqzUORG/gdMjP+xQu1EE1E7lO
         VxQKAAEOIPdIh6yqoQtrymg7nr7od1YeZdeOkd8boO3cEWUx4TgZAlzTJAUPJ27j4s23
         p8/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXy7SDT2HcAf/sh7EQgQPx1Hu1psnCoCD93wrzrMGKKlRiAtcxXU8/d2u2TEei2m1H0ODgOgXCLJT6Xpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWIGMuQDAWVgD9a1PSld+OazD4q5qcXTWq2qgk7B22J5M6LvC9
	6lrYPLWjFxxsdDAPe1H6Aqx8A8xrTnuRD+HGzB3wxEh+hDcR9HhFxci4NjcDLQyzb7n8mYbVnAC
	blSTCi+zYokMkTdiBMUgzQgNzkM4FqXg=
X-Gm-Gg: ASbGnctlWkHm2LgwKZQeGC+YzuMdDYJEj9kMoxms4pDxg/lwZljdWh79QWyRcRuBZMH
	h3FWntdFv9wsFUWUJe/nL3I+ztVZ49F4yIo8ckREtTYZyqxBu/PDh1/n35owfkhdEBht5a9YuRu
	s6EnT0JivgFcpBCgCXK44CFhu516ukhYOgYaSoDi1plIsxRIFOC5bnxBiZR9NVWXAgX4J14J3HA
	7eH0w6+
X-Google-Smtp-Source: AGHT+IGs8N2Za5uD7V8CJlL7/UBfxVMm9tPDgKV7PBembRGnfUF9U37ImFXt0pqlo73lGmzPgv3o+6kGEtm+zgslSZg=
X-Received: by 2002:a05:651c:2205:b0:361:774b:8b2e with SMTP id
 38308e7fff4ca-36d121ba628mr9245421fa.0.1758705217099; Wed, 24 Sep 2025
 02:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922032915.3924368-1-zhaoyang.huang@unisoc.com>
 <aNGQ66CD9F82BFP-@infradead.org> <CAGWkznGf1eN-iszG21jGNq13C9yz8S0PW03hLc40Gjhn6LRp0Q@mail.gmail.com>
 <31091c95-1d0c-4e5a-a53b-929529bf0996@acm.org>
In-Reply-To: <31091c95-1d0c-4e5a-a53b-929529bf0996@acm.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 24 Sep 2025 17:13:24 +0800
X-Gm-Features: AS18NWDh4YoKVvwiPJPTuArIa4_L6TIXxcKByByVO2my4d-ujrstbeY6JtaK-p0
Message-ID: <CAGWkznGv3jwTLW2nkBds9NrUeNQ1GHK=2kijDotH=DN762PyEQ@mail.gmail.com>
Subject: Re: [RFC PATCH] driver: loop: introduce synchronized read for loop driver
To: Bart Van Assche <bvanassche@acm.org>, Suren Baghdasaryan <surenb@google.com>, Todd Kjos <tkjos@android.com>
Cc: Christoph Hellwig <hch@infradead.org>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com, Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

loop google kernel team. When active_depth of the cgroupv2 is set to
3, the loop device's request I2C will be affected by schedule latency
which is introduced by huge numbers of kworker thread corresponding to
blkcg for each. What's your opinion on this RFC patch?

On Wed, Sep 24, 2025 at 12:30=E2=80=AFAM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 9/22/25 8:50 PM, Zhaoyang Huang wrote:
> > Yes, we have tried to solve this case from the above perspective. As
> > to the scheduler, packing small tasks to one core(Big core in ARM)
> > instead of spreading them is desired for power-saving reasons. To the
> > number of kworker threads, it is upon current design which will create
> > new work for each blkcg. According to ANDROID's current approach, each
> > PID takes one cgroup and correspondingly a kworker thread which
> > actually induces this scenario.
>
> More cgroups means more overhead from cgroup-internal tasks, e.g.
> accumulating statistics. How about requesting to the Android core team
> to review the approach of associating one cgroup with each PID? I'm
> wondering whether the approach of one cgroup per aggregate profile
> (SCHED_SP_BACKGROUND, SCHED_SP_FOREGROUND, ...) would work.
>
> Thanks,
>
> Bart.
