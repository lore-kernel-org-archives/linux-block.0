Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE871C1975A
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 02:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB552070A
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 02:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R75vorCW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wYT/j0uq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCWCeX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Mar 2020 22:34:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8482 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgCWCeX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Mar 2020 22:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584930863; x=1616466863;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jHUWXAYCaUwozbHKr/NUnbSCk50IaMN1KzXFOSKKd1I=;
  b=R75vorCWwKVsNOAOuQugupFkXJXbs2a6jqNLhhfpyUzANK7+UXdSyHpn
   g+m2aqeUUAJ2LazZIPk+eH843hYtFRaxqoUMAR47bXTiuMfhHsABDBVQt
   YQqDiDrIrisBNPQsw1Fk9b9DnYWvCM9ikZrRuFMK4xwxLu7EchAgPAl+J
   P+ixkomix4Kd6Yjc+Fa4LAVVBsz3mE/h766gyy/fzZ2cMflSHIAiNTQd3
   kJmVMnEwWknPt3tgyvyTPTEO0xDp56xnk1TcP1km2LCtSAV6d2SNJomUw
   gh+SI6fXmqDfiMj6Q4vr8I9028Pgr6fHftadvVLpobJ+XeD3QVZPH+4yY
   A==;
IronPort-SDR: +sEcCa0R3gEV/cR3vPL1ztWwlT1zHjK9hxubctSl+RS5XvQLhCpiNObyJ4pc+qcDiL3098Xl0Y
 CneapcmYW2svYvTbZjfJkyHG6gkohd405lN9GIgZJcX+Y0vLz0qGAetExMiG6gPurkXKGjldCs
 lUr+Pgni6gB27RUznfcSyAmz+KQCaW6cmzRcNl//4QDnOC6muc1+pmtXJEI6tIlEllX1S9ybDT
 ccI4unZYFcUqQIaxKBrxu1DgNwGp9SdABYTkFh7KNyxMG4cXax8/XhMqyrVH98M/wV5WMbTdYl
 NpI=
X-IronPort-AV: E=Sophos;i="5.72,294,1580745600"; 
   d="scan'208";a="133654320"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2020 10:34:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TT+RMp+leoWlRt91eV/xvs77FvP2L/RNqHRvgiW7z7YWoncPRWICVA4GbjrbnAkrmhj20OW3yH3AnMItC1Lo15HkfgqsC8S+a7NzYbPaa5iBxgRuaNfixDPgAVVtvll6BZ4O13O/GVD9w2ei1eWdlupm55U3ppuxaPoX564VDEzLSP1AVb7KlGvH2KSAS2ZuugQKfJJN4bn5WQ/eV8Bgg1l6YftW5n0hlbLuRctkrs5OPGeD2Xw3l2iBbRX/6sMqDqdL9PZhMhbX8SaKJ4TZtn131dMqhwQQ+jQDsDXN2ndgo2EkYai5o99sst1n4ysC7MHGSafebDY9QZb/5F37zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFcy89noPvxqDrP3XkFvXnde42WY81AfXmN8/8CrNns=;
 b=mZReHSgWj7ZkBQcqPBfeA6oSL+NRIg8A8COrw+sJ0gY9ISDiElqa2tsUpG/E7C8HUVlzEYuWdHG3hJsFAbzy8yQQaEHWloLIqr1C/lbW6bj8yEMkuTClgHBPLfjVNqxLwCj/i1KbLBZQYSLIxzZV49e/Nsswm2n/TMBLP9c77xUB4/X7wZMuJ5ij+A4aR0NEFTRI4khdqaAxCTqo5V/HbVNWfmbGVvO2HJwhfOfA18lN8lbfrXlj1CXJHzVDZjLvfpfAPtGbSQjfRhOCagH7XCsOZv6dOkoE1fAozwCOegilZBD9SCVpddsIET0Ve2OawpSyufmdRuBiwtRUxLyjUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFcy89noPvxqDrP3XkFvXnde42WY81AfXmN8/8CrNns=;
 b=wYT/j0uqkxSiLwH1LFuvdR4Egn6trKbRhgBPxZPNFmAKKf7DTXQhLyemH8WkZnbWCcFraPGLct8oJluP2UXTZt4qKUHNlUp06q7Mnv+2fZ/mmHPC44hocvg43CLc0paxrpZFpaMxesag84UqU4qImUTI1JyqbMGYMzOHBrq+4XY=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2344.namprd04.prod.outlook.com (2603:10b6:100:1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 23 Mar
 2020 02:34:18 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 02:34:18 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bob Liu <bob.liu@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH] dm zoned: remove duplicated nr_rnd_zones increasement
Thread-Topic: [PATCH] dm zoned: remove duplicated nr_rnd_zones increasement
Thread-Index: AQHWACx4CVTkHZ3jTEqS7u0EG8fLcg==
Date:   Mon, 23 Mar 2020 02:34:17 +0000
Message-ID: <CO2PR04MB2343196CAA8DAC40192E0A1AE7F00@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200322092912.23148-1-bob.liu@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5cad68d5-04b6-4333-21d4-08d7ced2afa0
x-ms-traffictypediagnostic: CO2PR04MB2344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB23442466D206753A7CE7BC5FE7F00@CO2PR04MB2344.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:392;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(199004)(186003)(26005)(53546011)(6506007)(66446008)(64756008)(66556008)(5660300002)(478600001)(66476007)(76116006)(91956017)(52536014)(33656002)(66946007)(71200400001)(8676002)(8936002)(81166006)(81156014)(2906002)(9686003)(316002)(86362001)(4326008)(54906003)(110136005)(7696005)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2344;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SXPO4ELUn/cvzo903xErnGjb3yqK9U13TMOMAJjw0kvBQQYKm294r3y9SgLNetk55+l/gZhWoFzb0aKPAFnR3LL8WWpL98AnKnyjW45bvp9DE7tlbJl/75o1uzxbgWOmhJrBIHfcuM9rgtOrkqps4ntaY1emqKoKw7KUZSwEO50dPPOH6ItkpyhQH44a9N6dtVOEZdR7RxTMD9/4k8U7dgF6dE5IPoNV3THZDkZT3a2jbuX757ca5+3RrtxUbBlVm+89Uo25zwTBGWKaF2KjvGdhC6bYeBAp1k59nmDBlGzfXa0mH3Zj84KwYqfJi6ltgcsBkYTbdW0lsNAVqIwZu5AB0evAgo+OAc0ZGaeJ/eaCU2LzldEyclizl2L4R/WGy9M0AZ7DIqjn5FmNUE2p7tj20GfZDp8BDKUqEIcyKMNMT1bkslqmue/ERLMU6/94
x-ms-exchange-antispam-messagedata: d+mwhnN7SvFVCkY30Kzytcrgchg/v/ivg7BJakCGVnBL0aRasnldn0PA/a7UL/Xu1is/ehmpGNp1O19Dw5rEnoWk5kFHP8dovZgnzuVNbgutf3B/bpWK3e/J+W35Rntb48G9BSNyxiaIL992oTDb5w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cad68d5-04b6-4333-21d4-08d7ced2afa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 02:34:17.9696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wck0Pjzee3JgL7CUQCUI+E7WoMMtcd+hI8q+OOsZ/I4G+VUFIbQb8SloOiAylMgRjE9nhzdpuUk9bKNyIZ7ZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2344
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/03/22 18:30, Bob Liu wrote:=0A=
> zmd->nr_rnd_zones was increased twice by mistake.=0A=
> The other place:=0A=
> 1131                 zmd->nr_useable_zones++;=0A=
> 1132                 if (dmz_is_rnd(zone)) {=0A=
> 1133                         zmd->nr_rnd_zones++;=0A=
> 					^^^=0A=
> =0A=
> Signed-off-by: Bob Liu <bob.liu@oracle.com>=0A=
=0A=
Good catch ! But you need to add a Fixes tag and CC stable.=0A=
=0A=
    Fixes: 3b1a94c88b79 ("dm zoned: drive-managed zoned block device target=
")=0A=
    Cc: stable@vger.kernel.org=0A=
=0A=
Other than that, looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
> ---=0A=
>  drivers/md/dm-zoned-metadata.c | 1 -=0A=
>  1 file changed, 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadat=
a.c=0A=
> index 516c7b6..369de15 100644=0A=
> --- a/drivers/md/dm-zoned-metadata.c=0A=
> +++ b/drivers/md/dm-zoned-metadata.c=0A=
> @@ -1109,7 +1109,6 @@ static int dmz_init_zone(struct blk_zone *blkz, uns=
igned int idx, void *data)=0A=
>  	switch (blkz->type) {=0A=
>  	case BLK_ZONE_TYPE_CONVENTIONAL:=0A=
>  		set_bit(DMZ_RND, &zone->flags);=0A=
> -		zmd->nr_rnd_zones++;=0A=
>  		break;=0A=
>  	case BLK_ZONE_TYPE_SEQWRITE_REQ:=0A=
>  	case BLK_ZONE_TYPE_SEQWRITE_PREF:=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
