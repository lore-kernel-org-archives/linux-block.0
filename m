Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA59CC2D0E2
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 19:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B74223787
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 19:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZVGQbq6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIVTbC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 15:31:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35134 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVTbC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 15:31:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MJTDw5037166;
        Tue, 22 Sep 2020 19:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=lo0N7QaLiuq42DK3xUcu48IdgiLxDW2es6QF0rpgapg=;
 b=ZVGQbq6HISC2w0mjC3mcfLJRzW7899qRrcCw8miS6a9q1ZhYVPLuGCXCpXX+eXC5nmyP
 ME6NLuAt8B9B4egX+dUvgfK9xtIH1lxDVtKHwhw/QIqp8FQ/dNuYvNafv78VizAro0NI
 G0PXe7a+EyWVc6+MhDXTQc0oeXWyZC1TFiyu0hb0Sz2jkZ7xRKGZXkX8wE5V0Keq4+5/
 pFS7AOQQoqQ/nZF710vXnVCVEO/I4WFlYddL8UrmmR/oCMDpVKmEioow8VtZyEd2t7SO
 y7g+LUYg19Ks6Ew2NfmNvWlnGV+0zR7GceQd8X6aERqAKo43Lpa6oHZZG3oObIHE+nac 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33q5rgd3x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 19:30:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MJPQ2t154830;
        Tue, 22 Sep 2020 19:28:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33nuwyvk7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 19:28:55 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08MJSscg019845;
        Tue, 22 Sep 2020 19:28:55 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 12:28:53 -0700
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 3/6] block: use lcm_not_zero() when stacking
 chunk_sectors
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq13639r4po.fsf@ca-mkp.ca.oracle.com>
References: <20200922023251.47712-1-snitzer@redhat.com>
        <20200922023251.47712-4-snitzer@redhat.com>
Date:   Tue, 22 Sep 2020 15:28:51 -0400
In-Reply-To: <20200922023251.47712-4-snitzer@redhat.com> (Mike Snitzer's
        message of "Mon, 21 Sep 2020 22:32:48 -0400")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=1 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=1 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220151
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Mike,

> Like 'io_opt', blk_stack_limits() should stack 'chunk_sectors' using
> lcm_not_zero() rather than min_not_zero() -- otherwise the final
> 'chunk_sectors' could result in sub-optimal alignment of IO to
> component devices in the IO stack.
>
> Also, if 'chunk_sectors' isn't a multiple of 'physical_block_size'
> then it is a bug in the driver and the device should be flagged as
> 'misaligned'.

Looks good.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
