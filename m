Return-Path: <SRS0=nPog=C6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA72C43464
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 08:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F0C20773
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 08:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fmPpHWXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgIUIhS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 04:37:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46370 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgIUIhS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 04:37:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08L8YQFY033906;
        Mon, 21 Sep 2020 08:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=62a8UL3OAUMDd3tSQYkh5y5Nekyd00f1dKIe/NrNJ5Q=;
 b=fmPpHWXeFJhzH5FLrx97IwbMvH2hyuqAk5akxn+iPQGM/W+4nXfMA2fqQ6ISCgA1CX8X
 Ouyh+9R7onaGD7QfHTEi3vL10CEozciFkU4Xzcv550wJKwk686Ea+MzzdKjf8CCIzEsM
 IXpIX9XTI5eRZiTkqxFYoJ021HNO8gCaJ6eyhJfiug1EOF9ocG2ic6KZW/m5nOerqDsg
 rE7tjPVQ3X9K5LCf4qGLoWYGvjWT/CQObk7yoRQ6Z5Ih+t+gFe6Xl0rdhy8jrhrkr/B8
 2xmAoJ5vwJrmQhIaRcF/vXHl1mFDxMP4v54QzvnRArcrTf6oreb8CFmJNwTAMGsl6OgD mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 33n9dqv91t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 08:37:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08L8aHvL049498;
        Mon, 21 Sep 2020 08:37:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 33nujkbysr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 08:37:11 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08L8b7sY002472;
        Mon, 21 Sep 2020 08:37:09 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 01:37:07 -0700
Date:   Mon, 21 Sep 2020 11:37:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] lib/scatterlist: Fix memory leak in sgl_alloc_order()
Message-ID: <20200921083700.GB4282@kadam>
References: <e69e9865-a599-5bd9-95b1-7d57c7e2e90c@web.de>
 <1608a0b7-6960-afce-aa39-6785036b01e0@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608a0b7-6960-afce-aa39-6785036b01e0@interlog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9750 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=970 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9750 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210063
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We asked Markus over and over to stop sending these emails but he
refused so eventually he had to be banned from vger.  Unless you're
directly mentioned in the CC list then you can't see his emails.

regards,
dan carpenter

