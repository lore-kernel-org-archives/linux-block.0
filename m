Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EB7C433E9
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 09:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A6B64F7C
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 09:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhBDJ0o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 04:26:44 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61761 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbhBDJ0n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 04:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612430802; x=1643966802;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=D+05JRlhZ6MwPevRe/66BZoTjc6SOOOkc1odb51anmM=;
  b=LGqUiLkYlDZfjNOYegSl+u+CbYf09rS04EizpKfhmSA6RjQjE7KrBPTC
   EJUNbeqbQye3gRTsLPr9/3MAMMrpGyH1TlM2773AzGn+R6wJoMdTtFahQ
   pykGS8dXgETZvpcLEZBVThxsjcYuKdckSdeCO15VDgI5PBRCAdbdvxvJY
   Tq66Jdnsyka2/Hy0HqhmYIDt5hSYQgJnsZ6Q95S4pgeUr6l6pG8T0Zvlb
   UoedbG/Sn5wB4QYevgcuqdOkMKZno2Z3DesL4JexOyHvm7MsqBy5r+Jng
   DrBYwDg1ZyhsVU/BYPGllhM17/v5GapO/c+XnvTuPbiax56WQ3YxIjE5C
   Q==;
IronPort-SDR: IFfcEZRqfoJqE8EEGRgwCovSeYpiuaR6Jm2XBEfldaNuN2brcp4VVOc/oMb3cKck5zckwVtybM
 byJnFMaFOTDijJnIBEZCTsOue6GHBK2OC9PJfiGpevFHsKmZHJsQmoFjCmh473qu9rgM7RO4MM
 9w78GY8vrJc+uN0MtAWQfUX7wxqyL7RE+uy6pm4Rsg4b75yo0fBD9wTDPHga8wg9FZlSQtUwJF
 ll+gubTSMplZeX4ntikhLiQjgzNh4/vemQMB/bztNbh9RCfAHVZnYF6zSxfr+cIkudrWCDdxzj
 WYo=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="163551942"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 17:25:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEIGoOZdzTXY+5+r6/XeJMGiKp9T/GNZnWeRcLa0B8RyNeh5MRdJKmzJVBu6CUVxFDCaJ8S0t2oo0f89MIfv5RfBT0ujhCbRVvP01Nwacj8zSwFsVG74sRovs45jgE1OT1COeN2azFmdRr5VOCBlZje+ns5n0eyqrbVbJ3gk1UmepY5RXKXMI0PcHHsMQlSkncCxs3AYnchsGk1p7XQOk0X3f8nvXedpXZqNYM7mh6RDy6p6VQ7e7fg1436HN9ML0rzC9eJOFMwIkt2K7y7FUlce1UzeugYSK1xtlflAirrrWqm00D/TbGqtqIeG93ljFHcJQ5hHpKF342IEIONUCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZe5brL6kbGZy0/n2NM0nrugt2tM3flgqX0L1L8own8=;
 b=Wj6FM2SaOf9AgTZF//S1JonXm6df3ZS/WwwhovjqPJXpDErn89GPMnFeD93iFzbc1++D4otfynD8M70b/CVfJKsRpnUQEaJL9+k9BeGB+RRlu34Grm7Cv+/dhLGwuBRPvASQyaJjemaL8eUkm8o38hGqXp8OKucuroJk/9W9dDxXKDu3jYkAjbjIMJAYx8jdm3dXsmeiQXl8DtrC2e3oQaRmT/UO5e0ldjBB/Zclmt7MzZ16/1nu4xSTGgg2LAwHqWKdvlnSMyqQ5QukyQYW7T4yNLgMWmXp1FFyzXCdeMPdmtoqJFG6Ka5Mlbp3oST1zk4tgofOCJ54mDl2K9Lntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZe5brL6kbGZy0/n2NM0nrugt2tM3flgqX0L1L8own8=;
 b=kT/6luVNZ8hwZGQzKUbL9blhALni9rg5Z6L4EdQVRc1VSUeJC766/AHGuaIv56nZ1rwXPpAVRG9gRq3qDxhbgFySkyEEkVrbhFCSEHK/01GYYbdaCgpbZHsbhatJ6fNfog+8MquicV6fgxmYikLhGXwrfobUs3vBLI7GGHZA4eY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2239.namprd04.prod.outlook.com
 (2603:10b6:804:15::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 09:25:33 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 09:25:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 2/2] block: revert "block: fix bd_size_lock use"
Thread-Topic: [RFC PATCH 2/2] block: revert "block: fix bd_size_lock use"
Thread-Index: AQHW+tJckzeVsveL8EqbiqYBSLlIvA==
Date:   Thu, 4 Feb 2021 09:25:33 +0000
Message-ID: <SN4PR0401MB3598CEF4CCFC248A7729AF9F9BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210204084343.207847-1-damien.lemoal@wdc.com>
 <20210204084343.207847-3-damien.lemoal@wdc.com>
 <SN4PR0401MB359853B6F1875CF1233A495D9BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BL0PR04MB6514F0C5971F11B5BC548202E7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
 <SN4PR0401MB359820BA20257B72EDFBA3499BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BL0PR04MB6514C26DF3AFF2A78B5DA438E7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:51f:6b4a:2171:57e6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d0ed136-6ed5-4840-24a2-08d8c8eed2e3
x-ms-traffictypediagnostic: SN2PR04MB2239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN2PR04MB2239AC97C12F4D29DB85D2659BB39@SN2PR04MB2239.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ikBJyyI58E4LqQroVqivmrb1SwKAU+FUfznUrKJnuPhaj8PRfpGXgW8jw97VLomp9oX9NixLbDqnIOYNMDgh7fyiaStrhWtmEBsIpK2jxxmUbhWaYTe1L+MWm3TF068yHE8ZrErr4KikiUdXX8cFxldHx9Wxs+i6qN+1ypegKGRiBbkDBeFIzyllmTeWKx0mK8k4mOib32mRTkMigb3w3YZtGbRglPV44N2IicmNHdiQexiBecwxPpPmb18KpJ+pEsj5xHGUo5OXPwliT/YwcjcV/zISUlqNwajILU+vpB2Fk6Ff94DHUod70SHa0mCovjV6EZWrcZlfROfLyCCRdAZ9cCWcYI0FLTgGcGxGis2M+kkVaobfg36I/WOH766o689v4I8cJZpTWQO/IBZ6XbzeQNuDrO293MuljPxFiLhmCmMlgy7Ugt4d0kdbxfJIRWpq9Wrkrdywd9JmYU0t+hWH5DL5gX8fe9wly8uc5mHLpw3kWcDz12ao+JmLnAO7wW9V3bLGhrXkWcoTV8BkmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(8936002)(83380400001)(4744005)(91956017)(8676002)(76116006)(5660300002)(4326008)(33656002)(110136005)(71200400001)(64756008)(66476007)(478600001)(66446008)(66556008)(186003)(53546011)(2906002)(7696005)(6506007)(66946007)(86362001)(52536014)(316002)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?C/sZ2n5wSaWhtfvVgv6eXqWV1ueXBWO+LrwbP8Ex/KHK2O1E1WBhVnkj6d1q?=
 =?us-ascii?Q?08mBjFdsRTgrdn/PsqqO03MuXll7DW88s/rtPDirqVEoLXlz33l9Mk1+ApNA?=
 =?us-ascii?Q?+Nq60+1pcX2684mhoRYr5CpxKc6b9BqwwxAgeyBCQ7ZQiX3kGNmMeBXifuim?=
 =?us-ascii?Q?EgYgX0K3GWD7EUU/UaEQcDLY9q4eY2j1BJM3D+FY9gRx6rz6zE8Wkd0J5r1C?=
 =?us-ascii?Q?FEqVmUawEuNu4HjahtHNDgNjqJ+thY7Wz0v3yvAb7pA6D4DzQPzwBKV/5WDO?=
 =?us-ascii?Q?9WLvuI/klzGCMSpemC+nt3q1kfDAEZBkXoMSA/86mizXjZSgvKIIxOPFIVXM?=
 =?us-ascii?Q?x1gl1iUANvuzPwKI4WDYeTc842ZSOuNg8jS6IBjZkJr9EuMbOsJ+zPA6aRKe?=
 =?us-ascii?Q?c8zfoOmWdwcLTElk5m2KKjagcrUfvgx6EqJf1sJXnEQ2++IPylObVVPfy4m/?=
 =?us-ascii?Q?R4sjgFp8dDqkfJ5q2fQE5dMVOECDxUwzBnW78+mr9GNS9Ca7WgBatTRA618k?=
 =?us-ascii?Q?IsNPfvdlvGjdbKtfFNs/j4UgWgAOhhI28C+50ciTfJjIbsleXZrjb4Okl3IV?=
 =?us-ascii?Q?jvw3QvCLDhWYzku6qLX95sIRzJd9ueY5mmomUIzDVgtff3DICw7iiSeWXbt/?=
 =?us-ascii?Q?kZLe64WZwJWhfngp2jf2siB/Godkk3LA866xPzsl6jq72vBm1uBJvtZAtkww?=
 =?us-ascii?Q?ymewU815ilK47DVMgvPWh1+mGHRUcyP6oeyXJEQE9YuU4nZr3BXUZO9IfHc8?=
 =?us-ascii?Q?cIvdJWypeM/36mi4wC4h38SzwcEkAy87zPsKSlA+3FuTh63j9DM3Ji1gc8dl?=
 =?us-ascii?Q?QISZ++H3kWj2zaOSBBKE972W2vSGsNxhuoavXaLXKNOVyi1jvQRQBufUsc+g?=
 =?us-ascii?Q?H+HzoOXAJYT9tD+JaqPenJXgdWEpsUUAUP6VEscB/RbBeAHykrYqIUFwktvu?=
 =?us-ascii?Q?HlWfNIztJrlpH4CjNt6QXcQY2YC1Z37KIIqtGfoAPXIeQ4ODsEuKsW1VcwMM?=
 =?us-ascii?Q?bYIntiawSmsjdqbLnare3kkY6iPt7bviP9sMhNe88o9EP3HaDFU0B/7lG701?=
 =?us-ascii?Q?MovCBYzx+hmMbEVtWnnMVB3hWIYx4dQEZDa4Mmc/3yf4Kmvj16qL5v9ENG+c?=
 =?us-ascii?Q?hk2bXcK+E1PQKxTkIiogBTVhOvzBAkWrJQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0ed136-6ed5-4840-24a2-08d8c8eed2e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 09:25:33.8008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EEE64FHShr2Pu8DqR4qkZxPa98QmELEae4eMNhAJtVKEuxakcgpHF0yDORDRDEhK7IU0ZQD+ZrlBp9+BC7VVFTrZBR2d2AcRHqTIT8b7gTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2239
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/02/2021 10:20, Damien Le Moal wrote:=0A=
> On 2021/02/04 18:14, Johannes Thumshirn wrote:=0A=
>> On 04/02/2021 10:03, Damien Le Moal wrote:=0A=
>>> On 2021/02/04 18:01, Johannes Thumshirn wrote:=0A=
>>>> Given that #1 in this series is accepted,=0A=
>>>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>>>=0A=
>>>=0A=
>>> Do you mean "if #1 in this series is accepted" ?=0A=
>>> I have not received patch #1... I wonder if it hit the list ? Did you g=
et it ?=0A=
>>>=0A=
>>=0A=
>> Me neither, seems like vger is acting funny again=0A=
> =0A=
> Patch 1 is 111KB... Probably too big and it gets dropped by vger.=0A=
> =0A=
> I generated it with "git rm" and a few other changes (MAITAINERS, Kconfig=
 and=0A=
> Makefile). Is it possible to shorten the "git rm" part so that it does no=
t show=0A=
> every single line removed but just the files being deleted ? That driver =
is a=0A=
> single file, so very large.=0A=
> =0A=
> =0A=
=0A=
Well that's bad, but how could you remove the driver then if vger doesn't  =
like it?=0A=
