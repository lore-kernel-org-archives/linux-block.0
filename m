Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04D320DD2
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099450; cv=fail; b=G0eublH5JI/d+fy5ibFFpdWDG+wl6FwEiruQUcOY20FYH6KNn46raEJGp6yYGNVtnOiEE9s167jp3FPIWktMPMOjXIvORW89xuZm9izZF9XTxrRHMO2sq6lNHem/yqvrq9VhuQu/23iUou9XwzpByuhy91HrcngsWTmWfzwEkzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099450; c=relaxed/simple;
	bh=6VH/7lhlbb3C2FvnN+GcPHPu727fZ6pOBfCEOB7ltjU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dIxIMp1E6jEDTV5hyBbwcrqcPrXXaDAhIhuh1AIqTf9kzVGuipA4Le1TvDzQI8ZjP5R+MXEgdUHggHdYu3uHJ0ArcmvFWj7sybbIOhaDXDxa6UZCj6VLMi0k+0lbgj+R/gdacxHtj9fcwd+XDHqQ8Azk6mJzpsV+xRnjvZNkfjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qi/2tBA+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=k0mXqn4B; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qi/2tBA+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k0mXqn4B"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711099448; x=1742635448;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6VH/7lhlbb3C2FvnN+GcPHPu727fZ6pOBfCEOB7ltjU=;
  b=qi/2tBA+W3kGGc64HZGkca83ITeQtfq5UX8keWD1A1x/iZP0H5wdvs8S
   1f2wr9YJvqkrtniirMaTDKIpzy95gOOQdbQ1ylcF+AhmqhZ2VwonxGwXf
   zLZErzaiq+hPAVhZ3AkSfWNVhOo66RBHsVP/6D/iIiZeAXlJM9gcBpIot
   5I5sjAFJ5ZxkluQVlK/eob7Q3RsM+SvTpzD3oE3ek/h0xTY9nPVrAHl/L
   mkxuI6nDvwDI36WlnX8ZbCbOp3Qqrv1wvjQaRJN06zUleEty3boI9eKye
   mH4osBKmetak7rAviEDxzJyGXRtkrBy5jnNDdJ53mbnRLEtu8MxsJj/9E
   w==;
X-CSE-ConnectionGUID: qQSYFRZ+TW6C137RcUatEQ==
X-CSE-MsgGUID: AihEZAE1Qv+J8AAa1amJwQ==
X-IronPort-AV: E=Sophos;i="6.07,145,1708358400"; 
   d="scan'208";a="12232161"
Received: from mail-westus2azlp17014040.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([40.93.10.40])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2024 17:24:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSDx4SX5/mDXkBfhs2IMoXbWBf+P2XH56XFbt7sT+6CUwP4OBc1/KKhyRyW4enXL/G/gaFr9zML8mcLACPVUM+nS9eOvCwSndW3dwLAAu+95Od0dd6KAuguZEUxEl783yH0Fgju+QV1ETTuy0pevkol8JzFgH1Z17gzAdBjd4VSl+BepWk667yxF6bmOFJb0NRgOY70cNBLYhYMELlWx7rR8ya/93oLVrGujXN+sbURYlfuwRSroj6fZBeFedUCs57+V1gsNDAjjLOE98hWeT0zd8VdbgKjkkKj90TRmcu7KCf5/G3N+P16Caxlar2kis+Ijluak5fEoT9ViKH2lVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VH/7lhlbb3C2FvnN+GcPHPu727fZ6pOBfCEOB7ltjU=;
 b=ApnkWL9ys0fnjAFuBXz4OW9VbwZUtBa526c5W6+j0CbI0evvGN+hI3JNSMBwaFb7lGZwH/WsJqKp8VlyAHyl3h0GDtWboK7zltb8Qo7QWjypjrz855/uubX0Anze4iCSHK1eWeHTTjQQSWVp9hnRCQMl8bG6te98y6TFWQ1w1jSXhVSbfOdnXcliBvHVMjaLOR9bYa8zM5KZYfIklkIw49TtsUuBVufOtgxnG3hvYzypOLxfXkKK9S91Y8OFSDsG+1v2JbCuz7FNYfML6WTc9P/Q0alHVBSTbbvAaBNDgCXyTgWqeFBI3jEzyFCCcmtQ7EAJEbslQ45ZRJNvbNVZYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VH/7lhlbb3C2FvnN+GcPHPu727fZ6pOBfCEOB7ltjU=;
 b=k0mXqn4BWA57lyBWjRU+Ng9DBzG7MkhxyPtXTxfHoDvQq7UekBjd7igKWdfYxWkfmYeRRHn5IBLD9OgZqqM+AdlFbmS4kvD60LzqexCMOVSW6DWthAjBVa2zloCZpFtnSwV4sUIodqLmljpXZ972M3GZj6ASqyUjrMM5Z5x7We8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7278.namprd04.prod.outlook.com (2603:10b6:a03:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.37; Fri, 22 Mar
 2024 09:23:59 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%2]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 09:23:59 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 14/18] nvme: drop default trtype argument for
 _nvmet_connect_subsys
Thread-Topic: [PATCH blktests v1 14/18] nvme: drop default trtype argument for
 _nvmet_connect_subsys
Thread-Index: AQHae3TTp0YH5dseuU+3aJplkMvI/7FDfmwA
Date: Fri, 22 Mar 2024 09:23:59 +0000
Message-ID: <62n73xslzqgnyc43a5iartghhkfoibrwm4lusfivbae2e73m7n@m6ld6457hpkg>
References: <20240321094727.6503-1-dwagner@suse.de>
 <20240321094727.6503-15-dwagner@suse.de>
In-Reply-To: <20240321094727.6503-15-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7278:EE_
x-ms-office365-filtering-correlation-id: 462d57dd-ff2c-467d-ba62-08dc4a51ce7d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 26J8Bhx9c9yTw1xRRvOU7zYyuYb2SkNEmpFkJVFB5iUN4InJ/maAc8DlBvyqHqB+pm7wZdrh3+KOuykq/piRHo2Kr4/NNv88kKVp5hSY9d9T84xMNE+XCsNda6VUwztrPBqTTZNpLipvJHihnej0BKTm4AwAkmws6maqa4SrWBTLUmbgycLDYONAbfDZpYSEc6dtnGY/+c3CeCVQtyCqd1yfSzQYgcWYCNDyD67nyREbvR+h5BqoXl7x26u9cYJJNOBKW+BCo7cqfjahtENyYZVVClyd+6A/QYyXZ/Pkh2QhYGdu0n6A3uKLvTIJlt4ujhW2MXo0u4nn/LRdEzVYoq5nZs/Xie4ZAd+5KOvD02E+vCjBr++sYnBNfFNBqozaXU4KWUeIH2HGUO0Lma3tGucpY1ug+WlRCU0zYfNx8ocW+qH/HxtGjjYOyCazcfrOUv6BP74bNEHB1MBM7tZRs4D+Kel6bInDDvqiYL2TlfRGx/Vly31OwOrp2lsHe7OlEKR8jrHxXW2W0TxBZ3RU1aarR9O8SGoYrOOTeep4KWp1rQifTBsJG3GdquOlzUPZM8QojxUtLD/v78pUrkpgDbTs+UZ6aM1U53J9hHeX/D7DkKndZjDEKjJnJHa04fbpy6aJuTZpfkeCxbJpHrNT+cYo57rVIXNU7dSKlk00+PzF92NTOOZZMWRMftrJpkOX8KHK0zmhndsfyzDYa9MWZIhHBdHEtCx1cxgQPdJVjvg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zgX+iR1EP+i3/B+FgSjyJz5lUi+RMQiZ1cE9AO88ryOZXRwbP7MNI94GV9rP?=
 =?us-ascii?Q?3iAnYh2TFWnJ5O+wqYIfJkkeqhCzAxzEDB6cOliJ6KCZDzLzhfEi8lSry2g5?=
 =?us-ascii?Q?0SdYRa3QzTzboRadEzV22+5DuzLYV9mHn68SJdl+F9Y937qdKtKiYsNN369T?=
 =?us-ascii?Q?rbvdwbTci5EzPDE7NOqAmV6Hsc2zknhP8zILxPI3NSSRNxgPBmxB9S7EgX4O?=
 =?us-ascii?Q?lv5nnBgKZprtCu63QoUw6N9TbM0g1dC+SGI1vi0SFW0TjDAAee2p+WmR5Lq5?=
 =?us-ascii?Q?MF8DqFN2OaRe5uXk/LMsjBiwWy/hdWRwG6NonfTbLdyl2mZaKh5qDnooFR9v?=
 =?us-ascii?Q?selq5qmnRcj+CW/MoFtLES9JmPSulDDFWb/oSKvA9VATaHpClmjk2v8/ZdkK?=
 =?us-ascii?Q?pNWamvOAbO+skfe2Gn7qi0saJTsOFCZ1vibzh3vD+uU2fGQL8FjWpVmDWegY?=
 =?us-ascii?Q?LQFvDnjj0CRsSVFVK6XWGo4Hk5SHkp371E3AGXqkwzIwmVA2xA8cbmQwIjeX?=
 =?us-ascii?Q?1fjNjkqVFGfPMirUuzXuv4SztbFIlz7xGcU0Qe8OrIU3qe/pdst7R7UNUHzJ?=
 =?us-ascii?Q?FH5XMEosU8xowsENHjP5U0Yon2uUqY49u4YNko0CsKyiKKhmaiNXEDYoRFBX?=
 =?us-ascii?Q?wCdPpJIrIiwd80EVyZ0vp1IzbzHab6DAqwsEr/Le8Iy3mgEbGnQG2TggX5ei?=
 =?us-ascii?Q?dUQ97whHh3LxN7nJ2/iBQFvy3DLdkye0iZ0jMhrr24vT/SvcqdT+ckFrMxma?=
 =?us-ascii?Q?BiYxRpLaOVNdcVaH3f/DnK0Dmlu0TRxj3y4/pep+/yTSAhS3FmCrglBYtHjz?=
 =?us-ascii?Q?cPE9OnZuBtnp/JIhV77yN3drrMDKVl/EhFPBNJoPzWRJ5YHhqpPT0ry6M+O3?=
 =?us-ascii?Q?aWkHIzxXz6p5YDqAETvqtx3rqidfPbno3Ouef/PHKoDhsJhm9HYw21is/g4N?=
 =?us-ascii?Q?CnncXQrgVMYeIvV5BaXw1VMRKcULkoIn5KJvOMCNQgqVf17Cuphm3IRdL7KM?=
 =?us-ascii?Q?6Cbn07nMyBQBerTKurJ/GkOPRhqRuij/RFIOexP19Ga7sDjFpGlStlFNQHE/?=
 =?us-ascii?Q?Fi0/TY/ZfyymJf53/DyN9SVBfBCuxK5lsWSsbLPcuKXo72QpB+Dq31oH7PhQ?=
 =?us-ascii?Q?u7w1loBQ0hIExEfvkrZXgW01w5AlyUi0UddhgcxU5UZIZ3FUJ7MFZ1vGgWd7?=
 =?us-ascii?Q?ynP1qluYnWGekGS7IVRqzamzzxudL4Vfoy6aH7wqR6vOS4gMIchMWZMyKGEb?=
 =?us-ascii?Q?YZcoQLe2VqCexLnv7P40omyn9xl5Zoe1dOxF5cYGTIz4h/5Ic3QSY1joOxZo?=
 =?us-ascii?Q?rr+CBbu02u0zvNOg6Atdce4LVE7ewlBtTbNyKlv9n0k+ZCyVcuiaDHusGlm+?=
 =?us-ascii?Q?yeUoKhoWpRFnk3ktuZrnf2kHErLddAmD9YFlALfRUcFSPHHOTDzdTn6df6uB?=
 =?us-ascii?Q?WvFQhcz6ipIoTRLVCF7fhaCXE00jYCsDzsaWa4FJ40NWT/VRtQ4O/nZIWte1?=
 =?us-ascii?Q?9sL7dI83SsXBwpBlZnPmckpEc5ZrR8FCQE9go1Oi9v6X5tzroPCjRcnvBIcr?=
 =?us-ascii?Q?CZuGSEqRnjZ8qXFnLxmt69ff8PSqFGdngWWj//lHHK8R76kuLbKzwQ8g2Na0?=
 =?us-ascii?Q?wNOo8rI6hDKGy2soCsydOxA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FE9F7205D085254C849DAD432C2FA124@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	np4QDGqrQ9L/NKMwWN5laqZi5zzioXSF4G/2PX+2KM8UF5U6RLUSJqm9GdDeRSlT5iZO7Tna7hXVNNj03giOTunCm/j1oq8Oc8fg7X17OKOU44a1M1Rix8RICQZS11IZZi9++VtrUNioDY7F9bia/fL7CmDsWKBrxxpAR4/A50EREDYuPw9LR4EKBfOVhYdxS3OZYc/vD74Mjeu8BdwU7CilMDpWnsuYs/dHmbrKyl3X5fLue50xjAR9s7kviHoD1CgROn8mgHhLBjzIez9t2jT7PjIvQI0R09d21aBh9YEXmkAWjLOQ/W5L/XFk4AohiEX17U7yLVkPyVs8umvNZlX3AgqxUfozYlJFfNhZToUe27C45Omz3RkhGzndiahbZ9LQllwH0PTmh2/UBOv+gnvIaZc9Y0IQ5n/p1aWvZUS9gQIZku+xbs+FcdlKBZHesAemmaD72K517IOFIrfO2/KG9wB+0XXgUtUPQRWgtsidtMkXpjOsvqWCysBHFrBVXhKhX/tkQMkQLrOeVTBSbezgfD3mNShDU3qpjOL+bEvPZFOAwTBcDlKyXJTS6BwMCue3uQqmiw85DoIPVR/FY5eqXJoXdUXk7CoCnq0cUVKSfI20frY7PjAoMXR8e74y
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462d57dd-ff2c-467d-ba62-08dc4a51ce7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:23:59.6331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CsmF8/choe+1tiNHdWbVPOnIEEeyF3hGhPSYPYXvxaN/M39RvwO4dtx/mmvJu3lx1nPZr0zrMgU3xQLXewtsK50tugjvpU998vqv/mpEKKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7278

On Mar 21, 2024 / 10:47, Daniel Wagner wrote:
> Every invocation of _nvmet_connect_subsys passes in the default
> nvme_trtype argument. nvme/rc also assumes the test is always using
> nvme_trtype for trtype (e.g. cleanup code paths), thus just drop
> this argument.

It looks one _nvme_connect_subsys() call in _nvmet_passthru_target_connect(=
)
in tests/nvme/rc is left as it is.=
