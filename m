Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F412C32793
	for <linux-block@archiver.kernel.org>; Wed, 18 Jan 2023 21:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjARVUM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Jan 2023 16:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjARVUI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2023 16:20:08 -0500
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C33457CA
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2023 13:20:07 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id b17so355241pld.7
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2023 13:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6h6kbarYsbc6Mk1Wk8cEyAYd12ve3nrJTJAhuMtgC0=;
        b=SSP6F2YLPwBuk6ozleKtE9hWR31Bjn7VdTbuqZTORv5riZjnyXuQB7yOxxHTWRMF+c
         0XWeKr/xmftqE8qn0WK7mUmO2Ikke9YXoKRUJ3ZLmwJ3XyiFabBrXwr3W4adX9GxhXzp
         sDZVlZIIvaohe56+WaR5xkM0m6Gc8XEOx/JnIDjeSA7L51h+vJZ6UobS+k5ji2iwJdno
         qYBG6/gEKrcVwjXuDcNXqkW8AJ50NqsLhtS1Wbr/HA9i8p7sRojpDBaGAZiXDtO9A4Xc
         PS5buqYlbEq1Lua9xYTE9jQ2J0LIT4HBqE9XeBPuxO+GXRLndqrwSUIhnjTobH5c1UGa
         9ObA==
X-Gm-Message-State: AFqh2kruYyUfWQMnaiSDjnx3zKagrkFoD1EPQuXw2pKF94s7pKXTnxnf
        62upPUHscrB8GHTwUdmrqEA=
X-Google-Smtp-Source: AMrXdXsC2eELVU/sLwrE7rJa3rmR/u49YIDJ7Bh8fIZqunhpW3GDB6CbmKv7YchdD8ozoh8FbloaNQ==
X-Received: by 2002:a17:902:8216:b0:194:59c2:a155 with SMTP id x22-20020a170902821600b0019459c2a155mr7736461pln.16.1674076806996;
        Wed, 18 Jan 2023 13:20:06 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:22ae:3ae3:fde6:2308? ([2620:15c:211:201:22ae:3ae3:fde6:2308])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b001930b7e2c04sm20516803pli.287.2023.01.18.13.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:20:06 -0800 (PST)
Message-ID: <c46f4aed-de57-9964-42ca-c34fce3d003e@acm.org>
Date:   Wed, 18 Jan 2023 13:20:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] block: Improve shared tag set performance
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ed Tsai <ed.tsai@mediatek.com>
References: <20230103195337.158625-1-bvanassche@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230103195337.158625-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/3/23 11:53, Bart Van Assche wrote:
> Remove the code for fair tag sharing because it significantly hurts
> performance for UFS devices. Removing this code is safe because the
> legacy block layer worked fine without any equivalent fairness
> algorithm.
> 
> This algorithm hurts performance for UFS devices because UFS devices
> have multiple logical units. One of these logical units (WLUN) is used
> to submit control commands, e.g. START STOP UNIT. If any request is
> submitted to the WLUN, the queue depth is reduced from 31 to 15 or
> lower for data LUNs.

Can anyone please help with reviewing this patch?

Thanks,

Bart.

