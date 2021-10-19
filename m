Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F89C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 07:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E5B61374
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 07:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhJSHqt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 03:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234552AbhJSHql (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 03:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634629468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xdb9pgCES243B4qiRy/jopANeVX7zGOs7S7OBfoCKBM=;
        b=S1e08T8jGuiq4cXZqcKV9l9IZbOy2yz+1mH7iE+dALLwobINh2k3HVrjd0OxH4grwc9sDp
        faQELyEpxKiz7cE46yJzSvKfaOT9evwZ0Dkco+YniFMLeCYD/vhvvpuSndWShMEF1GX5hf
        8QFqsCz+qZ2ZeCEAC2/pz8X+XZ+eHLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-jCxHfB9sO5-8XCTP8TdceQ-1; Tue, 19 Oct 2021 03:44:25 -0400
X-MC-Unique: jCxHfB9sO5-8XCTP8TdceQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 952DE10A8E01;
        Tue, 19 Oct 2021 07:44:23 +0000 (UTC)
Received: from T590 (ovpn-8-39.pek2.redhat.com [10.72.8.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56D8F19C79;
        Tue, 19 Oct 2021 07:44:15 +0000 (UTC)
Date:   Tue, 19 Oct 2021 15:44:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Lennart Poettering <lennart@poettering.net>,
        Jens Axboe <axboe@fb.com>, Martijn Coenen <maco@android.com>,
        linux-block@vger.kernel.org, Luca Boccassi <bluca@debian.org>,
        Karel Zak <kzak@redhat.com>
Subject: Re: Is LO_FLAGS_DIRECT_IO by default a good idea?
Message-ID: <YW53SrKnKmn2Aa0k@T590>
References: <YW2CaJHYbw244l+V@gardel-login>
 <20211018150550.GA29993@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018150550.GA29993@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 18, 2021 at 05:05:50PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 18, 2021 at 04:19:20PM +0200, Lennart Poettering wrote:
> > A brief answer like "yes, please, enable by default" would already
> > make me happy.
> 
> I thikn enabling it by default is a good idea.  The only good use
> case I can think of for using buffered I/O is when the image has
> a smaller block size than supported on the host file.

Maybe we can enable it at default in kernel side, then fackback to
buffered IO if DIO is failed.

thanks, 
Ming

