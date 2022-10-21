Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86E9C4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 06:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJUGuo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 02:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiJUGuh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 02:50:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6029127BE2
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 23:50:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60B16218B1;
        Fri, 21 Oct 2022 06:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666335027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LdLvVMYluDs+UorP3kC9cVNAXtBEUJS3Mu08+Hov0HM=;
        b=DD9nbr6c01t995uPUouDzo5oLbhKSQN8CDM6iX3ZuYNonZlYug/PE2ZfRn/yibZ5SBFs6s
        LUNWH7TTVgiilJjrISIoIaCty/kuCCaVh67GSUIv4/ZP5yIZn5k44ZLsJOdJwihwPf9lK8
        wQVzi5XeNAXRMLyDlI2Fm2H8mBgo1c8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666335027;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LdLvVMYluDs+UorP3kC9cVNAXtBEUJS3Mu08+Hov0HM=;
        b=a7b1iKEDWk+gt5PEat65ecGWjLidYD9X54Wc6HBoXZCGToKlP+V+Bu1X9MEmLBarzQjqmy
        E59WMzyfaAjvrBAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A4DF1331A;
        Fri, 21 Oct 2022 06:50:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CUJfCTNBUmOsHgAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 21 Oct 2022 06:50:27 +0000
Message-ID: <b9f1e81d-04ee-d7db-43a7-12ca1ca73049@suse.de>
Date:   Fri, 21 Oct 2022 08:50:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/8] blk-mq: move the srcu_struct used for quiescing to
 the tagset
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-4-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221020105608.1581940-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/22 12:56, Christoph Hellwig wrote:
> All I/O submissions have fairly similar latencies, and a tagset-wide
> quiesce is a fairly common operation.  Becuase there are a lot less
> tagsets there is also no need for the variable size allocation trick.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c       | 27 +++++----------------------
>   block/blk-mq.c         | 25 +++++++++++++++++--------
>   block/blk-mq.h         | 14 +++++++-------
>   block/blk-sysfs.c      |  9 ++-------
>   block/blk.h            |  9 +--------
>   block/genhd.c          |  2 +-
>   include/linux/blk-mq.h |  4 ++++
>   include/linux/blkdev.h |  9 ---------
>   8 files changed, 37 insertions(+), 62 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

