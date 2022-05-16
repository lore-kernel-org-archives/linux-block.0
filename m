Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB97C433F5
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 01:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiEPBLH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 21:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiEPBLF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 21:11:05 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523B2BF76
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 18:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652663461; x=1684199461;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PPg7HE2DBVczZr2CdOprzvqFIfcYKmgbcrE8RwgD1Q8=;
  b=Rm0e4TAkk/T8r5aS+2ZjMYEmEmXJRh1GEBCigPqgXkwnPGwEkbIpmi2l
   dznJWK8uU8qHc0Wb+hTRo9+L58DblMT3OGsvUTrytR89S63V8sKnFpz1D
   nXT1wFcM5ikeTXAPC0+gkEag4Uer2nz+pRwRkZhy0dELVCMxQ0tq9QwsX
   L52ynfbK4VheixfxpyjRZRS0CPxI2ouiiNmtXpPHtRmiYsHPHUy9Zdg0H
   jk0THRGX0u4JKWmIzzxNAEpIxRqKrZsJA0It7F0GS/ftzZihl+cuVkFPH
   o8DbsaKgNagQ0kkqXOlxZ7LTSLDEEcbnGIae1osdOADunbkBkiud9yaAJ
   w==;
X-IronPort-AV: E=Sophos;i="5.91,229,1647273600"; 
   d="scan'208";a="200392061"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 09:10:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LH3kGgNGf/fOrS1RRjmBYXw9EEZr3DVpM9D72FrHp/fgwYMPwJkDm1/1jaE49XtcwiV4qzD5lBcnG0ZauHoxAFcYiKiNhlRKeU1gpqFfU1hN8T2Hghu8NZZPgkrjYaZFHO5BldvkHpdm7BvWC/3xBgduFiA3GoUXDeV8EGgumoZNkBydVCgJVmRuVCnLVPcQq1rttMM/5tW8okMDuuHlD8+eR5SkKoqg+GNCWOWiBWFuScllQqGNH9DuDZNB8IVi3ob0s9Vv0g0WTNLjwvvu9xULw7kpME7NLd+sMk2tT16HIkG8R8ZfGFF8fcgqin4bDS1py+IBrm5uOqb7LnsE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBw8USXZCWRqb/G64baC+Ixd0Ec48MWbc/xIBobzrzU=;
 b=EOZB80b96O/2J8M7w3Az5NwuCDCXza2EeetN6G8iLa36AMdcdXqwVIzcaA6TNn/Q2wmLlgN8ODzSkHpGv2XSJbvHrFqaY96G+CsQlpJIFX+4B9MG+87pZ0ypkoih/GeuI2BcH89CRRF6nP0QwY47vZTq1hVGVWFFbnzL7zMGYJOoL2iriw+uhY6rf8+IbuS4DKpfyT1dpF3uOX6diw7Wql3A36bxqkTq4zK4qGKQDqzPoI07aPXyV+k2xE5bQIUrxxI1+WmfBu6bmQlu/SUnCYRgMBZVKJeWRhQHRlMsSfqQ4z/LssC9wPcAt8pTT6f4smC5DXGgxGTD/Fvf0oqgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBw8USXZCWRqb/G64baC+Ixd0Ec48MWbc/xIBobzrzU=;
 b=qvPU8LhAIXD3wLHWrxV89Iuc9snvRGXcse1f1EbqO2tIiJee7TVciRRPACja9lNzY+T7W2J0uu+32ygL3WyMi+FZbbZyerVPffHeK56AayMITuA6VULeI7udrNM2EIU7BpCwvjgSMgXH0jxiHHBmKpB8hPXR5o3rUj/K8H1tT3w=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO2PR04MB2167.namprd04.prod.outlook.com (2603:10b6:102:c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Mon, 16 May 2022 01:10:59 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 01:10:58 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Alan Adamson <alan.adamson@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH v3 blktests 1/2] tests/nvme: add helper routines to use
 error injector
Thread-Topic: [PATCH v3 blktests 1/2] tests/nvme: add helper routines to use
 error injector
Thread-Index: AQHYaMHMl3KZZDxn30GAhQ6GnTtzYQ==
Date:   Mon, 16 May 2022 01:10:58 +0000
Message-ID: <20220516011057.yychuxqeyo6otvgy@shindev>
References: <20220513155252.14332-1-alan.adamson@oracle.com>
 <20220513155252.14332-2-alan.adamson@oracle.com>
In-Reply-To: <20220513155252.14332-2-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a49332b-c375-419e-aec3-08da36d8ef9e
x-ms-traffictypediagnostic: CO2PR04MB2167:EE_
x-microsoft-antispam-prvs: <CO2PR04MB21672D66DFD1A9125509E270EDCF9@CO2PR04MB2167.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 03XG+VT74pX4Z9TliIBdNDKKRJU3mWBjqTdAjFUrlKl7IsjynCBOSREFpPS6juSdjwq61wcl5IaFhNuRdlM4nCmgYJbqWEnGZGpwdlXacAgdd+7loER593uIjpN0XwTfXAzs9QR7AMxhf1JxRMaoR0ugcvbPLYtAaaZa6h2Psuqp5MwYbZjH1IfylzREztiw2B1GbT/MKu3yyr3Eo9hz0AzHE3ZZ69imV2e8TuviYEXDyTkCzXXVemiJbw93XN/BsaINetQwK+pcQa7ivaq9312goMcD8godVT33Y4WUdVUWDxwIiY9NkVGVc41tNuZdIkege8qs8tIDd5eUAr6EslAjuTLc5dSeUs+UmH+NbNEcKzHkoxN/SIQC0AEOSj5IY/fyeayrt7qZyKEjcT61RlMukon+oWRSdgWmDuTDbGi963GCENSYciIAdcVukKsR998qJsuDyGcZXe+l6S0wKsdShJnCMfRBaYK27m4x8IYMqT2MHgn+CxawDGndM6KBAmJ0MqI+VwZ35sbWQYTbl9k5n3R5hBhs/AzMUbXgMMOplJjV+Hla9d54s9+hXPLbDwhxck3nrPUk7PKsewx0/0RQ0/AMftTVVVbvmdeVwaQIwLncyUBS7SKl8CKxs9qWu9XktCIl9udcttUsQF1R5PFYDixI1zWQuCChUBT6jPOdGrk4eUmgQ2UmxhQEkYIqihkEkgdwlqnNIQOOgTwD/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(1076003)(8676002)(8936002)(54906003)(122000001)(316002)(26005)(6512007)(6916009)(186003)(5660300002)(9686003)(6506007)(6486002)(2906002)(38100700002)(76116006)(86362001)(33716001)(4326008)(91956017)(44832011)(82960400001)(38070700005)(66946007)(64756008)(66476007)(71200400001)(83380400001)(508600001)(66446008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qth9KLTJqPiyVbchbFqq9legkU002cfQZ1O/PvEoH01irxSFsSwahpUPcQrW?=
 =?us-ascii?Q?HXj4tSmGCbbrzU8NXmcUSIWVpY/vtoiWh84qC+RPX6fYqPw4u0WVcvF+rVCw?=
 =?us-ascii?Q?MszXtdCP5mUD/pp94rtpy/YNR7qcELjRvMhFToD27tTuMjIIaoXrhslTV11v?=
 =?us-ascii?Q?2OFYCRnWZBfufg68gtlf4hvz+HHcrL2/GuZG2MVu2TOazgMwofCALEBph3wK?=
 =?us-ascii?Q?PWRcQoB81L6uJOmVB4HZ+YRAHKqNljT/230F8bNNaw1VyfImGKaZfp+2rXnm?=
 =?us-ascii?Q?+tvZJxkvEG6U3CuJfCeWcLcqXYmSEtbYMEN+XF89AWaHL3J4JN44FuwS6ApG?=
 =?us-ascii?Q?PYmW4RArZKWt6K/fabS8axoDMkUAnWyXBK5VoQ9kfVdRpXmvDOUfWyRb7v5X?=
 =?us-ascii?Q?yTFSz0kWYw88dWoW0BwHZJikrBfMtIbGF4lJFWx8MK6pJ7xXQ+/NWR6UsEXX?=
 =?us-ascii?Q?UlrP1zqucr0F+9L7az5TLEU8BPJtKTCE/NxvnP0wb0o4feFwE9J00vr6Vks9?=
 =?us-ascii?Q?cQARIqr6w3b1upt/OSjqwPrJD2EE/TgaJrOUoBaPjyRGf1mpFQhwJWGr6Z+D?=
 =?us-ascii?Q?mV9XIUscMkyHno8tRfIN9ECxwMtGDE2f+gFyY1nqZofx9s4m2eKslJy+tlQk?=
 =?us-ascii?Q?PAQOQxD6PGoe5rw5jRWKet4t6FzGia0Jn0PYHMudtTT+XBFv4atTL8ujbFcB?=
 =?us-ascii?Q?jiUmQZSM3yTFETTerX7H+GlfnZzwn6ssysOKS6nGFVbe1qvQzHymgWD/momY?=
 =?us-ascii?Q?83PE5iE73rdmQPwYJjK8MjzTDcpgwd3/eda/Kpm1YFaLlWfDbMtjTQM3sqhQ?=
 =?us-ascii?Q?Cs4lpV8EyMslypZDUtkD/V89MlohbpxDq2f3V4U1gS1cZtzYPioPF+2d8rwl?=
 =?us-ascii?Q?uQJUr339dYky+L7wMeW6SB1iC+DGkTcloAPMzuio5qcY4FjHqfNTW2NBJ57e?=
 =?us-ascii?Q?+aBC3YpabgliJjoQA1+hpboh6x4jI5l+ZN3vMsVdWNog9Nphp9ADQ+sckKBx?=
 =?us-ascii?Q?1VAjQIDhD80bWqohQ2evyDTXQbyihVbCJdSo+rK35ZZWuMNcbpqK6yMCxIHz?=
 =?us-ascii?Q?LdvVSOhWai3moDzOaKFmfHRH9AYaFjhzWfcni8qSGl7FW6wNQGveGLzpGdjC?=
 =?us-ascii?Q?9tD24TKaOlpLDyntt6CpTJWWQhvz6pZ1j2B88Ihg09bE7EOx+GDl5gNDLAgA?=
 =?us-ascii?Q?7cHpsBYoCFwcOM2r9yoHHQ/n1XJtdQDOOnP8L1ggl0U/kpi2AC3TMxnIn/5v?=
 =?us-ascii?Q?/j4TTX7MmZkeM9GTMlKOGiZK5kfpqoy0NioaGPfwaj3UrG2/g8Z05udlGNlD?=
 =?us-ascii?Q?rEAABcCnLNF71tbpVGe+kH3FN0K+JasN4Xy9SD04F9y6iqnYb7y+s5EbawBK?=
 =?us-ascii?Q?eHebvdHNQTyTJfq268E5OYsSBFJ7tbns6YnHxVavACU5OVclh8xCSdy1Q3hf?=
 =?us-ascii?Q?/Gb8/Y6LgUKiqg9FaGSRVg+j6VCz7hHs6DiTCYalxoNQM1GA16QPihMFcimP?=
 =?us-ascii?Q?bxQS5zp8QB96QKt2P+opZ5Ejxw616aIhacTad8pCgu8x79xmSf6Q++cQzLjz?=
 =?us-ascii?Q?itQLJy7Gq8LVbfVqwhnc3GA/jNQQqPqF4MaSp4YWQudcTfL4XJ2QiPIaOem8?=
 =?us-ascii?Q?R2GtNfhw/WQEz+ObnamBU4t85qQFqRkg8bYeghrS97+K/+97wNUfrOsNFGeB?=
 =?us-ascii?Q?+DvWkeljDHTpJwfwNeHXC35UU4vYs/IGpVPl1HG+EDyKqD1UL3XkYTCZEhw4?=
 =?us-ascii?Q?t3oWzXRMRuXoQ/RyB8AjMV2SC7B5bC7usBu9ps1XJ97FXGMFRCe1?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36A701D0F8526C4396D1171E1480F685@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a49332b-c375-419e-aec3-08da36d8ef9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 01:10:58.7024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7imDCp24iqmV3ORZ+Yhvl5b7fbIdPWFe/HZuQpAmWLTO/p2FEl4gNdzAPV4NxZx2cPYr7/Wy/mADh0tO4TOsyDgu7E+88o0Uu+HuoHVDIz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2167
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 13, 2022 / 08:52, Alan Adamson wrote:
> nvme tests can use these helper routines to setup and use
> the nvme error injector.
>=20
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> ---
>  tests/nvme/rc | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>=20
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 3c38408a0bfe..c49a3c5d78da 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -375,3 +375,47 @@ _discovery_genctr() {
>  	_nvme_discover "${nvme_trtype}" |
>  		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
>  }
> +
> +declare -A NS_DEV_FAULT_INJECT_SAVE
> +declare -A CTRL_DEV_FAULT_INJECT_SAVE
> +
> +_nvme_err_inject_setup()
> +{
> +        local a
> +
> +        for a in /sys/kernel/debug/"$1"/fault_inject/*; do
> +                NS_DEV_FAULT_INJECT_SAVE[${a}]=3D$(<"${a}")
> +        done
> +
> +        for a in /sys/kernel/debug/"$2"/fault_inject/*; do
> +                CTRL_DEV_FAULT_INJECT_SAVE[${a}]=3D$(<"${a}")
> +        done
> +}
> +
> +_nvme_err_inject_cleanup()
> +{
> +        local a
> +
> +        for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
> +                echo "${NS_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
> +		echo ${a} $(<"${a}") >> /tmp/iii
> +        done
> +        for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
> +                echo "${CTRL_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
> +        done
> +}

Thanks for separating out the helper functions.

${ns_dev} and ${ctrl_dev} should be ${1} and ${2}, and a debug code is left=
.
'make check' finds out them. Also, I wish to have an empty line between two=
 for
blocks in same manner as _nvme_err_inject_setup().

> +
> +_nvme_enable_err_inject()
> +{
> +        echo "$2" > /sys/kernel/debug/"$1"/fault_inject/verbose
> +        echo "$3" > /sys/kernel/debug/"$1"/fault_inject/probability
> +        echo "$4" > /sys/kernel/debug/"$1"/fault_inject/dont_retry
> +        echo "$5" > /sys/kernel/debug/"$1"/fault_inject/status
> +        echo "$6" > /sys/kernel/debug/"$1"/fault_inject/times
> +}
> +
> +_nvme_clear_err_inject()

To be paired with _nvme_enable_err_inject(), _nvme_disable_err_inject() wou=
ld be
the better name?

> +{
> +        echo 0 > /sys/kernel/debug/"$1"/fault_inject/probability
> +        echo 0 > /sys/kernel/debug/"$1"/fault_inject/times
> +}
> --=20
> 2.27.0
>=20

--=20
Best Regards,
Shin'ichiro Kawasaki=
