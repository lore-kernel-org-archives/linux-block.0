Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED839C433E6
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 15:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72E82075B
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 15:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JW6f7VFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgH1PwL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:52:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55592 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgH1PwK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 11:52:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07SFdwT7129630;
        Fri, 28 Aug 2020 15:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=5Inmo0ulbYj2GAw2LrLWeKA3QLnEbSoWIV74qRouhlA=;
 b=JW6f7VFg21Tba3QZXXrEmwGsbZRYuE0/vfjPBy+dIUXzYLQpUH1Y6e1pmZCURpwwGqyJ
 po4AlY70ceau+7RA7G+ETsxOXZW5VuXsG8jgrpr58/WMLxRfeHcr8V5sDX2NaKUS2iSE
 pZ2NjNn4fG+qxGHeJ2lpbxQTHVY0HfDjs6XqlRqqF8IrgHi6tf9FRfWjZh6/mNjpeb7V
 2JSkFnYiIw+ctajRyv/ogssrkHykFGJ8YQGDm6htMpuf3Yp3DPe0zwPbqyTHGqLOLJhT
 vUy1gN0a3qSQp16cxtzImI7Tuulc7+nLVN5LAZzrqI7CJX8YcqdFTKnaR0M5ZSlF4FG9 JA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 333dbscpd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Aug 2020 15:52:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07SFeOxA058705;
        Fri, 28 Aug 2020 15:52:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 333rug3qbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 15:52:07 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07SFq6Gd014893;
        Fri, 28 Aug 2020 15:52:06 GMT
Received: from dhcp-10-159-225-252.vpn.oracle.com (/10.159.225.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Aug 2020 08:52:06 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH 1/2] block: Return blk_status_t instead of errno codes
From:   Ritika Srivastava <RITIKA.SRIVASTAVA@ORACLE.COM>
In-Reply-To: <A0A0C5C0-957C-44DB-9B42-3EEC473D74C6@ORACLE.COM>
Date:   Fri, 28 Aug 2020 08:52:05 -0700
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3C0C6E56-ECEF-457A-89A1-0944E004DC77@ORACLE.COM>
References: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
 <1596062878-4238-2-git-send-email-ritika.srivastava@oracle.com>
 <20200814062620.GA24167@infradead.org>
 <C6F86C38-BE29-422A-8A57-5144E26C4569@ORACLE.COM>
 <de5c94ec-9079-22b7-bbcd-667f3b0fe94e@kernel.dk>
 <A0A0C5C0-957C-44DB-9B42-3EEC473D74C6@ORACLE.COM>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9727 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9727 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280119
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The two patches apply on branch block-5.9 in linux-block.git

I apply the patches using git am xxx.patch.

$ git log --oneline --decorate -n 5
4d8e990 (HEAD, block59) block: better deal with the delayed not =
supported case in blk_cloned_rq_check_limits
9a8a3d4 block: Return blk_status_t instead of errno codes
a433d72 (origin/block-5.9) Merge branch 'md-fixes' of =
https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.9
6af10a3 md/raid5: make sure stripe_size as power of two
79e5dc5 loop: Set correct device size when using LOOP_CONFIGURE

Please let me know if I missed something and should test on another =
branch?

Thanks,
Ritika

> On Aug 26, 2020, at 10:23 AM, Ritika Srivastava =
<ritika.srivastava@oracle.com> wrote:
>=20
> Sure, Will resend them.
>=20
> Thanks,
> Ritika
>=20
>> On Aug 26, 2020, at 10:19 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>=20
>> On 8/26/20 11:03 AM, Ritika Srivastava wrote:
>>> Hi Jens,
>>>=20
>>> Can the following patches please be applied.
>>>=20
>>> [PATCH 1/2] block: Return blk_status_t instead of errno codes
>>> [PATCH v4 2/2] block: better deal with the delayed not supported =
case in blk_cloned_rq_check_limits
>>=20
>> Can you resend them against the current tree? They don't apply.
>>=20
>> --=20
>> Jens Axboe
>>=20
>=20

