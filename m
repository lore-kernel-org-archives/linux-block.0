Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35A13D2A9
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032620; cv=fail; b=b1E2axN0xuFGsRyAFzju5ATsT6p2+uhy6I9OfaBlSAZPhqA1U5zrEF+VUUpepxndlb+KbN4xUirtsVG2yAi9pRaUVu5fricIhIG6mHdiORjoqV9Wrr41Qq7zoIVBA7ZReU0SeO6jSkATEqfmUhSQyXKFYMIcOd6ZhBxMUOSa7PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032620; c=relaxed/simple;
	bh=d7CM9o9I0oiaz2e52uTjCs/osWU6YsGq5hbxkcVZl1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dGqWcMdmgKdQcCnnCMxr9zC3ttwYoSExYPUpu3ZmnmwcEGFWtp3gLpjCztPHtl/8l+k0iB9L156b5zIFgY8u+/7ben75PY+9dflGKI48rGQnfV3bgg+6RpfVkDTeBTUbGdjdkZOPcPow7wzuG/b3xIsHbPy+z9cra9oBg1lVuCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NEdCNvL3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tyNW0kfk; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NEdCNvL3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tyNW0kfk"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728032619; x=1759568619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d7CM9o9I0oiaz2e52uTjCs/osWU6YsGq5hbxkcVZl1c=;
  b=NEdCNvL3nFyTY7ULUp2Ntx8g8t3uD9VMQiy0O4TojnzObzkI8bw8Hzny
   SW8b3MZQEtj+DfenCBLA4N9a8zpplnDeFiTY80JExdZqYkkAmbQRPqx2X
   yyZ9q9glKeHA4PP5yWvqvszYuuOkZ/xNDGyja7wprTJ1aajTQGrJ6eudm
   CVgg3QQmlOrx4Et9277v1ylMnVCUysB08T0OdiD41z3/hJx8FU+oH6HlV
   tsKrMMJQwQCblJzUPJykgVOmhJyEg2ovodU0rj+gH47GWOFK6RCirHB3B
   G5DL+CpNSzKWxOtn99+lFehkwThNLVZbP6ck16dbj2LFUE1X4qgwxZd/a
   Q==;
X-CSE-ConnectionGUID: 2zgVGQjqSVmWdWHLlTHiSA==
X-CSE-MsgGUID: WOWpU0c/QhCmQ09pbpJmYA==
X-IronPort-AV: E=Sophos;i="6.11,177,1725292800"; 
   d="scan'208";a="28305847"
Received: from mail-southcentralusazlp17012050.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.50])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 17:03:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5wC96wjFDTKcvs75j78zyXxbU6f9FI4Cg1vZFwYmOXUWAUpQjCrhZatIVgXycOiiKQ6pqOGnK12o/A2YWG8/Mz+ISDrgvMHNBZtX8qSCEBWaGjBGUVvwEA48b9Yt/4KZP7aW2RiT/5F2wqgJZjdgqJpcqSXXFkpxiqg5kOpJdJFPnSaudm9NF0IaHsfbDxVlGhkJy/KU8tdBaDUD3CVccAO7CZ45WmWdl3JoOnWxXBlm/O9GzPHIAuWdNL9WDmYULf0D1SJrxDXcw4/lahReEy9EutgL63ZgZ7UKcwHuw0D8yNa+MMJh9No5Qjanf/CRBBCfQy9lIkEpGUNaBS3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7CM9o9I0oiaz2e52uTjCs/osWU6YsGq5hbxkcVZl1c=;
 b=WhVgxoXTVmeipNrozDq5eF8RjR+0rRjiB+z32FmHmgLxQNXZgDv7XLdCGUGMdemXawSamjGGkm1vGB5TzzLVz/Wp5f9K1iVJGUGaYQF3UKilkbLNFUapwwO3Klhc3ibS8RwEUdOsqgMT7ZioIzBDVdi9tDMBAOos3wvvryjIC/6hiNxLtn1jECR6rg8UXgwWJKJ0L++cyKjw2bzUc5aZY5uZZgQY09dSi7Gb9EdF4AI5ifQ3wSLv0LSVVsRRTvY6n8rPHgaNzmuIARZokttQQ6G+cQToiTQeoLTutT82FmFfuA2HldpS9ESUMlGeLGvhGvxp02U7OvXgBkZXxEoKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7CM9o9I0oiaz2e52uTjCs/osWU6YsGq5hbxkcVZl1c=;
 b=tyNW0kfkwFlYIc5R9+dpU8vcuPuHBuOGGz8fT/u8qZt24MZL8gsLkSJcJ/XI0zWKifPVVp5yYVhi5KaEM5aZ5lqc/wm3yzt7DVFBuHC6pXW46T95YbBXayX87Kk7iH4SOmd9VXbVSslLv1lcuzk8UIm4HY0SG3axWzAiX40eVNc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8050.namprd04.prod.outlook.com (2603:10b6:610:f9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.18; Fri, 4 Oct 2024 09:03:35 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 09:03:35 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"martin.wilck@suse.com" <martin.wilck@suse.com>, "gjoyce@linux.ibm.com"
	<gjoyce@linux.ibm.com>
Subject: Re: [PATCHv3 blktests] nvme/{033-037}: timeout while waiting for nvme
 passthru namespace device
Thread-Topic: [PATCHv3 blktests] nvme/{033-037}: timeout while waiting for
 nvme passthru namespace device
Thread-Index: AQHbELLeYh/w+LiMq0eQuEXrF24oxLJ2Vy8A
Date: Fri, 4 Oct 2024 09:03:35 +0000
Message-ID: <af7hhahk7apwujuuly2jccke7v7nmj3nlluvisgi66drr4p2su@cntajmwbp7kp>
References: <20240927075616.343850-1-nilay@linux.ibm.com>
In-Reply-To: <20240927075616.343850-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB8050:EE_
x-ms-office365-filtering-correlation-id: 6da6cd71-eecb-4225-1569-08dce4536d9c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WteFarfhsB9NKn6tZjLATSX8HGVKhff0z8L7U2fjevkyKmZwb1YqXNktJ2sP?=
 =?us-ascii?Q?pRGrmdvZnJKxJVWc65bZxT7jTL9sG7sCWo3erWW3QPsD76Z2gzZGx/8UkR36?=
 =?us-ascii?Q?HlaucC7ODxKyXi5I74I034jnNx5OySW+i9+WosICd742J41t0egxBr8/P3v+?=
 =?us-ascii?Q?AfBr2NL8H4V57uZIZuyqBr7aAIgWaRADQX2sp5z9YGiq8kLrUUAGZc2O3sok?=
 =?us-ascii?Q?C+npFkFCCXu34yIg+rfR9HsAo9iCu4sFkay1CpMe2xm3RYvOJqgBHt2H4VQ2?=
 =?us-ascii?Q?iJxgKx8u2PyvDu0XUrGbMB5cXKtOX3uLOF8Yg8sEFxjq2KMZwjLNf52qleA6?=
 =?us-ascii?Q?FpbKsqXry/RX//TVVPq/VXqI+KZ55Fk5OlG3SddYCFQz560YUnDwogEw51rr?=
 =?us-ascii?Q?RRVg/ZpYauZ3hSQyuX/BwPxUkgxR+cn2atHi3o3tXXzhHV97WVGsy+By8k1Q?=
 =?us-ascii?Q?ACvQzMkshoiXhZVhxEUuOPdazQ6IDg2bJexW2xYD4rRPEozMUQ2BARI7L/7A?=
 =?us-ascii?Q?i5aZnqAIYydSwkkxVtTOgv8ahniTPwVHPW7hwLlVhhIkP645b9wuCjycq10z?=
 =?us-ascii?Q?/SwW5FG5zeznVvTqGTP8u4kCT0f8QuFy6tqBAmycicu3IorFJVEtf9ezHvFW?=
 =?us-ascii?Q?l1zZJxmuS5CFgOR9tIA/OgJTYnjI8GUvsFNw488G2o8C06T+a2tuJxN/gvZh?=
 =?us-ascii?Q?b81ArFKq9CDN9GdZn9lFidnUY7IWX6RUxSu8ZmDWU0yso5HNf4ODbssSrp+O?=
 =?us-ascii?Q?IwPxO054RV+gD8U9SFqd5vSdHyn2SAHrLIruLQ65R8rRv9K/cOKeenZdHG3Z?=
 =?us-ascii?Q?JHMcq0D4BUQ7NtzV46uFMssaDSgpYZBgDuV1X2w2VPX3TQ0wDI++I8uKgkoY?=
 =?us-ascii?Q?NsKDpZvTYn/4hOM6Jr5rLyBxdGOfjw+nFzguO1JPWPwpsjawpRiKF7n2SS/M?=
 =?us-ascii?Q?TcyWGA+Sa1C6tnMz+7xQzReMf9fp72qHXWsqUzAtyOWgrTQhGkeVxVfkMhzK?=
 =?us-ascii?Q?DZzYLztwCXfwIFqvwPNY/bMjtUYklwBkRZteLZIsqRroihy0xKz93b1M6tXO?=
 =?us-ascii?Q?RD1x5VkCp2rdoS90bm/5VhaTLKICL4oGfyHcjH9AMmInjJNfid0d42WB7x3/?=
 =?us-ascii?Q?dE9pqoOH+Q0fvcb5prW1bkKX18ipGbOFu9g6Y/I5PpLQAWlEX3AckQ9wmDUW?=
 =?us-ascii?Q?w8trIjZ5OyutVSpRLXftSKJcYbW6s1bLoWQnRfxqQUigu4HZMOylnUJS1RcL?=
 =?us-ascii?Q?4SftKdltObwb/CT03hAeSO807PLS6vBDoDcYTHs7Zt4TSQDtszzinmUgK71G?=
 =?us-ascii?Q?D3oKPBkJNmtEVDzndNlAtgLnpINONs/R9T8kNrohOHy3qw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NLXMUXi4zEFuzdRejZjpPHDjfb9k4cbVojMw2iBCAGVl4Xv/5fIQeKkEJ7GP?=
 =?us-ascii?Q?kkpHyqbZUM9NT2TwjxpxAwXvyJaxKf3e35T7Gs7djHXj5sZQk0n8yYcTDSKa?=
 =?us-ascii?Q?cldPFy0bb/BRRD+0nTZnuBfNkAGsa327R54xfky138G3s5gZOdEv+gZxGd/o?=
 =?us-ascii?Q?qtfqy9iZX8kfbeWNlJYdPKod0UG/L0KXr8K9rkzSoMLllfHn4SfmpxL7L4Md?=
 =?us-ascii?Q?cPLnaTJLUfvHKeODR19cc04gofkuBCeUhiC4g0k/oY29HqFKhtozYgi/dEBu?=
 =?us-ascii?Q?rxXNfoSKU53i5Dqi3GLtDxDBN7OqFUTv3Mttd8IDs+b6dpfqm32v9EWYYKwH?=
 =?us-ascii?Q?liRCutFTfRAk/X5ALmsidAq+ldS6/WIy1fdkOuFHvomvSbs8uI3xn/WXUwW4?=
 =?us-ascii?Q?YPLLRJ9hNhv8Vcy/ip4geFq4rIWav0FGA35jAexJ9FauJrYZyMhF2K0h+Jsn?=
 =?us-ascii?Q?JbEAX+4o0l11QepHgS738wyEXk33sy4d/vEC1YFnaAykMym3JtRdM+h/eL3u?=
 =?us-ascii?Q?UvpnnrNHE/AkigxppoD45f+xdvfpwKZMItbDDFXdijMgYQSZ5PDBFRz0wMQm?=
 =?us-ascii?Q?68BOVIPUWGZ85b3N0bAzsmvwftBl5PugQ/2YAf3I8UtQXagkGEax8VEXjDFl?=
 =?us-ascii?Q?72xZ0hBTDKPs6GP3BbnlRvTJS26ey5fnKG8wKSoU380Q9Hx5GhbwzoXzHHkt?=
 =?us-ascii?Q?wmW4o3m46UNGmk7KwXEaQM3sKLQiCWoZdIgG6dnPIwmM7ZtUPQJlfXVds4ht?=
 =?us-ascii?Q?5SWmdr+X5EYKl7CgOcQuZzVgUJWl0ukI8X43wsuwqRkIkPrgIaYBXfmD7XKq?=
 =?us-ascii?Q?TCHFR6V9LjS1nOTw9po74j/EXA4kti3/Kru2PZ9Lce63Q8Z9D1owvdibpOeg?=
 =?us-ascii?Q?rflI5PdLkEutVaCPtASwJg/tzdAD/GlxGLFTFlX16W2sWYY+l8abOu/oXIk6?=
 =?us-ascii?Q?XOLxFErKW7LZPvGbw04pUisvzivqeFL/g3PhTeatXjBMsovB+WD/QkPsN9Ug?=
 =?us-ascii?Q?XYrGIFKdSUN+UYDwUloHSSrlkHkB7kGF8+V9cJtY8G+VnY0mlsHjJ0c0KMdt?=
 =?us-ascii?Q?G0PXfdNLYTuUa8yoFztPO4Ek+QgEV3q7erUFASQZMgImeqSjXvFa83E+7eL0?=
 =?us-ascii?Q?o82UyreS4/x3jgWiMsZGq4JpUE92Wevosby4k8MLcJfg2JGVKZnNVb8quYgd?=
 =?us-ascii?Q?1LZKQT2czSa5O+/uQLFw3AM7l2Z5oBHffka8y2W94feagG5a64K3wyOHJ6TK?=
 =?us-ascii?Q?xlgNUcv05Qcc1Q9OzKfn6h+cQC+/fjvdZo+Dvjx+Z7JtocSRJqfkl9HROtfQ?=
 =?us-ascii?Q?KcewEeE9pL39gb+gdirYKdNjO6U5OTXoIgpNGbbqXqbRN5gb3QUs73X/1BgY?=
 =?us-ascii?Q?z0ecQQEFY/qaFVgED6949x5lHZZO2azt3cRjQrZNLVv4Mx4Czti3rt5UPNAj?=
 =?us-ascii?Q?/YjOn0U06xkiDKosNpbL2+hceHLT0RnTMBZQW68cRrlLiGJHCzlsVyvBLBTj?=
 =?us-ascii?Q?/ZWF328Qs/Wk2aE8kmmlHgAdZ+wKorMOpDnJPuP7IrTil6dzkXscVuTrPfC6?=
 =?us-ascii?Q?BJq/TMbSmdq2z91NAu5vpwKhaVnQJlZ+mW/yyPaWjpyyhxZfytWdwDi3KOWB?=
 =?us-ascii?Q?bmGb3jTIPfURvhmnQmqgbWc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <278CA7DF4990A241849E939B983E82C7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	viGjPtg+Vw/Rct037ii4Cse1HLpGPGSGi3IkZsVyJ+G5OMx0nnFyJsubrWCKNbTAJ+B0esPH8YZivStpxfSf81EFNQNIncn/Zow8yGo4GTKmsg5eo0r77zxf8UMiDqM62QX7lxr8KzNTruFnc7rmzed4BVskz/0Q1uTA2+p6YfziR1k5nIo7fr0r7/71LUwfvJnd4E7D36k3497M+ZmYWbc2+06iTGsIIEbVT9O7/S4T+zc+30BkNreIFDulNUI9CGeD/JafCRkx+Ba+TtaEtPpVzcWTcEmsWqXE69wVLsG0M43WfUnfTDL32DFBNiBd1HaxbxRhJCsNCSeB6cRz7heGoHxgt1nkAMdD77Yl9eOL4DO453dfL2y+FuySia/P+Q3YzzTqHUgq5NrA3WQ+KGHKunbAofg4tDqKwkD7iJ6Ve+PPwBuNkJLF/m8o5BZp3uficRRST8ubL3Fw8Y9wN+pjyPc5DzRYtgFEHN+ZSekgZd8EJ5sfYAx9/UbsUrf/xiz5gnG66FsZCQprYG047IKgBRdBXQGSKRp5+0S/8BtvMDywC4HsLrUagAdInV9ArcBCekZK55I+Z5rHkn4tYpwlGfahGwBXKpHBIBpbzGvZhRz7929UqFgt41ZpTzzC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da6cd71-eecb-4225-1569-08dce4536d9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 09:03:35.2095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guNge/a0SjB51zxdOa5KwsIh5mqtNJ1bze+Gyd2pSsMHYomJSZllC/rquxVAuLYkQik40nEEVb2RIKbD1dc4bgCnceh0e74RPUrb1YOKs48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8050

On Sep 27, 2024 / 13:25, Nilay Shroff wrote:
> Avoid waiting indefinitely for nvme passthru namespace block device
> to appear. Wait for up to 5 seconds and during this time if namespace
> device doesn't appear then bail out and FAIL the test.
>=20
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

I applied it, thanks!=
