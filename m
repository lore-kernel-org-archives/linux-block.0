Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E602C433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 13:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiD0NuP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 09:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbiD0NuO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 09:50:14 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48407404AD1
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 06:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651067223; x=1682603223;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0GmFkb40a/pecWM/jHAPUOHe95mFJ/Q1IRRp0qNZvA4=;
  b=Q9nNvNBdlDTE0gIA/8xtQS+BvbG4/7pSNAdhkbbc7qWK24OfLL4rk8iA
   U2Bv3PXJz8RVjuee9QdMHETUHDBT3twcqCLHXMSDeK2CofWi3R/H3TIRr
   RGIzh+2uSA2e5caInrGw/VfoMh0AFCgQ3udg4zH3W3v64GCsScmoH2EFN
   PIjQloARfj4fWJfP2M+/riYXRyLB3HOIKygMQSrzYgjkaZcbfzYqrtYQb
   T8y+BhEvdHi+z9GYg0asio852VbwarWwA7Jaekx4lyhGl17S7ekBt298c
   WUrEiUXZFXx6eGXN7i+52MXAluLpsw3UfUUhtp8DG8y/NBOQwOaa3Zoo/
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,293,1643644800"; 
   d="scan'208";a="199852958"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 21:47:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZitNVkelqSeGdI3Q2qex6G6yuUhDYhVJXUfn5QfTZyTTjODpqz4bYw73c9sasyXLtA88oiDdvhzTe7VNQEIfSHGhxSpuGadIU4a42pW4K4SCD2+nZJc02MHPKuSZ4gejRK6AzLVVtnt1KfTCacKym4ErhtxjG+KE9H2qJPpI0ADiEFq+Mk3KQjAvfI3r+8QeydMdVM/DclgznZIy0t53R8Q666V+7j0Itcyo6BcdyfwOhfXcQwBV439Yl4OHFzaTUpqHQtvAxlAdXbIKdmJmBO8h8feaDZo3f4kaoPgxWHp2yQ5d/WYFcgI+HnYnNlxyH0RdcI1ktFO3fPSsQlwUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GmFkb40a/pecWM/jHAPUOHe95mFJ/Q1IRRp0qNZvA4=;
 b=im3q/hzsmYFIMdqdDT8d7iKgWAkjd5dlt+xolyyJd4SXwjh6wlbZhzzlBNITAgSokfln6VyuaHpHlRKSbhefWgsKTQQSA/m5IdAnORBTLykSbjI83t0t+7dLkfF3wilvdjC/dIflbkWnOesS3Ldj85UVpvf8Jq0iSS0i9VqSaUkrTxaURfz8riqbK+zwumFRjTnhu8zyOXldweNMx4VxC9I6nhVBEEwGPN/y/3psiQkG75Bxa5z2EPXqx3xYU1VmlKcq103oGFe6UL9tkhTjh02sm4IwtA13Kzp+GIF+KaWRjSD1A5BpU4klcCWtWymN8iVQLKgXqwBojON6T0oMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GmFkb40a/pecWM/jHAPUOHe95mFJ/Q1IRRp0qNZvA4=;
 b=tDBisQ9DU2mztNEEvK7FzeIThR02CBB6m2+pbUS35pgLkcILkEo/S7FisWd96K061QcWSVH0Bo9SWPvJdw2tTfiwOEwV5L+HYRDKydcSXFjsbVfPgEKN0GXHXxkTeWD9sOO8cJ+oEhhxQD0Ksr0CTSfHt8ZexoISvQTiipxjw60=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB0793.namprd04.prod.outlook.com (2603:10b6:903:e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 13:46:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 13:46:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH blktests 0/6] extend zoned mode coverage for scsi devices
Thread-Topic: [PATCH blktests 0/6] extend zoned mode coverage for scsi devices
Thread-Index: AQHYQ9X/np2PQw7bEU+9QFJnuSz41Q==
Date:   Wed, 27 Apr 2022 13:46:57 +0000
Message-ID: <PH0PR04MB74169B8CC438FAABF21475E79BFA9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220330013215.463555-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 923ae307-3f8f-40ae-9f2d-08da285465c2
x-ms-traffictypediagnostic: CY4PR04MB0793:EE_
x-microsoft-antispam-prvs: <CY4PR04MB079321B61B86D01D17783BED9BFA9@CY4PR04MB0793.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9cPEfaKZf9IygspmnvDAmuRQiFjhCVh1l9IaFNZG4ZOt8N8GPOkhWJdScoh0h9F/pJagnZW3cMlqDqH48ILMU4DhytYMYfCoItEw8NDbOSwyN/w5sguBWK8Oi3gzk+mnjV24PHG6EC1+ojuwSBBdZ+0ckWc74cCpaLl2x6nyRCjgqQSbyRUUc2ljnH+LEjTG5gXNhbUMb7k7SvWgOYUKAa3E6wbVtjpb0lgpsxvs/YSdxkG2AwkGBhwRpQ1ht8+usWsUt5gKWg9/XX8gcPAubo+pycBz/wPZAfUvOpx2swLuX4zcLzx7DWhMzxoUWbvmQ/IV6AGQSrhLtlekGPvGSgZYEhT5MEJXaTK5EDEu2nei05x5X+SdKyIleIEevFgyXQ9s8ZqhdxTzL/dRyOxa3DfHbbfw4QHDkmZaJqTpV0+RVIYyqOZNLeNCVGc+md+78bVOEiww8hiUuTHJUAKTqDn4KaoAYUxgeQytehSskxK6fmZie5bvq2FW1ODlyvvPWQuG4xieruOpBpDHkjkUyKP0B5Pxip/t2AyMeHDY/jYX7F/dTxvya4Ii5heAolsb/+jYeZ+WjLYJV//6RPtO+079+5hWizmkxq96rmpBmgxMjT6yJs+juGgVuH1d/DfOHpsgUKrKIah1p0v9dJ4nb2Xg5VzZXt6V1SgiN7uIOg3cRA7ZzjLXk+oQffNLXRTTRCGlr/hCcuEb1Bu1geklWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(316002)(33656002)(55016003)(110136005)(4326008)(66476007)(8676002)(66556008)(66446008)(76116006)(86362001)(82960400001)(64756008)(91956017)(52536014)(122000001)(54906003)(71200400001)(66946007)(38070700005)(38100700002)(6506007)(558084003)(5660300002)(2906002)(4270600006)(7696005)(26005)(9686003)(186003)(8936002)(19618925003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GYnNlNKt0N7jx1zmiaHEprvDBCGi2BAgDm29WTu9bl0yS13vahu1mlpmSpdo?=
 =?us-ascii?Q?CQTn7GEiU+VnDImyWvfuvuU+fEUY+NTqwaEFtzQWFubs9Xsxx2LcL1BQhYv/?=
 =?us-ascii?Q?zZlC3CKKIF6dv5n7ksTAuiDdnIybzvIXX9DEzWZXfDoT5RquY06wKtrweSrj?=
 =?us-ascii?Q?SR8kfozEMb5hyl7rQ2iMlseVu05SXsoa3hAyzpYlWOEPgymEPKtE+lRC4tsY?=
 =?us-ascii?Q?p7b1dF6UTGVxMrykpNN64N8ddDG68yNID4cgxyLiPiUphhnLmBElNBXgxr1n?=
 =?us-ascii?Q?/rfvI7ZNLi2ytg7TIdAQjSQI600T8haCjzRxJsyXzYNXSJwF5Qt3/KDIZQ7c?=
 =?us-ascii?Q?M86sl/crN52721K/uhdmuLVtq2fTyRjuwm4PDkPEIkPPJEatXXEF7JKrMLkI?=
 =?us-ascii?Q?FKc1i73QEWFoEziNG3X1evsL6CP6snmN27lS6Egv4FzMp9cxWgMVTsTLiB98?=
 =?us-ascii?Q?qcgdSX25MTNfKG0KRvbNU4wnpBXDwlYartT+Xf8KwSGUuIzGULmXGY/2eMkn?=
 =?us-ascii?Q?SEG43tkEEj1PiyD/0FZICyOxnhGb9Pz7w9vLpp+3HMmcxxqO2V5Dp5wwTD95?=
 =?us-ascii?Q?fRs/0yhhJWNRzOtQVXTEEAMsdHtUYQAFeMpaU/xFd0AXiRiiobroG8Wxg/IL?=
 =?us-ascii?Q?j20YixNfYP9jme75RDH3KMHbnMpYyQG0UBLVvwVM5/r0jHkLFfdNUG3VVmES?=
 =?us-ascii?Q?M8+GhduDdbWr72ip37Iklnpjh+UMirkGKPRhFaPDuJw3AqpgRT2UfVtgDbd2?=
 =?us-ascii?Q?O3qXGfTao0D1/tAhAIfpWnq0xbMDdg2jNsdWTZxtkAu+59pd/8UhmTEQ6xq5?=
 =?us-ascii?Q?kVDexI5csZg0xHzATRHhpRnnBVMn+MmbYsGkANbYURceRoJXBnV6m49zV1mR?=
 =?us-ascii?Q?j2ErsJnKMWEG4zOuHdTBH65E+CodmHioVr6UI3R9FJkgPiWSbl1T7Ieoc/3e?=
 =?us-ascii?Q?Jx/a8jNH18sDmpIZmWIKR7VRJDrjP9RdFDgbEO7thGuo1po+j3jD17Tod0yC?=
 =?us-ascii?Q?qyMM82MUajm0ORN2fdO980z/ZvsUFBtY3nDCv29fv1aTNMG13gQ+7SQExQMp?=
 =?us-ascii?Q?UKnKf6aJNOXbHCoG/HPaKZvZhxaT9Gzi+o5Qapd1VHRxyP6uUzr7It6cSzEQ?=
 =?us-ascii?Q?UiGwfVVCb5pAVR5EHdVOIv0xIokycbR3qX+fftv1xWfTCEit60Hx3nH740CX?=
 =?us-ascii?Q?Sro/iyQymW7k2NhCqlll6SJeiYmiRH3gvPSjo6b0TCUD/LonoeQJTVeqC2Yj?=
 =?us-ascii?Q?PNnRldlit9sJp6RVGzgzjn0DX3SNrAxQSI0BxofkWUBJexPIUscjZnBGZ6BZ?=
 =?us-ascii?Q?5AjYPMtcLOVB2UtI6m544RALRIPCv+gLMQM/dkcEU6rHGoBufraIuI22CS1k?=
 =?us-ascii?Q?bAMb0NuPzTvAdAr8xJM9D2f63sS8p73v7W5JNh2o4kI4XC1GVAhIZho59k3x?=
 =?us-ascii?Q?2m/trNVfUb9n1fgtyZzIkA1GcVnyc3EAUn7HePAbpLJuy4Bf0Or4XGALufp6?=
 =?us-ascii?Q?Z0rspS7YSeFQ/9/lzs3Emgqyx05pxLBG4Cc5GQDDpZciK750w2wzkAOJNGxq?=
 =?us-ascii?Q?kSEZLb9AkHG0BHH0myo6HKjK2ukdgzvUhm9piF36D0lDiHXJgrTe9OIQWiF6?=
 =?us-ascii?Q?V1l7sKVls1qkundiqtufzCBMFkY5hbXMeg7uAh7dXipmkRgUfEHE09H6HiYP?=
 =?us-ascii?Q?CUJEBzrOXOSI67nCGUZb5PhcSBVBzENTxl5lZztkZt82IkZm9HVDg/FU7ORb?=
 =?us-ascii?Q?SQGKJWrmlhQOUzPmiIf0O3JkWY5p2/LXyLIesqjFkrmDFGG9HVdK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923ae307-3f8f-40ae-9f2d-08da285465c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 13:46:57.5806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJGHV6QT/W/ciRjQK0Ep2iR76qx5KWTA3McbHT1vxsqq20sEaAOrxCWGFiYzb1ZHOgv2K3B0O2S7t9VPkIxG6qi7FSamZbYhPVSr+vvX6Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0793
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the series:=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
