Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B16C169C4
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 01:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B075E21473
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 01:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GhYlrmpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfA3BLX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:11:23 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51874 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfA3BLX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 20:11:23 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0U13vpj020562;
        Wed, 30 Jan 2019 01:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=IFuXM0fgA7l8lZxzK+vZ9dchzz69vPVSXzmJk473HGc=;
 b=GhYlrmpXM1qMGL3PleHikKiYBmGsJFpbxQEpOHvFcotYJTgpUbD6GGAiQXZQCKW3Uj91
 vmZfAWMmSl9V2RH4RbBmLp+qm0rm4RGma4T6DeX3gfovP7/0rreR2SXDYj3vnM2oXVDg
 89ic+gnoIE9EGnVT9Cn4va0mc9J4GZpfL7HL040OShpY21BQirMB5cxqqLQoGXNwxs5F
 yaoPYegaC20PicfnBm7CrnIDeLYj+ORUhMUC1LyE34MnywbwM1rQSwOXY0XP+TGOfRY1
 KmZ/iBKvldXdvCUJIoWAjh7y2KGT6Wtu+Z3oOY83MfK6RhIE6WZ6cHw+n9mCbpcLdGkN kQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2q8d2e811k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 01:11:17 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0U1BGdq015734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 01:11:17 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0U1BFRA028316;
        Wed, 30 Jan 2019 01:11:16 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Jan 2019 17:11:15 -0800
Subject: Re: fsync hangs after scsi rejected a request
To:     Florian Stecker <m19@florianstecker.de>,
        Ming Lei <tom.leiming@gmail.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
References: <70df6d90-31eb-96f4-908d-462ea58dea6e@florianstecker.de>
 <CACVXFVOSHtV7jcMwEvDKZzPnsLRzkdvAEqb+ggugkM27LJvagg@mail.gmail.com>
 <a30b5868-dd7d-d3db-b7f4-c723ac279ead@florianstecker.de>
 <CACVXFVOzwaZyJFaOJw3K-FQUHeYGWNx8sPr8kqJzCV59Rd6sqg@mail.gmail.com>
 <e18051e3-4008-e259-dee3-dd58f23642ab@oracle.com>
 <4b631218-49ee-c3ed-46be-17f9d30b663f@florianstecker.de>
 <c42631fa-3e61-e046-851e-8079906a14fb@oracle.com>
 <d9fd42a9-6105-2404-6e74-cc540da1cf16@florianstecker.de>
 <3d921990-06c4-4662-2853-7667b4e9a462@oracle.com>
 <4fe48ebc-43db-7ada-087b-5ccbdb64cc66@oracle.com>
 <00501045-a87b-27d0-6373-72dcf243b32b@florianstecker.de>
 <a7a3e95e-5c66-31d6-c442-ad295f82d72c@oracle.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <c5f74f0b-5a03-0478-0a5e-2232ab28713c@oracle.com>
Date:   Wed, 30 Jan 2019 09:13:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a7a3e95e-5c66-31d6-c442-ad295f82d72c@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9151 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901300005
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Florian

On 1/28/19 10:42 AM, jianchao.wang wrote:
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index a3fc7191..6e0f2d9 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -335,7 +335,7 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
>         blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error);
>         spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
>  
> -       blk_mq_run_hw_queue(hctx, true);
> +       blk_mq_sched_restart(hctx);
>  }

Does this patch work ?

Thanks
Jianchao
