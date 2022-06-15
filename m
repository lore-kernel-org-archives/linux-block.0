Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFCCC43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 11:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344082AbiFOLuU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 07:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344720AbiFOLuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 07:50:19 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B4B4B1D0
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 04:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655293816; x=1686829816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Uqn23XaqTHbTs0vOzg7h6CfAm89dPbgUIb3YQ1X6KDE=;
  b=eu/7kTcpRBLalY/GfKkCKdaxGqlBFTMGHb11bNLVT9n83txL5QtFL/n3
   nELWnHze1rVMqe8Y3lNH3QEqr58PMgD9F4+q1J10RbX1qUoiXdkivusx6
   5Q7Qc5Shn4mulMZxza+LyXTWfYZ/+Eg5NA7pMaYMEYfXiU6e9SGWxHfnA
   M/78aRPHWLKNOaa48SfijuZqvDnyPrxxXtCIMi74nu+cZo5LMxFm105Mt
   7j1sRzWOMWkKdNb2Qbj4vDlHVvJdAZ2d4cjN00wPg6QZnlhGMrH5iDziv
   pLpltRIkygEOlmYOc/oDb071qPV+16XnIO9J1t+euwq9c7au1TKVTP6mm
   w==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="203218162"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 19:50:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnIHWlokuU0DX70kXcL5TF0CB/kuqdMT8FjIuPHdKLYSA1ujbi6nahkY3AScRTN9eS2bGZntNtdF4KpnefEG8bWPNDS4Om/P+tptgcN4LElQrnYjdqzyj29RfwAlPwET34eOJJXa/Qa1Emi8T82RPSz2II6q945DRhgJ34eyWi1iaplJMpIjnZS9lzRL1csYEcGgRjpD29MRwPgpvT1hiSmGZWw3HIM2SiYEoNRA2F/u4Fb3tabiGxaBmzUKgwmMruOlqKRP7j2Mqc9MVfns+ovjQZokoVeSZyViLkgUuIRbbXod/sKJCtueaMcWagmgKo3cdQtu11aDkV32dwknqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhcaBOf7KrZWmE3aZvcNDcWcrLQPAOzEQq/Uass2W8Y=;
 b=PLye5uy2IiOBVnXvm7i2p8nCibCcILaN3JNlGCunNNNJWsUpHeJ9i80INpRCVHpOjulHejQQuOsfbkWs+X3B+ZaoEJZfBHxMdJtGN+dttD0CvO8PvcQl2QIVrhp6EOWEltgJLjFfpxz38IhFXF8umxJwgyLjNwlBvbhmJcjzTjpWVm3ZfgwBliyUJokiITawZCfrHpwoeBkheDuxbUjFYIPd9lR/gDI+Pu2rMV2oZufWKHDgx36FGlsdKSi2NGu6aS9g8TAS8tKUVdyQjh83LLFwDmpmMRDMBs1nFZuae/Wc5M//EMnkVPYkMxt1SMf8qcrvdNE/viBKg6iGpeNoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhcaBOf7KrZWmE3aZvcNDcWcrLQPAOzEQq/Uass2W8Y=;
 b=uQ+gUdSIobCZ3/Gw4RY3qj3viKfcECibNKlgBMmS1Qyrl7xwFmJVRSGBRF4SvdpSAskyZBkshcCZvHLKdCbHoHZQKz6JRy+YuY5gABUe6MnDhvQagNK2W5g5Z4wbRNo94lRkOIQFhSKog+hTTRQ5nXOOQIuxsh8+FT2I/lN+zIk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6973.namprd04.prod.outlook.com (2603:10b6:208:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 15 Jun
 2022 11:50:15 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 11:50:15 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jan Kara <jack@suse.cz>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktests: Ignore errors from wait(1)
Thread-Topic: [PATCH] blktests: Ignore errors from wait(1)
Thread-Index: AQHYf70MEAYM8410bECfhVCFN0sjpK1O4uCAgAF5zAA=
Date:   Wed, 15 Jun 2022 11:50:14 +0000
Message-ID: <20220615115014.nm3utxgvq2hkhuzo@shindev>
References: <20220613151721.18664-1-jack@suse.cz>
 <20220614070454.5tcyunt53nqf3y7q@shindev>
 <20220614131803.hwoykpwzfh6pxmda@quack3.lan>
In-Reply-To: <20220614131803.hwoykpwzfh6pxmda@quack3.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8ec01d1-1d92-4180-c103-08da4ec5362f
x-ms-traffictypediagnostic: MN2PR04MB6973:EE_
x-microsoft-antispam-prvs: <MN2PR04MB697387FAC2A6A91314B6C76DEDAD9@MN2PR04MB6973.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VH6r7RV184knuu29vNgoLYXLD3N90BrwZkJZa9upzgqUDuzp79MC4Na2/U1Q7Gv7MdJCN8PlpbIG/pcE9dvGgl3BCJBpjAZ85Oz6T7UiZ5I/Do9RZ3JRRMHaMF3C31rrTalC+pclry3cLsp2pamcvfIhqP2i06ISLFL+5Tgzv5342c4eSd8mw8E0n3VIWkpc9PPgi1K0TxQ11F/ia3dtASH9p9CWNNaoMzYqnodaMIsRGJpiHdDHEaEvZ1HF+UNa+MxJ6p0QqSRBvyZGvXUgzXEpY97ugWeUAXGP5/x/GvEB28YM/5lOP4oZr5fWwiTDz1vs5ln50kZNiQIWh+AvwF9thWUqZ0ZDQeqLa6Zj2kKCEXtdBo5vQz9mGeaQqqLnP/PF8GDHBEg+NI1J2J9NRTfegp0zQrJhTAWMZm+GTduOAByXiUSLx20BEmaOgHs+Kt/rLNWhDYESL7/0Nymdg3krcEEuRl3hPpO33FyKOOKudSCgAvoW9n2kx6q84WFC//Tyre3kaKs7jH/bmPOnM/HNLkQtXbIX5SWhb7HBFlvycZRA/6e8laEDtc8Zt5/83LLIV7uAlM2C5dbuMuqebJ7k1+bIwzRHsgBkb8Ug96lmNJJVuIlB15ZtNkpKSCilWREOJ+nQoiqFvKZ7EW5POt9MBDixBNMDQ3szVI9YIJgiRvzWFJ17pwqvhwe67IIC3PcPSTfVgN4kvFZwqY4ESQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(71200400001)(508600001)(38100700002)(6512007)(6506007)(6486002)(9686003)(44832011)(83380400001)(5660300002)(8936002)(26005)(64756008)(2906002)(6916009)(4326008)(86362001)(54906003)(122000001)(186003)(82960400001)(66446008)(8676002)(38070700005)(316002)(91956017)(1076003)(66556008)(66946007)(33716001)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PZZCpJ8Xmje4yzSPrjHN+ZHFZElLShSDdatVOQCRAu+rlrKee7yTOkc31UfZ?=
 =?us-ascii?Q?2ESm3elPiHnX2B3wTeG8NGIDCAwmmZp1MZhbCdSJ7XGtMdXhIk1PcpUgLjMf?=
 =?us-ascii?Q?LvFlDlHXAfo/8l0Miudb3PH0SHGpwhDkKQMEcBAFS/blSWwtiDt6mR9wcZ9y?=
 =?us-ascii?Q?OzFT9Smkx/8ocIP9iUBprNEEkenKLjoQHqDajTbCgp0PoshZu9z0iCkDwB0R?=
 =?us-ascii?Q?pas/aMcCh80oPt+8CpfhDSCxShdCEcKpp5f2LMTV51s03AcDCxbCSB00iZBo?=
 =?us-ascii?Q?pawb8c45ecRdFJpENE+DYornQkHHEBfGxgDt3V3+cr4yQUbm7d19gjlx+L/p?=
 =?us-ascii?Q?3wysI7j0D5q/4Ws+P3a+RrsRemI9Ve56Sczn+2UIcBHJTug1LqYFgX2XBSfu?=
 =?us-ascii?Q?4/nSLuwAj3MIenV/SqWaTYE5Yscgs7qUHflsWHA3hWTBfi/4Vc4EGAcq1ryl?=
 =?us-ascii?Q?+Qqcw9Rs7Ql7q/d9CbgiQN/827Y+X5lY3i0y26S9CdD3jJNz3G/LTpH1whqm?=
 =?us-ascii?Q?eTRPUmdQYIL1clwg87AC7imtc8kWRxmSIFj3ZLjMhREmgumFvPwlmrhiEZQp?=
 =?us-ascii?Q?HTIdYD7q/tPuI8Ru6E8lbRd1bUXb3pxvnLF/9iXw9ZB1KrNwRVHAYhdQZtBu?=
 =?us-ascii?Q?EGKr81dszo/7U1KiCLpFAjdJ5AcPHoRsZavvz2AQ7gEg6kZi54ed7K1HaLuq?=
 =?us-ascii?Q?mztCnqnyFurCLDmLUSGX21bcQaXGOdikO3YF6IpRRupN2wLplidxZ3hVKUQD?=
 =?us-ascii?Q?M67mG40seEN5bbm568acypsz5F5FImGqHBbIgECie1ZSahI/73fPFms0njf4?=
 =?us-ascii?Q?TKfHUXie7i6PG5KpO4tezK65WlTpceUqtKmjCEAtz32D/6joaniF3s2yzBCd?=
 =?us-ascii?Q?IlGEBpYpcnTsAmJiNSn2XslT/6y1RIKM3fzYGdMrSOOT8jtNgiJzRUJ7qctA?=
 =?us-ascii?Q?JcVuPLH3Nj7E80R7NLykzi5PhXzj2uxhelGJ0zXImxoJtX7lvz3RNcROLqTj?=
 =?us-ascii?Q?I8aJoRLknYuvDoUZP281KIH8Pp1y7rnNSbthlB/3GQ34fQDyzqXuyq4jslBV?=
 =?us-ascii?Q?03NBvstDgjQiDz7K2G1TIhlVA/60U8OH3b4MTUWbeFXaf/c0oVF34Zke7odJ?=
 =?us-ascii?Q?i+Ak6BOEJtEGfNCr/M745iYqsiA/8ENkIgV4T133GIcA3DZiizC6o29l+OGz?=
 =?us-ascii?Q?YGEY8sVE/p1FRdGAeKNLc16Q1FjJBSdQRnPv5/NEOQiA3ByTlVNdkLySFCMZ?=
 =?us-ascii?Q?OUz2iGa6YzE66Tck5SuErIi09NME5rh3bcjuGH1na6aNLfsEJ2PQo+EwMmi7?=
 =?us-ascii?Q?ca+3r9bgNKmFIVh9CtMSchuLgonRGqPc6YNMlsJVhhxWYCK9B9o2BjqPIqrh?=
 =?us-ascii?Q?+GybIEh/eUhB/9D1QvWlx2VGhcqNGgCqUEQunnU2tmsqwj5VF7PH/TeEUf3Y?=
 =?us-ascii?Q?fQev0+1pVM3Rd8cXl68+ObzIAbstDxVBVqrr2ujwdvF5g2gz78Gnn5nESxvd?=
 =?us-ascii?Q?9Mshoy5khAd2hJMZn4jYGl5rgUZRrgEu8yaguD1nDRB3plBNjc+kEl/IwzD5?=
 =?us-ascii?Q?Yd56aKe8S1MbDO4RjuWpmkE70VF/oaH9ev8qHAbdPlZVqt7SGm7AIhkV0Mdl?=
 =?us-ascii?Q?IxMGSOq9fq/23bolYaNhtoVbtNhyq5CbtuAUsw54PALlCqLSDkldrS38bWd8?=
 =?us-ascii?Q?btIrbJIxI8m3ttG+HQgGdZSUi5HMoa5NoQvgk07cdteSSGgAvf7YoK0RTjQi?=
 =?us-ascii?Q?KZM8DzYSmrTsJ4gfEBMa544irx2pSGO97u8QQlf5Kgau7nSO4Jv/?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23541B4AAFAB714099719DCB0EF87669@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ec01d1-1d92-4180-c103-08da4ec5362f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 11:50:15.0657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXrtyK8ut/RmqYPVPG7ndFRwJJ61mK03asQZeCou+/XbDmNbvcEEwJhnzNkrtbNIIE3d60NMAiOJhisEEmxjp30EFuY9zC+UYCsfUY3MUuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6973
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 14, 2022 / 15:18, Jan Kara wrote:
> On Tue 14-06-22 07:04:54, Shinichiro Kawasaki wrote:

[...]

> Yes, I suspect it depends on the shell as well (because otherwise I expec=
t
> people would hit this much earlier than me :). The bash I have is
> "4.4.23(1)-release" - the one in openSUSE 15.3 and it shows the error
> pretty reliably...

I guess the problematic wait command output is job exit status report. To
confirm my guess, could your share example of the wait command output?

Based on my guess, I checked difference between bash 4.4 and my bash 5.1, b=
ut I
did not find notable bash code change about job exit status report. Hmm.

Your patch covers several waits in the block group. I suspect other waits i=
n
other groups may have same risk. Instead of your patch, could you try the p=
atch
below on your system? If it works, all waits in all groups can be addressed=
.

diff --git a/check b/check
index 7037d88..ac24afa 100755
--- a/check
+++ b/check
@@ -440,6 +440,10 @@ _run_test() {
 	RUN_FOR_ZONED=3D0
 	FALLBACK_DEVICE=3D0
=20
+	# Ensure job control monitor mode is off in this sub-shell to suppress
+	# job status output.
+	set +m
+
 	# shellcheck disable=3DSC1090
 	. "tests/${TEST_NAME}"
=20


--=20
Shin'ichiro Kawasaki=
