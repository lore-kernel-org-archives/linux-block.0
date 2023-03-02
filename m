Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB21EC678D4
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 07:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCBHow (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 02:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCBHov (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 02:44:51 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFC82200B
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 23:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677743090; x=1709279090;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cxFjSYk5d9+58wOE8NWgGwgO4t0jRhbbOBLoFQbE4dg=;
  b=TnvjmriIoyoO7OPwKFJj9rfENLagu+CwHbwsPBCZtKKp3tzU/xphxXN7
   WoMNTICnBipkx+P68s6NpI5Y94GC/ZNd/r8a0fQ0m1LWaXhtmlmCPeV+e
   /pX5EEeRwMWNJYqFH9RsHjxRGXIV8EkzwCyUG7Qr81PAunL6QoBcfxHd1
   DPNzgM+LE03b00lxiGj75LfkfFzXDZPxQQHnAGDcCQN7P6jTH7EBcsL9o
   22i9vwiGSXKfl62BOVFVqhrLThXeRoeMCOXw6MEs67snYkL+oLK4xnODg
   kI64x1dMlQvVfxiMNhYbLtzivXKnCJM6P7tQ0Sf9hUxnL7ATb9TOW/hgm
   w==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="224606855"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 15:44:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDAKGPCzgUzkbHrUN9lDDKFgMKDoUwEkCQKegkVqyqq5/F5sMAmAovRGZxJgfxud83crCRScPTgNeB2pHUPnm9+uai8RP0h6hi+vK1PJ+bayVQ4Fum2f3BPRla1QhoXKQp7mGTNkueQToEAeCNgTejZ/sI+xbA7gYNKgO3+3OJH2VJ9ueDCc6fJFDVVC3TvfR6lFSY8T/10rQj+wwCioMogL5eeL3FWU3gzEwld+b8y8EFkdsHhvJDzPZhoz4L7p7Z7XScOHUyDzoEdJeMNFoYYo75eFOuBHMAgLwgdaLx2FGbJsrWY3+IeFEX/BHmyQRZQN+bLOccjUGa1tqi6ZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxFjSYk5d9+58wOE8NWgGwgO4t0jRhbbOBLoFQbE4dg=;
 b=VlTDzk3rljkcPYHzllr6nOHaR+JfdbyzBi9cC0D3S7yKFFomAHXrJEkeLVYN8TJ82pn78U5f3CrX5BEcl7LDLbzmmtIGyg/vg40Kg7jBJvmZCB/ybK5UeZsYDEaIW2C0wyW4CAPOJ2GXmQa+CZws3Lt7rTxamNUMihGUjaKRacSq8zBw70n+hEuNJ+7SdrswKN2YS0FbXVc3YGrjB5fMujN++uIwZ6nDLKCryYIYpbM7R6/FaS6FDVU/+D38xGgWd56BLub+FTzfA9l+/fLQyWdagscMlZNoytReRmccj8C9sZS1Bi4QrH5AmTxfHFwU9NYIGqGbiy4WR7kZffIbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxFjSYk5d9+58wOE8NWgGwgO4t0jRhbbOBLoFQbE4dg=;
 b=g0c2HTCg5ep+R/wLmMdBzGCtY4it4XjeQvo1/05GgD84ywqURkQ4SYllyGlEGSHgggwvpQcaSq3+4w4G7rYkKZLgenZyKbnqB49FhbQE7iajOA42g3ZEIvoVqQILPbzW8BuLyCtgPwAeihhAPMD4xrjB8zYI9y/GHiXYx+bbeUg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6840.namprd04.prod.outlook.com (2603:10b6:610:9d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19; Thu, 2 Mar 2023 07:44:47 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%8]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 07:44:47 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH blktests v4 0/2] blktests: add mini ublk source and
 blktests/033
Thread-Topic: [PATCH blktests v4 0/2] blktests: add mini ublk source and
 blktests/033
Thread-Index: AQHZSE3exEEzalLdzUWhdKDvbVsc467m91SAgAAtyAA=
Date:   Thu, 2 Mar 2023 07:44:46 +0000
Message-ID: <20230302074446.73egqk5bseexvqg3@shindev>
References: <20230224124502.1720278-1-ming.lei@redhat.com>
 <fafd397d-0590-b6ce-121a-365877596ee1@nvidia.com>
In-Reply-To: <fafd397d-0590-b6ce-121a-365877596ee1@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6840:EE_
x-ms-office365-filtering-correlation-id: 981eaca7-9d30-405e-7440-08db1af1fef6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bhwkc0Sv0FGK2vLTUvk3CiPohnHNmMK7ivVsUZQqid4HqrhD1lVbNbwSw2ic0b1qgFrUupkJiKae1cwZBTgxM0rzUsse5sooDc3RnQrYCyS46rlDM3r8pjtiYOnp2zAQF3vBMByVmJojIG630vLPcCi95SQP+IIMcW0VC95QWyF7TekZZwCP9H6sU2tYVWfy0Xps7a0EHOOT7ev2WuEUQl91I7yNcg8v/pFjOr10z2U1yAwkb8mTd+toId8lJx9AQOIyp8c0nKO64dmjhbVMYBCt08VDmdHrt/sEchTdSKBTcXduRI2MyUXpW62RgcneDe3woAYrM1BivYsBxc8NVkZ7cf3Bit6Aqi1Cj+ilklUhn6kN/D1eLJ6KTIscfap92l6X+OI5PnyW2szsVWBfmWOtE2pUn2VMkHmdzlwai7FnIhXl0A/y193FqtSaa0AhxoSTmqehvd8DXQ56iYDa93lx22LTa7eWPqBto5W27onicfjxqQqu1gEOi/swS+K+6TXZyTEc8irvN5yhpd5kHs50NewQLgI7D3A6b7w8zz513txpZh3tUUdVXnpeZS9C1HKWcys3Og2QuzewIZQXJQKf8cxRNywaeG73KvKJfpBIPrhsyRi+HBwsJ17uzapPDEHoNDYqE0GiEDUVRUXitb9TOATF5K+buhasW4mYo/0SjaKYiHhr9A1aILd+5mvBodUdzlnf93FqfdbcVBE9IA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199018)(53546011)(6506007)(1076003)(6486002)(9686003)(6512007)(186003)(26005)(316002)(41300700001)(54906003)(91956017)(4326008)(6916009)(8676002)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(44832011)(4744005)(2906002)(71200400001)(8936002)(5660300002)(478600001)(82960400001)(122000001)(38100700002)(33716001)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yws+Yvxef5s68xrYPVSeTEp3JQfnZTxtlUKXeQKcfq/Vd/HUxlI4hmMLGhxq?=
 =?us-ascii?Q?TlAlY9jWi+QJpLbe5MkCXXUp8zjMlTs9LP3eT2005wCnE7XixHouCMQXUNPr?=
 =?us-ascii?Q?GLUMQY+wwLoenp7WrlJHoha+WRieRWgDCJfa1aznwzLhH2gpjrZ+4fHwsBMx?=
 =?us-ascii?Q?zJvxuLPWuNjUWhjTpSGqSDa0zEvYb8AppSRx0JsaxBjAE2LhwBN70XdojRAZ?=
 =?us-ascii?Q?HWiC3p9Jo0M6cluKLDm3+yE+S0N74AMt6afEgb0lCdjeV3JPV2+RcJjgGHtI?=
 =?us-ascii?Q?Kyy1gnBxXGPBFnoDys55f377IKeTmNjFCYHNA7uXpW8P+fwbDgeRXOMEGVSU?=
 =?us-ascii?Q?0/f2+803oxxxAmClnb3KGP2/65zF9HBc7T2ejV8xIcUWiTxFOAJCiSqw4ySp?=
 =?us-ascii?Q?AqT/623Qn+Zmz+7HgS4t3WSITBVYadYtZ5RscHIpDcCD1EMmmSB1gwWo7nSE?=
 =?us-ascii?Q?gWhbXyOX4/7honpJ5STlU412z5RgvaQRmkQW1nt6ol6uerR/ZuWeybcebJz/?=
 =?us-ascii?Q?Vw27RVUB1VlxrBTdE05tMzKl5UxsJAWHx3c8ZePPhBuumlSzBmsTuL6r3sCC?=
 =?us-ascii?Q?BT/3xpmROMx+i8mjXpK/kaBHJjnDrIK1+SlTIDcJimfgcfJ0Uz7C+/fEu7da?=
 =?us-ascii?Q?wn1w1how1D6hKuKADs1LajsbH4ohvlVgpyNXZtDGySZMLJupayIS6O/xGjZv?=
 =?us-ascii?Q?KrGbd3DjGAa7BJBuo6bEn9mGrErRRORA3mpkLpSsm1OtUGE2e/dBhjCXZjyb?=
 =?us-ascii?Q?NjXb1zKOI3ckUse3KkLQP8v930rLQMguiFyataVl/ptM8DPlVtysSLOY/p70?=
 =?us-ascii?Q?XhteYiUHIWDVYuxnoknS/tu3i1dRQ9FiPYwT8XI5pXad0fQ7GW9Ub89CQ+rc?=
 =?us-ascii?Q?My3eb8owTUuRgocWbqI7vV4cxLoodIor3GI5+SxeYzeCb1r0c4PWk5SF8lcb?=
 =?us-ascii?Q?MYUnxoxOtW5RlQAKdcoX0NOkIJcNd3D0IqjY9FWsnui2B1vizFgCRcxG4I6y?=
 =?us-ascii?Q?xU1LKG8/56la1sar/jYZqB62AyoU1JBUp5FL7uCFPe2COnrSsKcZM9Ao/YwP?=
 =?us-ascii?Q?gr5tNCucTLLGHNME4w9C6UtfUc3jwndCMshmpx2g7HSOJmpskbDnUQyo53vC?=
 =?us-ascii?Q?6ShJ84QBw2sOWbwIcG9faG1CU7uqsQBEdT8mKL9qbxOffpfxGpNVokg3LSzM?=
 =?us-ascii?Q?vOrPgQJlyRESV3gRFvNH482BQxluhwFPgi/TjUlSQkppvvAV28zUfmZmDsBz?=
 =?us-ascii?Q?Tg4TTNkzvxodozw2K7HvPDqqXXitkAj5zi/ulsxqz0SLnobS7hhw8414/L2k?=
 =?us-ascii?Q?anZ7xovTqJAbWK3xR9gsZZUlG2TcGqUd7PAruXQS2XycfAfQYMnKGB/XmTEh?=
 =?us-ascii?Q?nywt6uc2nvYxBKpwux3pqWhrXGC4GgoZLH/JAlgIdQ51TJDaa0ye5MsZcVQR?=
 =?us-ascii?Q?KALnbkAWb0srKd1yM2Emg02NgFKmDR/I8Oy5AiOIoaFqerJTT/h/ylE831A/?=
 =?us-ascii?Q?95vPfv7qy7dQw0/VBS9asMytxK8WsDXh2wE65fWbfKSDyarYs7YVXWVmJ6cS?=
 =?us-ascii?Q?0H4yYg7aHwdHVt6ykrgqsMoFJRR1sTY6IFM2a+MIzKsOZiIOHhzOOHydUY4d?=
 =?us-ascii?Q?fN2ylgc24V7OpNWLmHmIRPg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <439F24B0C5AD794D8A5D72EA6A25719F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Mk5sGb2jXwF04f+OUB4dZ46yS5EVOVhGQ/VmKDzFk/piaaPpPV4ueJeCfA+0VNXjyh9juQJom6ZMjseGxR4H8G0jKjAg+OIv8Pc4MCo0TAgSvzbdleLwGtkshR7p55kX2FCM0FcUavICfwz3Me3KXVZ7E/OpMD2W3c5zG8BLRPAMVqrngxYqiJgptd9pnexZu+So2PT+CuL5cAMMXqgtd/itTDW39WjubjLP6rF+5nztENNV7uhtPyKidlw/DpNu5A2lMjh0Jn18WC2VIixH5y9hKuIPOmpUpf2ojSp6ZccJ1gTE/AAn+qnZZNHjqbaclPF7/49/v8bxKzxvt59LyC9wq8VtsLuPvZISc9JBtkz6559tbEO05mhVfBY4bROLRGe+8MNVa8WA4r3H2aoyy/fCRWXtPOaNQbYPowPDn7GhXWLH5B+ruGHQgD+k4/hFAoFt7vnhM7EjqyVSpzSsCEbX0z5HPM4ikd4aQfEfDCTsj4zwJl/jqjzhMILPpPXiD+fT4QCGps43Bhm92rNtDTnH621lt9xXDoTqWCT+V+z15S3uoz809pEAL+W4UVvUGnx4Hnd7X/OFMU6u7gPT7A+a9HBygh+lhfL9QmeQPBVlQ9JzxbN9Dl+LfIeB53YgKPUoXxxlndiyZ+ERHwPVDwDsB7IW0xA0mOG81LsxE+wd3i1Ep3ZNAPAe6jfrhTfj6o/FuwC4x6tuXwYm1PDVDk7l9aybMHkM/gRTXqpgRvHqJt4DQKEVs7Yumwe0KBdKKF8XfWQCchqThNoce+I5/3qZCxdtvObEjGfWuB5RRpeCfWvo7xqZZOSciIqh/NZi8FGH5EbDuYZ5VjBMPBjD/e9hvZq7DIwJmhwTa9HtGyUAhUcPtZa9NbQwyDg3RDHv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981eaca7-9d30-405e-7440-08db1af1fef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 07:44:46.9905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dIHxiuE+SMHUfi4rU5ww+dlcPTsrWV9TpkCHRVfR+p0S+N0K4jyitQzVbfsUfbiJoZlZu31aldkLdNYjKoXHsTsHNv7t4gRljaJIhv37sdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6840
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 02, 2023 / 05:00, Chaitanya Kulkarni wrote:
> On 2/24/2023 4:45 AM, Ming Lei wrote:
> > Hello,
> >=20
> > The 1st patch adds one mini ublk program, which only supports null &
> > loop targets.
> >=20
> > The 2nd patch add blktests/033 for covering gendisk leak issue.
> >
>=20
> Looks good to me, feel free to merge it.
>=20
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Thanks Chaitanya.

Ming, I've merged the patches. Thanks!

--=20
Shin'ichiro Kawasaki=
