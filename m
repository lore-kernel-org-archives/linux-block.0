Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE113EE57F8
	for <linux-block@archiver.kernel.org>; Fri,  8 Sep 2023 11:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjIHL0j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Sep 2023 07:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjIHL0i (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Sep 2023 07:26:38 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70FB173B
        for <linux-block@vger.kernel.org>; Fri,  8 Sep 2023 04:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694172394; x=1725708394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dlClcY7K3AL6cn+rFYEcDf5c8Wk0SOjaSEYC/Jp/pck=;
  b=OxDRTj9CR7594tlg+5XLworN+TbCOh+CxGJPja3/WjNNWip0ksNvbwoH
   FPz1JyhFSIHmF1iyzGGn/MdpAHjqvuVJPtElob2XTn3XxwJkXP+rkh+sz
   JccLXn0Kge0ORDdnx73XZC0VZfI7qjFt+Gj/cX+adLgDNx+Apukknd31V
   wCQHBG5nDGIexMtkObcAS+U11q5OWPWtxc309op8VouUP+GaBzHIDXSEj
   6aMbMcJcTlDl8f924fpP5vHRIJENBF2jeWp5b8H/nmOiylMqxM8C9HpW3
   MA2JI1A6I/QCe8mI3I90Laym4DJyCU9Qx0iiVxgsHoHNabwTIQsnMrzKy
   w==;
X-CSE-ConnectionGUID: zu9KhLRqTeGLonWrW3ajrw==
X-CSE-MsgGUID: UHGuBl9wQ3eZ8qhOiOTx1w==
X-IronPort-AV: E=Sophos;i="6.02,237,1688400000"; 
   d="scan'208";a="241556823"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2023 19:26:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlfOFb44W+1mzhKo7V265D+OJ4uHLQbbM1WYFiO8pu52kj/jkk/S++5SEn8ilO1wUJtFX2+paY1P5APPCbA25X0SLUrIuCRoEvpwarCDuHwTkkd2GOQ7FPoVZyBqzxJc3g8AyQrl4okAX0oqZ8J4H7XQ4LsgEBWcPDR7nAR1xR5I/5cMi5r2LzMENs9MP5GJLuqhTRqkUqjmPECj1chazazCgDqI+vSDJqVw3q6RprXvBgduQZYmsUtB4N87wQ1SiJDJWr7sxZrR98KQIuC0KJ1htHRwjyyV9vHlNsztnoD+cGKXbGUkdAonZonMDzENW1QwLc/Mf6cnkHCcUUMC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWhp23EEVlOQDh+DIOgLrqQ3lE5G1U3qcCVhsH1qlJU=;
 b=Tpv9EK8aXt+dr+I6AR6eywk4Pzqlh0N9wMnHDN6lKMoxGcfkFzmhYXhEqGsaG7SX4w2leymsm8WJsrJawBI/U96KZdJ6i7p6NcwMt01azkiPCqsTWCv3txJT30YPSsrPstrA05Shma3Oq616bLwjN7NYBoV0a62hwhxSgWTDQUqVbyRX9gALYaahIuOWa3x7dBXHSSPY/TOzZjXe7cUXUJ8iibbAmZqRL0HKwquAeV5NlHd9dAK/Awozi9hvB+cJIAC1ayM7xDCOWLFUqhDU2IoWJa3u5bwp7oqpYCLPLBRl9c9nmArDTctQwbejy6Aowh96NocUXfHZSJkpQ9q7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWhp23EEVlOQDh+DIOgLrqQ3lE5G1U3qcCVhsH1qlJU=;
 b=MyahP/YL1IyP2Sh3f0km+9wkcD3skSXjGoQ+3bega+hTwStixyZvu7T2DPl+tZjLvuhRCMS8byRbHBRDOYvXr0n4p+uhSS6oxg4EN03EU/IyEMvWwqEDL/fQwFP71SwbdSiEZr8X+dst9gRTPSBLSl86wHoGT/zabvm7V5WmzD8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7746.namprd04.prod.outlook.com (2603:10b6:5:356::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.11; Fri, 8 Sep 2023 11:26:32 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6792.009; Fri, 8 Sep 2023
 11:26:31 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "dwagner@suse.de" <dwagner@suse.de>
Subject: Re: [PATCH blktests] tests/nvme/031: fix connecting faiure
Thread-Topic: [PATCH blktests] tests/nvme/031: fix connecting faiure
Thread-Index: AQHZ4T2oqmvmMH8z00mCjjVD3irOrLAQzBEA
Date:   Fri, 8 Sep 2023 11:26:31 +0000
Message-ID: <nrfuja62qetxqxzwxuxhjve2u4r4reofcpo43zmg6qbbhjjqkp@ratsu2kubymb>
References: <20230907034423.3928010-1-yi.zhang@redhat.com>
In-Reply-To: <20230907034423.3928010-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7746:EE_
x-ms-office365-filtering-correlation-id: b1679502-fdec-424a-a21e-08dbb05e73c0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v6ACOt5fClLpAkD4vBzmArAMfDfCHtirt2iwyqphkuh0vLjnP2TA6ps988RMj+8Efieq0znoiiw3KhplHl8NdrtCK15Y4nQjmZNfnMqoIStmZzqai4A9l1k1Vg/95+7hOsTmNTckpn1A1NqM0BaJ0d9jjvyJioYZr+L88lNTM0OvOD7oDDORJt/ZFxNrzovDV8w1AXUeiUepDM+UjqNaDB6RPPZQ7CeYNo8pwnw1ZI//ObZyZkdLRwh/skMfj4W0ki5HlBPx5x2ufLkhfX3ddd/gbJqN5HLMU1H7hl1mW2eiTslNRnyjdRCtNR1zI11TNJGgD0MlJL+22HRZYYp+eEtRi+N1l87mRO1KreLEH1wAGaVmrql0CP/u7TGyQI51PlpOE9XIz2B+UBf6724BOPKjAZ7EbLHUihZd7MvNFbFY2ztTz8MUjV5I7UI62J0LP3NOeIC/xJm1GiLxXWxJI23FpMpcJXGVCGHncpvUOnJDST/VoY/pJsp2clLPau0r2EQsY2HuCFZ6q6Pasxi0bIQaqrkF6mYeoGS1G7kBusReRpr8aIEwy4lxYPQZqAsZ9Jjv0w/n4+Qpz6Odea+e+aOLAkfuotkxBL6MEd7sH3M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(366004)(39860400002)(346002)(396003)(1800799009)(186009)(451199024)(6506007)(6486002)(41300700001)(82960400001)(122000001)(2906002)(478600001)(86362001)(316002)(33716001)(66476007)(6916009)(91956017)(64756008)(66946007)(66556008)(66446008)(76116006)(38100700002)(38070700005)(71200400001)(54906003)(5660300002)(83380400001)(8936002)(8676002)(4326008)(26005)(44832011)(6512007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jse9N81/XFkaQ5hU+UmQh+67uCYh1uu61SRwa9sKxvse28fmOxVN2SVWgSqK?=
 =?us-ascii?Q?trfPuhxEin+Wlj4j2k8O/5CvHIat0y3arY4DWuv7liFRw2qaxUB4BJWsHo6X?=
 =?us-ascii?Q?OVAlISS7F68z7MfAtU8vGC+hFcM/BIZYbuyJrRe/2v7qQ86vLJEvM4iOIois?=
 =?us-ascii?Q?8pbrymo7cNvuk1TQcN+FN/1l3QEWf1glbY5KfWb5uyvpfGjC8rPK47p7NurJ?=
 =?us-ascii?Q?DdXMKg22K3U4NxR7LH5ZYhLcmXX4c3DfEAqXTTfCYwTfkZlZMBjG5JMvfcM8?=
 =?us-ascii?Q?vgH4QGc43fg9rhmuUXLUd+3vC/0T/RpQly0b0Iclb2G770Vyp57rDd/hnKhM?=
 =?us-ascii?Q?vD9UKvqkxBR2TgYWwDpfdQr4VvIXIBpYo2Eh8M0t82JFHh3Xk/PgFlHUSFFQ?=
 =?us-ascii?Q?B+fVRVydw0SRx+Wnys84inUrQXIbJ6hQD0OGrklKGPBrmloxGIE9aVzO53z0?=
 =?us-ascii?Q?ctc6XlqpW3MiTaCyfOxd7cPmsT3eH03wevUV4+JFOWTsl3okMWVlXXHarRjP?=
 =?us-ascii?Q?g5lPVokiY9p01ck5lVbN5fY/EXH+VLdZxUpBA6wZD8cAxHEAqUm57gNcOEc3?=
 =?us-ascii?Q?vc+hQcEWwMOdCSOOV7PKxM97GnD64exNrSKRROLzHG3Bx7gaMEwBSWtaBY1R?=
 =?us-ascii?Q?JO3YNYB7KAHbDYRtZg60PLJBGjgGJCQht3Dls5fkWZLbsne/X8fUdC0pLSaZ?=
 =?us-ascii?Q?xEhFmjzIyPD3rvHP9fg2nN2pGZfEK/MF6Hc+FdMaMOwMhMBDxc86PkyG1aEI?=
 =?us-ascii?Q?+zK3Urji/0yNcaeEv10BtjM3Uwwx8nYc8njPfRRPdu7vPnG1gj8Bw0JqdBGe?=
 =?us-ascii?Q?HA0UJuIbIF0Z6hXTSLF6/XmbCmgoUhoybGdkHA7/nU7gP5AxLaIuFb4NS4E/?=
 =?us-ascii?Q?WZslGpPgQAx4nZ1zpPq2kAxH8APD1ZQ/dUKyZlRRaaH5AVbUyCztZvTCbCTO?=
 =?us-ascii?Q?NjW0XISeHIeBKieRWUisKJwvMXmQNLVQtc6t/h8pZ6qwGtiHYACZzMqLFv3n?=
 =?us-ascii?Q?EYmg3BtPLaAXzl2lmgcHynfj0KJbXnznsnXBKcpJyrvsn30H49YAR0h7YhLk?=
 =?us-ascii?Q?rfz5+rLmN1kg5/Vosg1WzjNkWvNoYtpreDmIYweK2Ri6fgftb09lZIQo3Es0?=
 =?us-ascii?Q?zCNfimd82o/a5ldEB6M0xIWxpbTZTYf6E90UQJ5D1j3Qb1Y9Uf7aXJUu1mHC?=
 =?us-ascii?Q?UvYCMU+WdZsxfGYT5wflmpUZPGdRmr9ft8K4+eeJ3Pmkev1tZMLck22X7NqR?=
 =?us-ascii?Q?nEnnJ+V2zdKpbXLriQokEcJcIUYefGsGetSbrPW99XDytAMPHecN1o5mD8Zb?=
 =?us-ascii?Q?hdDsYVTKJ/w2tmWGAXjBNeh4HpPnQTeHZlNBqAGZXbxLVcTuHaoahf4dvM8Y?=
 =?us-ascii?Q?MlhikeH96074hthiFUcWft2SJBtb5OsxMcqZNtjJwF9UEKWh82h6f29kT3UF?=
 =?us-ascii?Q?ZZeZPxz6StTUkM4J2TyPUDntIQKFBfERZzXes/O6hVBxcMOzwJwlsJvrIppg?=
 =?us-ascii?Q?0BoauGLFJcL/rrbiKA1E4WeoSFraT82w1M0fInd6HmaCSPcSZavPCrz0pcUv?=
 =?us-ascii?Q?XuaXBgu9blG/myvrDpMnDXBOH3UINu4sYk2oc0yXaF6uROwQUl9141wVaEHt?=
 =?us-ascii?Q?Zs9RmruDWnYidJL9hrIihhQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <75B64DDAF4EBD844AB13EB701E5F87E9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3CRkvKOW1jdp0kI5NjkBKdN+/FPKKQilLPrrZDrZRKV/mZl3bxPJ5v/+CTkD2alf1XctOtfS7i/kl3mQEU74RLmFgigukr73Fa0xUTKJDRr1oJc39udoJWj29tEOT4lQnvi7tzjycWCDi+0AyHvLzt5NzwtrSo6qs08UzLJ4fKt2A7wA0g8aBEHEZmMGykfpHezOG/2uMlwLpeUB/Lz91zkYjVKB2q7UHt7LaJ8F1SxhE3x3GIlx6YOCx8GNRX7s3qXrGCaPxzDFdp5yauAJSu9eqU+yQ6MeRNqHHJl9pfDpxEFEHuPEtCCAE5qy8HogB1dnGPo1CHi6ZAA/4u5IfSH1/IIsMH+lefCsqK5rXDdf/ajyPbavpoQUA2E/KthuOLcK9naVH/8mLNJz0TH60zncc9B9Ja7ZqZaERQ7oWrGW4754dTS7Z8amvQZt7MhDFHXJLWrZhtPj03cplnT+PxpGbZ6lINc1Ic35VA9aHDy4zCXVvua6CIjeLdtxPauqUu1DRaovbjgzxApcji2jGwzjorx7rYhvtzTZOqmZAB22x75l83Rl+k6yqG3zwTz79nDplalS5tO2yUrkbLyHYw/xEprVaAa/NfgzmO3n+/CrKduUEuE9ZpFOK54uHRzNuEiqtUvqhK3989gW6tO1sz26LbtjRwOd6782JA6kgrjKPXL1FWRdeAvxz1HPaTkxdnTAFr3aMj9CKA4wtLG0oJPXbap1zxvonUpUc9pf2qATMfa1A58TGxPlOTzc2T3lTdB23TBrmiGG51jdRTnqYdxUV8IK7PMUvp5EKt322+VJbdbfnKBEx0dKyK64OiHfXK4OxNaWnVcHR/+XYSuW/E5LWkVctBPjrEamM2LnH5mwrc+4349dFEolWcbsYhrp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1679502-fdec-424a-a21e-08dbb05e73c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 11:26:31.7982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjDJTlOtex6aGSFSQJr1k4pRzFhPfEnkRGcwyQEJqt69rD8w0fDco5I0kwi4ouWwM5gERtxhThSiHulOeDBA3FSazKGr2tRK4/9IEump15g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7746
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sep 07, 2023 / 11:44, Yi Zhang wrote:
> allow_any_host was disabled during _create_nvmet_subsystem, call
> _create_nvmet_host before connecting to allow the host to connect.
>=20
> [76096.420586] nvmet: adding nsid 1 to subsystem blktests-subsystem-0
> [76096.440595] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [76096.491344] nvmet: connect by host nqn.2014-08.org.nvmexpress:uuid:0f0=
1fb42-9f7f-4856-b0b3-51e60b8de349 for subsystem blktests-subsystem-0 not al=
lowed
> [76096.505049] nvme nvme2: Connect for subsystem blktests-subsystem-0 is =
not allowed, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0=
b3-51e60b8de349
> [76096.519609] nvme nvme2: failed to connect queue: 0 ret=3D16772
>=20
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

Thanks for the catching this. I looked back the past changes and found that=
 the
commit c32b233b7dd6 ("nvme/rc: Add helper for adding/removing to allow list=
")
triggered the connection failure. So, I think a Fixes tag with this commit =
is
required (I can add when this patch is applied).

Even after the commit, the test case still passes. That's why I did not not=
ice
the connection failure. I think _nvme_connect_subsys() should check exit st=
atus
of "nvme connect" command and print an error message on failure. This will =
help
to catch similar connection failures in future.

As for this patch, I will wait some days for further comments. Also will do=
 some
confirmation test runs.

> ---
>  tests/nvme/031 | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/nvme/031 b/tests/nvme/031
> index d5c2561..696db2d 100755
> --- a/tests/nvme/031
> +++ b/tests/nvme/031
> @@ -42,10 +42,12 @@ test() {
>  	for ((i =3D 0; i < iterations; i++)); do
>  		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
>  		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
> +		_create_nvmet_host "${subsys}$i" "${def_hostnqn}"
>  		_nvme_connect_subsys "${nvme_trtype}" "${subsys}$i"
>  		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
>  		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
>  		_remove_nvmet_subsystem "${subsys}$i"
> +		_remove_nvmet_host "${def_hostnqn}"
>  	done
> =20
>  	_remove_nvmet_port "${port}"
> --=20
> 2.34.3
> =
