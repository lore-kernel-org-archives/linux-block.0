Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D504DC33C99
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 03:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5009206F0
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 03:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TZMPVBb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgAGDtK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jan 2020 22:49:10 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47988 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgAGDtJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jan 2020 22:49:09 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0073haFG071883;
        Tue, 7 Jan 2020 03:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=xgOB4zomvRZ7adt771i27d5HYk/b2xGvueMjSRBRM0Y=;
 b=TZMPVBb+uOtU/gcle/QKM8B2FIjboW6jmmUoHSo34VgxWDhZ/MAjrp24Gxa93uMr149b
 GEj3YLdLV3Emue+ekpE8VYLTybPLfV4d79GJP5XI1uOH2wJ+ki0zaempt7/Dzcsk8BUm
 fl3rf+Z3+eYc5MH5d8pN/45ByFiEc/53fc2Fz4hep5jKHyzoCdT9oVOAvPQSJiX2uCcp
 ExeL2YvHSINzkKyZxbmaUwD4EB5oconu25l5++C42k7OG2u92Ib+A3jTNkuBG/LjSIF4
 7eJNfM0L6PeGVVw20Tzq0KKyXlnQUOS+GLMjTxQ1++Z02T9b6JtdTCnzO4I066IRk5vL 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xaj4tu0fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 03:48:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0073muCc037940;
        Tue, 7 Jan 2020 03:48:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xb46816s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 03:48:57 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0073mXJn007470;
        Tue, 7 Jan 2020 03:48:33 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jan 2020 19:48:33 -0800
To:     Balbir Singh <sblbir@amazon.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <axboe@kernel.dk>,
        <ssomesh@amazon.com>, <jejb@linux.ibm.com>, <hch@lst.de>,
        <mst@redhat.com>, <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use disk_set_capacity
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200102075315.22652-1-sblbir@amazon.com>
        <20200102075315.22652-6-sblbir@amazon.com>
Date:   Mon, 06 Jan 2020 22:48:30 -0500
In-Reply-To: <20200102075315.22652-6-sblbir@amazon.com> (Balbir Singh's
        message of "Thu, 2 Jan 2020 07:53:15 +0000")
Message-ID: <yq1blrg2agh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=788
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=846 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070028
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Balbir,

> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 5afb0046b12a..1a3be30b6b78 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3184,7 +3184,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
>  
>  	sdkp->first_scan = 0;
>  
> -	set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
> +	disk_set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
>  	sd_config_write_same(sdkp);
>  	kfree(buffer);

We already emit an SDEV_EVT_CAPACITY_CHANGE_REPORTED event if device
capacity changes. However, this event does not automatically cause
revalidation.

-- 
Martin K. Petersen	Oracle Linux Engineering
