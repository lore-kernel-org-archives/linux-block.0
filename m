Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA66EB64D7
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 00:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjF2A41 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 20:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjF2A40 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 20:56:26 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E632117
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 17:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688000185; x=1719536185;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XrpjEGexWZUw5bAcR2M9/Y1GKMcBjgUn6ymLjrZn8h4=;
  b=fc+06g4gq8jSqr3edUNFxdP11kagcSMXCPaRa7GkbiT2D0ctA2fV6YNp
   XOhXSqWCTuZyNIWG9H6Q3AVrlZ78vgWUfrc6y2i4x1IhrujBBWLubon/Z
   s/gvAu01bDyBcpzqy6XR1N/4BAPZxAzkGsnAVK2e0GeErVtlaH2Jbyx3K
   CyIF1j+seFR5fdvjX1bdengXy9y+07G2VMxxA/KgoF1PJbH1izaBs/AW6
   O04aEr/dE2Q8e+5y/HLsviYgOxG53pOq8b7vYwHkRJHmFTT/nwaK3aZeV
   7U6ib36ZUt1Gj9XkrRuLp3MZzf+jGOSjKdoso6BP8bWYxlYyPprdrpais
   w==;
X-IronPort-AV: E=Sophos;i="6.01,167,1684771200"; 
   d="scan'208";a="235179836"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2023 08:56:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeJEfZ8QZRIrKAN9vOm3iVY3JAK/+Cc9REJK7bBZkHyTlG4BHOyq0sbnoqpGtbwiLeCWfgbvVpbzocMhTqJt1cF3wvXA/iXzbXwPwptygvI0fwlP066lyWpFE2PeiFhFgn4OCbPew/LiQXOr1tSg0NOq3sN7x0cTg/8cdr49PONBfXUmDL3XChh+87Fljq1I5fFBc8aWqby/EwUy5jxR9A/rLb3Ap6VssDhkNqw4pnwDsvWXiQaEew0yQmfXZm0Vqw0fFYGMbRvhLIW3ExAUZGMDBFi1HgkoUL6pTrn98m7gWWomF7lLnKBuQZ09p1F5xaagRQXBVK+pOGyz9h+/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrpjEGexWZUw5bAcR2M9/Y1GKMcBjgUn6ymLjrZn8h4=;
 b=bcI9lxrCZUs98xZIQqFwam2b6FVY9MY0c9I+yoOtWynhXlrx/CP+7t3Z8Jkx+IJMSRYJQ7KS9b5hhg0X5myfFRMXT5/XhC+hI4IQ4AepE2p/LQS2v1YnAcJCFQzM+oOFXx98+MQx5agXfk4XV6ak4VJy+nhMhkcjYg3aIJ5psyp66TFratPfAo4GyFHAWxQTj7V0JSCYKTJvbNPV4NDRhEspH+25AUxyFsMHqDeujDgdGZLcWZ7ZP8rxasr2IEgRk5NQ2BddosbUHSfRJubw1BWvdpDNaDWUJ9V9b+SdowaoIllFET9IiKcJn0qO3qCFwar02vgML9nP8v6cCsN1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrpjEGexWZUw5bAcR2M9/Y1GKMcBjgUn6ymLjrZn8h4=;
 b=jxWDp/2A9AIE1g3k7IBpaT47vfBTl22Q4FzEKfpib7tZFLg7UGv/6R9wRkXRxOZD1aGPY5NTUtj2j5Ry95bchbuMSsA/t4mzkihN0YfIGijj/wUGSPcwHkBA/J4xKvTgk4zvG8tUs91NzmIyjmWCrAnoWewzm7HBWi5xaBPeg/8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6992.namprd04.prod.outlook.com (2603:10b6:208:1e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 00:56:22 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 00:56:22 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
CC:     Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests] nvme/rc: specify hostnqn to hostid to nvme
 discover and connect
Thread-Topic: [PATCH blktests] nvme/rc: specify hostnqn to hostid to nvme
 discover and connect
Thread-Index: AQHZqb4wvNZAytiZukCXXV7cLLYJQa+g9Y2A
Date:   Thu, 29 Jun 2023 00:56:22 +0000
Message-ID: <czfmbbq3cqzimjtckrtc3fctg2zar2rsly3prnzt45d6drlyjp@v7cc7srlhi7c>
References: <20230628124343.2900339-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230628124343.2900339-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6992:EE_
x-ms-office365-filtering-correlation-id: 81ddb9d7-19dd-444f-a4d7-08db783ba81a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QFingJoOS1DDv5sHlSvkqxRIAt9HgvRlq+ksdHQtwpmiJq2uvG/HUMQnKWfBnk39INHp3BbmN/g6kZ70j8eXccu27emm3yFUAtJA6mgp2xoxnkqHmgtCVAWz+oxSCoRCz9ji9NhQ7+udpSu6vcqRFLNj93XxCedzFRZ64VSyFnYMli5yPO+GPeFGBiB4sjpenB6P5pW2LUGk0wr+cVAZVrZDGdzug6Stk1W4FhMEG7N1JNgxmH7Y1EaoSezPPCkz65npgdIDLFo4AUR/DOz0/vke+A+ZljTJ6ez8WEQgAQ6ZW5RwzjLRiYlRKSB4G5O0O9fH1gRuzYhnx26aOR6dEQAdo3AQasrU6xYUdowLaPxmpOltjQ4QaKODYyJ/Bwt+ZSLrmqGTR+JVS1z4KN8X9DWZx4+H23YlbKA0D+phr6GaYxGgEVty71gVxLX16Zoo/+QZfI4mWVJpVO1XceyLskUithYT7MOFBCGNFbmPS0TlRavSUijirdA369uYfbFX2qYumz8Wi0BvVezjyASaTwX1yMeftsIy/fK4e35l7mNyRdZKu6Vp+s6VDBCf06Ag1M4KvqzjSRuadI+AX+4ZFH9mWzBXuI/fZAE+54fMea9+m972Wz4ZLABylN1ZdoW4DGhF/PoO8CkLDNuaM44WEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(5660300002)(66476007)(26005)(33716001)(4744005)(2906002)(186003)(71200400001)(9686003)(38070700005)(38100700002)(122000001)(6506007)(6512007)(8936002)(83380400001)(66446008)(41300700001)(44832011)(66946007)(91956017)(64756008)(66556008)(82960400001)(8676002)(6486002)(54906003)(86362001)(478600001)(4326008)(110136005)(316002)(76116006)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HwyZjAHUPwQdgcVK/ZCPWFKotiClaC9VZPk4HuFTkWx/hEbxokvHy2RiIupp?=
 =?us-ascii?Q?zPWLXtXFGQjiFAf7gKrPwEdZBjjvdlMcMUyfOD/vdvNd0rYLDmRmUp7NuAqj?=
 =?us-ascii?Q?2gtLTW6LOPUcNtDBnvbm4Z68Wikp0Fd23Anw2y+cgszAnsZI0tzFqgjvRtJ7?=
 =?us-ascii?Q?7BqxepQG6P1i1XP/8cP5l7bf/u7acTPnfK9Ta4Hz/qCQCIgEn6Gm3OEqhi5M?=
 =?us-ascii?Q?aUzDPiB9fBpPU3wBlNn1QEfKWgvBATXmGzhhp0YJfxamUvqRar8AFUFbqhli?=
 =?us-ascii?Q?R+buFI17Wod5yCKbuBqvguiOdfWEHIykBukZrXbKphUCJvXe71bxHg7YR0iw?=
 =?us-ascii?Q?jpuMaYuCGqjo1kjTtEMogRabRtT06DJTUqwiFQrJ+FkxNRT3+Uz0AiCWGjoE?=
 =?us-ascii?Q?sALQ2oJEJREw46+kVRzxoJMHQU0iwiQUDM6v5sFssNt8JI6aAdqBDqQp9+bo?=
 =?us-ascii?Q?il5oz8qfT/HasNynupLEXwTMkAkvhc27qNQZqhHnYeIOmE423WDaQCqZA8C0?=
 =?us-ascii?Q?/jDZ6FcqDrTSJ7YYxZHEEVZd3Qq2TAce1m6WBgqiwNppDAH1VrCVnBrFSu09?=
 =?us-ascii?Q?+3CsFDvvThz42Sj3zfXAR568Dkk+nChDlWq8ihWR438eDeAwnv5orY+E0njh?=
 =?us-ascii?Q?HjSZNyOof1FbbKSBnt9mSl+N4zNfhILSCCh49uds1FoIq8prOzUQ4M9OoqEG?=
 =?us-ascii?Q?O1hr5Lygynr3pVsoPW59CEarCmPCUSuq0VUCNM6SYehPAvb64z/e7ZWIn1qx?=
 =?us-ascii?Q?+qsqeGzoKxdDn6uZiWHf5B4byFltuR4wvgIgW7avnijoP7AQNFWuaBcQyVIk?=
 =?us-ascii?Q?2YWjalF2+2Hqv0D57sa78ploac8WVEs17VJ+eYmPIu/KrGXI9XEGYeFHtmN5?=
 =?us-ascii?Q?Mhi5mSMNkio10Rig8sNa6ae7XvINcyj14MnjpJbCoDg6dlDsWCi3zv4RltBL?=
 =?us-ascii?Q?w94lp8C+252xIr4Uhg5CAj5LAGb/Ix42cU6IzQ3mFwJ3OE1erKZ5QKiOEZB7?=
 =?us-ascii?Q?HoYS8D1lH+IPGoeKp+ZnKnawDLjuKlJYDVNpbXfzVlRs4FfTIogZkPgBsyNG?=
 =?us-ascii?Q?wfyTMV3CQWKnhOmfw/Yvz0KG2I7ZAeg1b6wHwevxOdvQZV0y6R3TFQMC2EeU?=
 =?us-ascii?Q?pYwmgo3Sgf9S3yROFhvKGVnRL8Op3f9X/pmDcb1v/vBV9bef/ob9Q2s2/4+N?=
 =?us-ascii?Q?zwZRwOY9HJ46nmQ2q3r0Ju/eLad4A4yStQQ+AP8ASdeP8SEKFvVY8Bfi8Cac?=
 =?us-ascii?Q?09wa13GAoutfQW62TSsuwLZf5QwRd1+sz2o+TBL9c3AfV3tuDn56sIkJAvED?=
 =?us-ascii?Q?pqt4pskR8oV+dtcxwKh2v+R0bU8mYlnpKXkz+KDJDVztt/j3N9fd/AXAGxjt?=
 =?us-ascii?Q?TOBsSH/X4fTIBPRXzpCza3deujjD8qmE1WjpP2IpjSLQ+q72tRRHWxdWkst7?=
 =?us-ascii?Q?WdyFn607Epu/hKkp/38Rk2yBpSViJ2ywBs55sKYip4kQ2vcbk/QNe4HY1Z8d?=
 =?us-ascii?Q?jQr0UO7mXNANkFP9DwGLyLPfbcTvC6OkYAv0Q5XpPUiHdLf6rI9+4v6qu0pg?=
 =?us-ascii?Q?yVvuDcaD/fMSaYGs/qQUSoLZWfogZWii1hcw0+yXjhue3fmb2goAXuW50aaI?=
 =?us-ascii?Q?57eaLzD8qCMAgA5gX+lJtZA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E661B9DA1C7C454589677694B605231E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nAGLJfruqZPXQpRJsw7bVKMeSrCPRsafBxSa/PgsT3d3FrKPhDKz7hdCJd2QgCJ+0UgQzbZUY37GN8/isHgqJz5MkFPELWsRstUdoWj6y8mAjADs6w68B2zlGDkoAQFVHAeh1O/IDYcyakEWBFGwbJqUEXlFvfEGEGf5sv9LhUJrCBDk3txMVwN4lee+cW7NwwutfkwP1K7Yq6r5ibuSaQLJCUoh7+40ma2NLCUG+ZyM/UT6uRisnQR+YPvwId86BovxPaFRiE7F97hz8zUm9N4jF/ZECAcLpXRZu7KwEPmsDN5ht5f8iNmqBOdSFLmidtDXKAp73my7lWE4wNJyQgEYrHU35mu5LfOe4TZ+7E2FCKaq321ZhoQnrlKS3rR8CFP+M7FNEmuF0x3X7X7dI8kxX48bxpGTYkJRUZUhcYj2jjEtWILdHVdAXuOH6dRVdcVl7voDE2Aq9z/86DRAOevmQWRr6Wt5FmJ+Tl0tJxqkyV7tHgprluoxbauBGZyy9qoHZYyPecGwVSpidqLGJY8GDivHryLWM48h3cXfFU7xXz2xDf5E4NTlG2rl9mL/0Cx/EElQAv6Qcp5fraGbFb6Fbjyz4gT3Ls5XnZjOzzzqzgNgzhZ4+C0kbR6rDw/+nIn64bySUimHcgJo6q2ehbs7ryHG2y/484XAJ4OB4R9jW3GY8AaTptCqdq6g6ErLJQC14kV7asqQ2WF4odszi9/EmOwblwAr8ZG1YOTAWsdA8a5ouQRsBxlRBgKp1OMsRvWKuc5h/Bu5zPYsfkH2kHfPclCy0aJJLFu7GWHkCtgwuWYlON6hYiWfKcpn5s6XbVhhvCMAKj4H59GTLkI+UciUxNkk8G9CCt6W/6LQPeg6iixslAm4u+T6m9S4T3EOFdy4/8BBeAOu8Ye59kSIa0UgtiyiwFT35+Q1Zd50Nm0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ddb9d7-19dd-444f-a4d7-08db783ba81a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 00:56:22.1225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+pRUtGJO+kObHFc+yDeXn9Gbk4pajmnucMqf10pg8EGxAUEQB6Js+AzdM883wLWv2+znrKa40Z2Z9/FliYF8VZRkrEdqrSm9R/+fr8tmgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6992
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 28, 2023 / 21:43, Shin'ichiro Kawasaki wrote:
> From: Max Gurtovoy <mgurtovoy@nvidia.com>
>=20
> After the kernel commit ae8bd606e09b ("nvme-fabrics: prevent overriding
> of existing host"), 'nvme discover' and 'nvme connect' commands fail
> when pair of hostid and hostnqn is not provide. This caused failure of
> many test cases in the nvme group with kernel messages "nvme_fabrics:
> found same hostid XXX but different hostnqn YYY".
>=20
> To avoid the failure, specify valid hostnqn and hostid to the nvme
> commands always. Prepare def_hostnqn and def_hostid even when
> /etc/nvme/hostnqn or /etc/nvme/hostid is not available. Using these
> values, add --hostnqn and --hostid options to the nvme commands in
> _nvme_discover() and _nvme_connect_subsys().

Thanks for the reviews and tests. I've applied it with changes Max suggeste=
d.=
