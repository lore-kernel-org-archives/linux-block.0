Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D17C433DF
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 18:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 867B6206B5
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 18:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IhQpPxzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHRSOF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:14:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59256 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHRSOE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 14:14:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IHvW6h166096;
        Tue, 18 Aug 2020 18:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=iMksFHQ4jfy225K3CniF9ieExPgWqfav3epP9OsiFJ8=;
 b=IhQpPxzCQKfgji4hBxnknTqAhoQFngOS1ZPyPte+jKs9xvfbQ5XXxXEdc7CvnST21zf6
 +SI3OALgKVRSawxGurgJC/lzWu7cUGIqRjUqVg+lxO7lkZtyAYfmccrIF/VfoROf5NIo
 NHFhkMWuouXHD9bhmX4L11YVdN1rhvG77gmFehH/jQfYVtZkPICft6LKGaw+mc0uhGGn
 WZ1/JmUda/oNBIZZbyzwjQ4lCxo/URB2xHpCe3KfXeF+QlapDun7udcCBzEVcKGI+Z5S
 ytlbdGgUuKp7D0RYaUN7kzzJW2hEpNeBvpWwyowahZFBhh1OsrFrEonp8K+5hn+fQD79 gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32x7nmeers-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 18:13:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IHwCTM108014;
        Tue, 18 Aug 2020 18:13:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 32xs9n92g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 18:13:58 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07IIDuvj015544;
        Tue, 18 Aug 2020 18:13:56 GMT
Received: from dhcp-10-159-249-73.vpn.oracle.com (/10.159.249.73)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Aug 2020 11:13:56 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH v3 2/2] block: better deal with the delayed not supported
 case in blk_cloned_rq_check_limits
From:   Ritika Srivastava <RITIKA.SRIVASTAVA@ORACLE.COM>
In-Reply-To: <yq1tux0bq7e.fsf@ca-mkp.ca.oracle.com>
Date:   Tue, 18 Aug 2020 11:13:55 -0700
Cc:     linux-block@vger.kernel.org, hch@infradead.org, axboe@kernel.dk
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA28F307-418F-453C-A1FC-533FF54DBCC3@ORACLE.COM>
References: <1597699898-21157-1-git-send-email-ritika.srivastava@oracle.com>
 <yq1tux0bq7e.fsf@ca-mkp.ca.oracle.com>
To:     "Martin K. Petersen" <martin.petersen@ORACLE.COM>
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9717 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=3 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9717 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180125
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Martin,
Thank you for the review.
I have addressed the comment changes in the updated version.

Thanks,
Ritika

> On Aug 17, 2020, at 8:43 PM, Martin K. Petersen =
<martin.petersen@oracle.com> wrote:
>=20
>=20
> Ritika,
>=20
>> +		/*
>> +		 * At least SCSI device does not have a good way to =
return if
>> +		 * Write Same/Zero is actually supported. To detect =
this, first
>> +		 * try to issue one and if it fails clear the max =
sectors value.
>> +		 * If this occurs on the lower device, the right error =
code
>> +		 * needs to be propagated to upper layers.
>> +		 */
>> +		if (max_sectors =3D=3D 0)
>> +			return BLK_STS_NOTSUPP;
>=20
> Maybe we should make it more explicit in the comment that there is a
> window of error where this condition can occur? Something like:
>=20
>    If a device rejects a non-read/write command (discard, write same,
>    etc.) the low-level device driver will set the relevant queue limit
>    to 0 to prevent blk-lib from issuing more of the offending
>    operations. Commands queued prior to the queue limit being reset
>    need to be completed with BLK_STS_NOTSUPP to avoid I/O errors being
>    propagated to upper layers.
>=20
> Otherwise looks good.
>=20
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>=20
> --=20
> Martin K. Petersen	Oracle Linux Engineering

