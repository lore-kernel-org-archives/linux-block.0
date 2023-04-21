Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279AAC7618E
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 06:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjDUGjE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Apr 2023 02:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDUGjD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2023 02:39:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474E2171B;
        Thu, 20 Apr 2023 23:39:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 052931FDDC;
        Fri, 21 Apr 2023 06:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682059141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PtI5FsWIo7eS0MfsXeWP2DccH1Y9ik4GSJZ5dtRpXbM=;
        b=UcvZxfBYk144jFxyAF78oS1m2sQece6AviBda1qJyTTf76FX7EFgdPEQR3pNfsjP/nEYFY
        nNA5sW5bI3Es85PuIqLiT4DWfvuEmq0F2Fpt2BX6dWLW1tO/YaXxgQns8VhTArSt8UDYM5
        sc/VYE7YL5rhm7E7dP+Kt/bmb6ZNEwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682059141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PtI5FsWIo7eS0MfsXeWP2DccH1Y9ik4GSJZ5dtRpXbM=;
        b=hmWTq2sQ1y/r8w9SBFihB7nL2/dvz5pjJ7E9iM1BVShCkv39DDwuHa1wkeR5GFC6jrTriU
        oETECvkSU8hEKJDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5B1113456;
        Fri, 21 Apr 2023 06:39:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yzVWM4QvQmRhdQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 21 Apr 2023 06:39:00 +0000
Message-ID: <c5a5cf4b-ba96-1e55-26ac-d2da9ab7117d@suse.de>
Date:   Fri, 21 Apr 2023 08:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH REPOST blktests v2 9/9] nvme: Make the number iterations
 configurable
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-10-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230421060505.10132-10-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/23 08:05, Daniel Wagner wrote:
> Some tests hard code high values of iterations. This makes them run
> relatively long compared to the other tests. Introduce a new environment
> variable nvme_num_iter to allow tune the runtime.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/002 | 2 +-
>   tests/nvme/016 | 2 +-
>   tests/nvme/017 | 2 +-
>   tests/nvme/rc  | 1 +
>   4 files changed, 4 insertions(+), 3 deletions(-)
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

