Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D989249620
	for <linux-block@vger.kernel.org>; Mon, 24 Jun 2024 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215882; cv=fail; b=tlxBFB05rVznFy2YMizrY5WiKbtWZOsrNB7UKqSKBnr/x+HniQXkpQ+6/GTnxm0LLrndE9Tk1uzkPbOtueuZM4dcEg8RMddIYCOQ3rSFB7FQs0qhKydrM+aHX7+H1j3LkDTCShj1nKP+u1/1ncgJJ/VXgcXELLUI4NQbmQWSQJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215882; c=relaxed/simple;
	bh=wXh+c0DG5Hikn8/NskL/lRVuoji9D5jsoHJG62OzUNY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=knj/LtrAgGSBCtAB22Io7HHfJsD8skWVj7G3q8z6sPTLhbb8xMey8EsLiMyRIytH+7YlfUfSIzH4jhfmXPre7fuqRYSB4BLZzdUGt5NlbvgWG9JvufZAh51noPUoctlndCZCnSkZPii+sla/giMeAYApOYcWWwmHGpGzwqPozQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KYxYfz+/; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kWjNif7w; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KYxYfz+/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kWjNif7w"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719215880; x=1750751880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wXh+c0DG5Hikn8/NskL/lRVuoji9D5jsoHJG62OzUNY=;
  b=KYxYfz+/wgvEpMg32aGswPHtV9pv53RblX7qyLYTplPuTXX7SQfGMmhl
   ECOrFxBycD4EOFI6+HFyTYGoLRZKzPmCnld4sVLMW5HOhLih8oTAn3fPQ
   n/pOLI7cGDsdoe0/uytdVbmrbDuXCCnxfRLNHObOfHnoiuoDtSq0rUya1
   pHy1YB7YT6H+ByxzTfCLhhVUSiBlUkijulmT1cDwjKwowruMXJeC//uDo
   SmKGrWUKL6nWtEF4R7z9RtKbqBPGUeIbzvr3bETAJV8fEOMDZcVDS7vb+
   flAqkyE6XpcI8MSczBOxO3XNA0GA0E4xo4DO3DMpiIfVtWhy0ArGawI8h
   g==;
X-CSE-ConnectionGUID: YQl66inqT62IxYlEx1kdog==
X-CSE-MsgGUID: EqcQ2bVnTI+q9AJoTSoLiA==
X-IronPort-AV: E=Sophos;i="6.08,261,1712592000"; 
   d="scan'208";a="19830584"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2024 15:57:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjrWohK1BR6bJ+rz1++ZkWiQkp63ZJVsTCVqtCOgsUVsO4J82rdpOynxYn/VRtsBkMStXGp5sElBCFad48HBn8aPQCx1SCxoolcvRBXJbhCWroD18fI1J8qYtRKqgp2hCOad1T55R4886Krqgc/iCf1Gaxjz2SUc7F/JkPhbXS6ehT83/3DDl/WayjmxQNIhpy24l2jHjdrqnFDfGThk1VsRzbMXm4/CA2gtAQeClx0gLJ2gjUiVkPge+b9qht47XSp0fnIBYdQ113aaOOKOmQKQHp88YZHjrdxJ4VggQsTsHsLrDe7JQ+Kd2OWGLlvVtiEtwmu20ekZtAyXF9vg5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXh+c0DG5Hikn8/NskL/lRVuoji9D5jsoHJG62OzUNY=;
 b=axip1d2JrI+2GGxycW6YHe0D/hB9md+x6kPgSDgVyguV9l29747Qkq7oGbH5WbhNoC36uxaiJ4lFeLyZBEMwXHc1adE21sMfIDcdhgWgciUWjGd+uFCfQcsM5HuVlCdlwLpTr0ytfLtmQG8Mupn5vgbi8UoUpBEi/o7NcTwq76vrueQ60DPEyblLcTkEis9mMhNHj/hFgfS1QU6TmaImiW+YHi6gUDjH5rXruB+0eumxNJYgHr53qMNfS1LBEAhK+fvvKX+wjztEKofsJ+Zrmzq6ljXmEjGoV9VCBv2Xq/F1rKkP+DRkNReVo4FwkinZYCjYYHCWdzMag/f3uK9y9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXh+c0DG5Hikn8/NskL/lRVuoji9D5jsoHJG62OzUNY=;
 b=kWjNif7w9NbI5pvu6bIBY2ssgX8BcXGCYNKcgCIxpAR2ATJqbvYpGaaEvj04YyLedErpVPmlY9ukV4J4Ri4IFPAgmHnseKXH8mEuEtsu3Cew7Si9d6zkubDh8JEg6S130PPeHFYSytgflijsMg14JhXF81aXQwNhhYpiqv+gIUg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH4PR04MB9505.namprd04.prod.outlook.com (2603:10b6:610:241::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 07:57:50 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 07:57:50 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "dwagner@suse.de"
	<dwagner@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, hch <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"venkat88@linux.vnet.ibm.com" <venkat88@linux.vnet.ibm.com>,
	"sachinp@linux.vnet.ibm.com" <sachinp@linux.vnet.ibm.com>,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCHv4 blktests] nvme: add test for creating/deleting file-ns
Thread-Topic: [PATCHv4 blktests] nvme: add test for creating/deleting file-ns
Thread-Index: AQHawm3YUfmbVcl0cEOb/kAZf0JTJLHWk46A
Date: Mon, 24 Jun 2024 07:57:50 +0000
Message-ID: <6a2rpj24fiqygwvjv2wb624c5wvt6ed4gdelmm33q73je7hwb4@wqmu7kjcrzpg>
References: <20240619172556.2968660-1-nilay@linux.ibm.com>
In-Reply-To: <20240619172556.2968660-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH4PR04MB9505:EE_
x-ms-office365-filtering-correlation-id: fb6a62f4-b94c-4ece-af77-08dc9423582f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|7416011|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KUwdquZoZTsbPAMXfzdORMVvEQYVpFt4tDjM1DXG426QhrP1aNOm8MGEr+yV?=
 =?us-ascii?Q?Z+wILxcW1Yg3VqktWGbBeZjZxDknVCB3Us3/FcBEdFCn9Gc4XMKH+ysBq98d?=
 =?us-ascii?Q?clIj/t4m05iepozihBDkoPDSZi/dkA2ESGKB09riV4DFqieDlDV7o2yrJ5Jf?=
 =?us-ascii?Q?VburgvM1R9t9gu2QNuHQvQPZfQL4UvnQfIwRcn7RTPrTTsRDsThGJq3q8Q7Y?=
 =?us-ascii?Q?oXye3q1KNKqnisn05v/xiCtpgTFbCGV54Dhd53ukF5TKL3k+p+TZFDdVN8Tw?=
 =?us-ascii?Q?GSkZJ/NOoq2ZKQXh4YjhbO4rQevTvHlST3Gtx+9a4wkCA7gCFtbmSP/jRm1g?=
 =?us-ascii?Q?J3w3ApAgmy/4bdnPTF9CzrtN374Vf70HiwLC2N1L1AJp0WNJwzCZagrkioNI?=
 =?us-ascii?Q?zeQ8C2iTuPVTSLt1EWZ9XTHWFLY4RFJ+DEbpRok9E1LxAMxipcGEk6pRaYCB?=
 =?us-ascii?Q?NZ39yQSf0hxcKwdOS7x5WpkNsrfbzMDzLad2J3bw0HJ0VGgnAnUa+HfnP6rP?=
 =?us-ascii?Q?4Bf+u0YNdQ4hHvwerZcAAAlGyDeJv24JL2qjW+5UydShuXmEibTBTMZca+Lo?=
 =?us-ascii?Q?uEEQ8pgOcxguJ0F5LM8vm2FuT9/cqzoXrtKMEBVgmMkfwa2EKBVxXkcqmsHz?=
 =?us-ascii?Q?T88/KFcEalVr57jLRU1w/eUSh2iL1Tubf7pM9rMIYBNptzCJG/nAOxKxh6IQ?=
 =?us-ascii?Q?a8heH0cIydv5SE0BCVK7mQTJSYTDrtmCQtLjBdR43GgZM6bUSqMLbMViIKjL?=
 =?us-ascii?Q?TC/Pk5TnssgK9YVSZAeQElE+74q2Bx0o1vm499ok+bfuEChEYaho9neNYM19?=
 =?us-ascii?Q?mbJvLYiAZxSq0xSqNzOhDTVqs07+cvbsWKruKmS6PCc57/eHEait7TxJN/8Y?=
 =?us-ascii?Q?5lN2F3RjdgAZ4vY/ZLYFECBekYoC5EJo5Fq1n8761CGwDGK6SJMi+2uqoNek?=
 =?us-ascii?Q?ql5zGcRb5b01K6o6ChEm+vL5/szAw2yf+vPBwhjfEIyQ4iaZrUw7NeZxgZRD?=
 =?us-ascii?Q?PrAOyIu1q8QNryQbOFAcPPRUvxeJVqDWjSfcUdpndCj627H5nhS75zf5y4Gh?=
 =?us-ascii?Q?Iuut5Cg3MEw0WT1IgdH8WG4N/mJ+U/LGOxoyFlRQ2S+sK3H61zO1LFn/Ri2o?=
 =?us-ascii?Q?v0FxRVz+kZIL04tjIQ6YSXfcLHRQZCgoFeSP8IzGnpJh5DnblN8YZ6Q0hFVA?=
 =?us-ascii?Q?VK3yY+HHgJjwCkeu16CiP2IB1OX3Xb4HsiWyFMOgrCFABmEG1jiQvTw3Vgrb?=
 =?us-ascii?Q?eXUf9fXzK5cvWa0KtKSc13biEO/7vxURb5gxeU+sim8eS5ohSAkiLf9Av2Iy?=
 =?us-ascii?Q?zk5PGuGQNNmRrtNuiW675sYA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jmanwtQvX+3Mab7/jW1zRFZJJxJVv1SE8pgD7JuVSx5j7cZtSqtKC5DjPoAR?=
 =?us-ascii?Q?20+88nB/rRkKDmSr06gWdDaUbO3zVTzkku9sIIqIqpcKJWv3+GpEBvypp14M?=
 =?us-ascii?Q?HMDo5dMeE25X3Nu8dX49HpusKrGkCMV+Zi1q0CxR+rkxpnEnrWJL2/nNDUiV?=
 =?us-ascii?Q?i3i+/ngUIF+gN+IlT02Y9t4+ZwQkxuOJcnjFw3DfxniRat7hCbxRCay8kY79?=
 =?us-ascii?Q?AfzzGzjD1Njo433+tEEcK0/tggUQ5W67Ic0cTM8HRsvZ4+SNSeJ8mcDK5GAA?=
 =?us-ascii?Q?8S5FqgavFyqKd0Aygx1+0ljeQAFmpHC7vn+rG2kcAH+iQXUFr1KTCjk51aS6?=
 =?us-ascii?Q?7qWzJ+vhuL28BhuD7iDzeRXeKZ22QHaiP6XjpZ2154L8rylrc3DeWd4QyCvy?=
 =?us-ascii?Q?mIUR/tP35KL+efkjNzBE1zpjYlU4jYidomB8IJ89hVivErFlcbPT2YsHsLZD?=
 =?us-ascii?Q?royhOiPB6ZasLpBQOmNVzV5Lu9YZToROOvXiXlU2PDgcderFtTjCQxKV7Jws?=
 =?us-ascii?Q?avcyA+Q1AIjZ2140ICSdTteHErzuY/qpr4Gkr8L7Fkda9R+WxmgEF9d4/qWQ?=
 =?us-ascii?Q?lNlasatMtT0D3L7Vej3IsghcIG/G5qSLqVIcXnt2HBiV3YtYvR8nYKA3OMSo?=
 =?us-ascii?Q?F8Yg2qMVKv9wuL5EM23d5WhATG2irXL/1Obc4j8SMVxHthAa3GWrGgxby5ad?=
 =?us-ascii?Q?S8uhhT8eS9MpTDp3ibXI125kg24VwZxu7N43QdBIayUjqOkat8ETJW5PLyXZ?=
 =?us-ascii?Q?193evYcbbtP8iipNDBOKNPnz9kNT/VAMgXAnDKD9sLqiRofCywlXLeZRIoZ8?=
 =?us-ascii?Q?FG4hjukdYeznH9bZR2NEIC0Kzz3EqdKJRm6U1GDOK3ur5kflcNYkELFuF3mn?=
 =?us-ascii?Q?kBlYXlXGC0VOW+uFoqlmrzhcIh2T6pEJ8OkuUqwWKjQ7DhR7ASHiuuZ+1qSA?=
 =?us-ascii?Q?oEwWLE/eJSeMJ3qiiMKFiqGAN9GxjSHzV8wX/CdAEh8QsIwXG5997t99yqFB?=
 =?us-ascii?Q?ZL6Lgr96RvjUSBuS3PagdgEXKEaeNLSL1mMFe7HPGPzGhYkQihjo6mv8fXxU?=
 =?us-ascii?Q?zu+2E4aWS4vYk2645yKlbBxgG8gULp7cEiLzLHKq42gar83da6mTz08ogk01?=
 =?us-ascii?Q?xHEPDAjkt4WzLMrpgCKtB34z4TuAfrzcvlyKmvygnyhadgyZaq1669CWIOWM?=
 =?us-ascii?Q?PfGAQhHkYAqXZyd++imKzq/aXGrunKbWg0Dhj0WkK4mdOQoh39bm5kNH5pYg?=
 =?us-ascii?Q?4q94yThTb2ILDVjg1WlM/28/BTyA9v6claj457whfnwci50rIpR/BllE91e8?=
 =?us-ascii?Q?yzCND7CrivmqFXwCHXGTyp6/vXKU+jGET10+ytQHbW07oXw/R+eq0e1odyD3?=
 =?us-ascii?Q?1UFTUjqWjMeoS4+1UWDVz1TD7xl8ddcyjKrvZLCh6pmAdwlGKqWFFBrPG1f7?=
 =?us-ascii?Q?XyOHhTmewkkdTr5U08i8QWd/NhnC82tiz/KGH0qQJDez7oXjPw/MpURLXNL9?=
 =?us-ascii?Q?wRhwHsSd87qqgQLtpiruDx/RdbmxKsHYyoDkVtDmHyf4DfmHWhlZqueN+OO1?=
 =?us-ascii?Q?iO5hXjBvyohyxthVOm+qp4xTQAmeYvsw6kqgd7dKSCw35HE2dXGOhT3tAE0H?=
 =?us-ascii?Q?oGjS9gWkF06JLz2BLFminWU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A357E133E718B4F846A957D739EA11A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5HpDn0AzQZOBi9vTowTheC7JXFKVzFJEkrDicfWUsrXhE1AkRELPj8ghwoM7/xKCyCcIcw31DDzOyZJHmhRWBX0j1M17wz7s0eTAwfs7qfgZ9y0WtNvoDTLX0R1CdAQvIu19Og+Q33T/6Q0S3drpKM8w6vjgBf4bQ4a32VMxKoChV3hwzwzIlBffSaK6WCwChIlZ7gP9NmX0wTe/6S/3iErmnoo8uqi4gx6TDOL0zRoxxq8WA0nzOeJ3JABl1qht+nNt8A20UmpSbieoArqq6j6sVVbcVe3QNu3qwwzlLKe7WskhDDppSc8STjhEpwwxqTJAA+0ZJ1/51LpujWKJoydhha7MCNYEvFt1isLxEZ308LbhPSjgHykAcrg9Ugb6svleii8uXA7ruwwBIHw+/FcGHlOAjYLKeL4EGI/9b62GUGILahflcbVMbR6AFWFBr9IlhCn5KUpKwUfS+uzziMBgrMKjt1B4VgHiInzhGpxZsOxkEX8TLgiq4oBGEp9l8+CrL99VNyDb82Sd9gNLDxs/qO0Z/Z1mb87n3eYx3kKr5LQC3avAR1RJUyo02Q4fphA25fb+/JvW3kM7+AKtN+cSw8qIC4C58eC1UWAyLyrfD+IIPjAGB6v2yakKkTdI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6a62f4-b94c-4ece-af77-08dc9423582f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 07:57:50.3586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufQ/0rIR89iYO24ijxLvo74kVIGehgpU2uVhjE40UopRm0WMXc7c5Zzbtn70a4u3/pH9RLNnxHFcg0YFszMrxEteMnP0A66wJc16zmssyfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9505

On Jun 19, 2024 / 22:55, Nilay Shroff wrote:
> This is regression test for commit be647e2c76b2 (nvme: use srcu for
> iterating namespace list)[1]. It is fixed in commit ff0ffe5b7c3c(nvme:
> fix namespace removal list)[2].
>=20
> This test uses a regular file backed loop device for creating and then
> deleting an NVMe namespace in a loop.
>=20
> [1] https://lore.kernel.org/all/2312e6c3-a069-4388-a863-df7e261b9d70@linu=
x.vnet.ibm.com/
> [2] https://lore.kernel.org/all/20240613164246.75205-1-kbusch@meta.com/
>=20
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

I've applied it. Thanks!=
