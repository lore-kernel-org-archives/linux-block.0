Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D5E4C628
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662671; cv=fail; b=qiYcwyTcH4KoxbZzfyIZME20i2CpNvU4wjDLUXrpcJA5pSAimsZF+xk3HLww19HMj7aY78+h1Eu5vgLbRTF7TmByLxM3MAyhzfD4ifLWfa0yT50TWimngBjjiJQ+AJyG85gEfCOoDBZt2QYxeUfzuT+WeV1QaYX7HEQaQXtAH7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662671; c=relaxed/simple;
	bh=d3HkOnbznhBzBQ9wXOHm12scsOlIm6/hBHWQurUGLT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Opd7XwDDrlUtPYis9Vq6QB7hLSWhNYoji5tamFuA/drVdxLHclir4sFVz2Ql2ppNKqn69sGq7x362DNdG6z3hTp0ua0TP5WNQyBz3jVVTJOn+vdasE1L57kNKVYMbmAF2XqcvA9+yVQy6tkxLA5RTU2x0OUQOM0OPRithR6ZYMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Y0WnCqtG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RDcfUC2f; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y0WnCqtG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RDcfUC2f"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705662668; x=1737198668;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d3HkOnbznhBzBQ9wXOHm12scsOlIm6/hBHWQurUGLT8=;
  b=Y0WnCqtGGrJzY8Tm9kF6N6i5fqUQkO8UvYOUd/ccUeObyzixbjRSlG/G
   dYQgh124aILnLKijtI9gPwHk+vUH2JOCDLzGWwwZIYkrKvtMHFy9vVqKK
   RBOfjO3BZxV3NVd51IwVaBmKOLX9VUme3L2LVaAmL6vep1vS7uXr+dVoZ
   crJ7fApbO8x41fHFOHHb21eHe+kDoa+1ELqwxR2In9uONVncYKGvvV+R2
   g6qEQyLeiwEDTmI1P5BAJO3vQYYtytrb6UMvack9Q2PDkbdBNTEscPZHv
   c63+RADkx9jU5gkPCfB+wXD0ndE+tZMCs93htvpXm7hkQam3D15+xlfBF
   g==;
X-CSE-ConnectionGUID: N+8gwyI3Sk+n4M6BHgrjeA==
X-CSE-MsgGUID: 7raXkEusSomNS0au8yAp+Q==
X-IronPort-AV: E=Sophos;i="6.05,204,1701100800"; 
   d="scan'208";a="7493196"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2024 19:11:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WThZhZFMerDCC2ky1XeaQBKyiYgrhPySAPudBJe4KcP5N9krXSEVznbZ4oZ3BELG9Veqx35PXwp5CYCPG12viFz+LVOHdAOH01vhkRTeE43SiGPGMgvIcHql91lW+JoSnMtXHgC3WvU1/TddQvAHiFiiRPg3w64FrcsCYzI+lJYM8TULtdhYQ9GD0KB0xn2cVFVLAjFLfcOpoGoHo8wznIT8joTwI7TKfx12oZmTudunGYyG2p/uB7y0yaj+Cc0r1cnMTsqSRhs4glNtLZmb9E7B8QnO/8tKTPg7T76RtsVkLmn1lwsJ8ILfHuSDPz01Aes/kP/Djb+Elqt7vN8RWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIleoD6gEXnuGxTFkV5ZZ1FMWD85XDMZxOwOQHJhXic=;
 b=A539XGfVZaqgVa7xcmB/c8PSmA8q+6y2G2K/mpcVnNOjftyIpj+WU5sGkuO5wR0uX3cQ5UxbcAVwudWfkj6k8DuuDMlcStjTrCXeKaNMiTYejpCx7aUpRDKPu7YcyMHx0rLeRetD4RxJkX7YHnQnuKnqJ6mV1AUSSVrZ4SZZD5DBo4kpeDqyHaWPyw8WLx36Vw+Pw6RmfnckbNnk3AQpUeWgQyewMtctuo51DKJt1CCTwRhZl4bl9F8TMhUxSKiqc2XLJm2Ppxwn4ihj7itTIbnruM3GV0YnqOrprLgYbQowrkS4AoW3o0yJQVrcigtFhPfftzwFFSbiScw9Lddnbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIleoD6gEXnuGxTFkV5ZZ1FMWD85XDMZxOwOQHJhXic=;
 b=RDcfUC2fwKMeObmTCS7WP/r1spx+25UEkmtadGJgYxUa4WsrSjudbbuqW9YlReUjXIe3CbxolDnOrH7dCuvHvVyPjGpn0Tloo8lzApk85R7l8WoZ/Kn326WpPGpwvgld6oip1HtUIPsarmfPDDT18MYvk0Njy50oXSP3M28cDg8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB8396.namprd04.prod.outlook.com (2603:10b6:303:143::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.26; Fri, 19 Jan 2024 11:11:00 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%6]) with mapi id 15.20.7202.026; Fri, 19 Jan 2024
 11:11:00 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests V2 1/1] nvme: add nvme pci timeout testcase
Thread-Topic: [PATCH blktests V2 1/1] nvme: add nvme pci timeout testcase
Thread-Index: AQHaSPzY/SPwURlt0kGhyO8ON5HoDLDg/mEA
Date: Fri, 19 Jan 2024 11:11:00 +0000
Message-ID: <r6txdry3nph5s33z2wrgilq4hle5fvg65y6nhf7tfpwkdwqtmx@ju32opkuqqv3>
References: <20240117042206.11031-1-kch@nvidia.com>
 <20240117042206.11031-2-kch@nvidia.com>
In-Reply-To: <20240117042206.11031-2-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB8396:EE_
x-ms-office365-filtering-correlation-id: 85d974a6-5c4d-495e-e940-08dc18df5188
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 POXSUuNIgayyrtAp7lEil8IX/dGPJyxfJIS2YxQIeMzhf2XW8PBVorA4knbaUhR0x+HbGmzco/wo6ApgVPQDKq9q8YyhT7XghU/zi2YXN8FWkrPaqY4PzfO2Jvv+QDBMNYWU4p12ZMYiV7XJM1nlU5rOb2AOnl0hcmQNB4v45IRa1XSj2wWa5p8HIyOENKDMBe6Ybey/rFAgf7OI5Nto9bMlnPh/kPqP/FHAhy3O7MMbpD+54cwSY8UsO72GWc1SCdgQj2XpN3vDcvpcn1KiHYIOeFH/wkZnzlQ0eWaoVkzNIig1XvX8o0Ec/cAYMf7FBBo0IiKqBggTNzBtdTWkx+9N29V721+S5j5cj9GcWPXfoaDiysyd0cU2hEgT4OxALXhE2i7xKX2gWZau7chzuJG6/ny/HcIkkUKYd94NY5vPEbei05PXwYhnv/LtoK012gw7NNvvvs6iuuA2eWr9GqSzMrqVdZMJsBzcS11gnI/t0uD0gSNE8rijMoUoar3yOfdqjlMXo33QKw32Es5O4O3XqmINDUZ93mvh5Wf1wNSAz0cQtudzukDwfanTJLR+FPuppZ27yf9XMH1W5DrZUUDsIWJhj/gLRU7D3DhcQtE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(136003)(376002)(39860400002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(9686003)(6512007)(6506007)(26005)(33716001)(8936002)(4326008)(8676002)(54906003)(86362001)(6916009)(316002)(2906002)(44832011)(64756008)(5660300002)(66446008)(66476007)(38070700009)(66946007)(91956017)(76116006)(66556008)(71200400001)(6486002)(966005)(41300700001)(478600001)(83380400001)(38100700002)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PdRW3dyirAl9PUZ8PtCeRQed3b4SH0Y5lnUm73bjdf1Upt0jvu2ikK1oP92F?=
 =?us-ascii?Q?zv+YPStVOiBmhVSWrIEpPJ5zADDpsdEgd4MZ+n/L2TD3FGJYL5xeJcEwADL1?=
 =?us-ascii?Q?Jlyj9tc1fROjntnfdL+Y1fGMSikpzwwMUwT73BLWPC2vJcVQc76OcL3RS6ZE?=
 =?us-ascii?Q?qZZ1KnN1lVgrEJS9Givo7NdrxY5E/ae5o6RH46qhE4SImnQBTsqn2lZqQjA2?=
 =?us-ascii?Q?ix/nF0yYQMSJpVcx3yiXgCnpD+3qU8l5FnKkK/9xBMo6pD+51QQjD5p0g8Nu?=
 =?us-ascii?Q?dNiZDxWT4eiT9tFPDQ9r8dFpwygPfnCYgEVZcfdYtLcGWa0q/1YucTFlqOZA?=
 =?us-ascii?Q?sUeKe6eCpIoc4Bjswt/TLax6K8d8tqaiHhjMR9edfRpBIDPYF88WxUEWF9XC?=
 =?us-ascii?Q?TPHkjPJ/vkqfBcp1/nQIMo8Fok3ERHCQk1fXHTMJ1ZcGv2jqqLYIB9Uv/Vit?=
 =?us-ascii?Q?IqSiaIa42vhhG97wNwPlpFI10EQ31QThyGa9K3i/3h6kHecjSfKU/IaMfSVe?=
 =?us-ascii?Q?L6lPZRE3n0u53vyW6nHojKbGZNgCXvK4EQyzqR+Ms5BRYT1h+bML0d6uTUKR?=
 =?us-ascii?Q?xvuBDrIi1ybg7bjgvpzEHEN7OpBSh0K7odF0tr4LvVDCYPgjsPF4P7tR0FZo?=
 =?us-ascii?Q?KMnlfUdpPQF+m2jE/OJ3ROHT9aQmwzP/fqWAc3FN4HI4EfdlRQ/A0DjH6e9q?=
 =?us-ascii?Q?fs1bHqs4FpbZQMHpNXjYU8du/C/mOCUnFEJyKgEBZvicBJDwzcfAgjNbRw0f?=
 =?us-ascii?Q?ee4l7BFRpgPqa4wucWPpZD/nJ5MGpMmGHXaIo9DDrflY0fXr9gQDoa09kvz5?=
 =?us-ascii?Q?dUrvOpQsYpMccX5KO+NmZ7Z3/Wzt8v/g4R5Wf+Qzf2YzK8B44gPgsHTvRt75?=
 =?us-ascii?Q?pwtJVXrKv3l2j7k+7u+XekPhv2J0mkNnqHCcIGchsx8EK8t5pWY8wJ2auR8R?=
 =?us-ascii?Q?MztG7RpGQ6ZLQpGKefUCSwqyvFq7axHqaJQgfcP/JOfeL+L1+wjO66mv9LHo?=
 =?us-ascii?Q?gbLDDMJPVJMOOEk/MIV8D+I4xlwsbbf5/h9jt+YRdxuK2Ntl6fnVBNEYkKsL?=
 =?us-ascii?Q?uufcq8K75qaDARQevfXvVr/fxY5WxXD/FUUTm2KAWJ6Vvy6stal1ODsjUjLD?=
 =?us-ascii?Q?Q/5XQJvt92YV7xolPaOpmg+steIaj5Lk3701qIDz6zgdz+kq6recoUTAtyUR?=
 =?us-ascii?Q?vdtTeMV4B5oRWZST6CsVlYTxD07kozavj6NZgTUvGG72zU9sNyuuZ/3qLb8V?=
 =?us-ascii?Q?zQNA7u0jhV2VC4eVZuluycLus/FaVp8uRxiiDv3fAOizDtnUOPkaBD6q3dgW?=
 =?us-ascii?Q?V7TocgFyIrRyhO0EwyYF45COYvLAG6wiwofRc9uEP3rAmmle2bYdNJSqIMn7?=
 =?us-ascii?Q?yUcWtYsbgmIdetUVh5iAJD+H36oVuErZin0koiDaCbYbWLQPV2XooS+a3dWi?=
 =?us-ascii?Q?zLd0AXh5qroYWCITMHMdlHKIGkfeaEoyJ9NtrSg9QHY8UUSQJIYlnAq08J2I?=
 =?us-ascii?Q?w6+Bl2PGbcRZWsAI6ief66eOWudkmshDToqqHm/FGzIQt4CmIqRx9QkBkK0f?=
 =?us-ascii?Q?9InV11/sKDRTbLZBJ3DbtfwMvUwkoAt0r5ghgeRJKAXUJYo8BBeqdtuTySUJ?=
 =?us-ascii?Q?+GtEnqdg/mcrKnBucCGfnGQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18856B46F93C3D45BE418185DB29FF2A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R4bdQkELe9mBB3GmZoyyvGMd8GqMIPgu8U3jHIJzuQ5uM3lEewZlbk15pZIQm4+YPg4hcDnpRegZzBuYzNx0wrUiUdEl60XUV0p0mMB3dQOKrU0tNlMIxoyJTwbQgamBtxX/ofLhR/4gClQbLUikfRAbyRCule+kSTZzgMTbLlc6pF4seQZ/dBeVjaSUJjKDFk2gIL4WsycfLg8I6i44S4633V7NhPQEyhWUK9nlVzDsPRQ83rSKaMDFzUOqNDhL0i4Y4P+mI3xPw7g4ofUBOXIn0La0+Q4y5HbUgvPsBwFnUVlnhfgr8nFHc5CmleC6UUFqiYpEfuZRdvhJ/d5+P3LnWbnkSp5Nq563BeTF3dty3JqCPicRZqNrK7Oq2hTSkaSUsQB6cN0+NL7bYQDR4GugsdPEURXW/XTNlnxrq41IrsqNP2IoqZ0JvWfFLLo5iYHuGkZttqmk9Bq2IzMcU8MTV9aimYZIY6U82fN4TtSQXT373lfss7WvNalahU5LDHjZ6dpcADXz7wxKJj8jeIzbI/Cb+FlI6t5JeaE8skQzf8B5hhTlae3eY9OyX0pTEeefNRYanwAv2LJZ2B77cvQCwGJ4IY5SDjATLU5DomUDMRmNhpmd+2qaUTR3wdyO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d974a6-5c4d-495e-e940-08dc18df5188
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 11:11:00.3923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZfCnNsvTEPMGhNp15YjhqIr9I86yVvLxkaiDyrrxxuGucUJZXdWmSfL7AAXCZg7lX/2m0o6KmJbzmUwFuCqzrEQACtItQJwgej9+cjOe2ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8396

Hi Chaitanya, thanks for this v2 patch.

I ran this new test case with several devices and observed these two:

1) The test case fails with my QEMU NMVE devices. It looks all of the injec=
t
   failures get recovered by error handler, then no I/O error is reported t=
o the
   fio process. I modified two fail_io_timeout parameters as follows to inj=
ect
   more failures, and saw the test case fails with the device. I suggest th=
ese
   parameters.

@@ -49,8 +50,8 @@ test_device() {
        save_fi_settings
        echo 1 > /sys/block/"${nvme_ns}"/io-timeout-fail

-       echo 99 > /sys/kernel/debug/fail_io_timeout/probability
-       echo 10 > /sys/kernel/debug/fail_io_timeout/interval
+       echo 100 > /sys/kernel/debug/fail_io_timeout/probability
+       echo 1 > /sys/kernel/debug/fail_io_timeout/interval
        echo -1 > /sys/kernel/debug/fail_io_timeout/times
        echo  0 > /sys/kernel/debug/fail_io_timeout/space
        echo  1 > /sys/kernel/debug/fail_io_timeout/verbose

2) After I ran the test case, I see the test target device left with zero
   size. I think this is consistent as your report [*]. I still think devic=
e
   remove and rescan at the test case end is required to avoid impacts on
   following test cases. It will depend on the discussion for your report,
   though.

[*] https://lore.kernel.org/linux-nvme/287b9ed9-6eb3-46d0-a6f0-a9d283245b90=
@nvidia.com/

Please find my some more comments in line:

On Jan 16, 2024 / 20:22, Chaitanya Kulkarni wrote:
> Trigger and test nvme-pci timeout with concurrent fio jobs.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  tests/nvme/050     | 74 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/050.out |  2 ++
>  2 files changed, 76 insertions(+)
>  create mode 100755 tests/nvme/050
>  create mode 100644 tests/nvme/050.out
>=20
> diff --git a/tests/nvme/050 b/tests/nvme/050
> new file mode 100755
> index 0000000..6c44b43
> --- /dev/null
> +++ b/tests/nvme/050
> @@ -0,0 +1,74 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Chaitanya Kulkarni
> +#
> +# Test NVMe-PCI timeout with FIO jobs by triggering the nvme_timeout fun=
ction.
> +#
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION=3D"test nvme-pci timeout with fio jobs"

I ran this test case a ZNS drive today, and it looks working. I suggest to =
add:

CAN_BE_ZONED=3D1

> +
> +sysfs_path=3D"/sys/kernel/debug/fail_io_timeout/"
> +#restrict test to nvme-pci only
> +nvme_trtype=3Dpci
> +
> +# fault injection config array
> +declare -A fi_array
> +
> +requires() {
> +        _require_nvme_trtype pci

We can remove this line, since we added "nvme_trtype=3Dpci" above.

> +        _have_fio
> +        _nvme_requires
> +        _have_kernel_option FAIL_IO_TIMEOUT

Today, I found that this test case depends on another kernel option. Let's =
add,

        _have_kernel_option FAULT_INJECTION_DEBUG_FS

> +}
> +
> +device_requires() {
> +	_require_test_dev_is_nvme
> +}

Actually, this check is not required here, since it is already done in
group_device_requires() in tests/nvme/rc. It is a small left work to remove
the same device_requires() in nvme/032.

> +
> +save_fi_settings() {
> +	for fi_attr in probability interval times space verbose
> +	do
> +		fi_array["${fi_attr}"]=3D$(cat "${sysfs_path}/${fi_attr}")
> +	done
> +}
> +
> +restore_fi_settings() {
> +	for fi_attr in probability interval times space verbose
> +	do
> +		echo "${fi_array["${fi_attr}"]}" > "${sysfs_path}/${fi_attr}"
> +	done
> +}
> +
> +test_device() {
> +	local nvme_ns
> +	local io_fimeout_fail
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	nvme_ns=3D"$(basename "${TEST_DEV}")"
> +	io_fimeout_fail=3D"$(cat /sys/block/"${nvme_ns}"/io-timeout-fail)"
> +	save_fi_settings
> +	echo 1 > /sys/block/"${nvme_ns}"/io-timeout-fail
> +
> +	echo 99 > /sys/kernel/debug/fail_io_timeout/probability
> +	echo 10 > /sys/kernel/debug/fail_io_timeout/interval
> +	echo -1 > /sys/kernel/debug/fail_io_timeout/times
> +	echo  0 > /sys/kernel/debug/fail_io_timeout/space
> +	echo  1 > /sys/kernel/debug/fail_io_timeout/verbose
> +
> +	fio --bs=3D4k --rw=3Drandread --norandommap --numjobs=3D"$(nproc)" \
> +	    --name=3Dreads --direct=3D1 --filename=3D"${TEST_DEV}" --group_repo=
rting \
> +	    --time_based --runtime=3D1m 2>&1 | grep -q "Input/output error"

When I investigated the failure cause of this test case, I found fio output
is useful. So, I suggest to keep the output in $FULL.

            --time_based --runtime=3D1m >&"$FULL"

> +
> +	# shellcheck disable=3DSC2181
> +	if [ $? -eq 0 ]; then

With that $FULL file, the if statement can be as follows. And we don't need=
 to
disable SC2181 either.

       if grep -q "Input/output error" "$FULL"; then

> +		echo "Test complete"
> +	else
> +		echo "Test failed"
> +	fi
> +
> +	restore_fi_settings
> +	echo "${io_fimeout_fail}" > /sys/block/"${nvme_ns}"/io-timeout-fail
> +}
> diff --git a/tests/nvme/050.out b/tests/nvme/050.out
> new file mode 100644
> index 0000000..b78b05f
> --- /dev/null
> +++ b/tests/nvme/050.out
> @@ -0,0 +1,2 @@
> +Running nvme/050
> +Test complete
> --=20
> 2.40.0
> =
