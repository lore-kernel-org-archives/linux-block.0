Return-Path: <SRS0=yU/V=BP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1675CC433E4
	for <linux-block@archiver.kernel.org>; Wed,  5 Aug 2020 17:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE01E22D05
	for <linux-block@archiver.kernel.org>; Wed,  5 Aug 2020 17:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E4iZT1BU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgHER4s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:56:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41678 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbgHER4n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Aug 2020 13:56:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075HqGiU195631;
        Wed, 5 Aug 2020 17:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=+lXC6zDZOVnjMIVtuBsqUEFy7fEXbLL4Xw1DbtlLmco=;
 b=E4iZT1BU8/2AgLhfGkLXkpndAC0v48BFJ3UqNHtle1PCirXYHY6JYe0uFMdrllHmXB8F
 uUvzaIwukehzb0YY2irYzIYUocaykFvlCZEkIBTheOX8QBCOAwFbDfk0hyAtlf4m/6AF
 rQvAEtixhTOie0BBpVYjzHUQi/0QdSdwRPgu31atN43p23/UTKD4so08GtJVtf4ymrSt
 A592NzKnjFCHcoUG4K5t2DIskTBPba6/rQJ8kn8jNu4i2lMdkhVXYifrL3Vc7yzNOibB
 0SQxR3duA52G8j6//w71dkHP3AU2sGqLmH6BWRkxe0ZgB1B4gsjcl8ZM4qCugfVqecn9 EQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32n11nbhsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 05 Aug 2020 17:56:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075HrkIu076157;
        Wed, 5 Aug 2020 17:54:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32qyaa7dfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Aug 2020 17:54:04 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 075Hs3O1010785;
        Wed, 5 Aug 2020 17:54:03 GMT
Received: from dhcp-10-159-253-56.vpn.oracle.com (/10.159.253.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Aug 2020 10:54:03 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: Return BLK_STS_NOTSUPP and blk_status_t from
 blk_cloned_rq_check_limits()
From:   Ritika Srivastava <RITIKA.SRIVASTAVA@ORACLE.COM>
In-Reply-To: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
Date:   Wed, 5 Aug 2020 10:54:01 -0700
Cc:     axboe@kernel.dk, Christoph Hellwig <hch@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E78993D-D0D9-4697-A65D-1F2DFC914982@ORACLE.COM>
References: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
To:     linux-block@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=5
 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=5 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050143
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Gentle ping
Please help review these.

Thanks,
Ritika

> On Jul 29, 2020, at 3:47 PM, Ritika Srivastava =
<ritika.srivastava@oracle.com> wrote:
>=20
> Hi,
> These patches address the comments from previous v1 version
> block: return BLK_STS_NOTSUPP if operation is not supported
>=20
> Updates since v1:
> - Document scenario and SCSI error encountered in a comment in =
blk_cloned_rq_check_limits().
> - Add a patch to switch returning errno codes to blk_status_t in =
blk_cloned_rq_check_limits().
>=20
> Please review the following patches.
> [PATCH 1/2] block: Return blk_status_t instead of errno codes
> [PATCH v2 2/2] block: return BLK_STS_NOTSUPP if operation is not =
supported
>=20
> Thanks,
> Ritika

