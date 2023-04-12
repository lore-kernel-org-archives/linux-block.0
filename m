Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCFAC77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjDLHrr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjDLHrp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:47:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0DF1705
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:47:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5DC8616C2
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15E6C433EF;
        Wed, 12 Apr 2023 07:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681285663;
        bh=Kj1AhYYYhokgBF5jkCn7VbmijMLYSGG6ZVMhbIxLXrw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=p0kyVr70eD/AzYfhvOXHM7bO1a1KfpF+BvVGCUnzltgZKhqFM05LiHRErpwoR+5gn
         Cv55on2z5cHOTfZ8mY70OI1+tOwlRF+RwtI5NOYqLZ0NiyaeuCpEfPKisw6xGaHjnE
         DNzeI8DLd+QwugADaDSdBeUILt38jTN0nz3oVS/yiyW+0xLPX/TVrkJiQ77CKKLaVE
         N9zK1bORwubU625SGpMC2zVTBWrF8WS/LtHt0/QIDSoExkgIQMym5GbwxI4lzrbbzd
         y/YbuepaGneGsalueqJq/kBwU1QEG0FN4k+cFmXdwguy0qAJ6qd/U8VIMjZ/4WLK0p
         SnfJCGtQNJjnA==
Message-ID: <a679928f-8d13-8e71-6d29-3fe26682cdc4@kernel.org>
Date:   Wed, 12 Apr 2023 16:47:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 18/18] blk-mq: pass the flags argument to
 elevator_type->insert_requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-19-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-19-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> Instead of passing a bool at_head, pass down the full flags from the
> blk_mq_insert_request interface.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


