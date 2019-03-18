Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C95C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 02:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67ED920857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 02:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d0pRE4eL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfCRCpX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 22:45:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39974 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCRCpX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 22:45:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2I2iAM4070187;
        Mon, 18 Mar 2019 02:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=+H8sO4+ai3RUeaP13YotfoTwvVomwWWJy0pTcu/ByDw=;
 b=d0pRE4eLYhZH2blv1a2LtoyvQ+bHTjlzropLO8miLwbAJ6Ah9r4vnAXp2VJhYObnQ8pw
 6sCNdVFNelO9W4y7TDL8b6xjYn1RmBGCNOpLP7qJ0Un3tigLymjzPGiWHePHllt5ovHZ
 3bg15Dfj+DP0R3so/V0vT6XSwCzEpri/JowTkhvT5pD2287oep2UC9KkheICkVTRENlT
 Dxk1iWlVswvYUHLkM458VEbOfeJLEJW1bXHVPhZdR7o1J11WEae/ZcWdXikoGkav5x71
 8j9k9gCTmTIEAUoQeDoFw+6pfJCHshSdFxEqK5M/kziuNxoUogam0CzlnMpk/b7sAYgS 8Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2r8ssr3qrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 02:45:00 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2I2ir5I008309
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 02:44:53 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2I2ioML005642;
        Mon, 18 Mar 2019 02:44:50 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 17 Mar 2019 19:44:49 -0700
Subject: Re: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jsmart2021@gmail.com,
        josef@toxicpanda.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, keith.busch@intel.com, hare@suse.de,
        jthumshirn@suse.de, sagi@grimberg.me
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <20190315092020.GA2405@lst.de>
 <a36be8bd-bb9c-745e-cfdb-018cf0a96d42@oracle.com>
 <1552666744.45180.135.camel@acm.org>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <8cff92a3-2f25-18a7-265f-9bff7d8cc3fc@oracle.com>
Date:   Mon, 18 Mar 2019 10:47:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552666744.45180.135.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9198 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903180020
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart

On 3/16/19 12:19 AM, Bart Van Assche wrote:
>> This stale request maybe something that has been freed due to io scheduler
>> is detached or a q using a shared tagset is gone.
>>
>> And also the blk_mq_timeout_work could use it to pick up the expired request.
>> The driver would also use it to requeue the in-flight requests when the device is dead.
>>
>> Compared with adding more synchronization, using static_rqs[] directly maybe simpler :)
> Hi Jianchao,
> 
> Although I appreciate your work: I agree with Christoph that we should avoid races
> like this rather than modifying the block layer to make sure that such races are
> handled safely.

The root cause here is that there is window between set tag sbitmap and set tags->rqs[]
, and we don't clear the tags->rqs[] in free tags path. So when we iterate the busy
tags, we could see stale requests in tags->rqs[] and this stale requests maybe freed.

Looks like it is difficult to close the window above, so we used to try to clear the
tags->rqs[] in two ways,

1. clear the tags->rqs[] in the request free path
Jens doesn't like it
https://marc.info/?l=linux-block&m=154515671524877&w=2
"
It's an extra store, and it's a store to an area that's then now shared
between issue and completion. Those are never a good idea. Besides, it's
the kind of issue you solve in the SLOW path, not in the fast path. Since
that's doable, it would be silly to do it for every IO.
"

2. clear the associated slots in tags->tags[] when blk_mq_free_rqs
https://marc.info/?l=linux-block&m=154534605914798&w=2

+	rcu_read_lock();
 	sbitmap_for_each_set(&bt->sb, bt_iter, &iter_data);
+	rcu_read_unlock();

The busy_iter_fn could sleep
blk_mq_check_expired
  -> blk_mq_rq_timed_out
    -> q->mq_ops->timeout
       nvme_timeout
         -> nvme_dev_disable
            -> mutex_lock dev->shutdown_lock

Since it is not so flexible to fix on tags->rqs[], why not try to use tags->static_rqs[] ?
Then we wound never care about the stable requests any more.

Thanks
Jianchao
