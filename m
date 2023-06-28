Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDC1EB64DC
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 08:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjF1IYa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 04:24:30 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:14040 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjF1ISb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 04:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687940311; x=1719476311;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oZZX+le5v5WF27RNKI41Zxu4q2/Quhoa6yHSxzHRWUk=;
  b=JZAqBC3d/+CR8cO7zh8/4p5MLTDMR8ry6VC9CjBg/+2s3nnrjhS92m3+
   PO2u4H6eb0n+dmXEeQLVdX93MOCBOVuV3+hCYUmRx1ahCMthDZ4Lbo642
   Rqy8Dbu/h9z8CLGWMsxp6cW8/tStWgFwLiYv+GAkEYw/hYAaRl4KvIDfr
   6wRsLFU+g/ZsKSzeeOcAdwFXBJEPLDPF35X9KCZrsb9oHxehDZaYybiPL
   Bk3VCJGiQE0P1pfNQ86NuSZmWgRAc7YdqcTqcsD6sJfFfDJI7NeBndMmT
   TVPU12FkgrFJF0uhlBNxApdmu3jqnKbKraFzNrCIv9LmjnonnVDn8yIdQ
   w==;
X-IronPort-AV: E=Sophos;i="6.01,164,1684771200"; 
   d="scan'208";a="341764712"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2023 12:39:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGP3jToLQaLfUd0laZyo0I/MtizYM+zzPDeAiHFfH1akwOgKZkHkTNKQB+XF6OKOsTGc84WcsviKJM7t1Vy/0L5CIuJ3P91t4cC+P2SRe3rS0RVyZ3+t/NVWKKdM3t4Q8x/Oc9fkoWSbR76hL5QnrigbQXbUPcRJjYucdjs99whvmKrqYXPWSAtDfXaqUbRgA9ka6CahL3ZRV+1QuavoE0LExrtmumGNOUCvyrA7Y1CaXDbb0sg9+gHocgZ0gjSu2V8cULCemYnsZ/+jVI3uIPIkUsMfq0odPRm+YQFEIK1ImfuZIkVhl5Nu3INjT/ZFQGeCgNROEoafvm/Zt3d1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3ie+ZYkDr6Uux/7Hxj77sXnDS4kWA2HZGd1s+yNmk8=;
 b=LAa4bJRTAgIBRQYkOsbNIEt2Dmsp0x6L2xt9lpsP/YAwcL4lmuu24Y98aZvuIz0HtwKva8kd8Yw9EUqX7s0ZvAZDIfR9rxRizgECeQV1pNSE4aTsdurvKrgxSiLMbaRTWoua6UNMjeyt9aKvLw5tYH/RTC50uy80b5NDnZcfAzv8EHDy2RPwUhrNm2RdnEutSfgZn6S5PUf8bw2c7IAY0mR6K75kJcBmdJOTudRcmRKIK/vpeL4qqWXsOFElvZvF+LQ4Io4wc9OoJ7+u5AB11CpDgU9IZN8Guzg7hcXEdDd3PiszbK+yz0Vvkxp2XqyHRb0+T88r0MxhnPea/EBcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3ie+ZYkDr6Uux/7Hxj77sXnDS4kWA2HZGd1s+yNmk8=;
 b=wpjjo0bEyHftypksyQ6o0lY+g984LNcYoYuQmm4u8xZXXnuW+dFhTNTnUjYLrWCu+K3+QNaQHDXKzMBQRGKIfpWcdkGGmBMjLAewl1Vm4sR7UC+3CgauhC65VCncQZ4zt7I4aj3chYZ29tKKAcM49y4Wj31ehZyK/12tGWWxkuc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA2PR04MB7658.namprd04.prod.outlook.com (2603:10b6:806:14d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 04:39:53 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 04:39:52 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: blktests: nvme/auth testcae bug
Thread-Topic: blktests: nvme/auth testcae bug
Thread-Index: AQHZqXYKKv0icp4yukWU2n/X8YUTrq+fojqA
Date:   Wed, 28 Jun 2023 04:39:52 +0000
Message-ID: <72u6de4wfaxqkrnqw6puc432wvocqlbvpsprkvd6nbt3gltubh@7k6m6z3567ab>
References: <6dfe85b5-5415-7140-e377-c1448fd7fb8f@nvidia.com>
In-Reply-To: <6dfe85b5-5415-7140-e377-c1448fd7fb8f@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA2PR04MB7658:EE_
x-ms-office365-filtering-correlation-id: ca5396f8-5124-461a-afc8-08db7791b70c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZeMSDOKZ3v6vfA9WI2bNICVFfX3OQLy7rqNxS/ypRtyZjs8wE2Zo/WIVpF52FFXsOg81TwnCQQkfr072Jfl8TLLi3SyJDe0TpjJxespaQl+AbdjmLRyAweF7pAtWJ80MnKiJHXgZ+Vjc8vPw5z/Y+2PybdwoI7PMyN+JN7PCI1yHUFlmQJrbHwLW75oxEhQ/Ipzcy2QKJDuF5UmagL81lx1KgB+uoG7m6u5ZSCYn7xs9MjhNyvIUdOd4+e0EP8lCJXXREDPqfZ3vfwVaCDoZNLzy7nkyVauD/uUJNVaOn/KaCacPiNXyeCIGNf5rc0Tihq/Lxgj4aR2K5O162Gi9gMhJ5IXVwuYOM8zZGAbXQ9z0k1kE1ZSg5U3nmphUQQAoGqvOyw0YxPzFD537IkRQf54F/G2XwEFaPj2gBjBjfm3YZRzJqt80fvfnAXqAta4sdJhq01aERYxeQEMZEbTS+QozukaWrLhhk9NcNl94FMDm/lMc539oq4BywvbxV0JQyS81cQ+8pte+jGEstFOwcDVWqZBsgwC6jdrDF5Qrfez/s257euLJsodQWNmY9C3XZ/xK7R3sOSyHLXx2cdpfkbGzdj6e6VZtYnBwffSg/9WyqOrcqrbUIqOzEtvJsjYn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(122000001)(82960400001)(38100700002)(38070700005)(83380400001)(86362001)(478600001)(54906003)(9686003)(71200400001)(6486002)(91956017)(8936002)(316002)(76116006)(8676002)(66946007)(66476007)(66556008)(4326008)(41300700001)(66446008)(64756008)(6512007)(33716001)(6506007)(26005)(186003)(6916009)(44832011)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?owI/KpwcQuf0kSVckaOBaDJ4PhAPQPGM0IwHoy64O0/2rSOvVpiR/GvDwR?=
 =?iso-8859-1?Q?V5y1qAXQSC4Bc58b0c/HWXTbUBH8M1FGBcEEQscKq5h7sXoz/Q+glUOwqG?=
 =?iso-8859-1?Q?WoJ4ca4pTa0WemyiqJs8U2m3ZwWBBrZ0hAEA2KQNZiY+Zlb5q1XF+hUOGN?=
 =?iso-8859-1?Q?xKXxToTUs9T3M6obh7jSMmXl83qT/HfYDHvIN3BLO0Q+w1yybOP/zOp8mW?=
 =?iso-8859-1?Q?NCsWU3MUmEW61v1KjQxpfT/mUiRtZaPUCSduoA2LnU64XKFGhcacFaPLvW?=
 =?iso-8859-1?Q?fb3o+Pms9UpLqpoaXuc8SIdTzhmz+pF3G2KafZtdPwXtz7mlpVf4HC546c?=
 =?iso-8859-1?Q?scqYINpuC6NJ2dFUCYsQ4g5V3uptDElCfCPJZnEOzSM/CaforkiQbLsx2U?=
 =?iso-8859-1?Q?CFbZNP2WliQ2PByxkpX60t77k8y7QwDILu6hTnoCSkNvNf3NRXiNdSi7Vs?=
 =?iso-8859-1?Q?f774z6mukYtm8r33UjBjCaFsPMswgP1kSXHctsZD5dc3gzL5sOm9aNHinD?=
 =?iso-8859-1?Q?aLX4GSmFE+1NgQJnyc3zQ5a04yUNi9KgiA9qHkR8uv+KIzBWSLwYlGyiMt?=
 =?iso-8859-1?Q?PeC4m881dvw9KIsEUQPjgz9AgSI+w5vPuPwFqjNEsxRMTAo4WU3x5mAl0W?=
 =?iso-8859-1?Q?YLzb1ios9I1soP6TIfyi6iLUJA3+qW7QfmonF+qs1YG7PnPNIPdozZd/+B?=
 =?iso-8859-1?Q?SFsBN1QeNIyc8cb7uIr85KacnoJnm1EuQgMQYFigcFXrA/rVwWR3tzdslc?=
 =?iso-8859-1?Q?SBafzFqDdEy/vVjpKJN8SESLzZ/qNifjcD98dkC2Tuf/g2oXZ8jngIsQcy?=
 =?iso-8859-1?Q?OyjuTwh4JCRL1m5k8T2QVgH0e18oaeXlIc5ML5SCduFz308J8DXXoW+r9a?=
 =?iso-8859-1?Q?B6pPWnk4nDnQIonJ5PTrkCoM34unJJs9xDXI28PBUNfa5a5lz+/QdJbZV4?=
 =?iso-8859-1?Q?MARKk2yYbR6/CPVxXE4rsHLBobZvVSGBJjl1NhPSMzy4pkL3c2gT06rwyI?=
 =?iso-8859-1?Q?eoTlDj73BprbmaVX8g2q+G6vB/2JC3AUSOHZGF3wadl6toaP+XqRe0Ifim?=
 =?iso-8859-1?Q?FppwfxW3r7OmaZ03KgEcD59dorZtoLlT8mOYv/Vb9B1kd6kj+3zlyRNH5L?=
 =?iso-8859-1?Q?mu53F0bU/Pa57VNVxCGSGXvXwsD8/BEjb7yjTVQrMTJI5Tbp28YAEcAR3E?=
 =?iso-8859-1?Q?vc1sGpZh8A+4uSRzcai12+Dazi6vvZbukLjfijJflTJXuNMS0CpxIm1ewz?=
 =?iso-8859-1?Q?csck/dc4b2heOPSV+Vmh9ja5s3eqzuKacp4fHJdhYLxDTZeduAs2OY5UaL?=
 =?iso-8859-1?Q?4UQUGJRGx4p92ui1fvx7hwKPJgsTlgw+kr0C39Tv19fGvj79QtfXDAu4Al?=
 =?iso-8859-1?Q?hXdkF2CwinO8ekBlWVzCKnXle+GQ9/gNvuvnx4cZpWnt4YwAjXSGQUDQa9?=
 =?iso-8859-1?Q?6BViYD4nLG1gwfMP+xNyXRQLMWT3rFx/drHMfQr8Kjyk2TRcbCmkccaI81?=
 =?iso-8859-1?Q?fB+IfUBkupVHrfOFQznpEpa1CD9XmD2kHSTvjznYti+w9pRsfUzKJEAKJJ?=
 =?iso-8859-1?Q?YjRaRQAw8QSKSfBRXZTubtT4FToiz89FZY0QiUIIv7wQj0YWjaFpmqPDEA?=
 =?iso-8859-1?Q?qTZgPw7m50eEIXmxhoaC7iHb6+oBVldOxa3fU9xTGwTE7knJ3P/9H2h/ta?=
 =?iso-8859-1?Q?mkrXAfmQbRooQEWcTIg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F9AFCD389DE14144A4F8176D52A76D36@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z4iHEgDFMcQfPIFPVigv+8f4b87G/p98e4MQP2+kZyHBYGQ0wdyYPIhqS3VofgBKNu9XVPYSnQkrM7FUAKytI0CCTQQDC+Id8naY02Nweh3gbICD/QmE29pDXDedxYkD1v7kFn4zCmt2FNUSn4lK1Ioh+PCnszIdAskFAEK6Pcqg5Dn9C3hKClWjFBNsf7e7lEzyIHwG7WviVLvviE1R9cffIpgh9ve7cU8uCXxK39OQwGpfJFmEymV+7BmfMghU6vXK9eoC9s2uuM+QhGsqTlq2lGYjMN1nqEdmLIRoRtOptdfnp4RQzZSxYLGFSY91lVY5fzm2SeoVEQAwxRH+7PcHlYIsZ2Nf8VNpiXrr2jvOs7kCw275MGtsYSQqScsOuv3byK5p4HcdTXFN8Oz5QilgavfYyvJn2FbnT9PxPcfoi2UTXJ6ZmAZwyAyUOxo+8pjY3dE8zq7IeQojDNTHZbtjaJRImuirI5RI8ZNJMq0WXJNNvkNMNooVvAX+pphtY+2AX+reb4oN0JUyeC0ScqfNWa0Jpixbrvmksjz2MAL4dJzxmi9BXCNDaFdDsif5sFojy52aFd9CBRoIwy90xxB9HjRFzDfqlJvYxX1nuN+OqOWrAfWLweqc0fWbBujlUmCY+y3FzT+oInufLkYiLhxX7y2c4S1QzEEmLEGjfBs/cCJgoBsD89oOs4gCBqYUZo8Xc+QfwW/yxnOz18JzYqo06PSN6NFcEnsDSEM2GJX4NjlZm0Iccg0GHyaC7mrDk0MPTSJiuK8HC3wCwj3ZWa8D8C37UYGjxh+NYafJg291Zl9dYjpKd8TasSxErDvfeCYuBvziImckWR9Y6A8vVAb5/gHG/cqnpbct0Sa8+lMRUbmO7fNTJ16+aJBu6xLv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5396f8-5124-461a-afc8-08db7791b70c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 04:39:52.7934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWTN9eQPKOoUHMiVinsds/Aw8unVJCZWhPas8UPcmdl07fHx6Ormw2cdgfNxbnbiXAQvWnLSqJW2dIptr/8JQd08g7foELF9P0IBJSMSjEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7658
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 28, 2023 / 04:07, Chaitanya Kulkarni wrote:
> Hi Hannes,
>=20
> * My compiled the kernel is with git hash :-
>=20
> linux (master) # uname -r
> 6.4.0linux-01691-g98be618ad030
>=20
> * When I try to ran the testcases nvme/auth testcases are not running:-
>=20
> nvme/041 (Create authenticated connections)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [not run]
>  =A0=A0=A0 runtime=A0 0.440s=A0 ...
>  =A0=A0=A0 kernel 6.4.0linux-01691-g98be618ad030 config not found
>  =A0=A0=A0 kernel 6.4.0linux-01691-g98be618ad030 config not found

Hi Chaitanya,

These messages indicate that _have_kernel_config_file cannot find both
/proc/config.gz and /boot/config-6.4.0linux-01691-g98be618ad030. Are these
available in your test environment?

> nvme/042 (Test dhchap key types for authenticated connections) [not run]
>  =A0=A0=A0 runtime=A0 2.712s=A0 ...
>  =A0=A0=A0 kernel 6.4.0linux-01691-g98be618ad030 config not found
>  =A0=A0=A0 kernel 6.4.0linux-01691-g98be618ad030 config not found
> nvme/043 (Test hash and DH group variations for authenticated=20
> connections) [not run]
>  =A0=A0=A0 runtime=A0 0.731s=A0 ...
>  =A0=A0=A0 kernel 6.4.0linux-01691-g98be618ad030 config not found
>  =A0=A0=A0 kernel 6.4.0linux-01691-g98be618ad030 config not found
> nvme/044 (Test bi-directional authentication)=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 [not run]
>  =A0=A0=A0 runtime=A0 1.240s=A0 ...
>  =A0=A0=A0 kernel 6.4.0linux-01691-g98be618ad030 config not found
>  =A0=A0=A0 kernel 6.4.0linux-01691-g98be618ad030 config not found
> nvme/045 (Test re-authentication)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [not run]
>  =A0=A0=A0 runtime=A0 3.630s=A0 ...
>  =A0=A0=A0 kernel 6.4.0linux-01691-g98be618ad030 config not found
>  =A0=A0=A0 kernel 6.4.0linux-01691-g98be618ad030 config not found
> common/rc: line 212: 0inux: value too great for base (error token is=20
> "0inux")
>=20
> I thoughts it might be useful to share this ...
>=20
> -ck
>=20
> =
