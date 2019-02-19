Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA34C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 01:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9EC21738
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 01:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gr5iHHXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732699AbfBSB1E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:27:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39010 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfBSB1D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 20:27:03 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1J1Nnb6141573;
        Tue, 19 Feb 2019 01:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=R17V8XyrCVm8dipNbd4dGNKWnLfbOeh9TeYt21aXq3Y=;
 b=gr5iHHXxw0URdGMMccIML6YvVS0rh6SNdOTNmx2aH768ZYBU1VAg/i9LVEB/9mXnh7O6
 07FzLcqo68eMHjXAuRzwC7cnIhG9rStlhGG97Q01pcHSjkCL1NdaRF139p3hom9k+soM
 WCHA9RdLgXB6o/inqavKcXaiQqahOaxsGva16/IpA1sLlFxwZYRaJ8a+2tg7fS5NE2u1
 bQkrQyE36pEwcNczzHNmjBQFuWNaDa3uDM3cIWYy98GZMUN6EZlnN36KJCa43h1ad/kb
 gEo+ndG/ruiiJjA7mHrz2iDtwwed4AJDI1Lrc6wkYD0LeM3jf3vES/XqHwjE6OqDKhqp iQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qpb5r8b57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 01:26:52 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1J1QoRH017163
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 01:26:51 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1J1QnVj005140;
        Tue, 19 Feb 2019 01:26:49 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Feb 2019 17:26:49 -0800
Subject: Re: [RFC PATCH v2 0/9] Block/XFS: Support alternative mirror device
 retry
To:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca
References: <20190213095044.29628-1-bob.liu@oracle.com>
 <c2b6ec5c-ad8a-6f69-c8b9-8e264cc6aa0d@oracle.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <5053beac-658e-d6a7-bcf8-050e0590f18d@oracle.com>
Date:   Tue, 19 Feb 2019 09:29:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c2b6ec5c-ad8a-6f69-c8b9-8e264cc6aa0d@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9171 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902190008
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2/18/19 4:08 PM, jianchao.wang wrote:
> Hi Bob
> 
> On 2/13/19 5:50 PM, Bob Liu wrote:
>> Motivation:
>> When fs data/metadata checksum mismatch, lower block devices may have other
>> correct copies. e.g. If XFS successfully reads a metadata buffer off a raid1 but
>> decides that the metadata is garbage, today it will shut down the entire
>> filesystem without trying any of the other mirrors.  This is a severe
>> loss of service, and we propose these patches to have XFS try harder to
>> avoid failure.
>>
>> This patch prototype this mirror retry idea by:
>> * Adding @nr_mirrors to struct request_queue which is similar as
>>   blk_queue_nonrot(), filesystem can grab device request queue and check max
>>   mirrors this block device has.
>>   Helper functions were also added to get/set the nr_mirrors.
>>
>> * Introducing bi_rd_hint just like bi_write_hint, but bi_rd_hint is a long bitmap
>> in order to support stacked layer case.
> 
> Why does we need a bitmap to know which underlying device has been tried ?
> For example, the following scenario,
> 
>                     md8
>                    / | \
>                sda sdb sdc
> 
> If the the raid read the data from sda and fs check and find the data is corrupted.
> Then we may just need to let raid1 know that the data is from sda. Then based on this
> hint, raid1 could handle it with handle_read_error to try other replica and fix the
> error.

This doesn't work.
The md raid1 can only see IO success or failure, so fix_read_error won't fix this.
Sorry for the noise.

Thanks
Jianchao

> 
> If this is feasible, we just need to modify the bio as following and needn't add any
> bytes in it.
> 
> struct bio {
>     ...
>     union {
>         unsigned short bi_write_hint;
>         unsigned short bi_read_hint;
>     }
>     ...
> }
> 
> Thanks
> Jianchao
>>
>> * Modify md/raid1 to support this retry feature.
>>
>> * Adapter xfs to use this feature.
>>   If the read verify fails, we loop over the available mirrors and retry the read.
>>
>> * Rewrite retried read
>>   When the read verification fails, but the retry succeedes
>>   write the buffer back to correct the bad mirror
>>
>> * Add tracepoints and logging to alternate device retry.
>>   This patch adds new log entries and trace points to the alternate device retry
>>   error path.
>>
>> Changes v2:
>> - No more reuse bi_write_hint
>> - Stacked layer support(see patch 4/9)
>> - Other feedback fix
>>
>> Allison Henderson (5):
>>   Add b_alt_retry to xfs_buf
>>   xfs: Add b_rd_hint to xfs_buf
>>   xfs: Add device retry
>>   xfs: Rewrite retried read
>>   xfs: Add tracepoints and logging to alternate device retry
>>
>> Bob Liu (4):
>>   block: add nr_mirrors to request_queue
>>   block: add rd_hint to bio and request
>>   md:raid1: set mirrors correctly
>>   md:raid1: rd_hint support and consider stacked layer case
>>
>>  Documentation/block/biodoc.txt |   3 +
>>  block/bio.c                    |   1 +
>>  block/blk-core.c               |   4 ++
>>  block/blk-merge.c              |   6 ++
>>  block/blk-settings.c           |  24 +++++++
>>  block/bounce.c                 |   1 +
>>  drivers/md/raid1.c             | 123 ++++++++++++++++++++++++++++++++-
>>  fs/xfs/xfs_buf.c               |  58 +++++++++++++++-
>>  fs/xfs/xfs_buf.h               |  14 ++++
>>  fs/xfs/xfs_trace.h             |   6 +-
>>  include/linux/blk_types.h      |   1 +
>>  include/linux/blkdev.h         |   4 ++
>>  include/linux/types.h          |   3 +
>>  13 files changed, 244 insertions(+), 4 deletions(-)
>>
> 
