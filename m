Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80B9C433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 03:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiBQDJM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 22:09:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiBQDJM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 22:09:12 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6DB1516AD
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 19:08:58 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id y11so822090pfi.11
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 19:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Anr52g04+AVHtEhsIJzL+W2iG28YfG2faiyY/MF3S1Q=;
        b=07TZlRToCc/AdEf2OdPUHwVs6g+ZsE6t5ADSClYQD4YtLyHDVtCXrw0tbUm5v86EPN
         OcyUz4BPpxlWcNwlAG/jJ4TFq8G31s73PHQlBhy433SC8RI/KBQO0Gkws+BdbEE/vCP5
         uunMezkromTerPmrToxjiF43VMZj6JgV+Lp1m+ekN058H3KyHKdIGzREZe7VFg8MQC+a
         WCmwQ3PofM6Oe/FkqsfB2Dx8ro75SLsNUHeoFaNVgJX2gEypTIFOWshmUMn2J51B1eTG
         BcxZbdvjOZptcd3Hm9Hrqlc3/uXKMStobZyt42V3TWV+wy1/3/QJnRUERHVyTeXFFoqz
         YhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Anr52g04+AVHtEhsIJzL+W2iG28YfG2faiyY/MF3S1Q=;
        b=vRIPTtM0//qyTCNoaF3i+mRALffbFteGnIHvU+vSH1/7DT5T7UgRKKNSjehbLTvqPH
         uiBfA7LdW7hhoxYMOp24aNIo9wtN/sx4/DK1wQAWcz6CXN8n4Ki+Cf/VKVlxF3lUXeUC
         krlvfVSZ0Hu8FiJAuj4l9C+aSHTTgx3h6AqkJ0mE1D7uqeDMR7ei+nOTe6oCDKjhZzLE
         fMg0xUSdsC1nANQxRwoHiPeIy7YTQdq+oKmCOXk39AAwf9P/164Wrizcm7LVgA2zUe2s
         Pdcr0QwC6GtbjPSD5lAO5rWmmmikHCHu9ZkK0q4kG1UPj6aPrNgXLq3ngnv78D3SYrHN
         D3OA==
X-Gm-Message-State: AOAM532uZ3Eo0roVexujWRZCBIHNahDnk4EWIyTXkRnqTKUHS9Pjy0co
        z2XTNOsCC1QoSTopClOFuIz/gw==
X-Google-Smtp-Source: ABdhPJxl3am8omzitpxin/MQKTLxfv3srfGyqtpva7Sci8tI20hniUCP5Uj33Vt824nPP+nacT26Eg==
X-Received: by 2002:a62:1d07:0:b0:4bf:3782:22e3 with SMTP id d7-20020a621d07000000b004bf378222e3mr1145580pfd.52.1645067338250;
        Wed, 16 Feb 2022 19:08:58 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s1sm404329pjr.56.2022.02.16.19.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 19:08:57 -0800 (PST)
Message-ID: <5e633f42-817a-1861-524f-8659e7340351@kernel.dk>
Date:   Wed, 16 Feb 2022 20:08:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH -next] block: update io_ticks when io hang
Content-Language: en-US
To:     "zhangwensheng (E)" <zhangwensheng5@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20220125091938.1799001-1-zhangwensheng5@huawei.com>
 <164506609748.50355.11490091116960287078.b4-ty@kernel.dk>
 <1998c61c-c3d9-8050-be43-16aba2d6e09f@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1998c61c-c3d9-8050-be43-16aba2d6e09f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/16/22 8:07 PM, zhangwensheng (E) wrote:
> hi, Jens:
> 
> I am sorry that there are some problems with the patch below:
> 
> 
> @@ -913,12 +913,14 @@ ssize_t part_stat_show(struct device *dev,
>       struct disk_stats stat;
>       unsigned int inflight;
>   -    part_stat_read_all(bdev, &stat);
>       if (queue_is_mq(q))
>           inflight = blk_mq_in_flight(q, bdev);
>       else
>           inflight = part_in_flight(bdev);
>   +    if (inflight)
> +        update_io_ticks(bdev, jiffies, true);
> +    part_stat_read_all(bdev, &stat);
>       return sprintf(buf,
>           "%8lu %8lu %8llu %8u "
>           "%8lu %8lu %8llu %8u "
> 
> It shoule use part_stat_lock() & part_stat_unlock() to protect update_io_ticks(),
> 
> because it operates on per-cpu variables.  And I will fix it in V2.

I'll drop it, please resend a fixed and tested one.

-- 
Jens Axboe

