Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D72C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 01:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3493C2085A
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 01:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vCEdljOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCSBva (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:51:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50446 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfCSBv3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 21:51:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2J1n5Jk010020;
        Tue, 19 Mar 2019 01:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=jlCQNGVRFwgCBY4CJA2mPoW0A+Yv5I/mTd6xygvrpwA=;
 b=vCEdljOAEQ8WRFdZNqjCQIqx17dIsSaWZYvGJagJ1p+XjGGFE/4o2CK4TmuEZwiPWh48
 XcIF0BWi1zIonO29JDln8Q3yrurlENufjy4tWDIQQMif2bPoSOq/K2cQCGeozLw+Yo1c
 QJmVnHJuanpGgu0HekqgJ+yGQZOND6q11Z62F3+s+24nN6JOeUGiRhZDr2YhPetGnqsA
 QIo4+L9s7DJl66vVmHIzoe89Zi+VAyURZJvQN+Kjkb3EqzARrR/cUNlPJZC4pefFruiW
 IgH/uWXvK0UTM0No3MN87cAzuewbm5KHDhn4C2oLpYPs5lkgZu278mQ8EBn4MmFZOEPV sQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2r8rjuhvja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 01:51:08 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2J1p6fw015014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 01:51:07 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2J1p4N6003733;
        Tue, 19 Mar 2019 01:51:04 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Mar 2019 18:51:04 -0700
Subject: Re: [PATCH 6/8] skd: use blk_mq_queue_tag_busy_iter
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, jsmart2021@gmail.com,
        sagi@grimberg.me, josef@toxicpanda.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, hare@suse.de, jthumshirn@suse.de, hch@lst.de
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-7-git-send-email-jianchao.w.wang@oracle.com>
 <1552929635.152266.30.camel@acm.org>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d21aa530-7466-a21b-69f5-cfc8750c6e1a@oracle.com>
Date:   Tue, 19 Mar 2019 09:54:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552929635.152266.30.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9199 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190012
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart

Thanks so much for you comment for this.

After make blk_mq_queue_tag_busy_iter safer in patch 2, the patches that
replace blk_mq_tagset_busy_iter with blk_mq_queue_tag_busy_iter in drivers
are efforts to unify the tag iterate interface and finally we could remove
the blk_mq_tagset_busy_iter which is not safe.

The blk_mq_queue_tag_busy_iter will try to get a non-zero q_usage_counter
of a request_queue before it try to access the tags, so it could avoid the
race with the procedures that need to freeze and drain the queue, such as
update nr_hw_queues, switch io scheduler and even queue clean up. And also
it iterate the static_rqs and needn't to worry about the stale requests issue.
So it is a safer interface. Although for shared tagset case, the driver
need to loop every request_queue itself with blk_mq_queue_tag_busy_iter,
but all of the work is in error handler path, so it should not be a big deal.


Thanks
Jianchao

On 3/19/19 1:20 AM, Bart Van Assche wrote:
> On Fri, 2019-03-15 at 16:57 +0800, Jianchao Wang wrote:
>> blk_mq_tagset_busy_iter is not safe that it could get stale request
>> in tags->rqs[]. Use blk_mq_queue_tag_busy_iter here.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>  drivers/block/skd_main.c | 4 ﭗ橸ṷ梧뇪觬(), 2 deletions(-)
>>
>> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
>> index ab893a7..60c34ff 100644
>> --- a/drivers/block/skd_main.c
>> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
>> index ab893a7..60c34ff 100644
>> --- a/drivers/block/skd_main.c
>> +++ b/drivers/block/skd_main.c
>> @@ -395,7 +395,7 @@ static int skd_in_flight(struct skd_device *skdev)
>>  {
>>         int count = 0;
>>  
>> -       blk_mq_tagset_busy_iter(&skdev->tag_set, skd_inc_in_flight, &count);
>> +       blk_mq_queue_tag_busy_iter(skdev->queue, skd_inc_in_flight, &count, true);
>>  
>>         return count;
>>  }
> 
> Hi Jianchao,
> 
> If you have a look at the skd_in_flight() callers you will see that the above
> change is not necessary.
> 
>> @@ -1916,7 +1916,7 @@ static bool skd_recover_request(struct request *req, void *data, bool reserved)
>>  
>>  static void skd_recover_requests(struct skd_device *skdev)
>>  {
>> -	blk_mq_tagset_busy_iter(&skdev->tag_set, skd_recover_request, skdev);
>> +	blk_mq_queue_tag_busy_iter(skdev->queue, skd_recover_request, skdev, true);
>>  }
> 
> Same comment here. If you have a look at the callers of this function you will
> see that this change is not necessary.
> 
> Thanks,
> 
> Bart.
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwIGgQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=sLURgJ0-Ppht_QzBm__dp4MAaPyGCYjTWVYVglTtnoQ&s=fmR2wU9GQUr-0yrG88JCs1afrjYTd9or1wPKyDKgemg&e=
> 
