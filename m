Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2FAC07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 07:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C6361358
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 07:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhGOH04 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 03:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhGOH04 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 03:26:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F077C06175F;
        Thu, 15 Jul 2021 00:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1u+yT6IFUTSw8uuRjzesJ7WhUZssdnULKNc/AOe1yAM=; b=kfkHfEclUImyj4PpiZ2KWs6l9n
        NdcjLNJc0X7A5W4CdIFjQF4TiI+B4+DgXebNYKwGtP1D71XfHqIQAK0Y0zdMkqoulLuRkxwI8+1w+
        noZJqouLcHhpfg309o48Ii44Y0yKzG/WmzNDZtf0BQPgB5pshW4k8PXXiUTSVwbGijK6FessGx0X2
        raMTzvcAzQKmTvkjB8CmIPXp0dDK7FsTM7RHu9wKVbEbTgHz2C1u4NRxKpYLp0EBBZmDEcoh2e+J+
        aNF55xmARLyXuI3xVIUe77MzuusQ2C4qRjAcrQ7t6PS6OBZ+YA0CsQSlHs/Kfc9idDUx15fshnsVK
        ft6CBF/A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3vi0-0035uk-Qy; Thu, 15 Jul 2021 07:23:05 +0000
Date:   Thu, 15 Jul 2021 08:23:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, hch@infradead.org, jack@suse.cz,
        osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] block: add error handling for *add_disk*()
Message-ID: <YO/iVNCSTWy5EmoP@infradead.org>
References: <20210715045531.420201-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715045531.420201-1-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 14, 2021 at 09:55:25PM -0700, Luis Chamberlain wrote:
> Although I've dropped driver conversion at this point I've
> converted all drivers over, but that series is about 80
> patches... and so should be dealt with after this basic core
> work is reviewed and merged.

I think we need at least a few sample conversions to show how
you intend this to be used.
