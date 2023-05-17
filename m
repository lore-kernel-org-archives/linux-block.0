Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601BCC77B7F
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 01:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjEQBHo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 21:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjEQBHo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 21:07:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D726E4C17
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 18:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A30364085
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 01:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B56C433D2;
        Wed, 17 May 2023 01:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684285661;
        bh=Xhvk1BBfRgblVv0ST7BUAk8r3ADXhORHCYnBGd3lFY4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DjF71DQFNJwkhnjSR4aIdoOmRiVxE2bTPFo4++yEmT3aMNmGhFRL+O1XgFcngFntv
         TECqgwRQ1vu7WbHBZQP3TJ5FrhVIsR5q8tEHvAhbxtIlkemTXNOEa5mgPKGsTTT3d+
         HkQzY5Tbpcs4URhO6CyYP9OCqqSyot/wEi5XGPygaMSX+yCOQEO1EyIS5Db77Byn9D
         JHBGAus383sJQx/qCgPO0alnBC9WgoexUacHaxQO7pgayHHcZamGGPoMfDl8QYyxFO
         xFhCurMO5dNbcfdMPslMpg+fwbgzJCXC5n1ls6Q6ND/tjdmlVRjdAsMgIq5k72DU4d
         SH6Bp8SKKH5WQ==
Message-ID: <87039d38-095a-ec2b-110a-6bdbef9d5379@kernel.org>
Date:   Wed, 17 May 2023 10:07:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 08/11] block: mq-deadline: Reduce lock contention
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-9-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230516223323.1383342-9-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 07:33, Bart Van Assche wrote:
> blk_mq_free_requests() calls dd_finish_request() indirectly. Prevent
> nested locking of dd->lock and dd->zone_lock by moving the code for
> freeing requests.
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

