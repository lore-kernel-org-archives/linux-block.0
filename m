Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150A7C433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 21:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379649AbiDUVXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347806AbiDUVXy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 17:23:54 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AC44BFE3;
        Thu, 21 Apr 2022 14:21:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x80so6150591pfc.1;
        Thu, 21 Apr 2022 14:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IinI33pSr8d3WhExYC7mTfj7eLtY6joSBsl3ibPhoGg=;
        b=DCakvaO85AHCPkXp1OMlJGDTQgPZHI6loyZStX1R06qX3I8dlTt8gy4VOUJ/X1QRo5
         kj/GasYXiUQfIkp1NFVNFCx3EL3XjoHbJHjAjvCnBsRgeJ3Te1ZQUT9RVkXXzc7oahvi
         T6ldgq9In5sBxJlTibzusLYfg9f5Js72idQqPI712gT/X61EPmDWdmuVgGOUlHfmH1OX
         tBUqSwrtLOnSkSIQGg4T8kZ3yKXcCJ8WxP32RePAeqhVPOXJM7Q6YRCzd0e5qp12hlNK
         9agkcAvEgTQ9aWn+ojFuWjNXu6sbKRHPBgOdfl8Ef9piSRNhYS6a7t0rtNXuhCfVGL0w
         b0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IinI33pSr8d3WhExYC7mTfj7eLtY6joSBsl3ibPhoGg=;
        b=kzA6swiQu2S5H4TKwD8ijz1WFoBodLK0HbydU5U0C6INd3UwtTIf0XXt0wcvQIshIn
         xsLxxv9pdJ8N7LeFAtYFraiZ11ReRvTxnqNgeOUmZAzy/02BPowcoIuJ7L+Ja6r9e+s4
         5mJf9Cf5NxEyQdivBcDFrOgqHa7ZZAcvSF7zqPSMwsTySJf0iB45Y7hehEXqnpvOSyOC
         tT/jeviqlWw8JXJ6rbf1dDI2ZqFilhjpuQXwVcbX+ja84hR7WWtcf+Mq+fnhy/riVhOm
         5DK5EGNRBX0NwHirRpreDwJXgxqr9ApR3Nc7JOOQFLDWVxUUhKVSXQEcuCOpXSrlJszY
         xuyw==
X-Gm-Message-State: AOAM533DTZoUXf7/xBpSoBRM1rdFGTL4k4AHbS2kjuBfeORjVocdu53S
        mlGaCZLHPYnmoXMAfvY7Nx6jmsX/3VM=
X-Google-Smtp-Source: ABdhPJy5TJ66lJLVdKIjrTX7qAzuwVt4TUqEbAZpVabpPFZJqIcnhheMAkwWTUQtOy10+JNdywDS5A==
X-Received: by 2002:a05:6a00:1a0a:b0:4fc:d6c5:f3f1 with SMTP id g10-20020a056a001a0a00b004fcd6c5f3f1mr1626949pfv.45.1650576063704;
        Thu, 21 Apr 2022 14:21:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:15fa])
        by smtp.gmail.com with ESMTPSA id z16-20020a637e10000000b00382b21c6b0bsm64796pgc.51.2022.04.21.14.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 14:21:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 21 Apr 2022 11:21:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH 01/15] blk-cgroup: remove __bio_blkcg
Message-ID: <YmHKvY658MbXQKzj@slm.duckdns.org>
References: <20220420042723.1010598-1-hch@lst.de>
 <20220420042723.1010598-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420042723.1010598-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 20, 2022 at 06:27:09AM +0200, Christoph Hellwig wrote:
> Remove the unused and deprecated __bio_blkcg helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
