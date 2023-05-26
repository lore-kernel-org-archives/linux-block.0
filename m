Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD900C7EE23
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 04:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjEZEkO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 00:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjEZEkN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 00:40:13 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3DB122
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 21:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685076013; x=1716612013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cVUSPC3WGd/10kzh1w5KD6FybRWEj1SGZNuEgTSIxCA=;
  b=ngEbyvBjH9aiH2zdAVLWP1JDsrfZDpkUB1Ok8AAWAvvDFEFS4cRXHa3s
   8GUEZuqQ4r1lOo9Cm3EiwNYiHOtlFyUiwYs+WwSmgSZyukmr8kPUuKv3q
   xMkk8C8Ao2ZVyFtb4uRHVUE0OZNPgAq587fgmsoHZiJnNqgpFCqSNsbtd
   1/jzORWPUayIiO8NknN/XnP8gPh8kTxeGYMZy+WudecVlAJiTEkoaVEsv
   OQ7pLzBLIKx3yong/qY1Hxol2U+3qZlDBS85S2lRdwUUb0jhb0WhaZKq2
   9NMwCnrVTlJBVLeV982flXr4qst7qO31Lg/Jnaf/A5+thgvkaua+Z+1mS
   w==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681142400"; 
   d="scan'208";a="231615551"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 12:40:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LC76mcDnW8gxHeHrptHJk0760sqWPWFiy6p65UdQ+LaV2fAiJWashYQckDBF5sbbF5dxTP7h7bkZGyk5tV1INlg7SWddovBgICc9SKp0VLg3vMkn3vgv0AIInd1RSHxEwITw7Z6UfY/orlJvxt22enzOAI9KTqyc9eSnYRtpoDpEhRKq2iSsqjzNWizfCvB5p1yrH0Dea2euFis9zOH+St0I5qj+uTTVVDqPTRDT6Y6dTM1e0YfYpK44LLqZlqgyJl82NaP1H6YdXUQ0eZZ4v90bDb3RpqiIo/JbQdORTtit02RjaeZmsmfCfNYV4jyV4LO3DXzARCKs1exvqa7+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVUSPC3WGd/10kzh1w5KD6FybRWEj1SGZNuEgTSIxCA=;
 b=bK0rlxiWrjO1xWGrvsvTOxTnILAs9BiG7FhKMGZwrp+Hf0yQYmoEE/Dg7+A2cFen1bpF+iMbSRuQxO16AcSQlbSKncBRVeurcdU6SGsrQRrsawacmkdZNxVSc59lufFpW8oGI28vu+hOU6wFvm2rcWbAWB1DEapr2ycmjvgAsIJFmdnzVANQUkVmAbAY56WNUs1/J92LXAO6Yvr6n9akYP8l6RBK6PrIJS94khzUNSSzTEFysunKqC+0jiXo8kkEETdQprWjrAlO3lS5u0HrCV1Fp4rdbfPKMth0zpJuUwY3UVo4+fPOxAzw7E4N0qEacOtM2Lx53q+1qzCbUM2gLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVUSPC3WGd/10kzh1w5KD6FybRWEj1SGZNuEgTSIxCA=;
 b=r14nB6RewdBacX+vTJtOU9Fampu34ftf/s/rxiaGFZaYVkkgdNVZe711RqE+paPDdmsBr3m6ucPRM/nmLT/+X2eXkvff4Ph9jBopfGRLrqNRk/qOwRpLlvPAkXaa9ljKUgVPRZkoWvcPRFi8VL2EJc7dj1yfy373k1Wa5WCdA4c=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6720.namprd04.prod.outlook.com (2603:10b6:208:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Fri, 26 May
 2023 04:40:09 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%7]) with mapi id 15.20.6433.015; Fri, 26 May 2023
 04:40:09 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
CC:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V3 blktests 0/2] blktests: Add ublk testcases
Thread-Topic: [PATCH V3 blktests 0/2] blktests: Add ublk testcases
Thread-Index: AQHZjh2XsVMWQT1PLUqbo8oo8wFEwK9r/BAA
Date:   Fri, 26 May 2023 04:40:09 +0000
Message-ID: <gh5nkfk5zyt35d6u2numuixq5itlc6zsjiirirajp2ade63yvb@vz7gciz23hcc>
References: <20230524085541.20482-1-ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230524085541.20482-1-ZiyangZhang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6720:EE_
x-ms-office365-filtering-correlation-id: 597577de-a2e8-4b76-80e3-08db5da34955
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDE/ItgkqAAR16WwC6dAu+9G2PkHAC58SNjkSm2URtEQ/dXJGRpyIea8JvbkuymDfocSg/IMhV3ZGmxZq6nZAccr+KzmSt6D86i6I7mImcvnaEUbjmXGBEJV/rdrN/NJUsnvm4RmZPRlc5gWD4RZljo98tbnHRWuT4z5TnN1sXgcHDZnYkYr0hdNcmi32Fuyu4X41GeDBRS0toK4b1SQBXWiW5IE/dkRJtDhXzJj+TxEFfplD+5LnK7VjMh0zxSH0Su+0nEY5GOtZr5gALVPpR5z9mBrZOafiE2Gcgs8tE537cGvFmteBWuFcQIg8QdKROEqbs/kgr+QC8ZwcfLWH5QbLN32gk0bs47x2tFl+E0oDtlsisW7ivme6IPAVPoBZjzeunWiCKlq7T2mBxDKsx2rFI1GqH2E0x5vzFa4pMySyArWrhdKJc5ST3tamxmWk+4qNMmGoZy4dlZBRu0GFTYj/wRN3KYqi2cUz8NXoaVDiuPY0RO0kW7HyGZoFcvg4H6I1OBW2G1eubgF0Lx8RTtryticd2gaBn1HJ9MSrMbdjczNSE3xUFyN/m8eVkJ9SC3/QBaf7LKpfoz0DGH1CdPz1JCFdgkiIi5NWvS1TypvR838XKDJKPgN2RrmTaLe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(9686003)(8676002)(8936002)(6512007)(83380400001)(38100700002)(82960400001)(33716001)(86362001)(38070700005)(122000001)(6506007)(4744005)(2906002)(41300700001)(76116006)(64756008)(66946007)(66556008)(66476007)(66446008)(91956017)(71200400001)(6916009)(5660300002)(54906003)(6486002)(316002)(4326008)(186003)(26005)(478600001)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LRGXBuJp18PedSqkoPMXbYDneOsI5WkaPPVRjAHmUBa7FxWDmhUfFjOxvNrV?=
 =?us-ascii?Q?Cz+nyspSuCixdHA63/TxOzOEd2I3ISMDazUwpJQiImFunzbucigtTnwFUvp4?=
 =?us-ascii?Q?lIpKoZD8LMd2441lMgr8P+aZsEzu4roMvDarV2PlSu7keZjUlrX+4V1Sz5UV?=
 =?us-ascii?Q?zn91u2KeEqErjchSwqkiRHAc0isPwOZluPTiemeqhU0N6Tm4YD031eZpTy8a?=
 =?us-ascii?Q?y1SN+SekARSJYkr2sEa9J/35TLS1xxa7phzgn1Ft2KhkQEf10tKIMPPyIlY9?=
 =?us-ascii?Q?fM0bZc0ZQt4TGDSqUOnDSooj1XwdfSl2WrJ7LAvgiGtTgm1vrMyVsDISbBLN?=
 =?us-ascii?Q?JG6fS99hYXTyCaFkMe8RQsp8UcQ48f3lQnYQgLN3eVc1R7O+jy/VrPp7qmUg?=
 =?us-ascii?Q?gMwDvKZOaPGrXuH34XdaQgOXcZigVOaNIgaeSSrnmTWhTXBAnJXp96D2mQIO?=
 =?us-ascii?Q?FOkF2Ex+O5jEL6QHEzAcDREWWbJb9IsvYHELT6Z6qlofSCwhLAz2WUyXHVeZ?=
 =?us-ascii?Q?nkbYyuWMsz/Uu6YAW8gJN0VdfNtZf8mc9a3U7fs3ScsfZaHImR3yqtqDxC6n?=
 =?us-ascii?Q?Ep+PQX9jGtDoGoLPdngl1Gr8NMZw+e7uTWOYDCGHuyMJ00oUbzSDcY1O7Gp+?=
 =?us-ascii?Q?uV/u0uOCBk6OazSIItmjWFFb9s1AdAwujPc9ywVhpYEEySl7ppRvQ5TAGS85?=
 =?us-ascii?Q?VkUE4WYuel28eAwuCu/2TGeNSYxDvVTKsp4uzJseesSHeAeYw5UOyWa1kT0e?=
 =?us-ascii?Q?b6L4kMeh3vG4IkBM3PYi1457ZAsSPrOnvKjDeVmgFYTBczsXMc5adlbcbYrw?=
 =?us-ascii?Q?qq/DCN4VoZXfwY6c+6fF6EgD3iOQtovFnNVtYBMSQcixTR9KXRczdeEkq/2V?=
 =?us-ascii?Q?n+DFISjqdnbbh3XJn80IOawkSYlby8UGl4yEsacwDiC7IRh19lM9BoCQC52E?=
 =?us-ascii?Q?qIIuGoKZ73RlwgqC7wZ9lUhqzATvaajycZL7xaV0/xzEifEraJZb1Qwh/sDS?=
 =?us-ascii?Q?SHqW4BPEpXcqVzbFlI0v0R9GOAXKfz3nEcs91cwPz6nj0JImZv/3GwRTEnc/?=
 =?us-ascii?Q?pjTFTZ8M81WhEm9rJ5xbt0rNxeXXCm18iW4HSRa3BZXXc5QlmzZh6U9s3fS8?=
 =?us-ascii?Q?AKePCp7Siz/zPjBumDLhZzaFCLok7zZbyHgAQZqUTuHNmyJpKRhrtvS8GGQg?=
 =?us-ascii?Q?sKH8M4jFo5b1e6rMXtsa9P3APv/Qv0iN2c4vWaMroP2+a3POXfQdebFvdHVS?=
 =?us-ascii?Q?Ebvh+EQP4wDZCPrwODgV1KJ4DVTF1knitYDsc9i378cxSSvhu5Q+EP1O5gN0?=
 =?us-ascii?Q?AUP6ZceqD4JciXs31xMecZlwtnoYL6GvRI3K5flCHn5AxvP1Rc1UsNwo73ss?=
 =?us-ascii?Q?Bs1TQzJM5IlkU0o2dYsqS9/rp0KxnYz07V2qzHZGwkFU8SMB0lD3PvW3bUai?=
 =?us-ascii?Q?sW3fdI1kSbKOJPKqMmtnLPGOl04kqJEM7Ei4TEL7iwEjO/EmF6x/MMra21y+?=
 =?us-ascii?Q?07OW4U0n9gG0QmUV+MiEZXerNhRsjur3XgRqg4ZqvkRQIhTBYs5IBZXPoopE?=
 =?us-ascii?Q?iNMdTlcws7tr9r8YDSswXvBT0DX09B1FbSdlQovAwhAO8XDztPooF8hRF3q1?=
 =?us-ascii?Q?drwlAsb5ejdTPk9WYQRvsYk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4154E978FB1BA14486958F6D6E4194AE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5FrEcSSjnboyjwTHXT6AHAmM0HID3ZZiO9Hh7ud//9Dp47ZH4v4I89bb9Y15PW572HUtPOpiqx44mN2VHNHWt/cfJ95HpF7L11JJT60b5Ujfy4V47awHINI6elWHRl/r71fGbhSLMAa5EV8gT6oUkfQSQvQOIymLZ3YZZ3KAM6WoxKZbMpN7w+JG0dVQoA8H/cBIsrV6rM3x9HpbuVATBPe0JKOD3z+dfveUd/5seMvTuGZqvt9GONoodWw/4F0l27gOsy6IPfRgXrQ6uNF6Fty+SLjaBMQgEGOlA0t9S7TicWG/Qb/eDhPX8lBdc0JhrwYk5ROAiDITk6g13vkdELQuj1vGfjvAWpfcmq2C9yV0nXdqDEV8mvFIdBVpgVscu2pn196sawWLdsOBqRNlJX5zoh/VWj7yxU1Bmdh896/+2pgCvB3dyqSUDdjdnZOUqs/2qudCzMjwfO30Xu7BTGP1BbrI0qHbVYYTvthE06st/G6XwLBYVcj/ER2j7nrXP6UN2FkiGu+KB/SaDMpPyZoMe0Vad3VjZfIeuCzuDKK+0zCInyeuTqfHdBD6w5ViG6CnpmW37SOdWKDqklDe0u0eHNjJ6iiA4u/kuWn2XL3xThG6sgrtIaWCHASdBxbsCRY9uOzOg32cr0em1yCJ0B11uxQGtsUGn8y2KfeFAjqBJDBBEQSRQcQ3lGbgyeCsgeBCN5ViSjtYZMo/bbhR2H/YEO2OXk1l5eAgK7joC1CU3A9fNGdL4BJ7/n6pC+gygZJpOzq+XKq/sHOV1dEgMj236lp9V9NaLBFBDtMQyN4pT1sjTsHoFZHnIfYudhNChnbpEjzbe7dJVfLy68ZtTeNzwlSW5vZ+HHrety1RAw4=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597577de-a2e8-4b76-80e3-08db5da34955
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 04:40:09.4231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8nq05+tfUbg2TCZ6sTvB3d+tDcJ3x/6GvvHRb4k8qq6O86zLf1mdpElCUNRD6qE3A9ME8BUHZhx2icc/mWtUK01lO1eIO9G9+kfmvRO2MU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6720
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 24, 2023 / 16:55, Ziyang Zhang wrote:
> Hi,
>=20
> ublk can passthrough I/O requests to userspce daemons. It is very importa=
nt
> to test ublk crash handling since the userspace part is not reliable.
> Especially we should test removing device, killing ublk daemons and user
> recovery feature.
>=20
> The first patch add user recovery support in miniublk.
>=20
> The second patch add five new tests for ublk to cover above cases.

Applied, thanks!=
