Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832AAC433EF
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 12:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbiEaME7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 08:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbiEaME6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 08:04:58 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452526EB12
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 05:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653998696; x=1685534696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wca54yX+KHCJQEIECzARPilyY5mCCa6bgXbhZIHvnPc=;
  b=coJWLqAP+anZ22nOUtLNzILbdoZlmd3wOi5qTz9RWsBv0o0FSdb+VzX5
   qG+J34T8NLgcWs33DKuqb5ZW9tUvjwjE3ESmQ7NlqEEFs2Q59ksMrN+5c
   87N2p/62EuUoM46S9W2xnooJ//tCaxdM3tMszrCEF3/SBc0Mo5BKzOZhN
   9rlsoPbI5OtEARXrBJK/KcJyUvv8A142M9xPenIiVrEfvdiVQUo+kxdha
   oBJTdqtN4cC+Nz8h3GZ7IKmOW6U++OyMB7cRGEtqZ3nUXQyY+NFt+RJkM
   ggU7vWVDfE+CyE4fSn3E1X8W4mRr285+NxPtsIJHpSVLXKNh84WqKaOgM
   A==;
X-IronPort-AV: E=Sophos;i="5.91,265,1647273600"; 
   d="scan'208";a="201883392"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2022 20:04:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efAK3NncccX0xei67sDTTT0BLmKsSYDh2vaZLZiGGK9eRH5aboMdsw90ENn9yuW4L/9LcbuxhYFoYOwDCSC3SxR8BXWqQH+s9isKkAKlvzMfcdUZFhMy5jJI3cSOmLDIjJaNzekWHGtgagjndP6r+QBG29l+vcUtVQ81tyKGgh/O36hYW6ZENfYqRNM98EEeZ03dSMd1+K3T9N8BT/3TarSRZXvEMaV0kqdtqZHy2Wo4nln6HjdDVdKBmjG5QrUAYa1LrGJz4X6OsST09tkFr3nyhXjNKCv4xEvI+HlmFz04qz4G5y6kDmnqcZWraYtDM75ra2BNT5FgpjFjCitt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PArCFCmv1h+5o9cgxfCR4tZHwXjMrlpJdQNWTAFLUBc=;
 b=PguDmIafjaYgyWisNY9MD5LdjOQu7yaFoVptqRgGA6DOo+7rvixxDim4XFHFieVPqIQkc5hF57VqqAjE9NAZh43XHtMKYCbbQTo2kKFkeE7H2/SUclPK9HTMmRCgQWSXwWV66y4js6psz4HDkcjyAS5ZGKuT33wLxeu0Lk1cVK4rbZRKzmBPBmjefq9CL3MeOSK60upVeZ3/3rbX/MbG4PlBQoK4Syx9SLUzP38TG1wKEg8+50kw2VABLUxF4nHWhGCQDC6No8CYYwNJj2haXCfZL6TNHhZtH7PlubSYbu3y6bNbCZwaW9oFoudXN5tR9GnE0QBbAjivmSN/e0n79w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PArCFCmv1h+5o9cgxfCR4tZHwXjMrlpJdQNWTAFLUBc=;
 b=PsurzwfaQeAitLUL77xaaUrgqHUYnoOcrgP/paTeKux47AFu/2Xd2w7A8Hv4+tPte3ftp0hxNnywruLA6KZOR6uGO/mla3VB3RTN9QbBnm4stFaedqdDsILf7/BDFGxB0YcQ4iKBpnukNXo6caSbDRs2QTid2lANEVpCQCMv/B8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7747.namprd04.prod.outlook.com (2603:10b6:5:35b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Tue, 31 May 2022 12:04:55 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 12:04:55 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 5/9] common: do not require null_blk support to
 be modular
Thread-Topic: [PATCH blktests 5/9] common: do not require null_blk support to
 be modular
Thread-Index: AQHYdCZeSpLRBe1ZvUetlZ0PQ5g6G6045PoA
Date:   Tue, 31 May 2022 12:04:55 +0000
Message-ID: <20220531120454.3hlprbotkc3ftyyf@shindev>
References: <20220530130811.3006554-1-hch@lst.de>
 <20220530130811.3006554-6-hch@lst.de>
In-Reply-To: <20220530130811.3006554-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1b0e87b-7dfb-4323-5357-08da42fdc695
x-ms-traffictypediagnostic: CO6PR04MB7747:EE_
x-microsoft-antispam-prvs: <CO6PR04MB77474BE30E773430E5CAB81EEDDC9@CO6PR04MB7747.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rSGWanursaKv+bqn8uFYrcDt7P3CboGQyIcuavDx+nBjNLl0S7MevxzXvjo1NBR71vCBR/EXcdUequwZZz6wRyWDo3duHRxFgwj7jIdlbNtdVHGCyJ+I8P/RxS7ekuxWypZztlf+EYwB3tSUy6fPDQ6MvoxEUHv2k76SUmFMVnVnPfq9MBZ/MxUlKCeSfNFhbnueh0kaZetkYA28PvCpgEDnhs3LHixsaGbjedzUHyI0+cb9z1ZGrmXm3g7N/JOypHZ9TcB/PDrh4sTtzxN6JZ39BFdWAu26LBM2LmuNH9lWokvWMnPfAxF+T6PGelrKKp5JogHspICoUmy9jXGx1UZrhF2ZFtcrFRIzCua/9fSzht9RzJu0suaciwCzl6s5pLxvrzNH8vceEpWHw+4uKNe47RXMlh/AUx8lwmVMeEdAiCgj7Nxr5x6yISeoxturx+/pytyOhfBni2SD5Tx8SIdDkMsq2DoG2a/Dt0cP05Tt0z6ourGQq4fY028tYVN7i1N0gAtGx9wSm5zC4rmfbGH5xG/bVge60Myg9cwESY5QEb92SAt9j/FYxMEDYH6rtn8V92beRWybAax/auubvvynwnlE3ipw2YDRk86UpCudF6P20YYXqkAEnS0Cy5Hv4mMXGfSwKbrPpWlQ33TsWmtujOf2RHqy01j10J979/pzBJMVATGni1GUAzCo5OxqASmlTSdVDrplNKtNKrfIfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(316002)(5660300002)(83380400001)(33716001)(2906002)(6486002)(38070700005)(122000001)(44832011)(82960400001)(6916009)(6506007)(71200400001)(508600001)(38100700002)(86362001)(6512007)(1076003)(26005)(9686003)(186003)(66476007)(66446008)(66556008)(91956017)(4326008)(64756008)(8676002)(8936002)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VpMm7xe+3NyJ721GCjKkWKLTX7aVjuclpK22EBYM9mxGybWZIom2FZVfXK81?=
 =?us-ascii?Q?47BGTpr+ZYJTTbUOf6KJK/PCfNB3ITuzVEV4H3Q8X6COvSqrNuOuqkesUcO8?=
 =?us-ascii?Q?U5/Vm9Q31C//yTG2ZJNsmoKRA/2cp6Pxzb61npAia7oQo/WKyHhrWdrdk9x1?=
 =?us-ascii?Q?HCRw1/6s63vsXTHgh7iCX1EBPPAhMRKBwHxHyM7ZGfdB6MxlwKNvkoNh/aKX?=
 =?us-ascii?Q?9S2U4D4lLKBNyknvY/Q2FC9gv78gbQ8HjAqHMwB/+pDK86ZRCESpDKBDg6eG?=
 =?us-ascii?Q?Cqgw0MGu1ecqsurTpwpBBKR4vlNY/EMIxnXitGkNunaqSPf/Dz/DWqLnPrtr?=
 =?us-ascii?Q?vT3KptutZkDZzubKcM0g/1ufTQ2v85LJ134aNxrKmUVJysbcs0C32hYkWkBu?=
 =?us-ascii?Q?J75wLQ1mJuwrDHExvce47gSZ+qHfjvQnpWhZT1LOC3LLS9MjV+DQDZcKbd3C?=
 =?us-ascii?Q?riZqucXZ308KkFahiLRtd1UCM+chZaB4QuH7u3YLrwEh95sf8GDvLGV9zLDg?=
 =?us-ascii?Q?7xWcmJcAYf6T4JzPuVWWqaKdba9FoQE7BLtefjWL+U3jwYrFpntUpT/UUwXW?=
 =?us-ascii?Q?Y7qrzIKsEFkBrutDnHocYbHnqND7CrY1xEcP0mYUU0AQLhWapu+WilQY2mJ8?=
 =?us-ascii?Q?y2j/zKwWpQK4bBAbqYl2JCpfYLd/yrlp2gpEU/cAuBTSndT2g92JgNjX0KkQ?=
 =?us-ascii?Q?OuMkR6TJTHCQXkdUDbl4iKFo10GKVbNx0qGoqaDAuIcIaIj0fGQRGHJLJIrn?=
 =?us-ascii?Q?lXcBbbqvyiQM71UEHgSUWYG8AdDMneylw7phVQaKTTwDDV809uHgLS93wcxP?=
 =?us-ascii?Q?x2PgQyR7ISqcCJgrsaX8YFPlGrJt/TfSh0ANDqfn8vtLdc8mEbMhFe8LAB4b?=
 =?us-ascii?Q?FS341I5jvdLrMx3ePi0dC/P4s9oA5ouu2n2A6tsz4RApzLPZNi7Sv3KMIK/O?=
 =?us-ascii?Q?5rE9owPRsLyrqYl12Mlp4wbcbQadFdJ/s6kGZLBfx8f+S+Qy6lvA/oqsWF0i?=
 =?us-ascii?Q?Zr1yyA9Nwj4TcPQIvY0FY2LcroQ6EqsGrwrmlH9NQnrJ+V9ZRl1n6yQRuKTC?=
 =?us-ascii?Q?4p7giBk8BgEALbvLkUoNvV8LL30RGV+Zqf4VJU4maa4ybHDIL5tT2oKR4iKv?=
 =?us-ascii?Q?MDfPLJ90vLbRlog1FSZYEnr07vimZiPfrAzpzLhtIE6aTepF0S8U/Sh1T0x9?=
 =?us-ascii?Q?V1py3hKzwiDv+YPp8JYRuIQ2e10xocYea6ZcXM6dxQPjr8u5Ek0kJFndJt3p?=
 =?us-ascii?Q?OPMvDe6PkG5s78OnMnzcHCcDSd2kEcr7nOcDncnxI+Yohk3pmaqNLd1vOZw6?=
 =?us-ascii?Q?1VvnXFP6cBuFG2F8d7QtHL09WIWh24h6AA2qgLAUBw3RxaMyYmQGhUZNZ3Mu?=
 =?us-ascii?Q?fbNU4sr6L2wIPuMGdT7XE5sX6VynrryRsaNkfEEk7eY3IUhW82Xu47IjwBGf?=
 =?us-ascii?Q?n9siXgjafuBaEIrsCPnTQGJOerZoBFnYVV/6NuFR0qnzaZqdbCj4XHvTxy/G?=
 =?us-ascii?Q?2lhWMmTFq6fY0L9jNWiU/7kKWpddb/33qvjPu1TKt19539wosbtFBMdcBjPF?=
 =?us-ascii?Q?iOl1vlrQo4FFmpq7fpsn86LbWraBGa0QXupfM1E/pgoraPQJoIdjSMCGqNYo?=
 =?us-ascii?Q?A0SBOxQ/nSrsxekhuHy9/BMHD/x98ZoUCRWW17YBYDUKEskN5uoUZ4rYbk5h?=
 =?us-ascii?Q?3ic9EpeGfcr5ijqifPp0Y/JapXehpqkP68ZU06TMTk2j/Ga2nlt69wjeVD1A?=
 =?us-ascii?Q?4eg4LjbnFX5+rE3remaVuPCw/3knLfsb9QgriJEtYqaZY6rR30u5?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E45D31E7B5AB54994B203736656E545@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b0e87b-7dfb-4323-5357-08da42fdc695
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 12:04:55.1868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTdXX4n19oNRVEpchYSjY/zYUlOcW9s7yliYnjuNLjVrMhNo5uiHa8mKn+nk1EXklh28f0ImOeL9goQK3xE+FKK7qcbpB2DgNABP2xFBqK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7747
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 30, 2022 / 15:08, Christoph Hellwig wrote:
> Use _have_driver instead of _have_modules in _have_null_blk for the basic
> null_blk check, and instead only require an actual module in
> _init_null_blk when specific module parameters are passed.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  common/null_blk | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/common/null_blk b/common/null_blk
> index 6611db0..ccf3750 100644
> --- a/common/null_blk
> +++ b/common/null_blk
> @@ -5,7 +5,7 @@
>  # null_blk helper functions.
> =20
>  _have_null_blk() {
> -	_have_modules null_blk
> +	_have_driver null_blk
>  }
> =20
>  _remove_null_blk_devices() {
> @@ -16,15 +16,19 @@ _remove_null_blk_devices() {
>  }
> =20
>  _init_null_blk() {
> -	_remove_null_blk_devices
> +	local modparams=3D"$@"

Shellcheck complains on this line:
common/null_blk:19:18: warning: Assigning an array to a string! Assign as a=
rray, or use * instead of @ to concatenate. [SC2124]

I think array would be the better.

> =20
> -	local zoned=3D""
> -	if (( RUN_FOR_ZONED )); then zoned=3D"zoned=3D1"; fi
> +	if (( RUN_FOR_ZONED )); then
> +		modparams=3D"${modparams} zoned=3D1"
> +	fi
> =20
> -	if ! modprobe -r null_blk || ! modprobe null_blk "$@" "${zoned}" ; then
> +	if [ -n "${modparams}" ] && ! _have_modules null_blk; then

I tried this part on my test machine and it looks that '_have_modules null_=
blk'
returns 0=3Dsuccess even when null_blk module is built-in. This may not be =
what
you intended here. I think _have_modules needs modification so that it retu=
rns
1=3Dfailure when one of the modules is built-in. (At least until all null_b=
lk
parameters get supported by configfs.)

>  		return 1
>  	fi
> =20
> +	_remove_null_blk_devices
> +	modprobe -qr null_blk && modprobe -q null_blk ${modparams}

Double quotes for ${modparams} is required for shellcheck.

--=20
Shin'ichiro Kawasaki=
