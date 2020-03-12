Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816E5C10DCE
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 12:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8C7206FA
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 12:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBFG0drK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgCLMKR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:10:17 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:36367 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLMKR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 08:10:17 -0400
Received: by mail-pj1-f42.google.com with SMTP id l41so2587213pjb.1
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 05:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vy2n5NLy4xxeHaOT5IV+2cRebGf34zNVVuHAtfA0XVE=;
        b=DBFG0drKwkjP7JdKAYbsXYq6vEBqhyBD6TCQI6UlcrtbAmm/FcNKecul+8w6BLPGN1
         G6EliGVexITzn19f2Ef9CAQmPXnCwIhVMTBqjwl9AN/2OX7NayJZoDh7ImPWwDlVjA/F
         GgOEAvjfTVPpCUe+6o7ZwvLnlZwfWlPstP27j8FuB7fVnwVb090NyB6Jev5c7ZzIPbWh
         RBcfsM2k+/ghchFHhaQ086epBW7J0raR/XtUoGx/XCWgIzuLCH+N6mGBgyAYL4BgAndo
         OuA5CRELF7zHjtfaKcZ0AaIn8E5d6xfugN/ctWEz0nJpPoF5tl5msGQrKI+1DHB+QMIg
         RxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vy2n5NLy4xxeHaOT5IV+2cRebGf34zNVVuHAtfA0XVE=;
        b=DoPKlLZzIiEk3FFsV/2sGtjELo5kyBQGXJaPv4pCgtqVZNN8oVLXPhJkeL11XNlzyu
         iBmNcBJqZAjMLjahcSgO0cpGCw+e68KUNywomB0f/u9THzm9yj7fxKKhHnruY7gbgNLH
         38ZPgJpcRkal7Kf9/IJgBSHLWeItXbbkLxd6f7gBBb+us/1Ci9L+QfOvX8NLTTjrWHnF
         Ds0Z3HVf35kdkqN7fdcbWb7OGWCGDrbX4aYRMbR60glW8lzlqf2G969hTXGXvMaMudAD
         SPn4pJNaEl+k14gD0C230qEP21D6hK+4t6Clf1w05S0chwwsx8biB3B/tNgvVR1VTrRk
         tVIg==
X-Gm-Message-State: ANhLgQ0WYKGo+aJBiEvk6mg0Y6qqFio6vpA5dnFsFHdHFIaMoaHSwyy6
        frWgIw658gK1WuJ7saTl73yVAMvN1UF6GvPb9Eo=
X-Google-Smtp-Source: ADFU+vtdWyHu34mT/l6awb0ZY3IDbFaknaatAZaqVazfUbQ2J96Y8JasuQbuixyZGQWP/xbvMXSH0+xSISkW0EXIFVY=
X-Received: by 2002:a17:90a:c244:: with SMTP id d4mr3799820pjx.133.1584015015910;
 Thu, 12 Mar 2020 05:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAEK8JBBSqiXPY8FhrQ7XqdQ38L9zQepYrZkjoF+r4euTeqfGQQ@mail.gmail.com>
 <f7963269-bf90-9b1d-2ac4-bf324d5462e5@suse.de>
In-Reply-To: <f7963269-bf90-9b1d-2ac4-bf324d5462e5@suse.de>
From:   Feng Li <lifeng1519@gmail.com>
Date:   Thu, 12 Mar 2020 20:09:49 +0800
Message-ID: <CAEK8JBDKR9AYy9_-uWhjUParRT7s9qGciXsCw-riCBN8UMCGOw@mail.gmail.com>
Subject: Re: [Question] IO is split by block layer when size is larger than 4k
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ok, thanks for the clarification.
I mean each bvec consists of one page.
It's not good for virtio backend.

Hannes Reinecke <hare@suse.de> =E4=BA=8E2020=E5=B9=B43=E6=9C=8812=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On 3/12/20 12:13 PM, Feng Li wrote:
> > Hi experts,
> >
> > May I ask a question about block layer?
> > When running fio in guest os, I find a 256k IO is split into the page
> > by page in bio, saved in bvecs.
> > And virtio-blk just put the bio_vec one by one in the available
> > descriptor table.
> >
> It isn't 'split', it's using _one_ bio containing bvecs, where each bvec
> consists of one page.
>
> 'split' for the blocklayer means that a single I/O is split into several
> bios, which I dont' think is the case here. Or?
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                        Kernel Storage Architect
> hare@suse.de                                      +49 911 74053 688
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: Felix Imend=C3=B6rffer
