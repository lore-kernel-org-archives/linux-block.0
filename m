Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8B20B11
	for <linux-block@vger.kernel.org>; Mon, 19 Feb 2024 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708329989; cv=fail; b=Rl9VJGj6APt9kjyL5NlJazVrSVEFJRs+KoLFM/6Ujt7QZDbD4g0+2BOsFiIqkqoT+EKIhlmMEL/JDjaggw7BMui+TlJhR6mg1lUNO5hEogfPkZZZaysPQ84yjMrhporQjXwOcOBmXggU7LAmbNlJIo2GViHld/3tWMMGFUJHcU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708329989; c=relaxed/simple;
	bh=xpXqzkem5wuWE0+KOrgHHm3T27xwAZblGpkKaykJ+lU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oKFlYp63g16EpU1kaq18w+R4szSNzq6pRvCRlcjOFucainNbfbOVJYc9MMnPDVl1BrPBP8k2OpXAcjUMwsKoyrXj6Y6snUbwY7QYiEs6EnS1xR2I8iUF3yTc/bC2U7F3wrplBgJttQYpgg1U0KCSBoZrLO/atbZzDcvKhO5nQ9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=H7mG9iwU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oFV1r94F; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H7mG9iwU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oFV1r94F"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1708329986; x=1739865986;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xpXqzkem5wuWE0+KOrgHHm3T27xwAZblGpkKaykJ+lU=;
  b=H7mG9iwUUvxzztfKxAGZPm0wjGWNfK8yzUC8MUGvMcFelU7WHljbj/KF
   kQTiY6OJ4Y0Ik44O/tyM3qXVC+iiYQ1vgAFaVhom2hP/jXfqOBwBJGhYW
   YQW4IMBwbFMd/Kk1Xf1ogC5gWSBsR828sJFxznoxsCkgfGf5WzR710QY1
   dQBP9Y5B1WsP/nxsB7Ac/ylrAMvOFOuAMzXR5/9CKJqYsmnOVeIEF84kC
   huTXqDjeGu98sM5pGJoqwLtJfQwCCTBrBr5cx//orF2aYDMMnvlt1yxT5
   bVKX2RI/aWQaFZbbH+enjddK7jCKrSE6QQeXn3A5TO+Loiepsb/7TDJNT
   A==;
X-CSE-ConnectionGUID: OItrg0zHQO6OLHHBvfNIxw==
X-CSE-MsgGUID: 2kjf1CQdQyegZUOIfHOiiQ==
X-IronPort-AV: E=Sophos;i="6.06,170,1705334400"; 
   d="scan'208";a="9231506"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2024 16:06:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSZ8BHV/01Jj9uxJlQnprAgCJheNbFu3Xf0InkOaj6rFOlpIcRlLPOst69Yec11OcnUHcDjKZeeU25MQfqcS1QRN3+XczwZz/+pc8FE4TA4rsLhp6TMgUMRBc0d/7T1AsTucK2Q6OLWLu2Xy4IBcb544ssZ3B2aiq9TZrSCbua41/bXsxBF7TF4DVXoKYU82asKrPwbOVB92RZIdyNmHeoh1Sscnle++2NnHGN7w01jDSndMQPCljAEtUNHLa4a86SA6xbzhYqAq46B6dmqPcR/VmemL+tS+J0TJUR4sidMYn4xkCa4bbAv4rdqto1O/Ce8T32vtWNaWW1Wxa4CyUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MCOo4XL5/mqakwHFNcp0dizmpifXyI7YoaiWxzCg3g=;
 b=FolwH6qpwzegUBzoEluPJFgn1aDwkKOdO/vPh21QPQ845TqduFIckNEx9fzScxU+hP6tQB4dumFSlDqwU14ClFRARtG9G2pZ37QgSBCqfEDQt/5yTlQ6WOuh4P+hNjaMKzlxOK6OwpnrmE3RusMYyv7s+4Q1hfp7uEvg1YksadB8xMlA/FX28EfG4ROkDQSWwD3ACR2KmBDZqdbbZv4IapzkRUQL2Fj7vtmo5K/uCKlL/RSjfBSZSghN+//Db+OIAataQs5ctWdbkhVydZcvhmJus11YeNDA2n0QsZqfQeWJ1XmfGQHDebBms1L+/0g5XFAkM2kZxSzZ4G0s7ehYwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MCOo4XL5/mqakwHFNcp0dizmpifXyI7YoaiWxzCg3g=;
 b=oFV1r94FlObRqLo9NxGXvhxkQ2p1A+V4MpGjYEhKAsDmEVXsm9zfF6ByLkv3wUJdoLqKQFMyLZwkH+uLDnzsZ058KMdcIhscBDqzi92gC9aqg35Ywo3MIFTM0cFw5gy2fj6mRzLYohcHO1gAIEn63z5ef0Wh5o6WpHMqOuphWnE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7882.namprd04.prod.outlook.com (2603:10b6:510:ef::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.38; Mon, 19 Feb 2024 08:06:17 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 08:06:17 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme: Add passthru error logging tests to
 nvme/039
Thread-Topic: [PATCH blktests] nvme: Add passthru error logging tests to
 nvme/039
Thread-Index: AQHaYTAENfBlt+01bEabu428v7dj57ERUqYA
Date: Mon, 19 Feb 2024 08:06:17 +0000
Message-ID: <ja3ocox727qncqiyf3z5xvbg4a7h5jjr5w7rwqekixqf53dutp@i4h4pllexdyi>
References: <20240216233053.2795930-1-alan.adamson@oracle.com>
In-Reply-To: <20240216233053.2795930-1-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7882:EE_
x-ms-office365-filtering-correlation-id: 50667025-8840-458d-01ec-08dc3121a63b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 a8NWkcmBZDufSx46FKdAhO2rDEojVTp2X2jyLQsI0OkbgGLDqToPGESoio7PxGzE2z63M+h3ZmwCKh64W76h/oIsgM/73sCi84VGmoh1JjZ4DvY7Ndu+Yd1Cvyra5jBcZCJllopyIa/9NHEJFSEOQ2PDZ9PzTbylSvUUuyCT8EagEo3yQ1vr05ookPMVdZHcZnN697uzDv1CgQhxaTkrL3AtiP5dklPym/5ISSIXWVfVHkKiTX90P/qOo9NmpDeAWuVkCg4c3VY8adJ/MBj+JenjSW4Y/ZVj3Piumo4E0PYPRx9jrsuezBy1K8tqfjMdzkG0A5z7Z9ccCtGfWCnVPTcEBJJN+c5GS2HrcKFrs+joInwPYys34zcXvU7V1+M6w2/zcR1wtT0zx0cypCt273Aoi+7Ts+Jn6mp4XXf02jE4ZT8LZ6eRuF6PKPmP1zEapDy7f+tO03sca7vqJXbUI3vh2whDFhJzJtMfr5ff15402f2PhEhN/0Et3H21xBFiNueY3buvlUcNfQQVbVrgciFAZMTw4V7n0K6ja7CErBhkrVzPOWV2elwGaRSbIeZACenis/amxIDPBhHRHrNUJPQnkv80tZKkSfmORsGsfhh3vaEX8kfVHFkiVFJyF7bA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(8676002)(38070700009)(26005)(41300700001)(83380400001)(66476007)(66556008)(66446008)(8936002)(64756008)(316002)(66946007)(4326008)(6916009)(76116006)(478600001)(9686003)(71200400001)(54906003)(6486002)(6506007)(6512007)(122000001)(82960400001)(38100700002)(86362001)(2906002)(44832011)(5660300002)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z4KpkAFQK5a6fAVjd+nD4GkEMpJYWg/BhVCLroA5NnGf8652chZTPZo9iYUT?=
 =?us-ascii?Q?LQdDH68TP0etreR2TUTWXIgdzzfNcCBrMU22bEUlxkU/T3wuBOQFnJCVz2sL?=
 =?us-ascii?Q?f44ldQAO84oG9+VyM3fhUtq4XMrWaBPc9noEZpiouNE0ThQHLzkhzci/WqBb?=
 =?us-ascii?Q?EqsewlkwtoN6w5MXY5vZNh9atTMApIstoJDJifWttQr9tR/fSSdQNuXcpbjG?=
 =?us-ascii?Q?gUafswz/btr0LAZGJU74jkwP7mX4Gt+bE2PvQ0mlRAgBo/3OY2dIR6oUtAPU?=
 =?us-ascii?Q?Yfj3hj5SWAQ0z8L9aB6qjbH2Cn9ImrhtFcw8yNJaKtFLguUjym4GGj2RkwTh?=
 =?us-ascii?Q?0SEvqswe/LunDlF8xTQvgnR9mNp+Yf+xXIJ+ftnGsEdSv3qT1vwidRyZ/fk9?=
 =?us-ascii?Q?OHVbZpQS99gFmOGLJJV7O8lez5uiTmnQPVPw2aHhKc0ZCT9gDYxRJ45xx1O6?=
 =?us-ascii?Q?ZCM9+3i4Eem3A0Z4WWGhb8UOq0z7ce81wP77IYtGr6cKqAqnRgOEgOWRpJtX?=
 =?us-ascii?Q?7cVP6jll4L19xFXYmFD2eCi1BGPD0Z+i/JVZUpemDYVnLkU5vcdvjdxOJark?=
 =?us-ascii?Q?FuWSnZpxeS5oHac6FhCnuqcLVMGIKDppAn8Oiixy5SHvm/H4Ouo+24oyBDp+?=
 =?us-ascii?Q?Pr8xBgMcvYoQ5XXdFlBRnDbBZU+mTfuc8lkYnVLdkBgN0zOn+A+bQH+fOLq6?=
 =?us-ascii?Q?JJ96CiEo+b65eqDiKsOqj3NdeFDN8UouqbYsCs0131UF4oly/1LEEWYDbr5T?=
 =?us-ascii?Q?h/gmCE1vD8b8pMia2XjxwcxaEANiHlOwsq6mONy2skeg//sHUTNOjbP9bvwY?=
 =?us-ascii?Q?dO+81GsLhb4Tc44z6IMx6ztyLoLk6A/mWOeK/HDYqfWgi0NM/xDTlbGYXyaC?=
 =?us-ascii?Q?RGA/FS5gr9w4z6NQrQijlwW+XltuIq4pH/5kZpIelabeTwnugoNp/ou/Sste?=
 =?us-ascii?Q?TChPdKBFvi2wLTeYAzLHwvtX1Bqd+dBSXzO75flZG4H48Su4BSn5cnd9+QUE?=
 =?us-ascii?Q?5cn1O0PV94h4F9Rchwd7Q8Ql/dUncojPR7Rm7F9z12dg7F+X43dlUJ5A7Psp?=
 =?us-ascii?Q?eg7rSYOxE3eUuKsEonwjySRFzgJSysISrfT4vF5kcGQb3wd/SfhkLZK/Vpxm?=
 =?us-ascii?Q?kl6/SaPynGhraUX9yZL1zw2Jg5t1W4IVGWKIMiLS9MtP2HI2qJHFjPYMwPbk?=
 =?us-ascii?Q?I7XRxh8XRY+KmWyYHy2D7gn1dCGRJxo6RY1FzsjiuuPNQeDJfLm9Iwi+F+0q?=
 =?us-ascii?Q?dToZ7H2nbUSd80LxlBWWjXu9ZGV85ZweqoIZSc6913On6B1C1y/PPKrCjSAA?=
 =?us-ascii?Q?LDVvIT90ct1MvsIEkUAwEbkYTbpayMTbkZmnQgjS3Wh85YEGK9/7V8jBPPrl?=
 =?us-ascii?Q?ELLo1NgpRhQ4CcSKEo46lg75+WclCG54vHdOwXdtWGbVi0TnzHYxMgAHoGKD?=
 =?us-ascii?Q?FjfkOqX3MWTrPYdoM1dbissixB6Yg1PkyvkRsWpF/q6rLYEQvHCqiKfAnbxw?=
 =?us-ascii?Q?gfXnHiquy05zdHpGV63KknSC2YvCww02/bDK0YOKWEWmipJWGmWE+yIQ0C/N?=
 =?us-ascii?Q?Fei0Rfd4DtexQqUXV2gycwyDYEDktgzaktbJUQKV1oTRQgK3w4XC7JUS3F9H?=
 =?us-ascii?Q?Obx5lkMrEkwMXkhD7ePVDWE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <63C24B757826BD4A9F0DC29412E80ECF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iESG4aHfLBZEOcEsLekkvK6e/tAtIBfmq0S2knIBNENpO6QX/yQXCC4UcwgoW6Ny3+u3tEMVmzJXqDcBtSXAXJoq2kCOMla/2CJWRv7u795B+0SxkSrF9EtIxNL4RPHonZ3+PY0KDl2yz2xAxl/hSLwVeZuVjMsRHgxr7bsaydyRZXTqqw9aJrzKrWfmxkvRviu/Qivh2RS52yk8KqPU0lvb//S7tZtux7bN9Bk/mPXAwO2Y7rsvRGEcH+MfLbB1G89oKK7NIMLIj7PRyBwQk1YSRu+NmHqwR3pCtY6STY0SHXjUXitoZqsycdpzkWNYir0e3frVqk18dKf6R5sgjeqPsKvA+Jq93Ef6DG0Bv6GD4oAultmVAkiSh56nYXYeUp9oi6gv6x80hWCN9/qAuqEbTvGXOm+D+0ssfZa6NVUmdeUvRKkMcGyYnJf5l9WKxyccG9JFZpLUutBRStOFpomPvapeGbdA9O9pHkdsR5a7WhJGRzbioHa10VBOixLyhCFqAmLmaKU8p2As6je8EwqGbB874ScEv/9G9SG+JCXyuDMzvBBURHo2qwM1Bx0L7yqBQDFoJbiiSYnfnxcTCFv/K+vNnBMDa8CFFaBjnO6FdfLQcoM7JkSKaT0yFiv2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50667025-8840-458d-01ec-08dc3121a63b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 08:06:17.2175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjhfD5c+3hiyrPgURHEPVG43tocP7aJtJlvd4LdcHVL6w/dJ0Ius1wP19jWR4SdnVWqpGVtQHlessKNX/2kCLR/CLFL9h1BBNCBfaiOVhHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7882

On Feb 16, 2024 / 15:30, Alan Adamson wrote:
> Tests the ability to enable and disable error logging for passthru admin =
commands issued to
> the controller and passthru IO commands issued to a namespace.

Alan, thanks for the patch. Good to get the test coverage back.

I applied the patch and ran nvme/039 for a QEMU nvme device on the kernel
v6.8-rc5. Then I observed the failure below:

---------------------------------------------------------------------
nvme/039 =3D> nvme0n1 (test error logging)                     [failed]
    runtime  5.308s  ...  5.318s
    --- tests/nvme/039.out      2024-02-19 15:59:12.143488379 +0900
    +++ /home/shin/Blktests/blktests/results/nvme0n1/nvme/039.out.bad   202=
4-02-19 16:33:06.135840798 +0900
    @@ -3,5 +3,4 @@
      Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR
      Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR
      Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR cdw10=3D0x1 cdw1=
1=3D0x0 cdw12=3D0x0 cdw13=3D0x0 cdw14=3D0x0 cdw15=3D0x0
    - Read(0x2), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR cdw10=3D0x0 =
cdw11=3D0x0 cdw12=3D0x1 cdw13=3D0x0 cdw14=3D0x0 cdw15=3D0x0
     Test complete
---------------------------------------------------------------------

FYI, kernel reported messages below:

---------------------------------------------------------------------
[   41.441042][ T1040] run blktests nvme/039 at 2024-02-19 16:33:00
[   46.539249][    C2] nvme0n1: I/O Cmd(0x2) @ LBA 0, 1 blocks, I/O Error (=
sct 0x2 / sc 0x81) DNR
[   46.539974][    C2] critical medium error, dev nvme0n1, sector 0 op 0x0:=
(READ) flags 0x800 phys_seg 12
[   46.570149][    C3] nvme0n1: I/O Cmd(0x2) @ LBA 0, 1 blocks, I/O Error (=
sct 0x3 / sc 0x75) DNR
[   46.571329][    C3] I/O error, dev nvme0n1, sector 0 op 0x0:(READ) flags=
 0x800 phys_seg 1 prio class 0
[   46.597495][    C1] nvme0n1: I/O Cmd(0x1) @ LBA 0, 1 blocks, I/O Error (=
sct 0x2 / sc 0x80) DNR
[   46.598334][    C1] critical medium error, dev nvme0n1, sector 0 op 0x1:=
(WRITE) flags 0x8800 phys_seg0
[   46.672226][    C0] nvme0: Admin Cmd(0x6), I/O Error (sct 0x2 / sc 0x86)=
 DNR cdw10=3D0x1 cdw11=3D0x0 cdw10
[   46.714923][ T1137] nvme nvme0: NVME_IOCTL_IO_CMD not supported when mul=
tiple namespaces present!
[   46.754907][ T1149] nvme nvme0: NVME_IOCTL_IO_CMD not supported when mul=
tiple namespaces present!
---------------------------------------------------------------------

Do I miss anything to make the test case pass?


I also ran nvme/039 on the kernel v6.7 and observed a different failure sym=
ptom
below. Old kernels do not have the sysfs attribute passthru_err_log_enabled=
,
hence the failure.

---------------------------------------------------------------------
nvme/039 =3D> nvme0n1 (test error logging)                     [failed]
    runtime  5.570s  ...  5.308s
    --- tests/nvme/039.out      2024-02-19 15:59:12.143488379 +0900
    +++ /home/shin/Blktests/blktests/results/nvme0n1/nvme/039.out.bad   202=
4-02-19 16:23:02.669330853 +0900
    @@ -1,7 +1,15 @@
     Running nvme/039
    +cat: /sys/class/nvme/nvme0/passthru_err_log_enabled: No such file or d=
irectory
    +cat: /sys/class/nvme/nvme0/nvme0n1/passthru_err_log_enabled: No such f=
ile or directory
    +tests/nvme/rc: line 1017: /sys/class/nvme/nvme0/passthru_err_log_enabl=
ed: Permission denied
    +tests/nvme/rc: line 1022: /sys/class/nvme/nvme0/nvme0n1/passthru_err_l=
og_enabled: Permission denied
      Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x8=
1) DNR
      Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR
    ...
    (Run 'diff -u tests/nvme/039.out /home/shpin/Blktests/blktests/results/=
nvme0n1/nvme/039.out.bad' to see the entire diff)
---------------------------------------------------------------------

Then the added tests should be executed only when the kernel has the sysfs
attribute. If such control is introduced in the test case, the output of th=
e
test case will have variations and can not be compared with static 039.out
file. Check for the added tests must be done by the test case in a differen=
t
way.

Another idea is to create another test case dedicated for the added tests.
It will allow comparison with static out file. It also allow to use
_require_test_dev_sysfs() helper function in device_requires() to check the
sysfs attribute (ref: block/005). On the other hand, this approach will nee=
d to
move more functions from nvme/039 to nvme/rc.

Which way looks the better for you?
