Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2987BC433DF
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 15:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090512072C
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 15:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LzBmRpRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgEVPof (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 11:44:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49360 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgEVPoe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 11:44:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MFbWvx009979;
        Fri, 22 May 2020 15:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+b1bOSIszfpMRVfqY109cXHEdPKXGGwLiyk7E6kPnXc=;
 b=LzBmRpRBPFEXBqV0aYvh0i0Pk9OE9S3X8z6sPJy3IiezLo3sPvvqwcQK1MFX1+DxGOSI
 cda8QE22ErB/NCbr5TYZ08EpjRdNnTTIrgc8DEjP6WoYUW5TOHP9q6dT+deOrtm7zOsS
 kJEtJzhrWLP8ZLK5C76ezW7IttALTFUZZ35UHbq7L0Sc5YEVGiyAZzpgdvBp0NLFB+UR
 Q4KeX9BOdwFhdspjqpfbhD/T8X7fjTZbTRODiJ3mQqClf9NQRRyLyMOGuUro1kimH5k4
 oqMvRZrwzyeyLbkLLdF2b/y0yHBrQtQ1nqiq24i2tFo+JrsXx2Met8TACbWv3jScFtF5 BQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3127krpg1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 15:44:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MFdKCd100562;
        Fri, 22 May 2020 15:44:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 315024ha6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 May 2020 15:44:25 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04MFiNqS032398;
        Fri, 22 May 2020 15:44:23 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 May 2020 08:44:22 -0700
Date:   Fri, 22 May 2020 18:44:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] block/rnbd: Fix an IS_ERR() vs NULL check in
 find_or_create_sess()
Message-ID: <20200522154403.GN30374@kadam>
References: <20200519120347.GD42765@mwanda>
 <CAMGffEnuk2WfWmwjKy_Sqcuf_xKwzrPpE_o8j3nHM30ADr8HVw@mail.gmail.com>
 <CAMGffEmC215iOmtT_iZizey=jnbgWneE5f5zapYvdJi5WYDM1w@mail.gmail.com>
 <20200522144831.GH17583@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522144831.GH17583@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9629 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9629 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005220126
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 22, 2020 at 11:48:31AM -0300, Jason Gunthorpe wrote:
> On Fri, May 22, 2020 at 07:13:08AM +0200, Jinpu Wang wrote:
> > On Tue, May 19, 2020 at 2:52 PM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
> > >
> > > On Tue, May 19, 2020 at 2:04 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > >
> > > > The alloc_sess() function returns error pointers, it never returns NULL.
> > > >
> > > > Fixes: f7a7a5c228d4 ("block/rnbd: client: main functionality")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Thanks Dan,
> > > Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > 
> > Hi Jason,
> > 
> > Could you also queue this fix for for-next?
> 
> Uhh.. Yes OK, but if it doesn't get cc'd to linux-rdma I won't see it..
> 

I suspect that we should update MAINTAINERS so that
./scripts/get_maintainer.pl gives the right lists.  Proabably all
drivers/block/rnbd/ patches are supposed to go through you?

regards,
dan carpenter

