Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6546C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 07:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B4C60F92
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 07:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhIOHtC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 03:49:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:49633 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231364AbhIOHtB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 03:49:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="221914103"
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="221914103"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 00:47:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="434032384"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 15 Sep 2021 00:47:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 15 Sep 2021 00:47:42 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 15 Sep 2021 00:47:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 15 Sep 2021 00:47:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 15 Sep 2021 00:47:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwLPaxGtTskdLQaimnox2bN1995YS7Bgwib+KlzujQO8/pyrPIl52kTTJcJQI9K/LqPVBEx+i0Pc49kYsQlk1/XMdXVSpzY2PhmkSXI7jkSf/6D5vz9PjwOmKz7/u9xlnXGsGgVQ+u9/aGf7NVR8CziLAJ0YUcsgwGtPQWTvZmu0mHLjNRUe8Cne0wD7LnpTrRIfGefmVdvag5yNcnqrBCfcUs9AIuFpMisFM+8CCOxeXLeakwHpK62E6cWaVqTZ9PahmltChy6hjnmdBsCgxCVO4Ya3yTtfPRGSyBO1bpsKjkNy0VyG+G0S4GdJij9T7RllbZNw+OTlaNmNSxhfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ls7nkV+y/BzsSkfs87pGkkeKxG732fP2cKyfJnA5Uv4=;
 b=Q1VzHKDzg16URE07P8dYUb7TVry2+6UgyP0AVa0WyenazyYHrx6vCBVk7/5j1K7OvesFsWuG3+KjCY46B4RfYH3hugYiLf7ym8J34PHhl3J8NuPscntrQqZz2bnzdOtPPJmqhYTX7108gjQTV3x8zEzrADAf9KyI/QXjYPuQkSMN1TP8Az0T0a3HfUn0H5rmKAjL3YWxc2Jz/71ppGWXqmNAmJe0mPP5Ec8RCS6CS2kFIpBpKCHPGpmzlKklTUZtm+bV44k+mjOAdGdBzPxwklxCl5/WnbEtuKGrBWmYUsBqDXNOyhBm48PNaGotnBKOycfKjzV1KVl8dKA3DQxcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls7nkV+y/BzsSkfs87pGkkeKxG732fP2cKyfJnA5Uv4=;
 b=hk7M4BPGy5tmZMo+7K8OTFclsqFMwxKc5JCPnUb6M6mdJB5z3cAa3TrBsnSASbUuM/mKIreDHUV1/EueqckgcKbaVyqvwYvXMUda4766gnSFKf3xrjUISH554ZYqOxP6GHLhWxo3IZxpuZ8WOMWYZzuG9j+HMdAp+hjsOsVC+IE=
Received: from DM6PR11MB3932.namprd11.prod.outlook.com (2603:10b6:5:194::17)
 by DM6PR11MB4755.namprd11.prod.outlook.com (2603:10b6:5:2ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 07:47:34 +0000
Received: from DM6PR11MB3932.namprd11.prod.outlook.com
 ([fe80::b029:69b2:f711:b6e5]) by DM6PR11MB3932.namprd11.prod.outlook.com
 ([fe80::b029:69b2:f711:b6e5%4]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 07:47:34 +0000
From:   "Zhu, YifeiX" <yifeix.zhu@intel.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "Li, Philip" <philip.li@intel.com>,
        "Ma, XinjianX" <xinjianx.ma@intel.com>
Subject: Re: blktests nvme testcase error
Thread-Topic: blktests nvme testcase error
Thread-Index: AQHXotDIQ1BReCa/Bkq4w9G+UpzGzKuYJ90AgAycgFw=
Date:   Wed, 15 Sep 2021 07:47:33 +0000
Message-ID: <DM6PR11MB39326F8DA10531EE067C801484DB9@DM6PR11MB3932.namprd11.prod.outlook.com>
References: <DM6PR11MB39327C5E42F053888DA37BDB84D29@DM6PR11MB3932.namprd11.prod.outlook.com>
 <b26b4808-fd69-04fe-dbd4-fa45fa75b5fe@nvidia.com>
In-Reply-To: <b26b4808-fd69-04fe-dbd4-fa45fa75b5fe@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 584ddde5-4dbe-b840-fa8d-3b2a05686c51
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 506fe4cc-acbd-49d3-12b4-08d9781d1460
x-ms-traffictypediagnostic: DM6PR11MB4755:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB47559CC61339CD640DC0F96584DB9@DM6PR11MB4755.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4VwbFTUUokY+WIi6zd5P5OIyYTyAwdVTzTyJM9EseWMu8psMpRzWzPdTkEU71vtTGqjATuzPru7p7LZuypbimEKjAY0ntUkwTdMIBxP6JzaCYOZKnnKtwkM5pyS3jMy4HFGiVi8oOA0CXRCTvRYJ0+F91O474HF4IIZXOeZsc5pShZCMt4XMgM+p4E41j9C4UIic1X+sWpSaqJkdrMcyFUacB6KbitxeRgUn0jNd7DnLop6B2Nbk13exoD/lFl+3p5spvLIm9RHaCBXA53xxptS+zOjVm7ZTPvU1LpKxQhjAuTG1vBxabGWnyA5GIL04CoYRJgLNo+icjsnhpdoconuMmN4S+MPWkQpZEKXTr/xuwdhteKXODa096GBu9zk5XRKyoyB+tCUGrjKc/wdHotzZ4QFUJEQH9pcpVeRRVhDJMSdHVvpDEE07McrbRI8NO0PSNwRRuKUrWoWBXCkQSGLLT30x3q1xqXzHi569WKLyed4px1QXV/AaiUWoLAv/gMU2oGbe5+UHSbOUKMlNPOjIvCn8rMiOIRXNzz1zysokX0dRK0mB5PdBeqB/+NmxqcP49/72jrzDqwRI/FRgwSU4acAa+WzhdA8Fx58NSdHAKq1pTQCyCwfG40k08J/PbPSGAwRRA25ycVotAiO9VsYZiNkhrFzrUUw9a8TmRqku3TdPvVIz78jcguJKvtA/P8WCsDcIMcbvm54enh9ewg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3932.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(9686003)(316002)(3480700007)(55016002)(122000001)(54906003)(110136005)(52536014)(4326008)(478600001)(5660300002)(86362001)(38070700005)(107886003)(91956017)(71200400001)(83380400001)(2906002)(66476007)(76116006)(66946007)(66556008)(64756008)(66446008)(8676002)(26005)(33656002)(186003)(6506007)(8936002)(38100700002)(7696005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WGh3bUlYano5MnpzU1ZwTmFla3hjMXJGcjc4RDdzbW9MZitVU0R3MEc0?=
 =?iso-2022-jp?B?U1dHWW5YZWRPQlYyTUswbitMelA0S2ZSYTFJM2J5RUZqcTNxTUxxTStz?=
 =?iso-2022-jp?B?aGd2SUVkWm5JaWpuL21kaElzaWhIaHgvNXhCMEVoTnhGNU0zZDYzQ2lo?=
 =?iso-2022-jp?B?azZCOXExNmJBY2FlRFhoOUd4M0QvRERhcDRsd3MzOTlzRlpvQVhZdXh6?=
 =?iso-2022-jp?B?VmVRaHN3OUp1TldhaVhZNzdmeU52dGNhVllndURaSmQxcE1NRTBRT01S?=
 =?iso-2022-jp?B?SlBQeDRiYWVlRy9jWDg3NGtnYWRMK1o5U01QaXpTV05LV3dlNW4vTitT?=
 =?iso-2022-jp?B?aHgwZmt0WGZGdWtWWDlibUpQeFpZVjlGcUJtY0xLZjZneW8rVytkNXQ5?=
 =?iso-2022-jp?B?eWpwbms2YmpSZC9lVzZhbmVGT2NBWkdqQ0tjQmY1M3hzeHRGbG1SUS9y?=
 =?iso-2022-jp?B?cUpsRmFWeWExMDdhbThTcUhpQklZT0VPUU0vNWZKVzJpZG9YeGZtQ0VH?=
 =?iso-2022-jp?B?YSs5UTBuK1ZEQlZZUklRQVV2SXd3a21XWk9oMFMrY05hVzlTL1dMRVVV?=
 =?iso-2022-jp?B?a3JiMTVQNWhFL21GN1VpenVDc2RGYjlvWDJvOGJiOWxyR0ZkekZ0WFBB?=
 =?iso-2022-jp?B?T2JobHIyaEZuVDNWVWV1MTd6ZzI3dFZpMEdMVVNaYW80RlF3U0JXcnUw?=
 =?iso-2022-jp?B?eTJtSWExTEhVYlQ5c1V4SlFLRk51VDhYUmxHR0VNa01IeFZvK2xGYUh3?=
 =?iso-2022-jp?B?enh4MmZCeHcwblI0YWxRSjRtaDlJR2JseDVNNnFQOHRQQVVzM3ZtcDJt?=
 =?iso-2022-jp?B?N1V1blFHS2x1ZENIUEFNcmpiWUUrbzZBK3NTME1vQXdTVUpSdFFnSnJW?=
 =?iso-2022-jp?B?UlhlNXlpT3NHM1htZnEwUnJlbWFkK1ZFcjVJZzdCbWJJVVFNaVNWaHVt?=
 =?iso-2022-jp?B?WDNYcmx1enJoU2QzUDZRdDBaRlNLVVR6ZXdGOGQ0MEdHeDV0YWgrV0Nl?=
 =?iso-2022-jp?B?OTRMblAxYzk4azN5aVpUbmFudjZIK0hGdTRKWWE5OGpKb0dQVG9MSHdM?=
 =?iso-2022-jp?B?bWpEY3IvT2E3Ymt3bU82UXdIcW56YUhWYm9FdFBDYlVGRzZuTWc1VXlL?=
 =?iso-2022-jp?B?eG5sVENub2orclpGeVJJeExvZjVlbkh4QWx1cTNvQ3ZHRFRIM2pLaVIz?=
 =?iso-2022-jp?B?TjNxMW55azVpeE1PUzZDODJUVllYNWNqUHI4MTVUbVdORG4zM3phU0lZ?=
 =?iso-2022-jp?B?andlLzF1TWc5c043QXJuYklCc21wWFJYdk5GbU5oV3lOM2xGQjFxTkFV?=
 =?iso-2022-jp?B?M0g4T3hERnBGNDNqUFZnYkIvejR3c2pHMzVaZzZFUlFJbnhsZk92QlJr?=
 =?iso-2022-jp?B?VE1RSnZJUE9VU2RoaXlRTlJwc200Z3hqY0cxR1Zqb05wMW85Ym5GVmEy?=
 =?iso-2022-jp?B?QkRGOXpROGtlMm5Ga2gzMFNJd2RZYmJlNkgvdEVGRkIvRmd2ZFhJV3cw?=
 =?iso-2022-jp?B?RUNCWmtuS1AwOGdLYUZCOFI2ejlXWlhObysxN1pNZWdCc1RmWFNpSHFG?=
 =?iso-2022-jp?B?M3g4RXBvN0lTL3h1Z2RRME9uWm9kZk83UFJTZUxFUjk4dEdaT1N3RnMy?=
 =?iso-2022-jp?B?OTBMYnRwZm14TUlUR1FlWUt6NjR3ZitkcDFGazRvdnNjYnRSRGFISTJX?=
 =?iso-2022-jp?B?RHhLZklVNGxFQTVnSnNPcUJjek0ySHJxb2g0U3N6c3BraEptdDdXWllC?=
 =?iso-2022-jp?B?dVJLaGMzM3lUNGZhU0MwTTErU3l5Y1MrSHFWckthOHR0SHlEemZwZktx?=
 =?iso-2022-jp?B?ekpRVkhjOEI1TG5oajJBRzZTTi8zN3Nla3RPNTZvRFVKc0c4TENiUkFl?=
 =?iso-2022-jp?B?M01rT3o0cWZCc2JwVUZWTHRLdWtCaHE1KzI4anBKV2twZ0hieTN5Sk41?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3932.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506fe4cc-acbd-49d3-12b4-08d9781d1460
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 07:47:34.0041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LBfLHZ0wQXzd8Jr4l9qr6rBxHIXlmmfIwqNwvYbmGkMRUZ1fuaSlo8KTmiwDj2z0gwDW7Fcu3Se9xE4WpKXSRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4755
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

thanks for help.

here is exec testcase and this case dmsg.

exec case(nvme/017):

 ./check nvme/017
nvme/017 (create/delete many file-ns and test discovery)
nvme/017 (create/delete many file-ns and test discovery)     [failed]
    runtime  ...  52.826s
    --- tests/nvme/017.out      2021-09-07 20:22:14.000000000 +0000
    +++ /blktests/results/nodev/nvme/017.out.bad 2021-09-15 07:37:57.844363=
924 +0000
    @@ -1,4 +1,1004 @@
     Running nvme/017
    +tests/nvme/rc: line 236: printf: write error: Invalid argument
    +tests/nvme/rc: line 236: printf: write error: Invalid argument
    +tests/nvme/rc: line 236: printf: write error: Invalid argument
    +tests/nvme/rc: line 236: printf: write error: Invalid argument
    +tests/nvme/rc: line 236: printf: write error: Invalid argument
    +tests/nvme/rc: line 236: printf: write error: Invalid argument
    ...

=3D=3D=3Ddmsg=3D=3D=3D
[  132.507288] run blktests nvme/017 at 2021-09-15 07:37:04
[  132.625368] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  132.641069] nvmet: failed to open file /blktests/results/tmpdir.nvme.017=
.pdW/img: (-22)
[  132.672208] nvmet: adding nsid 2 to subsystem blktests-subsystem-1
[  132.689458] nvmet: failed to open file /blktests/results/tmpdir.nvme.017=
.pdW/img: (-22)
[  132.719888] nvmet: adding nsid 3 to subsystem blktests-subsystem-1
[  132.737744] nvmet: failed to open file /blktests/results/tmpdir.nvme.017=
.pdW/img: (-22)
[  132.767270] nvmet: adding nsid 4 to subsystem blktests-subsystem-1
[  132.784708] nvmet: failed to open file /blktests/results/tmpdir.nvme.017=
.pdW/img: (-22)
[  132.815045] nvmet: adding nsid 5 to subsystem blktests-subsystem-1
[  132.833484] nvmet: failed to open file /blktests/results/tmpdir.nvme.017=
.pdW/img: (-22)
[  132.865054] nvmet: adding nsid 6 to subsystem blktests-subsystem-1
[  132.882758] nvmet: failed to open file /blktests/results/tmpdir.nvme.017=
.pdW/img: (-22)
[  132.914428] nvmet: adding nsid 7 to subsystem blktests-subsystem-1
[  132.932313] nvmet: failed to open file /blktests/results/tmpdir.nvme.017=
.pdW/img: (-22)
[  132.962468] nvmet: adding nsid 8 to subsystem blktests-subsystem-1
[  132.981265] nvmet: failed to open file /blktests/results/tmpdir.nvme.017=
.pdW/img: (-22)
[  133.011579] nvmet: adding nsid 9 to subsystem blktests-subsystem-1
[  133.031565] nvmet: failed to open file /blktests/results/tmpdir.nvme.017=
.pdW/img: (-22)
.....
[  180.912375] nvmet: adding nsid 996 to subsystem blktests-subsystem-1
[  180.932275] nvmet: failed to open file /blktests/results/tmpdir.nvme.017=
.pdW/img: (-22)
[  180.961400] nvmet: adding nsid 997 to subsystem blktests-subsystem-1
[  180.979499] nvmet: failed to open file /blktests/results/tmpdir.nvme.017=
.pdW/img: (-22)
[  181.008340] nvmet: adding nsid 998 to subsystem blktests-subsystem-1
[  181.027465] nvmet: failed to open file /blktests/results/tmpdir.nvme.017=
.pdW/img: (-22)
[  181.058338] nvmet: adding nsid 999 to subsystem blktests-subsystem-1
[  181.076647] nvmet: failed to open file /blktests/results/tmpdir.nvme.017=
.pdW/img: (-22)
[  181.105358] nvmet: adding nsid 1000 to subsystem blktests-subsystem-1
[  181.123796] nvmet: failed to open file /blktests/results/tmpdir.nvme.017=
.pdW/img: (-22)
[  181.183335] nvmet: creating controller 1 for subsystem nqn.2014-08.org.n=
vmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:71bd033c-1164-4=
503-930c-4bab1cdc09d9.
[  181.211442] nvme nvme2: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[  181.232221] nvme nvme2: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.d=
iscovery"


________________________________________
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Sent: Tuesday, September 7, 2021 15:05
To: Zhu, YifeiX; linux-block@vger.kernel.org
Cc: Li, Philip; Ma, XinjianX
Subject: Re: blktests nvme testcase error


> CODE=1B$B!'=1B(B
>      221 _create_nvmet_ns() {
>      222         local nvmet_subsystem=3D"$1"
>      223         local nsid=3D"$2"
>      224         local blkdev=3D"$3"
>      225         local uuid=3D"00000000-0000-0000-0000-000000000000"
>      226         local subsys_path=3D"${NVMET_CFS}/subsystems/${nvmet_sub=
system}"
>      227         local ns_path=3D"${subsys_path}/namespaces/${nsid}"
>      228
>      229         if [[ $# -eq 4 ]]; then
>      230                 uuid=3D"$4"
>      231         fi
>      232
>      233         mkdir "${ns_path}"
>      234         printf "%s" "${blkdev}" > "${ns_path}/device_path"
>      235         printf "%s" "${uuid}" > "${ns_path}/device_uuid"
>      236         printf 1 > "${ns_path}/enable"
>      237 }
>

You should be able to get the error in the dmsg, please share that output..
