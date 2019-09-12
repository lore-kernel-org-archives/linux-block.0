Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75565C4CEC6
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 22:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331E72084D
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 22:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N5qDW4UE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RxVOSHC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfILWU6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:20:58 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7481 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfILWU6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 18:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568326857; x=1599862857;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rpo67BWJURBiGFuhguDg+F6l+IqO54VZT2DLK4MQXKQ=;
  b=N5qDW4UEF5sl1DDlD1ll1pyYfCy7njrPTdKcKtCgNP1GKLB7KJMyUnQy
   xwc1wC/HXx6oz9BI+ebTZwv+2Eetg1o6W0oNQkJQQIKEWlpOpH5K6dNEH
   EZFkAulRM7/AxZLSnLcu7/JgfXKXiaf6bWn/J+nM+7flUBTCwfMNIFnlq
   hvP342KrCV6wAXSb7LufDwRfbR4REE3fSYz8W7iBB8IiDBWQb8bEHwVpP
   uQGmInPds2Tww2YD9WsHuOGYHazD1nYEcZ3QhD6u1IFb0LYc5H5KDSpjo
   AoDtvWiboyHMjOvQYWuLt3xuNGDr15miq9jlsRBNObqRn4fbC86FJAeov
   A==;
IronPort-SDR: kx+dzzXKrIuM5WY0nEqXTFR7+dJmrWQSJQOyKnpxpOKlvYdX4twDl4/zgGI1TnCoIOa5UeS2R2
 HgdSyjQzxSXZm9rKXFSiOzMHxDMEz7svCCT5ldzJCsQZwkisUJ4ztQ9SKVdK1B7tULcfUzjcq0
 F7lPZI9U0p0Eas+0W51FsEIKme0tpLrVuU823x7LXLH2vSnHwUEBj5Ne9aD7WOY5CaBFaEfcAa
 4vYD4pNN+b8GBThJ0sha4fvJ0xRqGX6ZACO/n4bjJ9hHXhdtforLBVaB9wf3PpewKMN55rJXW9
 bO4=
X-IronPort-AV: E=Sophos;i="5.64,498,1559491200"; 
   d="scan'208";a="122659531"
Received: from mail-cys01nam02lp2057.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.57])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2019 06:20:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBB2qpzPz5KfI+5CHI0B7gUpgApyGKVqOf7DThf2RE3PcH7tL8cWQl73ZPJrEV3zNYe0iDDdhzaH8jYXvKAHnHvhr6oYTy22LtlyBw/QDIAGE3we5W+NTZN7YwmtAzlafiGWcDvrgE99vDoshL9pYFwkMxJUxUGatrDjNvc/EywPMcn4nObgH+4E3Xz9wTlDazPPyqJrinvwDqGVM4HFNfmsu+T9eWvIXMW0gVpLKEBGd9LWLrlsR06yiZkrGH8v2REi3bnYvPOsxJ6zqo9uZlOikOj3Zbdri6T7ojO/3d7EeqEWZLHYvXGDp/1BLLbzpXUl8zkh74sRp7rvos6byQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bu+t3ZhL4VSNdr0emaYSFRU9Nnc24XEh7NWxhxmxukc=;
 b=hcDha+7oQia1SQ6yFdCYJR0L8GnfSo1/tBha2O0xdzMRwCa9DQZuu7tONYoVEyb1mH9wtBhK2LmR9t/tDHqKhR5Ctf0gW0kd6d22nmorKj6VLdhoyzTA/IHiKNsRuFMPScOL6ksnGmMg5hS0WNOUTZXLxQ4S8dmLol74fha1F5TEqwz5OYy1D7b+gbkQiaeXO0gQAFI/BuNiJL+QHrTDgcSZrbSVfFqPftg9CTO6PgEUArjxkDoE+ertEptulX0xRn/M5rjoO9Ct/a1vzrr5t4f2pH5cQeRdLk4iSggCCU2s80LHMjxmybEOOjnPi5kfvLbOQxqTguh1Fo8RJJKLcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bu+t3ZhL4VSNdr0emaYSFRU9Nnc24XEh7NWxhxmxukc=;
 b=RxVOSHC2zxyetBrSVbkMnoWfP2djBdDkQniLiLJjWgR0KPpZ+xUolPASZCwQnM5k05FZz6W1qwm6wiqYYn1hCEL4GpbVxTiEMvj9Y8//s161X2DgXulHzWSaPb5JwFAQF6vq3bRFW4aIO4pA7nDwJVmdcrnh8qiQ8kikNhfzKw8=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.52.22) by
 DM6PR04MB4907.namprd04.prod.outlook.com (20.176.109.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Thu, 12 Sep 2019 22:20:55 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::81ec:c517:7b2f:c5d4]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::81ec:c517:7b2f:c5d4%7]) with mapi id 15.20.2241.022; Thu, 12 Sep 2019
 22:20:55 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     =?iso-8859-1?Q?Andr=E9_Almeida?= <andrealmeid@collabora.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "m@bjorling.me" <m@bjorling.me>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "krisman@collabora.com" <krisman@collabora.com>
Subject: Re: [PATCH 3/3] null_blk: validated the number of devices
Thread-Topic: [PATCH 3/3] null_blk: validated the number of devices
Thread-Index: AQHVaK/tthLu0hDHKk6eugQSeTinSQ==
Date:   Thu, 12 Sep 2019 22:20:54 +0000
Message-ID: <DM6PR04MB5754177B405819C802549AE686B00@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <20190911144636.226945-1-andrealmeid@collabora.com>
 <20190911144636.226945-3-andrealmeid@collabora.com>
 <20190912161937.GK29434@bombadil.infradead.org>
 <dbdb0415-8762-f9c1-a65a-3531d9cca109@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7103ae0-3ed3-4bc2-d9b7-08d737cf7a8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR04MB4907;
x-ms-traffictypediagnostic: DM6PR04MB4907:
x-microsoft-antispam-prvs: <DM6PR04MB4907719A422D1E0C1304963D86B00@DM6PR04MB4907.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(189003)(199004)(76116006)(52536014)(229853002)(26005)(2906002)(256004)(186003)(110136005)(478600001)(53546011)(6116002)(14454004)(316002)(5660300002)(6436002)(6506007)(102836004)(71200400001)(7696005)(76176011)(64756008)(66446008)(66556008)(476003)(25786009)(486006)(91956017)(66946007)(54906003)(66066001)(4744005)(3846002)(446003)(86362001)(9686003)(66476007)(4326008)(81166006)(99286004)(71190400001)(53936002)(74316002)(33656002)(7736002)(305945005)(55016002)(8676002)(81156014)(8936002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB4907;H:DM6PR04MB5754.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LJ64QhQO0cQkZoJGnu2aq0QxfXVqbxqGC/mt22/BYDJ+dZRub/j/hgoad7PwfIM4rGuSuJlJsmLAIdJaoe18OvW9SJmgVC1RpinGaP6GRA1coKXwSevUv+B2KC8IvEPnpqT0kNTgWK0v+C1dRdeirRi94Ta/B6qnpZG4iG7Go7SMLMqHWrvttP9mEuUbF6MPp/jJd3nBhJkkExSnbhnQt9FxOG0M3cjctl4S2R7K7RWA5P2KGCD3VG3eH8yHxPkaOaC6h5mVl1vCr1Gjb7tKEVGlMWSi5S8sqIRaicjfcxQPFocpl0/nnfxdHjKSX6BX980lglEBt2YV2QkhQLsWUQkFIZF4wah0c17P13S3swFiyIG1h7qME03HeXTDnNlb0CfN6R1CWmPtktj2s3Gwpue6+kKbE9csePFocHVjk3w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7103ae0-3ed3-4bc2-d9b7-08d737cf7a8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 22:20:54.8734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDcx8ff84EhfPNnsMOsxSzU0niw2KQLmpWhzVMk8SXANBYtdBBaSHw90o/eUkU16pNIy2T89utWn2xySF96pYbiwIH8qg4S9NSIHnV0io6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4907
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/12/2019 03:09 PM, Andr=E9 Almeida wrote:=0A=
> Hello Matthew,=0A=
>=0A=
> On 9/12/19 1:19 PM, Matthew Wilcox wrote:=0A=
>> On Wed, Sep 11, 2019 at 11:46:36AM -0300, Andr=E9 Almeida wrote:=0A=
>>>=0A=
>>> -static int nr_devices =3D 1;=0A=
>>> +static unsigned int nr_devices =3D 1;=0A=
>>>   module_param(nr_devices, int, 0444);=0A=
>>=0A=
>> ^^^ you forgot to change the module_param to match=0A=
>>=0A=
>>> +	if (!nr_devices) {=0A=
>>> +		pr_err("null_blk: invalid number of devices\n");=0A=
>>> +		return -EINVAL;=0A=
>>> +	}=0A=
>>=0A=
>> I don't think this is necessary.=0A=
>>=0A=
>=0A=
> Could you explain why you don't think is necessary? As I see, the module=
=0A=
> can't be used without any /dev/nullb* device, so why we should load it?=
=0A=
>=0A=
> Thanks,=0A=
> 	Andr=E9=0A=
>=0A=
=0A=
I think Matthew is right here. I think module can be loaded with =0A=
nr_devices=3D0.=0A=
=0A=
Did you get a chance to test nr_device=3D0 condition ?=0A=
=0A=
Also, did you get a chance to test this patch with all the=0A=
possible conditions ?=0A=
=0A=
=0A=
=0A=
=0A=
