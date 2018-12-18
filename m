Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F8EC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 07:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EC82133F
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 07:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeLRH0a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:26:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46720 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRH0a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 02:26:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so14711014wrt.13;
        Mon, 17 Dec 2018 23:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/YeJAZ2uNgtdaEC1Qs9aHeDuPRrG+NKZK6JKbxE+PZA=;
        b=HwDSrDeh0GimRdkccfEs6/DZgODzC5S0oj2wWhABi3K3TnUlB3mkR7ek08XEtqjXnc
         o9yksM0Dx3kEprTMhi9vPOoEpFuUBKeYDr3p1yWEw3gojXpexTJzVLKCamTtqCVmpVhz
         K73a9KYcfGL1/nl+ZO+6SerN37K2eY3EWiI0SD/dYvZ8JJhhYwTqxWm2X+2dhjyHalgg
         AmuHK3A07PrWAbLSK+RDXQ+auriZ+fBEYHRK9WaxNhFplr2dINk4H+6trdBW2R0bWG6K
         r5cHqdiDXq0jAtwtR12HQuKIs7FGP4W5sojWI9qM+WaFE8R2oJvyoXkCDzdmp2IY/sj8
         1ElQ==
X-Gm-Message-State: AA+aEWYLSBJw+gCgGyq1TCmlEejmI/CPKAdWtyKA43zVHFWddXXoK56v
        uzVoLyDUoTaq7TnrkzocqvU=
X-Google-Smtp-Source: AFSGD/Uhq0282MGOj2h8PTA5Tcbv76NyHgN1VoqVwD/wb9zmVC2YVyFrY2oS+ocCHAF4N+CNJxd3WA==
X-Received: by 2002:adf:bb8d:: with SMTP id q13mr13311051wrg.183.1545117987997;
        Mon, 17 Dec 2018 23:26:27 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:104e:891:8425:41e? ([2601:647:4800:973f:104e:891:8425:41e])
        by smtp.gmail.com with ESMTPSA id m6sm1864670wrv.24.2018.12.17.23.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 23:26:27 -0800 (PST)
Subject: Re: [PATCH v4 2/2] trace nvme submit queue status
To:     yupeng <yupeng0921@gmail.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, axboe@fb.com, hch@lst.de, jthumshirn@suse.de
References: <20181218045138.4282-1-yupeng0921@gmail.com>
 <20181218045138.4282-2-yupeng0921@gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <24f78f57-9786-effd-6ffe-f9a556211898@grimberg.me>
Date:   Mon, 17 Dec 2018 23:26:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218045138.4282-2-yupeng0921@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> @@ -899,6 +900,10 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>   	}
>   
>   	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
> +	trace_nvme_sq(req->rq_disk,
> +		nvmeq->qid,
> +		le16_to_cpu(cqe->sq_head),
> +		nvmeq->sq_tail);

Why the newline escapes? why not escape at the 80 char border?

Other than that, looks fine,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
