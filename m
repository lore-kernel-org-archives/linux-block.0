Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F387C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 02:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1671861260
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 02:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243039AbhJRCqH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 22:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243029AbhJRCqH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 22:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634525035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=24awu7awUCOKi36V9SWrgRA1ZbaOc+SStEb3sQlvlgc=;
        b=Z+PMTp7vElYDgHojDYn7xJSRhiZs7aSI7sYyQQLwTuU3OYMJNzf9XY5QfqVW7J4rd7BGUM
        wQ+U1AuiSoik7S3NMS2uIETtSgIkSzAMrSutEpG/Xyf+krxqkw9XoCrRu+ByI9cW3pSOJN
        SG7VrIs0rOVdkIEMjqIaukw9n2EIasU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-kLn7Ul-gNHCDwpGZi9m_PA-1; Sun, 17 Oct 2021 22:43:54 -0400
X-MC-Unique: kLn7Ul-gNHCDwpGZi9m_PA-1
Received: by mail-yb1-f197.google.com with SMTP id i21-20020a253b15000000b005b9c0fbba45so18399355yba.20
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 19:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24awu7awUCOKi36V9SWrgRA1ZbaOc+SStEb3sQlvlgc=;
        b=g9k2JarM+ioMOuA9pt0KPIwYrQ2IB7c0nC4/fgZmvrf6yxV91UQFrcFl67alo7Vj6E
         +9khruw1Wjk5CG2tEm954dchMkdxgCBSG+W2+FDHO9Q1AiDKpto4KjlDZgHA1+l+dY52
         6PaC3G5Iuh5I2fxgSer7CqrSM3FKIJKPSdekZczyvyfnFSOI/dDuvJE82IWaxNd+P7ei
         qpxD+GA+nkCTDxO5WurJIuknPxJtE4jYrAU4lpAJM4wuDhpeSjRxk1rl3KfOUDVajjbq
         CWOaIqWnkMGqc1xG9Jsn+fxMkS6tN2KYV5W/e9ZNRubHgeczFXdc75E73ANAZLcsbRC+
         72JQ==
X-Gm-Message-State: AOAM531WkTDoyTG04X4OYRWpIdFBYjNFE9namYhnqwnZR+T3kp9jvxUf
        pOIJ0Lk+//ib0uNgRR6gGxUopATVubMcE277ilqR+9ardVrhWZJSTD9WoMRbemg6eCKXzmVjGSw
        IGEJamPT79INZ5jC3Fdy+ZSKnYFssUBj2sLYzq3U=
X-Received: by 2002:a25:3212:: with SMTP id y18mr26370129yby.308.1634525034095;
        Sun, 17 Oct 2021 19:43:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs1eNssraNdT+jK9OAQ4JYVymDwppEy4Q2v5UAjOMxe1lPfmqVIgivEI4eg5P4o95MD27a2g2qp0KTSXO83K0=
X-Received: by 2002:a25:3212:: with SMTP id y18mr26370110yby.308.1634525033886;
 Sun, 17 Oct 2021 19:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211014090455.7949-1-yi.zhang@redhat.com> <a24c9629-be0b-145e-414f-327ad35270e9@acm.org>
In-Reply-To: <a24c9629-be0b-145e-414f-327ad35270e9@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 18 Oct 2021 10:43:42 +0800
Message-ID: <CAHj4cs9HXs0+jHPdUZ53TWjeYOTKw_9M59qNPHHQY=n4=pqnoA@mail.gmail.com>
Subject: Re: [PATCH blktests] tests/srp: fix module loading issue during srp tests
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@osandov.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 15, 2021 at 11:30 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 10/14/21 02:04, Yi Zhang wrote:
> > diff --git a/tests/srp/rc b/tests/srp/rc
> > index 586f007..f89948b 100755
> > --- a/tests/srp/rc
> > +++ b/tests/srp/rc
> > @@ -494,6 +494,7 @@ start_lio_srpt() {
> >       if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
> >               opts+=("rdma_cm_port=${srp_rdma_cm_port}")
> >       fi
> > +     unload_module ib_srpt && \
> >       insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt."* "${opts[@]}" || return $?
>
> A nit: the backslash after && can be removed.
>

Thanks Bart, I've sent V2 to fix it.

> Otherwise this patch looks fine to me.
>
> Thanks,
>
> Bart.
>


-- 
Best Regards,
  Yi Zhang

