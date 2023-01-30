Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02EFC54EED
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 08:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbjA3IKV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 03:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbjA3IKF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 03:10:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684792B29E;
        Mon, 30 Jan 2023 00:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BCQTYoAwacQNQ/c7Hitilj1PDqlXyVP8xTVb6SNgBs8=; b=ssPnT8Uvy6HX6ZeHIXPwH8Uojl
        dSYpo5ok2SbcNltdyDfhP+HsmOZm9rbO09dtlzj0yXy/imXrtL5W6F+mbyfYehfbpm7y92jWreK3A
        R+NNJt6hIHcdurYvKf5TevT5fS8F5W+Qvoe6BBwEsodPeyxeL3qQOK72UdcwQubISJGRu00Ab7Z+k
        MQJzJAWa4ChbRpn3WwHXN2SKf8iKHNWO93rEjKV/fI7Qa1ukcUo27iP87zgijFoq2KQnEyy5PQC6+
        Z5aVHHPRwWTuxetl4hXain4+UjTTLsInccyy2IU22ozFBkNPOQWtBaNDqPDw7E0KecZVK69o0hlW9
        tGMccjrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMPDD-002c5C-1y; Mon, 30 Jan 2023 08:08:23 +0000
Date:   Mon, 30 Jan 2023 00:08:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] block: Support creating a struct file from a
 block device
Message-ID: <Y9d692WEX/ZvBhXI@infradead.org>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
 <20230126033358.1880-2-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126033358.1880-2-demi@invisiblethingslab.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 25, 2023 at 10:33:53PM -0500, Demi Marie Obenour wrote:
> The newly added blkdev_get_file() function allows kernel code to create
> a struct file for any block device.  The main use-case is for the
> struct file to be exposed to userspace as a file descriptor.  A future
> patch will modify the DM_DEV_CREATE_CREATE ioctl to allow userspace to
> get a file descriptor to the newly created block device, avoiding nasty
> race conditions.

NAK.  Do not add wierd side-way interfaces to the block layer.
