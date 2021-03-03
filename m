Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E329AC433E6
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 00:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B820764F42
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 00:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbhCDAuz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:50:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:39946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359034AbhCCRbY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Mar 2021 12:31:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614792635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=egCST0Rney7JPu2RYQem6LVUwo8s+4euh2SRmmo9eVM=;
        b=cAXBQI+qNeBUJXGyjZkZPTVerspuX5S3hVS/whxo5bEk4HcJAyN3wgJbnpW2dLUDu9LQgj
        ISRy6RYv/DgPHpi0wjC0ar/wLUuaJQLi9uCi54CyrTigVAnG+lCsZjiBOUSt671jzp+tAc
        HpERgrxQ6YoHMoNSW9xQWtPPOchiFFM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A546AC24;
        Wed,  3 Mar 2021 17:30:35 +0000 (UTC)
Message-ID: <66a9b7ff4958ab990f58a3dad8152d00c59775ce.camel@suse.com>
Subject: Re: [PATCH] block: Suppress uevent for hidden device when removed
From:   Martin Wilck <mwilck@suse.com>
To:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Date:   Wed, 03 Mar 2021 18:30:34 +0100
In-Reply-To: <20210303171201.8432-1-dwagner@suse.de>
References: <20210303171201.8432-1-dwagner@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2021-03-03 at 18:12 +0100, Daniel Wagner wrote:
> register_disk() suppress uevents for devices with the GENHD_FL_HIDDEN
> but enables uevents at the end again in order to announce disk after
> possible partitions are created.
> 
> When the device is removed the uevents are still on and user land
> sees
> 'remove' messages for devices which were never 'add'ed to the system.
> 
>   KERNEL[95481.571887] remove   /devices/virtual/nvme-
> fabrics/ctl/nvme5/nvme0c5n1 (block)
> 
> Let's suppress the uevents for GENHD_FL_HIDDEN again before calling
> device_del() which will write trigger uevents.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  block/genhd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index c55e8f0fced1..ab9ed355bdef 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -731,6 +731,9 @@ void del_gendisk(struct gendisk *disk)
>         if (!sysfs_deprecated)
>                 sysfs_remove_link(block_depr,
> dev_name(disk_to_dev(disk)));
>         pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
> +
> +       if (disk->flags & GENHD_FL_HIDDEN)
> +               dev_set_uevent_suppress(disk_to_dev(disk), 1);
>         device_del(disk_to_dev(disk));
>  }
>  EXPORT_SYMBOL(del_gendisk);

I wonder if it wouldn't be wiser to remove this code

        if (disk->flags & GENHD_FL_HIDDEN) {
                dev_set_uevent_suppress(ddev, 0);
                return;
        }

from register_disk(). The way you did it now, we would receive neither
"add" nor "remove" events in user space, but there might be change
events in between ?

This said, I'd like to raise the question whether it was the right
decision to suppress these uevents in the first place. 8ddcd653257c
("block: introduce GENHD_FL_HIDDEN") simply stated that they aren't
registered as usable block devices. Maybe the kernel should leave the
decision whether or not they are interesting to user space itself?

For example, I've written an extension for multipath-tools some time
ago which displays the topology of NVMe native multipath devices, and
uses sysfs data from the hidden NVMe private namespaces for that
purpose. Not receiving  uevents for them makes it practically
impossible to track the status of these devices.

Regards,
Martin


