Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA88C433E0
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 03:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A2220855
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 03:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dnCEOf8v";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qoFVm1WC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHGDJd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:09:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34123 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGDJc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 23:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596769770; x=1628305770;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bM7nlZRge779psB12vbdduJ68aSucZ5w4MGgGrm2RfE=;
  b=dnCEOf8vfOmYhhbW4Pnu6AxUlyre8HAc/TMOMeygjTJw5Z0/xsk7JYqO
   7irpc/vg0rHpRUxAy1JEfpGExZN8p9FzjSvlkKWWUtQaT52h8KxSsqNh+
   30nfrSHfr6cy84hlPj3xb0NwYxjCdejGwzkda/RXVYocivEqtpxUvO4zj
   G6K7stpbjABT/o40bPCPfb2DVi6ksQt5WxP6z+TVAuY+PIbrHo0RvXIP7
   dhAm7IzWfPvcTc8DflIM77jOGk54thm/SjAFJ/yZPusTDcbqMX7kNfBK7
   Is7nzaKki2ZOsm0XjBgiX7B4qwK2lwGv2Thjsauz5mPxbMQeQn9K1sdM8
   g==;
IronPort-SDR: xg6ZWfV5zXjbza7uxoH1QKnvTR5FgJL8IHwc5/bwn601bHI6DSJm9P7HS47/o113zIzVYbwg1u
 qBLmCsWnXhDGQbU/YuqQN+zHv/rjLhf2RqFHzDgWNDNMnpAimE8jZl5XjeVvP0qXQOKrnXcTME
 H3864UeT3JrVowcy1kWQOxuWOUfMX/4hjdwNE//eyks8DsIcmYvk89Jr9ROs74C32stoQy3dE1
 lsyNFcYIdDkRc+E/d9Aa/DCown9CVxw4bZYsWFY4pzxOX1MuHC5cmdilPIMXu9uirSVlLzQrkg
 Yqw=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; 
   d="scan'208";a="145589099"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 11:09:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpU+To+QIE2/w8faSXECVHC6wJQHY7aWmCdJuhVDJBL7r1agZ1gPDzcHjXPzCV7F20BNUSuDHlZ46JyY8zHV8iAJPFKmuFDcwAH721Iuv5yQSJ4sWpV4a3ed7ShS2S1hWxtq60aavABAGyOoMo16PXNsy4Hicub2RCBFKyjkLSEtIlQ6+AoHwcYLlU6+eo2wZv50aPlZq+DWTgSImmnB7xsCarMxX27JPma/r3fBUiFH6ni6O29UbRhJ+7Ttnjz/zNuhSV4iqTbBB70fNbS22P64A+qf6JlY613EJghwaZleev4r/+g/ao2agHaqfQUgUvwl1viLiCJvb6nslu7tyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqgnTquXpEhsQDu07CXc6MgTNHjl7OCdT4YAW0cDe1w=;
 b=CTwTcshqetT00aSxYT4YpxYVd1nOoItxNFmV3Fh5SvmGt1PFXo+sKqQdgxcERpLhacKB85MCv6uQIYxu+dF6UnUIey5VI8pEjWOOBJ4BiAuObOGA03MdXbUygDZRdR8hXS514vlNZm+eMjvIvVNepMTQyEDxw6MQzqe6Iyfs/+w4gCAxGkr/0XvootDRKznLZeDnliJXbysK3EB+sFQpXgASUQu1L8XiJ/WQjhHky+TQUEUsMQEvvQPWXeDXRociLmNY+S/f6biaXpl2y4cUlaNvSk9nOdyKlYXfWy/Pgvqvhk7v0QHdqAFWVv4ppBM2v+zKJ4OnWJgrW8tS1SBCZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqgnTquXpEhsQDu07CXc6MgTNHjl7OCdT4YAW0cDe1w=;
 b=qoFVm1WCs0IuucSgECVKQwimbI8HLJP5YHQRVS61tVZHm7cwLJcu3bmyrmEKvMhhuNx5vFpYybzf58KGQpCptg2Jn+Hs3Wj08Ibll9lirabA9FC4tx2WUrqqH4QWyD32UouzU7wbq6YJj9AEoGos4AHt0OYE0hSvtP1w3KHROD4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5831.namprd04.prod.outlook.com (2603:10b6:a03:10d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Fri, 7 Aug
 2020 03:09:27 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Fri, 7 Aug 2020
 03:09:27 +0000
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
Date:   Fri, 7 Aug 2020 03:09:27 +0000
Message-ID: <BYAPR04MB4965624DFCE5A870BDE20A4686490@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-4-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30d78ab4-6ead-4d49-d41d-08d83a7f4bb8
x-ms-traffictypediagnostic: BYAPR04MB5831:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB583195462C49EC6F5508B46786490@BYAPR04MB5831.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:374;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eYjlV8PBIjzRNYwzHL6tzKgpiqrAHCxMSQNwynrrx4x8ym05GChQgBgv2J0Pt42utjy1WwxUpWYIK0WGUp03CgqH0GW7bq+LVhI8B0d4Ql9oxczVlkD83UwbLpzVvfnOWAmIuGV/o4ghVSiuo2nYKYK4v9xqHb7xcRzZcETjf6Ld59wVSgAFuUjE08SmTqM6PlQnJXhqzB7EbU2YQKHiwOJxxD2wE1tsIAkbfeWn79Jtxh0cDCsvELgcV7b0KTbDvD5wmXHQ90P2eRssnqv66kSqXFf1FT1uZQyctMZBrUU+RRyPQDD/BWHbmP3otC/fPBtBpOJAOEZ4lDQB2NY6SA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(8676002)(55016002)(33656002)(86362001)(66946007)(8936002)(9686003)(76116006)(71200400001)(64756008)(66556008)(66476007)(66446008)(83380400001)(2906002)(26005)(52536014)(110136005)(54906003)(186003)(6506007)(53546011)(316002)(478600001)(7696005)(4326008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /Sz4x+L7MiwtJ978F97+O65bwMNC5PinOR2IP8R9XFCp1ftnSYNwGMoJEyRp7QuXfoYMeTQDJqnbcZVHA7P+7W3SKQ1J6wqdLCc8OiaDm5NAyO9V8AB5e6RDEbYCq9u9ZIwLpwpJvfJoyXgRP3RmHhjojpv0xY6BDsbXY1bcpvtvxIgL8JQm594QdbfUbtNrMgeKTAUPkenKlxC0M2AEdSW1VxPGO9lDgJiIgP0v1LBFa8LUTdDGoUwA3HMeX+n1zn+VOXzc5BRAKvsEbkQYdxRu9Lj2TOXa3KLN4wo5P4kFxg18oTmHZxyFeTyVKfnkpdBQm02VwXJtJbed5VZnDep1KDq2f1P/pMVFQS0QugdLY4KX0xB+NVNnIsfzm+Sy96agl0jp7uR5+wXbX1LMpenTHTGiUBabnGlwQ8TQ6YdvzhB8vNBojbKrQ72EZYCqfqb8r+5fnFSJE7qMHZZYZP+qC7NmCPZfRwI66iZTtvoaTq62xXDnaQvw/fB4B8N0rMfQExWLOQY3mOHSmz3fsoxcmSfyI50V7uNomzFNIE43kVvUG3u9p4/xYMDSfV5H+kv7pSnerLLj4Vf3zQUG+2/RXPkNARAZ0/j+aXUIoCN3bmQgy7Y2CBecmJc/4u0puoQlbjl2j5YiaflUjqxsgQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d78ab4-6ead-4d49-d41d-08d83a7f4bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 03:09:27.6727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYDJlPUlLBBN2sqvtHej6tvvmS8iKCBbIT+tK7aBGVzFxXHp2PlVsBdVr1UQDI/QSUiW/6PHXRMRjbrxFTpU7Mzn154G4Z6r5p1RmDw3+K4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5831
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/20 12:15, Sagi Grimberg wrote:=0A=
> Pass in nvme_trtype to common routines that can=0A=
> support multiple transport types.=0A=
> =0A=
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>=0A=
> ---=0A=
>   tests/nvme/002 |  4 ++--=0A=
>   tests/nvme/003 |  4 ++--=0A=
>   tests/nvme/004 |  6 +++---=0A=
>   tests/nvme/005 |  6 +++---=0A=
>   tests/nvme/006 |  2 +-=0A=
>   tests/nvme/007 |  2 +-=0A=
>   tests/nvme/008 |  6 +++---=0A=
>   tests/nvme/009 |  6 +++---=0A=
>   tests/nvme/010 |  6 +++---=0A=
>   tests/nvme/011 |  6 +++---=0A=
>   tests/nvme/012 |  6 +++---=0A=
>   tests/nvme/013 |  6 +++---=0A=
>   tests/nvme/014 |  6 +++---=0A=
>   tests/nvme/015 |  6 +++---=0A=
>   tests/nvme/016 |  2 +-=0A=
>   tests/nvme/017 |  2 +-=0A=
>   tests/nvme/018 |  6 +++---=0A=
>   tests/nvme/019 |  6 +++---=0A=
>   tests/nvme/020 |  6 +++---=0A=
>   tests/nvme/021 |  6 +++---=0A=
>   tests/nvme/022 |  6 +++---=0A=
>   tests/nvme/023 |  6 +++---=0A=
>   tests/nvme/024 |  6 +++---=0A=
>   tests/nvme/025 |  6 +++---=0A=
>   tests/nvme/026 |  6 +++---=0A=
>   tests/nvme/027 |  6 +++---=0A=
>   tests/nvme/028 |  8 ++++----=0A=
>   tests/nvme/029 |  6 +++---=0A=
>   tests/nvme/030 |  2 +-=0A=
>   tests/nvme/031 |  4 ++--=0A=
>   tests/nvme/rc  | 39 ++++++++++++++++++++++++++++++++-------=0A=
>   31 files changed, 110 insertions(+), 85 deletions(-)=0A=
> =0A=
> diff --git a/tests/nvme/002 b/tests/nvme/002=0A=
> index 999e222705bf..8540623497c7 100755=0A=
> --- a/tests/nvme/002=0A=
> +++ b/tests/nvme/002=0A=
> @@ -21,7 +21,7 @@ test() {=0A=
>   =0A=
>   	local iterations=3D1000=0A=
>   	local port=0A=
> -	port=3D"$(_create_nvmet_port "loop")"=0A=
> +	port=3D"$(_create_nvmet_port ${nvme_trtype})"=0A=
Is there a way to directly use nvme_trtype especially in rc ?=0A=
if not disregard this comment.=0A=
>   =0A=
>   	local loop_dev=0A=
>   	loop_dev=3D"$(losetup -f)"=0A=
> @@ -31,7 +31,7 @@ test() {=0A=
>   		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"=0A=
>   	done=0A=
>   =0A=
> -	_nvme_discover "loop" | _filter_discovery=0A=
> +	_nvme_discover "${nvme_trtype}" | _filter_discovery=0A=
Same here for nvme_trtype.=0A=
>   =0A=
>   	for ((i =3D iterations - 1; i >=3D 0; i--)); do=0A=
>   		_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-$i"=
=0A=
> diff --git a/tests/nvme/003 b/tests/nvme/003=0A=
> index 6ea6a23b7942..68f823011d7d 100755=0A=
> --- a/tests/nvme/003=0A=
> +++ b/tests/nvme/003=0A=
> @@ -21,7 +21,7 @@ test() {=0A=
>   	_setup_nvmet=0A=
>   =0A=
>   	local port=0A=
> -	port=3D"$(_create_nvmet_port "loop")"=0A=
> +	port=3D"$(_create_nvmet_port "${nvme_trtype}")"=0A=
>   =0A=
>   	local loop_dev=0A=
>   	loop_dev=3D"$(losetup -f)"=0A=
> @@ -29,7 +29,7 @@ test() {=0A=
>   	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}"=0A=
>   	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"=0A=
>   =0A=
> -	_nvme_connect_subsys "loop" "nqn.2014-08.org.nvmexpress.discovery"=0A=
> +	_nvme_connect_subsys "${nvme_trtype}" "nqn.2014-08.org.nvmexpress.disco=
very"=0A=
>   =0A=
Same here for nvme_trtype.=0A=
>   	# This is ugly but checking for the absence of error messages is ...=
=0A=
>   	sleep 10=0A=
> diff --git a/tests/nvme/004 b/tests/nvme/004=0A=
=0A=
> diff --git a/tests/nvme/018 b/tests/nvme/018=0A=
> index 4863274cc525..43340d3c4d25 100755=0A=
> --- a/tests/nvme/018=0A=
> +++ b/tests/nvme/018=0A=
> @@ -29,12 +29,12 @@ test() {=0A=
>   =0A=
>   	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \=0A=
>   		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"=0A=
> -	port=3D"$(_create_nvmet_port "loop")"=0A=
> +	port=3D"$(_create_nvmet_port ${nvme_trtype})"=0A=
>   	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"=0A=
>   =0A=
> -	_nvme_connect_subsys "loop" "${subsys_name}"=0A=
> +	_nvme_connect_subsys ${nvme_trtype} "${subsys_name}"=0A=
>   =0A=
> -	nvmedev=3D"$(_find_nvme_loop_dev)"=0A=
> +	nvmedev=3D"$(_find_nvme_dev)"=0A=
>   	cat "/sys/block/${nvmedev}n1/uuid"=0A=
>   	cat "/sys/block/${nvmedev}n1/wwid"=0A=
>   =0A=
> diff --git a/tests/nvme/019 b/tests/nvme/019=0A=
> index 19c5b4755387..98d82ae21b42 100755=0A=
> --- a/tests/nvme/019=0A=
> +++ b/tests/nvme/019=0A=
> @@ -33,12 +33,12 @@ test() {=0A=
>   =0A=
>   	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \=0A=
>   		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"=0A=
> -	port=3D"$(_create_nvmet_port "loop")"=0A=
> +	port=3D"$(_create_nvmet_port ${nvme_trtype})"> diff --git a/tests/nvme/=
004 b/tests/nvme/004=0A=
> index 7ea539fda55e..af434674beaa 100755=0A=
> --- a/tests/nvme/004=0A=
> +++ b/tests/nvme/004=0A=
> @@ -22,7 +22,7 @@ test() {=0A=
>   	_setup_nvmet=0A=
>   =0A=
>   	local port=0A=
> -	port=3D"$(_create_nvmet_port "loop")"=0A=
> +	port=3D"$(_create_nvmet_port ${nvme_trtype})"=0A=
>   =0A=
>   	truncate -s 1G "$TMPDIR/img"=0A=
>   =0A=
> @@ -33,10 +33,10 @@ test() {=0A=
>   		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"=0A=
>   	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"=0A=
>   =0A=
> -	_nvme_connect_subsys "loop" "blktests-subsystem-1"=0A=
> +	_nvme_connect_subsys ${nvme_trtype} "blktests-subsystem-1"=0A=
>   =0A=
>   	local nvmedev=0A=
> -	nvmedev=3D"$(_find_nvme_loop_dev)"=0A=
> +	nvmedev=3D"$(_find_nvme_dev)"=0A=
>   	cat "/sys/block/${nvmedev}n1/uuid"=0A=
>   	cat "/sys/block/${nvmedev}n1/wwid"=0A=
=0A=
Since we are touching nvmedev can we move above uuid and wwid to=0A=
a wrapper something like _nvme_show_uuid_wwid ${nvmedev}n1 ?=0A=
=0A=
>=0A=
> @@ -36,12 +36,12 @@ test() {=0A=
>   =0A=
>   	loop_dev=3D"$(losetup -f --show "$TMPDIR/img")"=0A=
>   =0A=
> -	port=3D"$(_create_nvmet_port "loop")"=0A=
> +	port=3D"$(_create_nvmet_port ${nvme_trtype})"=0A=
>   =0A=
>   	for ((i =3D 0; i < iterations; i++)); do=0A=
>   		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"=0A=
>   		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"=0A=
> -		_nvme_connect_subsys "loop" "${subsys}$i"=0A=
> +		_nvme_connect_subsys ${nvme_trtype} "${subsys}$i"=0A=
Same here for nvme_trtype as first comment.=0A=
>   		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1=0A=
>   		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"=0A=
>   		_remove_nvmet_subsystem "${subsys}$i"=0A=
> diff --git a/tests/nvme/rc b/tests/nvme/rc=0A=
> index 6d57cf591300..191f0497416a 100644=0A=
> --- a/tests/nvme/rc=0A=
> +++ b/tests/nvme/rc=0A=
> @@ -6,6 +6,9 @@=0A=
>   =0A=
>   . common/rc=0A=
>   =0A=
> +def_traddr=3D"127.0.0.1"=0A=
> +def_adrfam=3D"ipv4"=0A=
> +def_trsvcid=3D"4420"=0A=
>   nvme_trtype=3D${nvme_trtype:-"loop"}=0A=
>   =0A=
>   _nvme_requires() {=0A=
> @@ -62,8 +65,8 @@ _cleanup_nvmet() {=0A=
>   	for dev in /sys/class/nvme/nvme*; do=0A=
>   		dev=3D"$(basename "$dev")"=0A=
>   		transport=3D"$(cat "/sys/class/nvme/${dev}/transport")"=0A=
> -		if [[ "$transport" =3D=3D "loop" ]]; then=0A=
> -			echo "WARNING: Test did not clean up loop device: ${dev}"=0A=
> +		if [[ "$transport" =3D=3D "${nvme_trtype}" ]]; then=0A=
> +			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"=
=0A=
>   			_nvme_disconnect_ctrl "${dev}"=0A=
>   		fi=0A=
>   	done=0A=
> @@ -87,14 +90,20 @@ _cleanup_nvmet() {=0A=
>   	shopt -u nullglob=0A=
>   	trap SIGINT=0A=
>   =0A=
> -	modprobe -r nvme-loop 2>/dev/null=0A=
> +	modprobe -r nvme-${nvme_trtype} 2>/dev/null=0A=
> +	if [[ "${nvme_trtype}" !=3D "loop" ]]; then=0A=
> +		modprobe -r nvmet-${nvme_trtype} 2>/dev/null=0A=
This is not from your patch but I'd keep the error message it has=0A=
turned out to be useful for me when debugging refcount problem =0A=
especially unload and load scenario.=0A=
=0A=
> +	fi=0A=
>   	modprobe -r nvmet 2>/dev/null=0A=
>   }=0A=
>   =0A=
>   _setup_nvmet() {=0A=
>   	_register_test_cleanup _cleanup_nvmet=0A=
>   	modprobe nvmet=0A=
> -	modprobe nvme-loop=0A=
> +	if [[ "${nvme_trtype}" !=3D "loop" ]]; then=0A=
> +		modprobe nvmet-${nvme_trtype}=0A=
> +	fi=0A=
> +	modprobe nvme-${nvme_trtype}=0A=
>   }=0A=
>   =0A=
>   _nvme_disconnect_ctrl() {=0A=
> @@ -112,20 +121,33 @@ _nvme_disconnect_subsys() {=0A=
>   _nvme_connect_subsys() {=0A=
>   	local trtype=3D"$1"=0A=
>   	local subsysnqn=3D"$2"=0A=
> +	local traddr=3D"${3:-$def_traddr}"=0A=
> +	local trsvcid=3D"${4:-$def_trsvcid}"=0A=
>   =0A=
>   	cmd=3D"nvme connect -t ${trtype} -n ${subsysnqn}"=0A=
> +	if [[ "${trtype}" !=3D "loop" ]]; then=0A=
> +		cmd=3D$cmd" -a ${traddr} -s ${trsvcid}"=0A=
> +	fi=0A=
>   	eval $cmd=0A=
>   }=0A=
>   =0A=
>   _nvme_discover() {=0A=
>   	local trtype=3D"$1"=0A=
> +	local traddr=3D"${2:-$def_traddr}"=0A=
> +	local trsvcid=3D"${3:-$def_trsvcid}"=0A=
>   =0A=
>   	cmd=3D"nvme discover -t ${trtype}"=0A=
> +	if [[ "${trtype}" !=3D "loop" ]]; then=0A=
> +		cmd=3D$cmd" -a ${traddr} -s ${trsvcid}"=0A=
> +	fi=0A=
>   	eval $cmd=0A=
>   }=0A=
>   =0A=
>   _create_nvmet_port() {=0A=
>   	local trtype=3D"$1"=0A=
> +	local traddr=3D"${2:-$def_traddr}"=0A=
> +	local adrfam=3D"${3:-$def_adrfam}"=0A=
> +	local trsvcid=3D"${4:-$def_trsvcid}"=0A=
>   =0A=
>   	local port=0A=
>   	for ((port =3D 0; ; port++)); do=0A=
> @@ -136,6 +158,9 @@ _create_nvmet_port() {=0A=
>   =0A=
>   	mkdir "${NVMET_CFS}/ports/${port}"=0A=
>   	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"=0A=
> +	echo "${traddr}" > "${NVMET_CFS}/ports/${port}/addr_traddr"=0A=
> +	echo "${adrfam}" > "${NVMET_CFS}/ports/${port}/addr_adrfam"=0A=
> +	echo "${trsvcid}" > "${NVMET_CFS}/ports/${port}/addr_trsvcid"=0A=
=0A=
Do we need argument count check before we apply these to configfs ?=0A=
>   =0A=
>   	echo "${port}"=0A=
>   }=0A=
> @@ -207,13 +232,13 @@ _remove_nvmet_subsystem_from_port() {=0A=
>   	rm "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"=0A=
>   }=0A=
>   =0A=
> -_find_nvme_loop_dev() {=0A=
> +_find_nvme_dev() {=0A=
>   	local dev=0A=
>   	local transport=0A=
>   	for dev in /sys/class/nvme/nvme*; do=0A=
>   		dev=3D"$(basename "$dev")"=0A=
>   		transport=3D"$(cat "/sys/class/nvme/${dev}/transport")"=0A=
> -		if [[ "$transport" =3D=3D "loop" ]]; then=0A=
> +		if [[ "$transport" =3D=3D "${nvme_trtype}" ]]; then=0A=
>   			echo "$dev"=0A=
>   			for ((i =3D 0; i < 10; i++)); do=0A=
>   				if [[ -e /sys/block/$dev/uuid &&=0A=
> @@ -233,6 +258,6 @@ _filter_discovery() {=0A=
>   }=0A=
>   =0A=
>   _discovery_genctr() {=0A=
> -	_nvme_discover "loop" |=0A=
> +	_nvme_discover "${nvme_trtype}" |=0A=
>   		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'=0A=
>   }=0A=
> =0A=
=0A=
