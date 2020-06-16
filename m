Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4010DC433DF
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 16:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2642071A
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 16:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WGIapUiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgFPQP1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:15:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47938 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731515AbgFPPlr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 11:41:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GFbS2b087032;
        Tue, 16 Jun 2020 15:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=x71oBn1m/tF2XvIfsUgElKRHW9e1eYOow3P3SFBORSg=;
 b=WGIapUiBpCyxlkBoDlt61JxsZxduNAh7fVJidJtdsvoZ3HdFLhPvHzSoSOc6TmmCUCN+
 buOgpTw4hgWXgcEO/X6M1SmsNObrbyYDZ+lMRghnYxieHUkZKczO396NYsUANV5M/4+w
 dbWg71YvdDStIX+3FcEuekdlTm0dua7Mi+GYZ3K5QQEozwAxXZ1LEt/qB3OFtVJ+J/Ci
 eZOop1VVqk3GvcWAbaxASUgn0n4iGGbkDps1kBGM14D3sIudk1BULhTUmsAWWCxYS+IA
 fMQ5h7s2/cXUwmtvsFpqENb9KNSa7enjvI4OF37M5UrhAN3ajM7bLKiq7dEIkhOmt6LC 3A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31p6e5yjjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jun 2020 15:41:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GFd6ch046602;
        Tue, 16 Jun 2020 15:41:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31p6s7d9b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 15:41:25 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05GFfO13030328;
        Tue, 16 Jun 2020 15:41:24 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jun 2020 08:41:24 -0700
To:     Keith Busch <keith.busch@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/5] block: add capacity field to zone descriptors
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sgevm31m.fsf@ca-mkp.ca.oracle.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
        <20200615233424.13458-2-keith.busch@wdc.com>
Date:   Tue, 16 Jun 2020 11:41:21 -0400
In-Reply-To: <20200615233424.13458-2-keith.busch@wdc.com> (Keith Busch's
        message of "Tue, 16 Jun 2020 08:34:20 +0900")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=1 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 suspectscore=1 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006160110
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Keith,

> In the zoned storage model, the sectors within a zone are typically
> all writeable. With the introduction of the Zoned Namespace (ZNS)
> Command Set in the NVM Express organization, the model was extended to
> have a specific writeable capacity.
>
> Extend the zone descriptor data structure with a zone capacity field to
> indicate to the user how many sectors in a zone are writeable.
>
> Introduce backward compatibility in the zone report ioctl by extending
> the zone report header data structure with a flags field to indicate if
> the capacity field is available.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
