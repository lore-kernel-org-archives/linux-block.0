Return-Path: <SRS0=SfBO=36=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2468C352A4
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 03:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA8220870
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 03:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPWVkpeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJDQ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Feb 2020 22:16:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31897 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJDQ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Feb 2020 22:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581304616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B2VonG/X8Vx9WnWym+dJCLHJZ7AYbg4oAY+nxppyQOk=;
        b=UPWVkpeuPGfYQX2ppyF/3n7B1Ts4vPXN4hwsklRlMA/rHElBl+TL4r5HlB/sOrrcNVxpNx
        avHX6JWwZ+D1McnQL5mok/k3o5vKhHUhRmkU7KaY2RQEiCPXJ/TzDzksIFNZ8RWHREN/xQ
        ezgj8D3oqOQvOQ9famXflyrtb0pNpHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-DNqv5R2gOG-s4TlFFWkpDQ-1; Sun, 09 Feb 2020 22:16:51 -0500
X-MC-Unique: DNqv5R2gOG-s4TlFFWkpDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AAF3184AEA9;
        Mon, 10 Feb 2020 03:16:50 +0000 (UTC)
Received: from [10.10.120.117] (ovpn-120-117.rdu2.redhat.com [10.10.120.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F65360BE0;
        Mon, 10 Feb 2020 03:16:48 +0000 (UTC)
Subject: Re: [PATCH] nbd: fix potential NULL pointer fault in connect and
 disconnect process
To:     "sunke (E)" <sunke32@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk
References: <20200117115005.37006-1-sunke32@huawei.com>
 <5E21EF96.1010204@redhat.com>
 <c15baa64-ef8d-970f-f4e0-ecd10cc0b0a0@huawei.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E40CB1F.7070301@redhat.com>
Date:   Sun, 9 Feb 2020 21:16:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <c15baa64-ef8d-970f-f4e0-ecd10cc0b0a0@huawei.com>
Content-Type: multipart/mixed;
 boundary="------------010007000101060400020607"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------010007000101060400020607
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2020 01:10 AM, sunke (E) wrote:
>=20
> Thanks for your detailed suggestions.
>=20
> =E5=9C=A8 2020/1/18 1:32, Mike Christie =E5=86=99=E9=81=93:
>> On 01/17/2020 05:50 AM, Sun Ke wrote:
>>> Connect and disconnect a nbd device repeatedly, will cause
>>> NULL pointer fault.
>>>
>>> It will appear by the steps:
>>> 1. Connect the nbd device and disconnect it, but now nbd device
>>>     is not disconnected totally.
>>> 2. Connect the same nbd device again immediately, it will fail
>>>     in nbd_start_device with a EBUSY return value.
>>> 3. Wait a second to make sure the last config_refs is reduced
>>>     and run nbd_config_put to disconnect the nbd device totally.
>>> 4. Start another process to open the nbd_device, config_refs
>>>     will increase and at the same time disconnect it.
>>
>> Just to make sure I understood this, for step 4 the process is doing:
>>
>> open(/dev/nbdX);
>> ioctl(NBD_DISCONNECT, /dev/nbdX) or nbd_genl_disconnect(for /dev/nbdX)
>>
>> ?
>>
> do nbd_genl_disconnect(for /dev/nbdX)=EF=BC=9B
> I tested it. Connect /dev/nbdX
> through ioctl interface by nbd-client -L -N export localhost /dev/nbdX =
and
> through netlink interface by nbd-client localhost XXXX /dev/nbdX,
> disconnect /dev/nbdX by nbd-client -d /dev/nbdX.
> Both call nbd_genl_disconnect(for /dev/nbdX) and both contain the same
> null pointer dereference.
>> There is no successful NBD_DO_IT / nbd_genl_connect between the open a=
nd
>> disconnect calls at step #4, because it would normally be done at #2 a=
nd
>> that failed. nbd_disconnect_and_put could then reference a null
>> recv_workq. If we are also racing with a close() then that could free
>> the device/config from under nbd_disconnect_and_put.
>>
> Yes, nbd_disconnect_and_put could then reference a null recv_workq.

Hey Sunke

How about the attached patch. I am still testing it. The basic idea is
that we need to do a flush whenever we have done a sock_shutdown and are
in the disconnect/connect/clear sock path, so it just adds the flush in
that function. We then do not need to keep adding these flushes everywher=
e.

--------------010007000101060400020607
Content-Type: text/x-patch;
 name="0001-nbd-fix-crash-during-nbd_genl_disconnect.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-nbd-fix-crash-during-nbd_genl_disconnect.patch"

From c007f70b73d31a11ea90ae53c748266eec88c0ab Mon Sep 17 00:00:00 2001
From: Mike Christie <mchristi@redhat.com>
Date: Sun, 9 Feb 2020 21:06:00 -0600
Subject: [PATCH] nbd: fix crash during nbd_genl_disconnect

If we open a nbd device, but have not done a nbd_genl_connect we will
crash in nbd_genl_disconnect when we try to flush the workqueue since it
was never allocated.

This patch moves all the flush calls to sock_shutdown and adds a check
for a valid workqueue.

Note that we flush_workqueue will do the right thing if there are no
running works so we did not need the if (i) check in nbd_start_device.
This also fixes a possible bug where you could do nbd_genl_connect, then
do a NBD_DISCONNECT and NBD_CLEAR_SOCK and the workqueue would not get
flushed.
---
 drivers/block/nbd.c | 44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 78181908f0df..1afc70ed1f0a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -341,9 +341,12 @@ static void nbd_complete_rq(struct request *req)
 }
 
 /*
- * Forcibly shutdown the socket causing all listeners to error
+ * Forcibly shutdown the socket causing all listeners to error. If called
+ * from a disconnect/clearing context we must make sure the recv workqueues
+ * have exited so they don't release the last nbd_config reference and try to
+ * destroy the workqueue from inside itself.
  */
-static void sock_shutdown(struct nbd_device *nbd)
+static void sock_shutdown(struct nbd_device *nbd, bool flush_work)
 {
 	struct nbd_config *config = nbd->config;
 	int i;
@@ -351,7 +354,7 @@ static void sock_shutdown(struct nbd_device *nbd)
 	if (config->num_connections == 0)
 		return;
 	if (test_and_set_bit(NBD_RT_DISCONNECTED, &config->runtime_flags))
-		return;
+		goto try_flush;
 
 	for (i = 0; i < config->num_connections; i++) {
 		struct nbd_sock *nsock = config->socks[i];
@@ -360,6 +363,10 @@ static void sock_shutdown(struct nbd_device *nbd)
 		mutex_unlock(&nsock->tx_lock);
 	}
 	dev_warn(disk_to_dev(nbd->disk), "shutting down sockets\n");
+
+try_flush:
+	if (flush_work && nbd->recv_workq)
+		flush_workqueue(nbd->recv_workq);
 }
 
 static u32 req_to_nbd_cmd_type(struct request *req)
@@ -446,7 +453,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	set_bit(NBD_RT_TIMEDOUT, &config->runtime_flags);
 	cmd->status = BLK_STS_IOERR;
 	mutex_unlock(&cmd->lock);
-	sock_shutdown(nbd);
+	sock_shutdown(nbd, false);
 	nbd_config_put(nbd);
 done:
 	blk_mq_complete_request(req);
@@ -910,7 +917,7 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 			 * for the reconnect timer don't trigger the timer again
 			 * and instead just error out.
 			 */
-			sock_shutdown(nbd);
+			sock_shutdown(nbd, false);
 			nbd_config_put(nbd);
 			blk_mq_start_request(req);
 			return -EIO;
@@ -1178,7 +1185,7 @@ static int nbd_disconnect(struct nbd_device *nbd)
 
 static void nbd_clear_sock(struct nbd_device *nbd)
 {
-	sock_shutdown(nbd);
+	sock_shutdown(nbd, true);
 	nbd_clear_que(nbd);
 	nbd->task_setup = NULL;
 }
@@ -1264,17 +1271,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 
 		args = kzalloc(sizeof(*args), GFP_KERNEL);
 		if (!args) {
-			sock_shutdown(nbd);
-			/*
-			 * If num_connections is m (2 < m),
-			 * and NO.1 ~ NO.n(1 < n < m) kzallocs are successful.
-			 * But NO.(n + 1) failed. We still have n recv threads.
-			 * So, add flush_workqueue here to prevent recv threads
-			 * dropping the last config_refs and trying to destroy
-			 * the workqueue from inside the workqueue.
-			 */
-			if (i)
-				flush_workqueue(nbd->recv_workq);
+			sock_shutdown(nbd, true);
 			return -ENOMEM;
 		}
 		sk_set_memalloc(config->socks[i]->sock->sk);
@@ -1306,9 +1303,7 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 	mutex_unlock(&nbd->config_lock);
 	ret = wait_event_interruptible(config->recv_wq,
 					 atomic_read(&config->recv_threads) == 0);
-	if (ret)
-		sock_shutdown(nbd);
-	flush_workqueue(nbd->recv_workq);
+	sock_shutdown(nbd, true);
 
 	mutex_lock(&nbd->config_lock);
 	nbd_bdev_reset(bdev);
@@ -1323,7 +1318,7 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
 				 struct block_device *bdev)
 {
-	sock_shutdown(nbd);
+	sock_shutdown(nbd, true);
 	__invalidate_device(bdev, true);
 	nbd_bdev_reset(bdev);
 	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
@@ -1986,12 +1981,7 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
 	nbd_disconnect(nbd);
 	nbd_clear_sock(nbd);
 	mutex_unlock(&nbd->config_lock);
-	/*
-	 * Make sure recv thread has finished, so it does not drop the last
-	 * config ref and try to destroy the workqueue from inside the work
-	 * queue.
-	 */
-	flush_workqueue(nbd->recv_workq);
+
 	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
 			       &nbd->config->runtime_flags))
 		nbd_config_put(nbd);
-- 
2.20.1


--------------010007000101060400020607--

