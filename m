Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E27C6FD20
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 18:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjCUSpD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCUSpD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 14:45:03 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904B353DBD
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 11:45:02 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id fd25so9658399pfb.1
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 11:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ERTv2GYmi0sNtPH4wp3GqmBDbXjned4PNdpvTVS2A8=;
        b=g6JmZCK+VXOLfRWYivrbTXM+3FNsX4yvMGfi0GdgfaJUuSsdy+j0m6K3K9YDpQxGzU
         13JA5vnDGUq08+JbYvcZ0GdxIM0hx3QgHluoWQ/1P//e4wCkxcoISFoLGxC1QRtEi789
         yyaD4nJXlK7E3yq2KolMzbpuGaB4/sDcT8rOXp2jaPJURzVTxNOVvIWxq8aEkgN+pjlb
         N3XB3d//Ucd9Cd8nJLuRGDbJSDusgUUQPt6SR58cpcGpw+vivIWX0i+Ou3QpflWsJEE8
         QwPe/9/3z3ehLUvMaNWSWQrmuZTIHw/bgkY+L89wxk+UM/HTFWgJtC4R9mMrYc8Ftgyq
         ePJQ==
X-Gm-Message-State: AO0yUKVf5ws3hTzJ7bHLpBLAHbaxQpwFoE7LbbMJtVlgmWuHFGjnetbB
        DjTJWz8RmF7ax0alJAB4x5U=
X-Google-Smtp-Source: AK7set85or01B8FINuyEoZenoYGQw+bhREreKffa1/91/vXp4EcqdiLFLszU2ETqT+FcbQRiF9M3gA==
X-Received: by 2002:a62:cf04:0:b0:628:635:1ade with SMTP id b4-20020a62cf04000000b0062806351ademr637774pfg.21.1679424301943;
        Tue, 21 Mar 2023 11:45:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ad26:bef0:6406:d659? ([2620:15c:211:201:ad26:bef0:6406:d659])
        by smtp.gmail.com with ESMTPSA id b21-20020aa78115000000b005a7f8a326a3sm8594776pfi.50.2023.03.21.11.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 11:45:01 -0700 (PDT)
Message-ID: <6596c17f-62cc-2f2b-1a25-0ec2b6ae230c@acm.org>
Date:   Tue, 21 Mar 2023 11:44:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/3] block: Split and submit bios in LBA order
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230320234905.3832131-1-bvanassche@acm.org>
 <20230320234905.3832131-3-bvanassche@acm.org> <20230321060307.GB18078@lst.de>
 <20230321060530.GC18078@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230321060530.GC18078@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/20/23 23:05, Christoph Hellwig wrote:
> In fact I wonder how you managed to get into __bio_split_to_limits
> wtih a NULL current->bio_list at all.

Hi Christoph,

This patch series is what I came up with after having observed an 
UNALIGNED WRITE COMMAND response with a 5.15 kernel. In that kernel 
version (but probably not in the latest upstream kernel) the device 
mapper core submits split bios in the wrong order. I will check again 
whether this patch is really necessary.

Thanks,

Bart.
