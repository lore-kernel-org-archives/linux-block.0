Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60973 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751176AbcIHACL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Sep 2016 20:02:11 -0400
Subject: Re: [PATCH v2 1/5] blk-mq: abstract tag allocation out into
 scale_bitmap library
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        <linux-block@vger.kernel.org>
References: <cover.1473291702.git.osandov@fb.com>
 <de3d08bb7b2a2f20bd456112b97a9ab2fe6f1573.1473291702.git.osandov@fb.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <57D0AA74.5010000@fb.com>
Date: Wed, 7 Sep 2016 17:01:56 -0700
MIME-Version: 1.0
In-Reply-To: <de3d08bb7b2a2f20bd456112b97a9ab2fe6f1573.1473291702.git.osandov@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 9/7/16 4:46 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> This is a generally useful data structure, so make it available to
> anyone else who might want to use it. It's also a nice cleanup
> separating the allocation logic from the rest of the tag handling logic.
>
> The code is behind a new Kconfig option, CONFIG_SCALE_BITMAP, which is
> only selected by CONFIG_BLOCK for now.
>
> This should be a complete noop functionality-wise.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>   MAINTAINERS                  |   1 +
>   block/Kconfig                |   1 +
>   block/blk-mq-tag.c           | 469 ++++++++++---------------------------------
>   block/blk-mq-tag.h           |  37 +---
>   block/blk-mq.c               | 113 +++--------
>   block/blk-mq.h               |   9 -
>   include/linux/blk-mq.h       |   9 +-
>   include/linux/scale_bitmap.h | 340 +++++++++++++++++++++++++++++++
>   lib/Kconfig                  |   3 +
>   lib/Makefile                 |   2 +
>   lib/scale_bitmap.c           | 305 ++++++++++++++++++++++++++++
...
> diff --git a/include/linux/scale_bitmap.h b/include/linux/scale_bitmap.h
> new file mode 100644
> index 0000000..63f712b
> --- /dev/null
> +++ b/include/linux/scale_bitmap.h
> @@ -0,0 +1,340 @@
> +/*
> + * Fast and scalable bitmaps.
...
> +/**
> + * struct scale_bitmap_word - Word in a &struct scale_bitmap.
> + */
> +struct scale_bitmap_word {
> +/**
> + * struct scale_bitmap - Scalable bitmap.
> + *
> + * A &struct scale_bitmap is spread over multiple cachelines to avoid ping-pong.
> + * This trades off higher memory usage for better scalability.
> + */
> +struct scale_bitmap {

scale_bitmap sounds odd, since 'scale' is also a verb.
We also have lib/rhashtable.c:
  * Resizable, Scalable, Concurrent Hash Table
everything is 'scalable' nowadays.
May be resizable bitmap would be a better name?
'struct rbitmap'... lib/rbitmap.c ?

