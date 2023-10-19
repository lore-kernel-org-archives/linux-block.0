Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A450DCDB465
	for <linux-block@archiver.kernel.org>; Thu, 19 Oct 2023 07:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjJSHYe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Oct 2023 03:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjJSHYd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Oct 2023 03:24:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9641B123
        for <linux-block@vger.kernel.org>; Thu, 19 Oct 2023 00:24:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B777DC433C7;
        Thu, 19 Oct 2023 07:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697700271;
        bh=Y7/RgxS6eDdTnl62hNbYaqOLvqoDI7GSPffvTf1rHUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DOqfiKqRDXLKsMwN91ow53EQAdi3d7B53CV2s6fTSdn+3Xm4TJvE/x0gZQgPZ40+E
         fY1lqszBxhJb6d7So8EMrJAhO83fa3mAcpM+zZiiN4fmxmeRdIpFkim/GOqMhiaWyN
         Vnv6yNK9tsBioVdw1qI/Kbc+dwIiXVsdtxDUAXdaZaHsW1NdcRZN/E2c5mrthJ0Uaj
         Cu1Gm+bKEkdD1wsrEmRvBGeVN571Rqvjcjlhg4YnrIVREgxKdAtU/uaPTSxKhMIGvQ
         sdzsat6VMLB+tm+DN1SAa5daRGTrd3iCU/HVM5q1PUg4asueizxXP3zHxCS/9VmQgC
         SLoDs3hBdQo0Q==
Date:   Thu, 19 Oct 2023 09:24:24 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] block: move bdev_mark_dead out of
 disk_check_media_change
Message-ID: <20231019-albern-vormerken-6a1c3548a02a@brauner>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-4-hch@lst.de>
 <20231018-retten-luftkammer-2bae34ff707f@brauner>
 <20231019055740.GA14794@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231019055740.GA14794@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 19, 2023 at 07:57:40AM +0200, Christoph Hellwig wrote:
> I turns out that we'd need bdev_mark_dead generally exported for this.
> I don't quite like that, but I don't really see a way around it.
> Maybe fix that up in your tree?

Done.
