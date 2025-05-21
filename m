Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF12238179;
	Wed, 21 May 2025 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819955; cv=fail; b=UE1S2fNNEPkqIEBN52kYMjNkBwtnqZgZxv3gWbBMLpO9EYu+g/iHEUECRtV1Wf1WYF0l+jaEgTloZLyTHdordQ8e68XTOZWI06SIG8w6gHjbQgDuHL1gdNz2j42tFoYoOKYoAQ7v/LjmLSG7HK6gab/aszIlV4EASz6DfI6GG1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819955; c=relaxed/simple;
	bh=QY1/O5BeedKYIcmcPEtU168Q0hrMAmc/io/0w1qJQYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ipSsMJDik4EiSx25tKVXdQdK59APT4j7LEbHIovkKtKQGxdPy+Uciv3CxuuH5dqaT5yCNOGDhBOAHSGm/8xbshnXqfoU/tOb6mVhwutmHcl7kxyFkfKfQM4a7VbsuZJEUrsZqeg+CjXpkhl3xWY00Tbfh41d5zi9js++4V0dLY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mmkr+fxd; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mmkr+fxd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACrpBa9asludfbuzpmhI5WoISj4Cv+G1f8SdnwNvADzTlcmuILvCb7uDkQaiYqASM9wzlXkQPNjDtanMj1FBsJzuNGeUyUYf4aHYlng72nEAHQVDXDPkgmGvaWZJQxgV9vJ2aDl3llah7ip1dgdwZvdP2np5JqBnZCq6bUvBHfBUC3oN8zMzHgdZW4/J+rokhva5G6ZY58rUFbKmHRBzgwPyGnE5f9P7bQVuSKBoVcXzd33NDvW9uHqGf+nNnJmPeNIep1P+RvMsk5iBEDmrR76n+IxRUAb4HjG7KgldmZe0Cwe1JhmFJkkks1x75Eq77rusl2LE7QYr8yGHLkFbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igN7A/MvKOlv0kT6EH0PXOkQHXwh0cnwljSBivibY28=;
 b=m1ChudEfx6H2gjMDsx8Pec7SJK2GOdYAPpJlHEgarbEZrX6bwQpruMbxMddvUD/2FioLNDjDxWjUbogn792uDhSu3npIGgrjNyqgCARA3sGdYrl37Q9GYk5sNbf9nhXCGKsltO77f1VamdjxjiS1Mr4JS9XqRbYlf1871nlKWg18BxuPdaMre8ZZ9xXj3FIs7astwf7rT1z2lwwPEH3jfE78fkPbhpUame/PVcEBNKXd4ZOrxEeOFX5di2bLbwvou1bFsfp34Pafg4+1foAYDBU6r0blKutML7DdPnuNXiSW0njHOQlAv5uT6WU0FtQr428xdAtIe9mOYns7SiNEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igN7A/MvKOlv0kT6EH0PXOkQHXwh0cnwljSBivibY28=;
 b=mmkr+fxdQi8e/jdGHXDv5h4uq1IIms8I4/0Lf0PgV+O8nnjdMp4GettO4FQbvnGpL+SwIbrBzRmnOOUJ01eXtrYabAptoauiTsPbHmJwWtBG87ooEr+NKhesfOFa7dE7DB9zDKxbCQnpTRiKMnVoVXBFhZBU1XPOYCwDkq3ZcNtSKafbT8Lxgmk09jEhQPtzvun8my8u46kbRcWkmZoAOZYvwLZarNBRqmJlNbUW8PyZzF25gCLeSt/rAFh4J7hY6odEoN2+CSUu+yp3MNEHL7ULyPiQrBcsI+BcRTftAnHiRfVkT8rm1DiMXZDUMRoJu+oyQGgq23sxZaC9nsjPYg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.35; Wed, 21 May
 2025 09:32:30 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%4]) with mapi id 15.20.8699.026; Wed, 21 May 2025
 09:32:30 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "stefanha@redhat.com" <stefanha@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "NBU-Contact-Li Rongqing (EXTERNAL)"
	<lirongqing@baidu.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Israel Rukshin
	<israelr@nvidia.com>
Subject: RE: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Topic: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Index: AQHbyhrdL96Oqawka0G+Ryv5JzR6PLPcvXWAgAALoUCAAAWOgIAAALHg
Date: Wed, 21 May 2025 09:32:30 +0000
Message-ID:
 <CY8PR12MB7195A306A9A8CFE8FFC1B033DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521041506-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521051556-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250521051556-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DS0PR12MB9397:EE_
x-ms-office365-filtering-correlation-id: 82e3d6ed-9a41-4560-9ef6-08dd984a68a1
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MxUCcIPZducfyfaAm+9LgNAh4ziz5zSWf1Zz8NBmuOG14rL3WT2YOVTLEsV3?=
 =?us-ascii?Q?vxM2eZc37JTbBPFf64kNlv/rk2AJhwsyqU7GRwtd/+GNoLUhF0wpdiH3e/jt?=
 =?us-ascii?Q?WGh9hs5d2zx558zIxFAMjA1/FLK4HYWedFtainpOVIU1KXH7oivJnkkXD2lT?=
 =?us-ascii?Q?7R88y36RtwybR116GrBGsNgbyKgHzNlfpiiCVOA06GinrNNjrv4ef7TTNtHK?=
 =?us-ascii?Q?D75xWwYTgoChZjrzWh5WsEJeiMKh87RGm2WrVQXV6aj/RnXTM2vHLo6sO4dt?=
 =?us-ascii?Q?vAI8ogYMiAcc+Yk4AzRINCHySAG+aMS1D4E44jjnUcv76cHya6Uy4oqgp1KM?=
 =?us-ascii?Q?eS/jh0MriPOzTN7vB4XB9fXxyrcb2Jke1CbTOAWAGZbglpiGzsPrkEjbSkSQ?=
 =?us-ascii?Q?fCwB/6yh1r2rZ5Pta08smBObAhjnm9z5ci9ROvsRRQ6jNrjzwnDRO0gVszIM?=
 =?us-ascii?Q?YGDqiVDQFIXJilbaNDUu0wTzhIvHsUZKmIgY2qcX97QRi62xV8LPq5kIXGkd?=
 =?us-ascii?Q?UBf3nbp9a9Mo0E0LbNJlM5/ccel31d6+VFKCXEOCPG2hHpBpdoX2zFpafVwL?=
 =?us-ascii?Q?7EHxD4WQpSJaI83shfWyBzFi7EE+H2EcxH1XekhSWe1ncqb7fL3/+3IsVi78?=
 =?us-ascii?Q?9Cj2c62TQ03A08U33Lpvx9Ps0Q02URwQBSPwYKFdDs8VzbzRf7uk5EqQb4kq?=
 =?us-ascii?Q?DqtSlG88FMOXnycZIgvoS2lx+KDfEFE4rU69xqOWp6ETwHlbXWVOFTRuGy6i?=
 =?us-ascii?Q?ib78flRw1VtAJ57j0A1ZJbI8Sa81C8GiE4uvdqvK0Mz6BDk5rtME72Ng37V5?=
 =?us-ascii?Q?MBTeWWoT6+CpAgh1JVwlLIFQBnk9hGbej4+9dYS+tjiiiF5YGaC9XGd7xbwX?=
 =?us-ascii?Q?K5/GuAnY0phgDCk2qlVorQOyix7HeXmkWZnPsYxXmTZkkarIkiVQ4ZnCaKU7?=
 =?us-ascii?Q?X+apZ00coD+28gmPsoO7hD0TRr/yW1T1+uEdzjNpX73/3wI3/MtWK9pkWxul?=
 =?us-ascii?Q?P02ImQ3NImv9NG1MFFLD3cIkK1cTXwq4iwRauOB9ay3yfpNyC9ecUSo0RWSQ?=
 =?us-ascii?Q?tOqiV72r5/8TH4SefOH3RuhW75ULAxT6V9BHlG9nrz4MQuqkPsipdVuwx3Qs?=
 =?us-ascii?Q?PqIvycSJQDTWa8US7aJh9yVNq5pMXmyFx3fE2ht0aYYAOiJDeAVwQmJFMDvT?=
 =?us-ascii?Q?wMYheHQKwfStdVclKW+okhvThbm5aftoCnJKian0a5Z8+RfM/oPBJgtmXk2x?=
 =?us-ascii?Q?xMZhFSgHF4vy2U7gI70cCkACtFC1qI9Zoi3vsdBnmTOSvuwVLftZXEC2QuaV?=
 =?us-ascii?Q?9BJ0QhUONkIPfQ3wmjE8S9rk6Ro9kmHz0T28vr+wC+j4QKZibgKmR4hfbjnC?=
 =?us-ascii?Q?fd4ly9GUWPGSRjmwqbF+SRY4vUZqR8sFbo7LPb2pAZdCIENAUBEAl+mt7rdj?=
 =?us-ascii?Q?qiiVDqiEFKD25Ndvg40Ayi7tr7VkjpqHbORYwpH+vm/Ql/DAP0WttQsxWHG6?=
 =?us-ascii?Q?XinLadVJzE6ytN0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vnMQSvNzYGprFNv7wpN73HgX8il+x16q7hYDcvaZIdt7DkjzScTwukWBGspJ?=
 =?us-ascii?Q?RCFc6UCJcUNgYmTh07oFQtUEJEExeDM6KoB9AE0GK1mojjW9cMZFkBbpiLgR?=
 =?us-ascii?Q?P0vr+doZC1x9Yv9cDhSXbWgluRZ0yq4LG7epw+eAhgat9MzogzJn+xnDSLAt?=
 =?us-ascii?Q?HaseML1MiOtTNnIaeiXqf2jaTUepwTQigEhz1HQZDc2a+2tYSP59cokpqqwF?=
 =?us-ascii?Q?xqOt0WxGPPe/dXEqVk0eH5dyzPW6tsfGA9a12hpFLtE2NSZireBy8P/AMaDJ?=
 =?us-ascii?Q?2Xq8BsbMjZPgEVY6PIldUNe6cPGSRCaGzjLIm0DZdlACu+kTEZ8LIfSQzq4l?=
 =?us-ascii?Q?h+Js0QlcdE6coujtYiBt2dd4oOFw9fu8P1Vmxk++EqcgMg9De2PkS3+ebBFQ?=
 =?us-ascii?Q?nvTtb08VPOf2PM8otZ6s6HTARSW2/SGWxGDWHSWkqXoeToXSVWYnRT8fGfT9?=
 =?us-ascii?Q?TkmjCwgIWum4uy3B5W4G13QMC7NDv7cORA8fF9SDcEzYBnrLaSwKrXLO3Rn1?=
 =?us-ascii?Q?LgKXJRo37EOxW+vHA2taD4PAS0mPD9VNMILu8VYijUh1Ufqrkx8/UNvsxogV?=
 =?us-ascii?Q?S4JGD4maehbAN9gLv/h4bQMg025H+EHkOaPMH7X+T5WhCsSJLwO9VaOWwfAV?=
 =?us-ascii?Q?Sn2x5p38IIJqmPVuYyXX6vp4xKCsDcP5BnWJE8NMfRDYkAeLVUnYiFHMEWVr?=
 =?us-ascii?Q?UvjmMfoLn5Q4fKIfhjTMsREFWXVICbJZ3Hp8nZ/DJhzph9wc27Odgfwx84aL?=
 =?us-ascii?Q?ieMl5K7aNlpLwN2KvOdLFbniZcl6OZtLq9lHqgB3QDB4GW8DFB0ZP+jSTQQj?=
 =?us-ascii?Q?RH7ECGqCurKmMIwKq01cZhkq711G8Ki0AwUl0Ru0Yz2qoSus9L62CsUKF7za?=
 =?us-ascii?Q?VKM04H0N1lqTLKASmIZrwNCBhm4aWiqDcvjpoPUMlhLDq1h+DATq/YGbm6Bu?=
 =?us-ascii?Q?q+0kjsYj7uLVqnBLe/3WNC1w2GP8II2nr0ZhQynvQjp1ZhgWALVFOFqsLPA0?=
 =?us-ascii?Q?DePWkwm5PKHzU8Dv7OyICkszsiwWqHP8E3dhkuQsnCMm5HQO2yCBu9c7lZ4v?=
 =?us-ascii?Q?TqssheTptZhUZVrkW53pCitbNPH1rOtUcAA7woQv7suM3a0/OJn8DCRMIKgL?=
 =?us-ascii?Q?rIWsu4VF3GbRU0q2avtdPLPBO+Uh9iwTk/1TLf0RDh6mbf/bk9dhR8TNk4FY?=
 =?us-ascii?Q?f5zuHMH1sKerWDh+lc2Z0XbZuH9m8DMCWW4ZfdPUiHOifGsNlK/gHKXC9P6A?=
 =?us-ascii?Q?DiPGUm2v0UidrI+mPH6hlyIYh4tJrngvGUiRgRB9blmeXsCfPmgEwZ+EyDRh?=
 =?us-ascii?Q?JWKQehoV0v+Q6KutsGt5yWzRjQwr2OJWxT9bKBRmN4zjUMhbhX+2yxZyly/N?=
 =?us-ascii?Q?fJfWiapO1jscUEf0aABPO55Lv71EtmONf9uwQkicR74qJMIC3HAYI0JrFmwA?=
 =?us-ascii?Q?uVkKJj8BKU0TBtiMfO+R46XdhZNI9rqMWNi3t/ylunm+hmupNvPXWXeq+uEC?=
 =?us-ascii?Q?/apcCsQkpOM2oUjwBvbyAL6Z0fFeqyMyYFEgt3PGH2nFZu2F7x+VmKr5Hc+V?=
 =?us-ascii?Q?r4o9KaY/a4RZw03tEmo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e3d6ed-9a41-4560-9ef6-08dd984a68a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 09:32:30.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2qQJcRSy2Jj6yCUW9wlVEBgnnGhx0G3NxIgRFrxVjnVbnvI77FkVP2HyhFeXBYR60Yrr+m2tsW2kU6qu+C2uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, May 21, 2025 2:49 PM
> To: Parav Pandit <parav@nvidia.com>
> Cc: stefanha@redhat.com; axboe@kernel.dk; virtualization@lists.linux.dev;
> linux-block@vger.kernel.or; stable@vger.kernel.org; NBU-Contact-Li Rongqi=
ng
> (EXTERNAL) <lirongqing@baidu.com>; Chaitanya Kulkarni
> <chaitanyak@nvidia.com>; xuanzhuo@linux.alibaba.com;
> pbonzini@redhat.com; jasowang@redhat.com; Max Gurtovoy
> <mgurtovoy@nvidia.com>; Israel Rukshin <israelr@nvidia.com>
> Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device surp=
rise
> removal
>=20
> On Wed, May 21, 2025 at 09:14:31AM +0000, Parav Pandit wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, May 21, 2025 1:48 PM
> > >
> > > On Wed, May 21, 2025 at 06:37:41AM +0000, Parav Pandit wrote:
> > > > When the PCI device is surprise removed, requests may not complete
> > > > the device as the VQ is marked as broken. Due to this, the disk
> > > > deletion hangs.
> > > >
> > > > Fix it by aborting the requests when the VQ is broken.
> > > >
> > > > With this fix now fio completes swiftly.
> > > > An alternative of IO timeout has been considered, however when the
> > > > driver knows about unresponsive block device, swiftly clearing
> > > > them enables users and upper layers to react quickly.
> > > >
> > > > Verified with multiple device unplug iterations with pending
> > > > requests in virtio used ring and some pending with the device.
> > > >
> > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > virtio pci device")
> > > > Cc: stable@vger.kernel.org
> > > > Reported-by: lirongqing@baidu.com
> > > > Closes:
> > > >
> > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4
> > > 74
> > > > 1@baidu.com/
> > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > ---
> > > > changelog:
> > > > v0->v1:
> > > > - Fixed comments from Stefan to rename a cleanup function
> > > > - Improved logic for handling any outstanding requests
> > > >   in bio layer
> > > > - improved cancel callback to sync with ongoing done()
> > >
> > > thanks for the patch!
> > > questions:
> > >
> > >
> > > > ---
> > > >  drivers/block/virtio_blk.c | 95
> > > > ++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 95 insertions(+)
> > > >
> > > > diff --git a/drivers/block/virtio_blk.c
> > > > b/drivers/block/virtio_blk.c index 7cffea01d868..5212afdbd3c7
> > > > 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -435,6 +435,13 @@ static blk_status_t virtio_queue_rq(struct
> > > blk_mq_hw_ctx *hctx,
> > > >  	blk_status_t status;
> > > >  	int err;
> > > >
> > > > +	/* Immediately fail all incoming requests if the vq is broken.
> > > > +	 * Once the queue is unquiesced, upper block layer flushes any
> > > pending
> > > > +	 * queued requests; fail them right away.
> > > > +	 */
> > > > +	if (unlikely(virtqueue_is_broken(vblk->vqs[qid].vq)))
> > > > +		return BLK_STS_IOERR;
> > > > +
> > > >  	status =3D virtblk_prep_rq(hctx, vblk, req, vbr);
> > > >  	if (unlikely(status))
> > > >  		return status;
> > >
> > > just below this:
> > >         spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> > >         err =3D virtblk_add_req(vblk->vqs[qid].vq, vbr);
> > >         if (err) {
> > >
> > >
> > > and virtblk_add_req calls virtqueue_add_sgs, so it will fail on a bro=
ken vq.
> > >
> > > Why do we need to check it one extra time here?
> > >
> > It may work, but for some reason if the hw queue is stopped in this flo=
w, it
> can hang the IOs flushing.
>=20
> > I considered it risky to rely on the error code ENOSPC returned by non =
virtio-
> blk driver.
> > In other words, if lower layer changed for some reason, we may end up i=
n
> stopping the hw queue when broken, and requests would hang.
> >
> > Compared to that one-time entry check seems more robust.
>=20
> I don't get it.
> Checking twice in a row is more robust?
No. I am not confident on the relying on the error code -ENOSPC from layers=
 outside of virtio-blk driver.

If for a broken VQ, ENOSPC arrives, then hw queue is stopped and requests c=
ould be stuck.

> What am I missing?
> Can you describe the scenario in more detail?
>=20
> >
> > >
> > >
> > > > @@ -508,6 +515,11 @@ static void virtio_queue_rqs(struct rq_list
> *rqlist)
> > > >  	while ((req =3D rq_list_pop(rqlist))) {
> > > >  		struct virtio_blk_vq *this_vq =3D get_virtio_blk_vq(req-
> > > >mq_hctx);
> > > >
> > > > +		if (unlikely(virtqueue_is_broken(this_vq->vq))) {
> > > > +			rq_list_add_tail(&requeue_list, req);
> > > > +			continue;
> > > > +		}
> > > > +
> > > >  		if (vq && vq !=3D this_vq)
> > > >  			virtblk_add_req_batch(vq, &submit_list);
> > > >  		vq =3D this_vq;
> > >
> > > similarly
> > >
> > The error code is not surfacing up here from virtblk_add_req().
>=20
>=20
> but wait a sec:
>=20
> static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
>                 struct rq_list *rqlist)
> {
>         struct request *req;
>         unsigned long flags;
>         bool kick;
>=20
>         spin_lock_irqsave(&vq->lock, flags);
>=20
>         while ((req =3D rq_list_pop(rqlist))) {
>                 struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(req);
>                 int err;
>=20
>                 err =3D virtblk_add_req(vq->vq, vbr);
>                 if (err) {
>                         virtblk_unmap_data(req, vbr);
>                         virtblk_cleanup_cmd(req);
>                         blk_mq_requeue_request(req, true);
>                 }
>         }
>=20
>         kick =3D virtqueue_kick_prepare(vq->vq);
>         spin_unlock_irqrestore(&vq->lock, flags);
>=20
>         if (kick)
>                 virtqueue_notify(vq->vq); }
>=20
>=20
> it actually handles the error internally?
>=20
For all the errors it requeues the request here.

>=20
>=20
>=20
> > It would end up adding checking for special error code here as well to =
abort
> by translating broken VQ -> EIO to break the loop in virtblk_add_req_batc=
h().
> >
> > Weighing on specific error code-based data path that may require audit =
from
> lower layers now and future, an explicit check of broken in this layer co=
uld be
> better.
> >
> > [..]
>=20
>=20
> Checking add was successful is preferred because it has to be done
> *anyway* - device can get broken after you check before add.
>=20
> So I would like to understand why are we also checking explicitly and I d=
o not
> get it so far.

checking explicitly to not depend on specific error code-based logic.
