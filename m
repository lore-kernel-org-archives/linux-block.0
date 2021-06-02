Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FB2C47092
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 19:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8B2613EB
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 19:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhFBTHD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jun 2021 15:07:03 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:37627 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFBTGx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 15:06:53 -0400
Received: by mail-pj1-f44.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so4005771pjs.2;
        Wed, 02 Jun 2021 12:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2jsgl46qTXUFETegG4YX4Eozd/vKYgq51F4jK7XaaDw=;
        b=qrUFRUSkdhOR3lV5nkM1VAwpsSIurtbX4VDOCCTalyBAwEACBB0wnrdgTiTeeLShUg
         2Ij2HXYlNanQGlQXiS4/0uRDXCFe8s0gBIcmSyww2NS3G8UGZlCp5mO/4GJuA9CROGA2
         e+it5RPObVcuByaiIhXldUSbxfnySjIxD314WPi2OY+lP/+q3K/9Si35DJwg2I5rALjO
         9bAA4pFv/ds72ceApWHE+xLKyqp9klPwBf+smAm3I451C2Uz7m8RSxOSBYdqFDCk76hg
         cUlP7qdkZaWPyiyCsjsJbifO0NgXkHwYLbOhlXkhhaGxzQtcu55cvUfafk4sjHStyB3g
         0ZIg==
X-Gm-Message-State: AOAM532IuSCEMX4WFsHXlRumFgHNOk3usBYG71TF5PX5cqriFXMWwzWZ
        aAsBQO15sgekIKrDEXtk13s=
X-Google-Smtp-Source: ABdhPJyBzZGUV9/yaTEs3Kcnxd6x6X+34BJRqwqWmPR0/3+Kbl5QzLZJiFIJOxnFARVPW9Gh6dMjLA==
X-Received: by 2002:a17:90a:7842:: with SMTP id y2mr7143661pjl.68.1622660648117;
        Wed, 02 Jun 2021 12:04:08 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id x9sm464893pgp.5.2021.06.02.12.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 12:04:07 -0700 (PDT)
Subject: Re: [PATCH v11 3/3] scsi: set max_bio_bytes with queue max sectors
To:     Changheun Lee <nanich.lee@samsung.com>, hch@infradead.org,
        Johannes.Thumshirn@wdc.com, alex_y_xu@yahoo.ca,
        asml.silence@gmail.com, axboe@kernel.dk, bgoncalv@redhat.com,
        damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com, osandov@fb.com,
        patchwork-bot@kernel.org, tj@kernel.org, tom.leiming@gmail.com,
        yi.zhang@redhat.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
References: <20210602121037.11083-1-nanich.lee@samsung.com>
 <CGME20210602122912epcas1p4faff714cc9457b0d482fc1a4b63a49a9@epcas1p4.samsung.com>
 <20210602121037.11083-4-nanich.lee@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <10c02317-7528-bbad-3cfb-75db54d2ab91@acm.org>
Date:   Wed, 2 Jun 2021 12:04:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602121037.11083-4-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/2/21 5:10 AM, Changheun Lee wrote:
> Set max_bio_bytes same with queue max sectors. It will lead to fast bio
> submit when bio size is over than queue max sectors. And it might be helpful
> to align submit bio size in some case.
> 
> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> ---
>  drivers/scsi/scsi_lib.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 532304d42f00..f6269268b0e0 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1837,6 +1837,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
>  	blk_queue_virt_boundary(q, shost->virt_boundary_mask);
>  	dma_set_max_seg_size(dev, queue_max_segment_size(q));
>  
> +	blk_queue_max_bio_bytes(q, queue_max_sectors(q));
> +
>  	/*
>  	 * Set a reasonable default alignment:  The larger of 32-byte (dword),
>  	 * which is a common minimum for HBAs, and the minimum DMA alignment,

Has this patch been tested with dm-crypt on top of a SCSI device? I'm
concerned that this patch will trigger data corruption with dm-crypt on
top because the above change will make the following dm-crypt code fail
for a sufficiently large bio:

		bio_add_page(clone, page, len, 0);

When testing dm-crypt on top of this patch series, please change the
above dm-crypt code into the following before running any tests:

		WARN_ON(bio_add_page(clone, page, len, 0) < len);

Thanks,

Bart.
