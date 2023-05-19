Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDA9C7EE29
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 17:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjESRqX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 13:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjESRqV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 13:46:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159BB107
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 10:46:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96f53c06babso276856966b.3
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684518378; x=1687110378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ucWVdofg5ar9Sy7957FpoXFp27vLdLXG53ARFC9CGo=;
        b=dmfgn+2oAtG1+yz3ye1VFrOvDqB00VHnc38rAnVtSe1ptEoW20JJ1GB+2o7KpZ6zJ5
         qffkaBJLz6in6/yqKmmfcGxkkMiXPQ8pUcaFMNSZzFyoqtd+qoYrWxiGqqI5nBIouZlW
         ZTluPzxq7n1VB+de1iHs8hKkh1M4QN2hS8RXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684518378; x=1687110378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ucWVdofg5ar9Sy7957FpoXFp27vLdLXG53ARFC9CGo=;
        b=aSb1Q7HUwxIGeSeYvAb/qv9W2onnxFkZ4G98JiMW2SF7obTXJ9GGDc94gDLA1msmKm
         XoNCbtbYi9Y+8gxnHYbQ8dUylTcCzcSuyV48AZjaJXeCOCF27RhF1HgB7m23ZUz1icEG
         sFzMo6CtTPTXgw16E81fLIXbRECzkl8MKBmwQZbN3WB3KonJxZEQreis0hZG088OLseY
         rKXM8g4PfSnuO1maUZxQZ2J9itjgKL2GBT2oO9SO/kO4cHkUTTHzBAlF1Lc4/GzKr7Wk
         gNZd0jqrOaUZAx10/U+Up2pOBwTI3ma7PE+0pjLh9YADUo38U/M/GbBRRcSBhw7W6FDN
         X4Pw==
X-Gm-Message-State: AC+VfDw6Pa0mqqENSRWWtZsm0QDLeflyWd5Ls9+0mlMEagFd9woqhU4N
        C+Ewunig37lh+Oaeizi0xySujr3tdgJaVFU76kZRLzvc
X-Google-Smtp-Source: ACHHUZ7YfqbAxu2DaV2r3Ntcc394o0ySdxijUeQH/LDYC7cuaTZ1hS84rNH2N4QkCG51OmtLRfYQ9w==
X-Received: by 2002:a17:907:9448:b0:953:3e29:f35c with SMTP id dl8-20020a170907944800b009533e29f35cmr2721253ejc.45.1684518378310;
        Fri, 19 May 2023 10:46:18 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id j20-20020a1709062a1400b00965bf86c00asm2562232eje.143.2023.05.19.10.46.17
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:46:18 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso6444377a12.2
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 10:46:17 -0700 (PDT)
X-Received: by 2002:a17:906:db0d:b0:94f:1a23:2f1b with SMTP id
 xj13-20020a170906db0d00b0094f1a232f1bmr2341051ejb.24.1684517896563; Fri, 19
 May 2023 10:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-4-dhowells@redhat.com>
 <CAHk-=whX+mAESz01NJZssoLMsgEpFjx7LDLO1_uW1qaDY2Jidw@mail.gmail.com> <1845768.1684514823@warthog.procyon.org.uk>
In-Reply-To: <1845768.1684514823@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 10:37:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDq5_wLWrapzFiJ3ZNn6aGFWeMJpAj5q+4z-Ok8DD9dA@mail.gmail.com>
Message-ID: <CAHk-=wjDq5_wLWrapzFiJ3ZNn6aGFWeMJpAj5q+4z-Ok8DD9dA@mail.gmail.com>
Subject: Re: [PATCH v20 03/32] splice: Make direct_read_splice() limit to eof
 where appropriate
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 19, 2023 at 9:48=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> This is just an optimisation to cut down the amount of bufferage allocate=
d

So the thing is, it's actually very very wrong for some files.

Now, admittedly, those files have other issues too, and it's a design
mistake to begin with, but look at a number of files in /proc.

In particular, look at the regular files that have a size of '0'. It's
quite common indeed. Things like

    /proc/cpuinfo
    /proc/stat
    ...

you can find a ton of them with

    find /proc -type f -size 0

Is it horribly wrong and bad? Yes. I hate it. It means that some
really basic user space tools refuse to work on them, and the tools
are 100% right - this is a kernel misfeature. Trying to do things like

    less -S /proc/cpuinfo

may or may not work depending on your version of 'less', for example,
because it's entirely reasonable to do something like

    fd =3D open(..);
    if (!fstat(fd, &st))
         len =3D st.st_size;

and limit your reads to the size of the file - exactly like your patch does=
.

Except it fails horribly on those broken /proc files.

I hate it, and I blame myself for the above horror, but it's pretty
much unfixable. We could make them look like named pipes or something,
but that's really ugly and probably would break other things anyway.
And we simply don't know the size ahead of time.

Now, *most* things work, because they just do the whole "read until
EOF". In fact, my current version of 'less' has no problem at all
doing the above thing, and gives the "expected" output.

Also, honestly, I really don't think that it's necessarily a good idea
to splice /proc files, but we actually do have splice wired up to
these because people asked for it:

    fe33850ff798 ("proc: wire up generic_file_splice_read for iter ops")
    4bd6a7353ee1 ("sysctl: Convert to iter interfaces")

so I suspect those things do exist.

> I could just drop it and leave it to userspace for now as the filesystem/=
block
> layer will stop anyway if it hits the EOF.  Christoph would prefer that I=
 call
> direct_splice_read() from generic_file_splice_read() in all O_DIRECT case=
s, if
> that's fine with you.

I guess that's fine, and for O_DIRECT itself it might even make sense
to do the size test. That said, I doubt it matters: if you use
O_DIRECT on a small file, you only have yourself to blame for doing
something stupid.

And if it isn't a small file, then who cares about some small EOF-time
optimization? Nobody.

So I would suggest not doing that optimization at all, because as-is,
it's either pointless or actively broken.

That said, I would *not* hate some kind of special FMODE_SIZELIMIT
flag that allows filesystems to opt in to "limit reads to size".

We already have flags like that: FMODE_UNSIGNED_OFFSET and
'sb->s_maxbytes' are both basically variations on that same theme, and
having another flag to say "limit reads to i_size" wouldn't be wrong.

It's only wrong when it is done mindlessly with S_ISREG().

             Linus
