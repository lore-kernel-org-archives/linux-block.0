Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B836DC7618F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 23:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F9521951
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 23:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2y5dCRqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfGVXbL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:31:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48956 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfGVXbL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 19:31:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6MNTCdL104363;
        Mon, 22 Jul 2019 23:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ZOinQjjkfv+8JYlsnjKtWVora/RDCEJ06rc6HsclIrg=;
 b=2y5dCRqNbyDeHDW0jO++e2I1na2Hzhb0IYMqCXazV73vVweZ4OOd8KSFXiqhSyPL/eem
 iXesaIm/WdS+KhEKF6eZ68fZEQTJoluEaEKrd7STPFx+IQffTHYYhJ543/d0UaYk+pmf
 MGTEO88kQsEaOzcNiR5TXyYkL1k4AwSs7+1do0/FOkeAymeiVs6+Im8IHK6XodjXW6Rr
 dM5lAOwvQUdebQviltw1VTHfLR2jpc1Z/PVcidXg9ld9vlb78FoECgHwBnwhfyGHfj3f
 eDEefmgyPeKhTIPH4C3fUOM934zI2/pGn0ZQuNNo018pzFMzr1uxRWmAxyh7uPY5VdJd 5Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tutctaeaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 23:30:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6MNRu3t087843;
        Mon, 22 Jul 2019 23:30:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tut9mkw89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 23:30:46 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6MNUjZ1000912;
        Mon, 22 Jul 2019 23:30:45 GMT
Received: from [192.168.1.14] (/180.165.87.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jul 2019 16:30:44 -0700
Subject: Re: [RFC PATCH 0/3] md: export internal stats through debugfs
To:     Hou Tao <houtao1@huawei.com>, linux-raid@vger.kernel.org,
        songliubraving@fb.com
Cc:     neilb@suse.com, linux-block@vger.kernel.org, snitzer@redhat.com,
        agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org
References: <20190702132918.114818-1-houtao1@huawei.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <1ebcf2e8-f3ce-7417-4060-b9264a5a4e51@oracle.com>
Date:   Tue, 23 Jul 2019 07:30:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190702132918.114818-1-houtao1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9326 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907220248
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9326 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907220248
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/19 9:29 PM, Hou Tao wrote:
> Hi,
> 
> There are so many io counters, stats and flags in md, so I think
> export these info to userspace will be helpful for online-debugging,

For online-debugging, I'd suggest you have a try eBPF which can be very helpful.

-Bob

> especially when the vmlinux file and the crash utility are not
> available. And these info can also be utilized during code
> understanding.
> 
> MD has already exported some stats through sysfs files under
> /sys/block/mdX/md, but using sysfs file to export more internal
> stats are not a good choice, because we need to create a single
> sysfs file for each internal stat according to the use convention
> of sysfs and there are too many internal stats. Further, the
> newly-created sysfs files would become APIs for userspace tools,
> but that is not we wanted, because these files are related with
> internal stats and internal stats may change from time to time.
> 
> And I think debugfs is a better choice. Because we can show multiple
> related stats in a debugfs file, and the debugfs file will never be
> used as an userspace API.
> 
> Two debugfs files are created to expose these internal stats:
> * iostat: io counters and io related stats (e.g., mddev->active_io,
> 	r1conf->nr_pending, or r1confi->retry_list)
> * stat: normal stats/flags (e.g., mddev->recovery, conf->array_frozen)
> 
> Because internal stats are spreaded all over md-core and md-personality,
> so both md-core and md-personality will create these two debugfs files
> under different debugfs directory.
> 
> Patch 1 factors out the debugfs files creation routine for md-core and
> md-personality, patch 2 creates two debugfs files: iostat & stat under
> /sys/kernel/debug/block/mdX for md-core, and patch 3 creates two debugfs
> files: iostat & stat under /sys/kernel/debug/block/mdX/raid1 for md-raid1.
> 
> The following lines show the hierarchy and the content of these debugfs
> files for a RAID1 device:
> 
> $ pwd
> /sys/kernel/debug/block/md0
> $ tree
> .
> ├── iostat
> ├── raid1
> │   ├── iostat
> │   └── stat
> └── stat
> 
> $ cat iostat
> active_io 0
> sb_wait 0 pending_writes 0
> recovery_active 0
> bitmap pending_writes 0
> 
> $ cat stat
> flags 0x20
> sb_flags 0x0
> recovery 0x0
> 
> $ cat raid1/iostat
> retry_list active 0
> bio_end_io_list active 0
> pending_bio_list active 0 cnt 0
> sync_pending 0
> nr_pending 0
> nr_waiting 0
> nr_queued 0
> barrier 0
> 
> $ cat raid1/stat
> array_frozen 0
> 
> I'm not sure whether the division of internal stats is appropriate and
> whether the internal stats in debugfs files are sufficient, so questions
> and comments are weclome.
> 
> Regards,
> Tao
> 
> Hou Tao (3):
>   md-debugfs: add md_debugfs_create_files()
>   md: export inflight io counters and internal stats in debugfs
>   raid1: export inflight io counters and internal stats in debugfs
> 
>  drivers/md/Makefile     |  2 +-
>  drivers/md/md-debugfs.c | 35 ++++++++++++++++++
>  drivers/md/md-debugfs.h | 16 +++++++++
>  drivers/md/md.c         | 65 ++++++++++++++++++++++++++++++++++
>  drivers/md/md.h         |  1 +
>  drivers/md/raid1.c      | 78 +++++++++++++++++++++++++++++++++++++++++
>  drivers/md/raid1.h      |  1 +
>  7 files changed, 197 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/md/md-debugfs.c
>  create mode 100644 drivers/md/md-debugfs.h
> 

