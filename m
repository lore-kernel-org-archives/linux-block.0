Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802CAC6FD1D
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 14:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjCUOq5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 10:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjCUOq4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 10:46:56 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4B75FE6
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 07:46:55 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id c18so16244175ple.11
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 07:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679410014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQflYYDOt8iG2bWEoAisev99TFiRBpWXZ6Fp/SV5wo0=;
        b=yXZrIexe5fYfEx4LG9glNcsO+7NajPQXf8qadK1smtmewsDWuLYLo9dvKbI9OPH/My
         PfUXJx0Io/hoxS1dnq7/FKL1ZrJ1Eh/wbYxVlzesOFfH1owbosaBmUFOf3XNLk+h7L7x
         dbHqKW+44RFfIOkJ+ofEY7ZO4D9ofh/j3Tyd3YD+T95ncB6gwp9zBug/4i7N1H+eVFbN
         w4KWxNxAkcfRWnFOIUoQWtOtiwswhhgxGHS6Gv/L81HkmLcDNa6j8lIbMKxO/X8zTO3q
         bqLs4TM3oGeSDClR2E9rfWWrNEXXXoQCKHTkTqEKYqM1rGHisXWY0izIPeVpL4hSF437
         24YQ==
X-Gm-Message-State: AO0yUKWHXiWLmJ/2GNgaygVnGfRDWVKY77fQk5aMDwy7QuMCMncWST+N
        UqFnM0TrgCnAqmtXdlpSj4BI1mFXLpo=
X-Google-Smtp-Source: AK7set/XZ7J7p9qsyUYQRv/c5BtpcT9E8owmQLNIxBLtADYygHDu2c+F+0tEDnKtT/9S6DzyyBplDg==
X-Received: by 2002:a17:903:138e:b0:1a0:549d:39a1 with SMTP id jx14-20020a170903138e00b001a0549d39a1mr2553631plb.32.1679410014303;
        Tue, 21 Mar 2023 07:46:54 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id ju10-20020a170903428a00b0019a83f2c99bsm8857065plb.28.2023.03.21.07.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 07:46:53 -0700 (PDT)
Message-ID: <6325fba6-3dac-9391-28ef-177fcae9ad0a@acm.org>
Date:   Tue, 21 Mar 2023 07:46:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/3] block: Preserve LBA order when requeuing
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230320234905.3832131-1-bvanassche@acm.org>
 <20230320234905.3832131-4-bvanassche@acm.org> <20230321055802.GA18078@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230321055802.GA18078@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/20/23 22:58, Christoph Hellwig wrote:
> On Mon, Mar 20, 2023 at 04:49:05PM -0700, Bart Van Assche wrote:
>> When requeuing a request to a zoned block device, preserve the LBA order
>> per zone.
> 
> What causes this requeue?

Hi Christoph,

Two examples of why the SCSI core can decide to requeue a command are a 
retryable unit attention or ufshcd_queuecommand() returning 
SCSI_MLQUEUE_HOST_BUSY. For example, ufshcd_queuecommand() returns 
SCSI_MLQUEUE_HOST_BUSY while clock scaling is in progress (changing the 
frequency of the link between host controller and UFS device).

Thanks,

Bart.
