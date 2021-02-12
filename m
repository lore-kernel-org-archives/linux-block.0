Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C91DC433DB
	for <linux-block@archiver.kernel.org>; Fri, 12 Feb 2021 05:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0357E64E6C
	for <linux-block@archiver.kernel.org>; Fri, 12 Feb 2021 05:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhBLFn0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Feb 2021 00:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhBLFnZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Feb 2021 00:43:25 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75257C061574
        for <linux-block@vger.kernel.org>; Thu, 11 Feb 2021 21:42:45 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id p132so8154008iod.11
        for <linux-block@vger.kernel.org>; Thu, 11 Feb 2021 21:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4lipxPM8WIe2Nq215U51DffXjPHE831yVP7oaiBC0XA=;
        b=qwBx22/gWPOjnG/66+l3hS9O7nnFlq4V5DcSUZFqBTBNnZYi7sSXV0WvNap+javWb4
         8Zext2s6DzjtE3L4PBBPQjpbDgduHkkRLp6j8eU6pQLFkZpj5JInx+QLWnvgHpKBQhap
         s8Lh518R3rQcEDag8RTEFYw523eGuOsAjzy/3DQuywgziV0yfHPYl42Di7TRmK3xIyf0
         /Hm024CCC52xF2wGna74hhlu+Zkfk/dGucL9iuP7+fwl7V2wRIYcYL5HkZrCSdxGY/8e
         he5fkK5865McmCZi/Hn7RUCfOUx/cRF8ySXI8IaZJ3WEUr2jdacmPFN1AiIV3WlAkJh1
         b6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4lipxPM8WIe2Nq215U51DffXjPHE831yVP7oaiBC0XA=;
        b=jLf6FviR4TzJ+vDq4ywYF+qvrrLysMA5HkU+yKQfGA7LR3M2FtUHDRhevlQD66Rvi+
         1dvO8U9KWRNOiNIveBvMhip8p12w2HkrFW1lej8oNxDRKNAmxhaZFlR2QbV2uKhx0xAw
         yfvCuKw8g/d+85eqf4h+ss9LsHLfqGfP6CJQBW8tZ3Dqo/1U7bGMZ/bMrhAGJz4qoSTx
         807MYk6NGIT+r8O4IcPgHsZ91KxgjpHZgAnedIGvSQ83tES7qC2uDJguVrxq07nf/aug
         C475VRDjuHJwp/3ZgyeTskvEeur2GTIPfwlOiS5BZg7fcesbbola3H6l60zY7/LeUREA
         T4Gw==
X-Gm-Message-State: AOAM532gQZjWLtL4Ya8jwcZsqxeagOK30S7Ds9zKsq5Lts8mjvu/AANw
        fieOKSvB7oISug5Qu3dIyu0+70u3TIcRczmdiOkv+6yL6ODF8AqI
X-Google-Smtp-Source: ABdhPJxct8kksahwahA3irB1+dOWbieb1u/QIjKgq6qVBs8ib8BBMYpH2a2CK8lWomYUbesP15dYMdKPKsqUgyb3c7o=
X-Received: by 2002:a02:856d:: with SMTP id g100mr1221375jai.10.1613108564622;
 Thu, 11 Feb 2021 21:42:44 -0800 (PST)
MIME-Version: 1.0
From:   Tom Seewald <tseewald@gmail.com>
Date:   Thu, 11 Feb 2021 23:42:33 -0600
Message-ID: <CAARYdbiUBxFTY25VusuxgxqVzNRnoB61fFQeXcmsKyDP_d_ipQ@mail.gmail.com>
Subject: [Regression] [Bisected] Errors when ejecting USB storage drives since v5.10
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        tseewald <tseewald@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Since v5.10 ejecting removable USB devices on my desktop has resulted
in the kernel throwing errors and not cleanly unmounting the drives
(dirty bit is set upon remounting).

I have bisected this issue to commit 471bd0af544b ("sd: use
bdev_check_media_change"), and have confirmed the problem is still
present as of v5.11-rc7. It appears that several others have run into
this issue, as I see that there was a bugzilla report filed a month
ago [1]. There was also a bug report filed against udisks [2], and it
looks like they believe it is also a kernel issue.

Steps to reproduce the problem:
1. Insert removable USB storage device.
2. Use eject(1) to attempt to eject the USB device. (e.g. # eject /dev/sdd)

Example result:
[42006.656393] sd 8:0:0:1: [sdd] tag#0 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE cmd_age=0s
[42006.656402] sd 8:0:0:1: [sdd] tag#0 Sense Key : Not Ready [current]
[42006.656406] sd 8:0:0:1: [sdd] tag#0 Add. Sense: Medium not present
[42006.656411] sd 8:0:0:1: [sdd] tag#0 CDB: Read(10) 28 00 00 00 00 00
00 00 08 00
[42006.656413] blk_update_request: I/O error, dev sdd, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[42006.656420] Buffer I/O error on dev sdd, logical block 0, async page read
[42006.657520] sd 8:0:0:1: [sdd] tag#0 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE cmd_age=0s
[42006.657528] sd 8:0:0:1: [sdd] tag#0 Sense Key : Not Ready [current]
[42006.657531] sd 8:0:0:1: [sdd] tag#0 Add. Sense: Medium not present
[42006.657535] sd 8:0:0:1: [sdd] tag#0 CDB: Read(10) 28 00 00 00 00 00
00 00 08 00
[42006.657537] blk_update_request: I/O error, dev sdd, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[42006.657544] Buffer I/O error on dev sdd, logical block 0, async page read
[42006.658490] sd 8:0:0:1: [sdd] tag#0 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE cmd_age=0s
[42006.658492] sd 8:0:0:1: [sdd] tag#0 Sense Key : Not Ready [current]
[42006.658494] sd 8:0:0:1: [sdd] tag#0 Add. Sense: Medium not present
[42006.658496] sd 8:0:0:1: [sdd] tag#0 CDB: Read(10) 28 00 00 00 00 00
00 00 08 00
[42006.658497] blk_update_request: I/O error, dev sdd, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[42006.658499] Buffer I/O error on dev sdd, logical block 0, async page read
[42006.658505] ldm_validate_partition_table(): Disk read failed.
[42006.659490] sd 8:0:0:1: [sdd] tag#0 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE cmd_age=0s
[42006.659492] sd 8:0:0:1: [sdd] tag#0 Sense Key : Not Ready [current]
[42006.659494] sd 8:0:0:1: [sdd] tag#0 Add. Sense: Medium not present
[42006.659496] sd 8:0:0:1: [sdd] tag#0 CDB: Read(10) 28 00 00 00 00 00
00 00 08 00
[42006.659497] blk_update_request: I/O error, dev sdd, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[42006.659499] Buffer I/O error on dev sdd, logical block 0, async page read
[42006.661000] sd 8:0:0:1: [sdd] tag#0 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE cmd_age=0s
[42006.661003] sd 8:0:0:1: [sdd] tag#0 Sense Key : Not Ready [current]
[42006.661005] sd 8:0:0:1: [sdd] tag#0 Add. Sense: Medium not present
[42006.661006] sd 8:0:0:1: [sdd] tag#0 CDB: Read(10) 28 00 00 00 00 00
00 00 08 00
[42006.661007] blk_update_request: I/O error, dev sdd, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[42006.661010] Buffer I/O error on dev sdd, logical block 0, async page read
[42006.662002] sd 8:0:0:1: [sdd] tag#0 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE cmd_age=0s
[42006.662006] sd 8:0:0:1: [sdd] tag#0 Sense Key : Not Ready [current]
[42006.662007] sd 8:0:0:1: [sdd] tag#0 Add. Sense: Medium not present
[42006.662009] sd 8:0:0:1: [sdd] tag#0 CDB: Read(10) 28 00 00 00 00 00
00 00 08 00
[42006.662010] blk_update_request: I/O error, dev sdd, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[42006.662013] Buffer I/O error on dev sdd, logical block 0, async page read
[42006.663050] sd 8:0:0:1: [sdd] tag#0 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE cmd_age=0s
[42006.663053] sd 8:0:0:1: [sdd] tag#0 Sense Key : Not Ready [current]
[42006.663054] sd 8:0:0:1: [sdd] tag#0 Add. Sense: Medium not present
[42006.663055] sd 8:0:0:1: [sdd] tag#0 CDB: Read(10) 28 00 00 00 00 00
00 00 08 00
[42006.663056] blk_update_request: I/O error, dev sdd, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[42006.663059] Buffer I/O error on dev sdd, logical block 0, async page read
[42006.663068] Dev sdd: unable to read RDB block 0
[42006.663993] sd 8:0:0:1: [sdd] tag#0 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE cmd_age=0s
[42006.663995] sd 8:0:0:1: [sdd] tag#0 Sense Key : Not Ready [current]
[42006.663997] sd 8:0:0:1: [sdd] tag#0 Add. Sense: Medium not present
[42006.663998] sd 8:0:0:1: [sdd] tag#0 CDB: Read(10) 28 00 00 00 00 00
00 00 08 00
[42006.663999] blk_update_request: I/O error, dev sdd, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[42006.664001] Buffer I/O error on dev sdd, logical block 0, async page read
[42006.665000] sd 8:0:0:1: [sdd] tag#0 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE cmd_age=0s
[42006.665003] sd 8:0:0:1: [sdd] tag#0 Sense Key : Not Ready [current]
[42006.665004] sd 8:0:0:1: [sdd] tag#0 Add. Sense: Medium not present
[42006.665006] sd 8:0:0:1: [sdd] tag#0 CDB: Read(10) 28 00 00 00 00 00
00 00 08 00
[42006.665007] blk_update_request: I/O error, dev sdd, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[42006.665009] Buffer I/O error on dev sdd, logical block 0, async page read
[42006.665019]  sdd: unable to read partition table
[42006.668496] sdd: detected capacity change from 0 to 62333952

Please cc me on replies as I am not subscribed to the block mailing list.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=211023
[2] https://github.com/storaged-project/udisks/issues/827
