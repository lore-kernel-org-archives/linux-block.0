Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73E0C6FD1F
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 19:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCNTPh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 15:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCNTPg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 15:15:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9815D34323
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 12:15:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o12so66307183edb.9
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 12:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678821326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAToBCAVYt3GcGYadQEhb7AkREOTPXmIkwVjM1uSyZg=;
        b=bp/1XnEfMOVVgkVuXGDbLCETn1HWQMaGTl5iXTyUBYdJib7zhMpymdp46nponpQ25I
         /5mW/ubRpskp0aRTdAQUTy35cyausQACNsJ6UgVC19Uhk9GQlBskq6I/bOpy7xrg4X5f
         DB/JkKjiPbUD8IYU0wsAl2K7siy9t1j9+8psQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678821326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAToBCAVYt3GcGYadQEhb7AkREOTPXmIkwVjM1uSyZg=;
        b=09xzOh+4Z+ai3++Mvqa3rrnoGItPzbhkw2x/O8HbMvPYTrB3lV1cVBdmfYE1SaE0I7
         hlx4zMLcLQcG+zLGw5yMBA2AFuUlJAUb5iRmP422K4nxq9af/9VmJdGAJBjCLFaZyFgo
         k6KkN1vvWwJ+CDUVKqGPN4u162e+prYC09FRL/H3ZxxAPJzU7HYvj0tQICqIP+uAXlhZ
         OT90qnn7Ua0f8TLKQ4yUbcA6RnvVYV2JkmC0T18EF+6vSS9P9bWWF8gBlsbgXb9rGhqu
         bO5IivBvdfDYzB4mJ8ZqG3ckTaTctBtkfSGAnAZ6FIsLXQ0Li5xJgGWb6ftt9d4wvAUO
         Ucow==
X-Gm-Message-State: AO0yUKVThoRccmpBCzPFQvja405/bp3blUV8yo3u2TcV7EXK0z3NrHAj
        J5YIubTrtkl35xeOTenibXXOtqMY1olGUJpnkERaDQ==
X-Google-Smtp-Source: AK7set/TtoVjffLODAAGfjG65lODSf7H4R+SH1FuAVeRZs0JErpiJ2aEKEWzu+EVYebUMfI7TyQTig==
X-Received: by 2002:a17:906:844f:b0:8bf:e95c:467b with SMTP id e15-20020a170906844f00b008bfe95c467bmr3126162ejy.63.1678821325850;
        Tue, 14 Mar 2023 12:15:25 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id i9-20020a50d749000000b004af6163f845sm1449499edj.28.2023.03.14.12.15.25
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 12:15:25 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id z21so1015883edb.4
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 12:15:25 -0700 (PDT)
X-Received: by 2002:a17:907:2069:b0:8af:4963:fb08 with SMTP id
 qp9-20020a170907206900b008af4963fb08mr1869330ejb.15.1678821000656; Tue, 14
 Mar 2023 12:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-4-dhowells@redhat.com>
 <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com>
 <ZBCkDvveAIJENA0G@casper.infradead.org> <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com>
 <3761465.1678818404@warthog.procyon.org.uk> <CAHk-=wh-OKQdK2AE+CD_Y5bimnoSH=_4+F5EOZoGUf3SGJdxGA@mail.gmail.com>
In-Reply-To: <CAHk-=wh-OKQdK2AE+CD_Y5bimnoSH=_4+F5EOZoGUf3SGJdxGA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Mar 2023 12:09:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEuJ6VXqaCemzXR-nss_aM-hUVWEnKSwdGioQJXDLF_g@mail.gmail.com>
Message-ID: <CAHk-=whEuJ6VXqaCemzXR-nss_aM-hUVWEnKSwdGioQJXDLF_g@mail.gmail.com>
Subject: Re: [PATCH v17 03/14] shmem: Implement splice-read
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 14, 2023 at 12:07=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Maybe we can do /dev/null some day and actually have a common case for th=
ose.

/dev/zero, I mean. We already do splice to /dev/null (and splicing
from /dev/null isn't interesting ;)

            Linus
