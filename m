Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6707FC433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 21:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbhLUVuG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 16:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLUVuG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 16:50:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57EDC061574
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 13:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4uUB7OvEP777x5aSTb3bjGyRvtnNEoJahrUKQnkYzZA=; b=d8f278I0epkwa0u4oUG6Y09EGi
        5F+Lyh1Ynf353smMbI+czmvNsEe5VvGifCMQiQzj/VJXmdq2Roh9h+8rBP6kM8a20JKglW/NCzCh4
        LgptBC2NMjh0aeObnKZgLF/CBmYdy7yJnslCJZqisSBjh/K/UjXZ5EaDhsaj98El+vwVl4mqKTH33
        V1JFiDrZbCu3415wnxYLT0shGYhYT1UH/66DIoF/PbSqH9QQhLLJ/wzzWuqebBjiNuKMwvQmtcc86
        4dh5w89HzwrbG63Bn0XHO83BObgjKD7PWm5hDYtw4ZxiInqwzN45w/g8V0Ur5K0v1uGojwra217nz
        pl0ukqMA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzn1E-008ZbH-Pq; Tue, 21 Dec 2021 21:50:00 +0000
Date:   Tue, 21 Dec 2021 13:50:00 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix error handling for device_add_disk
Message-ID: <YcJMCPvyWZgolXdy@bombadil.infradead.org>
References: <c614deb3-ce75-635e-a311-4f4fc7aa26e3@i-love.sakura.ne.jp>
 <20211216161806.GA31879@lst.de>
 <20211216161928.GB31879@lst.de>
 <c3e48497-480b-79e8-b483-b50667eb9bbf@i-love.sakura.ne.jp>
 <Yb+Pbz1pCNEs4xw3@bombadil.infradead.org>
 <11adfb69-9ce6-c1f6-7b0d-c435e1856412@i-love.sakura.ne.jp>
 <YcDWjrTgNG8/vkmJ@bombadil.infradead.org>
 <e5a62dee-a420-f9c4-f33d-e154cf4b0d9e@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5a62dee-a420-f9c4-f33d-e154cf4b0d9e@i-love.sakura.ne.jp>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 21, 2021 at 08:41:18PM +0900, Tetsuo Handa wrote:
> On 2021/12/21 4:16, Luis Chamberlain wrote:
> > The kobject_alive() tells us if at least the device_add() had the
> > kobject_add() complete.
> 
> 
> Testing with error injection
> 
> @@ -3284,6 +3284,9 @@ int device_add(struct device *dev)
>         if (!dev)
>                 goto done;
> 
> +       if (!strcmp(current->comm, "a.out"))
> +               goto done;
> +
>         if (!dev->p) {
>                 error = device_private_init(dev);
>                 if (error)
> 
> told me that kref count is 1 when reaching the out_disk_release_events label.
> Thus,
> 
> 	if (!kobject_alive(&ddev->kobj))
> 
> seems wrong.

Hrm.... quite unexpected.

> Christoph proposed deferring disk_alloc_events(). If it is safe to defer
> disk_alloc_events(), that can be a fix. 

*If safe*, yes, agreed.

  Luis
