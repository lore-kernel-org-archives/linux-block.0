Return-Path: <SRS0=DoUd=BU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35667C433E0
	for <linux-block@archiver.kernel.org>; Mon, 10 Aug 2020 17:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7C82065C
	for <linux-block@archiver.kernel.org>; Mon, 10 Aug 2020 17:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K2SuD3CM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VuHHWH6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgHJRfL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:35:11 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:36382 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgHJRfK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Aug 2020 13:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597080925; x=1628616925;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pLpEhy0yXJStl5iBdUQMNQHiMSBYgzNlUOcLB5uYhv4=;
  b=K2SuD3CMVhyWKr/KLv8e+PiAWEVni5n6yWocKuJSwSwAdbdU0TBR7g7y
   MOvydRvmIJV3sNXKuRMO9WX3z5TZh/bRD3kyzCMgUP3K4a32XdGywXrTb
   xVYp/ozeO7Rqt3HpH9AUkKq33Fbb/Rx8sJtFvLQoDLSx2XGKeqVhzldSh
   zhOdKpp5GUDIYN7AJhu/arCwelG8ZaGsmsetTd8Ot4dO+TZNeW5sDM/wb
   kb6oUkCyqcwym1+Wbeyn9JSfecr0dqAuYdxJDFKoDXF/tB60WmXMFDp/X
   pEwGoctLw1BhvDjNOd66EIbeyS0DD8kTSs4mppZrAKxzYY49fBN+ErUf0
   g==;
IronPort-SDR: ipsYWeGck1RVNO3rGXAhEmmWYG5oxyPjVoasX/QtemoZn2iXvQzPyIeRHYmjoDGw2sXlTxHJ8p
 ZdW/0CCvZsnRIsy5NWoFxwvOXY5m86PmzUx3BDCyIU0QNRMBj0wCgeH6ISicOp4efrLzpUY1Ff
 Qr7aVwR/yRireKyQh7VKEhqPThCIS5Gegx/gxB1JBo4t/+zkqmfuwlMSHxcMAWKI+38Y5eJwZm
 /pU/Htfe7y0al611HINf+D/WZVCzDoWCK3UPDzhCIUnBxrABeBFx6jVFOAWChfV1AzRTpAXM0Y
 xCQ=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; 
   d="scan'208";a="247726955"
Received: from mail-sn1nam07lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 01:35:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPSafj4Wu1RQ5pq0Aer+eo/gKhX6i6OeR7fNVlQYeMa0xNfo9r2wG1NcByHN2irY7WV6+EX8c6nJf0aRoHoqOkj5S4d/UXF+odRf6f3vh8iJYxK8KQVkJLgunpGTZJ1YWpGCVeol81aM+XOPi3Nte6WYBbwd9E7V878+uLJ65p1r8x8wO7K6vyc7KoqANHVPlXFgsxErnjYSm6ghkalAx5KKmyPIsrXMTO2UyN/TwHtF5cxE2zhoHNDOvqzJqsmA1va8w596vLG0fR4S2/JI5IdhM4yd4KkxBnsGh3sbv6VB0DMXw6FnZyao9N5f73y/atFulHd6QYPWzUAulpRo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRG4UQsDDNXd8+q/eQ5bclaow3pBAdtvDfrtKrwllds=;
 b=Jd/llt8o26fn5fUFzyc82MxJBooRRkpYYU+rllcYKb9f9+4hobi7ywbYgjF7pGshYgjVLWg8J0RrKTC0j1AmVQ34lCg9KmTQN6Hva/Ec/KogMgqffUrg0jEmG+s7FbVjmAHPvuy6KVuGABh9KdqGJ4VIQKLaaRFSBiC66U9v2IXNX1d1sJzsppzUyTW7/G1q6XWNGeuvtYletLvP+3Iz3gPUwuXarrpknVR1BxDP3daf+bHZrcb/11jkAPdkkBW0QAJokO/jvYANI1tao+JZfTutbBUXCbf86JWPR3vxDpkuukuBw37mg90UCTmFz8n7ZzjtzrVEmNf6KR6Ftz4w+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRG4UQsDDNXd8+q/eQ5bclaow3pBAdtvDfrtKrwllds=;
 b=VuHHWH6U7V1ufoEm8bSvPUiEgmjmRLdflHWSVGfeG8Wtn4aEn2CEGCcMU/W8tnTOxV81i8qLOhvIFl74ROjRUL+iM4upToKubUm7HRfaX4rbWb/7zaf+8NziPRggUVu9H99soLtftswF/ESHuz+edVyt42tPTSPn3TktZo4dz4o=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3959.namprd04.prod.outlook.com (2603:10b6:a02:b2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 17:35:05 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 17:35:05 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2 3/7] nvme: make tests transport type agnostic
Thread-Topic: [PATCH v2 3/7] nvme: make tests transport type agnostic
Thread-Index: AQHWbCXzh+xG0oszjkqmPtQ6X3QuYg==
Date:   Mon, 10 Aug 2020 17:35:05 +0000
Message-ID: <BYAPR04MB4965DDB160D053CA2F546B0286440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-4-sagi@grimberg.me>
 <BYAPR04MB4965624DFCE5A870BDE20A4686490@BYAPR04MB4965.namprd04.prod.outlook.com>
 <ecf895c8-c009-2327-cd37-e8838b7e5e38@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:9d4c:6bcf:e259:5003]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da9d0892-6625-4e26-b81e-08d83d53b7fd
x-ms-traffictypediagnostic: BYAPR04MB3959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB39596C5FA3AF34CC3B480D8D86440@BYAPR04MB3959.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vhMLj3ZVWz+TT/C3ybeEB2NuguNuSzcjMmt7JRmExJsqzlv4lLx/z7Xo5ciqZiKczsH5MdXHfyYd60mBtBiaTaZKkR7ScOP5eG9xau/MSAAaWmRIGgeMkXK1vNXrMqNx69yc9VCx+gqogb0XUnTQC5YEZQmYD0gMSDR6dWZhcA/fE8z6YCQXcBFPL5x5HLNwL6BpFi0xfX/0qGVayBE4d2hPSbxmXYsiL0N4WAJkFZABighbJdv4JTIUuw/WK0BXQHdj4R2mgZ36Jc4h2Vu+1xUp8ozvedRSzG59LGoIAcZdP0uU0qSGpztXnCslTIkSs547GHN6sji3QpExgCMhsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(186003)(71200400001)(316002)(66446008)(8936002)(2906002)(5660300002)(478600001)(66476007)(66946007)(64756008)(52536014)(66556008)(76116006)(54906003)(110136005)(83380400001)(55016002)(33656002)(86362001)(8676002)(53546011)(6506007)(9686003)(4326008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2krqYI2zRynsiRLhcpKCNj4gAtYc98iGbgfCruKZtSm/LeIPWo80/LAuP86hjx/+0EaSoNCKy/KoC0Rz/mD/TI5+Sm5QRd9UUpfku9jzWEtFyvA/UhRrQ+NYIbAqtYYJnFje5EfzVzDLnbItzZyiAbLY4WGCfPqPDAvG+hWG+xq9Nv2Wm3GJkhaeiyBq+IvrFGFBIQdAOsN2xfeQqxb1lasHfjJ3OP1/hlTOL9IIiUW2HnaWD+PZLsgBk25XijQW2kKQDF7kHSYLzF5dKLw2LIvpAJ8PScg2mKOSB+mnZXTvGOqO+LBP6FZh9/ess2ZFsRBTS3KX7Um/C+dQndJmaVHRNGFDk4IikIc8Ng9tgs03ZX9Jx5q+8cUTHEToBywUDwvCmfU3oE3/X3PseV3DApvZ8EB+zOrU57T5x4A0gdUEr3TnpxrNO6WbFov6v6PH9pv21CEJiR+ejw6FO8ayql+RMsTRL67YM612ajET5ofQilJZ5s5hBN48XS9Nv54GfdZUZbREIE+3CfFQ2/mb5FXgAaffrUfO0Eg0UclTQT13uvbItvFJTAYmaelGIpGrtOBkV3XsGVK4q5rjc675CY92jx0JP1QTYjuTon7jXS8Niiqe6C6hS5fU1X3EQtz1I2bsYQDAkR55/7+SSmA9PRQSjEstSwpM8idSC2M+fc4WtRhyDExWZaN9xuJnfxfIeEtduejH1k8iiXwnO4XoMg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9d0892-6625-4e26-b81e-08d83d53b7fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 17:35:05.0433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rvmSRGwieMO77HSg3wpMCF8zy1ss1Gebwl5IF+tiZ1J1ySudlAnIg5Rm5JSCI4cS0gHwm8xn1VIKhAWcgHt2lKga0gVQ8HJOZ54jR9bHUwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3959
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/7/20 10:19 AM, Sagi Grimberg wrote:=0A=
> =0A=
>>> diff --git a/tests/nvme/002 b/tests/nvme/002=0A=
>>> index 999e222705bf..8540623497c7 100755=0A=
>>> --- a/tests/nvme/002=0A=
>>> +++ b/tests/nvme/002=0A=
>>> @@ -21,7 +21,7 @@ test() {=0A=
>>>     =0A=
>>>     	local iterations=3D1000=0A=
>>>     	local port=0A=
>>> -	port=3D"$(_create_nvmet_port "loop")"=0A=
>>> +	port=3D"$(_create_nvmet_port ${nvme_trtype})"=0A=
>> Is there a way to directly use nvme_trtype especially in rc ?=0A=
>> if not disregard this comment.=0A=
> =0A=
> I didn't want to do this, because a test can create multiple ports.=0A=
> But maybe it could have a default value?=0A=
> =0A=
>>> @@ -33,10 +33,10 @@ test() {=0A=
>>>     		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"=0A=
>>>     	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"=0A=
>>>     =0A=
>>> -	_nvme_connect_subsys "loop" "blktests-subsystem-1"=0A=
>>> +	_nvme_connect_subsys ${nvme_trtype} "blktests-subsystem-1"=0A=
>>>     =0A=
>>>     	local nvmedev=0A=
>>> -	nvmedev=3D"$(_find_nvme_loop_dev)"=0A=
>>> +	nvmedev=3D"$(_find_nvme_dev)"=0A=
>>>     	cat "/sys/block/${nvmedev}n1/uuid"=0A=
>>>     	cat "/sys/block/${nvmedev}n1/wwid"=0A=
>>=0A=
>> Since we are touching nvmedev can we move above uuid and wwid to=0A=
>> a wrapper something like _nvme_show_uuid_wwid ${nvmedev}n1 ?=0A=
> =0A=
> Doesn't help the patch set cause, so it can be added incrementally.=0A=
Okay.=0A=
> =0A=
>>=0A=
>>>=0A=
>>> @@ -36,12 +36,12 @@ test() {=0A=
>>>     =0A=
>>>     	loop_dev=3D"$(losetup -f --show "$TMPDIR/img")"=0A=
>>>     =0A=
>>> -	port=3D"$(_create_nvmet_port "loop")"=0A=
>>> +	port=3D"$(_create_nvmet_port ${nvme_trtype})"=0A=
>>>     =0A=
>>>     	for ((i =3D 0; i < iterations; i++)); do=0A=
>>>     		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"=0A=
>>>     		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"=0A=
>>> -		_nvme_connect_subsys "loop" "${subsys}$i"=0A=
>>> +		_nvme_connect_subsys ${nvme_trtype} "${subsys}$i"=0A=
>> Same here for nvme_trtype as first comment.=0A=
>>>     		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1=0A=
>>>     		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"=0A=
>>>     		_remove_nvmet_subsystem "${subsys}$i"=0A=
>>> diff --git a/tests/nvme/rc b/tests/nvme/rc=0A=
>>> index 6d57cf591300..191f0497416a 100644=0A=
>>> --- a/tests/nvme/rc=0A=
>>> +++ b/tests/nvme/rc=0A=
>>> @@ -6,6 +6,9 @@=0A=
>>>     =0A=
>>>     . common/rc=0A=
>>>     =0A=
>>> +def_traddr=3D"127.0.0.1"=0A=
>>> +def_adrfam=3D"ipv4"=0A=
>>> +def_trsvcid=3D"4420"=0A=
>>>     nvme_trtype=3D${nvme_trtype:-"loop"}=0A=
>>>     =0A=
>>>     _nvme_requires() {=0A=
>>> @@ -62,8 +65,8 @@ _cleanup_nvmet() {=0A=
>>>     	for dev in /sys/class/nvme/nvme*; do=0A=
>>>     		dev=3D"$(basename "$dev")"=0A=
>>>     		transport=3D"$(cat "/sys/class/nvme/${dev}/transport")"=0A=
>>> -		if [[ "$transport" =3D=3D "loop" ]]; then=0A=
>>> -			echo "WARNING: Test did not clean up loop device: ${dev}"=0A=
>>> +		if [[ "$transport" =3D=3D "${nvme_trtype}" ]]; then=0A=
>>> +			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"=
=0A=
>>>     			_nvme_disconnect_ctrl "${dev}"=0A=
>>>     		fi=0A=
>>>     	done=0A=
>>> @@ -87,14 +90,20 @@ _cleanup_nvmet() {=0A=
>>>     	shopt -u nullglob=0A=
>>>     	trap SIGINT=0A=
>>>     =0A=
>>> -	modprobe -r nvme-loop 2>/dev/null=0A=
>>> +	modprobe -r nvme-${nvme_trtype} 2>/dev/null=0A=
>>> +	if [[ "${nvme_trtype}" !=3D "loop" ]]; then=0A=
>>> +		modprobe -r nvmet-${nvme_trtype} 2>/dev/null=0A=
>> This is not from your patch but I'd keep the error message it has=0A=
>> turned out to be useful for me when debugging refcount problem=0A=
>> especially unload and load scenario.=0A=
> =0A=
> Again, I'd like to avoid doing things that are outside the scope=0A=
> of what this is trying to achieve because it is not a small change.=0A=
> =0A=
> We can add it incrementally.=0A=
That make sense, we can do it incrementally.=0A=
> =0A=
=0A=
