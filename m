Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6EFC433FE
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 14:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbiKROGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 09:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiKROGt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 09:06:49 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A4D62057
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 06:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668780407; x=1700316407;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ia7ByXf3QNOVxmICQbYda4t8XpB1Fax7jdBFkoml7Vo=;
  b=KBslko05fKZzOtHdD0oUEWXGTz4WzVkUFQusOcOrP1uSd17ex3GcwE8k
   xIVInRTNTIyI3Y5PzvL/hWgtDSJ11WSK8HkyrJmD05mhBCUdduwR4gxhZ
   oTvyarp9Fa91uvwIC4ezbcDHj0IeeGNddM0GsdIFXpnKIdu/SkQwFJcye
   +hGvQTBxwsRcfSluFsbFBGazEMivtGT/YZU9YClbMYRzKbIvap+Zcc0Pq
   hBNRseDchV2xM8bMlX5PqmubNDC8XwlMKTaGBZqwBU8x2JIDQFBQM3XA1
   0xtVq2GJoC3l2T7uzoBSKaCpBLZhXeZ6Dl8LzrUfZbGkEcHdkKUFZCwfi
   w==;
X-IronPort-AV: E=Sophos;i="5.96,174,1665417600"; 
   d="scan'208";a="328715854"
Received: from mail-bn8nam04lp2042.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.42])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2022 22:06:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tk0/K8ashU9ZH0yz+vAgNH4aWURW/GDuJwnIW3E9xl4OKdUryDe+L3X6dvVei9KneRXXkKqVu0TOp7YG18PBgeorSoS+fy51muJ2SMAwu58Fcm8u0IEXxATcdwPez43K+y0vnHudFGHPAYiIgSg3UyeQM4JiMkPnn1iUJ1kweSmxsnuFaWc6KnR2UO4YB7/0U4Dnh5B4KMKho5Afv+0quGTRoqh/aTYqoktprZN4YyAZvIWhWhkchjDeqr0eFMXaLRU1lxN97f3z+s7hn/3zGeMMwY065FwevniOq+5YYJkVSE2W+DrbU/wRSOxpC5MKHlE/NV65Spr1O8oX7/pYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYmxQQUADZUTnYIiavL3p9U/TS2txw1avOuX/MIF664=;
 b=jloTQJbS2yJoEVN0fF7vqEjbmfPNNJYDe1NLJsv2YYfzFM0ZpW0DJvnvf43U6yKHzdAhLOZOBmY586ujjOyE7aXy+GUn0yWBlNPf8SDK0sDOY0FZy5zD1WeWHjrC2MlgI7l25+gzPNFf4QKU5cMEHgE+u1HbKBrvp4SMA7twU9och/tLdDoUSPZ9w50mMfbVOR0nTV+AzHeXyKhoI69kJd5pSm5YFQYzE9f05Ule0yc6A1ukWqHr9XE+4w8NxXKgG+AnBPiYaYmJPiw422aUDsRyAWgbMtV4zApqJPjVLaPxUJWLgkTrcNoaBv1SZHf5HV991lBcpmtYajzgGOmvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYmxQQUADZUTnYIiavL3p9U/TS2txw1avOuX/MIF664=;
 b=tUizGVz75S7g6mFZeK8M3wyvdLMQ3umdb64g/U/2zAfrVPGWNACk+REYnmqgFkWsDjZX6DRHiKHtXUO188oj+wtCIvYclGCs0mfsXvKa8w5Xru6G5nENBvxJaIH2nNscsmjfqXA8hUx1cDOQl7sh3iq6BBOuoNEfa/TelnG9pA4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM5PR0401MB3559.namprd04.prod.outlook.com (2603:10b6:4:7f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Fri, 18 Nov 2022 14:06:42 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%6]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 14:06:42 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kch@nvidia.com" <kch@nvidia.com>
Subject: Re: [PATCH 2/2] blk-mq: simplify blk_mq_realloc_tag_set_tags
Thread-Topic: [PATCH 2/2] blk-mq: simplify blk_mq_realloc_tag_set_tags
Thread-Index: AQHY+1b7ftomuUpRfUWLZOgyWXnC3Q==
Date:   Fri, 18 Nov 2022 14:06:42 +0000
Message-ID: <20221118140640.featvt3fxktfquwh@shindev>
References: <20221109100811.2413423-1-hch@lst.de>
 <20221109100811.2413423-2-hch@lst.de>
In-Reply-To: <20221109100811.2413423-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM5PR0401MB3559:EE_
x-ms-office365-filtering-correlation-id: cf617a67-be2f-4676-d410-08dac96e1ea0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y0A/OJVCVwPzYkTQ2X40gVq7YJCCvggng7UbZGUr6UK0KzJklmUOV0K6OVkSW59YLY+8LWzc2FtbMaWNErO3Rn4J5ivpL6cskg6buaBA8uFKBhrmSFYjXNby+rgPXF9rn5RRks/NGg+lGZ9gn7+tpuie460ISc5uYk9pf3dNu0Bted+/J8y7q33IMdYoiBP58lUhTXsFl8cKV3gN9pQ5X40HMY94e0UVDhYXJV6TIvWk5mcN6TBP4k3R6WDly/OV/gtGzzN/dDUpK4oTF3pEHmIa96aWlE/7iYrjVi8QqxG2EjHaMJL/rWnE+MM/avFKkiVqHrk2AaZydlIvzkXhc61RdpQmPCM6YRdo44wTLjjTaob62LdsAEM7g4U3NTfygaj59eY6qXiYeawkycUhO7mr7gEAkLO0m6bLyZVf2vTPmV9RDcacaividf6g4UdC9XkKVQy7xSOMEeTG+viMnxb6nU/C7Q4gWag7Et5oticdU+Z6VjX/8LSebZAqGAPkUwOYV/rHyjr34PIjYdi2eugq3IhzZZoRJyS8JHrxL5L6+GJdE51j1SDWbLzOWvMFz9MhvzxljXIWsJVy0kRKPIPbd+EtJ7uLW/z+Nrd3SFHjTlJVHcQDn7wVO4P17VBA6nbv5wOoXph0AQkeprZRfWngGEUrDOsWUJXYCTtxsthiJiyUvCNge+7kmOvQj/IbHzL5tYmZ8GTWBBYAQnalJyq9G16NkALn2OI3UCEJ+p0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(186003)(8676002)(44832011)(33716001)(66946007)(1076003)(5660300002)(6916009)(76116006)(66446008)(41300700001)(91956017)(316002)(8936002)(64756008)(66556008)(83380400001)(54906003)(38100700002)(4326008)(2906002)(122000001)(82960400001)(38070700005)(86362001)(478600001)(6512007)(26005)(6506007)(6486002)(71200400001)(9686003)(66476007)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eZEoXGV8gpahjJmeLF+eUsKggTC0LNouvp/RjeFmH1VyVwiuJVDYMy5014d0?=
 =?us-ascii?Q?iMDUdNcQBa/ihjPGMUthNjejQcot4OpMhs2KKHma6HhVEK6GtsYZZcodw+CB?=
 =?us-ascii?Q?fEXHIDJt7o6PN56Tu8j3fZfW96sKpy7knHsr1lkO5U+gCQj26h3PUkxG8dOu?=
 =?us-ascii?Q?JUKVU16twi8MmwSgbLX6jqHE2s6Ix2BL3DJUGLxFIrcuVWDSjgfquTa6Kigv?=
 =?us-ascii?Q?GsHxf5XhMZ1kBMlw+slaZkEaRQuOdSLWe6dw3WS5tXqVqbaOnPhwGxMxed4B?=
 =?us-ascii?Q?txgQ9tjCw2ikp2wHWDxRQHHzIC2TxHrx5TI41H09tQoIZVRhsSflYgFeRXOC?=
 =?us-ascii?Q?0vmg+iMFDSyFOLwQs09wY/5m7CtcohZ1B4WTIedqieIFqhXJdmYP+5xoJY1a?=
 =?us-ascii?Q?ZF/9rH4bT3PYvbYhuUc+BWeLwek1Pm2/QvWBruFvaQTWRadVErkqsiyGXPz4?=
 =?us-ascii?Q?dK3qR80eljd2PiOrURWIOIfQXxyWU0sWXfoH6cIQXZKGYQueSU1Za9cOD4wl?=
 =?us-ascii?Q?bnD4kKkA67la7Z3bHzHL7+L85zd2G9zgfNjv1g0grkPLwtx//VSDEY2eQZeh?=
 =?us-ascii?Q?gClEZHHx002C7y8e4gS3e0DuNXIszfTF5J4MPsTbH4iDOTyw6CfyCzK6DAv/?=
 =?us-ascii?Q?IsVG6MfJNOwqmdiVjS0r2K/CfY4ZyiLO+B7uFm8ubgPXDPSaXFOWP26Dh7iF?=
 =?us-ascii?Q?QYHbuKYkKz9MgFxsXXIYZ6Wu8gcHj/EKEjt1h7rXafAbDBD285J/ZLwqRao3?=
 =?us-ascii?Q?QQd2P9Rkaq7Uim0hmby1YgOwHGHkSVa7JnSMjg13MaBQQ403g8Ltw2JwZVpD?=
 =?us-ascii?Q?liC0qZ+lO0+PKYtSEMtaySXgx64Rz+i3ibrdxwLR7Iy1vuIDc3h2qIj6W0y1?=
 =?us-ascii?Q?KEv7IKEYoUezt7/6zywv9Io8G6VSFiP7QnSwqvndDo8HRaiKPFC90IVXuJ5Z?=
 =?us-ascii?Q?WH0EhQJ2WDxtg9tyNbD50KDOHGmJ5LwfDj7+4AyqUhaUwMEFHoxdN2EM74lZ?=
 =?us-ascii?Q?GGjMrZ3b50D/l4LjJwNOCXJNAGXt3naO5iTJtizsQW+K3LA8mI+WVyN2ahXl?=
 =?us-ascii?Q?1RxRh5IOakUuUrMX5+buuCTWsgeGVhGvbsRItTyQqshq0AW4JOGmYFp+RkAP?=
 =?us-ascii?Q?WihsZrPKFE9nsYReJTU4ugGEer67Zjjqv6IZWkyumB29u/Aly4NYapsmO0mk?=
 =?us-ascii?Q?1/k7/8Js5Nz+t9fzX7uWbDk4gHIYG5Rp6hKIp4Ft2QIqpxvI3soeO0SIJOog?=
 =?us-ascii?Q?Msf+n1gYSf4bMFu9eTpEMr0ORBXz3kMTiagMpAaoEii6duqj/0TW89zRQjF+?=
 =?us-ascii?Q?QgpNmnCoI8rfxi1KwZLZbpbiVBLInmVqWDcgf5Pf0nqjRhaBqgxi3E6h0rZJ?=
 =?us-ascii?Q?SnudOdhnFWSAA1b9OZdHfMynx0SoGClDSLOoL+7gCfFzAn+0XrwNHtoogLhr?=
 =?us-ascii?Q?r43Mj1TA0S5i2f/zh/arWwKWxEFF/HJQ6OrhbJyjLGfb/4YSzzjv6N3mEKF1?=
 =?us-ascii?Q?3M13+Lbkqv2MpRQaLNfyHmIcLu+lXRdpUK8rcFrQZaePT/UK2rr6BZQsQO4f?=
 =?us-ascii?Q?DFdHohLrrqnw8kqfuWmcMe8WCShali9fIW68IwUbbntjAU3XCyriPOsc0MRU?=
 =?us-ascii?Q?cvTJ7ixQxO+0Sqiu66nw7RU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3680ADB8151614468D5E76A7195A374C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YLE4tvxo9cJzitqZ+Idnve/iuKhh7GYhl36xZTaBSUJSctt2pl4UfrL/Mv5JUpbb7k7KumVgNL+AQnlCng+VXt1j8n01tyXmu80v6hkBZWNqLX4WAfprDcFWvvmwAEXIiT009HRl0SI+ODpFaiJbsu8hTUvmdTrqGaMjISFTq7HfD9Cp104Ht2nIRxPBhmoK+FkJMHeVEyd7T4REv/jUsSdkb+8/uW5kaulvu3Nx/QjVHSmiOy34vmyUnJEZbIC44X48RsHSaLg3N/MiQiXhq4JbtwboyF0cUfqJpXlOIuqc6gioGmsvjsLLvYNPbcxOIQDyKKnSP/pUPKw0hRH7stHS+YCU0PtcVR83BtF5VZ+f46tFSX/HC8KHuBuk/RLQ5JUYQLD+2zi7w8xHm/h/Us+PHgbehUgbW4L0logkC1RC2A3AK4DWdrMPAMxm1JA/BHDv/zHatRiBAW/RMZ+JzZgV6WqSfvT6yBC2oPCtTA9en/u15FlVXo574tZDKUBYTsiKivJ21xNetoSKy/In2T7d4MO2Fj3uBChWeDX9IePeXEMloLvNtvkpFadibkyzhMna6RNBklzWPL3PX/1v+g/ZkWQ5GahAc0LMsNDYid1EITTPxews21FJRHBYgf9BCCxSgwAXfNtrOemVlhjO/G/AT3xAgBXKblwJcx1KZPT5Y1Q8ydhR7330HzsrlUFoS4/AvKWxxsWf/B7wniiipP/c26A+jvZo3IyjnLR3cAcm4EMau7Atg7HFfxXmNRyLn1Gvpr8ZgNzWX6cKdGUEeRvUzBE0wTD9kfe2FXeYLpHOzfLpidRGwyyb/vpQc1ttkZyTatymsSMf0WgJ/kcTuicb0AnAikin1+xgqyM4JLw=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf617a67-be2f-4676-d410-08dac96e1ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 14:06:42.3319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjKdaGYr+xa0fc7jJiXAfVjmHu81OVavgtir8xnW+BydY77DR8+T7xLaER4uIE2AQujziGHeKybjKEWdz8KaG9oGv/s1TftZuzri549thVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3559
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Nov 09, 2022 / 11:08, Christoph Hellwig wrote:
> Use set->nr_hw_queues for the current number of tags, and remove the
> duplicate set->nr_hw_queues update in the caller.

Chaitanya found that blktests test cases block/029 and block/030 fail on
linux-block/for-next branch [1]. The test cases modify null_blk devices'
submit_queues number during test, and it caused the failures.

[1] https://lore.kernel.org/linux-block/5183bc2c-746b-5806-9ace-31a3a7000e6=
d@nvidia.com/

I bisected and confirmed that this patch is the trigger. As I noted below,
one of its hunks looks wrong for me.

>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8c630dbdf107e..9fa0b9a1435f2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4381,11 +4381,11 @@ static void blk_mq_update_queue_map(struct blk_mq=
_tag_set *set)
>  }
> =20
>  static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
> -				  int cur_nr_hw_queues, int new_nr_hw_queues)
> +				       int new_nr_hw_queues)
>  {
>  	struct blk_mq_tags **new_tags;
> =20
> -	if (cur_nr_hw_queues >=3D new_nr_hw_queues)
> +	if (set->nr_hw_queues >=3D new_nr_hw_queues)
>  		return 0;
>

When the condition of the if statement above is true, set->nr_hw_queues is =
no
longer updated with new_nr_hw_queues. In nullb_update_nr_hw_queues(), null_=
blk
calls blk_mq_update_nr_hw_queues() and refers set->nr_hw_queues. With unexp=
ected
set->nr_hw_queues value, null_blk fails to update submit_queues number.

With a quick fix below, the blktests failures were avoided. Could you take =
look
and see if this is the right fix?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a3a5fb4d4ef6..604e19be9648 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4384,8 +4384,10 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq=
_tag_set *set,
 {
        struct blk_mq_tags **new_tags;

-       if (set->nr_hw_queues >=3D new_nr_hw_queues)
+       if (set->nr_hw_queues >=3D new_nr_hw_queues) {
+               set->nr_hw_queues =3D new_nr_hw_queues;
                return 0;
+       }

        new_tags =3D kcalloc_node(new_nr_hw_queues, sizeof(struct blk_mq_ta=
gs *),
                                GFP_KERNEL, set->numa_node);

--=20
Shin'ichiro Kawasaki=
