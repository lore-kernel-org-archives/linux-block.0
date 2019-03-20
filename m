Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BA2C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 14:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D302186A
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 14:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GATWuRly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfCTOjC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:39:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36452 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfCTOjC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 10:39:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2KEXpjR041917;
        Wed, 20 Mar 2019 14:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=72Ikz92xE6o7/OKv9tzQr01ODA/hMEyQjZOhqgNMQAo=;
 b=GATWuRlyAXIaOSDfgESwbeDMdvBt9mfEQJ3TBJGEjuh9MxaNKxwM9ChfIXI6FzT9lM+7
 mXDh+hSVuMF7MQnTBuC38qsSuOg3hzEsFMs6Jgy1gJLSOurkasi8R0W45YShJihotCN8
 1M2Noilwf+wv53q7WhjIhMV4GY8CsjzNxFLXIwvtrCScTDbfCJxtf0E9tk0tfzJyL5fW
 HshjbrTi+Sn+sKC8OUtl3HXowRD3gkYJQXBJKokLU60eJjZ/4Ncqe0AuVSGUM9oHXbaK
 mpl9VmoIVFnthCWPjbLizwsOJCrWkpgzy8Vwulnk5h+kT68zE9m4ignhM39hbK+SUpeX ng== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2r8rjuu7m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 14:38:56 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2KEcoLp031565
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 14:38:50 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2KEcnLp018299;
        Wed, 20 Mar 2019 14:38:49 GMT
Received: from [192.168.2.8] (/106.39.150.192)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 07:38:49 -0700
Subject: Re: loop: Too many partitions and OOM killer?
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>
References: <f817788e-d228-67bd-1bd2-14a12bd76d0b@i-love.sakura.ne.jp>
Cc:     linux-block <linux-block@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <6afcdd5a-4d42-558d-dece-ac332886eb7d@oracle.com>
Date:   Wed, 20 Mar 2019 22:38:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <f817788e-d228-67bd-1bd2-14a12bd76d0b@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903200112
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tetsuo,

On 03/20/2019 07:42 PM, Tetsuo Handa wrote:
> Hello.
> 
> syzbot is sometimes generating corrupted reports like
> https://syzkaller.appspot.com/text?tag=CrashLog&x=14f62a8b200000 .
> 
> The report includes flood of global OOM killer invocations, and I suspect
> that the reason of global OOM killer invocations is a lot of "blkid" processes
> (invoked by uevent?) after manipulating loop devices with a lot of partitions.
> 
> Can "blkid" be invoked asynchronously upon manipulating loop devices?

I am not sure.

Therefore I have tested on Ubuntu 16.04.5 VM running default 4.15.0-46-generic.


1. I hooked blkid by a proxy bash script. If blkid is involved, the related
syslog will be printed to /var/log/syslog by 'logger':

$ cat /sbin/blkid

#!/bin/sh

/sbin/blkid-bin $*
logger "blkid $*"


2. Then I started to monitor udev messages via 'udevadm monitor'.

3. Finally, I did the test with below command set and there would be two
partitions involved:

# dd if=/dev/zero of=tmp.raw bs=1M count=100 oflag=direct
# parted tmp.raw --script mklabel msdos mkpart primary 0% 50% mkpart primary 50%
100%
# losetup -P /dev/loop0 tmp.raw
# losetup -d /dev/loop0


Below are the udev messages captured during the test.

For 'losetup -P /dev/loop0 tmp.raw':

KERNEL[140.622809] change   /devices/virtual/block/loop0 (block)
KERNEL[140.640550] change   /devices/virtual/block/loop0 (block)
KERNEL[140.640601] add      /devices/virtual/block/loop0/loop0p1 (block)
KERNEL[140.640625] add      /devices/virtual/block/loop0/loop0p2 (block)
UDEV  [140.676169] change   /devices/virtual/block/loop0 (block)
UDEV  [140.692198] change   /devices/virtual/block/loop0 (block)
UDEV  [140.701744] add      /devices/virtual/block/loop0/loop0p1 (block)
UDEV  [140.724253] add      /devices/virtual/block/loop0/loop0p2 (block)


For 'losetup -d /dev/loop0':

KERNEL[159.504382] change   /devices/virtual/block/loop0 (block)
KERNEL[159.504718] remove   /devices/virtual/block/loop0/loop0p1 (block)
KERNEL[159.504758] remove   /devices/virtual/block/loop0/loop0p2 (block)
UDEV  [159.505807] change   /devices/virtual/block/loop0 (block)
UDEV  [159.506201] remove   /devices/virtual/block/loop0/loop0p1 (block)
UDEV  [159.507036] remove   /devices/virtual/block/loop0/loop0p2 (block)


There is NO blkid log printed to /var/log/syslog and I would assume blkid is not
involved.

This is just a test on ubuntu 16.04.5. I am not sure about the env of syzbot.

Dongli Zhang
