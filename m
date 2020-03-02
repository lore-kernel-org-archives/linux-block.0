Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA1FC3F2D1
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 12:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33917214DB
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 12:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ssu40JyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgCBMRA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:17:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbgCBMRA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 07:17:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 022CE5HG092421;
        Mon, 2 Mar 2020 12:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=saQf8udrO5ljQAJSWGGKFC+TWXSS0LQVNPjAb1EGFzg=;
 b=Ssu40JyAUe51lbVP3kGL7jIf+XTK/q7y1tlhtqOFLQNeRDv1tXnE6DzJFh6W0M+2BeXL
 2NSMa6g8s66QNbGsW3+p2vC/+Px46zIBHFLCc1B+u00jxxnL4ZiaDUhkByiyL85a7tHl
 2FN8mx2sTM+JGzRv+nZU8ugrFgnPLBwkqy2cv5tmvWS+Ct+vGoVR6N1vNzjKwC8UNWNW
 iXDfoAoXhiMES/+oftcE9lb0nWgblVS5blvH6NSYr6/dSfbE5q5phRIIVUMDq3BppxHv
 nDKbzMVpuV/ES+qXMkCGSFZxbl0Gz4SmRYHxo68M8iwFs/e74Tz1FS84a3LYsTMAD+F7 cQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2yffwqfbu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Mar 2020 12:16:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 022CD7Ch091345;
        Mon, 2 Mar 2020 12:16:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2yg1gv073e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Mar 2020 12:16:55 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 022CGrex000594;
        Mon, 2 Mar 2020 12:16:54 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Mar 2020 04:16:52 -0800
Subject: Re: [PATCH] block: keep bdi->io_pages in sync with max_sectors_kb for
 stacked devices
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <158290150891.4423.13566449569964563258.stgit@buzz>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <7133c4fb-38d5-cf1f-e259-e12b50efcb32@oracle.com>
Date:   Mon, 2 Mar 2020 20:16:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <158290150891.4423.13566449569964563258.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=18 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=18
 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003020093
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/20 10:51 PM, Konstantin Khlebnikov wrote:
> Field bdi->io_pages added in commit 9491ae4aade6 ("mm: don't cap request
> size based on read-ahead setting") removes unneeded split of read requests.
> 
> Stacked drivers do not call blk_queue_max_hw_sectors(). Instead they setup
> limits of their devices by blk_set_stacking_limits() + disk_stack_limits().
> Field bio->io_pages stays zero until user set max_sectors_kb via sysfs.
> 
> This patch updates io_pages after merging limits in disk_stack_limits().
> 
> Commit c6d6e9b0f6b4 ("dm: do not allow readahead to limit IO size") fixed
> the same problem for device-mapper devices, this one fixes MD RAIDs.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  block/blk-settings.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index c8eda2e7b91e..66c45fd79545 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -664,6 +664,8 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
>  		printk(KERN_NOTICE "%s: Warning: Device %s is misaligned\n",
>  		       top, bottom);
>  	}
> +
> +	t->backing_dev_info->io_pages = t->limits.max_sectors >> (PAGE_SHIFT-9);
>  }
>  EXPORT_SYMBOL(disk_stack_limits);
>  
> 

Nitpick.. (PAGE_SHIFT - 9)
Reviewed-by: Bob Liu <bob.liu@oracle.com>


