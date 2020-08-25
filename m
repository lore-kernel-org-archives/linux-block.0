Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50380C433DF
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 23:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A18D20706
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 23:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prgmr.com header.i=@prgmr.com header.b="D7/MCbXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgHYXtu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgHYXts (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 19:49:48 -0400
X-Greylist: delayed 156 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Aug 2020 16:49:48 PDT
Received: from mail.prgmr.com (mail.prgmr.com [IPv6:2605:2700:0:5::4713:9506])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C33C061574
        for <linux-block@vger.kernel.org>; Tue, 25 Aug 2020 16:49:48 -0700 (PDT)
Received: from [10.0.0.5] (c-69-181-255-113.hsd1.ca.comcast.net [69.181.255.113])
        (Authenticated sender: srn)
        by mail.prgmr.com (Postfix) with ESMTPSA id 672D472020D;
        Tue, 25 Aug 2020 19:49:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com 672D472020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1598399387;
        bh=aqj2gMbXR04OYLOfqIigzCH6m6rRfCJoBzVT8Kvxf34=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=D7/MCbXOGMqa0T3GY/BFhsjhhKXrUC1FKBHQg/9N1ralznvcNeWliOugb8pCVLXTG
         x2IvzeGd7RF3G1TihwWx3W06bDen4hvXpblIOtAfgATpUV7/qmT+Ctq9aVfqVgQWaM
         ErxVW81GC7ojz3CaN+/KMhlBTQvidHFevojfo50g=
Subject: Re: [PATCH] block: drbd: defer calling kref_put until end of
 drbd_delete_device
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk
References: <20200819055237.30920-1-srn@prgmr.com>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
From:   Sarah Newman <srn@prgmr.com>
Message-ID: <8b581990-a978-7cd8-041e-c5374b72f967@prgmr.com>
Date:   Tue, 25 Aug 2020 16:49:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819055237.30920-1-srn@prgmr.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/20 10:52 PM, Sarah Newman wrote:
> At least once I saw:
> 
> drbd resource37: ASSERTION FAILED:
>    connection->current_epoch->list not empty
> drbd resource37: Connection closed
> drbd resource37: conn( Disconnecting -> StandAlone )
> drbd resource37: receiver terminated
> drbd resource37: Terminating drbd_r_resource
> block drbd37: disk( UpToDate -> Failed )
> block drbd37: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
> block drbd37: disk( Failed -> Diskless )
> general protection fault: 0000 [#1] SMP NOPTI
> CPU: 0 PID: 18526 Comm: drbdsetup-84 Not tainted 5.4.46-1.el7.x86_64 #1
> RIP: e030:kobject_uevent_env+0x1d/0x660
> RSP: e02b:ffffc900757a7a10 EFLAGS: 00010246
> RAX: 0000000000000001 RBX: fdfdfdfdfdfe023d RCX: ffff8880606f9870
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: fdfdfdfdfdfe023d
> RBP: ffff8880606f9870 R08: 0000000000000040 R09: ffffffffc01ae500
> R10: ffffc900757a7aa8 R11: ffffffffc01f0b58 R12: ffff8880606f9800
> R13: ffff88800fb5dc00 R14: ffffffff824055e5 R15: ffff88800fb5dc48
> FS:  00007fbbc98e4740(0000) GS:ffff888188a00000(0000)
>       knlGS:0000000000000000
> CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f978b44c000 CR3: 0000000007926000 CR4: 0000000000040660
> Call Trace:
> ? error_exit+0x5/0x20
> blk_integrity_del+0x1a/0x2b
> del_gendisk+0x27/0x2f0
> drbd_delete_device+0xcc/0x100 [drbd]
> adm_del_minor+0xc5/0xe0 [drbd]
> drbd_adm_down+0x13f/0x1f0 [drbd]
> genl_family_rcv_msg+0x1d2/0x410
> genl_rcv_msg+0x47/0x90
> ? __kmalloc_node_track_caller+0x217/0x2e0
> ? genl_family_rcv_msg+0x410/0x410
> netlink_rcv_skb+0x49/0x110
> genl_rcv+0x24/0x40
> netlink_unicast+0x191/0x220
> netlink_sendmsg+0x21d/0x3f0
> sock_sendmsg+0x5b/0x60
> sock_write_iter+0x97/0x100
> new_sync_write+0x12d/0x1d0
> vfs_write+0xa5/0x1a0
> ksys_write+0x59/0xd0
> do_syscall_64+0x5b/0x1a0
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fbbc93f1a00
> 
> Which I traced back to drbd_destroy_device being called early, as
> drbd_destroy_device sets memory to 0xfd and one of the pointers
> observed was an offset from 0xfdfdfdfdfdfdfdfd.
> 
> Make it so that the system can be recovered even if we see this bug,
> and call out if we unexpectedly do not free the device at the end
> of drbd_delete_device.
> 
> Signed-off-by: Sarah Newman <srn@prgmr.com>
> ---
>   drivers/block/drbd/drbd_main.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index a18155cdce41..9148713e8b3b 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -2935,6 +2935,7 @@ void drbd_delete_device(struct drbd_device *device)
>   	struct drbd_resource *resource = device->resource;
>   	struct drbd_connection *connection;
>   	struct drbd_peer_device *peer_device;
> +	unsigned int minor = device_to_minor(device);
>   
>   	/* move to free_peer_device() */
>   	for_each_peer_device(peer_device, device)
> @@ -2942,15 +2943,24 @@ void drbd_delete_device(struct drbd_device *device)
>   	drbd_debugfs_device_cleanup(device);
>   	for_each_connection(connection, resource) {
>   		idr_remove(&connection->peer_devices, device->vnr);
> -		kref_put(&device->kref, drbd_destroy_device);
>   	}
> +	/* There is a problem somewhere with the reference counting for
> +	 * device->kref, such that at least once we saw the last kref_put before
> +	 * the very last one actually call drbd_destroy_device. Since it should
> +	 * be syntactically equivalent, move all the kref_puts to the end. We'll
> +	 * then get a warning if calling kref_put underflows.
> +	 */
>   	idr_remove(&resource->devices, device->vnr);
> -	kref_put(&device->kref, drbd_destroy_device);
>   	idr_remove(&drbd_devices, device_to_minor(device));
> -	kref_put(&device->kref, drbd_destroy_device);
>   	del_gendisk(device->vdisk);
>   	synchronize_rcu();
> +	for_each_connection(connection, resource) {
> +		kref_put(&device->kref, drbd_destroy_device);
> +	}
> +	kref_put(&device->kref, drbd_destroy_device);
>   	kref_put(&device->kref, drbd_destroy_device);
> +	if (!kref_put(&device->kref, drbd_destroy_device))
> +		pr_err("invalid kref for device %d\n", minor);
>   }
>   
>   static int __init drbd_init(void)
> 

Added linux-block as a CC. I can resend this patch if necessary.

Checking in to see if the patch is overall suitable and if so, whether any changes or additional testing is required before merging.

Thanks, Sarah
