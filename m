Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879A4C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 21:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF3B206D5
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 21:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bVPQ5kvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHVnu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 17:43:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51538 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgEHVnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 17:43:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048LhnRT028390;
        Fri, 8 May 2020 21:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=/9HYuD/HqQ0OgmQhd4qkp9Eql3ac0Kzr6S/ly3Mw1dE=;
 b=bVPQ5kvzI7e7xB/fE0piTpDyb+5bQL+0w1ztZg+x9jJLSYlMtzNvrbA70l7hnMIFfMkH
 GjTPjucUg4BLgPFgyJW+SvZ4GNp5RmSchr5fzTOZy1MAJvltpZ4A82qnJfyaUektwys2
 QdPAaZgrgEqgy/8P6PsX5h2F22Nqa/+rC6hM3z2HyYgzPJCZwntAdTggApGJltT7jM1V
 +ksMXL3d0x9WMnRQLt6okeogOUEn6yYv0rfiG4UdSjU602Z8I945L1tnmEDDSRjsZTAH
 5CIVP6XNy7kktQsDoN0s3I6EDY/jxWVbbRqvbpyh3ZIsFtsfWC00x5G7YBjKrT3ExF/G DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30vtepnaxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 21:43:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048Lfo5v102607;
        Fri, 8 May 2020 21:43:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 30vte1758f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 08 May 2020 21:43:48 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048LgOmI103528;
        Fri, 8 May 2020 21:43:48 GMT
Received: from dhcp-10-76-241-128.usdhcp.oraclecorp.com.com (dhcp-10-76-241-128.usdhcp.oraclecorp.com [10.76.241.128])
        by aserp3020.oracle.com with ESMTP id 30vte1757f-1;
        Fri, 08 May 2020 21:43:48 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com, martin.petersen@oracle.com,
        himanshu.madhani@oracle.com
Subject: [PATCH 0/1] block: don't inject fake timeouts on quiesced queues
Date:   Fri,  8 May 2020 14:46:34 -0700
Message-Id: <1588974394-15430-1-git-send-email-alan.adamson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9615 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=3 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080184
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While using the block fake timeout injector to reproduce a nvme error handling hang, a hang was
observed when the following script was run:

echo 100 > /sys/kernel/debug/fail_io_timeout/probability
echo 1000 > /sys/kernel/debug/fail_io_timeout/times
echo 1 > /sys/block/nvme0n1/io-timeout-fail
dd if=/dev/nvme0n1 of=/dev/null bs=512 count=1 


dmesg:

[  370.018164] INFO: task kworker/u113:9:1191 blocked for more than 122 seconds.
[  370.018849]       Not tainted 5.7.0-rc4 #1
[  370.019251] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  370.019653] kworker/u113:9  D    0  1191      2 0x80004000
[  370.019660] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
[  370.019661] Call Trace:
[  370.019667]  __schedule+0x2dc/0x710
[  370.019668]  schedule+0x44/0xb0
[  370.019671]  blk_mq_freeze_queue_wait+0x4b/0xb0
[  370.019675]  ? finish_wait+0x80/0x80
[  370.019681]  nvme_wait_freeze+0x36/0x50 [nvme_core]
[  370.019683]  nvme_reset_work+0xb65/0xf2b [nvme]
[  370.019688]  process_one_work+0x1ab/0x380
[  370.019689]  worker_thread+0x37/0x3b0
[  370.019691]  kthread+0x120/0x140
[  370.019692]  ? create_worker+0x1b0/0x1b0
[  370.019693]  ? kthread_park+0x90/0x90
[  370.019696]  ret_from_fork+0x35/0x40

This occurs when a fake timeout is scheduled on a request that is in he process
of being cancelled due to the previous fake timeout.


Alan Adamson (1):
  block: don't inject fake timeouts on quiesced queues

 block/blk-timeout.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
1.8.3.1

