Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91297C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 05:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2A620883
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 05:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jnU1ZFPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfDIF74 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:59:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52294 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfDIF74 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 01:59:56 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x395wWv1061631;
        Tue, 9 Apr 2019 05:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=3uF0URoiP5pUDumVY98c4H5JHvsy1aDrQYZL1ihppkM=;
 b=jnU1ZFPdY7KM//QX11/h8gJfBkJ3RdYYVsnYaiI4DuUfuzZ6M4dK8dA5M9mvyRjWvn2/
 xZidXWX9W3/ayLHVgbMzsqE6hLTl7si8mDwoqfWnPT7KsYUryStBuSy+BqJKSoNRYYVP
 oH2Euafu5WXG3RD0tWEOlKU85FV/aTJ5Mzh4hPLkgGD9J4dJ2pTiewVvGUb5C7xGPVnC
 /rpbG3qxpX+kdPxkYMnMqoXLhOfyqctMZVDwLwVOTmALUsxHH1Kabw7WDIPunN64ImFa
 u9oeZnZubrUxRFmB+xo49fPnSA8KvDOtsee6nEelSRgxASbzYy7a1dHHSOModX4tFKvc Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2rphmeasnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 05:59:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x395ve2B059728;
        Tue, 9 Apr 2019 05:59:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2rpj5acgy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 05:59:15 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x395x6VL005667;
        Tue, 9 Apr 2019 05:59:06 GMT
Received: from [10.182.71.93] (/10.182.71.93)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 22:59:06 -0700
Subject: Re: [PATCH] block: Revert v5.0 blk_mq_request_issue_directly()
 changes
To:     Stewart Smith <stewart@linux.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>
References: <20190404170843.83517-1-bvanassche@acm.org>
 <87y34jwykf.fsf@linux.vnet.ibm.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <300563e5-ebf4-ed62-bbaf-207d3ab5d067@oracle.com>
Date:   Tue, 9 Apr 2019 13:59:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87y34jwykf.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904090041
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904090041
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/9/19 1:13 PM, Stewart Smith wrote:
> cpu 0x4a: Vector: 400 (Instruction Access) at [c000203ff398b100]
>     pc: c0000000021fe700
>     lr: c0000000002001d8: blk_mq_complete_request+0x34/0x138

Would you please figure out what is the source code here with gdb ?

From the backtrace, it seems not the same issue, because no dm-mpath is involved here.

Thanks
Jianchao

>     sp: c000203ff398b390
>    msr: 9000000010009033
>   current = 0xc000203ff3901b00
>   paca    = 0xc000203fff7f3680	 irqmask: 0x03	 irq_happened: 0x01
>     pid   = 658, comm = kworker/u257:2
> Linux version 5.0.7-openpower1 (hostboot@gfw275.aus.stglabs.ibm.com) (gcc version 6.5.0 (Buildroot 2019.02.1-00016-ge01dcd0)) #2 SMP Mon Apr 8 09:14:53 CDT 2019
> 
> [link register   ] c0000000002001d8 blk_mq_complete_request+0x34/0x138
> [c000203ff398b390] c000203ff398b3d0 (unreliable)
> [c000203ff398b3d0] c0000000002d0428 scsi_mq_done+0x48/0x6c
> [c000203ff398b410] c0000000002ee8d8 ata_scsi_simulate+0x78/0x29c
> [c000203ff398b460] c0000000002eee74 ata_scsi_queuecmd+0xa8/0x2cc
> [c000203ff398b4a0] c0000000002d2ac4 scsi_queue_rq+0x7bc/0x810
> [c000203ff398b540] c000000000202570 blk_mq_dispatch_rq_list+0x474/0x5c0
> [c000203ff398b600] c000000000207560 blk_mq_sched_dispatch_requests+0x114/0x18c
> [c000203ff398b660] c0000000002009e4 __blk_mq_run_hw_queue+0xe0/0xf8
> [c000203ff398b6e0] c000000000200a5c __blk_mq_delay_run_hw_queue+0x60/0x184
> [c000203ff398b740] c000000000200c20 blk_mq_run_hw_queue+0x70/0xe4
> [c000203ff398b790] c0000000002077ec blk_mq_sched_insert_request+0x68/0x194
> [c000203ff398b7f0] c0000000001fc1d8 blk_execute_rq_nowait+0x78/0x8c
> [c000203ff398b810] c0000000001fc234 blk_execute_rq+0x48/0x90
> [c000203ff398b860] c0000000002cfa10 __scsi_execute+0xd8/0x1ac
> [c000203ff398b8d0] c0000000002cc31c ioctl_internal_command.constprop.2+0x50/0x144
> [c000203ff398b980] c0000000002cc474 scsi_set_medium_removal+0x64/0x9c
> [c000203ff398b9c0] c0080000101f2754 sd_open+0xe8/0x148 [sd_mod]
> [c000203ff398ba00] c00000000018b730 __blkdev_get+0x198/0x3e4
> [c000203ff398ba70] c00000000018b9cc blkdev_get+0x50/0x35c
> [c000203ff398bb10] c00000000020b140 __device_add_disk+0x468/0x488
> [c000203ff398bbd0] c0080000101f5484 sd_probe_async+0xd4/0x180 [sd_mod]
> [c000203ff398bc60] c00000000009a128 async_run_entry_fn+0x68/0x138
> [c000203ff398bca0] c000000000090858 process_one_work+0x204/0x334
> [c000203ff398bd30] c000000000090ca4 worker_thread+0x2d0/0x394
> [c000203ff398bdb0] c000000000096cb4 kthread+0x14c/0x154
> [c000203ff398be20] c00000000000b72c ret_from_kernel_thread+0x5c/0x70
