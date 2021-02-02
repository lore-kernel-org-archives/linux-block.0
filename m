Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757EDC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D2664EBF
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhBBJUc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:20:32 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5870 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhBBJUE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 04:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612258368; x=1643794368;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vm+Ge4rH8lgbZa2zI7aUvYLCV/TAuHUQEEgpQjcC+2k=;
  b=NyB0Us+8jODCY3S1AkzWkqXlnWLqoh7hXgMJqmcdNCSU42WttIUD15/A
   9rPSkoIi0iwA+frBy9CwK4cTK+uOuCfHKwBSnafmV6OoXocKI8PbSl8ec
   bxy2015eeKsdTmHa/pwty+SzfNn/kF6YYtS+jjr3CesUOz0QyWUMPK/sF
   MRaQ6crRbN6OkkfnPHvyIsA9Z5zCpSGFQU0ME2cJ63gHAMS9Er4FJfF1K
   bxCwTrX+m86wZHvaIvw+mdAicEUegGrr3jNWjGM/Y+DHXLBJP2N/WJtbH
   E5YJrMfzPEZjxtS0mfiniEiVoS+JNRB6hZ8Zw8NyKNxNpQEtvl1JPM1Gn
   Q==;
IronPort-SDR: UcOrj+RAvDO71NfIfWJEcDnFumqoGdt8wC0CZxh0Ce72Bka7c+6jhJCvCaBrrYY7j8hP7+qWa8
 kFrnPoMNTescHFlTST4vmTmP7vF5GLAdnP2cBuGeszAVEYJIIDvd5+dcML2CUPj5qcgYxy7ta6
 tG6oxxyY8/7y6S4yyEDfsxxJzmTefJkeWPwzqz9omLYqsyGkccZUFmGoa545PQqus7F93HOF6h
 5aafxciCQvIbkwaiJLVank8SeP7Xwz/Hc44wVu2d3PzA06M0ZYdVV8ExsoqUrwE37ObNRaXk3T
 HYk=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="262981603"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 17:31:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtLuAmFbNPHL9gzLfK2/9qyzbTBE/rR5sMQ59mNa7pwBLNPFiNmFIUdKx7G3aYis9wlAJYbNqyscLaViB243ys6B+CRAL8tL9D5RSz752PYTkrm8sgJ6WjGJuS5UZ8PP7u4b70eHUc2WvwQQllk7UgQ83z5AJpcq+LXUORWasDHSoPwRq3Wkphi0gRJkPgrLBEV2FyoritWwpPxO1QfN9JChpMm1OtdWgHMUAFc1KkqXpuHwbadt1Oyz7wlnbJnlFqx4+aapvkDK8wdKd6xIWujKiSiA24bQof1m04XkEKPs9Y6JGd/FrGKvjHgO40dcArvzGE7+bj99F1CPEBHITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeM6W/ycxGF6n7g0nUplM17LyKy6kYMxN1YpVJO9nDk=;
 b=JCqapMUUMkeGMREwTIqAj62LcErn7zCK/hluwgmbJETkkPtBH7tPHlhIB3HRxZx3QDgJwRJpMnGiW7EvOk0naiQuzcPm/UBUd/9ITocBcCJCrJMTMAzAztS4TxOZi9V/r60eJoWah6dhfxD9gdraE2zdIYVgQpZB/0apFY5BmnCwGEJmwUMMZw2X5g6k05JeBvkbKWtsXp/4qTB1zHodBylu5zBYSigarumUhLx8HqOnfUBtuzgiUDFGax9l8nE3oFYq4rP1iRzwuGdxXkOBBmBsN9nVskS62WerVpmbQZkv8OLUT4VKFNEsrtOGd/cpP7pgmCyK7ve7BzFTZ3uUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeM6W/ycxGF6n7g0nUplM17LyKy6kYMxN1YpVJO9nDk=;
 b=XL67OHs6OqehfXogwHqvb90O/9zMXQW+vnJtpUVlzCrBiiYgl1fBxfSF0OI+7IQuqyGKiJExAu9S4YT6HEkJYZWkZh0rEmaMm6xpLAsPNioAyL3Kg9bkENDmoQJ8JqIRfsBtc9j6xL9/XgWx7boC1IHTClWRTY/1x5egNWF4pNk=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6477.namprd04.prod.outlook.com (2603:10b6:208:1aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 09:18:51 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 09:18:51 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hare@suse.de" <hare@suse.de>, "colyli@suse.de" <colyli@suse.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 7/7] null_blk: add module param queue bounce limit
Thread-Topic: [PATCH 7/7] null_blk: add module param queue bounce limit
Thread-Index: AQHW+SQGAQ0Sg0ggk0ahW3GTKUL+bg==
Date:   Tue, 2 Feb 2021 09:18:51 +0000
Message-ID: <BL0PR04MB6514B7265556126D274D2612E7B59@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
 <20210202052544.4108-8-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:38be:e4f3:6636:91ce]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b0b1503-04cb-44d7-b3c3-08d8c75b8e03
x-ms-traffictypediagnostic: MN2PR04MB6477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB64777B067CCCEC1FE5D9AB9DE7B59@MN2PR04MB6477.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3NatQXoYFGx4WSC1wtek7knkLm/ihMZxsHxpzcDmnK5OfYMWMd+VZ4lcpB7pd6t0/10SsEukaxqi5Pj6feE3+mS7MDdtSjKTPyZDkvDxtaPlioHTdIKIr3oGlKl2nMlRZdN+PAFNl7IPBbOIvToDd13wDwEw4vz/1WqvIuy1C+FiaJyWJH6C/PxxBEk7PPohXTYgU9KoDN5O25pczJAy5pafQ45GrHrHyIZLUTeAMVQUcnf/CPaqvW3BG7rEQ038NZyKd3TS9HiX5YksOffdg4aw7re3SVTj6RvXv2InPEyP3/NtktcSUBNFVVLuJIBuL4zJiLph3Uvio9eEqnT0YZcZhgqDLJ4aexOVdD5iblgWsCBEg3d3Lb85jvLXfivBFalbUNGBrLBt92801y5zMpqakEuXyeO/SHeXwARMdC04iTh5RtNaqLeM2Y2TcZnbzbIK0vN8XyceFHxV/2SpVkhUqkZERxjfX7lnBCtft8AiHKoN6AXGM4OuqQ+GzrYqAWqJSrqlbsDp0IglKp+Rpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(83380400001)(110136005)(86362001)(186003)(478600001)(8676002)(53546011)(6506007)(55016002)(316002)(7696005)(33656002)(64756008)(7416002)(66946007)(76116006)(4326008)(71200400001)(52536014)(9686003)(2906002)(66446008)(66476007)(91956017)(8936002)(54906003)(66556008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qV5TRH7tjzGUIGutIUpCnBCxWtSTM8VZH5bCxfCx1zYOH/IIJmcBqGfr9PoY?=
 =?us-ascii?Q?KnajKPWQgIzCru1Xic/mDpw091GxXBLFEgM0+WibqVS/udPEF5RQ0Tb49Cd+?=
 =?us-ascii?Q?sNMXI1XUdALy5NagBr0lk53+DUDKjYHA/eDhjNqfgHHKHhmvAmGPDN3THCuk?=
 =?us-ascii?Q?TFyLpUcWBDNCneSDP881vMfZi2D6L7DpqXOsGC3QN/qSN7zC0z2vhNB5OXyC?=
 =?us-ascii?Q?x0LuJ0nnSocl5z6lMpQcUbrNQd2jhNSRtp60Ic6dv0pwRedbfhn/DEZmD92f?=
 =?us-ascii?Q?kKxT64lhCeVhiu3EglnuFQaqQ2zOXIw2P19pPS9AgUtPj2IpfC0LZrbpi0s4?=
 =?us-ascii?Q?kdVv3S7UdRmYlCRWNlhdikkAsNWso4YxcyGL6ThM4ycsDntZyzdrVX8SwZWZ?=
 =?us-ascii?Q?GkPkWjzvfV6gKnAOSHvGfZoyFBdfQK3vogzwXoTCVheKYeV8BJg2iTcWkr2g?=
 =?us-ascii?Q?Dg7S80KUZrzdFKTAV5yh0dE6BnFSmW6Ip7CNTir1I1Vpi39+twB01xyfvf7K?=
 =?us-ascii?Q?Yx/SJoNNdFZm0ADEYj02L/eoT6zvyAR9gEnmfK3XauzLXSpbBa5HaG8FLnUT?=
 =?us-ascii?Q?yTWhUv2qLWDn8AYDCm5A0vaKfWq5iMAvgc3PeTYRgCKOh3KET77fbVbc58P1?=
 =?us-ascii?Q?ZVOjMicCvwXVd8Y3wQ97nby0TYDCuSiCf/ZgfcOY+R3mB5WNkCTVhWoBRVI4?=
 =?us-ascii?Q?adZuRcVK8AB0CzOoiltcXEasaJyMc+B+UFw87JlE5HiJi6+5xmkRcDSsJX8k?=
 =?us-ascii?Q?yLOGytIYjqGwaOUzYABU0ZPfko251CerSxrZPUCKgvE0hnMtaDjzYs7pqeyH?=
 =?us-ascii?Q?0FKbSnPMaPWCOyeZCVzsy+OutQeFniaxY3nylqjYSpEuf8/o4XD/5h9sDM8D?=
 =?us-ascii?Q?3trXC0FAlxQSIv9w75bFoFnjQxpQBukMoZM2MTKp8NI9ZsNecayjefBAvJRo?=
 =?us-ascii?Q?Z2IT1y21ZuRhac0NlZC/IihNsRnaAci0l47XmliLbnR7+D9vp1FiuSR4jt3K?=
 =?us-ascii?Q?9LpAYJ1BSrIxxx5S0OmkueXDi6qjDbL77ohoYhZX/7g1dlygsI968GunA1Kb?=
 =?us-ascii?Q?NT9VPjVBBXG3sgkavlQ+5VpzywPEXukTOJX+GCNWwTQQWoT7mIfG6KE0kbJI?=
 =?us-ascii?Q?Gg/5tc5vFcOSYltuWq8tQJx986DjQDvWJQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0b1503-04cb-44d7-b3c3-08d8c75b8e03
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:18:51.0886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRndkFdfRUqZWI663oaYLw7yBKtbssLsZ1LCZsUzzw2P7O5hxFsz4yVWhKtB6dslhH02USsuGHR2+4VI3dldVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6477
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/02 14:26, Chaitanya Kulkarni wrote:=0A=
> This patch adds a new module parameter to set the queue bounce limit.=0A=
> Various queue limits parameters are usually present in the sysfs.=0A=
> This is needed for testing purpose only so instead of poluting the=0A=
> sysfs space just update the null_blk drivers.=0A=
> =0A=
> This is needed especially for blktrace bounce related tracepoint=0A=
> testing.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
> # modprobe null_blk bounce_pfn=3D0x1000=0A=
> # for bs in 512 1024 2048 4096 8192=0A=
>> do=0A=
>> 	dd if=3D/dev/zero of=3D/dev/nullb0 bs=3D${bs} count=3D1 oflag=3Ddirect=
=0A=
>> done=0A=
> # ~/blktrace/blktrace -a write -d /dev/nullb0 -o -| ~/blktrace/blkparse -=
i -=0A=
> #=0A=
> # # With null_blk bounce =0A=
> # modprobe null_blk bounce_pfn=3D0x1000=0A=
> #=0A=
> 252,0   34        1     0.000000000  4390  Q  WS 0 + 1 [dd]=0A=
> 252,0   34        2     0.000010139  4390  B  WS 0 + 1 [dd]=0A=
> 252,0   34        3     0.000018996  4390  G  WS 0 + 1 [dd]=0A=
> 252,0   34        4     0.000024576  4390  I  WS 0 + 1 [dd]=0A=
> 252,0   34        5     0.000065152   829  D  WS 0 + 1 [kworker/34:1H]=0A=
> 252,0   34        6     0.000092303   182  C  WS 0 + 1 [0]=0A=
> 252,0   34        7     0.000098164   182  C  WS 0 + 1 [0]=0A=
> 252,0   27        1     0.004573597  4391  Q  WS 0 + 2 [dd]=0A=
> 252,0   27        2     0.004580891  4391  B  WS 0 + 2 [dd]=0A=
> 252,0   27        3     0.004589687  4391  G  WS 0 + 2 [dd]=0A=
> 252,0   27        4     0.004594356  4391  I  WS 0 + 2 [dd]=0A=
> 252,0   27        5     0.004619473  1049  D  WS 0 + 2 [kworker/27:1H]=0A=
> 252,0   27        6     0.004634411   147  C  WS 0 + 2 [0]=0A=
> 252,0   27        7     0.004638609   147  C  WS 0 + 2 [0]=0A=
> 252,0   29        1     0.014589610  4394  Q  WS 0 + 8 [dd]=0A=
> 252,0   29        2     0.014595792  4394  B  WS 0 + 8 [dd]=0A=
> 252,0   29        3     0.014599028  4394  G  WS 0 + 8 [dd]=0A=
> 252,0   29        4     0.014601713  4394  I  WS 0 + 8 [dd]=0A=
> 252,0   29        5     0.014621330   807  D  WS 0 + 8 [kworker/29:1H]=0A=
> 252,0   29        6     0.014633813   157  C  WS 0 + 8 [0]=0A=
> 252,0   29        7     0.014637660   157  C  WS 0 + 8 [0]=0A=
> 252,0   30        1     0.009147174  4392  Q  WS 0 + 4 [dd]=0A=
> 252,0   30        2     0.009154377  4392  B  WS 0 + 4 [dd]=0A=
> 252,0   30        3     0.009163064  4392  G  WS 0 + 4 [dd]=0A=
> 252,0   30        4     0.009167161  4392  I  WS 0 + 4 [dd]=0A=
> 252,0   30        5     0.009191437  1084  D  WS 0 + 4 [kworker/30:1H]=0A=
> 252,0   30        6     0.009206084   162  C  WS 0 + 4 [0]=0A=
> 252,0   30        7     0.009210863   162  C  WS 0 + 4 [0]=0A=
> 252,0   30        8     0.018510473  4395  Q  WS 0 + 16 [dd]=0A=
> 252,0   30        9     0.018517767  4395  B  WS 0 + 16 [dd]=0A=
> 252,0   30       10     0.018521213  4395  G  WS 0 + 16 [dd]=0A=
> 252,0   30       11     0.018524229  4395  I  WS 0 + 16 [dd]=0A=
> 252,0   30       12     0.018544026  1084  D  WS 0 + 16 [kworker/30:1H]=
=0A=
> 252,0   30       13     0.018555127   162  C  WS 0 + 16 [0]=0A=
> 252,0   30       14     0.018558333   162  C  WS 0 + 16 [0]=0A=
> =0A=
> # # Without null_blk bounce =0A=
> 252,0   38        1     0.000000000  4744  Q  WS 0 + 1 [dd]=0A=
> 252,0   38        2     0.000014768  4744  G  WS 0 + 1 [dd]=0A=
> 252,0   38        3     0.000021771  4744  I  WS 0 + 1 [dd]=0A=
> 252,0   38        4     0.000062557   914  D  WS 0 + 1 [kworker/38:1H]=0A=
> 252,0   38        5     0.000089768   202  C  WS 0 + 1 [0]=0A=
> 252,0   32        1     0.018453947  4749  Q  WS 0 + 16 [dd]=0A=
> 252,0   32        2     0.018466080  4749  G  WS 0 + 16 [dd]=0A=
> 252,0   32        3     0.018470619  4749  I  WS 0 + 16 [dd]=0A=
> 252,0   32        4     0.018495195   514  D  WS 0 + 16 [kworker/32:1H]=
=0A=
> 252,0   32        5     0.018509942   172  C  WS 0 + 16 [0]=0A=
> 252,0   55        1     0.005000087  4745  Q  WS 0 + 2 [dd]=0A=
> 252,0   55        2     0.005005637  4745  G  WS 0 + 2 [dd]=0A=
> 252,0   55        3     0.005008453  4745  I  WS 0 + 2 [dd]=0A=
> 252,0   55        4     0.005029352  1082  D  WS 0 + 2 [kworker/55:1H]=0A=
> 252,0   55        5     0.005041915   287  C  WS 0 + 2 [0]=0A=
> 252,0   31        1     0.014158231  4748  Q  WS 0 + 8 [dd]=0A=
> 252,0   31        2     0.014164173  4748  G  WS 0 + 8 [dd]=0A=
> 252,0   31        3     0.014167308  4748  I  WS 0 + 8 [dd]=0A=
> 252,0   31        4     0.014188759  1151  D  WS 0 + 8 [kworker/31:1H]=0A=
> 252,0   31        5     0.014203015   167  C  WS 0 + 8 [0]=0A=
> 252,0   58        1     0.010016655  4747  D  WS 0 + 4 [systemd-udevd]=0A=
> 252,0   60        1     0.009982571  4746  Q  WS 0 + 4 [dd]=0A=
> 252,0   60        2     0.009993942  4746  G  WS 0 + 4 [dd]=0A=
> 252,0   60        3     0.009998661  4746  I  WS 0 + 4 [dd]=0A=
> 252,0   60        4     0.010136269     0  C  WS 0 + 4 [0]=0A=
> =0A=
> ---=0A=
>  drivers/block/null_blk/main.c     | 20 +++++++++++++++++++-=0A=
>  drivers/block/null_blk/null_blk.h |  1 +=0A=
>  2 files changed, 20 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c=0A=
> index 6e6cbb953a12..8ddf2ba961f7 100644=0A=
> --- a/drivers/block/null_blk/main.c=0A=
> +++ b/drivers/block/null_blk/main.c=0A=
> @@ -156,6 +156,10 @@ static int g_max_sectors;=0A=
>  module_param_named(max_sectors, g_max_sectors, int, 0444);=0A=
>  MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sector=
s)");=0A=
>  =0A=
> +static unsigned int g_bounce_pfn;=0A=
> +module_param_named(bounce_pfn, g_bounce_pfn, int, 0444);=0A=
> +MODULE_PARM_DESC(bounce_pfn, "Queue Bounce limit (default: 0)");=0A=
> +=0A=
>  static unsigned int nr_devices =3D 1;=0A=
>  module_param(nr_devices, uint, 0444);=0A=
>  MODULE_PARM_DESC(nr_devices, "Number of devices to register");=0A=
> @@ -354,6 +358,7 @@ NULLB_DEVICE_ATTR(submit_queues, uint, nullb_apply_su=
bmit_queues);=0A=
>  NULLB_DEVICE_ATTR(home_node, uint, NULL);=0A=
>  NULLB_DEVICE_ATTR(queue_mode, uint, NULL);=0A=
>  NULLB_DEVICE_ATTR(blocksize, uint, NULL);=0A=
> +NULLB_DEVICE_ATTR(bounce_pfn, uint, NULL);=0A=
>  NULLB_DEVICE_ATTR(max_sectors, uint, NULL);=0A=
>  NULLB_DEVICE_ATTR(irqmode, uint, NULL);=0A=
>  NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);=0A=
> @@ -472,6 +477,7 @@ static struct configfs_attribute *nullb_device_attrs[=
] =3D {=0A=
>  	&nullb_device_attr_home_node,=0A=
>  	&nullb_device_attr_queue_mode,=0A=
>  	&nullb_device_attr_blocksize,=0A=
> +	&nullb_device_attr_bounce_pfn,=0A=
>  	&nullb_device_attr_max_sectors,=0A=
>  	&nullb_device_attr_irqmode,=0A=
>  	&nullb_device_attr_hw_queue_depth,=0A=
> @@ -543,7 +549,7 @@ nullb_group_drop_item(struct config_group *group, str=
uct config_item *item)=0A=
>  static ssize_t memb_group_features_show(struct config_item *item, char *=
page)=0A=
>  {=0A=
>  	return snprintf(page, PAGE_SIZE,=0A=
> -			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone=
_capacity,zone_nr_conv,zone_max_open,zone_max_active,blocksize,max_sectors\=
n");=0A=
> +			"memory_backed,discard,bounce_pfn,bandwidth,cache,badblocks,zoned,zon=
e_size,zone_capacity,zone_nr_conv\n");=0A=
>  }=0A=
>  =0A=
>  CONFIGFS_ATTR_RO(memb_group_, features);=0A=
> @@ -1610,6 +1616,17 @@ static void null_config_discard(struct nullb *null=
b)=0A=
>  	blk_queue_flag_set(QUEUE_FLAG_DISCARD, nullb->q);=0A=
>  }=0A=
>  =0A=
> +static void null_config_bounce_pfn(struct nullb *nullb)=0A=
> +{=0A=
> +	if (nullb->dev->memory_backed && nullb->dev->bounce_pfn =3D=3D false)=
=0A=
=0A=
nullb->dev->bounce_pfn is not a bool... So maybe !nullb->dev->bounce_pfn ?=
=0A=
=0A=
> +		return;=0A=
> +=0A=
> +	if (!nullb->dev->memory_backed && !g_bounce_pfn)=0A=
=0A=
Why ?=0A=
=0A=
> +		return;=0A=
> +=0A=
> +	blk_queue_bounce_limit(nullb->q, nullb->dev->bounce_pfn);=0A=
=0A=
Shouldn't this function simply be:=0A=
=0A=
static void null_config_bounce_pfn(struct nullb *nullb)=0A=
{=0A=
	if (nullb->dev->memory_backed && nullb->dev->bounce_pfn)=0A=
		blk_queue_bounce_limit(nullb->q, nullb->dev->bounce_pfn);=0A=
}=0A=
=0A=
?=0A=
=0A=
> +}=0A=
> +=0A=
>  static const struct block_device_operations null_bio_ops =3D {=0A=
>  	.owner		=3D THIS_MODULE,=0A=
>  	.submit_bio	=3D null_submit_bio,=0A=
> @@ -1882,6 +1899,7 @@ static int null_add_dev(struct nullb_device *dev)=
=0A=
>  	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);=0A=
>  =0A=
>  	null_config_discard(nullb);=0A=
> +	null_config_bounce_pfn(nullb);=0A=
=0A=
Where do you assign bounce_pfn to nullb->dev->bounce_pfn ? Something is mis=
sing=0A=
here...=0A=
=0A=
>  =0A=
>  	sprintf(nullb->disk_name, "nullb%d", nullb->index);=0A=
>  =0A=
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/n=
ull_blk.h=0A=
> index 83504f3cc9d6..cd55f99118bf 100644=0A=
> --- a/drivers/block/null_blk/null_blk.h=0A=
> +++ b/drivers/block/null_blk/null_blk.h=0A=
> @@ -86,6 +86,7 @@ struct nullb_device {=0A=
>  	unsigned int queue_mode; /* block interface */=0A=
>  	unsigned int blocksize; /* block size */=0A=
>  	unsigned int max_sectors; /* Max sectors per command */=0A=
> +	unsigned int bounce_pfn; /* bounce page frame number */=0A=
>  	unsigned int irqmode; /* IRQ completion handler */=0A=
>  	unsigned int hw_queue_depth; /* queue depth */=0A=
>  	unsigned int index; /* index of the disk, only valid with a disk */=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
