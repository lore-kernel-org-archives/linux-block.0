Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3F7C433E1
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 17:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9FB4206FA
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 17:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ALoLGFqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgHZRXq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:23:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45452 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgHZRXp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 13:23:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QHJTxE063903;
        Wed, 26 Aug 2020 17:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=XW2vh4qc/xFscT5yCl7WGXMYL+gVgbioQSpB3szENIw=;
 b=ALoLGFqxHxtGq/NzSDFrCQfVtkJXmgNjpI5Ga2ZALP9zk1tm0pOrCmLQe04o0+zo1adV
 AZjodsXwgp8ifKM3J2irRJ7UeybNmY3E9r1rJESqRTjq4izU2u/zw9gbdlxB97a7w6IJ
 huEhul4FDBrhuJR+qNPArHu7iWzWjjGcedjChkXusPc2+NSbO6iQHL9N4jR82LL8j0q9
 V8rj+/psFfKjQvFvFaXtk52QF0CYrtNq4d2F73qlcHrUK3GhGu10RPOpp0Ns2vpsQ3bk
 RL6OHIfa0Ou1gYWPlZhorevIQhCcXK4whcFiCvrZdg1aPev9SmyZXuVECNofskU2m8BU wQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 333w6u0bs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 17:23:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QHEpiw013738;
        Wed, 26 Aug 2020 17:23:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 333r9me3eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 17:23:40 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07QHNcrR014415;
        Wed, 26 Aug 2020 17:23:38 GMT
Received: from dhcp-10-159-234-53.vpn.oracle.com (/10.159.234.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Aug 2020 10:23:38 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH 1/2] block: Return blk_status_t instead of errno codes
From:   Ritika Srivastava <RITIKA.SRIVASTAVA@ORACLE.COM>
In-Reply-To: <de5c94ec-9079-22b7-bbcd-667f3b0fe94e@kernel.dk>
Date:   Wed, 26 Aug 2020 10:23:37 -0700
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A0A0C5C0-957C-44DB-9B42-3EEC473D74C6@ORACLE.COM>
References: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
 <1596062878-4238-2-git-send-email-ritika.srivastava@oracle.com>
 <20200814062620.GA24167@infradead.org>
 <C6F86C38-BE29-422A-8A57-5144E26C4569@ORACLE.COM>
 <de5c94ec-9079-22b7-bbcd-667f3b0fe94e@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9725 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008260129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9725 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=3 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008260129
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sure, Will resend them.

Thanks,
Ritika

> On Aug 26, 2020, at 10:19 AM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 8/26/20 11:03 AM, Ritika Srivastava wrote:
>> Hi Jens,
>>=20
>> Can the following patches please be applied.
>>=20
>> [PATCH 1/2] block: Return blk_status_t instead of errno codes
>> [PATCH v4 2/2] block: better deal with the delayed not supported case =
in blk_cloned_rq_check_limits
>=20
> Can you resend them against the current tree? They don't apply.
>=20
> --=20
> Jens Axboe
>=20

