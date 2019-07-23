Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8CDC76186
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 16:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC12205F4
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 16:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EEVB23qD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfGWQPg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:15:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57874 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfGWQPf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 12:15:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6NGEJ8v162874;
        Tue, 23 Jul 2019 16:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=f64VnAYgd1dGJHWV5EaECwDib0DmMVcorF4HAdPH0xI=;
 b=EEVB23qDpdgmQcM1DMPra1HjHR7TNDeu7/OwvMTY+VWkzjJG0iSuf3lWk+VPTGpjX4ZS
 yKVN50i6qHECbbyP4ZwtFMR3jr8r3ZCZvlt1kozPFpNayI7IzfA6vKZnigP8XDtCT2lD
 bHG6desDvmWA+kIqfmh9oUUNK6Osn73uoO5+UP3Jpis9t3FcYDkeFcjrLE+6VXUuLkAU
 JFCaqdsCw4BiT3lzSplyAzFzHEamuW4SyMYpYnAvXabKpCjIY3hmf/Dt0l3hm3n/T4Rj
 oiv/Bg1Tc5Dx6jvGI60HOHedQXM0XPlTEKkK2zgZg2vc6wMs4+QodbPF0BWfU5hW2aDf 1g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tutcth8ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 16:15:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6NGD6rX058594;
        Tue, 23 Jul 2019 16:15:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tur2uganw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 16:15:00 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6NGEviR011454;
        Tue, 23 Jul 2019 16:14:58 GMT
Received: from [192.168.2.8] (/106.39.150.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Jul 2019 09:14:57 -0700
Subject: Re: [PATCH 4/5] nvme: wait until all completed request's complete fn
 is called
To:     Ming Lei <ming.lei@redhat.com>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-5-ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <8d6268ac-42cb-d14a-d4c3-c8c285fca6b5@oracle.com>
Date:   Wed, 24 Jul 2019 00:14:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190722053954.25423-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907230163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907230163
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On 07/22/2019 01:39 PM, Ming Lei wrote:
> When aborting in-flight request for recoverying controller, we have

recovering

> maken sure that queue's complete function is called on completed
> request before moving one. For example, the warning of
> WARN_ON_ONCE(qp->mrs_used > 0) in ib_destroy_qp_user() may be triggered.
> 
> Fix this issue by using blk_mq_tagset_drain_completed_request.
> 

Should be blk_mq_tagset_wait_completed_request but not
blk_mq_tagset_drain_completed_request?

Dongli Zhang
