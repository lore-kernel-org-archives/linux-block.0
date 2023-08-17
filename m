Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DD3EB64DD
	for <linux-block@archiver.kernel.org>; Thu, 17 Aug 2023 10:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350029AbjHQKum (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 06:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350075AbjHQKub (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 06:50:31 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34D030C1
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692269427; x=1723805427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tX/uoUh/TXEpxH582mATF+Y7QZx96s24dmsW5vx7zpo=;
  b=BUfD+pZPm9kVjy/CiEFT04XCGMh1/+B3i7WJ9sie9za8Jyp08Frm0EEX
   XU8d00nHVh01kjI3cyQ1JIL/je0YAXAD1hlrXIbs91MbdQEyYq2Q0Dsq0
   t5Hx0UItWK/EheFVAloTbqFSY2RdvpQm/CC2vvBzL1O4KHlh6QA2P30Dm
   POmhhQNy8tCYdP6p3gx+3uCe2bZTvFRxML5zYOYkkacZyG1CfuK6xHel+
   8XEQGIQAMkL8lnHxWRnPjd0TyacDD1y3zeSBy8HTnNXrG75Aqg+VqBbEw
   36eIz4HDF1lKSaptCCtLJkAJ7AryS7c6H6EhMUHLPcK5k8Gj090gy1eWV
   w==;
X-IronPort-AV: E=Sophos;i="6.01,179,1684771200"; 
   d="scan'208";a="245980548"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2023 18:50:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxJEqpLZ4zJcr9AoaM4z6Jrp88UQi1uFAiu6mWmKiI1rpv+/GOJgA5XAm01kl5mGP6LFozG9p7Ffhg+nlnuRBTg2Xd7y3l7Bq2BDnhtuYFU/cMpCGijWVh973jvO3Q1Vt8tnT188T8jYAHZF1oEE6n1dy54jliWNN2EI6FpLZDULDquqxVufu1OYUbetLHYtPazAUo6aWtvTAlIZMFlNkzwZxh0a8LmqXNhRbCv14c34z8fHWTZAN0YQigCnamUCpADQHhobAAg8poTY3tASpeXMq0/HDEjnVTv/FgcEimHDKdcuh4/3c6et2VXFs/ri5B/z/kDrQz6Tel4I7+bXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM/5hcg+NLIRypGXSh4SSCE0ibt5EiEf0zjSVO5EIC4=;
 b=eWaG/a5SpRhjCEF8TrW5l4QPmLL1xtn8JrflgxApzugOkHghIBpz4EebslD/C2LEuDlZVAt1aR2g4tPY9Fn6kppRfZ4kWAdpCn27FyUX6G3hacqvddbMmObwzHbwD/999xI9488vJ7u4cdddCHDaWxCYB1k/wrH8y4kPMrFWf0YkxBGcP1uOawMVTed8MD1HD1Hfn5m3sF3ID09L8jLzz7NmvbZoy9PNg/6XQdMotvJjsK7R24D0cZiNfxDkBcwsW3WFGeIfzE3d6y1puFWW8ayllyqCXtwDh0OC4L5awLczb7f4MqDxFgqg48pnTAuN0eKdlbKB/ASQ8lDE9ghPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sM/5hcg+NLIRypGXSh4SSCE0ibt5EiEf0zjSVO5EIC4=;
 b=eIcyR0ry3UymEH2nTkiVjr+qva5A0KAUA3bD3ssRHPZPb56WlHMyeh54iXTzYO5VjTrQf200xfrV19Oy8HIsyVYNWdIEXlLSgvLwr8gb/W//XHaO7/8zuc9n0oUO0oeNn5y905DtIrZG57WaqnVri3P2H6YEEQbqGtvy/o0nSLY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA3PR04MB8692.namprd04.prod.outlook.com (2603:10b6:806:2f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Thu, 17 Aug 2023 10:50:24 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 10:50:23 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2 1/2] nvme/rc: fix nvme device readiness check
 after _nvme_connect_subsys
Thread-Topic: [PATCH blktests v2 1/2] nvme/rc: fix nvme device readiness check
 after _nvme_connect_subsys
Thread-Index: AQHZ0Ny0P5ATiBbPDUSCwGuDWeUxK6/uKC6AgAAnVYA=
Date:   Thu, 17 Aug 2023 10:50:23 +0000
Message-ID: <ip36hurypoznip726vj2hxwedt7k7acezwu25f3icou4dvwngi@vod4n6pi4vbe>
References: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
 <85f074cd-d916-2baf-36bc-05a19384dcce@grimberg.me>
In-Reply-To: <85f074cd-d916-2baf-36bc-05a19384dcce@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA3PR04MB8692:EE_
x-ms-office365-filtering-correlation-id: 696ad62d-57e4-4db8-16f2-08db9f0fc26d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d12DvszuEIdNNDn8pJ33AbKbBqJrkMpNlNvm7mTq+2Zca5LDdXOfFOxKNBEfMvRwQCfbIUfGLIvw3yswBWNhukHHJ1aRwWIHAfZXYElh5IG6X28ZV37dqCaAm422368M8AEuz5WNHpENjaKf31xu3joTD8tmu4Aj8V2ptpr31fzXD7O6uD0lz2NY9GLzGcPv7TDHP3jKNca6B8Rcwmyyns7dNJAe68VNTmcIwovl9Y94nm+YWeptgZ/VupnTng37L3J6me21R55sCKbHW/zcfNRou2kEDNPjch1B5CEAo2YeUix2zTZyT1jl04McXJeTwTxx9kZ2pCNvSlbAXOKMkrPxxyxFu494V2i0xdZEeo5q4RTdAXXjF/JAOdTbw59mjyJf5/WaAl3P2fdc8eygEcfaAjs86eOEv/dyWBCYorB79nV4PEDwNCwaMGjEm/ivTjFh7fSHbUs0qkesbsXFIm4jl/94z0/h6e159JCQpH0ZyRmDnhog8WXINAkAt3ojAhU6uS4+iMMLgNq1qZoRT3mIgk9lE3jaCjTMfsX9xVBHttp/Das2Ln6HYmJa77KOHLiN3x4rlNtrblJdvQEHdEy7YKti7dOKfRl54KkzppOwCi6oprGcR8/s24wS3iLl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(346002)(136003)(376002)(1800799009)(451199024)(186009)(316002)(54906003)(66946007)(91956017)(66476007)(66556008)(64756008)(76116006)(6916009)(66446008)(122000001)(5660300002)(41300700001)(44832011)(38100700002)(38070700005)(4326008)(8936002)(8676002)(33716001)(82960400001)(26005)(2906002)(83380400001)(478600001)(86362001)(9686003)(53546011)(6512007)(6486002)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nu3uY/RD45UOWhXKcJjKm7SqGSmSINABMuHR+RK+I/Aq2VVix5IPcF/8iAIm?=
 =?us-ascii?Q?uXWAmlC1KheHn4rh3nLkNehWvELJrfhRGsSol0NWZ1Y41gsIm0q9EIZvBQeV?=
 =?us-ascii?Q?znX459q9YbVOBUfFpTLVgMuJrz482q1JTX5TRSPe0cR9BluKDloGs3OaDFIL?=
 =?us-ascii?Q?tAfJbuhRGhSS10lTipw3ApRCCtTp6zWdyf2atORZElki8lQOeDN2B6PjoGwo?=
 =?us-ascii?Q?YAQU1JJyU6DeBfNkN9PQzZzt59kDCz+fAegWi0qfgQhzx+CUmpdB5qRUu2zg?=
 =?us-ascii?Q?dH+LcpvJWz+v+ECx4UeVrdM/15jqjEZgCzvbplIIGPsNwHB0kO+7z/A6fTC2?=
 =?us-ascii?Q?8OME2D7jeqQb5U1dBvMB+cYin00PZLICKJ42avfxW4TGbetjFDQd8BxFPDFR?=
 =?us-ascii?Q?i948JPU7krEbuIPaM1J6U5X6mx3v64eYYDMbR7179vWaNg32/oEIHHKxOp92?=
 =?us-ascii?Q?BTMa7QZnMROgyn9X4q1nb9yHd5OXXmatPhdpj4hIsN6y0STmtdsFvrJrXH1x?=
 =?us-ascii?Q?jcqHTOAsl9WJOI8J8P6jUAqYI+6XpP8KAjCsKinBFFIO9JSthy+uCq85aP7B?=
 =?us-ascii?Q?e3V39QTkgR4BSrKrfi5LNjduGnfAG8JsGI3O8lgInQi011V8fp5siCcfoEhC?=
 =?us-ascii?Q?JAtxoylZWDmOeqFcrXnyLV5XfCXjNUAgvqqksqgY7+Uxcz8Sozg62+7X+yMH?=
 =?us-ascii?Q?Xdbi1uxWyZloXKrT2Es0aTZkB19t+9sTL6g89zUXkp11e/D90dnznnRKSQMg?=
 =?us-ascii?Q?UfBgbvRw8vPYJEq3Iq3MyWql5HU6RIos0dUU0/ioALibws/BnLjTCXiSdiQW?=
 =?us-ascii?Q?euaqOWkFbEoWUH6zfQsznmAfnpoSldJQaaadKEy/0fy/xaJ2axy3B4s2zsp5?=
 =?us-ascii?Q?uNTbUAdTrqgq1eY92sIZ9aswdz+IhS6C82oeKdhHHk6KXafticosKcdGQK6V?=
 =?us-ascii?Q?+1z2fh1bDj8jj0SH5W708kmAAqY65v63x/1wlP8o4zQoxsTyxoISoTLHdL1n?=
 =?us-ascii?Q?VPC+1lApPsBHjzErvhLcIb8oYrPzLRZtMVOi+bL7YfTY9HfrRN5eaipYbd65?=
 =?us-ascii?Q?ZrZOWbJg4rtO4lDx6gG9S6GtaWQ6c+Qi3L1OYsTvYGqjoRw1gKZqGdma7M7J?=
 =?us-ascii?Q?0ZtEDExSgDXQ63GsTyNM2OyLBb1wCfc+d5k85vPML2yAK733eXhMNLm1kJfr?=
 =?us-ascii?Q?vcitYP5QYm3Ae2fPn+9jKbo06NcENVWQiL4VnESADfQknxudCgtnZSjZSjDe?=
 =?us-ascii?Q?sSK1G7a41zpDcjH16CMG2AsETQD7enOdDSGPJkvIxcKsKgNyXADvehnH1cmg?=
 =?us-ascii?Q?JNRqs5kpPhQdWdC3yYiFDfN6b0ewzJtu6M+algBFlgLkFrohdleAblTdyAXu?=
 =?us-ascii?Q?EIbmQmolD+WCxjQh+UgQXz3hESxUfKKEH+DXGWh/wu8pPlRksU4IDaFjU3P/?=
 =?us-ascii?Q?1vjoPZguxiKC+5zjl/mVkcsPjSJsliZPdVBaGF3zE5jXovwvlpcEod6T5cy1?=
 =?us-ascii?Q?k+WgAslo0yZXsgHSPs2aFTyQ/pxjUfekm4bkdRELB+wM1TDfiANV0txkyq/8?=
 =?us-ascii?Q?sZsSePqNNqXfLFWnsWgapk7heBWcurS+ZFhJBwb0g2UrKeHl/yk415tszSeS?=
 =?us-ascii?Q?gnT+8nTftRxonm6PXBYFBew=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F2742376565B74C8114E1A68DD11E9B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?s0NGQ8TOBmwn/GofM16TwaRpL3qWsZpcmjxqlyDY2loZYdcSlsyL0u/qtbhd?=
 =?us-ascii?Q?uIJW+/4eRfK22nWBtcvOu3rix03hMpRSWesWXAzkb41HiByzidIr6b6DzoO2?=
 =?us-ascii?Q?dl/OIefwK8HyEM2dIjqqvsBRa34od8aNDt3yelTf119tXD0Rv5nK4zW/rxjh?=
 =?us-ascii?Q?NaQjyd1qqeVwmKmaYK+dlLuAIb28Z4b8zGKDFqZAPEHRpDPKnSV5K6iIUM2C?=
 =?us-ascii?Q?okiBeCjJj0IcN9I78f1sPEju2+cvrKtw8m8Y/br6xZWR1Q+4y1/KSncZw2Pn?=
 =?us-ascii?Q?e3CAm9I9KvR7+vWC0inncWOqha6yiBFktoYf8RH1ZefkesED4WWh28cOKQCi?=
 =?us-ascii?Q?NPkNYEdqj3mYRnOetaSt7QSu6hn8CZet3yiXjwAzff0xAFxGvgBM3P/SiLZw?=
 =?us-ascii?Q?xwQSGBkX3jKtksd9n5Dtc19cvqG0s2WKO83+3FQkIBGBG/32aFvq4cTbfO5N?=
 =?us-ascii?Q?gw2kGxMzv9evKbPjj18uy72tgx80A8qBSb6R7iSwYM2KExnWA315CCEHyEZy?=
 =?us-ascii?Q?1H2T28mfegXtbGPzax9hnMLGNhk5xLt8OImK1kNtzXCy3+m0B0Mr0Yi+RywO?=
 =?us-ascii?Q?aMec0DOv1euzQd9EeBl1l2jX23b+K4CvoGhN3FzE/pkCGkC4xlyksh14g6by?=
 =?us-ascii?Q?+QHplmtXNFghBV9KvwP/fBsDpsXUBm+wXU7nUS13BCdCFb/mKH6C0OrdFf00?=
 =?us-ascii?Q?IWuPwM9lehqCgFwwooeRq3G4Xm21mYEFMSIPHhws2TqKP4fp7Axu1LqsJZNZ?=
 =?us-ascii?Q?NTcZy07v1EhHC5sGoH0rAJHliHMQ5aOsCwCleQ/SQL+cNk95WQ7A6bQZuMm7?=
 =?us-ascii?Q?rewB/Vs5GlDmI50n3a1DdZhHk/kjPgejbjNHpRKHMRt0kTJlkHFPuvi0fj1S?=
 =?us-ascii?Q?B/oP6k6aETfiXM+eViPWAP9HPMCrUkXDog7F4GhvF7OazkzK6cpfmzAJIuHt?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696ad62d-57e4-4db8-16f2-08db9f0fc26d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 10:50:23.7756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qoWAj7Lek5asRH6meo6uD6volNiE/o0Tmhi//BCi2VUQsRdCA/CTN3UMDLTbQKZGNJbHB1awe4/awLMOoeEoXbki0OJeSN4BetT5tXmeJJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8692
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 17, 2023 / 11:29, Sagi Grimberg wrote:
> On 8/17/23 10:30, Shin'ichiro Kawasaki wrote:
[...]
> > diff --git a/tests/nvme/rc b/tests/nvme/rc
> > index 0b964e9..797483e 100644
> > --- a/tests/nvme/rc
> > +++ b/tests/nvme/rc
> > @@ -428,6 +428,8 @@ _nvme_connect_subsys() {
> >   	local keep_alive_tmo=3D""
> >   	local reconnect_delay=3D""
> >   	local ctrl_loss_tmo=3D""
> > +	local wait_for=3D"ns"
> > +	local dev i
> >   	while [[ $# -gt 0 ]]; do
> >   		case $1 in
> > @@ -483,6 +485,10 @@ _nvme_connect_subsys() {
> >   				ctrl_loss_tmo=3D"$2"
> >   				shift 2
> >   				;;
> > +			--wait-for)
> > +				wait_for=3D"$2"
> > +				shift 2
> > +				;;
>=20
> I think that it would make better since to reverse the polarity
> here.
>=20
> connect always wait, and tests that actually want to
> do some fast stress will choose --nowait.

Agreed. Will reflect in v3.

>=20
> >   			*)
> >   				positional_args+=3D("$1")
> >   				shift
> > @@ -532,6 +538,21 @@ _nvme_connect_subsys() {
> >   	fi
> >   	nvme connect "${ARGS[@]}" 2> /dev/null
> > +
> > +	# Wait until device file and uuid/wwid sysfs attributes get ready for
> > +	# namespace 1.
> > +	if [[ ${wait_for} =3D=3D ns ]]; then
> > +		udevadm settle
> > +		dev=3D$(_find_nvme_dev "$subsysnqn")
> > +		for ((i =3D 0; i < 10; i++)); do
> > +			if [[ -b /dev/${dev}n1 &&
> > +				      -e /sys/block/${dev}n1/uuid &&
> > +				      -e /sys/block/${dev}n1/wwid ]]; then
> > +				return
>=20
> What happens if the subsystem does not have any namespaces?
> Or what about other namesapces?
>=20
> Won't it make more sense to inspect the subsys for
> expected ns and wait for all?

I think such check is possible. I assume that we can refer
/sys/kernel/config/nvmet/subsystems/namespaces to get the expected ns and c=
heck
them all. Will cook something for v3.=
