Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0854C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC7120836
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="d+1hBQG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfCDJCQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:02:16 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37657 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfCDJCQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 04:02:16 -0500
Received: by mail-vk1-f194.google.com with SMTP id 17so960194vkf.4
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 01:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pHahKkLWS8KGOMYzYznCUAtvFIYsi5ZIdOlqC98EhVs=;
        b=d+1hBQG/dHSQgAlyGm9+WKJJTNfbEBIz2eC2oHLFmELyvjDpvSzzxFaKiCI6lb4Tdo
         H8c+04Z4xA/FmoOdSiNseYxFyJL+vvtSybOo/cSfTSQNa5YACfx0NTteOX+emk/3oMBC
         QlyLpdNtevDKDt5d99sj8TkZMywQCS0ly2InA5nJFD5NYyN/0afgBFQi18SQ0hSRhN5i
         jfAGPTloldNPTT+1rsesjlSzZibNlYqEBnISKPnB868J8/rgHMoOCFK5Q5X5L3nTvWLl
         mNERwZogoaJjKh3BSfr9FWImI+JcDqlqjqX/tPL27W0juBT0YZokmloLbA2TppQNAXAn
         XSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pHahKkLWS8KGOMYzYznCUAtvFIYsi5ZIdOlqC98EhVs=;
        b=QXVXSpHid+Nr52E8JF/fmxmgZevjBiGotUSzbJYVVY+kavZ+q/T3aBX0Wlob6pNvx8
         6IDvRNhNaZgE6YJETf/3WeMK/UGHSsii+5AemDXUf4bnrzbUvrZS7mU5sZ5xJXyLndw+
         huyR9PIrfBjhztbD74XnE4ffSK/wXoY3VTq/IpHHtetderBGoUOAAUo4bUYJtZIufj7w
         DHaHS/P+jsJho7Epw2xuIx8sHZnvx0Q/sgt2Ej6WGA52aFdJxGJ/ks/smNGwMbNhw6fq
         4wOxo+HGGsITZw2LV/XLabjHYOd0DQyQlL0bmDD60SuH/Ctup0XhGDRNK6ODZ5NwZ8/T
         5Mfw==
X-Gm-Message-State: APjAAAUd3HQrMoqJ9GCu/d6sGNfBgvu6A8kW3/3/wKjA10lHetUgetti
        kcV8SvZVQ0Rc9dxXFNX7zdHpCEpBx7vQOVNpv9w4qMh3fk8=
X-Google-Smtp-Source: APXvYqzL45V1lDKOy6NpyRTtvNNKuZ8D3xp9UzIJvkt2RqIPlAaLgABz0/JWI/zzYv/iVlRSt6Od9wv1QIoxvp5nAEw=
X-Received: by 2002:a1f:b483:: with SMTP id d125mr9229944vkf.51.1551690135093;
 Mon, 04 Mar 2019 01:02:15 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-6-igor.j.konopko@intel.com> <BAC8CFE4-5D1E-4FA0-80DF-9BA655D458D1@javigon.com>
In-Reply-To: <BAC8CFE4-5D1E-4FA0-80DF-9BA655D458D1@javigon.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Mon, 4 Mar 2019 10:02:04 +0100
Message-ID: <CANr-nt3rzEGw0wNdOmm3ba9Oz10BLh_dbHoCECobMr2cfakLhQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] lightnvm: pblk: Count all read errors in stats
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Igor: Have you seen this happening in real life?

I think it would be better to count all expected errors and put them
in the right bucket (without spamming dmesg). If we need a new bucket
for i.e. vendor-specific-errors, let's do that instead.

Someone wiser than me told me that every error print in the log is a
potential customer call.

Javier: Yeah, I think S.M.A.R.T is the way to deliver this
information. Why can't we let the drives expose this info and remove
this from pblk? What's blocking that?

Thanks,
Hans

On Mon, Mar 4, 2019 at 8:42 AM Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
>
> > On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote=
:
> >
> > Currently when unknown error occurs on read path
> > there is only dmesg information about it, but it
> > is not counted in sysfs statistics. Since this is
> > still an error we should also count it there.
> >
> > Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> > ---
> > drivers/lightnvm/pblk-core.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.=
c
> > index eabcbc119681..a98b2255f963 100644
> > --- a/drivers/lightnvm/pblk-core.c
> > +++ b/drivers/lightnvm/pblk-core.c
> > @@ -493,6 +493,7 @@ void pblk_log_read_err(struct pblk *pblk, struct nv=
m_rq *rqd)
> >               atomic_long_inc(&pblk->read_failed);
> >               break;
> >       default:
> > +             atomic_long_inc(&pblk->read_failed);
> >               pblk_err(pblk, "unknown read error:%d\n", rqd->error);
> >       }
> > #ifdef CONFIG_NVM_PBLK_DEBUG
> > --
> > 2.17.1
>
> I left this out intentionally  so that we could correlate the logs from
> the controller and the errors in the read path. Since we do not have an
> standard way to correlate this on SMART yet, let=E2=80=99s add this now (=
I
> assume that you are using it for something?) and we can separate the
> error stats in the future.
>
> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>
