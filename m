Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318DFC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 14:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiDSOwB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 10:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiDSOwB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 10:52:01 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D34A3A5D5
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 07:49:19 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id k29so24144664pgm.12
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 07:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yOk1XsRCskxk7wSp4pLxp73hP701kySO4jblQDeALWI=;
        b=HwsFDanAjU6vUWyWAfHD5wEw/Drf3kB5Ay3QOoSOIu0mN9JjK0Oa787gXw0WiTfuZu
         4ziGbkKmerU/jqowSsL00qUtCTxno5u9YI6Bvc33cBdcpQxGoAVxSmnlkMFrTwBoOKGQ
         gtKpLTIgNAt2WITn3FLC+/NGOqHKxbq9Gsk15z4IW8qAqxVZfUZ2BmO6R488y6oyNb9p
         iFkZ9EewzZTSzTL4LV6330z3lV3567c4j/EK9WAyS/kUSc6U7XtlfpUlqNQW0I8m7LJL
         tY+M9hbADqpLOggfW2kbDS0O7f5QRZ+Q4ItImlQb9dmkzMIR/It5oNTm+wh80mw1XHHC
         Rtfg==
X-Gm-Message-State: AOAM532hBM9j95iQ4zG6K/kQlyJ4uBO2nAZcIMMiHDiP4hmA2S7TMBoc
        ySAxRqMvCWUuhJpPJ79IDIM=
X-Google-Smtp-Source: ABdhPJw2hAscEHRcFTzUWOyqhxAELSPOyyqwloflr/drlb0wIfWBB5eDGOBqcK/cdaadIdC+TPUxsg==
X-Received: by 2002:a63:67c4:0:b0:3a3:2134:aed7 with SMTP id b187-20020a6367c4000000b003a32134aed7mr14659885pgc.398.1650379758451;
        Tue, 19 Apr 2022 07:49:18 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id f16-20020aa78b10000000b0050a81508653sm6661024pfd.198.2022.04.19.07.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 07:49:17 -0700 (PDT)
Message-ID: <d0d73b81-22ba-270c-2866-cac045b61965@acm.org>
Date:   Tue, 19 Apr 2022 07:49:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Nullblk configfs oddities
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <Yl3aQQtPQvkskXcP@localhost.localdomain>
 <c7f02531-8637-89a2-d8b7-1da03240db73@nvidia.com>
 <b1fcc3dc-71a5-4a07-8f18-75f5e6cd7153@kernel.dk>
 <827699fb-e21b-2cad-6a6d-0a21c49f444e@nvidia.com>
 <bc93d84b-3c10-07ed-5203-9eba485fb108@kernel.dk>
 <c5418ac1-460f-348f-d7a3-d7c3a1aaad71@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c5418ac1-460f-348f-d7a3-d7c3a1aaad71@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/22 21:23, Damien Le Moal wrote:
> +	ret = vfs_mkdir(mnt_user_ns(parent.mnt), d_inode(parent.dentry),
> +			dentry, 0755);

Christoph, if I remember correctly functionality has been added recently
to configfs for creating directories from inside the kernel without 
calling vfs_mkdir()?

Thanks,

Bart.
