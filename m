Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA8FC1975A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 06:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41474206F8
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 06:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgCYGre (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 02:47:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:44416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgCYGre (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 02:47:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6ABDFABC2;
        Wed, 25 Mar 2020 06:47:33 +0000 (UTC)
Subject: Re: [RFC PATCH v2 3/3] dm zoned: add regular device info to metadata
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bob Liu <bob.liu@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
References: <20200324110255.8385-1-bob.liu@oracle.com>
 <20200324110255.8385-4-bob.liu@oracle.com>
 <CO2PR04MB23438E0AB35CC46732F96085E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <812da9e9-cfd2-ea24-60cb-4af48f476079@suse.de>
Date:   Wed, 25 Mar 2020 07:47:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CO2PR04MB23438E0AB35CC46732F96085E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/20 7:29 AM, Damien Le Moal wrote:
> On 2020/03/24 20:04, Bob Liu wrote:
>> This patch implemented metadata support for regular device by:
>>   - Emulated zone information for regular device.
>>   - Store metadata at the beginning of regular device.
>>
>>       | --- zoned device --- | -- regular device ||
>>       ^                      ^
>>       |                      |Metadata
>> zone 0
>>
>> Signed-off-by: Bob Liu <bob.liu@oracle.com>
>> ---
>>   drivers/md/dm-zoned-metadata.c | 135 +++++++++++++++++++++++++++++++----------
>>   drivers/md/dm-zoned-target.c   |   6 +-
>>   drivers/md/dm-zoned.h          |   3 +-
>>   3 files changed, 108 insertions(+), 36 deletions(-)
>>
Having thought about it some more, I think we cannot continue with this 
'simple' approach.
The immediate problem is that we lie about the disk size; clearly the
metadata cannot be used for regular data, yet we expose a target device 
with the full size of the underlying device.
Making me wonder if anybody ever tested a disk-full scenario...
The other problem is that with two devices we need to be able to stitch 
them together in an automated fashion, eg via a systemd service or udev 
rule.
But for this we need to be able to identify the devices, which means 
both need to carry metadata, and both need to have unique identifier 
within the metadata. Which the current metadata doesn't allow to.

Hence my plan is to implement a v2 metadata, carrying UUIDs for the dmz 
set _and_ the component device. With that we can update blkid to create 
links etc so that the devices can be identified in the system.
Additionally I would be updating dmzadm to write the new metadata.

And I will add a new command 'start' to dmzadm which will then create 
the device-mapper device _with the correct size_. It also has the 
benefit that we can create the device-mapper target with the UUID 
specified in the metadata, so the persistent device links will be 
created automatically.

Bob, can you send me your improvements to dmzadm so that I can include 
them in my changes?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
