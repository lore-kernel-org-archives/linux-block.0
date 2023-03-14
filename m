Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE05EC05027
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 18:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjCNSDE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 14:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjCNSDD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 14:03:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59038E3CB
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 11:03:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cy23so65394382edb.12
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678816980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaNrWV0j7xcmGChzOfmkTnIc3tuBbFeTK4GfA059lX0=;
        b=A355oSfcS4IPkDnWgCLNYE3gtKpKx8SSzUdqkM4uAX5YXMXLzLtZSXfYmX1DKdWWsf
         baCik0PqYXtSj6qxvChNsn7kFuSEL4gSpsLgVh0midQaUV0TPrAM785rJfl1WY1M3cug
         hufMQEu+RmMfWQw5pnxLWJ1o5MvYPwQTbNlV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678816980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaNrWV0j7xcmGChzOfmkTnIc3tuBbFeTK4GfA059lX0=;
        b=1fNg2GToXo6jS7ce/FMD5p+qyR/Lc16AGHlrzTTdmk7de2psF6hhrwdMduZvwgYkDq
         lDf3TRxtu51oxvUJJ3PMlW6r+6IoK56aGNlKOIQodYawan8iz7glmwCikPFnZOCJY0G6
         Eo1TB9ofT51N2gqFVxxAwDigvl5oIdFJEy7rNJWDwPKmd9YTCQJuafEssBzoKdxHhD1G
         ljDHjQFwzQ+lBZIQNth2SKLSpAloyQpYVsF/qwWmwO4vY6uV1KHAFiJr8C9zBdlFN8Gc
         WTfrXgMHTq9MreqqK7z7sK7FcTUdEx/YPl5xhhK1AVewN8rwbJ1s7pXSZ8zv+Pyzowsm
         8yDQ==
X-Gm-Message-State: AO0yUKV0c4rFrdC53MfvtoUzFh1wJ+WAhxVnUOFKMk2G5Ivw7AOHuHBC
        wHxpskxBARehMky3nB/GCkGtChJ5E7yjO5ss+Z+s9g==
X-Google-Smtp-Source: AK7set9E3lBf+xCDs4Am+d68qeqcWDqg/5xKhEK1HCniY8clbcDWp2WJb8nibu5kFo2SlZPtVa57hw==
X-Received: by 2002:a17:907:a2ce:b0:8a9:e031:c4b7 with SMTP id re14-20020a170907a2ce00b008a9e031c4b7mr3161739ejc.4.1678816979920;
        Tue, 14 Mar 2023 11:02:59 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id l1-20020a170906644100b0091f5e98abd5sm1425571ejn.133.2023.03.14.11.02.58
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 11:02:58 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id z21so208777edb.4
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 11:02:58 -0700 (PDT)
X-Received: by 2002:a17:906:c30e:b0:8ad:d366:54c4 with SMTP id
 s14-20020a170906c30e00b008add36654c4mr1933623ejz.4.1678816977991; Tue, 14 Mar
 2023 11:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-4-dhowells@redhat.com>
 <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com> <ZBCkDvveAIJENA0G@casper.infradead.org>
In-Reply-To: <ZBCkDvveAIJENA0G@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Mar 2023 11:02:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com>
Message-ID: <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com>
Subject: Re: [PATCH v17 03/14] shmem: Implement splice-read
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
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

On Tue, Mar 14, 2023 at 9:43=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> The problem is that we might have swapped out the shmem folio.  So we
> don't want to clear the page, but ask swap to fill the page.

Doesn't shmem_swapin_folio() already basically do all that work?

The real oddity with shmem - compared to other filesystems - is that
the xarray has a value entry instead of being a real folio. And yes,
the current filemap code will then just ignore such entries as
"doesn't exist", and so the regular read iterators will all fail on
it.

But while filemap_get_read_batch() will stop at a value-folio, I feel
like filemap_create_folio() should be able to turn a value page into a
"real" page. Right now it already allocates said page, but then I
think filemap_add_folio() will return -EEXIST when said entry exists
as a value.

But *if* instead of -EEXIST we could just replace the value with the
(already locked) page, and have some sane way to pass that value
(which is the swap entry data) to readpage(), I think that should just
do it all.

Admittedly I really don't know this area very well, so I may be
*entirely* out to lunch.

But the whole "teach the filemap code to actually react to XA value
entries" would be how I'd solve the hole issue too. So I think there
are commonalities here.

             Linus
               Linus
