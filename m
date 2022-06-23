Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1096CCA47F
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiFWTdJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiFWTcb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:32:31 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C956F4B5
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 12:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656011355; x=1687547355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LZgyMSKXfM3cRy5Xisq8i32YZs3DFq4K1TcKVVEFVS8=;
  b=ZIWdolUccdQKIrw3CdlQ3yd714628r4m0Lf+qRo94A4Rrb0L6vQWrsjS
   7Ep6KGt0w81gxM6emGdXwXjHomdS00NXWaWgHSvJldifO36m5qdqVVNYo
   nvbwiNQrDUn+jLDnYD6gXKxoZADt6+0yYJegFqxjB+199t/lDpbKl8Mfb
   TbSlWncQayd8qZRSgFOW9PwOgoEHaeAtLUcVb+P8yF9rFAzz7cOIsqwxO
   Ek/5zgacnPfRu4GSC0+WTIAY91RxDW51wqACeLFC0AqQzGZ0lvKBCgNbx
   ETG4nqh/Bv64Toovb3Rqbe3btspmAwm/0TABwexmO3zSFhM/QpXsfyDOo
   A==;
X-IronPort-AV: E=Sophos;i="5.92,217,1650902400"; 
   d="scan'208";a="316056713"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 03:09:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHt50NQqHuDTDmoU+5dwy6re0bkEjxi1P95+gpdp0K8546+stAUi33neNpNom2TplMRHZLBNAU6Y58iJkvq7/RUc61KkLv/d9QZjoYlIBiA0M14KhD6kU1vBaIObwA4h6IX9emgtzWA0g8q8NhcTLbZOe7NswXLBW1ZWp4hBKTKiAuqeAiVK0MTPsjET6wvxS3aTLnqlwvhgjafUpohSbhb6DitUjCZWeuWTmASKCV1wqXlsGLWGMrmLKKp5kc0R7BoP5LOdm0blajxfrdIkzmCeFMQ0rCwyLZYxEXI3WX56V3Mion/AcZ0Vy+QLiNwODDxk87GnGq1J/2yOEP/MPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZgyMSKXfM3cRy5Xisq8i32YZs3DFq4K1TcKVVEFVS8=;
 b=QCJgRwA2/6VQQ+Tt9dHv6ceEyFmJ8VdpDCPhXVfWcqpyMRCvErqQP5XaIn+45ExLlAArIKl9AD495pUEoTyDxSePbCH7y9kOOCZVC9Kgpab2tY68Uv1WyZnOVpi3NDIjRVVkV1nmkrqv6g/PNQTZnn/sWVTpBaZtiX541CzN8e18Hq5zlLc3fLWn4Sv5aO0bdpSvwLy+EfTZg2l6fQV5P3ZfYwtesm6+6bC3I373RLRErQGrs8+W/PI/IdZOBfofeElLJzRSainemats9ZUio4Q3PM/P14mG4KguOc7I6igHqx8xADE6hQOPR0GJSYpSsFdALbkdM23ei49yKSYsLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZgyMSKXfM3cRy5Xisq8i32YZs3DFq4K1TcKVVEFVS8=;
 b=gNcdR2GTvdZLjlPIpRP4mxSHY8ikvLnI/PY9Ex0bvmNglCxlCur/uUWlo73yFOkl96duSbv4bv5Z06VwzeKBlgyCu/TDfaRg9R2Jzrm00lM/rsbk//FjUm7kvhP4qCCLj15KD0Yt0nu7sjjzXRVs+VBhdG1SuFMv4yO01EDSy14=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB6831.namprd04.prod.outlook.com (2603:10b6:208:1f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 23 Jun
 2022 19:09:13 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%7]) with mapi id 15.20.5373.016; Thu, 23 Jun 2022
 19:09:13 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: RE: [PATCH 33/51] scsi/ufs: Rename a 'dir' argument into 'op'
Thread-Topic: [PATCH 33/51] scsi/ufs: Rename a 'dir' argument into 'op'
Thread-Index: AQHYhyv3TbXpkMnYqUe4BrVmPxAnga1dWmBQ
Date:   Thu, 23 Jun 2022 19:09:13 +0000
Message-ID: <DM6PR04MB6575F3D128766CDB68868434FCB59@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-34-bvanassche@acm.org>
In-Reply-To: <20220623180528.3595304-34-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b912698-e00f-46b6-a454-08da554bdc69
x-ms-traffictypediagnostic: MN2PR04MB6831:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v3V2uFH1iCCCFGdcxGgy7IZ31n66cZgjMSZ/ZCTr0R3MNVSWjTDIZvB2qqOKm85I4ANJRKb7opy91pQVKVj+kWgMHCKumLLPLGJd2kTq4pzKKRx5xk5xQyIbcE2E6DG85IhUT/psLWXmjDL3y2l/VJrLuELf3KfOP1L1dSvFHTW4KIczKRWz1rUK0tooCBUAtDfUfPCr8/60FJU9NyFXJ/OWX/YwW0/Gvu/5ttCX1qKZy+iU4HuLg5NmesFn4m8PHsjNAPm2s8E4Yycv+8O+wb8ciftNvTVUNFlgkqNLouOk8hzVmG98zdLJjdO3Ovy3XyeMzuUT8gKDLWJImLut0Xk1uChayKTBnoJ5k8gN/jjnRTSv9oVEbtpv/irknBmXQCWEFzWSJBd8UPIr4D5CKtv38rVs1cN17DTezIKJSYtBf1bL76vGhIBkZ9x3vFN/pJT0iyeovY95I7vavI62fVPKcixpXg5XGm4DQw5C/AHqq6PL2TL71TYGSMW6DZqs/PkQdF3a2w7TNlrx6k2MnNRt/UHcox7CfxuBi71/jac6+9Tdc7ScR0sAy/V7763e8L3ccPeKcOrIShmil5PS1DnGYVuMBippGWWcTDzhqq7MhXRt3vSf1Xr19yXb2B4gaXIRw3nqqBNcaLAZxeSVHC9BLAlZZMET53htzQWIrVdP3RrVP8seHsu+hdWzqBwOAezU3iKsJFxrG5cmAr25GJA76WWp19ZbK0X0oGlfob+vn7Kehro4h0XCeQAfHYUlZi2m/jcI0JAPOnkCcIpY+Y6n2ZfZcVaE+95J59M6aQs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(186003)(5660300002)(558084003)(6506007)(55016003)(110136005)(66946007)(478600001)(41300700001)(33656002)(122000001)(71200400001)(76116006)(8936002)(52536014)(82960400001)(83380400001)(66476007)(26005)(86362001)(54906003)(9686003)(38070700005)(8676002)(2906002)(7696005)(66446008)(316002)(4326008)(66556008)(64756008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EYs4fLXxvOmdJezy2Agv4nguW62ZwXP2bNfX0iXyxyZITGasCBjmBeXP7568?=
 =?us-ascii?Q?tTLtSqeKkXchlNeoX2NP/XbZU3jCusgXO9VRqDhBAGElJWiiU61TF82UBAKi?=
 =?us-ascii?Q?NZxqhhFh/A9jEj/h3IeVrg2wQInju383VVJ+clKW+LkOea65qll3li+WkU2T?=
 =?us-ascii?Q?IaP1VxhJ3DHpIYyrR8A3jnjECZ3DibIsphXQsoEP8nQL1bVoqK1wVQaVK438?=
 =?us-ascii?Q?zLoj4wR/ooVKswR3yLdqnbtD7a5tfqhjF0gekiITLu6aWbP7PPWGd4VTEFzd?=
 =?us-ascii?Q?UmAkCJni4qH+8i66hcrHk2Bn570V9PbqJfSmZtDrnbjW7Bax3kPpksMXtxkG?=
 =?us-ascii?Q?oGZ8VHQq9X1zaroOAKmvLtC5sLLENL7UgFrpi1Vk6lJiMuifJdsgkADL/yN+?=
 =?us-ascii?Q?BYS0cBTHH/48qjnwap7MfOLYGtSaq0m/Ka049dBXLUfgb4e7xQzJ/40M9sFt?=
 =?us-ascii?Q?3yd8mOZ3DKAIhEJF/MboFq7RZDHVlbOBdWpukApbdnq3OOSME4mcPFXDBspV?=
 =?us-ascii?Q?MdKaDFJzEFVQI9qRJD27MCHR2YYcw7u8ImKYq6MiuGftILGTSrk3OQeCq0ug?=
 =?us-ascii?Q?ae7sbJF9zBHs+xwtTPtfny8vEQfK+dJJmBJM22KdSK8zE+xMzXG4FU5oefgi?=
 =?us-ascii?Q?H8z7qXFP1b+wAJm9IheYX4Ue2+E0sJuHeCNTXIw2QbIkHakldG5p+JPQ+u3Y?=
 =?us-ascii?Q?oh4n48CVzIjbfF+sOH4sBOmhTGge2sI555wQCnHcB/QzqqYicx7kEbQlba0b?=
 =?us-ascii?Q?azN615TL8eRpPZFcZ06554QL8iEEe7ATpG3YrOyggpPpTmiuAo4Q70EB52/E?=
 =?us-ascii?Q?bzdXZvpJoc4Nf/+dow4AAZYlQAvK5k+jc3T3u7+mSur68vcon60aHextcdv5?=
 =?us-ascii?Q?fm/D24L5WxX0XaUWuvPL7XVq2U/Vil8ahWuegTuabGwOvAp6LvIDqXN32ZDT?=
 =?us-ascii?Q?AWErCLlMhwmuExfwQJqetfK4Ye5c0ud7WPpWRpZAxJBcbWYnHCcAoAWxDNqy?=
 =?us-ascii?Q?YFiRQ99r7dsTu5jBgtTLgG9XaT2kmGhNZvFqFZo1FJKRaYqjMKxhWmveK4bT?=
 =?us-ascii?Q?/Hh1Kafgs+5dq9qTfnk4K9BVhCVuVChyavChgNZnlkn44TZUrtTFH5P+Ay4p?=
 =?us-ascii?Q?v76yy0yemvc8QGCQgFuuH3JIC5fhHGzXcGcqJg9roJ5iO/f7M6woirfL74wL?=
 =?us-ascii?Q?rBGVjokNbiq/jkN99GX0lZ3031kbJh68v/jqTu43L74jmipm+6N8UkRx6L3U?=
 =?us-ascii?Q?KzI6utPmHmyB+XDHXlRm8BkXtPhvCUvEgtSpcUJ8ipNYSioi9hm0TeDBKJ3l?=
 =?us-ascii?Q?zh5iXFMLWpbHKyFI4VwnyLD1OZjKRD4uGo54kzqv95Lkjot9oiHj6ARjdxKU?=
 =?us-ascii?Q?IOkK1lhJO5q8JzmabbtfIGiOaylKUCmkOX/AwTF8fS9bAwuQJcFyfa4LWJ2w?=
 =?us-ascii?Q?Zre20KYDy0W/jPIQsa7sFYw++msiL+ccPNzoknXMDpYWWsd9nKi9/QgJJSnj?=
 =?us-ascii?Q?0aR8z2ULGP6LqpPTgoRWWGelE//zF1NW2INkEZQy1iQxTRerCyHkEag2s7WM?=
 =?us-ascii?Q?ZMQJXPF2lv/wpy5UAyxS7rujGN4A6w5MJk5Q4CVR4Exwv3xkr0oIKJj+K8jW?=
 =?us-ascii?Q?GNt5XblhjMxnvS8zs3pGs0oOj/GH9i38qD/N3rX3EtvNVezl/U9itvvR5MUK?=
 =?us-ascii?Q?4oSZ1+xRgsS6iLc6KY0EtdpuoayyUO03O6Eekq1VLzmrXr02LM5lhKNAp1NC?=
 =?us-ascii?Q?fGfgMio72Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b912698-e00f-46b6-a454-08da554bdc69
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 19:09:13.5009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L3HibR/7JZtGUS8hn8hb/u6B1Xk053MS6aNvkTcWZaphm8YI77pkHpl7dwIkiT6cnsHDIM/UIzXgGUPdGbiiQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6831
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>=20
> Improve consistency of the kernel code by renaming a request operation
> argument from 'dir' into 'op'.
>=20
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Avri Altman <avri.altman@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
