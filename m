Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA2AC636D3
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 02:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjAaCbe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 21:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjAaCbe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 21:31:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C474FF0C
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 18:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675132246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VLQQh/uutLlIM0duU2JS2bF3B/pzPSM9EmB78Rh0AsY=;
        b=Tt76cuUHTIEFNUuj/3g6ADeuJO3gxmhadS2Awo3z+HQyAh3bMbnOOt2AV3hQ6EPZXe9glz
        8jWPQQ/hmx4ChWc2r6IIRJFK6Y+hhStXzevrdYq+ngF8zuAe/akBCv9rEb8bxkB8uZbuBZ
        l6YwKzLDPzqT0jaouP+rR7XDg/MzlYc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-nMHfRg9xO2KPS5eIy0EouQ-1; Mon, 30 Jan 2023 21:30:44 -0500
X-MC-Unique: nMHfRg9xO2KPS5eIy0EouQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 829FC3803912;
        Tue, 31 Jan 2023 02:30:44 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 728954010D2A;
        Tue, 31 Jan 2023 02:30:39 +0000 (UTC)
Date:   Tue, 31 Jan 2023 10:30:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>, ming.lei@redhat.com
Subject: Re: [PATCH V4 0/6] ublk_drv: add mechanism for supporting
 unprivileged ublk device
Message-ID: <Y9h9Sefm+uRLG+8R@T590>
References: <20230106041711.914434-1-ming.lei@redhat.com>
 <Y9hCrrTYnFf+1Z2Y@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9hCrrTYnFf+1Z2Y@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Stefan,

On Mon, Jan 30, 2023 at 05:20:30PM -0500, Stefan Hajnoczi wrote:
> On Fri, Jan 06, 2023 at 12:17:05PM +0800, Ming Lei wrote:
> > Hello,
> > 
> > Stefan Hajnoczi suggested un-privileged ublk device[1] for container
> > use case.
> > 
> > So far only administrator can create/control ublk device which is too
> > strict and increase system administrator burden, and this patchset
> > implements un-privileged ublk device:
> > 
> > - any user can create ublk device, which can only be controlled &
> >   accessed by the owner of the device or administrator
> > 
> > For using such mechanism, system administrator needs to deploy two
> > simple udev rules[2] after running 'make install' in ublksrv.
> > 
> > Userspace(ublksrv):
> > 
> > 	https://github.com/ming1/ubdsrv/tree/unprivileged-ublk
> >     
> > 'ublk add -t $TYPE --un_privileged' is for creating one un-privileged
> > ublk device if the user is un-privileged.
> 
> Hi Ming,
> Sorry for the late reply. Is there anything stopping processes with a
> different uid/gid from accessing the unprivileged block device
> (/dev/ublkbN)?

The device is only owned by its owner, and other user can't open the
device file.

> 
> The scenario I'm thinking about is:
> 1. Evil user runs "chmod 666 /dev/ublkbN". They are allowed to do this
>    because they are the owner of the block device node.
> 2. Evil user causes another user's process (e.g. suid) to open the block
>    device.
> 3. Evil user's ublksrv either abuses timing (e.g. never responding or
>    responding after an artifical delay) to DoS or returns corrupted data
>    to exploit bugs in the victim process.
> 
> FUSE has exactly the same issue and I think that's why an unprivileged
> FUSE mount cannot be accessed by processes with a different uid/gid.
> 
> That extra protection is probably necessary for ublk too.

Looks like the evil user creates one trap, and wait for other users to
be caught. And any unprivileged user needn't grant access to other users
cause anyone can create it. OK, we can add the check when opening ublk
disk, something like the following:


diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a725a236a38f..f1a5d704ce33 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -377,8 +377,44 @@ static void ublk_free_disk(struct gendisk *disk)
 	put_device(&ub->cdev_dev);
 }
 
+static void ublk_store_owner_uid_gid(unsigned int *owner_uid,
+		unsigned int *owner_gid)
+{
+	kuid_t uid;
+	kgid_t gid;
+
+	current_uid_gid(&uid, &gid);
+
+	*owner_uid = from_kuid(&init_user_ns, uid);
+	*owner_gid = from_kgid(&init_user_ns, gid);
+}
+
+static int ublk_open(struct block_device *bdev, fmode_t mode)
+{
+	struct ublk_device *ub = bdev->bd_disk->private_data;
+
+	/*
+	 * If it is one unprivileged device, only owner can open
+	 * the disk. Otherwise it could be one trap made by one
+	 * evil user who may grant this disk's privileges to other
+	 * users.
+	 */
+	if (ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV) {
+		unsigned int curr_uid, curr_gid;
+
+		ublk_store_owner_uid_gid(&curr_uid, &curr_gid);
+
+		if (curr_uid != ub->dev_info.owner_uid || curr_gid !=
+				ub->dev_info.owner_gid)
+			return -EPERM;
+	}
+
+	return 0;
+}
+
 static const struct block_device_operations ub_fops = {
 	.owner =	THIS_MODULE,
+	.open =		ublk_open,
 	.free_disk =	ublk_free_disk,
 };
 
@@ -1620,17 +1656,6 @@ static int ublk_ctrl_get_queue_affinity(struct ublk_device *ub,
 	return ret;
 }
 
-static void ublk_store_owner_uid_gid(struct ublksrv_ctrl_dev_info *info)
-{
-	kuid_t uid;
-	kgid_t gid;
-
-	current_uid_gid(&uid, &gid);
-
-	info->owner_uid = from_kuid(&init_user_ns, uid);
-	info->owner_gid = from_kgid(&init_user_ns, gid);
-}
-
 static inline void ublk_dump_dev_info(struct ublksrv_ctrl_dev_info *info)
 {
 	pr_devel("%s: dev id %d flags %llx\n", __func__,
@@ -1664,7 +1689,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		return -EPERM;
 
 	/* the created device is always owned by current user */
-	ublk_store_owner_uid_gid(&info);
+	ublk_store_owner_uid_gid(&info.owner_uid, &info.owner_gid);
 
 	if (header->dev_id != info.dev_id) {
 		pr_warn("%s: dev id not match %u %u\n",




Thanks, 
Ming

