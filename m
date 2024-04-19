Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8598BF7
	for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 04:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713501002; cv=fail; b=Eg/gqDUXsGVY1EFpF6u3bsYWsHQgV3iCk2p408h6qGkr/lcR6ReCJOCxrmi434+HtMFQ1KNN0EfeCaJTDvrQQxHmyWbsGFpj2WebJASewXRnc02LKHHSpoOMHu5YvpYDr1i2/rdGGo/l9gHADaDBOmfDsMDWRfEjUHo5KfOuJvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713501002; c=relaxed/simple;
	bh=Wvb//tBaN1ZpMcPamLP1BsHpXMO/p+EXbcSSjzKr4vk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B+zXBX8KEWQVmEmRsRVt9l881eUmqAoymAyDZEVV6Sr16r5gSm8oObrUbhAtMGUBBby7MerUDLstz3kUv+QLdrwqumK2ZDdFK3SjZgXSVsFhILtwrKYZ1FJo7xKDdPYBqZ2x/x5NudtFybeWX63re9VmupwlrC1EMsjkT4Xrtrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AcoB4BYc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=d/Oj9S5M; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AcoB4BYc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d/Oj9S5M"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713501001; x=1745037001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Wvb//tBaN1ZpMcPamLP1BsHpXMO/p+EXbcSSjzKr4vk=;
  b=AcoB4BYcufl41Zg7Uc47UaTmEC7gITCwRzekfJXUmUwfkk+8g561Xhcd
   1/SDtLAU2QB3jLcPKfIehTL2phOX7/WUtE/82oy+5oASxnRGhc/0g12NG
   B7J+Fj5N+ohZ2zd6h1cIvPejW3Vqrs1Ienp6pr1Ca9IVGYWPOi91k2GMi
   jLwlzjtFOXsm90JU79nxVfGWGROsxH2Hf/BFmGyke+tHgRTQaGa1TWw1b
   lhB6D54lcpGNVT2V1b+UX3GhxQabPlyVQD2UXx5h2ertLpgSzY/oiuFNp
   3BYT+ZR9+tkBJV3UrfJx607LV6zAL28IMGnuKA/fR9Apv2vjThwyOe+Pb
   w==;
X-CSE-ConnectionGUID: mZI2A64wSPurpJRMBQanww==
X-CSE-MsgGUID: k+7+ptsaRQ+ETRUlh9jEew==
X-IronPort-AV: E=Sophos;i="6.07,213,1708358400"; 
   d="scan'208";a="14165996"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2024 12:29:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXKEPeu18h1nJ8dkwNy4hqqsslpeQDkYwI+QS5G7yCig1gABUWbAOesHdM2enMS9bG/0RW6uVswnwPLxqOd4RQrM0M2BOaLbXzLP54H7W/hesDCOqRD4shytH+C+cT6Usz9ITzxHOmEKUD5kDQ+K1wk6xm4uvWdgBNSx/ATQgP9swXkWeXJWO/XSDMOVwbyy4ZqR8BGxzP81A1S4U9ryUXaEstzH/5/+nnMk2IcvXcf8y8cFMF4/sQoQvtcyzEI/pOfWiQ62mOj8GN7mlVH8ZqbixcDq8hiQVxSwfWb0C67vcj9WFJIthzR+YxVrGAbBFK5hpAxsDshubsgvt6rmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zv7tFua8McxMXcvy8nnHrbX6AlSQcrG6lW3Ypmd0/Cw=;
 b=G/HuM5o74kbMjpqJ05WmQrn9WTVChAADgqyc74Z2HFhZySxf0jPgf0eAp9ubCu0TgZXbjGkQE1zP7inOyXISVLMGtiAkwLGP9WOGYVFri7FEkZ0YWgHUY/+hQYv3S0W9AGHq3ynpVY+BqxGbFsLLTfLyi3GxKC3gOIG4YSlLl6ghJLFZiSBs9qkOtjbRo6323Hq2CWD8BdnpeLeq24KTjCwSEsT+dvSX5+lzwMjNP33OGBA5vmsl/d+unB2rn8SBKJB/7s6DX8uD26+UpJDUmflQTb4FYiGEIOKtkb2ThjAU3mwrGzYHm93AI4upE1bM78REENra5oUPFY8Or/LUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv7tFua8McxMXcvy8nnHrbX6AlSQcrG6lW3Ypmd0/Cw=;
 b=d/Oj9S5Mg5oyiOU8q3+alwHLUPgzUO5md1CwqDKk2PAqaSqbXaBWAcZ+D9mQjIEJTKNp0tJjC3O0oVrA8gl/sL/pI7wW/CMa2HhGge0l8mEIrPCRq0C/7s4YPPEJnVUljghxZK6rw3WE1WVj5B5DGtRgmDEAH4oU0d8+aLN7bfg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 LV3PR04MB9260.namprd04.prod.outlook.com (2603:10b6:408:274::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.39; Fri, 19 Apr 2024 04:29:50 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 04:29:50 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
CC: "saranyamohan@google.com" <saranyamohan@google.com>, "tj@kernel.org"
	<tj@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yukuai3@huawei.com" <yukuai3@huawei.com>, "yangerkun@huawei.com"
	<yangerkun@huawei.com>
Subject: Re: [PATCH v2 blktests 1/5] tests/throtl: add first test for
 blk-throttle
Thread-Topic: [PATCH v2 blktests 1/5] tests/throtl: add first test for
 blk-throttle
Thread-Index: AQHakhI36ARzVIb2YUivhgfViJXHaw==
Date: Fri, 19 Apr 2024 04:29:50 +0000
Message-ID: <vx5xlimpl5znnqzwjwevtl4yj3yaxyaebaqfxkdi6ndztzu4hs@6fddxhpmqfhg>
References: <20240417022005.1410525-1-yukuai1@huaweicloud.com>
 <20240417022005.1410525-2-yukuai1@huaweicloud.com>
In-Reply-To: <20240417022005.1410525-2-yukuai1@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|LV3PR04MB9260:EE_
x-ms-office365-filtering-correlation-id: 1dc0087b-c52b-42f4-0d4d-08dc60295a32
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Mv9lHWuqSprknYar9NYrF09PI+fwFye5gt4khKVVDAVqumRI6k2f2/8pKsfnmO3ZNLGbEr01MAe1muYx/2hGOOc3wWHIptOFlHDyvR5FFuoU+Mm0uiI9G9oo6Jqe+1eCmsTCqfqa5rCTz7vw/7a+KQBP3F9i0C65U/hUDZyRmG1HVbRZh1CaYFMZNnL0c5Tmaac5cOSUpiYIn6vnuKxDp9pSy3r+Vr+HhFIRd1rVcf5ABPJWpQa9QwSlfBiuEm7YwStTNxUUK0VqdgTmf8xiceUQGorzmT+IQyo13WgqAGN2Ob/ZQtRnmyxVXjuGcg6bmeTOsy0DFbOPX/LqGW8j07aO2clhjuO4yzivaeDqkZxao56SCiwhqNbp7oj+6oPokSWkUVfIHYi6RDr3wTmxIUC8AJUlvnMe01kULcsA3tF/vtVtsEjKnps3gvr+cIi4nYMuAsT+ZCVlGG05Nqs4WuAONSx4oM3E83PFNLEj1wcxSrHPARIt6O5Ms5+U3ZPqGxpG20fJxXw+4e+bepBDk7VxsgxqEHaC86mXo+ZT/GxnJFh5s9K1MwqtkFLjZULIgIU+dsxfAQbegg64gaOOOWbbZd7Ei1LyKJFV+NtDxa0dMjBkhqr6yW0UB+qDbTmefzNhecli4bpD/9Ov9WJpGgtAhB5WnZCetRWxPibheWf8m2JcVNqag3j9Vkpkyr3/YT34qlBNhuTvvuYP9PnijEKd/VuQ1BORw4guwfqQWgM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OT6PK/lZnC1l9lg2PgsHjwShobIm8K1DTJYO9WnjuD29U9tRY1FGWccPAjnT?=
 =?us-ascii?Q?BCP6WEBEsZcevfOVlpYgidirDAatvpnpic1EZyT7D29Z8s4xQLqsne/tIaKl?=
 =?us-ascii?Q?VOjUQzkhFXcEG3IXvJvEPMybTrMTPYeSq+o+w0qT0hDpBKVeSlFKG3xxMXpO?=
 =?us-ascii?Q?HpcnCUxb5Ropw/4SDA7KX20FciY+rWkDoePWqJRFhefiTJ9GbicC+I3p/dNH?=
 =?us-ascii?Q?IYYwKFM6aTPyyzXY8tjTKT8UMUA/kM2eVujONvDvYF6ihefUXcjWEC3vljQ7?=
 =?us-ascii?Q?vyWnT7iWl4E2IMXfcziWDKS2xGFP1A/GtczTl0C7Bg4jwQGbdTDJNKa2Ki+2?=
 =?us-ascii?Q?8GQrv/XU8pe3IkspJhC3RIA36XxmYOdmrZOyq7A0AvoJDty75+/RFPuCS8QE?=
 =?us-ascii?Q?u3yWiGsUXH1X2XyXlP/FsvcVh5mHIieIdtfxJf5wQh6lFLcLLsxuaqXwHvXn?=
 =?us-ascii?Q?Yxow6Sq8DryIdJl3SQ8tAjtBKZ/seYDtpkJC+1Jhzp5yDA2MkfHacS3/jaro?=
 =?us-ascii?Q?ZT5KeOlcSlLuPjHH5rY6uIXF7htTEI5LDSLrzSi8YPmUD8F3pkX/BfaZitdh?=
 =?us-ascii?Q?Vga6GUcjL5BdNxFWJUuOffomHtCf54afZGjzdPiaxq+gY2aLJxLOQsRZtjeo?=
 =?us-ascii?Q?/A654LUp/gb5vmXko7PVpHc+amSWtoqdd8HgnB+VZJCLbAXWLyu6SlwVk3YI?=
 =?us-ascii?Q?ioq8TGyoMWf+8DAVmnkfDuJo2EuP5c8G2v2hIhox9ZebRq+hQT5QuEHXEiCj?=
 =?us-ascii?Q?iS3SRzZ1g5xlfhiClOs1mpkq1WaE0uzt4LQahq+v20WgumsTYzm/VfLP9Y+y?=
 =?us-ascii?Q?6MYiagE2x5d4y+suCIB7kVGA521wqF1C2CTpk73pgnULf1TMBZ176p3O59gy?=
 =?us-ascii?Q?/AGJUnSqz8uOerJ5GEPT9d5P7avOew4NdGc7ObIiOJEq4RBCMua7MQlWcE4z?=
 =?us-ascii?Q?7/K38wi4biRoUv5ifVQIkRpK0Bce6cNLyAyDzXsU9qINmG1aHpIWdU/YxekX?=
 =?us-ascii?Q?7Lgi5jrGHCn9soXK2Y97nkQVek33Mg4SJMuRXmftlxqvCB1CFRlrICY9QZNU?=
 =?us-ascii?Q?Fcfnil9qYfdZXFF6pg+ZXe/SozeyiGizNiSR0Fhceu1HN3INGscPyNLATuXJ?=
 =?us-ascii?Q?DPrMOvEsuezGWiSMBNsJWB33m4bkn8/Qxod5stghWDAAyAz21E8KakwYT89i?=
 =?us-ascii?Q?caOZgTu3ERBlAxJ9q6L6dexkJCiSkUeYiLNAKN/G8dkZSrfZFejn5qLInKCV?=
 =?us-ascii?Q?gowRQ8NX8uv7pgKDM7/OmSiNhuCdbMlNUK6/NFwVNz1CV5kNssRQA3a/vY3y?=
 =?us-ascii?Q?bFtVI+9rjGQZEwbNG6tPVrnM6oEhHvtcNoypfu7BPwMcjSBrihxLonmLvM/Y?=
 =?us-ascii?Q?j74z8ayf0Tk/O6rPSABnwF5vXQBJCsc2wInS9fCIL1pkR7fDXpSndUPW+Eqv?=
 =?us-ascii?Q?T7RzHm3iekFdDjz2TKTAe7Uy5RAXrm1Gk4+fVWk9msnediM3m3lj9/Q0mlil?=
 =?us-ascii?Q?ByRdJg2d5JhDmmKuwEA1rcbzv7+5YlUEm6d+AWbBcF3gYRHSYrQqRbUc1pBs?=
 =?us-ascii?Q?yKnSVSmgF3aHzlenEymJDH7gqMQPZa2FJywfr93lUwI6R5dLS0+jUaK3+5Yo?=
 =?us-ascii?Q?eMZr7UWVltLkcW9UXimF2ko=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0835381907187C4D98D9C7AE2F632B50@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X7Dcsyd8ZtEaI6E4U4fuDY55NiHC1rfpr3BaWrGdQvjBnFVr8TAGBA3/aj83sreMrshIhsx/ED7nZ6MrRMgyG5zshDR+ZZhhouUut2U3y26ZvetmW2x+tWslv0A3/eBk+eDT60JHzDeM0Ku6WZM+lqo+dEYn6wdJeUeZqeBltbmMxtGW/wNmGE+E6+j2pTTcP2N4Pd4iS0IHVGny2Vb7MBZYMioiTRzHmQlh0knE9QjYs/1G40E8YAGkXRpf1V0nQ+5xluy+aDx2lwWwtsgk8gqaSbxZW52eKsLDTTdt3bz9FHhjTeRR0HigmQWQpnpNhR8UZxyTHmsJhMtxQT+nYYZrMONai2m/vjDlXRRqk1rpCTFEbJnSeNVbdEXwCJ44iTEiBTuPN6BxYO6v1qMewXvEJp4iOpB/IQZrQSgh3saL0rCoAGEs5p7gZe+q+0ugxCj9jb0EzeZD5DyxsYBtE5zsm6O9fVUeYi+OrQnfRZRspNAVMKQTfotLt8Ss1wyDJfikZdz72ayCS0/x2g7v6rvQ0lbivNvonKjLlZeJI8b3e0/Y0oh3g6dX8LkbLSwIthD1+BWMH6IK0byeUNkTTfFEYuO0cgS/K6WhGA0logLCLL4Lfba+76uvg2YMm1SW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc0087b-c52b-42f4-0d4d-08dc60295a32
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 04:29:50.2877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRmkOTOsna5/XwsmbxrsA9CeUMCwRQW8yF2XUSfAQW3vyuWFLZWtnE6CO92AhFElmaiKy/mLLXa4VBscSvHGG7A9x5M3t0xTi1u+iA/YxTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9260

On Apr 17, 2024 / 10:20, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>

Hi Yu, thank you for this series. It is great to expand the test coverage a=
nd
cover a number of regressions!

Please find my comments in line, and consider if they make sense for you or=
 not.
I ran the test cases on my test machine and observed that e new test cases
passed except throtl/004. I will note the failure for the 4th patch.

>=20
> Test basic functionality.
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  tests/throtl/001     | 39 ++++++++++++++++++++++++
>  tests/throtl/001.out |  6 ++++
>  tests/throtl/rc      | 71 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 116 insertions(+)
>  create mode 100755 tests/throtl/001
>  create mode 100644 tests/throtl/001.out
>  create mode 100644 tests/throtl/rc
>=20
> diff --git a/tests/throtl/001 b/tests/throtl/001
> new file mode 100755
> index 0000000..739efe2
> --- /dev/null
> +++ b/tests/throtl/001
> @@ -0,0 +1,39 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Yu Kuai
> +#
> +# Test basic functionality of blk-throttle
> +
> +. tests/throtl/rc
> +
> +DESCRIPTION=3D"basic functionality"
> +QUICK=3D1
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _set_up_test nr_devices=3D1; then
> +		return 1;
> +	fi
> +
> +	bps_limit=3D$((1024 * 1024))
> +
> +	_set_limits wbps=3D$bps_limit
> +	_test_io write 4k 256
> +	_remove_limits
> +
> +	_set_limits wiops=3D256
> +	_test_io write 4k 256
> +	_remove_limits
> +
> +	_set_limits rbps=3D$bps_limit
> +	_test_io read 4k 256
> +	_remove_limits
> +
> +	_set_limits riops=3D256
> +	_test_io read 4k 256
> +	_remove_limits
> +
> +	_clean_up_test
> +	echo "Test complete"
> +}
> diff --git a/tests/throtl/001.out b/tests/throtl/001.out
> new file mode 100644
> index 0000000..a3edfdd
> --- /dev/null
> +++ b/tests/throtl/001.out
> @@ -0,0 +1,6 @@
> +Running throtl/001
> +1
> +1
> +1
> +1
> +Test complete
> diff --git a/tests/throtl/rc b/tests/throtl/rc
> new file mode 100644
> index 0000000..871102c
> --- /dev/null
> +++ b/tests/throtl/rc
> @@ -0,0 +1,71 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Yu Kuai
> +#
> +# Tests for blk-throttle
> +
> +. common/rc
> +. common/null_blk
> +
> +CG=3D/sys/fs/cgroup
> +TEST_DIR=3D$CG/blktests_throtl

The names of these two global variables sounds too geneic for me. I think t=
hey
have risk to have name conflict in the future. I suggest to drop them and u=
se
the function and the global variable defined in common/cgroup, as follows.

  $CG -> "$(_cgroup2_base_dir)"
  $TEST_DIR -> "$CGROUP2_DIR"

For this change, "mkdir $TEST_DIR" in _set_up_test() needs to be replaced w=
ith
_init_cgroup2 call. Same for "rmdir $TEST_DIR" in _clean_up_test() with
_exit_cgroup2. This change will add some new shellcheck warns then some mor=
e
double quotations will be required around $(_cgroup2_base_dir) and $CGROUP2=
_DIR.

> +devname=3Dnullb0

The global variable name devname is too generic, too. I suggest to use pref=
ix
"_thr" or "THR" for the global variables and functions defined in
tests/throtl/rc. This devname can be "THR_DEV" or something like that.

Also, I suggest to use "thr_nullb" as the device name because null_blk devi=
ce
name nullb0 can not be used when the null_blk driver is built-in. In short,
I suggest,

   THR_DEV=3Ddev_nullb

> +
> +group_requires() {
> +	_have_root
> +	_have_null_blk
> +	_have_kernel_option BLK_DEV_THROTTLING
> +	_have_cgroup2_controller io

This rc file introduces the dependency to the bc command. I suggest to chec=
k the
requirement by adding one more check here:

    _have_proggram bc

> +}
> +
> +# Create a new null_blk device, and create a new blk-cgroup for test.
> +_set_up_test() {
> +	if ! _init_null_blk "$*"; then

_configure_null_blk is the better than _init_null_blk, because _init_null_b=
lk
requires loadable null_blk and does not work with built-in null_blk. Some
blktests users run tests with built-in modules, so it is the better to avoi=
d
dependencies to built-in drivers. Then I suggest as follows.

       if ! _configure_null_blk $THR_DEV "$@" power=3D1; then

Please note that "$@" should be used in place of "$*" to pass positional
parameters correctly. With this change, _set_up_test_by_configfs() that the=
 4th
patch introduced will not be required. nr_device=3D1 and power=3D1 options =
in
throtl/00x will not be required either.

Regarding other functions, I can think of renames as follows:

    _set_up_test -> _setup_thr
    _clean_up_test -> _cleanup_thr (or _exit_thr ?)
    _set_limits -> _thr_set_limits
    _remove_limits -> _thr_remove_limits
    _issue_io -> _thr_issue_io
    _test_io -> _thr_test_io

> +		return 1;
> +	fi
> +
> +	echo +io > $CG/cgroup.subtree_control
> +	mkdir $TEST_DIR
> +
> +	return 0;
> +}
> +
> +_clean_up_test() {
> +	rmdir $TEST_DIR
> +	echo -io > $CG/cgroup.subtree_control
> +	_exit_null_blk
> +}
> +
> +_set_limits() {

Nit: local variable declaration "local dev" will make the code a bit more
robust. Same for other functions in this file.

> +	dev=3D$(cat /sys/block/$devname/dev)
> +	echo "$dev $*" > $TEST_DIR/io.max
> +}
> +
> +_remove_limits() {
> +	dev=3D$(cat /sys/block/$devname/dev)
> +	echo "$dev rbps=3Dmax wbps=3Dmax riops=3Dmax wiops=3Dmax" > $TEST_DIR/i=
o.max
> +}
> +
> +# Create an asynchronous thread and bind it to the specified blk-cgroup,=
 issue
> +# IO and then print time elapsed to the second, blk-throttle limits shou=
ld be
> +# set before this function.
> +_test_io() {
> +	{
> +		sleep 0.1
> +		start_time=3D$(date +%s.%N)
> +
> +		if [ "$1" =3D=3D "read" ]; then
> +			dd if=3D/dev/$devname of=3D/dev/null bs=3D"$2" count=3D"$3" iflag=3Dd=
irect status=3Dnone
> +		elif [ "$1" =3D=3D "write" ]; then
> +			dd of=3D/dev/$devname if=3D/dev/zero bs=3D"$2" count=3D"$3" oflag=3Dd=
irect status=3Dnone
> +		fi
> +
> +		end_time=3D$(date +%s.%N)
> +		elapsed=3D$(echo "$end_time - $start_time" | bc)
> +		printf "%.0f\n" "$elapsed"
> +	} &
> +
> +	pid=3D$!
> +	echo "$pid" > $TEST_DIR/cgroup.procs
> +	wait $pid
> +}
> --=20
> 2.39.2
> =
