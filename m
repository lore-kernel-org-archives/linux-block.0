Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09C1C04A95
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 08:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbiI2Ifu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 04:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiI2Ifr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 04:35:47 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3391A1162C1
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 01:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664440547; x=1695976547;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ihJ8rr7UV8CD9nJBn4fJ6DsM6dgS2CPN/b9Fq/yEibtvpLJfN/UOxZ14
   AhZ8lXnoVjQxBRKd3m+EmlSaoZX1W0t89FuDDz2ceHCAA5PbWescyo+a+
   l+KzmUyHcoE0aC7sioaZjERgpmvyOrDYiy28ymQtnlwXoDUW+O/T2+//u
   TtuyOHOzZwoq/eTbRj8JG9ReWB4ajlAPkDnSsQ93W1Dt0tsaj9yTFwC+G
   kJ4gmVRttiNMkSaAKOzXpnLe6GeHU/BwW7KNIZgHxT+8fK71EsHUonpqy
   cA5FVMjUL/0hP5d5pb+LXGio6JAHfiEGkV3h/4sDUrRvmFNF/KaEEU1eh
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,354,1654531200"; 
   d="scan'208";a="324665488"
Received: from mail-bn8nam04lp2046.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.46])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 16:35:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM7Z5OUMooMcJzCF2aZokmxurfqrHbidk9hpxaDuqJ0BODey1HTWgQvLEj+tqnDbk75bIuX+IaPXe8jouUBiU8BIWHzPgiF/qYanYms6KlTr0THfsVWswaDZhINOqEzCvKmoCHgZYMVzuBskfuZ+18CGPLeEdZ9rJacsuqeq4Br5YxvTFNrQ/FMn6r2wmFnWK53E229UsroNIiZY2Q68znhyCU+YIdz1IrAgo8R+l3JgdOoqsMGSJMIHtUfpGQvnY6T1LfkrAhHzX4KY9Rg7OseLXb8Y0xo44XuagCy9fpopeuWNKW0ThzegeZTFwY3sGAAthAvuwolHRsfLRNWOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=h6NP1i84t+JYqrYXeCsNEaBLgR5PriQGN8qOI7+u8b1qKPE6OzmHbCO7rsZ2H8yFGmUbLP1FaduoyzXZxoIo8oInHc+/RBXxfTaaT0LLvzxnS4/QhcbSUP75jNE3KnN2QzNzCL14ef27rZkXLKpIVbCvubt/ctDpfNefdPp5+75Fa2cMxFD0juhTTm6Pj0eUPV5LgGACLLTzPa/Cr9fvNwQRRYOwiB7cm3HsgKUOxIH3AfXAaiUHjvn4NRFaehBlwTRaHFTaw8YSLTP/8QOGGBNbFkh4R79JjmO2/BronckyJEPqlkjavbigWDdFHyLoLu3kEw78LVrhWG0CORGUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=dFt/VmtNGmCM94CO3ekDl3wwheyX87eqojJsLJ0GagvWQpXFnsd8HgF3qmSrFp8Ka8bE1TdLDDzuqSpS5+Qo3pOG6xWrYYvupNd/1D6FdXonjl+21v4Fs97YQXWKWLjgnBRY9ZJCHaR+wf8owFVop2Cp+x3NWHInprHgNZ/7oa4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6099.namprd04.prod.outlook.com (2603:10b6:408:55::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 08:35:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 08:35:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v3 2/2] block: use blk_mq_plug() wrapper consistently in
 the block layer
Thread-Topic: [PATCH v3 2/2] block: use blk_mq_plug() wrapper consistently in
 the block layer
Thread-Index: AQHY09fystxW19EZW0uaAkSvxXL4Dg==
Date:   Thu, 29 Sep 2022 08:35:42 +0000
Message-ID: <PH0PR04MB7416FDF383181FD8E0387A999B579@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220929074745.103073-1-p.raghav@samsung.com>
 <CGME20220929074749eucas1p206ebab35a37e629ed49924506e325554@eucas1p2.samsung.com>
 <20220929074745.103073-3-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB6099:EE_
x-ms-office365-filtering-correlation-id: 7a8c97a4-1226-4adf-ea2c-08daa1f598b8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PGu5Sndp+iIj7Iaiv7+892UwSJS66VGrNVtiR8IzQ6mjVKsTFmRAfDsnSb/Q7olfItPpu+uP6ZxHbNhhgXFgk8YE6cimN8U7uzH7ZiRkn2NYSg47q0l0B/QAvGsPLiAIfhfNNFbJ8Md5Jsel+OSPTWV8IccjsU6epMNfC8jo1hx/xNILeGTLraNkM+AI/SY3JBvWtqvjV62zyHLAYBGDSVwAOovs13HB+tbPQSegNYj7yNPzDTy8LyALArqmN3gZ+p7znoZMN/6cYZkYGsICNY6i/7l+lOdxsNw0dLd8VBqinfofA0ZYSpZjTMOZ9x8547Ryt+TysAvpC115NvSxBVl0O1xRwsaHyh6dlxlxdmkLOGJBriGJL2owJhIS+LDIAbtZel4V1vpwK384/wuVg9PYVx0hML06JZLNaBGiLeiNJbuD6ddmWbqM5Jpo4QsbsK8ega3iV2YFTK6uStfexb+t5T8jr/Ig/XcL1mEGFa1HtQGvxvVCB8x5AuuVb8k0U/DbddG370RM43jgYwSsquenjdT3GJfPpUJQAMUFt6kefINEGLYzzpI/xZDPhz7/dJRI1p6mU2iv7nPEf0SDlgq862wXDKvQfVJIEIOrTeE+dV29Eh6fHdWdOEQ6ZMTYqCzyeCMESMm9WtEsA9YQ3qCEoGkTO17NlwYJ6XNH9NCW9td2nvttVjRX077NYzSeKGHBIsOoWnd0RLQ6qvA+Mss2KNLfpagOweQhXM1+rzuJsPU1R3ZG/AwGCb+S4MKe67UaXrfzLZKMi1HxLv+oUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(54906003)(110136005)(316002)(71200400001)(478600001)(91956017)(76116006)(41300700001)(33656002)(82960400001)(186003)(558084003)(55016003)(66476007)(66556008)(66446008)(86362001)(66946007)(64756008)(4326008)(8676002)(38070700005)(2906002)(8936002)(6506007)(7696005)(52536014)(9686003)(4270600006)(122000001)(19618925003)(38100700002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pGfsKcETuhZmAGK4VEjktm3IZcWx7Xc4Fd0GDgheGPVhGthx/x6bDm7trnZj?=
 =?us-ascii?Q?sQV0q37C/gEUqUqyRXgvLO2NWNvp/k5DFF3R5GxVLQQv0eRHbBAVowWinw4V?=
 =?us-ascii?Q?Ws6w+0HZP/c8NjW3EcqExpyQyCmFV8rtbJqq0BlCU2kZVBAocqayQGXBdwr8?=
 =?us-ascii?Q?LMVutfCZA9RUtuuZZObD7ACuhQ0eUvr7BvHJk6wbStjS/6ErtsQAtJr3/QTb?=
 =?us-ascii?Q?2WnUTPbbWwaTrpXG7GI5E/i0ID9/dxrBovdfKHfRX4QfVgGc3unqRg/hmkFa?=
 =?us-ascii?Q?wGMH/hVPW7bqbHLd9/T6ihZdQ69H7mugQxvHDguhWU1mbKsLMdj9I5ndY/pV?=
 =?us-ascii?Q?HHPLhCSMTi09A0kfPypc2QEgMrwLR9upcmsnPtnFSNBWq8QUn+f1rtj3gzu5?=
 =?us-ascii?Q?uMD/bxHFIg5OO5u1MYN/JliIwOgT6NQZeXc/Zew+gubYoT5TbPQTc9x7fq3+?=
 =?us-ascii?Q?mvBjXMwpe4kzeNsZMoHEo+2W2TMbhtJwPKNtle1JkySqLNthca3ZHmh0jITg?=
 =?us-ascii?Q?tIHeef8TXho8DDc+GY1YX+uVpeS052qZwyLz3q+JzIK3IZKos2heWeswPBT7?=
 =?us-ascii?Q?cyYIq/q3/Hu3m6NkERt0v3tATKX15ZQps0f3T3HaLMiUrT0qCA2UrIc+xbJD?=
 =?us-ascii?Q?Rfcp37Bs9s8JNx8AbKqt8NjmsZapCe0cfzNfDQOrkclwOC40CLJgGhlJxjgY?=
 =?us-ascii?Q?vMBRaymJZ6aEtFZXpfMrOWcOI7OAgGpnJybFGs+gRSvRJCjooEYjxA5KO7Ol?=
 =?us-ascii?Q?BL+8kf/gPb64OIf3rjgsRe1zXTnFv2QEiiwAloLYMop4pJJWMIfEsI7HvJYl?=
 =?us-ascii?Q?6PSGvT/xs07J5DW9MZHaTqesy5rDEQvP3xJZl6/Pta0hB0N0qHWn60w+ne6o?=
 =?us-ascii?Q?7IgNHeylqIotMzEfKaRGq0eEYeFV31d7clCIl2FAalvUPqWQK4+OLWLmj1nQ?=
 =?us-ascii?Q?UsvHe2oiDo1p0d3C1GnAq7SefTW2yKyBDya7xN0/GoKi+g2RRi3Qo+pR2Gj/?=
 =?us-ascii?Q?wgOTuKLtOxYzeMKD29JuiyE6rqc7cc7VKW8oWHt8L7JoihK4zmlYcKsuSbNX?=
 =?us-ascii?Q?rC4wGt3eAn8b5H61sG/pxzHeVPujNymC2dgcisRiCH+T0aEZXKGR6p1PoM20?=
 =?us-ascii?Q?5syJLAT2+e/HANIgcx1gsoWtSnpiaYmSd7b2sY+ah94/j5a1xQCDrrnZJLUj?=
 =?us-ascii?Q?5cj3qdC2IHzp2h6uI8tEEgKPH+KjxJJEbFywMMEJjDMiLeCUKfiJpbRm5XvF?=
 =?us-ascii?Q?PMj5P53Bky2B3HD2QQAnU1rwq0rWhGFnI2QQnuxLFPM1aR0CAJScmvoHr8Ds?=
 =?us-ascii?Q?7pnHeI/MTYmi+MpxH5kp0ZCygUZmLx8/ptUbBWiOrA+6dcjd7gnvfm3meNal?=
 =?us-ascii?Q?zp16ZgMDzz1rJxHZ3Or65jhSkoV4y28Nj3/c0KZhsAsBJAnQ6tZjcPZJ3/f1?=
 =?us-ascii?Q?WCisHOOueC+afUSwJH+BZbTrpK4rhU3pzuwRgeD6FKxMeREHRPaG/xl4vA4z?=
 =?us-ascii?Q?AMeoBn6Di55y5HVYiTwTWYmpPhac+ZjCcgijzAKEr7UAb2bw85OU27SMHBXx?=
 =?us-ascii?Q?1axfuMkJ1DLO722j15wgjm7YZPrVZGXXRlERme91ZJlUSgxZuW8/x7e1kiTo?=
 =?us-ascii?Q?6Pm7mme70wPyNUS0ynrrlVxbqrAwgiNE7AqjY6qzfEY7K5RHgUqfpzC/k/ND?=
 =?us-ascii?Q?hFpJPsA4J9v4EXAh6Et/05seykA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8c97a4-1226-4adf-ea2c-08daa1f598b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 08:35:42.7505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fmQCkTZDn6cjKx6uhlblmp3FuxAmqda849eDOlDloftYDjwdaZwJXdIYw7da5qSRGBkQNgEWOjkrCkOgd3/5+XxcwYEneMFIpAQlH0jn8wI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6099
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
