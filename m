Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446A0C4346E
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 15:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0151A238E3
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 15:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wm/rY2eE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgIXP62 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 11:58:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59964 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgIXP62 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 11:58:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OFZKWg125745;
        Thu, 24 Sep 2020 15:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=TItLMSlmVedz8D60wT2v3Gzregj/492Cx/940qop2ac=;
 b=Wm/rY2eE0euQtNye+YNcOppYVF/IIE0kfCnCnw/ed0fVYmhBz+y8s7IeNNcVaQKYwNpu
 CB96VViQBWoWtr7cwThuzxIhFun6tQrrBzdJVpTmfIC+MPaeFTMNwvWijxQzKxFiRiwn
 GGYwaRBzuTvd5MYZGKgXq5UEY8i0+Wb8YRkuhne6BU8XGZ/daibUwAaUv2nqx1dA/5Iu
 2C/k8b32RIS3BqkIpFAuOvKsXMFFWZJ3pSqSRfc6zczBOmqvJOiWRq205e46K+Ty7ra5
 UVJVd0lGq9bHapx+ylptn1mjqKBmIfZBtGTGawaKWsECQRQGWbb2W6vC/mPTyqSplBcO DQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33q5rgqgp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 15:58:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OFVSk0126419;
        Thu, 24 Sep 2020 15:58:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33nux303cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 15:58:18 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08OFwGRO022527;
        Thu, 24 Sep 2020 15:58:16 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 08:58:16 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 86D976A0109; Thu, 24 Sep 2020 11:59:46 -0400 (EDT)
Date:   Thu, 24 Sep 2020 11:59:46 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc:     SeongJae Park <sjpark@amazon.com>,
        SeongJae Park <sjpark@amazon.de>, axboe@kernel.dk,
        aliguori@amazon.com, amit@kernel.org, mheyne@amazon.de,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen-blkback: add a parameter for disabling of persistent
 grants
Message-ID: <20200924155946.GB6370@char.us.oracle.com>
References: <20200924101344.GN19254@Air-de-Roger>
 <20200924102714.28141-1-sjpark@amazon.com>
 <20200924104720.GO19254@Air-de-Roger>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924104720.GO19254@Air-de-Roger>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=941 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=954 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240118
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

.snip..
> > For the reason, I'd like to suggest to keep this as is for now and expand it
> > with the 'exceptions list' idea or something better, if a real use case comes
> > out later.
> 
> I agree. I'm happy to take patches to implement more fine grained
> control, but that shouldn't prevent us from having a global policy if
> that's useful to users.

<nods>
