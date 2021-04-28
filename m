Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CADC433B4
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 18:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB3776142A
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 18:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbhD1SeH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 14:34:07 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:1344 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243631AbhD1SeH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 14:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619634801; x=1651170801;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wYb38BMEIUszj3ct0nSPiYGlMOUaMAl4wDyNgaNI7hY=;
  b=csYbDs5zOVrfyjphn06jCzQYmjzJkfuCnuh8f9NyV7wC3xevo+chJAq9
   Whgni7HxChvS2+tNn+0+bHANO3eQUYNU2EN4VKUnddmIDl5qCjuceQkDp
   6ZSFh2iHUa8PlloS9nzgH8SqOYrNz6E5TQV8fB0zMvP6lxTXFzE7r3QHe
   /e2P6MZxsI7cNabJbx5sVouosDJs5cOgzaQPadzGbZQ4nLvXzNZJtZcYh
   pVfr2yiX/GILBnvlOjDp8vrvI/IBQ0c2kHqzvm9k7gP+3qWKM0bytJUJh
   fl2G+BR05HjwycQPxIC2lfU5eEioAujnfZjOUOgLJnJrniKKKfioaNIj7
   w==;
IronPort-SDR: hSaAEKAT6OxgNxYN7Q/CmJsIPPdyAk/tgQMKswZmq7GCjlG3aSf6uReKFeA18gcZHP71IyqM0/
 jWmXR2e0AIdBcCJcYFN54lAcx57UBtTovq1tM1SuKTAj6/UG0K2UBvyWi4kVQxv/Ea1Lp7a0wI
 2yFOqRsFiTT/ndEKjr/72swCD8oFDukOHXNC92uvhhPdCnh+vEHLycgTS+Wium84fkSkxE8PXV
 ugoV4XMA395kzYfwAN1KJ8aq+CtncHflLSPyxn8Ov/MOa1FLy+AG4boEKIZwzJ1uXFfSU5R8lj
 wRg=
X-IronPort-AV: E=Sophos;i="5.82,258,1613404800"; 
   d="scan'208";a="166573445"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 02:33:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAfY32cPZCt+A7z7jzoDMjSAAu45DpzdQb6DUvitZCNUUm/XuFCite6ZbjyOtIMKfwoAbcqjWr0BHqQE41wFqBo1/FcYAE460xDM4VA/ylT8RWcJc8URHhlHqXi5B3FcFpHWAvmd6Dl3ozwPWwymXqsEWJrNGM8peRM32/mYgXrZhZiTErwulwX5DBQ2qiYBeTwKBCIKAOvs0rWtZQtKjFH2MYRHMoJWkDuErXS+pNjexjwqhfvU4U75N7keU5eTisEu2VJPCvUBucKwfXbU8D5Nj8tylUcZugSe1+xZUoTSc0xrfOBTi2iZOUkiOUtOuN8OKb6Y+YmAp/OYydfDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYb38BMEIUszj3ct0nSPiYGlMOUaMAl4wDyNgaNI7hY=;
 b=kjDHOuvC9mo4Ac7UYYHr5PKtd0jobT0UALRC7+BknWp9xUGn1q21utIAU2b7cqGYp4Nvs5XBKw5SYomx72gvNdsUDsfu/P8pOoTbMoBnbKqXZZhWOIhS0UUi2gvLZcoyAuqzXJ7OArBfTg/2Z3PvwTgcUbr8VCNZ0hGM6/IDsKkg6QZeSlNti+s+kamOIpo/nEP6ZYHZ3v+AMCQ7PqlnZ6obwhI8smnDHFln0QhEGc7A3EYQPrbS3m6mLKharBPXZbUIrHF/H28okdv4TpkewadHGtVqHEEBkMJLerlmjVs2rS+xnPe71YLzLUHaf3PS3Fs6u6GXaMBvh/fsvuW9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYb38BMEIUszj3ct0nSPiYGlMOUaMAl4wDyNgaNI7hY=;
 b=Xl/pekfozZSnlWzaS4+MvSpkbJ+LIFNBRsNhwHw0zAXptRxKZq3+Hq8TxVAINnKOWS7P38R0RrLDMklu4Rzwd3AfNwiOxSEd3ggN7BaYKx0pEewkFn2ea9sm3U+sKBbdkcGI+FRXHgD4FZcUAEVqsi8hZfK4MNBoln006XI6SZ8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7678.namprd04.prod.outlook.com (2603:10b6:a03:319::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 18:33:19 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Wed, 28 Apr 2021
 18:33:19 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>
Subject: Re: [PATCH for-next 4/4] block/rnbd: Remove all likely and unlikely
Thread-Topic: [PATCH for-next 4/4] block/rnbd: Remove all likely and unlikely
Thread-Index: AQHXO/XM74Bf+s2CDU60LggBbTEF9w==
Date:   Wed, 28 Apr 2021 18:33:19 +0000
Message-ID: <BYAPR04MB496504E1348ABFEE30FFC0C186409@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210428061359.206794-1-gi-oh.kim@ionos.com>
 <20210428061359.206794-5-gi-oh.kim@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 557fb3f7-d9dd-4a0c-8eb7-08d90a7418de
x-ms-traffictypediagnostic: SJ0PR04MB7678:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR04MB767853715D6C0C21EF4B0A6486409@SJ0PR04MB7678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vYY0mGdRq7verNMyRWQNYlN9KI/Uk76ZCl6OBrO02kXtEnDWI6Np4WjNCaR6F2915DsRyz1TZhKXf1VH37iB1K3w4sUeMBdD4IUbZzyodO2PGO2NIFEFUxXidkAwzKaX77UD8v7yoPVVChC1jZGrC16XVugh7hFvIPopmehkb4ze5JoiMlFoAlGEVCmgmft/ICFCxXskH7Gzg1jKoLOkT6+P6Mie9CRq9Udd1mYSginLMoU5NkMNGIn4zKnwLi95dJzcx/jlY9jKzbq9uo/B4CSebLzM2ayDHmElxV5kwejs9zFKC0J+MWqqmAVrf/Hw/J8cZmVfbtM/wwOCbGw2J5OEAzEGMZIEKVmvHlNqF6mS/pUR/brGxs2XJ0kel0E4Oxzoj6XJ93Ts6kMli17LGBwXtx7WLblE5DyYn8ZRH5f1xvYAsjVEu9DjBTw/q6/T0fT6TVFfxHWoXZE7i8B/fUfUBoC7LH7+K9np3iIaJ76uGPgpbfMzshK+c15W5AHlimlXLPMIxi7LjsZsVBV9UEdYReSjR5tBNZj2BuP97yOg6vGnLGu4091zl8l/SJaRvNsOeMh2W5QbD+g3Szzexw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(6506007)(7696005)(5660300002)(53546011)(38100700002)(86362001)(52536014)(9686003)(64756008)(55016002)(122000001)(66556008)(76116006)(66946007)(66446008)(66476007)(33656002)(26005)(8676002)(83380400001)(478600001)(54906003)(316002)(186003)(8936002)(2906002)(110136005)(71200400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HKV0ZfqBohGgy4vpGbvTaDqerrkmttRRbEJvl3T+tlk8At7DKOpY44T2z16H?=
 =?us-ascii?Q?OFNOtVmQ5GLbQLzaP9GqYlOKxWcYbNdOHJeHfWavY3G6IxmMtDeEM9YBJYya?=
 =?us-ascii?Q?jUmtGZwBaLVDCpwFbccNnPc85dkxs1ZTZzzK08d+TLsO81jlkUWnSi1XQKN8?=
 =?us-ascii?Q?bwrFwBQLbbKlTFz70X9ldjO8YXjJ1XVOZ8dFTzCp8nqjRnpoxpyGg6qHT3i1?=
 =?us-ascii?Q?gV7PCRh4CJc/KpEpVuIJfZw7KgngNTmqCt+EE9yA/+dmVJO1C3hc2jQ6N52G?=
 =?us-ascii?Q?k1mtrvZ9EXW8cWhsYmroxfcz5iRpQbSsxxrJzGMrL7VfygX1Es4H70tLgRAg?=
 =?us-ascii?Q?HBR3FX53gfeFVmORmzJwxAC04stMcnDmKHz8HJG62OtBiYNrpRtIO/UwwpNn?=
 =?us-ascii?Q?ZLokfviEpZnKpYQAdvPjbXOESW2Uc9rDJql8D/D7DyGqJd3HE+cntkztv10v?=
 =?us-ascii?Q?Abi+bttVxQKz03NRyfnGYMC6Hg3xPjzP3PSiYTgyvYj597U/8Vs6UepEG0Nl?=
 =?us-ascii?Q?4DjkjVx6QZc73LOHqYg7faUfSdfYtD9lNaoaGP1LIg78L7chsXrxszFwt0Ul?=
 =?us-ascii?Q?xeAz3xwtC+aUYARNy7geNVSc5a3chwOiBJZfBB+jK15c/HhwBjmT8As2ZV5k?=
 =?us-ascii?Q?fPh3tuhtSOFRTTIEl592ruO1l9AG+XozNMbYd5BtODs2RvhgfcJER77uKMOB?=
 =?us-ascii?Q?AenWOEU36HRONmMeXjpuY8rT0TvvSuXiUY6FBZzQWnb6yjkImezd43lWs8we?=
 =?us-ascii?Q?jebwFgwDg8aqhyojz48zJM5U6UE9KvGmBJNOdYLPb661/IyeZsKLsbTF6g60?=
 =?us-ascii?Q?7MOev7QwjP8Sal6AA0yYlm/fM2md/D9STm+gxABpvUWZVGK4KT9mTCpeVjui?=
 =?us-ascii?Q?DOkf+EOAtWmajrK/3AM21QQVmUnUS5U0iCBsOO79ufAZKhb6qeTdAksR+/k1?=
 =?us-ascii?Q?7KcIeAU6X0kyeKmmuHLFwaC/fUhM4F3Ab4RFJ9QMkV4mdvmobVTw3XWFr/4e?=
 =?us-ascii?Q?CZ/KsBma7czMabNq9TV6mSjxgrJZpj+sSeMzYjSxHgGKvEhCw90IJfA0rdTe?=
 =?us-ascii?Q?98rftUFxaZXRgbkN0+TvehMKmSG+RQmtHR+QcU2d9EjYuXzSWpCXDqo8WDTw?=
 =?us-ascii?Q?dkdbn5ErUcSf5HxsSgwDzH5r6WkESAUavzhD+w6A8/plHYvzUlsGxwlo1ng6?=
 =?us-ascii?Q?9g7/+jey1Kbz4F2KFcQy8ncNaQeONtwi7DI16Me5FR3bCTJeJLEf7lanCiTT?=
 =?us-ascii?Q?4iBOUfyayDTZRzqQxNZk/19g6Z9qVpzseHt1Ij4sfz8D/NBySZIA4bRISUcS?=
 =?us-ascii?Q?bFiY3QsDN/Og2mCxVrJhYrJx?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557fb3f7-d9dd-4a0c-8eb7-08d90a7418de
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 18:33:19.8209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94J+UKR1HF6t8PeLC7NtHXlhAzSmIcuQGpa5djdm3BnK8oDkgwmi7tyxvuPE4JMh6iyQ7lVpC1bIvbtMIZ2/ftAdJKLoJ+IyDHjhIlqX/lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7678
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/21 23:14, Gioh Kim wrote:=0A=
> The IO performance test with fio after removing the likely and=0A=
> unlikely macros in all if-statement shows no performance drop.=0A=
> They do not help for the performance of rnbd.=0A=
>=0A=
> The fio test did random read on 32 rnbd devices and 64 processes.=0A=
> Test environment:=0A=
> - AMD Opteron(tm) Processor 6386 SE=0A=
> - 125G memory=0A=
> - kernel version: 5.4.86=0A=
=0A=
why 5.4 and not linux-block/for-next ?=0A=
=0A=
> - gcc version: gcc (Debian 8.3.0-6) 8.3.0=0A=
> - Infiniband controller: InfiniBand: Mellanox Technologies MT26428=0A=
> [ConnectX VPI PCIe 2.0 5GT/s - IB QDR / 10GigE] (rev b0)=0A=
>=0A=
> before=0A=
> read: IOPS=3D549k, BW=3D2146MiB/s=0A=
> read: IOPS=3D544k, BW=3D2125MiB/s=0A=
> read: IOPS=3D553k, BW=3D2158MiB/s=0A=
> read: IOPS=3D535k, BW=3D2089MiB/s=0A=
> read: IOPS=3D543k, BW=3D2122MiB/s=0A=
> read: IOPS=3D552k, BW=3D2154MiB/s=0A=
> average: IOPS=3D546k, BW=3D2132MiB/s=0A=
>=0A=
> after=0A=
> read: IOPS=3D556k, BW=3D2172MiB/s=0A=
> read: IOPS=3D561k, BW=3D2191MiB/s=0A=
> read: IOPS=3D552k, BW=3D2156MiB/s=0A=
> read: IOPS=3D551k, BW=3D2154MiB/s=0A=
> read: IOPS=3D562k, BW=3D2194MiB/s=0A=
> -----------=0A=
> average: IOPS=3D556k, BW=3D2173MiB/s=0A=
>=0A=
> The IOPS and bandwidth got better slightly after removing=0A=
> likely/unlikely. (IOPS=3D +1.8% BW=3D +1.9%) But we cannot make sure=0A=
> that removing the likely/unlikely help the performance because it=0A=
> depends on various situations. We only make sure that removing the=0A=
> likely/unlikely does not drop the performance.=0A=
=0A=
Did you get a chance to collect perf numbers to see which functions are=0A=
getting faster ?=0A=
=0A=
=0A=
