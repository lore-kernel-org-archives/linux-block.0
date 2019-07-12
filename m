Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746FDC742A2
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 02:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3092084B
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 02:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ThpceOik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfGLCHM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 22:07:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60068 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfGLCHM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 22:07:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C24ive152789;
        Fri, 12 Jul 2019 02:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=1O+a8zU/pTxG5RusyzsKpmYdKee4MqcAOJTPVcylUhY=;
 b=ThpceOikmwkXZMzC1+uoShlkr1RIqe6hkQyocYeeh+z6ZezHCU6GtfXvxiFkFP47ZvxS
 x6DMKtRa/NktAqBVvPxoRfG+C/GSNsSvGtcsCIqB3qv/xCKmsSG4mSE5BwHjzWHl3Ie6
 v8Q+C+SZ0oo04QO8d5mpm0bTl5m6Wnpu1JaNJTDOdfwQ8BaTu5/RvPCr/nEZpy4JOhH6
 G9coe7zyPKxoX02IJuT9EshQX6amQuT31F6X0GXUmAUUhdRnpAJYf3rmcco8/ynGke6h
 b8XGUaO3IzZwDsqd5KIh2wtD13J5hemeu0Z+5DHUXfbYULTwwnVgH7f7eHA70W4q5G81 TQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tjm9r31pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 02:07:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C230Cp117101;
        Fri, 12 Jul 2019 02:07:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tnc8tvu3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 02:07:07 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6C2741p017758;
        Fri, 12 Jul 2019 02:07:05 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 19:07:04 -0700
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 1/3] block: set ioprio for zone-reset bio
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190710040224.12342-1-chaitanya.kulkarni@wdc.com>
        <20190710040224.12342-2-chaitanya.kulkarni@wdc.com>
Date:   Thu, 11 Jul 2019 22:07:02 -0400
In-Reply-To: <20190710040224.12342-2-chaitanya.kulkarni@wdc.com> (Chaitanya
        Kulkarni's message of "Tue, 9 Jul 2019 21:02:22 -0700")
Message-ID: <yq14l3s57ll.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120024
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Chaitanya,

> Set the current process's iopriority to the bio for REQ_OP_ZONE_RESET.

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
