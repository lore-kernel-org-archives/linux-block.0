Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB48C433DF
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 17:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D81B20737
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 17:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jDqgSIit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgHZRDv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:03:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58412 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHZRDu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 13:03:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QGxxfX088173;
        Wed, 26 Aug 2020 17:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=W8WIDsjBeUH49dxRrFlJgTaxY8ty1j3UIbUMJ+kBlus=;
 b=jDqgSIit1JoNUAL+cKqOZbXDTDBWdx5vOv+i7BqUw4Js6D2FG/F75WY4J9UVPfDpdd5G
 xTxXPhcYvqf5lq1fsjGXWH3Hj5EyUB8CqUZiHUygxZetJzpTLxlRNA1MNJvm2qtnnkiQ
 WWGDSfX3LYQv8/jLxpabvyh0Civ1OchYC2zF1IUJ1PsuF9OaHu3WVv409UThytrBS0nU
 6b2waP3H4UpnW5lzZ37puAM5To67pjeQtqW9widJp12IjC56RXZ1lO2539+9z0yKFkPD
 B4wBqIliWJl9bjh0Hcqr75FRde2MTjZWQgpwb7OCEt6gQf0ngjDi/OM4zndhYJSbjf/3 Kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 333dbs1q6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 17:03:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QGuG4V054660;
        Wed, 26 Aug 2020 17:03:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 333ruar8qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 17:03:09 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07QH38Qs005528;
        Wed, 26 Aug 2020 17:03:08 GMT
Received: from dhcp-10-159-234-53.vpn.oracle.com (/10.159.234.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Aug 2020 10:03:08 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH v4 2/2] block: better deal with the delayed not supported
 case in blk_cloned_rq_check_limits
From:   Ritika Srivastava <RITIKA.SRIVASTAVA@ORACLE.COM>
In-Reply-To: <20200818194321.GA3271@infradead.org>
Date:   Wed, 26 Aug 2020 10:03:07 -0700
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A746E97B-C886-4211-8A28-B3A4DDD1703C@ORACLE.COM>
References: <1597772380-3034-1-git-send-email-ritika.srivastava@oracle.com>
 <20200818194321.GA3271@infradead.org>
To:     axboe@kernel.dk
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9725 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=5 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9725 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=5
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260126
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Can the following patches please be applied.

[PATCH 1/2] block: Return blk_status_t instead of errno codes
[PATCH v4 2/2] block: better deal with the delayed not supported case in =
blk_cloned_rq_check_limits

Thanks,
Ritika

> On Aug 18, 2020, at 12:43 PM, Christoph Hellwig <hch@infradead.org> =
wrote:
>=20
> On Tue, Aug 18, 2020 at 10:39:40AM -0700, Ritika Srivastava wrote:
>> If WRITE_ZERO/WRITE_SAME operation is not supported by the storage,
>> blk_cloned_rq_check_limits() will return IO error which will cause
>> device-mapper to fail the paths.
>>=20
>> Instead, if the queue limit is set to 0, return BLK_STS_NOTSUPP.
>> BLK_STS_NOTSUPP will be ignored by device-mapper and will not fail =
the
>> paths.
>>=20
>> Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
>> Signed-off-by: Ritika Srivastava <ritika.srivastava@oracle.com>
>> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>=20
> Looks good,
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>

