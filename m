Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217AECA0EDB
	for <linux-block@archiver.kernel.org>; Mon, 11 Sep 2023 21:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350842AbjIKVlo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbjIKLAZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Sep 2023 07:00:25 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C23FF3
        for <linux-block@vger.kernel.org>; Mon, 11 Sep 2023 04:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694430020; x=1725966020;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+Ov4JDGf3QD5TQvMnepNOtNDtkG2VodLXpOBA0gLsBo=;
  b=O+MysfgUeHzdeXr2x7YxSvTPKgcbvh/snm0MnhoLnLobbjuWpOYpPbB9
   CsC9mUcwuWcpXo+1byVxWt6FNXQYWHFMB+8fd/GZlnvdl7/crxFeQuozN
   BNxYYoJiMxlIph+IlKQFV18E1SfuBzb9lOmcj2LJ0KWe7M6hJxoJ51klG
   AtsDQH77eLl5WuvLX4KQHCFRnuR4aGsURLGsWuyZTO2sqX/fQb7fdz71Q
   Y7iaBWUM0CQF0uNHNL+glBxGpnhgfZlFE0lGaLT6J6fUgG+6r45nNPxb2
   VkySSksMXDWZqaXwyDdeVvoBLJ0VhVAAoKV9Vc3hCi3OWSOsIeBgsHcxE
   w==;
X-CSE-ConnectionGUID: 7scEEzmTTZqISNV7DAgo6Q==
X-CSE-MsgGUID: 8bF+SncqSEeNyigbzFzscg==
X-IronPort-AV: E=Sophos;i="6.02,243,1688400000"; 
   d="scan'208";a="348903639"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 19:00:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkBKAgFBUGtVlrxF9+ygF43snx6aH+fhityOEs2rTZKkVsN7ks6swFY8rViNqypkHgjZxSSc97AUwVhfBiZWJOAFabQ3Y+HQrK/kbpFO8CNrw9PgMcwqfWeCoJtgrVy5L/t13wXPr8mSqBpiTS1ZydbnHcDgNSQTx/VVHz2+VOVxq8sEr65mO54nZR30cqrU7GNbiRP3rz9P1c+XI5BpuXGtzha6YBdPrYbzMoKu5GlK0ALCUOEVbLDqb/qDvae3SE+sz+qzC7PNt2SY781LB/R2BnEMWsx00K8MiIA9h/Odb8FfqOXjz1LkX9Ij6A2UboDAItgo9tAULxMKiqfHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+PPXdzP2hwCrlPdT/kZbS/5LPWqgc2OggyFAEW0Xo8=;
 b=UcIz2k7bML9wQdg1jxsjN9zSxtDdlvBt1a0oVQJEpdlCin007tV/PKI/+Q0vqRGCQot5A3RQW9I0UVmC82qxPJYLhlD0EmDxmJU9NeXBGLr9hEV7nCmmc30jJB05SmqdRNZrs1kMvUSOeMstVktV9fi5XtOqbpLXeuYPH5/MJr7TB9Sjuk3D6+j0eoH4hytAg3Ca2/Dsmtlp/7EqXyf0Xl9SQX9mIAAoRB5KSHQ34UxYwqokjgnqphZJEHHtSok4FTuntwZKqeZ9jjRJm1E2voeyokqsnW3jHVdfqlULb00F8iWYjl3S8V3cPcoE7cqIc3G9sdZNRlpfjy148qX+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+PPXdzP2hwCrlPdT/kZbS/5LPWqgc2OggyFAEW0Xo8=;
 b=A6IMqYn+1EHBIBTqlRvCFsPH6xwhk8S2aiFhCO3KkmQGfRUR9TEGO04iGgTEccjzhb/XdRfk7UH7QITkinLhatpcNuM4Ta3U73ddxntixEv3kwfMSYkJVNl++6GlLQDsACvuDZ+SwxUhKdBc72k34imLUs9EsZS58ldx1w77xEk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6842.namprd04.prod.outlook.com (2603:10b6:5:243::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.16; Mon, 11 Sep 2023 11:00:17 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6792.016; Mon, 11 Sep 2023
 11:00:17 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] tests/nvme/031: fix connecting faiure
Thread-Topic: [PATCH blktests] tests/nvme/031: fix connecting faiure
Thread-Index: AQHZ4T2oqmvmMH8z00mCjjVD3irOrLAQzBEAgAAc5YCABJLXgA==
Date:   Mon, 11 Sep 2023 11:00:17 +0000
Message-ID: <swd5rjag3soiz5b6fkktk5vncfjtb4wemrbtl4fwkpcx6uodg7@5wnw5gf6luz6>
References: <20230907034423.3928010-1-yi.zhang@redhat.com>
 <nrfuja62qetxqxzwxuxhjve2u4r4reofcpo43zmg6qbbhjjqkp@ratsu2kubymb>
 <kflpcc7u4wksuuo27gcrjxwsqr277b3phpnbbbjkdaniycmttn@f6t4dadmvqih>
In-Reply-To: <kflpcc7u4wksuuo27gcrjxwsqr277b3phpnbbbjkdaniycmttn@f6t4dadmvqih>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6842:EE_
x-ms-office365-filtering-correlation-id: 0849f916-72f8-4df3-c4ef-08dbb2b64865
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3H+pyYkeRZ8WFbovDi0Oatgt3AFLp+4nOuAjM+9nOq6tmI1GCWgCS1pS44tMJtlnEwWmY+0+4eYGDjhcYMehK/UiZAI9451sgMlL9tdmyT6O8Y19F8nb2yFhgQEYDbXqyNJN7nAT73i+UF+0dVimPp/fXymROpo3d51XWG6MhRTpk42FJ12AZJsBNbwkaV2bRpkztTMDnswFXxtBybyF6oed0M/J/u/tgA7lziuStypSEEcFY6JThyjMArX/I8qI5MwSn0mnbecsEtqMSC875KbbX+bKh/bOeZWLajQdem35unFv5M5O4xdrMihDRnjoQXrVbR6nMvQNQc2sTgb8jAT5gb4qr2nHK1EIuQ3bDkS77hBnjerwhAdzt7F1NN7wMnHunIOuboLgFKtLiZlvv/Y+quIW/Kk9/UrAzkyVrEHVIe8v45GQ/pi101Jma2LbQI6/gBfssM+cMfooPUzc9SF6HQCzP/4qIlOpsKLFx6q1r4sKbioYkP8N5gIoMS8v5Z+qmWTtvcKoL6iQMNEN9gbZf9zUB7iPSl1keEKzbw/p7aFfQyjc8dZXmwoonlT1C1nzYuS9rkFueCsWLxz1KFU7zzlonaQsjqzuScJ4SG0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(39860400002)(136003)(376002)(346002)(186009)(451199024)(1800799009)(41300700001)(6916009)(316002)(26005)(91956017)(478600001)(44832011)(2906002)(76116006)(8676002)(8936002)(4326008)(66556008)(64756008)(66476007)(66446008)(66946007)(54906003)(966005)(5660300002)(6486002)(6506007)(6512007)(9686003)(71200400001)(83380400001)(33716001)(82960400001)(38070700005)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ISxNX+sHMqi3Mb55aijorc0Er84fhFvoUfCSTZX1ZYtGigVtAzX5qOgdmAaz?=
 =?us-ascii?Q?vJNAYg/3kkm9g52OlJf6C2e+gnB5ksjSdjT6neG4CLxSLW+7sk0JN6Kq58XH?=
 =?us-ascii?Q?OK4kN6QSvt5RKslagFQ7BiLDkLk3mJHMO82On4h0fvaY52dfoLWHnfG401Bh?=
 =?us-ascii?Q?HdfEr3E6PH9dO9W/Ncz/BpNCpkAtbL/z+TpJ4jmeBRHNhCWUGcY5x2EMLGv0?=
 =?us-ascii?Q?0sfxpY4QK3A+fJ4yayjlkp9Y1xDYsoSoCZOsxPX6IG5e0q0xqH41FW/cgkxi?=
 =?us-ascii?Q?9K8K4nbv1lKmect/pMlki7CE81fIJrVz8iwkvxu1tL4Dvwa3NpArU/zFglfV?=
 =?us-ascii?Q?yUi2nCAoUa5ck41O6z5aetel6ea8DKlvGe0Bz4Tbae57SiZn7NN32JllwcsR?=
 =?us-ascii?Q?mSNA/sN2tjdyErGipOH/kG2Pll4sIzEgmNjnadOu4oZO30KMXdYM663GXdsy?=
 =?us-ascii?Q?1UvKFX7wga3/BY/sLMm/dwKx0qnhv0qGTvA6P9DQdDI5AnIItTr/Co5E7xax?=
 =?us-ascii?Q?u91AK7HurTACpF4kSOwbuRq5rnudHeO85JnYgpqlPI5vjuzkSKBC0WXuXoWV?=
 =?us-ascii?Q?VqONw2rFLEBlBpdhGL1Rd5a1S/ViJgAK0QFJOUxbzAk4uhkYBFVKRyc1qVXT?=
 =?us-ascii?Q?xOSiGiQMO+SprAVkfCapByWNmeT8hYX73emBLvDFY8qho1iKhKwuiRqQ1oYR?=
 =?us-ascii?Q?z6Te0nWoFBJpF/H0/T6HleU+J2e6VGhUK1zHsoPu9CBmkqIEfh8f0DAUyjks?=
 =?us-ascii?Q?GsO5E24x4LD3az7wlJDJbxu5kW/yugcVYh4kqsAXWxr/7/SDGxikNHDfViak?=
 =?us-ascii?Q?AqaHYvz84OCu6rdP1aMLEh+D38WkBopC5WsrFWNEvrbHL5kjOb41eVqSDaR4?=
 =?us-ascii?Q?+PrB53hPHUMTAB80Ii3X88spEAALWnHqZ7+zX7dZlEazi1tW9VLWIKw+xANb?=
 =?us-ascii?Q?/3peO8sQUtrERcxM20a02eDW47Q4vp8xughl6IDHn+t5ZcWbM5iCXYEK6PE9?=
 =?us-ascii?Q?tqX8BDXhRIMt/uohsBgRRrG1TQfVcT/YOVfkknYXiK9Ffv5G90tFW6FqyK8w?=
 =?us-ascii?Q?pe4doIbBcjbPnNZ3N14pg18mb6uxtlLCAXpB8ZjH2F5eaHykWgzfqBqj6YLR?=
 =?us-ascii?Q?ttXkwbNff0JYaphVENK0icvJeFin9A6jgJ7JMh/TJV1/djqkLIIG0zTKRLK2?=
 =?us-ascii?Q?s9Vhl/rCuLOjfkSpr/KmaHDhiEQn6E9UG4S8NzhdfW7VnJwQ7buZJcBVqU9v?=
 =?us-ascii?Q?HRYcINHVoiAB3ZQmTDbWJIxIc7ntuO5+HyVN+xvoRMN0xHL5thSm3OAoKKcB?=
 =?us-ascii?Q?oQ5re6uGxagwhYYVsmufjCQAK9hviYGviS+2Pr5JNqEq0NL2oRtAQPY297hW?=
 =?us-ascii?Q?KZtsymq/DZ6Bg3CqRyN/iNw0UMBdPPD8kVAIW3o9f8rjHtf4d9kjYDRbLy+p?=
 =?us-ascii?Q?S7UKNds8FJsJS++Sq3Edpjf36s0fo/54epB8Jyv+WHC2gPrG6nNGiNi0FCZX?=
 =?us-ascii?Q?7PmnfJBnj3ovdjDFuoVzIZJhTjaHnvzRzHVgjNv5vL31honfD5yztqCGkR7h?=
 =?us-ascii?Q?w1R/YUEXXCSUCrkIAQjTOVnQ+C7rQBFwhvbgYuCs/8NbeDBZ2aZMX0JjmxGj?=
 =?us-ascii?Q?qQ6JNRT5zQkFYHXK7R8pZLE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD54C47C786BC14BB3B10732BC852156@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zXog6RPJLPy3NLxsG/9/2Vl2BE+Dpt1ZIo1/w2dr5vTjt6IWEL1MztR79h5xHXwT7h0ZTT7p3pXbeVPBtQQaYSD85u1BNBTnZciiVg0RD3p6/c1k2HJQ+5MDvwoc5lMBJg4S8U4sXDbyZ8asQA5uJ9SP0dlZhSj55/8L8Vz1UyYQPtl1+5qnzdJ7LqmFLaoMkFoX5ca/bR/RGZDl8xV5W6XNMIcnsxDz9bDPuRvUZHWPOR/tidSBznv2hQ7/5tiMinHg2tn+wihD56fViGTwS44R7FT4cNtTi7dsZ3ehvemgv1nM98JEXWn1EgYeD/KYLZiZEpDbLV0CjetbxKLUrg4dOjQsTGS3lrkJOQovqADPEHn9RPFZUyxiy81tB2NEs37SFxwqMMn4QOED/9TwwdFp3vXrWwHXObOFrnTe3gC8mFEejnXgrd1Eq5bwAXUITZlcMD1Bsu0ev5ollexmbQLdUm/59AmBOWj/Ho8884vRhdh3HBKxCfGPqmOvqHP3txejvd5W6FCvR7/ErYbLlTtFveRJgbau4xql+bv2dRC/5lVDo1Zayq9i7O8wtBbHiuQEgLNr//SBpefGsTMlhCrr0HAT7Sp0LztLNi3MXp7VnO26S1/UBwOoSXS+L4kk8fJjkCZ3ZA/zOVhXYefyzbnDONykumD8nVq7pE9hNO2gpffUCck96pQfuHsSIrWDBrXG3h2+YUrVjTO818/9kDZgHDMQKvo33NqaGwcXqqofQKOUy0W//eC/XbCOepNCR5dhkFsZSmOer2xwT7g+2ELJf5Ed/+vTgiUJSmomTYNJMEMWSvpk7I1WnTiVF/8jbcbnZqbfWEv53y3QSJImcLLfU56lB3KMywfgVsoeo1n8pn/sslZ7h8Ksdxih/Bnl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0849f916-72f8-4df3-c4ef-08dbb2b64865
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 11:00:17.1241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1XK4VBbb9xLWs013I8dwV7l2a3K/DLfFbBnJlxRZdUKHurwiHPCljZECA4UkjOUUbIl/6ZccaBSpsBcrGzIyRUec0IoeQ/B2Y+1GGm/1x3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6842
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sep 08, 2023 / 15:09, Daniel Wagner wrote:
> On Fri, Sep 08, 2023 at 11:26:31AM +0000, Shinichiro Kawasaki wrote:
> > On Sep 07, 2023 / 11:44, Yi Zhang wrote:
> > > allow_any_host was disabled during _create_nvmet_subsystem, call
> > > _create_nvmet_host before connecting to allow the host to connect.
> > >
> > > [76096.420586] nvmet: adding nsid 1 to subsystem blktests-subsystem-0
> > > [76096.440595] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> > > [76096.491344] nvmet: connect by host nqn.2014-08.org.nvmexpress:uuid=
:0f01fb42-9f7f-4856-b0b3-51e60b8de349 for subsystem blktests-subsystem-0 no=
t allowed
> > > [76096.505049] nvme nvme2: Connect for subsystem blktests-subsystem-0=
 is not allowed, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349
> > > [76096.519609] nvme nvme2: failed to connect queue: 0 ret=3D16772
> > >
> > > Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
>=20
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>=20
> > Thanks for the catching this. I looked back the past changes and found =
that the
> > commit c32b233b7dd6 ("nvme/rc: Add helper for adding/removing to allow =
list")
> > triggered the connection failure. So, I think a Fixes tag with this com=
mit is
> > required (I can add when this patch is applied).

I've applied the fix. Thanks!

> >
> > Even after the commit, the test case still passes. That's why I did not=
 notice
> > the connection failure. I think _nvme_connect_subsys() should check exi=
t status
> > of "nvme connect" command and print an error message on failure. This w=
ill help
> > to catch similar connection failures in future.
>=20
> I was running into a similiar problem for (not yet existing) nvme/050
> test case [1]:
>=20
> nvmf_wait_for_state() {
>        local def_state_timeout=3D5
>        local subsys_name=3D"$1"
>        local state=3D"$2"
>        local timeout=3D"${3:-$def_state_timeout}"
>        local nvmedev
>        local state_file
>        local start_time
>        local end_time
>=20
>        nvmedev=3D$(_find_nvme_dev "${subsys_name}")
>        state_file=3D"/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
>=20
>        start_time=3D$(date +%s)
>        while ! grep -q "${state}" "${state_file}"; do
>                sleep 1
>                end_time=3D$(date +%s)
>                if (( end_time - start_time > timeout )); then
>                        echo "expected state \"${state}\" not " \
>                                "reached within ${timeout} seconds"
>                        return 1
>                fi
>        done
>=20
>        return 0
> }
>=20
> _nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
>                             --hostnqn "${def_hostnqn}" \
>                             --reconnect-delay 1 \
>                             --ctrl-loss-tmo 10
>=20
> nvmf_wait_for_state "${def_subsysnqn}" "live"
> nvmedev=3D$(_find_nvme_dev "${def_subsysnqn}")
>=20
> We could make this a bit more generic and move it into the connect
> helper. What do you think?

This nvme state file check looks a bit complicated, but looks more robust t=
han
"nvme connect" command exit status check. Do you think that "nvme connect" =
can
fail even when "nvme connect" command returns good status? If so, your appr=
oach
will be the way to choose.

>=20
> [1] https://lore.kernel.org/linux-nvme/20230621155825.20146-2-dwagner@sus=
e.de/=
