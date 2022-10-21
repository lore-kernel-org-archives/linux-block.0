Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0443DC38A2D
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 21:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiJUVSL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiJUVSI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 17:18:08 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D05C2A58D5
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 14:18:06 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id h185so3607073pgc.10
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 14:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5gjExI0OGQVf5MMUfW+J/Ig8uCVySaCPKsKvlNix8o=;
        b=NlCTAXjfENK1e4RHL/vZibTQjvNbTbvJImJTmQE4VBhVjhOm7OfaxLmdpRWJ2v8xIK
         tuMVN2h7pG+4T2pBV74Z+lQ5uXPanmAdz/1zk8eEN/MRiIDzrZ9k/y4AvA5Ffh9brUKa
         arPEaCwceaffYXyXjrsf++gXOg+1BGN9gVJj06n+AXhLnPBtcNUcwVeVGsepuY6ZlcY+
         2nCuI3pPJcZ02KoEiZMcRm85qh2bAzWE951r7l63DSazYmubmUt8jH8Fh2iJj09JoONq
         WtOXI7CAuAt4SO0m8gs53KRcfPi2/dOZ2jAjHP2Sg8c0zc3HMJ1xh+xkfKNM2D/1l+dd
         iqOQ==
X-Gm-Message-State: ACrzQf2CEC0bMW/wGtVyZ8gxVNIvsmEa0JbngsgFAsQCa/vi8+zCASYT
        D2pVcdJ3DTTEc8Nf41QKJDk=
X-Google-Smtp-Source: AMsMyM6ju3s+P0WRsG3hEO0puPCoBQHkO0xuzJJN5nG5dawIgCzD1KYAmUU0KPhx3yO7NKJr2GKKmA==
X-Received: by 2002:a05:6a00:1688:b0:53b:4239:7c5c with SMTP id k8-20020a056a00168800b0053b42397c5cmr21408615pfc.81.1666387085374;
        Fri, 21 Oct 2022 14:18:05 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3bff:84a:36de:737? ([2620:15c:211:201:3bff:84a:36de:737])
        by smtp.gmail.com with ESMTPSA id rj14-20020a17090b3e8e00b00209a12b3879sm2055474pjb.37.2022.10.21.14.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 14:18:04 -0700 (PDT)
Message-ID: <0dd9b8d1-79ae-3519-518e-433bda15abd3@acm.org>
Date:   Fri, 21 Oct 2022 14:18:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 4/8] blk-mq: pass a tagset to blk_mq_wait_quiesce_done
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-5-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221020105608.1581940-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/22 03:56, Christoph Hellwig wrote:
> Noting in blk_mq_wait_quiesce_done needs the request_queue now, so just

Noting -> Nothing

Thanks,

Bart.
