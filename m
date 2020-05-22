Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A60C433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 13:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E2E20679
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 13:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TqrTc+G8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgEVN26 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 09:28:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49688 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgEVN26 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 09:28:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MDRWFn100636;
        Fri, 22 May 2020 13:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=wJj/TOJ6M1t5cfmt+N94dEWcPKX/nTIvr6VL+0kO4SI=;
 b=TqrTc+G8JBybFizewgrreitt3mw0VvHVgSL9ltZcik1FLZn9T5MJy4h82rd9/Jj+Kwv6
 AEAzctPEEfiaRNNNzfYPdb8sKRxtqf9GWeVMnXWKm7dAYx7mChUM48jAOJd1h+yc3Mqp
 pA+ON8loBffZsTNDmsqZ0OQ43HGComdRj8/nX1ogSNAuYiOJUKx0JFiLPyejPU8sjfH6
 Y/NfmYtrWlrwumjV4cfg53ULXj46YCMdjLIibOUp9jU+eB5W+xXQZ0kJwV+NG+UJd4gL
 C0jTfwib/4JucFQtPd8TH0BA0TuzGoUXqpV4VRDWtAig6H9ZmUUOcuysjW0Yg0fSDNsc fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31501rm95f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 13:28:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MDSjh4174114;
        Fri, 22 May 2020 13:28:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 313gj7g554-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 May 2020 13:28:46 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04MDSdHN010303;
        Fri, 22 May 2020 13:28:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 May 2020 06:28:38 -0700
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH] block: Improve io_opt limit stacking
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lflkp0b9.fsf@ca-mkp.ca.oracle.com>
References: <20200514065819.1113949-1-damien.lemoal@wdc.com>
        <BY5PR04MB6900144BD2729172EBF5DF2EE7B40@BY5PR04MB6900.namprd04.prod.outlook.com>
Date:   Fri, 22 May 2020 09:28:36 -0400
In-Reply-To: <BY5PR04MB6900144BD2729172EBF5DF2EE7B40@BY5PR04MB6900.namprd04.prod.outlook.com>
        (Damien Le Moal's message of "Fri, 22 May 2020 07:27:11 +0000")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=1 mlxlogscore=862
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=895 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005220110
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Damien,

>> +	if (t->io_opt & (t->physical_block_size - 1))
>> +		t->io_opt = lcm(t->io_opt, t->physical_block_size);

> Any comment on this patch ?  Note: the patch the patch "nvme: Fix
> io_opt limit setting" is already queued for 5.8.

Setting io_opt to the physical block size is not correct.

-- 
Martin K. Petersen	Oracle Linux Engineering
