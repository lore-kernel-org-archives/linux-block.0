Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8279FC47096
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 10:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6549A613EE
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 10:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhFCKBy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 06:01:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36481 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFCKBy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 06:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622714410; x=1654250410;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tI6gjXhgfXek8N820mYvRUjnEV4JfL5el/WnUNpKDTM=;
  b=Zva/jd91RHbpXz7CY/qb3vspau3yT2Cc8l+RELqPBQYCaT5TKiu2+ksL
   F7m8vfMitX7xcGp3yQIaqt9hHPwa4+5OTRVMVy4LXbyEAjtT/w+GjpHDj
   sqU5Pf6Zi+sO+4QzFr99OMHHi5aAwc5H55N/BFvu+NmGryF9y8Cbu0u+t
   a/jA8x3z1y2EzEtmm1nNzSphsN3we+jHkLHrxRyy7p9QZA1ZL1JtEfuKt
   ZurB2jStMbIlNjMY6UbZO1wg50WbBm7RsytBAbQWINeqnTIm5hKpJBSb/
   MDGwKk+f1DrAT8lkdHG004eB3dZfpVo1JGMk6ux+HylBKPlpo2F9B9u0R
   Q==;
IronPort-SDR: Sa1p7tKt2T1KKxTnSG48NIzJNr2tOueD6zH2cITT4ALLaTX6sZjKfioJAWDH1y7McgBICUWeaj
 u9UMm0sv49FpqOdJpq1jYpyXu2z9u7EkvxnpI2WQmS757i4CP9NEpKiGY0JAY5l0qIrhP0osm7
 qIHKQo07+Qp0QRfTA39cKyMtKCa7ltO6du4WpSPX+3uV9E7CLJH4OhAJShpUyLckJUH40Euob5
 3vMrgtlVhyF9UTEGqFWIhqsXcMNpKQvsL+sb9gnanBa4ior32XDin+AZzjmslBgZYT91b5BMrE
 aDc=
X-IronPort-AV: E=Sophos;i="5.83,244,1616428800"; 
   d="scan'208";a="169848352"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2021 18:00:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVbHR/dEa4hEG2cJBKXeyxgQxCAnvUw6mZA7YTAikn4sGYJQfmAVkvTmrIc+gufEtg5Ftd3qLR+XEJk5R16dLqeR3q53bT0gylLHTo5awzccmmpmjib5Dqk6nIWScsy91AwsE06TSpADKIZuHdGm/pWOzRlxlqDXiFO0Xiur5h4sCxGV1mDollF9vP8LOXlV8DRytFupNsV89x2SXonj8T6w22IdTx5ZHH7EpuzNmIoiLW8tSblg9I5H3OAx70S6MtBsvE9Co09piZlgHIxW9hGJsxe9/bzYyqGqJhUGdpOMfiMPdr8uJvrOFo1pBqodkzagHoSvU/2w2b52L+w20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tI6gjXhgfXek8N820mYvRUjnEV4JfL5el/WnUNpKDTM=;
 b=LOTYBTSFiCAcRjY8G+a1WVph559gMm2lFwcuYGfWFSACtQOPe98k01qCNVTpZOMP4w/gAVFztgJ8KjUzX3F4xZ/jM8EeWi8+6ZZF3M0W4ZNUg6STTmenTRZFHQHibPSL8+vF9n4rMUyqCjSCN4yyjLz+baCPwbj+4h9Hq5GSKavaNVbGWNZprzxE1Lr80hwON0fYkabxLRd4h0269dciWr4ok+RDdlTQ/rSHggd1pJ2ukIUWnAjKgPcNJggFZr84p5ps8lp8FyN70bSnnqDNcKwbjjaddQ2OGUMhSYCIabPAkunTYCDp32kSa4ppL6O3zCn6M7tMjib8qSig5U+b9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tI6gjXhgfXek8N820mYvRUjnEV4JfL5el/WnUNpKDTM=;
 b=nMEWv3wgCIpUWhzDchKjijGqjRXtafmGv8aucUvTCe31lT7FGOTAg7ikt10GNeLpHgvRG4b547tm5BSd5FTFbNVBxckUY8dC1C5UNbuUfjb6+mTc33tt8s6xbQ6FVW1SyjIAKl9ekphIb+zMrzDLs9oyYQub0QigjuGNnqpWem4=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5595.namprd04.prod.outlook.com (2603:10b6:5:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26; Thu, 3 Jun
 2021 10:00:08 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 10:00:08 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN
Thread-Topic: [PATCH 2/2] blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN
Thread-Index: AQHXViSI8g5t53fJ2UqQanQJze0fFQ==
Date:   Thu, 3 Jun 2021 10:00:08 +0000
Message-ID: <DM6PR04MB7081B69E31BB7ADDF02E2D9BE73C9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210531135444.122018-1-Niklas.Cassel@wdc.com>
 <20210531135444.122018-3-Niklas.Cassel@wdc.com>
 <20210603095117.GU31483@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:467:7587:9599:cace]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f824e368-c7ca-4b7c-59f2-08d926765e72
x-ms-traffictypediagnostic: DM6PR04MB5595:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB55959C2D2A4FE3A4415676E6E73C9@DM6PR04MB5595.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Kp43vYr35adtn9SGwfvYCR/qy0J+wZ40Cef10W5peftg+HqCk+5HKwFDY8AgW8yxwWHmvMigyiFu/rXyPPrdMu9VFM2RXUIlxtcVsWh8/h4c2Pq4kQMv2IiJcfW9asZpbJtPQ0zfdE7qkV0/gof5Bws+V/N/eixdZB6qvzcYaH3JpUNqL5p9tqCjL7xOiRW37bCfDRy2QbgPDqcGUEqaW5xq5qWJ4z5/96p02dxym+X6yzO9nyLgK/hoVD9S9wPBoNV3z5ZYQhi4K2AafEGM3rIxv0Y4Zz/1nr82J6ifHO65ENRhK+rBQJTiAFQdB2u8XMdnA95K8XDt546gF3o+dOILMg5+nyxqGXsOxYeujr2QHitOtIAu9RARpxRRkAvOpNAk0rCXSSWceB+nVixmvfv5IGUiC3w1+taeuTUYBAQDrZ2YyzgERq9Dj3XHm1wUXp33yoce6Dpl1/F8C6+h0JDRwNe1EhB3EgrZcdaBGf2XE0YeuF6YbKe22mjLXqQ9P44r+xe9OdSrf5rUaY8IsBykpPiPrIQE8YzteOgD0SEZcqOFu4Fm2rdMHSZKJOaM1ywAXqG9xF7CtXjpbGqDuILvtImku9yI0/21mnM64o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(8936002)(9686003)(4326008)(6636002)(2906002)(33656002)(86362001)(478600001)(55016002)(66476007)(122000001)(91956017)(4744005)(8676002)(54906003)(6506007)(5660300002)(186003)(52536014)(64756008)(66946007)(316002)(53546011)(71200400001)(7696005)(76116006)(66446008)(83380400001)(66556008)(38100700002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Jf0Z0DD8vOAu8HsD4zl/vUE/1J01FY5iONOligxsJf9/VsNySR8ND8Iol2OK?=
 =?us-ascii?Q?y83H3uUUwUj5GA62pqy9qYZDTDFGWAhT6xsRJTUitQdv8q03uztYtmCdoUSG?=
 =?us-ascii?Q?S8dCcQ0cu2u12vmo0Tw+EO8zsGL6sfmHT9Dzjdo4/Mrf4JSFb7lK001aR0QX?=
 =?us-ascii?Q?sVlwCocY7twbAczvEsdPtArQON0aWjyHNE1OvzqmVBJ0PEdUU0SSzGznvRWg?=
 =?us-ascii?Q?tGoFcflubmeJDN6VQriP4h8W6G/N/NdwDYkMlNHZ5bkl0HIZTQt6DzTaNvLS?=
 =?us-ascii?Q?7MFtqRs5cWraI7A/jRChty5I+aoBJRjODbc3dQ8IewaQ2f6r58lj0ohE2Evp?=
 =?us-ascii?Q?tgPUsdZ6TJwGO6XCjYLnK+LnA/Z65GmBux+YT8Gy4L0irgQ2FeNTVcKVg2wu?=
 =?us-ascii?Q?P5lLepY2bzeiI1Bts8SEwfFt8EqavlK9SWCt8Vgqxq/S3qWSgZjLwu7ttebU?=
 =?us-ascii?Q?XYSz/TEAr7XwpQvEdOJoRcvzvGEueXFSe11E5BN5OHF+FQyL2QagTBjqUWhS?=
 =?us-ascii?Q?y2p+CDc9cM9zK2aikBN+K6jE0GsbCE0oqAKL0bZKK9ndUlXAXOWVkdFK7Ic3?=
 =?us-ascii?Q?BAxXvW72dPmLAUA8efWeg3SHAFA9X7Niv28N8iUxkbi+/ZlO0yWt7p/9NjQm?=
 =?us-ascii?Q?j0hH7tXPZzZ71Eo5e+XTObdy4edlAtWyegPv3yqyDW5xgN3tyu1F5VzOu8+K?=
 =?us-ascii?Q?oW7GYwuymHSSwz9wQdsR2DfEq4Df6VvZLTtt9BYRZMaOs3BDJMSvZVhQe0jD?=
 =?us-ascii?Q?PRhhoN9ZsS3zRFHKwTT9O9sOiMWgO2CcBrE0Yp1uP3+PrrFi2zlyg7ZGIsDw?=
 =?us-ascii?Q?2q5zMyNDF8uHbdTTDgxAY2fTgiRSWW7W+lh7NbJVQG4ZPPC5DB3gwzS6ldMv?=
 =?us-ascii?Q?Zxe8NfJ6/Yzmz1yE19WK0G8b4KRmSOcFKeX5zLYRMLHZgg7fjMzj7DRKqAwW?=
 =?us-ascii?Q?gZlIPaSUAXOgxm5oPg/4MVm5mz6Obet1lx6J//Iwzb/EVPNMoTtjr+Vf0bEw?=
 =?us-ascii?Q?X9YaBlT42At+IjhRYkLFHFdd82AbgJNKXPxg8iN1GRZu2xPzLLPr9m6a5R37?=
 =?us-ascii?Q?F2pD/vFOrsAJS9dE1EvzpWN5sY25AuFVDYKVKiw3Y2ZFcEU/uxSazWpBL0R1?=
 =?us-ascii?Q?hGYZIBBJWg5VLhNBRfeG7N8xUS0SigE8WD8PBnTCg/7UwJRoEwEf8Kt4XlWe?=
 =?us-ascii?Q?iswe9rwz+6KiwKv7e5C1oJ7Xi7SdtGV+iJWcTpN87h2QC4/5DPTuP+3UUfHa?=
 =?us-ascii?Q?JDyQqny2OgCzvY4htMl8OA5fSYOb2btu21HAOHTqFBbkFNoxKwbZ5LxvzDI/?=
 =?us-ascii?Q?WSPCPfd9jEBkWhBQxot/v9z93dd0FFGACIZAOazheU9DzZqV+cU3TRozjVe0?=
 =?us-ascii?Q?xQN9gekWAC3aFAuLrPav8OLrmxl2e4mFpnEdk6rbzjhbk4LbIw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f824e368-c7ca-4b7c-59f2-08d926765e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 10:00:08.0512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bBtNsrEL3JFu8baYZF9Ck9iIn8guADscfdKAr49n5z2dWmEr8Pa77kzSYKRR5QQwOCVoLW2YxHlrGJ68RUfkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5595
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/03 18:54, David Sterba wrote:=0A=
> On Mon, May 31, 2021 at 01:54:53PM +0000, Niklas Cassel wrote:=0A=
>> From: Niklas Cassel <niklas.cassel@wdc.com>=0A=
>>=0A=
>> Performing a BLKREPORTZONE operation should be allowed under the same=0A=
>> permissions as read(). (read() does not require CAP_SYS_ADMIN).=0A=
>>=0A=
>> Remove the CAP_SYS_ADMIN requirement, and instead check that the fd was=
=0A=
>> successfully opened with FMODE_READ. This way BLKREPORTZONE will match=
=0A=
>> the access control requirement of read().=0A=
> =0A=
> Does this mean that a process that does not have read nor write access=0A=
> to the device itself (blocks) is capable of reading the zone=0A=
> information? Eg. some monitoring tool.=0A=
=0A=
With this change, to do a report zones, the process will only need to have =
read=0A=
access to the device. And if it has read access, it also means that it can =
read=0A=
the zones content.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
