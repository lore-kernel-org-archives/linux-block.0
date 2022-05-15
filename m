Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E30AC433F5
	for <linux-block@archiver.kernel.org>; Sun, 15 May 2022 18:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiEOSFd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 14:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiEOSFb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 14:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48B5927175
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652637928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qj20J4C0pCzhfO4dii1bvqngq+90GaIULASSkm4GF+k=;
        b=OMI2A+gH9GC8Rk7NObGR0XbovD92g4f8BLc9ENJDgm0RBz1fsmCI5JSaHDTffzMi0CaGu7
        3IlvYhA3bMixPalvv+H8Iw9dIMydQTIYABLwd8qvyRHoJ6PsrOKd/BMzKr6JPBwWrl1vQo
        j+xmDeNrYTV5OzDWOyGP4Oz55pbG3m8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-FGIUQ5hxN76Di5175JWV3Q-1; Sun, 15 May 2022 14:05:26 -0400
X-MC-Unique: FGIUQ5hxN76Di5175JWV3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CEE4811E75;
        Sun, 15 May 2022 18:05:26 +0000 (UTC)
Received: from localhost (unknown [10.39.192.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38EF3C15D75;
        Sun, 15 May 2022 18:05:26 +0000 (UTC)
Date:   Sun, 15 May 2022 19:05:25 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Nikolaus Rath <nikolaus@rath.org>
Cc:     libguestfs@redhat.com, linux-block@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [Libguestfs] Communication issues between NBD driver and NBDKit
 server
Message-ID: <20220515180525.GF8021@redhat.com>
References: <04a0a06b-e6dc-48b7-bc29-105dab888a56@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04a0a06b-e6dc-48b7-bc29-105dab888a56@www.fastmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 15, 2022 at 04:45:11PM +0100, Nikolaus Rath wrote:
> Hi,
> 
> I am observing some strange errors when using the Kernel's NBD driver with
> NBDkit.
> 
> On the kernel side, I see:
> 
> May 15 16:16:11 vostro.rath.org kernel: nbd0: detected capacity change from 0
> to 104857600
> May 15 16:16:11 vostro.rath.org kernel: nbd1: detected capacity change from 0
> to 104857600
> May 15 16:18:23 vostro.rath.org kernel: block nbd0: Possible stuck request
> 00000000ae5feee7: control (write@4836316160,32768B). Runtime 30 seconds
> May 15 16:18:25 vostro.rath.org kernel: block nbd0: Possible stuck request
> 000000007094eddc: control (write@5372947456,10240B). Runtime 30 seconds
> May 15 16:18:27 vostro.rath.org kernel: block nbd0: Suspicious reply 89 (status
> 0 flags 0)
> May 15 16:18:31 vostro.rath.org kernel: block nbd0: Possible stuck request
> 0000000075f8b9bc: control (write@8057764864,32768B). Runtime 30 seconds
> May 15 16:18:41 vostro.rath.org kernel: block nbd0: Possible stuck request
> 000000002d1b3e8b: control (write@14499979264,32768B). Runtime 30 seconds
> [...]

Does it really take over 30 seconds for nbdkit to respond?  You might
want to insert some debugging into the S3 plugin to see what stage of
the request cycle is taking so long, although I'm going to guess it's
the remote Amazon server itself.

It seems like you can adjust this timeout using the nbd-client -t flag
(it calls ioctl(NBD_SET_TIMEOUT) in the kernel).  If I understand the
logic correctly, the nbd timeout is currently set to 0, which causes
the default socket timeout to be used.  Using the -t flag overrides this.
So I guess try setting it larger and see if the problem goes away.

Rich.

> And userspace ('zfs snapshot" in this instance) is stuck afterwards.
> 
> On the NBDkit side, there seemingly are write errors when replying back to the
> kernel:
> 
> $ nbdkit --unix /tmp/tmpi5o59_y_/nbd_socket_sb --foreground --filter=exitlast
> --filter=stats --threads 16 S3 size=50G bucket=nikratio-backup key=sb statsfile
> =/tmp/tmpi5o59_y_/stats_sb.txt object-size=32K &
> $ nbd-client -unix /tmp/tmpi5o59_y_/nbd_socket_sb /dev/nbd2
> Warning: the oldstyle protocol is no longer supported.
> This method now uses the newstyle protocol with a default export
> Negotiation: ..size = 51200MB
> Connected /dev/nbd0
> [....]
> nbdkit: python.10: error: write reply: NBD_CMD_WRITE: Broken pipe
> 
> 
> What's the best way to narrow down who's the culprit here (kernel vs NBD
> server)?
> 
> Best,
> -Nikolaus
> 
> --
> GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
> 
>              »Time flies like an arrow, fruit flies like a Banana.«
> 
> 

> _______________________________________________
> Libguestfs mailing list
> Libguestfs@redhat.com
> https://listman.redhat.com/mailman/listinfo/libguestfs


-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

