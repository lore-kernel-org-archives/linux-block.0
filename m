Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F28FC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 07:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259AF20815
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 07:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbeLTH06 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:26:58 -0500
Received: from verein.lst.de ([213.95.11.211]:51360 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbeLTH06 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 02:26:58 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B4E5E68AA6; Thu, 20 Dec 2018 08:26:56 +0100 (CET)
Date:   Thu, 20 Dec 2018 08:26:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     Christoph Hellwig <hch@lst.de>, Boaz Harrosh <ooo@electrozaur.com>,
        axboe@kernel.dk, martin.petersen@oracle.com,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: remove exofs, the T10 OSD code and block/scsi bidi support V3
Message-ID: <20181220072656.GA10011@lst.de>
References: <20181111133211.13926-1-hch@lst.de> <4f4b6aff-6726-c500-e3e4-f8b73d641851@electrozaur.com> <20181219144347.GB23410@lst.de> <0e8b8d45-cfeb-ba9d-c92f-953cabede1ee@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e8b8d45-cfeb-ba9d-c92f-953cabede1ee@interlog.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 19, 2018 at 09:01:53PM -0500, Douglas Gilbert wrote:
>>   1) reduce the size of every kernel with block layer support, and
>>      even more for every kernel with scsi support
>
> By proposing the removal of bidi support from the block layer, it isn't
> just the SCSI subsystem that will be impacted. Those NVMe documents
> that you referred me to earlier in the year, in the command tables
> in 1.3c and earlier you have noticed the 2 bit direction field and
> what 11b means? Even if there aren't any bidi NVMe commands *** yet,
> the fact that NVMe's 64 byte command format has provision for 4
> (not 2) independent data transfers (data + meta, for each direction).
> Surely NVMe will sooner or later take advantage of those ... a
> command like READ GATHERED comes to mind.

NVMe on the other hand does have support for separate read and write
buffers as in the current SCSI bidi support, as it encodes the data
transfers in that SQE.  So IFF NVMe does bidi commands it would have
to use a single buffer for data in/out, which can be easily done
in the block layer without the current bidi support that chains
two struct request instances for data in and data out.

>>   2) reduce the size of the critical struct request structure by
>>      128 bits, thus reducing the memory used by every blk-mq driver
>>      significantly, never mind the cache effects
>
> Hmm, one pointer (that is null in the non-bidi case) should be enough,
> that's 64 or 32 bits.

Due to the way we use request chaining we need two fields at the
moment.  ->special and ->next_rq.  If we'd refactor the whole thing
for the basically non-existent user we could indeed probably get it
down to a single pointer. 

> While on the subject of bidi, the order of transfers: is the data-out
> (to the target) always before the data-in or is it the target device
> that decides (depending on the semantics of the command) who is first?

The way I read SAM data needs to be transferred to the device for
processing first, then the processing occurs and then it is transferred
out, so the order seems fixed.

>
> Doug Gilbert
>
>  *** there could already be vendor specific bidi NVMe commands out
>     there (ditto for SCSI)

For NVMe they'd need to transfer data in and out in the same buffer
to sort work, and even then only if we don't happen to be bounce
buffering using swiotlb, or using a network transport.  Similarly for
SCSI only iSCSI at the moment supports bidi CDBs, so we could have
applications using vendor specific bidi commands on iSCSI, which
is exactly what we're trying to find out, but it is a bit of a very
niche use case.
