Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21199C77B7A
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 17:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjEYRV4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 13:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjEYRVv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 13:21:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA1F19C
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 10:21:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4d80bac38so962439e87.2
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685035308; x=1687627308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zMzRygPKkdKlo23QW/uYg+LGfB6C3Hjzj0Tw04tNig=;
        b=XjezFziPW+pxwjS3AWttrsHiJeNM3jO++5s42fJP1YdqkK0dTYWLjNTu4R9LzBcrJy
         KVSsK54UC/s46QZIL1adWVdJOk1hVc/mUH/3BYXVQ6xV2nsFZrp1jYRaD320XiRxqIIP
         jIkye5PCNE7P9WhAZxO5RONfIYsqILW4b8CVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685035308; x=1687627308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zMzRygPKkdKlo23QW/uYg+LGfB6C3Hjzj0Tw04tNig=;
        b=SwMVhP5UKZNNP5XLk+/CsXda9U6ru0hZAA42coJtWwrE2MM5a2N3G8pJ0fpa3n1bnU
         mRz/63SzSVimfO5ikEdw4Hw4snK31F1vg/uygdzReJq4GAfVlKHS/MLZn7I6dkrICtsm
         62VEHH+ojMM7AwAPsp0o0CqC/juelfYE7luRDK+ZcJkTh7QVe5XVjDIwHT37YPtMrI31
         j6D7/ZjqtVvlVBfIpVl4QPZM38DM+S6RHC5iLZfBUUkHvPZxVEBLJrhC7khSsL5Z0S74
         rc4JVzYSWJQSXENf0LA3+RwFUcVa1UvcX8p6Bq60MFXRJF31D7bTPu3EtM05TlMTE97i
         hZyw==
X-Gm-Message-State: AC+VfDzaOcimcJfFtvlq9ZynXbiol0Qme8Z83vO4FZkueQlumh/8p7ut
        fcrbw8CVk1bP6SvZ/wOq4G5pUIt/iWH3+znaCDbXFQ3K
X-Google-Smtp-Source: ACHHUZ63Fe2TSQ8czNJbgurgXlTK7WHhmW+aJshRcPM8xgM86Gc/h9bWQKGC+tGsTUh7HwzYQ+OW8Q==
X-Received: by 2002:ac2:5602:0:b0:4f4:d0ab:97d5 with SMTP id v2-20020ac25602000000b004f4d0ab97d5mr1158996lfd.14.1685035308385;
        Thu, 25 May 2023 10:21:48 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id q20-20020a19a414000000b004f271790d6csm276455lfc.136.2023.05.25.10.21.47
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 10:21:48 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4f4bdcde899so2716219e87.0
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 10:21:47 -0700 (PDT)
X-Received: by 2002:a17:907:a49:b0:96a:498a:bd4b with SMTP id
 be9-20020a1709070a4900b0096a498abd4bmr2248713ejc.64.1685034836175; Thu, 25
 May 2023 10:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org>
 <3215177.1684918030@warthog.procyon.org.uk> <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
 <88983.1685034059@warthog.procyon.org.uk>
In-Reply-To: <88983.1685034059@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 10:13:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguy6bcoUznDCU3mr-wbi-8NigkTw5GvwiF8R76J=vGUQ@mail.gmail.com>
Message-ID: <CAHk-=wguy6bcoUznDCU3mr-wbi-8NigkTw5GvwiF8R76J=vGUQ@mail.gmail.com>
Subject: Re: Extending page pinning into fs/direct-io.c
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 25, 2023 at 10:01=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> What do we gain from it?  Presumably since nothing is supposed to write t=
o
> that page, it can be shared in all the caches.

I don't remember the details, but they went something like "broken
purely virtually indexed cache avoids physical aliases by cacheline
exclusion at fill time".

Which then meant that if you walk a zero mapping, you'll invalidate
the caches of the previous page when you walk the next one.  Causing
horrendously bad performance.

Unless it's colored.

Something like that. I probably got all the details wrong.

                Linus
