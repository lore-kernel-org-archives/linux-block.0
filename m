Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10CDC1975A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 08:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910B1206F8
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 08:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dGA50EkU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ms6lbWUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgCYICc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:02:32 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17791 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgCYICc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 04:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585123357; x=1616659357;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8wXIOGqKkf4OANzj9qpXGfOoOviyNsck2h6P32OFX+M=;
  b=dGA50EkUcWr+0NnognTF+SsD9/ZxzNrouXDj7NSbeeGW35b+w78OP/Cx
   lYTl/Nr9OChxIikM549Fv3hMETxnr83hvWBG6SDITm1JhHNylmX3Q8TDK
   +d/7AAZFV6t5vPfdWnJxIjq1N9pbyvyEKcb20GivcaUYFK2nvzwHnfrbj
   TVK2YRaCve9/7AzYwOBIfd5YIXkpvFeNyC3vTEykeTO0DCi3sj0FHvgjg
   VqCAkGGUz9zFQLj/IPeURgyGHYuXas7E5MV6KMOH+W3Cg/u4H7cSASULj
   hGa0+h8s4SCM62D695pe57LH2h2qYwW0cJkp8PmUCTb9y1dQ7rzpIIcFT
   g==;
IronPort-SDR: OQ2sq/eZXffcws64McNp571OdyUewgZP4aD3Y6xbVUfeJQnase9dKcoy5hx5i60KuhcZWTUFpI
 Gx1QysxM10YZT4X1L/Aadu075D74sFUXlDsjwRxKzZ/sJunAh4+mp396mSNG+D9UMU9u7mhS1f
 Ga/ZqImCVa5HiNrFYyVienIIrqPLtrXDwO+oMD4CuGquy43KZIKwbgmQ474JQp/5fJeFZKCNfO
 /Z19klSYts8Lk3f7Fxy74jpjopVMq/vo4tYKYBDthDqkkpLibrbe3SI1j6fihm6DMYYov0ZTSr
 vgI=
X-IronPort-AV: E=Sophos;i="5.72,303,1580745600"; 
   d="scan'208";a="235671313"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 16:02:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKhycJcPdXebdvEwqAyzuQjWGFF+D7wbu5WVbZtvNE1soG/w6EGYS934wVMzQ9PIm5+B9agifTos4rJYwRsFXFlW+g/PCzcyiw6NjtbIimW6r2j3iBwc/3Qcvh8alwPgVtS90GQfOWqjeaAIugg/lxwch+e8TCoNoThAbJI0rHKEoTWb1rT9lTO+xMkrVnbti75C6fbbKTa9Jojvehw/P7exoIPwpSEPMKIStFjxvI66Rp/XfM/j1egwBrvvld7UIcsl4Q6IvMaMlv2aCemx9J7j97fnim4JeBU5rAJMucyczGQ6l4S2LIN3BhfYNHZH4hBSQLnVfKK8o19si5UTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v7D+3GHyASesjIyGBvMXDTN7lmkimkPaZ5AA4zBXO8=;
 b=DLSDT0DSac8GPQuh8fWB/dNLDoP12Z3fNd0f1W82eRxq7Mv/YnuCRNqBZGSPb9X9nX4Vz71JHzDJjuHIve2P3NIxqw5/mjE8beNdLOqm1b8+u8Xznl8c/gVfxSAHZNEYPBLAgPkG2ydcyG1zNNDMA9DGT+vswpnDx/73Hvy0d9e0mW3sdePgAb/pkXGjD01zhCnQuljt9VHfps66yKgE+0k0UVL4q39GGG850122hU5i8dMrqbnYUvQA9BmV4ucEWG9idWT3eFsdYF5WB2RHPd2nG9Mc7GXhW06u1t3Lq4j49yIXRNam5nNbCHmCb11u/Pt5Hww+K7Rkr9hkTrMeAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v7D+3GHyASesjIyGBvMXDTN7lmkimkPaZ5AA4zBXO8=;
 b=ms6lbWUiNJrXagJUjIS4RxLmN/4zVCQFzh1EDK6YKKHo7SARq/5LNSRDEGVAvryqDtHR11xUh9eLUOMNSGtOqk//Ky6BleKWRJ0ZmNU0HQNadwHJGGbuzmMMly9bSPobw1Ol2g1bT3iP+5fkln98s736RDE3b9oQkJmA9A9W778=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2245.namprd04.prod.outlook.com (2603:10b6:102:6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 25 Mar
 2020 08:02:30 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 08:02:30 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Hannes Reinecke <hare@suse.de>, Bob Liu <bob.liu@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [RFC PATCH v2 3/3] dm zoned: add regular device info to metadata
Thread-Topic: [RFC PATCH v2 3/3] dm zoned: add regular device info to metadata
Thread-Index: AQHWAcvtLt+lRR39/UysINFCEirB8Q==
Date:   Wed, 25 Mar 2020 08:02:30 +0000
Message-ID: <CO2PR04MB23439B5FA88275A80D3449DFE7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200324110255.8385-1-bob.liu@oracle.com>
 <20200324110255.8385-4-bob.liu@oracle.com>
 <CO2PR04MB23438E0AB35CC46732F96085E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
 <812da9e9-cfd2-ea24-60cb-4af48f476079@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 261764b7-943e-44b9-86f9-08d7d092de29
x-ms-traffictypediagnostic: CO2PR04MB2245:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB22457A6A1DC9969C6E433DA7E7CE0@CO2PR04MB2245.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(186003)(8936002)(55016002)(66556008)(9686003)(91956017)(26005)(4326008)(66476007)(66946007)(76116006)(64756008)(81166006)(52536014)(5660300002)(81156014)(53546011)(66446008)(8676002)(86362001)(2906002)(6506007)(478600001)(33656002)(54906003)(316002)(7696005)(71200400001)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2245;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xQ0ba4CmiR9PbGfqVb9QTA+yyHrP/BUYT8ITe62r07J/MR31u89R7KvQ6lsP0P17RteUdoXqg8hFs397CxLTw15Sjt/8xnzgaYyhVyW/ZAWuexlmkEwciMY+T5lJiH4p5m9+OohIR2JHOGkm1TjOE3XSQ0FisbssLSi+mMpJMX+FIDkpCTXQaAHzRP85qBA+Jg6+dtYRKJpyk9Z8tXEnihfxiBB14QxW6xYuNJQjOgKNu/1Re+vxGTCKjBjwtpmXaJqaLK2fHms4zsNjbEC6xlN9Xw9Wn8kvpaNaqVkjRKUwKIaVS4jul0mnx/DjaT3STQif6ypcaa9i/tH5UCQPBYgfASf7dPHfkQbOUnzF8HD8/werm2Nef2jLZbfR6ucJ5ID7/4VJeiq/484wpgBV/dt6/TeBMCeRDVO9v4aRZ8LWcpnD0R2zc4147/Hh0HX6
x-ms-exchange-antispam-messagedata: DAnee2Lm69tIZPJoCGA8Fr2c4GyisHJkldnl7iaEhAgtLOV00Td90iTVviMswwo7H7z2Ce3KQch3eOUoYwVYSLDz30CffZsdCPrsazvQKV0MedEWPMbGr0pINu/QBDETmHbqawEpRV+E1fbz28OrWA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261764b7-943e-44b9-86f9-08d7d092de29
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 08:02:30.6371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPx1+SAdikkw2hSBu8/+7a0yhtDuxCVoRaDM09PO8rwZJO4s1A9sUS+/tmwOb9BJ71+VBPcE0bXYNd6zmA6BJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2245
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/03/25 15:47, Hannes Reinecke wrote:=0A=
> On 3/25/20 7:29 AM, Damien Le Moal wrote:=0A=
>> On 2020/03/24 20:04, Bob Liu wrote:=0A=
>>> This patch implemented metadata support for regular device by:=0A=
>>>   - Emulated zone information for regular device.=0A=
>>>   - Store metadata at the beginning of regular device.=0A=
>>>=0A=
>>>       | --- zoned device --- | -- regular device ||=0A=
>>>       ^                      ^=0A=
>>>       |                      |Metadata=0A=
>>> zone 0=0A=
>>>=0A=
>>> Signed-off-by: Bob Liu <bob.liu@oracle.com>=0A=
>>> ---=0A=
>>>   drivers/md/dm-zoned-metadata.c | 135 +++++++++++++++++++++++++++++++-=
---------=0A=
>>>   drivers/md/dm-zoned-target.c   |   6 +-=0A=
>>>   drivers/md/dm-zoned.h          |   3 +-=0A=
>>>   3 files changed, 108 insertions(+), 36 deletions(-)=0A=
>>>=0A=
> Having thought about it some more, I think we cannot continue with this =
=0A=
> 'simple' approach.=0A=
> The immediate problem is that we lie about the disk size; clearly the=0A=
> metadata cannot be used for regular data, yet we expose a target device =
=0A=
> with the full size of the underlying device.=0A=
> Making me wonder if anybody ever tested a disk-full scenario...=0A=
=0A=
Current dm-zoned does not do that... What is exposed as target capacity is=
=0A=
number of chunks * zone size, with the number of chunks being number of zon=
es=0A=
minus metadata zones minus number of zones reserved for reclaim. And I did =
test=0A=
disk full scenario (when performance goes to the trash bin because reclaim=
=0A=
struggles...)=0A=
=0A=
> The other problem is that with two devices we need to be able to stitch =
=0A=
> them together in an automated fashion, eg via a systemd service or udev =
=0A=
> rule.=0A=
=0A=
Yes, and that has been on my to-do list forever for the current dm-zoned...=
=0A=
=0A=
> But for this we need to be able to identify the devices, which means =0A=
> both need to carry metadata, and both need to have unique identifier =0A=
> within the metadata. Which the current metadata doesn't allow to.=0A=
> =0A=
> Hence my plan is to implement a v2 metadata, carrying UUIDs for the dmz =
=0A=
> set _and_ the component device. With that we can update blkid to create =
=0A=
> links etc so that the devices can be identified in the system.=0A=
> Additionally I would be updating dmzadm to write the new metadata.=0A=
=0A=
Yep. I think that is needed. And the metadata for the disk that does not st=
ore=0A=
the mapping tables and bitmaps can be read-only at run time, that is a supe=
r=0A=
block only holding identification/UUID.=0A=
=0A=
> And I will add a new command 'start' to dmzadm which will then create =0A=
> the device-mapper device _with the correct size_. It also has the =0A=
> benefit that we can create the device-mapper target with the UUID =0A=
> specified in the metadata, so the persistent device links will be =0A=
> created automatically.=0A=
=0A=
The size now should be correct with single device current setup.=0A=
=0A=
> =0A=
> Bob, can you send me your improvements to dmzadm so that I can include =
=0A=
> them in my changes?=0A=
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
