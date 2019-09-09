Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C61DC4740A
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 17:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D986621924
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 17:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cuXZo2Op";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hAsuCnKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389872AbfIIRFe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 13:05:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39873 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfIIRFd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Sep 2019 13:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568048747; x=1599584747;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=caIthZQ02ztJBWqCIFwBAeAsgxR47w8+3ZMz2k2L6Ns=;
  b=cuXZo2OpgfBOo8l4HKcyQoj6PndXi1FR7iZpe7gUZf0wQOdp1Q4arUVI
   q77k5swSuess7/yOJ0poSuQjfTG9Qm25lO1cywXIDEii2bInRgFHWjpA3
   p3Dp/CqLSlkSgXS7/n+KSeTmvpaCfvTuDz72ipseT445qAZPW+Y86lYQS
   l9C8B/tLdaiYnBQfJbkVfVdGYDigpHD8w+QMs6msDZCbyHmmSsW9mGG50
   THPXDx3Gvo84KJrPlGVMD06HRFTxYOGK1Agn8FLGfrwqLOtI1X/7sowBj
   92G5qM5IZUI+fVXA4de2BrzmPFLm7HK8lLuIQVECkicGQdyJ8wRRCICj8
   A==;
IronPort-SDR: dCXCH+aT3+nzFMjTXofVblRRbb66bExe4jiE7ymQHDSb1VEKUNb5+kmnNnKeDSf02qMaYj0wAu
 t1SUjQlC4bjyzF4G2kAHm3YSnVIVdqbc2x1XhNmCFXEAUFmK/kW1Mj7qFZbCHG3fxi9DEQS4lx
 kV/8kRIxsiImp6zS8dcpwzj2cuek7IQpsRSlV1r15nffMsZOYneTicKm/pJVqkLn3dzxKS/I++
 LlXEwzz4CRVa8ZF9N3d/0gMx+9f6SHR2deW2u/bGspBYbMiHbKQm9fJ2k4F65JQ+rxqzDl4JRf
 hME=
X-IronPort-AV: E=Sophos;i="5.64,486,1559491200"; 
   d="scan'208";a="218508314"
Received: from mail-co1nam03lp2051.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.51])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2019 01:05:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYQHHYz3fDKBfeN7O1iNC7PlItrFFMRr5NyXLO0LeMOKZIDg8PNyP8UKH8YOv/5FpH3hcXs5VgpB+9Qv5eKNlSjpmULfJ0PTS6bq6JDzkhY5D1ZzsCFBqdNAPQpnmqVyOSLvr40wVE0//s4ZemzWSc568MeQQr1u/pN1+jiNqvkU2v3qFWGtt8DHVOyuKVsZXWIN19vgcTKJweCBaEG7FwqQnc9vafUFr5RPEhL0xR1p6KlU9dRa8h8YSilo96jiJVAB1xJBDt4msR684FHLWYCv+2wMp+uRFgWK0T/t1QJVoFy3pd1YYEDhHUtQ7vzLsp+t0VCsZmqNawJac3rVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTmb1UwrRNM3I7zO9yoaY4cCgPCaFg6oGdV5xIgjPO4=;
 b=muzfCsCg8/Q9jS1xj2OfyLBlhfEoFuD6sCl1nzbsDBcTB+U8EfJIrYN6FNqMNHvOeEncR36xN58QCzgVc5QrxG/i54ZQOf2xqB6tBy0xoeQXy+x/x4fmCfvjT3m+tzCxq7vzL8u5qCD4VwGwAGEORUVb3w3l+M31xQuaAPaY6T13nUevdmb7JtHa/EzXVxnQivjwdcTaLvT/M2SeZy1KeReXt6EV1oHaMf+X/u96dHdd9cq481OIzNnSAEf3yF0asnaGmn0fFA2xiahQ27wutdAnF6OAfiSk4BlIXYmcKLo29zDdDjcnxPf8qyfORkwVuae63Dxxyvv9KMbtliawLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTmb1UwrRNM3I7zO9yoaY4cCgPCaFg6oGdV5xIgjPO4=;
 b=hAsuCnKWeTXS1pmjEDjKOrqKC8+BypoGr/15sNdnx28UhxmQS+5a+gbJYyytLk1FUwkB1Ii1sBQr4Dve6ifKBM+NXRoS2baWGuw06dOI7FONgfZyNZzcH/CREX3jpYLpTGVLyPNfoO9yrfp6vQXtv8dT99gT5mH2zDASf18oX+Q=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5621.namprd04.prod.outlook.com (20.179.56.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Mon, 9 Sep 2019 17:05:30 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 17:05:30 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [PATCH blktests] block/027: remove duplicate --group_reporting=1
Thread-Topic: [PATCH blktests] block/027: remove duplicate --group_reporting=1
Thread-Index: AQHVZy+TlFr3ER/zckibnUaoeLY8Fw==
Date:   Mon, 9 Sep 2019 17:05:30 +0000
Message-ID: <BYAPR04MB5749D90F72105513AD59887386B70@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190909165506.14716-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef52a0d4-c51e-49ed-7316-08d73547eb32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5621;
x-ms-traffictypediagnostic: BYAPR04MB5621:
x-microsoft-antispam-prvs: <BYAPR04MB56219A2BB8818A5B8C9DE01C86B70@BYAPR04MB5621.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:124;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(189003)(199004)(25786009)(8936002)(498600001)(3846002)(26005)(186003)(6116002)(486006)(476003)(2906002)(53936002)(305945005)(33656002)(110136005)(229853002)(55016002)(6246003)(9686003)(74316002)(52536014)(66476007)(71190400001)(71200400001)(86362001)(6436002)(64756008)(66446008)(66556008)(2501003)(256004)(446003)(4326008)(5660300002)(66066001)(81156014)(81166006)(6506007)(7736002)(76116006)(102836004)(99286004)(14454004)(7696005)(66946007)(8676002)(4744005)(14444005)(76176011)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5621;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eP+aajtxxdVcoZC0r+PkmiiezSXgtv+P25QcGMt3KGyvM0YyeXbvYxdlawPlQKHbu3I7VvGhP3PKZr3RrR4noF6kSRL3HJ41sAJxNKe1TDP7+hT4xo6xo76LskntW3AsStKML0+qa5KL5Sv9DRxmc2p20PzXEuzPYmsFJ6wcDjqdSdSUR/UZLnF5a79EpZxlcsp1eAOeNHMLxUcVye7zDwS+kL+i6pXWP02xm42F3mdn2jbVpiHclrT/bquBsmu59kweCZeE0vdHX6ODgJip2PcqY24xYREhgNnTF+WmjC/Kr+2Jz2OzZ69e7Lo/LOAwJRrlDO7LWaku8Vxi7frkNLc1E6rrua2pFqmO6doiZpIwFOigFGIbxo87SYeCD+m/lTYUnoolmvvaPutNaGUpGqIp0nFQdPLppcOTdIPya5o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef52a0d4-c51e-49ed-7316-08d73547eb32
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 17:05:30.0267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: py3eLvqjP3aIUjQa/g0D1UUZkLi5AIJJ7Nb+4dT4j33qdobcvy3M4rYg/Bi4iitgvlDEdCEcgc0CF+w39VOh0e1QVZjZPRuE7UtHsi+geZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5621
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Good catch Yang, looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 09/09/2019 09:56 AM, Yi Zhang wrote:=0A=
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>=0A=
> ---=0A=
>   tests/block/027 | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/tests/block/027 b/tests/block/027=0A=
> index 0ff9e4c..e818bf7 100755=0A=
> --- a/tests/block/027=0A=
> +++ b/tests/block/027=0A=
> @@ -56,7 +56,7 @@ scsi_debug_stress_remove() {=0A=
>   	local num_jobs=3D4 runtime=3D12=0A=
>   	fio --rw=3Drandread --size=3D128G --direct=3D1 --ioengine=3Dlibaio \=
=0A=
>   		--iodepth=3D2048 --numjobs=3D$num_jobs --bs=3D4k \=0A=
> -		--group_reporting=3D1 --group_reporting=3D1 --runtime=3D$runtime \=0A=
> +		--group_reporting=3D1 --runtime=3D$runtime \=0A=
>   		--loops=3D10000 --cgroup=3D"blktests/${TEST_NAME}" \=0A=
>   		"${fio_jobs[@]}" > "$FULL" 2>&1 &=0A=
>=0A=
>=0A=
=0A=
