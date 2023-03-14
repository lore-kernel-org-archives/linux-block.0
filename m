Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DCCC6FD1D
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 23:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCNXkS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 19:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCNXkS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 19:40:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B9637B45
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 16:40:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r11so17178333edd.5
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 16:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678837215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNuC5vuLHUrjsLAEtJntp1DYmMh0ryjDseFJIAEyVKE=;
        b=SWqsjXNtJB90zrndCdVwNbsgqtdhu21jKTQCRGI+yGN8eaKZJdg+Ia/4z6CNA17e25
         +YbzCjCwIJrc7wvpays0t0a4NTBUNih9VnP0oyTKL7nPZ/+d2WBNWGYNhQ4STTZShx2W
         uU8qXwm4+fPS4iWPXCcND8/UwnyPMdHQUuyoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678837215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNuC5vuLHUrjsLAEtJntp1DYmMh0ryjDseFJIAEyVKE=;
        b=yhHktUMjmtFPLuebuurIEeIAnMzfCHdNOJo2Sa3D2hqPAAzqn5BYnGjKzTaunSpU96
         z1tVsxZtXtE0cc6pv/M1WFtPpxXjFr3f5N9vszxG7ZMqjkNwZPBPiqLGnTeor2/TYwYo
         uhTC3+ek/EC9aNKVK+tII9VwObyPncY7FzUhIiIB5Nl0BPHEANvyWB3BdoFssaeWEhbl
         G9rV0j7mLnU6hFktgy3M6Br7xWRGIXaWMLWCVTtYzSlnmYWKvrF+b6jJ0oqjYvTIoxjG
         bpn+u46ZPGToULh244Xj0IeWLnsCT2Td2yrTN2vlsX6V1SBiL6q/fc19ExY4arjI+lx6
         igkg==
X-Gm-Message-State: AO0yUKUBdnCaUMKkbl/zz4B/JswAReEMolMqpJHnH3czS6epsm7eKrkR
        rkLojq6NSv5lRQuFxEw3FUt4VCX/OW8hWi++XXCsNA==
X-Google-Smtp-Source: AK7set+Kjd9Ebikst6thxYf/Ew9u8feYiojxm8LYXGuS6ilrXdaMr+0f3rrGW45iSsB/Ip3TBKv7vg==
X-Received: by 2002:a17:907:608c:b0:92e:d6e6:f3ad with SMTP id ht12-20020a170907608c00b0092ed6e6f3admr372129ejc.6.1678837214961;
        Tue, 14 Mar 2023 16:40:14 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id ga31-20020a1709070c1f00b008b904cb2bcdsm1750618ejc.11.2023.03.14.16.40.12
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 16:40:13 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id o12so68798298edb.9
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 16:40:12 -0700 (PDT)
X-Received: by 2002:a50:d506:0:b0:4fb:482b:f93d with SMTP id
 u6-20020a50d506000000b004fb482bf93dmr435862edi.2.1678837212326; Tue, 14 Mar
 2023 16:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230314220757.3827941-1-dhowells@redhat.com> <20230314220757.3827941-4-dhowells@redhat.com>
In-Reply-To: <20230314220757.3827941-4-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Mar 2023 16:39:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKPK=Bn_je2A19rSptpDo589DWxBJi8UQYS7sPjDPurw@mail.gmail.com>
Message-ID: <CAHk-=whKPK=Bn_je2A19rSptpDo589DWxBJi8UQYS7sPjDPurw@mail.gmail.com>
Subject: Re: [PATCH v18 03/15] shmem: Implement splice-read
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
        Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 14, 2023 at 3:08=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
\> +static size_t splice_zeropage_into_pipe(...
>   ...
> +               *buf =3D (struct pipe_buffer) {
> +                       .ops    =3D &zero_pipe_buf_ops,
> +                       .page   =3D ZERO_PAGE(0),
> +                       .offset =3D offset,
> +                       .len    =3D size,
> +               };
> +               get_page(buf->page);

That

+               get_page(buf->page);

is still there, and now it's doubly wrong because it's never dropped
and will eventually overflow that count that shouldn't even be there.

             Linus
