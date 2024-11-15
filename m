Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205AF1D5CF1
	for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731702346; cv=none; b=JETQV0mln0Ng+9YjCNkVmDvLOVtcrQYgBmwwvXrjO8oJwNfzG0R1qFVn17oG5ukej/CT1qYOyuWHg9TW1ZnqUZ3Q54D0S6vafUBq6C2fm8vV5JkeTmQxipi2rxI81XDGPM1RhmPLmlH6bcSYav6Tq8J9hiyTLzqxOPLITntyDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731702346; c=relaxed/simple;
	bh=vzB88Ab0K9g7gx/HZQf5Qt3upMzQRUJK5J17p+p5qss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIe+QWdZQERcAgwcJzMs2QYpr8BztLCPdBoeO/6oCfGuT6bDZ6ulfDVqGx67cDd4xLjRM1wB5cXndoXhulp0kSwkqBhI+D7ipjzwLtc6Jhl2yOVKAgGwa5OBAB5o8f9QQiezu45y51NWBc3i/QW5tNDhSsK1FqsKN2MLG8TVQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjV/O4UL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjV/O4UL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731702344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNLrlgsuyCSQO136ZlOgDlHV4KMR1L8gzLEmcIW3BjM=;
	b=UjV/O4ULn/idPIrUfunUQExglOjVT2mvMVdD/UGCx9wJ1KeBZHOkLNczn26EwMhfao+RGQ
	19KDRL5f2GBny0vlNiVWXW/RSBxQ4L7W1grxAhCscZpO+EjbZwV/3ydY4y3zu1nLGSC7+9
	Se0BoRfJeDns0Q6ky7Ky4c94PPOGync=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-4h7YjqTjM0WvTOckCSWGnQ-1; Fri, 15 Nov 2024 15:25:42 -0500
X-MC-Unique: 4h7YjqTjM0WvTOckCSWGnQ-1
X-Mimecast-MFC-AGG-ID: 4h7YjqTjM0WvTOckCSWGnQ
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5eb6275167dso2031370eaf.1
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 12:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731702342; x=1732307142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNLrlgsuyCSQO136ZlOgDlHV4KMR1L8gzLEmcIW3BjM=;
        b=YsEE2Sp7O3pk6m/UUoVIxoxjBjHHQmeu6DPJSfRGYaQ8Nwe0QnDEQHzCUzI3jiGV+W
         sYtsiKY1HBP/X7k47fQdywoYOKy3x8aGM2Z3L62O/WmncQcllG4tRGGMm+/UF7G/baTM
         nxVjJQROTQjS93wDqKsOaF5S2WW4+HNxd8ucyuVz4X6mWnzd/UMgMbutuZ6W3H+Emc/6
         Myd4FSa756dH/hyfHEhg0bKLqW1e8a8HHvCC+oQfdDtLZXKXdMdW6NLZXgVObNeqw0Ox
         qwEwsgW1MjHsGE3C/ikU/po6OCFKWuRKAKYwMLosJrt8xND27pDoxHqCBQxyBiDm6fJB
         FD1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6vxm/+AJ8URAUpxKg3D/sY6oCMfI7cObFhbta6c8psG7FvFQjdLy1sT/iyQUheFK7fOEv2+Mwkzpgdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ejyka2/UDblBBdDaEX0a/8euI90K9VbueVy6aSTMJWHhW0JF
	S5EzTPRXOcX1yB5PFO6KMec6gxFvdlSB+SvYyAewdzz138kUKGHTIygytrMZxfyg4VpGIJzrnsA
	Rc01f7rG4bh+25LAbCdfCKDUcK8xYgq0Jc6cGw40a4Ylz1guInZj04Lp+Y5BqyTXE3+TzV+kF0T
	Yox25YQHeEBTEzbvp6yWFwEIu1qYMEvYuZWIY=
X-Received: by 2002:a05:6871:e085:b0:295:91a0:af1 with SMTP id 586e51a60fabf-2962de09fa0mr4330105fac.19.1731702342157;
        Fri, 15 Nov 2024 12:25:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHprnkP4mcnKY9AIEZogy1RG7ERmEnfoV7JX0QKAbhQCgxNP7EEumthj14YA/khDgoSXi5sWHjd6wPh6Z6kCCs=
X-Received: by 2002:a05:6871:e085:b0:295:91a0:af1 with SMTP id
 586e51a60fabf-2962de09fa0mr4330087fac.19.1731702341911; Fri, 15 Nov 2024
 12:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108054831.2094883-3-costa.shul@redhat.com> <qlq56cpm5enxoevqstziz7hxp5lqgs74zl2ohv4shynasxuho6@xb5hk5cunhfn>
In-Reply-To: <qlq56cpm5enxoevqstziz7hxp5lqgs74zl2ohv4shynasxuho6@xb5hk5cunhfn>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Fri, 15 Nov 2024 22:25:05 +0200
Message-ID: <CADDUTFwYKjbPnzdzQA0ZjW4w3pHBsoZBQ6Ua5QbFp=X2-GfGtQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] blk-mq: isolate CPUs from hctx
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ming.lei@redhat.com, Jens Axboe <axboe@kernel.dk>, Waiman Long <longman@redhat.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Michal.

Isolation of CPUs from blk_mq_hw_ctx during boot is already handled on
call hierarchy:
...
        nvme_probe()
                nvme_alloc_admin_tag_set()
                        blk_mq_alloc_queue()
                                blk_mq_init_allocated_queue()
                                        blk_mq_map_swqueue()

blk_mq_map_swqueue() performs:
for_each_cpu(cpu, hctx->cpumask) {
        if (cpu_is_isolated(cpu))
                cpumask_clear_cpu(cpu, hctx->cpumask);
}

static inline bool cpu_is_isolated(int cpu)
{
        return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
                !housekeeping_test_cpu(cpu, HK_TYPE_TICK) ||
               cpuset_cpu_is_isolated(cpu);
}

cpu_is_isolated() is introduced by  3232e7aad11e5.

Thanks,
Costa


On Fri, 15 Nov 2024 at 17:45, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hello.
>
> On Fri, Nov 08, 2024 at 07:48:30AM GMT, Costa Shulyupin <costa.shul@redha=
t.com> wrote:
> > Cgroups allow configuring isolated_cpus at runtime.
> > However, blk-mq may still use managed interrupts on the
> > newly isolated CPUs.
> >
> > Rebuild hctx->cpumask considering isolated CPUs to avoid
> > managed interrupts on those CPUs and reclaim non-isolated ones.
> >
> > The patch is based on
> > isolation: Exclude dynamically isolated CPUs from housekeeping masks:
> > https://lore.kernel.org/lkml/20240821142312.236970-1-longman@redhat.com=
/
>
> Even based on that this seems incomplete to me the CPUs that are part of
> isolcpus mask on boot time won't be excluded from this?
> IOW, isolating CPUs from blk_mq_hw_ctx would only be possible via cpuset
> but not "statically" throught the cmdline option, or would it?
>
> Thanks,
> Michal
>
> (-Cc: lizefan.x@bytedance.com)

