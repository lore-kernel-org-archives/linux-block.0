Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CD0C77B7A
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 04:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjEREOR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 00:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEREOQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 00:14:16 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C8D35AE
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 21:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684383254; x=1715919254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pFDFKu0TdHE7pC/vvgDBPdOSfqfRUhMBYTQI/bwtVNI=;
  b=JdJu9DqE978q1B3VsjnXgTgNMCy2ai+izbWu6HCFlYxKdY8vHb6M48mP
   Qu4Q1+Aif6bbe7FeefqrTuoYFzOIh8a6gQf4AOs2faV1RrxtVAIqBuLNR
   iuFxIfX4ev85ROvkAtxGSTHQCdOqASJEWoNmWdWmoD7fLriod+XlDqx17
   ecBxFU7SGsCFPMZqaUc184pJn7jpAOWEQDAFObrH1Ibkzl9Z09cmFmsaN
   +674tFkQ1kLEdd+EWo05s5jlTW1HZFUY+VTrJzn2WihA4gfhKvpCFr2JO
   z66QDqtkGgMwtNQBvOKg5rg0bzd2w/4k73hRfP3+LRJ060mYOv9CYmVIJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,284,1677513600"; 
   d="scan'208";a="231085181"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2023 12:14:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9GQI1fIR1MEB39Ih8NAK1eXvj5kivxSSC4zYnDFreDOwS30cjdXZH0haHqaWUk/g0gY4MQD/s81IOihAHf+1Otb1+SnugvfcBj2DuJzV5ZJAx2Xan8hAg8RFh+vbuTtDLFaoGU5V3FEWxFaij55NJGp19F+8oq2ieI0e2mLWFoLBQbHf5AQHAWZ2F3VkwuiJTALC0ikfsZShfg4tTkb3EwRcuIcm1avNrBEVZ+U1PuOoDtfuq2kFDPwkMSzi3aisER8RV3IMd5REn1zTc4e9tNkYefoTsN0wggeTEN2fvfijbrr/MDfahB8HVSoWoFY5YxU36ES3/QxB4Aw9TJklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFDFKu0TdHE7pC/vvgDBPdOSfqfRUhMBYTQI/bwtVNI=;
 b=SbgVrFFrWOfttJnOl+IpuWy9NEKg6gTOPxf4zzG+PWDu1izKaTCoe8o87bSRy2uXBap7iyxnBMjWqLgRn1YK6r07hX7OkSugAWTsOTXewH9SzYCImQqP+vtAnhReqWvE8BKE9gFgjOCInIsY0hWqTMHXma/4q47RuPXf8AvGmfzlvo32hIcJVVowEmveRunRvRNve/iNe0whbmEDiLTaAAhQp2B3xoq6DNsykeyIz091BnJxe3S6a4B4XMhXiJCPEQe0tARhupH307TXDhnV+5SiROT2JVNoGRck1epqYbz4AXIKkhCkuzq+CvA7jGGewowlhGoRcbTsJUgi99ooIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFDFKu0TdHE7pC/vvgDBPdOSfqfRUhMBYTQI/bwtVNI=;
 b=dDbIHEyZmt1ifxjgmbxwDF54ec0Wg4OmBICso051JcFDMZJtGFMaXRp2dj4EvhPDDtfVlVOV80tB+rhocTJyVb8YS63FwpnjC1MOd5Xf7tFeJQGQsp8SMoUXqq1TTynE+R8XqS8DOZp4aQHfv8QpWhn3jL9xtVaBje9C5FQlOCE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8194.namprd04.prod.outlook.com (2603:10b6:610:f9::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19; Thu, 18 May 2023 04:14:10 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 04:14:10 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests] common: Replace _have_module() with
 _have_driver()
Thread-Topic: [PATCH blktests] common: Replace _have_module() with
 _have_driver()
Thread-Index: AQHZgw1eDFNfSeydbUibyURkzZ4XSa9THeoAgAAFb4CAAAFwAIAAj/SAgAvDc4A=
Date:   Thu, 18 May 2023 04:13:51 +0000
Message-ID: <ecrelgmx2fmya57dsc5i6jvwaybnjiw4olllfujkhhjz7wpnni@vtdrlloshkvi>
References: <20230510070207.1501-1-yangx.jy@fujitsu.com>
 <9ac0b861-01a0-9dce-3d2c-5ff9e265c994@nvidia.com>
 <1f2061f8-de32-15cc-818b-56ca0024c5da@fujitsu.com>
 <14ca2b51-6ccf-d3f7-c61a-ad2e8c384448@nvidia.com>
 <cpnmpplrcos4mocwilkwqo4sxuoqw2mimb42p65b7pkn6e6yc6@wvxrnmd6b5cx>
In-Reply-To: <cpnmpplrcos4mocwilkwqo4sxuoqw2mimb42p65b7pkn6e6yc6@wvxrnmd6b5cx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB8194:EE_
x-ms-office365-filtering-correlation-id: 90ab5f76-6c6c-49a8-4347-08db57564962
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QxMuf2f4HiM1YJZuwSDi7i6YKhz6hfJlkpjer7CT2Hrq0jmNh/KeAYVMOG6RtmtHUYL2N0CmlGZrJ4RvOu98n6mQWbIrDyNh997efrEFZLpCZgPX+qRNMzpVd3kyQdkIu2zrMPTSrhkti8GRb66ClYdJXQfwww0v84EHFEpkwrd3uBM+hV4eIEdfhqQX47AxN5UFduuw2XY5fBIRVsMwKf13YFPWHp1rYDmUDn9rYJFaBN7ypTNfBrku27Aoa8TwVqofwiEgnis0k8jcFzHu4pmPIFracii7EfSQO0TX4IcCBLB2XtfskMgP0Jx5sexU+LixuBkw65abnK25Dqjelxu3TiMI6PB5Men7jx0p61/VLkmeP1/XekxKUg0AX718UjgaHifSa2ncsRmvAan9RdpA0JjaSi1VpTuiyHNRrycib3Ds8AyfIoUOiggwMOWY5A74up/u0mhZsEVS1N+cnAdYp6kNmjF/jACeMJypSLNQVI+STY04N6fevjncRTvdTvgH9xXWjjur98fdSoIvuo/NeAM3mwDXJi0BXzYzRTSDOAkB28uMdtflwZiwMP+x7dx0p+BbWDhRzgSJ0C5jC8sGwcuV00gh1O1vXWvlD7OT/Pl13N0x4UvH9bO/9xxtTTyI9xu6kCLYCc/f9BAAZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(8676002)(44832011)(8936002)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(83380400001)(91956017)(316002)(6916009)(2906002)(4326008)(54906003)(5660300002)(478600001)(41300700001)(86362001)(6486002)(82960400001)(38070700005)(38100700002)(6666004)(122000001)(33716001)(71200400001)(6506007)(6512007)(9686003)(26005)(186003)(53546011)(27256005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g1K53RKJie+nPAe/+jrVe4pBr1CMeRfOt6qVuNVMA5N9V6+hvoLg3ozAFA2W?=
 =?us-ascii?Q?08SO+QDWCNyiXh3h+aiBOaKSqlgqLl8BdQ2xeiZNutLNR9inJFE3AzuKVNbP?=
 =?us-ascii?Q?9WRlAD7Ah9XbF3tWJBkDNkP0WDdRryKQviygb8vKx/F++nldaY29qBKtaeTF?=
 =?us-ascii?Q?8EQ9+qgRttbiXkEs2IWyAcTBwaZ/vL993CMC1FYovWTNdp5ggs4eh9MdCXEY?=
 =?us-ascii?Q?HpRH4ajwu6p/sHcllU5zubWsk3lA1EdfSJqzcFbxYY80RLnCPYf4vgEEmD5a?=
 =?us-ascii?Q?5gUgja4s5HsgEK1PKL1AxhrmxAj+3Fbxy0TtpA/p8KNUCKO8y+cPsZlqAuiY?=
 =?us-ascii?Q?0kJUiQY8D8dDMO10zCRqst6nZL6HMMOL9PywAJBPQXw7vJJqzKKY7fEpqfB9?=
 =?us-ascii?Q?9Q07iWKIJ29do1WN++dqvR8YVftPCKtaRGXR3Zphf/6xV/e6L+CqM3D1awbD?=
 =?us-ascii?Q?cwii1ZbWQmwPxAHgPaJmndLLPQoAHRksBI4OaOzGoUdrowOGVlj/LW02C5N6?=
 =?us-ascii?Q?fCfPF0JaF1npEdxCtetUslDVSDNSbWk7EJXVP/5aU5uNCAJGEyTOnoeKVX5s?=
 =?us-ascii?Q?E2s97AQIRhkUYrtyAMrwpxA73c02Y4UJPf+otC0jkvKR1rM/zlw5XEmDHRF5?=
 =?us-ascii?Q?6k0wf3zIYY8MYo/RuVu/Q0OHHOG/7QvMWDqffNDLbuD+6efpc3oqu4WHERf9?=
 =?us-ascii?Q?C/NA4xslvA/thI/thNyOrV+QT3dj+RFIuGeij7U/dsU4MkCOm4rkKY9Xxyaq?=
 =?us-ascii?Q?ZDcq9kjTEx/0aH3yDpriinLwXoCgv17DYKJMifEwqhcfpI1tcTn4KNqOQiiL?=
 =?us-ascii?Q?h+rVUzS6iKbNXaOBHbVDVQjlfPxkqeUnoBliTwWMx1mKu5oYpyZng+xTHLv4?=
 =?us-ascii?Q?BbeRX3WyfdZoRA7w71LVHDVleifmNWHBPrxFqYPP2vvMKMuMBx7JDyrufu3z?=
 =?us-ascii?Q?kfvH/GiE9FQhC1rZBAZrbZ6NV/JzgmyFWRxv+Y5xhMqlA8NpY1SrFos/Puxr?=
 =?us-ascii?Q?+qs870R5cVIEf8RzdSmg6nd4Tjz3o9B7kdMfiCvTC380io1r25fGYu7yt4Cp?=
 =?us-ascii?Q?lVZjihpqRmGegiD9ViV4NpmH4l/Xchd1E/Q8uQqS7m9on+Od4jT2LO2XUAgT?=
 =?us-ascii?Q?sz98xYK9d3Gyx92gIeRldu++NsgfTnHFwm6knKCMW793o/dT/MlY7bdBNuYl?=
 =?us-ascii?Q?vuuLeV8ByJCUeQtMd8eViiaEHjCS2JV9RtWBHhlsOKKfSIs11czQ1PV+9v06?=
 =?us-ascii?Q?EqqlTqGgpczaeWivMI+5OR8k/Ll5jzU08WEPKgcY5vx8E6NuzzKqxSOuwspr?=
 =?us-ascii?Q?AeYoJ7N1yaSQEFaQWLNC8+ZTshb7aOA0AnzUG75pbK+dszchF7iR09yfryo2?=
 =?us-ascii?Q?ehQhF9JLKoxo1GXn3/oFVeLArOczMaqQNW1vfS2bj+ShW2zyJecFICzNfOzC?=
 =?us-ascii?Q?CSaFxkotUbt912QEfIApFqhcw92oYlGCL6nQPUHrvo02Wvsw8lURj5pAqNwO?=
 =?us-ascii?Q?qEwsVpa77SFmsvaKgVgHmWCp0dWJi000dEMXv1LTnalpHClSzDNI9A2vTTCS?=
 =?us-ascii?Q?NEaMKxczY6mXeLwLlZBSwMXLyeUxAdSu/XG3YKhs93QgRXrK6x4PYYzW8peH?=
 =?us-ascii?Q?Fx98D08bcMzBczMd7Sx9JaE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9C37E550590F7438D7F82005A21C8B2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zsQUIQ1RrPcG9DZ3Vy9sCGL1PuphfaS+5JNpjjkBUVX1GjYkkd79iLRdYg/1juepGo77ni7dGp/nYsPGBGUMdKYT5zrhYYXA14T6LaERpIpEdaVOLw2tut1gRJSi4Pcdz4kbGJPULHvKUYeuQsWwFlSlHecjckqO2c5OwSpuHfqwiwMlPa6riIgVaRFgVP8GRcGRs0CiPY3I0/xi4rCZQjEK7+ab0B94PTsUzZGT12tz/X6v6nqcSF3Z6LYANlNnZ7+1wupNkKe1ZHPnbbPGQlb1oCZYg+K+Csj1JplwHoxtx1Fniw4+wdT2EI5f7QMk3n/NRkmS2wh5fmx0n0IRqRI7mh1f78Lbq9VSt2nctqLSw4jMF36eiN9ecLl/fuulCkxL7QS7dQLOOdm/LapmO8trBroT/vgoHPP26Ubl8lb8aXGDJXqqu8h6tSPQKikQdJm1B69zqYBquti4QXpZdh0VkSye6S5DU8XE0Q4betoqXqwTfYdPWaSXrBTCy7424K0BvWzySvgt3lvUFvnVDpS2gkgcnIroaF2LK7Q/htunqz4Z1IYHfhLGp5WC1mYztuMK9gRDAGSNKGQyPkLmS6Q0a+zFZIIAkuAVCwQybAJhlsd/mTwT484gH8N6dgZx2TDbltoGrKB1M23J2xWdgyvcKpmuvMBxAv8y5VMTndaRg/sqZB5f6Iuh22MsE2G/3sUm9f3tNrBiW8g5dSWD/2JlVC4Owoy5S16cJqnx/c4RXmcBp7G5b/pyKf+Kqh0Qp6diOjXQ4IIlkvRFLiky4RB0v6KykKIt6lNLE0aM2wnQNivoqu3aa3WsgMmQrRJ3oL+0XPt84WN7wVhXGMs7ZY0wJJ6GpMWNS2nXtegB8Js=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ab5f76-6c6c-49a8-4347-08db57564962
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 04:13:51.2934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJqVr9VffmreKGYiGZtfFBFIJr5vo7IUzW+e8R+e/4EWZpmrunXjcGBqOhwoGilOWIMVasThYO7LOAax2rfKw7ouyuK1XIFQO1OyOKe8R0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8194
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 10, 2023 / 18:35, Daniel Wagner wrote:
> On Wed, May 10, 2023 at 08:00:12AM +0000, Chaitanya Kulkarni wrote:
> > On 5/10/23 00:55, Xiao Yang (Fujitsu) wrote:
> > > On 2023/5/10 15:35, Chaitanya Kulkarni wrote:
> > >> we might remove nvmeof-mp, so not sure if that part is
> > >> needed, let's wait for others to reply ..
> > > Hi CK,
> > >
> > > Thanks for your feedback.
> > > Could you tell me why nvmeof-mp will be removed? Is there any URL abo=
ut
> > > the decision?
> > >
> > > Best Regards,
> > > Xiao Yang
> >=20
> > We talked about this in the LSFMM, I hope to see lwn article covering
> > blktests session ..

Yes, the conclusion at LSFMM was to remove nvmeof-mp test group, since dm-
multipath for NVME devices is no longer recommended.

Xiao, could you repost your patch to cover only srp?

>=20
> I think a couple of those test might make sense to be migrated to the nvm=
e
> suite. I am thinking about the test with simulate_network_failure_loop.

It does not sound reasonable to keep dm-multipath tests in nvme group. I gu=
ess
you mean to reuse the simulate_network_failure_loop not to test dm-multipat=
h
but to test nvme fabrics transports, right?
