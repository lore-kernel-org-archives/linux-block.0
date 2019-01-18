Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7441FC43444
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 15:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4647020883
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 15:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FKbP+hHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfARPRd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:17:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48352 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfARPRd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 10:17:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0IF8ip1092650;
        Fri, 18 Jan 2019 15:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=D4DIOqT7zPf5gQjMhw+FSUOxTVmr/GQyTUHzTnlvF5U=;
 b=FKbP+hHtL5Y9awTsQUOlA0qDIzHgbDX/ES/LgUWhxdsrS3m/uFPcVOObZJ9VDz3v39kH
 2ofHHIKG3OAnN+A3+yl5VpV41zunftvACp1VaDafqy12dmUigFRa/WE8lb/bPN1/GxLY
 rPi7YI15FZ4l9iLkXRebvyCAaNBXSvvYNKgDNshPzBzfz8wzwTNRdhHnGCQh/OGSUaLK
 d258+CqMz9W5YWsfb1ksc3vDs/2Ts5/KJEmsAm+P6MZrpgvcdRLzye3C9B7EVEm+Akdb
 KMDmMYDk4/fUduv7Kj/dBJOBJUHzdYjx4DqAylfNWcaicMXYI7iDUpg1CvJqtLA6hbx9 aA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2pybjsp4wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jan 2019 15:17:09 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0IFH8d4023093
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jan 2019 15:17:08 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0IFH6rr026900;
        Fri, 18 Jan 2019 15:17:06 GMT
Received: from [10.191.21.13] (/10.191.21.13)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Jan 2019 07:17:06 -0800
Subject: Re: dd hangs when reading large partitions
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joao Pinto <jpinto@synopsys.com>, Jens Axboe <axboe@kernel.dk>,
        Fujita Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Paolo Valente <paolo.valente@linaro.org>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
Date:   Fri, 18 Jan 2019 23:18:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9139 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901180109
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

On 1/18/19 8:10 PM, Marc Gonzalez wrote:
> Hello,
> 
> I'm running into an issue which I don't know how to debug.
> So I'm open to ideas and suggestions :-)
> 
> On my arm64 board, I have enabled Universal Flash Storage support.
> 
> I wanted to benchmark read performance, and noticed that the system
> locks up when I read partitions larger than 3.5 GB, unless I tell
> dd to use direct IO:
> 
> *** WITH O_DIRECT ***
> # dd if=/dev/sda of=/dev/null bs=1M iflag=direct status=progress
> 57892929536 bytes (58 GB, 54 GiB) copied, 697.006 s, 83.1 MB/s 
> 55256+0 records in
> 55256+0 records out
> 57940115456 bytes (58 GB, 54 GiB) copied, 697.575 s, 83.1 MB/s
> 
> *** WITHOUT O_DIRECT ***
> # dd if=/dev/sda of=/dev/null bs=1M status=progress
> 3853516800 bytes (3.9 GB, 3.6 GiB) copied, 49.0002 s, 78.6 MB/s
> 
> 
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:    1-...0: (8242 ticks this GP) idle=106/1/0x4000000000000000 softirq=168/171 fqs=2626 
> rcu:    6-...0: (99 GPs behind) idle=ec2/1/0x4000000000000000 softirq=71/71 fqs=2626 
> rcu:    (detected by 7, t=5254 jiffies, g=-275, q=2)
> Task dump for CPU 1:
> kworker/1:1H    R  running task        0   675      2 0x0000002a
> Workqueue: kblockd blk_mq_run_work_fn
> Call trace:
>  __switch_to+0x168/0x1d0

It looks like the blk_mq_run_work_fn went to sleep with rcu lock (preempt), isn't it ?
Can you share the symbol of the following address ?

>  0xffffffc0f6efbbc8


>  blk_mq_run_work_fn+0x28/0x40
>  process_one_work+0x208/0x470
>  worker_thread+0x48/0x460
>  kthread+0x128/0x130
>  ret_from_fork+0x10/0x1c
> Task dump for CPU 6:
> kthreadd        R  running task        0     2      0 0x0000002a
> Call trace:
>  __switch_to+0x168/0x1d0
>  0x5b36396f4e7d4000
> 
> 
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:    1-...0: (8242 ticks this GP) idle=106/1/0x4000000000000000 softirq=168/171 fqs=10500 
> rcu:    6-...0: (99 GPs behind) idle=ec2/1/0x4000000000000000 softirq=71/71 fqs=10500 
> rcu:    (detected by 7, t=21009 jiffies, g=-275, q=2)
> Task dump for CPU 1:
> kworker/1:1H    R  running task        0   675      2 0x0000002a
> Workqueue: kblockd blk_mq_run_work_fn
> Call trace:
>  __switch_to+0x168/0x1d0
>  0xffffffc0f6efbbc8
>  blk_mq_run_work_fn+0x28/0x40
>  process_one_work+0x208/0x470
>  worker_thread+0x48/0x460
>  kthread+0x128/0x130
>  ret_from_fork+0x10/0x1c
> Task dump for CPU 6:
> kthreadd        R  running task        0     2      0 0x0000002a
> Call trace:
>  __switch_to+0x168/0x1d0
>  0x5b36396f4e7d4000
> 
> 
> The system always hangs around the 3.6 GiB mark, wherever I start from.
> How can I debug this issue?
> 
> Regards.
> 

Thanks
Jianchao
