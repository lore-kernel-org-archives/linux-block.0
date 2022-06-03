Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84128C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 01:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbiFCBYJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 21:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbiFCBYI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 21:24:08 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C146E26CB
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 18:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654219436; x=1685755436;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g4so0IAW42jl4h6cu3EG6jmOzEizf4I6CnVRNN7qhdU=;
  b=BUMW1HkmiYGbqBO0SVe5pLa3tGaK6MP281y/U7/zIyA+do2HEAsCzY/v
   654zCFYMhafnCUpFxUN0bjMNcI3FnlYY2RFJVY0Y63lOlFVumactq6ZCK
   XtRNtOKCGoYrcc8Vhbnf+4MuA0mYfRbaI920N62CiYuOQ2WDVRvCtpH4Z
   yQuNquu1o/zceBMhwBJXJCZg3he9ykGJVNyLlAsApMFBhI1tY7BhOtsGK
   4LDPHYFENsQ73b0rlC6dsb8vqaf0pbn5I0yIbckjnpVtxaWYLy1EjUj6+
   7Umours1AeAZcrxcWXiC7V1bvTGOy72QOTJmPhxRM7E6l+FpzzsNAQW0t
   g==;
X-IronPort-AV: E=Sophos;i="5.91,273,1647273600"; 
   d="scan'208";a="200898377"
Received: from mail-dm6nam04lp2043.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.43])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2022 09:23:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YffufJx0TwkJNDxVqSpal2FzRZo4HGkLYBDK79LAGmtJJVjgT/hkn41ZmmxnKktCDW1dSlyWYZNOtHm+q5+yQD+ZyOfrfi64X7EH2o6loR7x7fXtjwWc3o09yQqrKDXs2a6kxStHw/kuCiy4cKYqdNzL2SoVKD62XPAokdyKVUu+U/daWAsBmRUfayJCjCYmOaq6uLs64z4SyvA4OvRp84/gMVjkRG9YoWkhk3BaIifyYyuI7UcDQP2rmzuORBhk7JMisFzs7osaB9Pq7vDpc9emDtfmAcRf92R3/KZURHvd/G2jFYSwjhdgsXDQMtsGNjUHPfG3RNCaohUROKTKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksDAEUiZKVGdld2hOJNOj0vSmlWTQxA/QGzX0KD/feA=;
 b=eE984aE0rvieM6+vIhS+ZYDD4MNxksxldMwznuQYTEzVYK0M2qNTtVZZCabLtNOHDf0/WfqUNu75mwsHIJB+p8wyd5Xu1LthkN2OHQezcODfAtOny0hfBQh9bsW3kEEaZW0eO6MXVT64W5LM/QsfdzFsnovV8cqvo7J0ibTokuwDplrDcXLonlFNGpPBo+/eYv2JeDxK9xeX7LyOsE3GbTpgHpuiykM/D/F3TpL6tXvNocsnzz0aTsQ6fdULZDlhuWBT7Okvu6Z55/gnaoIba+k2eepWIln7zRM0nLbxWESwW5vb4qQ6qHGW0c8oyvpmOIjNq6nNQ4kEPPZcJQoL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksDAEUiZKVGdld2hOJNOj0vSmlWTQxA/QGzX0KD/feA=;
 b=Xcx51hJ5KvRFZ6GFrIfky9uaH2BjWere29+ZvokhDOnIZujv1WPmtj2GyDRn+FoELU/hNE1NNT7rDMJebJLVljH5TM86iX+w/QURmqQ70EAmxgLPtJLHuJTM4BvTFs6tQfzKtomC+Sp1D7mcyNQns/KBOeRVr/K7QzCQq4I+WuE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB5030.namprd04.prod.outlook.com (2603:10b6:a03:47::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Fri, 3 Jun 2022 01:23:20 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5314.014; Fri, 3 Jun 2022
 01:23:20 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: reduce the dependency on modules v2
Thread-Topic: reduce the dependency on modules v2
Thread-Index: AQHYdYOlQyu8fPUOAkS5yrxM8IeFOa085fyA
Date:   Fri, 3 Jun 2022 01:23:20 +0000
Message-ID: <20220603012319.duh6egbfapk7veie@shindev>
References: <20220601064837.3473709-1-hch@lst.de>
In-Reply-To: <20220601064837.3473709-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d00cf4b3-67c6-4425-9797-08da44ffa51e
x-ms-traffictypediagnostic: BYAPR04MB5030:EE_
x-microsoft-antispam-prvs: <BYAPR04MB50302B9272C6ACC8790F4C0CEDA19@BYAPR04MB5030.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1EOjB8QHzucsLQAaz3V0tqCmGG6ZaTfPbejYxnUqLWDmAri4+S2gctHSWI1DzYlJL9MOM4+DIM51zKmvBtSh523yFq3mHNWflZWOU00VOUkb98u5z5a6ZCb+9Io3L3oL3CcF05OXAwJsE6v+uBi0EuASCBOKBiKYrvBUcvD5Pgp4+Fdg0E3nO09RUp3mz2aEoyKY2ZAF7KO4xIgE+az6UaYgs17kya+pc0wONg0sKEgBg/D84PODoxjuhmB4uKLuKx3DYUJmYtpSDVckaGOF5mwSvvEBAVugEF/v/HcuK1h33jWqFm4ElAH/fvSv7HApD1s4j5iUOTKzlXj+jpaJoOX8Nk7/POyuFFtwctSJZkWRMyF0TfE2lRD8JfQhA5OxEgYJ/zSZPGw7LZiHygZDznLpYK4VQ70UhBuRF30Q5JktYCA3JAdqGc1yajXZ0VJGDRtpfBTOHW0GN3WJmvzBYvlqGPOajassT3FyppuPlcrvFi7reZdG7s6GsAMpz3DJwV1vuTQ3FBHh2Klzx857JMi3ARY2wRyvbIhBrg0zz7NP7pLgmJYhrKJ8vZqf73u+EldFofLCQtpBx0EaXhvDDB4tVgYeeg4UIu/7Ywwmur1xsrkIR2eoEov2WV/sqFdTvn1d4Ps4Ad5luiESZw5WZ1bZn/+NtnobVCBMSQEwbRC0cjF20eCyU2vAOtK8fkJ5zog27U7PA2IU4QqNRH9xdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(8676002)(86362001)(6512007)(6506007)(64756008)(26005)(38070700005)(76116006)(83380400001)(4326008)(66946007)(4744005)(8936002)(71200400001)(82960400001)(5660300002)(6486002)(2906002)(186003)(6916009)(122000001)(91956017)(66556008)(316002)(66446008)(66476007)(38100700002)(508600001)(44832011)(1076003)(33716001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?INyJ1es0ANmmR3u6LfZuJxg3P3EeXrXip3dUCa22ouWIqbiXL4JTeRnWNjZ+?=
 =?us-ascii?Q?OvM6MA0vuP9c1WKcetjId+8npVTV8pQi+R7yoO646jp37P5hz/GN6t3xOLey?=
 =?us-ascii?Q?/N1vf7D1M51y0fHSaQzgbI3k/5RQKgli6D8270gxXzmlPLifooK5aAhMImJE?=
 =?us-ascii?Q?H0l9NG3ueThNSMy98hcUrL02usAchg1yPtB1ejnuNHuxRDJQFy3e0im70MSe?=
 =?us-ascii?Q?S5XBDaxJs8V2GVFjQmOcvoNrQpPF1+JXbN97cBg3IuirzWx+MKQ5jd0oVlIg?=
 =?us-ascii?Q?jdK9liTjdnPBeqxYTkvug9kDzIaa9WdKdxC+Nn/UMzy8tOe1Y5XnYIDnczXc?=
 =?us-ascii?Q?BjIRtjdC6AqAZVxAvw2NVH0rVUUT4/LP53JSB/ydtqQ9EfEqo2XwtbSYifAs?=
 =?us-ascii?Q?Md+SULPbVgRCQLAFi/CwAc4REVZdHiUTKxPstWMjsvKN8zGSy9Nz5a45htKZ?=
 =?us-ascii?Q?mP2Hfagu9f6JWMogW0F4jSyMfS9XkpcCcYCatvJ4mbOAYZlP1ZVXFIZlqNkY?=
 =?us-ascii?Q?tK4pXfU4UTSM30FCKJUABANWtEHP4odZAMfcUorfqw/5EapPKRayM2kZ3Yxt?=
 =?us-ascii?Q?uCTHyHXeYOt3NbyB3gmPJdOagQJbDothykzNBLJKD0cO60K451PeoyuCy45H?=
 =?us-ascii?Q?NEnWbajPpJ6ZL6/Sil9GTpZvVK97gGTMiJhb7fY0VZTSTH9cOlcaxhouuWaR?=
 =?us-ascii?Q?evkJsag5Kf3KMI3uDheIR+ZFpAgcTpqDQHz5xcyIB8HU5fiQKk8RPoK7GUH1?=
 =?us-ascii?Q?47qFXKwF8GjsI8gU7tqT/Y/DdyN+gBSq4Sja22XRE9FFt+lDsxjB33/enpdM?=
 =?us-ascii?Q?nshK4Sk92I2Zfr7LcyUyuPQ3M/r1CbJNMCSbxebUft5zBZnLFDF/DlbwkpTC?=
 =?us-ascii?Q?5Bg8sGebseSAyQsWdtdq+Ewcuhz7mkT8IeIjTDtgUBDzDreP/X+uVg2qC7eW?=
 =?us-ascii?Q?9rr33WWTeZee7mSsz46Oj2JobXrbybJuka35/TZpNZLD4omzBkU4C5tmKuyf?=
 =?us-ascii?Q?SS2cauVdGdG4U9CtPJ8K91R9n8k5l+R+DiDHhKd5FQ4DQ8TbPAS4qsaHMvrP?=
 =?us-ascii?Q?Ls9FnNVLP4dPc1alx1+zDmAvMBcHV8VOVBADfLMj5GVbtEQ8c8wch8ECUGzo?=
 =?us-ascii?Q?0J6RvJkiR8ndhEk+tQ02EO66UkRPsSP/BVcjmluU7pnq3C06SxXAwffGY898?=
 =?us-ascii?Q?kgsFUFGFwB6cD/Bf4C+pqIO3nZyDxttQ+iofqBhAxn9lvwg4Mpf84x14D7OU?=
 =?us-ascii?Q?V+XpAamk+F49z0BQ3pamRZbT0gb5CMyKJH5N+CXtTMWmNGnUAeKnOibBBgvY?=
 =?us-ascii?Q?QcS408kuT525PiiNz5AhS8EqoqhtqnrT7UAci0uge+Q3lGTZnF60hl4tE7+I?=
 =?us-ascii?Q?REjw33n9w8wbMy6+GMzL07QrX3fApH9VEYd1oyxzox9G8bkH3rR5C6wjw8oB?=
 =?us-ascii?Q?6e8/DX74c4HA2vv4v1Edi2vzXTY9iM7UM28bHb/De4TTgwibI+jf74V4zZfq?=
 =?us-ascii?Q?TeSD4bKyzxhXT1UV4qOZlNN0ecjF5LoIoEF/1OEx+BmLeLqytRaNNsBYxyMF?=
 =?us-ascii?Q?IT0ESc7XzwnQxkfSh96og19pnTadVm/pxyp6K1wWPxUOgoDt1Z9mg7cvOC+m?=
 =?us-ascii?Q?D4JQGn2Z7QgTVJItDcD06TgQcqM/fgrgOc6xF60/7f+ul/Js7vdFsVFzzfiw?=
 =?us-ascii?Q?C/XQXKT6fh2MSBs13cqtYZLDgTNy91M+WgDRR91GpbJ3bc7+xa61pbZtffGY?=
 =?us-ascii?Q?CQh4j5wBnrKF4lOQn8E04Eg5HHG0IdYugUa8btd46w8f7esXIwQ3?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99E36A80A2265A4C8F4AA457D6783DFE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00cf4b3-67c6-4425-9797-08da44ffa51e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2022 01:23:20.3316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGVbGpTdh3ON6jlLICJxEa7AMnBbhwbBBqDIC7RQqmlzuc/02LU+wVtYVjR243W7nYHISBdadjGg27hjNYxJr8q0krU+fr10AO4VZjZwi1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5030
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 01, 2022 / 08:48, Christoph Hellwig wrote:
> Hi Shin'ichiro,
>=20
> this series reduces the dependency of blktests on modular builds
> of various block drivers.  There are still plenty of tests that
> do require modules, mostly because a lot of scsi_debug and null_blk
> can only be set at load time, but I plan to address those in the
> kernel soon.

Thanks, applied!

--=20
Shin'ichiro Kawasaki=
