Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5959356777
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 07:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319657; cv=pass; b=RhWHvqv/USPszBk9biRyWRTF/GSYFArAtFvL3Rdd87nuJdSyTQc8kJNztkUAWR8OELfI7Y80jWG9VU3GGsr2JZeDVma66+d0YYD1dbYr8AQA4Y/Y6bWRBLWTjGtJfvmd8wfpAF4QptjAjE56PpOh7dUzoo8FKIFKMuAnPUHsXE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319657; c=relaxed/simple;
	bh=yW1j8DeY8ApZV6Ko2dzi4EzUT0F1I7IAr6qbeR25e4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcWQ4viHNphXXMOJO1inpGJmdaEukc4nhexsH8B6g4By7YAvGfLmUCBW5AOqP1vA/jtuEkQcIPH7K5o2IDee5lyTKK/Bc36IMdtsG/FJmhmab9Y6ERjOcLCBYF8kaVGFEOsfL2GtTZC67h+SZUsAa5EtyaqFKYQI2shYh1d87Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjQGvKro; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjQGvKro"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c6d6660191so370378b6e.2
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 00:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790319654; cv=none;
        d=google.com; s=arc-20260327;
        b=QzrHsRUvkEM1e0Hcww8GU4irbOCoigiuO0+UcLoCR4D2wJyE5EejR8aqEneGCaHZjh
         1USLMFOnSDYy3W91QxogY6QsZ7kMG3kwWklPWmx4aw745MR33kDBm/1WOU0APL/vjy0U
         oTH1zVIjNchO4UsJYer0kSQvVv88dkQoSIvs7Za+49bdyNgawwdwcH6T2sLckbFFXpWj
         bTk0HdlSbxa9jGucBdZ0Br6nDxO6vMc29qI97m9ULAtPatAOmiSAKIhU5ziX3MgjCuEu
         WTD/lnNEKFmWdv3j63JJRsMfGwOSKWUmT3H8MzSIppZ1ULoVqATTsOIsijK04Ndo99PL
         2BOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S1fXxaoehIopV1PeW/nrL+gXG87cQGpcsm5CRZuB4kM=;
        fh=ABpFi7nCzGDZyndhsq1F1ZkQ62jeA6kA1gK1irqAgKE=;
        b=OItXghBEdyLufF3UPI56r+B8zWdKYY3oHY3ZfG9pwhXQ3dBmQGn1Fhze5j8qLg4eBr
         zjk8WLEqHfvsm7i078H3J7ZV9msDkdyc+L8sKWAerE2OaotYKJ7lpq4/0MZEmwPY+pF2
         nlRefVA6vwIORa53gOLrXBBvQ0+c45DEQXPbJguo/9Vg2MsJAzB/7Lykv3gJfcu7GSqm
         sLrnClFMP73u0Ym4rHNt6JBKtdwVJWw8z913vzWqmayz0aL2sxU4iv9VGvGeXzzgOygB
         BIKZDJ8yrDQIATM5FCea9vKD6gHOaQRwUz15WkCqUMC5HlAlUjLfRo6i8yAiUZn/1zwO
         GoaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790319654; x=1790924454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S1fXxaoehIopV1PeW/nrL+gXG87cQGpcsm5CRZuB4kM=;
        b=DjQGvKroGER4zTPaCXicv/a04cOxxx0hHV/QVmta6kTNX//vJoWdZt1+TRO1bY4jMD
         63OoOlP9Clca1Nm8aTNMlEcB98LFBSLvlO+M54vMlbK0s1HOWMo9nDjI5q9KYbvIW9fF
         dB7J4VAGNI/pxuseLs2aCjZ8erPdsRq8Ehy3VahvZPSt8hIXKk+HnWrDPcE9Aq2+rOcb
         Es6ZftgeiQiO34B97IyT7x+re4YmCC/vmwWwRuOkXP/zuYYmranlsWFkqI9bwa+5crrv
         0z1ZsFkA6l9hg6dQbz11gt5gYCP3tHV7PvuyepdhzG35gH7z6KS1Y0l6oMbYIL7/rhAL
         PqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790319654; x=1790924454;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1fXxaoehIopV1PeW/nrL+gXG87cQGpcsm5CRZuB4kM=;
        b=NguDhIXGKOY4OISjCJ0kH3dzYPiVJY3J2AUDWNTHb6JzocPAbAS5XgUwa74q7ZjnOw
         5yaMga/gOvwgpI/fR/dMrce+vdq8rtvjRuTZga4JxNrvihwUkCBJkjpG5utIvFXLycHB
         55Ak22+cScTcEANZIwXYt4UbQY3GhDaGYeF2YItmQs/8gXfCqu5Xc51Tr8XWEx6LgU95
         q/DWZcoEIS46eaZ53XO4U+wrFCgt2qvjN923LwgUJdaR2b+BoQTPUb5zPWkHqqCbA70J
         lxRZZjFae8EEpdeO7KPjkoD4HSwXeFCWDpF9yGl2cLb5P7M9rnEE2fn3+wGPqx/H/9CV
         2YEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwiyjXIXeoF8+R3WOhtTSXc0yHVWe7KPA8Rz0Rh37PP7u97DXDisGVB+t8Mrx1LxNlj/gNqbk7kU8wVzw==@vger.kernel.org
X-Gm-Message-State: AFuF++kM7+PCzAFb3k8am5gVNO1WekTe2yoC7apQdNuwmafBbSqvyAjz
	Uc+2qPh5YfaJQB6EPaekh+okUX7N5YeKvrPvqeZA15xQlxAX14RzICQZ3rJBNcFgLI4lG36ye5Q
	hYyonCNZOL2EmKEDCEZI1QvVPIhmPCr8=
X-Gm-Gg: AYBFou3mdMsukKXTdWfNghbYjl3WtamctKOijwxFPRqjZF0ObpkNUVxZjIThZKgKPnn
	Qab9/Sd1MHFCxiiudWhqf5gAxz4ghmW4Ht4tDd1B/+dBc04JOd24rqmdi4MbyiuMwCl1pi5Hxg1
	s9Qf3BcOg12zjVK6waCcyQLOEGvabkb10ggeoBvBYDu8JmcaA/PkuoLEtyWWji+kbBLYCgpthdC
	6bvHOS5pougRe8c6YR2OK4+W4r/EU7wIcaJ7AwcYCFSaSISZTyjZTGbCn/t4JIUlOhSz+oYDzIs
	aksU6fZ70r5smyYGk4MYb/oBsuVkjr3oWYu1bVDtLWV+GdGCNVsdda7XSolChRlZZPWKufcUbNG
	GBef7ATAJEhLudQr2oUV2Wg==
X-Received: by 2002:a05:6808:159b:b0:4b9:a829:f01c with SMTP id
 5614622812f47-4d72e16431dmr5142881b6e.40.1790319654501; Fri, 25 Sep 2026
 00:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924053121.17703-1-yupeng0921@gmail.com> <arS-38fE5r638g4Z@slm.duckdns.org>
In-Reply-To: <arS-38fE5r638g4Z@slm.duckdns.org>
From: peng yu <yupeng0921@gmail.com>
Date: Fri, 25 Sep 2026 00:00:43 -0700
X-Gm-Features: AclHuK80rKmiL3-JKRQwzW_6XT8TAtbFUe0xI3YnKDyMTZWe3I0aCFGT4xVZq5g
Message-ID: <CAG3TDc0DZs5+E1tEBCn7uQyWJwZOY-brXBKTx8fBCy3HJqaqiQ@mail.gmail.com>
Subject: Re: [PATCH v4] nvmet: add cgroup_path to charge namespace I/O to a cgroup
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 11:10=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Sep 23, 2026 at 10:31:21PM -0700, Peng Yu wrote:
> ...
> > +#ifdef CONFIG_BLK_CGROUP
> > +static int nvmet_blkcg_ns_enable(struct nvmet_ns *ns)
> > +{
> ...
> > +     cgrp =3D cgroup_get_from_id(ns->cgroup_id);
> > +     if (IS_ERR(cgrp)) {
> > +             pr_err("failed to resolve cgroup id %llu: %ld\n",
> > +                    ns->cgroup_id, PTR_ERR(cgrp));
> > +             return PTR_ERR(cgrp);
> > +     }
> > +
> > +     css =3D cgroup_get_e_css(cgrp, &io_cgrp_subsys);
> > +     if (!css || css->cgroup !=3D cgrp) {
> > +             pr_err("the io controller is not enabled in cgroup %llu\n=
",
> > +                    ns->cgroup_id);
> > +             if (css)
> > +                     css_put(css);
> > +             cgroup_put(cgrp);
> > +             return -EINVAL;
> > +     }
> > +     ns->blkcg_css =3D css;
>
> This is really odd from interface POV. The user specified "associate IOs =
to
> this cgroup" and that can fail if blkcg is not enabled on the cgroup. Eve=
n
> if it succeeds, if blkcg gets disabled and re-enabled on the cgroup, the
> device is still going to be issuing IOs as the old draining blkcg.
>
> What the user can express is the target cgroup and the IOs should follow
> whatever IO control that specified cgroup is under at the time of each IO
> issue. Currently, cgroup_e_css() has to walk up the tree to find the
> effective css for a given subsystem but updating cgroup code to add e_css=
[]
> array on each cgroup to avoid the overhead shouldn't be too difficult.
>
> Thanks.
>
> --
> tejun

How about this:
1. Add a one line change in the cgroup code: export the cgroup_e_css
2. The nvmet invokes the cgroup_e_css for each bio and under
    the rcu protection.

I think we don't need to add an e_css[] array on each cgroup. At least in
my case I don't expect to have a very deep cgroup hierarchy, so we won't
spend too much time on the cgroup_e_css.
