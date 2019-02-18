Return-Path: <SRS0=V8DZ=QZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5052AC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 08:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061B42070D
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 08:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qUB1ne2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfBRIGs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:06:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55818 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBRIGs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 03:06:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1I83u5o129822;
        Mon, 18 Feb 2019 08:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=tSdbvmMOHmJ6sUcj3Ui1o7OgG+uGlQ5wXEKiCaY6PBk=;
 b=qUB1ne2GH1x5LJVvmoEJ/T1DjDtGWcsWaTMDMLyhwCl1hDRw3itdAV7iRVAOcddJtoxK
 y5tvjNSCumEVHZ0TNXKc3/1uytbeYNYl6dol0bJEgz5Vo7Zn5GfAJGw5ZbaXDhOfakzV
 ArclPSNzgfZnKVL6LmqNwumJavosSM8dXptCPSCCrebPUuR+JZ3MDHY06l1ewbzHO2mC
 QAGqfUTCOoiBdphx2w48P4FCI8Zk6BKTj+gs1w+WdPpmP+dC+mOqFkbrDkfmUzP/YPwa
 E3T5QiGE5LofrAeoq6z5S7EeGKQKMIDcXRiLK2oQ6U5l/M+DwVTbDbwKoayMybcRTHvX Vg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qp9xtmt1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 08:06:33 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1I86QtT029833
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 08:06:27 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1I86QrX032365;
        Mon, 18 Feb 2019 08:06:26 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Feb 2019 00:06:25 -0800
Subject: Re: [RFC PATCH v2 0/9] Block/XFS: Support alternative mirror device
 retry
To:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca
References: <20190213095044.29628-1-bob.liu@oracle.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <c2b6ec5c-ad8a-6f69-c8b9-8e264cc6aa0d@oracle.com>
Date:   Mon, 18 Feb 2019 16:08:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213095044.29628-1-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9170 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902180064
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bob

On 2/13/19 5:50 PM, Bob Liu wrote:
> Motivation:
> When fs data/metadata checksum mismatch, lower block devices may have other
> correct copies. e.g. If XFS successfully reads a metadata buffer off a raid1 but
> decides that the metadata is garbage, today it will shut down the entire
> filesystem without trying any of the other mirrors.  This is a severe
> loss of service, and we propose these patches to have XFS try harder to
> avoid failure.
> 
> This patch prototype this mirror retry idea by:
> * Adding @nr_mirrors to struct request_queue which is similar as
>   blk_queue_nonrot(), filesystem can grab device request queue and check max
>   mirrors this block device has.
>   Helper functions were also added to get/set the nr_mirrors.
> 
> * Introducing bi_rd_hint just like bi_write_hint, but bi_rd_hint is a long bitmap
> in order to support stacked layer case.

Why does we need a bitmap to know which underlying device has been tried ?
For example, the following scenario,

                    md8
                   / | \
               sda sdb sdc

If the the raid read the data from sda and fs check and find the data is corrupted.
Then we may just need to let raid1 know that the data is from sda. Then based on this
hint, raid1 could handle it with handle_read_error to try other replica and fix the
error.

If this is feasible, we just need to modify the bio as following and needn't add any
bytes in it.

struct bio {
    ...
    union {
        unsigned short bi_write_hint;
        unsigned short bi_read_hint;
    }
    ...
}

Thanks
Jianchao
> 
> * Modify md/raid1 to support this retry feature.
> 
> * Adapter xfs to use this feature.
>   If the read verify fails, we loop over the available mirrors and retry the read.
> 
> * Rewrite retried read
>   When the read verification fails, but the retry succeedes
>   write the buffer back to correct the bad mirror
> 
> * Add tracepoints and logging to alternate device retry.
>   This patch adds new log entries and trace points to the alternate device retry
>   error path.
> 
> Changes v2:
> - No more reuse bi_write_hint
> - Stacked layer support(see patch 4/9)
> - Other feedback fix
> 
> Allison Henderson (5):
>   Add b_alt_retry to xfs_buf
>   xfs: Add b_rd_hint to xfs_buf
>   xfs: Add device retry
>   xfs: Rewrite retried read
>   xfs: Add tracepoints and logging to alternate device retry
> 
> Bob Liu (4):
>   block: add nr_mirrors to request_queue
>   block: add rd_hint to bio and request
>   md:raid1: set mirrors correctly
>   md:raid1: rd_hint support and consider stacked layer case
> 
>  Documentation/block/biodoc.txt |   3 +
>  block/bio.c                    |   1 +
>  block/blk-core.c               |   4 ++
>  block/blk-merge.c              |   6 ++
>  block/blk-settings.c           |  24 +++++++
>  block/bounce.c                 |   1 +
>  drivers/md/raid1.c             | 123 ++++++++++++++++++++++++++++++++-
>  fs/xfs/xfs_buf.c               |  58 +++++++++++++++-
>  fs/xfs/xfs_buf.h               |  14 ++++
>  fs/xfs/xfs_trace.h             |   6 +-
>  include/linux/blk_types.h      |   1 +
>  include/linux/blkdev.h         |   4 ++
>  include/linux/types.h          |   3 +
>  13 files changed, 244 insertions(+), 4 deletions(-)
> 
