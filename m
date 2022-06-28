Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D67C433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 16:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiF1Q0j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 12:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiF1QZ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 12:25:58 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD29393FB
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 09:17:46 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id h192so12683944pgc.4
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 09:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OqNTPczUsw2zcywpbvs/mPwwiHqZhMHPqN5un6qsoCs=;
        b=RC37RkucUB+GtOjJUBfmf8cYvocb9h2OZdOg7Q4us0ka2EGjbwTc9RQgsP33fCq0gy
         8Yp0O1ZIxw0hNPqQ6UgopiXPjnyLWjTwlqx2lfC5FCCv0tDthdUlNQmjD9KKkKSXbhUG
         VkWULnx/RKVV0Has0B62OvoRuDY2CUhghljgT0RHqaOkUcWvnJeciDxp9y6g5pZhrkx5
         XcyvQuJ5DyDc2xrg5AGt9fNIyY8MYBuSvFlVseI4yQajNAVFmeWgN8f/aflKRPR2aOzL
         Rn1Joc98Z3F6wR/1kkHHXtGqlcF5GJajI7C5u90U1rxXnSov6O8I2Xs4R32M8b1r4tNm
         iZEg==
X-Gm-Message-State: AJIora//ca3cbt5qrzTMiFsHmF3/pSTMUWh3O1GMezJb5tQ0+D5c8xpx
        Q58t+XY2z4iVjPSOCTE5ckqcXBxjI4A=
X-Google-Smtp-Source: AGRyM1uoibtSuzGd2gLlsK6rYv+ETUSkFAyHHUyjinyMyL4yUcjgyu+0TRn3LYSep+ezQoqeMSnPnQ==
X-Received: by 2002:a05:6a00:2287:b0:525:5574:9ac3 with SMTP id f7-20020a056a00228700b0052555749ac3mr5441736pfe.79.1656433065429;
        Tue, 28 Jun 2022 09:17:45 -0700 (PDT)
Received: from [100.125.51.173] ([104.129.199.11])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902650800b00168a651316csm9507458plk.270.2022.06.28.09.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 09:17:44 -0700 (PDT)
Message-ID: <2cffff09-579a-d4e8-9f13-6c0f6b906714@acm.org>
Date:   Tue, 28 Jun 2022 09:17:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 6/8] block/null_blk: Add support for pipelining zoned
 writes
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220627234335.1714393-1-bvanassche@acm.org>
 <20220627234335.1714393-7-bvanassche@acm.org>
 <05441933-6a41-9b9d-a81b-2784f40840f8@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <05441933-6a41-9b9d-a81b-2784f40840f8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/27/22 17:39, Chaitanya Kulkarni wrote:
> Is it possible to move this into the blktests ?

That sounds like a good idea to me. I will look into that after this 
patch series has been merged.

Thanks,

Bart.

