Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51A2C433C1
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 00:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD1E61A12
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 00:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239388AbhCYAhc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 20:37:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239386AbhCYAhT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 20:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616632638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GRfuu7xpZ85/H49Tpuw4jfovznEhXIxKCB64SyS/4Ro=;
        b=IktNTFxgQDzEpk0HNdXu+vwVMxpDBsOWP8mpgbvzyVbaXNzV7bRBi+pc9vGsjGGeOYHDyy
        Eb2bgBmq0pwTA6nMYPFuTUZhch+CY1z976hm8bHDmBZbU0vURQrVlWdl1SkhR004slz5Sv
        CpY2xL44pQ+LlZ/dgtALSc8DWvlUaPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-oBwuWkYnP_eRPn3j4L8KIA-1; Wed, 24 Mar 2021 20:37:16 -0400
X-MC-Unique: oBwuWkYnP_eRPn3j4L8KIA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB48B80006E;
        Thu, 25 Mar 2021 00:37:15 +0000 (UTC)
Received: from T590 (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3044D19C71;
        Thu, 25 Mar 2021 00:37:08 +0000 (UTC)
Date:   Thu, 25 Mar 2021 08:37:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Gulam Mohamed <gulam.mohamed@oracle.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: Race condition in Kernel
Message-ID: <YFvbMERoGwJPFGFu@T590>
References: <CO1PR10MB4563A6404AD789EEF93F995798639@CO1PR10MB4563.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR10MB4563A6404AD789EEF93F995798639@CO1PR10MB4563.namprd10.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 24, 2021 at 12:37:03PM +0000, Gulam Mohamed wrote:
> Hi All,
> 
> We are facing a stale link (of the device) issue during the iscsi-logout process if we use parted command just before the iscsi logout. Here are the details:
> 	 	 
> As part of iscsi logout, the partitions and the disk will be removed. The parted command, used to list the partitions, will open the disk in RW mode which results in systemd-udevd re-reading the partitions. This will trigger the rescan partitions which will also delete and re-add the partitions. So, both iscsi logout processing and the parted (through systemd-udevd) will be involved in add/delete of partitions. In our case, the following sequence of operations happened (the iscsi device is /dev/sdb with partition sdb1):
> 	
> 	1. sdb1 was removed by PARTED
> 	2. kworker, as part of iscsi logout, couldn't remove sdb1 as it was already removed by PARTED
> 	3. sdb1 was added by parted
> 	4. sdb was NOW removed as part of iscsi logout (the last part of the device removal after remoing the partitions)
> 
> Since the symlink /sys/class/block/sdb1 points to /sys/class/devices/platform/hostx/sessionx/targetx:x:x:x/x:x:x:x/block/sdb/sdb1 and since sdb is already removed, the symlink /sys/class/block/sdb1 will be orphan and stale. So, this stale link is a result of the race condition in kernel between the systemd-udevd and iscsi-logout processing as described above. We are able to reproduce this even with latest upstream kernel.
> 	
> We have come across a patch from Ming Lei which was created for "avoid to drop & re-add partitions if partitions aren't changed":
> https://lore.kernel.org/linux-block/20210216084430.GA23694@lst.de/T/

BTW,  there is a newer version of this patchset:

https://lore.kernel.org/linux-block/20210224081825.GA1339@lst.de/#r

> 	
> This patch could resolve our problem of stale link but it just seems to be a work-around and not the actual fix for the race. We were looking for help to fix this race in kernel. Do you have any idea how to fix this race condition?
>

IMO, that isn't a work-around, kernel shouldn't drop partitions if
partition table isn't changed. But Christoph thought the current approach
is taken since beginning of kernel, and he suggested to fix systemd-udev.



Thanks, 
Ming

