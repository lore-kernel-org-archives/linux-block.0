Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE4D254B18
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 02:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776392536; cv=fail; b=lIb4cf/yR2OYVD4VXZPbrl/fVHXYL7IhFY1DhF42KMeDT7hplTtekSLdmMI1tAb0Orb/bn7UPPeslnsdcdLtGlO9GEh9Qkyrn72BVtcQnwX1d1xqjArQT21DwdVZpXCm4ybJVEf886uWeZjxAPcwvQLypasIUdJaFTwkRX8Skm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776392536; c=relaxed/simple;
	bh=YtIGuQMLyAV5e6euLdO/L6s3No0rIMtCIsScsLFA7ko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ks42oY5OlF2dF6bLylPnthynZPgh5Xg+o7IJDuWHY5wzUzDlZ5d6M5PixacF7j1VFSruorAGpG2dgqzsSQGrUQv2MQE5CIWbQ6DJPDw6sPznweWVdzn7XQ4f6mQEgEkGwkdxEqK8dQvAMgbcxnNvdPE0uBWUdhUZsDpWX9Zz390=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AzHepI+0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=B7RnJkVe; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AzHepI+0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B7RnJkVe"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1776392534; x=1807928534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YtIGuQMLyAV5e6euLdO/L6s3No0rIMtCIsScsLFA7ko=;
  b=AzHepI+0gQ8SvuKTi0RTvo59tabzbbT+/FFUYKPM5vgU1c+5a/Kymrei
   sMgVCoxp5T9XV5Y2fza0wjP6aoZTm42KNnf6PreiUsMsy3/axVJL2nuAG
   qIUgz8puODhbkHrAUzqCOq64AFfMKFrXYfj2odRdqAyej+f8Lo8EE6deA
   b9Ikj05Hpe4ornH16OV2rYTVCqscw1gS6lEPlMLYSE16O9MsFGuwp1usJ
   PlazQBpGOtZMFw5eRhDvLKr9qS4CfwK2SNVOPXEmAq0kCLPKlv9Yn7Z62
   wgViIV9vaUEdCtL/OEC/VEVues/siAKx4athyLAm1F0RglvMRMcsjHdNg
   w==;
X-CSE-ConnectionGUID: xiobi8cXQSK+nLxzfn9UEw==
X-CSE-MsgGUID: rcmz8/C5RQGMN1eRF2Bh0w==
X-IronPort-AV: E=Sophos;i="6.23,183,1770566400"; 
   d="scan'208";a="144195549"
Received: from mail-eastusazon11012047.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.47])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2026 10:22:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Id1c7zeMEq/ze/Hg2OtSIhqQ2kNZWEs77SuKCr6N2gceqM5teeSVc6JsM1qw5C2CNEw/8rf6Eoh/Rg+1QVoOetRhAcZP8WsEV0QaFmpbFrmk1mhCRSKRSGUu4WDCFqF6woQjm+Y4syex0tSA84C8YSa3yH6wWswJQ2w2++N0nuw91XVKYmMbG+23hek7Lonx4la88jAtdZ72tVbMmA5fN9R1qQFYv6jXa8SQqq3Ps/SAEj9+LVcpBh42KtynkegkBEAcARV0W5vyTkMzTRX4YtVVa6drNEdeMI6KF1UvV19GgxDBWSScAqaO4a0oaFNwj7VGXBAOxs3Tq2GMMft6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmEucg8bgXKQNWWkvd/OlzAPUC7bitG8JLsOCEMvdz8=;
 b=ZvmTmXNORR67bSXEpaBLpGiEKTlgVCK0QM8+uaXA74EjHhYJW6Q4COQouBF9iqK19toXNNYH014S0PxNrL+EnEL8+1I/xAAwYzgBMDiVO4mhCVq3O5Lb3IYT38Y6KzFZ/AnlBU7proJee60SUMKRXM3S9xIkwqPKRoWIyCAkfc7U1PLgO+ZXtQp3iH1qM0bboAyveL3kFpyD/fyvUpaGyt4zoTdZu7YPBY8fHLIkPqHJmmOZUrwsWqOh7Xotoildg79pQ4iRqjeAgqSUcRiCyckwDYhKTihDlJhK22+ybzsvI5HEuhwXyaC/4/8i2PV3ZclS5s83aRpKNzDdL3seWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmEucg8bgXKQNWWkvd/OlzAPUC7bitG8JLsOCEMvdz8=;
 b=B7RnJkVepLjufTfareyG1dML1MzfOtcqIL51YHB3vNGnpQ931CAvmkN3NI3PjLQP04CPHcLnapJ75S+rP4Ih4LTkzGiyzzREbkTpEkTxOjHoIQbUPxStApT23LTmiZRVn7SN14RmIAEpA9znNIEN8CJbXQCBtuVn1rltszZP3Bg=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 02:22:10 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 02:22:09 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"nilay@linux.ibm.com" <nilay@linux.ibm.com>
Subject: Re: [PATCH blktests] nvme/068: add a test for multipath delayed
 removal
Thread-Topic: [PATCH blktests] nvme/068: add a test for multipath delayed
 removal
Thread-Index: AQHczMR07HPDR5bpHkiJJCT7jVf2qbXhpaCAgAADvoCAAN8TAA==
Date: Fri, 17 Apr 2026 02:22:09 +0000
Message-ID: <aeGYt5LeJFmW2VQD@shinmob>
References: <20260415104111.1439459-1-john.g.garry@oracle.com>
 <aeDYE1BfumNvutvS@shinmob> <b00f7f6d-278f-457e-9151-7528ef7d61b4@oracle.com>
In-Reply-To: <b00f7f6d-278f-457e-9151-7528ef7d61b4@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH0PR04MB8549:EE_
x-ms-office365-filtering-correlation-id: a3af5f92-826f-471f-2ac8-08de9c2820ed
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 8tgd1BAcgYNMdo/VRwjD8oYpcLzJRAV4QpQBJtv2B/8+jWP7qvkSWb4M+08zsK7tCrduYIWSq+Q3SP04+EKnQYYLldv8/n6htvbMXMCRNkF2bA7Am+xzvDvAI6fS3SqXuDJfOg2tdyt/BQ/E01DvfQLOOvAc4zDuBL3rF+V6o5ZuLknXymZqj29E01Edr7ka16aF47ZvtaAOS+9kfva62Sn0VrLSpB/QOSzsJKMemp0mRMl2jk4EIWN5RYrRKu/Pl9qCx4fv0wFzuNs6YcbnoR2aKHyVpnMeegca8I8u0GYgVMrq4rwPs0B+O2cJK9/b0/JOUwEKgESR5sqgs8YWentAKGXWCiPoMcjRL3cSmBCBdTJgF5rwIygI4ePkASeTR15VUnCNwKV3bYewMQGgxTASRcBZ5S74kmkM6iPPxm7lc/K6daqfgGE7ZVqXjptayqDEpkZOWg8kC1oGQVq4yM+4ZywajnBNFXdv7La8itATAr/XHsZLED5UgpmcRZP/9sKKLaW1LtE6L3re9DctRDfbFZ6HlkvyScbwlnFcFiY31UVdCbV/Wz8clLdk59XYo4OiCk9KD+9IE00PVLtbPKlV7noiYaMmeZo5DXi16szKtJjkUgDUGxCtqORVCAFUZhwOUBuZy3cKW9I9dM3PpUjLt8wIYj+7xJhSP0scL5x5yUmPNsImxeGP+trKsSxfUrUg0on/u60UlSE/FMcVpiTbEjrq49O4vlo5oJmzQBBJgaa5xf9JIIU1OHMm5O0F
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dGUWKrW9WNQhmygsJAkh2f84nZ5XRWx5CNgVMy+bEcKKinlmrOyZkde6bK3E?=
 =?us-ascii?Q?PplnsbRb0WfVpa5oIq2YU5DOSk/k2C1M6D1k9+eOq1T05V+1+Ehq/OHaz5fi?=
 =?us-ascii?Q?r5ORFeMPWLDWIIavSt+5SAsW837DCqsWDHk0VbxzU+d6l2szeUm8Orodt0Jr?=
 =?us-ascii?Q?krPLkvE5KLycQMiP612Za44SgkIdDef1JFszvq0h7VqyGDmzy9zwFU2x6JPF?=
 =?us-ascii?Q?oo+FLkTDRIOFKCH+E6A8Uw7A/vALJr/JZP75XhG0DqWRcIJ0nhF3WDnFjjBv?=
 =?us-ascii?Q?JFksR81j4lhMZ5XMtsLTLkKrhlBUHuO9tYIOEHHXFAz1uCjbtBm+wF2LErnM?=
 =?us-ascii?Q?02f4h4VNL9bUD9QSe1pjMlR8pwHHeFGnsVL9CzMrM3e/rrOYEV9DHdwtx7dA?=
 =?us-ascii?Q?wRF+urmm7vNAiOYb6MGCYt6c1/Ttklt9RZC4SNs9/CK6O9aCUql+ak22uima?=
 =?us-ascii?Q?O5LGHnvWRjlzPpww4IQ0q4/ovhxECfLAxhZpKEkCQiOoNxkLBTZXM2Hr79oY?=
 =?us-ascii?Q?hh0GOP9FvBAjHg0gnDyrs3qvX0LlbzyVv1Tn2QGe2kNjccPmSyUIc0b109SU?=
 =?us-ascii?Q?mZF6wMV68MU0NkG8DeMLeoRLGBlX+HH5IKs+pgf9RFIRS5pnT7HL78H4f0cS?=
 =?us-ascii?Q?hHDsJbgQwPEfdvFZAzETmJBYAAkjv0cglQdXFbYzHOarksi4Icx7Fj8YAKgR?=
 =?us-ascii?Q?JmcfIIjz2n0oJewQoNGCsevz7ETAVJX0a6ic6PrtGni9OySjPP31djPlPYIB?=
 =?us-ascii?Q?71BSJzX34A3TCUT025iKzJuSiKeddLLyuAUX/AvjlVyAZYJVzW2OMwFtk9u/?=
 =?us-ascii?Q?Seio3ySCCQAXJYpH64S8Bu/fNHdUv2H3KuPDQTJMCndOzN0kF68zYtMzfvQz?=
 =?us-ascii?Q?YFhfnIXut1oov+U8ZUv8Y6SFz3vF4cm22nzFF+EHQmvy7rM+fudNyp9P7hEk?=
 =?us-ascii?Q?u7eSa8htEHzVUiE4z5vw7cJ5+R8C6KKmxef5GobxMHMHeea3zpY22DLafkkj?=
 =?us-ascii?Q?qyx9Gq0qWETbc0EGtik2UZN5Iyyut8EyI4GFIPl37diTl1cMRlyZdfKNqtrJ?=
 =?us-ascii?Q?tkUYnuAOTDnq129uzMm809ShPQWzgSR83yKmSExe2+ClT4g+0ta9bPjG9Gac?=
 =?us-ascii?Q?bO0xbrBeE01nbm4PcZAusMcYsrXfhM85BXx4aBj0bBI5hJplKE4xUrxPBUO3?=
 =?us-ascii?Q?xKUxWKNtMhRoElPlLoygiFb8SZQqB2g7I6TOw44aK1JcVXt9awUFlehTfxJi?=
 =?us-ascii?Q?oLPuI4tKstaX0CkMW0Kzep+t8h5Hist9ZP4fJZYHS2KB6rlTaY5xiHqGok6w?=
 =?us-ascii?Q?kYPwDO6G/nFoPN2v6hEeJ5kh2ZY8qo1Mb37eCYfSx7GMKRG33tTna/pn233q?=
 =?us-ascii?Q?p7+A9+yqtDLR3Wr7SkwNq7a4ePosa80grDfwzhjd6K+eyOw+KTwCJjCvpdll?=
 =?us-ascii?Q?P+W8Sh6SclASBx+u3RCbgkD8hYGDoLY9sXXfvxfaXP/XmO5oid9I0x+4PBCp?=
 =?us-ascii?Q?nkrPtvToAaI/l/3ubrSptqMgv17mi27dD3rHJ9hJHNzWRrbmEr7h/YJnutVM?=
 =?us-ascii?Q?Jo14f16Od1awmebOhC3mjt1CfLqWRAS3D6bmoRWwHIJyRIvDeUpIF/2ZMq9Z?=
 =?us-ascii?Q?cLoMZiAbcmZgiU3MswvWUK6069gfPHc3FwfEYImKPhvvP1oDfTDEKdbEgc9j?=
 =?us-ascii?Q?+/z+cuPWY+V9zdRf5mxa6S0qhRiiT5pC4k3cPM1GDlsewJS7sm/WCk/A16go?=
 =?us-ascii?Q?mZ2/jGduL6cgivaWJBnVJu5GarOY8c0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE1380F98A02904D8E2D10EDDB58B17C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	AuXaH+QLG8CltloJjhE0D1sTSMsD0/sEGHMuxgX5cY1ts74NgYjYtQGdXdDe91joaMbTpEsM1/sHAEA1BZ2QrKbo6RaIiJOfa8R9UMbZDfF6+7QwSrPW9uWPyekBzWyu9NUpOCLpd4Kyx7S1eUBcySzxjbiREm2mm2ofew19oBvft1uJw9j9k7c1upZvU8cbmCkGnOxpVGUZcINQWlRY4z0bdCjhc9w2ccAwlO9DDYufNMLcrebmoqNtqWujHoZ1FcxCO/rIuq10nb0SO7l63islq3rvqvsgmnkldCLWaUhTyKgQqxLEOnwj68D1j5G21pJfNeEH7ffLDcOg5SSy4g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+93bmx9YLZrIC80X9GV9gTA61UwvcV72B/4Zfci6vMISwlESY+f4bQN3eny5DXkV487IvuSS4zQjoqQ4V179c8S1rDSvHnfrbgtFfo2vTCqDp/FTCgqobBvlza2KRgsy45K7dWXdWRub2JH3xEL6I429IZW2SNMwx2bOGMa9ZO42XZ40bm/A5lL+bzWSiZRMlekWF5ei9/ilhL+FWUjpBy44kRWADeI2JdREPlqqCQn1zcGiDIZh138Ivaf8LMjzxov/FgHuC823oKn7q/D9Wm7X/1hAXzj0oxGDEfCOySsnB6u/eNaW9VAdSlhDNVakyLFbEh5A8DOHXHTPfQMI5vTcssdI/DLXQ5koKLjqFhpAqyeAo8ynJ3wfyJFTlbQfMZHAIYYVHl7YNh69wFsjdOBd2SX1Howb/kUXlgfb3Hqj5tkmOSNmwoBbgZe5UA4LOOEZLmK/rNj12l/tBmH1WqU4tPK8WwtgwSqqUJmvnEVi534H5h+tUIh/68PiCvNJ+yb7+uObjRsEwIGeFB+U9A3mjl3cvxFs90n8C+fSNtRIoDmG1sdRS8YeGlWKprnZElQbwA9XpThbEd8yjFaRNNqS2H4CYFjaIJQX5INmOXaWgtkKRI3Zp480pOKYbRlY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3af5f92-826f-471f-2ac8-08de9c2820ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 02:22:09.7563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WMlcSvR7oAU+pNKdQ46WJnT4VBCdgXuI/ARv5y5iuXZjdNfZUcQ+E4orNuD2YOBG1osp7HWuKtpcNJUWtu0XGR2IRzQVGtHzGx18e6GirSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8549

On Apr 16, 2026 / 14:03, John Garry wrote:
> On 16/04/2026 13:50, Shinichiro Kawasaki wrote:
[...]
> > John, thanks for the patch. When I ran the new test case in my test env=
ironment,
> > it failed. The reported refcount mismatch looks happening in the Part b=
.
> >=20
> > nvme/068 (tr=3Dloop) (NVMe multipath delayed removal test)     [failed]
> >      runtime  38.579s  ...  38.770s
> >      --- tests/nvme/068.out      2026-04-16 20:50:21.228000000 +0900
> >      +++ /home/shin/Blktests/blktests/results/nodev_tr_loop/nvme/068.ou=
t.bad     2026-04-16 21:30:36.215000000 +0900
> >      @@ -1,3 +1,4 @@
> >       Running nvme/068
> >       pwrite: Input/output error
> >      +module refcount not as original
> >       Test complete
> >=20
> > I have no idea why it fails. Do you have any guess about the failure ca=
use?
>=20
> I posted a fix for this here:
> https://lore.kernel.org/linux-nvme/20260416051459.GA14802@lst.de/T/#m17eb=
549aba102198009a37621cb45775841639d9

Thanks. With the kenrel fix, I confirmed that the test case passes. Good.

[...]

> About this specific part of the test (checking module refcnt), I was
> wondering if we should be testing kernel internals like this. But, since =
it
> found a problem, I suppose that makes it ok :)

Agreed, this test case already proved its value :)=
