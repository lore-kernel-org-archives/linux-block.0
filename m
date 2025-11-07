Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D68030F55C
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515674; cv=fail; b=lDNaIED/Y/JYKyQv5CcVuJsNOH9XPQRqjPiYok0+WPA3uyZpDqR+RZzkYmWPI0SSb4yT00rimmIUYiJdPHrqNistHyOJJUz61WK0pEePaJQDfj30yw7UqCDbxbhHX2+t2tIDo4mi/LDBXRubmJ7VMqlObdYddQmgZLKLBeewQ/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515674; c=relaxed/simple;
	bh=uCz0tB5aa4MJvReZgYOC5i7Ffsw8sLcDH3eGMsGcTeg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PF00m6frrxoD0+nqjc87DcWfnBdFtpd9lAueXaKmZlaBWVaibPdW7jfuveA3Q0uVP6XRwQDk18gfQ62iSKXkiU+qd6OBrzHFn5oKDLMhtnEBOFnUxwjp6jQ6wlFziPctAtdWD9Nr1obJ58Bu7XLptwVzVKvhPV+uVtBr3fvncLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FceUpFIb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cEEWHBmV; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FceUpFIb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cEEWHBmV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762515670; x=1794051670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uCz0tB5aa4MJvReZgYOC5i7Ffsw8sLcDH3eGMsGcTeg=;
  b=FceUpFIbriF4m8xktq31jjGkEYSbLSQBLkB2Uv9dU6Ry5CSX3BGo4qkc
   2y61DtcD2bjtg8CbBIsxktp6OmFyfFqJFHyrJmxeyPFSWbO2vdTX0z2nL
   4H2IxufUwsKtCEX0Gin+vZvKAYKph6Gdg5fZmO6eLqbgAjMLsPQsa/9aK
   /fqLw5fr8HQIwlJCTNlKTNmaJEIOLj75rWzPHUUglzO0r91RAjYzLzsOt
   9bQLcWoNJUq/RvpNybPR0BLp9jkGiz/Z8wEsoNXpPVPuu72s6UAcyUfGa
   T/rPXNCeQqTYDH0jjcd4T3RAu3ud1LgIat0ZjTX+5DR8wnff8rrR+5wc/
   w==;
X-CSE-ConnectionGUID: vBiHpqToTB+4AbhBqLtIOw==
X-CSE-MsgGUID: N3CXK2pSQqGs9tQiwL2TIg==
X-IronPort-AV: E=Sophos;i="6.19,286,1754928000"; 
   d="scan'208";a="135649876"
Received: from mail-westcentralusazon11010066.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.66])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2025 19:41:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUdNxXzCg3RNTDAJVel2o+mpSQ/BAvQCKZiA5s9jsjarrYAHgCSPZmVxPPL5ShRHDzRtNQduyZy6jShZqeqan2HKPuFZS3V6SQsAIbhZSm5EKIWAtkxZQ5b0ubbAyt/r++8unD4gcW8m8vLlI2xPZrEm6dGyHwSBSJH2HKmO92YtYZSMg/fToU2q/N35FNpbc6RoSeGrSakwzz3FF4Z2X+ukFkalVJllP5sX04RfJWRO+f043YaduFdxD9ppLTeCPqjSrY9s63ebxHp+CFRzl0vpvyHpEo9JDn620GZ0hXnyb+wWVidlPh28zvup/sSntAJgI62V9qecFu//zkgQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q89X3OQk8ZE6dcDbTCglAB0Qbnqx5JFzCPfnoXjmSO8=;
 b=TONWX4y2OBSlnDJcvvYRbJa625QXLCXJXVxEwmNLpilEou0MLvv4YgcCidJlouexuKpBM7HI5W4ID9ZhalwH8HN8trtPoIP5cVi4A1DJuUqZj4c2O1P6Fdeuf+nyEBwn2L4dL4iOA1EAR5cvOYU5Grl8TL8ZQ+YQIX3oWdGJoyjIfzX8sXCERwWxKiW8qX6YnjL+S29G1XLjhpeAPkwIWRAXjoTZjx4GeP+oFe6F9sLVVbdO0sRmc2j9odNl3Rm8SmIV710eFUoyrLsBOysuAvDcayHFfNrJrgj45ZdIXMqbaw/BA7a9s4vd3Qwg9NeRRZEp/6DcZDXXOH35dCeacQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q89X3OQk8ZE6dcDbTCglAB0Qbnqx5JFzCPfnoXjmSO8=;
 b=cEEWHBmV3B2lBglpPyf/nHBrKXrdyNbB0TMvXFu3bhcrHiwkKtGCC8o5n3JlMy7JR5KZMWPymTk5OJRUaKhhmasnnq7nvCYSpemXuM5rOC7/d642LMhgR2/ncLyR8RoN5vazpvtEHyBJVd32/JjYdk1Lu2EsZwA9nxhViMJ+ogo=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ0PR04MB7536.namprd04.prod.outlook.com (2603:10b6:a03:32b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Fri, 7 Nov
 2025 11:41:01 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 11:41:00 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktest] blktests: add nvmet memory backend support
Thread-Topic: [PATCH blktest] blktests: add nvmet memory backend support
Thread-Index: AQHcTWMToI71eOtWe0uJ2C61pe3D6bTnG/+A
Date: Fri, 7 Nov 2025 11:41:00 +0000
Message-ID: <qfziubfpdzaqj5bzb6tyiowncwuk47qtr7zx3onmyejarr5jib@cu6eydg2ehsl>
References: <20251104081436.191823-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251104081436.191823-1-ckulkarnilinux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ0PR04MB7536:EE_
x-ms-office365-filtering-correlation-id: 72d1c264-c421-4601-c156-08de1df2866f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tCeCrK4ithj4rTbJ/+ibz0aPE/anIxrcphVNX4eQ0RfZlNyfBPB6r0NernBf?=
 =?us-ascii?Q?s3DtZcJ97KT1UmAyLN1Q9eb9aLi0AOs2T+8SNCAPSsPDIbbavoGMucSURzi/?=
 =?us-ascii?Q?idPlLLqctvz5RCVafeEMKgPwlxgk/PbDL8L7eyMoZ1TZB+CPYwMBuWkPqNhI?=
 =?us-ascii?Q?jG3sk2/9RJg5JMT7GuiRCOEalRihWmTj7HirCQA7UO2nq2tCV3YF89suk1p4?=
 =?us-ascii?Q?vt2vJn05ibqmhoLE8l0pw1yz9YVFHYyM6KmPBRsQrWCrz0s1ja7xkp100IGW?=
 =?us-ascii?Q?VCxtK1ZzwIf+twCJ0PKvKdFfWHHbzNN/UZYcBe/32mRVRgUc/lCCxdbnc1hw?=
 =?us-ascii?Q?KTGHmWGCUsM45zSO49ASSjIEvlFXku0BigKo3VYbQPFP/CYblCqa5nRP1I4j?=
 =?us-ascii?Q?Lc1sLEzJHgMO1XXPYbDEaGJlRa7WOzxQ7NS9dAXwXACtT0F4R0WGHx+ZoQ9S?=
 =?us-ascii?Q?+tSxNUEY6EzHJdjm49JG9BEKw2hG7cazpDdwx4MIBgb325aXf6GTbBhj0FA2?=
 =?us-ascii?Q?UCPftj4/Uz0tw/DqTT1tlA/YnCY6/qZt3t/qMkF1Nsa4G2Uw1zjvNERoT7vr?=
 =?us-ascii?Q?Rlhj/YDDsuC6U6ui+6myBGrc3oeeFiGNt9dvSaW+2lRQTI41W0nwV5w+tqpW?=
 =?us-ascii?Q?LROq5dAFE4G6kcOgEtCr4GFiwVAbe1q+iyYu1ImUQH2pOzYrVX30FDL3tXQs?=
 =?us-ascii?Q?7KA3Sk0joaiTgDPkzOW/wSFZ+VfPdMGr4fevhHUE2XixNs8hyk6ngA/R9tMW?=
 =?us-ascii?Q?vFyvxTWKuezcXRKbwehO1LsXvT3fjJ4K6VdO1BIBH0kfa7gGFuPsCMF8u9HM?=
 =?us-ascii?Q?z922kL2EodrmRdhgdIBB1IKrbfx/5KjQ0Un9daB7Uvt/nzhNJmXmZq6ohS5A?=
 =?us-ascii?Q?GIQfcX4FHFBz5pDmbHQnXs4r3yTG0/LiKrcZxCDGAvhJeRiI/mg0t6oc1HV+?=
 =?us-ascii?Q?l9qBOc7Mon39bh7trdAjkpRW+ZWIQ0lH2qd42NfVHDnAYtdVDWILn14VYj9b?=
 =?us-ascii?Q?oXf7+hIpbLTAA6qCWhCMMPcauG7Iw+Kxq34hR0PeLev8Oo3c9t9WjAKPVGLT?=
 =?us-ascii?Q?rzVCVmQZLgtR4nLyJWSHgIiQ0H/Kb4Cvezms7wtO3hp/iLsToYnF8Olw4iv5?=
 =?us-ascii?Q?m+exG3lTYRrCohFPcvzfnPxvf7Hb8WnhFOjhq0VtM4eTz8cgvRLJvKCfpXA7?=
 =?us-ascii?Q?3XaiaEqJuVq+WPwEiu4L1WfQqwtuZjJSzUccMTwLJYZ7B6KbvTcHnbyoHT1w?=
 =?us-ascii?Q?k4qvZEht7epnp0tajLhZrp6USMhLMI+PYSSawwZ/u4+h475RoNQekDLx31KK?=
 =?us-ascii?Q?jAYy1hxtheuc1kO/sODKNWBMzHByITjJlYkPTcfY6wYkH/k2m6K8WKAl06u7?=
 =?us-ascii?Q?E6oX9fJv2jvYW4p18zI3iXD95dSDsB/IBESEWLivtbkRsE4krdZ2W5lxcug/?=
 =?us-ascii?Q?a3IZd68LAg6aDispc4RHNMk9zO9XlWcpF3FAHJtLOf9arT4YlqayB+dFOPAr?=
 =?us-ascii?Q?mWMfambCbbey88sYp0pxBdtSBR1SQKX4IVKU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PInaQfc6jQohRglbAG70Q420+GQSqPHofdYypL1Y7bNzMJR62sSRzPjR3wG5?=
 =?us-ascii?Q?Z9y+R264TxWycc9XQP2RCbVXi2M7XXRykHnJp4xqc1niWO0JjO0ukTSz4OQ+?=
 =?us-ascii?Q?7GcGR9dXeOw/jqQrpPGhAPYHJnm0/nxDgr7CrPLLDCBQKCan2SfJ8XYT3U46?=
 =?us-ascii?Q?QBKAtp/g9OHEfH4fjKl6R/T47RUV4RhCEOkp7c2muMqfeJpKVyd4fijn4KO0?=
 =?us-ascii?Q?sHjNa3Xp3IGWqCfgQlkTBJsFrPZTa3d0MeIzC7zwFJqS62piKREnSEDQE35M?=
 =?us-ascii?Q?2USFn+vPyI6K46p6vXA9Z+pe+7xu/UsL9lDPtO9TCaDojRsui8dWF6ffi04u?=
 =?us-ascii?Q?gnhPCnmtZj2JMVCUMFnFpSH/ZrAzcZE9TLIljepI7oIjTffyDeF00ZAJz8pP?=
 =?us-ascii?Q?6SxQmeNjMy+cu6yoYJXylJg5mPemde7CxYSGkvZmSE8XsX4+BR83OWsYIVud?=
 =?us-ascii?Q?1oQP5NUeIDzxA6UClljKYKOtcTFXgpArGW4mgrCN+f8kNld0BVIUOZcvf7CM?=
 =?us-ascii?Q?RWbAZMKu1xu3rVWqeY7hf1rNwtxKA6WB027qbu5yr+rB86ttCiamQKMqFIat?=
 =?us-ascii?Q?GWy4EK/ZQ58isQrbOnPs/BoZlC7v4UVrB5hfNULLZnUwgiOjXxr8oKdLzv2S?=
 =?us-ascii?Q?W5oYOi8JXdkr6ruHUg2g5spGANV4OSIlPlIllFcEgjwNhZ+ezOln6ZdZgT04?=
 =?us-ascii?Q?ufsKTnZp8H2HaBhOwA531z6o/RuodA3yrCg8pmr8RZQvIznTD1izJNySuafa?=
 =?us-ascii?Q?GXu+7u+c5BACEOaROOVWFedyFYdqcQsVAp1B8xuaQJe5goc8EYbff3StD5at?=
 =?us-ascii?Q?L8MpD+Uvk2D4O614cNaxCDkDUWt/qRlz33t7MAJceshyzIUgsXRGG1M5UUD/?=
 =?us-ascii?Q?WkEtRYimXoTRd4Cf7wl9Sgdm1CZKzuU1pT63uZH0sM1qJjiCa2qbaqbyIK+s?=
 =?us-ascii?Q?4WlmNIxAoInog3Uh4W9sPipgLmfs7njwTDAHAnydD4UXxNn0X9FaN4dGis2p?=
 =?us-ascii?Q?oD+A5TOzwqqZfYJEkGnubVFai9JdlDnVvMvzu2YukSN48otDRoxv07yeMLwA?=
 =?us-ascii?Q?JQRQXR9cE0m0XhfR6LYC8ir5ahVuHWrc179QNk+Hhdv6vcwRVHqMasevsBEz?=
 =?us-ascii?Q?24IX5YvqG/cI29l5C6slgptFeGTQ7izvwvVzhahsglPqXjXuzDW7rSjFonjh?=
 =?us-ascii?Q?AvCJ8FIUBqp/Lu+UgE1ASAUbHqvp8QaA05L+kvBye/0K6TK27h9eQaikd3Y9?=
 =?us-ascii?Q?NPHvtCtJUaMZx3Sn+sbSXj8w3vQA6PIoglsHWFfyQDXdCV2CdZQysMMYF3DX?=
 =?us-ascii?Q?J9J6Cy5+Yon+pCL2LV/zbU46n4VGwLU30l30SRYFfq36pe1uv2r330EZMDi+?=
 =?us-ascii?Q?Wpa302UW8Qpn7asg9VCdNpI8CP/dxG4Uw/epum44BrBmPn5h+SjFdz2IVP8T?=
 =?us-ascii?Q?mOjWVWE7zGmsMmxFaaRTXPXpLnKHc6gSmTsMlPZF+zvy3rScksRGyffaekjK?=
 =?us-ascii?Q?UaCYPFAGYTXCsHugdbYd0c77zPiCrobVhIN3cy9xasMiDy/HGuM8vlKpRwUU?=
 =?us-ascii?Q?JvLvrxegoqAVtn1rEF/2qZNy1gUT5CJHQQLVM1DKUFmnuIy0029xR4pDaKt8?=
 =?us-ascii?Q?2nPSnmhQLaDa72miY0hnxHo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2F41616B612A74EA01D79A22517F4A8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CYFKBiSHiU4bW8NQt6E8Vu00ZswyD5BdE1I6E4t4QwwVhBfPZx/p9mzlhf7YPyNLwP74a5Tx6vCReDXiSy0Z5YIc7GEj9eH1lds9VK+R38aJUY7NMYx+PEbzCt665qbJyK8z50TduhSwuBNoIKZ6Uh/CR1qsh2XuRT4Zo426yxG4eXA3Fyxx/UefaE2BxT3rfM955lOokfBhrIb9+BF1WSs5rowm2tMGVh8u1lq5D01ec7oOn0sGto3+4KrM0JIDlGTbYFwQ5XFFpSsCIwxwYuxc8eiQdTw9/BtsC9N/wvfXB6h+sPLnpKX7KpimuDlvu2qj9rFoEDKK7FNvbHdqtGbupz/YABDb2+rqwzWs1BrUuYIePuFhdgeCnzpy14mWS/tEuqu4rPbPayjCljMZT7SKhyyP9+T56oZ2RoBXJZaiP9adufli0tbaXpyn/rT11x43sqpdqx6NYRfXsq1BC16uJB13JfSbPCRfbu6vBXJrYFpuNuVrh05ULv0tKnnOWYcvOS3kfiJ2W6Ui71INIZ30ykz3sfUbG00LxB2gnSAPM0/h7aZPrRAWjtfg4EsCeJW05mlJrOmfOzWVcMWlSW8VVhPPzt5bmWgDjMiaMwk/xgYsllHPXjIkNrMzlZ6V
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d1c264-c421-4601-c156-08de1df2866f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 11:41:00.7684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z0XyzisvysGJuWCGEA+adK/BnBtpo03uWdKYCQ7W7jdafdvwQmtvRBOwQQf2o+pYfMxNn8RcWkiNOIEmOwwkxL+3cGX4STdGQWiNS68N07Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7536

On Nov 04, 2025 / 00:14, Chaitanya Kulkarni wrote:
> Add support for testing nvmet memory backend across all transport
> types. This allows tests using _set_combined_conditions with
> _set_nvmet_blkdev_type to automatically test memory backend alongside
> device and file backends.
>=20
> The memory backend provides RAM-based volatile storage for NVMe
> namespaces, useful for high-performance testing without disk I/O.
>=20
> - Add "mem" to NVMET_BLKDEV_TYPES default value
> - Add _require_nvme_mem_backend() prerequisite check
> - Add _create_nvmet_ns_mem() helper for memory namespace creation
> - Modify _nvmet_target_setup() to handle memory backend type
>=20
> All existing tests that support multiple backends (device, file) will
> now automatically run with memory backend as well, providing 3x test
> coverage: device, file, and mem backends across loop, tcp, and rdma
> transports.

Thanks for the patch. I took a look in it, and has three comments below.

1) I ran nvme/006 with the patch on the kernel v6.18-rc4. The kernel did no=
t
   have your patches for memory backend. Then it should be skippped for mem=
ory
   backend, but it was not skipped, and caused a failure. I found that the
   helper _require_nvme_mem_backend() is not called from anywhere.

   I suggest the change like [1] to do the check in _set_nvmet_blkdev_type(=
).
   This way, memory backend can be skipped when the kernel does not support=
 it.

2) The section of NVMET_BLKDEV_TYPES in Documentation/running-tests.md need=
s
   update.

3) It looks that the kernel side change needs some more discussion. When th=
e
   kernel side change get settled, I will take another round of look for th=
is
   blktests side change.


[1]

diff --git a/common/nvme b/common/nvme
index a558943..b08376a 100644
--- a/common/nvme
+++ b/common/nvme
@@ -62,19 +62,17 @@ _require_nvme_trtype_is_fabrics() {
 	return 0
 }
=20
-_require_nvme_mem_backend() {
+_has_nvme_mem_backend() {
 	# Check if memory backend is supported in kernel
 	local test_subsys=3D"${NVMET_CFS}/subsystems/blktests-mem-test-$$"
 	local test_ns=3D"${test_subsys}/namespaces/1"
=20
 	if ! mkdir -p "${test_subsys}" 2>/dev/null; then
-		SKIP_REASONS+=3D("cannot create test subsystem in configfs")
 		return 1
 	fi
=20
 	if ! mkdir -p "${test_ns}" 2>/dev/null; then
 		rmdir "${test_subsys}"
-		SKIP_REASONS+=3D("cannot create test namespace in configfs")
 		return 1
 	fi
=20
@@ -82,7 +80,6 @@ _require_nvme_mem_backend() {
 	if ! echo "1073741824" > "${test_ns}/mem_size" 2>/dev/null; then
 		rmdir "${test_ns}"
 		rmdir "${test_subsys}"
-		SKIP_REASONS+=3D("nvmet memory backend not supported")
 		return 1
 	fi
=20
diff --git a/tests/nvme/rc b/tests/nvme/rc
index a8f80d8..92cefe6 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -42,8 +42,14 @@ _set_nvme_trtype() {
 _set_nvmet_blkdev_type() {
 	local index=3D$1
 	local -a types
+	local t
=20
-	read -r -a types <<< "$NVMET_BLKDEV_TYPES"
+	for t in "${NVMET_BLKDEV_TYPES[@]}"; do
+		if [[ $t =3D=3D mem || $t =3D=3D memory ]]; then
+			_has_nvme_mem_backend || continue
+		fi
+		types+=3D("$t")
+	done
=20
 	if [[ -z $index ]]; then
 		echo ${#types[@]}=
