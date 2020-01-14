Return-Path: <SRS0=JLuE=3D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B78C33CB1
	for <linux-block@archiver.kernel.org>; Tue, 14 Jan 2020 09:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFE8217BA
	for <linux-block@archiver.kernel.org>; Tue, 14 Jan 2020 09:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/gaxXT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgANJRQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:17:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40169 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725842AbgANJRQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jan 2020 04:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578993435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8EBCXj/eGLlwqN/DCPQsauNTZOGi8UpIemA9DO6Kwow=;
        b=E/gaxXT7DvemEDkij5K2TxOwSWy60VWTcWHqlvDOOsv6kLydnscpBkwpnCWyOwbT3EhYuv
        ItSDxBU+WcOn1DJMKuEa1x92wwQRXDSp8wu4ixPolsvErveVJp1yUz1frMt1JQYL8/A3gA
        d4fv6s3AtRojxmbHuM/SJlFexRKSqcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-nducgHoPO2ilQSImbti2UQ-1; Tue, 14 Jan 2020 04:17:12 -0500
X-MC-Unique: nducgHoPO2ilQSImbti2UQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE708DBF7;
        Tue, 14 Jan 2020 09:17:10 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F3195DA80;
        Tue, 14 Jan 2020 09:17:01 +0000 (UTC)
Date:   Tue, 14 Jan 2020 17:16:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>, Guiyao <guiyao@huawei.com>,
        zhangsaisai <zhangsaisai@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>
Subject: Re: [PATCH V2] brd: check parameter validation before
 register_blkdev func
Message-ID: <20200114091456.GA22268@ming.t460p>
References: <8b32ff09-74aa-3b92-38e4-aab12f47597b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b32ff09-74aa-3b92-38e4-aab12f47597b@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 13, 2020 at 09:43:23PM +0800, Zhiqiang Liu wrote:
> In brd_init func, rd_nr num of brd_device are firstly allocated
> and add in brd_devices, then brd_devices are traversed to add each
> brd_device by calling add_disk func. When allocating brd_device,
> the disk->first_minor is set to i * max_part, if rd_nr * max_part
> is larger than MINORMASK, two different brd_device may have the same
> devt, then only one of them can be successfully added.

It is just because disk->first_minor is >= 0x100000, then same dev_t
can be allocated in blk_alloc_devt().

	MKDEV(disk->major, disk->first_minor + part->partno)

But block layer does support extended dynamic devt allocation, and brd
sets flag of GENHD_FL_EXT_DEVT too.

So I think the correct fix is to fallback to extended dynamic allocation
when running out of consecutive minor space.

How about the following approach?

And of course, ext devt allocation may fail too, but that is another
generic un-solved issue: error handling isn't done for adding disk.

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index a8730cc4db10..9aa7ce7c9abf 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -398,7 +398,16 @@ static struct brd_device *brd_alloc(int i)
 	if (!disk)
 		goto out_free_queue;
 	disk->major		= RAMDISK_MAJOR;
-	disk->first_minor	= i * max_part;
+
+	/*
+	 * Clear .minors when running out of consecutive minor space since
+	 * GENHD_FL_EXT_DEVT is set, and we can allocate from extended devt
+	 */
+	if ((i * disk->minors) & ~MINORMASK)
+		disk->minors = 0;
+	else
+		disk->first_minor	= i * disk->minors;
+
 	disk->fops		= &brd_fops;
 	disk->private_data	= brd;
 	disk->flags		= GENHD_FL_EXT_DEVT;



Thanks, 
Ming

