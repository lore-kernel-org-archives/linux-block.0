Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3927DC3DA6F
	for <linux-block@archiver.kernel.org>; Fri, 25 Aug 2023 12:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242735AbjHYMIq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Aug 2023 08:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243185AbjHYMIX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2023 08:08:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF53E1BC7;
        Fri, 25 Aug 2023 05:08:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DB9863BEA;
        Fri, 25 Aug 2023 12:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DDFC433C7;
        Fri, 25 Aug 2023 12:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692965299;
        bh=O1BeJAOpxteZCBaP/YGN8SQfYOsZX2At27ufhN4mM1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BbyBgEI19svlljlDTWGcuzKjbRKQwL8ggEAYN93ZiJHcuFgyEf/FVH8XEM0VpsZHT
         HMddYEHY1t0tPG9U85q+sMSgb25zamlmi44NV12tIfIZo34+Z+TwFLY5BwERmhW+MG
         o32A0+nJjZ387JD5JBvT25EwmxKrRr+1SRELUdow1FRAqiLNXBe847yUsSChZ9+R26
         QOWDY3D+55ccrD6RNnDKM+3gIF2Rk7914Fw0kH0/1lbOPUl4HT5MHpGZeUeYSb0rqP
         4cGBy3LDVM+nCtSaVcpWDwuArDTHilJ/8FNzyvODyX6mzLZ6WUfTzNFVHkPn5GujWY
         2QXvEpbQXSgbQ==
Date:   Fri, 25 Aug 2023 14:08:15 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/29] dm: Convert to bdev_open_by_dev()
Message-ID: <20230825-geduscht-glitzer-dfe0505470c6@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-10-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-10-jack@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:21PM +0200, Jan Kara wrote:
> Convert device mapper to use bdev_open_by_dev() and pass the handle
> around.
> 
> CC: Alasdair Kergon <agk@redhat.com>
> CC: Mike Snitzer <snitzer@kernel.org>
> CC: dm-devel@redhat.com
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
