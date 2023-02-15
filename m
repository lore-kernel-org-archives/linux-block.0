Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D3EC636CC
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 15:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBOPuS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 10:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBOPuR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 10:50:17 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93063366A6
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 07:50:16 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cq19so20014232edb.5
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 07:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gxx4XcKwvyNpOp3VEGiE+719FH+KggeO1TDcZH8XIXc=;
        b=fUwRQosoarROxeHu1csL4um6cmJozX9RvBTdZqgdbzyF8Barwc8bIYcCdoDTmo/GS3
         IrM2E/JJIeMfYbsTW+034l9vqtsfBsV6SKeI/tbgP1heCoXj5YxjirQn7a2KEY1Q5MRe
         3QmYbDaieDTABhmer07N0SUOHXk1nlNqWCtBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gxx4XcKwvyNpOp3VEGiE+719FH+KggeO1TDcZH8XIXc=;
        b=sb3PrIrnsuzAIJHwhUPOPJQ1eWRlbGFjw42YobcP7+vkL7tanPZh19T3k+HG91zXqC
         Xs1aBA982tYyywvrNrEWcjBxMB1UpRck3W5UGb6y3oxCkU5Wp7RAkRYmOEOvjq5bvbr4
         Fdx+wkQ5iMSFRRd81bSwFcJ0PkdORsg6IAilgivAUP3aA0+jdX2FSY5CTwGStVESnadd
         VTZhG17qqD1bWSyRihd3LSiZPklWDtuYTWcCOh15XsbZGh5ftB8axkGjab9JrOgaRrTf
         kCA0vJ4RkaxOAs85XrgPvE80CdG16OJTgRny0wywcXPhbw8Ut5EuwDv3VDjavcgYTN1U
         iChQ==
X-Gm-Message-State: AO0yUKW+8zR4iHfoKb/ujpf/LRnK3pripj7I3AOE5z1OvsEWKW62WiSA
        iredtBhR5hx7Bf8LnB57eZbs2hvhhyKO+M5vTGj0qg==
X-Google-Smtp-Source: AK7set/c1PSjKuHwb5HoUktp2BYZfMk+QVL6t/16rqfQYUzXFAPu8C+88H0jVH04WKFY9zcgUpkjnk6LsbMVdzmu3MI=
X-Received: by 2002:a50:99c1:0:b0:4aa:b30f:c784 with SMTP id
 n1-20020a5099c1000000b004aab30fc784mr1318317edb.8.1676476215115; Wed, 15 Feb
 2023 07:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20230214171330.2722188-1-dhowells@redhat.com> <20230214171330.2722188-6-dhowells@redhat.com>
 <CAJfpegshWgUYZLc5v-Vwf6g3ZGmfnHsT_t9JLwxFoV8wPrvBnA@mail.gmail.com> <3370085.1676475658@warthog.procyon.org.uk>
In-Reply-To: <3370085.1676475658@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 15 Feb 2023 16:50:04 +0100
Message-ID: <CAJfpegt5OurEve+TvzaXRVZSCv0in8_7whMYGsMDdDd2EjiBNQ@mail.gmail.com>
Subject: Re: [PATCH v15 05/17] overlayfs: Implement splice-read
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
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 15 Feb 2023 at 16:41, David Howells <dhowells@redhat.com> wrote:
>
> How about the attached then?
>
> David
> ---
> overlayfs: Implement splice-read
>
> Implement splice-read for overlayfs by passing the request down a layer
> rather than going through generic_file_splice_read() which is going to be
> changed to assume that ->read_folio() is present on buffered files.

Looks good.  One more suggestion: add a vfs_splice() helper and use
that from do_splice_to() as well.

Thanks,
Miklos
