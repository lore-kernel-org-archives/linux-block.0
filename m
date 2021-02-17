Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDCBC433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Feb 2021 23:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B94B64E5F
	for <linux-block@archiver.kernel.org>; Wed, 17 Feb 2021 23:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhBQXKs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Feb 2021 18:10:48 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:60820 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhBQXKr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Feb 2021 18:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613603446; x=1645139446;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0naMlFWoeQ19fGTH6ZJ9mDgr0Wg+PiqRE8wZQ8cTIRI=;
  b=UQoqF2F2XlAOOklq8F5bsIq9iUR6J3At4r2tRuCTT3PMNhgW55BO1MZ4
   fn2Poi1M20/cD50VqsMzHTifosO2PGKSDkBpGN+rJdjYkqSdbYDO83Ftx
   FG88s5iL6kbeOGdt/p6iU1bAiCluApuLnD52nQDUtwHxmlva836kGzIDd
   i7O7yuiSvL4lN/GNkoEBgjOvSvY9HP567i8dBswcBnGrUOSDT/jXbDI06
   Kgt0UFoG7KXiStyJ130IJfOxfTbABaxxKwbnK1U/TBa5RfdbJvDQ89CFp
   NI8SiDoXOai+HSxKBTUsMRPdp2WJlu9qgEFYafxnJu7RRM7illGfvVwEh
   A==;
IronPort-SDR: +ILWfdT+Im8Mo2L8uLBSrqoBKQVXGDnJgldJuP31ZuSG/LXjnYa4B9U1HMd4DKnnrr1V9DTUud
 7B7MDt3wcN8H2PL4z24+sk7Gf/N36lYjRgX/Sk7ysf4v1g+X63744J1goaQbIPCr272Nuf+54d
 yWOl7HmUdM3vtZW1xaB/xSJMD1F/styMDn9w2jd8dL9CH27N1+g6e8vXolMT3IW4MOm6SOpx/T
 JcWmoW8LgO1EE+N0SgUKPr5XeYMPw+JuuvpCYcGvWnRgl3/xc1LfMWCKALk5HcpoxicU3d/98L
 L10=
X-IronPort-AV: E=Sophos;i="5.81,185,1610380800"; 
   d="scan'208";a="164695485"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2021 07:09:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RT5dQ2a/jlEO7q/eleh1BdxKI477N6wyKqxYauOMkicQseHM3l47q2UOSHsYQpVkuMu8I8RZB+ZZXA4m4klZEyDOlEtFs0pi1HpBOzw/ObJpop6iuGEwHyZJ1TofS+QnSS19+3t+n4lyInKs9sF7uy25r33yNC/5iIWUdcC5MB5e0zrlYs9nmGssn/vMBettdKgIVB7bKPScIiboeui5EVrwTbGHVLWulL5U8NfgtcOVsyQih+xzuB45/E8uEadd4aLA0IvQ2lIAt81AsG45NP3UVlQuwy0Si/GVG6ejsLGcqdrik3l9Yn7PEkz/bNOwVk0zaT0GU2eTmyl98cy5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGDnw47/JOtLmdXFq7JJMS0Ge907XQoLOv3btpvITCE=;
 b=kGaxHy5mYRi2IXJFZHaFrKcSHfegL3duqtNDckHHpo5NGPKoGnDmMLTgZR6APVuQpWK4X68yvO0rBXShHalxGyybQ9Ma+gSsM9vcopj8+3wAWz+IZGfQr1bc7xr4G39VM3OAmLdMYUCSXCPLE/8qygLZW58PP8QeDcjBux6YUYXCs65aR+Cv7XhTq+dQZW1pQWJo5xHTTQLDuFwRTa3PxHp5XW3qBPLkjZn2NQ9MDFvJCzTr4dv851Z0cDhkd0jjtpn3jUQQjhZP3acNJGr06bYnj8L6QYpA5+8yWFUz158/heCJ0uyxNAzY1MSSumfxZnXePbqM/WT0dwiUKHuBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGDnw47/JOtLmdXFq7JJMS0Ge907XQoLOv3btpvITCE=;
 b=zpAMP+l/gwp2Sez6TZCFje+qdxOjm7/BxUezLZ2wCaYoScJjTnqRMrqDaYyAJfxFUCQj4GWF47wsZKFeH3dQFkTqgTS/a9V5ktkT9mGoEbvkSpKC5P+CA9Juns44oZHSyzsDjdDq57tLnSnSsZ2tblDldxUUXGyNuo7cFm/ypX4=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB7070.namprd04.prod.outlook.com (2603:10b6:208:1e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 17 Feb
 2021 23:09:39 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3846.042; Wed, 17 Feb 2021
 23:09:39 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block driver changes for 5.12-rc
Thread-Topic: [GIT PULL] Block driver changes for 5.12-rc
Thread-Index: AQHXBYD93/cIg6VIAkeeOLqTAW0FtQ==
Date:   Wed, 17 Feb 2021 23:09:39 +0000
Message-ID: <BL0PR04MB65148E7A098A395694E93EDFE7869@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <2026e767-054e-00ba-46bd-716eb827a600@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:75c0:49b:2210:beaf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19bcebda-02a2-4737-47ed-08d8d3991a2c
x-ms-traffictypediagnostic: MN2PR04MB7070:
x-microsoft-antispam-prvs: <MN2PR04MB70702FE402D594EA254BBA46E7869@MN2PR04MB7070.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DMUuvEBSz/D4sjN1c4G8wLbjcPE5OPw1KH5cnBFwOxoaQ/64pJbjz/yaXx+dtOA6PFyF1LeQclBNr/qQsunBhwk1jsorXCBhn+QlSig/dDsmwt8NJVVj6z2c7cMw11o3z0tFzatODUbP7HP1c8eFeSXlzDjweFRYYzgCM89E162CYbMGOcOOau0o5hXRGJwQs2adMpUJBPz7UMAiTUJjHrIBpTiH1dslEv/CIK1pQ8D+BMlDLRf6zLxuEsoab26jkgSZKjdvDufDOEb6nAfAYdM9l2EvvR54Zsl+s65+gF3NXOkua59+nu1tsueP73/LbGfFa5uNNp7B3VjTnx5p1jgrRAyRzZWsSY/c2vUrhBZIjSwqpDFDljX1UAHsfl0/ONyXs48vM2ANQRCmzxUTdwl7VkHJ04SCUqxJSDEtPW+lU5bk/uBKzcic7fBuoWE8u64pjNIiaa53NfcnEBSRYyNkW5z7qtsOhPJGL5+3rk9NuISsf97yPb1eFMukh/d3tZ10u65Sg5hDcoHTN9zry7yQwBZNHH5KOcpWYKxsr0MyIpIU5aozo8yOwRouDPjh7bzUyndUF9YoRIDCAblMx7CMumsvoIhSrBd4Z2tAbM0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(66476007)(66446008)(76116006)(71200400001)(478600001)(91956017)(53546011)(33656002)(66946007)(52536014)(9686003)(66556008)(4326008)(8676002)(64756008)(6506007)(83380400001)(86362001)(2906002)(7696005)(110136005)(186003)(5660300002)(8936002)(55016002)(966005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?km34IAJmAmb6U7K7VTeZXS0qERLFYX/27MsPOCzbefLwxP7qovPdqpUKCQWi?=
 =?us-ascii?Q?Eih6r4IPiPXYDYbDpr/WtCHUk64Go5FLKXoExK1PnUsPBkYzPmtl+u73xeFs?=
 =?us-ascii?Q?BLqQcnmmZ6Y/FvdJjl+q6iR0bAx0IiV7oNSEP3/UddGgAOIllzPFMsizk9OC?=
 =?us-ascii?Q?/9CWicgasiIEk5vNt4hIlit7leSpiNKPxAoZj4MS4AEdEXdOxz4XJhwywu0d?=
 =?us-ascii?Q?v4ssJDD0L/Wn/EP8xWLkGtLNgAm9WXcBPcSuSqO7e/vIpwd7GRkcebepDKvN?=
 =?us-ascii?Q?hMj3+k7Z95OqXjohJGvK/TYPZYyvXh7z7XMnP9u7eCIE3OXGiUetENKgyvt0?=
 =?us-ascii?Q?9j7w5OJ4KbdyyFo6G25K6riHvMkXbFsMHfdMKgXGbHVgmEdnZcEb+F3sso/M?=
 =?us-ascii?Q?MaL4WP0IjoszfwGGz01CkKIZjbIW7ha+3UgrpNz8CkJHYz+4NwgAkddvGd00?=
 =?us-ascii?Q?lnvXMZoglEJeTBRTMSaOLgxm/SrESVHQXP96YIWN5YyLl6COmzi7Mkk0FIR4?=
 =?us-ascii?Q?504iIKQvCwbAp3/uIEYlVBMeLmjS3fJhtQaxwwjvf05dVvkHr7AIWVfW+N+l?=
 =?us-ascii?Q?85VjPPQ6O6UNjmYpP8n2STXeBUQcMfRf0NShZO0pNDI0D8yQ7hbDFJqoGGwD?=
 =?us-ascii?Q?8/KwX4+y1M9fm5qS3UjUsq73p0ifH4NAAXM5oy2uUxwKyK2BVFERG3UB8w+v?=
 =?us-ascii?Q?Raeuv2QboPCi+JIh6rehKmZIL9ePrYF5OD9RPKbqxrywPzalo+/dYAoTkBza?=
 =?us-ascii?Q?LZ0nHO7thPaEC8WUJ+ajdtl3z3Adojix8s30TW219Hgd1UAR9Mnzj8lyWdXE?=
 =?us-ascii?Q?MReO6EfwGD8trcMqt9/pQ1+6YKL7WHqIjHFiueDq5qjd/4IPOYUSlymE/vxI?=
 =?us-ascii?Q?L1yryGsqBjLJ1ONBqGdQIyQB7Wf+cSdVvDsroN1srmQFumM5fMngpOoh1IE+?=
 =?us-ascii?Q?TZRMncnYRCgHJxjQ7xn1fWRjov5gh+Gtc/N0HIg8r6LhIWxHVEvD2cbZdHry?=
 =?us-ascii?Q?V43tC99sdpHpYvEJFjEbf4SuuriRai+V/aSJ0Go3d/R92b/PqsCG8AS2ROYs?=
 =?us-ascii?Q?waK3W35FP0kjNZAszaTFNE/AIVvBsmoCnL77w/aqV6UBanBcBJewaEJ7YIhi?=
 =?us-ascii?Q?2WXjaMPte1tndzy2icS7n8G0SwEJ3oPFxgwfwIwaO8dpVS4yn2pWTp98XJdU?=
 =?us-ascii?Q?SBGp772usb9/xy671wYdLQoy0NxMwf7h7v3BlpvJcYMSZfCZWOYflz1x3cTl?=
 =?us-ascii?Q?u2ZzI7gVexqDN92yxJgok9Al7asHEq8I1Kb2/SwRzhP8xSyxK2Rk95hyAIs2?=
 =?us-ascii?Q?XG3Kg0aJy60gd3eNMM1zx0iAiStekCrn++z1cagGqEZKnpkQOajcaDA5X/HI?=
 =?us-ascii?Q?4Rdbe8bn0vPrEGztRtXFKjbtrLCX+w3wRYb7VX8DshVyZzMynw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bcebda-02a2-4737-47ed-08d8d3991a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2021 23:09:39.5123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ot4urARIuSQfrYGWoQ5I1e9l3AnkGAB1GRNAA3prQNC6W4J4ijU2g3dZ56IWvn44TK7z1VnpT6kRgeP8WX9nig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7070
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/18 8:02, Jens Axboe wrote:=0A=
> Hi Linus,=0A=
> =0A=
> On top of the core block branch, here are the 5.12 driver changes. This=
=0A=
> pull request contains:=0A=
> =0A=
> - Removal of the skd driver. It's been EOL for a long time (Damien)=0A=
=0A=
Jens,=0A=
=0A=
Looks like this PR is missing the patch to revert commit 0fe37724f8e7 ("blo=
ck:=0A=
fix bd_size_lock use"). Will you send it later ?=0A=
=0A=
=0A=
> =0A=
> - NVMe pull requests=0A=
> 	- fix multipath handling of ->queue_rq errors (Chao Leng)=0A=
> 	- nvmet cleanups (Chaitanya Kulkarni)=0A=
> 	- add a quirk for buggy Amazon controller (Filippo Sironi)=0A=
> 	- avoid devm allocations in nvme-hwmon that don't interact well with=0A=
> 	  fabrics (Hannes Reinecke)=0A=
> 	- sysfs cleanups (Jiapeng Chong)=0A=
> 	- fix nr_zones for multipath (Keith Busch)=0A=
> 	- nvme-tcp crash fix for no-data commands (Sagi Grimberg)=0A=
> 	- nvmet-tcp fixes (Sagi Grimberg)=0A=
> 	- add a missing __rcu annotation (Christoph)=0A=
> 	- failed reconnect fixes (Chao Leng)=0A=
> 	- various tracing improvements (Michal Krakowiak, Johannes Thumshirn)=0A=
> 	- switch the nvmet-fc assoc_list to use RCU protection (Leonid Ravich)=
=0A=
> 	- resync the status codes with the latest spec (Max Gurtovoy)=0A=
> 	- minor nvme-tcp improvements (Sagi Grimberg)=0A=
> 	- various cleanups (Rikard Falkeborn, Minwoo Im, Chaitanya Kulkarni,=0A=
> 	  Israel Rukshin)=0A=
> =0A=
> - Floppy O_NDELAY fix (Denis)=0A=
> =0A=
> - MD pull request=0A=
> 	- raid5 chunk_sectors fix (Guoqing)=0A=
> =0A=
> - Use lore links (Kees)=0A=
> =0A=
> - Use DEFINE_SHOW_ATTRIBUTE for nbd (Liao)=0A=
> =0A=
> - loop lock scaling (Pavel)=0A=
> =0A=
> - mtip32xx PCI fixes (Bjorn)=0A=
> =0A=
> - bcache fixes (Kai, Dongdong)=0A=
> =0A=
> - Misc fixes (Tian, Yang, Guoqing, Joe, Andy)=0A=
> =0A=
> Note that this throws a trivial merge conflict with master, due to a=0A=
> late addition to the quirk list in the 5.11 series.=0A=
> =0A=
> Please pull!=0A=
> =0A=
> =0A=
> The following changes since commit 767630c63bb23acf022adb265574996ca39a46=
45:=0A=
> =0A=
>   bdev: Do not return EBUSY if bdev discard races with write (2021-01-26 =
10:22:18 -0700)=0A=
> =0A=
> are available in the Git repository at:=0A=
> =0A=
>   git://git.kernel.dk/linux-block.git tags/for-5.12/drivers-2021-02-17=0A=
> =0A=
> for you to fetch changes up to f4b64ae6745177642cd9610cfd7df0041e7fca58:=
=0A=
> =0A=
>   lightnvm: pblk: Replace guid_copy() with export_guid()/import_guid() (2=
021-02-14 21:27:24 -0700)=0A=
> =0A=
> ----------------------------------------------------------------=0A=
> for-5.12/drivers-2021-02-17=0A=
> =0A=
> ----------------------------------------------------------------=0A=
> Andy Shevchenko (1):=0A=
>       lightnvm: pblk: Replace guid_copy() with export_guid()/import_guid(=
)=0A=
> =0A=
> Bjorn Helgaas (2):=0A=
>       mtip32xx: use PCI #defines instead of numbers=0A=
>       mtip32xx: prefer pcie_capability_read_word()=0A=
> =0A=
> Chaitanya Kulkarni (15):=0A=
>       nvmet: remove extra variable in smart log nsid=0A=
>       nvmet: remove extra variable in id-desclist=0A=
>       nvmet: remove extra variable in identify ns=0A=
>       nvmet: add lba to sect conversion helpers=0A=
>       nvme-core: get rid of the extra space=0A=
>       nvmet: set status to 0 in case for invalid nsid=0A=
>       nvmet: return uniform error for invalid ns=0A=
>       nvmet: make nvmet_find_namespace() req based=0A=
>       nvmet: remove extra variable in id-ns handler=0A=
>       nvmet: add helper to report invalid opcode=0A=
>       nvmet: use invalid cmd opcode helper=0A=
>       nvmet: use invalid cmd opcode helper=0A=
>       nvmet: use min of device_path and disk len=0A=
>       nvmet: add nvmet_req_subsys() helper=0A=
>       nvmet: remove else at the end of the function=0A=
> =0A=
> Chao Leng (9):=0A=
>       nvme-core: add cancel tagset helpers=0A=
>       nvme-rdma: add clean action for failed reconnection=0A=
>       nvme-tcp: add clean action for failed reconnection=0A=
>       nvme-rdma: use cancel tagset helper for tear down=0A=
>       nvme-tcp: use cancel tagset helper for tear down=0A=
>       blk-mq: introduce blk_mq_set_request_complete=0A=
>       nvme: introduce a nvme_host_path_error helper=0A=
>       nvme-fabrics: avoid double completions in nvmf_fail_nonready_comman=
d=0A=
>       nvme-rdma: handle nvme_rdma_post_send failures better=0A=
> =0A=
> Christoph Hellwig (1):=0A=
>       nvmet-fc: add a missing __rcu annotation to nvmet_fc_tgt_assoc.queu=
es=0A=
> =0A=
> Damien Le Moal (1):=0A=
>       block: remove skd driver=0A=
> =0A=
> Filippo Sironi (1):=0A=
>       nvme: add 48-bit DMA address quirk for Amazon NVMe controllers=0A=
> =0A=
> Guoqing Jiang (2):=0A=
>       drbd: remove unused argument from drbd_request_prepare and __drbd_m=
ake_request=0A=
>       md/raid5: cast chunk_sectors to sector_t value=0A=
> =0A=
> Hannes Reinecke (1):=0A=
>       nvme-hwmon: rework to avoid devm allocation=0A=
> =0A=
> Israel Rukshin (2):=0A=
>       nvmet: Use nvmet_is_port_enabled helper for pi_enable=0A=
>       nvmet: Fix nvmet_is_port_enabled indentation=0A=
> =0A=
> Jens Axboe (4):=0A=
>       Merge tag 'nvme-5.21-2020-02-02' of git://git.infradead.org/nvme in=
to for-5.12/drivers=0A=
>       Merge tag 'floppy-for-5.12' of https://github.com/evdenis/linux-flo=
ppy into for-5.12/drivers=0A=
>       Merge branch 'md-next' of https://git.kernel.org/.../song/md into f=
or-5.12/drivers=0A=
>       Merge tag 'nvme-5.12-2021-02-11' of git://git.infradead.org/nvme in=
to for-5.12/drivers=0A=
> =0A=
> Jiapeng Chong (1):=0A=
>       nvme: convert sysfs sprintf/snprintf family to sysfs_emit=0A=
> =0A=
> Jiri Kosina (1):=0A=
>       floppy: reintroduce O_NDELAY fix=0A=
> =0A=
> Joe Perches (2):=0A=
>       drbd: Avoid comma separated statements=0A=
>       bcache: Avoid comma separated statements=0A=
> =0A=
> Johannes Thumshirn (1):=0A=
>       nvme: add tracing of zns commands=0A=
> =0A=
> Kai Krakow (4):=0A=
>       bcache: Fix register_device_aync typo=0A=
>       Revert "bcache: Kill btree_io_wq"=0A=
>       bcache: Give btree_io_wq correct semantics again=0A=
>       bcache: Move journal work to new flush wq=0A=
> =0A=
> Kees Cook (1):=0A=
>       block: Replace lkml.org links with lore=0A=
> =0A=
> Keith Busch (1):=0A=
>       nvme-multipath: set nr_zones for zoned namespaces=0A=
> =0A=
> Leonid Ravich (1):=0A=
>       nvmet-fc: use RCU proctection for assoc_list=0A=
> =0A=
> Liao Pingfang (1):=0A=
>       nbd: Convert to DEFINE_SHOW_ATTRIBUTE=0A=
> =0A=
> Max Gurtovoy (1):=0A=
>       nvme: update enumerations for status codes=0A=
> =0A=
> Michal Krakowiak (1):=0A=
>       nvme: parse format nvm command details when tracing=0A=
> =0A=
> Minwoo Im (2):=0A=
>       nvme: support command retry delay for admin command=0A=
>       nvme: refactor ns->ctrl by request=0A=
> =0A=
> Pavel Tatashin (1):=0A=
>       loop: scale loop device by introducing per device lock=0A=
> =0A=
> Rikard Falkeborn (1):=0A=
>       nvme: constify static attribute_group structs=0A=
> =0A=
> Sagi Grimberg (6):=0A=
>       nvme-tcp: fix wrong setting of request iov_iter=0A=
>       nvme-tcp: get rid of unused helper function=0A=
>       nvme-tcp: pass multipage bvec to request iov_iter=0A=
>       nvmet-tcp: fix receive data digest calculation for multiple h2cdata=
 PDUs=0A=
>       nvmet-tcp: fix potential race of tcp socket closing accept_work=0A=
>       nvme-tcp: fix crash triggered with a dataless request submission=0A=
> =0A=
> Tian Tao (2):=0A=
>       zram: fix NULL check before some freeing functions is not needed=0A=
>       lightnvm: fix unnecessary NULL check warnings=0A=
> =0A=
> Yang Li (1):=0A=
>       rsxx: remove redundant NULL check=0A=
> =0A=
> dongdong tao (1):=0A=
>       bcache: consider the fragmentation when update the writeback rate=
=0A=
> =0A=
>  MAINTAINERS                        |    6 -=0A=
>  drivers/block/Kconfig              |   10 -=0A=
>  drivers/block/Makefile             |    2 -=0A=
>  drivers/block/aoe/aoecmd.c         |    2 +-=0A=
>  drivers/block/drbd/drbd_int.h      |    2 +-=0A=
>  drivers/block/drbd/drbd_main.c     |    3 +-=0A=
>  drivers/block/drbd/drbd_receiver.c |    6 +-=0A=
>  drivers/block/drbd/drbd_req.c      |   11 +-=0A=
>  drivers/block/floppy.c             |   30 +-=0A=
>  drivers/block/loop.c               |   93 +-=0A=
>  drivers/block/loop.h               |    1 +=0A=
>  drivers/block/mtip32xx/mtip32xx.c  |   15 +-=0A=
>  drivers/block/nbd.c                |   28 +-=0A=
>  drivers/block/rsxx/dma.c           |    3 +-=0A=
>  drivers/block/skd_main.c           | 3670 ------------------------------=
------=0A=
>  drivers/block/skd_s1120.h          |  322 ----=0A=
>  drivers/block/zram/zram_drv.c      |    3 +-=0A=
>  drivers/lightnvm/pblk-core.c       |    5 +-=0A=
>  drivers/lightnvm/pblk-gc.c         |    3 +-=0A=
>  drivers/lightnvm/pblk-recovery.c   |    3 +-=0A=
>  drivers/md/bcache/bcache.h         |    7 +=0A=
>  drivers/md/bcache/bset.c           |   12 +-=0A=
>  drivers/md/bcache/btree.c          |   21 +-=0A=
>  drivers/md/bcache/journal.c        |    4 +-=0A=
>  drivers/md/bcache/super.c          |   24 +-=0A=
>  drivers/md/bcache/sysfs.c          |   29 +-=0A=
>  drivers/md/bcache/writeback.c      |   42 +=0A=
>  drivers/md/bcache/writeback.h      |    4 +=0A=
>  drivers/md/raid5.c                 |    2 +-=0A=
>  drivers/nvme/host/core.c           |   63 +-=0A=
>  drivers/nvme/host/fabrics.c        |    6 +-=0A=
>  drivers/nvme/host/fc.c             |    2 +-=0A=
>  drivers/nvme/host/hwmon.c          |   31 +-=0A=
>  drivers/nvme/host/multipath.c      |    4 +=0A=
>  drivers/nvme/host/nvme.h           |   17 +=0A=
>  drivers/nvme/host/pci.c            |   21 +-=0A=
>  drivers/nvme/host/rdma.c           |   34 +-=0A=
>  drivers/nvme/host/tcp.c            |   55 +-=0A=
>  drivers/nvme/host/trace.c          |   53 +=0A=
>  drivers/nvme/target/admin-cmd.c    |  114 +-=0A=
>  drivers/nvme/target/configfs.c     |    6 +-=0A=
>  drivers/nvme/target/core.c         |   37 +-=0A=
>  drivers/nvme/target/fc.c           |   83 +-=0A=
>  drivers/nvme/target/fcloop.c       |    2 +-=0A=
>  drivers/nvme/target/io-cmd-bdev.c  |   13 +-=0A=
>  drivers/nvme/target/io-cmd-file.c  |    5 +-=0A=
>  drivers/nvme/target/nvmet.h        |   20 +-=0A=
>  drivers/nvme/target/passthru.c     |    6 +-=0A=
>  drivers/nvme/target/tcp.c          |   59 +-=0A=
>  drivers/nvme/target/trace.h        |    9 +-=0A=
>  include/linux/blk-mq.h             |   12 +=0A=
>  include/linux/nvme.h               |   30 +-=0A=
>  52 files changed, 669 insertions(+), 4376 deletions(-)=0A=
>  delete mode 100644 drivers/block/skd_main.c=0A=
>  delete mode 100644 drivers/block/skd_s1120.h=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
