Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07502C43217
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 01:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbiKRBvG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Nov 2022 20:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiKRBum (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2022 20:50:42 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E381ADB4
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2022 17:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668736240; x=1700272240;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tUsYQxa5dGUsgJPHVNzhYbldS3qgV9RifEbWEvpbNdM=;
  b=G2eTHUhriO+KY2Kpouo7JDWGFofIisrnpQ7GRXcNmpLzPR5N2rfi7Abq
   knDJiNrlbjct9rrDZ8w14/yoshh8/HtEXdlrKJLvVlRHzmkb+XLczPcWh
   CnLvTKZED6nRuKeKpU0S5LAe7e5cXL0QHHYy7L7GD686VSKsrEk+jVvPv
   n1nAAg/DSCafoNjap+A5MIw1U6fMNK3+g4B9TBf6Tyjzkff90sjjW8ems
   rh/Zgy4V+Cuf1L2UuP3eZ6d+i7ojBpMYOljQavifVnh1faRtjDO+92e80
   A6wli8SBl34tjJ48mgBt5W3mK77DnVkEOKalyG6VlWqR7aGl0aaxmjloE
   A==;
X-IronPort-AV: E=Sophos;i="5.96,172,1665417600"; 
   d="scan'208";a="216574027"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2022 09:50:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fu5/3HrkHaYNGDEOyHIeDuQ6zMF+DigH28O2OhjSIM6z/vk19YVP6O5QyhM7+3qQ/UgZxCLNA5MU9+MKocPuGSPxY2MAoYmSf3nPeotWZTJo28/TW2bXs/sDkGsxm15K4RssuoKPavAJ5VwuvHuDx8th0COLH6HdUUWshqLo5Lfk85BeNsZljMWBBNBBDSnXgraQgKEj9b0XcXbkCQ6avXOc/bZxEmgx3+JRj8lA5McZ79D2Exs2Bys38urMNHOcpBaOH1B5GycpKGS8QOlzQKd/nod2vnt4oegCm41RnSjhZLv9UOOgvS4TP2KSiAZ6LIZ1LHGZq/Yz1TT5VcykVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUsYQxa5dGUsgJPHVNzhYbldS3qgV9RifEbWEvpbNdM=;
 b=n6cFMFCY5V2mChDyl4vRSbGEVvLPBnVSQ6V62tcN0KiYvgWqbEls9C4YzsSSseO6m8pL5wyqr2D8j7hITUY5sHKnq/iw6/KDPfFvNe5UPxEY67ljbeksHtBVG2N7EaU+2eCvjwXfUjNQlM00dVTSeZ0ivMc5jtqRwiDE9C6Fe2x5xE1OpCqjKIHRKDs7yrgE6/0QnOryIss1sWAPOPRQEEr80k7adFDcOpesd/166sj+qXwld/DVQP5MJ3X3fM0VNeftHhpXuk83/E0UXGUr1TP1Zd3vXSLO0eHLu20AE19iQ1b6bzJVGIairHQo9yMXRTomLjM3AxfdJfBhgKqX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUsYQxa5dGUsgJPHVNzhYbldS3qgV9RifEbWEvpbNdM=;
 b=vQ+WkIxvXg43lqGsRKDi1bZhDBl+eRIe7t/YEEi6i0Dy29VnWA6V/zlrx4O096ZTSZIovNJ4V1bs34Ex0TflhXtXK35WTb7/U1JSnO8xl/Z3tHKe3RKpM7s+XWfIcMPvvO726S62CwJmT2cVIKZO8mWLhk5Dtt6csF8hfdUyVx8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB8344.namprd04.prod.outlook.com (2603:10b6:a03:3db::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Fri, 18 Nov 2022 01:50:36 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%6]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 01:50:36 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Alan Adamson <alan.adamson@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] tests/nvme/039: Remove passthrough command tests
Thread-Topic: [PATCH v2] tests/nvme/039: Remove passthrough command tests
Thread-Index: AQHY+gxjZPpHQBBRv02g9jdU1ch8MK5D7DIA
Date:   Fri, 18 Nov 2022 01:50:36 +0000
Message-ID: <20221118015034.i6ystd6uyxxyti6o@shindev>
References: <20221116223945.1043785-1-alan.adamson@oracle.com>
In-Reply-To: <20221116223945.1043785-1-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB8344:EE_
x-ms-office365-filtering-correlation-id: 39839f1b-3b29-441e-ee65-08dac90749c3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 09Cl2IWW7ivPLagfksoMQaOghdc4crrNkMAhLDfxlveIM6uKFobNBWZW0GD7vQCNv4dRthKuQP06emDRkHOgzrrFlWE8QVneEQFKbkBNXYl1lFS/cfMr2oGD9xpQmnA1Kz1G7xSQLs9XfGXTqzIDayZa5zzztEaAwnYLIg8nvEfZmZQxOmtIrm/CqnfA2L6RbIhAs6XK//wOtAle8dRmiMKMC2ZAmEOzp8G76xSrH6CdG1gRyXbicLYtZEcwj8E7wbOdMBkibzSc7sUmvB1Mmvi2r3ovdtGlePgOthbqtErEOqAP+Bdpr8DvuQFW7bF23GB/PlQ5getVOWMVa4sCEcwG+v9xEcyCzhuISoJpDXHIY6e4+1Aur7m+gvI+Ce6ertRulghOFq2tJg88NyUsJbo55tyjXJ8ZEcoxTLfnWg523F0DC1uhh5vdf+Y95Uj2dzQ52PXTC+bKLdUofV+1SpZ4QI29NexeaFuj/kxPqgM3otzGPWNhmeMuHELAr4/UqpFeJxXS1ul84eoVzei+yf6ZzrNfuTb26oblfpoaipKPa0xSmDrGpf5mkR9XjeXTTb2gI1+Wl80tnOGe8uSFAoCRieDX9Nb8FstqbkYWNF+ytHbXP28HvlP26oEY3DyGRAZVlik5ovfl28I27ws/3vu50WoDhlDNtrywyMqJcm9TR44Tayj/hBCbsNQx8yeUwWQksd7P5ixb/LeS9mxadA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(38070700005)(1076003)(54906003)(83380400001)(8936002)(38100700002)(122000001)(82960400001)(44832011)(4744005)(5660300002)(6486002)(71200400001)(33716001)(66556008)(6506007)(66446008)(64756008)(41300700001)(26005)(9686003)(66946007)(2906002)(4326008)(8676002)(66476007)(76116006)(6512007)(6916009)(91956017)(186003)(478600001)(316002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lz8gNnrYVUL7gJamT5n2b4n4UAdofcX4xZtuNn2OGjNJ2XNhRelEbHrQ7wD4?=
 =?us-ascii?Q?Dx3Yhua6P4tBgKk+Leg7lk9MahCohO5Avdositbd0yeq7X9PL8HCCjB5HYwc?=
 =?us-ascii?Q?/rOWv2Kd1NthnfBrtLVvux8cy0g001MxW0GgdtT1P10bTAeQeFEh9felxRXu?=
 =?us-ascii?Q?SEi1oclTEYj3n39mHTBUtUmoOfBcASw3ijUZukfpEBzfXi2Ch23vL2U3/fFZ?=
 =?us-ascii?Q?CLknPYean0s7Dv1Ix6tzJyi+tfsowc7Rcst6ufwb4WqZW6W4dgrB1lq81JKj?=
 =?us-ascii?Q?R+seXI0QU1d3Vfu5vcEOMVcvowxZiGhS10jHTXLe29PoLBoDYWILFNTiulM9?=
 =?us-ascii?Q?fSpq/FC+8tQq3r3jcvWRhVQjiizANQJv+CogEedT6XGvgaNUdWjTZjLyMW18?=
 =?us-ascii?Q?KaAAqIJTJRt3ZWSyaABPek5pt/3eEMg6+UaG38D7Qvl7Z1i6IoFlgar722zk?=
 =?us-ascii?Q?a/z4cc8Eb9ExF+IpzPmPJcGa3NQSJ6g63rz7g9SRqtKhnSwsszt90fN4+6RB?=
 =?us-ascii?Q?7i8a3Q9ZkeKriULdOnpUO3itJv7IOE3lCIAFe9u7Rzw69X0uOIjKrO2v74XK?=
 =?us-ascii?Q?/629DJ6G1x56rfKn5rkSi8TLxKcUHf+gdgKPyRh4BLvEi+YvxsxN7sBBQifu?=
 =?us-ascii?Q?ysh1Okj6YPxpYG/+eQbB0nW0bEXdbmSel2oIagtp97jgd0rw4oxdKoeOGOFZ?=
 =?us-ascii?Q?IN0JptnpZqVfVceTsW0Z2MCdlWJsJx0zGzGUVG1FFkAVC/OG6Kcw9AMyPROO?=
 =?us-ascii?Q?6hyKhHTjUrkcHYdUVC8p679rrkUWF13mRTMCgnQ4XtSRtCozm6ap2O39wFGr?=
 =?us-ascii?Q?Yhrw4IxX6WlLmpPzHQFM19QNlFRlmyDjyopHqO8U1moOfTWR5VH8ChyNqCtJ?=
 =?us-ascii?Q?cLJBLBLpumtvZpj1g5IVYqDcprzGgB2bcj3mheMhKjJAY9CFSlgLnhYhq0aC?=
 =?us-ascii?Q?ICDI6fwJzV8zOKF7LLVmUhqz5UPmDTj00CRfJSL4Ooy2AE4XSyZuG9GVouax?=
 =?us-ascii?Q?pQ7bVm1/5Jric5hVkoMAxV/hDi9L1IW/5/SUnGxMg/OA7X1w3h45BVmuMmLq?=
 =?us-ascii?Q?3B9R1YDpH4G0+TAoOkQ+1MSkguRRp5yz1VVbwQ3Ny1HhehLq8yqBiE/nCoUF?=
 =?us-ascii?Q?hsK91vCV88irUd84QB3kzNh3WkhMa3vEn2p6IZztBkKSFbwilzdfFMNEuDdt?=
 =?us-ascii?Q?Ntv35JW2Uyo60kWM77D5XUaRIFHedOOCOjAqOOPUMnbGLYeD7x7Onj1Np4wK?=
 =?us-ascii?Q?3PwzIHTUt1Wu8qn/cg4lhXV2mvB48zYxfZ4BuBmr5L2UnTcfxCwqX0kdDP73?=
 =?us-ascii?Q?QCBA1RbTVlSMmc6nZ2DX3aETz35Ec+GSQPOM0Q7CiS/3EJiXY85C37CoLP3S?=
 =?us-ascii?Q?H3+V8HgPtCr0SYgg4u3uQDUKGy5usgAFwAcJyHF1+Zs5qcZnvncbC2ftRZMw?=
 =?us-ascii?Q?2ydbiuKNJ3JUs2lO2AnepuuqcrnHLVLGcwHVvbfbFeD9bWx6gw6iR7YWniQ1?=
 =?us-ascii?Q?hOrhIrr+82xwn7HCxN15ixM214H33RBuLoR1rIhaytQ7w0UnEC6Cm4LlWYlM?=
 =?us-ascii?Q?AZadbEWE5ZunHAoDyE00Od1bv4RyBlyIq+RACDgJ8+jcY4uxWhCDhmk3tMFq?=
 =?us-ascii?Q?2J97opQErcJ7tRkPOglakvQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16F512FBA8C09D4BB0E2A4CD74FC4296@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: inARqPfyEQ0Zgmiv5gxHx7PDHwTMO3KnFqP3i3tRlEiweCRzKLKcd7LdCEw64W9zZi6uTp3M9pHRx1mAM/ZKsBOl9+4QI1YnklhVVnopAuUzxFNgyZbHiSJ7lziSyDjQhmmOkPH5p9bRWZ5iFXTihmhis+CI9u/8N20shngeqTonqybsAZcecsWM0v2iH/P4n/Ai6BlqkG03ui058Q+WidiNwBEKt6hfeLXj90Ss7C90Suq/4YY8iA5Kk8+b3pIKThl1Leym/xzsrHk2FZx0DUn6+wJeNd1/u7K1ETgZdQtUofwPm/QVWrjLOmRiuU1xoOXpHHvQoY9E3igd+7AAcmDMEvYMR0Wwl+eE+iXqiqvtSVqeVbT9jPmbHCA4cc0uEBlXN0nW8EAwroGA7DU0GzAJ/M+GZiNkcOHqGOnt4uqESvvtKIykYgwGJfyp3QO0PkQGm+TT/97cNTnnm+lL1VqQu6JwUf4DJzNysOq5r/HH6OFZqoRCsOL40hkGBSCYUYeHpSDt0v3Ri3kN3f2NR+2/5ABj47TvCEYypQE0/6mQICN5Te1lMwgx7COgXwgqMciYLvI/Gup4M9qzAFP5di6aJEgtEF26dZpniSc2j+dmyHxzYN7p5KqpiJpLJVRmuTrwcXrTUI4fOvGfMTBtMMsHM+tt8YKMsDjFJxpkIVW7yggZ5LJUN3t+w5qcZQPmR97uUtai74LkDuhb1fHxYPzr558mPrPIBHvqwhM657x+MxjbT0rSzP23eoXwCVbYAo6j7v+SVf7yxVVPBh+S6Z6sb/L5eqSrjtDc9Yn0DG7KxhTzw8fQYRochVngLsr3y8iqEkKy1Z/8W0lSaXJSrT+iuGhsHJPh503L9YeBJSs=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39839f1b-3b29-441e-ee65-08dac90749c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 01:50:36.5565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PAn+zxiG9dRoyiBlGzwFDGu3a5rVbvIIT7ZcyH13FV388w3kjeLaWhNw5ck+IAxqdQ+iRkJg53/jOj6FuZ+QASDV4Pd5f6pkJVwUnynGW1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8344
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Nov 16, 2022 / 14:39, Alan Adamson wrote:
> Commit d7ac8dca938c ("nvme: quiet user passthrough command errors")
> disabled error logging for passthrough commands so the associated
> tests should be removed.
>=20
> When an error logging opt-in mechanism for passthrough commands is
> provided, the tests can be added back.
>=20
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>

Thanks, applied. I confirmed it does not fail with kernel v6.0. Good :)

--=20
Shin'ichiro Kawasaki=
