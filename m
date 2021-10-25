Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C47C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 12:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D01BC60C49
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 12:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhJYMWN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 08:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232524AbhJYMWN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 08:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635164391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bpba6Ufxti5lreO7XFqcxAVqDyGcvLBjU7CAmvKdMJY=;
        b=hgtTs6+iUKCSz3InYVgnuGw1fn+ppR02fmxs4Y5dRdkCo10Fg5E6UBqW7fvhSxrXSeegFC
        bj2uDrduCtQ5XJNOtHHqtJdFUW9s8labKvU8JPDowTiDmdcp4p8m6ZMTiVxOE5jZKw05JA
        UV4PyFvl7cqWMtEauIRPR6PoukhugGc=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-BD3kO3quMNWL-RAYcg1tjA-1; Mon, 25 Oct 2021 08:19:49 -0400
X-MC-Unique: BD3kO3quMNWL-RAYcg1tjA-1
Received: by mail-yb1-f197.google.com with SMTP id w199-20020a25c7d0000000b005bea7566924so17202343ybe.20
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 05:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bpba6Ufxti5lreO7XFqcxAVqDyGcvLBjU7CAmvKdMJY=;
        b=WficsnjwcAq9nf1mvddmcmsLs7mBta+87nTvnRPuFpj93m5GOrU2ZJ7fwZ2aNi5pm5
         JkzGhcQ3MZXCHAaLRVVMcH1X57YE8aiI1xapNJ+vXYATOgE28VXapt7V9Gwo6o4RTpHl
         8dm1KX7zMTluyNBcjb9Et2Yj9JTbTiH++m0AGTpIFE3KGVuFowHltG8GhgXe60JmY0gd
         zoFP/X8IY4FzExZ8aJetCe2Shi2146+z+ZT8FrYwHVoYzPZovYbzEQOicIm4PbOj3Fzc
         AEvkIER7PQf9FyOGl1xIzSvBibbk9gBdmzGJ1a4YGI62gFSU5CeLFxFxDREfT0FGouaq
         izXA==
X-Gm-Message-State: AOAM5326k1pG71JIwhpDppd0g3BnU10K/7VkjQE1qvPTKVmqNzZEj6Sg
        eMaOaby6ey+lxO27+eA/K15tq7BSKbN+36wrYJXpo/WiNABv3TZN2YzGVXpZRNyoHSijWqUu3Gg
        cumiR8ctfTJKtr/luUIXtk4bc+U5HjFzkS/zDuHk=
X-Received: by 2002:a05:6902:154f:: with SMTP id r15mr2315844ybu.153.1635164389353;
        Mon, 25 Oct 2021 05:19:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLRmqQpyhIAYMP02t4P8uRT0ULnsT+k0AqNRk5Llo5rrz8ecR1+o1DQO08FS2OKpa7+2ewGgKl5bvQl95RBTo=
X-Received: by 2002:a05:6902:154f:: with SMTP id r15mr2315814ybu.153.1635164389092;
 Mon, 25 Oct 2021 05:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211025012416.23432-1-yi.zhang@redhat.com> <904355ef-554e-0b72-5d16-3089a042de9e@acm.org>
In-Reply-To: <904355ef-554e-0b72-5d16-3089a042de9e@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 25 Oct 2021 20:19:37 +0800
Message-ID: <CAHj4cs-r2jgqCYmfBr1mNChmAbtOb=4NNhcP-66VYnToJ-B0Dw@mail.gmail.com>
Subject: Re: [PATCH blktests V4] tests/srp: fix module loading issue during
 srp tests
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@osandov.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 25, 2021 at 10:27 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 10/24/21 18:24, Yi Zhang wrote:
> > The ib_isert/ib_srpt modules will be automatically loaded after the first
> >   time rdma_rxe/siw setup [ ... ]
>
> Doesn't this depend on the contents of the /etc/rdma/modules/*conf
> configuration files?

Yeah, you are right, I didn't realize I've installed rdma-core which
included "/etc/rdma/modules/rdma.con", thanks for pointing it out.

>
> Anyway:
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>


-- 
Best Regards,
  Yi Zhang

