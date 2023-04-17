Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631D2C77B70
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 06:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjDQGiX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 02:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDQGiW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 02:38:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6043139
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 23:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67FB860B55
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 06:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22138C433D2;
        Mon, 17 Apr 2023 06:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681713500;
        bh=91RBdG9NjAIDd6W3Q/b9EwpSRwYRz6d7ac3R22vlfbw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uZ4lnbdFMn98mis1IbZbPslLk/pPX0g70/RI8s7PoAkgTGQQXdDYXLNTRBxR04s7V
         ya1i0yjn7HdMfnFx/Luhc+Mp22nuBJZsSJam9IJcEQcXU0ZqaLct3TUI4KDwOv5qgk
         fsIHK8Uy4Vabt/XD3aWVtqLUpR0CiyUVFa88kdrNqfKDlNknvxQfsag+//qskSHLE+
         CvH/TABkkAgEl8OC1gCVHuqMoWn3CUg1/glX850QD1ETJlskmggumBUUO2R/V8qHHp
         cCTTTh5M+wIoFhtqUpfiB1vl4fk9evGfXxanxFWO5ClW21vZEyrs4Sfa6L0zA6X3i+
         4gZn/MsokjT6Q==
Message-ID: <86043ca0-7441-f558-86c3-78bbd920b9c8@kernel.org>
Date:   Mon, 17 Apr 2023 15:38:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6/7] blk-mq: do not do head insertations post-pre-flush
 commands
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230416200930.29542-1-hch@lst.de>
 <20230416200930.29542-7-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230416200930.29542-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/23 05:09, Christoph Hellwig wrote:
> blk_flush_complete_seq currently queues requests that write data after
> a pre-flush from the flush state machine at the head of the queue.
> This doesn't really make sense, as the original request bypassed all
> queue lists by directly diverting to blk_insert_flush from
> blk_mq_submit_bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


