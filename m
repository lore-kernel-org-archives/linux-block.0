Return-Path: <SRS0=n79e=BX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45888C433DF
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 19:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B77206B2
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 19:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o8N3RKJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHMTN0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:13:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34304 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMTN0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Aug 2020 15:13:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07DJ6rEr073369;
        Thu, 13 Aug 2020 19:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : date : references :
 to : in-reply-to : message-id; s=corp-2020-01-29;
 bh=2bH+L+5tOd7phoyRcEg2GRI3KECdCReVmxKQMNOZ+OY=;
 b=o8N3RKJgybkvOgkB+XqzbBqaM/aMOGpWbCvf/B7xc2el0q9WAV9H30uTWb8JPONirItO
 p66RZLF5mCwPQLAf8eqdMpxbSS9ILJTiqIGURqzXaUhMf4c9akEQ3RyKSoYyNNSbLSQg
 qrCwZqMO3RhpOroZvf25SLWqRUQ9yYIM15gAsIAFgzzkfZAhimBowOBpXpOlydINt/wK
 qoIsbfqLysyGYUFP0T4IBHZI6t+wYRqnkV9cK2Q6wyRKQ9/Z7V9+pBW5AVbAd0kSDzkY
 yyx3Sx1FKVENaAHdzQ4LasS9Gs+DgBvmckSOxbnZVtQPDG+2/wpusVwBSm0gxRVWUeXa 5Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32w73c9mrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Aug 2020 19:13:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07DJ7eme171792;
        Thu, 13 Aug 2020 19:13:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32t5ms5xgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 19:13:17 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07DJDFY7027775;
        Thu, 13 Aug 2020 19:13:15 GMT
Received: from [10.0.0.22] (/99.174.171.88)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Aug 2020 19:13:15 +0000
From:   Ritika Srivastava <RITIKA.SRIVASTAVA@ORACLE.COM>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: Return BLK_STS_NOTSUPP and blk_status_t from
 blk_cloned_rq_check_limits()
Date:   Thu, 13 Aug 2020 12:13:13 -0700
References: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
 <7E78993D-D0D9-4697-A65D-1F2DFC914982@ORACLE.COM>
To:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org
In-Reply-To: <7E78993D-D0D9-4697-A65D-1F2DFC914982@ORACLE.COM>
Message-Id: <E24A5FCA-72CE-45EF-BB5D-3BB665657507@ORACLE.COM>
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130134
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Ping..
Please help review these patches.

Thanks,
Ritika

> On Aug 5, 2020, at 10:54 AM, Ritika Srivastava =
<ritika.srivastava@oracle.com> wrote:
>=20
> Hi,
>=20
> Gentle ping
> Please help review these.
>=20
> Thanks,
> Ritika
>=20
>> On Jul 29, 2020, at 3:47 PM, Ritika Srivastava =
<ritika.srivastava@oracle.com> wrote:
>>=20
>> Hi,
>> These patches address the comments from previous v1 version
>> block: return BLK_STS_NOTSUPP if operation is not supported
>>=20
>> Updates since v1:
>> - Document scenario and SCSI error encountered in a comment in =
blk_cloned_rq_check_limits().
>> - Add a patch to switch returning errno codes to blk_status_t in =
blk_cloned_rq_check_limits().
>>=20
>> Please review the following patches.
>> [PATCH 1/2] block: Return blk_status_t instead of errno codes
>> [PATCH v2 2/2] block: return BLK_STS_NOTSUPP if operation is not =
supported
>>=20
>> Thanks,
>> Ritika
>=20

