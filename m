Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D350C001DE
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 13:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjHKNmF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Aug 2023 09:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjHKNmB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2023 09:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1EBE58
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 06:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691761274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvNr7wvJoHoh75lBukJNiyR8Rgyu+GCAhkFpZWVqDYA=;
        b=OCFAlkb+eB3Ov5fbeYLz4x1m+xuBOxuaii8ayrtteWUpfwXSAP3SCxmQlNFdy7oVUR+EK6
        jRAOvHx7Yvciw0bz6qq8eKjNxLJTQ9/W6T4Mlwu3IuaPJyQ4HyF1/T71OPJTNkV6h14xrL
        2M2yu8joYLq9cYmZgiiJZX7PMjHELwI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-WTxid_gkOWWAfMYGSGcvCQ-1; Fri, 11 Aug 2023 09:41:12 -0400
X-MC-Unique: WTxid_gkOWWAfMYGSGcvCQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fe6141914cso2011083e87.1
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 06:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691761271; x=1692366071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvNr7wvJoHoh75lBukJNiyR8Rgyu+GCAhkFpZWVqDYA=;
        b=llA3bhfHtb2Llmal1Yl+mSk8ZHI8icpckmDlU2uXRmiLPogmm7S0p2zZhZzGojYt8u
         thHj2gnbZpAhg+zBrBRug17ZrjztGiWwhItBgMn4c0J7yQD/+FKOKmyL7aYHJ2z+qx3B
         ILxkOiWqj/yubEt3S5QNToApCpHgpC5P9vLmZcssb2Ve9NdODHRQUwJpKVugBBEJkqA1
         ME+GSSECI6EC4hXe1YLnShJS27M3kPgzYEXR5jw0paouwRvFESUN6SxVMwGbKzf1nave
         y/ssf+coyiGaXyT/HA+7ybawZZ5VFTplhHcqwvxKskX72N/eZ7RN0sOwFVgP+1GErqKY
         raDw==
X-Gm-Message-State: AOJu0YzHWOItOWgD5w+9NFvQ+86ydD/AqdxCWEgeusbFg1g0uXVuoq40
        2P05SIXpu8UbTVIMF+52zDmDroXdP5fVBspnvA58khASvDFdGcaUoc0pv3cA0aVlBjr2bRFky95
        8IpMs27jTkhcTAsIlqg7aL2EIWjYALI4jZsWI6hM=
X-Received: by 2002:a05:6512:2e9:b0:4fc:df79:3781 with SMTP id m9-20020a05651202e900b004fcdf793781mr1326991lfq.66.1691761271489;
        Fri, 11 Aug 2023 06:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbQ724PCdz1QmKdVZ3WXc3zOibB58t0y/rSTwR6t5zqRdCAsZxw7VBmhTMi7vGQPrAu3W+8jj44UfGoG5EvlY=
X-Received: by 2002:a05:6512:2e9:b0:4fc:df79:3781 with SMTP id
 m9-20020a05651202e900b004fcdf793781mr1326973lfq.66.1691761271140; Fri, 11 Aug
 2023 06:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230809020844epcas5p30e520491fa59ab8c20836d4275931e8f@epcas5p3.samsung.com>
 <20230809020440.174682-1-ming.lei@redhat.com> <20230809065920.GA19415@green245>
 <ZNNF/2NEPYCeiXlM@fedora> <20230810063411.GA13970@green245> <ZNSca/sJGA3zXpJ4@fedora>
In-Reply-To: <ZNSca/sJGA3zXpJ4@fedora>
From:   Guangwu Zhang <guazhang@redhat.com>
Date:   Fri, 11 Aug 2023 21:42:12 +0800
Message-ID: <CAGS2=YpdW5kJXGzyTXtbfWKn1sO8Zg3pSrgX5CzUWbyEzAgung@mail.gmail.com>
Subject: Re: [PATCH] nvme: core: don't hold rcu read lock in nvme_ns_chr_uring_cmd_iopoll
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,
Don't find any IO block after apply your patch.

Tested-by: Guangwu Zhang <guazhang@redhat.com>

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8810=E6=97=A5=
=E5=91=A8=E5=9B=9B 16:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Aug 10, 2023 at 12:04:11PM +0530, Kanchan Joshi wrote:
> > On Wed, Aug 09, 2023 at 03:53:35PM +0800, Ming Lei wrote:
> > > On Wed, Aug 09, 2023 at 12:29:20PM +0530, Kanchan Joshi wrote:
> > > > On Wed, Aug 09, 2023 at 10:04:40AM +0800, Ming Lei wrote:
> > > > > Now nvme_ns_chr_uring_cmd_iopoll() has switched to request based =
io
> > > > > polling, and the associated NS is guaranteed to be live in case o=
f
> > > > > io polling, so request is guaranteed to be valid because blk-mq u=
ses
> > > > > pre-allocated request pool.
> > > > >
> > > > > Remove the rcu read lock in nvme_ns_chr_uring_cmd_iopoll(), which
> > > > > isn't needed any more after switching to request based io polling=
.
> > > >
> > > > > Fix "BUG: sleeping function called from invalid context" because
> > > > > set_page_dirty_lock() from blk_rq_unmap_user() may sleep.
> > > > >
> > > > > Fixes: 585079b6e425 ("nvme: wire up async polling for io passthro=
ugh commands")
> > > > > Reported-by: Guangwu Zhang <guazhang@redhat.com>
> > > >
> > > > Thanks Ming. Looks fine, but any link to this report?
> > > > I don't see this breaking in my tests. So I wonder how to reproduce=
 and
> > > > improve the coverage.
> > >
> > > It is reported in RH BZ2227639, and follows the stack trace:
> >
> > Tried to access, but no luck.
> > Any chance that steps can be posted here?
>
> It is reported by Guang Wu, and I think it can be triggered by:
>
> 1) enable CONFIG_DEBUG_ATOMIC_SLEEP
>
> 2) run some nvme pt read workload, and fio should be fine, but
> don't pass --fixedbufs
>
> Just run a quick trace on set_page_dirty_lock() in non-debug kernel, whic=
h is
> really called from bio_poll()<-nvme_ns_chr_uring_cmd_iopoll().
>
> Thanks,
> Ming
>


--=20
Guangwu Zhang
Thanks

