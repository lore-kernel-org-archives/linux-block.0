Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7250AC10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 13:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7D42147A
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 13:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NyibkznU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDHN6E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:58:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43336 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDHN6E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 09:58:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38DsTKp064142;
        Mon, 8 Apr 2019 13:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=dIMyYXuJ/ZphoxiO57xMpJzVwF1azIzZHwbmusW54gA=;
 b=NyibkznU5fdPiNJ59OS18tyqwGmOxHoMxEbkNx582kg6zuA1oS39nAmRSBILIFrsfQWm
 b2ip3S4MnJGp/Kwe3MZd7Wy6Z1WGcxE7DusrtvUXIRrapUh6+M+vJ0rjf3c6jzjlP9eg
 gyjrCrwhyuOmea4foOqoLdSNR3DMECx7hMgdqKWWIhx72/yMUXTVLzJplf+KoLrXwYcF
 nXV58y7xTxHtgwzFkPbvwbXrDlQfHJsZ/fJdOFT3m364oDdgxfcntxkTXOYcDNs71gwO
 gp32kWMLZCJw9FQGuQhdbB6sUA2ALAVAb1r3P4j75PBmG3QNIjTvEgNn/QjK1bD6BO3r WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2rpkhspkr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 13:57:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38Dvnme097661;
        Mon, 8 Apr 2019 13:57:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2rpkehqddw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 13:57:56 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x38Dvsfo007793;
        Mon, 8 Apr 2019 13:57:54 GMT
Received: from [10.191.23.208] (/10.191.23.208)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 06:57:54 -0700
Subject: Re: [PATCH 0/2] Limit number of hw queues by nr_cpu_ids for
 virtio-blk and virtio-scsi
To:     linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <1553682995-5682-1-git-send-email-dongli.zhang@oracle.com>
Cc:     mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <8ee49e44-a52c-0596-e18e-7d92da8cef8f@oracle.com>
Date:   Mon, 8 Apr 2019 21:57:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1553682995-5682-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=854
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904080118
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=880 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904080118
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping?

Thank you very much!

Dongli Zhang

On 03/27/2019 06:36 PM, Dongli Zhang wrote:
> When tag_set->nr_maps is 1, the block layer limits the number of hw queues
> by nr_cpu_ids. No matter how many hw queues are use by
> virtio-blk/virtio-scsi, as they both have (tag_set->nr_maps == 1), they
> can use at most nr_cpu_ids hw queues.
> 
> In addition, specifically for pci scenario, when the 'num-queues' specified
> by qemu is more than maxcpus, virtio-blk/virtio-scsi would not be able to
> allocate more than maxcpus vectors in order to have a vector for each
> queue. As a result, they fall back into MSI-X with one vector for config
> and one shared for queues.
> 
> Considering above reasons, this patch set limits the number of hw queues
> used by nr_cpu_ids for both virtio-blk and virtio-scsi.
> 
> -------------------------------------------------------------
> 
> Here is test result of virtio-scsi:
> 
> qemu cmdline:
> 
> -smp 2,maxcpus=4, \
> -device virtio-scsi-pci,id=scsi0,num_queues=8, \
> -device scsi-hd,drive=drive0,bus=scsi0.0,channel=0,scsi-id=0,lun=0, \
> -drive file=test.img,if=none,id=drive0
> 
> Although maxcpus=4 and num_queues=8, 4 queues are used while 2 interrupts
> are allocated.
> 
> # cat /proc/interrupts
> ... ...
>  24:          0          0   PCI-MSI 65536-edge      virtio0-config
>  25:          0        369   PCI-MSI 65537-edge      virtio0-virtqueues
> ... ...
> 
> # /sys/block/sda/mq/
> 0  1  2  3   ------> 4 queues although qemu sets num_queues=8
> 
> 
> With the patch set, there is per-queue interrupt.
> 
> # cat /proc/interrupts
>  24:          0          0   PCI-MSI 65536-edge      virtio0-config
>  25:          0          0   PCI-MSI 65537-edge      virtio0-control
>  26:          0          0   PCI-MSI 65538-edge      virtio0-event
>  27:        296          0   PCI-MSI 65539-edge      virtio0-request
>  28:          0        139   PCI-MSI 65540-edge      virtio0-request
>  29:          0          0   PCI-MSI 65541-edge      virtio0-request
>  30:          0          0   PCI-MSI 65542-edge      virtio0-request
> 
> # ls /sys/block/sda/mq
> 0  1  2  3
> 
> -------------------------------------------------------------
> 
> Here is test result of virtio-blk:
> 
> qemu cmdline:
> 
> -smp 2,maxcpus=4,
> -device virtio-blk-pci,drive=drive-virtio-disk0,id=virtio-disk0,num-queues=8
> -drive test.img,format=raw,if=none,id=drive-virtio-disk0
> 
> Although maxcpus=4 and num-queues=8, 4 queues are used while 2 interrupts
> are allocated.
> 
> # cat /proc/interrupts
> ... ...
>  24:          0          0   PCI-MSI 65536-edge      virtio0-config
>  25:          0         65   PCI-MSI 65537-edge      virtio0-virtqueues
> ... ...
> 
> # ls /sys/block/vda/mq
> 0  1  2  3    -------> 4 queues although qemu sets num_queues=8
> 
> 
> With the patch set, there is per-queue interrupt.
> 
> # cat /proc/interrupts
>  24:          0          0   PCI-MSI 65536-edge      virtio0-config
>  25:         64          0   PCI-MSI 65537-edge      virtio0-req.0
>  26:          0      10290   PCI-MSI 65538-edge      virtio0-req.1
>  27:          0          0   PCI-MSI 65539-edge      virtio0-req.2
>  28:          0          0   PCI-MSI 65540-edge      virtio0-req.3
> 
> # ls /sys/block/vda/mq/
> 0  1  2  3
> 
> 
> Reference: https://lore.kernel.org/lkml/e4afe4c5-0262-4500-aeec-60f30734b4fc@default/
> 
> Thank you very much!
> 
> Dongli Zhang
> 
