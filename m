Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43086C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B7D208C4
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H2685615"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfF1UOT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:14:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41788 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfF1UOT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 16:14:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SKEBvX179436;
        Fri, 28 Jun 2019 20:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=fo9gm9gNaLtybFCkr0EGltBmAf9C9aJIyNOApyVZDDg=;
 b=H2685615gVOJpoBNFKcpAprsQIQESjJQ38ELqG5Ony9GcYX0GX3z0Ox5V8MDfKuxEmmK
 yVdsMRcc61iiHakMBPJF5PZW5zIvukPhjImovb685T9YozGMYpTzIionuCemYtgmem5U
 ZPPyqdNzs2sfllOdICyH4law+3brdGnoy90zi8PaW9fjumwpGcmLEsKF6ejayNazBLFM
 LJzA8A52r/ybfuxc5znafDhCc3tj4ClT/2I5eb5qBB3Rlfl+XS3CzoGx+AA3XXJbmlwL
 ekR19J/8HXeo/YwhHvTXNvHIFO6u05MYagU2pWe7gPh6gBLgNNns0R0W7qTLQPW3ccz2 Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t9brtqdtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 20:14:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SKDd5o102165;
        Fri, 28 Jun 2019 20:14:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2t9ace0p5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 20:14:10 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5SKE9Fb024885;
        Fri, 28 Jun 2019 20:14:09 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 13:14:09 -0700
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 3/4] block, documentation: Explain the word 'segments'
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
References: <20190628200745.206110-1-bvanassche@acm.org>
        <20190628200745.206110-4-bvanassche@acm.org>
Date:   Fri, 28 Jun 2019 16:14:07 -0400
In-Reply-To: <20190628200745.206110-4-bvanassche@acm.org> (Bart Van Assche's
        message of "Fri, 28 Jun 2019 13:07:44 -0700")
Message-ID: <yq1tvc9h3hs.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=841
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280231
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=896 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280231
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Bart,

> Several block layer users who are not kernel developers do not know
> that the word 'segment' refers to an element in a DMA scatter/gather
> list. Make the block layer documentation easier to understand by
> stating explicitly what the word 'segment' stands for.

I don't have a problem clarifying the documentation. But the sysfs knobs
have a "segment" suffix so for better or for worse it is part of the
block layer lingo.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
