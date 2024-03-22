Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B04199AD
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100307; cv=fail; b=ZyG3MVFxMW3FCgLqs9633JmkZYgcZFVBIUXi+QiQmfzZC3XSX2RK8GMvBTREUt1UX+aB57NN5q+1c4+ODeL35Qv75QV80uYQl6XexXDcSwIujOURIvep9ezLmQcu4YA9Vrf2wDFEqUvAPvh3zGoUrqLrYxFvnfXQ1rnON1OICH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100307; c=relaxed/simple;
	bh=5Z8KrkA/W79g65M7QK7JKAcofNv3CekMrw4JUtR882U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UXtjRI2Zy6L8WHFK7B5fAvZbbzVCe/zXao15pwj4LeDmMxV5+CQd+PZeRMPy9P/A+lZ+f9TltVj9BS+l0R2M5ZwnolOF5P7OxKMlHzL6Ysxv6EUtVRLTRDqUSMAq4XNFedIaG0oH0yMf7bHF0IsqQMkiY/+z5PrEPjJT2DGC6Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UQFjdlY0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LoFZcE2O; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UQFjdlY0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LoFZcE2O"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711100305; x=1742636305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5Z8KrkA/W79g65M7QK7JKAcofNv3CekMrw4JUtR882U=;
  b=UQFjdlY0KN8Gf0NJHy/ZoJIETEqeMv9Pvdh7kt0qISI66kDdAAJUi+UQ
   OEKRW98rDBips0pvKgXutvtNdApe5EK5iAdHfwcoZxmysN5/MniwbX4aC
   CRJszmE7MuNC8mezbjdr0hjUKmpSsKwLyg2LFnvqjxSA3/6kvzU6j66/F
   bK5ybkGLOwrE6m56BLuv2wzCeDxpSyvnFaKmRKm056IVM7DV7rcgdzaUc
   gH2qZwbVBPCoW1DFhWZe99O8iwu5dKvLO2UqNFA/2I2IY0fkNhrD6bDBQ
   hU1PtUdnhLlk/F2K1LUBgJhbnE+rWxcds7VQF1bnvnEaHLKDPMsJzAQmq
   Q==;
X-CSE-ConnectionGUID: byJ0MYglSLqtm++SeWL60A==
X-CSE-MsgGUID: gEzRXqnySfW6bhczfuMByw==
X-IronPort-AV: E=Sophos;i="6.07,145,1708358400"; 
   d="scan'208";a="12860639"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2024 17:38:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0Q+evyEY2glMTxsTBBnl6l2UtJBUjHs8LQLJo9uDFZJFjDRQKmasyONK8rBmlk0/TtKfqPRjtGdAotcaTRc+pSUxQmF9prgKAzJMoXC+hTHpZ7bo6t/C7/srp7G07hpUY9WON0bVQDQWtIJqaCtzo5rkUc6w7D8/RXxAizLoEIISwoB4edixdBbrEVhos68rrjLx9yKPi1jTwGA2UoPpgGWW85nY03T4yBUChR2tJpWzPUY3EfvBjwkK82QNx49BQsdD1q/ZpH0XtTm424fUZCxeLyV+nTWjGk2946bsFlonMDf0woYKUFKVXBDUyW5oQ3FiNfLCVHl2KYhlibV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z8KrkA/W79g65M7QK7JKAcofNv3CekMrw4JUtR882U=;
 b=XDrAOiflJadVlSdE5O4etCtzC9wpwQYfPq4MdIyC+Yoa9d1OhghL7KQ0cLmAqR9T4vziHCjwQ2bzR8tv+27U9Eh/pHjZA5aJ4NoGqjGbQtAOfudfnQxIlQVipUu2MsJfcztk6GeV3UJVJ5iN534n0dRB0tRoeFPLl/vlWTlBLciJpbrg1NTMVc8hHerPopJc/Xc2cqxqtvBRthP1wDEp6tsianaDLpbl2aTOu8WlRcfkuxQ54ibRGV2HCtsV+2plisDBOyxSyVv/6t+b1lraD8e0JXvE+DGP+9BlxYiMZj88W639NzGQSP9qoPDf7k248zVQfBJo1amOgw7khwOHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z8KrkA/W79g65M7QK7JKAcofNv3CekMrw4JUtR882U=;
 b=LoFZcE2O5KkPWO+VHg7Sm5Zr6+ug0yOUYRIGXKANu3xB2LejJdGZT4VaLl6L85Moja0CUKQoxAxDB5NHVboCGQwX+H7zrtNCUfxZskhd88OF2b5DRdHuycyIep877kSkAUo2rf77z+FD1mTjKvuwKTC/2RR23Re9yanASqrwC3U=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7810.namprd04.prod.outlook.com (2603:10b6:5:358::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.24; Fri, 22 Mar 2024 09:38:16 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%2]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 09:38:16 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 00/18] refactoring and various cleanups/fixes
Thread-Topic: [PATCH blktests v1 00/18] refactoring and various cleanups/fixes
Thread-Index: AQHae3TORSjYAII5SE+dd9YzlHIRibFDgmqA
Date: Fri, 22 Mar 2024 09:38:16 +0000
Message-ID: <25uxq4piju5fd5ya56wmlcsmihd6ddqbohv37xpkluqsvosorm@fvrrs53crtwj>
References: <20240321094727.6503-1-dwagner@suse.de>
In-Reply-To: <20240321094727.6503-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7810:EE_
x-ms-office365-filtering-correlation-id: 3e9777a8-8184-425a-b91d-08dc4a53cd38
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zjsFMW6Lib5G32fPdua19xPVK0/XlabS/b/X1eNoDzXcxKG/qYbj7NZrl93cPZ2jRW9g9oNBsSGuVHO1h4kqdJZ97TVL4zXjO9a0Jb+kd+NY/BShJrIna6byOqYCC9QoDzRUCSWy9lYAbE6Tfcyl7CrJH9vaS80Zp5Lg0247ShG+IXp3u1DaWMtPC8EUJIhXMNoxG3l/fHkDJKTtetyLvz/IXTrO1ByGM/X+SPNdZ8M3oxlOovxfL7Oi1SyWWxehUrcJz4aSd1CzY1pQB7Khrlt2C6gbVkFDJMoqVSUDm6kbRGYcLu+zbSog5n3ZVX/KJnIjmzpMWPTD2s4guTO7ntNDfUoyOgN4pVTfhyICbnh1tJFZHKty0Yj950nNP+fwrVe3eKkosINwK+fTzOcjRWiLtsu6YCVBMbDJHPiHVIiJ7SneCBPUPGK+DSew7T/H6Wdskbzsl/xgTsNVbFKZaAovcVet7z1SCPm3EWnJ+nS1kqrEZqPyZ5bZiKZyvUQ9/SQY/69NLta/vbDjoZgX+0lgQi5c93RllBadmaVT9TPnQ+/L2QJBsPAmUbArqAZXf19bu1zKRJMdSSYm5fW0INvWyfcmto1MBeh00gVbhl+xFO/pAGaaZ+sFf/UgAx9GlHZp5qcENMBKRuNUgcv4VqCH046elBRDCj6VV8Ft8pRDRxcUyjB4sX7cinjUp7gIQxFwaUVSxKEny1pNTb0CEEJWWV+BE/T9HYn+bdvKgm0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UtIGj1B+zQmVoKa5SCTAqtebuclT3SZgc6P7cEk2OArxvh1FqZ4uAEGlkkLj?=
 =?us-ascii?Q?18NQyRf4In3aKvbQETxcEqc+zwCr9fRjoEt57YT+P4vI2s4JXJ0FOwpuxE0i?=
 =?us-ascii?Q?XbRbmCJgC3uLqFWmBhKf8BYLhxuslgdWxZ+7+xmmGXNK3uw44Yo3yM9uH5LC?=
 =?us-ascii?Q?hlMZ48PyPLyLkFWZ6zImYeEqbvraGwHGV1wkztYcf6KWMUcMvCUsqTja2mCt?=
 =?us-ascii?Q?d0LZqpnvBT49M9DluGXa85EIaJWlfLhpwjlGHrwdgJo75anr55RVJkx7kmGZ?=
 =?us-ascii?Q?D2O4wrJWV2nnOO6P9cl6BSG8Ve9HTY7WhzF1TWfdrWqTUou31Mg/CCj5Nv+S?=
 =?us-ascii?Q?qZtS9dJvWW84STzEPOZGPy8PwwinWA7HaF0Qv8XPAnm2lUO8pfxjfhYhcyZ8?=
 =?us-ascii?Q?SC/XwtDusIByQBJcDN1qEzE18acfDfYrTleN+qzSWbyovk7fuzZppAExhTdM?=
 =?us-ascii?Q?wL4j51qJhevZHkUa1tXoUNuLx7nK2owMcQorjkE57dBpuWUj4XJnUgpxh4d4?=
 =?us-ascii?Q?XQ5221vTRmbg6LpjWTPygnS+GicW2DF+kjpddaCGQiS2BVQG3n0ZrofwDPCn?=
 =?us-ascii?Q?IeYMNvHATVaLlkFcMd7UNFVoQt/WJjjbSQ3+fQOjjmskAV/ctuLLAVATTQAW?=
 =?us-ascii?Q?81qoHKz5AW8N72UakkBzc3Vt/ObfTdCorOyr1jIxaHGQyeiZ2Yi+YpMc6W/W?=
 =?us-ascii?Q?2szkmKc9QSp9t/Z3GEQklr2gBi7HgztdiPeLq2zywJYg1reeFUoq/BUPUMGe?=
 =?us-ascii?Q?29PCnbw2/wHZF6tK0Bk8zWgdVQgWYusbq2IQKN1ahnv5FhuEC/iXqJRogO6B?=
 =?us-ascii?Q?gCawonqWOvIi32qZpuOch21SOzbgnBEYwYtbIERQPU45d0QAlt70m905yBLv?=
 =?us-ascii?Q?Ij/Qz4lkJ48KPI1JYR10scFTcNEoBrp7MbCgqxnlbPbKQ/wmxqfXR9xWq88j?=
 =?us-ascii?Q?yk7IO8SLEw5l8gjv2zDnI+iWLjCcl51slAzc15U6kjQY15H9q+GtlLL5rdHl?=
 =?us-ascii?Q?Xsh+GQVNgKRVejXuo4kF/t4s+ti+1WxX0JNDPZLXfvSEHYBUlv9LVnjzI31e?=
 =?us-ascii?Q?o3Y3omqI1YrnlY4vyyQvl7J3s4rf+SLnK3jRZI7h84Enq4VlxQTF9zaABcUW?=
 =?us-ascii?Q?MCswy2EgahKJVNK2nGMRWyveXBCQcOL1C4TJrfRkKKPDAbUkSKPIDspObM7B?=
 =?us-ascii?Q?iwG44Tc1T6HdFFZD5pX9qj+uSSfe4ZGKIe6Mt+Qyof3F1u27lrtNvYWPP8qC?=
 =?us-ascii?Q?RpLfLrj2MyJlKBsNlQ/N+RxU0lP5UJI+8v7KA/l5WT0jsfdbcqyF+SHZZ4Ja?=
 =?us-ascii?Q?sjxmPI9K9o7jc2jhMON4P3vqX6xxtwlUj+xGV6qII/P3kQer4kxxQg1nf2Hy?=
 =?us-ascii?Q?/rT0R4gYZPuEaH8kab1Cao1TJbXOGh0Y00A4yUaivpo5iAH+C27eFJkTKqJ8?=
 =?us-ascii?Q?A7ArzD6GnD4YYAj/bPlfaiUmAYc6fx6ayYgTtycSyt4n6x3XmP29v8C1rx+o?=
 =?us-ascii?Q?ubjI+3W2mlRL5/BhrBavVhXnLUlBe+WqQSn57ZiiawHZw64ppojEqUxzv3Qd?=
 =?us-ascii?Q?mmbdJtUk8bPpNLtSx9Z+aHXkD2+qrfEGeZRm7ScsDj6uMX5P8MlMyWKcZ8+M?=
 =?us-ascii?Q?UBHB8nFl3MU2P+JUMlujBq0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DBBA930357A94C40BD56D03443786604@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6C+L+uEcJgXRnI03FJQ7YUaukBLfzWGQtQgJKvyx1cvgY0h08/vj4XO5Ie1P3M46KTinGw8ZKq+/RsE0cCvXfR44z7ZYoEoY4+tS2+ctjUkQk5/DJ13t0EAA8+EWoYXlBg2QXiQF1nw0jVd30aoHVEXZm6fBnGfRnMna/OPg2LgsKZuVmsTVwRy9hvRBNWi0hgQP0NYkDzIe9UyZYeQBnQQJxIWtBvjsJtWpnKIT+7p+ZlPRh7IpagQkFU/QW1KMXAEIoSYWsvD01kiZxDR6QHIa2DiGn2RxkNVtxSZ3IOi8fvHYYN2KNUaXeRGDkRPM/S8X7m0NGmZwzVkNicuKfvfFfM1AduWzZRVjStIzfsuF2KM58Uvdb/mWP1qqzLT1rot2eVLo3cNViUV391lVorQKVrKA5pt9YJszsd7qfBRGQKoPIH3lMukQnVcRV7skDUXDQeoEZ0FZq33rKezNmL1XzqFSmihTAxSww4u2ViqdO+hnecLqvcWsinStnq+RAASZNVTMtmisjHWvKAAVXXiiLYKZa9pi/pT0uBy5nPQ6ZpUrWYdcR5W2b+cjWBOwoT1wL3G9DVXKVmS7W8OotiYT8RuXYG/xswj2HJERDxEK8jsBpMvxgxANYrqxtHKl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9777a8-8184-425a-b91d-08dc4a53cd38
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:38:16.5090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5dnJYQpVGjy1nMaH3d2+u2KFNa5DoLX+aLkuV6W7ppRCxUYCbyX7POzdQTx5A47Yn6SeznXcEKFcgyWdjGNGnoPHT3qDGoyYuuARksaufPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7810

On Mar 21, 2024 / 10:47, Daniel Wagner wrote:
> While working on two new features I collected a bunch of patches which I =
think
> make sense to review and merge them indepenedly. And I got a few more ide=
as for
> refactoring and cleanups. But one step after the other.

Overall, the patches in this series look reasonable for me. Most of them ar=
e
part of the RFC series for the real target support, so it's good to have th=
is
series for separate review.

I made some nit review comments on the patches. I will do trial runs after =
v2
comes out. Thanks!=
