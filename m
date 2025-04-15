Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A96328E61D
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721799; cv=none; b=nWsffG7YEsoedAVrbm408YUGDSg22xetQjYwgS/EgkQm26Gb55GkJNIo3KQvDQ+a8fGOM5ztlXDOgzWxPn6jsJ/gPdtRerO9H3yvAUVUborptmxBv5k0rxOr3//9Xrw8lcsBR0ZscBhtl+hklGM6/xA3KBSgsCJZ85ps6ZNHyuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721799; c=relaxed/simple;
	bh=4gMrVrd9kPNcccJSsc8Yngxwb7iQgJAl2S4pvWfWM0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOY8Whrxw5SIDlhZazBEy6nBuLk85JhNjT+q9/5ExpPfYOtBEfNv7Sphw30AFPNI4ENJGgIYFrkB+s9JB+tBQlI+ZHAe2FgHx8k0bCV5oBevCSb2m2g0xtXBIfOBnFUnmNadOk/AhfE+QL4nE5gNjlNMcsXES8XbJg/K4A7QhXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IAzx/OoI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAzx/OoI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744721796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=796EAfEY4/9miDaGUqWntFC7NuhVF6RlpCDZX0XB/ks=;
	b=IAzx/OoIjmvKM8V+RtudG+s7JxizJHk/hfKBr4MsBD7qVrgD81SHMjbetj5zP1qRbK0X2e
	vLAK2IUwI4gwk4zC2WO29B6UNmy+XHXAsvtmBx8vqtuD9iy7DSVSWGfZWPqiMTJ2yZwyc5
	czPfS5KLwiermBxBhbcKjvTob0fjCOg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-3l47kPgcMRu4xMG9s0xnFg-1; Tue,
 15 Apr 2025 08:56:31 -0400
X-MC-Unique: 3l47kPgcMRu4xMG9s0xnFg-1
X-Mimecast-MFC-AGG-ID: 3l47kPgcMRu4xMG9s0xnFg_1744721790
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A49041954B36;
	Tue, 15 Apr 2025 12:56:30 +0000 (UTC)
Received: from fedora (unknown [10.72.116.70])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6008A1955BC0;
	Tue, 15 Apr 2025 12:56:25 +0000 (UTC)
Date: Tue, 15 Apr 2025 20:56:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Guy Eisenberg <geisenberg@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Jared Holzman <jholzman@nvidia.com>, Yoav Cohen <yoav@nvidia.com>,
	Omri Levi <omril@nvidia.com>, Ofer Oshri <ofer@nvidia.com>
Subject: Re: ublk: kernel crash when killing SPDK application
Message-ID: <Z_5XdWPQa7cq1nDJ@fedora>
References: <IA1PR12MB645841796CB4C76F62F24522A9B22@IA1PR12MB6458.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA1PR12MB645841796CB4C76F62F24522A9B22@IA1PR12MB6458.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Apr 15, 2025 at 10:58:37AM +0000, Guy Eisenberg wrote:
> I am writing to report a kernel crash that occurred after terminating (kill -9) an SPDK application using ublk.
> Below are the details of the incident, including steps to reproduce the issue and the call stack.
> 
> Incident Description:
> After terminating an SPDK application, the system occasionally experiences a kernel crash.
> This issue is not consistent but happens once every few tries under the following conditions.
> We are using kernel 6.14.0-061400-generic
> 
> Steps to Reproduce:
> 1. install SPDK:
>       git clone https://github.com/spdk/spdk 
>       cd spdk
>       ./configure --disable-coverage --disable-debug --disable-tests --enable-unit-tests --without-crypto --without-fio --with-vhost --with-rdma --without-nvme-cuse --without-fuse --without-vfio-user --without-vtune --without-iscsi-initiator --without-shared --with-ublk --with-uring --with-raid5f
>       make
>       make install
> 2.  Create SPDK bdev (here we used PCI 0000.8b.00.0 as the nvme target, and named the bdev as guy_bdev):
>       ./spdk/scripts/setup.sh reset
>       ./spdk/scripts/setup.sh
>       /usr/local/bin/spdk_tgt --mem-size 2048 -m 0xff
>       ./spdk/scripts/rpc.py bdev_nvme_attach_controller -b guy_bdev -t PCIe -a 0000.8b.00.0
> 3. Expose it via ublk
>       modprobe ublk_drv
>       ./spdk/scripts/rpc.py ublk_create_target
>       ./spdk/scripts/rpc.py ublk_start_disk -q 8 -d 128 guy_bdevn1 0
> 4. Run IO to the /dev/ublkb0 that was created
>       Kill the spdk_tgt process (kill -9)
> 
> 
> Call Stack:
>       Below is the call stack captured during one of the crashes:
> 
> [54346.157495] [ T288311] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [54346.157625] [ T288311] #PF: supervisor write access in kernel mode
> [54346.157708] [ T288311] #PF: error_code(0x0002) - not-present page
> [54346.157790] [ T288311] PGD 0 P4D 0 
> [54346.157911] [ T288311] Oops: Oops: 0002 [#1] PREEMPT SMP PTI
> [54346.158010] [ T288311] CPU: 0 UID: 0 PID: 288311 Comm: reactor_0 Kdump: loaded Tainted: G           OE      6.14.0-061400-generic #202503241442
> [54346.158264] [ T288311] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [54346.158374] [ T288311] Hardware name: Supermicro SYS-2028BT-HNR+/X10DRT-B+, BIOS 2.0 01/10/2017
> [54346.158490] [ T288311] RIP: 0010:percpu_ref_get_many+0x35/0x50

Looks one uring_cmd use-after-free issue.

And the following patchset may avoid it:

	https://lore.kernel.org/linux-block/20250414112554.3025113-1-ming.lei@redhat.com/

If you can build & test kernel, please apply the following debug patch
against v6.14 and post the panic log.


diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ca9a67b5b537..6e50e8b9f836 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1127,6 +1127,7 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res,
 
 	/* tell ublksrv one io request is coming */
 	io_uring_cmd_done(io->cmd, res, 0, issue_flags);
+	io->cmd = NULL;
 }
 
 #define UBLK_REQUEUE_DELAY_MS	3
@@ -1498,8 +1499,10 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
 		io->flags |= UBLK_IO_FLAG_CANCELED;
 	spin_unlock(&ubq->cancel_lock);
 
-	if (!done)
+	if (!done) {
 		io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0, issue_flags);
+		io->cmd = NULL;
+	}
 }
 
 /*
@@ -1770,6 +1773,8 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	if (!ubq || ub_cmd->q_id != ubq->q_id)
 		goto out;
 
+	WARN_ON_ONCE(ubq->canceling);
+
 	if (ubq->ubq_daemon && ubq->ubq_daemon != current)
 		goto out;
 



Thanks,
Ming

