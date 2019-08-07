Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C21C433FF
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 16:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3BE22296
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 16:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fpFm9SNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfHGQBe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:01:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52862 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbfHGQBe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Aug 2019 12:01:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x77FhvPt186095;
        Wed, 7 Aug 2019 16:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=9rRv2tdDYAME0jDzjUd41r2Q/7zEQd+eMUzoCt6a3gM=;
 b=fpFm9SNc7siFT9SdDqaYqcb0xOqyXr8Di+OXrRB4eLAbiEBxNqUULPYbDBSleZiAUWqE
 XtcjPMkgDm4RZcaXb0bOqSLq4NWefmgFTg2BJmQSP5ksAfKdv07ctayR1L+pdh122Alg
 Bjk3p2Yc/sFCSjW/rvbugCTcvQJymRUXD2y7OmVtGkL/ypABtyyuVS8+ZcqeO+S5kg+O
 tZZzzwUpqZdN2pjJgG3Tepz+OcwM/q4wHpuZclfmb0mpagM9nYDvlVySafzYg0oLxB7A
 jXB57spZlyy9089ZB8F7OwXKV268CJxTpHxQtzsLNzclW5bmgPgb9ztoVea1HQWCUdGj oA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u51pu5dvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 16:01:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x77Fh2ok080593;
        Wed, 7 Aug 2019 15:59:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2u763j1uht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 15:59:31 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x77FxV8c000807;
        Wed, 7 Aug 2019 15:59:31 GMT
Received: from Junxiaos-MacBook-Pro.local (/10.11.16.208)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 08:59:30 -0700
Subject: Re: [PATCH] block: fix RO partition with RW disk
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com
References: <20190805200138.28098-1-junxiao.bi@oracle.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <b191908b-cc67-660a-468e-2f4164f430ba@oracle.com>
Date:   Wed, 7 Aug 2019 08:59:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805200138.28098-1-junxiao.bi@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908070162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908070162
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Anybody could help review this bug?

thanks,

Junxiao.

On 8/5/19 1:01 PM, Junxiao Bi wrote:
> When md raid1 was used with imsm metadata, during the boot stage,
> the raid device will first be set to readonly, then mdmon will set
> it read-write later. When there were some partitions in this device,
> the following race would make some partition left ro and fail to mount.
>
> CPU 1:                                                 CPU 2:
> add_partition()                                        set_disk_ro() //set disk RW
>   //disk was RO, so partition set to RO
>   p->policy = get_disk_ro(disk);
>                                                          if (disk->part0.policy != flag) {
>                                                              set_disk_ro_uevent(disk, flag);
>                                                              // disk set to RW
>                                                              disk->part0.policy = flag;
>                                                          }
>                                                          // set all exit partition to RW
>                                                          while ((part = disk_part_iter_next(&piter)))
>                                                              part->policy = flag;
>   // this part was not yet added, so it was still RO
>   rcu_assign_pointer(ptbl->part[partno], p);
>
> Move RO status setting of partitions after they were added into partition
> table and introduce a mutex to sync RO status between disk and partitions.
>
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> ---
>   block/genhd.c             | 3 +++
>   block/partition-generic.c | 5 ++++-
>   include/linux/genhd.h     | 1 +
>   3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/block/genhd.c b/block/genhd.c
> index 54f1f0d381f4..f3cce1d354cf 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1479,6 +1479,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
>   		}
>   		ptbl = rcu_dereference_protected(disk->part_tbl, 1);
>   		rcu_assign_pointer(ptbl->part[0], &disk->part0);
> +		mutex_init(&disk->part_lock);
>   
>   		/*
>   		 * set_capacity() and get_capacity() currently don't use
> @@ -1570,6 +1571,7 @@ void set_disk_ro(struct gendisk *disk, int flag)
>   	struct disk_part_iter piter;
>   	struct hd_struct *part;
>   
> +	mutex_lock(&disk->part_lock);
>   	if (disk->part0.policy != flag) {
>   		set_disk_ro_uevent(disk, flag);
>   		disk->part0.policy = flag;
> @@ -1579,6 +1581,7 @@ void set_disk_ro(struct gendisk *disk, int flag)
>   	while ((part = disk_part_iter_next(&piter)))
>   		part->policy = flag;
>   	disk_part_iter_exit(&piter);
> +	mutex_unlock(&disk->part_lock);
>   }
>   
>   EXPORT_SYMBOL(set_disk_ro);
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index aee643ce13d1..63cb6fb996ff 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -345,7 +345,6 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
>   		queue_limit_discard_alignment(&disk->queue->limits, start);
>   	p->nr_sects = len;
>   	p->partno = partno;
> -	p->policy = get_disk_ro(disk);
>   
>   	if (info) {
>   		struct partition_meta_info *pinfo = alloc_part_info(disk);
> @@ -401,6 +400,10 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
>   	/* everything is up and running, commence */
>   	rcu_assign_pointer(ptbl->part[partno], p);
>   
> +	mutex_lock(&disk->part_lock);
> +	p->policy = get_disk_ro(disk);
> +	mutex_unlock(&disk->part_lock);
> +
>   	/* suppress uevent if the disk suppresses it */
>   	if (!dev_get_uevent_suppress(ddev))
>   		kobject_uevent(&pdev->kobj, KOBJ_ADD);
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 8b5330dd5ac0..df6ddca8a92c 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -201,6 +201,7 @@ struct gendisk {
>   	 */
>   	struct disk_part_tbl __rcu *part_tbl;
>   	struct hd_struct part0;
> +	struct mutex part_lock;
>   
>   	const struct block_device_operations *fops;
>   	struct request_queue *queue;
