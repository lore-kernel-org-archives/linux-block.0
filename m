Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28F0C433F5
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 18:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345150AbiDOSIj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 14:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243676AbiDOSIj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 14:08:39 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8403961A07
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 11:06:10 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso8916685pjj.2
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 11:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h1tKDrb2kWusU2KqJ5UKYIqrT7yo83yzzjFAZ+KUf0g=;
        b=uCKP4vKooOljS2YinGSRyHtEDnQNc1weS3pTu3fDkipWc14edhpy3/3bfWgEx0T6il
         SzQtXX4EXf4hMCsNw+vdGm/MSDsDH+WSku7hf933SCYTp3XT8AOx6XqXpUdmzlameqPJ
         kVicJ9eZY6tGtDJGUscl0jAHhdj0G/U+zk4Tm50HKsg6w/GQ8jD3dghhjScB+EdPlxRg
         /4D8ynz+HQykTUW0CqmcmjYZYeM3xd5EjdgyKvhCidqqZMmNftVEA/i4dE2ojm6LBe4f
         aX6PfodbXhasif//rAjR7mlI1xrdwOXb3itkXknZmFfQQapQU0ftafqlLXkDfjh8YUOs
         QbMw==
X-Gm-Message-State: AOAM533Dfc1GC1RvV6ymbhQN8WxMOvpXM0Mq0uuIa9rE7LJXBqDy9lm2
        8kE6jH19LVYnnqY6XiFFhPkOvi8OXJbRwg==
X-Google-Smtp-Source: ABdhPJxSElclAbIMIm0ja5zrBH3cHdG23S3Yrk4nRqbBAtH5pdZ4SAnALt4p7fBfsb5FVmhlcrmtAw==
X-Received: by 2002:a17:90b:1886:b0:1cb:8e79:8ebb with SMTP id mn6-20020a17090b188600b001cb8e798ebbmr99186pjb.176.1650045969837;
        Fri, 15 Apr 2022 11:06:09 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a014:c21c:c3f8:d62? ([2620:15c:211:201:a014:c21c:c3f8:d62])
        by smtp.gmail.com with ESMTPSA id c2-20020a63a442000000b0039cc5a6af1csm4926454pgp.30.2022.04.15.11.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 11:06:09 -0700 (PDT)
Message-ID: <4c2f1a15-8d65-b234-a99f-354b4cbeef54@acm.org>
Date:   Fri, 15 Apr 2022 11:06:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: can't run nvme-mp blktests
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org> <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
 <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
 <YlkAlHe6LloUAzzN@infradead.org>
 <587c14e7-2b7e-74ac-377b-6faafcb829e4@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <587c14e7-2b7e-74ac-377b-6faafcb829e4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/14/22 22:58, Chaitanya Kulkarni wrote:
> If it doesn't add a new test coverage in the blktest framework
> then please remove.

cd blktests && git grep -nH dev/nvme-fabrics
tests/nvmeof-mp/rc:94:	[ -c /dev/nvme-fabrics ] &&
tests/nvmeof-mp/rc:101:					echo -n "$loginparams" > /dev/nvme-fabrics
tests/nvmeof-mp/rc:161:	if [ ! -c /dev/nvme-fabrics ]; then
tests/nvmeof-mp/rc:162:		echo "Error:  /dev/nvme-fabrics not available"

Does this mean that there are no other tests in the blktests framework that
test NVMeOF and hence that it is useful to keep these tests?

Thanks,

Bart.
