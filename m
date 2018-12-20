Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B0EC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 02:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B324620866
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 02:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeLTCKk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 21:10:40 -0500
Received: from smtp.infotech.no ([82.134.31.41]:45366 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbeLTCKj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 21:10:39 -0500
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2018 21:10:39 EST
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 3FF572041CB;
        Thu, 20 Dec 2018 03:02:01 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HUyAj3W25Fm7; Thu, 20 Dec 2018 03:01:55 +0100 (CET)
Received: from [192.168.48.23] (host-184-164-16-103.dyn.295.ca [184.164.16.103])
        by smtp.infotech.no (Postfix) with ESMTPA id 2E345204187;
        Thu, 20 Dec 2018 03:01:53 +0100 (CET)
Reply-To: dgilbert@interlog.com
Subject: Re: remove exofs, the T10 OSD code and block/scsi bidi support V3
To:     Christoph Hellwig <hch@lst.de>, Boaz Harrosh <ooo@electrozaur.com>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181111133211.13926-1-hch@lst.de>
 <4f4b6aff-6726-c500-e3e4-f8b73d641851@electrozaur.com>
 <20181219144347.GB23410@lst.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <0e8b8d45-cfeb-ba9d-c92f-953cabede1ee@interlog.com>
Date:   Wed, 19 Dec 2018 21:01:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219144347.GB23410@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2018-12-19 9:43 a.m., Christoph Hellwig wrote:
> On Mon, Nov 26, 2018 at 07:11:10PM +0200, Boaz Harrosh wrote:
>> On 11/11/18 15:32, Christoph Hellwig wrote:
>>> The only real user of the T10 OSD protocol, the pNFS object layout
>>> driver never went to the point of having shipping products, and we
>>> removed it 1.5 years ago.  Exofs is just a simple example without
>>> real life users.
>>>
>>
>> You have failed to say what is your motivation for this patchset? What
>> is it you are trying to fix/improve.
> 
> Drop basically unused support, which allows us to
> 
>   1) reduce the size of every kernel with block layer support, and
>      even more for every kernel with scsi support

By proposing the removal of bidi support from the block layer, it isn't
just the SCSI subsystem that will be impacted. Those NVMe documents
that you referred me to earlier in the year, in the command tables
in 1.3c and earlier you have noticed the 2 bit direction field and
what 11b means? Even if there aren't any bidi NVMe commands *** yet,
the fact that NVMe's 64 byte command format has provision for 4
(not 2) independent data transfers (data + meta, for each direction).
Surely NVMe will sooner or later take advantage of those ... a
command like READ GATHERED comes to mind.

>   2) reduce the size of the critical struct request structure by
>      128 bits, thus reducing the memory used by every blk-mq driver
>      significantly, never mind the cache effects

Hmm, one pointer (that is null in the non-bidi case) should be enough,
that's 64 or 32 bits.

>   3) stop having the maintainance overhead for this code in the
>      block layer, which has been rather painful at times

You won't get any sympathy from me :-) The sg driver is trying to
inject _SCSI_ commands into the SCSI mid-level for onward processing
by SCSI LLDs. So WTF does it have to deal with the block layer.


While on the subject of bidi, the order of transfers: is the data-out
(to the target) always before the data-in or is it the target device
that decides (depending on the semantics of the command) who is first?

Doug Gilbert

  *** there could already be vendor specific bidi NVMe commands out
     there (ditto for SCSI)
