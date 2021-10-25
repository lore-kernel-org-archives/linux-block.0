Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017B6C433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 10:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D543160E96
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 10:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJYKkW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 06:40:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232877AbhJYKkW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 06:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635158279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1fOeWyRMs4exdMtz4NGI80T+TinV1ASf/mcv6Mz8YcE=;
        b=hOc7kukKzmI4jJbcCgNR8iat858XF2i37KxKPqNPVu3tC/ZuLdkSbrtE2Zwuf/e1sXEsFQ
        0jKOfbRwrhxVF8HiWUR6jT89SYg0GOclYL54EaJ149O+p6W1yN24D0ZgXXfydz9lJ3dEKW
        +t5tMn+WDkeKC6qSbZ4h+kbRoSge+9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-Un1IlTeLNQGSZueuUVZbKw-1; Mon, 25 Oct 2021 06:37:58 -0400
X-MC-Unique: Un1IlTeLNQGSZueuUVZbKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A163B100CCC4;
        Mon, 25 Oct 2021 10:37:56 +0000 (UTC)
Received: from ws.net.home (ovpn-112-9.ams2.redhat.com [10.36.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F43A60CA1;
        Mon, 25 Oct 2021 10:37:52 +0000 (UTC)
Date:   Mon, 25 Oct 2021 12:37:50 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Lennart Poettering <lennart@poettering.net>,
        Martijn Coenen <maco@android.com>, linux-block@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>
Subject: Re: Is LO_FLAGS_DIRECT_IO by default a good idea?
Message-ID: <20211025103750.dhfmof4izoh5ybrq@ws.net.home>
References: <YW2CaJHYbw244l+V@gardel-login>
 <20211018150550.GA29993@lst.de>
 <YW53SrKnKmn2Aa0k@T590>
 <32ccb509-37b7-c9f0-14f3-d68c24c55dad@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32ccb509-37b7-c9f0-14f3-d68c24c55dad@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 06:24:34AM -0600, Jens Axboe wrote:
> On 10/19/21 1:44 AM, Ming Lei wrote:
> > On Mon, Oct 18, 2021 at 05:05:50PM +0200, Christoph Hellwig wrote:
> >> On Mon, Oct 18, 2021 at 04:19:20PM +0200, Lennart Poettering wrote:
> >>> A brief answer like "yes, please, enable by default" would already
> >>> make me happy.
> >>
> >> I thikn enabling it by default is a good idea.  The only good use
> >> case I can think of for using buffered I/O is when the image has
> >> a smaller block size than supported on the host file.
> > 
> > Maybe we can enable it at default in kernel side, then fackback to
> > buffered IO if DIO is failed.
> 
> Yes I think that's sane, pure DIO probably isn't a great idea by
> default. But if we have a sane fallback, then I do think it'd be the
> best way to run it.

So, I can wait for kernel rather than enable it by default in
losetup/mount, right? :-)

  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

