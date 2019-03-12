Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D501C43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 17:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB2B206DF
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 17:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cpR19JXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfCLRWz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:22:55 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48294 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfCLRWy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 13:22:54 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2CHEY8U159031;
        Tue, 12 Mar 2019 17:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=iOjG49OepcYwW0hFgqwiU+e6H/1osYxSanFbyDuWEf0=;
 b=cpR19JXd90mLmPVgD7ys+E3oaDO8XW940yzSZ4KqYPNTllwjq+6dPBSjEgth2r1ChE9/
 disihy+TtFn/KMhCh+JK8mzfPp4c6mZFu8SZ9IrRCXsUCn17xAr5sg7Cnyf4CRdN1Hmf
 bd2lcu9g91buKXYCu/n7s8hl2/tG/5tyqtJBenequkQqKGU7DDZORRPvY8YNgqB15Wme
 XsnSudBR4NbBH53GtZUnanYgHaNmVDNMIoXmFiSaE9/sDAvpkZP3YHfCnvwzHFQaVp62
 cQqi6i8q4gURRb5bjg7ptAviTUhHPO7CfkvcZNnrUP3K0fMb633vmY5VBpZb/3PTm4M8 fA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2r430epmm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 17:22:48 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2CHMlV5016709
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 17:22:47 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2CHMlDf018500;
        Tue, 12 Mar 2019 17:22:47 GMT
MIME-Version: 1.0
Message-ID: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
Date:   Tue, 12 Mar 2019 10:22:46 -0700 (PDT)
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     <virtualization@lists.linux-foundation.org>,
        <linux-block@vger.kernel.org>
Cc:     <mst@redhat.com>, <axboe@kernel.dk>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: virtio-blk: should num_vqs be limited by num_possible_cpus()?
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9193 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903120118
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I observed that there is one msix vector for config and one shared vector
for all queues in below qemu cmdline, when the num-queues for virtio-blk
is more than the number of possible cpus:

qemu: "-smp 4" while "-device virtio-blk-pci,drive=3Ddrive-0,id=3Dvirtblk0,=
num-queues=3D6"

# cat /proc/interrupts=20
           CPU0       CPU1       CPU2       CPU3
... ...
 24:          0          0          0          0   PCI-MSI 65536-edge      =
virtio0-config
 25:          0          0          0         59   PCI-MSI 65537-edge      =
virtio0-virtqueues
... ...


However, when num-queues is the same as number of possible cpus:

qemu: "-smp 4" while "-device virtio-blk-pci,drive=3Ddrive-0,id=3Dvirtblk0,=
num-queues=3D4"

# cat /proc/interrupts=20
           CPU0       CPU1       CPU2       CPU3
... ...=20
 24:          0          0          0          0   PCI-MSI 65536-edge      =
virtio0-config
 25:          2          0          0          0   PCI-MSI 65537-edge      =
virtio0-req.0
 26:          0         35          0          0   PCI-MSI 65538-edge      =
virtio0-req.1
 27:          0          0         32          0   PCI-MSI 65539-edge      =
virtio0-req.2
 28:          0          0          0          0   PCI-MSI 65540-edge      =
virtio0-req.3
... ...

In above case, there is one msix vector per queue.


This is because the max number of queues is not limited by the number of
possible cpus.

By default, nvme (regardless about write_queues and poll_queues) and
xen-blkfront limit the number of queues with num_possible_cpus().


Is this by design on purpose, or can we fix with below?


diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 4bc083b..df95ce3 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -513,6 +513,8 @@ static int init_vq(struct virtio_blk *vblk)
 =09if (err)
 =09=09num_vqs =3D 1;
=20
+=09num_vqs =3D min(num_possible_cpus(), num_vqs);
+
 =09vblk->vqs =3D kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
 =09if (!vblk->vqs)
 =09=09return -ENOMEM;
--


PS: The same issue is applicable to virtio-scsi as well.

Thank you very much!

Dongli Zhang
