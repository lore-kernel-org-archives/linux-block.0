Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25BFC43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 01:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07C120856
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 01:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="z4W/JVfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfDABqd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Mar 2019 21:46:33 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46662 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfDABqd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Mar 2019 21:46:33 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x311doQo152446;
        Mon, 1 Apr 2019 01:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XURvvysjbQ4/wJOJ0lUkFhLa06w7AVUceHU2RqSUXZ8=;
 b=z4W/JVfqBXWF8JLE8x6lTsGK3Ip3voCmoH5IeyGVJFoaq4yAJQ4BvgYvI6IkWDH7rVPN
 KCwrqyIX0hGnhLpA+RHXa5ka+mlFdRz0aqXc+tABC5GvTkVjG9mwscgRmhudlj75vJm+
 pgcX3TTqorPasFxBe5+1oqCpqklZiOVezPTxSgpIeUvskU0OeuAbeknPUKaBHC7z4T+t
 3V5I4Nmtw4rxleiaULu0eMr45+7jKqe2T3/JIWivcXi4MYP2DCsTud7FetHKKXhqwBaa
 qwhuC5w9EzspsP792RAhkX6z22Vz8KrbUsvpYqnTXQ/845eQIqBdFqSSHE6zitWuh/Ap hw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2rhwycvawr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 01:46:12 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x311kBtS010886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 01:46:11 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x311k97P025089;
        Mon, 1 Apr 2019 01:46:10 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 31 Mar 2019 18:46:08 -0700
Subject: Re: [PATCH 4/5] block: don't drain in-progress dispatch in
 blk_cleanup_queue()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
References: <20190331030954.22320-1-ming.lei@redhat.com>
 <20190331030954.22320-5-ming.lei@redhat.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <658802bd-99a5-6446-5059-8536febba05e@oracle.com>
Date:   Mon, 1 Apr 2019 09:50:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190331030954.22320-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9213 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010011
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/31/19 11:09 AM, Ming Lei wrote:
> Now freeing dispatch resource is moved to queue's release handler,
> we don't need to worry about the race between blk_cleanup_queue and
> run queue any more.
> 
> So don't drain in-progress dispatch in blk_cleanup_queue().

Unless this direction is not followed, how about we mention that this is revert
of prior two fixes (which are not required any longer) so that people working on
backport would feel much more easier to track the issue.

c2856ae2f315 ("blk-mq: quiesce queue before freeing queue")
1311326cf4755c7 ("blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()")

Thank you very much!

Dongli Zhang

> 
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: linux-scsi@vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> Cc: jianchao wang <jianchao.w.wang@oracle.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b3bbf8a5110d..491dc0295778 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -347,18 +347,6 @@ void blk_cleanup_queue(struct request_queue *q)
>  
>  	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
>  
> -	/*
> -	 * make sure all in-progress dispatch are completed because
> -	 * blk_freeze_queue() can only complete all requests, and
> -	 * dispatch may still be in-progress since we dispatch requests
> -	 * from more than one contexts.
> -	 *
> -	 * We rely on driver to deal with the race in case that queue
> -	 * initialization isn't done.
> -	 */
> -	if (queue_is_mq(q) && blk_queue_init_done(q))
> -		blk_mq_quiesce_queue(q);
> -
>  	/* for synchronous bio-based driver finish in-flight integrity i/o */
>  	blk_flush_integrity();
>  
> 
