Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6595C433F5
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 10:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJDKpQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 06:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJDKpK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 06:45:10 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7391903A
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 03:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664880305; x=1696416305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=E/ydriIcp4zDU/SvQzZj+/37vRx7Tp4l/3cUvH8oypc=;
  b=T5cBPR35a7Cqp15qdcWoLwUXlFIATo2oAIW8e5OqVs1HhZ9gcOX08xF2
   yial2ALw5Q61nAjttPNR5DWrmv2Gm4zre2ftMEtQjvhpOH4PncQAmyOf5
   gWZhMmj0cgr8yjdH7ISbixpxMwtrqsILr3a+qtBSp2D1wqCY6lrX9UtZL
   rVG/3YnxFw6XlDyL7U9E1iqUfBx/6wie4AQZSHzTl9MP/UkZjg1Rh+NEU
   HDNXWPmgOmSZuCgsAzMZXdiaBM/8Qg2mTOX5TN2Xu7ilNYvXlfpgIRSDH
   2ABh+0CizTthhq/hMU+73Wwg3/UOb1wN6/hHXLxX3VdEKVsUn/tQUYoCF
   A==;
X-IronPort-AV: E=Sophos;i="5.93,367,1654531200"; 
   d="scan'208";a="211292149"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2022 18:45:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dstYWLLQI43KEr9M7wtIhoTd1u4SighnGt1JlAVyD2lNZq1/FWz5bRfau4fbHj+81U7rypIi4WQ/yXceAx0O3aDJhiIH7LKn1iocsiID/6X39bcef+6+mtsXCAF6D5S/SiSNCl3Z/JeBlEPpgsgZaeiW9dmGmzA6QOxJPLClxawg81uApi1L7FZxidgj8a0C5VEAMjUlUhqsN0G9r2/vxlb5+RZFihGWSk7GRc+ZdL0ZCwBcWxZo0IlA7fTnBWW+kSfsqxd5DwHFBckfVdlBtb6CDB3CFigLU64RshQAxYpqnGBJQs3NVHr/MLd5qx2lmQRYjbpUDbdB90hCZaRJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmE9ZvJSYRRH5fqCohOouD1ki416eElgM2H3oGmQZmg=;
 b=cYhq1lo4JNNcR9HJ5BU9CIKudlGLyihQw6z6S2d3SH2GIDOcIDTIWcky7OgqJqHa8wGXXjgF85E5H08+3IOjO8JuSYiEalsPjBjyf799CwjURzW5i8GIs5t1QSEgLMaDU/64SvNizi2ZIqpZcQv8Y8ebXByYRBjRWjLE4Rlk/V8vy7TAi50gDKH3ns6A4NPByEoAJWwRQbDiyEm5VmRhL66iJbkUcHP64jAWtkjvmSBmDeqzz66VzT/OYHYsqI3UPjRku2WEFjYum07KNzmEzyF21rftCP5u465DpjtdJFarMMlrlnls2g4JCFKaXHA34umP6ZuCx+K3hnXiAT81Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmE9ZvJSYRRH5fqCohOouD1ki416eElgM2H3oGmQZmg=;
 b=wgEsYHC7vFtSTVqRJh4VQSCcsyl8RfuTHgY9BGvgvU/7/98We35CIaxW78kk5hc2lTauFdLktDL5Qiu3gByIgCgrQMkcm0jsh1iV7mSwlw+izMqM4mbf1YgQ5AiCXxi/BGAlxh0O8ZU3uEnjGxZldBGygyAZv0PoWox5Z1xqcnI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM5PR0401MB3511.namprd04.prod.outlook.com (2603:10b6:4:7a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.31; Tue, 4 Oct 2022 10:44:57 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::950f:778d:1de1:53f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::950f:778d:1de1:53f%5]) with mapi id 15.20.5676.023; Tue, 4 Oct 2022
 10:44:57 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: lockdep WARNING at blktests block/011
Thread-Topic: lockdep WARNING at blktests block/011
Thread-Index: AQHY1GJXrtuQitm3Pk+3ExLt/WFGaa330IUAgATf7QCAACBlAIABQxMA
Date:   Tue, 4 Oct 2022 10:44:57 +0000
Message-ID: <20221004104456.ik42oxynyujsu5vb@shindev>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
 <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM5PR0401MB3511:EE_
x-ms-office365-filtering-correlation-id: 292a0f30-5b3c-44dd-9f73-08daa5f57ae9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KngNW16I4RJm4PbZqokBTcP0tLMej0JohJ/QFVMeq5kUA4O9mAMEIBQrh5VombOueWvH2bE4uTYbSYvvqkPLqoYCJ3mFr/c0iL8B1t9XASUxj03Wkhjr56rFiUoCb7UWZmzDxp7GreqkGzGovixVHAPObvsww1aySGDX9mEGnZIyzU3rVEowlCVTeqhNsM3ToP82y/PNEPVxkAc0v47bwgD7yJTQDNKfd/2jsTiRD3Ss6XAEgc0r+ZGXQpR7mBOzojepbeZVRSGwbSPnKEz3Hn2XLUV+eLNKTMjtQ/ygm+RfY0C+QU5iq/5vToG8WqxWvLJjIUMr7BypbFuHCk2O/n3kwtMuu0fft3Pr4LOrgw3lzMoZhUD5vcX+PuR09SMPBThnPrORJJaO6kwlMfCxUg46PwRU/XDZpe8RK/BnmFYaM7nZM7ulL4smpCZ+R8bP3OxH9Rz3gPpu+rgmXJ7viYvmD0hflMQAzAtE7IPcWpZ3Y/mgQEIYspvPF7AfLecQF6dCUoOr47yObOQjpDJ0RyXpibk1jTheNb0MNzBoR1ar2wLLXROI3d4Q5G4LtZ1De1FYmerfXXYiohFMwP3t3CbmTfEhRfS4Glqm6PloxANf4DnZNMHcLCjA+rVhTGYx2VXKkHkXtRd0RN3hhwPxgkY0BbyFkLdk8wOBRr0PjoDvbXJJ1d3zmE/NLjw1eR6IlSL3SwEWSVbJPSZINqutiidtdJyayVU9xz+7xG9oFZr9WC0Q5tT1A3zDfZpdHcdsv4UQZnEa94dkq2at86CVfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199015)(478600001)(54906003)(6486002)(86362001)(6916009)(316002)(71200400001)(8936002)(66556008)(41300700001)(5660300002)(6512007)(66946007)(91956017)(26005)(9686003)(4326008)(8676002)(64756008)(66446008)(76116006)(66476007)(186003)(1076003)(2906002)(6506007)(44832011)(83380400001)(33716001)(38100700002)(122000001)(82960400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jmZk+IzgjLZTWLGorypD3yqUBUjwmjHaHJtvp0od1dwlk1q3jpdhNxr/yEbJ?=
 =?us-ascii?Q?FCvFlgBvKllG9MF4Md92eshI8e7OAKKI12aSnNH7M0HUBb/nMTGd/+/jLWLq?=
 =?us-ascii?Q?qg3SBzJ+8qG55hoqh+KEDyYjTmHIvyKobSjJ/yHrk2n5A74GvWYSyE93L33C?=
 =?us-ascii?Q?/me4flXlVGGJlHX7OmtmqFt8PApyNi9ZRVm9fSPQGRN4chMPDYw+FJS+bROA?=
 =?us-ascii?Q?9EtYcCIgEYlnyMTMRBw38i5mf2w6jjnfti4FdpYY+FT2xvN3izTZIwJu6w02?=
 =?us-ascii?Q?aIW+Zbm4mQcVN6cWQT5H8rSG0x3QJSEv7Z0W3aCdq2ux4K25JL6sJ6xLr80W?=
 =?us-ascii?Q?fbMwq8XZLn9Wu8BDOLdO7CWGviSd5DHW4Cni7dfiz7dGlaewnN0G7pQR4HCQ?=
 =?us-ascii?Q?AOchUe4CZuqqIfQ750DnUgEeqUzOogb1L0c3MtshkZAYjGGHrqZqAtnMbfZr?=
 =?us-ascii?Q?Jc4EbY6qruXHg1ykqd6smdr+oVyDaJqeLFOzlBFSY43VK9NiXQE5UlocoqqD?=
 =?us-ascii?Q?C6MN+C6sHlYc0b6rVNS/k1W3baM5e6vxiOR4GcMZzZwB2azb9FT8ADy0JRrw?=
 =?us-ascii?Q?L/fLKs/6dKIDP9FeekzGSiBKTTo0GpYAKUI8H0iCCd7FyabmgOXtLg3Yf16m?=
 =?us-ascii?Q?PzBOP8Jf2cNGN6gYSrN6e7r7hHju/3m6OyG8NMjArbcVx/nRjA9wmzCzAqaI?=
 =?us-ascii?Q?zqK7Njhaykx8u2XJqR93LRp5xU+3bzXWSRUse2fbFpuHEyZFv9KxN2bZWqSE?=
 =?us-ascii?Q?UjRb6BayJWcKsKzAvVk2FHAbDzOOE6zQwWuHHNIOakPjWtoexCz/TGS9+OPy?=
 =?us-ascii?Q?2o3aRGuV+Bn0TZGOtsehMJ7irt/EbagL+EpszISIEMW9a5n9DIlLX3hrlqel?=
 =?us-ascii?Q?xrBIeWjBeU6lOpDJbKAyNL7r2Moc0AW0ZhuhVA06CG7yuGjx8xEe4fdJHZAb?=
 =?us-ascii?Q?DCzkvYUPZZdeSXTIfmb00KeO50+zmwuLs+c7Aq/W6njyXRskZo/7u/vSisJ4?=
 =?us-ascii?Q?vj9deUVWm7x3B5QXLeTLCX9xKsGHfUkfq00mc+QsyQ+sMSfqFXftmXmMuX6h?=
 =?us-ascii?Q?YJBKEpe0L8PGy8uxGqiOfIX5RpBd4HGADYsbuMRANpfAj/f25HpgxwiTrrok?=
 =?us-ascii?Q?ION/PYCE3UWi1+sFunBY+yQpKH7Rsw/AX7Nof7XSqjCGMvNVzibKAIrIMYn3?=
 =?us-ascii?Q?/xJ1y2zWm9klKT299MMC6hPPnX982W9XN8Yl0wSKguIIKP7SlObEiib0hSI9?=
 =?us-ascii?Q?sNsgoRaOAoMtlwFAMuJNOY5FQ14OZnk8Z3Dy9BUVcJyiXwU29zySQNkeoJAI?=
 =?us-ascii?Q?FSKwqhcqpiKVZWGG7kM+VZVLo+1Jn7rzAhHxTR21rYXLwdMa115hp26RtAKu?=
 =?us-ascii?Q?M8WOTloEQ4ujrcGB3r2bZLhB5Hdu8QjwRYcV2kR+k/KTdoOP/BTYMAr3rNGM?=
 =?us-ascii?Q?APX34J6tvW2jcEJLwuPdXYFy/aqWFWJmZ/IX608HzGcl+DR9Cf7xLukyrZA3?=
 =?us-ascii?Q?V56tTlP5NjWzMAIzx1KjFw2qHsXdKLeKFb4wpBpciqugBlxHCEVIiWH6S4MX?=
 =?us-ascii?Q?iCT518uhMRb27N2Mk5RQl24gYqr/kUmvpled9jHCB3NrKAuJ7OekC7meYrAi?=
 =?us-ascii?Q?U7mULk+nwHpAP7h3Lz2K3n0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73FDF693FF3A4A4781F8392CDA085D93@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292a0f30-5b3c-44dd-9f73-08daa5f57ae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 10:44:57.3579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lx3x8RrEuCW2SJakFscEIQWrPBIuQE5Rvbh8qYb1IoU+2AepLcgUQH7EgWgWrLySl08tHcyfHQ1C+Owvqpf1dgf7SWfvbK6yQNLW9BLq6DM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3511
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 03, 2022 / 09:28, Keith Busch wrote:
> On Mon, Oct 03, 2022 at 01:32:41PM +0000, Shinichiro Kawasaki wrote:
> >=20
> > BTW, I came up to another question during code read. I found nvme_reset=
_work()
> > calls nvme_dev_disable() before nvme_sync_queues(). So, I think the NVM=
E
> > controller is already disabled when the reset work calls nvme_sync_queu=
es().
>=20
> Right, everything previously outstanding has been reclaimed, and the queu=
es are
> quiesced at this point. There's nothing for timeout work to wait for, and=
 the
> sync is just ensuring every timeout work has returned.

Thank you Keith, good to know that we do not need to worry about the deadlo=
ck
scenario with nvme_reset_work() :)  I also checked nvme_reset_prepare() and
nvme_suspend(). They also call nvme_dev_disable() or nvme_start/wait_freeze=
()
before nvme_sync_queues(). So I think the queues are quiesced in these cont=
ext
also, and do not worry them either.

>=20
> It looks like a timeout is required in order to hit this reported deadloc=
k, but
> the driver ensures there's nothing to timeout prior to syncing the queues=
. I
> don't think lockdep could reasonably know that, though.

I see... From blktests point of view, I would like to suppress the lockdep =
splat
which triggers the block/011 failure. I created a quick patch using
lockdep_off() and lockdep_on() which skips lockdep check for the read lock =
in
nvme_sync_io_queues() [1] and confirmed it avoids the lockdep splat. I thin=
k
this lockdep check relax is fine because nvme_sync_io_queues() callers do c=
all
nvme_dev_disable(), nvme_start/wait_freeze() or nvme_stop_queues(). The que=
ues
are quiesced at nvme_sync_io_queues() and the deadlock scenario does not ha=
ppen.

Any comment on this patch will be appreciated. If this action approach is o=
k,
I'll post as a formal patch for review.

[1]

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 66446f1e06c..9d091327a88 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5121,10 +5121,14 @@ void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
 {
        struct nvme_ns *ns;

+       lockdep_off();
        down_read(&ctrl->namespaces_rwsem);
+       lockdep_on();
        list_for_each_entry(ns, &ctrl->namespaces, list)
                blk_sync_queue(ns->queue);
+       lockdep_off();
        up_read(&ctrl->namespaces_rwsem);
+       lockdep_on();
 }
 EXPORT_SYMBOL_GPL(nvme_sync_io_queues);

--=20
Shin'ichiro Kawasaki=
