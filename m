Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0EDC55ABD
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 18:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E285208D5
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 18:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hFeYp3c0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgKMSo3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 13:44:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35690 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKMSo3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 13:44:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ADIi6xX061440;
        Fri, 13 Nov 2020 18:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=ppJMIhYlqBV6/rBGDGgz0Uk1ihsDGAW72UdhWwrAbrs=;
 b=hFeYp3c0hPDpZ4exIjDAX3zMmvqSf0ON7IHRzoFEF01ENpDgF4frxakf+40G+VgNaxW7
 jsz1sn34nbPbHEi7KD7Ww9jIFT3do7M/3xv23bE5UzgHE5C3RO45bl465v52Bu5xI+nS
 3PJoYnsG7IoW9qYPcZO/SeHAWKqcxZ7eOP+fFe7KlCXMdaA25TuBHbqzdpic/fvCu6vc
 gS+xPTJFBnGqhrdpuBojSIvYyLAMQti5CfwDtkQ/sueNVkjxZ74uflWCFhM/XssDaF9w
 rD4UCe9qPLUFuC75q/qNiW2EtXJuxQ0pNwOZ8lDAulunrMCeYvDrqtPhxhql1lRRfD2u jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34nkhmbqdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 18:44:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ADIf2Ce189602;
        Fri, 13 Nov 2020 18:44:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34p5g5a52e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 18:44:19 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ADIiFTP012671;
        Fri, 13 Nov 2020 18:44:16 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Nov 2020 10:44:15 -0800
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org
Subject: Re: split hard read-only vs read-only policy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14klt9k0a.fsf@ca-mkp.ca.oracle.com>
References: <20201113084702.4164912-1-hch@lst.de>
Date:   Fri, 13 Nov 2020 13:44:13 -0500
In-Reply-To: <20201113084702.4164912-1-hch@lst.de> (Christoph Hellwig's
        message of "Fri, 13 Nov 2020 09:46:59 +0100")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9804 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=897 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9804 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=1 mlxlogscore=927 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130121
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Christoph,

> this series resurrects a patch from Martin to properly split the flag
> indicating a disk has been set read-only by the hardware vs the
> userspace policy set through the BLKROSET ioctl.

Looks good in general but two of my test cases failed. Will debug.

-- 
Martin K. Petersen	Oracle Linux Engineering
