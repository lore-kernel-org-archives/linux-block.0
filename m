Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE447C433EF
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 00:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7F860F02
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 00:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhJ2A5O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 20:57:14 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:50623 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhJ2A5N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 20:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635468884; x=1667004884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Jogpewzg1FNCD9NkhIivbYtSqMPUk2Xi13MlVidfQzw=;
  b=LRwv3hn0g7l1d7QdKSVnt0syM7mDbhzlJvrPn0eoDh4nhHNsgXZMHrwo
   KJaVfcoT2GsmImiNHW7jw9CuHDE2D3q2uGKwXleahmOXIT5IqjkZyQ4ky
   9+gOkesRs20rzHvGjiNylQDZOWZ98DpvXdKvQWSbVWEcbhoTLzo2+Qjdp
   YAxkLcNYyxcspU0DWGUr+Jr6OahRNN0dcMFRzxb72nF8Ho6mbzSi6TlEH
   9ah1V4K/sRY9SZR9UuQmOIBwcFQrB0RL50VGqvT4QuuBZ1cqcpK84ZRBj
   +FQ1JoPiZx99AHSGMIlA5B1PbN7+PSuBi0W8uE5moEx5Ql22LumDL6uir
   A==;
X-IronPort-AV: E=Sophos;i="5.87,191,1631548800"; 
   d="scan'208";a="184122886"
Received: from mail-bn8nam08lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2021 08:54:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8CcmKwYcpoFW5bIu6HSYUUJRLicT5IVUfdaKt85I6tvX+3IWQyHE4rppDmDte3rk3LOgDrF0O815b5FIuQNNONnKYkK4ByWOFW30f5us9V87xLNZ5DVCnlUhctpqc/y673h2oEn0uCMxBkOPo7T3uGSy2xykV4Bio2H6NqIWBxOmay7EZQqR2ZSTIFTpiYT7yic9+SHEacWqbWmbE4Ssr1GN5nAXs7QqzC1JwjnPfLk/uKBtjzJz5QmaRq9bC9YVbJNe9ORvh8taqb0ZZNJthjVGg/P8JVuoDj7VF7bVp+qRGtM2yqNkNNT9Er1pi2j/v7eIxVs1f4Oiv1VcK09lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cS20N7QQvr74hqaF76F9+dV/9sBkeEMMDfXkwIGC+tk=;
 b=BGC3Pe68c+Z1bBOnbLTl9HM9gfKCBym8N/3B1wp3HXWR7R+HqaIcM06ZwEo85N6rll+P3v6KGUMB7CeE4DHZNcNPM/RFj2rMgf2u1tLuslVFmLjE590c0hU24SUZfFJzr0JPF8gG8g17KMUc8vmmAyZvuB8tqJHkCrrK7J8SKrLqVay9ofd1sY37F0lBq/mCdGgyhgS5TFZfAMWbZrg2MMohbGMrhmI7rAkly8cT/Bz+vbFv+2exdLpivhdnzMKyxAOTyy+5pMoS2HyN1k1I/mIhyu0oitoj05wSD99lYuI6Ki12UOcEjmW+/iJ//w99+TmzcAqcArt6RbCxsgB/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cS20N7QQvr74hqaF76F9+dV/9sBkeEMMDfXkwIGC+tk=;
 b=Xz8B7X9XbBElqKKOK6a502b/mh0gV8jubo9g7rHQPH75d5mdZBhlRVyP1eYCYfH2+wzLl9FVzja1Yt+VvxmKXdr3XsEzqdZKmLpAkr+Q13Kae2KwohnBcMTwTyXrcXvbmqDVnJZvE3ucu9xMKopVsVwAW0k3cedIFY83ad6lElg=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BY5PR04MB6819.namprd04.prod.outlook.com (2603:10b6:a03:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 00:54:43 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61%3]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 00:54:43 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARNING at blktests block/008 in ttwu_queue_wakelist()
Thread-Topic: WARNING at blktests block/008 in ttwu_queue_wakelist()
Thread-Index: AQHXXPwtp5wIJLz/bUO+HXbRCV2UY6sM7DEAgBwKMgCAETyZAICv0ikA
Date:   Fri, 29 Oct 2021 00:54:43 +0000
Message-ID: <20211029005442.fcuzovxuwebxis7p@shindev>
References: <20210609065339.aecrkqc6dj3xgbiw@shindev.dhcp.fujisawa.hgst.com>
 <20210610083200.3832-1-hdanton@sina.com>
 <20210628044346.jo3xzlxhnxuxt7nz@shindev>
 <20210709035704.mvhtxxr6ewootlpz@shindev>
In-Reply-To: <20210709035704.mvhtxxr6ewootlpz@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a66f943-608f-445a-865a-08d99a76b202
x-ms-traffictypediagnostic: BY5PR04MB6819:
x-microsoft-antispam-prvs: <BY5PR04MB681902361FF5DA1A5233787FED879@BY5PR04MB6819.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ohIonK/qHGMvkIUGMHyZd/wn7ULT2ftszpy/Bbgdxa2nUniG9lMPwR/iZ2YmDzfJ5d7cgcXRx54B23HcO6b0jObqVYst5fHUuKm251dAhh3THDhd76BBqqF0ufJgUu3O4pwdazQsKGN79P9j7OHEm6aWXFtdBex0ZaxyaR2cO3YUOYsxBO/BtvGPjXtGYCjddeDcCihRU9lsX/YxcqfPJyFnSFN8GHKhRohnOXop0TwRHP/4HjWev5ZkgklorR6/k39y6+OP05D0qq5FLu/acVB+BrLJQLue4XuoMvnwRhtU5r44hUVhvaf8tesL5fDyZUCs1MxrxWF6M7PM3FVPT3XTeTbYxXUa0lAeUkPZ37DybPtziD4YDkiBcc3o5o43f9vrOM7wEP1qOABDdXhqJ9Nb0U22w1SkXKMwjYf9SOONt+Rniqr6zr8/IlrG9gCE7aKCC5ObepbUfryhZH5LDBLbRSpunGBDsWVbJyvcu6mbIBVm36Qwd2YXDj1miT+QjNVx9Y7vxIP7H+xnKtH2h3eUVkTFpSKOYVpel93bDWPU3k9RA9dsBogtkpUElG6p/pQQ78Zv5dxJqtKfNEZG0YRJlheeKa+RHh3RUxBa//kRRoXxrxWoWtJEkbwM1NVwf7q+K8h8K6XeZQsYNDpXQ9a17zliFTvoYMcTXhPDhaZGEuvVVvG4XZGjg1jPAX9+Y9jFQLJHDoYlkf5Mf9wP1DTGxd4ATvEah4ZocfnOa9XOX8ZGlHJbT1xoS6zQJKes4bi7K4OhmI3qm7PY6r80GNhG08f7PtRU4qzVB2aQ5A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(54906003)(316002)(6916009)(33716001)(122000001)(2906002)(4326008)(8676002)(186003)(38100700002)(6512007)(6506007)(9686003)(86362001)(30864003)(26005)(1076003)(38070700005)(6486002)(71200400001)(966005)(5660300002)(66556008)(83380400001)(66946007)(64756008)(66446008)(76116006)(91956017)(66476007)(508600001)(44832011)(8936002)(45080400002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jiy48rzk5WuZFTS9XrmCJndSe+E0S0xXp/8qU1relf6ip/gfJaEuo8NAoHjz?=
 =?us-ascii?Q?Aknux7X8/cqUFbq5KsWMr91qs9+7H6DmELITkogB/V+y+ExvgD9GD4JN/vVq?=
 =?us-ascii?Q?yrr7uU/6LkrT2AJgaQ4QQqnxLBB0OP5Q6Dij0bQu9jr8yra7ZltxJTnUNKLx?=
 =?us-ascii?Q?o7gN8J9K7YhgQIz3zbs6PjYBRgN9STQFqKZNMhKSOg1NSmmGMuTtQAXZ7bM0?=
 =?us-ascii?Q?rjI0lU9ZXA4SJ3c5q33SAK8q4wGMTD+oHxZ0tRuHAIoTN0UH5XsBINUJEr1M?=
 =?us-ascii?Q?jV2OVSKmPs7b8Zi3UNrotH4EutP21d3QlNpOaUJvft+LbxvYRROAFCqQkXtr?=
 =?us-ascii?Q?xKfQjzwRU7DpBb9h8K9xI44trrtATPpUMJlVZMmLl8mEB3UjB6PQOpQ+rLGh?=
 =?us-ascii?Q?fkr6FQKyIiaePS4X+efaZ/LNpr1sjX02GrzD5RUZ+bCPytbleJPevDMbzPFy?=
 =?us-ascii?Q?1Th1Y2OQiVI5qQeE6yOkojggKLosNqSQ93RCCByXw9vKOmXKpKgcd3YcK7Mr?=
 =?us-ascii?Q?eTb9sLdryru5/lcR4shDVGtgblTs9DfKqppoYV4xRFrcwr/Hvvbg1zcJ9er+?=
 =?us-ascii?Q?9AaoLf4N3JjQie40dLJPrKrIO/5gcl4s+TrkQsVrDyojkt++uHFy6c67AzCO?=
 =?us-ascii?Q?WXGOB04nWyMGMsk5BiE9mcVVxIv8QB+zsFAtwWWHEdgCkDHKsuUAZwoglg3N?=
 =?us-ascii?Q?rBXXda/YIu+8vI4EDNTfI0I60//zxSK9zQW/ujB2mSaQ58mqZ4D34jmnKnGU?=
 =?us-ascii?Q?NUbRwwAEciq9DaEbDtGgloqbqTrHeNj79zO09TnkeqLcOYi9badbgyssXHDR?=
 =?us-ascii?Q?J40pGRBP+w4MrtN7Rg4hiEXcN2Kz5vitfkH7xfKIyu3tL7IC+x9+qEAlnOIO?=
 =?us-ascii?Q?AQsJwP9wYZNX6g1fMfx96ORlBJUk6iyjwn3seOTPRDnOM743WXLJa/zHIDpu?=
 =?us-ascii?Q?x8dXn0iZ2GbbKKSbTVArLFV1KLgGaE/PeunSzX+JuJCuvX5XTbYAejAPm3tU?=
 =?us-ascii?Q?T9D1DDANeZquqnxEw12Jp2y2GqV4a8c54LNQOG6dyku1uxTVNwypOAT9SCVE?=
 =?us-ascii?Q?ORhFBsdYG7nGOcW4Y33w3QviS3t/ADvSL3KZ1YIjGByOXPkFt7YRgr6saPkj?=
 =?us-ascii?Q?JI4h+IvH3zUFgOAMk1eBe/2Ru6EYGghbBjUp+T4I2yBLYCu3BwJErCCb1/eV?=
 =?us-ascii?Q?P4AzXpbA9ogZbjCZNmHyBw1Yy5UFVQiS0N/9VxNVzddH6CdE2dDrCTwYdgPx?=
 =?us-ascii?Q?YSD9dKs39IbOCUyb5G2l1aX0mZe6wFZyxuv8VuKB/b+GvnpnmneVRdFuCdiP?=
 =?us-ascii?Q?6cc6WE36Hglz5CHAla6qOBliDE7ho5YlLxSoPcavWgLwIemJ1Gb0xWDiUnHH?=
 =?us-ascii?Q?iEvdazQjsJBiVOje6W1DGcQK2eM8vTo/tDZkwfsqNGMFjx5vBBDdSMfzSdOx?=
 =?us-ascii?Q?qq4a/MTADNBsqrHgvS4qAkdWTat58UjNZ+9X+uje04XzJMnqchQ818TCm1p+?=
 =?us-ascii?Q?YPEKLZNNNGUPjd68L8XNusHNMaKKq0kzDdPLg/t3bJsDk/B6OR5KSxTGqN8r?=
 =?us-ascii?Q?VWt2Lr5jx4iCuXlrhY1PGVFgA/5nRt1gPPXU8YnjT4JO+hoh6jr2TPCNVad+?=
 =?us-ascii?Q?Ny088XRjfbzzNXfU/46xmaAuNdUP9pXEeHt84vtozFeURDSSWYXkXXNu5hGk?=
 =?us-ascii?Q?joc7OhUMy58cCW7DeLYt9E1Dzy8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B0039FADC176F1468B32CA092440A5A6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a66f943-608f-445a-865a-08d99a76b202
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 00:54:43.1898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvwTDDHkC39sdQa258xkQZse5CuP3+N0JcKQWmvfEB3K/oG41EnMmv/K7jttzM+1jcjJfZcFMfITh2haQhi9pxg7HIqKdod86Wbcp59Crbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6819
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The WARNING I reported with the kernel v5.13-rc5 is still observed with
v5.15-rc7. It took long, but now I think I understand the cause. Here I sha=
re my
findings in line.

On Jul 09, 2021 / 03:57, Shinichiro Kawasaki wrote:
> On Jun 28, 2021 / 13:43, Shin'ichiro Kawasaki wrote:
> > On Jun 10, 2021 / 16:32, Hillf Danton wrote:
> > > On Wed, 9 Jun 2021 06:55:59 +0000 Damien Le Moal wrote:
> > > >+ Jens and linux-kernel
> > > >
> > > >On 2021/06/09 15:53, Shinichiro Kawasaki wrote:
> > > >> Hi there,
> > > >>=20
> > > >> Let me share a blktests failure. When I ran blktests on the kernel=
 v5.13-rc5,
> > > >> block/008 failed. A WARNING below was the cause of the failure.
> > > >>=20
> > > >>     WARNING: CPU: 1 PID: 135817 at kernel/sched/core.c:3175 ttwu_q=
ueue_wakelist+0x284/0x2f0
> > > >>=20
> > > >> I'm trying to recreate the failure repeating the test case, but so=
 far, I am
> > > >> not able to. This failure looks rare, but actually, I observed it =
3 times in
> > > >> the past one year.
> > > >>=20
> > > >> 1) Oct/2020, kernel: v5.9-rc7  test dev: dm-flakey on AHCI-SATA SM=
R HDD, log [1]
> > > >> 2) Mar/2021, kernel: v5.12-rc2 test dev: AHCI-SATA SMR HDD, log [2=
]
> > > >> 3) Jun/2021, kernel: v5.13-rc5 test dev: dm-linear on null_blk zon=
ed, log [3]
> > > >>=20
> > > >> The test case block/008 does IO during CPU hotplug, and the WARNIN=
G in
> > > >> ttwu_queue_wakelist() checks "WARN_ON_ONCE(cpu =3D=3D smp_processo=
r_id())".
> > > >> So it is likely that the test case triggers the warning, but I don=
't have
> > > >> clear view why and how the warning was triggered. It was observed =
on various
> > > >> block devices, so I would like to ask linux-block experts if anyon=
e can tell
> > > >> what is going on. Comments will be appreciated.
> > >=20
> > > [...]
> > >=20
> > > >> [40041.712804][T135817] ------------[ cut here ]------------
> > > >> [40041.718489][T135817] WARNING: CPU: 1 PID: 135817 at kernel/sche=
d/core.=3D
> > > >c:3175 ttwu_queue_wakelist+0x284/0x2f0
> > > >> [40041.728311][T135817] Modules linked in: null_blk dm_flakey iscs=
i_targe=3D
> > > >t_mod tcm_loop target_core_pscsi target_core_file target_core_iblock=
 nft_fi=3D
> > > >b_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_i=
pv4 nf_=3D
> > > >reject_ipv6 nft_reject nft_ct nft_chain_nat ip6table_nat ip6table_ma=
ngle ip=3D
> > > >6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defr=
ag_ipv6=3D
> > > > nf_defrag_ipv4 iptable_mangle iptable_raw bridge iptable_security s=
tp llc =3D
> > > >ip_set rfkill nf_tables target_core_user target_core_mod nfnetlink i=
p6table=3D
> > > >_filter ip6_tables iptable_filter sunrpc intel_rapl_msr intel_rapl_c=
ommon x=3D
> > > >86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypas=
s iTCO_=3D
> > > >wdt intel_pmc_bxt iTCO_vendor_support rapl intel_cstate intel_uncore=
 joydev=3D
> > > > lpc_ich i2c_i801 i2c_smbus ses enclosure mei_me mei ipmi_ssif ioatd=
ma wmi =3D
> > > >acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter acpi=
_pad zr=3D
> > > >am ip_tables ast drm_vram_helper drm_kms_helper syscopyarea sysfillr=
ect crc=3D
> > > >32c_intel sysimgblt
> > > >> [40041.728481][T135817]  fb_sys_fops cec drm_ttm_helper ttm ghash_=
clmulni=3D
> > > >_intel drm igb mpt3sas nvme dca i2c_algo_bit nvme_core raid_class sc=
si_tran=3D
> > > >sport_sas pkcs8_key_parser [last unloaded: null_blk]
> > > >> [40041.832215][T135817] CPU: 1 PID: 135817 Comm: fio Not tainted 5=
.13.0-r=3D
> > > >c5+ #1
> > > >> [40041.839262][T135817] Hardware name: Supermicro Super Server/X10=
SRL-F, =3D
> > > >BIOS 3.2 11/22/2019
> > > >> [40041.847434][T135817] RIP: 0010:ttwu_queue_wakelist+0x284/0x2f0
> > > >> [40041.853266][T135817] Code: 34 24 e8 6f 71 64 00 4c 8b 44 24 10 =
48 8b 4=3D
> > > >c 24 08 8b 34 24 e9 a1 fe ff ff e8 a8 71 64 00 e9 66 ff ff ff e8 be =
71 64 0=3D
> > > >0 eb a0 <0f> 0b 45 31 ff e9 cb fe ff ff 48 89 04 24 e8 49 71 64 00 4=
8 8b 04=3D
> > > >
> > > >> [40041.872793][T135817] RSP: 0018:ffff888106bff348 EFLAGS: 0001004=
6
> > > >> [40041.878800][T135817] RAX: 0000000000000001 RBX: ffff888117ec324=
0 RCX: =3D
> > > >ffff888811440000
> > > >> [40041.886711][T135817] RDX: 0000000000000000 RSI: 000000000000000=
1 RDI: =3D
> > > >ffffffffb603d6e8
> > > >> [40041.894625][T135817] RBP: 0000000000000001 R08: ffffffffb603d6e=
8 R09: =3D
> > > >ffffffffb6ba6167
> > > >> [40041.902537][T135817] R10: fffffbfff6d74c2c R11: 000000000000000=
1 R12: =3D
> > > >0000000000000000
> > > >> [40041.910451][T135817] R13: ffff88881145fd00 R14: 000000000000000=
1 R15: =3D
> > > >ffff888811440001
> > > >> [40041.918364][T135817] FS:  00007f8eabf14b80(0000) GS:ffff8888114=
40000(0=3D
> > > >000) knlGS:0000000000000000
> > > >> [40041.927229][T135817] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033=3D
> > > >
> > > >> [40041.933756][T135817] CR2: 000055ce81e2cc78 CR3: 000000011be9200=
5 CR4: =3D
> > > >00000000001706e0
> > > >> [40041.941669][T135817] Call Trace:
> > > >> [40041.944895][T135817]  ? lock_is_held_type+0x98/0x110
> > > >> [40041.949860][T135817]  try_to_wake_up+0x6f9/0x15e0
> > >=20
> > > 2) __queue_work
> > >      raw_spin_lock(&pwq->pool->lock) with irq disabled
> > >      insert_work
> > >        wake_up_worker(pool);
> > >          wake_up_process first_idle_worker(pool);
> > >=20
> > > Even if waker is lucky enough running on worker's CPU, what is weird =
is an
> > > idle worker can trigger the warning, given
> > >=20
> > > 	if (smp_load_acquire(&p->on_cpu) &&
> > > 	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
> > > 		goto unlock;
> > >=20
> > > because p->on_cpu must have been false for quite a while.

The call trace indicated that the try_to_wake_up() called ttwu_queue_wakeli=
st().
So I had assumed that the ttwu_queue_wakelist() call was in the hunk that H=
illf
quoted above. I also had thorugh that weird, but I noticed that there is an=
other
path to call ttwu_queue_wakelist(). try_to_wake_up() calls ttwu_queue() at
another place, and ttwu_queue() calls ttwu_queue_wakelist(). I confirmed th=
at
the warning is reported with this call path. I think this path can happen o=
n
p->cpu false condition.

> > >=20
> > > Is there any chance for CPU hotplug to make a difference?

I found sd_llc_id change by CPU hotplug affects ttwu_queue_wakelist(). When=
 the
warning is reported, ttwu_queue_cond() returns true in the ttwu_queue_wakel=
ist()
hunk below.

	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
		if (WARN_ON_ONCE(cpu =3D=3D smp_processor_id()))
			return false;

And in ttwu_queue_cond() hunk below, cpus_share_cache() returns false, even
though smp_processor_id() and cpu are same cpu. This is weird. Why the sing=
le
same cpu does not share the cache?

	/*
	 * If the CPU does not share cache, then queue the task on the
	 * remote rqs wakelist to avoid accessing remote data.
	 */
	if (!cpus_share_cache(smp_processor_id(), cpu))
		return true;

In cpus_share_cache(), sd_llc_id is checked twice with the line below.

	return per_cpu(sd_llc_id, this_cpu) =3D=3D per_cpu(sd_llc_id, that_cpu);

When this_cpu =3D=3D that_cpu, it is expected sd_llc_id is same. However, w=
hen CPU
hotplug is ongoing, scheduler domain destroy and rebuild happens and modifi=
es
sd_llc_id value. Then, the two sd_llc_id references in the code can have
different values.

I think this cpus_share_cached() needs a fix assuming that sd_llc_id may
change. My idea is to add check this_cpu =3D=3D that_cpu. Based on this ide=
a, I
created a fix and the warning is avoided. I will post the patch for further
discussion and review.

--=20
Best Regards,
Shin'ichiro Kawasaki

> > >=20
> > > Thoughts are welcome.
> > >=20
> > > Hillf
> >=20
> > Hillf, thank you very much for the comments, and sorry about this late =
reply.
> >=20
> > I walked through related functions to understand your comments and, but=
 I have
> > to say that I still don't have enough background knowledge to provide v=
aluable
> > comments back to you. I understand that the waker and the wakee are on =
same CPU,
> > and it is weird that p->on_cpu is true. This looks indicating that the =
task
> > scheduler failing to control task status on task migration triggered by=
 CPU
> > hotplugs, but as far as I read comments in kernel/sched/core.c, CPU hot=
plug and
> > task migration are folded into the design and implementation.
> >=20
> > The blktests test case block/008 runs I/Os to a test target block devic=
e 30
> > seconds. During this I/O, it repeats offlining CPUs and onlining CPUs: =
when
> > there are N CPUs are available, it offlines N-1 CPUs to have only one o=
nline
> > CPU, then onlines all CPUs again. It repeats this online and offline un=
til I/O
> > workload completes. When the only one CPU is online, the waker and the =
wakee can
> > be on the same CPU. Or, one of the waker or the wakee might have been m=
igrated
> > from other CPUs to the only one online CPU. But still it is not clear f=
or me why
> > it results in the WARNING.
> >=20
> > Now I'm trying to recreate the failure. By repeating test cases in "blo=
ck
> > group" on the kernel v5.13-rc5, I was able to recreate the failure. It =
took 3 to
> > 5 hours to recreate it. The test target block device used was a null_bl=
k with
> > rather unique configuration (zoned device with zone capacity smaller th=
an zone
> > size). I will try to confirm the failure recreation with latest kernel =
version
> > and other block devices.
>=20
> I tried some device setups, and found that dm-linear device on null_blk
> recreates the warning  consistently. In case anyone wishes to recreate it=
, let
> me share the bash script below which I used. I tried it several times on =
the
> kernel v5.13, and all tries recreated the warning. With my system (nproc =
is 8),
> it took from 3 to 6 hours to recreate.
>=20
> -------------------------------------------------------------------------=
-------
> #!/bin/bash
>=20
> # create a null_blk device
> declare sysfs=3D/sys/kernel/config/nullb/nullb0
> modprobe null_blk nr_devices=3D0
> mkdir "${sysfs}"
> echo 1024 > "${sysfs}"/size
> echo 1 > "${sysfs}"/memory_backed
> echo 1 > "${sysfs}"/power
> sleep 1
>=20
> # create a dm-linear device on the null_blk device
> echo "0 $((0x2000 * 4)) linear /dev/nullb0 0" | dmsetup create test
> sleep 1
>=20
> # run blktests, block/008 many times
> git clone https://github.com/osandov/blktests.git
> cd blktests
> echo "TEST_DEVS=3D( /dev/mapper/test )" > config
> for ((i=3D0;i<1000;i++)); do
>         echo $i;
>         if ! ./check block/008; then
>                 break;
>         fi
> done
>=20
> --=20
> Best Regards,
> Shin'ichiro Kawasaki=
