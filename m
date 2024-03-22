Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4531BC3B
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099062; cv=fail; b=lMANqZ1hK2gw9HASWMIkS4tfst+sV2XCpBw1NNEjagZiI0yaf8CI4inb1CpN1zf0TIz/lpMd7Qu1/mZBqZH2pX3aZd6hM23lllGLLX8zTkyzvUFNVL2B9XcH7KsSJS/daaettQC5rNfZERgbvarfh9jzUXBFG1x0HMuetJkLt0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099062; c=relaxed/simple;
	bh=efehfLIOwMT7zSLvX2ey+tINM3ccm6bu3ld4xly+ZQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RH6b0SwY1k5p6UoApEIeUCBfP415DoqIHZ30ASj9aIBKnmgVBdFfigeGnBabgcYQ58cM5eS7UNRYkWmgK+QUlCRzVIvxiAXz5v/DYc3DUAHff8ceUqWCw2qQvUEsK1OCWP8Z5FZwR/cfI7C+jMlREUAzQcM3pFqDTARGHSQh6Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=I2WBwT5S; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=yle8LXUH; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I2WBwT5S";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yle8LXUH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711099060; x=1742635060;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=efehfLIOwMT7zSLvX2ey+tINM3ccm6bu3ld4xly+ZQY=;
  b=I2WBwT5SRDoXy96yH+ZMp//6yf4+4rztxDbrA7HJi+yyAIAVtqmsmcTq
   cUipkdvA5OHYSlvVpRqE8DDsLu7t215585cnNIBeiSH3ghAvyjlhLw44p
   ym79169ftpW3mbBgqqRk48rbZmwWFH+uVzZ2kvb9B6cFfjyNxRBOdD3YS
   uNGhSiv29TSZWLG7vbqz3AdEy14XYx7Gwb2JIrLptTIdpovK2psHMvdiC
   lmMObElpG2pqmEkmnU3fuLkj20GwolxtPGqaEdQ1cpCPh0UEsOontKZ+H
   +Ljo9o919aftTzSaxqVErf9NcDm0UTaKfw2jXu6qk9Z1Iy2Es+vR2cA7w
   g==;
X-CSE-ConnectionGUID: Of97+/8aQtWCqJnOAl0A/g==
X-CSE-MsgGUID: VlPBlYr4R0qh083GrnkB+w==
X-IronPort-AV: E=Sophos;i="6.07,145,1708358400"; 
   d="scan'208";a="12233064"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2024 17:17:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9Oqn6gGuOjdHZJyh1bLQEhyy/kuI6MSZQGyurQcZav1kYweKu7mlsqr/huLd6qBxLMvK32jSYrU8+DOSDS5dZs+j9yvyG0CIpyzYE1rzq8mCQ7JhgBBWvAnjHewb/c9txJFkWatafOjfBUU74oX9jjfZ6rsW2OwFBGC1pg2bjGguERIH97NyIDECshHCjMOxLtZXw908BsBWPcYZhtBQgQwmJ9M28uy2UE7EV9cW5HnBdbGxezJ6ScA03+lic0M8xPJTQSsBYffaWvEqik5hjhCCgCrC27y4mlOCGNqI7p5p7zfjcczv6S93dPWK/Tm55e6GU3Mh33sS0l0vL+ReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1U1bBUon8EhrepsITDlsrTVmv9cK0YxAJ8Bxizh8P0=;
 b=OCpbDPg8MwF4ceMtaIrOLyz731CJcu1HsVnOcASbGBqFH7VA5adm5T4KvUTaBLVjXy7XC28lhwJonDJD+ZchoY+plus21zrhh88NTLX6edqEzTBUqe4NTjRaGCM/mk7QRRGxoPQZFUsEhjZ3CvXr5sm2a2y+3Xkn2Wl9AyLEnbW3HUCw5kZeFVaLn9SoSNR90sv/uY1ki1KkwE9ZWrRznUUY4wA3MeAn8vdK1o6QCjIgFG479th1CN1RSiG529tdVKVZg+p7ZjZm9nPW0HW3Aq4fiMjzcqG6GE+ZsYZxsXpqPfOxye3sYY/uWyPuG9n+wtxznhMd6c1QXj6G4MQGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1U1bBUon8EhrepsITDlsrTVmv9cK0YxAJ8Bxizh8P0=;
 b=yle8LXUHBq2pHpu+xLKlZED4CLqRdDLs6qbAXOHzUO5maOEGK7SQgZ2UvBRY4Eegm2cq4d3poNuxDfSCvPaqwooZZDaIvUmRjiXs7J79l+GQJytpJ7y4WUa8XMm3vgjMdvSNrUIHLsgM3unY2kiMvcWXNKFvsY7ETUoH8u7TIm4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7827.namprd04.prod.outlook.com (2603:10b6:303:139::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 09:17:36 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%2]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 09:17:36 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 09/18] nvme/rc: add nqn/uuid args to target
 setup/cleanup helper
Thread-Topic: [PATCH blktests v1 09/18] nvme/rc: add nqn/uuid args to target
 setup/cleanup helper
Thread-Index: AQHae3TVxI+xjUzJv0exxlg1bBvjh7FDfKOA
Date: Fri, 22 Mar 2024 09:17:36 +0000
Message-ID: <sar2qgskalpp6p6do5iwm42ewbdctjwsmznqgy3a6jspvz6u4p@uyv5hyqv7l2g>
References: <20240321094727.6503-1-dwagner@suse.de>
 <20240321094727.6503-10-dwagner@suse.de>
In-Reply-To: <20240321094727.6503-10-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7827:EE_
x-ms-office365-filtering-correlation-id: 2dc0d218-82f5-45e7-0ce1-08dc4a50e9e2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lGrcI7rhbenKniHyJwtx2TiURZ5iPgEcRMjkW8FMe2TZ0DfF+QbIauy+MhYdT0iGQNOI8jdkPlCrDAvXE6gGJAcH1PNfAGuzIUXa+s95HY/bTEcREiTpghjBozRFqS7vNqUFURgiSE6z6mbOevYUJUtCG2TrrO+Lu1g6caT2wXhorcYCB6Zd/ysA9e0DhLl9MhaSL/eB7NFEaMZCGJqE9gm7a491il2GWEVhF9k659Tjysw3PoKrDBgGqHgi1VQ6wDiOpwq6luWWahEnPCT5CeVGdHs6ecYJfHMyVsGaaAqFS9EfNp5/HKyA/OjasHboeABBJcwKwpm4ZARhmBYny4ovhvnM373KoTG3xt/QBW84XTE4DD+lsR02gKfGW9eGmw0724d1aeBOIiiBL7ax9OCWS1Q/tdfw+YxZOcAcnAR1SXa0iozT8qqV0UaJBJ/yt1LriyByUg8fR3AolFUzgfhO7wxSGz1WxXqTAD0tS5dq3cnqF27AAG2JtVulMw+IsAxgSxWUIZNVlWT72NCLO7MoBk4ikyw0minRqkFzTB0IuLqoJkhh+4gkbufW30s1nMP3N5iGZbTS8YM3/Y3iXgmm9FVSy/bskPNwAXkIJ7c5KynRzVHWEiVZRug3cmLVgH2zqGDkAyqd4BXU93CleksALS7Zcfug5ezDHFbCnsHu/skxbtaLmEPHqFgFHZ7ejqBNekG4unVN/Zp5vcAVreuZAZbh0vyEQ2oJWZHeM5I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RXbIIJl+oYcuPSZJCNvDQ5ZL88gIk+rm4Mfs+bWKe9Oe95sZSQGz24jbLOXT?=
 =?us-ascii?Q?nWKnAFbPEICdSpF1Yln4OkvGbZTaeboAXFvVqWAx/dzeoc6ta3Rr2jzPZmAm?=
 =?us-ascii?Q?uuELBy6tMgNwjoQy0aH8r/6cxkzjJ7G7/C42LlY3H6VcLMxPJCYeCuUXBVp3?=
 =?us-ascii?Q?ctvAf1eLnizk6llkkBNLxTfqrq7r7ZaABTlDKoWiJjjdhvm7YGBiKYZpSJGo?=
 =?us-ascii?Q?Nkl+7XFo2DxQmQz3E+6Cid405/deTW0fn3BKrPEpeVr7runWT4MO2BQ/bkDi?=
 =?us-ascii?Q?zfW8vk6sHzBLhzSQZS31NzqXDEWL3CuiNedDor76L4MKowueUiM4vZLIASzN?=
 =?us-ascii?Q?f62fUCx83zdqjU5jtuogmZ085CPQcxYCS/Jpet22kX8bt6OqzmURikCX4C7Z?=
 =?us-ascii?Q?c20291XTn1OnKtlQp1Ks3cGKY9ULjHgsawWJpUJ/RB5kZB86UW389WdNlTFk?=
 =?us-ascii?Q?zKXDfeNYCq9sscfL6TjV5865YcQgKgoCOrVNsFD8dAtf6GQiDetiAID+1ebc?=
 =?us-ascii?Q?M8XhYt1BbNll96oy7WG6RkjZ+atPfHW2P2CErEhm7UMwXb26KpPRigz9579Y?=
 =?us-ascii?Q?527HXW37x/Qgm7wPtoxLmELz+GknzdGIfcyfTNA7e4X9cRS48puCrF/EeBdg?=
 =?us-ascii?Q?6hNxjXQ38lIJDgoW7AWKUVo/OYxTwQY8GReuPuMZl6s/R4iwEq2joe990ZWN?=
 =?us-ascii?Q?hUOwflxd4OFmikhwjEmNvUxW9I016HF9iDSpfGoHjFIWKVCVYu5oLhdMOgtv?=
 =?us-ascii?Q?W3MkKkNMTr1b4EFORoTCntQnDYo0vNhKXIT+q9QASIJemnBPC5xDGe/zBVzf?=
 =?us-ascii?Q?bmEW+Mk3NPIRcwdLiMpl8phYk9y2BRHnE1xB5xQkB5B0nOZH5VADL7CXcsk3?=
 =?us-ascii?Q?UrHgRya2UF946m8FfKFJ7nTDrKoiiH0hJS4PgISt6jVRmRkHwuXEv5HXOEj3?=
 =?us-ascii?Q?rntsLpAMt4Ncmj181cfOnWqIcO2VdQrki4hd+l9tJln0ZiY+YqYppzc+Kz9V?=
 =?us-ascii?Q?WJny3NsWYhWd0lxnOqxLx82l74ybUJzdkn7BUqBp2RvT3nAiS/etp09QSHaY?=
 =?us-ascii?Q?NlBibatNmiGx1nM+mdRRPMAjJ82uePglPk53MBidxeJaues2IZU/8GmJi2xY?=
 =?us-ascii?Q?oa6xvZYCQf3jOAvbvwTk7NoKmMNzsdUzl0oJDDrWivceHHPjFZ+NnBsAJF7+?=
 =?us-ascii?Q?aA16dJMvjNCSc5XaVehKxlmZcwfdWptQGsBuob3H5ctBYg4BdMLVw7W8laFw?=
 =?us-ascii?Q?aCye/jWD2d/nLHGGQNgrZrUPyJNTF/L1aqBo7fbTPwk15kZx0YfXAUkMLhcL?=
 =?us-ascii?Q?GBAhptIys+P4Fo/Z+dfs8QxaeopVgE5twRySItQkJptHAySDl6XmBvUZI4b3?=
 =?us-ascii?Q?MY6Dx57z1U+6XSy2hQPEVdyP8QAOWY0Hl1Wgu/ODadmbo65kkcLGuOpTfl3w?=
 =?us-ascii?Q?yX1Je9IvrQC6FNJq9H0MLlC+CIFgRWtBEm8VXPee7YVbOaB8bsu1egoP3NUH?=
 =?us-ascii?Q?VY2k1CbOtpDR1GZ+x4zMlMs8EiYSZHtNnku5nrbZCSSad0lNFgW5/snS+Ahd?=
 =?us-ascii?Q?zmMwsyCisGzFFnXT7+GbUQGAkLXSgsT4x5tnqEXY9lf+HrmHL8RpEkUUo4Gt?=
 =?us-ascii?Q?cdauPpZ9nnGxcjLiFlmxgxE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62C2690540A3B745A553127AB8B7D7AA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FQ5LDvcz7eXBZ9k1XdsALrkN3QHX7EzPhb9TbqIijIoYp8FIJiuMbUghyn6BjvtcuHiVNz5ZwdT/Sc8gd3E1MlYB3KLuIyyo2zPk7oiHauPXuphfzHGLqa3pfGzzLxNrr4/bAM7MAIOJNo6b/cAww4IxFhcNuVX/oaN+IekPRCaGel4LKqPLkxo0sKaNvSeBKMOxUZpsFtx0JEUCHE29AayEhw710aCjKDnL4vu9Clzg8731qU/en0sI1Wrd0gH82cMEX4xfHrSgXd1iDNhtu+iaKR70L2nwcFrYhBiTKaoBiQRn324ifPMsPwgxwxeAPdi9lESGw4OwPF8bywdNC4Wm1crk/jwwCgqrfnr1AFuH8QLWHq0Gx783XVTKddzoLsLhO1/2wkDA8WqSBI3SI14fNeKQglsFoQVBcuGnGsa383GkRdvT/M5nSOmf765Gu7yGWdXxRBnyERZ1uV+ih2rRbzc1P4cbzshUdadxk4pTkSuReFUPuIemcTE2Y5DGsUq4M2Omaor3s5noPHcwa69TwksfiLXBYYRAuyk0P/lmmcNZ52ygSqHuQ13Mh4tc3hJ0lWlS9Fgc9qNfJd8SI0/HEUEf/33R7BFnrrL8sxU9IMbTk7Ce+uj+lu4oL8tu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc0d218-82f5-45e7-0ce1-08dc4a50e9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:17:36.1422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BpZ4fT61baf51iGISMPSW9xFkOkXJqfNhfOeGcUlCJ8c9YJ/3RWLev2lsQVdh0+GU452laiWzg1V4Seg5UroqKhv275v9P08v8CFnRIrApM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7827

On Mar 21, 2024 / 10:47, Daniel Wagner wrote:
> Make these helper a bit more flexible, so that the caller
> can setup not just the default subsysnqn.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/rc | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 1cd4833bae7d..bcc936549689 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -817,6 +817,8 @@ _nvmet_target_setup() {
>  	local blkdev
>  	local ctrlkey=3D""
>  	local hostkey=3D""
> +	local subsysnqn=3D"${def_subsysnqn}"
> +	local subsys_uuid=3D"${def_subsys_uuid}"
>  	local port
> =20
>  	while [[ $# -gt 0 ]]; do
> @@ -833,6 +835,14 @@ _nvmet_target_setup() {
>  				hostkey=3D"$2"
>  				shift 2
>  				;;
> +			--subsysnqn)
> +				subsysnqn=3D"$2"
> +				shift 2
> +				;;
> +			--subsys-uuid)
> +				subsys_uuid=3D"$2"
> +				shift 2
> +				;;
>  			*)
>  				echo "WARNING: unknown argument: $1"
>  				shift
> @@ -847,11 +857,11 @@ _nvmet_target_setup() {
>  		blkdev=3D"$(_nvme_def_file_path)"
>  	fi
> =20
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${blkdev}" \
> -				"${def_subsys_uuid}"
> +	_create_nvmet_subsystem "${subsysnqn}" "${blkdev}" \
> +				"${subsys_uuid}"
>  	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" \
> +	_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
> +	_create_nvmet_host "${subsysnqn}" "${def_hostnqn}" \
>  			"${hostkey}" "${ctrlkey}"
>  }
> =20
> @@ -859,14 +869,28 @@ _nvmet_target_cleanup() {
>  	local ports
>  	local port
>  	local blkdev
> +	local subsysnqn=3D"${def_subsysnqn}"
> +
> +	while [[ $# -gt 0 ]]; do
> +		case $1 in
> +			--subsysnqn)
> +				subsysnqn=3D"$2"
> +				shift 2
> +				;;
> +			*)
> +				echo "WARNING: unknown argument: $1"
> +				shift
> +				;;
> +		esac
> +	done
> =20
>  	_get_nvmet_ports "${def_subsysnqn}" ports

Don't we need to replace the def_subsysnqn above with subsysnqn?

> =20
>  	for port in "${ports[@]}"; do
> -		_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> +		_remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
>  		_remove_nvmet_port "${port}"
>  	done
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> +	_remove_nvmet_subsystem "${subsysnqn}"
>  	_remove_nvmet_host "${def_hostnqn}"
> =20
>  	_cleanup_blkdev
> --=20
> 2.44.0
> =
