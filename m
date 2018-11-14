Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905FEC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 02:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4191D21582
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 02:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vwq5UN/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4191D21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeKNMai (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:30:38 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeKNMai (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 07:30:38 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAE2O1fg018183;
        Wed, 14 Nov 2018 02:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=fCWclTpGextYAo3IJxTrGT+yX1+GwyToMhkIwmp05ao=;
 b=Vwq5UN/wQJ6VymD0CQpLl6NlsfxNZ4O+395Vy1HquQ0Swylq+kd/HuQrMK6bPoKNvCe/
 qYgrcW7/raQHk7+4vEF8nydRSsJfBchwQimDWt7uJelko1I3z7d5Dh0TE5pWmsOmPeMJ
 kiUo3bCUfYgDVgSnBsJkSQZ+zM4eXxQLP8qyolhuspWihvT1DnGXbGWMAzHTDFsQb6CC
 6oZx51BSLumHePwkcCR/7ssdhsKPr3upNHTlWlq1qIrU/bC53vCxLQUzNtQlauCY+n6o
 64Mi3EySBS+VHcG+vJZGT/3y++zdpPMDHol/nYOI4SVFXsNv1yR4SBGhFTp+SBWkX1C5 pw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2nr7cs0ped-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 02:29:29 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAE2TSL3031710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 02:29:29 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAE2TS3o005555;
        Wed, 14 Nov 2018 02:29:28 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Nov 2018 18:29:28 -0800
Subject: Re: [PATCH 05/11] block: avoid ordered task state change for polled
 IO
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20181113154233.15256-1-axboe@kernel.dk>
 <20181113154233.15256-6-axboe@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <cc187e6f-dd59-8986-057a-99fbc247efd5@oracle.com>
Date:   Wed, 14 Nov 2018 10:29:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113154233.15256-6-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9076 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=802
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811140020
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens

On 11/13/18 11:42 PM, Jens Axboe wrote:
> @@ -181,6 +181,7 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
>  	struct task_struct *waiter = bio->bi_private;
>  
>  	WRITE_ONCE(bio->bi_private, NULL);
> +	smp_wmb();
>  	wake_up_process(waiter);
>  }


The wake up path has contained a full memory barrier with the raw_spin_lock
and following smp_mb__after_spinlock

Please refer to:

wake_up_process
  -> try_to_wake_up

	raw_spin_lock_irqsave(&p->pi_lock, flags);
	smp_mb__after_spinlock();

So the smp_wmb here is not necessary.

Thanks
Jianchao
