Return-Path: <SRS0=/Scz=CT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45B2C43461
	for <linux-block@archiver.kernel.org>; Thu, 10 Sep 2020 19:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8604E21D91
	for <linux-block@archiver.kernel.org>; Thu, 10 Sep 2020 19:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uFfkhAqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgIJTaY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:30:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56988 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgIJT3z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Sep 2020 15:29:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AJO3dK188331;
        Thu, 10 Sep 2020 19:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=K1QbJiCJUXRd9frfClKInO01DMENCng/7fwYBJX5YFs=;
 b=uFfkhAqVPRENf+NiejhgWgzXkL1Q8U43X7C9HcdYGLRTOg+YrW2PlHMntAyYgpveFup5
 YRJjfYDwPYQF2lscT9/0ZgGZa0+TxfZD+ypbRxbexhsD/a+izRCElYD6O4jDNt8tZHFc
 YDDhoyy8V2HOCfu03aMaDDO6q/z4mWMjL2QcqaMTiiUW2c59w+6aueuqVusjPpYDm2X6
 GnTIzqTEvHTtwMlisLFM/fnoLyAZqSH+1Mz7J3DJSG4qgQo7VEMI8Y5NwCn2x3S2Y8pe
 K4cA09Wv9kLN0K5BpBOt0/y0VyR+wcGZKH9UriNuySY5GvQ3G0deW8+EURqlZr6n7Ryu aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33c3ana368-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Sep 2020 19:29:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AJP9oH135955;
        Thu, 10 Sep 2020 19:29:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33cmkajt7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 19:29:50 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08AJTnSN018042;
        Thu, 10 Sep 2020 19:29:49 GMT
Received: from [10.191.236.131] (/10.191.236.131)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Sep 2020 12:29:48 -0700
Subject: Re: Revert "dm: always call blk_queue_split() in dm_process_bio()"
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        RAMANAN_GOVINDARAJAN <ramanan.govindarajan@oracle.com>,
        Somu Krishnasamy <somasundaram.krishnasamy@oracle.com>
References: <529c2394-1b58-b9d8-d462-1f3de1b78ac8@oracle.com>
 <20200910142438.GA21919@redhat.com>
From:   Vijayendra Suman <vijayendra.suman@oracle.com>
Organization: Oracle Corporation
Message-ID: <5261af10-bf5c-f768-dbeb-2e784a5823f9@oracle.com>
Date:   Fri, 11 Sep 2020 00:59:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910142438.GA21919@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9740 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100177
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9740 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100177
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Mike,

I checked with upstream, performance measurement is similar and shows 
performance improvement when 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74 is 
reverted.

On 9/10/2020 7:54 PM, Mike Snitzer wrote:
> [cc'ing dm-devel and linux-block because this is upstream concern too]
>
> On Wed, Sep 09 2020 at  1:00pm -0400,
> Vijayendra Suman <vijayendra.suman@oracle.com> wrote:
>
>>     Hello Mike,
>>
>>     While Running pgbench tool with  5.4.17 kernel build
>>
>>     Following performance degrade is found out
>>
>>     buffer read/write metric : -17.2%
>>     cache read/write metric : -18.7%
>>     disk read/write metric : -19%
>>
>>     buffer
>>     number of transactions actually processed: 840972
>>     latency average = 24.013 ms
>>     tps = 4664.153934 (including connections establishing)
>>     tps = 4664.421492 (excluding connections establishing)
>>
>>     cache
>>     number of transactions actually processed: 551345
>>     latency average = 36.949 ms
>>     tps = 3031.223905 (including connections establishing)
>>     tps = 3031.402581 (excluding connections establishing)
>>
>>     After revert of Commit
>>     2892100bc85ae446088cebe0c00ba9b194c0ac9d ( Revert "dm: always call
>>     blk_queue_split() in dm_process_bio()")
> I assume 2892100bc85ae446088cebe0c00ba9b194c0ac9d is 5.4-stable's
> backport of upstream commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74 ?
Yes
>>     Performance is Counter measurement
>>
>>     buffer ->
>>     number of transactions actually processed: 1135735
>>     latency average = 17.799 ms
>>     tps = 6292.586749 (including connections establishing)
>>     tps = 6292.875089 (excluding connections establishing)
>>
>>     cache ->
>>     number of transactions actually processed: 648177
>>     latency average = 31.217 ms
>>     tps = 3587.755975 (including connections establishing)
>>     tps = 3587.966359 (excluding connections establishing)
>>
>>     Following is your commit
>>
>>     diff --git a/drivers/md/dm.c b/drivers/md/dm.c
>>     index cf71a2277d60..1e6e0c970e19 100644
>>     --- a/drivers/md/dm.c
>>     +++ b/drivers/md/dm.c
>>     @@ -1760,8 +1760,9 @@ static blk_qc_t dm_process_bio(struct mapped_device
>>     *md,
>>              * won't be imposed.
>>              */
>>             if (current->bio_list) {
>>     -               blk_queue_split(md->queue, &bio);
>>     -               if (!is_abnormal_io(bio))
>>     +               if (is_abnormal_io(bio))
>>     +                       blk_queue_split(md->queue, &bio);
>>     +               else
>>                             dm_queue_split(md, ti, &bio);
>>             }
>>
>>     Could you have a look if it is safe to revert this commit.
> No, it really isn't a good idea given what was documented in the commit
> header for commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74 -- the
> excessive splitting is not conducive to performance either.
>
> So I think we need to identify _why_ reverting this commit is causing
> such a performance improvement.  Why is calling blk_queue_split() before
> dm_queue_split() benefiting your pgbench workload?
Let me know if you want to check some patch.
>
> Thanks,
> Mike
>
