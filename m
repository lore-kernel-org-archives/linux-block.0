Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F589C433EF
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 12:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A990611C9
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 12:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhKKNBb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 08:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbhKKNBa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 08:01:30 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4EBC061767
        for <linux-block@vger.kernel.org>; Thu, 11 Nov 2021 04:58:41 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:c018:2195:47a6:f384])
        by baptiste.telenet-ops.be with bizsmtp
        id H0ye2600816Lvom010yeZi; Thu, 11 Nov 2021 13:58:38 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ml9f4-00BfVd-2I; Thu, 11 Nov 2021 13:58:38 +0100
Date:   Thu, 11 Nov 2021 13:58:38 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     Jens Axboe <axboe@kernel.dk>
cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
In-Reply-To: <87ee0091-9c2f-50e8-c8f2-dcebebb9de48@kernel.dk>
Message-ID: <alpine.DEB.2.22.394.2111111350150.2780761@ramsan.of.borg>
References: <20211104182201.83906-1-axboe@kernel.dk> <20211104182201.83906-5-axboe@kernel.dk> <YYQoLzMn7+s9hxpX@infradead.org> <2865c289-7014-2250-0f5b-a9ed8770d0ec@kernel.dk> <YYQo4ougXZvgv11X@infradead.org> <8c6163f4-0c0f-5254-5f79-9074f5a73cfe@kernel.dk>
 <461c4758-2675-1d11-ac8a-6f25ef01d781@kernel.dk> <YYQr3jl3avsuOUAJ@infradead.org> <3d29a5ce-aace-6198-3ea9-e6f603e74aa1@kernel.dk> <YYQuyt2/y1MgzRi0@infradead.org> <87ee0091-9c2f-50e8-c8f2-dcebebb9de48@kernel.dk>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

 	Hi Jens,

On Thu, 4 Nov 2021, Jens Axboe wrote:
> On 11/4/21 1:04 PM, Christoph Hellwig wrote:
>> On Thu, Nov 04, 2021 at 01:02:54PM -0600, Jens Axboe wrote:
>>> On 11/4/21 12:52 PM, Christoph Hellwig wrote:
>>>> Looks good:
>>>>
>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>
>>> So these two are now:
>>>
>>> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=c98cb5bbdab10d187aff9b4e386210eb2332af96
>>>
>>> which is the one I sent here, and then the next one gets cleaned up to
>>> remove that queue enter helper:
>>>
>>> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=7f930eb31eeb07f1b606b3316d8ad3ab6a92905b
>>>
>>> Can I add your reviewed-by to this last one as well? Only change is the
>>> removal of blk_mq_enter_queue() and the weird construct there, it's just
>>> bio_queue_enter() now.
>>
>> Sure.
>
> Thanks, prematurely already done, as you could tell :-)

The updated version is now commit 900e080752025f00 ("block: move queue
enter logic into blk_mq_submit_bio()") in Linus' tree.

I have bisected failures on m68k/atari (on ARAnyM, using nfhd as the
root device) to this commit, e.g.:

     sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
     sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
     sd 0:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
     sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 08 00 00 00 01 00 00 08 00
     critical target error, dev sda, sector 1 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
     Buffer I/O error on dev sda1, logical block 0, lost sync page write

     EXT4-fs (sda1): I/O error while writing superblock
     sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
     sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
     sd 0:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
     sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 08 00 00 00 01 00 00 08 00
     critical target error, dev sda, sector 1 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
     Buffer I/O error on dev sda1, logical block 0, lost sync page write
     EXT4-fs (sda1): I/O error while writing superblock

This may happen either when mounting the root file system (leading to an
unable to mount root fs panic), or later (leading to a read-only
rootfs).

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

