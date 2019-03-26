Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA75C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 16:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA21B2070D
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 16:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfCZQzU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:55:20 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:35334 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCZQzU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 12:55:20 -0400
Received: from tux.wizards.de (pD9EBF050.dip0.t-ipconnect.de [217.235.240.80])
        by mail02.iobjects.de (Postfix) with ESMTPSA id C41A241696A3;
        Tue, 26 Mar 2019 17:55:17 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 4873EF01601;
        Tue, 26 Mar 2019 17:55:17 +0100 (CET)
Subject: Re: [PATCH] loop: properly observe rotational flag of underlying
 device
To:     LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benjamin Gordon <bmgordon@chromium.org>
References: <20190212225424.139232-1-bmgordon@chromium.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <52a9cb46-5863-834c-3378-5b0ec87814e6@applied-asynchrony.com>
Date:   Tue, 26 Mar 2019 17:55:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190212225424.139232-1-bmgordon@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ping! Jens, can we please let this finally land in 5.2?

thanks,
Holger

On 2/12/19 11:54 PM, Benjamin Gordon wrote:
> From: Holger Hoffstätte <holger.hoffstaette@googlemail.com>
> 
> The loop driver always declares the rotational flag of its device as
> rotational, even when the device of the mapped file is nonrotational,
> as is the case with SSDs or on tmpfs. This can confuse filesystem tools
> which are SSD-aware; in my case I frequently forget to tell mkfs.btrfs
> that my loop device on tmpfs is nonrotational, and that I really don't
> need any automatic metadata redundancy.
> 
> The attached patch fixes this by introspecting the rotational flag of the
> mapped file's underlying block device, if it exists. If the mapped file's
> filesystem has no associated block device - as is the case on e.g. tmpfs -
> we assume nonrotational storage. If there is a better way to identify such
> non-devices I'd love to hear them.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: holger@applied-asynchrony.com
> Signed-off-by: Holger Hoffstätte <holger.hoffstaette@googlemail.com>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Benjamin Gordon <bmgordon@chromium.org>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> ---
>   This is a resend of Holger's original patch from
>   https://lkml.org/lkml/2015/11/11/288 with the _unlocked functions
>   updated.  We keep running into the same problem on Chrome OS that this
>   originally solved; any chance it can go in?
> 
>   drivers/block/loop.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index cf5538942834..6c0fc0d49dc0 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -900,6 +900,24 @@ static int loop_prepare_queue(struct loop_device *lo)
>   	return 0;
>   }
>   
> +static void loop_update_rotational(struct loop_device *lo)
> +{
> +	struct file *file = lo->lo_backing_file;
> +	struct inode *file_inode = file->f_mapping->host;
> +	struct block_device *file_bdev = file_inode->i_sb->s_bdev;
> +	struct request_queue *q = lo->lo_queue;
> +	bool nonrot = true;
> +
> +	/* not all filesystems (e.g. tmpfs) have a sb->s_bdev */
> +	if (file_bdev)
> +		nonrot = blk_queue_nonrot(bdev_get_queue(file_bdev));
> +
> +	if (nonrot)
> +		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
> +	else
> +		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
> +}
> +
>   static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>   		       struct block_device *bdev, unsigned int arg)
>   {
> @@ -963,6 +981,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>   	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
>   		blk_queue_write_cache(lo->lo_queue, true, false);
>   
> +	loop_update_rotational(lo);
>   	loop_update_dio(lo);
>   	set_capacity(lo->lo_disk, size);
>   	bd_set_size(bdev, size << 9);
> 

