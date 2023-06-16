Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FC6EB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 08:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbjFPIDg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 04:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244486AbjFPIDf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 04:03:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0742965;
        Fri, 16 Jun 2023 01:03:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B203962FB8;
        Fri, 16 Jun 2023 08:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D62C433C9;
        Fri, 16 Jun 2023 08:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686902610;
        bh=Rv0CEfUf3lAtuXHRkW2o8+9meytXFbTIwmHLdrelU0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e/fEVhN4gZBfXzqO9ZDNi/o2qJSY2AqkKYqK8ZQ5ohQAiC2gyb+xLQ43eFUT+AnmX
         DsJRD8RattictBGw+vtVQxoMYRAJRwe577xY3NGEfHn2UB2+9y/zGt26YmbKQ8sZYm
         tg+E1vKljWd80jZfalGJov9Ngb6GPVlAZyQv3DT0=
Date:   Fri, 16 Jun 2023 10:03:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "min15.li" <min15.li@samsung.com>
Cc:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, wsa@kernel.org, vkoul@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: add capacity validation in bdev_add_partition()
Message-ID: <2023061635-numerous-amplifier-f78b@gregkh>
References: <CGME20230616030739epcas5p31e705be33bf080f988702d42534ad32f@epcas5p3.samsung.com>
 <20230616110557.12106-1-min15.li@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616110557.12106-1-min15.li@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 16, 2023 at 11:05:57AM +0000, min15.li wrote:
> In the function bdev_add_partition(),there is no check that the start
> and end sectors exceed the size of the disk before calling add_partition.
> When we call the block's ioctl interface directly to add a partition,
> and the capacity of the disk is set to 0 by driver,the command will
> continue to execute.
> v1->v2: check for overflows of the start + length value and put
> the capacity check at the beginning of the function.
> 
> Signed-off-by: min15.li <min15.li@samsung.com>

I doubt you sign documents as "min15.li", right? :)

Please fix.

You also forgot a "changes" list below the --- line saying what changed
from the previous submission.

thanks,

greg k-h
