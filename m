Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A50DC433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 17:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3AEE212CC
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 17:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nbb0lLbx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bi22z7/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgFQRlk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:41:40 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42138 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQRlk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 13:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592415698; x=1623951698;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qbJoZrKCgk5C7vYJjLqmPF9foO5tLuudu+oBAZ1u9vM=;
  b=nbb0lLbxfcySqpbe1zDwBUN4Fdry223kiqyHS/vTbuBqPgKpHVSxF8x5
   YlsnGutRyQPznfoS/D7Wo9R+vZavBBeafgva+Tk5Yq/iO9K0voiyxAlS8
   ZpgFo9bnhx89zXfh8lKc9YPqr68GpfTrZkDtQuFxGiu8Sb93LXGjft1D6
   S+5ZJ7cDdQ5hy7wvQx9qmjdIO6jueGFo93Po7L/EGD5O4EKpQtyJxJ9wJ
   EpIWwWZCd3LAsVRGZBXqpHWKXuJCBgVp1ttPpNaeLvBBtGJkyo6QurNoL
   BoTE0EsVrdQmU5e0cjJzagbvsqRW5gi0sSwjRXwB2tk/j1/aSzY+hf/z+
   Q==;
IronPort-SDR: RC8j2g+XQ5YIQsLOo0H6k5CFaxQs/BkLL2XonteiPTE4eGgcTuHrHoWyXt03PVsDm07h1VlzTX
 kJMw0h4H9ggnt0TZveR+xZYMjiX5DL58st2wNBUwy5ztPImGiybsLT90e08yoxMEBdYSfaCP24
 V7flQKl6/3+cMTIlxRwtEjoBpM/kSA24O5vr8DTI/6J5wp/nacEpagFuU0HtdVREpty0kAl3Ng
 J6PWwjtmysX5vk95oBK4KEUJPdh/dXmmsaJ6M/18NfmzyMkTspnb+DC7VeWZXtASsDnuvN5hFo
 MPw=
X-IronPort-AV: E=Sophos;i="5.73,523,1583164800"; 
   d="scan'208";a="249422675"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 01:41:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekev4RrkfxQ+bGyZQPEQbrckZrbHmuAhgeoWbwXFEt0ORz2XHpnUmfW/BaXVeIMPOYxet88OtpplaAxUFecPYcVu2w+5Dx1XP/xYpNTXyAXw4GEUIYGSTuFAy5N5q3+wjOJmye2z44BIfgrzwyNubu3SBQjUtyO8CT7FaXpDKhVHjB9ivCNWFyGEnDP9YesSO6gsZn0hJ0CNNUBO4kYeGoryFh+60Nj0iF/5AadtmMyWea90BAIrVDigaeVvqu6keZC6+pvquz1kSzmzQP0afsZo0Q/55BFOJxW6yzqL1Gnz2fpn8TqxjJWOfkKHU9S24Nio2N3bjSDeSy/UUDbw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwbZFo77QyM6g/7XG1iWkmNUJXtjo9OnnxNORyIx/pU=;
 b=LlaPb5gpSxYxGpN0F9/1EVYXCNCVys2jZHooOJMSceLvqWyouYvsEIlkhL+kC5rBGXJMgM03Kg9wLg319yXVyyJH+Ff1K16e1pb35DRZ+gKvEdLxItRZ/GuHO/fy/FZsqV5K/Hsi/P6IIqNdFbumhvesrFVXW1lLfK54/O8pv1i6Lqig9bc3WvJ/fFCi5m7fM7F036VB+FcfB4JJDbMjgl7qcY6N2OgSWZFBbs09hxJDVOA5QN88h5mgn0nU8qh7Bu3cA/xwqKR+AWL6acU2jcVFbeZVOS3JOVXt+kKiIpNmaOJiDDrtrt+2RsnH7+10HSRqAV9dzgzZfCcd6bERiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwbZFo77QyM6g/7XG1iWkmNUJXtjo9OnnxNORyIx/pU=;
 b=bi22z7/I7GK87ikBIWBoVfsF19C82EBPTpGyEPtfyJ2NLyaAPtVhekN303o097fFAJfLcEnwx4UoviDu4HVz4Ga8RtOuh65UdzIGlceqPwkgszBrhOHsrJ+YavG0WRetWkcrefqfMznjhuWWAmSv/2qKlBKDx/DCmvKZhiJS5xc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4661.namprd04.prod.outlook.com (2603:10b6:a03:12::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.26; Wed, 17 Jun
 2020 17:41:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 17:41:36 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] blktrace: Provide event for request merging
Thread-Topic: [PATCH] blktrace: Provide event for request merging
Thread-Index: AQHWRLAMNttH7JUaU0CGzcROGKdTgw==
Date:   Wed, 17 Jun 2020 17:41:36 +0000
Message-ID: <BYAPR04MB496500B1315D577596F07724869A0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200617135823.980-1-jack@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2cc79079-3355-47c2-9c92-08d812e5aefe
x-ms-traffictypediagnostic: BYAPR04MB4661:
x-microsoft-antispam-prvs: <BYAPR04MB466107779E55835190236F46869A0@BYAPR04MB4661.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XEWuBzKc2TOBNezg2xYFCKY3mZRtyD78YekPH0I7VkPUPsck21XZzIv6a+HsglMtQSQWmVKurhi1CEo4+qJrUkJgY8tEVQADEYyZqT/URgL2GMEDPEZvSwzKTZBipI6et/rSsv8zou4/gSmS6A6I/R57f/cFUx29C+SBaYBtfNZG4hMD7kjaSV3b6xpG0og71kNYf/D1oVwolLZzqxrd0hzfyAmf2nBC65buLDbI9py7DfHApBzHPzF02m/NWCT0vRD0QYyKkA6t1WJJlS3f/W4r7lL1SuCHFwRaX8nXu/D31akXY9Bl6dLS/VkotvNz2+d5+P+LOq6TRiFUVgDrZKg6z04ruvh/LoSsHLIDmW9saU+qgA3dWPiz6x3ratTg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(55016002)(4326008)(9686003)(8936002)(33656002)(110136005)(7696005)(53546011)(54906003)(86362001)(6506007)(8676002)(316002)(83380400001)(64756008)(66946007)(26005)(66476007)(66446008)(186003)(478600001)(71200400001)(2906002)(76116006)(5660300002)(52536014)(66556008)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: X+Ch+rmWF74l0Uz7oQ38kHCkhnX9vYvCfZPLvenp1s8AvY5YKcpF68eATFhTewEYg5DNWp5ZxZelJKEYgdFZLR79+lifI2Omxo6ujzNTkOxsCShpSLVZul0elyt9txZq1yOLofNp7qKvwNWiW9pEPHUvhcijUZ+q6K8BKaoE8xnOqTFRFfbannF35ZbFuFPD2d9wxfMqJxLfZw3xiDf83CMf4la1Nx+wtbNM5YvdSC9Kjf6OKLWcWiOf3b2CfkYgCnPI/r+7JiLDt8S1EJsulQ0XjmVn5wiyyEbvkgSe1NbD7qYrVTWycTKFHrELgVcuZMsQdmyzwLkhKuptUc9ye/p0svMZN0iMu0oe6g14MzsTdjgO+UEXSm5begxafwJP4+0sqHRTXrFlSm8mD1xB1KyT8AvGpjyx0L6I6hC7bJaWMgM3BSeQR/+rluIAAniWtX+TolwufVJOtnlCPqXNHuJqES/UUlunsGYruC6RTGA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc79079-3355-47c2-9c92-08d812e5aefe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 17:41:36.4058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8LROYiC5Li1MbnN5LFzkuKGej3f1WOgkPU3YMsAQNG8UAHzpSyt5+rvj4uZUXp7r1NMwwS+/EcPLeppMiJsbKftnvAirpYuPG56QeS1jmW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4661
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jan,=0A=
=0A=
On 6/17/20 7:03 AM, Jan Kara wrote:=0A=
> Currently blk-mq does not report any event when two requests get merged=
=0A=
> in the elevator. This then results in difficult to understand sequence=0A=
> of events like:=0A=
> =0A=
> ...=0A=
>    8,0   34     1579     0.608765271  2718  I  WS 215023504 + 40 [dbench]=
=0A=
>    8,0   34     1584     0.609184613  2719  A  WS 215023544 + 56 <- (8,4)=
 2160568=0A=
>    8,0   34     1585     0.609184850  2719  Q  WS 215023544 + 56 [dbench]=
=0A=
>    8,0   34     1586     0.609188524  2719  G  WS 215023544 + 56 [dbench]=
=0A=
>    8,0    3      602     0.609684162   773  D  WS 215023504 + 96 [kworker=
/3:1H]=0A=
>    8,0   34     1591     0.609843593     0  C  WS 215023504 + 96 [0]=0A=
> =0A=
> and you can only guess (after quite some headscratching since the above=
=0A=
> excerpt is intermixed with a lot of other IO) that request 215023544+56=
=0A=
> got merged to request 215023504+40. Provide proper event for request=0A=
> merging like we used to do in the legacy block layer.=0A=
> =0A=
> Signed-off-by: Jan Kara <jack@suse.cz>=0A=
=0A=
The attempt_merge function is also responsible for the discard merging =0A=
which doesn't have any direction specified in ELEVATOR_XXX identifiers.=0A=
In this patch we care unconditionally generating back merge event=0A=
irrespective of the req_op.=0A=
=0A=
Do we need to either generate event iff ELEVATOR_BACK_MERGE true case or=0A=
add another trace point for discard ? given that it may lead to=0A=
confusion since elevator flags for the discard doesn't specify the =0A=
direction.=0A=
