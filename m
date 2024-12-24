Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151114A099
	for <linux-block@vger.kernel.org>; Tue, 24 Dec 2024 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735028801; cv=fail; b=Vxn2XfP8gIF071W6CqfId0QBBZQs/Ha4wV+yJ9uk9LlIj1klhEc4LsGlCHG5CxR8Rmm3cg1NKwyvozMQwsr3IbPcGtaMx1v9NK/mMS0nkpqKZb6IsgUKQhAvYuVKZg3IWycsqrpIVQwr42NuK4Ufz7k08VTC2yfaFSVqH0OEkys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735028801; c=relaxed/simple;
	bh=TJ5QuvxVwo6NMCd8+m+U70a8g/o2ZjP8FdoTkzgTN3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VPUNnJXeNLnmA1gjrsPtUGwiaOJMi8cMPcqOmNuCyMjKafAySGw/e92MgBLxLZhPMSuQwJ+xXMDpfT9pUIypvsG01AoqO8CtA6npbpimr/jLsCDKz7R1HDTN03mIWmNGpMbl9N0/a3HGGezwMWPwLlov7vKnEi6npTDwcoGaIYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iUOKV+bv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ub9qfCmv; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iUOKV+bv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ub9qfCmv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1735028799; x=1766564799;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TJ5QuvxVwo6NMCd8+m+U70a8g/o2ZjP8FdoTkzgTN3k=;
  b=iUOKV+bviwnrY15FkajjEAG7PtUhXV/wdQcXGjfkVRdxfCNV3GoEgCdU
   A8cokwoWt+xfDTTS663krQiyWDF+oQnqAqwgTezJmCc6fqZWxS+0B8x40
   Ap4aBJeKChiqV0e7KVP6aCOk/j8/+EKqcksD9iH+VMugPDlwYtkjcMBgN
   EzqgEv1VeiGBTqVHCnbEMBnbDhZugfhW+okdbWkdTztCChx8zveeTOak9
   ysiIvw7POzue2jEfdIX2xaSr5TThQC0KQ0GlvmIC2AE0q06ShWbb7Ucix
   3JmQ6T42XS9Yvy2ja0kjSkkCpNsxtwGlzICICWrJAoZCzK77Aux8BBxAg
   Q==;
X-CSE-ConnectionGUID: 6GatUK8RTYqPMVMvyZFqzQ==
X-CSE-MsgGUID: AgIeSvmETfCPADvkgtVbfw==
X-IronPort-AV: E=Sophos;i="6.12,259,1728921600"; 
   d="scan'208";a="35743834"
Received: from mail-southcentralusazlp17011024.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.24])
  by ob1.hgst.iphmx.com with ESMTP; 24 Dec 2024 16:26:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTCFKdo0AQv9EfQoo21+W29cupHsfSfBpML2QcnGGgGWJnAXr46uUiDK5XusOUB6DbAUkZS2KALVJF3AewOVqNDKkG5nMk6tJiuyoVV8m+xcLpZ24xLVmFVuacQ+Kgt+fdIs36DzfCgiyvSILBQs7AhWTczoKzG9JpCq2Sypxd9jdxzEBxzPhVZUJ9bB4t2cmK3MR1DJWvn9Yk2Qx6k7tRzmvhBTez45DGJu2fikK0P/rZi9SWjhKd0MIpxXNsXaVA4mWAGgshIsJoqPPknnS1ZMiShUTzDV765LkX01hZWQFcoxEDR2KCvzwva+nnKTwA0nYTdbCy6MzbDIYfk/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHmhLLPaZKk46QkrbinQf3yjHtmy/F4qSe2OkDR0QHw=;
 b=c7ADj/uuKurcv9z0fLPYY+KLlCfQp0uUkNESpTGRVUEXYjSvPCXk7X3QCo/3W4I+YOh2GO8A0vvP6zjEEkNuZcx2yBXoKfPm6jR4m0WVGUkNMzdYtss37cNKIz5ku2EveLi3HldHT+7/kLnfH4qEH64usQqGGZQn//hbJEWudqWK5TuBa8nevIsgES89bOSCYV4CoA158mej+B2A6SI7OjyRbFOq6Yq8bnSypS/5UCoRhs4smw2d2tVEUjRXgaWN+BpLM/Ehvbf5hjMziUvLDanZ2C/C8DFdk/XudUrGoc0O3vUYIUp+XuIgaH6Y7CePoB78RniI0IgKBztojUbOnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHmhLLPaZKk46QkrbinQf3yjHtmy/F4qSe2OkDR0QHw=;
 b=ub9qfCmvhHLmSNUnO575yR6bZZkiuGkAVDzXUeBwRoAeKQiT7hpfqruYd5ZitynfI10f+3i9CB66Tnmg1MsxaCfxU8yogpAwdTjiSuGlYw/pjNG1X34lbyaL/ft4Uv5dzfkNhBxoDiwLJAL6D7g1TuGVvNY8ZLcxk6KuogmV5qw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6469.namprd04.prod.outlook.com (2603:10b6:a03:1e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 08:26:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%6]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 08:26:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yukuai3@huawei.com" <yukuai3@huawei.com>, "yi.zhang@redhat.com"
	<yi.zhang@redhat.com>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"gjoyce@ibm.com" <gjoyce@ibm.com>
Subject: Re: [PATCHv2 blktests 0/2] throtl: fix IO block-size and race while
 submitting IO
Thread-Topic: [PATCHv2 blktests 0/2] throtl: fix IO block-size and race while
 submitting IO
Thread-Index: AQHbUVLiLVZTxSc0kEWUkXxQB+gegLL1GGoA
Date: Tue, 24 Dec 2024 08:26:31 +0000
Message-ID: <3bttr4zv2clzes6q4cuyy3l35ls7cm2r6ljzcgzc3cpvut7dmn@grxcm43s2yse>
References: <20241218134326.2164105-1-nilay@linux.ibm.com>
In-Reply-To: <20241218134326.2164105-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6469:EE_
x-ms-office365-filtering-correlation-id: 88ad07e7-472d-4436-eb03-08dd23f4abad
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JSmIKkQe6PsNIxRNy3qbK3ZaPk5MoUe70KaPozwWI32qEqv3v7s+EMmrksue?=
 =?us-ascii?Q?IFh/r2L1C6TGD9LMNDbAcbnwO8PQWPcCj2xc1IxshXhyiCDsEy+SxMMInxJr?=
 =?us-ascii?Q?51j2Mr2jk8Gpd/FdqsRc/jK7z9Z1TINvXl1BpfUu/Lu2wteyOfcKg5W9Q5mj?=
 =?us-ascii?Q?fLm+PCFXdO6zYdzL4XInKbj3k3oieNMuyu0NqSRM+mMw+hVYCJWhUWwGNlU8?=
 =?us-ascii?Q?H6IeEK39FitcxSVYFjI69QHKJEeZO6tlP8LyQFIZr6gB5X0t/pLHItRniA/3?=
 =?us-ascii?Q?RsBId9nt02pEAKehyighOAmN3rwJhutiEDVFhXAKJt6lFhnVKFcMyuws6OLs?=
 =?us-ascii?Q?8dDyXOA+A8krZ0aQqT6nqdDaMx3yy1Y98ulnufzw6FTaY3/tgZwGBhAXaCUR?=
 =?us-ascii?Q?l/+XkEGYvq8yBhoPy0ZxvA2BPDStY/VRorvcACNdbFlePvxvECkEBiffMSRg?=
 =?us-ascii?Q?NJzT/mHtS0KZ/V8DUTnqpXKieKBZkB6b7rGNFT7acpR6ATWg7YxtuAbYB4QR?=
 =?us-ascii?Q?C4LMnHaZTyZUZ1GsVYDXQOy/MypOqkhnmrpCkF8DfSxB1+c8cj0by9j6eEYg?=
 =?us-ascii?Q?yQcYpQOOpaOhKZb5cF51rjF+opD2zxrzB34++4V/HlQr3ypv58VEy47RYSzg?=
 =?us-ascii?Q?iGeO2FYHy8ROUoEpDoqHvPkP7ZX0cmFRazLIby83g/5dpmk+RLJW2Yod6F90?=
 =?us-ascii?Q?imxuzjvi+AVUHnSM0IJ6Stf79V75pTUVr3Nnet08s+uWRcPMH2Hht2TLsWQl?=
 =?us-ascii?Q?aE1bRN9QBLGBGbM70v4aEjImPx3zKKot99enlwbxRdARH6OwvY2NsHXDRNcC?=
 =?us-ascii?Q?jWoxDXoR2o9Y36hjgM0kWBDKj6kIg1+HIqc21T+3gVJpu+VQ7jypjFceQPyY?=
 =?us-ascii?Q?AAwyg6gmGfaIcmVlD0H2m6fz53v8ktyENDxUhl3y65LOVRI/tHKscxgegrgL?=
 =?us-ascii?Q?W43ZQAR+/ibE29Zdl3LXA1yAgpvQBprvn3r0Angl0cFkxognKF5M4RL3zmEM?=
 =?us-ascii?Q?jdQD0inaqNacKqg+vnu5bdHpTgQx2tF8jehUkUhKoyx4TwyOxJSkRymweIe4?=
 =?us-ascii?Q?MsYvczuWs92Fing9C2R/w2VNJex6iGZb0TQoBOi0r96vdbGSgttlFCl6Ri93?=
 =?us-ascii?Q?l8p49/7T0Rjf6TKQ2czcndmLnu/ISYhPpAxYfOSo0SlLqgGyl0PRjmGeIzGQ?=
 =?us-ascii?Q?WoJf++8GXxmuIW3A7GgAAnODN5P7hXIbKis+dYdY9LRZqsW76TLUofgH6yfb?=
 =?us-ascii?Q?Stjlot01IbB6+4P0mRAUUHR7zwjWNgatnjMmQdbJCKFR1kPeHeK93IN3JgDF?=
 =?us-ascii?Q?ngWgbWHXzwf8vklW7ZzKDVUtu/78E2fyLP54Uh57Ylc3Mg8zr4OqFjeUboUV?=
 =?us-ascii?Q?Mu7BZFHmfE8WON4wkWxq11yC4P6UGBEvRdy/RAWmM1LW/4FIBta4rQt5rAE/?=
 =?us-ascii?Q?9Y4/AqpHjSmYwNAIvCpgpO8n6mFow7Lw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?T6aJQkKEQ5mvDE2VJnMP0JCDgHRa0q5w1+yf/B4l4e12sodWD/lc3W46M2OQ?=
 =?us-ascii?Q?/XKZffY6DgNoLnur23HUlXDUoX3+IJPm+U2/dcC+Kon8Tt4nR80ATEykvJdD?=
 =?us-ascii?Q?Ocfxd8kd4FLyXVJqdZb2xczcsvz6Y/915s24MLzqBQGHgOjYSJBA2/mhzLc0?=
 =?us-ascii?Q?KO2WO0OKW/0FOR6lNOKoQGYgQ59+bXtj8sxPEG1kvOs3ui5rI6EnwdSc4zpN?=
 =?us-ascii?Q?z0jC3oTrUYVw16oO/uUeM1UqKk5NyXXXZbGNKMk5DknXAYg+BdQMuApVjFZM?=
 =?us-ascii?Q?GMarZ9B+TsmXu7XeD8jioeYXcMUu7Y4BCJ3zhlOeR8G7NPtJ3A0WXWDFLAUp?=
 =?us-ascii?Q?y98BU0EcOjywGNi1w7nTBAhjP5APMb01PZZF1Xwhv8HIzgEWLFy5TczVzQ4q?=
 =?us-ascii?Q?QK+nNphwPaccPKXJnXXOoLXzPktvoglhmGNOPwQYG0H8/KSILn73c5nUrzQe?=
 =?us-ascii?Q?rQ9Ke9hAGJ34k5QWPyUx/a87UEw8cj+WqkXuo1PCIpwYecf98u6JDatqsGIx?=
 =?us-ascii?Q?eipy8r/lB87yD0LIaEKrAEVK5l+QeoFuc9gcxnZV+ZRRktD5P+X614+gtT1s?=
 =?us-ascii?Q?5/1EUId/rjpfMBDH/q+dd46+30ktfm7aIeFxIIiogw7FYwu34TS9AYjn+G4j?=
 =?us-ascii?Q?w+a7Dk+4PKBvY9WJJ6QS4sqpP91SdtoYGu9ybe6VqZAd9y8j9J3WCqJMcQwg?=
 =?us-ascii?Q?zZw8vglQyOrXrZl2IVeIOKkj6twfzigRLIMD98HVyHcGVAWyWRnLoOWS1jFG?=
 =?us-ascii?Q?mdFbUX0bJ1Mer50/sb0KbguAt0DdhENu2JPGUUiJfeyKuY+CvmNxI1KRKca3?=
 =?us-ascii?Q?IYDmTbLbM1PagyXxe/YhJd+f65VuwJfokIXijgWsUKA3pStKD7VkvpBn2B29?=
 =?us-ascii?Q?okdph2EtAvABRWsMyNkPIfEKrgjqtGq4VuOKGlkZhVmKymXYfBsV6/PT4L0a?=
 =?us-ascii?Q?A7KptGCa3FgHamy9u+uIH0Km5Y+YZSN5rBoAkjQvBxTxLFv/ZneNrJdItr64?=
 =?us-ascii?Q?N0P7lRhIAXvrDn1snseAk99Kb13dqFH60oQzYUQazeT0pSY09zYNLoEvkiKm?=
 =?us-ascii?Q?peYnFQeZZPDQHA5O+yEOUaLqgw9W/oMzqGiVnxsGTGTpO5p2r0T7Xcpw/275?=
 =?us-ascii?Q?qd8ola9RPaqXRlX8RocvAGXNQewQfTHAT2mR1PiozwSwy9OeZRQiC7fwLcS4?=
 =?us-ascii?Q?mXVf0tg8MzMNsz8CerGL15ERp5kUCXxuHgp2MBBk3uLjVjdUxzJy09qdz0Mr?=
 =?us-ascii?Q?nFZcnQ0lg0DrdpWY9qzfKCDZwpwE5CQ1orOGsPz8omtajXkNriuZNrx9x8W1?=
 =?us-ascii?Q?XSrqxyOsVcSGuDJaH2IysuH/3dwdlCkN4qLVOufKuHCWWIwJCI+n/vZkcUJ/?=
 =?us-ascii?Q?OvxVRZEkGp9iguBfAGe9gdSUygjdqu89AOYwYkJ14qHhp31M40GFE/buTWJJ?=
 =?us-ascii?Q?Mt1BpZwpKvXdvgVnFSYe0CWXzWWG7IR+72omDx8F30Ecr0Ji8W24g6vV20+T?=
 =?us-ascii?Q?+U4eaPzQhLPn9a/3yt72pZX2jscMP61kTtT/AEluggF+5nqbCutlkybMrwQV?=
 =?us-ascii?Q?H1ir5DOauXDi8vpi1UY7QgHFV8dxYwDhDzLz5hE7fso4uveM8oUkpgH5k06n?=
 =?us-ascii?Q?HDPEvE4spRz6x1iteT9Dke4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EEC0BB374F67614CAF676C436DBC342F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n/mOeboNbrSILvU5WVdaXTh/ENjHGUheIGIWYyiVMrzR3vzqmJaSYR+9ww05zq99mSZ6w52sfe5eY9otSBiAzA4U4MXKCBvJiLqkxuP7EZuMJufsEZ+kEGnNNIiLP46li8qba97hDjk7KNt4OWdFl+ip1Rcg0uZ4qxBw91/MZvy0FURL/6vIizWx4JiiMbxQFSoxrYUcFvc2WDdH2GaUzzpmG4d17a4CTarLtr5hgJfKbwK4dIOGQwKHYUf3x0ONHAuUeYGcoAWxlNAK16Vc/uYSnj25CKYToFIIUNJwQpikQdHucgQXA3ba5FZMd1EcC7TWd4TWaRMo3dtzyO8CvOdFsZzQ7ZcSuAXnLv4MeW32ybesI73vCAepS02LFFb3YzrfqzZdArEQ7qmfkuUhH+dSPs1713HXLKl55EGbNePiVN4W4llFHh9mMIJR8HG+QXGzUXF6T6oSoG316eCXV2ywcEBQzJ4un30eY/41Fva3c+zn4Apm+wVquyBW4Iy1Qelq3cYlbFsV4Uup4EzipSQ+tGlvqNh/JMdF4qcym8q108+JL28Zze83iOXFWi7hDV93G0X9Jf0BaokrGuhZdOFomNatDj5YUnr9kAOIXRveAOJiw4JAJK5ccd3vAjqM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ad07e7-472d-4436-eb03-08dd23f4abad
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2024 08:26:31.5439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVTud5uUuZhKNSTTzgMUKQd6TaOEnB+E8eSAYAqFzgvq3cRyfQm02ACwctbxzcJm35iRw6/vl8E8GX5dmiFCBpmoRr2vTF5M8KGOHGrjMlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6469

On Dec 18, 2024 / 19:13, Nilay Shroff wrote:
> Hi,
>=20
> The first patch fixes the IO block-size used for submitting IO depending
> on the throttle device max-sectors settings.
>=20
> The second patch fixes the potential race condition between submitting IO
> and setting PID of the background IO process to cgroup.procs.
>=20
> Changes from v1:
>     - Use $BASHPID to write the child sub-shell PID into cgroup.procs
>       (Shinichiro Kawasaki)
>     - Link to v1: https://lore.kernel.org/all/20241217131440.1980151-1-ni=
lay@linux.ibm.com/

Thanks for this v2 series. The patches looks good to me. In case anyone has
some more comments after this vacation season, I will wait several days bef=
ore
applying them.=
