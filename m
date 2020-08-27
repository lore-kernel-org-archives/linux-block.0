Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB00C433E1
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 15:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A387B22B40
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 15:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Bxv/2Gkp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kvFB0AZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgH0PFb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:05:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49018 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgH0PEn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 11:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598540683; x=1630076683;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JfbLCmKfbakII1PZKWDWSuhr1yUlZPqThPq0yOGCGBM=;
  b=Bxv/2Gkp3HXPyD6VYUGD3+d+eGypC4OnULIsdWRH6E3ydOVSZgqrGniT
   1ULN17uc5Y/UuCIhZ7j9H+gPHpYmAzBgJOPrlqE75I0DVH2z4mCn0/MT3
   k3UPmUITFffE8UzgdP6ogZblSIi+1EEcqNq43N1Qs4NyU11mWgqzB7ua2
   74T1R73a4FynxP8KTX8SThibf5ctMAMnIcvcm734axmxt/7n1+oOPphPg
   s4obuTP47F/byyl+O5q7rKs9/f1UILLRgp+BdryA0cnfJryyJXyderVDl
   Jc5KuE2LhF4pnX23ZqEemow95Tr4o074xcx2xxrm1zu2sL3kfsqlsxebh
   g==;
IronPort-SDR: PaL9SfgZIY1oTf3/4mFEuiVlqUCxT3TQlDTfjsRglVAXmXpMAv8+1L7hr/UoF8deYbTC2b+kRj
 i2TwFNoFv8h1Q+HzCzwnOsrgEwkinPRpoSVtuMGjya11fIp82bNzAS5/1k6GFyKjkaepVc35vG
 O59Co+D0x0uZrOa7Rtyci0pammrWuUUM9l7GUIyFkQ2uhBMVmXFR3EYUI3H9TYXKCrpRhEhJGI
 r7KwEZolpbDt2XuCnnp2g1YRWFvKIdu21i9QuFspdpAhXiOGGCIKAoj6tLkKvpSMwpa9w9Q2yz
 eoY=
X-IronPort-AV: E=Sophos;i="5.76,359,1592841600"; 
   d="scan'208";a="255483761"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2020 23:04:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZSDj6YNmxVKorWtB+l3z3QzuZgHUD883o2HmPn3p37wu7Hb/v+rTo5iJ+646jX3aQdXqLdPLLgASwZ+BKD1YYzbOPyeYWNKaDvr7BSqvJFOgX63tFhDEIntAL28XFws1zV9+ULS17n50bvzDezYDNksMBzAKd15PMrt+9yfBKfNkdSwiFH5TVe4tbfxgCTwKfaZZfM3Sav6nSsZx1W1fjLCTwbQGVnEbNnDH8Rx4T5y9vdG6hwqX6CajF7jy38r4Ayf9ms2fTx7IUQEy0YI0mttXd+OIJslSmXzrFMRVdMlEGq+F3gS+SFU8QqTjO+XXqrU9HhYYOK2O6qVTw3nUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3fD/zaYAbH7/Tr1fv1HdwsEO3eyiS/UZM/TonQWp7Y=;
 b=bIANmW16eOq5Aw1QqWQbdAUIn5Rp1yrPdz2E9atkAFX4iMcsyYhKTta1QrFcEzsZcS1Ry+PGIdL3BMME2TtmIViHQ+IzHOY7LE1Lvd8LhgmAJ9rYUVCNzzgTKushvbxPv/IvYb3hXjaxXUPRZ6WSUh1rwtzltkrgzQpvB64Qz7WIA6sGC3nVXI9vz+qbVWASrIfxkZoDAfb41MYk1QHvSFsqNhz+nl7t3FBs2OhkwQ8fYBDnvWdyHa6M02p4xz5ILxH4Mspi6jBuSXJgfefe4dqXELXcjE2JXw2QCqnGgRRjEwaBK/1j9K6AOSyOoHoTOf32I1/LRbo38Dr+6GeFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3fD/zaYAbH7/Tr1fv1HdwsEO3eyiS/UZM/TonQWp7Y=;
 b=kvFB0AZbOmRv5qTURACJ3kcJ7ezKdL8o45bascADMNrrIVJK4o1peHBllx+eAVQt+TUgoqvlHw19KoFjBl6wTSd+r8gFq6wgCeFvSVAtVLWsQvB9ZbYGEyaPITYuwi4CM0ngWy0s4MIJpiFUwI2w9G0MxkC45sqJHhqWXKXEZU8=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1030.namprd04.prod.outlook.com (2603:10b6:910:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 27 Aug
 2020 15:04:36 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3305.032; Thu, 27 Aug
 2020 15:04:36 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Topic: [PATCH v2] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Index: AQHWfHkH+20N/yg19E+BQ9ptEBewKg==
Date:   Thu, 27 Aug 2020 15:04:36 +0000
Message-ID: <CY4PR04MB37513D874343FBD2D682DA0DE7550@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200827135018.63644-1-niklas.cassel@wdc.com>
 <6d9fb163-f9d9-1f2d-d88c-db9d3a6185b4@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1cf:fa0c:32f2:7362]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5116448d-d559-42b0-e4c4-08d84a9a8393
x-ms-traffictypediagnostic: CY4PR04MB1030:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1030ADCBA8097EA54D495110E7550@CY4PR04MB1030.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s+ZvkrDquX4vt6IOvrgherPJkVnWW1DJqiDjeoH9dkl7DvJZh24WzBbpsHe08ei31LFPaeCzO8iYFLHsI0/ukw1FFvCg1w4g0qMMFGsFwwZDV72T1FvkPkNekUQ304YzuTR8iMQaP9/oWIV8bwzT4w4rlAUAvk/6YotsHfZ86EFvTApyvtVPB+e+2Ejjo93pyidX5oW46SKMT0E31nVBAV+KLR6dZm9LomK7qSjw6Z6BSaRpc1RgwtyLQfEkUBJFkRy1/Q8BUdbUpVe9ZT/begoClBxFOf4hL/Ol3UXUW7MKsz8AkB6HuZCX53kKZNJTnILG5KsrdIPQoVIjmVWSEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(7696005)(71200400001)(5660300002)(478600001)(9686003)(316002)(2906002)(110136005)(54906003)(55016002)(4326008)(53546011)(8676002)(86362001)(33656002)(83380400001)(6506007)(66446008)(186003)(66556008)(52536014)(66946007)(8936002)(64756008)(91956017)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CxLibUvwmxvzGbUq7jupbcpku/Ar5swoPKxCFK0g3lmpCql1R7jDxVbift/qg/cl9h7xMbXD2bMY+oRYtw/KlYOLfPesQSglwVP5TxVPPXEQWT/sGxhsA5WkLLKOts45qGt3OgjvmW9E7Y2LeND1fI1YFi2pYGiI7Kn7x6DjtSSQnEih51jcwjzJZ0QyNcsXpSmIBPD9VFU7vh0hk56IXGIAX5+kXrVCJ955XEb/5frGUq5Y4YztfNUlDJqrwvCJY5tePzWpZpbcZU4tEMPB9J9fIEWrfg+0SwlsqmJ3V0iUM86KGVxrEPDj4mD+x6v65knk5SJEyJVJKZmE9FeUMAxFdEzwHelrduPeNvDCB6v+ZWIt7kx7XcwwbCmaSP9Wic70+xmWvjTAsiMl6hw/0T4ZWVMjISMDwijC65Ex5vQqr6fBV9u5Jjq9COSnhagQa50GVeYM2q4RxIiC0+UrApss4PAZBGQp9YXwE7UzUKPBzMEBaFJbiBkJlBq50cVysSAJUy44mIG5+wsgswihNRXvmGF0Hys29EzwJWVLdKCuQVLMHLqVN+0FrZI04cSM+/rgodCVRZMu9tE9mBpfoYaJm/gHJoGLA+i1wIAEvDSf6tN91FrucRSCX03nQ05IHFanrW+muV7EnVG8zKSEdgFvizixBQGLjRXmS+4NnpiD4b/MuXjBcp9yFQ3dIabzfdBKKw4x7agNhDEu5vWXBw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5116448d-d559-42b0-e4c4-08d84a9a8393
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 15:04:36.5382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+nUkCFo6ogTOTVrY3GlIjbpAFUo5I5Sn2G/tRwXhsamv5aGJ9twXahiTA0SN94bCKWgwLNvjSXMarhhTeNttg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1030
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/08/27 23:51, Randy Dunlap wrote:=0A=
> On 8/27/20 6:50 AM, Niklas Cassel wrote:=0A=
>> Add support for user space to set a max open zone and a max active zone=
=0A=
>> limit via configfs. By default, the default values are 0 =3D=3D no limit=
.=0A=
> =0A=
> Hi,=0A=
> =0A=
> How does a user find out about how to use/set these limits?=0A=
=0A=
For the setting part, this is for testing. So any value, even extreme ones =
(e.g.=0A=
1) would be OK to check that a software correctly handles write accesses to=
=0A=
zones for a device that has open/active zone limitations. A more practical =
way=0A=
is to reuse values of real devices. For instance, some SMR disks I use have=
 a=0A=
max open limit of 128 and max active 0 (there is no limit for active zones =
on=0A=
SMR disks as ZBC/ZAC specifications do not define this concept).=0A=
=0A=
Another example is our soon to come work on btrfs zone support which shows =
that=0A=
at the very least 6 active zones are needed. So tests can be performed with=
 that=0A=
minimum to check the file system and that its block allocator does not go=
=0A=
opening/activating too many zones.=0A=
=0A=
For the using part, the above btrfs example is good: if the FS tries to all=
ocate=0A=
blocks in too many inactive zones at the same time without first filling ou=
t=0A=
zones already active, it may exceed the limit and writes will fail. The FS =
must=0A=
thus be aware of the limits and its block al;locator tuned to limit block=
=0A=
allocations within a set of zones smaller than the maximum active limit.=0A=
=0A=
Does this answer your question ?=0A=
=0A=
> =0A=
> =0A=
>> Call the block layer API functions used for exposing the configured=0A=
>> limits to sysfs.=0A=
>>=0A=
>> Add accounting in null_blk_zoned so that these new limits are respected.=
=0A=
>> Performing an operating that would exceed these limits results in a=0A=
>> standard I/O error.=0A=
>>=0A=
>> A max open zone limit exists in the ZBC standard.=0A=
>> While null_blk_zoned is used to test the Zoned Block Device model in=0A=
>> Linux, when it comes to differences between ZBC and ZNS, null_blk_zoned=
=0A=
>> mostly follows ZBC.=0A=
>>=0A=
>> Therefore, implement the manage open zone resources function from ZBC,=
=0A=
>> but additionally add support for max active zones.=0A=
>> This enables user space not only to test against a device with an open=
=0A=
>> zone limit, but also to test against a device with an active zone limit.=
=0A=
>>=0A=
>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>=0A=
>> ---=0A=
>> Changes since v1:=0A=
>> -Fixed review comments by Damien Le Moal.=0A=
>>=0A=
>>  drivers/block/null_blk.h       |   5 +=0A=
>>  drivers/block/null_blk_main.c  |  16 +-=0A=
>>  drivers/block/null_blk_zoned.c | 319 +++++++++++++++++++++++++++------=
=0A=
>>  3 files changed, 282 insertions(+), 58 deletions(-)=0A=
> =0A=
> thanks.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
