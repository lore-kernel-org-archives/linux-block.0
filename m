Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC266312C
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537293; cv=fail; b=Zc25iQxXffaj1gvmdL90PpHQNwLLYUy+W0HhHKtYsX4pEBi4gdc3G2ULaX9gaVIhJQxgqHSEGHkx8QTcUqVveRN4v7qPI4gfFr146HZjyy6VHcECiVS5Of1aCoKRGKqZBxgvF/8pqq5FU8jCXuuF11iL+O71vt4lZVrXgtGy+NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537293; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=chUvbqGKxw5qoatRThSoSNw4cbjPFEOv2GIp1GoD3gf165vUalmhkEhMOBVevAAwq950O/G20PLFdiGwvOmjavPDMDsa2gvYPxdlvv3151ZUfH7rgOWydesRPVqZ+zl9BQNveicoKaYthi0hrvG4DInBcC4yIzhFaaiVpf5KGQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ii7Efb7P; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RXWjJ49g; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ii7Efb7P";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RXWjJ49g"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706537291; x=1738073291;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Ii7Efb7PGDR8/acB8Z6Iee2czuf88CHaMSTmOtLOkY65F4M0MBr55TJF
   W8W9bJzonR8foZ6XN+O/waQwXjktjXDlU2yNFQS7whUVm88JegbLe4m0W
   vgLIUoITAAtEMFeK7+1JS4DhKKynj5EK7SUpdcekDL6BIi988RxRQrUUk
   YJHIZwOrgYnSfbpQJjB442bO0n01Rz03VIouIVdvB/Wmc6Ugxtov9hVMr
   vkfms1VIvhMuBAY3oP8cXkiepLQHpwiJM4de0qPzZUHfZoBMkVBCDQ1yH
   suX8Pnq/sJTJN7rKavYVkEgEg7k3qgLett1y9gY0KG+J2l8VDYK58oRtW
   Q==;
X-CSE-ConnectionGUID: My/Vp4T4RW+g/lxMXMDVTA==
X-CSE-MsgGUID: Wc7sVNl0RsSyYokgqcFa9A==
X-IronPort-AV: E=Sophos;i="6.05,227,1701100800"; 
   d="scan'208";a="8219504"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2024 22:08:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIt/aaOcx9cKmsQWg+rz3iIXM3p/xkndw1L7rampDqklNUFcyuNT7fVTf/9nseHz8FasS+kTGlXrEhVp3CltFMXyq1BBJqLP0vFQGjHvyQDnVHvsxThDIlaj2pFQReFQBmC9TDNAivpsUaoKq0tpKpUametCNB+rIH33lIXtCEu77YAO7tKJFmqudOjZQkq+5cY6TEUcvmjlfFwkn0OKYm04lPkWekBsQO32LswzaMwTXWIO5v3+F80GnW82nuBhqDmrLOl0b+PiqXFRRtgLd4e3WtaSmLktJ4eFJESNYC9D+UJnkPB5AXXsSnuCxt1LebsEZIu97gOBZOK51n7L1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=dsrY2M0tvr2bXen0UT6kD9OppPvJ2SI/mP+p5/GD+DtVE6o9Ljt17k73zK6x1uMxPlr+3zLbeJKXuUKr8jy9GEA9/HB5XpH9+BMsr8fGAfbOobU+tmz9hqAR3cGo8W7uSZoMxHaHRlxKbyxNZogKngI0ixzyoSkpPsH098As19vy6OleCAoR8oRnWx3NHtcXUPQWyHkG/tHnROD/DOkeVwcpF7LvdfbTHFoNsb08ncVx5+Tm+gtewnhnf7mNNEsdxBsskTc1IkjVbdBEqWCb9k3udFdQ/iR7CMxtCZIbqfuQnFoFTkuRaSJfmgaL5Lt+bfmc19JTiHSTSkWIopSohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RXWjJ49gIlnG1OnktuEzl1Qv8dnuOl6lw4eeBZ4nijkDxWRd33pDl9cyiNPfg1U/WiKNUYkjszlN/ELFUoPrhD6vE2QLAo9npZb6MpNpPj9ss+R+4CxOPNmeK1uji9Age8jFQuZ23izeuH3S+PN5LNEpJc+s+pgjfJUMqMr+79U=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SA2PR04MB7689.namprd04.prod.outlook.com (2603:10b6:806:14c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 14:08:07 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:08:07 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/4] block: move cgroup time handling code into blk.h
Thread-Topic: [PATCH 1/4] block: move cgroup time handling code into blk.h
Thread-Index: AQHaUKASENTxv1Y9s0i9f9HQE3oH4bDw1+qA
Date: Mon, 29 Jan 2024 14:08:07 +0000
Message-ID: <a06caba3-c84b-43f9-bff7-56fd590eb3a9@wdc.com>
References: <20240126213827.2757115-1-axboe@kernel.dk>
 <20240126213827.2757115-2-axboe@kernel.dk>
In-Reply-To: <20240126213827.2757115-2-axboe@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SA2PR04MB7689:EE_
x-ms-office365-filtering-correlation-id: e955f903-e5de-47f3-4daa-08dc20d3b823
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LI1Wl0NnPh12s5iupHy8xCDsxeU5j05Xs80+1drlswPn0bmwkJjaZ8ckxcp+PSFtPo/eVwOmYacjIqL+CqxUwzq+7zrpVlvbObONI6FklIF2Xp+Q7zj8hwr8jfjztr/1S56mFRHDHjt4hChbLtYeiSenqpg9wzYF8wpiwgioFGjPqHyP7m+CSMQ51MVJQcyWlIIx9X3IgUMPtUpo1mAiIYqkh6oFdClQRhPXWu3YuKrI2Nq6qy2aEzT0O+p7Gyz6jltKtARPYzBL9Quq0+E6ieQj36jEqgNFh9bLY5R2PRntVWzd8KhSolywfD4o56e0EjG9THsmMgs83F4hkiLzV5mLvPKZNwd62GKZMdJ+rHAjydFjdxG7YR7cBHzbj48Kuo/QKRJmp5HaC8IZ4/nrbbuBLD+sun+ztmvNmoFqEXoeI1YF07vcmm50PDVU6mV/+wLDymlh0vVhR6emF53OwGIW6L9o/JA/acD1wfa6KIp4PqldJiUm/UNWE9bsYi8Oj/dyPQagWy7vU4IvUsNQ4Bok8UsmS2VPFhAXY7PUYS7chpsys3S4sVa1FpPW3cB1LX1wV9ZhatJ+3nIlaLCM+ugfwQc5qLwlphhV+VkAo0POav2sUkx4c2r4oz8Hx6I/+RICGEWWkvMKZuQZOYAmbWuyTY7R3lvnz/+k3v8d/aGJYmi6T0XGmr3584p/pSlb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(316002)(31696002)(91956017)(110136005)(76116006)(66476007)(64756008)(66446008)(86362001)(66556008)(66946007)(478600001)(6486002)(71200400001)(4270600006)(38100700002)(31686004)(2616005)(6512007)(26005)(8676002)(8936002)(558084003)(122000001)(6506007)(82960400001)(5660300002)(2906002)(38070700009)(41300700001)(19618925003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWNpR1A3N3p3Q3lNbFI3b1F3aUlFdTEyVWRjWVdwc1NFNHdnaFYvUlk2TGdz?=
 =?utf-8?B?eXpRZm1IY2ZBeDRNcUdERXQrK2hOWHh5RFZBbFBOQk5nVVVWV0VMQ2MrOStK?=
 =?utf-8?B?Z25VV0VLNWIzTUEyK3dpc0UvUkxNVUo0VWowTDFvTW4zRHBjS1pwM2NoTmhv?=
 =?utf-8?B?Q1pYMm1sQjlFUzA4cWllYUJXT0hkQW42Zk94MDJhT0Irc2dTY1I5L01ZZHBE?=
 =?utf-8?B?eXpkYllqbUFoWnBpYUVCb1dKZHU3NUVzWkxnRkJwREJFZFljOWkwdjhvenpB?=
 =?utf-8?B?cUltZGFsdVVSanMvMnBQM1E1NDRWTXBta2t0dEduVmtuR2ozUkR3SlQwN1JP?=
 =?utf-8?B?T1lCMWg4U21iL0ZPQSs2SExHVlhMVEk0TWp2UkxlNVRZR2xlRUwreHJpVVBI?=
 =?utf-8?B?OXhhRks2eVFxZUJERlltblcvWmR0TzhKbVEvVE1kVkQ2eENIaFF1UU54R014?=
 =?utf-8?B?NEtIQnJUdTVkbG90OER3V2JJOUNOVjRHeVVoSVo4dTlSdHFnZ3E2YzhLUzJr?=
 =?utf-8?B?SmFVVWJvU1pCQkZRdDlIV3hKaTNhTERia3ZZZHdGbld1dWZnOGcvZE1uVnBI?=
 =?utf-8?B?Wk03bFhjWW8zenF3bDEzR2EzQUY2MndwZXRBTDQ0KzJHdTdJUXMyUmRpRU94?=
 =?utf-8?B?eEpsbkgzU3VmS2o0Sm1obzhuMzN0M1NNWFV4L3VpemNIYU1aUlBZT3pkNGJn?=
 =?utf-8?B?U0UranRybWIzL3RjbXlRY3I5WUkxZUNQNHlsNGQ5ZkxXZU1lWVlFdXBPK2xL?=
 =?utf-8?B?NGNGTzlpWWdsWnhKZmcxU1kydThZMVNqNkZZdGN4R21SUlpiTzVPZGpORDQ3?=
 =?utf-8?B?QjJGbTZrbW95M1ZLaThOczdOejFNTVAwb3Jzd0pJeU1wMUNpY1VyVmtBZ2li?=
 =?utf-8?B?alFDUldWcWEreVVXYmRTQ3hHQUlEUHV3akJBYU02amtKUHJrTWtpRTVVVEIx?=
 =?utf-8?B?dk1PVk1aTW4wOUFXVWxKanVhR0hvaURzMVQyTUpENThTUUNwalcyQkRMRDd5?=
 =?utf-8?B?dVBsRVR4MkVUS08ydTNidjlpQmZiYU9yVi8zem1vbCtKZXpORmZKMElJZnVK?=
 =?utf-8?B?dll5YWc2VGxCRFpnN3JYNUZ3a0czdC95cmkyVHVmdDBnOUI5QzhGZEFkWjhn?=
 =?utf-8?B?YVhRWnBkb1NURndxMEV1bmZBbDg2QlVBYnAxU3pDcUo5aEZ0QmdhV0g5T3VF?=
 =?utf-8?B?dnY5djZyVzZ3dkNKS1Rrbm5LbU1DRFdvcWlBZG9uRG4zaGwzRitkS2JLcXlK?=
 =?utf-8?B?dUh6RW5RUlAyTDMvSmJ2S3NVU0VmV2VENUptOGg1UnFBQ0k1MnZxcEppVGVO?=
 =?utf-8?B?SGJtcEp5eWNESXhLaFkrSUxQaHVKY0lEWkw0SHh3bXpOTGhiS0dyOVpKV2oy?=
 =?utf-8?B?WUsxdWExaEMwWHhQY1pUbHlmc3VoN2g4MkozRUtVdkY0eEZkQTVuRWhOTDEz?=
 =?utf-8?B?ZFFGcE9aR05TV3JJVUNaS1BHYXM5dVRDeEpQTjJ4cVB6OGoyUmtQZEEzaHBV?=
 =?utf-8?B?c25UZUdYd2pmUkF4anU5Z2tLbHFqbllDUHAwOWlDMzZWbWlEblBITGhQZzJI?=
 =?utf-8?B?R2p5VmlNdTRrNlArdEpZNHdldjU4VFIvRWpVNVV4VGV3cXNRSFhKVTlYSUM0?=
 =?utf-8?B?bFlxQVF1VmRkTUcrblZQNFNDK1luTzhyZjY2S2NpcFZKYTJnbThPV2lvMkxG?=
 =?utf-8?B?SDIzT2d5SnlRdGZoTkdTQ3kyVkV3OTJ6RXRDMnNSMWlrTi95V2dhMTRqSDBo?=
 =?utf-8?B?UzhPdWc1VHZYQk9DcVVqNE1ObWlnZk1vOWJlaHVyZFFZSWJsemxncFRmd1N6?=
 =?utf-8?B?ZlVPZjBBdlZiWFFHdDFrQUtGNHNIK3Y4SUxhbFV4RzR3ZGxvVHdHM1hQR1R6?=
 =?utf-8?B?NG9YM2ozNkcxWUpSYkYrbTBteHhjdkNvazNrVmFXd2QxeVNGL3ZkOUJvRVR0?=
 =?utf-8?B?Qm4rQXVNczNPaExIWjIzOHJxZ1NRY0VZSDdwT1gxL3pLUXJXQWxBbW82bDdO?=
 =?utf-8?B?c3hGdW1GeXphR1c1V21YSzVkdFk4blpIcVBLVzd1QjFQcEY4MU5PaFJpVysw?=
 =?utf-8?B?YllvUDdoZTE0WXB3c0dyYk90SnZFZUM1NWl6emE4ZWZzTVdjeUY5cTlPY244?=
 =?utf-8?B?V3ZqRWl6ZFFtSDlVL0RMQ28vdGttQjhQNnZLUDlrNFRQQnJ1RXNNZTFPc2Nz?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <685B8D7B9D3DA24099969E5FFE395080@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nipji3ZH55dzGU9BwAzYp8LX9vDXeaBizZ7TDm3o5DRTMmVmLyGYnoFRckqvlZ0EAk4yfP61340L+YOsyxDPjZtBywlFEYAi4JwxEKV32dzfmGtlGrqFHc0YyEDVB2+pUV9iz1q5l64aMGooMctlbJ0glN7JEQVwMKbIayBfg5r7yNqhzhu4AMDacuokB1mPMllMN67bc0Il+mD2U+u8CO1Bt6GNT5MLpjQvzVNbSp4Xpmw7dxuHoP8QHf0/Md3HeMGMNismT2e7/+B+Ak6JDeaZfM2AiWxcRvQOsN3yfxkU0dvsVj+7Z8QwlsJrOmxQZc92gNtPW0v7EQF6oZ9UIJJSZcEEtEO9LlVWr/52nhtRL0+H66nAyzRR6iJsv6OqiC9XfXdcKyuIyoXSZGNSFbhvfzKgv5GVdDiTiggWBpxP5MRj5gLiiSyvsvzfsY5JydSCwCGpUDuo/z0ADsg4HrmkhpQ+oVvGcYdaNpH/nn6saLcriigxBndh8zPlxoW5dEGgonFrK5JyEldnEB7bHoE7z7toN4ZbaMdoPGDBE2xTBCIa4g7ii15wXtvnv9fCr2wol/cK79dsCeiOUmPphGCtlxWBPc6it+RxIvRc8Hsn311eQ8vrhFNAvW+hckZI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e955f903-e5de-47f3-4daa-08dc20d3b823
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 14:08:07.8789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75a76wRv7MpJEi/aM/WbCN0VLe4Tvel9xvB32Z5NT/CAwkpRmFqBjicjkWemapqGNd8eluP728M27PEjyJ3Zo9lEabuVIcIsItt8JYux3L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7689

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
