Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36A17BA5
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159925; cv=fail; b=EheIizPdadTqUHr8wkcZMGxuConIqqliMJ90StrL5Mzn1V3LfDDqa2ipF8EnEZZxQkEUYhSqLWLMIleDzTZbnbJEnHuoVZ8Pd+Z+DaGRPELRbgTLHGbkGZy+NZwPrMHVywflmJlmr0bO9W8m4zRPPWiORGGaEJT11pZrfrP6f7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159925; c=relaxed/simple;
	bh=Mwq+b7OUXMOhbJVLZYKMu+dVmt3m11yJ5uMT7wTyYT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lnk1iRlPzZjK825uaLvRfxu3yiQ+Lyi69pKC6CmjQFVYk/Kt3kaVIcG3cKh//0kf/rDL1WtvPElCf11ByvA7j7iwmqvta6jXyuOwon7mQn4ct/BJYGJP9+pSHFJU5DnfEmK4LmoTaNV1tP8UvN//36StDHIljb0z/VnhobUVjG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lDP14n+P; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=w0cTBgBc; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lDP14n+P";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="w0cTBgBc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727159922; x=1758695922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Mwq+b7OUXMOhbJVLZYKMu+dVmt3m11yJ5uMT7wTyYT8=;
  b=lDP14n+PEU6GYlSuF0ypeBOd2nCzeM7lv/HqjwXTYYDzK3weN4zIymZL
   RvOYlXqqKVGs4V5uPOlzbbgHs2eGbi5b+Ksi5g93qo7cKniYce+oOsLZf
   u2kkS62TMsFARFhZWBtFySAAjkTwGF9odZU96ggjToeKGMO1IaLFhTb3T
   axTnJVOv2A/1ja6digR0QYs8yduDSMfrUH6ZdYDJW4DKAjGmBBZHdeNAJ
   c6X/D9iMtYp8TImO0AptSl412GSOhCGJ7DlU4aOW8AOSaCyeqf75db1yD
   kjce+5VI978RNF/+W+ZPpj/rt2ullmFLUPdRx0+tGzLIa18+IAafBiNqI
   A==;
X-CSE-ConnectionGUID: 0DT2FimBQ1eMQBqtkFWF7w==
X-CSE-MsgGUID: M+I3WO8ZRDKVviq6JX6YRQ==
X-IronPort-AV: E=Sophos;i="6.10,253,1719849600"; 
   d="scan'208";a="28264429"
Received: from mail-eastusazlp17010004.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.4])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2024 14:38:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2mauL5fzWqG5og1Xfc8nnpcjXMICyci4VEUCalnEhduE41ZCwV+eCg9jcvmHjBy53aIjPjR8Wc1hNS84dtxuKbGAOnEAL2EU+bFx6bRs7hUl3q4DDq3RC9x6DOq5Jq8xvXlRNSInIRJmXs2JW0Rg+d7gcko3QXi2XnZH0J0r53RnD2SHMeCex9j7CcRDcTs/sNBbYmGEebdY84rrn8Lw83oaf9CJ1BxHHPn16L6TpMTTzxbfAYrctTrBDFeZUHOSlmkvYKuC0/rPWsDO2k0hO3qL812BCcf6G06R+MhLSXfwVATfO0JgAAvuSnaDndmIrHCS2U6cCWo9VnnHpFXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R80NM2SJrbZAVSp6c7imTT71UURKG4fMBZMsrV/xkZo=;
 b=x92Mk1Yzii4zkx+IEz4fLztSbpFComo+sNBQMqAsbLDNwHnC0dY6K6ChnJTULzu0ROSuvmEOz36cJxwhFKqhln79L/oZRMk8asZwwMkCn3JlXgk52zO61rPBZXsd4OMfx3+nPp8Z/jP+VDXgOdq4FFMBUoQ00Mvpw6V8ldoCBt+KJJAHMJ5iiOa4+W27ofEP1Jh+apzZZDF13boV2HQoJ9naS+FU24eyiEjqn4GYAFzkN23Qzla5jiDtgILDZ/6slzl7iTDfq7+riQZMOdsznKLk3qTJWx+sbDhyPrOOdHCWJSUY+hgVbGu5UjpGAWCZbh/nvAPbn9MgyR9SpOjnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R80NM2SJrbZAVSp6c7imTT71UURKG4fMBZMsrV/xkZo=;
 b=w0cTBgBc8el3uMp5V2eiAQr3ycZ7kDfQnvRCpZRsHIjxhtixdZTygUeF6M8bAcPELjKicUooKp6yxNoT4Yqax59QqkEzHjBuWAUiTOfdAIvQi3AC1s5w8YJQWgOwhjfhOqi3zYALzyVERFha5uYA3hiQCEMiYrg+4I2EsWJ8RAg=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by DS1PR04MB9632.namprd04.prod.outlook.com (2603:10b6:8:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Tue, 24 Sep
 2024 06:38:36 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::2482:b157:963:ed48]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::2482:b157:963:ed48%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 06:38:36 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Jens Axboe
	<axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: Re: [bug report][regression][bisected] most of blktests nvme/tcp
 failed with the last linux code
Thread-Topic: [bug report][regression][bisected] most of blktests nvme/tcp
 failed with the last linux code
Thread-Index: AQHbC2hCx6Mz5ojvQUCjzyC2kqTb/LJk7ZWAgAGUXYA=
Date: Tue, 24 Sep 2024 06:38:36 +0000
Message-ID: <jhllwfxcedrcxcnbajwl4x2l2ujcqowqcd4ps574zrafrqhjna@f4icvecutekm>
References:
 <CAHj4cs90xV1t2NbV6P3_z1oYwD0BcvMhC5V2mGgekRq8iae=NA@mail.gmail.com>
 <CAHj4cs8YGgmemMZDXmt7yHa+Xq3EiEvRWOJGEQTDjqGB2rAogw@mail.gmail.com>
 <5ce3b803-275d-4be3-a9bc-87d06a8f5033@suse.de>
In-Reply-To: <5ce3b803-275d-4be3-a9bc-87d06a8f5033@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|DS1PR04MB9632:EE_
x-ms-office365-filtering-correlation-id: 04e44832-ec8d-4ba9-be74-08dcdc638476
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+9c/KREjxM9EErT19HPzu91QMZAS2gJZW24ys/DNRkI8qOulBrcWnaGNDIcE?=
 =?us-ascii?Q?4P1iz4LHiXBHPf5AdBI70CAZOudY3uOQu+dKrYIVYzZl/cJ7sX13+fptX9Uv?=
 =?us-ascii?Q?jK64uHsEh6aSc/sRrFulnrtgwVlVx/WLuVOpyL0jlJeq5ILhAzyZMh8hIRA/?=
 =?us-ascii?Q?RGIMKllwSkIgxhpOUVCwocjz+nZzRDxw55vLdu+RhtaPDXC0glb9lsD6fQcK?=
 =?us-ascii?Q?jtKNUC2zffd3JT8ryUjuqfhY6dUSnLZ0PVgs54+hkmUZXcNvFHPYI8dF9AYh?=
 =?us-ascii?Q?vTr1l48XGNLij7HKfRKzJM/RFzcK5mm7r5ydB2s8Aw2iiwAN6H7QMOm9u4bx?=
 =?us-ascii?Q?r2owSdvx/hT3DfPozuIf/f8PNYMN3D8FT4l1Esv2AVvORSAmHWdCeHnz5+3D?=
 =?us-ascii?Q?T9cM2y8YLT5ZYkoBjw9TGKFuo3F7EImNS234WMCEWBmqTqlhEXeA95eORZwY?=
 =?us-ascii?Q?EcCcRbhboPPBwHCjlsl8gA5PUFQPypbhm6NZbGFn5lSRykgd52YFgiwaMz+9?=
 =?us-ascii?Q?NBhu9axNEM0HqTo9egekEoZq59R6/2SQXHLdIX509TROV4axkBxq5IAVluih?=
 =?us-ascii?Q?3B/3VRN4EwMpZf2gfV7qgZZM96MCcwLoFYlfnNxa74fzse98xN17SlJPD7Qq?=
 =?us-ascii?Q?z1eaI8g5m6eMr7OobRuTOtTEXMmkS4BUZNB9bwgsivdxM4qAcTelONqEEoQj?=
 =?us-ascii?Q?s+fVGvQOfUGWY3yJs7yOEDbOBi5+ZdUmDLFljY1tPm6CBcn7yOst7J33kKVp?=
 =?us-ascii?Q?svjoxnqFcqRGb3E8QRcJ+AoH1j2Td4BZFS3nXO96m8r3KMX2NF15vgK76d7F?=
 =?us-ascii?Q?EB7Ja+Yvo4RIT9HvO9gyznty28dvSZj0LA1FHXh2Jv3qo+sCOdQaB1BwlCPl?=
 =?us-ascii?Q?JzLcqnCJqQ39FOzmE+3BIXeRqvavkLAsO2R2ZNHJQv7mmjtUSouWjusLPQdU?=
 =?us-ascii?Q?+JfnZ2r/RWku3fpISH3o+YNId8YkJ3yRzpCUfLnninnEHBolF4AXfD4ePB9w?=
 =?us-ascii?Q?0MGLcuAjA4jRArFdpd2DjHadjqyZYLKShfkw+hDFS7K31YqV1DNC33lXzXDa?=
 =?us-ascii?Q?djshheMbogwwhWlfn9iYNSTRLUNzpshMyIJC88iSxLv/WnD0D3MVM51Mac6h?=
 =?us-ascii?Q?RHAA0ahIG6CkciDPUMsj34T5wmrFqmqPL6A4+pRnhl/tRdBkEihlaiqv/OBi?=
 =?us-ascii?Q?n8Lu1qW/6KjxRKjtMckt6aH3oX5yk1SdKAGrQIo/As8bRfR3V6+easM3n0H7?=
 =?us-ascii?Q?C2htpcdRts1AeQpu4Ci1BUjLuDa7DkK/w1XMCqb9qxW2858vhX3IpfWIGPbp?=
 =?us-ascii?Q?XblPZ5sSbKo4BsHzal9CV+0tPJLLwpwEs2DzGb5/KejYDnSSX8ia6dxAC/ZB?=
 =?us-ascii?Q?98jleX8LQLEGnNEtMl8ndVdrIWQQj9NFtPuRPiFN7BgnBTDYRA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fT9ygIkA3apI2qtS+dwcqPrJTofPSeBSF5QOmR+Qznl3zlnPI6+XUpQqwCmv?=
 =?us-ascii?Q?fCLz9U7ADv7zEDFGj1gJnXKEuInqflBPig4bL4vpp+8Rwt+bf1buStg3BDb8?=
 =?us-ascii?Q?xm2AgHaOs+N8/t2r5Hrm9InI+i9Td8my3ICnSDGqUdKwIfzocrO1nvyk3lqT?=
 =?us-ascii?Q?XxcepzEjg36qDN9Twnl+zo1WkkNQoe7f2qpbQVWAYqhj+mTwXhPViPx9K2db?=
 =?us-ascii?Q?t8tfglwJCMarNgy2jLwXs5W15j0IJJRQ6tcRXHIkg8G1HYnQu16/ZC9AX+pI?=
 =?us-ascii?Q?k7yi6PbZ+zg/9avAswv69xXqSCLz0dCvA7tNUSu/KCQuj4SNQyryOmATJpNl?=
 =?us-ascii?Q?kDiV4q2CXfIxcuk7R8KE8iNnwn8K5reVbyGcN1DzQngQ8YUpStyBJu+czy1E?=
 =?us-ascii?Q?PlB/tbZYjC0bTfWG3X2WLhNL4R86arjwFFBgHnxnFrbVXG6+MdZpT74QQjQ2?=
 =?us-ascii?Q?gKg7rF3Am01usTHPDBeHb7t8WY8kaTNuYcpU75dvahJFxhbRGJ98TtGvLYw/?=
 =?us-ascii?Q?4qx5kmyQ8n4WRjXa9q51EKuhCkxE2WheS1KSpibcY+TemnqGREEiHPx4c4ZH?=
 =?us-ascii?Q?Gfe+uYRs4fcD5zLTdf4XFHV76aBGXMtt1BoF2a4/8cmt+DIO4pqoo4unWxTM?=
 =?us-ascii?Q?BcAqmZxulRIX4YZe8h3DiBw1Lh03uEjuwTX/N6cdGfKbC+3gbg4geYSIEPci?=
 =?us-ascii?Q?+L6Oc6DJK/1bkXLKZw6zHd7Aa3WKn6d4vI2U6m6w4XDtQ4/gTs9gS5KeKiU0?=
 =?us-ascii?Q?JxWHTo+ZthhppPsX0UUpBqhW6WciXX0g+mfqQadBCnENM3NXAhj8/E3rnEtw?=
 =?us-ascii?Q?VDPl3mNCH/CcgCGUrRmVE6mVaEIkuShceWlmrPSb/kJI4Jk5diA2A5Pih6Nl?=
 =?us-ascii?Q?rQJE79ajfpaKXp/QISoTph0ypDeSIoWdi3MikaPIxuuz2z4sfIfjBqi34dOp?=
 =?us-ascii?Q?IqxsU0NFYm7clgU+/p60P0BXxR4r8BEtpPfD2H73azJNXrxMR5vq1paTzmds?=
 =?us-ascii?Q?qpFDFA1HWQu2cibdRbWxKiJAJhL6SaeoaWDwtT5/oMdMC3K0Sk0HqDorrItH?=
 =?us-ascii?Q?ckrVV59pGA3lKpApY5kISSGMQtR6poQ/TSninqOIy81OWSRbijg/2BzVvgin?=
 =?us-ascii?Q?JapVqe2wxbAzrFQwyOvqBY9AXewDK/3tY4HcyChBOPyx+0I7Yoza9aCSgjza?=
 =?us-ascii?Q?2SmMOPc2XrajQtQynwsQYgclsj9zefyhPexgMZ7OxIKg6MD2LhoucdgZnqRW?=
 =?us-ascii?Q?9oYl1EuYXCvqJ0bKEEYqpcpfvDuA6XoXDLpiczc+85+avrVfTw8vQHHXcfor?=
 =?us-ascii?Q?H/X9Ofj1AhKN3NwgHHg2j1kJO7CbQynnSCVwGDeAtpwhb0L9XA7PXEUEKDPP?=
 =?us-ascii?Q?WJFniq34AVFv6YvLsnU+OCiG+ZfOf3Ltb36pqYJx0x4WYNKsSxPhP1K/VK+k?=
 =?us-ascii?Q?A34aCrQll0mVsNeEwNqQfURWDnqvxp4QllcyWxmAFwvSd6FETKMVFs10COuQ?=
 =?us-ascii?Q?JO4XQ8mQtiw7g7r1FdwSD5Z4vmTe1RFgM+nVkLrduDgPS44A7xMV5TQNCSma?=
 =?us-ascii?Q?lgEAaPUdI+Y4ygPhqq5LyjmxgYshktBcKiy75mze0JbccH0NUy6yqlC0Bin6?=
 =?us-ascii?Q?N8lHKgO3oo7munDQRW9VqwY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C59D7D84F91764E9E5C514DC08B0F68@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6QaaRLq/RcorYBAeUtOWC45NZshjU30xtkgO1/4WIqVkIfWsHk8aNuvJX/VASk+e5c0KCG9CxV+tZr6ziD2Qw7il2EyVeW2JItTOFE2huZBDWKL0ufk8ciqbmpOGSSPAx3zv64AIAgH+cqtXbKXYJEnJtkVi3HuyDFbeYucSs5S9xuOlPWDjceKLd2Px9zzsuyEyldhF8ra6h2QLnwJ/47x9H/mnoKu8xVn5SlZAnpf9+6WqR9/FJzmj7Yd6TzxC4r8rM6CCeVFsySuZTHazII3TiYJKbiQ1d4rIRdgXw/DfhnPZb2bEo59YLrsZsvLA+Ta+trGhttwynisK/R45elJ/3KhqOi+CEdImmbSd2eJOvhi+6TlU5gdjtZ9HqXZD7YOwUZQ+lOzoxPFGghHFDHqGTEnoyIHm/AH7lz74xmvbDZBs+GV4xWacPq4hozKVUEq51lzI8Fh8MSMnnvkh2jc4aGfpnYMSVWwMjUUhKzKZ47PO0nqRs6uHjuyNJ9BHiwv234H2ObUuAwaQupvgpZIwQcHjx+kTKqvXoSMhlj+Fl9C3TR77e7Q7NicVsjlN4nTwwnU/LBNPjvOt9LQVy9jf04S4HU8aAvXYBLSI+BlG8cmLoxLIkHR2c4bo3Dyr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e44832-ec8d-4ba9-be74-08dcdc638476
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 06:38:36.1735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOwy+GEnjEEzWzFhZLSHFmTe8+gbV47/tOND6sDB71nDpAmciTofKWLG4yYUXg9KEM/86Q6+gX7ogiiTDV6CKdFtooL9FVoykFT3cVX8nd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9632

On Sep 23, 2024 / 08:31, Hannes Reinecke wrote:
[...]
> How utterly curious.
> This mentioned patch moves some sysfs attributes to a different location =
in
> the code. The stacktrace you've posted indicates that we're creating a
> controller while the previous one is still present in sysfs, ie that the
> lifetime of the controller has changed.
> I find it difficult to understand how the cited path could have changed
> the lifetime of the controller object, but will continue to check.

I tried to recreate the failure, and observed a very similar but different
symptom. Kernel reported the KASAN BUG global-out-of-bounds, in
create_files() [3]. I confirmed that this symptom is triggered with the com=
mit
1e48b34c9bc7.

>=20
> Does the error disappear if you just revert the cited patch?

As for the KASAN BUG observed on my test system, yes. To be precise, I need=
ed to
revert two dependent commits 02a3688c53d6 and f5eb7397471 together with
1e48b34c9bc7. With these reverts, the BUG went away.


The BUG message provides some more clues. The BUG happened at line 54 of
fs/sysfs/group.c, and it indicated that the loop to access grp->attrs went
beyond the allocated memory. And I noticed that the commit 1e48b34c9bc7
introduced the array nvme_tls_attrs but the array is not null terminated. I
created a quick fix patch to add the null terminator [4], and confirmed the
BUG goes away.

Yi, I suggest to try out the patch [4] and see if it avoids the failure you
observe in the CKI system.



[3]

[  717.749561] [   T1361] run blktests nvme/003 at 2024-09-20 10:48:30
[  717.947434] [   T1407] loop0: detected capacity change from 0 to 2097152
[  718.007387] [   T1410] nvmet: adding nsid 1 to subsystem blktests-subsys=
tem-1
[  718.200391] [   T1417] block nvme0n1: No UUID available providing old NG=
UID
[  718.246928] [   T1417] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  718.254856] [   T1417] BUG: KASAN: global-out-of-bounds in create_files+=
0x3d8/0x4c8
[  718.262257] [   T1417] Read of size 8 at addr ffffdcc298356e38 by task n=
vme/1417

[  718.271572] [   T1417] CPU: 13 UID: 0 PID: 1417 Comm: nvme Not tainted 6=
.11.0-kts+ #3
[  718.279140] [   T1417] Hardware name: SolidRun Ltd. SolidRun CEX7 Platfo=
rm, BIOS EDK II Aug  9 2021
[  718.287919] [   T1417] Call trace:
[  718.291053] [   T1417]  dump_backtrace+0xdc/0x138
[  718.295496] [   T1417]  show_stack+0x20/0x38
[  718.299502] [   T1417]  dump_stack_lvl+0x70/0x98
[  718.303859] [   T1417]  print_address_description.constprop.0+0x90/0x320
[  718.310300] [   T1417]  print_report+0x108/0x1f8
[  718.314654] [   T1417]  kasan_report+0xb8/0x110
[  718.318922] [   T1417]  __asan_report_load8_noabort+0x20/0x30
[  718.324404] [   T1417]  create_files+0x3d8/0x4c8
[  718.328757] [   T1417]  internal_create_group+0x354/0x7c8
[  718.333891] [   T1417]  internal_create_groups+0x88/0x140
[  718.339025] [   T1417]  sysfs_create_groups+0x20/0x40
[  718.343811] [   T1417]  device_add_attrs+0x35c/0x478
[  718.348514] [   T1417]  device_add+0x540/0xfc8
[  718.352693] [   T1417]  cdev_device_add+0xdc/0x208
[  718.357221] [   T1417]  nvme_add_ctrl+0x120/0x238 [nvme_core]
[  718.362754] [   T1417]  nvme_loop_create_ctrl+0x210/0xad0 [nvme_loop]
[  718.368934] [   T1417]  nvmf_create_ctrl+0x318/0x840 [nvme_fabrics]
[  718.374945] [   T1417]  nvmf_dev_write+0xdc/0x170 [nvme_fabrics]
[  718.380692] [   T1417]  vfs_write+0x188/0x5a8
[  718.384785] [   T1417]  ksys_write+0xfc/0x1f8
[  718.388877] [   T1417]  __arm64_sys_write+0x74/0xb8
[  718.393490] [   T1417]  invoke_syscall+0xd8/0x260
[  718.397929] [   T1417]  el0_svc_common.constprop.0+0xb4/0x240
[  718.403411] [   T1417]  do_el0_svc+0x48/0x68
[  718.407416] [   T1417]  el0_svc+0x50/0x150
[  718.411247] [   T1417]  el0t_64_sync_handler+0x120/0x130
[  718.416294] [   T1417]  el0t_64_sync+0x194/0x198

[  718.422826] [   T1417] The buggy address belongs to the variable:
[  718.428651] [   T1417]  nvme_tls_attrs+0x18/0xffffffffffff21e0 [nvme_cor=
e]

[  718.437514] [   T1417] The buggy address belongs to the virtual mapping =
at
                           [ffffdcc29834a000, ffffdcc298374000) created by:
                           move_module+0x33c/0x5c8

[  718.456989] [   T1417] The buggy address belongs to the physical page:
[  718.463249] [   T1417] page: refcount:1 mapcount:0 mapping:0000000000000=
000 index:0x0 pfn:0x20b8b73
[  718.472033] [   T1417] flags: 0x2fffff00000000(node=3D0|zone=3D2|lastcpu=
pid=3D0xfffff)
[  718.479170] [   T1417] raw: 002fffff00000000 0000000000000000 dead000000=
000122 0000000000000000
[  718.487602] [   T1417] raw: 0000000000000000 0000000000000000 00000001ff=
ffffff 0000000000000000
[  718.496033] [   T1417] page dumped because: kasan: bad access detected

[  718.504471] [   T1417] Memory state around the buggy address:
[  718.509950] [   T1417]  ffffdcc298356d00: f9 f9 f9 f9 00 00 00 00 00 00 =
00 f9 f9 f9 f9 f9
[  718.517860] [   T1417]  ffffdcc298356d80: 00 00 00 00 00 00 00 f9 f9 f9 =
f9 f9 00 00 00 f9
[  718.525769] [   T1417] >ffffdcc298356e00: f9 f9 f9 f9 00 00 00 f9 f9 f9 =
f9 f9 00 00 00 00
[  718.533678] [   T1417]                                         ^
[  718.539418] [   T1417]  ffffdcc298356e80: 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00
[  718.547327] [   T1417]  ffffdcc298356f00: 00 00 00 00 00 00 f9 f9 f9 f9 =
f9 f9 00 00 00 00
[  718.555236] [   T1417] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  718.563206] [   T1417] Disabling lock debugging due to kernel taint
[  718.570790] [    T477] nvmet: creating discovery controller 1 for subsys=
tem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress=
:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  718.588532] [   T1417] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress=
.discovery"
[  730.521978] [   T1514] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.n=
vmexpress.discovery"


[4]

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index eb345551d6fe..b68a9e5f1ea3 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -767,6 +767,7 @@ static struct attribute *nvme_tls_attrs[] =3D {
 	&dev_attr_tls_key.attr,
 	&dev_attr_tls_configured_key.attr,
 	&dev_attr_tls_keyring.attr,
+	NULL,
 };
=20
 static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
--=20
2.46.1
