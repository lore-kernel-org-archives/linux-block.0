Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B70AC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 07:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357036AbiDTIBS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 04:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376592AbiDTIBH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 04:01:07 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A2E3C49D
        for <linux-block@vger.kernel.org>; Wed, 20 Apr 2022 00:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650441503; x=1681977503;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=GqsLVeuj1OAA6UCedWHaCKU3x8i3rLgX44GgL6k1rVlo+g4OmAN+BQIr
   bP0Vh09sLoHh5H0R/xMRqMe8ORXAhrJxDoB02KCK0BxMI0FSToAgrWJqC
   mTdT6Q97b900PFhx0a/wTv7pkO+V/2UfufBOjZevpNKQiMiZPgfBl6Yz3
   gT2v66MbtuA8CO5jCL1irqQuBfWBUlWhtWPtD141XlWB7FKwJj9ekPH+O
   wzgzy4v6MJUOHG0Fcu7PsWbcmagjVGE8rxhSLv40+JEQEnXEMThZPfIo3
   r5TkihH0Uo/FeoRXQ0f1d/mENDVF9vm/E2Uu4hfdBTTW93/Q7bTDCb1qe
   A==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="199238190"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 15:58:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6Q2X9fcpkfbNcdlgqqhr8Lg7Fmx1ocBW7/Y7gxqm88ljSXk0hjtSwsZlXE2J1cO3waps8AO7iY7Lhi0DyKgAzio9Qzx5oMXTpdulTnoDzhF9SvhCycLB+JxOhjbpkF/tBfIhqV+TVYPpqZAxpJ6dquxNVUaxAfJ1jms2sW3uLIxoAlo5kgOxnCU3ohj+KET/TcFJjtq5zRMN3JEvdwV8EFKLLTNz243y1mxmbWNKU9+qYhI22MMVeV/cyc+rpoFY7MPRC/lgHvw6T8KSkkrecVSCL/ogosPB/IO8RuYESG+SfiY9yRp9pInl9yNzj3WziPnkfCdmQU1Fpix+4DcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=iRGSFkQACV0W4phhLkK3odn1srKaDE2TnoDkMCxv/ZJOUfSJO0ZMlYs2AKdz3m3EtyjkutqArZE7PFbpO3KXpTFE09nFmXzD3YIvoClei4Xk8xIjW8+TmqTo1Lmlc574VNWYOFOrOpHcgr+7fdOBQiSbfP8fnvE8KsAXunfyjXRyLnPQ6VIJyKjImS0Qb20rM4L3NNPgK0B7cjufzRAu8s9L9cOBAnzinLm1L4G9z6D59zeSKERCArqzH2AbhiZhuS+TWrpQC25VVaOq4l9MhzVtf7dU1HL/iSRFZyI/UpXNK+NRMFGTzdjmbgz/KPUSAYZW8xEo66EK0eb2WsAZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FinMttoYApykYMPJXdx8OpYdXaQD9RSesF3Ph+VM4q1AueXkYDSAN5VKgL6P574QqmJ6ibnI1/wm+qBA+NlTBYSjxoZSxbk18bRy0ttYaEdvp7PrP1r23QyKk2hFzgHWrgHpImMMneY5KFaA9yhXlj9QhvZ2tdmuCbbNR8XdROs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5556.namprd04.prod.outlook.com (2603:10b6:408:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 07:58:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 07:58:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 4/4] block: null_blk: Improve device creation with
 configfs
Thread-Topic: [PATCH v2 4/4] block: null_blk: Improve device creation with
 configfs
Thread-Index: AQHYVFHowtTPLgpz2EOS/Kd1zOWz9w==
Date:   Wed, 20 Apr 2022 07:58:20 +0000
Message-ID: <PH0PR04MB7416EA07938C2AD561280AF39BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
 <20220420005718.3780004-5-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0f91009-4019-4418-5842-08da22a38952
x-ms-traffictypediagnostic: BN8PR04MB5556:EE_
x-microsoft-antispam-prvs: <BN8PR04MB5556B955F2E61E9F10827D2A9BF59@BN8PR04MB5556.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wssteRKyKkvvsTHsFnkm/og7W4iN4q6aiJ/piCueq7368il2sdA9TNSQiYFTKSFG4VtjinPDJmccwIJNf2yeAfOQ2ROrGi4sUv0yYlUtW+v/vSnZT5Cu+qwVD0o0bt9jq6RhXpIl7kOcA7joC3uw59H9PRwAh+A5TapX+w1zZszc/8lrF9J4IZ/IilT3Ba99AqtWYO/bnFBnC2RkDsKWNFhWbil9sjGRFUBu1GQsvaqSOM0va6INIDZjmnePY7NhCsrakcoo+AfQyfvcERkHgI9sTUW0mRbnefK3iJ+hzSdUGYHyDtAPf1a8i5RJo2uiaNL9Mf8IA8YIoghwSwcK5HuYdW2NPWqwnjep+WWHUUoTs+IbRQVL+NAyOPiTsCM5vrrnNzeMQ1ad6k6/NkWSrH1DCuGbFz0julDnCPNahc0yl1gXxxftMZZVnk4QXoMFMnD/x+LWCacqZRG1M5IXgwTdgOVXim5/OwmHBtSCvIuk+mCfpYQ0II0SDNbNGzZQcI8MUNJxINF9IvMM9ys066fFoJcirMqyDZgpjDSNvIsre/wJayvZ2vx4xTkbzxeaLLKxr//wk1sBFfvnLVRjSl5RhUBcvDJsFXACLzWB4mXZtvWQ2RnZ2UuEASaIsSjz8D6EDFZ8feicxT8KkhWfolr7w8SCSMNSH71ilEvwrjZX5KZlsEIAMtOHUvfP73uWX67bV3AUC532aw22ZozMmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(52536014)(5660300002)(38100700002)(508600001)(19618925003)(2906002)(9686003)(7696005)(6506007)(4270600006)(4326008)(8676002)(66476007)(66446008)(66556008)(110136005)(86362001)(8936002)(76116006)(38070700005)(186003)(316002)(64756008)(66946007)(122000001)(91956017)(558084003)(33656002)(55016003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BFS5cpNpMhuyIuwTpWNI/qF7lQreagZ8e+l8c9CV0zxwQ/C1ei4Mksb38JO8?=
 =?us-ascii?Q?0CRGoNihj2w0TvaRXrJ1bfiPBlhrxdhLw3FiIeqhOCmSxQOFQiRZ/XhJp9W+?=
 =?us-ascii?Q?O9q73usW1hSlWSwxRaCdm9kVNFIynbaqsLRN0ZsK9V0xET7zi/wS1p8U33k4?=
 =?us-ascii?Q?hFPGta0y5zgq+vzRdHFmYgRcow68+t6u4GI4O9hhbFTXMDS3EtwN0tU/Y7/1?=
 =?us-ascii?Q?5gooeEtzGEGlPhaweG3BI3f9R4T8YLHmzwaQVQIkJgr+YYS9imduJuguMEzn?=
 =?us-ascii?Q?GTIZZh22cv/f0jlAx3Zcf63nhkdl8TEyi4nId+V1jR0MJd63aBneGshU4R9+?=
 =?us-ascii?Q?XfOFN6MOA1LmFZHvWvqKu9DBa5XWbITeGprjl5LjUHwnLwrqU5aCKyvPxlbd?=
 =?us-ascii?Q?BaP2ApnXYMCyFYQVPcPgGJz2G/ELleWlW5feFc0Hsm3+HK4mknlGLghW96zm?=
 =?us-ascii?Q?EwSGQTqRJufPRR3giekRZxPHXj/GPtS7zb0v3cXwnhXSeazJVQgzIk6rL9q2?=
 =?us-ascii?Q?GYTFQJtLdKMYiBO/BWeCPVzu6L37HR/vIVJVro02KlPKlg04WpV63N4E9ybF?=
 =?us-ascii?Q?bDtKcRwJSsa7fKroUgtz/gaTUQC4z7qUHuJLhOagbS8l2WG66KuMAXiOugRZ?=
 =?us-ascii?Q?PDkRQZpfrlT3a4tuwh3deP7KT0DzfqZvFNTjl9PhYq1QN/C4Ms6hYYgszODe?=
 =?us-ascii?Q?ua5ZpUeq809VNBL9K8Y1sCSYqNEyXgZHQ3Hcgz/8Y2V6+zYAwr87iOWpv8CE?=
 =?us-ascii?Q?bg/pf7HKMx1L2LAZ1RuShJgKwhSCtHLD80NpW8OYEkPTcf+ODE0bXIm7RbaC?=
 =?us-ascii?Q?ohKjadHmhDuOIy3qZw+lk1+BMg+C5X6S6f9tLbkcQ/v6V0f7k3NqAAtnGHxl?=
 =?us-ascii?Q?+4O2I+6sZ9b1Fjbf9Op9h1R1uNSa763F0jmWY5llNzJ0Eail070c6QFdSSt4?=
 =?us-ascii?Q?nCDekyv1Dfuo/2z4nXCqOHZb47DTjJdLHRDeT4ZBWWDHrWQKveUP1hIPKDNP?=
 =?us-ascii?Q?9EcEmN2e3oA1Fib8Dy/TZiZFTnkcsJXu9JNw5XtOhzbg3K4SuFRHOI0wxCo3?=
 =?us-ascii?Q?T5XIcz0BReYazjvhMpo2YxOl8ZE5DDxErDb9LsKpsp1yVT2f80AX6DEGhQrJ?=
 =?us-ascii?Q?TZm04+8EUf/dDxKiza9d8xcIv9GXvp2S/PZHWJVoIxnJyFxJdRF0ZFu7jcFT?=
 =?us-ascii?Q?cSkrEDfBbrB1hnLfK6FmwEF3fAgm90SJ/TWDXUOt4EKak5KMYCae15iY3uXt?=
 =?us-ascii?Q?D4NtUEggsTux0J46oJeYGtV9XbrfusD29NE3+zp92Oe+EjrrvlfmNGtB+6/m?=
 =?us-ascii?Q?l3ArcuYqDHWELLwIgNQL6Wl+ItiEZp6BawAQMp5E98HtGEtLlyKRIMqjH3bJ?=
 =?us-ascii?Q?aQh6N+IwNJtwFMljNcOn4ciA6t8TMtQVUhtqAo+FdNe4KRufE2HTCjcixTUC?=
 =?us-ascii?Q?GSPauruM6QotHwYCF/XiaGNgZnYNWsJGn01MXvW0GUMDUZ6yrS46M4h9NtRs?=
 =?us-ascii?Q?2N6ldDqgMQsudbSpoCCTUjfc7bbf2iNNVRibTLlX2dactt58iixWuFsU7miG?=
 =?us-ascii?Q?r+oA91JzI3imssF9o/PVcK6PtXbWoret4MCD5u1iYdFUPPUdRKpTpyMfupsD?=
 =?us-ascii?Q?DIQAtFB0o9RNPidtJ9xRPRI3yeXp8i3657FOmewh/WhkPl6Z5JRfOHIbVSbj?=
 =?us-ascii?Q?ULGMmMdy38GKIff+FLJTcloExT9fDrAJmDWk8rvvdBCOFq3RPzt9x55JlTBx?=
 =?us-ascii?Q?29eAWJhxYMibLz0y9CEQQxNy9aRq7Idy10qiNUY1nGMnxJJ/W07Q+cAtaBLD?=
x-ms-exchange-antispam-messagedata-1: bVe35G79WNgKCmGJkJaRRbuDe2US/je22fqPwSGFhn3WVJKrFMpmdIPz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f91009-4019-4418-5842-08da22a38952
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 07:58:20.4766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2dtYZ5bmaOQ2MfklzeRySrIfbQYUIWLxdyCxStZqrD5T8RTAuAdPo5igrSCxAyu+JJ5VynmtIml7AYkyBrnTiXUlZGSJbT6Ea3A8UAesqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5556
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
