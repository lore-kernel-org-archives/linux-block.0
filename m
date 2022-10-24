Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2708DC38A2D
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 10:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJXKb6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 06:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJXKb5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 06:31:57 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDA656B83
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 03:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666607516; x=1698143516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0FVKHB6vRMFv8NpWi4u3xNp6TvONiKK4lBFy4A1O6KY=;
  b=QPlhpeP/YvRymhvuq6zEn1epWKOXUAna72WYN8rgYHYXbwAOiDdJbFPd
   XWS/lgAWOeKAf16syUK2iKMEtuXeNkEbTSKNn+ZPtk/zfOkmAUHuf3G/z
   luHu091yvF4OVMLpdl+E7dRzMF9Irxt9Bl9PO1x2fe1cFmmpWUd/6gc/T
   lHF1FbHokys4RShrshjGjoImTxGr23uiEf/Y5pFF01IywsHOpYlewWU8z
   Hezd5znV+sAKVUi4OATOduR4dQF8NazCgjPdMIUCFfb2a1IZuVi5PbXR+
   b3SK0jGrP1iKZn2j6+MrMb/73Y+aHnfxa6A7Hdo7XC+sIH6zxE996YOxI
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,209,1661788800"; 
   d="scan'208";a="326697606"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2022 18:31:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzNxDnqfCsqgvoHOJg4OSbiZL7Y2qCMA24BJpQdSALEvAFgcQtfn2xEWUk+4d6t2HbXcWGUxfKN6RCH9tOJSRTZI1Snh178Jx+BDAAGfVtIMCie0V6pOP5aIWCbSFKfdfIAmgOBbXAmqFmd9p3bSH9VK/1rDRU94HqSdm8B+Ht8n1dzZzAzW2Y+YweXvEnoCh4kUOPHya4W6OiriZAAWWDyLxzjbmVIH/y7x9aE7VAPI58/VG+VnxUDcI74+xpEwBrx7IRlFFDXG4hhFCH6VtXpVXC+TvEfJk8F0xzfeVwdpP9aHUDNd9FEdBC4Kl6cFn1Jdo4krrd9mhjKkiPNJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsyLy1bf2fOmiOT6YN1NerhOijSd2pgG9HEmDMatwro=;
 b=bAFyUN26wd3Gldxtxu8qmHzUVPji1Sv0Xd0i6T6GWGcPvo23ASbLLqxEUNn6Zs3OEgTtq21yAWX1Ch78Zsq6aQVuVPJkjOZojds0jRXAc3JTys5cieKWiqwZ3EZCefyqL7z76Tl1KIv4aWpt9DwRZKhXTFYj7YoHpsktqpC2UIPGghBcaMFNonBvoCtZDIgaEhiuIfPWKOPL8SUrMFfBTY1+lGR0tiq9yVYVa6cU+OdWUxZYEID6PsbDxxoA+gqW0Q92y62B/j5W10u7ZKLSZOGpqD4e7QMdM8FaQkTQv5+UvtAT3X/eY0iDl+huDP3WJ7wJbNkycMvSfMhNtga2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsyLy1bf2fOmiOT6YN1NerhOijSd2pgG9HEmDMatwro=;
 b=JhOiYzC2kJnQBoP9yOyidxwL53U047D0QERncq07UyFjDD/qZux0dniZgiEG1kbI1DTYsNBtPKCjAzTLuFN6Ht/KhcUOU+SElsq0NBf53Bf7PJe5afAF5PGv6zxiDK7G3bObk4yRizTsiBGm2Z5feNu6CQsrjYlcxTagUCB/LYQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN7PR04MB4033.namprd04.prod.outlook.com (2603:10b6:406:bf::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.28; Mon, 24 Oct 2022 10:31:53 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 10:31:52 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Topic: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Index: AQHY43l6J1B4S//4t0qObxFCSR9tRq4VPZSAgACG/YCAAFOEAIACd3OAgADVjYCAACWRAIAClmaAgACdFwCAAF+TAIAAQv6A
Date:   Mon, 24 Oct 2022 10:31:52 +0000
Message-ID: <20221024103151.qmfxbyysivk6uy55@shindev>
References: <20221019051244.810755-1-yi.zhang@redhat.com>
 <122cec5e-5374-e98f-a8e7-b063d9c413fc@nvidia.com>
 <306b38d1-3098-91e0-9ddc-f4a8660fa386@sandeen.net>
 <d3688d8d-bcf7-9cbf-7c99-74cb1a05a9dc@nvidia.com>
 <20221021085809.zkzw23ewnv6ul3b4@shindev>
 <0f2957e1-2b05-73ec-85b1-91cb643ccb54@nvidia.com>
 <20221021235656.fxl7k4x3zjbbaiul@shindev>
 <CAHj4cs-Vx0+QBF5cSNh4iHEhPao8iJ2gtfE_W7XHKwUh6eFNPg@mail.gmail.com>
 <20221024005000.givqygw4jyjzjp7q@shindev>
 <CAHj4cs92c_3t+Ov780F5wsO_B=Mq=0T31Xhv=FWaAy=KqmXpDA@mail.gmail.com>
In-Reply-To: <CAHj4cs92c_3t+Ov780F5wsO_B=Mq=0T31Xhv=FWaAy=KqmXpDA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN7PR04MB4033:EE_
x-ms-office365-filtering-correlation-id: ea6e08fa-ff03-4ecb-db12-08dab5aaf796
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N72U36mGqv+VGV9Qhriy7KrL+qgb4E7fuIX98En503kjbtmeA6tyx/UJxb2q7M6FP9KgnXd9e0PA5Bi+zA7JmFhCL/N0nnSNUYBVv1zhNJyIG1gu5m52q4w/7+8YR+mddjWv6DfTqfU83FjBHa+bACeeVksekpA6UFGPx3VxQX+/+xx4+f7DEIOJtPIFGRLc4ulnG2jp7R+cNLdGkM2frrfehNyESrxKP0HEC2JNbOOioWOahRL2XnX6wMMUYwUZ4U6fR2xFPBKp8WhplIeOL7LmgR2+qr1XFcfeyzREkDwfEwTYUi1+hOV9I7uTuf2p7YC4vmX9LjOBIQlZmVNB/LJSTVQkX9TOxPMLX3CqJgS/eMCWGiRmIE8nr+otqmQ0kWX3bcOqTfkeB3UDlmLo+IEMuFae1VyZ7/wpFIT0AVvIAVkP7R2rqa/Bo/e3x3gBCEydgXYfDEsi13OdcjLXsqVgtru1ywdkfOCnnSZqcMz8IRx/LFw8bZBG4dAl5TR136kql8D+dWo+aTUKAxO88Y8yESXHO++ucZ6pEKON/9o2j9bi8HxKHd4+7cU4S3P9zL9ZssDtfgQwcW0ORgk/U5Xpp0e40is0hxNOFyIX/vzBq8z7jltbRUjcPdHMDkRWVsaSZMhixaPYr53V4Eedlb+EhfkNtKuq2OKgbf+8LjRFeSCFQw4f+UweMSTakRrC59lnf0RpVQSzh7UneWUAzNVnVsZ6Bl2pafF7r3XwSpDXXSC07NEaskJhcEhhiM7i9a31v1AL9vLoibZxZztWqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(33716001)(4326008)(64756008)(66446008)(66476007)(66556008)(8936002)(41300700001)(53546011)(83380400001)(6506007)(82960400001)(38100700002)(316002)(91956017)(76116006)(8676002)(44832011)(2906002)(6916009)(5660300002)(66946007)(54906003)(122000001)(38070700005)(71200400001)(66899015)(86362001)(6486002)(26005)(6512007)(9686003)(186003)(1076003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8H7aZ3GM0KgO1QN61f8W4SNSzwTFv7gUvikRgS/mOzpssQvCbRgi2WD6xZPB?=
 =?us-ascii?Q?rHMd1XSvALUp7NiFyRX7andMYG4oHHh2ZnAnjq+yLR2Gt7nMyQhzWe0S2H0U?=
 =?us-ascii?Q?eWNx+91uf4yYBJcBUk9k6QpL1xxZaAl9HDIllUf4f9dKrGgLVvsjc9zCWtRi?=
 =?us-ascii?Q?Gw6KKSVrqK4jZTKuD/y2Ui5CpkdvhZ6mKQI9LMi4O7Bzi7u4V5stKV/ep/KF?=
 =?us-ascii?Q?7L8Lp+jBV8hP4J0maEQS2hgJ9ujycuU07b9rhogRIOj2/oL47FAJy2LKqqrj?=
 =?us-ascii?Q?sKbqvRzbFXvTR5Ihdvh8+2Aep/ofO/tDc7goPCUGhHatWfdPi/GDlyJArtU6?=
 =?us-ascii?Q?ZLzoUHHVs6UTxIwB0O1ZAFH/u1hmyJoYNL9RA//maQ6OlcI6NHaaRHPJZ9kK?=
 =?us-ascii?Q?SvMdaJ0pFaR2a+rF55S70Rud2tZDpYd+6iCATKsrtGssdLgFD9XEazclBTtR?=
 =?us-ascii?Q?7Cnmr7JOGyd3zaJO/bthUA4ArgSnuOWZk7jv0VpZHwcFlpE02ce7qVDXqeg3?=
 =?us-ascii?Q?XIYlwrIsaW2rVBSd0A/MGeGMMvNDKeBTjrIrE4kj4Ja28E0rE7A6jyQxa2jc?=
 =?us-ascii?Q?78k0YaofMbdARmnUkwXhcHx5h62q8Dipop1Bpk/0jd2x3EVp/VuawWrPlTWS?=
 =?us-ascii?Q?4sJQ9EGYe/moSnCzG60lA3KlUFAQAJCr3qTPbegA2goybLt+bAbYu/mQvUwM?=
 =?us-ascii?Q?qu9MT1Vgd7G8xQ2g2RrHgRrEVQgPtQ3to4uH7oS8hog8/2a/zI2fRlfm14o0?=
 =?us-ascii?Q?LQeJwdPKUKZUKMUTlDBHhPfYdN/ikeoiQj3SeOZC6ui6Tsb7TXxD1RNhXMgt?=
 =?us-ascii?Q?JhY6aU5aoBTLIpl3YBLksepnfd2U5DWsC186fCzyWgZN8IxZv6C+MffLN9D7?=
 =?us-ascii?Q?qx7YWOlDdei2VZfQDBNdpVQc0WQGIoxwwUCwqp7grzchPQQw0MbzVvGuiIIo?=
 =?us-ascii?Q?5AAwDQSCe42PGGOr0+4e+5D7FJfNh6Nor5VH1l4RFzCFNm7TAHh5wDT0zVzo?=
 =?us-ascii?Q?MSBlGvrhDWj7r8TNBRFFR34oDplR9mYcV4G7mRd/gr9MB0u2XXhQyfNSo4jN?=
 =?us-ascii?Q?vNFI5LJEKoVQWxpj47c6Wn2sTmIt/fxEzdkMOiuOGvGzTv2/ivo08u+eyqFT?=
 =?us-ascii?Q?XwK9FZSxiXzO5E47HT026WGhzCxc0HY1iA49EVKc6yJENvGjhqHLaVCw30DJ?=
 =?us-ascii?Q?RQQ9KAS2S0H1VSEBBehuE2ZfSosMrZeDZLJVUGe75h6jba0Vx0xhZWES7l/D?=
 =?us-ascii?Q?fkk66iCBRwKrkRH+THfhlAjThCmDzhvqJQYaqSX4X8VJiviCYJ/302rqvpf8?=
 =?us-ascii?Q?hUo55zfdHyWV/Dp1sKmN3ulsNsvLP8GYtFGVng37doyNOm62ZzthVJBMKP2j?=
 =?us-ascii?Q?RNXW2JKs2T6D1qULmJrL74oqVeoccaLCuu4AWZeCyE5Zp6oZxG+jXERYRyuk?=
 =?us-ascii?Q?ftIi7fQLBnH1rRlCP+FYYYeI21o7+bl6zUzN1o5jYOIZsOOWc8/ZSknYNUEn?=
 =?us-ascii?Q?rDev4TWBoT+aaQ3o5qDxaWe6UPa+X6Z0hd7Sfqr8St7HO6dPP0VsUPpHfcVY?=
 =?us-ascii?Q?cPI7K/XXGhmLuSBzJ0KDAlHpgG4j50sXfM22K00pB6whoOMQoouA4kX9vYhe?=
 =?us-ascii?Q?8blE5nsPVNzweYiSDKsxdxQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <275A259CE2EE974A80A008E42CCB535A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6e08fa-ff03-4ecb-db12-08dab5aaf796
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 10:31:52.8804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJtUJupD3zXj/mDEc2EaqSFfawZfpNpA/1aPvoIlv76ZYgMFNgm/xKPx6UIFjs0SefMpdj8p72AS0BcbE0xdy9WCpJWvuH+ij8+jYdxzvlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4033
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 24, 2022 / 14:32, Yi Zhang wrote:
> On Mon, Oct 24, 2022 at 8:50 AM Shinichiro Kawasaki
> <shinichiro.kawasaki@wdc.com> wrote:

...

> > From Yi's observation, I found a couple of improvement opportunities wh=
ich are
> > beyond scope of this fix. Here I note them as memorandum (patches are w=
elcome :)
>=20
> I resend the patch to set log size to 64M and another two which could
> address below :)

Thanks! I'll wait for comment by Chaitanya then review your patches.

>=20
> >
> > 1) Assuming nvme device size 1GB define in nvme/012 and nvme/013 has re=
lation to
> >    the fio I/O size 950m defined in common/xfs, these values should be =
defined
> >    at single place. Probably we should define both in nvme/012 and nvme=
/013.
> >
> > 2) The fio I/O size 950m is defined in _xfs_run_fio_verify_io() which i=
s called
> >    from nvme/035. Then, it is implicitly assumed that TEST_DEV for nvme=
/035 has
> >    size 1GB (or larger). I found that nvme/035 fails with 512MB nvme de=
vice.
> >    We should fix this by calculating fio I/O size from TEST_DEV size. (=
Or
> >    require 1GB nvme device size for the test case.)
> >
> > --
> > Shin'ichiro Kawasaki
> >
>=20
>=20
> --=20
> Best Regards,
>   Yi Zhang
>=20

--=20
Shin'ichiro Kawasaki=
