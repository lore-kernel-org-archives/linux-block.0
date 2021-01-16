Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CFDC433DB
	for <linux-block@archiver.kernel.org>; Sat, 16 Jan 2021 08:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593A5223C8
	for <linux-block@archiver.kernel.org>; Sat, 16 Jan 2021 08:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbhAPITQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Jan 2021 03:19:16 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29470 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbhAPITP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jan 2021 03:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610785154; x=1642321154;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TbY4RBnkY8zuo4/l3Z0xoxAhGcUDcth9NsIugwifIkA=;
  b=abuL1eQgSGJqv1kCfwm7ieVyolqYAs4jgwdfwaokPbnRNL/n2fudf9fi
   Ct1oTj0xIZAPRWuAO3lRsP6xrVLBn3KJQOwFJG9NSmgXI6qYIs85jCa+5
   fQtZfR7pesHuMhQ95TQyoKFEBKPcqhbGpj376hCtxPFgY1uj71e0p2Wzx
   1WgLwr8GmlGysmb9yewqVg32UDXrfp+YnvHMCeuX91P3sV94hLLIg4/59
   eYpDru+1pxICo2BfZJ/IC8jHE58nC1vv/ZypiUh7AS7bgI7CQoOIZzfVy
   i2hw8pGHQeoHSZUPvzS51v25b28lpo8Hs4GBiqh6n1Csz2TMCxqizmwiP
   Q==;
IronPort-SDR: vlB29pk6gw7Ezy18fFgSGJX3yN7ykynA4hOtvMk+xGHc49xW8Yw7LbSYrF+ObtxottX7V0Ybfh
 FNCpy/2gSffPzEBXT6zUK1jI5OpYWydoteLqTDXNixfPx1P1m71O1C2sr464T2o69NkjndcTPm
 7Z5GWeMYAxEX0LlTT28Yk+SxZF0ibaKhgpiGmGE3rNJqTagCA8jnthAoAmYi6txyYaZYRH/59S
 SPa43nWb8+1xbHNYZQtRsxTyrgJF8FYFXed5eFH+cBynyYqJAN0WLQqWvv0SwGs94vf40RrKIW
 M3s=
X-IronPort-AV: E=Sophos;i="5.79,351,1602518400"; 
   d="scan'208";a="162012368"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2021 16:18:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3+Yk6ZuH6+dopsk3LmcYcJrziep40U3W1Lw3j55AhlTCiG4a8ltp8HxGAEHcihXwxYpSswH2FfQnziFfIzUvw4F8MjCsGnyl3CPwKIldzOXNtQqpeEJG8imPgAEVhX0PsrcwwRUhM5Uf/3BU6yalWw9XMaFJjytgqDrP/EMq+vnhTN6CWbz/tFPRn6W3S/jkLw5/oBJ9ugKp12EACtWAqdE5AOZAW/LJEHHt1Mldv8b7S1Xyo0Xk5txRecTtbKmLi4EuFtdnUTrhO+ZqmRKRX+PwKOhwaXEwSp+8oWdOn6Q17dLT9O7TNQQkBkumnhO6TVrxlZxDu7YbDKlM30UKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbY4RBnkY8zuo4/l3Z0xoxAhGcUDcth9NsIugwifIkA=;
 b=FJ2wITZDQn2dTiAOmXB+Hqsxp3Me3f87IYmfWEMXIo6oZpqXQuiapA7EerHaqBEiRgEcsMQlrxcVqppjt2M8LGwf7wu0ipu44U5UdRSzh9cwro4fAtFHEgJUjNpn27o6JGEyD37tpIn6wCnUwsD4TCg9T2JI/agxZWtfRhhyB56p4TM5fEYqWBPZMomXfVP4P6/NyIdb0Ydyl74XgQaqh8yCrh5KFcBLAaIPnVrUrpe83g+IaWveU5I8wfemavtFUuHzlWoxW9fv9o3Y8TzrVl3CB4m0gVhMLqTnqo+sjPX42uTGMnKUIID5s1BLbpj56QG+Mc88bR1pALkbEkz7tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbY4RBnkY8zuo4/l3Z0xoxAhGcUDcth9NsIugwifIkA=;
 b=GeT6PJPwBGRYS0SSMr10Nf/2inpuJm9sHgidfUTVqvbesB4Rmw3nvOea2FjQHdGalrpHampo6cx4EcQm5w4wC7ehuU1V6J8aS/ke3vt/XKKcc7rHkt7iyVv0TO0AKapqMvzm9KWubc7UVZFjQfhOmUreS12AuOwLzu4ioIp1ED4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4983.namprd04.prod.outlook.com (2603:10b6:a03:41::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Sat, 16 Jan
 2021 08:18:05 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Sat, 16 Jan 2021
 08:18:04 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, "kjlu@umn.edu" <kjlu@umn.edu>
CC:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Fix an error handling in add_partition
Thread-Topic: [PATCH] block: Fix an error handling in add_partition
Thread-Index: AQHW69oGPNdrRWfzgEisqwMAdsdShA==
Date:   Sat, 16 Jan 2021 08:18:04 +0000
Message-ID: <BYAPR04MB4965E41A9C690FA11883469A86A60@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210116072802.21940-1-dinghao.liu@zju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: zju.edu.cn; dkim=none (message not signed)
 header.d=none;zju.edu.cn; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:b4f2:cf54:1af4:f2fd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4cd3c2d9-8821-42bc-ea68-08d8b9f73fb0
x-ms-traffictypediagnostic: BYAPR04MB4983:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4983C62C72ADDEB3BA75E03886A60@BYAPR04MB4983.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4GDS8Rjz71e5jI9U3mLAl7gMYGyQwyDGiJ1QWoZwBt4exZ2iF991D3i/V6aT1EtP1lvaIbPHdJI1+HYy/r2yBvWnBZb60Xotuk45AjxYl4T4k/GUoxHICwZ11fFKHHKiIKx8FptqXfS+17ormT/GbANVva9rE5phD7T7ExgHcUCDhAerXgoqfDaj42lSr4SU5hksBwQI/5rGhqbhZ+Zgp+7AM+5QlV7AIw+lUutsuAAim3n+eKUPYiHIEhGxOJImxBWn0EABJXVKZgZiqc+mNskIFL6pZh3yXGXAmlDXOUdVW+MvsmZuS/t4YFt9Nw75W7kcO//GG/VYt6Y4V7QezUIfpn72zL2Nihv7kiZ1N2Mij8XdzdvvMVriE5ghNNKSvvuhatof4iemsgXOV3bMSwuXfXDFJIa4iqdao2UswKIQ/uVP6wgkAEpkVrJQdXkA3T1Ur+5OT5hK1Il3aXsewzkM39NLqCcgUsWyTUH4Bc3EdYUjq3UKV/nHBXw7eJIjocP+LXm+0PBuUoRl0UDyXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(5660300002)(71200400001)(86362001)(2906002)(186003)(6506007)(52536014)(76116006)(55016002)(4326008)(9686003)(66556008)(53546011)(83380400001)(66946007)(64756008)(66446008)(66476007)(7696005)(478600001)(8936002)(54906003)(110136005)(33656002)(8676002)(316002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sAkr66ecCUOzQKW9gBrDu0TBPebNeha01DWm6T54bnLvcrxQ74b7Jpf19qhl?=
 =?us-ascii?Q?wrshuAuWQPBWgfPiYyxp9r5DWmfyM2ORWcuaFtoDaUtrhvTwS28IT/5xeMLJ?=
 =?us-ascii?Q?pgFD0t3xqxTc+eacCSaa6TQkrNJri1LpViRu/9zv7p1vjDUtstvK2nDO4RN6?=
 =?us-ascii?Q?Rnb2XcMcl01veioTbL8PcZ+6w0PbNhAOyYImMa3mOPRINJcHJCMCmOWYRXxC?=
 =?us-ascii?Q?jlgsiHWBddCj7LLJi8Xltu32cst7PCnUTFhsz2WHg+MvZUKbbhARhR14p333?=
 =?us-ascii?Q?8C0VUgFBwK0YTxJGsUykLmRIeq5HiVjEHj0hEsRZOhP81fE0ahAl/uu5nIKt?=
 =?us-ascii?Q?RKKC2Zr9scAq0PlaCDQqtRGMlxO61N7TLLfl61VzhWrba984hrz7s2b2YFlx?=
 =?us-ascii?Q?Z156XHvuX286VBJAuHlEM5uyRwDemtAcBkoI4lA713oxd/Ufzcfz2kUkLTyj?=
 =?us-ascii?Q?YCCeGrQyNpDiW+67Abkmr4uGAGv/Np6jNDuurVnbtEuS6A7/TU95nIf9tf8D?=
 =?us-ascii?Q?WcCwPR9uyOLdARALHc87tNrrgUTJq8qES5EIninvuTpRzBDVsF8zxbEcTq6K?=
 =?us-ascii?Q?HljOQxbRpxkkPEh0x5mC4lVe1dYdXydDh1QhP9MTxY2EOYMLreNN6tOS7jlQ?=
 =?us-ascii?Q?2X9g/rCsGWI6ML7MdG62FHfxvVMk/rq6vBCLkJnJuzkj7FSRT3FlSb5xXbqY?=
 =?us-ascii?Q?x4OMO0aAbQExhO7h1tHNT2rtYsdtTb4nYe+SEwGB0TZ9wgzbrADTal7fewpn?=
 =?us-ascii?Q?nBLLZrx+URnKmJzmKePl5ayiGNivZQaeDKFuOwFubxvNILF+wDQRDoYi5mpt?=
 =?us-ascii?Q?RKV6DEUsovD5GzcA0efT4d7SDhC1iWJMbdN2zaVm/8gxUf8u/EdyfNaFaaLb?=
 =?us-ascii?Q?bHMblyszMRTAvaleWKhNc+aO9D4QyJU4A95YRTPnXeZInASF8UafAlEOORha?=
 =?us-ascii?Q?Ee8RrCpio9SVCcM9ZV0ztT3mfKG02GQnsNLIrNXtfJIG2ILOvARr3xnh5jwB?=
 =?us-ascii?Q?qlbsmlBC/rwZndBNTtxh1gqH9il8E21pVMftDhfa6OaecEVSXuBvFpzmt51x?=
 =?us-ascii?Q?6AtE1hTP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd3c2d9-8821-42bc-ea68-08d8b9f73fb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2021 08:18:04.8147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNHVjBGXdQ4JsJRgiYaaweZeG/9bl7qDcTH5T+Wq8DhZJ6mH50N6eO6otIpaqaTQEV1cagH8DTaqikUowvwTFUoixxn5GwBQceHKmF425g0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4983
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/15/21 11:34 PM, Dinghao Liu wrote:=0A=
> Once we have called device_initialize(), we should=0A=
> use put_device() to give up the reference on error,=0A=
> just like what we have done on failure of device_add().=0A=
>=0A=
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>=0A=
Please consider having following commit message, since above=0A=
commit message is looking odd from what we have in the tree :-=0A=
=0A=
=0A=
Once we have called device_initialize(), we should use put_device() to=0A=
give up the reference on error, just like what we have done on failure=0A=
of device_add().=0A=
=0A=
=0A=
Also have you tested this patch with the with generating appropriate error =
?=0A=
=0A=
