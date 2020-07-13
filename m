Return-Path: <SRS0=ze0F=AY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D02C433E3
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 16:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F8D207BC
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 16:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iOXy+Dt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgGMQr7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:47:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49374 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgGMQr7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jul 2020 12:47:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DGl3Xr048465;
        Mon, 13 Jul 2020 16:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=VTKq9lVjDy0fpYpsFjVbxDAxgxb2mzMrc6KMJp6Es/4=;
 b=iOXy+Dt5fF1wBTR06n55eXfMMnHQpje+N3h7hT0kL3LPww2kdcuLwJfmJ0XEMAJ9pXxP
 tZciWstlSFuJwwl10ZrBzpMJq2+ARnokEXBaef0XiBlHojftvn5FAXxmvTkTQsPOiOoI
 diJRyhdkTAQ4HJCKXN9oimPwkQJAQ+qGB+tfVzQ55YfBVvYSEY8VMT/ppLlZVJrqUrlC
 i1nVZf2aR33PNzGOVf+UDzBaXdFDyhMdQuSe/I0X3UmC7qrDfQlScWoGxCRQnDkIcyaB
 s5/LdIYNqTnriRRklsJHK0JI1Y/y6okBa6odRFtb/8H43W6iBy+F4/j42f4Sq4ONnEGa uQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32762n82ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jul 2020 16:47:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DGMZPU094443;
        Mon, 13 Jul 2020 16:47:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 327qbvw1qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 16:47:40 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06DGlcx6031658;
        Mon, 13 Jul 2020 16:47:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Mon, 13 Jul 2020 09:47:30 -0700
ORGANIZATION: Oracle Corporation
MIME-Version: 1.0
Message-ID: <yq14kqbtllo.fsf@ca-mkp.ca.oracle.com>
Date:   Mon, 13 Jul 2020 09:47:28 -0700 (PDT)
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Coly Li <colyli@suse.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Acshai Manoj <acshai.manoj@microfocus.com>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>, Xiao Ni <xni@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Enzo Matsumiya <ematsumiya@suse.com>
Subject: Re: [PATCH 2/2] block: improve discard bio alignment in
 __blkdev_issue_discard()
References: <20200713123511.19441-1-colyli@suse.de>
 <20200713123511.19441-3-colyli@suse.de>
In-Reply-To: <20200713123511.19441-3-colyli@suse.de> <(Coly> <Li's> <message>
 <of> <"Mon> <> <13> <Jul> <2020> <20:35:11> <+0800")>
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 suspectscore=1 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130121
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Coly!

> This patch improves discard bio split for address and size alignment
> in __blkdev_issue_discard(). The aligned discard bio may help
> underlying device controller to perform better discard and internal
> garbage collection, and avoid unnecessary internal fragment.

If the aim is to guarantee that all discard requests, except for head
and tail, are aligned multiples of the discard_granularity, you also
need to take the discard_alignment queue limit and the partition offset
into consideration.

-- 
Martin K. Petersen	Oracle Linux Engineering
