Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2D9C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 18:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B27E218D9
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 18:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388734AbeLTSTu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:19:50 -0500
Received: from smtp.infotech.no ([82.134.31.41]:48660 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbeLTSTu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 13:19:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 96B87204191;
        Thu, 20 Dec 2018 19:19:48 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dCLIx0k7T2Xx; Thu, 20 Dec 2018 19:19:42 +0100 (CET)
Received: from [192.168.48.23] (host-184-164-16-103.dyn.295.ca [184.164.16.103])
        by smtp.infotech.no (Postfix) with ESMTPA id 310B820418E;
        Thu, 20 Dec 2018 19:19:41 +0100 (CET)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH] bsg: deprecate BIDI support in bsg
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20181219143934.3910-1-hch@lst.de>
 <c1bffb86-9b3d-d8c2-98a3-480364f21346@kernel.dk>
 <20181220071254.GB9895@lst.de>
 <b9d89b97-9f9d-b586-ff89-61bafaecd5cc@kernel.dk>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <43c65430-2dbe-9063-3dd4-4941751c323e@interlog.com>
Date:   Thu, 20 Dec 2018 13:19:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b9d89b97-9f9d-b586-ff89-61bafaecd5cc@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2018-12-20 12:09 p.m., Jens Axboe wrote:
> On 12/20/18 12:12 AM, Christoph Hellwig wrote:
>> On Wed, Dec 19, 2018 at 04:23:14PM -0700, Jens Axboe wrote:
>>> On 12/19/18 7:39 AM, Christoph Hellwig wrote:
>>>> Besides the OSD command set that never got traction, the only SCSI
>>>> command using bidirectional buffers is XDWRITEREAD in the 10 and 32
>>>> byte variants, which is extremely esoteric.  It probably doesn't make
>>>> sense to keep the support code around just for that, so start
>>>> deprecating the support.
>>>
>>> Acked-by: Jens Axboe <axboe@kernel.dk>
>>
>> You are the bsg maintainer, so I expected you to pick it up :)
> 
> OK - did you to amend the commit message to reflect the death of
> XDWRITEREAD as well?
> 
It was made obsolete in _draft_ sbc4r15.pdf according to my notes.

It is not "dead", not until SBC-4 is ratified. Until then, SBC-3 is the
current SCSI "block" device standard and it is there as a non-mandatory
command.

Doug Gilbert

