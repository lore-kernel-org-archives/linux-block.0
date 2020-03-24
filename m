Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE3FC4332B
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 11:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C10820870
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 11:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCXLxE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:53:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:56384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbgCXLxE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 07:53:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CEC64AD5D;
        Tue, 24 Mar 2020 11:53:02 +0000 (UTC)
Subject: Re: [RFC PATCH v2 0/3] dm zoned: extend the way of exposing zoned
 block device
To:     Bob Liu <bob.liu@oracle.com>, dm-devel@redhat.com
Cc:     Damien.LeMoal@wdc.com, linux-block@vger.kernel.org,
        Dmitry.Fomichev@wdc.com
References: <20200324110255.8385-1-bob.liu@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e2bef18e-f363-47c4-dd38-971a60ec1eca@suse.de>
Date:   Tue, 24 Mar 2020 12:52:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324110255.8385-1-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/20 12:02 PM, Bob Liu wrote:
> Motivation:
> dm-zoned exposes a zoned block device(ZBC) as a regular block device by storing
> metadata and buffering random writes in its conventional zones.
> This way is not flexible, there must be enough conventional zones and the
> performance may be constrained.
> 
> This patchset split the metadata from zoned device to an extra regular device,
> with aim to increase the flexibility and potential performance.
> For example, now we can store metadata in a faster device like persistent memory.
> Also random writes can go to the regular devices in this version.
> 
> Usage(will send user space patches later):
>> dmzadm --format $zoned_dev --regular=$regu_dev --force
>> echo "0 $size zoned $regu_dev $zoned_dev" | dmsetup create $dm-zoned-name
> 
> v2:
>   * emulate regular device zone info
>   * support write both metadata and random writes to regular dev
> 
> Bob Liu (3):
>    dm zoned: rename dev name to zoned_dev
>    dm zoned: introduce regular device to dm-zoned-target
>    dm zoned: add regular device info to metadata
> 
>   drivers/md/dm-zoned-metadata.c | 205 +++++++++++++++++++++++++++--------------
>   drivers/md/dm-zoned-target.c   | 205 +++++++++++++++++++++++------------------
>   drivers/md/dm-zoned.h          |  53 ++++++++++-
>   3 files changed, 299 insertions(+), 164 deletions(-)
> 
Well, surprise, surprise, both our patchsets are largely identical ...

So how to proceed? I guess if you were using 'cdev' instead of 
'regu_dm_dev' we should be having an overlap of about 90 percent.

The main difference between our implementation is that I didn't move the 
metadata to the cache/regulard device, seeing that dmzadm will only 
write metadata onto the zoned device.
I would rather keep it that way (ie storing metadata on the zoned 
device, too, if possible) as we would be keeping backwards compability 
with that.
And we could always move metadata to the cache/regular device in a later 
patch; for doing it properly we'll need to update the metadata anyway as 
we need to introduce UUIDs to stitch those devices together.
Remember, one my have more than one zoned device and regular device...

Should I try to merge both patchsets and send them out as an RFC?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
