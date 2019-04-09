Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53695C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 11:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233D22133D
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 11:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oty1tY91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfDIL2B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:28:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34010 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfDIL1s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 07:27:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x39BIrr7142644;
        Tue, 9 Apr 2019 11:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=pWumepPcTxhskpyg9O7WSTJj/P75JPumuGN+584Dbmo=;
 b=oty1tY91/H+AyPcA+OFlR01ADnIAdD5RYuOX4fTotexzQ93/47Rsz30pU1pmhbZPTkPL
 99IsQCtoPjGsTMQ/4C/nG9pka9BkKSHM95E02AaLs4JEZmV4Jj5kXbUf5ntOOTZqO+hp
 rbEHRfdzeFo+/UNM/5MCKpdlwKkKaDLHbt+/AqTXBU0nHM6/tw3ARB4gGFssjgglKspg
 H8P/UpTQD2qsiKSquszDdezW+7MRPaTx65K5vKBgndbuXwtm4j9jqnFrAbxeeul4qpBO
 i38t+b6zEesEgOvP7Rw8cvH0Br4WzEZ1mqlCtUlUpAzOGFBWlXlMlL/WcoMmt/aGLJN1 4Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2rphmecfts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 11:27:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x39BRbC2182693;
        Tue, 9 Apr 2019 11:27:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2rpytbj5ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 11:27:37 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x39BRRdQ010373;
        Tue, 9 Apr 2019 11:27:27 GMT
Received: from [10.191.22.92] (/10.191.22.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Apr 2019 04:27:27 -0700
Subject: Re: [RESEND PATCH] blk-mq: fix hang caused by freeze/unfreeze
 sequence
To:     Bob Liu <bob.liu@oracle.com>
References: <20190409090828.16282-1-bob.liu@oracle.com>
Cc:     linux-block@vger.kernel.org, shirley.ma@oracle.com,
        martin.petersen@oracle.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <051bab97-5294-d832-0a03-0600fdd96d6a@oracle.com>
Date:   Tue, 9 Apr 2019 19:27:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190409090828.16282-1-bob.liu@oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904090074
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904090074
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 04/09/2019 05:08 PM, Bob Liu wrote:
> This patch was proposed by Roman Pen[3] years ago.
> Recently we hit a bug which is likely caused by the same reason,so rebased his
> fix to v5.1 and resend.
> Below is almost copied from that patch[3].
> 

Hi Bod,

I think the commit message is not applicable to the most recent linux. Perhaps
re-write the message based on the most recent version?

Thank you very much!

Dongli Zhang
