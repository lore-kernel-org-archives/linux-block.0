Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAA1C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 07:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiGRHgM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 03:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiGRHgM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 03:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6196A11C13
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 00:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658129770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NbrPYDqOIPXVLjqn6bvsTG1sis87yuCrRp/gxSeYXS8=;
        b=FKENxbl0zdBiVPzerkEHMffyaas5b0STDFljDAdDx4DwB9SPz8+ZD2ZbdXcjFtji+hQmWx
        xX45gqtzGhuuTujldWPIboKUjmX2IcFevp5iWjM35lOCHTllI9dGSbEzwlRrZ/lu5qPvsi
        sECD4ZNy+GayLQvmbdLBit7ESO4w62w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-SesqOqdJPhSgJaX2zqnyhA-1; Mon, 18 Jul 2022 03:36:08 -0400
X-MC-Unique: SesqOqdJPhSgJaX2zqnyhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69F4D2813D2C;
        Mon, 18 Jul 2022 07:36:08 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A12340D2962;
        Mon, 18 Jul 2022 07:36:04 +0000 (UTC)
Date:   Mon, 18 Jul 2022 15:35:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: use of the system work queue in ublk
Message-ID: <YtUNX2l2xkWXQwYA@T590>
References: <YtT/4Y387f/6pxZH@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtT/4Y387f/6pxZH@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On Sun, Jul 17, 2022 at 11:38:25PM -0700, Christoph Hellwig wrote:
> Hi Ming,
> 
> it seems like ublk uses schedule_work to stop the device, which
> includes a del_gendisk.  I'm a little fearful this will gets us into
> lockdep chains of death once syzbot or Tetsu notice it.

ublksrv has two built-in tests(generic/001, generic/002) for covering
heavy io with device removal and killing ubq_daemon, not see lockdep
warning when running the two tests with lockdep enabled.

Could you or Tetsu provide a bit more info about the warning?

> 
> That being said, I don't reall understand the design of
> ublk_daemon_monitor_work, which is only used to kick off other
> work to start with.

If the ubq daemon becomes dead, ublk_daemon_monitor_work will be
scheduled for handling the error: abort pending io requests, and
start to delete disk.

It has to be triggered when del_gendisk() is in-progress for making
forward progress.


Thanks,
Ming

