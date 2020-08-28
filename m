Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F95C433E2
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 17:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF01620B80
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 17:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hR95Cgrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgH1RKY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:10:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47448 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgH1RKY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 13:10:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07SGtQN5100452;
        Fri, 28 Aug 2020 17:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=vamxKMuvZ3cN/ZFAZ1LYkc6X/ddmGQFVCg25Sq0cwNs=;
 b=hR95Cgrdo883OoUoVl3/d3q8hSnhL0InIpbwRIhUjIQVkJTGwvdB1Otl6SJ4KrjTuZ/C
 8iS/6S16OzpA8IFtp+dyn4EYAi9vP3bRDqnK6+d9lmFCTCW/XYXw7bdmjogL5CrX15m5
 mGkr49Hn51MO7OXQx+STYULoDyB+5axTPhYW7IZ8rpeAMirain94MEALi4pcLO447G7h
 rhCMo3sZjERNzFPlahGr7mWbnJCC289JtABYn+1BP9+OrwmIgFa2Y17hwsmdzMiObpN5
 aqWPdgdAcMEnRSfjm1TAuy0Rep486wvmJGiznECyI9+X319/kJaylcQiUSw2Yf4XQYC3 bA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 336ht3n5mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Aug 2020 17:10:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07SGpUIG076824;
        Fri, 28 Aug 2020 17:10:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 333r9ptksn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 17:10:20 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07SHAJRI019686;
        Fri, 28 Aug 2020 17:10:20 GMT
Received: from dhcp-10-159-135-178.vpn.oracle.com (/10.159.135.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Aug 2020 10:10:19 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH 1/2] block: Return blk_status_t instead of errno codes
From:   Ritika Srivastava <RITIKA.SRIVASTAVA@ORACLE.COM>
In-Reply-To: <d5c2818f-ed6e-e8ff-709d-ecc4858ff4de@kernel.dk>
Date:   Fri, 28 Aug 2020 10:10:18 -0700
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <67BDE4B3-830C-476F-939F-5AB2634E0F7D@ORACLE.COM>
References: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
 <1596062878-4238-2-git-send-email-ritika.srivastava@oracle.com>
 <20200814062620.GA24167@infradead.org>
 <C6F86C38-BE29-422A-8A57-5144E26C4569@ORACLE.COM>
 <de5c94ec-9079-22b7-bbcd-667f3b0fe94e@kernel.dk>
 <A0A0C5C0-957C-44DB-9B42-3EEC473D74C6@ORACLE.COM>
 <3C0C6E56-ECEF-457A-89A1-0944E004DC77@ORACLE.COM>
 <d5c2818f-ed6e-e8ff-709d-ecc4858ff4de@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9727 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9727 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008280125
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Jens for the update.
I will look out for 5.10 branch and send the updated patches.

Thanks,
Ritika

> On Aug 28, 2020, at 8:52 AM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 8/28/20 9:52 AM, Ritika Srivastava wrote:
>> Hi Jens,
>>=20
>> The two patches apply on branch block-5.9 in linux-block.git
>>=20
>> I apply the patches using git am xxx.patch.
>>=20
>> $ git log --oneline --decorate -n 5
>> 4d8e990 (HEAD, block59) block: better deal with the delayed not =
supported case in blk_cloned_rq_check_limits
>> 9a8a3d4 block: Return blk_status_t instead of errno codes
>> a433d72 (origin/block-5.9) Merge branch 'md-fixes' of =
https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.9
>> 6af10a3 md/raid5: make sure stripe_size as power of two
>> 79e5dc5 loop: Set correct device size when using LOOP_CONFIGURE
>>=20
>> Please let me know if I missed something and should test on another =
branch?
>=20
> It doesn't on my 5.10 branch, but I haven't pushed that out yet so =
can't
> really fault you for that. I'll get to it in the next day or so.
>=20
> --=20
> Jens Axboe
>=20

