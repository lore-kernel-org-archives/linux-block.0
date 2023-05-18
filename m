Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAB9C77B73
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 23:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjERXOu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 19:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjERXOu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 19:14:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2319E48
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 16:14:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 663DB64074
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E392C433D2;
        Thu, 18 May 2023 23:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684451687;
        bh=JqbVb1UIPKioOfaMSdSClGQ1kUwHR2fRtcoDFWZvtS4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rQj5UhLirV/LjIX4T4Xcm1YaUwRRC4GI4dDE4aH0/n7/WSZcYXpNjxIb3bE+/4o8A
         N5QGFIQrYbpTnIEP8jvX2Z3UoDbklSkjIWXTkm0w+lPSxJtXLhFPsMPMk6/xzC/Zo8
         1TpMBzN58/UiIazdCHNXiBVOwKxcUQrnZhDV5OS3ajenq25IKTLU2ca4UDiE+LNfan
         drj/NT+C0zNcc6BkT61tT2srM8qnBDuuPpgl4JSHTnVRSqjfxrymFKKk85iCC3tMAK
         Llrdi6yArDwOA2Ain2qkzX0qsmSYvrFF+v5UE32f70nITt/6hqE1azgC8bp5XXifeE
         eSC/UBHVjpkMQ==
Message-ID: <48583f68-02a9-1e1a-8a1b-a67e5255a89f@kernel.org>
Date:   Fri, 19 May 2023 08:14:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 06/11] block: mq-deadline: Clean up
 deadline_check_fifo()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
References: <20230517174230.897144-1-bvanassche@acm.org>
 <20230517174230.897144-7-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230517174230.897144-7-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/23 02:42, Bart Van Assche wrote:
> Change the return type of deadline_check_fifo() from 'int' into 'bool'.
> Use time_is_before_eq_jiffies() instead of time_after_eq(). No
> functionality has been changed.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

I still think that time_is_before_eq_jiffies() should really be named
time_after_eq_jiffies() though, but that is a different patch :)


-- 
Damien Le Moal
Western Digital Research

