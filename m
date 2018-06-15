Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40013 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965639AbeFOPn7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jun 2018 11:43:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id n5-v6so4631263wmc.5
        for <linux-block@vger.kernel.org>; Fri, 15 Jun 2018 08:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180609123014.8861-1-ming.lei@redhat.com> <20180609123014.8861-31-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-31-ming.lei@redhat.com>
From: Gi-Oh Kim <gi-oh.kim@profitbricks.com>
Date: Fri, 15 Jun 2018 17:43:22 +0200
Message-ID: <CAJX1YtZYrRwQgASEX_CQtBEcYuk02LA=cKibsx=TitC70_=+zg@mail.gmail.com>
Subject: Re: [PATCH V6 30/30] block: document usage of bio iterator helpers
To: ming.lei@redhat.com
Cc: Jens Axboe <axboe@fb.com>, hch@infradead.org,
        Al Viro <viro@zeniv.linux.org.uk>, kent.overstreet@gmail.com,
        dsterba@suse.cz, ying.huang@intel.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, tytso@mit.edu,
        darrick.wong@oracle.com, colyli@suse.de, fdmanana@gmail.com,
        rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Jun 9, 2018 at 2:36 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> Now multipage bvec is supported, and some helpers may return page by
> page, and some may return segment by segment, this patch documents the
> usage for helping us use them correctly.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  Documentation/block/biovecs.txt | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/Documentation/block/biovecs.txt b/Documentation/block/biovec=
s.txt
> index 25689584e6e0..3ab72566141f 100644
> --- a/Documentation/block/biovecs.txt
> +++ b/Documentation/block/biovecs.txt
> @@ -117,3 +117,33 @@ Other implications:
>     size limitations and the limitations of the underlying devices. Thus
>     there's no need to define ->merge_bvec_fn() callbacks for individual =
block
>     drivers.
> +
> +Usage of helpers:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +* The following helpers, whose names have the suffix "_all", can only be
> +used on non-BIO_CLONED bio, and usually they are used by filesystem code=
,
> +and driver shouldn't use them because bio may have been split before the=
y
> +got to the driver:
> +
> +       bio_for_each_chunk_segment_all()
> +       bio_for_each_chunk_all()
> +       bio_pages_all()
> +       bio_first_bvec_all()
> +       bio_first_page_all()
> +       bio_last_bvec_all()
> +
> +* The following helpers iterate bio page by page, and the local variable=
 of
> +'struct bio_vec' or the reference records single page io vector during t=
he
> +iteration:
> +
> +       bio_for_each_segment()
> +       bio_for_each_segment_all()

bio_for_each_segment_all() is removed, isn't it?

> +
> +* The following helpers iterate bio chunk by chunk, and each chunk may
> +include multiple physically contiguous pages, and the local variable of
> +'struct bio_vec' or the reference records multi page io vector during th=
e
> +iteration:
> +
> +       bio_for_each_chunk()
> +       bio_for_each_chunk_all()
> --
> 2.9.5
>


--=20
GIOH KIM
Linux Kernel Entwickler

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 176 2697 8962
Fax:      +49 30 577 008 299
Email:    gi-oh.kim@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg, Christoph Steff=
ens
