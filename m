Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091DDC4363D
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 00:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A08FA20739
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 00:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eFpmzK7D";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wXsqeRmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgJGACM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 20:02:12 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31677 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJGACM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 20:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602028932; x=1633564932;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ljdPZKNshwOcCoiKCGzJN++GZTIK66ghb+NYu3NK+JQ=;
  b=eFpmzK7D/zQs5eXG1nIeEyxe3FYIjM4Hc4Q6ONH20wxPgbhJRZRFxGYp
   Yn/XGgffMafms6+7QXhkKXc31VZXXu0EtzX9o2ZUz3krxsw4395mP8XKa
   INrljDX+CqlcISGsHxD+DhSOxvH17+E8AZsaNHR34Un3cIqlJr/+UEo3W
   2bB7rEjW/1RAWkhe/hVVy5Unglv1/Wno3GAaVLdlqPKx7o0u9lMMx9BWt
   BRMim6V4uylFmq4azZ2GqI1qZyZKvY+rNfCK4xqe3BN7vNftT+JSRgE03
   GttC6ad/FsDAoeok33jgsN2Ch/Q0HXYkeXtgDuSbHPGSFgONqRM9bUeYw
   A==;
IronPort-SDR: lzonD3ADaAweDDA8oUGjyHCKomte3Bu/pE4smydq9Eea1oPgzu1OMATtVa3kukQuBoWU5RUIvv
 z3KJmFA9BNTjlRxpjz5BOR5eo7N9F82EUrCnnp7DRhKShJ+YRJUHRLKv4uBmylDQOBeF2+Iwl1
 qjQlUlcqg5yKpGQEiStiWkvej1XPWVd89zQXqWZMu0tjjkbYR1/q1vpgUNrbJ1Y6n659Mk4sZC
 EeyOpAB2UR+d6FYqwb6KY86cEaNog/VTvcbV35JTjmKM7xOX8jDNdXsGFX1Ux/86rusR9CIoBC
 3x8=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; 
   d="scan'208";a="149280027"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 08:02:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkhRyaLJW9CtaXkCNgZZLwW3gorKypgmuDK7n405QFD5HgQjHqahu13orfEsKFHHxH2CLy7dt3qxWAESoH4cQMeZUWXFtHOucEGzLEqf27Uf8nrYpeE4lgjW1/UL1ihcE6ZYTd9v8b1YMQUgnCl5n7tq7TLkycfJTav4uzgQP8s8roQdb1H4EBNYFFpxebObejvLNDqepZIF6k6v/6ixpoSqWv/2VeuxzmbJoM9Bi2+CrRCFwP+akP+SRrhUD4tXC8kSRpreKUhr6vS+6ddabwKm9JW30eDb71jG9llOTvuVhlnF+dXo68Yqq/QNQjxF8lNRXunzSdfcGh2teacUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3nEjWpZIMaD3BPDMc6LGqquELG/PO6E6QuxWuGou/g=;
 b=PWrpFG4V4sADC/ZLjuBVeG3GSrkltNDe6CmDdsStgo2/E/HkSaffniR08VuWAsVcHOqWk5finca3CGGmsfXjHN4cVDqdDpt2l62iZwCAAknGKzr6PmxJM0fexGvFm/L31zUMLj/aQJF+dsdIXHwnfh5zYp0Fua1YujtN0YzojKqSrte+tK3L2umf3kRbDq9khebQN7wVHoWZsX1z+y4F69DTQ0qa7E1GHTBd0IrzGTVURhzCtk3ZnS3I1qA4+2RRl8sA/1qDZe3O9AumXhmfC1McxwXI/VIgwPqEqwVn51PLzi6mwYEKX7FQ0rQTNL2+zGgeCa+TlEJQcu8DlK+dww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3nEjWpZIMaD3BPDMc6LGqquELG/PO6E6QuxWuGou/g=;
 b=wXsqeRmmwTbAT0NsBG/2F2i5SmLVIbYWKBe6GF17Zzynvy1Ez6G9HOSEXJ6h5BxqaQgy8lxY0E7bK3FsyQ/9zM6Kvq7H/gZDpFqZtq6LcCbXLZDK7QnhPE/kxsSBQYMCwbdAD9cYVtFvHU+HSqRhNL/XHRVqKyY5K9D7hKMw6aU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4037.namprd04.prod.outlook.com (2603:10b6:a02:aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Wed, 7 Oct
 2020 00:02:09 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698%7]) with mapi id 15.20.3433.044; Wed, 7 Oct 2020
 00:02:09 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH blktests v2 05/11] nvme: Add common helpers for passthru
 tests
Thread-Topic: [PATCH blktests v2 05/11] nvme: Add common helpers for passthru
 tests
Thread-Index: AQHWl1wk5ovaYXCvmkSyan6E05rb7g==
Date:   Wed, 7 Oct 2020 00:02:09 +0000
Message-ID: <BYAPR04MB49654DCBAD729B05759EB6FF860A0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-6-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45edad90-7299-4181-7371-08d86a543c7d
x-ms-traffictypediagnostic: BYAPR04MB4037:
x-microsoft-antispam-prvs: <BYAPR04MB403784CC726EBA4AB56A1B0C860A0@BYAPR04MB4037.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0oJ3P/SQEq5NiwhiHSAlsSiAMnUFyjPR7wZWVKmuYQRUSeDLk1dmr1KSOJdj87ibhLkLStq6AouDWJCYq1B5wMchDge5VB9PPmaDE0SypISVktfHIlmpTSs8Ptr0A/M8OoxJri7w6m4P0Nvj38WUNGONimG9kNNbuuZRgPu8qYMZjrOcW5WTkALs+P3iNkkQ4+FpkYgEfMDTChVcs68EdS1MuPCM286vyv09M8UPvl1t/pAyKouD0xaxYnXtLEA2Nr3fClpK0IxbtjDuyKCTvJ3YN2NMwuXiBK61XB7GA6JMGmNIuUg+YtjHaM5K/5XhA/G3fJDJZJotYFsBAV/AyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(66946007)(5660300002)(86362001)(83380400001)(76116006)(64756008)(66446008)(52536014)(9686003)(66476007)(55016002)(26005)(66556008)(186003)(4326008)(498600001)(6506007)(7696005)(2906002)(53546011)(33656002)(54906003)(110136005)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VEP18dS8DHEQpr7uNIvXeiPCxM5YtJIjKmD24Tq2TUa+9sfF7WJII6HHJi+q7ze/3kMm3rQiNOqX/QNwTAWYzPt89OKZjLcnduw4Xwc8guW12f6u2fo6QHUDcPAvCwTQeBgMgiiwmkdSuPRXwbdWmzl3Lp3py33+yEYyo3zoEbZatEGdDKGJSn7TdoLxTDREeSFFwO0NxTljhTnDMgoUb+C+AHME6hWRa1OyNjTQb4UxfSV0bU2G6RpHWOYJvaGX+l+OP26mZea3gwGRDyAk7iA3RH4kdTnsLgAz8IAbc+6RX5PLTXEvzYkqHry47jxs6+EMQqk/7hAFc6Nhf33mM+yXknIKcHBFvFSqZGRqAPGqVQTzUug3fxyomV05c2Uug3n+wyg/ciWH9ppFhGsH6Jv1Acla3wbaZ6zHF/dJbtc5UqDnlqJaPlsvwA+pr0t125DbSGCcw5wJTIjHnNsW/RIi6O9AmqNeT4uFlIUfCMCQftaPG8j+AWxPVwb5FFmswEG5c94tVV4zUXcpXb+ps+9K412XGIirqjRVxfwnulxlaY3pOWVBFqukdl87ZHA1c0JuR36RpByoMwFXQVUrLh4O6loPsqbCCuuDtObghfdTnh1ZVL7zrX8WyJZ2BvJEPtJhvS4xRug0F62g4HFV4g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45edad90-7299-4181-7371-08d86a543c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 00:02:09.6127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3TBpTNX0tchE/OO5Nqa1ZbbidNnhtkT6S9RI8yv2W/K6EuENFzrmq5e+mF4gxA/GC56aid9eGnxoVQnhBeh+m3I0JpdFcMy73g8P4M0RXvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4037
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/30/20 12:01, Logan Gunthorpe wrote:=0A=
> Add some simple helpers to setup a passthru target that passes through=0A=
> to a nvme test device.=0A=
>=0A=
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>=0A=
> ---=0A=
>  tests/nvme/rc | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>  1 file changed, 76 insertions(+)=0A=
>=0A=
> diff --git a/tests/nvme/rc b/tests/nvme/rc=0A=
> index dfa57a299625..1ea23308a3f7 100644=0A=
> --- a/tests/nvme/rc=0A=
> +++ b/tests/nvme/rc=0A=
> @@ -73,6 +73,17 @@ _require_nvme_trtype_is_fabrics() {=0A=
>  	return 0=0A=
>  }=0A=
>  =0A=
> +_test_dev_nvme_ctrl() {=0A=
> +	local dev=0A=
> +=0A=
> +	dev=3D$(cat "${TEST_DEV_SYSFS}/device/dev")=0A=
 can you initialize dev this at the time of declaration ?=0A=
> +	echo "/dev/char/${dev}"=0A=
> +}=0A=
> +=0A=
> +_test_dev_nvme_nsid() {=0A=
> +	cat "${TEST_DEV_SYSFS}/nsid"=0A=
> +}=0A=
> +=0A=
>  _cleanup_nvmet() {=0A=
>  	local dev=0A=
>  	local port=0A=
> @@ -257,6 +268,27 @@ _remove_nvmet_subsystem() {=0A=
>  	rmdir "${subsys_path}"=0A=
>  }=0A=
>  =0A=
> +_create_nvmet_passthru() {=0A=
> +	local nvmet_subsystem=3D"$1"=0A=
> +	local subsys_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"=0A=
> +	local passthru_path=3D"${subsys_path}/passthru"=0A=
> +=0A=
> +	mkdir -p "${subsys_path}"=0A=
> +	printf 1 > "${subsys_path}/attr_allow_any_host"=0A=
> +=0A=
> +	printf "%s" "$(_test_dev_nvme_ctrl)" > "${passthru_path}/device_path"=
=0A=
> +	printf 1 > "${passthru_path}/enable"=0A=
=0A=
can you please echo in general and printf only when it is needed ?=0A=
=0A=
I know existing code is a bit inconsistent I'll send a clenup to make it=0A=
uniform.=0A=
=0A=
> +}=0A=
> +=0A=
> +_remove_nvmet_passhtru() {=0A=
> +	local nvmet_subsystem=3D"$1"=0A=
> +	local subsys_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"=0A=
> +	local passthru_path=3D"${subsys_path}/passthru"=0A=
> +=0A=
> +	printf 0 > "${passthru_path}/enable"=0A=
> +	rmdir "${subsys_path}"=0A=
> +}=0A=
> +=0A=
>  _add_nvmet_subsys_to_port() {=0A=
>  	local port=3D"$1"=0A=
>  	local nvmet_subsystem=3D"$2"=0A=
> @@ -292,6 +324,50 @@ _find_nvme_dev() {=0A=
>  	done=0A=
>  }=0A=
>  =0A=
> +_find_nvme_passthru_loop_dev() {=0A=
> +	local subsys=3D$1=0A=
> +	local nsid=0A=
> +	local dev=0A=
> +=0A=
> +	dev=3D$(_find_nvme_dev "${subsys}")=0A=
> +	nsid=3D$(_test_dev_nvme_nsid)=0A=
> +	echo "/dev/${dev}n${nsid}"=0A=
> +}=0A=
> +=0A=
> +_nvmet_passthru_target_setup() {=0A=
> +	local subsys_name=3D$1=0A=
> +=0A=
> +	_create_nvmet_passthru "${subsys_name}"=0A=
> +	port=3D"$(_create_nvmet_port "loop")"=0A=
> +	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"=0A=
> +=0A=
> +	echo "$port"=0A=
> +}=0A=
> +=0A=
> +_nvmet_passthru_target_connect() {=0A=
> +	local trtype=3D$1=0A=
> +	local subsys_name=3D$2=0A=
> +=0A=
> +	_nvme_connect_subsys "${trtype}" "${subsys_name}"=0A=
> +	nsdev=3D$(_find_nvme_passthru_loop_dev "${subsys_name}")=0A=
> +=0A=
> +	# The following tests can race with the creation=0A=
> +	# of the device so ensure the block device exists=0A=
> +	# before continuing=0A=
> +	while [ ! -b "${nsdev}" ]; do sleep 1; done=0A=
> +=0A=
> +	echo "${nsdev}"=0A=
> +}=0A=
> +=0A=
> +_nvmet_passthru_target_cleanup() {=0A=
> +	local port=3D$1=0A=
> +	local subsys_name=3D$2=0A=
> +=0A=
> +	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"=0A=
> +	_remove_nvmet_port "${port}"=0A=
> +	_remove_nvmet_passhtru "${subsys_name}"=0A=
> +}=0A=
> +=0A=
>  _filter_discovery() {=0A=
>  	sed -n -r -e "s/Generation counter [0-9]+/Generation counter X/" \=0A=
>  		  -e '/Discovery Log Number|Log Entry|trtype|subnqn/p'=0A=
=0A=
=0A=
