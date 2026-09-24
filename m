Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148CA326927
	for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 04:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224507; cv=pass; b=Y+aUmfEfv9whsC+OjrB50wIcjnLQV6hwR0o9gK5wWIEtiXhxKaOpqe68jkTApuxSFy2Zr+Gztfnu1ohWstYYnIjDhvkaVxmPpz3OJRcJuCw9jLXh1aQVxAd4evYzURmNKSJHonqlAA9ao2N+AMnREq0Sd5FpFERUna9nf3YpNWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224507; c=relaxed/simple;
	bh=th4Y241gR8fKqXdszPTrMDgI2QzkfuYH1UjS4q/XE0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFDVcRJWgxTUx7hB2iYKPRWYp9mlB4lBAFBgXwPdiEQX6Ox8elwg+3kN9cl9ajTKO/6BQKNpOHgUvuxKuF+D5RSDmFPSpK+1QhpICV7k89KemfNTZNvbol3ZWlvT7ZRJamPDiC96iF7g4jcoKKfdOl+pSaobD9tKT9MOfzCpVVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn0yF/PV; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn0yF/PV"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a36887bso981640b6e.2
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 21:35:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790224505; cv=none;
        d=google.com; s=arc-20260327;
        b=E9yRrteESj+yGnffus5OGbxES4jR9L28XdXNQ06YPgqD9l3ekvyxdHyrgmQHzouOmE
         Y5UBrZ5WVcC/9lJFlJ4XiftDM9qImqQYe3tsiKQlJy5QIPOO0NVYAkd1ej7FqgsMthOa
         OQ623dfTxLy6nq06QtpedqC1+YLShRrYo1p1NNRAqEjWbW9KwAndz8qrTKEpt3wvwRsk
         bxxy41HDD/um/8VWfSYpH+/v7UkG2xd78NJag+NHR26hsGc4gJLtih/yVMxfkrIrIpsq
         +aoTSGXYGGruJO3BtkyvCnFkXFXg/kViY2HKnDqCoy1N+IOsYW8lcGPZ368NsZ01lWkl
         /FUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HgPIQmEvwYaItDda9jIvvcgV4nx3Zf69aHXsVWLINFs=;
        fh=S/UMyiKphgCRdQHmtRBrtVDX7/xN6T5pr6OJc+oYL14=;
        b=QlrWPbmgAbJu7OIjQy9Ru8Wy+Bz1MRQqiNeUBp7HzQn5QvXJ6e4AHCY13ybAGmuErs
         odL7ls7uwz10HoN4r5alcaHEy7DUiqtXL9V4g9tZX6Zh5pudxqxfsBHgo3Q3gM47dOtg
         69fdqf4jsTc7GfiXFw9V+qpuXZxWRXDgBPZ0dg1BA40ATZUlFSzqjYdxovc+o+gmOKmb
         /OjOOj/44aIsUDJKsbe6EPp2vZ0VpoSM6qmf310kVg3C/yRt4+2TSuJnInIjEPf8L+Nc
         7U1QBDR5/bzGNugWymiu3porvYxAKCOf3HQBk9rVcAHGaBqg3mxAtqgcFYXA5gUPVmER
         TKpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790224505; x=1790829305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HgPIQmEvwYaItDda9jIvvcgV4nx3Zf69aHXsVWLINFs=;
        b=Yn0yF/PV+g1RlFbDOnz3BVwuIlFOiZkSVx9KP8g9JJeaiPf/TB7+EAkKOzB80b0Iy4
         ZWASIaRpVAjMSxa+V80uzprm9U65TszsVkBeT8OgaGR7QthwnFstQHNT2W0AbkhyKp3+
         yit4S/I77KtNKm9MVfYwkL0vJ5lLO6dTffb3N5Q2jEX6lldmUZ/6SEe82WdSzCPyxoc1
         A+/T7jTV3gL3zpvS799EPh34D2EgigO5yP9P9iUdOnykei9r+IvIw6Kq2UE0dDFE2DMZ
         qeUdj6ms6Gez9aF6jCdHxQfj1O6IKHUpPeML4ge7l49SRhtEb2VIigkauQB6FqexXzIH
         x3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790224505; x=1790829305;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HgPIQmEvwYaItDda9jIvvcgV4nx3Zf69aHXsVWLINFs=;
        b=W0TTPNM9rWflB33eFkIusEJLijXBJ5zs5RHFUI9dfROuo4ZwyQWy3YI8mNhC754130
         XRcumplq6+QcWSsgvElxuoycOGPpDgHvOVzb83wfrHnGu3inKyF7dlvzL9Act5v6F98c
         VZpP9qTuEEGISEfcU/A19yBAF9qcTmOzNKLPmvkWM+Ak8wv96LVWYMpjsMUo4frD+eeE
         6eTs3S256qiXeum3ZbDzFD88lam7gt40/XCykfpZj64kt0Ws4QFRpGoKe87WTDhRY4Ka
         w+V+jBYmdfufVZSYr8F24WTBVGehU2PqWojCNF2nE1p+3nJhneNz8LG0cgWM3Tg6s3+V
         RBUw==
X-Forwarded-Encrypted: i=1; AKwUvBwKsnbBhkD/FbEHSJ8EM6GBdwQ85ypV3+49htJK9S/spoq7bxU5+ehH/r8RT8ACzY95HA5Omi8qlovdww==@vger.kernel.org
X-Gm-Message-State: AFuF++kPhvFkzUQ5+XQd4rtWgVrL4lsvhOLiqA3JzkXWRaF5noHZFpaW
	9fxGkmJHNGR3rN+Qy2BTIPeyLJ20fZ4Fknfe30oYAJtrdrAXCqTRYqXNN5J4aC94gIka9wWYhin
	ZGXRCY/GsBjGPOnYGknTo3C/YVXVFSlk=
X-Gm-Gg: AYBFou2v7AXcelr8d5o8GhdPBDiQ/Z/UvxquaA+t/J/b717K5wMI+JoNqlAANA/YwsS
	cCAT0KeM6plFgUvPQlMbAjiALtc04E8nXmXnvJ5qUq/Yoti2tMZ4zJ1fiS7x9lzTizujtUTvxt7
	Q4kTOIqrlaqKMVJuJmPw2qMcHuHcuoCPcpPcKXfgMOswpyt+u+tWGJh7jN6FVeeWGnb138VZweS
	bAkKe7l+SmQCIr3XrIhMrQbzDKznFJqG5BcrPzFDXb2GxJuT8FgW/n/BFzYjzLbxGiXnGx/Ze3V
	wtxhb7uuVTWTXn32sEi0FWYNvG4NKSHdVemtZzlnxWTEVDCWPK2+gUqJreqrIHo49XGb0S5MbPh
	hU31h+t0r1C0=
X-Received: by 2002:a05:6808:1992:b0:4b2:98a3:a567 with SMTP id
 5614622812f47-4d72be39068mr1776744b6e.4.1790224504958; Wed, 23 Sep 2026
 21:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923152653.40953-1-yupeng0921@gmail.com> <arP0TmdK3FnNfbwH@localhost.localdomain>
In-Reply-To: <arP0TmdK3FnNfbwH@localhost.localdomain>
From: peng yu <yupeng0921@gmail.com>
Date: Wed, 23 Sep 2026 21:34:48 -0700
X-Gm-Features: AclHuK942CAMjDTV2Zi3exg6L6EKi3Q-gOuQhHvB5LNabYOBYKDQn8SWx2V9lpQ
Message-ID: <CAG3TDc0bQJATmJR5dF5j9RoDp1ti-tbAiUkLRGq4zX2CYD3unQ@mail.gmail.com>
Subject: Re: [PATCH v3] nvmet: add cgroup_path to charge namespace I/O to a cgroup
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 8:53=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Wed, Sep 23, 2026 at 08:26:53AM -0700, Peng Yu <yupeng0921@gmail.com> =
wrote:
> > Scenario:
> > * Create multiple nvmet subsystems/namespaces.
> > * The namespaces are backed by different LVM logical volumes.
> > * Some of the logical volumes share the same physical volumes.
>
> Why are LVMs mentioned? (The test scenario doesn't seem to use those.
> And the example is backed by RAM, so where would be any IO to control at
> all? Note: I'm only giving this part of my attention span.)

The LVMs are close to my real use case, so I mentioned them to explain why
I need this feature.
When I write the testing code, I try to demonstrate the usage in a
simpler way, so
I use RAM devices.
Sorry for the inconsistency.


> > * The subsystems are exported to different users.
> > * We should provide each user a specific iops/bps quota, thus a noisy
> >   neighbor won't impact the performance of other logical volumes.
>
> Why cannot you place users into respective cgroups and configure
> appropriate per-device limits?

I export the devices to nvme target. Per my understanding, the IOs are
controlled by kernel threads. The users are remote users, so I can't find
a way to put them in a local cgroup.

> Thanks for providing more context about the scenario so that I can
> understand what's the goal and obstacle.
>
> Michal
