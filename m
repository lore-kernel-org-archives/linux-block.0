Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1BBC433DF
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 17:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 125C92078D
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 17:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MwhN+OcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHZRDR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:03:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58010 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgHZRDR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 13:03:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QGxIuk033805;
        Wed, 26 Aug 2020 17:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=GQAp4LD3lFjkFvE8L1qOViGI8DoJYSQ2PQaY0xAIOuc=;
 b=MwhN+OcI5OnBEmtkIcRpkT6F9YFhJ+SSN+lokY5cN25AeHOlinNuk87of0Z5dUrMh0sb
 GULWJ9w7eGqj0i+SL4ziMY1d+mG8fpkXbrJ/Mt8tf5CSSLvRNILuVbUQ3D62WXdisVMx
 E0zOGBQBVSdT6Rg3+Qx7O7ayi5EObeFAsPAJW4d1nE5oaIrzveJ9mvUZtuMGEx5N38TA
 /BxLEOQPTxW4G6GiL+ig9SA3RbnUvb/1ybCVTaqNtQxUJFt/KmmmJwXn3AATVG+Euu3i
 HLlIrNzgIBjJO06hPzXCpnoOYKy3WnpYYqQAFjXquj5gPeO/Sp5Wwsl12k9k0HiA4ybW xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 333w6u08jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 17:03:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QGsqJC140243;
        Wed, 26 Aug 2020 17:03:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 333r9mdb70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 17:03:06 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07QH34ii004663;
        Wed, 26 Aug 2020 17:03:05 GMT
Received: from dhcp-10-159-234-53.vpn.oracle.com (/10.159.234.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Aug 2020 10:03:04 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH 1/2] block: Return blk_status_t instead of errno codes
From:   Ritika Srivastava <RITIKA.SRIVASTAVA@ORACLE.COM>
In-Reply-To: <20200814062620.GA24167@infradead.org>
Date:   Wed, 26 Aug 2020 10:03:03 -0700
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C6F86C38-BE29-422A-8A57-5144E26C4569@ORACLE.COM>
References: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
 <1596062878-4238-2-git-send-email-ritika.srivastava@oracle.com>
 <20200814062620.GA24167@infradead.org>
To:     axboe@kernel.dk
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9725 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=5
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008260126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9725 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=5 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008260126
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

> On Aug 13, 2020, at 11:26 PM, Christoph Hellwig <hch@infradead.org> =
wrote:
>=20
> On Wed, Jul 29, 2020 at 03:47:57PM -0700, Ritika Srivastava wrote:
>> Replace returning legacy errno codes with blk_status_t in
>> blk_cloned_rq_check_limits().
>>=20
>> Signed-off-by: Ritika Srivastava <ritika.srivastava@oracle.com>
>=20
> Looks good,
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>

