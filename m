Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F108DC54E94
	for <linux-block@archiver.kernel.org>; Wed, 25 Jan 2023 20:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbjAYUoF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Jan 2023 15:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbjAYUoE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2023 15:44:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D8223136
        for <linux-block@vger.kernel.org>; Wed, 25 Jan 2023 12:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674679431; x=1706215431;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=goQfAjzF6P8lkPN6NkKNG+nfcqlb/FordxG4lj/VYhQ=;
  b=XsHwbqP5szeNt91zhZT9AJlpQeIabKXmTsts/eIdO5U952w6i+UaOpxV
   idABY+WB0nIwW/pSruehJhbiVBd5K28THnGrqddEUZGdnL+3izAqr/IFz
   3s+EsaG5Ez2ys+/VvCfNNuFOci/SmWyS1oCHm0Xus7EFiB6Zae1/S2Y5w
   NKsYUxTzTYhSFVoZVcMPdpzSUVA4rrN3hBqBwpqFxU04jOnRM//tldn8q
   zKQg34/KiqihmUJTIqvZbRSIk4aDKa65EK+FzX2lg+qJjmU5jiWbCBIhH
   wKiCiWx2qsIzkmuQNn+TjwdDwx8NUHfpfCUXMSGQbPfEMAoiRLmSoqsq1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="325347511"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="325347511"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 12:43:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="786574456"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="786574456"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2023 12:43:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 12:43:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 12:43:49 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 12:43:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2Woe2fiM3zXHrXp7o/Kl7jItyRLmsCfpTbdNOjmA3EyDirQlrMlPBqH9KyzWsF2qdAO3ZiY+vP5qtE6oCNC8YzfWeJj+iUCJoM3zrmkZMjuMnkknNtyQS5vvTwA4su/4gyYdPg4oOgto9YkHr4Kv1ZuH7QroYynaxR4tlk3MS1VPk+2heVgkoZ5msx3DDgm7r1PmKtsu+U3704r9NKds4YpgPEPRqmwZm1es7CDqL48EGcuBRkbuX87VpgWg9H9NYTfWRRK7jL+gOhfR1Q9lRWD8+/gjBDs7g8P+6OaQQ6sBWaWuaRRs8FPDqOc0KZ2iaMd5gs+x9/Kpum3ozOm6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6pvTJV8wldqriUBptXgQ3GMJxyTX0xuQXp52S2QfG4=;
 b=Ieo5k7s461LAgU+yzw52nHNeXvwfRJMl5IJA2tvIKA0NerJTHSZjYq/dSsXKCGF5O0Btl7agQV6oHD1gpR4sdCjvUA9eU8eF5z+FWwrFzg6ixWH0odfMS8d7qk0965adGi15GZoIvBtnGDZALvMsaX63XCQojeMi8XWjL9rmsTEnjvFuLxVdgHiQEAM/I/aPCGRWAORlBXKd0vWhbILAlC0/4FMTaoJo1fqFaOJQ7DArBxBMUOUR+RMS/eByEAROXe4r09jrUSEo+2vxMwQokDJ2f1qYR0W/f5QAKHVNVtasXatayuzBz3LK0UrLMlQsr8GMWVc4FpG+nI146v2WAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3303.namprd11.prod.outlook.com (2603:10b6:a03:18::15)
 by PH7PR11MB7570.namprd11.prod.outlook.com (2603:10b6:510:27a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 20:43:46 +0000
Received: from BYAPR11MB3303.namprd11.prod.outlook.com
 ([fe80::4c48:5771:574d:2099]) by BYAPR11MB3303.namprd11.prod.outlook.com
 ([fe80::4c48:5771:574d:2099%5]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 20:43:46 +0000
From:   "Harris, James R" <james.r.harris@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: kernel oops when rmmod'ing ublk_drv w/ missing UBLK_CMD_START_DEV
Thread-Topic: kernel oops when rmmod'ing ublk_drv w/ missing
 UBLK_CMD_START_DEV
Thread-Index: AQHZMPZOyFJwCmWyS0iy5xqmSDXEQq6vjvCAgAAKkwA=
Date:   Wed, 25 Jan 2023 20:43:46 +0000
Message-ID: <A9A5C598-D365-484E-89C3-9556EFC04BEA@intel.com>
References: <78E62777-98A7-4D19-9608-D8A3412D9800@intel.com>
 <d949dbc2-a0cf-c581-c5ca-ddefc592a0a5@kernel.dk>
In-Reply-To: <d949dbc2-a0cf-c581-c5ca-ddefc592a0a5@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3303:EE_|PH7PR11MB7570:EE_
x-ms-office365-filtering-correlation-id: d23baf9b-a025-4464-e723-08daff14db00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JWLgmVWKu0FdbETS5oLGJep4nZJXZ/T3f00FOLj6obQzaQrBC2XPcTfp/xlYUQpMogIzDEHzwguKAaS6l/X/cU7tIcf+Sa5ohqnUxmc5RR+JMiDH1PmK7QlFJgSGLPt6zC1HFkl+ECU49XW7YWSJR6/2Fu2WZVOmJcsrr8JyHnCvXgaJupuB4t1JPJPrQlaLDb5S2Pl6/yhsDZOToQTycL7GVUVuH2LvO7yYuuxDlVUodFagmUL2Csn+SK2Qt9R6TkIQZqzClNOypoUbU/RTu2Wn3j7m3x3/2AL8KE/2KYinI0Y1D6QmJdvqzcc12ynGEcMSKJgNWck+fMSSIbOQ2rJoepchAxE5GznPGA24w6uzuw7vTO9dz2NVkfQZ9gBbWONvbvqp5eQ501rSpftvCWoAMKpDvLXoEHwgeR2XSBKCrhNULM0kOwDx+sjAQtuPNz/VqbeQhzons1d1ll7NrOHb1zm8YcVQT9jtSu6aoHFcMTQUckQPWFkIjZarxJuwNeevX8cIAMGbjEa2T6qM2dMFQfIyYHCk3Cc+maz4vZcykGnqepyPOtJoC7/PYleuUTU4z796IYq/BcmxS/7UiSrTipxWRTHkTTID6hV4iJR9My5RNtgrOuGkpMGObby9jEw3AIgQT/w/otKPW6b7738pzqt/BIFNv85hc/Ii7+eCtxZIYohaCSWlEiEkhrQlq7i8If0sLMPic/YidkwHCar4nugLnnjra3nEg8K0l+I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3303.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199018)(86362001)(478600001)(33656002)(71200400001)(316002)(66446008)(54906003)(5660300002)(2906002)(6486002)(8936002)(6916009)(66946007)(64756008)(66476007)(66556008)(76116006)(4326008)(82960400001)(6506007)(122000001)(38100700002)(6512007)(36756003)(38070700005)(2616005)(8676002)(186003)(26005)(53546011)(41300700001)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MKEHnqeS2VIh8wnYWGtkduAkHGBirObwrmkydsy1gnFiK0f0Kue+EflEQQ9y?=
 =?us-ascii?Q?9KqVEuAePzA6fi5rh7j9x5SsUiGFTU3hr2uIBAFgltHoZWKnNAi+BgcDJMf+?=
 =?us-ascii?Q?+hTdxqVtEv2BEPEgPN3eDK3yVZ3tCpdyoVPGn8DNC1unv7hVHIxt7IAyDs2R?=
 =?us-ascii?Q?cpSdSIuPO0031+jQ8eCqqkRtRtF6SKuJXdOeO0UmkbIoh4RwtbIJNY8JaYsE?=
 =?us-ascii?Q?EJG+tl9y667vCFiaYQ0IxzB7/03uwbJQ7JDgzgPTLF/esdc1Q8Lxvmvz9QQ4?=
 =?us-ascii?Q?RdzMX931VB10nNCR9NYOcwgT87N0uoKH61v1mDPf5kbbZjeMXlORI6+UN/1V?=
 =?us-ascii?Q?AW3CUybImWQCdKEEYL+ycf5GDvLDPrfkEihws02aM35QsxHz4dFY/p9QYu3X?=
 =?us-ascii?Q?Ifu9I9a8f0/31OTCXAadC3gPwFTNdJm5ka0VzCJKOwEPdS0Y23Gc3OOA9syU?=
 =?us-ascii?Q?z8w4bf9h2bYSYdONxtMYfpGeldSpNw+DaA0GtQsp4msDN6I3w1NHUXQequnH?=
 =?us-ascii?Q?HUbHlD/02DG2rYJ6SdPoTE2kb+pF4sn6V9DabJId/hA6/LIRiCioNKwxwE85?=
 =?us-ascii?Q?NQrMjCS2Jr7rplYSKdCg6dtWraRfNlF2fmkhbBI+GjR4QLy2Zv5eiiPzGz9X?=
 =?us-ascii?Q?rkYIJXPyX7XVI00phfF1SnuwVPvrFp9wykXz07vVPhJ7bpHm7tCwmTxjH/Lq?=
 =?us-ascii?Q?FY3lNHeFBSnFI5UJH2luXG0anUWIZWM9aGfkaFvojCoAsE8Br5IIecTO2Hg5?=
 =?us-ascii?Q?DrzMBX7k2GB+HrnT3ngjRAIPjWm6VPlLG0Agn/xH7Efg1+oRE3ifmx37u2ZR?=
 =?us-ascii?Q?lmnguppnxVgZYYhDxvvl0sK16e65qhShX39+3WoMmYbAYn/4sz2t0v5NvQdL?=
 =?us-ascii?Q?GWgAyrLOsZ7E3tMCBGn5gy6p8HejqnYg0OoyxzAt8xDbdIBJBwcvKKdaKxjI?=
 =?us-ascii?Q?jg3vW+zGJWu38wPkGHsGKutUD6EdQVi8m1Jl37TPbJKWJ1KmuA5Gzz56PJqV?=
 =?us-ascii?Q?YP19lgwUlrzEg1Mo+BOX/90Ir1XQTQdeawfuJBN529AKVsms3BulsRJLlhGy?=
 =?us-ascii?Q?c4d8AYPe6T7ysrjQXHAHA1WH8uFGtngaC2+HKMklQHRLadwdf8J9iUS3We6S?=
 =?us-ascii?Q?QQGudI5Rv8TAOXy45PaCuu0WlKqacYyo+OGLEKGnMJA8PVHdq+XXxz+UY2ZW?=
 =?us-ascii?Q?bj7fyffRA+KDWtaxDlN9FtVSnMbcLSbrXrntBQzAvIqqUkDbaKojfJ2zMtNV?=
 =?us-ascii?Q?BUv7t90GVoxM9UbOG9105pK+yUsW/UDeHqNfTrzZ7znqxJ/jinvtsIMWSCxG?=
 =?us-ascii?Q?sXvp0C/bpNM/kfjBOXu2bzibmT06+/04ZUVb23HsNDSf9hZuYYEtSc+VKy//?=
 =?us-ascii?Q?blSzRLbgDtZktAkKg+sflodtf5S8AJhFyvW+wZXI0aOVQiemhRl+RpfVl1mM?=
 =?us-ascii?Q?FYxnCfMKSYSG/THLC6g3j4Sd4VIR28uaOXPv8wymXeH1Ut3eecO0h9aqfEaV?=
 =?us-ascii?Q?Nno8NK9ZFjIOhjYgFKS7Yr/g/VoXh3siskyYMWLb0pyEJ07eetsCeJk4Nzvi?=
 =?us-ascii?Q?hTZ9RtDwrpLBDhpGsBuvIfo0OC0/lr06BiIdUS96C0dstKbpRYp8NVT2ZAOS?=
 =?us-ascii?Q?1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A419EBEF31ACB43926B33A7F96297EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3303.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23baf9b-a025-4464-e723-08daff14db00
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 20:43:46.4576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHEM0aZdcAce1tO7mT3EAKE5kIeMhaWyYi+woQRtBVT4RkMESSqAfNR7qVCP2a+oYbGKqZ2/f8Ehes+8p0QuUPCsZfKdA0VVfwCwdOoMOi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7570
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Jan 25, 2023, at 1:05 PM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 1/25/23 12:50?PM, Harris, James R wrote:
>> Hi,
>>=20
>> I can reliably hit a kernel oops with ublk_drv using the following abnor=
mal sequence of events (repro .c file at end of this e-mail):
>>=20
>> 1) modprobe ublk_drv
>> 2) run test app which basically does:
>>  a) submit UBLK_CMD_ADD_DEV
>>  b) submit UBLK_CMD_SET_PARAMS
>>  c) wait for completions
>>  d) do *not* submit UBLK_CMD_START_DEV
>>  e) exit
>> 3) rmmod ublk_drv
>>=20
>> Reproduces on 6.2-rc5, 6.1.5 and 6.1.
>=20
> Something like this may do it, but I'll let Ming sort out the details
> on what's the most appropriate fix.

Thanks Jens.  This patch fixes things for me.  If you and Ming decide to go=
 forward
with this patch, feel free to add:

Tested-by: Jim Harris <james.r.harris@intel.com>

>=20
>=20
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 17b677b5d3b2..dacc13e2a476 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1149,11 +1149,17 @@ static void ublk_unquiesce_dev(struct ublk_device=
 *ub)
> 	blk_mq_kick_requeue_list(ub->ub_disk->queue);
> }
>=20
> -static void ublk_stop_dev(struct ublk_device *ub)
> +/*
> + * Returns if the device was live or not
> + */
> +static bool ublk_stop_dev(struct ublk_device *ub)
> {
> +	bool was_live =3D false;
> +
> 	mutex_lock(&ub->mutex);
> 	if (ub->dev_info.state =3D=3D UBLK_S_DEV_DEAD)
> 		goto unlock;
> +	was_live =3D true;
> 	if (ublk_can_use_recovery(ub)) {
> 		if (ub->dev_info.state =3D=3D UBLK_S_DEV_LIVE)
> 			__ublk_quiesce_dev(ub);
> @@ -1168,6 +1174,7 @@ static void ublk_stop_dev(struct ublk_device *ub)
> 	ublk_cancel_dev(ub);
> 	mutex_unlock(&ub->mutex);
> 	cancel_delayed_work_sync(&ub->monitor_work);
> +	return was_live;
> }
>=20
> /* device can only be started after all IOs are ready */
> @@ -1470,7 +1477,8 @@ static int ublk_add_tag_set(struct ublk_device *ub)
>=20
> static void ublk_remove(struct ublk_device *ub)
> {
> -	ublk_stop_dev(ub);
> +	if (!ublk_stop_dev(ub))
> +		return;
> 	cancel_work_sync(&ub->stop_work);
> 	cancel_work_sync(&ub->quiesce_work);
> 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
> @@ -1771,7 +1779,8 @@ static int ublk_ctrl_stop_dev(struct io_uring_cmd *=
cmd)
> 	if (!ub)
> 		return -EINVAL;
>=20
> -	ublk_stop_dev(ub);
> +	if (!ublk_stop_dev(ub))
> +		return -EINVAL;
> 	cancel_work_sync(&ub->stop_work);
> 	cancel_work_sync(&ub->quiesce_work);
>=20
>=20
> --=20
> Jens Axboe
>=20

