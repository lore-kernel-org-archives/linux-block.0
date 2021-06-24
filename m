Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27E1C49EA5
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 22:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964EC613AD
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 22:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhFXWuo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 18:50:44 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:6339 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXWun (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 18:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624574903; x=1656110903;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=neyedgUFYXZ3sYieu2Ywi2RllZkIApI87tGcEpo6zOo=;
  b=rNMOQYpkc/43SZ9Uc+iERHyaj26cjHsZ6JyTx5yBl9+jaGIT5cEoUuFt
   mbmGCRBhH5pdPdvFLPlT6hBCQ8hKssgVtJh9Vc1gsWx44QGxmdL2E7+5i
   zPyBdW4vtn2f34mAH/yBS5SwaqCy+cUq3MOiJle3FV0flilisRiByK66x
   uD7y38n/NBBWDtcAuqD7b/xZA8YV3Gm5t4Waq1qjgYFEfBDYJBfpan9Zn
   39uIy0HNQEKdFZ1nkrpb2oc8oryqEPLouSNXC/fQdAtPOurYwuPWe0aJi
   oomYth04OaQFIrXZHuPsUajyj8hE8ZxAiuo5xvHqTX9raSbvf0+jWOLJA
   g==;
IronPort-SDR: 4lRPiDwEI9R3MqM+kmdeYncHglq368johZK3uYILJNe9w2TBfFO7UftOfuf3ksyddlbY+iRDFm
 MUByl1+Ov66V+wsLNjXiB98Hkh1SGcrM3SaARJ3C7ZPKGVdfG/Atg42E/UarZ1gF5Kd8uiWPEp
 AIUB/e08dBJ5veSNiMeOWSTKCVyCl1CQtbFchdZzSJpWfcQK61R+cXYzRiHJZkj7WHMz/rxY1X
 S1SYUZTsK5akDvr5/thHCbnIMTNVQamxzXrokDNWP49vbil3kdBS0dfBmaU93RCxJlrAOD//zx
 ah4=
X-IronPort-AV: E=Sophos;i="5.83,297,1616428800"; 
   d="scan'208";a="172844252"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2021 06:48:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrJaxvwFvb7SsiOj4VIkFQ/AwI+A1Ct+f45MOPvZPT/99btI9g8nDUxYThSQAZfPnccwCbN1IgNsGCucoTolZyoMd0znRLUGLu7UIfsGGwMxTGmhyB/Wmh2pJoUHJcnqmyZhUnBGc/CQCyS9N3dPhomegOo2mGOEgPP03XkFzCNT8L3hA4lhgowzIXzSjlWPXC97KeZ+iPV3Vx+0xukT1l/c4xMBYqDfKnpRE6wGOSC080/fL5Jm3uE1cDYumk3qd8vGiJfJ1Z4I077ZqKO3UMp2VICk7lzMToAE/Sovt5NvMcL5C1yl+PDYavnaRh28ILrE9PYLQN0ciFfNfgnfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neyedgUFYXZ3sYieu2Ywi2RllZkIApI87tGcEpo6zOo=;
 b=f7k1kLBVj3tTcSPgzqDWonhx/pbkf82EfnBAS23qzC2No8xyk1v9QaJrb2CPHtO8xVagi6wZ8qq+26A93awmiytKgAkWIsYioQRq9pIv/CT8Lrle6ghtlYjWSBhMlruIFE/D908ylSABqWQ2Ww4Lzca/OFa9aTs7qCd+z5mNmhB7abEQbnATFpeKlTxWjzxCeEGn5xaFg/NKZYP5jnpPXJHnLKQTzp7H5q8YPYX1HmKGVjTSTLhhB+ZN8mL3KF4HOXbTaBwGB3oVisdlqN5siCAIZ1QLjbmSPYBzsgvRtkqxBUFkpBBdzd7/otIYNO1HIwSBseVJ+Dlms+ZkgfAMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neyedgUFYXZ3sYieu2Ywi2RllZkIApI87tGcEpo6zOo=;
 b=MD4PWuO1u0jqbJ0Vg+859chgt2PJYfED7qAGfF11u+QE2A+j+WMN96mkLRwM8rS23rWhiLuSGVZ/ik9dtwbPPNiQk8v4ByMFPSyp7F9EVENqNCCH09b7yHi94h0ydCi5kvbnSQf7JjkU9TNmz/sTsy7NHAuZLl5Kzee1ioG4uDQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7152.namprd04.prod.outlook.com (2603:10b6:a03:29f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 22:48:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 22:48:20 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 9/9] loop: allow user to set the queue depth
Thread-Topic: [PATCH 9/9] loop: allow user to set the queue depth
Thread-Index: AQHXZ71Xsi2lrvqM3E2T/BjEMZdiIw==
Date:   Thu, 24 Jun 2021 22:48:20 +0000
Message-ID: <BYAPR04MB496564636FFF75A921CEBD3386079@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
 <20210622231952.5625-10-chaitanya.kulkarni@wdc.com>
 <d433361c-f270-f1a4-4eb2-3c1c10e7e5ec@acm.org>
 <BYAPR04MB4965D4C98E4ACB32709A273886079@BYAPR04MB4965.namprd04.prod.outlook.com>
 <af677291-d4dd-e3a3-886e-3dc9e3779fd1@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bb65b04-af4d-4b06-30c1-08d937622a7b
x-ms-traffictypediagnostic: SJ0PR04MB7152:
x-microsoft-antispam-prvs: <SJ0PR04MB7152952F2DC8A97C046A9E2F86079@SJ0PR04MB7152.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FhAc/f+QYsURis/d7+oPJ4EWx+isGDS+4xp0fWLr5e16wKnGoc866FrUaDenzHXtq7uvvtvDloukzkHaVnzFkB5X3gAtYl9u3NuyDg7gF6FRwSV5M4TIOEO/8OhaAmhED3Nk9CTfHyvonQZ30ogZSpiXsq2EWaRmscUdFAFojifInDtPEg5T1myotoTpY9Ax5al4b9WA5+exS0Lta1v2vnUELE3in458ak8+sZ2WYvBBKYEDX+56TgPAO9HWyPkqHvh1y0OHzmloFvhDRvraXInB3OypqT/Tc0FOPBv7sAlVFgGAuBlbYbHygxxnPbglPwWzBRlcf/UY471rpStOJvCh7Ge2tesLv3SMVgQdZ1Ez2Xuf2P/WCcvWjVfKv60N4OBMkrzKp+EKLY4r3+pWkyByx0IFlDemogXHqkHdj9lvshf7+OOrkLPr/zgVo3nfGVpNdcTFonAnKGNew3iRCQDS6By/8Apb6N3mdN8jg4t7XK2oJFSvFbkEAL3R4xzZw1AeOIghjxLnlsRJtRnCbzejMEjpTROCbvD9lc1snvXbDvN4rNLb/9AsFd5UgCngBXjrTaTM/cRhLxDDWtmNm4EpiKCexjRrgXeJASNLGXSyMQyElpT5V5Lps27cZWTmi1Yt+z0/rtKJ+pZEdcYHow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(33656002)(478600001)(8936002)(8676002)(86362001)(4326008)(122000001)(38100700002)(71200400001)(2906002)(52536014)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(9686003)(7696005)(83380400001)(4744005)(6506007)(5660300002)(316002)(26005)(54906003)(6916009)(186003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bMP25Xfxf66Ja4Tn7eTUVNKDBRN56Gl6Fuj6PanLAmd90uxUbDWz/xxMFspP?=
 =?us-ascii?Q?7G+9QrbYjQoJlss92YCrlif4Zm/52PB7rk/qJEq6APLFyk3OAKbl34wnlvGH?=
 =?us-ascii?Q?ma0yaa3s/sgSxcuoztVAaJUBWPUWhpIklayDI6+FCv8OcIip036qvHvHbCqp?=
 =?us-ascii?Q?onJSpSWSNH4xC5ugPia0p8JIOUiQxluWvlpePdVCBXQxUogQ3dx+WvV9nWMd?=
 =?us-ascii?Q?4bNW6YAsjJX8n3UK8vxmRD0DpLVyEO7BzRTnhUNrZnWtxC9yLhhEzgmXZ/64?=
 =?us-ascii?Q?9FIqTvCVG/dfMRPAvRttKRML/1zfG8igRydchVU+/ebtmZWXQzhCjGdduN/r?=
 =?us-ascii?Q?xuF67UcxGVr3+LA05Fgs9bDtjRhrg9gfG//xHv4piwMIXTVAyq1Q82oMPAn4?=
 =?us-ascii?Q?Iw2HQtDea+xw0RrC5KW1jHd4WPQhVWaLBr2RWxWDpQUH7MlfdaNqQ1BRKIeX?=
 =?us-ascii?Q?aC23KYOPyARLNCvj3MYnSloqC0+m6NgA0Gg4PW31ifaDlOgjElKFerbHFfDH?=
 =?us-ascii?Q?MbbslNkXq3CTKlhmvYVtzxsxyTa6jIEXPpE2/gNmLA3SB0s7DoMkOLgrdDIi?=
 =?us-ascii?Q?o4+goXkLvabd8i0j22hvyUI2bPDMwkhwGUgHYTXBJpxuYD+GOWCpQRqi0Pte?=
 =?us-ascii?Q?q/y9qje0J/Iz/9zBm6buID/adwuBaFX+kO7ngRvWOYT3lO7hvKTYW+i+YPgW?=
 =?us-ascii?Q?zbEmRreqEAUsqcFXbN5kzw2ARhdpyEfOK0JlfgVh9bNQbIjNnjsjtiFLLM+s?=
 =?us-ascii?Q?hAC49ilaGIBEWpk0qMd1paE82pIKxDRUJfg5fOxnmcniGJ/T1CqEkvqYshJM?=
 =?us-ascii?Q?Xt1RlOpGVx/SMDEUb+bDe5IG3iMXMvmTa2abhE2YoK+UdeuWB+mlSVrKlVnz?=
 =?us-ascii?Q?dVrq2IS9q34hlupHJqbYLBJPGfP4+mKvo81EHjOH7sWMZtjlzW+jvShLD+cb?=
 =?us-ascii?Q?MBXr2qX/LlH7pq8jmWMxymzrOWynV/85zU9FWf/+zHDGwAQPYZRPcXWCMxxj?=
 =?us-ascii?Q?YC7o20Zm8elsSLifoLF02hoXzWESBx2dtHknRJLuSrprKeBa1al0AcGzdMIc?=
 =?us-ascii?Q?dSfmxANLrIHlii5MqYnKpPntLPRVs9/XYgknSDmNCfzVAZ0rETQKWRJlQcH2?=
 =?us-ascii?Q?qyHYSh/LtbuVZxAC4Fm9gH1P2pGaDjoYX2qmfOWJWaVITsFtgPWHhO05ORYa?=
 =?us-ascii?Q?HYrJ0+46Yup1l5iJ6Utkcz4BjxsyhRZUsZjv/eqyLEMT6PEHvCy3SBb7faRG?=
 =?us-ascii?Q?X6QA428LCohyiQe08g5X/kFF1dxUGt4JXeUF2KiCMTZT75W2mQB0KyxF+89P?=
 =?us-ascii?Q?Y7l3Oh3jWyCQcwL2UAINrYUz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb65b04-af4d-4b06-30c1-08d937622a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 22:48:20.7995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7yWpD1gZS689zPs5p+arO4FU8NKU2e7NtjvUwaZAejwJCt0Pek5VUS8/HkoOxGaw51zwedldXXbhJPEIpFzLshjvf66Twa0GusZrdSIhE8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7152
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>> Unfortunately I don't have access to all the applications so I can come=
=0A=
>> up with=0A=
>> quantitative data, I can try synthetic applications such as fio.=0A=
>>=0A=
>> This patch is more on the side of allowing user to change the qd value=
=0A=
>> so they can=0A=
>> experiment, making loop qd flexible like other block drivers which loop=
=0A=
>> lacks right now.=0A=
> Kernel module parameters are inflexible. If there is agreement that this=
=0A=
> parameter should become configurable it probably should be made=0A=
> configurable per loop device instead of introducing a single global=0A=
> parameter.=0A=
=0A=
Agree, but it is still better than having a statically assigned value in=0A=
the code.=0A=
=0A=
I'll drop this in the V2 version, meanwhile it will be great to have your=
=0A=
review comments on the rest of the series.=0A=
=0A=
=0A=
