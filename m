Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8912653
	for <linux-block@vger.kernel.org>; Mon, 19 Feb 2024 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708325091; cv=fail; b=EEdrFjPMSU6e6cV9zq1sAy+3EnvRDBSgRdhYraA9bwSNC7m1VRcJlvZFN1Y1U37DjrTEeQGHQ03P/qWP9s+nrF7aWY9RCN2hV2Spcs7YbbotqVYTBFkbSr1nKk4jQ2P7IevnVqSCkwNFAURwLltuo/6Jq1BBZkvLTqIAPXc9Q98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708325091; c=relaxed/simple;
	bh=FpQySVfj8uTaiSKxQuWwXJ+mg/rRpljvvm0fAjYwMbg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PA1IyOZFGM8eklTUPlr6P1OGXZ6OLw7iGYPnszFk8QhEjIfpFU5+zKxhvcYVqbTyFiUg8qyqLs1QVA8hrc4vTLpf4hk2PJsx++slX1J91kXrLk7oQOciCiO75TlDyvp/YYHKKG/S2i65CXLA073xpjXsYnu0TYvjzoo4/koNIuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XbdXC1zO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ICzuYI+C; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XbdXC1zO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ICzuYI+C"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1708325089; x=1739861089;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FpQySVfj8uTaiSKxQuWwXJ+mg/rRpljvvm0fAjYwMbg=;
  b=XbdXC1zOWm1v6VFcEaDEJMAAbDjuBCOlImmS0hHLcR7F9xcy2U+vd5Kc
   /ajPTEN+T3csRcqibIv6RQJ/dmb4sLXXGp+IEcI8yq0g1fCZFdEcO7n4E
   6pab6uCikQkzEng1ECcwf66j6BB4i2w7rT82+TXdRAXZG5btUaPuZ9pzX
   tib8mkP5kYHRLyqckHQSiUy8JLpxu4oxOXk7IYpfxuUd5m9EFQ7CyQmy/
   VDJShYlhNveJlGmpERSh+QlkV1NyhoELwSW1dNA3DO8xPmyrJTu9gDYk+
   ivFOy2MKZu0UenN8woyfETvWXJWm+TLd0aAweJKlC2aLtW0iwFaylXbM0
   Q==;
X-CSE-ConnectionGUID: mfukURp3SUeMRF/A3q1/vg==
X-CSE-MsgGUID: PmrMKHFOQJW8hFKJELCtGw==
X-IronPort-AV: E=Sophos;i="6.06,170,1705334400"; 
   d="scan'208";a="9640032"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2024 14:44:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzEvej57B7p0PkyIfkP6kagWEfo33yWLtjRf3uTPlAOykJvXixR4ROjakS/xY9cQ9CGyftg/Vy3NZnz2UdDZI7rcDxYs33ouKOQrr9ASlYQryAYXSfvpWT67v8bQA2sPzcUAE1QDTPWL6dEuiDQpnNthqsyEbgY96ZI9V6AvjG/1mculpmIBluwG9WYX3nax9lIHKf92sQcEJzIRgiqxEfS9o5ZNnxjCcvP64DxUvRPISucu89h0uaukwusbjkL5P9cNV6/2KrVeeaCBDpsc05qcXOMC4xTtbRB0l/qgzljc4DhEBoAyJ0E15n/dStbvzcBpmz8sCAmqkT/VMKtPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJYAtMymD9Um3QNqKW8eBv72JF18AkGrTYQZBixOmzE=;
 b=PTg7//3CrFuAnz9rsdJKg1nzPXopj3tQOSWairQoyI0ZBcn5TqHzQFAfZDEgW5QPyZXvcDnZXkZLFwOOUh9eKugq5NsoI4IhhORRrB68Gwm6gZO0RbA4S0KOEYRl4ADrO9ZhB9XheYell8IQAIT1eUaCnN7+44WoZTvjAMseBK43HqPSEHvYX9/V3FAQSwRFR+68E+W70NN+WQecF8eZRWD16bCvCKCsYOMYmLavWuGZOFyKjBc/ZGcgEaTfDYtK+j+SVxjF0FAKkEse1Up17V7Ywb3vtY8u6/uVhx/gbqY4i2u01XPts29lsG24+gMEz8Cepq7VXm5mcEtYJ8r3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJYAtMymD9Um3QNqKW8eBv72JF18AkGrTYQZBixOmzE=;
 b=ICzuYI+C7UqzzkZtax0/ngQY6fsHCYwYt3eLeOjD3z2qr10ah88IXUgaQbo4k/ZqyojO0MPjFW4d/K474Uagupo09Z2k403tiebYj2NjaYg57/sGaPaHODALfD7rxKLdeCbS+RasIFC7TPOt9ZpKPep7RO4Qre6U4vdhc/iIv2Y=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN4PR04MB8432.namprd04.prod.outlook.com (2603:10b6:806:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 06:44:40 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 06:44:40 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Alan Adamson <alan.adamson@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme: Add passthru error logging tests to
 nvme/039
Thread-Topic: [PATCH blktests] nvme: Add passthru error logging tests to
 nvme/039
Thread-Index: AQHaYTAENfBlt+01bEabu428v7dj57ENtCQAgAOHtIA=
Date: Mon, 19 Feb 2024 06:44:40 +0000
Message-ID: <l4fccsfnizagtkzf6cukj55dzpymmznkoc5e6ewt3yz3mpzvtq@5lragxv3fwau>
References: <20240216233053.2795930-1-alan.adamson@oracle.com>
 <2d2da03e-da35-418a-be85-b11f57bbd374@nvidia.com>
In-Reply-To: <2d2da03e-da35-418a-be85-b11f57bbd374@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SN4PR04MB8432:EE_
x-ms-office365-filtering-correlation-id: a1c05720-ff55-4d0b-aa23-08dc31163f68
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 R6WFO23gk68RckBKNdbZPm6U/xzY6qRORHGXwveuLeGIpo8mz4xLFsD7cOWlaDTjuBTzW6CyR/aaLb7RNG5hlfUNjUJg04M8VqfioFYmwpR1nqBU98uFbCoLxqEv4QfHKA1UpwlXE52DTU3hBTGZKcEMPVIaJUdvmpMgmNH8rfQ74IIlDGLU6z3j/lxQWQI9QjhgPVC+SLlcnvgrymit4SkPgRu9Ga0eAOcnpOuuBqhTF1by7D9yDCTtW3Dk1Q84K1siYvo0wWcs7VALVhUnnucgv4syi6ifWohCOqs/86z+cJwDR295ztFfWQn1Ursz3XTNzXcXkwZUEHKhqxKsCO3yn9nVQGJc0z9FR2J3Casmsz0Bmjo7NT5O54hDKY3kLHcjFVjR5hSeXenRpzEfaUPbb9c4JlakySB/YC288xnxQSFRZMIAc6eujsFJNaFS2z8tdIVOZpytyXAvJATm0TUEyoL6WYvAZbpnS4/S6mujdoh2RJlpGbreJPhV2bVcgSX4bA8jtHbD8mPLhsgisXZa8+DbSq2W6wZjFt6Dj3+QeAvHEFuwDkXWBWYNf98JzdglhleHs8A+OaxuYUg/lcfMI3CBcQ6ONcyvTYFE4dc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(396003)(136003)(366004)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(33716001)(41300700001)(71200400001)(4326008)(2906002)(8676002)(8936002)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(6916009)(38100700002)(5660300002)(86362001)(44832011)(6512007)(6486002)(122000001)(54906003)(966005)(6506007)(316002)(9686003)(38070700009)(478600001)(26005)(82960400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E22SXO902nIo4+R5KwNq7VbChqE/kU5OHy/3WtaMBSZW60e7Rt8mA4GWmrBX?=
 =?us-ascii?Q?R0JDKss0g0erxEbDEHt+DNxrv3Pku7Xpda9B1VSKbS/mAHRf3SB8X7vPBHV5?=
 =?us-ascii?Q?oIbfjW5uP74QRQllgwMNmnJDHsGFktiMD5aTywDReooMe1p1PEWKJqsMlThp?=
 =?us-ascii?Q?AXs/EmGmV2FTwJGBjm7Ym2hEY1hD75G5/bugIEhGCLTGro4o5GsEAO3caiJx?=
 =?us-ascii?Q?LUnmK/cFsybsfIvA7QuuOTSsRxGVV+4f8wWULJz78cQUYY8fGvWj5YUZHCWX?=
 =?us-ascii?Q?f5zs1M1t23RITfhuVT8Vwgg5zCufUAG49TbcC8CQlu8bpvLj/+CNzPp3yyYH?=
 =?us-ascii?Q?THy44AhP/bI7ce8vTa2RzY+tvdsseHvwowwZSk3EfgdDOAbNs22x6vqB3hcx?=
 =?us-ascii?Q?wcFvKf1RDuIlMOKIxKhlQjNJ6X3N58jcYX1qTot5UlaI0rvOnWfBjF0LzIgV?=
 =?us-ascii?Q?IuxOllaEeetWN4jovGCKyK/qzkyGF3weIcrq7l2R03dJtoBxUJoKtszQ1zuW?=
 =?us-ascii?Q?euR6mjDQSc2hJT3F56CWmZzFVoQb0Qdg/h7LNEKqkrFnJpJz6lCWVBtPQgAC?=
 =?us-ascii?Q?cefIk0T91kuHYbgaqQGBoL9t+2kxOEOqI0tFyDCxCrocAhCcY/h9V1b5XT53?=
 =?us-ascii?Q?7vGV9FzxV22GTM52gJQgpRIyuYDVzJexLTk8VexhiFzfys+caqzfAMd5x/mI?=
 =?us-ascii?Q?T3Gcws1w02pQ4WJ95I1yjP6CLbgOrk/UkSa8t0P3ffZXC6yPD8feRi7cYAJE?=
 =?us-ascii?Q?s8Q3STScNOsl8Bxun8I5gATRLHDa30ZpvDDIAM8RVQxo5Z/MwkgtVkKwucQh?=
 =?us-ascii?Q?s3fFbTT/risW6NeHF7fSe0LLZMHGcmw/ECDeqaLdt2D5g9L9zNjDOYd2AWZX?=
 =?us-ascii?Q?MWhiEmhDHz6A9d2ifrqCwOGIVr1ucAbsLqUdna8Vc4CJPMGsHnaPCH4VDGf6?=
 =?us-ascii?Q?QmBt6QUZsEyxFhlB8K2sRfo9xhbQI2qvK47MXVhKKuKbSUACcs1wop50Bhxl?=
 =?us-ascii?Q?RyghF4kyh4r0iQOvs7Wb8nxfvkHjawGKqbFJwbiOByffWni3+MZ46W9zB4tA?=
 =?us-ascii?Q?ME4ivhLkXtrcnzB7LbqfDA2sO0GDTDBQ3M+847WuEibLxCiTcke58BLb5/v4?=
 =?us-ascii?Q?7suCVklP7wgTamBvbf4mpxMbymlbaeLPSZNhCU7obdC6/doqR4ALBfJAc+D/?=
 =?us-ascii?Q?dVD/TnsJR5NLM4uIM9XxOoR8+PwKcg5SkVjco8h+NGCSe2wxl1/NOQcawIpu?=
 =?us-ascii?Q?9V7HkFTueahEUV9hUEW7lWx+qnIYS8AU/urFXWh7XfiMkQAOJMjtXXjszvug?=
 =?us-ascii?Q?ugmB0sy8nJX2Wr0wDB0RxmRmUEmOewV4sWbN8+0yZ0MFKXBpoPKeZlVzzKLq?=
 =?us-ascii?Q?Lq1JSIxdGTPUJZTtfqxglWPdC2jkwLzYh8BHu34/tdUsShQ2GrwRwvK8gbi6?=
 =?us-ascii?Q?zZo9KL6g3zOBFYAWUSf9YeZPKfofv79F6OtEdC73Puj2PSMM8Qowhcg/IV7w?=
 =?us-ascii?Q?k0lkeR3aAKfRyIX7rmNJPBPWl8nRI7ftuKcnsaRANiF6vAGpfmV92wqtgKgT?=
 =?us-ascii?Q?maCXr/peTrXG+SA7dHqHGsbCy/NYw2wFF39fdKdXYUE9AJDM8xNalYAMFd6z?=
 =?us-ascii?Q?fGh/MALu8cMQiB3oLOE1juc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CE35C8A1C5FBAC46B482A0B28B1A0287@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VvrWirCvzmpkhUiX0g2bMYnNKWqexGrnr4tiUoFHe2r2CPZQr2zoEArXKdC8cVoJ8vOKRjmJFxSXUivLD+/uN1zjFcFzlZnzye3MtZr7ZDFFHHpq7Y4aqwa8Vlw6QYuZsZDpmZepNKKLsx9q5s4oLLx8yvx8VFNNIv3OXn0tskhVeBMC6djaT/EZMW1xVY7UNhjhLc4BFYI/mmbpR3WL6EJw8PiELl2O9nu6/sAuMWk0jx2KVBlefiiQ+zAIXFvbWqyq2m69PfHijLEdx2FaN1rSghL0cjBbcD/xWJIhCVQowi3Sm46rhCDMHjBYBmlRuRE9L7On/ObbS9DT76j5jo8SGDT3jxAfucyfVsaJoqTOQfrntGjbYv/w3USrzlmwfKse6jYMi0Cbd3yBUJTqVduNYWOU2ffcTERGCPlYBMf+41wjJwepOAjieGgVkxSzwsGoDsimEH3WHAy5Jwg1FM0XlYw0qBMFc1T8zK1yI63toONEQFsyaDzAdFg+bD/GKxoUMVvY2CkldC04VO+PxK42OPWk5zufniqBQeU9erd1Bm6Ft7tEBRGAtsijNOEl1K4B94CWRGhYfAXChmJO1KpsfRn3KMTmpE9lTPtCbGS/BONweBXtgUHhZgYBO/ZY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c05720-ff55-4d0b-aa23-08dc31163f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 06:44:40.2502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSXrU1a1UxgtR1iqcPCeoyjakH1f12stkQtk10NlTGRTju+H8M32Zd2MO+ku6LY4YaZxpLHBj1ZG3D1qKOcfutVwZsZgu29yUCDoJwpFEvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8432

On Feb 17, 2024 / 00:50, Chaitanya Kulkarni wrote:
> > +_nvme_passthru_logging_setup()
> > +{
> > +	ctrl_dev_passthru_logging=3D$(cat /sys/class/nvme/"$2"/passthru_err_l=
og_enabled)
> > +	ns_dev_passthru_logging=3D$(cat /sys/class/nvme/"$2"/"$1"/passthru_er=
r_log_enabled)
> > +
> > +	_nvme_disable_passthru_admin_error_logging "$2"
> > +	_nvme_disable_passthru_io_error_logging "$1" "$2"
> > +}
> > +
> > +_nvme_passthru_logging_cleanup()
> > +{
> > +	echo $ctrl_dev_passthru_logging > /sys/class/nvme/"$2"/passthru_err_l=
og_enabled
> > +	echo $ns_dev_passthru_logging > /sys/class/nvme/"$2"/"$1"/passthru_er=
r_log_enabled
> > +}
> >  =20
> >   _nvme_err_inject_setup()
> >   {
> > @@ -985,6 +1002,26 @@ _nvme_disable_err_inject()
> >           echo 0 > /sys/kernel/debug/"$1"/fault_inject/times
> >   }
> >  =20
> > +_nvme_enable_passthru_admin_error_logging()
> > +{
> > +	echo on > /sys/class/nvme/"$1"/passthru_err_log_enabled
> > +}
> > +
> > +_nvme_enable_passthru_io_error_logging()
> > +{
> > +	echo on > /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled
> > +}
> > +
> > +_nvme_disable_passthru_admin_error_logging()
> > +{
> > +	echo off > /sys/class/nvme/"$1"/passthru_err_log_enabled
> > +}
> > +
> > +_nvme_disable_passthru_io_error_logging()
> > +{
> > +	echo off > /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled
> > +}
> > +
> >
>=20
> Thanks for the test, let's move these helper testcase itself if we get
> second testcase ? I'd not bloat nvme rc file unless we have another
> user for these function, also if you move these to testcase itself
> then you don't really need to make these as a function ...

FYI, we already have similar helper functions in nvme/rc:

  _nvme_err_inject_setup()
  _nvme_err_inject_cleanup()
  _nvme_enable_err_inject()
  _nvme_disable_err_inject()

In the past, it was discussed where to place these functions and we conclud=
ed to
place them in nvme/rc rather than nvme/039, so that they can be used in oth=
er
test cases [1]. I guess Alan placed the new helper functions in nvme/rc to =
be
consistent with the existing functions.

[1] https://lore.kernel.org/linux-block/20220512115457.hoa6lhk4as63xrq3@shi=
ndev/
