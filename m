Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F63C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 22:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB58218AC
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 22:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XD6ZGBR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEHWZl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 18:25:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55114 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgEHWZk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 18:25:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048MINZH185998;
        Fri, 8 May 2020 22:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=lj1fAt6rOModmti5aCOIFkfy9VrMd8ePv3L1tFUn0To=;
 b=XD6ZGBR4wbLqH+Wnm2Tm+Yy/Xpp38SOKshysRw6uWGRkjCy07cM4111gShgScGziiisa
 fRrUhu9saU4Oj7qsdgVQo+jK2NprTNt6MjQ4mxwtt3L0i0/p8RDar/PyvMkpeTGfttQN
 dGgenS1eMSVvNnDrDvOALpro6a/P9ywYn5wQUvTD5W9kJ9AGcEZTi8bdMwZWWnVcPtJw
 jJUt8vyxLQLXkOq+zAUZNQ9LJ4ZdS1asv5M94mPPwsiNct2qbnIuF3m9+JPJfsnG6MI7
 M9gNSqOnYMZtsVcge4v8dDPkEz7UdTQlv9BmGYotTj+VQ71FkEnkMkgm9gUN8S1MNFjn 2g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30vtewwfum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 22:25:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048MHdPD067602;
        Fri, 8 May 2020 22:23:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30vte1a3qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 22:23:36 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 048MNY7c030537;
        Fri, 8 May 2020 22:23:34 GMT
Received: from dhcp-10-159-244-154.vpn.oracle.com (/10.159.244.154)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 May 2020 15:23:34 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/1] block: don't inject fake timeouts on quiesced queues
From:   Alan Adamson <ALAN.ADAMSON@ORACLE.COM>
In-Reply-To: <20200508220526.GC1389136@T590>
Date:   Fri, 8 May 2020 15:23:32 -0700
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        martin.petersen@ORACLE.COM, himanshu.madhani@ORACLE.COM
Content-Transfer-Encoding: quoted-printable
Message-Id: <9B08C28D-BD67-4C3C-BADD-C0E3B67040BE@ORACLE.COM>
References: <1588974394-15430-1-git-send-email-alan.adamson@oracle.com>
 <20200508220526.GC1389136@T590>
To:     Ming Lei <ming.lei@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9615 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=3 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080188
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9615 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=3 adultscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080188
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On May 8, 2020, at 3:05 PM, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> On Fri, May 08, 2020 at 02:46:34PM -0700, Alan Adamson wrote:
>> While using the block fake timeout injector to reproduce a nvme error =
handling hang, a hang was
>> observed when the following script was run:
>>=20
>> echo 100 > /sys/kernel/debug/fail_io_timeout/probability
>> echo 1000 > /sys/kernel/debug/fail_io_timeout/times
>> echo 1 > /sys/block/nvme0n1/io-timeout-fail
>> dd if=3D/dev/nvme0n1 of=3D/dev/null bs=3D512 count=3D1=20
>>=20
>>=20
>> dmesg:
>>=20
>> [  370.018164] INFO: task kworker/u113:9:1191 blocked for more than =
122 seconds.
>> [  370.018849]       Not tainted 5.7.0-rc4 #1
>> [  370.019251] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" =
disables this message.
>> [  370.019653] kworker/u113:9  D    0  1191      2 0x80004000
>> [  370.019660] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
>> [  370.019661] Call Trace:
>> [  370.019667]  __schedule+0x2dc/0x710
>> [  370.019668]  schedule+0x44/0xb0
>> [  370.019671]  blk_mq_freeze_queue_wait+0x4b/0xb0
>> [  370.019675]  ? finish_wait+0x80/0x80
>> [  370.019681]  nvme_wait_freeze+0x36/0x50 [nvme_core]
>> [  370.019683]  nvme_reset_work+0xb65/0xf2b [nvme]
>> [  370.019688]  process_one_work+0x1ab/0x380
>> [  370.019689]  worker_thread+0x37/0x3b0
>> [  370.019691]  kthread+0x120/0x140
>> [  370.019692]  ? create_worker+0x1b0/0x1b0
>> [  370.019693]  ? kthread_park+0x90/0x90
>> [  370.019696]  ret_from_fork+0x35/0x40
>>=20
>> This occurs when a fake timeout is scheduled on a request that is in =
he process
>> of being cancelled due to the previous fake timeout.
>=20
> Not sure root cause is timeout injection, and in theory request queue =
shouldn't
> have been quiesced before freezing, otherwise it is easy to cause =
deadlock.

It's the handling of the previously injected timeout that causes the =
queue to the quiesed.  When the request is attempted to be canceled (as =
part of the
nvme reset) the request is setup for another timeout and doesn=E2=80=99t =
get cancelled and the hang then occurs.

Alan

>=20
> BTW, could you share us how you conclude it is related with queue =
quiesce?
>=20
> Thanks,
> Ming
>=20

