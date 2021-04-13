Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9873DC433B4
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 16:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A57761153
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 16:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhDMQOY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 12:14:24 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:40672 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhDMQOY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 12:14:24 -0400
Received: by mail-pj1-f52.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so10925184pji.5;
        Tue, 13 Apr 2021 09:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lcF/ThtsgzVbxP/muR754mTGTdl7h0H3ZKJ0gQVewaQ=;
        b=Wy9qLuDcSVhDvErAH5xTOqmwUYOSoaWjKGxUnHPu0aVz6DmKm0X4CwpHqMInxLFKvn
         8mksXlDnb/oaGvvsfQhHMZcEV7b3pK9SFwMLMzEjsYw36tBvXEe/fHM0+qu8v6K7PKaN
         kUbBzH7H4nzxv3JtHeMgORzDncLBh9SpGN5pMA6KOWDcOvBA9HyxFUM0a7Nk7Z/L+qzN
         X5wBwezqfYZkTiDqB4qHYXsHpJrguQN0aapZM4ItbCuC8ZRVtCo8uVwvZafJrHLXBPxn
         ft6CLknKEwoO1yUJUtLLYekISbp57MXg4GUYE4xdJsKAHG1EBCz0OUif5avm2k74vunj
         sn9g==
X-Gm-Message-State: AOAM531rzeHZil8tf4FWSmX8LuRUZgpTWnwuSTC4r6JAlWwoAUGwI7P8
        +KtuuGu3Z8oPJr9boJ+clgg=
X-Google-Smtp-Source: ABdhPJwIOdCxx8b2F7nTGa2lWW5FpGFN81BwXHTNgl72fYoZUloIFSXRvdxjD5ERofLJzcHSeRo2kA==
X-Received: by 2002:a17:90a:6a05:: with SMTP id t5mr893292pjj.20.1618330444171;
        Tue, 13 Apr 2021 09:14:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:345f:c70d:97e0:e2ef? ([2601:647:4000:d7:345f:c70d:97e0:e2ef])
        by smtp.gmail.com with ESMTPSA id q14sm15772289pgt.54.2021.04.13.09.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 09:14:03 -0700 (PDT)
Subject: Re: [PATCH v7 2/3] ufs: set QUEUE_FLAG_LIMIT_BIO_SIZE
To:     Changheun Lee <nanich.lee@samsung.com>, damien.lemoal@wdc.com,
        Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
References: <20210413025502.31579-1-nanich.lee@samsung.com>
 <CGME20210413031258epcas1p469e9bd0145a49d440541cee899fd4d8e@epcas1p4.samsung.com>
 <20210413025502.31579-3-nanich.lee@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b923af39-8a33-4c2e-38ee-3ef53ced08e1@acm.org>
Date:   Tue, 13 Apr 2021 09:14:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210413025502.31579-3-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/21 7:55 PM, Changheun Lee wrote:
> Set QUEUE_FLAG_LIMIT_BIO_SIZE queue flag to limit bio max size to
> queue max sectors size for UFS device.
> 
> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> ---
>  drivers/scsi/scsi_lib.c   | 2 ++
>  drivers/scsi/ufs/ufshcd.c | 1 +
>  include/scsi/scsi_host.h  | 2 ++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 7d52a11e1b61..73ce6ba7903a 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1838,6 +1838,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
>  	 * Devices that require a bigger alignment can increase it later.
>  	 */
>  	blk_queue_dma_alignment(q, max(4, dma_get_cache_alignment()) - 1);
> +
> +	blk_queue_set_limit_bio_size(q, shost->limit_bio_size);
>  }
>  EXPORT_SYMBOL_GPL(__scsi_init_queue);
>  
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index d3d05e997c13..000eb5ab022e 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -9313,6 +9313,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
>  	host->max_channel = UFSHCD_MAX_CHANNEL;
>  	host->unique_id = host->host_no;
>  	host->max_cmd_len = UFS_CDB_SIZE;
> +	host->limit_bio_size = true;
>  
>  	hba->max_pwr_info.is_valid = false;
>  
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index e30fd963b97d..486f61588717 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -607,6 +607,8 @@ struct Scsi_Host {
>  	unsigned int max_segment_size;
>  	unsigned long dma_boundary;
>  	unsigned long virt_boundary_mask;
> +	unsigned int limit_bio_size;
> +
>  	/*
>  	 * In scsi-mq mode, the number of hardware queues supported by the LLD.
>  	 *

This patch should have been split into one patch for the SCSI core and
another patch for the UFS driver.

I see an issue with this patch: a new attribute has been introduced in
struct Scsi_Host but it is not used by the SCSI core. That seems weird
to me.

Another comment I have about this patch is why to restrict the BIO size
(blk_queue_set_limit_bio_size(q, shost->limit_bio_size)) only for UFS
devices? Aren't all block devices, including NVMe devices, expected to
benefit from limiting the BIO size if no stacking is involved? How about
the following approach?
* In blk_queue_max_hw_sectors(), set the maximum BIO size to
  max_hw_sectors. As you may know blk_queue_max_hw_sectors() may be
  called by any block driver (stacking and non-stacking).
* In blk_stack_limits(), set the maximum BIO size to UINT_MAX. Stacking
  block drivers must call blk_stack_limits().

Thanks,

Bart.
