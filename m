Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0534AC433DF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 13:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E5A2070B
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 13:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XYXveadh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgG2Nmk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:42:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37906 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2Nmk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 09:42:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TDfg86026932;
        Wed, 29 Jul 2020 13:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=7hDTZcL1H+gqmTNV7vM++HGqFdvOXEKkjw3kBgyuJMA=;
 b=XYXveadhbNeiaCS88febDCmnLiYPEYTnjJhz8Kek/8vzmaDmF4y8f/4bmA2m2V1MVvlR
 uKlNt5vq2gjKn5KvB6Way2OoqRw1rsZ2Ur9GG6p9GlGDzRZFUvpSXRojKSzFvEU3/wae
 oqUpuU8ozEHJSRxmABQ8RA0sX21N7Bs4RTr2dNdhzUodvVgHi6OKi/pP4lpFiQWqsaiA
 JkusBgTBXdGs/Zl4cwBt8H33C44BZBWtp2ENl6yqUBdmbAGScdmkiuh0Q3JdVDzZknO7
 bMkK50fkBz+fx7YytlP8VrOcIEkJDWcIunu+RTjKmymQrlw3OnDFknuW3YADgURfMW1L Qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 32hu1jnn52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 13:42:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TDgUtJ073072;
        Wed, 29 Jul 2020 13:42:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32hu5x0nfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 13:42:30 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06TDgL8a017184;
        Wed, 29 Jul 2020 13:42:21 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 06:42:20 -0700
Date:   Wed, 29 Jul 2020 16:42:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH v2] block/floppy: Prevent
 kernel-infoleak in raw_cmd_copyout()
Message-ID: <20200729134214.GA5493@kadam>
References: <20200728141946.426245-1-yepeilin.cs@gmail.com>
 <20200729115157.8519-1-yepeilin.cs@gmail.com>
 <20200729125820.GB1840@kadam>
 <f2cf6137-987a-ab41-d88a-6828d46c255f@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2cf6137-987a-ab41-d88a-6828d46c255f@linux.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290092
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 29, 2020 at 04:22:41PM +0300, Denis Efremov wrote:
> 
> On 7/29/20 3:58 PM, Dan Carpenter wrote:
> > Argh...  This isn't right still.  The "ptr" comes from raw_cmd_copyin()
> > 
> > ptr = kmalloc(sizeof(struct floppy_raw_cmd), GFP_KERNEL);
> > 
> 
> copy_from_user overwrites the padding bytes:
> 	ptr = kmalloc(sizeof(struct floppy_raw_cmd), GFP_KERNEL);
> 	if (!ptr)
> 		return -ENOMEM;
> 	*rcmd = ptr;
> 	ret = copy_from_user(ptr, param, sizeof(*ptr));
> 
> I think memcpy should be safe in this patch.

Oh yeah.  You're right.  My bad.  I just saw the:

	ptr->next = NULL;
	ptr->buffer_length = 0;
	ptr->kernel_data = NULL;

Assignments and I missed the copy_from_user.

regards,
dan carpenter

