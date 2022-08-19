Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950E1C00140
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 00:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiHSAe5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Aug 2022 20:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbiHSAe4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Aug 2022 20:34:56 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45059D7407
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 17:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660869294; x=1692405294;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cuO2lmjb/XJZprGclH+sXp9YOn0Fucx3Lo8iBJS//9Q=;
  b=Dah5SzN3RgZSKpiV6wXtOMocDjD/zFfapQCRkr2c3grulljQWLvnlGfZ
   +wZdGBv4Rv4rfoeRSWcWoyIYicO+coRkxXFyhovMrO0GmyQCTCmXKfWTm
   4sFYomGaJJmH4HsOtpXy9HtQkRbb++Vj7DTI7l5C3DvJHPzGDbEVSkDJ4
   AkG7cucCAGA2+QgaKFwlgNvbIesafghE2cZTZSbTDcoX4muKwgodpHztT
   DVwy08yJHCyyN9q9XPRkiTR58RZaIzYE3KZXV/K5TvtnRBRna1RRndyFv
   wtjHEwDRD4wj/SshJLYF9k0XGHVpZ6VMBg1jXsKEmvk6dCSBJe7P6w/jH
   w==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654531200"; 
   d="scan'208";a="214214263"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2022 08:34:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMpk6QVJ/wJGHIi0K2SrTTamBVS71pRtBcuBV6BVt0GmgqF/e28Fg7muw97Q9lqLpZRGMpfom3ryfqEzbt+v5bZ9tWbiQVQ+RQ5aqsyp3DFIDbG7sFbXjBgj7ifTVSSBO8kTR/6F14cvRxVY+LvABEMzGxYdFMk8q7kYU0kBXjYLJVyqOEFGpI53+kG0NtVv1vYLt3bDnSaaBhgkXwZtnt/Q1eq4JrADIyzJnNO3H84xNp/wAFkAxisXL0oLny5KugZgbhbL6nUT8+rcwlDoia6/A96IsjZEf5cilQQs/rlTk+3A+oO4PqhwaXCPQ9Fu1DKMPEEru6eI1Fy18V3GJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8SvAxFRmjTOKyJDSfZ9oRpnNRV6TnG/pqa/mBM6i24=;
 b=G3YoUmLHFkFQisqUkTu95LT5DJ+hI2AC2f9dCYNGCFqGQ1Wc0N0eHdFzXZKsZ+ZHFHrHjd99uJvTwP6N4j2Do+y7T1gwFGbxOt7Egee9TMXRHjCin6EKBHlddkUTy/RA3is7XP0k16GtsJomJhrr2VtXAofFVyN4M1mlGFp6xghKJOf/I6H4tUd5cvulEjmyO8heAIL5D+qtCy5VwOij4xvInUjMOTQ/Jgw3aPBP3OpIPBjllA8+z0YEr7gM6O75UntEhJv7VwiA7gggOqtpsJ7/nFGaM9fA6Mm51MyDDzAdJNIAz6keWPDeApeWuNhqcYVwns3LKCfq1fN6pw3Q9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8SvAxFRmjTOKyJDSfZ9oRpnNRV6TnG/pqa/mBM6i24=;
 b=v1pW4hcvUMuBsqb5POAeL9iMSFaFCXCjApHQ6OYQ7XoMP2iG4QbhigWi4bAVPK8JfJ1A8Auj4AlAcLLzNgYz2qwhWIABq/Kl32D+3kFBYs31lXNgxmXtTM3Ze1Ri7DrM70fIJ5+oBtD6L/r25xW5qkO0EZE3Q8X5XGpQQE3MyQs=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by DM5PR04MB0508.namprd04.prod.outlook.com (2603:10b6:3:a9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Fri, 19 Aug 2022 00:34:52 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::55c6:d630:64fd:5896]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::55c6:d630:64fd:5896%5]) with mapi id 15.20.5525.011; Fri, 19 Aug 2022
 00:34:52 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bart.vanassche@gmail.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests v2 1/6] common/rc: avoid module load in
 _have_driver()
Thread-Topic: [PATCH blktests v2 1/6] common/rc: avoid module load in
 _have_driver()
Thread-Index: AQHYsqGKdTDTFcePOkyI6r1tmTk5ra21FYcAgABMMoA=
Date:   Fri, 19 Aug 2022 00:34:52 +0000
Message-ID: <20220819003451.jqkmwbzdyqhw2t47@shindev>
References: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
 <20220818012624.71544-2-shinichiro.kawasaki@wdc.com>
 <e17212c6-d7dc-514e-e51d-ac818863a80c@gmail.com>
In-Reply-To: <e17212c6-d7dc-514e-e51d-ac818863a80c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b475193-29ea-4cf9-dd62-08da817aa1cd
x-ms-traffictypediagnostic: DM5PR04MB0508:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mWT/7j8gGH7gFZSvstbVQ6m7Yc7K9nkdXFdvA0VAtz3VtW+3eEamUJ3BIY/pq/f6DRLSInbhgSG8rdzMldkJpTjOQTHmxeTfWxHIkwh0j9ALvjDA/YxGt8BI8Rvet0tcqDkIyeTFgKWnR7f8Go+GKGDUJUP3Nt64LNHmoA1UTqKXr7QGk5oT+8NeQe6JtHbSLnBiv/E7jzWnmmtQRTMjZ2wYk36dA5rulvEpwn32d5zBrWQm/xJd5z2nYXBR754SyiyKrRFP3u3PhpWctsnG+Bb2LgrPYsDzX2svfKoeUdrvKCo1w/yd2KGjqd90Lx2BYxgtOQMMq2F+uKAmg2AHyLfhrJOWHqJtldJkvVu/jI4k7tXsD91aHH6u+3BCNHsXBUv38BJf794y/fDXciC/ego+Yve57St+WjRXA/sMDscDQco2KPI7tm7+HAs62vdjcAtTvJ/9VFb+LQjArcVCkqwGkHCeO9EEFjHP3L9RXYd+oS+cOgAgQ0YAFwQSiTH1NHR/pe3ZFh9J3p+CBiT07/S5jXhGEsYPrQOctxEZm/apsjS4H8vRCvZuQbsvs2jpO4XRespEuwrZC8C21WyPvvyFVFAlaEONxba5j8zDJad3TNWs+4qGspZUqwlo4qzD2vR5dMZ8n5eImzydY0ff2ymKunX/V+N1YvWkWZAMjroE1r6/P7WhVRaZ7gVzV6WrKEIN0vz8Qnk95+TIQiGn4zoJ5/yRdyfXBjJI7h5RhYO5Y2pgflb9Wlc1iRc5TK9e/sLyqikXBcvD/12RpAlk8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(136003)(376002)(366004)(346002)(396003)(44832011)(4326008)(1076003)(66946007)(66476007)(8676002)(66556008)(9686003)(66446008)(76116006)(64756008)(91956017)(2906002)(82960400001)(26005)(186003)(41300700001)(33716001)(6512007)(316002)(86362001)(71200400001)(6916009)(83380400001)(38100700002)(54906003)(38070700005)(122000001)(5660300002)(6506007)(53546011)(6486002)(8936002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0/iz76o4L2wSPRcnuDzzrYiOYmwjTKOPi6E5ZrDiSxolW5Wagkf4SZUFMfHd?=
 =?us-ascii?Q?g59YnXIOimQl5illTEoto3jvzknbxEIjnvDrXenMSLtEL1v054H76xg2mfdq?=
 =?us-ascii?Q?7Tblssr9ydFAP/bgsgKZ0aZ8Y6j8yGr3xerdP5QwhKlhYNuyCXHwkz1FikmJ?=
 =?us-ascii?Q?APXNoVHL1rBfn/LC8RProIgFb7vl7MO47tvmaqu7Obv/awmu40tiqm6vHoKG?=
 =?us-ascii?Q?tqcGy5ch7giZIZ9XffGxqc12AuyJQk9DOiRfFo6AeJxLRbayDGyxbRL32r9P?=
 =?us-ascii?Q?iOMJBc9Qsd8HhtbQCivoPV+dftRaouxy8yPT3+af2reHJHe2WDkfSqA8pi7O?=
 =?us-ascii?Q?Si6oNxvFCRoemeguVoxB8tIxuX8K3qF7Q4UoYPWdkMnyEk4llQXl7DJyWa95?=
 =?us-ascii?Q?YzjGWKqzeQfaHj2Kd9Xb7eP7hfXFkuQL9c26jR4MSrfqGmQez/Cwj14AVCVe?=
 =?us-ascii?Q?ymFjGr2Z4iLJaDC4rWrrWIp14/8NX7xwwDW1O8lpbVu7f+3yPIlZ7DMhb2vO?=
 =?us-ascii?Q?VnVy+7dLzQMYYY1pORQurJ3EUO0QbeoYM+q+pNnwrpBqT81xohCm8JptR9j5?=
 =?us-ascii?Q?7Eal1dqQWAck0zIl5BONuqh3OGcP2oCfUTY+myTeQ0ZDsEjgIzIiUjyIu+SV?=
 =?us-ascii?Q?GzVfGARznCGrZ84LEZpjF6U9EOkzo9NgdcFqvzAtcaULCF82sYzGTITuos92?=
 =?us-ascii?Q?tuQ869BKjPjBmwvA8JSekhd3rcXzJW4q1MH6ajWEWRtzYMLrfB5NXupijo10?=
 =?us-ascii?Q?x3guvHP0n7ZR5Rkl8HerXDHNbiVIdjbEF849SNrTRC7Z48helS+Q6UnZzgK2?=
 =?us-ascii?Q?TsztPZb3rD02B8p246J27x/kR25dc88umIlePxdNTIQvGOUlI+TsDQUkFRdw?=
 =?us-ascii?Q?nRwntWj+5OhqaVPm47P8NpQRunmDJYmtI4dbo2mgRSucjI4esweNL9Z7oYp+?=
 =?us-ascii?Q?vEK+tQAfhEkuDkETHI6q/NyzNpLz2/mAZ1O0JSe00lGyPDcqwFR6wwRXEuEy?=
 =?us-ascii?Q?mTg1hBV6cWqAv1HiAOIv7NaANFcqq+jmgI+Lkm+4L48+TeCdWl/DEh3EE/7p?=
 =?us-ascii?Q?LqrH/WeL8JC+k5IrF+feAr/P74eop+h6TMTHF14K/cuBynN5HTdCcyR3UaSp?=
 =?us-ascii?Q?diYkg4S13PUkRnt2hOSppwRVrY2wYsnB7dy6QCqLcf8C0e4+kqb/50fTohzA?=
 =?us-ascii?Q?TLqCmltONxALBXxr98Buqu3XURYdo8Lgn++aokK/s0gTUk5sBdohKFa8PPpJ?=
 =?us-ascii?Q?IYTGvop4WOvIsDnA+vghIURnMTeYb8EJvEqukucxxUeNWsbYb5AZBmtn0dde?=
 =?us-ascii?Q?r0sfKOUsc3Oie3Ca6U5iColdfiAMN3po21Tltnmcj12ufIvipfFZ7+cPLoVo?=
 =?us-ascii?Q?Ly4KyXt4as5HNBf0FBTdLk+F6LbdOz2M/J8fcI3eaBHy2Q2M6m6PFIb4Hi50?=
 =?us-ascii?Q?G2zyHemzmpMjZoI2s6OpPtR417S4sfM2p4sZGBdNjP+g87sPawERflykPNrS?=
 =?us-ascii?Q?iKHxwS6Ky18o9gCq2DvkraeM3ltIJYJ9zpus5WCu43Ybh6Y/T9LmpiXwvfge?=
 =?us-ascii?Q?OAokdweaH1ScGRzXz+l7iIIsPWIR9JsL7Bqkq2pNQGHbXrmE8x4mtbNebdfX?=
 =?us-ascii?Q?ZKyfnl+4e6NgbvSP2QOYUP0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C18654B3BB4BF4EB26996BD7E79454D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jSfZTiMQSdpI3X7lRUv0iRd6sFoQXrBF6GK+kHfb7mYwDEouLKKKc4HNNxgU0mebbBXmKXUbz8cCCprE57tTubjHrVgKntOtlEwF+6bUb1SCbANcv9Dkbc/N3k/w+W6e2Wo5fUiQ68FD7mCVxrVc3ozCWf5/A10pB+7Q8qfjimcHUjvy2wbIs1f1GhRv9wZm60uE6F5UVs8G6Nv2OPSMA6WAOARKVYvevjA0AWdY+P9A39dbwFnETuBNEboChuFJYQ8IeGF7d8/plvzoolsqcsJ22PMq+JAHr/Yu6B/nAREymDAY5+qf6lGQHcc7nikRE8U9OdO1njRYXfN9wOS8T4SnqHZvHxxab9We8JjG0ok8ohTuGOb/YoWyzQ4nlFosHdJHPrPbGuOjp+poBM7fbKdwqGjfA1MpIwnP+QhFca2wn4ti3sHBtSgQpUj7BsLKTltLWBDuBBLaoa9GdugXRt+JMJqDFykvVaZgOmzcuuowMyIeVkJeAoykxyjwgXgUuKCHGjbMNo4MGER9YcqtfaOs6WgTRpXeWOnMqgKua9NAhMIHzEc5X4AudfzXSWWGfDjIZmQ7DzYLlqpTXkW5L9/pMqgfl8s3kAHhLmhIlYORMhtSp0THWG3U/u42c+P8y+le9pTtB5Zl4f9wyJOfALZEPABdS2z4uFfdEuAtyZ/Cz1elVyBgy0qeVxfDbUHt/hj4i60ChroJ1nqVyvIHWaIVqspmOXL1OlR/ijaoparTE2ZujyWDIEodC645lY/cu6KDmwiIUG5S+/hGtui/rJd4cW+6lfJ/eKTM+V3j8cV2HEjOT7eNWeUt6TcfiHUd0dpxdq4iJJgJhL4yyw0k1w==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b475193-29ea-4cf9-dd62-08da817aa1cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 00:34:52.6650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDtTTZBAhmpbrzSXzjl95o90HRfcwXimWs/3WKQvRKVzHtOno7FCT9IcAhc7ljHON6UTWdCbQRklYvUjKZhhg6mozeaWokwGeMkzD426P6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0508
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 18, 2022 / 13:02, Bart Van Assche wrote:
> On 8/17/22 18:26, Shin'ichiro Kawasaki wrote:
> > The helper function _have_driver() checks availability of the specified
> > driver, or module, regardless whether it is loadable or not. When the
> > driver is loadable, it loads the module for checking, but does not
> > unload it. This makes following test cases fail.
> >=20
> > Such failure happens when nvmeof-mp test group is executed after nvme
> > test group with tcp transport. _have_driver() for tcp transport loads
> > nvmet and nvmet-tcp modules. nvmeof-mp test group tries to unload the
> > nvmet module but it fails because of dependency to the nvmet-tcp module=
.
> >=20
> > To avoid the failure, do not load module in _have_driver() using -n
> > dry run option of the modprobe command. While at it, fix a minor proble=
m
> > of modname '-' replacement. Currently, only the first '-' in modname is
> > replaced with '_'. Replace all '-'s.
> >=20
> > Fixes: e9645877fbf0 ("common: add a helper if a driver is available")
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >   common/rc | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/common/rc b/common/rc
> > index 01df6fa..8150fee 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -30,9 +30,10 @@ _have_root() {
> >   _have_driver()
> >   {
> > -	local modname=3D"${1/-/_}"
> > +	local modname=3D"${1//-/_}"
> > -	if [ ! -d "/sys/module/${modname}" ] && ! modprobe -q "${modname}"; t=
hen
> > +	if [[ ! -d "/sys/module/${modname}" ]] &&
> > +		   ! modprobe -qn "${modname}"; then
> >   		SKIP_REASONS+=3D("driver ${modname} is not available")
> >   		return 1
> >   	fi
>=20
> There are two (unrelated?) changes in this patch but only one change has
> been explained in the patch description :-(

Hi Bart, thanks for the review. Regarding the local modname=3D"${1//-/_}" c=
hange,
I explained it at the very end of the patch description with one sentence.
However, I admit that it was unclear and confusing. Will separate it to ano=
ther
patch in v3.

--=20
Shin'ichiro Kawasaki=
