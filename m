Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17715C433F5
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B3060C40
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 13:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhKKNsO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 08:48:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233437AbhKKNsL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 08:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636638322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2yQ/kuuLA5DM2/1kHzwjtCpUZK1BxKEhkS6A9QGB5NA=;
        b=JwGp8HTID6fdNT28Lxr/F+9x8UguJW49E1qxanOCH9qzeiogDis2d1DY2lhkqKQiaV32uD
        67N1gv2nV3g/DjrMI8nvQkLU7CAn78sle3/mh0Ck2PQ4+945GFaeudDoI2Zi9u6r9Bs7Mf
        QROBGlmGTZ09CzogjCBjNyL8Yt3Vtns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-2a1cRGN-NAutNk9PnJi_qw-1; Thu, 11 Nov 2021 08:45:18 -0500
X-MC-Unique: 2a1cRGN-NAutNk9PnJi_qw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85F76804140;
        Thu, 11 Nov 2021 13:45:17 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F68A5F4F5;
        Thu, 11 Nov 2021 13:45:02 +0000 (UTC)
Date:   Thu, 11 Nov 2021 21:44:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
Message-ID: <YY0eVnbjmHmPZ3M4@T590>
References: <YYQoLzMn7+s9hxpX@infradead.org>
 <2865c289-7014-2250-0f5b-a9ed8770d0ec@kernel.dk>
 <YYQo4ougXZvgv11X@infradead.org>
 <8c6163f4-0c0f-5254-5f79-9074f5a73cfe@kernel.dk>
 <461c4758-2675-1d11-ac8a-6f25ef01d781@kernel.dk>
 <YYQr3jl3avsuOUAJ@infradead.org>
 <3d29a5ce-aace-6198-3ea9-e6f603e74aa1@kernel.dk>
 <YYQuyt2/y1MgzRi0@infradead.org>
 <87ee0091-9c2f-50e8-c8f2-dcebebb9de48@kernel.dk>
 <alpine.DEB.2.22.394.2111111350150.2780761@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2111111350150.2780761@ramsan.of.borg>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 11, 2021 at 01:58:38PM +0100, Geert Uytterhoeven wrote:
> 	Hi Jens,
> 
> On Thu, 4 Nov 2021, Jens Axboe wrote:
> > On 11/4/21 1:04 PM, Christoph Hellwig wrote:
> > > On Thu, Nov 04, 2021 at 01:02:54PM -0600, Jens Axboe wrote:
> > > > On 11/4/21 12:52 PM, Christoph Hellwig wrote:
> > > > > Looks good:
> > > > > 
> > > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > 
> > > > So these two are now:
> > > > 
> > > > https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=c98cb5bbdab10d187aff9b4e386210eb2332af96
> > > > 
> > > > which is the one I sent here, and then the next one gets cleaned up to
> > > > remove that queue enter helper:
> > > > 
> > > > https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=7f930eb31eeb07f1b606b3316d8ad3ab6a92905b
> > > > 
> > > > Can I add your reviewed-by to this last one as well? Only change is the
> > > > removal of blk_mq_enter_queue() and the weird construct there, it's just
> > > > bio_queue_enter() now.
> > > 
> > > Sure.
> > 
> > Thanks, prematurely already done, as you could tell :-)
> 
> The updated version is now commit 900e080752025f00 ("block: move queue
> enter logic into blk_mq_submit_bio()") in Linus' tree.
> 
> I have bisected failures on m68k/atari (on ARAnyM, using nfhd as the
> root device) to this commit, e.g.:
> 
>     sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>     sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
>     sd 0:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
>     sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 08 00 00 00 01 00 00 08 00
>     critical target error, dev sda, sector 1 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
>     Buffer I/O error on dev sda1, logical block 0, lost sync page write
> 
>     EXT4-fs (sda1): I/O error while writing superblock
>     sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>     sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
>     sd 0:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
>     sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 08 00 00 00 01 00 00 08 00
>     critical target error, dev sda, sector 1 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
>     Buffer I/O error on dev sda1, logical block 0, lost sync page write
>     EXT4-fs (sda1): I/O error while writing superblock
> 
> This may happen either when mounting the root file system (leading to an
> unable to mount root fs panic), or later (leading to a read-only
> rootfs).

BTW, today I just found that hang in blk_mq_freeze_queue_wait() is
caused by commit 900e080752025f00, and the following patch can fix it:

- blk-mq: don't grab ->q_usage_counter in blk_mq_sched_bio_merge

https://lore.kernel.org/linux-block/20211111085650.GA476@lst.de/T/#m759b88fda094a65ebf29bc81b780967cdaf9cf28

Maybe you can try the above patch.

Thanks,
Ming

