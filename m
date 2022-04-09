Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C898C433F5
	for <linux-block@archiver.kernel.org>; Sat,  9 Apr 2022 12:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiDIMD4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Apr 2022 08:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiDIMDz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Apr 2022 08:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C11D340D2
        for <linux-block@vger.kernel.org>; Sat,  9 Apr 2022 05:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649505707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtwSo96nr254x9OEzEhUA59HmJMtNhlCZM5GqdzW6Ug=;
        b=MzHWXFK6LGPKBvTzFcW2iTq6dupMJW/AoXc/6MjxVxHA3h/H9FOuyaU8fkeTecoAA9iNTR
        CKBia00XOy9AKLz45QwVBHeWW/5+JOigu23m5j0mYgVu1hVdRl9H4YjND1vug5tvAs4U46
        M9jvEzfwA2wA9HrFp8FlwxzzjMalShI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665--XWqDl97Ow6mxgKRzG-LMw-1; Sat, 09 Apr 2022 08:01:46 -0400
X-MC-Unique: -XWqDl97Ow6mxgKRzG-LMw-1
Received: by mail-qv1-f69.google.com with SMTP id o6-20020ad45c86000000b00443e7ec6026so11587687qvh.19
        for <linux-block@vger.kernel.org>; Sat, 09 Apr 2022 05:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vtwSo96nr254x9OEzEhUA59HmJMtNhlCZM5GqdzW6Ug=;
        b=LwzvyU22dH2tciRsJ2I+BliJtqpHqdjELO+VFstC1BcTh7cNNvzLdMO5PrBNDED1hZ
         krrNzAUUQvnWb3DMM7paQ8ZqeKGxGYSBgvd2g7XsGINwh4HZUtF0nTEZ5F0dCnwZ4oUA
         FQvpvYfimjQFRgXqiJCFODcReR4znbwMIvjSg+9ugrz2OTfBMrZl6hw6GK9KMoxHEkhx
         ZHG1VjN2Xj3OzOgk3THmeseuAD2VLw/p3sC/rmv/dV6EvuswfBfXh0PmB3FJ2+FvxYo7
         BhbezynoMHYh3Hqt3R8JjADg3ihoiBMXKyv9Tx8gM89IK8EjA/k64eArkJU3Kgm4qiJ2
         SG8Q==
X-Gm-Message-State: AOAM531grwIDimcn1n3f0t7FXGoxXina/z0CrRr5DStHBoHFrgSBuqwy
        6Z4dXrBjSQ9m4VudnFbmCKMf0Ul2w66MKDKT4XHXnnNv/9v0IAKzYM/3mCTK0T4wkC0eQAT+e/P
        qhHpheoD5HUfLM1f+GatgVMM=
X-Received: by 2002:ac8:5784:0:b0:2e1:ed90:fc65 with SMTP id v4-20020ac85784000000b002e1ed90fc65mr19448434qta.232.1649505704886;
        Sat, 09 Apr 2022 05:01:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT86i97UUtFTjAgdxxXM0MqeFpU4TbMS9Jr3qCPh4WYJcB26wrKSAbGWHP5MMlTc/GhLGrcw==
X-Received: by 2002:ac8:5784:0:b0:2e1:ed90:fc65 with SMTP id v4-20020ac85784000000b002e1ed90fc65mr19448405qta.232.1649505704579;
        Sat, 09 Apr 2022 05:01:44 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id z202-20020a3765d3000000b0069a0e1416a5sm4017484qkb.68.2022.04.09.05.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 05:01:44 -0700 (PDT)
Subject: Re: [PATCH] block: Remove redundant assignments
To:     Michal Orzel <michalorzel.eng@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, llvm@lists.linux.dev
References: <20220409101933.207157-1-michalorzel.eng@gmail.com>
 <20220409101933.207157-2-michalorzel.eng@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a56d1184-d399-d5f8-765f-5a4f35dacd5e@redhat.com>
Date:   Sat, 9 Apr 2022 05:01:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220409101933.207157-2-michalorzel.eng@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 4/9/22 3:19 AM, Michal Orzel wrote:
> Get rid of redundant assignments which end up in values not being
> read either because they are overwritten or the function ends.

This log is the same as your last patch.

Instead of a general statement on deadstores, a more specific

analysis of the setting being removed would be helpful.

This will mean splitting the patch to match the analysis.

Tom

>
> Reported by clang-tidy [deadcode.DeadStores]
>
> Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
> ---
>   block/badblocks.c        |  2 --
>   block/blk-map.c          |  5 ++---
>   block/partitions/acorn.c |  4 ++--
>   block/partitions/atari.c |  1 -
>   block/partitions/ldm.c   | 15 +++------------
>   5 files changed, 7 insertions(+), 20 deletions(-)
>
> diff --git a/block/badblocks.c b/block/badblocks.c
> index d39056630d9c..3afb550c0f7b 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -65,7 +65,6 @@ int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
>   		s >>= bb->shift;
>   		target += (1<<bb->shift) - 1;
>   		target >>= bb->shift;
> -		sectors = target - s;
>   	}
>   	/* 'target' is now the first block after the bad range */
>   
> @@ -345,7 +344,6 @@ int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
>   		s += (1<<bb->shift) - 1;
>   		s >>= bb->shift;
>   		target >>= bb->shift;
> -		sectors = target - s;
>   	}
>   
>   	write_seqlock_irq(&bb->lock);
> diff --git a/block/blk-map.c b/block/blk-map.c
> index c7f71d83eff1..fa72e63e18c2 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -260,10 +260,9 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>   
>   		npages = DIV_ROUND_UP(offs + bytes, PAGE_SIZE);
>   
> -		if (unlikely(offs & queue_dma_alignment(rq->q))) {
> -			ret = -EINVAL;
> +		if (unlikely(offs & queue_dma_alignment(rq->q)))
>   			j = 0;
> -		} else {
> +		else {
>   			for (j = 0; j < npages; j++) {
>   				struct page *page = pages[j];
>   				unsigned int n = PAGE_SIZE - offs;
> diff --git a/block/partitions/acorn.c b/block/partitions/acorn.c
> index 2c381c694c57..d2fc122d7426 100644
> --- a/block/partitions/acorn.c
> +++ b/block/partitions/acorn.c
> @@ -282,13 +282,13 @@ int adfspart_check_ADFS(struct parsed_partitions *state)
>   #ifdef CONFIG_ACORN_PARTITION_RISCIX
>   		case PARTITION_RISCIX_SCSI:
>   		case PARTITION_RISCIX_MFM:
> -			slot = riscix_partition(state, start_sect, slot,
> +			riscix_partition(state, start_sect, slot,
>   						nr_sects);
>   			break;
>   #endif
>   
>   		case PARTITION_LINUX:
> -			slot = linux_partition(state, start_sect, slot,
> +			linux_partition(state, start_sect, slot,
>   					       nr_sects);
>   			break;
>   		}
> diff --git a/block/partitions/atari.c b/block/partitions/atari.c
> index da5994175416..9655c728262a 100644
> --- a/block/partitions/atari.c
> +++ b/block/partitions/atari.c
> @@ -140,7 +140,6 @@ int atari_partition(struct parsed_partitions *state)
>   				/* accept only GEM,BGM,RAW,LNX,SWP partitions */
>   				if (!((pi->flg & 1) && OK_id(pi->id)))
>   					continue;
> -				part_fmt = 2;
>   				put_partition (state, slot,
>   						be32_to_cpu(pi->st),
>   						be32_to_cpu(pi->siz));
> diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
> index 27f6c7d9c776..38e58960ae03 100644
> --- a/block/partitions/ldm.c
> +++ b/block/partitions/ldm.c
> @@ -736,7 +736,6 @@ static bool ldm_parse_cmp3 (const u8 *buffer, int buflen, struct vblk *vb)
>   		len = r_cols;
>   	} else {
>   		r_stripe = 0;
> -		r_cols   = 0;
>   		len = r_parent;
>   	}
>   	if (len < 0)
> @@ -783,11 +782,8 @@ static int ldm_parse_dgr3 (const u8 *buffer, int buflen, struct vblk *vb)
>   		r_id1 = ldm_relative (buffer, buflen, 0x24, r_diskid);
>   		r_id2 = ldm_relative (buffer, buflen, 0x24, r_id1);
>   		len = r_id2;
> -	} else {
> -		r_id1 = 0;
> -		r_id2 = 0;
> +	} else
>   		len = r_diskid;
> -	}
>   	if (len < 0)
>   		return false;
>   
> @@ -826,11 +822,8 @@ static bool ldm_parse_dgr4 (const u8 *buffer, int buflen, struct vblk *vb)
>   		r_id1 = ldm_relative (buffer, buflen, 0x44, r_name);
>   		r_id2 = ldm_relative (buffer, buflen, 0x44, r_id1);
>   		len = r_id2;
> -	} else {
> -		r_id1 = 0;
> -		r_id2 = 0;
> +	} else
>   		len = r_name;
> -	}
>   	if (len < 0)
>   		return false;
>   
> @@ -963,10 +956,8 @@ static bool ldm_parse_prt3(const u8 *buffer, int buflen, struct vblk *vb)
>   			return false;
>   		}
>   		len = r_index;
> -	} else {
> -		r_index = 0;
> +	} else
>   		len = r_diskid;
> -	}
>   	if (len < 0) {
>   		ldm_error("len %d < 0", len);
>   		return false;

