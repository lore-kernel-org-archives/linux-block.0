Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975CBC433E3
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 17:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AC520809
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 17:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vFZ/vA3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbgG1RSc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:18:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56800 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731791AbgG1RSb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 13:18:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06SHHwMw087461;
        Tue, 28 Jul 2020 17:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=jd54vjPHOXLUbAgjl30uoarVJxhhc8ZOuByEqVSi2Ew=;
 b=vFZ/vA3hAQjch9Xd0MngobdOyUNmFZWkpuu92gPP4Bqhv0UOOfIDj/SRpQh3AFCpdTpd
 BLKTL4Oo+OmL5nyuAzT5Pvq0xkBljgge9IKQm0Huk5H0jFI+h/PEn61I9VID04fHPfER
 ct4oOD6EXiivaEhA8IReuhXFCLGFJdx/Mkd2EHVdRsRMnoZCQsNhXOG3Qoc9Siep00DM
 lyZ2xKPZh83mzOuIu7aBvpAjvMs0k55F5k9Rv5EnTNobwdW7p81ZPsn9uEXAqvbJSRUQ
 gkTX/5I1QOOUelBSaiTjJWSVNHRKm2Do3MVyGeKDkDYZquoF9Dm+vSDCwBEpk9fRQaR9 Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32hu1jgtwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jul 2020 17:18:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06SHChtR081678;
        Tue, 28 Jul 2020 17:18:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 32hu5uf17t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 17:18:27 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06SHIQA7007255;
        Tue, 28 Jul 2020 17:18:26 GMT
Received: from dhcp-10-159-131-222.vpn.oracle.com (/10.159.131.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jul 2020 10:18:26 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH 1/1] block: return BLK_STS_NOTSUPP if operation is not
 supported
From:   Ritika Srivastava <RITIKA.SRIVASTAVA@ORACLE.COM>
In-Reply-To: <20200728072855.GA4774@infradead.org>
Date:   Tue, 28 Jul 2020 10:18:22 -0700
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Content-Transfer-Encoding: quoted-printable
Message-Id: <91295B21-661A-416A-A601-AE1671365F72@ORACLE.COM>
References: <1595608402-16457-1-git-send-email-ritika.srivastava@oracle.com>
 <20200726151003.GB20628@infradead.org>
 <1C19DDD2-C7E9-45B5-9FBE-641E7BAB974D@ORACLE.COM>
 <20200728072855.GA4774@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=3 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007280127
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Jul 28, 2020, at 12:28 AM, Christoph Hellwig <hch@infradead.org> =
wrote:
>=20
> On Mon, Jul 27, 2020 at 12:11:19PM -0700, Ritika Srivastava wrote:
>> Hence block layer issues write zeroes in blkdev_issue_zeroout()
>>=20
>> In response, the storage returns the following SCSI error
>> Sense Key : Illegal Request [current]
>> Add. Sense: Invalid command operation code
>>=20
>> Once this error is received, the write zero capability of the device =
is disabled and write_zeroes_max_bytes is set to 0.
>> DM device queue limits are also set to 0 and device-mapper fails the =
path.
>> To avoid this, if BLK_STS_NOTSUPP could be returned, then =
device-mapper would not fail the paths.
>>=20
>> Once the write zero capability has been disabled, blk-lib issues =
zeroes via __blkdev_issue_zero_pages().
>>=20
>> Please let me know if I missed something.
>=20
> Oh, the stupid SCSI runtime detection case again.  Can you please
> document this in a comment?
>=20
> Also please switch blk_cloned_rq_check_limits to just return the
> blk_status_t directly.

Sure, I will make these changes and send updated version.

Thanks,
Ritika

