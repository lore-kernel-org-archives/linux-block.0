Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47B1C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 14:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B7421855
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 14:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5OHhzwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfAXONq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:13:46 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34030 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfAXONp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 09:13:45 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so2961664plz.1;
        Thu, 24 Jan 2019 06:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v355TmYnSOPcfYhBeXzzL9Avc7CnSYAT6Wo2xd6izBc=;
        b=G5OHhzwrCpl7rHXYn3XEgfaFoLW8D3NIRU/9EaWEMQM/QS5l++8kgdYAxZtgCSI1Mk
         Z+mCYqw5IGiFhPfpQQr9wbYC4rqPzTTshqBcjQgVaZUA/Bvffwo+5d+6g83RIajqvVie
         HgFhlSr6rZOoIk2Vko1IiJlaZGPIzAtP58sVck02H2mpiDNKnDVJrmjGatOK4uzLhloP
         hz+UbaN15tYjShTwCVczQ2Gvl5z6Lu9Y+51WxlM6lymdtLwCnNaAY8OZ102daTW4ydJ7
         ISBks31EjXCoELfRVpQEC7VPKkPLFM0Ey9Da4zga+cfxEw4nAFs09gKC1onk1HGP/MIm
         S78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v355TmYnSOPcfYhBeXzzL9Avc7CnSYAT6Wo2xd6izBc=;
        b=b7nll6qw7vADNjy0BkUUbpZR7aW+jSaf7KNXFx5j2JEYSu4J3deBOTmU/F69AaXjVg
         vSi4vLC4hdLkHnhlT4xUmDtnsY/GW06cwQJ4+B9iZshfRLataxkoZnunDwmhoyUgV71M
         hxfm1wrEKhKgXwDTYcUC0K5aqcuV47a72LVrluWw2eXdiFu822DgnQvtO9H/iNeq+NJS
         FR+RD003wfFVEkReq1D49hRhHvw/ao4sst/V0hUM8x+lVtQNrCwV+HewmWV2+JLofdP1
         tebUfQKBNyc9ew3jCUcP+6r5uBRJiic2tOxLeR4Ddxzy00rQ3NZCL14UiAUfTASJ6Xza
         LB3w==
X-Gm-Message-State: AJcUukcBsnoAUI8QmK8K7E/6NsuZuc1ijQOsFoZvnEdFOirXdniOJBRK
        RAcq6zF4ihBWGwSO+NMIbbS+LW467KODvuuKa6s=
X-Google-Smtp-Source: ALg8bN4WoEFXpf8kPRowueS1GlsOpHLsDP6oQWNTgo0NkK9K4dbrRBJKd/UU2vfiKTXP4k+eynfor09DTZACZgjMh7g=
X-Received: by 2002:a17:902:2468:: with SMTP id m37mr6701205plg.314.1548339225090;
 Thu, 24 Jan 2019 06:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20190110143051.52305-1-andriy.shevchenko@linux.intel.com>
 <20190121084732.GE18680@lst.de> <20190124121659.GH9224@smile.fi.intel.com>
 <6D748F08-F9F9-4DFB-84DF-63E97C691013@javigon.com> <CAHp75Vf4ndBaS6BjAM==7csYB9EYDvjV9jT9C6kioDryzb_HnQ@mail.gmail.com>
 <9E0FD459-75F2-4EF1-9310-8FCDF6F87604@javigon.com>
In-Reply-To: <9E0FD459-75F2-4EF1-9310-8FCDF6F87604@javigon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Jan 2019 16:13:33 +0200
Message-ID: <CAHp75Vfd=B-AP=7KNFiDU-qER9BjB0Qw9Lyp+hb8x94NfQiZyA@mail.gmail.com>
Subject: Re: [PATCH v1] : Switch to use new generic UUID API
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 24, 2019 at 3:45 PM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
> > On 24 Jan 2019, at 14.36, Andy Shevchenko <andy.shevchenko@gmail.com> w=
rote:
> > On Thu, Jan 24, 2019 at 3:19 PM Javier Gonz=C3=A1lez <javier@javigon.co=
m> wrote:
> >>> On 24 Jan 2019, at 13.16, Andy Shevchenko <andriy.shevchenko@linux.in=
tel.com> wrote:

> >>> header.uuid is defined using __u8 type, I'm not sure we can use guid_=
t there.
> >>
> >> We can turn it into a guid_t and bump the minor version.
> >
> > It's not so easy. __uXX types are dedicated for external APIs. guid_t
> > is kernel internal type disregard of (still) presence some uapi bits.
> > So, the question is those __uXX types in the driver definition is a
> > simple mistake, (weird) style decision, or what?
> >
>
> I would define it as a mistake and I think it is worth fixing it. At the
> moment we are only using this uuid for recovery purposes, to discard
> data from a different pblk instance,

Does this come from outside of the kernel in any mean (user space,
data from device, etc)?
It sounds to me like it does. In this case there is no mistake and we
may not use guid_t there.

> so there should not be a big impact
> outside of pblk itself. Am I missing something?

--=20
With Best Regards,
Andy Shevchenko
