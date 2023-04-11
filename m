Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FEFC77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjDKRqN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjDKRp5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:45:57 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFEF6EBB
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:45:43 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id o2-20020a17090a0a0200b00246da660bd2so2242862pjo.0
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235142; x=1683827142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I97NiA+diLd0m37PN8htLmIMoCY9szgOQG14HWFCSHg=;
        b=VNENXIA+1fplWnFi/23QfNfhxnSzZ40y8C6RQaAXoMWMr5gbzlcFyknlNuIK0qnS0H
         Jd6We9tp+X1Zwf42V4o/7Sgf8ZboU4qBTYvuwlCp3ua4JogVmjrPSk2TKoBfRj+5ExyV
         inzJjxOL7NNPuqXJmFn2bKevrI0eJhAEu9IX5UF182P8jTRPaW/eZ8Y71vCfE+2FljxF
         waJZ+war14Jmmu5aD9o+cW4FS7dk6nxvKl9lR9H1O8BRVY2pnkYl4DfSiRPjxV/mwTLP
         tAcCINp8njQm9sBv1K5fa4iR7jIf2sNQtqTscLGeuxy5Gs4PagwEZUh1D/7OvDcpg43a
         1cdQ==
X-Gm-Message-State: AAQBX9cJrgVrysRxryiHJubijSc3BJwfU+sPg1yaPql9md6XQcfNhJKU
        qy7Mwr2bg9nZ+dsQD1G2kY8OPcJJCCc=
X-Google-Smtp-Source: AKy350bKrFhkhYcC/B5KMv/i5w6byzcD/g0tTajiGC6/aqv7P4D17LeL4IfcUkS1SoQ368tD3A4f/g==
X-Received: by 2002:a17:90a:1952:b0:23d:31c3:c98d with SMTP id 18-20020a17090a195200b0023d31c3c98dmr19885638pjh.15.1681235142650;
        Tue, 11 Apr 2023 10:45:42 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id ot2-20020a17090b3b4200b00246700a5e15sm6682113pjb.33.2023.04.11.10.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:45:42 -0700 (PDT)
Message-ID: <3c4b5957-3d89-dbcf-ec16-41def636b79c@acm.org>
Date:   Tue, 11 Apr 2023 10:45:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 03/16] blk-mq: fold blk_mq_sched_insert_requests into
 blk_mq_dispatch_plug_list
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230411133329.554624-1-hch@lst.de>
 <20230411133329.554624-4-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411133329.554624-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 06:33, Christoph Hellwig wrote:
> blk_mq_dispatch_plug_list is the only caller of
> blk_mq_sched_insert_requests, and it makes sense to just fold it there
> as blk_mq_sched_insert_requests isn't specific to I/O scheudlers despite
> the name.

scheudlers -> schedulers

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
