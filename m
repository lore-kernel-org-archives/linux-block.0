Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C185C433FF
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 14:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6B421726
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 14:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bnilDgSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfHBOQu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:16:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56628 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfHBOQu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Aug 2019 10:16:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x72EDZTg108200;
        Fri, 2 Aug 2019 14:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Kc+1uUsKse/3+nDlkrNp/b9xVgecGlZcWytsS39Hp9Y=;
 b=bnilDgSWM0shJ1jzbwcljYgZWvTbzuzFNqkI490n4WP5IalxNmmzy3oxvBiARvgaH0yN
 k5wRYN62jNoXQ+OfP0kep0b689HoJS2Btvdy/UbHlI8Vo7/aDXv8ZxedmhOFtSOqgd6D
 bq7rFlKhOERk96NAjXNWNFDGyfFX2T+kb0ERI6fV64+uOhgWp71c8Qf5+Tg5uxbZlb/z
 c9+fxoK72wuFp0bkXVSxcaBWguG9d+NkPI/HWTRtpqs6SeTQw5dORTn0Y9nRtSiuGHWY
 UFQmobiOr8PeFucHMS2kiLDjYikiIlQ/QZ+ixF2FvJX8lX1R8NICunzSCBWPuL1IfyEr 7w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u0f8rjfqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 14:16:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x72EDRlf117655;
        Fri, 2 Aug 2019 14:16:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2u349f1mfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 14:16:00 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x72EFvWY015243;
        Fri, 2 Aug 2019 14:15:58 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Aug 2019 07:15:57 -0700
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        axboe@kernel.dk, jejb@linux.ibm.com, dennis@kernel.org,
        hare@suse.com, damien.lemoal@wdc.com, sagi@grimberg.me,
        dennisszhou@gmail.com, jthumshirn@suse.de, osandov@fb.com,
        ming.lei@redhat.com, tj@kernel.org, bvanassche@acm.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH V2 3/4] scsi: implement REQ_OP_ZONE_RESET_ALL
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
        <20190801172638.4060-4-chaitanya.kulkarni@wdc.com>
Date:   Fri, 02 Aug 2019 10:15:53 -0400
In-Reply-To: <20190801172638.4060-4-chaitanya.kulkarni@wdc.com> (Chaitanya
        Kulkarni's message of "Thu, 1 Aug 2019 10:26:37 -0700")
Message-ID: <yq1v9vfirfq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=901
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908020148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=957 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908020148
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Chaitanya,

> This patch implements the zone reset all operation for sd_zbc.c. We
> add a new boolean parameter for the sd_zbc_setup_reset_cmd() to
> indicate REQ_OP_ZONE_RESET_ALL command setup. Along with that we add
> support in the completion path for the zone reset all.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
