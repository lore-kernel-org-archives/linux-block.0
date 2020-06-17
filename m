Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ECFC433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 02:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C5F42085B
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 02:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BS4XpOyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgFQCB5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:01:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32858 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgFQCB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 22:01:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05H1vjlu082195;
        Wed, 17 Jun 2020 02:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=P6n90haX3wMwqEFit+wXP2CZ58I0PaaDATVvkPo5s6A=;
 b=BS4XpOynpHuW1ixQ8SB6BAJlq1oN1v9aiBoAW6b4So1R5Sj9w3RATpmm9mm6MVAifn3S
 AhqwpU1JJ1mafHOgHxNEoSLMLfb7mB6aJhzhnOHAlx8YNQU/N0i0J+KAPOJYVYyLTsDe
 v1e7GdiHKV2rCU74JPEbUKw4UpQIax9IkqC0ZQJm8Tl696b9U0xszSxd1MyZomZer4X4
 qO7BsLZHKLV5rl2txnRONnduVQ6sfYuyhzMjqIHRsB0PoPr6k7AHfIMpsF9OnnYOURqj
 TdQGLVWmD9gvhgeZQDMrvbo+8IVbM/0wF7Vx39y3ic2I2mlWZfjrf7utOoHskGy2HW0i TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31q65yrkvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Jun 2020 02:01:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05H1wCJO166264;
        Wed, 17 Jun 2020 02:01:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31q667umju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jun 2020 02:01:41 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05H21cPK011350;
        Wed, 17 Jun 2020 02:01:39 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jun 2020 19:01:38 -0700
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/5] nvme: implement I/O Command Sets Command Set support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pn9ylaxl.fsf@ca-mkp.ca.oracle.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
        <20200615233424.13458-4-keith.busch@wdc.com>
        <yq1ftavm29u.fsf@ca-mkp.ca.oracle.com>
        <20200616170607.GA507534@localhost.localdomain>
Date:   Tue, 16 Jun 2020 22:01:35 -0400
In-Reply-To: <20200616170607.GA507534@localhost.localdomain> (Niklas Cassel's
        message of "Tue, 16 Jun 2020 17:06:08 +0000")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=1 bulkscore=0 adultscore=0 mlxlogscore=783 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006170014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=804 suspectscore=1 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006170014
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Niklas,

> This function, nvme_identify_ns_descs(), was previously only
> called if (ctrl->vs >= NVME_VS(1, 3, 0)).
>
> Now it's called if (ctrl->vs >= NVME_VS(1, 3, 0) || nvme_multi_css(ctrl))

OK, that's fine, then.

> Someone could send NVMe format commands directly to the drive, using
> e.g. nvme-cli to format a specific NSID, using a different CSI than
> that NSID previously used.
>
> In that case, the same NSID will now have another main CSI
> associated, so it probably makes sense for revalidate disk to
> detect that it is no longer the same disk.

Fair enough. I hadn't considered the format nvm case.

-- 
Martin K. Petersen	Oracle Linux Engineering
