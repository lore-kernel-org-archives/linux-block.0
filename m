Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED13C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 10:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3408364F54
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 10:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhBBJ74 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:59:56 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22574 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhBBJ7e (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 04:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612259974; x=1643795974;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=SO58mCsl9DPAfOerOeDSumKs3tXLEQyygl8MJRw9+rgtFsdPCuC9ZcYL
   JZGW91guJPS7Rffh4rTugCWQ9lqgX2Lic18+/B1+F4jMQU0EqvwAJFvjD
   4cwcpDYyxBzFUiaRgjAbfyaov0wJ8indOJfn3YpRToGPrku8WXeU8YzOZ
   PPVR6n+sLNrMyCpgQTAAMOGRJAM0yA57mn1/WrobgNqJruM5EyvQ5lZaL
   JvxV9VolpXPXVRPz+lW61nt+RnzdDDEB9uvnALn9zZa+UU1cvBdQj5q0N
   +2AWVCwLC2ezUVD8ayS8eQIuFk3IK8ZlIs0BIOxq3c1pMF9j/T4B7fGFJ
   Q==;
IronPort-SDR: AjwHL17JPs75W3bJZjgAdu1KbybH0VIfwLRf8OABxJTp4FpliugJIxzpYfR5jJYJcBD0pRHHGf
 zvnpYoYp/pMA3OM9JuZBN0V7JaUtqYdiqvezjiqoGDO5mKrZ61XR/oDrRI9ystpHmQk77fLkm9
 rNlr3XdL48PtYpvkIQaIzazi/PKYZ2d6pv91CR6KouQsZY15QX10zpWg4Er1oPym5cIcYC2cCr
 7cdl39x40a4eFheCBKXrMLgIW0+jcORan9znhKlYmDOZhOuRX4sW5YtByRxrsmNteYuz7e7E1r
 qN8=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163354585"
Received: from mail-dm6nam08lp2045.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.45])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 17:58:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbgUygfXa9xdemyQNN7DW3Hs0qlyh9ID10lO+nu7tU88SnaeXa7iQW6ALLuz4Mh7Ef+nGqIAp14OYci/b9DVws6VT7ZkLJZbnlGQRdjuhMhFFyVgm0LH6jNw2AMEPQZKj6y4Ih+XNg5plxiGnp6aqIqNV5dYkBgCiDZZ2nt+XmtisqsChgh/MJx0ZsC2iB8z0U3CXGqDxam8cH7vEqY3i3IJm84SFVddHG7uhYnLqiadBfZ+DCChwV331Bnw3Pxtr1jacfMN8KCZ9gn8W0PknAOD1Fqll9RgNdb7gm8deSEteE/nfY6vIX0aZRv5JDlAmj07LESCEtXc7FmmK/zsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=R6EPP157pT/yknZl2SUlm6zu0yo7rJEYQJ4fvGk66Jsl7JbwWU82wp/Dmn/4E2gw5ds6WPsSa4EPI8rMttm9v2Z417DwTn8hv9Ng5ztO3KxHV560HrXEOrwC6MMgFzuCA8nfY/kGRf0aIv1D048/7m91f2F0B0nqrsu6+x8JEzuGQfvjY6iXeWttJ491pkOVi1gm0eV+Efluf8HiGi44kHD606H1tvN94GpnNvE4AStgvr06v6FbdY1UBRJ44HAbvisRk4sJjYrzrK95nMtEu+LAYipuqpk8c98u7rngj0YkY0JAk1DSpjQryTW2PnG+P8AXzH6pTnlXAb7yfGJ03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=s20Tg9VqlYQA7FCB+eYikw7/Y9PFGSxQUFHSfpsSVbHLSoszCRLRybhNhYZMbbDbSnnzmsP4cLXLlqnyA2rkYfdkW9n4LXb7mnCM+OfTeoILUhn3iN4ZyiAMgjMYKaPnp8f+wVCiNjc6fwANqxbHhq1iYfR6mcq7Ss51GmGLR+g=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3679.namprd04.prod.outlook.com
 (2603:10b6:803:46::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Tue, 2 Feb
 2021 09:58:49 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 09:58:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
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
Subject: Re: [PATCH 5/7] block: get rid of the trace rq insert wrapper
Thread-Topic: [PATCH 5/7] block: get rid of the trace rq insert wrapper
Thread-Index: AQHW+SP6eBFVxTnq+UOKdUd7oo+5IA==
Date:   Tue, 2 Feb 2021 09:58:48 +0000
Message-ID: <SN4PR0401MB3598112545F8F0199DF10D729BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
 <20210202052544.4108-6-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 03afb06a-0bfe-4bc3-52d9-08d8c761233d
x-ms-traffictypediagnostic: SN4PR0401MB3679:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3679D9A6739A23D927E0F2879BB59@SN4PR0401MB3679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ami9W0AKUFRAYddbH7BvFQXiGyYvKfjHCzvTLuDw1oap+ID7Xeyd8NxwFpQlPD0kXEjVaPEmWIT1g5djmPld26CK91HpXqcWBoVG7IKrhEnh4oPep6tG/FdpQnir0lKIgU6nCRiE4GJALAg7evmszSgVC9Ka++EHNwoWfFSLeHKSXXsbWFTjf2AqNt89LlrUHhHW3KcBgxH3ecUwu1zY45/+ZcyUhc+r9EBpbC1YFtjZvzVXFi4Paa1ra1y/j/wrQCzBpXiMLHKWOuGLvF8DI/Lv+t/ILC8z5WjeALMCmQ/fB/XNicAGfJh5/f8FTJ1H5w9Ks0xu+nT3j65af5ivqlXDcXv5fZnVxXLhQNkpTY70zVotbtt4Ty7+wtCPDZOGnDPOgVk8Xtu/GwlFrjdVXIy1jxSWbtaFKeLE/pnqSis48ZuMJmueHgNWqXUp1sDoNR33pOn/JUC78or3KE3ZZ+cq+LxAq11RJFf6nqLYWl/AehclmbkKOamT+CoHyjnabQcetEaQZArDKBumn97GF1Hca1Hj55f/qZqG0qv4TyqZ5K8fwsNXQZAuXGZuBPk2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39850400004)(4270600006)(4326008)(66446008)(7696005)(66476007)(71200400001)(8676002)(19618925003)(66946007)(64756008)(2906002)(54906003)(110136005)(33656002)(9686003)(52536014)(558084003)(316002)(76116006)(55016002)(8936002)(86362001)(6506007)(91956017)(186003)(7416002)(66556008)(5660300002)(478600001)(26583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?whYkpbeR90q43qCgUnSJ6yKkKbQPLik77nxE0N38mdp5NALTde6wkzGE78hy?=
 =?us-ascii?Q?6GXo8+zQuY/oCGNHcz94MTUdATn/weUs53k1GtT5kyQIaCbVbT9drmzBfm7h?=
 =?us-ascii?Q?fxO/GG9oHuK8bs/57iv9BT94A3/730QvY4JOSbxQNGauzBAiBvzMFEDKSu7o?=
 =?us-ascii?Q?b1NxsIEU2ygDnjjMvn05QwTSK2wN2o7NAe9gIkbDPrkh7bkcR+8jYxlse7xX?=
 =?us-ascii?Q?zT3XK1OGZiJOt/h3nZ8qTzWm40fXc5QEENFj8zgXS1pD+Dlv1WnLWiBwyRoy?=
 =?us-ascii?Q?+Qv5MQHlEWw+Z+0JGToELUyYkT25h/Vz1uAJ+JHvUQ9GeQZ18wsdy1tA5kxt?=
 =?us-ascii?Q?5WT+uiSdluQSZMBPOBuqBAUku2YTl1fgw081IAo85FzIuVJQ0P4TdU0p8jjM?=
 =?us-ascii?Q?Si2obQfL8MHH+xXGYS3BX+wWoNGjR4YSF2G2f9/5/a9A++JoE6StkzPrMSfl?=
 =?us-ascii?Q?NIHMhWtaVPe6BuPuNYgBErNZJNYkHtzn77WdkJz6Wb9uJxObs5nYWWl2Dn3z?=
 =?us-ascii?Q?1hBBD5A3BdgODtw8p+0sMPVq/PQVjMaIBhehqQgjDuyLtwYNIzrNILzs3PUq?=
 =?us-ascii?Q?h/1Zke12nTg67eiRBYArn3/6MRwWAR7OZWJEm0+zDOmpT2fZJ2bMVzLeKUnY?=
 =?us-ascii?Q?yuaTRNLF3ZyMPbouyNbQJwJikVSCQ1Glx2Z0ir/UWnd8Y3SQzPKgDQqp86yC?=
 =?us-ascii?Q?lgFCTObfZ0N42UUAtazO/V4qe7NwRPqswh2ihv+cyx8lk1Lq6kTvApRy8cj/?=
 =?us-ascii?Q?QDPVwGLF+hJMH7JkRQCtZlA/iI6j2iLA6xPXRFZKls41+4ArjR51xlKqt2BK?=
 =?us-ascii?Q?K1ogr4CPHiwe6VRcWlCuWEaLUzQxmzQJiQ+u2cM19kGud2F4TGmPmIM1+oYn?=
 =?us-ascii?Q?MbUUjEWl9LAPaRScMEBV+vogkFZ1OBbgOGZK/Wkye4jogYRrWNPvVipVBCiI?=
 =?us-ascii?Q?XRDHy7JqMqdjRmmg0QzA3x0DMGmXBBB2plJqV359IJEDOmZovgktM9ekOfyK?=
 =?us-ascii?Q?/zHoJq0ZqbkXTfw1vr9VquLpE5+LY2CvdHObLUy/Nq95XaskDj1PLJV2gGso?=
 =?us-ascii?Q?TBVvIQeMlLLSNyOVU9+hE/P4LQiWBwZoiUuc53uqqZHwhYxZmwpK5xfmoR7Q?=
 =?us-ascii?Q?955MN8YMZ1HevQ/mmdgibm8MHEKFN7glAg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03afb06a-0bfe-4bc3-52d9-08d8c761233d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:58:48.8672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7XQELCCW+DVmeaUvQpOUJRnnn21JYYKc6+0lMpqM5aEVaAwQzH/pcPA5TbvgEfu1R0bXb9q+ZOr4CoddFWb+pRJMKPCFQ68tGDPccNfLJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3679
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
