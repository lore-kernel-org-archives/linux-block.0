Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD11EC433F5
	for <linux-block@archiver.kernel.org>; Fri, 30 Sep 2022 18:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiI3Stp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiI3Sto (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2022 14:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8FE1EB
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 11:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664563781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YWfYo+GDUoZ0OpeHuuLzSQerAIG+GqmtkQYeKrxmQZ8=;
        b=eZQF5LXus9SnWZdhIpgrOPO/A04zgLu31aIfa7TqEbaWEjFN4WE7axD/bN+k+OKPwZPtqo
        a7Xe1RymJHGV/l+QgX8zvuwRs5JspXZzfdHp4VtmxmGSwtVkqOyBut3UuUq/TWi9NZWIg0
        SAytqXmoqSAyxi7smFNgrpcHCX34k6k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-PNU3mZ_eMy2cYrsr1z9F3A-1; Fri, 30 Sep 2022 14:49:39 -0400
X-MC-Unique: PNU3mZ_eMy2cYrsr1z9F3A-1
Received: by mail-ed1-f72.google.com with SMTP id e15-20020a056402190f00b0044f41e776a0so4142927edz.0
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 11:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YWfYo+GDUoZ0OpeHuuLzSQerAIG+GqmtkQYeKrxmQZ8=;
        b=k4sEZ63UY98oH4tJiqcw1ea1PLlx8xYPtzLYsTm5qDTEcf0nFkh0qCcnWPlieCnsyW
         HnBfO6XsOjwAFt+Ta8ySQi5uEOXPjf3Unz0gnJbJG5bvEgj35PjERAWWFw6miLmlzy7y
         5X9rfh0DrIMBKliuLYTge01KR5YoCJZVlR4ytUzb/4jaRX8QEGhYh31BIZizYTs8gmEC
         paZ5XErhyvUtZ1WNapiOrBBAamBL6kw5j9AKGiU/YlEjTEwmePG9a16tJtTjkDDlL/zw
         RKhOBkUKmFz0DfpU8khNdQ6/okG/ISRxxZm/InCWnD1l9PdFELEx+8snnkxb+U0eb8bD
         P9Rg==
X-Gm-Message-State: ACrzQf3fd6+qbQGHgzBFh3kkuru2v6+gD5+uvVyO5R5PcAlayAmot8go
        IOgLO0tZ4BIvoMpbokjI+nh1ndcaWyrN4RTO396XryRmFxYjc7NZBWiUcHzmBVd60sA2nJ+67pl
        VQrElNGgYH2GvVzcW8/cVIiu1ocseNCR9jOZQzUI=
X-Received: by 2002:a17:907:728f:b0:787:71b4:d84c with SMTP id dt15-20020a170907728f00b0078771b4d84cmr7330261ejc.506.1664563778488;
        Fri, 30 Sep 2022 11:49:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4OgpVLQpBnb1EG5QAel1ZwsPNE20c1qFyH7MP8dEAsKE2hckQEEyzdRygzRftCMeGHB1OB5BL9cN2bO2EiIdM=
X-Received: by 2002:a17:907:728f:b0:787:71b4:d84c with SMTP id
 dt15-20020a170907728f00b0078771b4d84cmr7330246ejc.506.1664563778305; Fri, 30
 Sep 2022 11:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220930150345.854021-1-bfoster@redhat.com>
In-Reply-To: <20220930150345.854021-1-bfoster@redhat.com>
From:   Nico Pache <npache@redhat.com>
Date:   Fri, 30 Sep 2022 12:49:12 -0600
Message-ID: <CAA1CXcA9_EOcOsc+7QqrtjtNe8fhyqUVDLFwFPwwipBghgMFDg@mail.gmail.com>
Subject: Re: [PATCH] block: avoid sign extend problem with default queue flags mask
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-block@vger.kernel.org, Joel Savitz <jsavitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 30, 2022 at 9:03 AM Brian Foster <bfoster@redhat.com> wrote:
>
> request_queue->queue_flags is an 8-byte field. Most queue flag
> modifications occur through bit field helpers, but default flags can
> be logically OR'd via the QUEUE_FLAG_MQ_DEFAULT mask. If this mask
> happens to include bit 31, the assignment can sign extend the field
> and set all upper 32 bits.
>
> This exact problem has been observed on a downstream kernel that
> happens to use bit 31 for QUEUE_FLAG_NOWAIT. This is not an
> immediate problem for current upstream because bit 31 is not
> included in the default flag assignment (and is not used at all,
> actually). Regardless, fix up the QUEUE_FLAG_MQ_DEFAULT mask
> definition to avoid the landmine in the future.
>
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>
> Just to elaborate, I ran a quick test to change QUEUE_FLAG_NOWAIT to use
> bit 31. With that change but without this patch, I see the following
> queue state:
>
> # cat /sys/kernel/debug/block/vda/state
> SAME_COMP|IO_STAT|INIT_DONE|WC|STATS|REGISTERED|30|NOWAIT|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63
>
> And then with the patch applied:
>
> # cat /sys/kernel/debug/block/vda/state
> SAME_COMP|IO_STAT|INIT_DONE|WC|STATS|REGISTERED|30|NOWAIT
>
> Thanks.
>
> Brian
>
>  include/linux/blkdev.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 84b13fdd34a7..28c3037cb25c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -580,9 +580,9 @@ struct request_queue {
>  #define QUEUE_FLAG_NOWAIT       29     /* device supports NOWAIT */
>  #define QUEUE_FLAG_SQ_SCHED     30     /* single queue style io dispatch */
>
> -#define QUEUE_FLAG_MQ_DEFAULT  ((1 << QUEUE_FLAG_IO_STAT) |            \
> -                                (1 << QUEUE_FLAG_SAME_COMP) |          \
> -                                (1 << QUEUE_FLAG_NOWAIT))
> +#define QUEUE_FLAG_MQ_DEFAULT  ((1ULL << QUEUE_FLAG_IO_STAT) |         \
> +                                (1ULL << QUEUE_FLAG_SAME_COMP) |       \
> +                                (1ULL << QUEUE_FLAG_NOWAIT))
>
>  void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
>  void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
> --
> 2.37.2
>
Looks good, thanks Brian!

Acked-by: Nico Pache <npache@redhat.com>

