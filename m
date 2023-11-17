Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gIciG59F";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B+LuZBnM"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A91194
	for <linux-block@vger.kernel.org>; Thu, 16 Nov 2023 23:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700206024; x=1731742024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SYgx/vRQAmXKntDcf3LYlaxX9OoOWdxObpsr4oSLYz4=;
  b=gIciG59FU5G0VYY8fnztFcxf3Limsy+ysMapb7s9sIMP9a/8uQHLoOpH
   5xGKg1ETxzbmdmAetfPjm2f9awutDjMTW8O/k2VQY8scOmJGNSgYt0un2
   jiOSoF1S5VGhEbtaOpD3qHNJbNWG2CfdKfU4AR0CMo1BrKPSjMl5X8DHL
   Wdk+PSYgIEKCSpNSC9paVZRCjzeQyGu6QF6ETAPbCiqRVqRqDZJjwbapU
   pyS5oKKsLj3ru66KxzH+6kHkLXPzXQqFriAzXYMK50Hvc4TF1uHjiHKVp
   Ipi0sEw2eiX9mEJ/s/HgIw+j6jEJ+bOExeDp+q340xvXDjsUci14VM6WE
   w==;
X-CSE-ConnectionGUID: Twwf+qc3QmGnl/Frw+XMuQ==
X-CSE-MsgGUID: oTzPp2NiSoWVFEAgcG1fEA==
X-IronPort-AV: E=Sophos;i="6.04,206,1695657600"; 
   d="scan'208";a="2545606"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2023 15:27:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQbeo4XqQ1ewddVjbqqAKuz/rPGLIFeWMZpTqoDfqozZN6+OQ2OT13LCGTRrnqos5HyGLsDeztv2SMhUHeFAywSlA/RUN3UIh4dRPybSNsMS0pZk1tlGwrugIEOS4VpzfZAvUecsxbOAsdI5ovnqJUwi8t+nFhCna9vLutzrLdaiKZFiURHwv9fV2n/mx9E9DWsX46mlssb2bmvDkUw5TkNjfGOlPbOBAWvQz/XEWmnvnIH9m7iMCHo1kSFbV3GDVQNIRy14iOK7YGQU14c2WeBYtR+2HqvBoX79GyH2kjXi0QmrsDhNApWOuAPTYaj32GMkFf/bi35ljMIizbDbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYgx/vRQAmXKntDcf3LYlaxX9OoOWdxObpsr4oSLYz4=;
 b=UiN0fYv97TP4BYPpxPmWrij4io9wPj38agx7vssaO9rrSuhGTuZeElNCmrMi3AaByvbbRGZbahPauTgYUPKtFuDnW3KTYiVJUDgqGT7LzFCRaAG3PaMNlj4XyQATrsH+4KYi6BZKFKg+sgg4tRszq3J1pZqLJlEImIsNvdG9xz67uIaHGQXbXEyivfAAuR4p64ar1VRFOzm4UD5GqXwuFzuKuHgBCwT27KLhDOtmYzFkvwEgNQg2m9SyyLIcka2cgisQcdKjbqNwkF/0PDe3XEez9FUKvyFdYYzRjSfNB6U3cNNngXqn9hgEweSzaj0vTuedSrxhIvFpbi9DjR9sWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYgx/vRQAmXKntDcf3LYlaxX9OoOWdxObpsr4oSLYz4=;
 b=B+LuZBnMfxO5MF2uXZlfN4g3REZ9XMC871lbuuTY1mzLfAvymfczVakcoKyrXPN9zILPaK6EcH2cF2ImJCnIIypqrDbEWWJIw8DYZF8oaBp01WBoup6730q8VKtT+7dr+am7iYqzJIp7DKq2a1tgCC7afW/58CDxCbI3OhHixKU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7616.namprd04.prod.outlook.com (2603:10b6:a03:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Fri, 17 Nov
 2023 07:27:01 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 07:27:01 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] common/ublk: allow to run ublk test without building
 miniublk
Thread-Topic: [PATCH] common/ublk: allow to run ublk test without building
 miniublk
Thread-Index: AQHaFjZAi7DM9mCX8ESMHcaRWIBGxrB+InsA
Date: Fri, 17 Nov 2023 07:27:01 +0000
Message-ID: <kjq66lalts5jrnf3vn762vv3eekyzx2gfewebivxmtxro75kem@ivcs7cjix55c>
References: <20231113133503.2768452-1-ming.lei@redhat.com>
In-Reply-To: <20231113133503.2768452-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7616:EE_
x-ms-office365-filtering-correlation-id: 71af9553-72dd-4ecf-57d6-08dbe73e9734
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ogi4SKOggSrJUyoz9RW+UcZ1cnwOKJYSnWJAvShg89ijYw1HqVVYjbLCB1tvtMlG05mx0IsKks3a05llmnAFlILkriLmTXk+egt7xPuC6W8OTWccSEhPnw/CqV2G+CVY/YKFkgXBiFPaPAEmRFY0Q8BXYNKOCOFnj8K00bBMd3OAqEugeiwfcE7nnBBRhFnyZgPmldambcf26L73rrDwU9eGMLrgDQ/ID3rqHynMsVGbYG33vcyDOYt+3+xFynvfQZvffjYGm8XzXnUOC3bsK9gh7xYgVqBKUqP5abR9IGkcG6k1rujI7nd5FYt2thIbPL4jwx5qgdaWz0aEcy2VQ90r8r2JHVTvMMQw3zTgkuMG5+pX8Ta7wJqWbMSUbxqLxC1qtXRYbZ0vkTS3iJyixH4ChvQBe8nTOtXnjT+6JjKS3p7wfvjv4tnfYy6CPl3eEWtEMOAmtwugxhqADEgD9xuhRivOMkhm/ubeW4PfCQMpNSDUsaHLOMkNVO4sIDMxxHa9i7hHvE9CoN8+8dec5yRv6cesC1H2wGulQ4TJzPLfjXhsJOOLfTstYlkKXeYQk+AucPBBqcFjRKx67XklvqH+ix3ATmdUGw5g0Hh3CWlpi5DFTsHJTRP+IS0PKj2+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66476007)(66446008)(66946007)(91956017)(64756008)(76116006)(66556008)(6916009)(6486002)(478600001)(316002)(71200400001)(86362001)(5660300002)(41300700001)(558084003)(38070700009)(2906002)(4326008)(8936002)(8676002)(33716001)(44832011)(9686003)(38100700002)(26005)(82960400001)(122000001)(6506007)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P5tI+QBPBvhqKwGQXGmubcssOwSzox+Ml+Pd2S3fpJ2vI2kW/bsiv7GKUhg2?=
 =?us-ascii?Q?AqouiEv6mH3rQP8DVf46m57ZkcMVUKFitIOWosEWMoULg8VGthtZQt0fYmb8?=
 =?us-ascii?Q?qTZrQ5Rbr1a7jBnQZ6L837y91LbkERuP/bm9Ckwccb+P4N+/II9GnbZoZoCp?=
 =?us-ascii?Q?b7VXtUOADVQ2F6Lb4pZ4WYi4hhHNFajCFEDuRr1/PCI+2FAtA+QoDc+uVcAR?=
 =?us-ascii?Q?yiEPEtQO7PoDdn1DOr8qvx0DM49wl+/2GlbXpPcybyZhbgAHG/aPbW0Rz45g?=
 =?us-ascii?Q?UCmQYNsfAz0sMT/WEBgdu0XHmhTU6fXspzgzEa+2qeu4jtmumeTd50S9Fv+v?=
 =?us-ascii?Q?6eNckarFDJxEhJ2pj0gmn7NxhwfcOBkpOmVutdN/YsU/VJ+vhsKtAMb6U9PF?=
 =?us-ascii?Q?gOWcfMJD5LIKwNHya6EPHGAKoAefjTqavZcfUtnA6GG31vuGCo4yvJxXaM4+?=
 =?us-ascii?Q?G5ICglqoV2xFCZTy4GvJ9bDHiyYlD0OAgxnH0i3Rv1qKwAp5WTU8qD89bN2+?=
 =?us-ascii?Q?CzlIl/ta4Ul6BvY3PFb8oc2aXX2p8DGIW8Fl22z2q1ijOQSMFhk8xJjvDkyC?=
 =?us-ascii?Q?ikOXGiUTeKAW5TRH5NMoC+93OrkcWptwwa3vK6zywJwDQvNw0OtYhRk++jSD?=
 =?us-ascii?Q?lyvH/m+FPEL/zij4AHpvnjJEmbAgPaD/MrxjwzCzbWwoVkrNkDTj8hQPjDlm?=
 =?us-ascii?Q?zCxWR5aVEx90MOyCcSnY7F2zRLHav2eqdL/edJbQEYRqT/shNqmQ+ZOWzcsV?=
 =?us-ascii?Q?1c+6/k4VCFAPWjjDGvAXljSyxewpknO0pQFgDHDVLydmTxWtAEh+qTrbGINt?=
 =?us-ascii?Q?7DmGYxCNlvbKMqujH4vQ4KN55XMsUdo+pDXKxVDyXtnN6Tjic0ddNDIr9QjO?=
 =?us-ascii?Q?josJOhbYsI6KsHaGtMvInhkE66o+AhI1UYXK9Bxkib/B+evqV402SRGH8MIs?=
 =?us-ascii?Q?zvGV8ZlT2KzEXlZkhhz6rL3ZEuXYkCj552k5eIpMxpA+hr7qBD9r+mUIaCpw?=
 =?us-ascii?Q?8MGLWl+plsoo2KMVqhOzvBWW/5Nabil55cCqSJN7leRdzPH0TN5tQqzqUy1W?=
 =?us-ascii?Q?AGyQ/Rgj5A9e2hz0y1wC+MhgEpH5A15NAeq3kaa3zLNwRx2wIX2FHisx4kIf?=
 =?us-ascii?Q?6tpc/c1QkWBT0Bx7Y7TgwBkZ/K/n9OVJwXRZIClglpKOMDDhG5uRB13iaLAA?=
 =?us-ascii?Q?CJZaqX8KYsya/LZTA22T9+Mi9ZHqXt21FJf3/Kdzrwi7V6ksyxm82e+7HXZH?=
 =?us-ascii?Q?O/mkYNp9GVCM4/f6Ax3RsAICFGN0GvwlGSpCri+l8YjS9ySwlegNPSMgxP+o?=
 =?us-ascii?Q?QS9SF8RqCzgE6sgbOkusXvEC5rY1xZJySvZafWhcjzehlmiJ5LJHQMq/XsZ6?=
 =?us-ascii?Q?tLyfpDk1DQjme5brtGdV5CD+sFDy/tKwqTe0xsLFD4rnDpthTLg+Rj7f7vTG?=
 =?us-ascii?Q?eDBQ2RT0bEoDK5o6zB/NRWWQYGCyMb9G2KIdsoj0mdQ6d6FExWVdFeMZptNl?=
 =?us-ascii?Q?6OJmRTvbOX7RkERlqJJBQkSsaxVgdzkHwszuIlMWK1p5qiZRvPI15qJyRsDx?=
 =?us-ascii?Q?/2G8U5j41UNxsExDf/7yDOE5gfVb1i6SDCCFvxT/eDfd73YrkE2YXRIa33+h?=
 =?us-ascii?Q?O9W5+emLB6PCF3mLFVvNzpY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <804AE059AC75D3419D219D888AEC7C2E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	usz4+/5lY2tpzQZNoDm9HdvsFajYGhpHmyBqEEqvey8EUvnw/hzVi27sAVrDDhdmTz7aycSACaJvTnypsvtrUvkpvSCHwuzyuIxiqQCIcdjiMNPlF2acs7Y12hyUvwLxt2owjbDpxhvgydXmZYW5OWbKcjR1LNEEGY0FoOgrebevmDhakv1CWA29CE8i1KU+kaP3XXJRMNHOZaK4sUnkAL/cywAZMnfsScZkZWM9LH3FV1ia8b6vEo+CalFzGVpql0M58rZHwc537ARdY+IS8nB3sr3ZXcNVI1NSrEQyozJu/osNm1DPxnhwuKxvETJjAl/ijdmIX7bdPPXUASakjFYHjclFmIJIo1rAQtPJq6AdJwtR53XnBtuR7yc4KwRYNUf179ib0I7fPLV7YgGgidM/PViN9MY+tVYTEkcrPkLD9iHmlcvo+Ck04CmHH+KghNB9s7/aGIOlyxZRI5vW+axfes/G0ZxNMRUojHKFUrfgduUs3ZPgzhWj0DUseE72Ih1NWOj60D1bMEG49W3nhurIBfFORBINRiklVvABEWJ1R0v8DjFrMfvg8hXcBgPcNw3jnvsHMUCJsYyOK/JO3eVHv/5Phvk4fUMI1lDH80hoghoDuVnYJU0S1RkUqlLbmIrhcmbkYfRn0MZ/b08Fsna+47JUkRcvdrWtBNE07INaZBxk0fwdVL8bDa5umtF4/jh1sBzMFPVv27BEs1pA0xnxynizTBZWONIsBbWt9jMceAIZ+mstKBLCTHf8yxfHMr1VBnp+4he852kf6f+pHMacSQ09vh+PiGbHoFBivfHF8BLPHEWEJSdPXM3/BXHj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71af9553-72dd-4ecf-57d6-08dbe73e9734
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 07:27:01.3674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVYq6LPQiN/q5vRioMKwojCtrECrJSuRiNCCmxjPdj/bfMhlQaJrGydvSRTVfNGWbz1jeS9nqrfnZXqFCsC1f/m+aN6PP//M0pnkJP9VM1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7616

On Nov 13, 2023 / 21:35, Ming Lei wrote:
> Now `rublk` is enough for supporting ublk test, not necessary to build
> miniublk any more.
>=20
> Convert ublk common helpers into ${UBLK_PROG}.
>=20
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I've applied it with a minor edit to make shellcheck happy. Thanks!=
