Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E340C00140
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 01:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiHSBeC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Aug 2022 21:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiHSBeB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Aug 2022 21:34:01 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D96F356FB
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 18:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660872835; x=1692408835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lilKcUvsjSy58+yfuGo3LnPUJegCQxmaKC1eQEU5tsw=;
  b=GZNOwB03cggKeCAwPTWYkjO8LoNAnDgXVrURO+4wc8U06nH6Xe5YzH84
   THwKy+0lrWYKHL+HFBj+4yp9KPfsSQs6f59YLhkBXwZ3uTEoZOk4Y9HWY
   CWAhJOMA7gbg5FWAvIi+icAgr+l+9IfxlIV6lJ/jpbvMSp0Ip44bEZ7ED
   JUtNCU1h8JE1OhHL5zFlyFDrq9M4qY12bCplDciYYDDT12VihrGz3SG2d
   jD2Q++VZFJLpBRbrTcOzWEgmh63SvcI8DeTmMJ2E8gwKekL3XJUb+13n2
   KC0iuzL0K1gNmDJ65J9Vo/TffCzOfPtXeG/3YqEhDD7R5DwMWHearENbk
   A==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654531200"; 
   d="scan'208";a="209626875"
Received: from mail-mw2nam04lp2171.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.171])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2022 09:33:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8BCvt3GjpNKACp0lQs8umRoyPVJ7rfmONA1T7boIz2zDsrs/nHa2LksXgXN1OOsDf/GleP0JQ7mgkXY3PICn079kX0MTblxTQDRebyWRbmMjn1G+ERSBKWODrxsixumh1ufUfcU3LCs22Y2AZJlBE38Pdbnpp02BSf/zkNqfpG46f+xerZDQ0cNhXUKyLLpRlR17L0CkhpZPsZccf5k2iOlJOFG2gaM8OsPRhhzThr0LYgORKxgQJst0rlTGiIQ+xKPDidpEKn/+EWABhB8mpDXzi5nI53RvivcSMj8+VapEUa+T1NA/2Ee0HATh7SZjMAUmR5YBWeCT1WKSOO/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nPzsjYVrFERrdv1AccEiQZE4begA6HB9+4Y+xiFWQM=;
 b=bUkF5QdbKMyGfDAIkzTuZ9+ENRbjlYcZyRLDT1TnCETHjNGZzJkJmKmewkOhoNL4UT9SlUKg7g0VOY89ZvYDsjBMgtT4xmD6IN6iSafiAUGxMatve8d1z3qsyaCprlETOT+6S0X/CL+s3fj1aClUIn3H9cltFuVR8/6kuo/J3aM7YX43+e+6LVIIGmNV8roSy2q12KMBD8fpzpW3h+ldiF3H8XRq8WMJmvxjYKy1zYS5+0atvR5AD3CMG2eTW2Po/SHE69HnB5W5j5xP/8lGTQCnrzEj/vISbC3sjLQunqQvROwdAXKgH13jOZ/zLNEHxvY2EVFLsriiqMS5d5NtGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nPzsjYVrFERrdv1AccEiQZE4begA6HB9+4Y+xiFWQM=;
 b=VDbgfe+VwXfqc9jfEmLNDx25k2lljIUVDQpLtCNpOibGIo2snwFFyFy76vbcTS05/CCpZlS+Y36Yp6zCeMEQ6q8vtAqJTFuqLdBdS3wgPI2B983pTM5hubEKPQo17A4wl5IZf8zpEhwjnc59RZIY60ZNPa51AWFmZkLkZZ4s/bQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6970.namprd04.prod.outlook.com (2603:10b6:5:244::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.16; Fri, 19 Aug 2022 01:33:52 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633%6]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 01:33:50 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests v2 1/6] common/rc: avoid module load in
 _have_driver()
Thread-Topic: [PATCH blktests v2 1/6] common/rc: avoid module load in
 _have_driver()
Thread-Index: AQHYsqGKdTDTFcePOkyI6r1tmTk5ra21FYcAgABMMoCAAAf6AIAACH8A
Date:   Fri, 19 Aug 2022 01:33:49 +0000
Message-ID: <20220819013348.3cy6zjrtrd3hhjjs@shindev>
References: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
 <20220818012624.71544-2-shinichiro.kawasaki@wdc.com>
 <e17212c6-d7dc-514e-e51d-ac818863a80c@gmail.com>
 <20220819003451.jqkmwbzdyqhw2t47@shindev>
 <d810fd8e-6c49-1ef4-e84a-ee12f209d91b@acm.org>
In-Reply-To: <d810fd8e-6c49-1ef4-e84a-ee12f209d91b@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3e1d36a-3d3e-4ec9-780d-08da8182de4a
x-ms-traffictypediagnostic: DM6PR04MB6970:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJhqOQVElCoPLutf9g3TFSrLvhqDWVfSKyow5VQwaM0lQDUsUAMLs11X/epCTS0/ZPUNViWCDzj9mJpFyz4oy3tGvtBDZ+Bp9sJPcvgScJBOqIksopoWdmndFeJxBH5AXTRI8cbOnqnI6TL76PiKJTBUxRCjFANIav/vFEu3Yy+w3Hwb06l7WFD1ldA3WpGCSkyiFmJbqTM3wfl1/BtxbpF/Lai3XnsR3lf5qzl6d+yVCP3DLj9hNSutP+d8i8MR5ZHIA30k8CcHuRCwqB7DXCTLeUlGUPJjkC688VGB2ZpOxff//jId3mA4rSvwmC3mpL5SVihmJkHl8Wedp2Nxy6gpcRHUAOZtsBeOaLqFunTzJOGxQF78YrMU/oXVZAsAS8hWzP6AJXmotfzddm0a4zkah8XhODYgH6/9BlC4H5fpRrLGj5IWUMQlAZFp0Y2DJ4kgQXWYFhN7awilPnpFpKCa7FBp6i57RwMWneTrcGvXTS2p9fVBdEqLXcQLJ8UzdOrRiaGLPfJfxJZLbc00PK4WUfo1XoscffmzWAszMRA2ytisHigglAoJVO/GXKRlqQeQkhWGzh9BF4umBhf+rnPGq1BVsE0baE2rL71POrcJ5NRVE7Kce1LbiyQWrCpesDfin3eInJvXaMj/QbH5szjCNapHIvkd3rim3APHF5Ft1nehkW5TxP/dm3XRnkfOrY3M5bag5nZR3OO9SnudN77D6m7G1x7S9YI8ZlVRDFghdEAgjeV/80HdW0oBcElDEUVeSGrkGOn/6zqoh+sE0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(6506007)(38100700002)(53546011)(33716001)(122000001)(41300700001)(44832011)(6916009)(1076003)(186003)(2906002)(38070700005)(54906003)(66946007)(64756008)(66476007)(91956017)(5660300002)(4326008)(8936002)(8676002)(66556008)(86362001)(316002)(76116006)(83380400001)(26005)(6512007)(82960400001)(9686003)(71200400001)(66446008)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FGTbUBYNfGycx90nC2+Ke8QeLk6uCdQ5ziDZYn9OQeBlI7DldJsmgeMfYtgf?=
 =?us-ascii?Q?o1eooKmmI6XJyBMWiMYaRsihfXE+zlnuFgIJI/VMWYlcDqVIoc5h0VJirzVv?=
 =?us-ascii?Q?7h0CVRF/pYSxTZw9x4QVLcU4v72C46DEpqkoNUinxFHDgFkdjRXt1LaSTUVy?=
 =?us-ascii?Q?9fZURMPGXbgxCRCFesABzaTFXb+t7ZFn3tFgqWdKR+/udyBZfY3WJ5ZMwVj2?=
 =?us-ascii?Q?EW0NjuL4Fp3JfZhBd2HoD17m2PdDbFhS6FSSxUcmUiWfC59YJiqklb2Gv5kO?=
 =?us-ascii?Q?DSoA6Se0njkLfLIvDzGqrxIkd4ZGKGGaRaYZufqAM3A9Fsz2MQvRBJ6b3h6w?=
 =?us-ascii?Q?FCSW4BiTdac9t5ZAUvmVgdM1NAwD0UNuaFTr1isCeQ/VPDkWruAx2ae9shXt?=
 =?us-ascii?Q?rZiq8/xF6qvk+Z6QKm7yJyZMIBZlqdMv7ekZm3/2rSaDyak9OY3MB5YgHIcv?=
 =?us-ascii?Q?GqLGqEROBNfzi3pQMpwPOuVm5Y7g6q/bWoGkY92dZiK6VXa+qGcyLZ7ZqEwq?=
 =?us-ascii?Q?72TfiAL5ocyzhtoxN4De2NbdUxCgiaMoIrZ613SFPelQKjnrQBF8RQ/3hyys?=
 =?us-ascii?Q?7V+MouIbiBtRPbClfw9KYFpLSnMFCbm8gfVpVCqYXp9+88NdKywE3foG0CGo?=
 =?us-ascii?Q?8MQACMRPkjHK1mKl7Bwl9+bkfJAQh/DEK1vb976q7hY540YrKd6aGVeqxuP1?=
 =?us-ascii?Q?c3JlkOTDBLlazSweflQMU/KgjKC1Wt8RJ3YvwSqAAgKQzcjtCzyHpoqvpiTx?=
 =?us-ascii?Q?mKKVeOM+gx3qHUgYnqoA9Ej0fbi/wm/tST3LgX48jlNHzHIX14JiAAMNkorU?=
 =?us-ascii?Q?IMM1inMWiQ9yH0af3RqOHlUilO8SgV3LbPKhOGawkZKzlpt3qhBMEy3p+Ozm?=
 =?us-ascii?Q?mz82bM9B52PElJm8VMJuPsLFSwHSvsVEo3DFkU2tLNsdGkbPDEw8P9yApF5C?=
 =?us-ascii?Q?pY/QLqqoeLn1OB4NecQ/uZGoA5YmzdWx5a6px7wXT3j/y+c0M4y+nJ1XAANv?=
 =?us-ascii?Q?/yq9Gs7zvK6nqiflgJezOmaIaJqgSIMOZsghQTIJExyKMVjQ6YDn+X8yRpyb?=
 =?us-ascii?Q?+dT8mH3SmisyLVFv1aWsdWBFfHqVPpGnldTm84LbSCJgDP398yTokNqmv6yt?=
 =?us-ascii?Q?N8ta0UueyBZ6/cvgDL5qEh/i2MSKgfsDQiVJrI657Q8PdPZTwti646l6I91/?=
 =?us-ascii?Q?6iJ1eUXEXuQO2/0d3Tk2B+G4dKw9gbIQ0gpxN8TmEldtGqa1XvDE7tEMPrFK?=
 =?us-ascii?Q?bxkhZdAodhtfS4UAMqTR+vCpiOuVdR4kszg8dqGjfe1n7bR8YJjA+qQTCc/c?=
 =?us-ascii?Q?BQrp3bgaOYZ7B13t8wEaSUquMpIaF+HcrWLcpU7ntL0zxWQz7sMOz6sLJTFh?=
 =?us-ascii?Q?Kdz873ITXryNDc46tW4KKO+wm2FfavWN3Z6km173eNULs7+c4NvRDdym/IcL?=
 =?us-ascii?Q?96Km2YWYdXhbOm4J60eHLST5Dl0NKuUkoH3kGI50qtdy4J9IpmhbwRNmx5Co?=
 =?us-ascii?Q?LtxnQP7JTkNFeDV/u+X9IjzIbLwNVqrjTZDlxpaQFINQyLcmLh3eG8kMwYQM?=
 =?us-ascii?Q?cPFCqvMY8gLX9AZUE7AGDIXKJHFt945gV5oSj3C4NTQLlwpwFmIJAtagzREP?=
 =?us-ascii?Q?RzfAJ7QkS1pYM5HgX4nE5X8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CDD557E4EA83EC478A8A57D40BA64D80@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 942oNYR9MCREeuhV/ZFTRoglMtBSQfKOP9K+P0xF6PRUw66VehHjH5rrP5J3J1AXOJhu0VuDQlEc2GWOKvJ2N2L96rKQKyn0vEPdrkon9caNK874snvGWRbQV0qH55FYwidyoT333l1MmWLt97TNDV7mG72oBVumWagrx8L6+FlkVaI1SZZaaKqF+EB6f+u85BzANUUZIjZNVeUkoaA9fPs+4KEKV8OPvyxZZEh8UVND7gW+8jYcKBM+c7l0CccrKynfRGRa04kXaXOCEW3hxPdj1DnZLDg16qyGh4VziEOD6+Ytsrlp90OUfHXTsL+Ivlzz1PU2QrzFXIeQVn4lHbPuIxH5w4HBWu61Mg260p5oNYuIVdQsCF+LND3OKd7WzSOsppWciAWNvhQ2b3pJfd0c0+3io4t4fCeVIaWyQ4PMLa5yFSRdY1AQ+ckRufABPPRm7sNhPy9oXYIC/YXr3tI/UyyJSVCiOuHBqvrc1bGRtW5zTcE086ajUoEjrWbWZliRKiLAS22FLdPBnq5p82WK3YRARWCvC4OwENEgkUaMuUEzMlHCR3nyIXDrG+70PhT75WWqeRJP/ZiXWWo+W3NnTjWyI8fmUTHYvDa4m4NznQnOjfCeaDia9qLvQqibTUCI1OxpSB3+SfhOWvOAskuo4AVbEjAd9DoFnc3wlG2M5vz8RkVJLXm6wyRsC0X38siTvZk2IpDAEWJay9yGp/F8JPRenauX0e5beYgiWoqdojDZuRkVZKnHosv2hvuH47Y/DVWILjKFlpj5xTA8Oq3eKJ7nc7r3g/4eW8ddzC43UYmb7jcb2FqMg4VfIz76
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e1d36a-3d3e-4ec9-780d-08da8182de4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 01:33:50.1187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AcIAHDusxDR+FfzSeaT8OGgH+YtNkjz19IW3Ojt297agIluRwrfIKPggjHemGaEnPB95+Y6/+Aj655zZP7XrRtMw7Za0v8WkolQBS7B8otg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6970
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 18, 2022 / 18:03, Bart Van Assche wrote:
> On 8/18/22 17:34, Shinichiro Kawasaki wrote:
> > On Aug 18, 2022 / 13:02, Bart Van Assche wrote:
> > > On 8/17/22 18:26, Shin'ichiro Kawasaki wrote:
> > > > The helper function _have_driver() checks availability of the speci=
fied
> > > > driver, or module, regardless whether it is loadable or not. When t=
he
> > > > driver is loadable, it loads the module for checking, but does not
> > > > unload it. This makes following test cases fail.
> > > >=20
> > > > Such failure happens when nvmeof-mp test group is executed after nv=
me
> > > > test group with tcp transport. _have_driver() for tcp transport loa=
ds
> > > > nvmet and nvmet-tcp modules. nvmeof-mp test group tries to unload t=
he
> > > > nvmet module but it fails because of dependency to the nvmet-tcp mo=
dule.
> > > >=20
> > > > To avoid the failure, do not load module in _have_driver() using -n
> > > > dry run option of the modprobe command. While at it, fix a minor pr=
oblem
> > > > of modname '-' replacement. Currently, only the first '-' in modnam=
e is
> > > > replaced with '_'. Replace all '-'s.
> > > >=20
> > > > Fixes: e9645877fbf0 ("common: add a helper if a driver is available=
")
> > > > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > ---
> > > >    common/rc | 5 +++--
> > > >    1 file changed, 3 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/common/rc b/common/rc
> > > > index 01df6fa..8150fee 100644
> > > > --- a/common/rc
> > > > +++ b/common/rc
> > > > @@ -30,9 +30,10 @@ _have_root() {
> > > >    _have_driver()
> > > >    {
> > > > -	local modname=3D"${1/-/_}"
> > > > +	local modname=3D"${1//-/_}"
> > > > -	if [ ! -d "/sys/module/${modname}" ] && ! modprobe -q "${modname}=
"; then
> > > > +	if [[ ! -d "/sys/module/${modname}" ]] &&
> > > > +		   ! modprobe -qn "${modname}"; then
> > > >    		SKIP_REASONS+=3D("driver ${modname} is not available")
> > > >    		return 1
> > > >    	fi
> > >=20
> > > There are two (unrelated?) changes in this patch but only one change =
has
> > > been explained in the patch description :-(
> >=20
> > Hi Bart, thanks for the review. Regarding the local modname=3D"${1//-/_=
}" change,
> > I explained it at the very end of the patch description with one senten=
ce.
> > However, I admit that it was unclear and confusing. Will separate it to=
 another
> > patch in v3.
>=20
> Hi Shinichiro,
>=20
> In my comment I was referring to the other change :-)
>=20
> (changing [ ... ] into [[ ... ]]).

Ah, I see. Then I will modify this patch to keep the [ ... ] as is. And wil=
l
keep this patch single.

--=20
Shin'ichiro Kawasaki=
