Return-Path: <SRS0=GTOX=X7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8284FC4360C
	for <linux-block@archiver.kernel.org>; Sun,  6 Oct 2019 20:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A1120862
	for <linux-block@archiver.kernel.org>; Sun,  6 Oct 2019 20:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuaBLMWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfJFUsu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Oct 2019 16:48:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39623 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725900AbfJFUsu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 6 Oct 2019 16:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570394928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0n5/QVFjxZJUJjSitLC3Cb0RH/iVnwERCpBFf6ATYGY=;
        b=PuaBLMWZGo94NGxPtQWHA4mDZxrjs35EUlfl+QBv/eosD/PdyFPI2ZdgNKr9PhXH0se+0q
        JD4s/59xOcs6M8Fo9hYMOmVqs3zbXUslsA0yb9z/TSa/9t37cg5hzUGJGM5WWo9lwsCELz
        mp00N0ToY5MTVJt9iIYJ48PFQ5BEC54=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-hNZoIHe1ND-FlDeiSE5o8w-1; Sun, 06 Oct 2019 16:48:45 -0400
Received: by mail-qt1-f198.google.com with SMTP id e13so13115553qto.18
        for <linux-block@vger.kernel.org>; Sun, 06 Oct 2019 13:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHi35jjYxKbkdjmm0frY18OUymXKQrESkDz2p16jXEw=;
        b=iIaq5P0TQCy/5cn5/SK4PlGGx1xsJNXZA9DDSOFFiwqP0bZGt1e4V47AxK2PNS+SUv
         jGL4SrQCx87SMD3aYDwe9LFHsmLqGLRsr3OM4mC/CINeDRKhfwoSMq1h/8p8NkonkfJO
         jZKTnPX2Bk7V29YW1NhbuRwyp9/hBn4Nc+9d1TSdpMSkV7swC9O6IZfJXde9ovkpcswG
         C/mf2lZq4Pi4dwn7gWCCReNWegEgNYiWl+XscIUENDpkgW43z7HKmbtuTBHUZzgjgpIw
         8bXDqQk4fLAy+t40S7ALzNpqs4I5Q70Tys0N0xmQfPfWuzuca8yOoVfAbP8l7HpEJ3XP
         bBBw==
X-Gm-Message-State: APjAAAUpNnq0mmBnmQ5uKyy2H2PY+wKSiHEfFNoahdLuLqVqDZb+3ppg
        0rD8fsk/TdrkSJgRoH54v13iq6KQFIDGUDlKNqXtYoOmCnwsjouYzPpRq6LQSKsadUlB3MrEYWf
        Cc6AFTTsKq6VoRRymEjhZ54s=
X-Received: by 2002:ac8:6696:: with SMTP id d22mr27174835qtp.21.1570394924502;
        Sun, 06 Oct 2019 13:48:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5eiRNbN0ZvkDGalLgpCh3K4cVJofIJJn2mxr7k62YnQNTAEmV1kN0lyofp5HIME0E6xxdGQ==
X-Received: by 2002:ac8:6696:: with SMTP id d22mr27174817qtp.21.1570394924025;
        Sun, 06 Oct 2019 13:48:44 -0700 (PDT)
Received: from rhel7lobe ([2600:6c64:4e80:f1:aa45:cafe:5682:368f])
        by smtp.gmail.com with ESMTPSA id y17sm7295110qtb.82.2019.10.06.13.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2019 13:48:43 -0700 (PDT)
Message-ID: <a5c5b4da389e43ac4fb6960135f634a6e2b8ee13.camel@redhat.com>
Subject: Re: packet writing support
From:   Laurence Oberman <loberman@redhat.com>
To:     Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Date:   Sun, 06 Oct 2019 16:48:41 -0400
In-Reply-To: <63a7e40795da8efc782c1985ceeb54e0d3e708b6.camel@cyberfiber.eu>
References: <db5c89c3fe26e4b7ec96443ec97a05df97162889.camel@cyberfiber.eu>
         <6e381f83-9a12-30d7-8f99-caaa6a608c4f@kernel.dk>
         <63a7e40795da8efc782c1985ceeb54e0d3e708b6.camel@cyberfiber.eu>
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7)
Mime-Version: 1.0
X-MC-Unique: hNZoIHe1ND-FlDeiSE5o8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2019-10-06 at 10:31 +0200, Mischa Baars wrote:
> On Sat, 2019-10-05 at 09:50 -0600, Jens Axboe wrote:
>=20
> > It's not really a case of quid pro quo, if someone gets removed,
> > something else can stay. I'd argue that the floppy driver is
> > probably
> > used by orders of magnitude more people than the packet writing
> > code,
> > and as such that makes it much more important to maintain.
>=20
> I'm not into time-reversal, if that is what you mean?! I love
> unilinear time and causal computers!
>=20
> Regards,
> Mischa.
>=20

Hello Mischa
Something is not making sense here.
If this will not be an open source project and not released then why
not simply snapshot the kernel as is now and go ahead.
Maintain it yourself, issue solved. No need to harp on the packet
writing code support anymore.

Many companies have taken a snap of the kernel to use for storage
arrays and then made changes and did not release the entire solution as
open source.

You said

"Yes, I've written the the code myself, thank you. It's prototype
hardware and it's not intended as an open source software project. It
is therefore not going to
be released to the general public. When it's finished, and it isn't at
the moment, it's hopefully going to be part of your future processors.
"

Regards
Laurence Oberman

