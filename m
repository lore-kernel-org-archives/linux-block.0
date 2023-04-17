Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026A9C77B70
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 07:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjDQHXL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 03:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDQHXL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 03:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEEB1996
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 00:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681716142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iQeXJbCFtyjEdqAFQrkKjrrrPIQvjzAWCeNdtEUO9qM=;
        b=FwoV/8Pst/I7NgEVQDTNNNannJBS3awK5Q2XCm2VzzJMZRXO78BBFkDvV54y2AR9fnyne5
        Auwhep9EYUCBzsLqSQhcVZnpaK/Ri8iRl7AmtaVOVrFArz43vMO8V+fO/jpsp5aacaQrQs
        c/R5La9wgXvsheDnyko1cArCzmTNLGg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-6L3Ha9QgNTGr8w-topv-3A-1; Mon, 17 Apr 2023 03:22:16 -0400
X-MC-Unique: 6L3Ha9QgNTGr8w-topv-3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B7833C0F669;
        Mon, 17 Apr 2023 07:22:16 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44B7B2A68;
        Mon, 17 Apr 2023 07:22:12 +0000 (UTC)
Date:   Mon, 17 Apr 2023 15:22:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH] block: ublk: switch to ioctl command encoding
Message-ID: <ZDzzn0jg/0LL4r7F@ovpn-8-16.pek2.redhat.com>
References: <20230407083722.2090706-1-ming.lei@redhat.com>
 <ZDzQeE3dHIC8FmE8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDzQeE3dHIC8FmE8@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 16, 2023 at 09:52:08PM -0700, Christoph Hellwig wrote:
> On Fri, Apr 07, 2023 at 04:37:22PM +0800, Ming Lei wrote:
> > All ublk commands(control, IO) should have taken ioctl command encoding
> > from the beginning,
> 
> Why?

The traditional ioctl command encodes type/nr/dir info, and basically
each command is unique if every driver respects the rule, so at least:

1) driver can figure out wrong command sent from userspace easily

2) easier for security subsystem audit[1]



[1] https://lore.kernel.org/io-uring/CAHC9VhSVzujW9LOj5Km80AjU0EfAuukoLrxO6BEfnXeK_s6bAg@mail.gmail.com/

thanks,
Ming

