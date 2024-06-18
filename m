Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6373F1AD9E8
	for <linux-block@vger.kernel.org>; Tue, 18 Jun 2024 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699910; cv=fail; b=UUR39DIrORCOvBrdTwn72sAwy3a3/FopV9z/GP+CsbrykJoIbBVx4p0c0nhS2FfgKByZTU9yV3SavPnjWHoosV1puO4uuRkknthkkL881Tn9vJ95gdIfcU05QOgudb+3rmjcaSCJ7LNWrJ9LsBH8adpV8hZQXrUxaHbuKKBpayg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699910; c=relaxed/simple;
	bh=B6O4HmB4HqiefVhvsx0johvaKcC28T6TK42mmn3oX/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rglS2nv1XCEB6DKAiVuhz39c4hyG25Aku5HcVFCfF8thHLa4/CRdzqEjU1xIQWsZ4LLqH3MntQzyaPDOp9Iq006RFMWDd2q9tiL5WBDu16aZxL4l7/ue55/pG2gc/q29se8ojxgzapg9NN0q9hnCV/UwRXHY0OK0WMEyi0WJ1hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kfhUzNgS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uIszZ/9+; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kfhUzNgS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uIszZ/9+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718699908; x=1750235908;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B6O4HmB4HqiefVhvsx0johvaKcC28T6TK42mmn3oX/o=;
  b=kfhUzNgSzfs6uPC7L8cNx31k1BomZpn6tSwj1jIe51Q5NQ10PPcC64mP
   ulnROfTmmFLwX1r+55SsqvUpwuxzHLHRUYddhfDRaFsdgX/PX5UVLlJjn
   FBWF2cA9oeUm8zP7zy7zFlAXdxsc/cpoBOnH9Wushur03T7C+yPNESzA/
   QTk3mvIkKTUpJ110EKtT/npMJTS0kPjLHYshpMNJ49GUbBC6GM7at2oOW
   XAc2DTH/FiPGHqrJnvwKOIRQcGhzfMVmuycr+zXEQPheS50rfRqbZAfOq
   /6FX6r57q+5DDfvZc5YYGUDSS272F0QKthwwqY2tEi/3u7X+rlSNxjacp
   A==;
X-CSE-ConnectionGUID: xzS6oGgYS3GUwtlVtQ8tNA==
X-CSE-MsgGUID: ojb+e7xCSx6DlmSrwwtI9w==
X-IronPort-AV: E=Sophos;i="6.08,247,1712592000"; 
   d="scan'208";a="19696901"
Received: from mail-mw2nam10lp2047.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.47])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2024 16:38:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzsGwnDUxfzD+vXFXOzC2C5JIaLIXut0oZhmRC2+aVxKZ5BLv49RVOc1R4nOxQOX8oC95R2IWFctMBBmBTUIwk7EO1Zsgl7g4RKPFRL74fWWmv5WtKeVvRUIJ4yT+pCf1nsZHVxoQZ6KObpkGn3uY03MTzJhb+49jgSR0Cyoj70wbW85qad5/1IgcOQTiKJYLkGnQY76Alg+wfyEL+ibtJK3WsxFwD2xqUhZX1CAyy959YJE1SQqnD5LWSqJlBQhwuwEXzXmL3z2I8ee3Yq4Ttvun3iESxW3WF1TvEqjCYbMPlJ11HIuXCTHvukRZuLYlnrcxhU5TX3RUZOAf5fp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6O4HmB4HqiefVhvsx0johvaKcC28T6TK42mmn3oX/o=;
 b=BbdKEHOT266LFf4qvnrJFZ6lNgswMgzQMySHHIrXFreIBiT/sEuQmILpz8z/l5w6QH9BqCLb32kxKTQYx7fjQ3nQ2rylOyNvol1F8xbcZ564Upk+khaQK53LZ7t6bZZi/OHRuPR29e02wlUrvIuCjBAO0HDWfxMCLaU7pcGuxwubaFtI6oyYhDDfl/5P3nYM4wkBIQukrChGIjjXCfhDnqcEqxkNtWh8oH2lCHI+60JtKiduBgpNHe0UdbQJhgpH+xrLw9PeCKXCMIAELGR7Ld0kn403HquwmFa3JQBJedHTm35ByQphoKTU4oXw83C+yjvlM5lAUXEdtlSZ3RFEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6O4HmB4HqiefVhvsx0johvaKcC28T6TK42mmn3oX/o=;
 b=uIszZ/9+3Hhsyquj8NhDTCQ+8CGQVNnxPB/s+jFTdP2mBHe6bmhFj3kMmTr3eROVH4f3Z8wUzkif5N3bsGHkH438af/drQPSEhenT6m6G4QfQxvO7snW2xLm1H1C7VaGSjPjc3vSgayKmZ6MKxQNJeO4iE0NruaKJ4z1Xx9ednk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA6PR04MB9326.namprd04.prod.outlook.com (2603:10b6:806:43c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 08:38:25 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 08:38:25 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ofir Gal <ofir.gal@volumez.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel
 Wagner <dwagner@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests] md: add regression test for "md/md-bitmap: fix
 writing non bitmap pages"
Thread-Topic: [PATCH blktests] md: add regression test for "md/md-bitmap: fix
 writing non bitmap pages"
Thread-Index: AQHavY1+2yGNDI7RnEqMuaOkwQh00rHL2PmAgABMY4CAAJv1AIAAanSAgAAO4wA=
Date: Tue, 18 Jun 2024 08:38:24 +0000
Message-ID: <edemct7jaeuhy6qugbpuilmdzdyy6xvj3diqdliw7z2tie2vgw@ccrxm4cvlr6h>
References: <20240613123019.3983399-1-ofir.gal@volumez.com>
 <cnaunh75p4p45e4hgdaeaqry6whwdc2pqatil5v3oxjitwobda@p2oqftzlwv2r>
 <34ee55e8-a23c-4e7e-b897-cfbcc8337136@volumez.com>
 <zbeftlk6oti6uh5wx6m5ijvlvjv3xpxoqa6pj6mlasdr32eqfm@vyc5i3gyyj3s>
 <8c121c1a-a100-4cda-98fe-393c593e2f9c@volumez.com>
In-Reply-To: <8c121c1a-a100-4cda-98fe-393c593e2f9c@volumez.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA6PR04MB9326:EE_
x-ms-office365-filtering-correlation-id: 64d5ed7a-bdcc-4714-a69f-08dc8f7204d9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8/H4wAomYnKp7Svpb0qlZ67U2fwT2ADI1I+kB80YTtsG3FAbM6xBE7HpQnWU?=
 =?us-ascii?Q?EtQoSXByiWgMvcsXwNpx/GxfpfKxZeV5kNoLeI34weO0wBHv0G5vb0LyuMMM?=
 =?us-ascii?Q?igO4qvDBdInOp9McVm6GsjdFPLJzuLup8gRi6nCtuUDCOG8cZm0fQFGIr9jQ?=
 =?us-ascii?Q?yKqustRtKZABv9ldGC8nxkTEYCewv8tImhyjiiiHySBZ23/CRkj16r/aJlN3?=
 =?us-ascii?Q?4e6a+W8VkapkE/VGzRXxko3hXWtIu6RSeOUTTu/C4freY1DsP8QETBH0WlrN?=
 =?us-ascii?Q?Hb/cLhUiBxD3Tr1KKV3/x0hycmFd3ou8uYPKlRZUqUjQsgZOH4PrLP5lebLV?=
 =?us-ascii?Q?RdcqgxNrKUHi2IrCZFijGoaGDjH2g4itB0UD8Bazh4h498v74QgtTZ4IzJHo?=
 =?us-ascii?Q?ctoY4iyb5nATbHDBpLAATMetdTkC4YhWI86bKdsfHjLz+c8A2V3Ve8c/uRN9?=
 =?us-ascii?Q?aWRNZ/8fDhpwBkkb7cBj6xOFU9IGYNBZ14OR3DTyvjsCVK552g0TW3V3js3K?=
 =?us-ascii?Q?fOEf/XhvgEf6p4fqYvq/eDaSS1bErSESY7vcCqbDaucEWcUBJ4VmwVKDdZtT?=
 =?us-ascii?Q?p2IDBuz3Obvzugyed1hw8K7vsfZKoUnzTmWKwzNW+DynW/MYPytOa4lSuVZo?=
 =?us-ascii?Q?9LVMi5fbGNOQnHa6/RYYrjMfQBi1blE8LCKBSXabfzKbyLAM7Z4/93E2OqWG?=
 =?us-ascii?Q?sNkDd2nOiT1ZhLnzS0CUe6EZ4g/mcM/WMJmE9w8Ae+aKS4alAW+kqV0LWmdG?=
 =?us-ascii?Q?EhqaLQ99M/0oHhW984g2bdqa68V44j4lyMXFqrqb8FlbXyS5ymuMh3QeJ8QU?=
 =?us-ascii?Q?11VL3l8FvuhHRiHm87d6pz0rUbIqqvEF+uqRseIN6XMADd2JbTu5kvxQyfGb?=
 =?us-ascii?Q?gMU0Q2Z78P1dptvQsq3jWKxfd/8PvQt1lIv8JECCL5OKRoJmYb/UXu/pgCXj?=
 =?us-ascii?Q?yiQ26duxh+aPSphXjs6Z2Xf/AEv3veBRifX/HYfA+eDN8fggT5WVPTxsrVTo?=
 =?us-ascii?Q?y7YA9I8ZXxKSOG5EJlfQa1j0OmEz6qdx3Psrv/+wGPYcK6UJdN2IR13b/Ay8?=
 =?us-ascii?Q?Romp+40AYeph5YBHy3GrFQdQssgUvDzqmvkJRUBmm1ShdYZJNo3fGlW+NAbR?=
 =?us-ascii?Q?DNuTUKEQ5v5RL727OnRfKfsOUzrkPIbOuQd6rZiAZqpsOP3BvDsM73wQaVkm?=
 =?us-ascii?Q?82ZPI8ELbKw4ZUfDWpSLfOA3QhduuaB1So7wfR9EVFRxyX635LX4xVWSGh59?=
 =?us-ascii?Q?kGnGNwMUQYjbbaXzotcDqRtlJy4oOys1qZHZvkc2q/EKtluaEHX0iM6wBkfd?=
 =?us-ascii?Q?QJT9oWkMsqgj4F9h09oceQD7mweBcRF1Hh552N3Ojh5Hnmye7rmZomgR0L6V?=
 =?us-ascii?Q?b7baA9M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AKxHcmMRaLyXAxmxhWXFHz7lyLpsFDqT1mcrMR3q4ter1oCARhZUrKR6iDyG?=
 =?us-ascii?Q?LsaShJFN5hxsy5IqcCbptVbNaTdeBS0K7VV2Ylou6FU4dTkgCpF6bkx3eU2z?=
 =?us-ascii?Q?NOsVVvyoAeKuuhwfG0fBj+wZofdAtYHXIodr+oM5Y7FcwtJp2QQWNn8TWlCE?=
 =?us-ascii?Q?hK5QXsO47QW47h4idKULybVt1NuFWWILw1VjM1dvzoUSI73T3ZN6vkQ9YFvs?=
 =?us-ascii?Q?EOfXiXo3xBPbIA9DRAZ2zjwH1JbOh2Lpkf9JR5kqFWzL7GnEDRh9VbwSySNa?=
 =?us-ascii?Q?N1ekt9sj264Z6Vsj/2Hkyl8p/R+xXW7lCV9AZ+KzQxRA9fjhGc+oLzahoIDW?=
 =?us-ascii?Q?MzbfLMGBqajM0Gqjo2sgZp3v1YkzlZJPObG0TjGwjgCQESbqJZ/EXNzfGdIH?=
 =?us-ascii?Q?xG01Hy0CPf1iRV9iVyTcU0iwH5l44Oxp0ZXlsTK4eH3DNBVqmlGmzrt2ckIE?=
 =?us-ascii?Q?GtYP5ggDNv/cwYWZSQecu8M8waMjJksyIF+Yq5IHfwJ6N8+qE6tbwGC/xVYm?=
 =?us-ascii?Q?7XWCSWMS2z9lgvKu4VUkd00dYMQPdiPBizvyJ3wS0LPlzES6OcFJ4yLZMub0?=
 =?us-ascii?Q?MRvHhA46K02Fck7wv2B7F/z+Z9qFMi8EFls2So1NZ4tgxvCUmlibjBWa2Kx4?=
 =?us-ascii?Q?q6FBJ/iIyi4pTKMT2Xvds1L2/wYYxJ9rJZcVIJC/uJTLUB1kUHGtJ3YBxVv+?=
 =?us-ascii?Q?5XM2VTH1orhoTWawl+A2UEW+biQkEKp6zN+lD1XGxiSjAF3cBYYZpZa+39zl?=
 =?us-ascii?Q?JlySQPwtMimCfNgrxRlLbtiRKzsLHt7n+cDBxKXWD1fzdFkBhbpXL0J7SYOR?=
 =?us-ascii?Q?hJRtz5qbwJAwMmcWQwe8ex11YN/In8Fqp3vI4JeSIpPyAM0r7nk0YGX2w9H5?=
 =?us-ascii?Q?8htCw2H8pEwRT7vwcgFbk4GLmSDaZzHPIPBFgVNeYu0TPNNdYZFkmaQYx7uT?=
 =?us-ascii?Q?2rW9zQSx4IakPzlfbXqt/WAg7IPqn+dik9SjGXc67iedKDAfoExYr9Hvr3wA?=
 =?us-ascii?Q?qwCcY/KvderGCcgIkcACdZmPCI76hz5j1cwB+wpPpetvnkog/M24PDsu/Gph?=
 =?us-ascii?Q?aMm1DAb6tuq5B4gVox3KRmEkXocBGd8V98tI42VxXtLysC1Yd8+P4EOW6xap?=
 =?us-ascii?Q?nAwy4A4nQ2g7eY7hJNZZ8fTXciLJ+9O9CwSfooOKCbFgRgZjodpoh9vzgRUR?=
 =?us-ascii?Q?FtdSXIvDLdhK12dgUBLZSbDDEomKhDxu7rC8Jkb+yktAiu/6TOEvzqXNe2t6?=
 =?us-ascii?Q?JaEVEvZ6Di4BQg/ypjspumwP7m8zJj29KWtiCYcTYuMeW8LPEHUYD/i7ob0k?=
 =?us-ascii?Q?JkmCr2YtT1+D/OIpf0C12nvlkwG+emT8BUJeCNdj1LfXPkrWz5ZVzX+jnm6v?=
 =?us-ascii?Q?APOGpYOG2Qw2OTxY0fuIxMlGHLAi9y2g2skqH19Wb2qiQa3Li+S6Nd9xcaKZ?=
 =?us-ascii?Q?Rpmtb6k+bfUfCu79ofo6dI2ZQwirRw5KjWdrqn4iae52Yn5c8AYHVsyjcp3j?=
 =?us-ascii?Q?BIpF1gCg/4ZH7cC4HNSKY+R7lpCgYJigZI5JdcYJi/nK9+X4DNS1K8kfzE1i?=
 =?us-ascii?Q?H1PdxeqrRirm2T+vCjrIUn4WOitr0fMAeSdv9I7v4d7VKn6ugryvd88jtZyA?=
 =?us-ascii?Q?fCj+dh55voTK/Q3czqFOXTE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1755408BDEDD0843AECB33E0F92443DD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1x091if1gPAayC5xsBTZ6XSbwdSZpAtIRxlI+9qj+KKZCJIsTE9fmtTcgR5oIZBMaZkyKve9TXVbhn6lKVv/xGCVRl0NliCEV7bIUnZjM2SHhHX3AsJgxi187AbPbWdFewH3A7Dm0yqTIxWH2EldnJdMzgTq4zmbQnN/brfhz9hQyDEE7D44CDVDhIcArQHrNcUjL4bVzkcqqZZXgY7fwt5Oz0Qs0zhCDY5RX4OxdvEWm/r45RDsRFy6xtHR/7hFjVDcJFVseVPxdKGUn+qfETE37hD0CWBu6vc7cIsodEkHOZ3tr9U5f71E9tPxZxVHq0S9hhJI8krjWZaK3A+k3byE3i9eCEF/ibjz3OBcg8GxmK8L21ZjueDHgkgTQ7fAf9IRNzeCKeZV/FncLui04dshDhF/bI+dUEgGtlGCcW8dQwt4CLC6dXGOiYAZ9seXnu+R0Crjx7O7eb5r9j+Orx3WppWMfL6bkeNSdB3+XPo03RFJVIiesaw7O/bX7spJU1ixJ4NX1mHFRFk5HtC3c2qopH6mYknJDi6wk1YbRgUfmycnX/cjZj6HgiB/9N73ZXIMrxdWjG/ID6XNgCCSJ5Xl6J71sMRG6fgibtdc2swH9flplokVUoPe56uNE8uq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d5ed7a-bdcc-4714-a69f-08dc8f7204d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 08:38:24.9615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jtj+AKmn4zLY5dBHe5u3GiVvb1UDl9ZwFfUtgL3vARn5ET2RuPIYjZ7Z9uae6DaQOFAN3GADFHMdaIW6CvHnpFTqPqrdS3aZj7HagdQ2LqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9326

On Jun 18, 2024 / 10:45, Ofir Gal wrote:
>=20
>=20
> On 18/06/2024 4:24, Shinichiro Kawasaki wrote:
> > CC+: linux-nvme, Daniel, Chaitanya,
> >
> > On Jun 17, 2024 / 19:05, Ofir Gal wrote:
[...]
> >> nvme-tcp is used as the network device, I'm not sure it's related to
> >> the nvme test group. What do you think?
> > I see... The bug is in md sub-system, then it's the better to have the =
new test
> > case in the new md test group. To avoid the cross reference, the nvmet =
related
> > helper functions should move from tests/nvme/rc to common/nvmet, so tha=
t this
> > test/md/001 can refer them. This will be another separated, preparation=
 patch.
> Ok, should it be a patch set or two completely separated patches?

I suggest to make them a patch set: the 1st patch moves the nvmet functions=
 from
tests/nvme/rc to common/nvmet, and the 2nd patch adds tests/md/001.=
