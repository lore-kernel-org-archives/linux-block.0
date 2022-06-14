Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77747C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 16:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344126AbiFNQtE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 12:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbiFNQsj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 12:48:39 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC2041F93
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 09:48:33 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso12310027pjl.3
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 09:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c2KqkaSirHWOrrAQw1VC+PyGO2MeCmppR3zyYxox92k=;
        b=dNF8eSmuv4eoMar1NsMBq3ASL7s2tCgHqEwaEDIAae4kSoHfe4JNiLIFNAh7w3/Ypy
         Lrw2wjH/zcE85+tQVbQF2a3NRO+paQSlKflChSbsSFmfEumCjgYpYsuZJESW9T6rqojB
         ZX/r0K2bVIkoTMCX1xVesRbPT5rmOTrCRSPdPO5sDWSHzavxdWq7MN95mLFR9asTNIpA
         010K4a9SNqeTJ45WJyttTEWUal+qjNfGbyiQTeetXnUYFmbPzP1L5ixcp4FzXnZxSO3L
         n9OEo7vtZP+iXfAvqHCGVaA5F2FdFGqojqqiQvWcG9j/Ku0NMzHpUMepQ8Jipv6rL5M+
         f8Bw==
X-Gm-Message-State: AJIora8hvIQlvLnvnUmBSsIkjdil/VkjzoNIxeXEyzECoi5k4I7Z/y7Y
        IAFazrY7tuloe9Sr7obzzzWyiSEY/dQ=
X-Google-Smtp-Source: AGRyM1tjUmtBMcCiU4gTQbOUdr192bm9HtNqYwOlXmyTivvTuBfRm8o98/YtExWV1FWEa3DgVsndkQ==
X-Received: by 2002:a17:90a:df18:b0:1ea:96b7:b328 with SMTP id gp24-20020a17090adf1800b001ea96b7b328mr5447146pjb.183.1655225312853;
        Tue, 14 Jun 2022 09:48:32 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ab60:e1ea:e2eb:c1b6? ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902a38800b001640537511esm7422334pla.71.2022.06.14.09.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 09:48:32 -0700 (PDT)
Message-ID: <3d28498a-98b8-9168-d7f9-71c88e0034ee@acm.org>
Date:   Tue, 14 Jun 2022 09:48:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 6/6] block: move blk_queue_get_max_sectors to blk.h
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20220614090934.570632-1-hch@lst.de>
 <20220614090934.570632-7-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220614090934.570632-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/22 02:09, Christoph Hellwig wrote:
> blk_queue_get_max_sectors is private to the block layer, so move it out
> of blkdev.h.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
