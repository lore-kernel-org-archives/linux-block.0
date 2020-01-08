Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8CCC33C99
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 03:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889902087F
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 03:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jN5/F5XV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgAHDT7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 22:19:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29564 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726146AbgAHDT7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 22:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578453598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wvEBuw7GXT/dhI2u1WBG49AGz4RwHQH9v/2XZP/TBRE=;
        b=jN5/F5XVh0LKoK+c3GgU9LCtsudqaJPi1EMFfqkj4xotyxQlOOOctypwi4+rtbLnFEpwdM
        xuIVImXkY0sMnd4ntq1Wceck3hXA3FX2e1yv7iTuZ0yE+ejpC0E/s46F//0+bUgS0zDSl4
        wo/9xLI2L4SUyj8vDBl7Ohtts56HsNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-BLn_FBXXPTSGiUvJdBs6Qg-1; Tue, 07 Jan 2020 22:19:55 -0500
X-MC-Unique: BLn_FBXXPTSGiUvJdBs6Qg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 756C0801E6C;
        Wed,  8 Jan 2020 03:19:53 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E20A110013A7;
        Wed,  8 Jan 2020 03:19:45 +0000 (UTC)
Date:   Wed, 8 Jan 2020 11:19:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, hch@lst.de, zhengchuan@huawei.com,
        yi.zhang@huawei.com, paulmck@kernel.org, joel@joelfernandes.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] block: make sure last_lookup set as NULL after part
 deleted
Message-ID: <20200108031941.GD28075@ming.t460p>
References: <20200103041805.GA29924@ming.t460p>
 <ea362a86-d2de-7dfe-c826-d59e8b5068c3@huawei.com>
 <20200103081745.GA11275@ming.t460p>
 <82c10514-aec5-0d7c-118f-32c261015c6a@huawei.com>
 <20200103151616.GA23308@ming.t460p>
 <582f8e81-6127-47aa-f7fe-035251052238@huawei.com>
 <20200106081137.GA10487@ming.t460p>
 <747c3856-afa4-0909-dae2-f3b23aa38118@huawei.com>
 <20200106100547.GA15256@ming.t460p>
 <762e1d7b-af3e-93f4-c744-ecd8ae8946e8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <762e1d7b-af3e-93f4-c744-ecd8ae8946e8@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 07, 2020 at 07:40:10PM +0800, Hou Tao wrote:
> Hi,
> 
> On 2020/1/6 18:05, Ming Lei wrote:
> > On Mon, Jan 06, 2020 at 05:41:45PM +0800, Hou Tao wrote:
> >> Hi,
> >>
> [snipped]
> 
> >> Yes. The solution you proposed also adds an invocation of percpu_ref_tryget_live()
> >> in the fast path. Not sure which one will have a better performance. However the
> >> reason we prefer the index caching is the simplicity instead of performance.
> > 
> > No, hd_struct_try_get() and hd_struct_get() is always called once for one IO, the
> > patch I proposed changes nothing about this usage.
> > 
> > Please take a close look at the patch:
> > 
> > https://lore.kernel.org/linux-block/5cc465cc-d68c-088e-0729-2695279c7853@huawei.com/T/#m8f3e6b4e77eadf006ce142a84c966f50f3a9ae26
> > 
> > which just moves hd_struct_try_get() from blk_account_io_start() into
> > disk_map_sector_rcu(), doesn't it?
> > 
> Yes, you are right. And a little suggestion for your patch:
> 
> @@ -283,8 +289,9 @@ void delete_partition(struct gendisk *disk, int partno)
>  	if (!part)
>  		return;
> 
> +	get_device(disk_to_dev(disk));
>  	rcu_assign_pointer(ptbl->part[partno], NULL);
> -	rcu_assign_pointer(ptbl->last_lookup, NULL);
> +
>  	kobject_put(part->holder_dir);
>  	device_del(part_to_dev(part));
> 
> Could we move the call of get_device() into add_partition, and that will make the assignment of
> disk to p->disk in add_partition() be natural ?

It isn't necessary to do that way, the parent disk's refcount isn't released
until device_del(part_to_dev(part)). So it is enough to hold disk's refcount
before calling device_del(part).

> 
> Maybe there is no need to add a new disk field in hd_struct, because the kobject of gendisk
> is already the parent of hd_struct. But make use of part->__dev.parent after the calling
> of device_del() is a bad_idea.

Yeah, that is why I added 'disk' field, which can be put with other
fields not accessed in fast path.

BTW, 'struct percpu_ref ref' should have been put just after 'nr_sects',
then these fast path fields can share single cache line.


Thanks,
Ming

