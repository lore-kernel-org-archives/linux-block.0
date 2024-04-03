Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EAE3EA97
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 04:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712120074; cv=fail; b=S76U2PELbEoMx0UxpSd6SkpV0Ck2V9RtsTBRAGCezTttCSFIuVC0CKfNBfFvhl5EmFNPKChc69hks/FtVer4yPFgzi9DSTR0OO6qLu1HqKtFQRM7DH5ceVIIAN/3XpT54TvjxUmA99Cc9v04kO+lat4SlFCwTJMgsky3+yvX7l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712120074; c=relaxed/simple;
	bh=rye4vMZpIzJNEZdG6I/5z+kg05CXOjFpFEhrzS+Ou3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uSI1gqx1+P0M1WGSL8cGGk5CpGGncU+zbtvw3opwIQBROtHh6l0XvxbnJ+mdNRSH/4BRI1CyNMtdvqqRYVoiftWdYmb6rMhCxgVlGxJNNrDZHd2ck+ZhAfi3EKSoP8hIugZBSYky+EJ/H2kCw+1AKLIHnniLRc+/XdUokiPij6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=N7TfKq7s; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=V0uuFmQW; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N7TfKq7s";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V0uuFmQW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712120071; x=1743656071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rye4vMZpIzJNEZdG6I/5z+kg05CXOjFpFEhrzS+Ou3k=;
  b=N7TfKq7sUkPJExc5CuB/Xlslek5/PIrQgxsSpGUXyOczr91toYJw6wSG
   1bKquoEsTmYf3zvCVUtemt0/MatYaAoY6/Oqbn+KPT3sAocIHc9iOl/V8
   3qEGp1mdLbUw1T+/UcDpwqByPn40TJa8b4fj4/JwrY0faawOQT0kdTcJs
   7y4SRrBMj4X7Mmk7H7wB1Ftp3nN7MaHVoQBztDEDlkzgeDjRzR01+cLL/
   XyktLQ7uKChUXlScRDz2W9bQOiHHVeM1lRPRf4VvNgxZ/YGmo5qjMng+l
   Y3yLE1XWL+uPiRB1VUc1EOat+PO7MqhcnnR58CFAiDGm0hm6+p9NZo2gW
   Q==;
X-CSE-ConnectionGUID: uLYFDtPgRWmnRazvdwJWjg==
X-CSE-MsgGUID: JSgy+RwNT6qlhalFCArN4A==
X-IronPort-AV: E=Sophos;i="6.07,176,1708358400"; 
   d="scan'208";a="13108039"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2024 12:54:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/f3elh1TpPawi9aj5mYTAP7zKaY5/1wKd1L2YGeyV6uX7TTtz27bwxs8PvONA/y52AyFFFFHuh2bajrE7N5LHuepIoAq2mfCBup29iqUrXTO0W89ru66xOTxayRrSUp5DPmbp/5UZZ/StPnIU6Nb7xVn63X/e1YQFjx7L1GKG7ep2qTZNq+vw2Uh17ehuBYq9aaDH+rzv21mpLbOHndF+FTNZDACJYOMrmKpqd2rL7oFPKMwNW02WmHsPuQmFRGapM1p4Yibb/U87HxHTx8OlPbIWTz9r6v3ZpwB9fgA+yFepqa4qZmugAiC7v5HGSY8UBUevEdv3yAWHRAT0ORtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD/kdg8ljEoylmau/kd9qIsMdWMYjDdfp3qZNbFfBa8=;
 b=IDK+4vqpnaZsBCcY47WmuCdvEkR8oUfmyN1Lx55DmO/hzcP+ix8qy44a8a9VsmbWv4SsJ/DzsqSCZxdZOppniP2ZA+o057S7toJq5Sy+3/Jc1A2eRiAqUk3y5e4Yn21o697V1cQ148YZ6vU0SUfIca0vyr2qjNAD09k+TIA9ABio6NGvphPrsoSbFUGMg1fsie/hQYJyysckx0dE112BIJxk7OHO2CZzf5jj/vO3ujgtLJ9Cn/vToo9KZ1sPyULYliSvg8bkCPB13a6dfMsEBASRoo2uAdQpFfrzPCHx1CTjNWpDdhOC7r/VzmJS0rzb897tmCQzXzCFvx6ZCI3Q3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD/kdg8ljEoylmau/kd9qIsMdWMYjDdfp3qZNbFfBa8=;
 b=V0uuFmQW5GaS6cm2BXmveeVPnWpXGOI3TpOGdXB2LePLburWElao7dGypUETxH2/4riMRmvMvDLbNitblIDZqxaiW2+ML8ilqfCVZYrAsOWzHvNkCr8h/9HWOZsiRdhKGMrzmQE3+hmu/gyo+A4ZiFC8s7r8HG9FjOGp1KhtKXE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CYYPR04MB8880.namprd04.prod.outlook.com (2603:10b6:930:bd::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 3 Apr 2024 04:54:28 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 04:54:28 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 0/3] add blkdev type environment variable
Thread-Topic: [PATCH blktests v1 0/3] add blkdev type environment variable
Thread-Index: AQHahOUD7cM19WGut0Kq15XIUevcELFV/DcA
Date: Wed, 3 Apr 2024 04:54:28 +0000
Message-ID: <mqpuf2a7obybtw42ydte2wq7ktema5odvc3dqm32hknjmamgdb@rbo3i6lqqkld>
References: <20240402100322.17673-1-dwagner@suse.de>
In-Reply-To: <20240402100322.17673-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CYYPR04MB8880:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Jv4qzQBBIhgsnOAPMDZROHHsWrVE071HeaQVJ0WXg2WEhE+NHukBL6h1y8iVPR/uM+bw6/EQForI/SNJCyDVrxT1pPPxmPx/DKL1PEa3PIhukZM7BuOQ60fb45CQntKZ0KYcA+bM0JeydG554NnqWf9aNkbsLIImbiil1Px1B0ff7plJL+Twrp8CJwngjyCySoJp375qWEqBY0y12uMWumnIj/OD9MIP7V7qgJzXHJTDxfj22IbEvxvTZEnttuIZvQJ7dU3k5gBR4bPlzAOK5yASjAzbpO+B+jXQlJ3fyiHHIOmBa72GrXTIrVYB1LD/O2hDc3idxzVXFsgCWjQdXjvlvvfa2KL1Gxuj5JahbzGH9myZbwxf+yccn7oTweAy34wyFGvFT8NZHlPtZy6B0ZWTxlP1nrJvufcBtP/wlFexH/+c1QhwjBF5f6KoEKZgldQeubkPbb3W7Pj/l1DStZcEOMJtHicedZkpr8TbQNeZisSzMPoQG0s1hnp5cchUOFSG/AjSR/FjlTb35it3KPkBLriEiKSNGpvDcG5rq0KNxfiJtd3NK88USD/pqlJ6YVuwrW5jq6xzmIj/gGm75u19HiefwYDB6n18QiZQ0rb7XDMTl6Gfk0TIFCLSkcZzQr1EZ359/JGfsGBYjjzVZc/KooaHHQwA1clCxipBRek=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f1/TJxzJI7AYOtaMG7t8/WRWeksahk5Gnd8AVWItEisQps4fjM73RsShprf5?=
 =?us-ascii?Q?TiKT6FBPfdbW4snjzAjEKAiKj8BidCPifbknuOvuqZQqC4McjW3nj+Pa3JTP?=
 =?us-ascii?Q?PuVlVEgflaBFfk8Nntf1n6VvPPJ/ubvch4jxETTh26UHyq6uLPmCE3uQ766U?=
 =?us-ascii?Q?1y46RsDPGgpcXQ8RsrrDcjc0XY7nN/WwR7dB2ccBLczpTlrc1zXe2C7wMZja?=
 =?us-ascii?Q?nxprEkXGMrIWzuMDOW4IXpyr4J1DJqMwaM3M7/upQQLryLddUjC+iVuEpllP?=
 =?us-ascii?Q?td9vFgXdcir3nY+9mrWNOHS/IKkay3M5+donxGANLkpOBSbyY7mpIe8IStvb?=
 =?us-ascii?Q?xkmTzExzgVB4RLBWKbErZ6ZrGOAxpYfxfFJN2KSxO/tTcd2tMDjxf4Skcsz9?=
 =?us-ascii?Q?qQDMxZWPdtYtmOXjFl26LsIetEI8gBsHisVhoMDb8TjKAANvendes2SYsrKI?=
 =?us-ascii?Q?+bHVFh8RPzV1TF+bs/Zrje8LuGg08ce4MLSv/ExTtzZ3y9y0Gg7l+UYrCScC?=
 =?us-ascii?Q?K/4LH0NDl6d1PY3NMpSZHN21F/lQBLcNtMBkXIjrSjZVSqpirczxSx3vtHf0?=
 =?us-ascii?Q?qYXeqc9Jvkx8OvVLQfzzudXf10bBv8o3TAFjudKXpXUm+q6yvwgw7bwsx6//?=
 =?us-ascii?Q?lWfd2w5CtyP4rxlGrbwDNUXBIFYP96sjp7Due1XgPSIM5L8TWRDEDn0V7ZJ1?=
 =?us-ascii?Q?EpavhxxLHbSaCcl5NlWXIVFyB4uVNJ+vgUvcwG1/FfP43HH8KOffzfDP6NRz?=
 =?us-ascii?Q?jlnH+oMgdG/hwbDcXZ7hnfaQndRzw+LagfSx36UgBuMD/eABMdG4M2en9tMC?=
 =?us-ascii?Q?bxCoWudnPtC5eWI9no2aKn36s+aJ0CBAehCcjbTilWctM8k68mqeBau3dUjq?=
 =?us-ascii?Q?dwMMdOPUm7Lw5gh+nrEn9n3CADjKOKRO9x8KQSF/yeidMrsx1og+hnsOCwSD?=
 =?us-ascii?Q?8Us6vwebSCJbbwcL1FIm9NKd3+j92k+IkEIHvMZck0yHcRqqKvi1EevrXcYn?=
 =?us-ascii?Q?C7taIxCZOUj9rOy1pF94aX2NzSZCx8KbnYaW7EvMiynovBjSfVi/HLU0GjkK?=
 =?us-ascii?Q?9NOXsYGvsXzXCEepSj14cwn6u2Eu0TBKhbrx7wdb2fAIavI133cMUDB5yUWA?=
 =?us-ascii?Q?xtKkwdAWXYFDQHFo5BeWG+lVlkW0Rervu6+fuOI8cqKzVtEmjChXZ0JrZyrZ?=
 =?us-ascii?Q?9lkzh43fCoBnMN0eXqeEP+ObJhECqhGDx4pHHcCDiQfL0ye5mVsu++34ExHD?=
 =?us-ascii?Q?L4Kk/Dz2+ogg1I/zU0hwA68EyJCbjdiyal5VcyAZdR85+Edv2ZxXFJD7lzU2?=
 =?us-ascii?Q?TuyqQtLWRtvUvXYS2WBGY9ILKz/Ab7KLo99byD2yYh8eKXl9Ou5YJFY75a2F?=
 =?us-ascii?Q?Cm1IJBMfyA+185i4XIUZrMdhiqMoMQEjG/dnAFZNbI7c4qP0M+Z1e335pUKt?=
 =?us-ascii?Q?3+sHP9VM2E0GYyPOa2MO0JGgJxuh7nCot31+YS0zh4wVv3t/Ia8lDw/WYjUZ?=
 =?us-ascii?Q?ufYoZ1AoWJR3XGoJ9Nc7djzMa3r+UETzVyeSuVEX6QwMbi7O26apAaoMnXrM?=
 =?us-ascii?Q?LhhaZpDzVEhmf/PO++nH1fTuuyLMTZViNOwe6Nsi/DA8DNMg+o/LbiqIgJ/+?=
 =?us-ascii?Q?1wAkGp5H92DZLnqkqVW2SjA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7BDA6FB6E864EE489A7AAED2526DDE33@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gIBDhhqjPFO9unrYo9gOZZ/f6T7gXBa/BG8knDdYeltQaTbDduitpBOwTCpoJU1csl2Q4dxNrB4FBSPJxTJcl1Yn/rwbZRxtel3g0F6q0LUEKJhuBwf8R3iivyjsRLmxRQasuDfdH9Bbq9sXWgh7pIZwVtyAB3jX0xLU5n9fJr2E7qR4KPV7sR1rjsLdOnFTVnbSnNYpvqQZ1230W5Vk+oVgTFMo+MTkrDC/V74MK7vDWUP8EfFMqu45RHXt2hjU+2WqBp6ZSEcxXniViKN6G7VKCKH+c8181Dw0bTxoWzWGw15JPOj6MLk2ySFxTP2Nl5KPkQnb2FfC6j5sN/WrgrwUN4C8a4dNHUbygXkS5guoKw/u5FTTdt1cs9tPvIVZRwNgZJIFqr/mjJZhKzmkZi2SZ6XUyMebrxcojFhfZ0eTAfAnUa7BExUpMGW1vUom0eCOSCtNZZpzTKGoDL+/pvk6151Yb1T8KAca2n5/ULQ/KtVT5WoNhDotp6Nrqf1/6dXCeXHR+ipMUA8gmLkvQvupE13utLdbp5Q4smlrH2mgpEZMW2vTBSOJs8BdmvA58p17uCDm5vsXsuDRywi8Hbu2a1UzxSZDjxQJiSt3F/NRCZf8M2G7qQw3QQ9Lh2KP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13ba526-5e36-4a65-e95f-08dc539a2489
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 04:54:28.1625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PU0HqfFwhgCJ0JJthjWVWvE9tR37zyhUkuV/hi5ckFpT3SS14eSUEcB1Fp2pc4UnzbKAb7e8UV8SYt3UO15Adjh6jXwg6Nct1OyvXacQBzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8880

On Apr 02, 2024 / 12:03, Daniel Wagner wrote:
> During the last batch of refactoring I noticed that we could reduce the n=
umber
> of tests a bit. There are tests which are almost identically except how t=
he
> target is configured, file vs block device backend.
>=20
> By introducing a configure knob, we can drop the duplicates and even make=
 some
> of the tests a bit more versatile. Not all tests exists in file and block=
 device
> backend version. Thus we increase the test coverage with this series. And=
 not
> really surprising, there is a fallout. The nvme/028 test with file backen=
d is
> failing in my setup but I was not able to figure out where things go wron=
g yet.
> I'll provide some logs later.

Hi Daniel, I find this series reduces code duplications further, and it exp=
ands
test coverage with small test script changes. Good.

On the other hand, I see that the series has a couple of drawbacks:

1) When blktests users run with the default knob only, the test coverage wi=
ll be
   smaller. To keep the current test coverage, the users need to run the ch=
eck
   script twice: nvmet_blkdev_type=3Dfile and nvmet_blkdev_type=3Ddevice. S=
ome users
   may not do it and lose the test coverage. And some users, e.g., CKI proj=
ect,
   need to adjust their script for this change.

2) When the users run the check script twice to keep the test coverage, som=
e
   test cases are executed twice under the exact same test conditions. This
   will waste some of the test run effort.

To avoid the drawbacks, how about this?

- Do not provide nvmet_blkdev_type as a knob for users. Keep it as just a g=
lobal
  variable in tests/nvme/rc. (It should be renamed to clarify that it is no=
t for
  users.)

- Introduce a helper function to do the same test twice for nvmet_blkdev_ty=
pe=3D
  file and nvmet_blkdev_type=3Ddevice. Call this helper function from a sin=
gle
  test case to cover both the blkdev types.

I attach a patch at the end of this email to show the ideas above. It appli=
es
the idea to nvme/006 as an example. What do you think?


diff --git a/tests/nvme/006 b/tests/nvme/006
index 65f2a0d..6241961 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -15,14 +15,18 @@ requires() {
 	_require_nvme_trtype_is_fabrics
 }
=20
-test() {
-	echo "Running ${TEST_NAME}"
-
+do_test() {
 	_setup_nvmet
=20
 	_nvmet_target_setup
=20
 	_nvmet_target_cleanup
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_nvmet_run_for_each_blkdev_type do_test
=20
 	echo "Test complete"
 }
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 5fa1871..4155411 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -996,6 +996,15 @@ _nvmet_passthru_target_cleanup() {
 	_remove_nvmet_host "${def_hostnqn}"
 }
=20
+_nvmet_run_for_each_blkdev_type() {
+	local blkdev_type
+
+	for blkdev_type in device file; do
+		nvmet_blkdev_type=3D$blkdev_type
+		eval "$1"
+	done
+}
+
 _discovery_genctr() {
 	_nvme_discover "${nvme_trtype}" |
 		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
