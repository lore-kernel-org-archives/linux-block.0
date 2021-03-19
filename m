Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2495BC43381
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 09:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE23864F6A
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 09:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhCSJsj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 05:48:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52758 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCSJsU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 05:48:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12J9dnUk042618;
        Fri, 19 Mar 2021 09:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=SEAtkM0w4DEiPBQH9PWUjwAjyKt3uTwfJj3iDqVVRMA=;
 b=tRjsI8CYyp15K98dnUaEKKxoQlQxrM5yXr8enf415zb35+DQgHIJ5UWuvxBb7jQCf5nJ
 Pmein1VHUvX5DQPr3bgGOFKNNJrosbWx556FA3z+IbwQJu6rGvXfgBjxn+sfF71t4VWW
 MtxdzSBUTfNusRTIKFZx57UWIkeDiixUGDl2W8JagCJwjG7lrjglov6qeHNWIQ8vNpdO
 62D5XkUMkOGCuIXLGzN2wWqGHH2SiJFhjgStZlXiwdOKAsuVHsXNxh44dogSs48YsCd8
 XPJSXPy8DIHlsfRXa5mcavPawAo2xNWeMaEd0U3ftMcDP/Nr6TXnU+e6Y65VyW8x+ODL zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 378nbmjfx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 09:48:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12J9eDud033192;
        Fri, 19 Mar 2021 09:48:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3797b421rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 09:48:13 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12J9m9l4024988;
        Fri, 19 Mar 2021 09:48:12 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Mar 2021 02:48:08 -0700
Date:   Fri, 19 Mar 2021 12:47:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] loop: Fix missing max_active argument in
 alloc_workqueue call
Message-ID: <20210319094759.GH2087@kadam>
References: <20210318151626.17442-1-colin.king@canonical.com>
 <13a1d187-4d6d-9e06-b94a-553d872de756@kernel.dk>
 <62cd71bc-86e1-412d-b2b9-716c0f8021be@canonical.com>
 <d32641ca-e34a-2bfd-9b86-28c95546f434@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d32641ca-e34a-2bfd-9b86-28c95546f434@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190068
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190068
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 18, 2021 at 02:42:33PM -0600, Jens Axboe wrote:
> On 3/18/21 2:24 PM, Colin Ian King wrote:
> > On 18/03/2021 20:12, Jens Axboe wrote:
> >> On 3/18/21 9:16 AM, Colin King wrote:
> >>> From: Colin Ian King <colin.king@canonical.com>
> >>>
> >>> The 3rd argument to alloc_workqueue should be the max_active count,
> >>> however currently it is the lo->lo_number that is intended for the
> >>> loop%d number. Fix this by adding in the missing max_active count.
> >>
> >> Dan, please fold this (or something similar) in when you're redoing the
> >> series.
> >>
> > Appreciate this fix being picked up. Are we going to lose the SoB?
> 
> If it's being redone, would be silly to have that error in there. Do
> we have a tag that's appropriate for this? I often wonder when I'm
> folding in a fix. Ala Fixes-by: or something like that.

I've always lobied for a Fixes-from: tag, but the kbuild-bot tells
everyone to add a Reported-by: tag.  But then a lot of people are like
Reported-by doesn't make sense.  And other people are like Reported-by
is fine, what's wrong with it?

regards,
dan carpenter
