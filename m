Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9119AECAAD3
	for <linux-block@archiver.kernel.org>; Fri,  9 Sep 2022 15:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiIIPtk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Sep 2022 11:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIIPti (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2022 11:49:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3394140D1
        for <linux-block@vger.kernel.org>; Fri,  9 Sep 2022 08:49:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 551EBB8257F
        for <linux-block@vger.kernel.org>; Fri,  9 Sep 2022 15:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FCAC433D6;
        Fri,  9 Sep 2022 15:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662738574;
        bh=GHOBIlczqsmAvKB+02H6pIzStnx+qxkYX8Fisjt1Jqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XifhMVM8xPQAKlGJlEraGcbqlaoZLswEATeclzm5HZpdKyDXvXmQc/q6a2jIJDr9e
         yit968vxc1iyQvMdQBxyOPTiMw6I7Z1iozODoSu405L9BNSHpjG7fk86xG1AAXPoJi
         B580mTfy34zV1wQmHE9+KHtWWtSATvJ/DjyXrt/hJA8A9i0TyAl/HzYj2XllTXqGj/
         UlOM0oqaah72t3Bs1rIXnD3ExTHtoqsEKzgq3c4oRAEtEtz2vrwBbxMz7sIRt86T79
         k1lyAqYDev9DTouzbCxCCIA2ycuU61vvqj8FYg/dMA6OL0C9ExMTQeMnYDKVibVYkV
         q7tYt8MzHIovQ==
Date:   Fri, 9 Sep 2022 09:49:31 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Keith Busch <kbusch@fb.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCHv4] sbitmap: fix batched wait_cnt accounting
Message-ID: <Yxtgi6tbDJj9JDyI@kbusch-mbp.dhcp.thefacebook.com>
References: <20220908215132.3243008-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908215132.3243008-1-kbusch@fb.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 08, 2022 at 02:51:32PM -0700, Keith Busch wrote:
> @@ -638,7 +641,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>  	 * Wake up first in case that concurrent callers decrease wait_cnt
>  	 * while waitqueue is empty.
>  	 */
> -	wake_up_nr(&ws->wait, wake_batch);
> +	wake_up_nr(&ws->wait, wake_batch - wait_cnt);

The reason it was failing is this was not spreading the wake up among enough
wait states. I'll have to go back to the same method that patch 1 was doing
with clamping the decrement count..
