Return-Path: <SRS0=vwZl=3Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D85C2D0B1
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 08:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575AF2087E
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 08:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuAABrbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgBDIwg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:52:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20448 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726053AbgBDIwg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Feb 2020 03:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580806354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDDftAtPJN7YLmiKkApk/wNe+ULS/HSMN+9U0StbKz4=;
        b=RuAABrbQZIo0i6eNctSfXSahbKX6zZbXfopqnw5rehnvPkxUVZvaZlM90l7Dho3BU3aRZm
        XEM9nP+9/2GWKZqhbNpqy4Fdi+hCSs8oaptjzBHHKHzB3wMhtXrvAHIWumyqxdyQaV+7Fg
        EWcnPKOKB/9wcy/AUZymiX3diUV+ii0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-NJboiqNtOkaW0opL38iU4A-1; Tue, 04 Feb 2020 03:52:31 -0500
X-MC-Unique: NJboiqNtOkaW0opL38iU4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C79E13E6;
        Tue,  4 Feb 2020 08:52:29 +0000 (UTC)
Received: from ming.t460p (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 108B989F01;
        Tue,  4 Feb 2020 08:52:22 +0000 (UTC)
Date:   Tue, 4 Feb 2020 16:52:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingfangsen <mingfangsen@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>, Guiyao <guiyao@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>
Subject: Re: [PATCH V5] brd: check and limit max_part par
Message-ID: <20200204085218.GA19922@ming.t460p>
References: <3f053491-d8c1-7092-58d1-85afaa2e68df@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f053491-d8c1-7092-58d1-85afaa2e68df@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 04, 2020 at 10:44:18AM +0800, Zhiqiang Liu wrote:
> 
> In brd_init func, rd_nr num of brd_device are firstly allocated
> and add in brd_devices, then brd_devices are traversed to add each
> brd_device by calling add_disk func. When allocating brd_device,
> the disk->first_minor is set to i * max_part, if rd_nr * max_part
> is larger than MINORMASK, two different brd_device may have the same
> devt, then only one of them can be successfully added.
> when rmmod brd.ko, it will cause oops when calling brd_exit.
> 
> Follow those steps:
>   # modprobe brd rd_nr=3 rd_size=102400 max_part=1048576
>   # rmmod brd
> then, the oops will appear.
> 
> Oops log:
> [  726.613722] Call trace:
> [  726.614175]  kernfs_find_ns+0x24/0x130
> [  726.614852]  kernfs_find_and_get_ns+0x44/0x68
> [  726.615749]  sysfs_remove_group+0x38/0xb0
> [  726.616520]  blk_trace_remove_sysfs+0x1c/0x28
> [  726.617320]  blk_unregister_queue+0x98/0x100
> [  726.618105]  del_gendisk+0x144/0x2b8
> [  726.618759]  brd_exit+0x68/0x560 [brd]
> [  726.619501]  __arm64_sys_delete_module+0x19c/0x2a0
> [  726.620384]  el0_svc_common+0x78/0x130
> [  726.621057]  el0_svc_handler+0x38/0x78
> [  726.621738]  el0_svc+0x8/0xc
> [  726.622259] Code: aa0203f6 aa0103f7 aa1e03e0 d503201f (7940e260)
> 
> Here, we add brd_check_and_reset_par func to check and limit max_part par.
> 
> --
> V4->V5:(suggested by Ming Lei)
>  - make sure max_part is not larger than DISK_MAX_PARTS
> 
> V3->V4:(suggested by Ming Lei)
>  - remove useless change
>  - add one limit of max_part
> 
> V2->V3: (suggested by Ming Lei)
>  - clear .minors when running out of consecutive minor space in brd_alloc
>  - remove limit of rd_nr
> 
> V1->V2:
>  - add more checks in brd_check_par_valid as suggested by Ming Lei.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Reviewed-by: Bob Liu <bob.liu@oracle.com>
> ---
>  drivers/block/brd.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index df8103dd40ac..6b9db3f63cb7 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -389,11 +389,12 @@ static struct brd_device *brd_alloc(int i)
>  	 *  is harmless)
>  	 */
>  	blk_queue_physical_block_size(brd->brd_queue, PAGE_SIZE);
> -	disk = brd->brd_disk = alloc_disk(max_part);
> +	disk = brd->brd_disk = alloc_disk(((i * max_part) & ~MINORMASK) ?
> +			0 : max_part);
>  	if (!disk)
>  		goto out_free_queue;
>  	disk->major		= RAMDISK_MAJOR;
> -	disk->first_minor	= i * max_part;
> +	disk->first_minor	= i * disk->minors;

As I told you, the above change isn't needed, otherwise:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks, 
Ming

