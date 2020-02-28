Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079B9C3F2D2
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 16:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8362467B
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 16:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WhuZQwKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgB1QMV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:12:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56392 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1QMV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 11:12:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SG8rIV177523;
        Fri, 28 Feb 2020 16:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=GQ+GrrZZEREBJ6pZFtKFK5HH2nQizyRqJ6jwWaZJ0mw=;
 b=WhuZQwKfpJtcGOrJZy9N6Fy2Q4eiwf0Sg0H08ce6knPITTwm2FfcxLK8KH52S++tB0A1
 RoJm+ToeRMSrARomC+8G1gSJS1aGNOOuTIh14G24ER44WhQEkkfViOLv2LIC8WnHobkg
 Ui7Crgt3NfFQ6HndrIegiCd3b7dhuDkCADcG/MUYwbZ12wChhNqDgG7Tuc9fShlbwci7
 SR5Gk9cxXOrmmXvCLd984a2y1JY9tDpJyWozkRf5cqAnn5CjXERPgBetgGeONpzL90dm
 HqgAaWcIn4V2GLikzg+uYlDAeDE0Iep0TEApbkmWz6/8iZrDa39Q9BEclkyxrYWTUxtn bA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2ydct3ksbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 16:12:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SG8E6d063741;
        Fri, 28 Feb 2020 16:12:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2ydj4r5gvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 16:12:07 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01SGC66t022907;
        Fri, 28 Feb 2020 16:12:07 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 08:12:06 -0800
Date:   Fri, 28 Feb 2020 19:11:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] loop: Fix IS_ERR() vs NULL bugs in loop_prepare_queue()
Message-ID: <20200228161158.GC4118@kadam>
References: <20200228141350.iaviwnry3z4ipjqe@kili.mountain>
 <c106c6ec-7171-3586-d5c5-5c14e386b3d5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c106c6ec-7171-3586-d5c5-5c14e386b3d5@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=894 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=973 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280128
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 28, 2020 at 07:25:58AM -0700, Jens Axboe wrote:
> On 2/28/20 7:13 AM, Dan Carpenter wrote:
> > The alloc_workqueue() function returns NULL on error, it never returns
> > error pointers.
> > 
> > Fixes: 29dab2122492 ("loop: use worker per cgroup instead of kworker")
> 
> I can't seem to find this commit?

I guess this went through Andrew Morton's tree.  I'll resend to him.

regards,
dan carpenter

