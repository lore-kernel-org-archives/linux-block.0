Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735B2C4332F
	for <linux-block@archiver.kernel.org>; Fri,  4 Nov 2022 11:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiKDLmT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Nov 2022 07:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKDLmQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Nov 2022 07:42:16 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE062CDF4
        for <linux-block@vger.kernel.org>; Fri,  4 Nov 2022 04:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667562136; x=1699098136;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S6+G668Jg9xGJjmWVMAKwMIJy2RaqfOVmAJn2LyzUK8=;
  b=I4vtjuyBltdCv9MZAIW+N4TPH8odzxI/pkSOYxLTm+AIj5DjU9fia5Qc
   /3IoxXu+VjjKBskBMKwpGzXcNtJTXXhCAq2USIdIvOo1KD641/khbf5Q3
   BXJXdeHt/wf0yWQTKu6i8heeM9I6kAlxiSb36FuzOhBOzcZy05F8d6u3y
   IRQj0rK/Tb53fGcjQfSJzLc3gXp5M7OFkOcyVIbn0uFvKobwFFpmKvK6O
   46CRzDKXNTcVTHwEzJ00nFdaz9tYqY/+yXcQO6Sw5fCSxLJyCajxoplxr
   YHC29n2JYPHq3eHqZ75eB+7L7Q5kzPoFMtlYH1uvjL1fu7QqwtsgYokpV
   g==;
X-IronPort-AV: E=Sophos;i="5.96,137,1665417600"; 
   d="scan'208";a="327595416"
Received: from mail-bn8nam04lp2045.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2022 19:42:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRoc83pZ3TVuFfOwfBCnDPL71EreBaXVowWNpk1kyXJHGkZZu/7MAokmyPH76nKChdkMl9uJSR5XVfx+jdf5DOsfhATAzUuoSvvJbTqau9l6fWab1xRswTTtHLrRCXDrwiTGXZ7h/GQDRj/ImStzEi8+MnMz9+fcxQaIxv9K5rYUXa2zbrhLukMZdHhZjkE1HYZYn0xC+a8bZ6iDM1OhWg8oNc+0/AsfYd60wwGZsyoJIhQsW3MK3l+pAZ2C73wC8IpNEksgKA/kzR/JFuQIvmidqpgWcnfmORNy4ElkXdGAbaCKz0teoHi+VRsEZ8Jrb0PhOpgtimuxCjhjF28Bcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6+G668Jg9xGJjmWVMAKwMIJy2RaqfOVmAJn2LyzUK8=;
 b=Qu6UvWMf42nrtmB99zRKCxTHmiJu7aVkC6SQqVQUf9c6Rg+N8GbSaJ9yUdGO6ZLGLQjHX5BNtfkZ1DT4dv/wLb1ijrpLst3+UEUcO1p9G5/ATQXC0AQJfGanZ82pW3ZFICA5hPjO78BhseBL+vZ5+kGJsLYNJvXlmsylYnxPPtMKskKNga5yx5onEfxCexexpzRzPv/phtC6cd7x/FYvaprSoFZsejPxjj4fsgTkINRxxIUxSbV/39eVxkI7SHhqCOEd2hWTFV7w8VVyZXIP3bwFNhgCRYtxiWfSXN2gwheVbxHCBAQ8XNCDwRT9Qz1yUx9s3cm7l8+OBoSC/GtD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6+G668Jg9xGJjmWVMAKwMIJy2RaqfOVmAJn2LyzUK8=;
 b=KA8UGGtuQnivssY+g4EyoOSTCADCcIHwV9rT4tAPByN3C47D/y0PQykvFRmkEFTsVanJ3vPlGBEO6L9p+TYgGdHdgTvdsyL/YA9Udq+4yiwCr40cMU5dYV9+v3c1W1IET0izlazcwMj6P/oky+VBDp69oPqitaYQepnO3afF23c=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MWHPR04MB0816.namprd04.prod.outlook.com (2603:10b6:300:ff::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Fri, 4 Nov 2022 11:42:13 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 11:42:12 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 blktests 0/3] fix and improvement for xfs log size
 change from new xfsprogs version
Thread-Topic: [PATCH V2 blktests 0/3] fix and improvement for xfs log size
 change from new xfsprogs version
Thread-Index: AQHY7mbYLPKYuUWNDUKQrOqIUgrDja4uqCcA
Date:   Fri, 4 Nov 2022 11:42:12 +0000
Message-ID: <20221104114212.vi45fza33ytlsgbx@shindev>
References: <20221102025702.1664101-1-yi.zhang@redhat.com>
In-Reply-To: <20221102025702.1664101-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MWHPR04MB0816:EE_
x-ms-office365-filtering-correlation-id: ac56fa55-9bd9-4f97-c369-08dabe599d77
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MQHWAxXVnYC8OsuGvFrCnZree6hNjua8JEFBETrfaZrYN0ZywiftGdNP2dycybsIex52aC66sOOWoILnkjir4gvaCE2xMEhWKB3ZLSBYDs3pKhKXi7WwFJNlFJJ9RzYy0ZJU1JxOLBYmRg1S8COgtrqSsR5CTqAs72GzN/1ekngiyX9kAKllpRhvbnzqiJ8k2mMBJuPz0gNhSCl3CP0mlrzaZaZCQjv4hxinvGEgM6caWDyNM4tszApRut7TdUcCi0G+nH8OOnOmi3ZpmKg1EWBGmiErc72C1D3c+HjmgmvP2H6llTvKZqTPR4Sqrh7WMYdrLkmMf6e0FXvSUKNtH+LZn2vB3qLcCml++ZOlcVg8s5X3fsveKIKTZBqTYEYxKqO3mZKVFcyU7wIrNetRPR0ZzpuryBULpMh/WMHQ4WoEbtQLgzQEhGoBLcO38XYfoI5bzctLAswuznSbkqN1g8U6c/wliMT0zTpjlBGznVOfN//qobXbSukRJj7f6MeTo/osP1d2QPAmr4nqJlsnU+P7ljTcU3ZIxEZILWdTxzSgwhQPKp9ZsddnJtHoym21Lrkf7OpmD3N4a6ccSrq/IYFW3KbLK8wut9X+YXnE7qyCbklslhfyBg2Lx68qTTtijXNHZjVbWJtJWvkCutnI1bz6pMoJ6WfxNtMxpBexJ3t0f3RMkLTyheaekUakUMbygbTRU90N5XfacSV19Q4VK6Fj92XnUEW56c/WzcG7GpWqzayxEkTtzVOM02LPjMNh7cB0JKoQljxIDr6j6yxkEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199015)(2906002)(83380400001)(26005)(41300700001)(76116006)(6512007)(66556008)(66476007)(66446008)(9686003)(64756008)(4326008)(8676002)(38070700005)(33716001)(66946007)(122000001)(316002)(82960400001)(54906003)(6916009)(38100700002)(4744005)(86362001)(8936002)(186003)(5660300002)(1076003)(44832011)(91956017)(71200400001)(6486002)(478600001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dhG3zAoHdfWrulmADNpSMZmsLc16SgPLM4zJHBQIch7RUVknq/M38cQ6jW7x?=
 =?us-ascii?Q?5va2jFFrTUrJkRFE4xY4AicKujvqHUQxBYUnkCjsQNeFXLo9IlW7Cq9eO9c9?=
 =?us-ascii?Q?Ezu7tmjZBubGgCfsLTGriOyfL0bU7XOfp6w61PJdu3uLTFZ9cSq/DkpPn6jc?=
 =?us-ascii?Q?2ndGHsmNLIL5PFVShOWWViGn9G1CbTQHLfv4QPlY/3AV0ZEoXW44tAd6OWYD?=
 =?us-ascii?Q?wdA5YTBqtwq3AqnQvSXk4wwAl/cnQ6y7jp84gVBCvvL3aE2pRnOzmPJAnDPy?=
 =?us-ascii?Q?D2qXUetGfg/VWekgsE2N3Ka5rJrRDc3w9vR2tCpALjW0aCgmcvcE9Xf0/pvx?=
 =?us-ascii?Q?fR1WWom3CmTfPXrCvVTaK8IjdFNlLZigMwnYqB0ywjxPl4zb+Nmk9hbmnHcI?=
 =?us-ascii?Q?ZnRzUrdHbMciTDzMex1ySpw4/ujAgoBhweEko2wfsXoi+f+kEG5qW50i1rKs?=
 =?us-ascii?Q?EW7FvC4zAYpQbDm+pf24aaDpIdTgT7mWQhWwdxqDvjiQSv3kjRxfyXwiSEH4?=
 =?us-ascii?Q?3gokSWNI1WacxcgHE5bwPumBE9CrzKPZaRS7a40SbsZKKcDMlidwCwdHmwj5?=
 =?us-ascii?Q?h08VmMtqEMVGsMoYF3qtpgWPZ0oqugcllwKgMmpcPa4oBq0gz0Hmq7oa2Pgv?=
 =?us-ascii?Q?uRFwBSOH5o09IceoQdODqRBytDmmHUGnR2UP9rvNlf3LnXJs70LxedouoFqq?=
 =?us-ascii?Q?9q/OYSOwNaUb1Uk01noC5qJtsQS4W3JaZdHNNU8hL1E1mSu85Qlbud8d8Alp?=
 =?us-ascii?Q?ma0Okr1eARkb4TSINyFUA16aS34Kzso7Yr4ce4a90JtkndzJrkuV/qNOCmpB?=
 =?us-ascii?Q?5xxQYuuK1UQs5z/kd0phsTd4xsMfcnqRMj6evhfHmIsTTo1Aio+297/i91f3?=
 =?us-ascii?Q?hEu9E1Ql9l1V+L762al54ClPWmYYe8IZyKNUQMIA9y7e0N6UOVC13fdzz3+v?=
 =?us-ascii?Q?yHSMsHUrJux+fQE1EnXAJkdrZz3tx8JqWGe2FibCrY5v8KCb5ynlH0U5yxq1?=
 =?us-ascii?Q?Xhlk66Klu8RYh0YEppgXtAQMJ4kgrWj88cWs0NAUzg7Pq7Ti/y92H4hWzd0e?=
 =?us-ascii?Q?NjKW8RlsYH0hU90Aon9MwLy92taKaUi8cRf0MSNKNOIrRGHYB2wZLn8Qu6JN?=
 =?us-ascii?Q?dt5rNAQzbMdjiQkXGf+s6HPEfc4LXqtau0BCCRNUSEKCIX3PSzD4m2n88yJt?=
 =?us-ascii?Q?XlNN7GKsxKGqCbBIOS+1+BpF2zhFiDnljtLxMttfOR/aWUhZmQ6Xr8iDVoSN?=
 =?us-ascii?Q?LIxVU82VIuX7T6NYcw8CBgC3tKkTJsJNaVlUugjg/0cr3nf+0WHqZwYqYIW4?=
 =?us-ascii?Q?ZceJsEKCoK7aXfQNIFdjG1yjhPiJxGSYa+lFdELraLGAmQ2gKhrVVNu4cWc/?=
 =?us-ascii?Q?Ma4nTjLjAdthGB+KWjxzREH8KTDzBTMxCRNqkLJ4NHPZgCUnAvaUV56DRWaY?=
 =?us-ascii?Q?Th56LXP1LjhdeRX6ID3S8udQHRN7xFJMDWfPCF5dC7sakcdPRPz0d4MB+EpO?=
 =?us-ascii?Q?y20tP4+30cuShzSN14CL5xmlXNiM1isAB9k3/c+vc9gvFOdafMxQEmyGQWWP?=
 =?us-ascii?Q?kQCA/RPZUXXd7EoVNbPXLoZRKDMRm0fB/+1myelNuZfPLEjS1sGdeHYk8rN8?=
 =?us-ascii?Q?3b0ZHmW/NxCLIyf2cqNkKWY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8224976B22FB2B40BF12BF7F40642FE7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac56fa55-9bd9-4f97-c369-08dabe599d77
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 11:42:12.9116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGb9NsNyZrDGPcApbV7g2bclS5Dojumxjg/wArnlIbnWdKz6xmjpEreB0kL2N/GrpPbQP4eEy2xAyiCqHoCRuB0YtIrHpRCLOSWdG4Vjeco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0816
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Nov 02, 2022 / 10:56, Yi Zhang wrote:
> Hi
>=20
> The first patch addressed nvme/012 nvme/013 failure which introduced
> from xfsprogs v5.19.0, the minimun xfs log size change to 64m
>=20
> The second patch introduced one new function _require_test_dev_size_mb
>=20
> The third patch add one new parameter to _run_fio_verify_io, this will
> allow fio I/O size definition to the test case

Have applied the patches. Please note that I took a liberty to do minor edi=
ts in
the second patch. Thanks!

--=20
Shin'ichiro Kawasaki=
