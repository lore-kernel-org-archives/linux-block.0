Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756F9C3F6B0
	for <linux-block@archiver.kernel.org>; Fri,  5 Aug 2022 17:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiHEREC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbiHEREB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Aug 2022 13:04:01 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4566E881
        for <linux-block@vger.kernel.org>; Fri,  5 Aug 2022 10:03:59 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id r6so1628977ilc.12
        for <linux-block@vger.kernel.org>; Fri, 05 Aug 2022 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3nQ1rVXLpDSEFDUYuvx5YwgSl2ilKx7UDUIcTLmdIuo=;
        b=G4ApnmUZDgpX2DJmLdTVMAJs8qbQzm92gbUQFUaXmWPNDuJ1O/43ntQr630qbpH2FN
         VemYqANkxAxoNDvqRwXnNv+d0P0IEFfxMsYHwTYbJ2PmJMcHAc3kYQ5DMUI6U5nWjbn0
         GfWksrjiw2cVYPX+7ApGFWdgKqb53JNYuTHuPp2YuIKD6Bp6DhoI5UAU6lAR+CnH3Pvm
         x0pKJ7yLKvuawC37VPBNaMRf1IoCIeNYIGwfZ5KRb5pmMhGAEjP/wbEoek3qUCiHIn/A
         OHdX6D5X0+QZfrTZRVEHQLaELAnauH4pLqGiMcDIhiut35i8efoEwES6yuHJdRhxBnSd
         gETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3nQ1rVXLpDSEFDUYuvx5YwgSl2ilKx7UDUIcTLmdIuo=;
        b=JxfrxKDMvHxas0t0kxBiHSh38RemFDIPoVCDEqtrgU4EjoIidihfmbflNSCcwL7VRQ
         dU0c3+JvA2GQSsv2du+4ocln1UEwtof7rJ8SSh2LcHid8lXLgQcz4cCjigsCz13mxWBp
         yJzOWAUjhQyL+y6w9//Vg5wgbkXkQgM/EunRbWV2L2SVgfPAa/2AqzQNmtk3l5fZdcq/
         1qYYnr1jY/illxA7+Ydp9Udrev7iLoVobEH1uKe65zZi4PlZeXaFhK3eAPmzv9wQz+pD
         xJxR/jRuv6VELtOidHnkAK8YlXmvtdiwUidNRi061UjWZu1sNji31t1UtFdUWMGSLi74
         X5Sw==
X-Gm-Message-State: ACgBeo3y5X6Hsn/eME3w4GlUoWiOyiSwUwqgSgqmuB8KxxWZIuBA5Lj5
        2jc+07tS3R9U9gA0qLlTE+gU2A==
X-Google-Smtp-Source: AA6agR5xQA3di+F1B3DmrrgTAxXjfGE66ys1tZEHESkOge6dBVCelgqekLGqKnaWIx8jpVB/c/uRjA==
X-Received: by 2002:a05:6e02:b26:b0:2de:b192:9dfc with SMTP id e6-20020a056e020b2600b002deb1929dfcmr3612125ilu.273.1659719038985;
        Fri, 05 Aug 2022 10:03:58 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n16-20020a056602341000b0067ff1354b46sm2041257ioz.39.2022.08.05.10.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:03:57 -0700 (PDT)
Message-ID: <769524f5-c725-85f7-e7ac-ca3b2b2d884e@kernel.dk>
Date:   Fri, 5 Aug 2022 11:03:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/4] nvme: wire up async polling for io passthrough
 commands
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, ming.lei@redhat.com,
        joshiiitr@gmail.com, gost.dev@samsung.com,
        Anuj Gupta <anuj20.g@samsung.com>
References: <20220805154226.155008-1-joshi.k@samsung.com>
 <CGME20220805155313epcas5p2d35d22831bd07ef33fbdc28bd99ae1d0@epcas5p2.samsung.com>
 <20220805154226.155008-5-joshi.k@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220805154226.155008-5-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/5/22 9:42 AM, Kanchan Joshi wrote:
> @@ -685,6 +721,29 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
>  	srcu_read_unlock(&head->srcu, srcu_idx);
>  	return ret;
>  }
> +
> +int nvme_ns_head_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd)
> +{
> +	struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
> +	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
> +	int srcu_idx = srcu_read_lock(&head->srcu);
> +	struct nvme_ns *ns = nvme_find_path(head);
> +	struct bio *bio;
> +	int ret = 0;
> +	struct request_queue *q;
> +
> +	if (ns) {
> +		rcu_read_lock();
> +		bio = READ_ONCE(ioucmd->private);
> +		q = ns->queue;
> +		if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio
> +				&& bio->bi_bdev)
> +			ret = bio_poll(bio, 0, 0);
> +		rcu_read_unlock();
> +	}
> +	srcu_read_unlock(&head->srcu, srcu_idx);
> +	return ret;
> +}
>  #endif /* CONFIG_NVME_MULTIPATH */

Looks like that READ_ONCE() should be:

	bio = READ_ONCE(ioucmd->cookie);

?

-- 
Jens Axboe

