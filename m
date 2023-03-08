Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164ACC64EC4
	for <linux-block@archiver.kernel.org>; Wed,  8 Mar 2023 22:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjCHWpP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Mar 2023 17:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjCHWos (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2023 17:44:48 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B76CF0E3
        for <linux-block@vger.kernel.org>; Wed,  8 Mar 2023 14:44:40 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cy23so71789561edb.12
        for <linux-block@vger.kernel.org>; Wed, 08 Mar 2023 14:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678315479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgHOh6/Mv9MfzuVql9i7aCQo+w921G9eVyn2ZtvpMeA=;
        b=ChLxkbti85NFZ2bXwntnqX7+pCAtU4R9zEVz+IPKSMidHCU6Q4i/ZCObD+qtLN80tz
         Sfw9PfBByt/3fUuxZt8p9LPYyj9aQ08wzzhiW/+AvvgwawrPayjAVA6haeyRjF8wLACL
         tLURNvFC6q6DhwOgPzPCA/5SieMbhAg2+lQnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgHOh6/Mv9MfzuVql9i7aCQo+w921G9eVyn2ZtvpMeA=;
        b=idc+m7/eOmj3m1u5Up+PyCyw0o9ki++Nm3fqdP+byOPZmCAtPGJcqp+Lwrr4/JPPwN
         rL2gyRXicSfm4omz+IWFgotjZ6rPoDkK/e9XdFWrxYC2ExnSfcwo1bimNPkWbLjVbJGG
         szDIWRJvc5/8FdAwTbq6JeIWb4lqH2RfPlJ1pMainPu76FpWi/sOVgQEcstYPoMWodCq
         uSpHadGH8eCaL0nYiIroeVh7sgT9ry+YlRx4BJ5e75LwpFoFq3qnwQG7kzFYBzcVjHOe
         8jm9sTD6ObXuaVFfh5GbIVgbPLeDCZL2m5K4j3eTR4mEBv0J8dZjCqRaAWxaouDrgblh
         +99w==
X-Gm-Message-State: AO0yUKV2qnfcS7rLKQ/uXKCBFPIRRASjfy3OA2IkSQnD/zkSXfHVNHSS
        lUsimjZ9ytyDoI/coWxiE/S8N3/xdbjFLcP0eBGGQ729
X-Google-Smtp-Source: AK7set+4xSwChGw0SHsIQ6+6vWvMRcAD/nzdoRCITpw8vnx1i60oLgaVuAad1SENzeRMSOrgvMolEg==
X-Received: by 2002:a17:906:4c8e:b0:8af:447a:ff8e with SMTP id q14-20020a1709064c8e00b008af447aff8emr17442988eju.20.1678315479139;
        Wed, 08 Mar 2023 14:44:39 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id si9-20020a170906cec900b008c5075f5331sm7931294ejb.165.2023.03.08.14.44.38
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 14:44:38 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so2820443wms.0
        for <linux-block@vger.kernel.org>; Wed, 08 Mar 2023 14:44:38 -0800 (PST)
X-Received: by 2002:a50:8750:0:b0:4c2:ed2:1196 with SMTP id
 16-20020a508750000000b004c20ed21196mr10973452edv.5.1678315158081; Wed, 08 Mar
 2023 14:39:18 -0800 (PST)
MIME-Version: 1.0
References: <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-4-dhowells@redhat.com>
In-Reply-To: <20230308165251.2078898-4-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Mar 2023 14:39:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com>
Message-ID: <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com>
Subject: Re: [PATCH v17 03/14] shmem: Implement splice-read
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
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

On Wed, Mar 8, 2023 at 8:53=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> The new filemap_splice_read() has an implicit expectation via
> filemap_get_pages() that ->read_folio() exists if ->readahead() doesn't
> fully populate the pagecache of the file it is reading from[1], potential=
ly
> leading to a jump to NULL if this doesn't exist.  shmem, however, (and by
> extension, tmpfs, ramfs and rootfs), doesn't have ->read_folio(),

This patch is the only one in your series that I went "Ugh, that's
really ugly" for.

Do we really want to basically duplicate all of filemap_splice_read()?

I get the feeling that the zeropage case just isn't so important that
we'd need to duplicate filemap_splice_read() just for that, and I
think that the code should either

 (a) just make a silly "read_folio()" for shmfs that just clears the page.

     Ugly but maybe simple and not horrid?

or

 (b) teach filemap_splice_read() that a NULL 'read_folio' function
means "use the zero page"

     That might not be splice() itself, but maybe in
filemap_get_pages() or something.

or

 (c) go even further, and teach read_folio() in general about file
holes, and allow *any* filesystem to read zeroes that way in general
without creating a folio for it.

in a perfect world, if done well I think shmem_file_read_iter() should
go away, and it could use generic_file_read_iter too.

I dunno. Maybe shm really is *so* special that this is the right way
to do things, but I did react quite negatively to this patch. So not a
complete NAK, but definitely a "do we _really_ have to do this?"

                       Linus
