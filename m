Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1E5C433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 08:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiKPImc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 03:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiKPIma (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 03:42:30 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E447679
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 00:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668588149; x=1700124149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7Vs39ZpGk+0IATtZdlWVnWVbCkWTR8nwlJZqLSpO3hY=;
  b=IPPyB9v8Cmupa17+XEF+bayBJQcDzbKs9N0ERjut16LKj+XP1rRbKjpW
   Np4kr9DNHdXQQeUFyp4/KdFati139KTKb+Qkr3R0NXlqoykGhPp0HM5PW
   Y+S13HSI6wl7wo9r/eTH62+ADYKMcyrmQjR9YmoH+9mQ864GqptvswAD4
   5qBMCXIb1D96/ujLdt3XWrzfmshZnkLLel9BtpZ0PqyeUZZ3V+awhhD1B
   8xzLyrxWuWkVbqwKVb4ELmKw0jyQLIFioxWrR0D9CcCjbXMTURFFfy6MS
   nwRwfy6enob7fNR/fMv6orX+g8NesgsyZ8FXFtQ4VdsXz/Hhr3+sTqBTN
   A==;
X-IronPort-AV: E=Sophos;i="5.96,167,1665417600"; 
   d="scan'208";a="221556878"
Received: from mail-sn1nam02lp2043.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.43])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2022 16:42:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxEb2TBfZnv/7Z9Mj3wcZTCiBGoLdiEeFFC4Ew1jPXDBKAdN3F/mUq9VL8YwRVAi7MJzluQHpJE2pbrVwKErD/ejTSMz2LYSFb4e3Tvk1LSgV8wNudUoJhGMKFYwYZL1DhwniTUhaj5yxgciNjy/a5AUwzVjzb8XMzigpQCHuc6YWEBuWVyecuLssqCbKahVT0SzJfcikrCULobO0Ybjam9q7TupzO82XuZ3JCksmWjnniDBytL4oszZq5QuOJsY5aoghHIk2pN9avWyDuQWwZHc0ZaDpUcm7SiHFEzRGmcDybqQrDeUISYqvsdcYdJyYF37DTnn80vcqokrmsYpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BgCOrGkQxbj7sqdzz6Inu32zjCHTecqNafmaIVzGLU=;
 b=MsMBJKWYF1vF5kkYgSZSGmx0kClEQe0PAMFIHsxXBUGGcBpO+EOyYpBW9sWGNyxAICj1MDf5hhYhmQzwLaXWHu2nlRUaDMpgpwHYLeUb3iz698LGNdK8hEI0xhqYNXASid8+SZu6+xDgG3PEO0GV9U4RSyOD0YlG83xCOVCzwBaEstpOpuZwDq7tqcn426ZpaLeWYA7QMiMnhICNk0cF2dchENh8zAybXLMKuoRgfLrm5DMYaVYmEp8sRbDkIPHxzVd5XVA7rJbx6hC8uQAyeBqr/5xhDy0VEa9P0QKYtNZiCV8jqC0DsD2gsK79ihnK4afwB5uS495kriKQqS1IjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BgCOrGkQxbj7sqdzz6Inu32zjCHTecqNafmaIVzGLU=;
 b=AhSqi1rzJIJdDWdA5kiM9mUDauT/fen8qDKpfI0hKGIGC8g5X5toyg3+dNC5oGVkpIegUUT1uDXxsogoOW+0uSsRxKea6T8cC6uzDINQYgPdlR9RrGjV6ayJn3escfrVUz5cPC2PvdQjTPSbaRa0ZzCdCzkAewSuAe8gdcLQubY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB5593.namprd04.prod.outlook.com (2603:10b6:5:172::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Wed, 16 Nov 2022 08:42:27 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 08:42:27 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: blktests 002/029/030 error report
Thread-Topic: blktests 002/029/030 error report
Thread-Index: AQHY+Ir0s7dvwA9xikK2tKxkR8tqiK5AZT8AgADYXwA=
Date:   Wed, 16 Nov 2022 08:42:27 +0000
Message-ID: <20221116084226.nfm4xvcq3jzbbj3d@shindev>
References: <5183bc2c-746b-5806-9ace-31a3a7000e6d@nvidia.com>
 <7f58627a-3b8f-a609-3f8b-362fd01ad2b3@nvidia.com>
In-Reply-To: <7f58627a-3b8f-a609-3f8b-362fd01ad2b3@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB5593:EE_
x-ms-office365-filtering-correlation-id: c878e4ef-9508-4574-3dc2-08dac7ae7d99
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8GxBYZ2y+1Hs7AVb8/92FP0lmKqU5y7/HniS8rKpch8teA51mGKGn1vJFmYT0umCZ7GT0be/an9VDkSo4VybYonVfnBMon1iTVadoyAORbFUVOcw4q4fijPYS7ZsegWfUzrjjpsyrftLp96NAjtHpMAkqqzZ+wSwtHajYHJloOWogbFk2TJFxbnqkk1P78A43u4xRRtPIPg4wudmHq8EL+hAqlMPCllWmVyd8xe/z/wSRch1ONr4mPcVyvhjsz12HmJ7DGWUg3WYQ81zfzRmYNhKN8VZfjOizzypWUlT+jZszgluvfA5f4iwjtsPhbc4iC6z0wIg/s4l7xIsE+EvrMl9Tg+E/VVCAKVMlmR2S0vwEn60HISguG/erbHpa/9WAmPEfY85Kc5DPFdxAPQSuOncYW0gF+a84OsfSFJWlmlI7o5o6Dxq+/brIOnA4DebkKZx7CsIErztEklemxexcq49wfTtKSmt2IHJxzdchnLAliExt5fyZNmxL315JSnl+4n5Oft1oHBWEplJm6QViHBdrY352YF8DIMayhLUm+LPrYTIBW/435QSl3U7xm3I3xjOYL0OoWjvZCmnNcel/92J5YlGgJLJgf+QtaJBuiabWY64gjIyZukNW4xdb81LAw14YD2h5C+OlmuGaMzXHGsuaiDK5y68SzfiNIwrLj8p8Z5K1MGtVSlPmwywzW5GcCmbGKs/PSEQ7CtTspItd663qXqfZG4/JcoZvG2kk/tnBz6StuM+fOKST7jpOOP4i2YYHResGwmGcwpeYuk/QQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(38070700005)(91956017)(86362001)(122000001)(1076003)(4001150100001)(83380400001)(6506007)(38100700002)(9686003)(6512007)(53546011)(26005)(186003)(41300700001)(4326008)(76116006)(71200400001)(478600001)(66556008)(316002)(64756008)(33716001)(6916009)(66446008)(66476007)(8676002)(6486002)(66946007)(2906002)(5660300002)(8936002)(82960400001)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CFHQGPZcMSSdw4WyJiKI5x/43gcZ2ywCOD18dY9bicNew6OVyFbCyuyzIkeW?=
 =?us-ascii?Q?kYJ2QDIRIqfuZulqBQjAzEhnzYQVNbbom6GjJ2qnoebUmOtQOyE0P6wD2zXj?=
 =?us-ascii?Q?wbKTpM3qieCU+cBv8IxSnzGlBX+qcdJCIYMZYxJF/WscCoF/5/i+DaSVAw0V?=
 =?us-ascii?Q?tleFM+YrOvYzN1Gx48bgLEMKkCj1uYzaRo14uhQhOyke2T6b/bMqS/cohOKg?=
 =?us-ascii?Q?Thj36EkoYTOmXiSi14E1FaArO4RdZAm8ls7QZz8XO0qa/bvn2sDpYoT7J1TU?=
 =?us-ascii?Q?0n2tkuCfSncF3QFbT6KJlrX5eRXScEA7tKFOPfbX/MECtWogcdzsuXWB6068?=
 =?us-ascii?Q?p9kg2uAv3l4LY3N+hBfiGNyiwDCkDpKOchY5VSzs5QIUrxzHp1KjE47IkU6C?=
 =?us-ascii?Q?bJ089gppcZfoCjJO+5+2NL2Iv7MEo/DYeC4dr+uA8SQJb6D+Cux2NxBOytvo?=
 =?us-ascii?Q?xPTswFKSZlA/RPjtUm5D+yMljH/ZXeus//7MzuJE3WmfuTAISSptshe49psf?=
 =?us-ascii?Q?1yAn6lZO5DoRNRY4GJosQZWUjFf+JfPm9SDkIGaE+OePORKiQ3cRAmmbEiH9?=
 =?us-ascii?Q?BeehXaaGmgePPNe2yEL3MackPgeLKg8c9ecTmWfcGJh2N+YwYbdS9F9KJ4Ot?=
 =?us-ascii?Q?HVYv1i25bni3LleZikxnwLf343GlwB/miD81f2PevIAlhO8sJWAv/SVSCg4O?=
 =?us-ascii?Q?2t+muNCsCE0y8HRFm0f1XH+qQS/saZ2B5NjBB4WSpIr/0in4JY8SWZYPBumf?=
 =?us-ascii?Q?aQS5j/TZnFIsAuwH6w3U/GZy/zIOnlR+z904jvlxwoI40O3/RL6AeYEibA/D?=
 =?us-ascii?Q?E0JWazKs64XmRHk/n8Qkzkc/Yva1Oiq5LUOmIBAr7nKbnu6hwC/CNK7752sf?=
 =?us-ascii?Q?/XoPOqYByHS7Bk1LAKtGc1v2Ojjr1KafmpIGQX6QWjUySNdiYUj2C5lBLaSF?=
 =?us-ascii?Q?J6zKbLtmWNS5ArbFXbHBlMPjwj5hzR2vM2igTHzjlhaB5QMKue/dZryyn6cx?=
 =?us-ascii?Q?L1XtGFna9N9/wXuxHwgyrLNawAB7YxYYct0PNJ6jwFzNJigNa4g4rVzsPWJD?=
 =?us-ascii?Q?dKEX518yzxCiEVuxaPSx0DrqcT/xyYVKTIkVRHRuig8r5EuG+x1gpJ5/iiMy?=
 =?us-ascii?Q?bRKTcrfbzmc9GKd4r6X+PKBCLOVtKxo+NiyTTCVCQRmCY4odTSMZA3V/ANPQ?=
 =?us-ascii?Q?zzy1bqaRi5Qr/eRFNBiXq8Xo/t5zcBrDAZGwmAcEtSjJmHseg6nBcuicrPVN?=
 =?us-ascii?Q?3KGbteA+mC6JLCek+VSQm/46mrh4ztZDOY/UrtSaWgTzPQ2sjMXbpLOHki0L?=
 =?us-ascii?Q?w0KHbCT/7BQXsR/+aDfssT9spYizfTuZmIxi9A6TgqAG2hVO+N7LqZXAyolN?=
 =?us-ascii?Q?3fo46DbpLdPfCl+vh3IM3cKS9jfMEMjS+7Qt0QD6TDet0igLDQJ8FLMKEUvJ?=
 =?us-ascii?Q?PakP7+tw1fReYNQ1I1YUiLCmiGTpsVu5RGS3XckGfZW6RqAMn+rfmE2nvdFX?=
 =?us-ascii?Q?KOibwkGdLWTkNhIXKfk1lGiblJdHtxSGnu1BGSlF+7jE9be2QDPM1JpN8+Aj?=
 =?us-ascii?Q?exC5KHrMEIFOEZRQUIU+DoemLnBN6jmZO2w4+Vy6HqRFmjUGt1ztfriTt9Vw?=
 =?us-ascii?Q?kQDnCUUhlEf2aVOOkXD8wPo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC19EB056103A94194F198BC73260138@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R4EyimMUzHAoomSL1b4BpYx/hwxHMiyF3IBi9YdB/oztO/Ti6k2kdr4zS3UW6fhUPShzk+k7wmN6NgfiJq9hUtDzVHkpcvhmbh7xpPS6ESMKyH7Xqj7ACacfITGX1+FI5SwHqxM+BJqAjH776jhO0IiGCJ8AsqXzuB62ZklcGyxgyAEw/EZUWqI0OTlUJ1hSoEHKOJR8b0i6T7WYcvTRvizqmET7JVAeVC2Ve3DKx8gim1IHZIyjxv8Kfx7iQep3WPG5+kaBBCc0pFJBWHGQ8sa8opCaSS+Y+ngqck9oWEjySpGEnfBbBN6tcaUOSK9Z3Us1dAMSGf/PSf0hWBidzpxhb34r5VQ8+avi2SQ1+YIGYRTWKoT87PSC0J+e4kHvkldHINBimGg8FdWG57kfsDqY4aCRSzRgUJqyoQSFKNHnJc7gSqibhwWJ+IbD5a5UsfC7oqtQBSB3IvP2M4XgDo4ag9IUf8xVMapUhXm5S60mRLreFfpLcLCzQx8SQwTw3+a8/xwQXUSgCplP6WnqbK4UFjYEF2atJlx9+YM7JT5PhsRGBdJ6Y/GLTTQnnaJn297LpomJzHTJvl1nZ6NlN3GftcjZmNw7DHV10AM4IoBkXxyA3r4YHAcdCrnRg3abBjk4tdvZEJG839Qj21tQ6SBVmAWjv8eKmqzuJuWaetMC/bx+JvESZM/BNHbDDrF0/Yr/brCM/HYCVVH1rl3ML62VEoyy53KGmCSBW3uu9iuYcni4d4+RBLuN/EQkhChqxzfY7CEBbiKucYv74N7QTRKYAmPwOeUSGfp8jtwIhCO+amzP3cmT+7JjxWwYrmPU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c878e4ef-9508-4574-3dc2-08dac7ae7d99
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 08:42:27.1464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYmlfO9HCGnEJgEkDvBODpc7JEpqA7wZ3jBHmdQfzKVzJ/9aVRQIC6UZClMV5svk4nu2Epa9qdJHVCFrmrk5k9lg3rhkAmY3G4C0beuQUrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5593
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Nov 15, 2022 / 19:48, Chaitanya Kulkarni wrote:
> Shinichiro,
>=20
> On 11/14/22 16:41, Chaitanya Kulkarni wrote:
> > Hi,
> >=20
> > blktests on latest linux-block/for-next are failing:-
> >=20
>=20
> Do you also see similar failures when running blktests block
> category ?

I've tried with linux-block/for-next branch tip at git hash 067707e91646. T=
o
compile kernel, I needed to revert the commit 958bfdd734b6 ("io_uring: uapi=
:
Don't force linux/time_types.h for userspace"). With this kernel and my tes=
t
machine,

 - the block/002 failure was not recreated
 - the block/029,030 failures were recreated
 - another failure was observed at block/017 [1]

Will take closer look in the problems, as much as I can.


[1]

block/017 (do I/O and check the inflight counter)            [failed]
    runtime    ...  1.854s
    --- tests/block/017.out     2022-11-14 16:40:48.486495344 +0900
    +++ /home/shin/kts/kernel-test-suite/sets/blktests/log/runlog/nodev/blo=
ck/017.out.bad       2022-11-16 17:36:33.028161082 +0900
    @@ -5,8 +5,8 @@
     diskstats 1
     sysfs inflight reads 1
     sysfs inflight writes 1
    -sysfs stat 2
    -diskstats 2
    +sysfs stat 1
    +diskstats 1
    ...
    (Run 'diff -u tests/block/017.out /home/shin/kts/kernel-test-suite/sets=
/blktests/log/runlog/nodev/block/017.out.bad' to see the entire diff)

--=20
Shin'ichiro Kawasaki=
