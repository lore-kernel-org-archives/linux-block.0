Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32D5C433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 08:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiJUI6Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 04:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiJUI6P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 04:58:15 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEDF250ED9
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 01:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666342693; x=1697878693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bFTA9ejc91GeWKPAeYjOm9kE75KVn+z9rPb4mB6rQX8=;
  b=Bhwr8HviW+vLEauuGyEWoWEhFv6IZwpU3Qsa0X22dEGEZF1z8jWmHcJJ
   DgPvYWdvgykJIbTuhgyM2a7mgoPL8luy6Ah3BbiRCcoxtTSYdRg5Skx9D
   pYr+4cg67NCKVoGdk7rAbkGGskkaZSH/G9lypH2vIQGktcL2bFxid3Jra
   s81lAtThXCQH41VZx3xW2tjucLJY07W/ER7CotrxG3bZZ4ZeJVbFplwHj
   TT/oUDi5tt7XQ47SllRVoAJWr25b3b0RcywMa2QPy54KtxoFEL5JpJmGe
   bEWAeKWsLXMp9qMxjUVtI++zKQ11RDqJttg9RVtxr5GPV0sEYy0Gbhgaw
   g==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="219582823"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 16:58:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+wcR52ovJ+KUNlS5zDZlJqJb2BUkW6RcbUO3QHCfQD2e5W+Sv4gLeNcQHnmjj/tfPiBsTtR7oOf4y9iV8SyleHiaQUedD8IEFQKK0oBYHgqP7JobPqxpQd/GLKmIq9iGcXhfEtvdZrxaimnLtFSbr78Qa2Mv6ofU1qwBvMuIh0L0uJFCP3pdezI33vDxOpqhVB/53iU/O6VSRthIbFp7Ts0vxEJqebCfXdK/XukmFQxhA52ZCSaOaJFYdpZXuTfmhzQ8S9ywHa90q8SRdrGdrru+kvFhDsHj+JZiO8EjJMAsgTG79ocLV+JGNHY1P4myZmL83wrMblUYEXQBDvOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvcJFXJJoXRmWcxN8TiS0ajZ5PNzKyWGoEvZ9mTAmjA=;
 b=dOUCMwOqJsKitl13y4qWWtgF8L70nS9pxCSdWwzgnG/6PHTAsDNDoCjIa0YqGy8hMQMJqgWYTKQ7Amvb4W5D9RUo1a3MVrp0SnDb+NxEKYEsXT6oc8d52itV5SWOxRehWAZRVr3R/62iQlABbNs4cNZpcOcbVwvVb4iGH8EsTQb+6rPsOqVGPqYXVbLCNyW2wY+vhjX6oW+TxYyJFfPlnVs0J8Y5wMUMBlX7hCxjtgw+S2yja+g/HwYeTL6bAbhPcZo9rI8uKDjgQSpa6JeA1BOFx560/FibDjpzUECFhw8AOuczNRdISGWHpbj0G1sIOPvpo+2nduVGxHZ8kCxl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvcJFXJJoXRmWcxN8TiS0ajZ5PNzKyWGoEvZ9mTAmjA=;
 b=p2DZOSDamxLBmzEe7hzYuxV6tqbMqZaHrlj9WqbRPh7GKQnZC/wxhN5kVKvFwdKkJthsVu9VucnGmSgT0/gm3amwCr/LOs2t2Uc7gCGPQ2B7cSEgrOyARGAPMXONGwIgmA5w0pcidNUgxPrmIdKqVWg+IIO6JbX4LOVSEwbAGvQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB7028.namprd04.prod.outlook.com (2603:10b6:a03:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Fri, 21 Oct
 2022 08:58:10 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 08:58:10 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     Eric Sandeen <sandeen@sandeen.net>, Yi Zhang <yi.zhang@redhat.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Topic: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Index: AQHY43l6J1B4S//4t0qObxFCSR9tRq4VPZSAgACG/YCAAFOEAIACd3OA
Date:   Fri, 21 Oct 2022 08:58:10 +0000
Message-ID: <20221021085809.zkzw23ewnv6ul3b4@shindev>
References: <20221019051244.810755-1-yi.zhang@redhat.com>
 <122cec5e-5374-e98f-a8e7-b063d9c413fc@nvidia.com>
 <306b38d1-3098-91e0-9ddc-f4a8660fa386@sandeen.net>
 <d3688d8d-bcf7-9cbf-7c99-74cb1a05a9dc@nvidia.com>
In-Reply-To: <d3688d8d-bcf7-9cbf-7c99-74cb1a05a9dc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB7028:EE_
x-ms-office365-filtering-correlation-id: b46873d0-720e-4595-60dc-08dab3426108
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3m6eI4UZXvfAv1ZgvB9LCVnSAcAvWDnthgZBu7pVkQdApBESIOf19oAIC5LXDkgu0j0mNWmg5D1QedjarXC4vOL+NhnovfLoqIXdFtbQcZQYXAM1LN137+NI/MYHyUA5lPEsxhYoljJzfJriWPiGvMomF2YVtdZtygtntbkVaXxhak6NV4FSZjniaOkwzQ6NzGjLPCa6vnsRiNdYmopfVAgUgDZj9kifwJqWQf7++w0dR9VjCEezx+/KwMsKwe43HjkCzXctRTGzTkxE/368BhwuwMq9Rl2wtjY1f2B/ssjLJ8PFxWsoVBFbHZOt0lIV3yjuKnXBR8lcySaNEZ6UkrKHgLIrr/2XGKYk4vUNntzZ+Cgmhq2PKwTLkze1Qeufw4yquiDEkJvQ3cCrAc/RLBRkm/Hx6XF8+gL8GuJr/evSBSlPQIIDGg6/NBU0V0NoHpda0Q5W5WdZavsboe73SOps2ac0k2ZgJdlIDp+PAZaHZam8PQTkZUqiu6ktVNQRsE2AxkdJHRUGwOF//5KfIfA9Vu+wYgHD93pofbNEulRye/wSrhJ/E2+z9V+1wwJ/hMMv5iXgZOYDc9XK/F72+GVVT/MI0ZRKwGTagmExU5VwJmnFw/hP87EuOev+WsOHEnZOlI6CBs4RasxFRTfZIBXF75VIxWtCisiHo+bbgNOSjAhfXetWf5i/93cbAmp8nSAJdYqto4qq+xxVeVRFORjljzHTIN2CiZtCejCd95t2lKY3NgQ3lcLWPGLpG0OmqItVMIkj1NCJl902TfoHSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199015)(1076003)(6506007)(5660300002)(86362001)(8936002)(4326008)(186003)(53546011)(41300700001)(478600001)(6512007)(26005)(33716001)(9686003)(66946007)(38070700005)(44832011)(8676002)(66446008)(76116006)(71200400001)(64756008)(66476007)(83380400001)(66556008)(54906003)(82960400001)(2906002)(91956017)(122000001)(38100700002)(6916009)(6486002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bp/5RE8LCw81mSV9ffCKavm4vSl1f/N0duf6vkVNh7vonkpxo7g2Hr0sjwb8?=
 =?us-ascii?Q?yWonsS54mtKynjp3CA2/gQG2Zapu8EAlH8k7B9gW69cnY4JCBFiwiFGtS1Rb?=
 =?us-ascii?Q?Ouh6yBOJYGvy445zGb8aBqbTEnuAnnBOtS7vaptP1mI2aJ81DcVehJ2Uf/9Q?=
 =?us-ascii?Q?fkeN0CqwcijvppCbtEpCgbN1slGLZcpcU5NCWTV1874El3T7AOHMx17XTVDA?=
 =?us-ascii?Q?B1TWTFzjKAJdhW8yjv4SSQdeNu1Z6UNY4fYianDTx4Ae2dLdTp8xiOr3omE0?=
 =?us-ascii?Q?zT/2XP1674uOW8UK4bjNabb8AaS8Qd28eMAO8gBorUSRLDzEc90SMCU9fs0L?=
 =?us-ascii?Q?UYobH6MLRls8WqFGE1I7T7s2RibWpsTUkHvlo8D/9FASZyJnmJPrySEc4FdT?=
 =?us-ascii?Q?X5flkH1QXqov5+ob7jUUmuuF9UWrqRVdjc6xoRNYbOxiKVepR3dXRgCuZkbA?=
 =?us-ascii?Q?ANVcRY4YDc3+6rGuqQhuTRkBzcJTfddz+7F8fOKTt2JP0FPyNnBC3Uz4SLCj?=
 =?us-ascii?Q?+U6vTPbKFVGRs80XCtk0pRxSqVgFVc86VsBNFdhCXQBlKC+2diCbWTRAYynp?=
 =?us-ascii?Q?EgRUYm1BNFM5Ys9YMSxEMgBsXbIWDN1oO0nFzdZmrxJ1cv0mlCwDcoVcY+N6?=
 =?us-ascii?Q?4kU0sjWPXUuCpz7FUMZwq5eXN9lwdcJcUqVYxqVf2zKiXg/8rlU5kcCNLfTV?=
 =?us-ascii?Q?WywA8kYO7DZg14hPykh5fyfjx3xtP8/7bkGa/9JuvEREuO7I7D25wPHsEmaQ?=
 =?us-ascii?Q?bVmOGyZgvVKf18JsCqZXfsAdx1Og1sqo6gsSqiOMuVgBQNbZUL5Rw4BhGH7T?=
 =?us-ascii?Q?YguJyQ5yFf52KzgZChD5jxNYuo760XRPVH/vS2yGWTXRm3U6xxDZtpGaXXhg?=
 =?us-ascii?Q?HRdGQfWuJDbB46/D2gEr5bdC65mVlJ/QdldHsikNK1zjCMWDXHTya+9iIjFJ?=
 =?us-ascii?Q?rBTXunjQgL0bf2Nx7fA6K24DM03J6MrFmWYexGkFwE7F+lQloiJY7E2Jymdj?=
 =?us-ascii?Q?2JexHzJ1UWimOtRu/fH64QaYUBFskWOv6I+aPqfQ9qZRBQ2rM/z0i4EX1H5c?=
 =?us-ascii?Q?P8hXZ478f8p+dBfmrmbU8tPcUitOG0CxmwzYrdKtHDWSE8Z7Zp9z5uBcf+w5?=
 =?us-ascii?Q?oS2Y7IzS11Iw4w7gcuIeIeB2O1uY1m0GSxT0ejx8/b6/mylSTy26YjUi88w6?=
 =?us-ascii?Q?SgiSieWUH3keT1Z9bmCt8GvIVtJLwoTN3mZJ3i3rbccAQYe2NzFQZ7AmnfxD?=
 =?us-ascii?Q?1+WAicwHTxfKIywzJYtrAJtP3o9dPF6HeH8b45hTJE2idm1o/G1sjtr/7xWG?=
 =?us-ascii?Q?ziR8/piB0LzAnPVBprRYTc5By9npNBsgtKw8X90r7jpgzHKBp4sRqQJ9shUy?=
 =?us-ascii?Q?5wTRPF27ocIi9Kt+Ir9djCla2hq7286AiZNd2sEg8RDxyD74vbl3HfQcCpsJ?=
 =?us-ascii?Q?/x1H1V/Cr9k0cGpmtzvgITT9kryoLAqMxPPV/Z1KHpu/MIhennFd6DvYRVgG?=
 =?us-ascii?Q?DQc6INGqkezt6V4NTsPbJV2k3/XZrU6auyav6kYBdejE3hmjDk2oiyFbT1rp?=
 =?us-ascii?Q?YrcZw++a96gIXzzpe/o0IdHcbrA8tvDJzRpgmaVOA22CULNk92Mh2JHBwH9X?=
 =?us-ascii?Q?hU8UaTZYQe2ZrG/3bXg9R18=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB52E3CA3967444E845287C4BE9FEF14@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46873d0-720e-4595-60dc-08dab3426108
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 08:58:10.3342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZB63wFsAo2lTd9cNFBEBwZZ7jox3JAmQ4pKbk82l5P+hAr9urnqk+8CEH0Ttsez2yeUOm98d9yvFwAYpGAILLXv/RuGUAJPEC22PancAhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7028
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 19, 2022 / 19:18, Chaitanya Kulkarni wrote:
> On 10/19/22 07:19, Eric Sandeen wrote:
> > On 10/19/22 1:16 AM, Chaitanya Kulkarni wrote:
> >> On 10/18/22 22:12, Yi Zhang wrote:
> >>> The new minimum size for the xfs log is 64MB which introudced from
> >>> xfsprogs v5.19.0, let's ignore it, or nvme/013 will be failed at:
> >>>
> >>
> >> instead of removing it set to 64MB ?
> >=20
> > What is the advantage of hard-coding any log size? By doing so you are
> > overriding mkfs's own best-practice heuristics, and you might run into
> > other failures in the future.
> >=20
> > Is there a reason to not just use the defaults?
> >=20
>=20
> I think the point here to use the minimal XFS setup.
>=20
> Does default size is minimal ? or at least we should document
> what the size it is.

As far as I read `man mkfs.xfs`, it is not minimal. It changes depending on=
 the
filesystem size.

To have minimal XFS setup, do we need to care other parameters than log siz=
e?
I'm looking at 'man mkfs.xfs' and it mentions data section size and some ot=
her
size related options.

Two more questions have come up in my mind:

- Did we have nvme driver or block layer issues related to xfs log size in =
the
  past? If so, it is reasonable to specify it.

- When we see failures of xfs user test cases (nvme/012,013,035), is xfs lo=
g
  size useful to debug?

--=20
Shin'ichiro Kawasaki=
