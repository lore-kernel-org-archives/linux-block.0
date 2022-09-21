Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFCAECAAD8
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 12:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiIUMQ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 08:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIUMQ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 08:16:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB52A7D1C5
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 05:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663762584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lRz/z/AXpEruTQsHU4EAQEPc0Y+Waw+jrJW7+kWECyI=;
        b=HC1WaawmTydvuc2LUpWkM8stA646rPW9rVnWDrInzSOEHFSiILBF18jfAL1GdizbpJQK/u
        ATYiFKN3pCjg/fZXJm+VhXq52z3jAgSGoFIvFDX3jQGZPePiTamidNb9XxlYWvBvFDOQrg
        c6o/b/+e4R6BXmQK9oHEDomgVU9bwx0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-133-MiyWjtkHPuGg2HYcJPaO3w-1; Wed, 21 Sep 2022 08:16:23 -0400
X-MC-Unique: MiyWjtkHPuGg2HYcJPaO3w-1
Received: by mail-pg1-f200.google.com with SMTP id 14-20020a63000e000000b00438c0563dc2so3354855pga.9
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 05:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lRz/z/AXpEruTQsHU4EAQEPc0Y+Waw+jrJW7+kWECyI=;
        b=KhhrTf2jvesQQJeoFHq+Hi7r/BMAZvg5AAikN9Q5qXYTjGu8WWKNncbBPwnlWKNkBf
         lOhqF8v7y0x7Hjz1xTUlPZjF+o8uKVdfDNROCjIF3fA1120nWXkPOMPuA97jPu09S/zx
         7Ue49M0Ehh7N1r80Hmgtr2qnZftqVd9737KFju8j6qdZOggvyYEhODN3Gc+MXnkA9a6E
         vPjNLsbptKec1c9LublcmlHk2rKlssOHh4KCkOTZ/Bs1/uSfrvuudwyjkc8PGkeKrXdg
         4ejf2HLY7iIUEH6cF83XKj1HvPEL6cauCLw/4fALppnXdA8Fu0T9qcbx8VOQ4PO8jWbd
         bEhQ==
X-Gm-Message-State: ACrzQf3HjqQrJanMD0mIJ9EZvyq6hVWrVn8yJIxI+jnjhVwjmw6SWIu9
        N2f6IQi09x0zhgpEEUjM4j+OF5qgsa7el6pLp2AOmlQWH6fJzkMUWLqDMQLTBEtSyMAmNJZJ0oM
        TZzb22Bn0jwvbXMujNTvnpULuNMUDoZYBwwZR8ds=
X-Received: by 2002:a05:6a00:114c:b0:528:2c7a:6302 with SMTP id b12-20020a056a00114c00b005282c7a6302mr28503661pfm.37.1663762582639;
        Wed, 21 Sep 2022 05:16:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5r/ijjU2c5rOZiLzk/NojDFwRsD3xgDKZQeggVJqltBvK5luALhPFt8HfhxhdtEdOtWZNDc8CkV8CGgvipPTc=
X-Received: by 2002:a05:6a00:114c:b0:528:2c7a:6302 with SMTP id
 b12-20020a056a00114c00b005282c7a6302mr28503640pfm.37.1663762582408; Wed, 21
 Sep 2022 05:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220721121152.4180-1-colyli@suse.de> <20220721121152.4180-2-colyli@suse.de>
In-Reply-To: <20220721121152.4180-2-colyli@suse.de>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 21 Sep 2022 20:16:11 +0800
Message-ID: <CALTww2_raNwb3j9evCWi4LD3FqBpW9+hugKw9-OEU+0LG25DBA@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] badblocks: add more helper structure and routines
 in badblocks.h
To:     Coly Li <colyli@suse.de>
Cc:     linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-raid <linux-raid@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        NeilBrown <neilb@suse.de>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 8:12 PM Coly Li <colyli@suse.de> wrote:
>
> This patch adds the following helper structure and routines into
> badblocks.h,
> - struct badblocks_context
>   This structure is used in improved badblocks code for bad table
>   iteration.
> - BB_END()
>   The macro to calculate end LBA of a bad range record from bad
>   table.
> - badblocks_full() and badblocks_empty()
>   The inline routines to check whether bad table is full or empty.
> - set_changed() and clear_changed()
>   The inline routines to set and clear 'changed' tag from struct
>   badblocks.
>
> These new helper structure and routines can help to make the code more
> clear, they will be used in the improved badblocks code in following
> patches.
>
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Geliang Tang <geliang.tang@suse.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Vishal L Verma <vishal.l.verma@intel.com>
> Cc: Xiao Ni <xni@redhat.com>
> ---
>  include/linux/badblocks.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/include/linux/badblocks.h b/include/linux/badblocks.h
> index 2426276b9bd3..670f2dae692f 100644
> --- a/include/linux/badblocks.h
> +++ b/include/linux/badblocks.h
> @@ -15,6 +15,7 @@
>  #define BB_OFFSET(x)   (((x) & BB_OFFSET_MASK) >> 9)
>  #define BB_LEN(x)      (((x) & BB_LEN_MASK) + 1)
>  #define BB_ACK(x)      (!!((x) & BB_ACK_MASK))
> +#define BB_END(x)      (BB_OFFSET(x) + BB_LEN(x))
>  #define BB_MAKE(a, l, ack) (((a)<<9) | ((l)-1) | ((u64)(!!(ack)) << 63))
>
>  /* Bad block numbers are stored sorted in a single page.
> @@ -41,6 +42,12 @@ struct badblocks {
>         sector_t size;          /* in sectors */
>  };
>
> +struct badblocks_context {
> +       sector_t        start;
> +       sector_t        len;
> +       int             ack;
> +};
> +
>  int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
>                    sector_t *first_bad, int *bad_sectors);
>  int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
> @@ -63,4 +70,27 @@ static inline void devm_exit_badblocks(struct device *dev, struct badblocks *bb)
>         }
>         badblocks_exit(bb);
>  }
> +
> +static inline int badblocks_full(struct badblocks *bb)
> +{
> +       return (bb->count >= MAX_BADBLOCKS);
> +}
> +
> +static inline int badblocks_empty(struct badblocks *bb)
> +{
> +       return (bb->count == 0);
> +}
> +
> +static inline void set_changed(struct badblocks *bb)
> +{
> +       if (bb->changed != 1)
> +               bb->changed = 1;
> +}
> +
> +static inline void clear_changed(struct badblocks *bb)
> +{
> +       if (bb->changed != 0)
> +               bb->changed = 0;
> +}
> +
>  #endif
> --
> 2.35.3
>

Reviewed-by: Xiao Ni <xni@redhat.com>

