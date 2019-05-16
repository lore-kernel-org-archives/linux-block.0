Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BE5C04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 12:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F247220848
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 12:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfEPMdY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 08:33:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:47090 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbfEPMdY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 08:33:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 46D69AD57;
        Thu, 16 May 2019 12:33:23 +0000 (UTC)
Subject: Re: Block device naming
To:     Alibek Amaev <alibek.a@gmail.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <CA+TYKz1o=uOn0m3tPGqmNZtw7mGdZ7_BGX0C0RH9f3wnFDpO6Q@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e81e675e-e084-197a-fc13-101985bde590@suse.de>
Date:   Thu, 16 May 2019 14:33:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+TYKz1o=uOn0m3tPGqmNZtw7mGdZ7_BGX0C0RH9f3wnFDpO6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/19 2:26 PM, Alibek Amaev wrote:
> Hi!
> 
> I want to address the following problem:
> On the system with hot-attached new storage volume, such as FC-switch
> update configuration for connected FC-HBA on servers, linux kernel
> reorder block devices and change names of block devices. Becouse
> scsi-id, wwn-id and other is a symbol links to block device names than
> on change block device name change path to device.
> This causes the server to stop working.
> 
> For example, on server present ZFS pool with attached device by scsi-id
> # zpool status
>    pool: pool
>   state: ONLINE
>    scan: scrub repaired 0 in 1h39m with 0 errors on Sun Oct  8 02:03:34 2017
> config:
> 
>      NAME                                      STATE     READ WRITE CKSUM
>      pool                                      ONLINE       0     0     0
>        scsi-3600144f0c7a5bc61000058d3b96d001d  ONLINE       0     0     0
> 
> Before export new block device from storage to hba, scsi-id have next
> path to device:
> /dev/disk/by-id/scsi-3600144f0c7a5bc61000058d3b96d001d -> ../../sdd
> 
> When added new block device by FC-switch, FC-HBA kernel change block
> device names:
> /dev/disk/by-id/scsi-3600144f0c7a5bc61000058d3b96d001d -> ../../sdf
> 
> and ZFS can't access to device until reboot (partprobe, zpool online
> -e pool scsi-3600144f0c7a5bc61000058d3b96d001d - may help or may not
> help)
> 
Hmm. That really is curious; typically existing devices will not be 
reassigned. Especially not if they are in use by something.
And the FC layer is going into quite some lengths to prevent this from 
happening.
So this really looks more like an issue with how exactly this 'adding 
new block device' step was done.

> Is there any way to fix or change this behavior of the kernel?
> 
As I said, this typically does not happen.
It would need closer examination to figure out what really happened.

> It may be more reasonable to immediately assign an unique persistent
> identifier of device and linking other identifiers with it?
> 
Which is what we try ...

> Also I think this is not specific problem of ZFS. And can occur with other
> file system modules.Moreover, I had previously encountered a similar
> problem - NetAPP
> storage attached to servers by FC and export multiple LUN - suddenly
> decided to change the order of LUNs and Ext4 on servers is switch to
> readonly mode because driver detect changes of magic number in
> superblocks of partitions.
> 
Suddently changing the order of LUNs is _not_ what is supposed to 
happen. This really sounds more like an issue with NetApp.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
