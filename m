Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C301EC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 10:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937152075C
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 10:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QZAdvwXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbfC0Kct (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:32:49 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39018 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfC0Kct (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 06:32:49 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2RADXc5043835;
        Wed, 27 Mar 2019 10:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=1tW29WhXsQZtDQQ0Z2G78kTtwyNKbuql7nWIeE0goBk=;
 b=QZAdvwXJ/Xi0U5zgiZuGZxvKOZ32XprVxbBz003PbKreRkziqZ5xQnyb247EbscXhM/q
 A+FlBFrl2DovzdIvZyisqKp8gyzoOvQG+B/hCDwlnVNt8FF52p2cbXoT9yA+6T8sUYJA
 +KtpuaZpWau5NgreWJsBxmyjO0a1FKVUXnoczkv8Q6+sHH3MoPdvgyKPqZVs8EWUOCN8
 Ob7o+XL7V5/RI2YIYqGUg9tU5RwKnWGAfZzeJl3zGVzf78SUWUgt33N5Uid9NObmsvtb
 pKu7WZaKP3ITLcLLvi8mYUJfpOz9OakMHNfQtkoZUH+UYy1VpRNYXGfrqWxBf5/TiqLM nQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2re6g0yns1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 10:32:40 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2RAWdoW019899
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 10:32:40 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2RAWcp9001129;
        Wed, 27 Mar 2019 10:32:38 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Mar 2019 03:32:37 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Limit number of hw queues by nr_cpu_ids for virtio-blk and virtio-scsi
Date:   Wed, 27 Mar 2019 18:36:33 +0800
Message-Id: <1553682995-5682-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9207 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=686 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903270074
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When tag_set->nr_maps is 1, the block layer limits the number of hw queues
by nr_cpu_ids. No matter how many hw queues are use by
virtio-blk/virtio-scsi, as they both have (tag_set->nr_maps == 1), they
can use at most nr_cpu_ids hw queues.

In addition, specifically for pci scenario, when the 'num-queues' specified
by qemu is more than maxcpus, virtio-blk/virtio-scsi would not be able to
allocate more than maxcpus vectors in order to have a vector for each
queue. As a result, they fall back into MSI-X with one vector for config
and one shared for queues.

Considering above reasons, this patch set limits the number of hw queues
used by nr_cpu_ids for both virtio-blk and virtio-scsi.

-------------------------------------------------------------

Here is test result of virtio-scsi:

qemu cmdline:

-smp 2,maxcpus=4, \
-device virtio-scsi-pci,id=scsi0,num_queues=8, \
-device scsi-hd,drive=drive0,bus=scsi0.0,channel=0,scsi-id=0,lun=0, \
-drive file=test.img,if=none,id=drive0

Although maxcpus=4 and num_queues=8, 4 queues are used while 2 interrupts
are allocated.

# cat /proc/interrupts
... ...
 24:          0          0   PCI-MSI 65536-edge      virtio0-config
 25:          0        369   PCI-MSI 65537-edge      virtio0-virtqueues
... ...

# /sys/block/sda/mq/
0  1  2  3   ------> 4 queues although qemu sets num_queues=8


With the patch set, there is per-queue interrupt.

# cat /proc/interrupts
 24:          0          0   PCI-MSI 65536-edge      virtio0-config
 25:          0          0   PCI-MSI 65537-edge      virtio0-control
 26:          0          0   PCI-MSI 65538-edge      virtio0-event
 27:        296          0   PCI-MSI 65539-edge      virtio0-request
 28:          0        139   PCI-MSI 65540-edge      virtio0-request
 29:          0          0   PCI-MSI 65541-edge      virtio0-request
 30:          0          0   PCI-MSI 65542-edge      virtio0-request

# ls /sys/block/sda/mq
0  1  2  3

-------------------------------------------------------------

Here is test result of virtio-blk:

qemu cmdline:

-smp 2,maxcpus=4,
-device virtio-blk-pci,drive=drive-virtio-disk0,id=virtio-disk0,num-queues=8
-drive test.img,format=raw,if=none,id=drive-virtio-disk0

Although maxcpus=4 and num-queues=8, 4 queues are used while 2 interrupts
are allocated.

# cat /proc/interrupts
... ...
 24:          0          0   PCI-MSI 65536-edge      virtio0-config
 25:          0         65   PCI-MSI 65537-edge      virtio0-virtqueues
... ...

# ls /sys/block/vda/mq
0  1  2  3    -------> 4 queues although qemu sets num_queues=8


With the patch set, there is per-queue interrupt.

# cat /proc/interrupts
 24:          0          0   PCI-MSI 65536-edge      virtio0-config
 25:         64          0   PCI-MSI 65537-edge      virtio0-req.0
 26:          0      10290   PCI-MSI 65538-edge      virtio0-req.1
 27:          0          0   PCI-MSI 65539-edge      virtio0-req.2
 28:          0          0   PCI-MSI 65540-edge      virtio0-req.3

# ls /sys/block/vda/mq/
0  1  2  3


Reference: https://lore.kernel.org/lkml/e4afe4c5-0262-4500-aeec-60f30734b4fc@default/

Thank you very much!

Dongli Zhang

