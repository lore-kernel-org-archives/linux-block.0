Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8818C18E5B
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 09:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F0120722
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 09:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BgRbilXM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hGWqve1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgCYJKn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:10:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29764 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCYJKm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 05:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585127442; x=1616663442;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WwvfiY5xi+9lMRHZdt8QPefNlzv1XxKH40ZXUZBHxBo=;
  b=BgRbilXMA7g+mCcVycVhOakeDzpCaBzoq8xSo4A2N29oHWSRhcemGdtQ
   7wHLHgLufttj1i4iJ1c7WT7NJebNGJ9TF/Q3Qb7h/+ZBS1MTl3iBjzLZm
   2XMp/kbZ/y6v/ixFCXSwLqDTqkzbx1KAQSZWtYHAQFsJMoiKu29bMxmIP
   ftPek6LsHHbeH4bJ01oShQlI3PS7U8vb8T/L7XoXF2hMRKrs9JyCMgNL2
   yHyI+DqaiYjFSL+sON6su0zTqkUu3R+gQddJwWKIq7rhSAJzP7JVY44rP
   TzW+as4wey/O3ChyAhPgwuO1KW014msbyarknWy8wluRnbNlwyO4d3IKc
   Q==;
IronPort-SDR: L6B2BSh854wquZc7piI2MGjXSI8UnB1LpeKS3LR5WhiatfOdstIsDdH9UlijS+ayYLnHix8LwK
 sK2OPwpuopEzbmR20oKpbJOWTf5y5AcRs5VvLtVImvVf8xQNLJL23U6NtfiaSRgNMbpm7pKrbX
 18fMGXugh2Zr+5wMc/4K24lE5b6MaNtvuMk0/oIB0xAX/GBEWBvOY712OHxUVsF3Fp1CiS46xl
 9H2XN2+N8awTF9TfzfDBvmwrLItzte2SKNOPUQrNW+OH16QAO0xG830/TGACuueG+oFuavYTZq
 UyI=
X-IronPort-AV: E=Sophos;i="5.72,303,1580745600"; 
   d="scan'208";a="133453149"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 17:10:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kx3+2bSeFK31aI8CaVPUszb0uazelGnKHG/mwaoPo7gGWzmcHbEhra2dprns6YRRzo03JtaoBbwTLZ9Lh+4xEy57ZZvdNIiIboob7JQG6D1BVj1a7zrff8QWGPlc3y8osTJRPTLkGJ89G+iDQ127I1RfDMD/+MZIEgjK2tXlueHU2OqwZUnbs+5vfT1QzxtMgilTNTgztC9xFWhv7hir8NdY8B/wFz5c8ygQ/SczHnOxeZWYMNMusYQF2SwKJaDICYKD0phQ/QDJaoNqCDaNC6apxOqALL3tyY84ESGkGK2vyflHZ3F+ZgZxMYmZPYQMjmlE8MiiUp7J3Wwlb5ZCyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk4hDlQMn3v60LV07iLCjMJ1GJjaSClnOHD114BO0s4=;
 b=Jl9yV3faidCTPBfZ/YSzcXuTGKOmO1uTShOC5AeM3c0lAR2aR2eETC42WaXTnzG/10ISNTzkjRTq7iSrZsroe6cbM16/kWavIl23TIhfSXZzUqnyihUmmRChu4wOyb34807Orq4YE72jpoQkkk0buTZTSc24eBOTa27ebcCDn5/c5EHTi8MxyPwYGSWSTpq99ctc7KCNRjWGbPUcSjjMq41PbkuQFbNoph0QgkPcumrbKaBiELnfwQk+wTA4JDV889NMPsm1mavMVyimP3sPizPn3RrLj2o6P2sdFuaYdJgjOukn77Xhr3Fa4FgGmLcecXBlk7lBy9QaMuo4h4W8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk4hDlQMn3v60LV07iLCjMJ1GJjaSClnOHD114BO0s4=;
 b=hGWqve1X57ndlCpWeeXLObJAzjSaZ9y2lTBsci+5W1XgrKWUXIEO42lk3jMox3EYgFjTkKs46GatTILqztvgvraMShodDC23T3VboGC3CVwu5t6FBNml9Uv6rpziHkv6yfJvPBR8wvtnJ4D84actOtL+e7pjpwH+PlO9K0WpP60=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2198.namprd04.prod.outlook.com (2603:10b6:102:7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 09:10:41 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 09:10:41 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Hannes Reinecke <hare@suse.de>, Bob Liu <bob.liu@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [RFC PATCH v2 3/3] dm zoned: add regular device info to metadata
Thread-Topic: [RFC PATCH v2 3/3] dm zoned: add regular device info to metadata
Thread-Index: AQHWAcvtLt+lRR39/UysINFCEirB8Q==
Date:   Wed, 25 Mar 2020 09:10:41 +0000
Message-ID: <CO2PR04MB23433CAD26D492654041FCDCE7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200324110255.8385-1-bob.liu@oracle.com>
 <20200324110255.8385-4-bob.liu@oracle.com>
 <CO2PR04MB23438E0AB35CC46732F96085E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
 <812da9e9-cfd2-ea24-60cb-4af48f476079@suse.de>
 <CO2PR04MB23439B5FA88275A80D3449DFE7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
 <0bd2daa1-abbf-681d-405c-f7e4aecd577c@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da12d0e0-8ff4-4db5-4185-08d7d09c643b
x-ms-traffictypediagnostic: CO2PR04MB2198:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB21982A029A3962B86C41D75AE7CE0@CO2PR04MB2198.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(478600001)(71200400001)(2906002)(8936002)(9686003)(76116006)(81156014)(64756008)(8676002)(91956017)(33656002)(81166006)(86362001)(66946007)(66476007)(66556008)(66446008)(4326008)(52536014)(53546011)(6506007)(5660300002)(55016002)(26005)(54906003)(7696005)(186003)(316002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2198;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +4b6+y+huNAbN7YunWzcttYFAe7l7DnmLAhJPAhWMEC5O0rRP2lLhXXXZwfW/yc8Uv5p21WMiVACQOB6RMpmFWYkQ/CBSQ+qX59FGczl2KRuPx2eDJ6aIGQmmMzqfBN5tKl477Hc/oMCqqZB8E7f/fk/zhbgWemkBYSPLgxmftLh9J2P1j6Za+Fhl8tYEPlwP5dH/AV7l9X7ZaRY/5z+YY4QVyECGEb6moD0jDvfMNT5kgUlPf+aOpx0AvoKNiV/6mnZg4l81JssP2E+zF+dNnNTYWmt3+KVpQyg/yB/c13gDKIqJN6UqwcwDeHSgSLB+hGoEQoIMO29LBkIRWGlygO4KydcICaq06VfA4saDmfKofpHyH7w6qvtetbegEzUxJxBh00yEftZHyZp9RdoNYQ4DbSAg69g/OXch/ZJRNRAaJIWxwc4Pc165byDZrs+
x-ms-exchange-antispam-messagedata: qZB0qV59xrLe72x2CmtOfn8/saHy2zKteQVaZV2p2lLHdlCJXU7jzwXMUpPlznJa5kKzv2r4FIK5DFulHVQ15XW1cEBqQwulvjxSbx/oNKEF6OW5JywxKL92rj5taFu7KF62KMIjtUAqzdfsEfBBJg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da12d0e0-8ff4-4db5-4185-08d7d09c643b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 09:10:41.0265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GCU+GSDueMJnGJiKMYXTSJZfVt/goqjcPHqpdIuh0t+zM0iKpMy8yyFzw4vAuL+32PB5ni1cIw4jPq+bul3JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2198
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/03/25 17:52, Hannes Reinecke wrote:=0A=
> On 3/25/20 9:02 AM, Damien Le Moal wrote:=0A=
>> On 2020/03/25 15:47, Hannes Reinecke wrote:=0A=
>>> On 3/25/20 7:29 AM, Damien Le Moal wrote:=0A=
>>>> On 2020/03/24 20:04, Bob Liu wrote:=0A=
>>>>> This patch implemented metadata support for regular device by:=0A=
>>>>>    - Emulated zone information for regular device.=0A=
>>>>>    - Store metadata at the beginning of regular device.=0A=
>>>>>=0A=
>>>>>        | --- zoned device --- | -- regular device ||=0A=
>>>>>        ^                      ^=0A=
>>>>>        |                      |Metadata=0A=
>>>>> zone 0=0A=
>>>>>=0A=
>>>>> Signed-off-by: Bob Liu <bob.liu@oracle.com>=0A=
>>>>> ---=0A=
>>>>>    drivers/md/dm-zoned-metadata.c | 135 +++++++++++++++++++++++++++++=
++----------=0A=
>>>>>    drivers/md/dm-zoned-target.c   |   6 +-=0A=
>>>>>    drivers/md/dm-zoned.h          |   3 +-=0A=
>>>>>    3 files changed, 108 insertions(+), 36 deletions(-)=0A=
>>>>>=0A=
>>> Having thought about it some more, I think we cannot continue with this=
=0A=
>>> 'simple' approach.=0A=
>>> The immediate problem is that we lie about the disk size; clearly the=
=0A=
>>> metadata cannot be used for regular data, yet we expose a target device=
=0A=
>>> with the full size of the underlying device.=0A=
>>> Making me wonder if anybody ever tested a disk-full scenario...=0A=
>>=0A=
>> Current dm-zoned does not do that... What is exposed as target capacity =
is=0A=
>> number of chunks * zone size, with the number of chunks being number of =
zones=0A=
>> minus metadata zones minus number of zones reserved for reclaim. And I d=
id test=0A=
>> disk full scenario (when performance goes to the trash bin because recla=
im=0A=
>> struggles...)=0A=
>>=0A=
> Thing is, the second number for the dmsetup target line is _supposed_ to =
=0A=
> be the target size.=0A=
> Which clearly is wrong here.=0A=
> I must admit I'm not sure what device-mapper will do with a target =0A=
> definition which is larger than the resulting target device ...=0A=
> Mike should know, but it's definitely awkward.=0A=
=0A=
AHh. OK. Never thought of it like this, especially considering the fact tha=
t the=0A=
table entry is checked to see if the entire drive is given. So instead of t=
he=0A=
target size, I was in fact using the size parameter of dmsetup as the size =
to=0A=
use on the backend, which for dm-zoned must be the device capacity...=0A=
=0A=
Not sure if we can fix that now ? Especially considering that the number of=
=0A=
reserved seq zones for reclaim is not constant but a dmzadm format option. =
So=0A=
the average user would have to know exactly the useable size to dmsetup the=
=0A=
target. Akward too, or rather, not super easy to use. I wonder how dm-thin =
or=0A=
other targets with metadata handle this ? Do they format themselves=0A=
automatically on dmsetup using the size specified ?=0A=
=0A=
> =0A=
> Cheers,=0A=
> =0A=
> Hannes=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
