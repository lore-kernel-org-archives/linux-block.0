Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB0CC433B4
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 02:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3EAC60C40
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 02:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhDBCim (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Apr 2021 22:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233665AbhDBCil (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Apr 2021 22:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617331121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nov4TthvaPKXWEDlyg35jkHCWgK4XpWD0U3xOpZhgMA=;
        b=QIsEW+VEPV0ZzSlasf6NR5B/gFLbTOe7nQ+at49UX3cYOA/3s3JFLFQMjlWgOWwziDjR4G
        fyV1vSmdFwqCiI/ks8xNPscc8+t8LewWldLNokSP5Sajnz0ICvchaDNPfouPCtsxYklIWl
        fAcGF5NPLKZT3SorcVLh6wVb18D0MjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-_huYUYkPOL6rm_C4AqKzsA-1; Thu, 01 Apr 2021 22:38:39 -0400
X-MC-Unique: _huYUYkPOL6rm_C4AqKzsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A621F501F8;
        Fri,  2 Apr 2021 02:38:37 +0000 (UTC)
Received: from T590 (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AB4719C46;
        Fri,  2 Apr 2021 02:38:29 +0000 (UTC)
Date:   Fri, 2 Apr 2021 10:38:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Gulam Mohamed <gulam.mohamed@oracle.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: Race condition in Kernel
Message-ID: <YGaDoIJHHe90+Jd5@T590>
References: <CO1PR10MB4563A6404AD789EEF93F995798639@CO1PR10MB4563.namprd10.prod.outlook.com>
 <YFvrZUzmdLpj7E4F@T590>
 <CO1PR10MB4563673A20326DF5170CF60F987B9@CO1PR10MB4563.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR10MB4563673A20326DF5170CF60F987B9@CO1PR10MB4563.namprd10.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 01, 2021 at 04:27:37PM +0000, Gulam Mohamed wrote:
> Hi Ming,
> 
>       Thanks for taking a look into this. Can you please see my inline comments in below mail?
> 
> Regards,
> Gulam Mohamed.
> 
> -----Original Message-----
> From: Ming Lei <ming.lei@redhat.com> 
> Sent: Thursday, March 25, 2021 7:16 AM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>
> Cc: hch@infradead.org; linux-kernel@vger.kernel.org; linux-block@vger.kernel.org; Junxiao Bi <junxiao.bi@oracle.com>; Martin Petersen <martin.petersen@oracle.com>; axboe@kernel.dk
> Subject: Re: Race condition in Kernel
> 
> On Wed, Mar 24, 2021 at 12:37:03PM +0000, Gulam Mohamed wrote:
> > Hi All,
> > 
> > We are facing a stale link (of the device) issue during the iscsi-logout process if we use parted command just before the iscsi logout. Here are the details:
> > 	 	 
> > As part of iscsi logout, the partitions and the disk will be removed. The parted command, used to list the partitions, will open the disk in RW mode which results in systemd-udevd re-reading the partitions. This will trigger the rescan partitions which will also delete and re-add the partitions. So, both iscsi logout processing and the parted (through systemd-udevd) will be involved in add/delete of partitions. In our case, the following sequence of operations happened (the iscsi device is /dev/sdb with partition sdb1):
> > 	
> > 	1. sdb1 was removed by PARTED
> > 	2. kworker, as part of iscsi logout, couldn't remove sdb1 as it was already removed by PARTED
> > 	3. sdb1 was added by parted
> 
> After kworker is started for logout, I guess all IOs are supposed to be failed at that time, so just wondering why 'sdb1' is still added by parted(systemd-udev)? 
> ioctl(BLKRRPART) needs to read partition table for adding back partitions, if IOs are failed by iscsi logout, I guess the issue can be avoided too?
> 
> [GULAM]: Yes, the ioctl(BLKRRPART) reads the partition table for adding back the partitions. I kept a printk in the code just after the partition table is read. Noticed that the partition table was read before the iscsi-logout kworker started the logout processing.

OK, I guess I understood your issue now, what you want is to not allow
to add partitions since step 1, so can you remove disk just at the
beginning of 2) if it is possible? then step 1) isn't needed any more

For your issue, my patch of 'not drop partitions if partition table
isn't changed' can't fix your issue completely since new real partition
still may come from parted during the series.


Thanks,
Ming

