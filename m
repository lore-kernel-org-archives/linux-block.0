Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0729C18E5B
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 08:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F146206F8
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 08:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgCYIwj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:52:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:35304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbgCYIwj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 04:52:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 18AC2B11F;
        Wed, 25 Mar 2020 08:52:37 +0000 (UTC)
Subject: Re: [RFC PATCH v2 3/3] dm zoned: add regular device info to metadata
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bob Liu <bob.liu@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
References: <20200324110255.8385-1-bob.liu@oracle.com>
 <20200324110255.8385-4-bob.liu@oracle.com>
 <CO2PR04MB23438E0AB35CC46732F96085E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
 <812da9e9-cfd2-ea24-60cb-4af48f476079@suse.de>
 <CO2PR04MB23439B5FA88275A80D3449DFE7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0bd2daa1-abbf-681d-405c-f7e4aecd577c@suse.de>
Date:   Wed, 25 Mar 2020 09:52:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CO2PR04MB23439B5FA88275A80D3449DFE7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/20 9:02 AM, Damien Le Moal wrote:
> On 2020/03/25 15:47, Hannes Reinecke wrote:
>> On 3/25/20 7:29 AM, Damien Le Moal wrote:
>>> On 2020/03/24 20:04, Bob Liu wrote:
>>>> This patch implemented metadata support for regular device by:
>>>>    - Emulated zone information for regular device.
>>>>    - Store metadata at the beginning of regular device.
>>>>
>>>>        | --- zoned device --- | -- regular device ||
>>>>        ^                      ^
>>>>        |                      |Metadata
>>>> zone 0
>>>>
>>>> Signed-off-by: Bob Liu <bob.liu@oracle.com>
>>>> ---
>>>>    drivers/md/dm-zoned-metadata.c | 135 +++++++++++++++++++++++++++++++----------
>>>>    drivers/md/dm-zoned-target.c   |   6 +-
>>>>    drivers/md/dm-zoned.h          |   3 +-
>>>>    3 files changed, 108 insertions(+), 36 deletions(-)
>>>>
>> Having thought about it some more, I think we cannot continue with this
>> 'simple' approach.
>> The immediate problem is that we lie about the disk size; clearly the
>> metadata cannot be used for regular data, yet we expose a target device
>> with the full size of the underlying device.
>> Making me wonder if anybody ever tested a disk-full scenario...
> 
> Current dm-zoned does not do that... What is exposed as target capacity is
> number of chunks * zone size, with the number of chunks being number of zones
> minus metadata zones minus number of zones reserved for reclaim. And I did test
> disk full scenario (when performance goes to the trash bin because reclaim
> struggles...)
> 
Thing is, the second number for the dmsetup target line is _supposed_ to 
be the target size.
Which clearly is wrong here.
I must admit I'm not sure what device-mapper will do with a target 
definition which is larger than the resulting target device ...
Mike should know, but it's definitely awkward.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
