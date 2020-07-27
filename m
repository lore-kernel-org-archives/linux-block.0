Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B9FC433E0
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 19:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12EF2073E
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 19:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lLDtxmes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgG0TNb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:13:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35840 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgG0TNa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 15:13:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RJ1aEf182567;
        Mon, 27 Jul 2020 19:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=TW36hHGOxvrx4ycLryskU8rREGa5pA1iA/rk4aB7Uec=;
 b=lLDtxmesXysOfJVKN78uMoUrHbujhS+Q4mz/z8oZuLqLoW71KsJCpnPDVNWsjUplkQB8
 mpZvoAYdRD7wYVR92EYtczD8zddnj993f+3bpBXsuTYeFDyGjHZgJBGO/hvUUvqVWQoi
 6JL6ki1YAcB/CVOYJaXo6qb0GO94FGSANWK8sD8pjV1NVgXdmSewQPYyMzlRg2Dsiify
 KLbpVE19vPgDBxJZM8vOV0gQGbNPKh/Id5MITa7LYtxaOemEfBBqufebXVeIX/c5xJ09
 6bb/LcoooiRzxE0oPZBruwbbLFEuTfszr+uFEogzupajZpf64OeMu/ETE0O8PveYJQip lA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32hu1jbd67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 19:13:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RJ4Wa3191595;
        Mon, 27 Jul 2020 19:11:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32hu5rf45f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 19:11:21 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06RJBKDO029718;
        Mon, 27 Jul 2020 19:11:20 GMT
Received: from dhcp-10-159-224-152.vpn.oracle.com (/10.159.224.152)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jul 2020 12:11:20 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH 1/1] block: return BLK_STS_NOTSUPP if operation is not
 supported
From:   Ritika Srivastava <RITIKA.SRIVASTAVA@ORACLE.COM>
In-Reply-To: <20200726151003.GB20628@infradead.org>
Date:   Mon, 27 Jul 2020 12:11:19 -0700
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C19DDD2-C7E9-45B5-9FBE-641E7BAB974D@ORACLE.COM>
References: <1595608402-16457-1-git-send-email-ritika.srivastava@oracle.com>
 <20200726151003.GB20628@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=3 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=3 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270129
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

Thank you for the review.

> On Jul 26, 2020, at 8:10 AM, Christoph Hellwig <hch@infradead.org> =
wrote:
>=20
> On Fri, Jul 24, 2020 at 09:33:22AM -0700, Ritika Srivastava wrote:
>> If WRITE_ZERO/WRITE_SAME operation is not supported by the storage,
>> blk_cloned_rq_check_limits() will return -EIO which will cause
>> device-mapper to fail the paths.
>>=20
>> Instead, if the queue limit is set to 0, return BLK_STS_NOTSUPP.
>> BLK_STS_NOTSUPP will be ignored by device-mapper and will not fail =
the
>> paths.
>=20
> How do we end up calling blk_cloned_rq_check_limits when the =
operations
> aren't actually supported?  The upper layers should make sure this =
never
> happens, so you're just fixing symptoms here and not the root cause.
The device advertises it=E2=80=99s write zero value as non zero value:
cat /sys/block/sdh/queue/write_zeroes_max_bytes
33553920

Hence block layer issues write zeroes in blkdev_issue_zeroout()

In response, the storage returns the following SCSI error
Sense Key : Illegal Request [current]
Add. Sense: Invalid command operation code

Once this error is received, the write zero capability of the device is =
disabled and write_zeroes_max_bytes is set to 0.
DM device queue limits are also set to 0 and device-mapper fails the =
path.
To avoid this, if BLK_STS_NOTSUPP could be returned, then device-mapper =
would not fail the paths.

Once the write zero capability has been disabled, blk-lib issues zeroes =
via __blkdev_issue_zero_pages().

Please let me know if I missed something.=
