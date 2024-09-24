Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EACC3EA83
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161191; cv=fail; b=gu1U31oq0oSHCZqlctJVGy8EFLV/Mw5fM8VMluCIWAEwiJWm46V4Y86L2KCJv9xEuGKRoCvYzK4wanpIYiZ1gbEgDXb2OPcZwrMivdStWIrinbOMJ1Lxx23fUZjW85VlSq6/RxePkr52P7vQ6VIQwfZchwPKUCxjUzqU0qhhJF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161191; c=relaxed/simple;
	bh=f5Vm89k+HDM+KVcrqGLrpa7jzIQbCC9GsFntTLEG4Pg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UFcrSQ2zi5cQt377YpIdET8ppoqw8WHXQS9rI5QxqL3P82PuyaJ9ZDn2OEbUN5xnk7yoFw4sTquXNEQQcvGZdWRVnZmcV1x7oveb+QzlSqdgyfx0jdx6lBXmW/Zk0djGIQweuIVf9KOaKjCyeXxSq60NY1rzTKZiWJw8bUL7brs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MVmSJR+S; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bTParLF/; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MVmSJR+S";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bTParLF/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727161189; x=1758697189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f5Vm89k+HDM+KVcrqGLrpa7jzIQbCC9GsFntTLEG4Pg=;
  b=MVmSJR+S0luViU1PbpduXKR7r/mzZYmrz+PihC+VL6m9/TY6b5qoCdNG
   VmUvNyP+cw/1r+MItnKoaREiOcV+7umUIHz0gWllrBIkRQGWrcPm2C2Wg
   8uyfBdHG6Db0O1CQK5obvDkODEakyVSxLnWHKwIjhy2tl6pp7tRhN/kDp
   CZZwB1TgQlh2rj0lfzNA9duE6ObrJAvNT2JYbsdO+Y0N49nUxBfe1pOmp
   BS+Y9l5q/8jb7wj2aJaDOzUiO9bC/FMIXPZRz3aowhiaEffq1g0UYga6C
   hadrzD//EzWF0wsDQO3LEPp1M6a5qHiU4Rv17dkLXKPW6cTJ8pZT6Ioma
   g==;
X-CSE-ConnectionGUID: FWYnF+MUSCCjfedj/2MuTA==
X-CSE-MsgGUID: pmhmWPNbRMuSCrDnSLzufw==
X-IronPort-AV: E=Sophos;i="6.10,253,1719849600"; 
   d="scan'208";a="27801726"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2024 14:58:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/dV3Z4TAB99D70sxDCqu0sv5tchuMykosUO3JM8zaAFUFkUGuAo2plePH7RacfZbihYEMkF+TR5YJfK20dT5+XK4l6ydnONxlXM0Mk6i/Vd1mnsE7gR9syBQHrO4tnQBA2aL5Q67it5mSprq6NEtaxA7hMOiakpbRX8zOpuG3K7HGqfo0i7ad4rLMzHoEgGL2r3xnatoH9TA7boZsG6fGUJhXjmr8wfpBnNFNsgPBPBfGxcB/0fSklRtpSjRrYFchdMxIAn8UU2AcZTP03gblwrRR+8gTSSO7rQ7XLaZVaKV9mmbiqC1Gv8UjHh5EP/iA75PM7ENRpHin3C+ro6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY6hgh6DDOSWC9agQ0XUjhtZUUP8tsAwMANftTwTrQI=;
 b=g80IaeysOkmPPNmm+gCZmkSjypzHo7lcKakDkuaQyTQJBJQyDYpIT2ZrKOEJ5Wq5TqHUDUujvPyF1eqrvQ/cXV2QbrCpKB6LRrWnXhzWIJG+BIA0EjrXQ4V2kXBANUc6OuEqw2Z2JF1W/li+saerWHXhdXY9AOTh2xDXqvZ9uTtCQHuur//9QmaMRzgkpgonMDQCX21xnv8z/H8ornryWBfskadW8ewl4SXdzuynuY75f3elxYlFr0Zo0QumWGixSTQBE+QVtbKRKLCwJWJ5UICmZbZ2jO5lWLsZk+pb3f8I4m8TGckq1bHReA752AJHaYnanGzdZg5V4ZTYmhTkJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zY6hgh6DDOSWC9agQ0XUjhtZUUP8tsAwMANftTwTrQI=;
 b=bTParLF/KeznqpRlp7NmNfIaICiTeMex9+fOs7IeWNeAJnXphWG3I8HaZMA2x1C4jhoYCzkDElfvgqSq+CE0x7G32ulkrC++yviaYNy9vxfRr0anXQkigvE3ilJGJpR9259aJXzPHVuoWnY5tmDa8j7iXj2PpUDGsDGAER8gZr0=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by DM8PR04MB7943.namprd04.prod.outlook.com (2603:10b6:8:d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.25; Tue, 24 Sep 2024 06:57:35 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::2482:b157:963:ed48]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::2482:b157:963:ed48%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 06:57:35 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Jens Axboe
	<axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: Re: [bug report][regression][bisected] most of blktests nvme/tcp
 failed with the last linux code
Thread-Topic: [bug report][regression][bisected] most of blktests nvme/tcp
 failed with the last linux code
Thread-Index: AQHbC2hCx6Mz5ojvQUCjzyC2kqTb/LJk7ZWAgAGUXYCAAAL9gIAAAlAA
Date: Tue, 24 Sep 2024 06:57:35 +0000
Message-ID: <dl5dpppkwhowzokmggh23cgi5wv3yckkfdpvrlarrsagtqhwru@2aruxcxrspwc>
References:
 <CAHj4cs90xV1t2NbV6P3_z1oYwD0BcvMhC5V2mGgekRq8iae=NA@mail.gmail.com>
 <CAHj4cs8YGgmemMZDXmt7yHa+Xq3EiEvRWOJGEQTDjqGB2rAogw@mail.gmail.com>
 <5ce3b803-275d-4be3-a9bc-87d06a8f5033@suse.de>
 <jhllwfxcedrcxcnbajwl4x2l2ujcqowqcd4ps574zrafrqhjna@f4icvecutekm>
 <7d355b78-fe13-4cb2-82f0-95795f61db36@suse.de>
In-Reply-To: <7d355b78-fe13-4cb2-82f0-95795f61db36@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|DM8PR04MB7943:EE_
x-ms-office365-filtering-correlation-id: 843fe668-0a6f-4997-9ff3-08dcdc662b43
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6DYWRztxfWhyhAxY3dzFTqeZrdxpzjTArGCpWEo4URiUyFBHG4jGMmzOz2GG?=
 =?us-ascii?Q?kiDoxxO0cFYioWxgWNtNxpwUQDXPiwQ1U6ycXe3wS2SqvQxJkRGdHZ7IoIu2?=
 =?us-ascii?Q?eg+DUH2dcR4nP+MxO9cxsAnwgnBapiDcseLH9JjNpHhx6xUDyD5ePX6CxCvl?=
 =?us-ascii?Q?GM/Cl0sz/BArLs3xDjXgzt5OqvhhY2ujM6X2AupIEhfSgtKQ8nyl4CM+R8CS?=
 =?us-ascii?Q?ZkL9OWiiKDsNI5wE7Bz2EUNoh2Fr3hTE+VSkGLSc5+j/dMrvfwCjEQ2duOuA?=
 =?us-ascii?Q?wZsvZdVJX/XwOZOiMRpkmqap3gTUOuhbrOLqetuhz7wEZMTD9gyRIaW0IxEl?=
 =?us-ascii?Q?qaeYwhTjmQfOBRwCfkhH/5b1otojqCxrNznhZFOleMiRrgBcgACwAGlSCI8J?=
 =?us-ascii?Q?NkeVHefOiJacXQL2EhSWpA1kwMQxFWeQMU8P1/BspK8yNs1cUvsEyrluQ4mJ?=
 =?us-ascii?Q?mIeosHrAXpEvU7nBhbT+9WmXXHGtl+6vw3/BqFQu0F/B72hyIFzJdiWbd23W?=
 =?us-ascii?Q?UV1Yfgm5cWYYeOnWbSV9DgeIHadpj8saex2AMfTvvZrjJOO5btPjj8Kf9y5W?=
 =?us-ascii?Q?Tr0czDsMjfs70R3SWzZ16E1V4+Vz2UkhN5D3bEgM1SgcPf/7LcxzRp/WqRax?=
 =?us-ascii?Q?Uq1NMu1T8C0zXVAfgHFDo6qqSO/YxYke6nwu9mVc2eulC6mpwyHm/d6IRC9Z?=
 =?us-ascii?Q?grVZrlccCBCwaK2DnSaGobI5b1iqTXtZpZwhzK51r6zUt+I2CugpsNUOx6bL?=
 =?us-ascii?Q?u939XDswBh0kPxE5kraiVH9tDbyPvC5Zo+lEy8oUxeaK/XXSTt6jekeciHpO?=
 =?us-ascii?Q?1ijzqIiQ78nYwKlFuIgLJmbxrxO6Fls7J0QycMW1+71MxyPDOea0PSR61kfD?=
 =?us-ascii?Q?mSuI39EezHq3I3z3L/rVH+6t21Ms9AdGaDxs94jSlvTfE4lgeQ7Flxflo2uF?=
 =?us-ascii?Q?FlGNNtz3go5jXU3abP8ItaqzvfbYiPG1gEhmztw7h2oZA0oGF570CMIcI+Il?=
 =?us-ascii?Q?zScPpiFD8FcMcgDAVpSZ9KSnpW6lePyhUmAfycetYc2NdIIt7M6yKSGZcSs1?=
 =?us-ascii?Q?Evfm+vtRbBYi37eFv0dHXcUbg+kobNIugyRpQMuVHkkMkV3S9fWbaARtOUak?=
 =?us-ascii?Q?thRkBlWPlMWmfOdWeHHIn4ns81/r9Q0k9fCv65xkwMqZ1B0e5N7Osb2hmhW5?=
 =?us-ascii?Q?mXC108XvbRp1RfosKh/0vXl7sLVqee72Qwv7Ys7hMwKByzLEaVaZE0mVpzgd?=
 =?us-ascii?Q?wT3ZUAQAcP3nJCkvgmTpBjLUIf+rSvgfngk0YtylnwCNHKDFi2dgVtGJdbzA?=
 =?us-ascii?Q?cQkcHyW7EXUV/hAm4nTTBgCcqN1yNVwNuwq/1KIAP0Tjbb1yzwqjL1WRqDnw?=
 =?us-ascii?Q?PjSMg+lructS1pqpiPWATxbtoB6Vb5Du7GITEU48AL8BN1ehyA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rBhUcGW7afVSv7B5JQbNCrI9WDTOPMg6ln4ZZolk8vhGNvYQG9nO0OQK6X0t?=
 =?us-ascii?Q?tSAbjxtouFF+jR81wOYrKupchzRDhWZ2sVScx5d/R1Ran2SOs5QIhGmi5IPb?=
 =?us-ascii?Q?Yx2Ib3EpX3aLEr6cJzKcEyXCwn19mE9CVli+gsiSdwsIfHXONoFrnHAdPeF9?=
 =?us-ascii?Q?B6exrJnxtx4A/OZIDeNNwoJDjo0RXVc87Z+SOOoLIxPimgIyPL1sJ8b8yg5D?=
 =?us-ascii?Q?hCThDPYanDmyaXDicFNcTHTFFSgMb3g/zBTEdrWDuyTsO18X7BR1S/t1LQvd?=
 =?us-ascii?Q?G3qK62YJoGHFibGxoa0lZZVYBcQNjAG0MKY8cDCkE7NJiPLrv4uJYjt8v+MG?=
 =?us-ascii?Q?RsOPTj/uYPzhoIhyhlhBbyBRfYBuhJVLqRwUL9F308vjcr8znwo8LGE9IWAG?=
 =?us-ascii?Q?7ptcqEhMfvp0V7X9p03CJMeOOY+ZrZxaRDlxqBhVZOYZHodIMSGHxTiBcWkG?=
 =?us-ascii?Q?wQZWVnjhALHQ8HH6e6MvXN97lV+y+MsOp/QmDKHQvl6mkIZ6rbjv1yL+u0iX?=
 =?us-ascii?Q?tPzGTMOxruMeUwnmugnG935NA9cNyqASOFLGWG+9tIwtj3iZj3MhEVVnHhWW?=
 =?us-ascii?Q?bewZPPaUBnQRVN3BaCPsN1KRFZ84Fj8le4LzIu+rDv8lF9EWRwbAo27oK1Nq?=
 =?us-ascii?Q?XZrhpPdVfTuWMfPhG5EUAZvZoHhFc+2I65dx4CSEKBiV+5F7yzDXd4rT+A3B?=
 =?us-ascii?Q?5odPxXhwSX0pzlIyjr0qH1T/RA1erV1U9PJhnf/FEDbqUSlEiZ7BMzwBFIVQ?=
 =?us-ascii?Q?Vg0QxQUdOXRryHs2h4g0/NM2Z0FcC7wKGZZQiQWWuN4KOFG6F6dWGo/dwZtM?=
 =?us-ascii?Q?RSJRKlfTG3LND0BYhhbpTDQ5vnSwPtyYqHIL+Dk++10FPDJ53J0qKVo4fqC7?=
 =?us-ascii?Q?ugXEPzG3dEVfHjIK+LUYoM/alC1PbuGCWAfAy4QuiLbap1OUXbZa9M5zagM/?=
 =?us-ascii?Q?ZCwW/F6ZgnAfrzqh76xV0NLsnZBWVWXsThR5fk7sQmbzI5qWZ7z8IsII9yCO?=
 =?us-ascii?Q?YWgnj7LcTZqBJ8I4lHDc0mZWDhgIcHggP0+Fg7B7j7BC4cM4hrkKQK5/Raic?=
 =?us-ascii?Q?Q5ffwWMb9G21B6nZVPKIEEmynhrMyhWmoJDnGiSnb1r73AWzap17SqwNFMqw?=
 =?us-ascii?Q?O/ZflsOD5EMFMwtFVZLWfZsE1rMqq2q/vF1F07RYMaDDHJZSlIiMyz9Lz/AT?=
 =?us-ascii?Q?vrgz9r30rE5KqMClBCpRIueyCaJcosh9wqH8i0Xnfi0QknKrAAm2zKucvqMv?=
 =?us-ascii?Q?kYZh5l1r+5X7PhYphxyUMNcCEZjnrnJWtM1F86uwn4O2WtGNPlrDyrqodeHo?=
 =?us-ascii?Q?cYIOFGn/IyVcKjjY/TVaRjNVEA8i4OYmTaP/5zF1SCGoZUuVHXOREjtYzU/J?=
 =?us-ascii?Q?ZyXDASSAomAUWx8TdvoX9sTNWjkIhME/OjLhrM8OTOw5XkE4u0wF/ZXUsaU6?=
 =?us-ascii?Q?H+Bytnl1g9up5Dur2XhayxUTb9j9L/j+hQO2lx1su6++d+v/knnmLzyVp+qN?=
 =?us-ascii?Q?LY4eA3biApLAm6Bwg0ozoHk/qusObrQWTh2aFgCkepgrmeWtbIgJmK0OxZD5?=
 =?us-ascii?Q?4hoSKtx1HSOWg68YweTMQ2Z9bMS6qs1cYkws/FItVN9rzwqNA57i0/+Y0VUu?=
 =?us-ascii?Q?iWXe5jEa+/Hv1Kx8UduBL1A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A645B69BFF9349448EE17A29EB7B4769@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5CDBPYdbZUaP9f6n3v4I6dfYOlP7Z3ZTsruZwbLDNFCNkI0cvl2CtyQENgPv0/QdgDGlBmWCuJyv7sJGG60bOdBtzY0e96nuO72Mw24N/Hu7vzNAfJzmh3ZKiuuK8oWrlHvqKQdXyD5RWsWF1kjpJyInVefUQrcob1/sABVpZX6bJp4+Z66n+keR6WJpEl15081x1iADc9KM6acw0+gcZgBxSRSppdAfVnMvuvY2YLZ1uM30XBFuCI3LwRX9exwNE9r7+iKOSEUcy0m/DptYfscnGq21Z8swBXrR1fn3d/Jgl8wAW+2Yf9MI8/eMPxV0HT6z23c+zRw5b/Q9NgmWgQLlav2wXhvLnGzpzLgirP/fh4bINcYtxA4s+oG9n3UmxoJSu6DOdYmejUxKH4oRyE0fw2iLEi8wK6vtJK1FGUom832+fJamrAtXXnKnzV8Q50taTDn4zcSkfZav4Rtn4/CUOGim5LMQvbtIt4FgjzsE01fFsPNCUJysv/qBTjRMmrDT82g+ZGFsKfKHCWAzbYJa3W0YycxlcBGPYQZDPJQrOCTHyid6OEhfgwts3WONi0sX1heJl3BC8ODKKBWVdfwY1PJa4VIS4qNUjtZoV/CBIKE1gDnraze7LQoJb9XZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843fe668-0a6f-4997-9ff3-08dcdc662b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 06:57:35.0206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRpzsBjKefXERP8Kxsi+aTAMsrQWiiYEXrVzBMpqwfVd5rgl5AE2rmjODIdVVvflbcPvnipVxAGV8jwI4Ncvi93fRfj+b72x37lj11xNXDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7943

On Sep 24, 2024 / 08:49, Hannes Reinecke wrote:
> On 9/24/24 08:38, Shinichiro Kawasaki wrote:
> > On Sep 23, 2024 / 08:31, Hannes Reinecke wrote:
> > [...]
> > > How utterly curious.
> > > This mentioned patch moves some sysfs attributes to a different locat=
ion in
> > > the code. The stacktrace you've posted indicates that we're creating =
a
> > > controller while the previous one is still present in sysfs, ie that =
the
> > > lifetime of the controller has changed.
> > > I find it difficult to understand how the cited path could have chang=
ed
> > > the lifetime of the controller object, but will continue to check.
> >=20
> > I tried to recreate the failure, and observed a very similar but differ=
ent
> > symptom. Kernel reported the KASAN BUG global-out-of-bounds, in
> > create_files() [3]. I confirmed that this symptom is triggered with the=
 commit
> > 1e48b34c9bc7.
> >=20
> [ .. ]
> > diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> > index eb345551d6fe..b68a9e5f1ea3 100644
> > --- a/drivers/nvme/host/sysfs.c
> > +++ b/drivers/nvme/host/sysfs.c
> > @@ -767,6 +767,7 @@ static struct attribute *nvme_tls_attrs[] =3D {
> >   	&dev_attr_tls_key.attr,
> >   	&dev_attr_tls_configured_key.attr,
> >   	&dev_attr_tls_keyring.attr,
> > +	NULL,
> >   };
> >   static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
>=20
> Oh, indeed. That'll be the correct fix.
>=20
> Care to send an official patch?

Sure, will do.=
