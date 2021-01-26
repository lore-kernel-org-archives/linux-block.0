Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62F9C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 09:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7623220780
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 09:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391675AbhAZJ4X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 04:56:23 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:58993 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391737AbhAZJzF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 04:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611655671; x=1643191671;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=k75xZMIKW8UwrsrlMfEiwXdhhy9Tt2mC48q9gmvCypU=;
  b=dTEwijvyHsAMxdQw7qJbRDMnY1LCA8VmeNnzxiL6hhUIW4O1Z79cY5Ct
   V1bkEfym1w0Mos/6BeY+rXvMKC+uds5+uduuK48t5gyiyVvmb++9iRs2q
   7cErLD+KAN+h9+sYiUnQne+Q0OfCE2g4f+pC8I/bMZDMuga/0rvAhuvw5
   qc3uK8b2lZDyfeavgHLoQLYgGMj5sGS209ehnOP6xTkIhyfyMI29pCHHp
   iXQ5tgDdlmNOOT2y9b8ReN1lq9OaGCiwGhnfYknl0ikSz8Up8wVFbw5YO
   5m4Bf8bKpP+WyLeQZ39Cv55tdd83uqmzsQXz+Ev+csEHh5Z7dLRzGHGLa
   A==;
IronPort-SDR: zVhy9QepD/rhyxaow+f3BHTqKIJELBoCOnfu67BMeVzSI0+ttRDwP5KDX3QbmbDx/fT4iumtcC
 wcJJQ0fHnMDbYHRzixS67xSUfb+oOL6/ApzPF0/CdMnpEcUELJjjDzJGsMAiiWxuNAV6XAY7JN
 C3Il2si8HnfhOw8UT4JoxZsoRwfn/RlCvhIFcA6QG84E8E1T8NGuSI9WBsTX9vRgM5g9znJdWD
 jxSUZtLdATXJCUgWbbzd4drG11JZJr9tJa194FHN3kmibveLRKQPBBgbzEjZKnoIysKkJILdlH
 ZKo=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="262351015"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 18:06:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjrCjb8JHFRyV2FFZbBOOEM5dv364SDNFJCBtzqR3Rdf6lBaVBr6KmJdFQFsvENIAHzzv2zq9v3iSegS0z2KVPMvcCIisOxOJmhdT9m6YwiVcbZXaT5p2VsLXOotgNwtMuDvGTp8dKOmnviZAkSk4Z6ulvyjc/4Ssol0euALs7Um+2FwodlpIoQYUEK33W5aiEFl8nii+bY2zYhUyJSHnRpY5M5huPE5Ef6R3GT0CbxkgZu1jp1KxovTKerlqSmQ1GwmA4uVYQUeASyjP6FKi51IduHDlG38+r/x/Dir4c0WfrSVHrz+lj+/youKqh44pBjP0+AGvLdzvnfMvevSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiiW4nHVLfvMQJ9ydarmR72oGvvW54S+kGyiPmuXav4=;
 b=H8vCNiOBLylXFAtNXqv0UEfxG5H6pUZB8Y97mg0CA7PlRfjYUiA9DN5aLrnwLAjRa3RHqHBh+iz1bpGmrpzfhr61MeRGuryX3vvWi0a6JSlWFFr1biKd5B/2rLPxVn0cLSnDSkivfsnb+J/MbaUlnHtrZkGnOQI2xLNvbbQ+lby87hJVZK6pffZvPvaBooRUv9QwDJiSpQWLyBKpf1MKB6wCMiT4GPu6YoogCznUipiPSKX8Xr/8CirzyOqkxOHW3ShSCJfDohgXndV6aVKFC+bEJZ4i5TIDgxc+3vx6s8G2/6fCWOsYqIM47X80qbux05izxwXQoXFan1yN0XR9Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiiW4nHVLfvMQJ9ydarmR72oGvvW54S+kGyiPmuXav4=;
 b=i2OuJTK7SJPbOv49HcudN3J++4g+2+SQALrsgIBhBckrQezl8sgKvmA8XRoKVGyqKofT/GENDGqNrS8MOmRR5EupSaHtFe4vau6NOvDbpHMD92Z4cawieZAeMquDufxCpCeESztL4VcXPXhJSeoSuq4vNUI+Qugb++9TOC59B/s=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5592.namprd04.prod.outlook.com (2603:10b6:a03:10a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 26 Jan
 2021 09:53:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3784.016; Tue, 26 Jan 2021
 09:53:51 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        "tyhicks@linux.microsoft.com" <tyhicks@linux.microsoft.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "hch@lst.de" <hch@lst.de>, "pvorel@suse.cz" <pvorel@suse.cz>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "mzxreary@0pointer.de" <mzxreary@0pointer.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "zhengbin13@huawei.com" <zhengbin13@huawei.com>,
        "maco@android.com" <maco@android.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>
Subject: Re: [PATCH v3 1/1] loop: scale loop device by introducing per device
 lock
Thread-Topic: [PATCH v3 1/1] loop: scale loop device by introducing per device
 lock
Thread-Index: AQHW81bClynMFg2aekKXT4gGzq3SkA==
Date:   Tue, 26 Jan 2021 09:53:51 +0000
Message-ID: <BYAPR04MB4965A6FB4ED51882E326EC1A86BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210125201156.1330164-1-pasha.tatashin@soleen.com>
 <20210125201156.1330164-2-pasha.tatashin@soleen.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: soleen.com; dkim=none (message not signed)
 header.d=none;soleen.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:270c:4b00:4c16:6058:6f22:9176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e2c0b0e-d32f-45a4-6115-08d8c1e0491f
x-ms-traffictypediagnostic: BYAPR04MB5592:
x-microsoft-antispam-prvs: <BYAPR04MB5592C9014466A43FE2DA179B86BC0@BYAPR04MB5592.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JKCyzTR6EvZO4OsECsi9JUmnkSQj0itqRuVyo32YEyznW4u+02QSK0IWXET1/vCC/zpVo8DxB7GLU5OyipAUKXteR3RP3aTltwaTMvLRfbPUZTbNbuJxAPZzgyG/A2pUtMha+VaG+CyYJfRIu4J6LoQIn8iBfiHm7agXFE43Dk9aHcskKpSrzdfrqadaubtvG07oWdeM14nBPjoXITKaR5b2zuqYNS0Y75o1j+ZJZXZs5KA1062c1mkM4fY6dSyfxpYici9lxoEoA8LuY9qHEX5BmA8lVomvqF74cQNFdkHZaHUqGepzm4jNzz0Xrp6VZyMPe1WUgwqWcF7b+LkNfDdl5tTKTJnxVSShePhSSwp6zOi7e4EJCHLzjg9+ie6gXX4r2YYb7OVrdSbQNO4ocj000cBFyp8ez0PP8ZvHxRET2wZkYwUiiHrG2LYDfjrJtXuajf2ZHD7LVi3mh2fExJw0HpCLKTwQCdvt7ZV69ylHoNwdoLjSrEi8gqwADPYWuFF7nhZgzS3JL+bioySftvCZ+Om1Oxa/YZT6uOczWQseoXTCJUPP1WnXbOo7xpul
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(2906002)(64756008)(186003)(76116006)(66446008)(316002)(66476007)(8676002)(478600001)(9686003)(110136005)(6506007)(7416002)(52536014)(8936002)(83380400001)(7696005)(5660300002)(53546011)(55016002)(71200400001)(66556008)(33656002)(921005)(66946007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bXHj8hx/WbpfX1TXD9sAQNNdlAg7KZaTEDwiNYLCv10abR4iou3tXG1ysfKJ?=
 =?us-ascii?Q?ZEoUlFbT2Bov/fLlogf4BGJOWZgtFjcaZbQvv4EneiTve16iBpPeyXmW0p/Y?=
 =?us-ascii?Q?s6AiE6RIgszIRaDusC8ySxFYVya9WOsqZ9TShXItbhs+46hIKiHzVrb1mXkN?=
 =?us-ascii?Q?dHfSSSOPHtoxRJlGva2car6/AgmbzdgOZsXPPaV8ZAphfSnEkZGmrKSremO7?=
 =?us-ascii?Q?cUhOrXqXrKKaHKV2A0J3JGGpg6FgYLJrfnj1Gwgw1xLPHQBA7oNy9O9dHUqJ?=
 =?us-ascii?Q?SW4c14pHa4npH0Y0MrSi02EytbPSOEbVBpOU88YuYOJ9nmKsqrAoUldXORC4?=
 =?us-ascii?Q?iDrmwFhU6U61wM0fiRoqvBWSeCIQUrtKfwhAClcNytcaxozWkbfTtnuyKFvU?=
 =?us-ascii?Q?cd9D8SdnGBHIWeB0N5FWFDu10r9JkRHCb6x8Cjprj4qrt4S03vspcTYcOwNT?=
 =?us-ascii?Q?gmm3aTqHoVY4R/ZB62rrBZidxV03RohQHASIOK/dD/NqK35FP8kuzgnibiJF?=
 =?us-ascii?Q?eesbJtRjsmcHSmuJZMWXSsMPKOoKQfoRcywEFFOxNG+GMOxoQDAg9xhF5r4R?=
 =?us-ascii?Q?RgmvUEe9Z79cpKbQUc0BxJeC9WQ3t4ETk8kPstY9oBFuXEQlEGqChCR6O0BU?=
 =?us-ascii?Q?sWnmIymw3LHDoy5RTKIlkXpa0FPZql+nz8el60M9z1w8il+7lvqVoCSW7/cF?=
 =?us-ascii?Q?TD3CPQCTLlAO/IMri7kiBc286/20LFGTDNphFJfYIpWK5hPDjVY79K+2fqLy?=
 =?us-ascii?Q?Blp63xTn7SwB5kpof0vgFlPQlZt82YU4Je0dYm4LKMuzl3L8M2fCk8DR2mOr?=
 =?us-ascii?Q?l/YzUK+VTeH04km3S13Rogn9wtsa9qsL9+ISGNluw0p775232UnXhKhaUY8r?=
 =?us-ascii?Q?S6l6NuPosCmSu+tWSxdZbEXXb4pjoF66h6J63uoVqZfMgpRVyNT0r0FcbJLU?=
 =?us-ascii?Q?XubinE/L26nEwfWd5Pf33YoOtn7yCjwtiPkdv/vGGsi1CWi20BJa6YmkjF2U?=
 =?us-ascii?Q?eTh+nx7ZCppI4zUmGXfcAAEi86lecIPjNOFNXAEJElce0Q6s9emn+BVcwDSj?=
 =?us-ascii?Q?pFDIcfXxgGPPcCp6Drj7o6DETM2E07WC0kHbj86oOXGIIHn5lboscae1+Bly?=
 =?us-ascii?Q?17lVb0+3I2gt2yGP7SC81YKAKQg+4lXzwA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2c0b0e-d32f-45a4-6115-08d8c1e0491f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 09:53:51.3565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CzeyWrwGCwm5a9ifqVrkdDFvosMPyofCNsmAcq+MmVyXAkAqOjdm4sasPiIJy7QbMWQFXOg8Eer/QJUXCtc/Dgp+hWWKgI/at+xxMre0XAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5592
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/21 12:15 PM, Pavel Tatashin wrote:=0A=
> Currently, loop device has only one global lock:=0A=
> loop_ctl_mutex.=0A=
Above line can be :-=0A=
Currently, loop device has only one global lock: loop_ctl_mutex.=0A=
=0A=
Also please provide a complete discretion what are the members it protects,=
=0A=
i.e. how big the size of the current locking is, helps the reviewers &=0A=
maintainer.=0A=
> This becomes hot in scenarios where many loop devices are used.=0A=
>=0A=
> Scale it by introducing per-device lock: lo_mutex that protects the=0A=
> fields in struct loop_device. Keep loop_ctl_mutex to protect global=0A=
> data such as loop_index_idr, loop_lookup, loop_add.=0A=
When it comes to scaling, lockstat data is more descriptive and useful alon=
g=0A=
with thetotal time of execution which has contention numbers with increasin=
g=0A=
number of threads/devices/users on logarithmic scale, at-least that is=0A=
how I've=0A=
solved the some of file-systems scaling issues in the past.=0A=
>=0A=
> Lock ordering: loop_ctl_mutex > lo_mutex.=0A=
The above statement needs a in-detail commit log description. Usually >=0A=
sort of statements are not a good practice for something as important as=0A=
lock priority which was not present in the original code.=0A=
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>=0A=
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>=0A=
> ---=0A=
>  drivers/block/loop.c | 92 +++++++++++++++++++++++++-------------------=
=0A=
>=0A=
>=0A=
>  =0A=
>  	/*=0A=
> -	 * Need not hold loop_ctl_mutex to fput backing file.=0A=
> -	 * Calling fput holding loop_ctl_mutex triggers a circular=0A=
> +	 * Need not hold lo_mutex to fput backing file.=0A=
> +	 * Calling fput holding lo_mutex triggers a circular=0A=
>  	 * lock dependency possibility warning as fput can take=0A=
> -	 * bd_mutex which is usually taken before loop_ctl_mutex.=0A=
> +	 * bd_mutex which is usually taken before lo_mutex.=0A=
>  	 */=0A=
This is not in your patch, but since you are touching this comment can you=
=0A=
please consider this, it save an entire line and the wasted space:-=0A=
       /*  =0A=
        * Need not hold lo_mutex to fput backing file. Calling fput holding=
=0A=
        * lo_mutex triggers a circular lock dependency possibility=0A=
warning as=0A=
        * fput can take bd_mutex which is usually take before lo_mutex.=0A=
        */=0A=
=0A=
> @@ -1879,27 +1879,33 @@ static int lo_open(struct block_device *bdev, fmo=
de_t mode)=0A=
>  	struct loop_device *lo;=0A=
>  	int err;=0A=
>  =0A=
> +	/*=0A=
> +	 * take loop_ctl_mutex to protect lo pointer from race with=0A=
> +	 * loop_control_ioctl(LOOP_CTL_REMOVE), however, to reduce=0A=
> +	 * contention release it prior to updating lo->lo_refcnt.=0A=
> +	 */=0A=
=0A=
The above comment could be :-=0A=
=0A=
        /*  =0A=
         * Take loop_ctl_mutex to protect lo pointer from race with=0A=
         * loop_control_ioctl(LOOP_CTL_REMOVE), however, to reduce=0A=
contention=0A=
         * release it prior to updating lo->lo_refcnt.=0A=
         */=0A=
>  	err =3D mutex_lock_killable(&loop_ctl_mutex);=0A=
>  	if (err)=0A=
