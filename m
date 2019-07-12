Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD12C742A5
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 02:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8912084B
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 02:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jLtVP+GS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfGLCKF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 22:10:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33614 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbfGLCKE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 22:10:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C29RlJ046000;
        Fri, 12 Jul 2019 02:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=RyM605Z/0iHNZWVV+erR9ZKSw8MMlP0VfyUcr14Ul5o=;
 b=jLtVP+GSigb1qoqPaBFUexFBZ3fPpgwrdax6Rp4/W0vaiH63urDPCFqTkZCnUor5QI2L
 lONM3r+qZVK+DKQY/bunMtDMTZK5/d/Zsj5/ASXRfXMqpKF6jVmmRV7B+B9RI+bml8Mu
 znd9FgKs96SyndcQvcig79JtKHMMWsQOa6/H/cKD45XwZaYwDk/FtOjMUVT2OdnC5SH7
 GVuHvaEoE9S5Nc7AEtF1QmhM6U6rL8VpRNyIuyzOfEOd8ZBH4xFZ/bzFmz2nako/MgAp
 2FoKdztzEakvYq+SNd24wq7Xoe2kGCx1U7fY8ejng8/9xHmXIoPz6HDr+kW7wDLLUSy5 0A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2tjkkq3298-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 02:10:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C28Aw6186527;
        Fri, 12 Jul 2019 02:09:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2tmwgyh2a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 02:09:59 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6C29w0f019113;
        Fri, 12 Jul 2019 02:09:58 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 19:09:58 -0700
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 2/3] block: set ioprio for flush bio
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
References: <20190710040224.12342-1-chaitanya.kulkarni@wdc.com>
        <20190710040224.12342-3-chaitanya.kulkarni@wdc.com>
Date:   Thu, 11 Jul 2019 22:09:54 -0400
In-Reply-To: <20190710040224.12342-3-chaitanya.kulkarni@wdc.com> (Chaitanya
        Kulkarni's message of "Tue, 9 Jul 2019 21:02:23 -0700")
Message-ID: <yq1zhlk3swd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=899
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=966 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120025
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Chaitanya,

> Set the current process's iopriority for flush bio.

Kind of weird for a flush command. But we might as well be consistent.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
