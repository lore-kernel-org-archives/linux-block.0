Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08505C4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 08:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D944161073
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 08:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhHKIv4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 04:51:56 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7991 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbhHKIv4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 04:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628671892; x=1660207892;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GdwPMu7tKkGTZp9556MQNDy05kVUNKJWreCfVUpLMCc=;
  b=GkOu29J9lBJOAYNyfEb2N5nmomol48tcz7v/vgFFXdBCX6Kt/T5/DX88
   gSRjNs+b/CkFiDiEnEozaXG34ncLFROItE2gqfZRPFaS3JEA2IsNe6jmb
   q//M+MQZ6pRfhb/YeXz+iH4ETZTy/CC9jbuxmfO8LllNSRzhNimMYL4p1
   RvlLmuQTVACdHuzlfwTvyt+/cPw0eiIZUvNAd0kbQcEG6L+ld5Yu3vLGH
   lZsL/a3Tmp4m+Pk1g5G+xN2QZjXRlpFwTrne0Mmq8uDWCQhGzABiI+hdP
   otS+tPKwnroKSaWszcm/xkc0+Dvk0rNhwxnSV1MuSlBTM42hhDlXH8J5q
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,311,1620662400"; 
   d="scan'208";a="181717033"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 16:51:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSNUrSAkSd+Bkrok0VlCgb0WOieswDn7yyFG48UCiQkQ84ymJjeZ0sNbxehuIs6QM8LVPnEwsZzOnOR7bdePjPizL/s+UXTLsErBCO6ZRZTBMGXAVi7CQL5K/xXb08p6Sap46iUIWhU+ZtSboAAo9W6KD0qOcoP4+FHVHG4izuLwiA9OLeFBsMBF4LT8weNdBdQp5v+L1MyjtSPgC5zfxPXgIv6VCCCMUo/Shn9QSGsQczaOqQGmleJU8Oa2pzPZVS0wykN+UAd6b/g/PRzqUeFth6vStzhnjy5jNfI1i4hWwMilpHwGET5Cw/tfs0f9w/hCjMzDr1lucj9fiEbK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gHy46ueO90qKJnA/7zSgu0z/TtCi02b8fMaVzYsZ6s=;
 b=HUls0fFLwCGt6FH3gyvDFwj5W+lIcZcHM6nUmNJaYVoSO2IXA/3SomjWdDW58/0A6G4eDcOfAr1JR0OkHTljv6zhLC6ctqqmY4eh/Zy+bBA7xJL71FbOz6Un5QVD+9XHT9RbwDap4Ae5aqdciV6HnTnc3r2tJ6qsJHlo9TLt6qX3I6Cst+Cvqt7PG3mp/Yc7umnTm1wcm8qsSNs780vtQ0YNVAIVm+BnpagMAvnm/ertxXKkSEZAX8USEywkHUs1jibhOS/zrhoe0pFfnsOpHCi4q4Vdu7/yzmAj8lYvFDfkuhuIhW/ogb6YLib89pg02r22O/NAG+gv9JtmgZ/bFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gHy46ueO90qKJnA/7zSgu0z/TtCi02b8fMaVzYsZ6s=;
 b=frHbm/7JyOLygR0jRPU9/ve1GX5Jd3nZ2qAh9ML4Yoj7HkplmJkyeqt7lk8FRw43qiDqD0AU5E6zYq49Iw4j2//l7EujpSrzJxYkZCvO+SrtEKF1QqxUHEwOfmjN481dt52HthrmTrMHDanmNKBG0daazVhNPg0eqHj5Nz4W/7g=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6622.namprd04.prod.outlook.com (2603:10b6:5:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Wed, 11 Aug
 2021 08:51:31 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%9]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 08:51:31 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4 3/6] block: change ioprio_valid() to an inline function
Thread-Topic: [PATCH v4 3/6] block: change ioprio_valid() to an inline
 function
Thread-Index: AQHXjmI7ygio9AazPkSFhGtRAF0BTQ==
Date:   Wed, 11 Aug 2021 08:51:30 +0000
Message-ID: <DM6PR04MB708110464CF08693EE8BFEABE7F89@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210811033702.368488-1-damien.lemoal@wdc.com>
 <20210811033702.368488-4-damien.lemoal@wdc.com>
 <PH0PR04MB7416DCAE9D84B4ED25E4C2ED9BF89@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e703673-db42-42ab-56fe-08d95ca536ec
x-ms-traffictypediagnostic: DM6PR04MB6622:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6622B2FB1DD0DF1AD3ECEE0DE7F89@DM6PR04MB6622.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xacg7fDRNBAxFj41dUCyFOWRJ+s7UL0kn1biPqNRedlNqp62U0AMnri46Cryf3hBh+yUv1Do0aCJydj8o9DYR1+KZsPwbc06zOfy3X5ONx+zWUgWMhxeGElRduMqfuD6CKyKH2gzL0Qjm4/pfYKo8fCU+OoMIM0csNE69oBDZUpJhziWGfInwdkHEXt5IBS1PgAlZKfmMuVATka/0CIqotxABYhJ3Ga7E7uYThrs+Lk1w/sPjAcBp2vJ1y3KpqNZFj6dmr70UOUv1jWRMiFsc+wEyPrxgCxYdevzV1YV5CwK3a96jwHsBb3uwIZfGwBrbbbdgJt4mjMH4jgO+8axiEd/PY37mwA1S3gAYP5U6i+mObEt41600O0HJbxXeYbu/HAsFmFmpWjbqIP2PGq9pog3zbSchrzxhmeLrK7PqnGZKdwZ40ZT89fP6XkVjQ3L+GgPwiTNaMM11h0X2+d+sOU/MIW5ySuntMATc52JXIj3PpZslBN40np0Z9tfJVBJA1WF+WNrJzyo7RIEVu8yh1NmZgdFdhaEpuLGrxKVstGBXss2iW1NXVipA4kuI9pSVdD2URdXTSj+Ox11jjSYpvMSAHjssLfpbbwp4CPpAGrHJY0IhinxzUJ8/XbjVMRI23LFQ0Sili8tVd/nzxER2SKWKYMVXoV+XLstKYlPgfUltdfq/uIaz+iL7A1IxWUuSpjS9ON8PGd2/eXN3OK3yQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(8936002)(52536014)(122000001)(478600001)(8676002)(66446008)(66946007)(33656002)(66556008)(38100700002)(110136005)(316002)(53546011)(6506007)(38070700005)(64756008)(55016002)(9686003)(2906002)(186003)(7696005)(71200400001)(4744005)(86362001)(76116006)(5660300002)(66476007)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tBZF56SvaLDJ2TqPhrrXXCjkPy/zP7x2tI+S1gLfsfYTWuk+iOmp7kG2sDQf?=
 =?us-ascii?Q?Cy6x8TMOQ5ze4JwOltLzmldtKCmHNKFJucpFHeAgaCptXY1luP7J2Ag5uuBy?=
 =?us-ascii?Q?pHnfyRgg0uG+MH8JAdKx4DePVjU3MQTZLaYM009T1Czth1ATrOvFbcsSVJkX?=
 =?us-ascii?Q?tKckAV8quik0gWC9C0azAw0eQhyG8aM0UqzLP9vqLHC7UVmFLg/YnKmDcam1?=
 =?us-ascii?Q?WArytNkIe6WbwLNfUnBZiIa4tNWbh0I1ICxMaFR19KZ5brty4FTYnkoYbe80?=
 =?us-ascii?Q?0OQlMJBPXhlCaiIxVGQGC/nFdpOipZ5/gmJvflJWBfn9PgcVSE+c6qvhALz3?=
 =?us-ascii?Q?SlrAMmpcFtkZYYkBI/oYBHEGYGsPtr/8P0DyysYFv8prxYiSSeUl1+8WtNPq?=
 =?us-ascii?Q?JNZM+4d//XaqjH5IVUm2T7jYfN095TrqwFadDqyaVFaLyL83nWOIskT4YflG?=
 =?us-ascii?Q?qVJ1hZf6te+9nzhp1c5aeAf+rCT/5r7gZDsObfPG69rpIQt8uv6AtxO9oCJh?=
 =?us-ascii?Q?yA8mFw+j0vIExWvf9HaywE+RsoTCal3l4L7RXU6j3weBY+aHRqbh1C2eUqID?=
 =?us-ascii?Q?kALfR+E0JPCpjeJujWKXpoBgJDK/iipEyBQmPy2k0Q3CeIgT/f/PIwXzZ92u?=
 =?us-ascii?Q?SVcxJlYKlctdGDIClGfM8zBZYJRHX6SOyGijpvKSDRo7yVjREUnb+ESk8eQk?=
 =?us-ascii?Q?VmmJqvNmvgGaNe5LNSzu3ZnR/6SBY4EEtsmu0L/sdyupCoD7NknrgJbhMV27?=
 =?us-ascii?Q?h2fwH7klHXZVVNulNc7/AhNFMYenYeEKEicj7PJDbg4AF5ejbq5XDT8ga24Z?=
 =?us-ascii?Q?GAtYXkw5uy6KfSnh/y1bc8hkcLLH5LLIFbGp5QNjZs2PO8Qpi3eZTQaluvJa?=
 =?us-ascii?Q?S1AT5OQU0/k/XEw3btJB0SlnIxJaYmpLPDElUzoD2lRwYAMRzJS9ydaKwgDe?=
 =?us-ascii?Q?9gSGqryp2RIuS771tSL1y4S1GZSikhtybYwQEfYy2U5g41dbmfcfvwgRnMOr?=
 =?us-ascii?Q?fhm6MOc7SHidBBhDAsb6UQTONIPuRLENl6rsdSTOUyKnNujrP/1DBPUZ2yCZ?=
 =?us-ascii?Q?i/g6QAX8gFW9zbXkhh1lgLCSRF4sPjxe0MTUTBjFBLLx+gsRlTklEbSt8AxT?=
 =?us-ascii?Q?NZ2d6x1LSsYTy/e+/XtjFimFdovutfJNtHJVoksIOJ/va8Lq6W7VN3ng3S3b?=
 =?us-ascii?Q?w/kkh4QdultqBhWAkW434ZOIPJPI5Je1z6nrvG2TEO972a+2cHb29YckcSlV?=
 =?us-ascii?Q?xZN7hs1fmuq5o6An/hm0taX47hY6kF/nvJgdKuL9zRLf8EVxDXy52RiUz6Iq?=
 =?us-ascii?Q?1eiB9Sud8aeMnnZzLDUFsna3a/+UEpasha4qiRhScH1rJRLt74f5+xn+3PZ4?=
 =?us-ascii?Q?lUbXUu8wXHW+pDl8acmhd2fcMHhsEPKs9HQ++x4MBtqOFi9ciA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e703673-db42-42ab-56fe-08d95ca536ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 08:51:30.8830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+5wSO28+s8M9LeXRtsLxjnHl6wbLutpZ/gpdLna2Iy+xaDcAy/lMv70dv98OwYCLBpqbj5HJuedg6k6DIKkMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6622
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/11 16:56, Johannes Thumshirn wrote:=0A=
> On 11/08/2021 05:37, Damien Le Moal wrote:=0A=
>> Change the ioprio_valid() macro in include/usapi/linux/ioprio.h to an   =
                                     uapi ~^=0A=
> =0A=
>> inline function declared on the kernel side in include/linux/ioprio.h.=
=0A=
>> Also improve checks on the class value by checking the upper bound=0A=
>> value.=0A=
> =0A=
> But I think it needs to stay in include/uapi/linux/ioprio.h as it's there=
=0A=
> since the 2.6.x days (I've checked back to v2.6.39.4) so the chance of=0A=
> user-space using it is quite high.=0A=
=0A=
include/uapi/linux/ioprio.h is being introduced with kernel 5.15. This user=
=0A=
header did not exist now and in previous kernels. include/linux/ioprio.h ha=
s=0A=
been around for a while though, but that is a kernel header, not an applica=
tion=0A=
header.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
