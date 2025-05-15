Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD02222CB
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312364; cv=fail; b=tgGXS5nolPZ4jsGTJaW1ZBH0XZsb+RmOoXuz8NFhZ7byljkFl6URHwBsAG6ZtIPg3tjVEuznTZMH27ajVmZF02QsvbSqnvqNDz6Z1tOzmGjmV6BwyW7SPmq4DzI521FxuZs8rZiVB1RUtFsV6sutyRC11EiSJrfEH5NJ0hKAO+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312364; c=relaxed/simple;
	bh=F7RmMePMIKgU99c5XAUoSiUmFstqn+9QNrmsyR3x9AA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CO9aiNYv1krV1plmnA2cM/nQ75ikSgQpYFNeQURs5j1s5objEHKlYuFqHEjIEZ06ClQXqM84fGoQQ5H43jBEOQ8rWoLE7UdT5VnC3Q4B50Qr2MwkPwJuCwl3DIsfE6PClY5cB62Kqtpfy/n8HBsvQ+f9t3FIHFmV9LIv6kvIPsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FtNXfl6D; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=CQr7U08b; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FtNXfl6D";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CQr7U08b"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747312362; x=1778848362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F7RmMePMIKgU99c5XAUoSiUmFstqn+9QNrmsyR3x9AA=;
  b=FtNXfl6DXSW7ySueiNp690cD78mKjVlIppSHPeLu7VFiFijOmmg0irTY
   4G6+AcTnwv02cR+QnNkcsbQ/KzBZsuPFUnp68H3f9cTwhrWvSEIuA1xaz
   zeGqr3aF4CdD8sC2Ubj0n1LALEXt+GAqMiUSGZl9Jr/ggzqF0XeyJ1Qwc
   vJFV/9s/OJJvaHDDagxof5EoKTOocBHbYNQATut7RJA6WYVbJ36PH12nA
   8OcRcQ9nHq+9NwFcBBkX04s65Kv6VQqd0YYMiaYAWqdEIg2DgeNYw1w+z
   x1DfJWpsyR3sXEtT6z2wwPf4c32RW8pfXSzi54/gxQUgZDrUPyXdSZMhS
   Q==;
X-CSE-ConnectionGUID: Yjt8uQ6mTKiQCBdKq+T+Iw==
X-CSE-MsgGUID: QQblHzDzTfO8FfHzzJkpUw==
X-IronPort-AV: E=Sophos;i="6.15,291,1739808000"; 
   d="scan'208";a="87351852"
Received: from mail-dm6nam10lp2049.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.49])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2025 20:32:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLeLjOuiUehnsedE64pjorFqTwGchwIflMLKmnGDYUactwGOX1qX89CZQbG0St8nou+PGOnOeC8unfHMmMCyErUoj9McQ7GBEnPZBMyyFYRaVHcS9L+RwzLFmBW3O2EdammFCRPp3uUJxfszOZycCB3Jz+Extnbe4saCQ7UuEKUoq10g8pqz7RXegbtvI7hw0ge/8zo0eqNCTdj5ZvKyHxeEnbe+6tfbnLcAABCvTdqFOy6rcUhMD4LE3egongzt5z5YQ6gSm95J+nIPi7fEz6PjgZ3nVVbjzNo5dT9Gj6yK8vnMXnjJFwNPbGejHqFLD+sLpqAT9lGZ2B3JGUVQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7RmMePMIKgU99c5XAUoSiUmFstqn+9QNrmsyR3x9AA=;
 b=pQ3DZG8xctHJ3VrnbUPz60BLMjyQjmiWmVL6ZuypN7xrRxIwXqkNm/r3iGhS8JpBJmm/ocjKxPvy1ZuE5rBPAIk4kDo076NRFrOUDh4eJ/Vujw1LrUAtdt1tRvH1iyA7rzYXXIIljlukKVpJmR4raAyD7brLh2y7MDWKrU5+gfrc7P0QNQAlyLU4vwMCkI4jcgX1vgdt1KtZWXmQpjP/lsR9AxBigqhe/b3Pb8VlND6IKwGnUDnqqvTHL+vzEgaAUarXQitmw1YLHfs4Ihk+L+cgZjETob2DvKjay0OLj5hf7H3lFQteKlvjl5IXrbsAEsKh1INbBX6W8kRwd5crMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7RmMePMIKgU99c5XAUoSiUmFstqn+9QNrmsyR3x9AA=;
 b=CQr7U08bJ3or2cWGZbg4zJMXuWVs8m0BK/Zqd0GAWdQwjFlTscK6luO1bn4K+JJwjkAHdpUH3pX3WtmopeMjti9UGWBmnMqABnBc79frIiJNysPfWM0/WxTWPWxA8+Pg39N/ktFGqtoLCQRcRrgkTHy7dIp6P0YPRzfXS91Q59c=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM6PR04MB6971.namprd04.prod.outlook.com (2603:10b6:5:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 12:32:30 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 12:32:30 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "hare@suse.de" <hare@suse.de>,
	"yi.zhang@redhat.com" <yi.zhang@redhat.com>, Alistair Francis
	<Alistair.Francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH blktests] nvme/63: fixup tls_key encryption check
Thread-Topic: [PATCH blktests] nvme/63: fixup tls_key encryption check
Thread-Index: AQHbwHMphzu049GV6k+vSt20vm6+m7PTqfAA
Date: Thu, 15 May 2025 12:32:30 +0000
Message-ID: <rbcyhtwwzx4mt5tustmtjoynaj6tsxk3h4w6uk3diuwn7gj23e@bicj7vvs4wtv>
References: <20250508234359.434022-2-wilfred.opensource@gmail.com>
In-Reply-To: <20250508234359.434022-2-wilfred.opensource@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM6PR04MB6971:EE_
x-ms-office365-filtering-correlation-id: 690aac46-8d4d-4f06-5078-08dd93ac8f4d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zX68ynr0ONSlYnWjo4TF1tp7IzEc1mCjsgw79FiT6vQ3oSgzJvru2kFsJaeu?=
 =?us-ascii?Q?WAlqbnY4o3WKZZxHIWX3kQZc3fVzk2VYlj3CKTbknPi7FxE09MmMiWTYVFGT?=
 =?us-ascii?Q?tU7CNu6vKVkDd7wIFiUZIpABa22I+gSOkc0ASxzEORUbARTxVmvZOVtbPT4c?=
 =?us-ascii?Q?7/QTr/ke8aJ470mnUauBOyzhqiSjNYdxbY2FE+49x4Rl+XzYe1M35XzKdF53?=
 =?us-ascii?Q?yrmaDR8+tFTHXB9G2MGqXbDjKuzL0nFZWm31opymS4QGvudgKHCmOoOP0f44?=
 =?us-ascii?Q?upfdU+YX7iMFc2fRqzcyXsQaYaJ+VRnYkKtQCvuD+Q91CpzM/fn0oEzVc4LB?=
 =?us-ascii?Q?a27FL5ZF1PAtkWq3KTs7/OVuNtXzvyGy27Yi4ckrXMWEsjewxyEIBwasdw5g?=
 =?us-ascii?Q?sTGq0yxr+ySr8ojDjdwAJ9fOQ7Un3Sy1RcP51ULlF7UfCZftjEKvFXyTJj0Y?=
 =?us-ascii?Q?qZ9lJ9ac6cdO1sRr/BYU9au4YnSeEPTyV/4XFJQZjyBZNtWO0YKR3knMYc6n?=
 =?us-ascii?Q?3/YEMxhFytkYcH6Kqt4HTz8dw1igC+Kh5cNerIhVoOCCk9WHGrHgyhYKF0zA?=
 =?us-ascii?Q?GDyBPNuNShmFcqokj19vYF5aOQpThMEiHP2b0Wilzkyml+FcoCcfy9YwZadH?=
 =?us-ascii?Q?VT4ugLXqenOvuYcLzabdZ5f4hgzA6GA6uakEWfgHrcpqODkN1AV4Y8grCk5c?=
 =?us-ascii?Q?tXax1kULjqdWPdCJp6d6SuOPZs7gc++Bg6Frsk4I7BcfrntLMQ91ObIscZkc?=
 =?us-ascii?Q?NpoWjFTgtpSQMqPgSKT1zHg+96p+31hj5owBswFqyl+ADAAGCRmXK455RQ0y?=
 =?us-ascii?Q?2DyZuqnC/M4ZN9nZ2gVf01gRD+pRot9k5sLTT///9rl540rBU/Hxv6Y/c87e?=
 =?us-ascii?Q?BXc5nznxGlOM6E4eTKRAbvWfRlru/VbhKZk7vLVgEQYUwKEZ6xtVz80Yp11Z?=
 =?us-ascii?Q?+ueHWUkjXgz3CdHOc/j4wruAkyUXv0JeixUMH8m+hZF3Iq8KoHT6vemxovA4?=
 =?us-ascii?Q?Q4DmmNh4/D8eNKJwEpvx75qYnXPEYU8NbVxI07wsxd0cOptNh+8+4LwKZJl3?=
 =?us-ascii?Q?zZFuNOoIFbYBRZ0bcHiSAqoap94vLsJu/A6QF7vwbQlVQ6mS7+ObytJfzZgA?=
 =?us-ascii?Q?VqG9MEqNkFPUVv51NWlKGlkuUdQHf1a3uT6qNK8cqgHeHCWnLsR78KxK5OwK?=
 =?us-ascii?Q?YMUNI4h3EIKN5tYc03UCEjQ4V4vOh9cQsqgQutRTBjIJdHDteQ715UdKMAQT?=
 =?us-ascii?Q?wSYd/oxQdMNYttOjVLoTL1KNloBm5G4Y2Ys4qxF4zDA0T71CX8LI5DAmh3WP?=
 =?us-ascii?Q?rtLGfq7lom7S4Ik3b+B6rYEFuH6W/SMWW2PCfiAXvxhTICa7UYOCDZEc/h+U?=
 =?us-ascii?Q?cJkkC5WE3HhLuaGxaQjFrjMxFXv+i+UPe9PwSWXwTudZIaMSZ+5XsJNewLMD?=
 =?us-ascii?Q?LLU13Bj0GnE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XX1ick3dwrQ9zzFrbMJ/sFRI1yv6SafYG7vPn2i3jldj6JUq5TEUPfdLN4Gp?=
 =?us-ascii?Q?htSSR+J749ULrHwP3mUv0VuCcQ0T8o9I3ul1utdLkT/gW1dtNmkGPi+d+sEi?=
 =?us-ascii?Q?ddlSxcSqhNUKxdQrb1xzdV5Jz6PIvm8NM7nPt3rS4xKJm1m7yRxwN0BCCl4+?=
 =?us-ascii?Q?lRb6Id+YcgBEL/75fYPXUBo6Vs3B7qag3WjbaiB0xe770mujxneLGDJUqwwi?=
 =?us-ascii?Q?NQ+1X41eVVwMe4CFeOU/42CQXEhRRTj6i4ipxV6k6SvHaeqBSjgAIOvXueLC?=
 =?us-ascii?Q?Devahp8dOCnhMZP1trMrHtjcM0JpPsrw147LvZDonoPBQAfSbkWiOLdmrL1C?=
 =?us-ascii?Q?haG1Hw4GQPOGKRUce7jCi8or4A0znnFaSkSh8VgfmFn6BDKAqrh6v65cq62x?=
 =?us-ascii?Q?/eaWlo5UAENwnflGhJV1DE1xMPWp+pddQHkCx9ankZXxILfIbdTlsxGyEdnh?=
 =?us-ascii?Q?l5TCjeMbCxqOAW0Gn/evc2U4Y7CXC/zasWIcze8yFU32dwLqX5wKhNi2eiJG?=
 =?us-ascii?Q?Q/jiboG0n5e27Co4nX1K/Q/0yh1vgYQu0yRZW3vQasvN3wqbHrPNIFKVWa4g?=
 =?us-ascii?Q?iKhHqcW48UUuZSEreKZruJjr3ezjWzN8vPIbpp/PjEwMwCVh2zC8xltdOg4i?=
 =?us-ascii?Q?deM37xNfWMnSJ68eOj2hxkcLMAEadkrU/TSQ2Na2MbfHbwUEI9W/AqIRZvs3?=
 =?us-ascii?Q?ibg1bp+V7O2PYNNeaQJh2DQ5x9Faj2rc28VYxeHA3sJ5/81PmAvKmHyINjob?=
 =?us-ascii?Q?T2yZLSQFJxxFXNAmd03j0t1NNY1zlQ9bmbDC1P4ErIBFR6kzsF/myyJ3qv8a?=
 =?us-ascii?Q?a7RvN3jVsxt/WwdM1RwdFA7kIbmXNz766IFLjj0xWWQoAwscdhBPsyOz8luG?=
 =?us-ascii?Q?LhCcHYwe7nCQ5ArSJBljpAnmwD/+kYuQOw5rZ5ENxOeLBqZKmPwsVcPOaOKP?=
 =?us-ascii?Q?1eDbeSn0TA6PW3uQuWDxsEf8QOQXQuEPqitMvS8NR6NP+/76NxtUV6yXH7tJ?=
 =?us-ascii?Q?N8FMoafy04W3bVCXc7XMiDfifxAX/tozLQ1HeVtSb5Ydt48jqPlb4AI29uoK?=
 =?us-ascii?Q?1o/U+p/HKn20tvGuJS6V/XNdoN+/4oZtXTTJFEigEGBhHy4H3IpOUv6QY8L0?=
 =?us-ascii?Q?OrwW/doZvRBM4D7PJXurKT2cjSVMPI3vKkqEfSus235cKuo1xB+N7y0sZUqJ?=
 =?us-ascii?Q?7jA+3Wos4Tn43Yj339jq1jAibcH4EmmkBI9QbPfo1B6Qt2h8N42/vr21iLGk?=
 =?us-ascii?Q?db3Txim6o8GBTgYXM/lE/WptUsSFTLy6CjAAZQu/fo52Grqayv+BmpwaqbN5?=
 =?us-ascii?Q?r7NDMji/+m8i/+y3O7vf+wV4LX5lWHOcr3IV+6FgrBE8uVpQcO7HmzItINVD?=
 =?us-ascii?Q?DlWVJCWYG1KVRyCZIXjD+Y4m78sZZK6UnMORnZh7D33byOy8F22C78f0WZbF?=
 =?us-ascii?Q?OYhznK7hEKQsUBUrPAMlr9B7cOcbToiyiWGsmnsow6mECvtM3BwB8u98/Ib5?=
 =?us-ascii?Q?AllWQ2SmdgDJuA6xvpOC84tl8IYQ6TfuK543xG18blUlwcN1KRaGy4kW+3g6?=
 =?us-ascii?Q?uvv9I5JV+8/3Zz9sEfV9nwSLzgPhrQhCfU31lXvq+KC5SyLdE6qDUHy63dn4?=
 =?us-ascii?Q?M3gD5Zi6rKQ8GXUtWX3yHFY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2C3C17A715C5094BB5FD147142B0C7AD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bEaekhVoGJr19DDglMBUnQa9V8m7ONCnK1LO+fVXxo9WuxPvMenE0HdllTFRs6uv7zoJelYa1m7ISYkKbWOkM8zLWs8PWamRC/2ZqgtGJMljQlgxiSoERmkLkW8tkN4zXmnxgr+LG/NL+AWjo8K8IQZwSRHEixBrGlC6+v9XN+RD7yAaUyzGIMVuNDc+4B66LsyGVJs5U742zjkzvc0qkf0WFrL/cUSa2m6xoXER0cQ4VE3+RkTMyPCgzpaiwy6/pXLuZdj36z3uWzKrcQsbNyeHl/27v+FXPNmG7kMJKvr+h7uboScTQGF+jPINNYmlH/ei8x4+h4rSvVUlunQ5OJJj9HS2zXzxs/EqCqmb0ePiIzpn+lMhy+3vUBjrDDtbRXJNgHLHlB861wwbETkfjwGutxMLESb4VtJXfJQ5Jh3BtVEKiO7o3e2D3GlufvKGL+PWXYXdWtqSrdcfu2PxvpKf1jBNJuMqNAS5l3/qom7wlybBcI2wRu7Gsr2Sf+kmyVEQxGNK4+y4gRuf8v4DpYsWop9ZfD5oOl+e6MuW+YEs6R8Gt+npIZpm/KR8Xup1T9bS00axoRBKIP5i5OTl/aAUgJH8XPeWGG8FcJolGDxeePi/WcdQMWwB3tpQgBHM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690aac46-8d4d-4f06-5078-08dd93ac8f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 12:32:30.4024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AeOjz0M2kgWf4kDW5ouUKHD9wUp2fbP2f54UGZB8fvVQNi5rnLWGcY2roBzFZTzE8x40lE9B+XjOSDTZOxZBpoFQLJcZmJouODjPryVoT98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6971

On May 09, 2025 / 09:44, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>=20
> The _nvme_ctrl_tls_key function returns 0 if `tls_key` exists in sysfs fo=
r
> the respective nvme controller. This will be evaluated as true. However,
> the test should error only if the key is not exposed by sysfs. Which
> would mean the connection is not encrypted, as per the existing warning
> message in the test. Currently, we are checking that it exists and
> erroring out incorrectly. This patch fixes the above.
>=20
> Link: https://github.com/osandov/blktests/issues/168
> Fixes: 9aa2023312bf ("nvme: add testcase for secure concatenation")
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

I applied it. Thanks!=
