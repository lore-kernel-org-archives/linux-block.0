Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796E2C0015E
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 00:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjG0AEZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 20:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjG0AEY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 20:04:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC67F9C
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 17:04:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BB2F61CE1
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 00:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0ADC433C8;
        Thu, 27 Jul 2023 00:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690416262;
        bh=w/qmvwjjehvpqynb3vuBkVGHo8qy4Drs8ixklhFtZ0Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QOELggGyTtOwOZNIUMe4DmxRYAP7QGJswCIkNNv1PWKPEIFW3jFuRkSU/u7kj0tN2
         kmNO+Y567Tk4nsY1+Ubx9/o5lKu0q6jR1K1fU9FnOkmr9FzGRRiFYRKusbfcbokPeZ
         Hsmij80Q5xvzScxiLFhWRmeHbJdWpDdZpNaDoQS5ZSFDFPg3i/8t4CYav8Kgi7KJaR
         jFMasgGGU4sas+eXAszx4TfcsZBqa+N991JM8aeq7niqbDsPEV0sR/6hMmVzex80v9
         EsYWW5My+DnFWUM6t0+5nNqulYySv9eUP4vGqNOwKxOpVNDDty/bn2VI/E09dxBuoq
         Wp8MFO36aJhTw==
Message-ID: <585cded7-e38e-5f79-87dd-23a361d336b6@kernel.org>
Date:   Thu, 27 Jul 2023 09:04:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 4/7] block/null_blk: Support disabling zone write
 locking
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230726193440.1655149-1-bvanassche@acm.org>
 <20230726193440.1655149-5-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230726193440.1655149-5-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/23 04:34, Bart Van Assche wrote:
> Add a new configfs attribute for disabling zone write locking. Tests
> show a performance of 250 K IOPS with no I/O scheduler, 6 K IOPS with
> mq-deadline and write locking enabled and 123 K IOPS with mq-deadline
> and write locking disabled. This shows that disabling write locking
> results in about 20 times more IOPS for this particular test case.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

