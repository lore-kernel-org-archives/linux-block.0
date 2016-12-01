Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:8052 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbcLADnS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2016 22:43:18 -0500
Subject: Re: [PATCH v2] block: Check partition alignment on zoned block
 devices
To: Jens Axboe <axboe@kernel.dk>
References: <1480551735-9288-1-git-send-email-damien.lemoal@wdc.com>
 <08af33a8-8705-788f-3b7e-e88eccbc71e4@kernel.dk>
 <778a9799-fed0-3337-e186-2a761cafa0aa@wdc.com>
 <3d13eadc-f7f7-3598-f4eb-880c5564301f@kernel.dk>
Cc: linux-block@vger.kernel.org, Shaun Tancheff <shaun@tancheff.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <44f7d36a-3212-4f2b-2031-d601efdc06c3@wdc.com>
Date: Thu, 1 Dec 2016 12:42:52 +0900
MIME-Version: 1.0
In-Reply-To: <3d13eadc-f7f7-3598-f4eb-880c5564301f@kernel.dk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Jens,

On 12/1/16 12:03, Jens Axboe wrote:
>> Martin, Shaun and myself agreed on the restriction. All ZBC/ZAC disks on
>> the market today match these so there are no problems. And it is
>> unlikely that we will ever see weirdly sized SMR drives (customers
>> generally do not want that).
> 
> I'm fine with that, my only concern is that part_zone_aligned() assumes
> this, and it's a bit fragile. If we remove the power-of-2 restriction.
> Not sure what the best way to fix it is. Ideally it'd have a
> WARN_ON_ONCE() and a fallback to a modulo calculation instead of the
> AND.

I can have a crack at it. Should I resubmit a new version ?

-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
