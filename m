Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F80AC433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 07:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5942074B
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 07:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6BdQM1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgFAHuS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:50:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52936 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgFAHuS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jun 2020 03:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590997817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IuO46ycNz8mneB+aXPJm85h+RFJWz/TY+HoUCs4wBY8=;
        b=B6BdQM1iHSTRCcw0jvK2iT6uF6bHY2lE54oTso0BGeLe9f9G65FBVgHI6Rf5P7FH17J4ia
        8CLIupeam+EiQEDAfHwW/Rvk2vV6MvDxZwXCdJeEsqcJdCxxdl6AmPxPbCkBFwaE7UyQWL
        ZZW9JGz1TtzqHV8R3fX4mlHc+zfZT6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-5Kga0UcWNre1R3UidKM26A-1; Mon, 01 Jun 2020 03:50:13 -0400
X-MC-Unique: 5Kga0UcWNre1R3UidKM26A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42EB9100CCC2;
        Mon,  1 Jun 2020 07:50:12 +0000 (UTC)
Received: from T590 (ovpn-13-152.pek2.redhat.com [10.72.13.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A29C78EA8;
        Mon,  1 Jun 2020 07:50:01 +0000 (UTC)
Date:   Mon, 1 Jun 2020 15:49:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] block: Flag elevators suitable for single queue
Message-ID: <20200601074957.GE1181806@T590>
References: <20200528081003.238804-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528081003.238804-1-linus.walleij@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 10:10:03AM +0200, Linus Walleij wrote:
> The Kyber block scheduler is not suitable for single hardware
> queue devices, so add a new flag for single hardware queue
> devices and add that to the deadline and BFQ schedulers
> so the Kyber scheduler will not be selected for single queue
> devices.

The above may not be true for some single hw queue high performance HBA(
such as megasas), which can get better performance from none, so it is
reasonable to get better performance from kyber, see 6ce3dd6eec11 ("blk-mq:
issue directly if hw queue isn't busy in case of 'none'"), and the
following link:

https://lore.kernel.org/linux-block/20180710010331.27479-1-ming.lei@redhat.com/

Thanks, 
Ming

