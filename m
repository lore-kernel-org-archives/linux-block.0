Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CBCC43331
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 10:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D89120775
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 10:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TpjaUFVR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Puv9lMqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgCYKCQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:02:16 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31873 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgCYKCQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 06:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585130552; x=1616666552;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=eT9p3qxFXU0mPEhTh5SxZ0QMocSUrp27g0tH179wvRk=;
  b=TpjaUFVRuweJKuWcdGZK6XUvQoLPP7iaAphoUtqIDvX+kbmvEh0Qrt/m
   nPxbt1WwPCKZjTcBK7f/l0gTYGQSteX0E6zQP2WsHYGN/sZf3XNiVjlYA
   6gMzp/vRFaWbW9EUyynp6IfgGZq4SwAihEnDjdHFU8HeNqPfDhFzusH5y
   KGHVwB2SJAUiHIdkcydSeLDVHwu+yciiBuSlSQD4HmaTOAFjN0UHvHfLW
   DOHQ9G0+xRa+hZNmWxf/216qmHxThJvqeZ6ccZAD8kViUfjR+dX8CcKFQ
   B+Y9A7P+16Lq/TN3x92HnBFLUSbWvi6/Ux0bm0NDxVrVaHuP/HXiJ8D85
   Q==;
IronPort-SDR: vmeoFQl61XZ0wk6dZ0elULDic44zubKDT20aKmELKCwG8wjoI39twfl7enVbUjtmKl6GkVpkl5
 9TnANp56lPy/uaHdHVNARo1qCH8JA2v3s3qu8KdFQq+g/bwDZl387om9E7AQxroTV65Mn6o46x
 lqHKLVsktM0f0xy1bNxdGN7nj3WKdG7DZm00Wn3DBHGZ3HbelkR2u7xLzK1+2HR7VwJs094gIg
 yxd9ptvnUrfRu6dt8PVH4xZlU7LP+vTKUvpkCKMuRDzAD689sNF8QyVC6sl2AP/cT9BhcuJimX
 Y6U=
X-IronPort-AV: E=Sophos;i="5.72,303,1580745600"; 
   d="scan'208";a="235679185"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 18:02:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwinsIVqtLLg9xgqiEPbf/3u4clPrbnLgaihuPy3KGyG8Cov6VQjug1j04c4mmDJODUKWXJDOwhnVKmDOEyS+2pjP/MnJTqqRYkBjnI5ngj1nynWW+pnsMchawrcg4HpvSjOJd7OUrflQVBSsJ5mx1oGTfjP2Af7N7ZWa7vEcoOlQPq6kWIBuZJ7cqzaiVPRrDI8c4hYBTAdLQ6oy5qL+HA/yeJzpea6F3+kEy/pEnvAmrW20h1IaNHJuYOEFSvG3+lMwUvKFq0CBDGieX6zyrKm3BxzjSa0Xbq4eTbHs9Rr9nQ1eyasSXVlhh134vNjC+X8rgdie5mHHCjZ+/cIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSTRa+7cpKyxe/Nc5FWzeFyE/dh46SVEWNS0z8opUtg=;
 b=mUy1Sc6qDPwTfqAJ/rZyvNwmsVgf092ap+Vo364V8ZqAjQOCsODzjxRVl3T1KNC/RpOgFQA9bXciB6X6Eg/XPpB8+pfiMC5H14iX3xLwC2CihcPAsb3PXuN23LV7c9TVCl3dikGNwo2mgv8apjDJV2WFvHX3eQEwqNuXIBh9ghGZqKM6Nj3JwMrZErwSs+Z/ykTxNunN8Z7ccInKR6mKfbJLqt24phE/dUV0bsQEIyf7zpzQc5VyV13WxmGQ4o1ydb4XrFssgMiKnEVVoN/XZJSE22lGPCF5GmSvEAFx6l/SCgiORIP66eNc6hS+7Mo25zET6bjAaBMkVkqHXd4qAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSTRa+7cpKyxe/Nc5FWzeFyE/dh46SVEWNS0z8opUtg=;
 b=Puv9lMqFMCOeJHu64pqbJKxE9RSpJh9/UY6knuabqee8tFRuKATS4yNuFCB4mHwtpEn8S339crvGJ1AyODP4pIIbh8OI+KmQAUsKrbrEoIQob5oofgAA0OvyFhLv0pPyNQYVRrydaqfVNSm+Vy1HrNRmSG96/cUJ8VXEb/p2lGw=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2213.namprd04.prod.outlook.com (2603:10b6:102:a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 10:02:13 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 10:02:13 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Hannes Reinecke <hare@suse.de>, Bob Liu <bob.liu@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [RFC PATCH v2 3/3] dm zoned: add regular device info to metadata
Thread-Topic: [RFC PATCH v2 3/3] dm zoned: add regular device info to metadata
Thread-Index: AQHWAcvtLt+lRR39/UysINFCEirB8Q==
Date:   Wed, 25 Mar 2020 10:02:13 +0000
Message-ID: <CO2PR04MB2343054E74EEDFC330FD98DAE7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200324110255.8385-1-bob.liu@oracle.com>
 <20200324110255.8385-4-bob.liu@oracle.com>
 <CO2PR04MB23438E0AB35CC46732F96085E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
 <812da9e9-cfd2-ea24-60cb-4af48f476079@suse.de>
 <CO2PR04MB23439B5FA88275A80D3449DFE7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
 <0bd2daa1-abbf-681d-405c-f7e4aecd577c@suse.de>
 <CO2PR04MB23433CAD26D492654041FCDCE7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
 <cdf003a6-b0c8-30c0-edc3-049471a7a2b0@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af357e54-f2d9-425b-59bf-08d7d0a39786
x-ms-traffictypediagnostic: CO2PR04MB2213:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB2213C9A538D8DE217F0091C9E7CE0@CO2PR04MB2213.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(54906003)(110136005)(81156014)(316002)(81166006)(76116006)(26005)(91956017)(66556008)(64756008)(66476007)(66946007)(71200400001)(8936002)(5660300002)(66446008)(86362001)(186003)(52536014)(478600001)(53546011)(8676002)(2906002)(7696005)(4326008)(33656002)(9686003)(6506007)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2213;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c4H0EwKgFWtqeUoYn9QCg59szNd/IAU0u498snczJngSlUhPqVFVVcWjrDPyoefAJOY9lGueQpCmdjOtXDA9LptCsubNyjuXDyfhANwuPRhnmmNxiYQte7U+ceYSAm5Ig8jaBIAw0ZFqeIQrDzShCBkg9WABBhw8kn9+rsdTaosxU2rUv83VgS8COcHxMRhHp+at8Qoxhox88ARkhEzijjIaXG0tQuXema0f251M3oDwuxmrMu/1CXIuRPc4EeuZhuLJ6+5H+sgpeEb63oCycISlaNVcQQXgibibNYlkrQy9pzpDE99zxiIp4npbpmdjwzgErcrZYxbYRF/VFvrBZDzOY2Nw2JGxBr3whYcZw6XthdBdm+SREnDBR4eXbA8m8vG2ugM6aZexZOUMRiUvXtUrNNd8DGCvCrRL70ACRFd2xj/zyKiV8gxJuCjkXWnk
x-ms-exchange-antispam-messagedata: raTsWq/VwhFWaqMU4VigiFxdnUJdF2yFf7a5WDvYWX0lWVkT3d5abYEPeSQjHZ91ay8PxeKemIHRZbx8s2TispPqqSa0GU9+SYYIGE6E/4A1gJOddZWS0n5T5cl6kbxbXejglGXaTuXPGMuYNf2EWA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af357e54-f2d9-425b-59bf-08d7d0a39786
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 10:02:13.5396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: umHUDhVQL7d0VTK6PGzuiMIKUKfexTtcqceTObwq5mCHpXIaZkdifUXl367FmOGWI+Rac90EOpaOyri2yQkulw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2213
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/03/25 19:00, Hannes Reinecke wrote:=0A=
> On 3/25/20 10:10 AM, Damien Le Moal wrote:=0A=
>> On 2020/03/25 17:52, Hannes Reinecke wrote:=0A=
>>> On 3/25/20 9:02 AM, Damien Le Moal wrote:=0A=
>>>> On 2020/03/25 15:47, Hannes Reinecke wrote:=0A=
>>>>> On 3/25/20 7:29 AM, Damien Le Moal wrote:=0A=
>>>>>> On 2020/03/24 20:04, Bob Liu wrote:=0A=
>>>>>>> This patch implemented metadata support for regular device by:=0A=
>>>>>>>     - Emulated zone information for regular device.=0A=
>>>>>>>     - Store metadata at the beginning of regular device.=0A=
>>>>>>>=0A=
>>>>>>>         | --- zoned device --- | -- regular device ||=0A=
>>>>>>>         ^                      ^=0A=
>>>>>>>         |                      |Metadata=0A=
>>>>>>> zone 0=0A=
>>>>>>>=0A=
>>>>>>> Signed-off-by: Bob Liu <bob.liu@oracle.com>=0A=
>>>>>>> ---=0A=
>>>>>>>     drivers/md/dm-zoned-metadata.c | 135 ++++++++++++++++++++++++++=
+++++----------=0A=
>>>>>>>     drivers/md/dm-zoned-target.c   |   6 +-=0A=
>>>>>>>     drivers/md/dm-zoned.h          |   3 +-=0A=
>>>>>>>     3 files changed, 108 insertions(+), 36 deletions(-)=0A=
>>>>>>>=0A=
>>>>> Having thought about it some more, I think we cannot continue with th=
is=0A=
>>>>> 'simple' approach.=0A=
>>>>> The immediate problem is that we lie about the disk size; clearly the=
=0A=
>>>>> metadata cannot be used for regular data, yet we expose a target devi=
ce=0A=
>>>>> with the full size of the underlying device.=0A=
>>>>> Making me wonder if anybody ever tested a disk-full scenario...=0A=
>>>>=0A=
>>>> Current dm-zoned does not do that... What is exposed as target capacit=
y is=0A=
>>>> number of chunks * zone size, with the number of chunks being number o=
f zones=0A=
>>>> minus metadata zones minus number of zones reserved for reclaim. And I=
 did test=0A=
>>>> disk full scenario (when performance goes to the trash bin because rec=
laim=0A=
>>>> struggles...)=0A=
>>>>=0A=
>>> Thing is, the second number for the dmsetup target line is _supposed_ t=
o=0A=
>>> be the target size.=0A=
>>> Which clearly is wrong here.=0A=
>>> I must admit I'm not sure what device-mapper will do with a target=0A=
>>> definition which is larger than the resulting target device ...=0A=
>>> Mike should know, but it's definitely awkward.=0A=
>>=0A=
>> AHh. OK. Never thought of it like this, especially considering the fact =
that the=0A=
>> table entry is checked to see if the entire drive is given. So instead o=
f the=0A=
>> target size, I was in fact using the size parameter of dmsetup as the si=
ze to=0A=
>> use on the backend, which for dm-zoned must be the device capacity...=0A=
>>=0A=
>> Not sure if we can fix that now ? Especially considering that the number=
 of=0A=
>> reserved seq zones for reclaim is not constant but a dmzadm format optio=
n. So=0A=
>> the average user would have to know exactly the useable size to dmsetup =
the=0A=
>> target. Akward too, or rather, not super easy to use. I wonder how dm-th=
in or=0A=
>> other targets with metadata handle this ? Do they format themselves=0A=
>> automatically on dmsetup using the size specified ?=0A=
>>=0A=
> Which is _precisely_ why I want to have the 'start' option to dmzadm.=0A=
> That can read the metadata, validate it, and then generate the correct =
=0A=
> invocation for device-mapper.=0A=
> _And_ we get a device-uuid to boot, as this can only be set from the ioct=
l.=0A=
=0A=
OK. Got it. Done like this, it will also be easy to support the v1 metadata=
.=0A=
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
