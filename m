Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE03C433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 05:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5576964DA5
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 05:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhBJFFJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 00:05:09 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:36956 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhBJFFH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 00:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612933942; x=1644469942;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TDPqWJxzLM76q8LDhYGjW7H4hOiHPNOk/gfqv6/sQAg=;
  b=X78qBNnOgGq8e0ctJPAhjYiXfPIm8/I1dxFOvlzZeyCMuO1bCvQdhWE0
   wVDWlLWmRTvl09IpzEyaWQ8p63Xa1RyDX/Z+2jHk6knEQrxs2s94klHEf
   EyI32gEy+iy6Udv+cnffxv9KaQq1OZ58Ap7ure4dhn0PGJSQta3SB7+O/
   a3EcOdFUN5Tg2UmQgqi7weJAhgQbvuSHQsHatskfnoDx8uTerw1oFKKex
   BSg17C/JecpC7MTiX4uSGpL2IB0hO5zVE9yZBz6tNa/azDGedLoP8Hzkt
   jnC2OhxXCRwb7sc8B02F0jq+w6+MngQ7zU+mi8fA4RtVHo5LFDvpfnBHT
   g==;
IronPort-SDR: 1URSRk/9D9wZsQwlaRXOmLHxhu7/Al2nkMrrSMBJKP4JDdgS16FeUjC/yY3VYKZRkaV0sKWzau
 o3XKyVc9gbbjHOQKGqAHAr+Xa7VO2643zRqAG2/yunTm3lJrODLlqol+MOv1jqvq01qYP41qEm
 w2F6W925XjNZYLyF5WwokLhpZ/cDghweGPhBTLoUICGwTELMn678ByEK9tOdbnU4VunNmAGYTb
 WFBJZ7mbMIBA8U3Tv2E1KW9s/+2bvYnm6jFF5O0Q9ZS83qxFI6o+BCEAbaACj3jJ/hj3gxTQ9i
 yXQ=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; 
   d="scan'208";a="263722523"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 13:10:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7ZDdW9rE8O0u+1Pc4KWG8GbPI2I2KwLZn85/FWd0KmImaRUMQS9dBMYnH/fRwtdu0XzMIqf2isLhQ8KF2RcjQc8n4GBCGFTfIB+KCe9LUe2PcznLRIJEXBGZq5k2wHm2JUJubeuMUromZn1rT3zg73V1csBa1rZYTHPXjTMLQU/6h/d4b+mSflTogrMY5ixfb5TFpLUXbNdydGVQUSgkZnpo5XIWwMj4tKC7OQoUH8H5531SAoPIpFoYbEWZ1d6hrcE+WOf0TsG9oSnZNbkkXUyfIQB1AcvlTIdBM4wIpHriPxJyJ/vIdwMffqVyWZ59f5O3/wTBwp+QEX1VHUS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gG8zq6lzt6osSM4PoOsqRIu/M5mMCTnz4geFGAE9/go=;
 b=QXh409MtntJ+f4LBKGKOgHitBEP3HlqqV18Q64y3/5FjnbsFQqeB4t9XtalwjnDjfVhTvMSy+5XimiNizMrS0cGMqSm7w6QguSnj2px2tWPD7euJydVgIL7Uvyr6eQWq2TRToGH0C8mxERreCqbLqHEdELN5+9Q8L5o6Xq64qoZWUVO1KsOinIVwC+Fo+9z7Bs3+0hfHtPTSTZgDoKAgHet5Jqs+N8wLLSGADK73xC9n35dpYwJZe/dUOadASOt+FI5rmjkq8WZCyAd92Ej+gXYRu8xpHI+5G8ijnmqzsSfcRms87R19T4SNl5FPMxS7mSGd7DUxGfC90oo5N+FNCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gG8zq6lzt6osSM4PoOsqRIu/M5mMCTnz4geFGAE9/go=;
 b=ppYW2qLotkqM2w1hSS0cQbDoDoDSKRM0H9LD6MA7erUKkdyj0c6F/m6ZCqttQIs9bsmP5LPYO2496AF3QSxxXDNQU9/knPqwbtjxl4Szp0JBTfhOURp1O09KoWWD3L5x6F4XxDdXcoxT314FBEXYjjmJ28/XbnBm0VquhZYfHXU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4104.namprd04.prod.outlook.com (2603:10b6:a02:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 10 Feb
 2021 05:03:58 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Wed, 10 Feb 2021
 05:03:58 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
Thread-Topic: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
Thread-Index: AdBd7/Jehsbeb/mKAfYcWAj9LaDbog==
Date:   Wed, 10 Feb 2021 05:03:58 +0000
Message-ID: <BYAPR04MB49652279710E99EBB6F8AC67868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <a88fd4c8-8d5c-6934-39bc-5c864e3ed84f@grimberg.me>
 <aec13f12-640c-77d5-bbdd-b4a3e18f1bf2@redhat.com>
 <6ae16841-5f51-617a-aab7-666b7eed299c@grimberg.me>
 <1a520912-ac7c-1a3c-c432-b382a5da6177@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b52f5c5-8e2f-4ecc-574d-08d8cd81460e
x-ms-traffictypediagnostic: BYAPR04MB4104:
x-microsoft-antispam-prvs: <BYAPR04MB4104E19E444574A969623CCF868D9@BYAPR04MB4104.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G4dKWX2oB0KHN2Km0DuOa+mklEGj9Y3cS6UAcLghZlqqbpC8jmjLDwgayPYbhr1PJtkM+8x/RswJPrHM8vAYfSQE0YTKNXi8V/qsh3rM30OvKkGsGHSswgZMj6gRDzJfCyomlcnGHLJjpKTgOV8BF6+VXeXqX+sXGYGHaIEczq27WWqBJ7tqz6uaYE9aoQYCqH6If5M9u7q93jnPDB+1HUTHZBABt9NoVBJI0HE/vFqIwriz8wZn8XMgd13rsqB2xMJCI/M3U6fY1EmJCOTxc6pbBKbAiSEyr2GpMYs0Swd193/XEeev4PKGF/PUOmgEf3TpmCuJpFqwZnlziscHdsWrgZMhv1d5f1MzHOi4PNaJy/GGX+iA4vJDWHlcebgsa3rMmZvIOc4xaM9YeWpSM2R8wy7lIo9FvppHA3VcxyyLPt4/twCuO54SFc9MrmI/LWs6Jfn9RWnCge4z3GRZhzNqLRZAjetD8TLeB+QUxQQBflJx1smlMUWIE1JNiKWWZ2WO7RtGCltG3HMOwFYOVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39850400004)(71200400001)(4326008)(8676002)(2906002)(66556008)(54906003)(66476007)(64756008)(76116006)(110136005)(66446008)(52536014)(6506007)(53546011)(33656002)(83380400001)(86362001)(26005)(478600001)(7696005)(5660300002)(8936002)(9686003)(66946007)(316002)(55016002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tPalVLvJNZVhF83zR/yiOAzETwgOplwHZ/Z6/bNFIKBebAnqbOfyWCoToFoa?=
 =?us-ascii?Q?CXXO9oP+0XWzHigsfAprOiA4U/5/UaOEExsu8no3qJLpX6wbqVTLg15KLiJW?=
 =?us-ascii?Q?Nq7dJ1q+yMBYIyl2ACV9jPTYF6+8Y7ekU2qMRQ/dmzXI101McnGh5frHMNsk?=
 =?us-ascii?Q?TtJ3XzhrU53p1dMfDqBSYu9voDbZFGuFUKOU1HwENnHRTPR1NC4yRJ9ie7EG?=
 =?us-ascii?Q?RaJS+rz9IOhjbCL2z9niFWV57yYQjCypqD5b9xcACuUslQ+h8uDPOcjZK18l?=
 =?us-ascii?Q?hAC8+LKRXXKtYpGzqf/DH4387rBG31eQSvjMcuXtwX9S2jnlWuvGP0HhffgD?=
 =?us-ascii?Q?AHgrCJbxRNmWIGUV6maQWuaTRAIt5gsqCY5tA/NlFLPtN6AK7EfALEfBEKIr?=
 =?us-ascii?Q?SPLYiylTIRu9lb+10BuOidNNOq38FGKfnIh/vdAtlzhIPNblTvgDEJnlQmI/?=
 =?us-ascii?Q?eTcOamwQ2+u7IsRMc9afQR1XBYCDgs5AY5tNqomnGaQgF7yke393W1eWaOCQ?=
 =?us-ascii?Q?5Di3VXIsjbMWi2OAFs8k8xrWEzEXbPclL6CL9DdmBpO3vAsY2Gxi56VRJtve?=
 =?us-ascii?Q?471P4dEk69zKgs8TkRLwpuwqqX8wM8wkLV8MOplECIMUIwY1nOviwAZpukVX?=
 =?us-ascii?Q?0VF58Z1zWAy3Jj5mwlFe7cqmO3YD+HNRqOxOkiOh4owmBi4JrSzsv+iF3sPI?=
 =?us-ascii?Q?GnCfG0UjgljJolihLlg5W4rXjBsdH/iXY51PTLDzXfQ8IjswOB+0N7gFdqeJ?=
 =?us-ascii?Q?VlAaKmxs8HV2M6+Qfj8Gg//Ey6Hw1xoRvnRdDLYP4Omzlfaf7C85nRrdCAql?=
 =?us-ascii?Q?lXJkNE/3Hp/Qpwrdz2NEOo4ofAbpwM2FW6qDvepZnMPri10uHpgVVMn0lItl?=
 =?us-ascii?Q?i0qSOdqcsPBHvkrEsrSVgX4ziF21WJKyA3vC6apZ3qhIoViCsZLHVdAdW4JE?=
 =?us-ascii?Q?oZfcTajSCpZXHK+agy8cw2tJSXJHbrHrDdQGxtPCA8A+DoXPrSoYio+Oakx0?=
 =?us-ascii?Q?+jUZ6ekGvDN2vmLdhML0RPpz31OEE/JjTSpNz+GUdJ4zJam7nKQLaY0j4L2K?=
 =?us-ascii?Q?6pHk6WIhMM3KcnbE8SmXkAO2HmQSIuOm95XyuUyrw+Ckl6unsEDGarHtIwvq?=
 =?us-ascii?Q?HUNowBbhrGurLTin9jyslqcdHxOmGnuhENvhtYiIatTZ9zGgC0OmovnCDRcS?=
 =?us-ascii?Q?4E5kTBvuzByj/5jtLYbzg4fPtPA1daOb9zWqOEriegQZR53HxpfjXsBxn8BI?=
 =?us-ascii?Q?P+TK1Owyg1rqE6DtYahvJL9T+BlKi76wpRneYvt6mFBytKL3EG1w+k0QrHxP?=
 =?us-ascii?Q?vl3WI4u4eZyobS9rSoffrr0n?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b52f5c5-8e2f-4ecc-574d-08d8cd81460e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 05:03:58.1436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okJ6KKvu0KBICgUlySyaKHsqIS113SLJSLvVNrw0cYSTONpcMsPP9xqKXfp7PIqgCUm7WELHj1IYDZ2IFE+U0N/W9bfbzqxqZbNRu1P/hB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4104
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/9/21 18:52, Yi Zhang wrote:=0A=
> So it's nvme_admin_abort_cmd here=0A=
>=0A=
> [   74.017450] run blktests nvme/012 at 2021-02-09 21:41:55=0A=
> [   74.111311] loop: module loaded=0A=
> [   74.125717] loop0: detected capacity change from 2097152 to 0=0A=
> [   74.141026] nvmet: adding nsid 1 to subsystem blktests-subsystem-1=0A=
> [   74.149395] nvmet_tcp: enabling port 0 (127.0.0.1:4420)=0A=
> [   74.158298] nvmet: creating controller 1 for subsystem =0A=
> blktests-subsystem-1 for NQN =0A=
> nqn.2014-08.org.nvmexpress:uuid:41131d88-02ca-4ccc-87b3-6ca3f28b13a4.=0A=
> [   74.158742] nvme nvme0: creating 48 I/O queues.=0A=
> [   74.163391] nvme nvme0: mapped 48/0/0 default/read/poll queues.=0A=
> [   74.184623] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr =0A=
> 127.0.0.1:4420=0A=
> [   75.235059] nvme_tcp: rq 38 opcode 8=0A=
> [   75.238653] blk_update_request: I/O error, dev nvme0c0n1, sector =0A=
> 1048624 op 0x9:(WRITE_ZEROES) flags 0x2800800 phys_seg 0 prio class 0=0A=
> [   75.380179] XFS (nvme0n1): Mounting V5 Filesystem=0A=
> [   75.387457] XFS (nvme0n1): Ending clean mount=0A=
> [   75.388555] xfs filesystem being mounted at /mnt/blktests supports =0A=
> timestamps until 2038 (0x7fffffff)=0A=
> [   91.035659] XFS (nvme0n1): Unmounting Filesystem=0A=
> [   91.043334] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"=0A=
=0A=
But write-zeores is also data less command and should not fail.=0A=
