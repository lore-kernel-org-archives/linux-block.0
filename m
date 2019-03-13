Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D62C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 03:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1C3217F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 03:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KWONPPm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfCMDWe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 23:22:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48322 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfCMDWe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 23:22:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2D38m2Q188513;
        Wed, 13 Mar 2019 03:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=0Yq1FeuG/zy7qm3WW2CIBx/apWyQ5162VsPKL1lLqHM=;
 b=KWONPPm61cIOTyd4dEXCHScLdoL9jvhPcDBNASoLUjTouESgTa+0pd6p8CII1fjIjY7H
 yG7NQwCc3uvy4tCzn/ePvn/+pNIZg5YLK9irMKJAXZleugSbexafIKe3erzTyeHsLI6g
 HXPP5MgGS4FYEvOJScdEQa0k0rUb5ijReLJkTgdigKzYJQOLlVibXuJTxrzPnUnc8WX2
 /LYY5ltBbXMH7cntJtyD1+90H9mzHcV1QRkJvMv5XNv/TIRddAsvDT0U4TbQlsfGwoIW
 Q7ZqgzQ75GHdwB8UNMgqCH2Awz4/J13R6bxKE7HjZJAxgOetrNXa2NCgMnOPb8G1/DnW 4A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2r44wu8be8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 03:22:27 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2D3MQ3o020767
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 03:22:26 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2D3MQ9O009597;
        Wed, 13 Mar 2019 03:22:26 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Mar 2019 20:22:26 -0700
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, mst@redhat.com
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
 <20190312183351.74764f4f.cohuck@redhat.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
Date:   Wed, 13 Mar 2019 11:26:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190312183351.74764f4f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9193 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903130022
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/13/19 1:33 AM, Cornelia Huck wrote:
> On Tue, 12 Mar 2019 10:22:46 -0700 (PDT)
> Dongli Zhang <dongli.zhang@oracle.com> wrote:
> 
>> I observed that there is one msix vector for config and one shared vector
>> for all queues in below qemu cmdline, when the num-queues for virtio-blk
>> is more than the number of possible cpus:
>>
>> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=6"
>>
>> # cat /proc/interrupts 
>>            CPU0       CPU1       CPU2       CPU3
>> ... ...
>>  24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
>>  25:          0          0          0         59   PCI-MSI 65537-edge      virtio0-virtqueues
>> ... ...
>>
>>
>> However, when num-queues is the same as number of possible cpus:
>>
>> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=4"
>>
>> # cat /proc/interrupts 
>>            CPU0       CPU1       CPU2       CPU3
>> ... ... 
>>  24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
>>  25:          2          0          0          0   PCI-MSI 65537-edge      virtio0-req.0
>>  26:          0         35          0          0   PCI-MSI 65538-edge      virtio0-req.1
>>  27:          0          0         32          0   PCI-MSI 65539-edge      virtio0-req.2
>>  28:          0          0          0          0   PCI-MSI 65540-edge      virtio0-req.3
>> ... ...
>>
>> In above case, there is one msix vector per queue.
> 
> Please note that this is pci-specific...
> 
>>
>>
>> This is because the max number of queues is not limited by the number of
>> possible cpus.
>>
>> By default, nvme (regardless about write_queues and poll_queues) and
>> xen-blkfront limit the number of queues with num_possible_cpus().
> 
> ...and these are probably pci-specific as well.

Not pci-specific, but per-cpu as well.

> 
>>
>>
>> Is this by design on purpose, or can we fix with below?
>>
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 4bc083b..df95ce3 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -513,6 +513,8 @@ static int init_vq(struct virtio_blk *vblk)
>>  	if (err)
>>  		num_vqs = 1;
>>  
>> +	num_vqs = min(num_possible_cpus(), num_vqs);
>> +
>>  	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
>>  	if (!vblk->vqs)
>>  		return -ENOMEM;
> 
> virtio-blk, however, is not pci-specific.
> 
> If we are using the ccw transport on s390, a completely different
> interrupt mechanism is in use ('floating' interrupts, which are not
> per-cpu). A check like that should therefore not go into the generic
> driver.
> 

So far there seems two options.

The 1st option is to ask the qemu user to always specify "-num-queues" with the
same number of vcpus when running x86 guest with pci for virtio-blk or
virtio-scsi, in order to assign a vector for each queue.

Or, is it fine for virtio folks to add a new hook to 'struct virtio_config_ops'
so that different platforms (e.g., pci or ccw) would use different ways to limit
the max number of queues in guest, with something like below?

So far both virtio-scsi and virtio-blk would benefit from the new hook.

---
 drivers/block/virtio_blk.c         |  2 ++
 drivers/virtio/virtio_pci_common.c |  6 ++++++
 drivers/virtio/virtio_pci_common.h |  2 ++
 drivers/virtio/virtio_pci_legacy.c |  1 +
 drivers/virtio/virtio_pci_modern.c |  2 ++
 include/linux/virtio_config.h      | 11 +++++++++++
 6 files changed, 24 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 4bc083b..93cfeda 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -513,6 +513,8 @@ static int init_vq(struct virtio_blk *vblk)
 	if (err)
 		num_vqs = 1;

+	num_vqs = virtio_calc_num_vqs(vdev, num_vqs);
+
 	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
 	if (!vblk->vqs)
 		return -ENOMEM;
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index d0584c0..ce021d1 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -409,6 +409,12 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
 }

+/* the config->calc_num_vqs() implementation */
+unsigned short vp_calc_num_vqs(unsigned short num_vqs)
+{
+	return min_t(unsigned short, num_possible_cpus(), num_vqs);
+}
+
 const char *vp_bus_name(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 0227100..cc5ac80 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -134,6 +134,8 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
 		const char * const names[], const bool *ctx,
 		struct irq_affinity *desc);
+/* the config->calc_num_vqs() implementation */
+unsigned short vp_calc_num_vqs(unsigned short num_vqs);
 const char *vp_bus_name(struct virtio_device *vdev);

 /* Setup the affinity for a virtqueue:
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index eff9ddc..69d1050 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -209,6 +209,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.bus_name	= vp_bus_name,
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
+	.calc_num_vqs = vp_calc_num_vqs,
 };

 /* the PCI probing function */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 07571da..f04e44a 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -460,6 +460,7 @@ static const struct virtio_config_ops
virtio_pci_config_nodev_ops = {
 	.bus_name	= vp_bus_name,
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
+	.calc_num_vqs = vp_calc_num_vqs,
 };

 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -476,6 +477,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.bus_name	= vp_bus_name,
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
+	.calc_num_vqs = vp_calc_num_vqs,
 };

 /**
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index bb4cc49..f32368b 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -65,6 +65,7 @@ struct irq_affinity;
  *      the caller can then copy.
  * @set_vq_affinity: set the affinity for a virtqueue (optional).
  * @get_vq_affinity: get the affinity for a virtqueue (optional).
+ * @calc_num_vqs: calculate the number of virtqueue (optional)
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
@@ -88,6 +89,7 @@ struct virtio_config_ops {
 			       const struct cpumask *cpu_mask);
 	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
 			int index);
+	unsigned short (*calc_num_vqs)(unsigned short num_vqs);
 };

 /* If driver didn't advertise the feature, it will never appear. */
@@ -207,6 +209,15 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev,
unsigned nvqs,
 				      desc);
 }

+static inline
+unsigned short virtio_calc_num_vqs(struct virtio_device *vdev,
+				   unsigned short num_vqs)
+{
+	if (vdev->config->calc_num_vqs)
+		return vdev->config->calc_num_vqs(num_vqs);
+	return num_vqs;
+}
+
 /**
  * virtio_device_ready - enable vq use in probe function
  * @vdev: the device
-- 
2.7.4


Thank you very much!

Dongli Zhang
