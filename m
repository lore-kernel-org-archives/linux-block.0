Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D56714A81
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442841; cv=fail; b=WXF0G5Y9Pa7ZsBnReASB0yDftjo+VQ9jNbhNhZG/kXYCe0itWwDOn+zlCn/KyZbf5YYBbiupbyILKsBVDcbDioDMj1pXdx11B0T4BpEUA4hoXf/Ex0LiENv0ypffw8chG0Wbj9tTNuGweDK4w3wirCPQ9vuy9V3Qrln1W1GfqaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442841; c=relaxed/simple;
	bh=ZFhF+oNWqJEE1dvd9b5OqEH1mVj9ixdJlj46Fso6+Bk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RGF/1/hXwxDqlyItdVSC64T/Odsquf98oyV8HwmTiAyaYqNd2xvvHy/2Vxrt4jbpxyYxcR2Bw0J+6QxlNaob8Cz1D5i6ddb2Kfyvv/JD2I8SzTGVKTTrEa8xre7ehAFSSQ4Zi4+zbuvTZNPnhSF81wVUI/euzGr/U/smBp190BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=emJK5dDs; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VLiX8IuX; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="emJK5dDs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VLiX8IuX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711442839; x=1742978839;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZFhF+oNWqJEE1dvd9b5OqEH1mVj9ixdJlj46Fso6+Bk=;
  b=emJK5dDsXBPInDotXXCZzQBI7iS2Gg6vSugLUvNGhLDK1Rj1/sPSd3GF
   0mD0cO7pjGg0f4B1gnbAGd+RR64+V8PIthpEdyRX+GoDn8evPuclhNcHp
   qa9zIt1LmgGhCacloPGw1BRgmW2cP9JbZCZWBU6cxrliZUts4w0Pp/E4b
   hh7YWMOhEqT0Y7kUP9r7uQ3Kkz/BVhhxefnzA2P49QGw1h7a5KHQeJ6ye
   ajEOKXR82lPAEiuJqzOKzd1cYF4SysRzRbo5W64ZWc3SSCfOiuYpk6MAo
   jKGNoVf0U7aBdTj9yw/VFgbp0I+lrjJLQJkS7d+Kt6PgIYqEzNFSb97Ze
   A==;
X-CSE-ConnectionGUID: 6XGtx9oNSuasZONMefjqcQ==
X-CSE-MsgGUID: EQzJq1zTSqyk/b+rcwfrzg==
X-IronPort-AV: E=Sophos;i="6.07,155,1708358400"; 
   d="scan'208";a="11997609"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2024 16:47:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jve2qq8D8+9xO/fWLFtt23WwjOkGRMtCJZ4JDQPTsyfG8ehhzvNPcMDjO+RHKo//j0fxWGsajXuElYELn8rBc8mKJiozZNOUzaqp/s4TRRCzn8bdhAaTMaZGRIx3YQAyaV8x2mvJteaQ4WTb6fD9RCHLplznRxTiNTHcOLsdgTUxQwqdRnO+aj86j0OYswSunsAc0jbFHwTaF+/IuGZYUO5K6Bh+V/aDTKFgWPQPMN7t0lfi/1r2Vi4XRH2Jy6xDu9CoGcHpcgb1ScLFn+DNO7dE6GzCSH1QjcFFZHSYURcJ1J52pHruAlyZn9H+BVlYtk/VxjZnOr4S5SRksYAM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQZ2ucMEINHcORdCfhuvyibWq3NOJ+fCajSKmKO7Lpw=;
 b=XmmmhPUHByEq8PqDd9xCblI8+FfTz3xb0yTCQQbuqVFCP86Al+z7LqxtIaJs9JVxYHI/wbrEsUfVZBDKb2c/wp/ssFKmhhrBn6lEho9ee34Qne5fBGbM1BQsBM89BXWcjbSlcvNWC9CekU+hjzat9+6UzAmHv0GX9InRhLxotY40S0+VXPqw4W3KUqgrYY/g6OKrAxRjoSVI9QcDG96zNbK+GjrdN53fzmwr79QH+gyjTe8yKTOTMncGms0abQGjP8+7uXV4HQ3QDUlDoHfGTwnXaea6hWtAPJxww2taPQ5JQzKDzd8Va0jyg9BMPWl4wXXmcK+uCrwwS2aYKrAXaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQZ2ucMEINHcORdCfhuvyibWq3NOJ+fCajSKmKO7Lpw=;
 b=VLiX8IuX8+f35uUEQmd4vR+o90u4j4BKVONBWH11fhp20LDB1PIet1LSKrD2XeyHATiMPBw+oftXpYQ24bTAeJ3ytmXHqZ4xRUr3+ZfhI4MFt62jBlRd5q5rnVY68W8M+MMhopY9kdxd2Aw7nQ+gLz1MMI4O6FHUVWqFCneolHQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH3PR04MB8994.namprd04.prod.outlook.com (2603:10b6:610:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 08:47:10 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%2]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 08:47:10 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v2 15/18] nvme: drop default subsysnqn argument
 from _nvme_{connect|disconnect}_subsys
Thread-Topic: [PATCH blktests v2 15/18] nvme: drop default subsysnqn argument
 from _nvme_{connect|disconnect}_subsys
Thread-Index: AQHafF/pwZaSVfROA0iSyqKN90lojbFJu6CA
Date: Tue, 26 Mar 2024 08:47:10 +0000
Message-ID: <jeqnjn3lxohklip3gpxalwudo6jtgzu23tt46h534hvcw6y4qe@2ktcrpgjd543>
References: <20240322135015.14712-1-dwagner@suse.de>
 <20240322135015.14712-16-dwagner@suse.de>
In-Reply-To: <20240322135015.14712-16-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH3PR04MB8994:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gu2HRSHJK/cNjeakdDuvtVfKL6bjh071eCFdvo7doW8O58Df+yXTJTr3f9ZoGogFidHZ5BBIJjRewCG+vRutBz9uJvVoGdJHadEmYSKTLOPt6TIo7frj4ZbYMneOusYHgrwkT8DRLMQE7DjdeRqB/EHw6Sdml/cI8l5uf8c7ZY4AGxrrLnBINbuMu0oMSL4gqz/EpWLzoBonfLsVPnvyQdoxPy0AvhfJCdNCUX/4kVVOhBLtr4E8m+TwE4WfXzSf2AYGCeQhsrmB8fNKN34s5h3A0HXsP159KGbBiOu1sjkxuv4ojGOyzXyF7aFsbCYFMsEfLAyfTdJxKQzpjuaHl24xcXtZFNHrkzCvtU4GxmoPGlboJHI1vd8VHmsHjMMwn2Vo7RIGfbV24ScW/9H4SqE0t0wvrMIum7AP7sRBicKfA1ZX4itWE1yWPTfyHMrdJfQWliajAmQ8zp8viRkRSc7ymzEI/6k+fiYp5XMvZN/ZJebcNwobg1P3m2Mh8ekjoARN+RrEI57CjrVkx0O9QVq65/yVllWBWXM+s0A7MepMfRQ/N7Zyq2M9ZGya7GVZClBiup3U0FL47AEjU1nmndDCSLOuDWpXdeMomxO8FVDVjMtMb6b36xWAJ8AXmi/7xXZgDHlK92aYOLwMIzpz7RuVWIoltg8JLwlRI6d68cg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8wdD3lLWivRyMBEFBE8yDdeBdbwKwD8RndEDu6kFVaaCtsdrBFHzHzYsjWdy?=
 =?us-ascii?Q?XaVuSvxAnDE7w1W+Zrhlx59HJVtlcYF2DM0Z/mwdsg43f+iAR6MrzDzhkAb2?=
 =?us-ascii?Q?KMa6Zsje+jDmEcyzES3y5iSgkuXHajSv5+WX6OPtGcM8LnFY5IU1m2u1GQX0?=
 =?us-ascii?Q?DVCHjn/GHMHe1Mdw2almlcqaGqqN9m6WLIDIM3/RDnE+uHbyn15yb2sAhUj9?=
 =?us-ascii?Q?+dWldEG95IA8FJXV61yAWEqgF9rfgVr42NruI8SJHZAneiwoQWSjRlzh6w5r?=
 =?us-ascii?Q?pMu57MRXaMzqYy/RzTegWU6n60RhPMmb+XaDtqXkZifLrFKPp1LWZwHXkghA?=
 =?us-ascii?Q?Bk76Uz7YjidJEPPvvRklUbZtt61c3IgNw/l0u6w3AipgU3GvTqJguXpLU2ij?=
 =?us-ascii?Q?DafZhFNu1faTF0vg+9/OBSrfVfEo6cYi6CKcmtLWnwTgOHEdnkphZzEUKygM?=
 =?us-ascii?Q?a0uQq7z0jYB0qzgmKDo3G4Ln4XB1708RpiHZQAqDBd5A5DbtiLJaxhsAEYsY?=
 =?us-ascii?Q?fVXb+10qftE1soXSRimCqOHarELWfhoN6OPUNAF8r8PwdHouRSH+xue6H9gm?=
 =?us-ascii?Q?jL7exLWaWMEoULN4x+UMtxjooJFKwHfbZchsNHq3HP/NkqxSz+s5GiyIRnWo?=
 =?us-ascii?Q?fLh2OcRHznFEHOnt/0GGqhl9wxK9yDRvaqBeBZvjeikkmebTeeYOlAj4z5Se?=
 =?us-ascii?Q?ka9uba0GeYX6FK8WxHihy1jXuu33Bw44llu1yZbipnFCFEz7xJgnRmfVVeiv?=
 =?us-ascii?Q?uEZocwpfl6WHPAIaAHR9inhl09fHZZWxaOqO7v8ECjN43GwgUFzyySuaHFog?=
 =?us-ascii?Q?3UUhmZ28C5d0pPETLClXWSHTH39WTz0Hcux29r4ROxi9ERaFvz2Mbs72ju9a?=
 =?us-ascii?Q?7OKOCnbQdOYFgS0rnrkpFYQhCjwbHdWdOAhP9j+FUFPnrE2Ph5X0MD5cV/i3?=
 =?us-ascii?Q?l67qR0YRw6qkYRGhBHw3qSIq5rDhQ9V5JRcWEfEVWTAVJ13odEYJFspEg9R3?=
 =?us-ascii?Q?xo9sSs+fL/90jCQQrxCWr8XDnml9kNvlL1vEzEYgtEV7bBDQ9NGHN1BALYHZ?=
 =?us-ascii?Q?5axY4a+4sUgviUWeV6awQWPi51Vj+HW9qQTN+1MjHfPyGL2Ncse33AxzYO6I?=
 =?us-ascii?Q?nZAS0TJhoHkQ1L//0gysmJvgyNcTdbvcrUKfUlj7LS0CEB+QcibgHW/99WAB?=
 =?us-ascii?Q?dcdaSNAKBU97o4jHAQwKzRL1rbrC+xbgu3b2HwpuGTxTq2sIj8uZrYmRfkOG?=
 =?us-ascii?Q?IG5Sq1skJ84ebQk0XuoqZOSwVJeJr30h/HNpUbaP3Ni6eKJrttUYCE8aWtWn?=
 =?us-ascii?Q?76d8e8dLe3wmQ4WklZQOOOV3swegqlsIRGgK0TZHXSx9w8Qp2suQYngLPFBu?=
 =?us-ascii?Q?8T/GTO8XNKapvpIuKaWkkIpS46gOn81X2/ivgwOwl9f6RRKpNC+X07t1277Z?=
 =?us-ascii?Q?fAQcwddVXdBl09gDph92BTSyQNwzBk+mzSuafTKrAXmpYAiW3nfMIWzY+ilc?=
 =?us-ascii?Q?I8QFdFM+ryJ6GCgOJp/xK53hmyTt5vtoRW4NXaWBY9FjgN61YI+7zOc8lIe8?=
 =?us-ascii?Q?zHmTvv4nkc4uDhn/DcCBLds2811Qpni1ZYO/Tv0Y7bZtFWCKrKL8x0yIdV5w?=
 =?us-ascii?Q?TbR9QX2AYuCOjmwNzRiyxQg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <303F9459FB5D064DBFDAC9D1D80CC02D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/pRWpfzHolwzur7y8+LQMS/1hr7ByGDWHgVnbTsqH+ditMgZ0I7sXPTkrb8QIcGN8nFV4BbXljnopIH4JAOh7FQRLKEjCfNI/SqhQfYYgTQFCGjC4Sp/XG+YhKhxuaWNO47E+tkGk7i2oKWp7eKMMrVNvd1tOwA45BeLqfMa8mNOjnL89z0FxN383YueSZiwGhz5gZ5ocYdjMRYjPekiNJGSqdYO1UCvDo3/YYwotmdwEyrWnN3m/Fh0wxdIsasBjDzvp19sMZoI+WErGN2ZQi7nIxBoKggnZWXD0Aq+w8SJerRwAjNsckcrPmawtBz+HQyC8BPWXxJe4KYfzqIaFwZ06RBoRC6kWZJWJj4tpVT0DSTEDHL+4PYkjgOjYb2m8jlMDO+LY1bQAUx+0g6djvgLtTzU0cGfacJYcKRpUETabvVjMVJ/dLFK0fshjP12SH/umPkqY4UFJStgR1qGVWmWK7pCo06oudE4pq4xQnr3xWxVyTQnO5XwRRZ06ZyCQ+I0SvWlIEL8JLqxK6NsAk3469UCz4yJieUfBr2JwNnWsG9llGJVGeQywqXVDt1EKQ4F3z+0b5TmCheCTD6daVwkw+hcN2RS7M8xdeTM9DPfEnwWfOlLTL4f1J5ZAAd5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217c25ba-4463-40ac-15b3-08dc4d715369
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 08:47:10.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4In9cJs+JwhV0T7sLPZUJDUamFuBOylslHsxLsmyzN2WED+8FUdVWwzA4y7iexOdUUCExmAmxxNQSq8RtQ3LER1UCOWBBh3R6SIPftRRNxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8994

On Mar 22, 2024 / 14:50, Daniel Wagner wrote:
> Remove the last positional argument for _nvme_connect_subsys which most

It would be a bit better to mention _nvme_disconnect_subsys also.

> test pass in the default subsysnqn anyway. There is little point in
> cluttering all the test textual noise.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

I did a trial run with the series, and found that the test cases from nvme/=
033
to nvme/037 fail. The failure causes looks these two:

1) _nvmet_passthru_target_connect() still misses the change for the --subsy=
snqn
   option
2) _nvmet_disconnect_subsys() calls in the test cases missed changes for
   --subsysnqn option

Could you recheck the test cases?=
