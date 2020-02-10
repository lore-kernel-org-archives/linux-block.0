Return-Path: <SRS0=SfBO=36=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFB3C352A4
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 23:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD39120733
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 23:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G7rLeEN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgBJXGq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Feb 2020 18:06:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52576 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBJXGq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 18:06:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01AN4Rsd122034;
        Mon, 10 Feb 2020 23:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=rnHskqOXFi2BvvIOFheNkMF38AvCeFoaUpqyawzkQdM=;
 b=G7rLeEN9eayeFp62JvVGFEotXsvukzTzXzGjZS9BfTNhhYVouKwnTiMiKcwA15lOQusE
 i1boV7NpPTjUGN+2DKvj0sDq3uXmisD3xnz+ESEQ1mGB1lpopJAOpQSNVpOFTF2QApkh
 triavkevstKa+jJkt43h2QFUblmllvurY8eg38wOTOLuBYyOk86hWlo02sh3Hu8vEmvw
 bPbA3CcUIjTc6IFqXfqs88rEreG8GcDnvz0UYcQhdbP3X7ZInOdXDNCH2VeVHgxw+Szn
 nogeX0S5DhyQLHSV5yXf34/nimeDHIjo4P7aIOjhuqR3nob0yeYnunHzuKhaQl8PvX+Y 7w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2y2k87ywvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Feb 2020 23:06:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01AN6DIa006247;
        Mon, 10 Feb 2020 23:06:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2y26htudb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 23:06:41 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01AN6eak026130;
        Mon, 10 Feb 2020 23:06:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Feb 2020 15:06:39 -0800
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, damien.lemoal@wdc.com
Subject: Re: [PATCH v2] block: support arbitrary zone size
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200210220816.GA7769@avx2> <20200210222045.GA1495@avx2>
Date:   Mon, 10 Feb 2020 18:06:38 -0500
In-Reply-To: <20200210222045.GA1495@avx2> (Alexey Dobriyan's message of "Tue,
        11 Feb 2020 01:20:45 +0300")
Message-ID: <yq1sgjiujnl.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100162
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Alexey,

> SK hynix is going to ship ZNS device with zone size not being power of 2.

That is going to wreak havoc all over the place. We have always stated
to device vendors that Linux only supports block and zone sizes that are
powers of two.

-- 
Martin K. Petersen	Oracle Linux Engineering
