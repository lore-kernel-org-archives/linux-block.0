Return-Path: <SRS0=ez2/=VO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8370C7618F
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 01:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30BA2173E
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 01:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0OGOPow+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbfGQB2A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 21:28:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37246 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfGQB2A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 21:28:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H1OHFi123718;
        Wed, 17 Jul 2019 01:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=nur+ZBZcC9PkVdT2v8g52d8+QHFAgnY37jOoCu7K2BA=;
 b=0OGOPow+riB+rRrY4Rdvxlnfb7MWvnGABUBH72dt6Xu4qY32latqcLTO754H0laG4NDZ
 Kk7LrwcJ82qq5inZvWXPNWO+0XnBS+IKE6PW34C8AZTW+qcysteQGlK6vA5qlf/Im9CE
 9fPj4XSfTpCLIFblh1oLL6UAN1u4iCK58kqZyEr3/Sa+IhYtH5wRHE5oylJM7mJyFw7K
 wLQUkUL1FvakJ/Sxmynv7Kh+2Nn4semJhpq4Opr6wkxle1wEviNFZV0xHuKII1/fVddE
 LTpzYhhEvMDpCLCGcmAUqIo1dYhQoCApw4Ke6avZi+rtVSJeDq1/1IiJNfyTRqQUP/10 8w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2tq78pqkxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 01:27:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H1Rl0b162828;
        Wed, 17 Jul 2019 01:27:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tsctwmy3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 01:27:55 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6H1RmIO024780;
        Wed, 17 Jul 2019 01:27:54 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 01:27:48 +0000
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] scsi: sd_zbc: Fix compilation warning
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190715053833.5973-1-damien.lemoal@wdc.com>
        <f4812ac1-dfae-73d7-4722-4158c38d2382@kernel.dk>
        <yq1ftn6121c.fsf@oracle.com>
        <BYAPR04MB5816AD75A6D989A8BA0B06D5E7C90@BYAPR04MB5816.namprd04.prod.outlook.com>
Date:   Tue, 16 Jul 2019 21:27:46 -0400
In-Reply-To: <BYAPR04MB5816AD75A6D989A8BA0B06D5E7C90@BYAPR04MB5816.namprd04.prod.outlook.com>
        (Damien Le Moal's message of "Wed, 17 Jul 2019 01:24:21 +0000")
Message-ID: <yq1woghzbzh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=882
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=938 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170015
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Damien,

> Do you want me to send a new version with updated commit message and
> Fixes tag ?  Or will you fix that when applying ?

Please send me a tweaked one and I'll apply it right away.

-- 
Martin K. Petersen	Oracle Linux Engineering
