Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50217 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752192AbdDLGQf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2017 02:16:35 -0400
Subject: Re: [PATCH] remove the mg_disk driver
To: Christoph Hellwig <hch@lst.de>, axboe@fb.com, donari75@gmail.com
References: <20170406112846.31078-1-hch@lst.de>
 <20170412055837.GA20204@lst.de>
Cc: linux-block@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <cb43550a-3608-47b2-638d-c17fc31d8024@suse.de>
Date: Wed, 12 Apr 2017 08:16:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170412055837.GA20204@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/12/2017 07:58 AM, Christoph Hellwig wrote:
> Any comments?  Getting rid of this driver which was never wired up
> at all would help with some of the pending block work..
> 
> On Thu, Apr 06, 2017 at 01:28:46PM +0200, Christoph Hellwig wrote:
>> This drivers was added in 2008, but as far as a I can tell we never had a
>> single platform that actually registered resources for the platform driver.
>>
>> It's also been unmaintained for a long time and apparently has a ATA mode
>> that can be driven using the IDE/libata subsystem.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  Documentation/blockdev/mflash.txt |   84 ---
>>  drivers/block/Kconfig             |   17 -
>>  drivers/block/Makefile            |    1 -
>>  drivers/block/mg_disk.c           | 1110 -------------------------------------
>>  include/linux/mg_disk.h           |   45 --
>>  5 files changed, 1257 deletions(-)
>>  delete mode 100644 Documentation/blockdev/mflash.txt
>>  delete mode 100644 drivers/block/mg_disk.c
>>  delete mode 100644 include/linux/mg_disk.h
>>
Go.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
