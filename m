Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF6719D8AF;
	Fri, 14 Jun 2024 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718408147; cv=fail; b=OtrzvOjV/Obowp9FTFr3zzuMZKJjdUpl1vS7TwHakAkl+GEonNWUVJlzNl3eACA9V2AyRHr1gXX4x8PRhL7eCX68gz4NVY/jKxNhmNBFDvB6Mv+bUGd9/RIR6ABuEwoTloOISsOepaQCpSJ1iz2Q8dJiq7yaT5TSxJxnEUn/5Z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718408147; c=relaxed/simple;
	bh=BZyf8dJwJhyMD6AbwC5T6g0/sasALbmvgCdaBt520FQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=azHhYLcU0HI+x07+ofhjOEA0MRVFCTrAEbAbhmsF2QEmXvRP53BWOstolRlOOAM+7zNLxYHp7VUOnH7ICQSo/fF7slrRH87HU4fHwQDrroHo8/YE5wrnOEDuCz24rr26OFqj9fjZ1lgR0oEjW9YPh8I3ZxEbzS1lLQjRD5h+Mhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BcjKBgxH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kmC4TS1F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BcjKBgxH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kmC4TS1F"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EMwGLV001234;
	Fri, 14 Jun 2024 23:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=BZyf8dJwJhyMD6AbwC5T6g0/sasALbmvgCdaBt520FQ=; b=
	BcjKBgxH02ZswQGLmLXjgU1DxgcuoQOUAVJP6LZLMhjAo3VOL7rtERWtZU7Dpn9T
	OmcCU5q8cwtfBij0vdntoLUSgqTQHjnEC0bMFM1xz3NCcgJR0vnPtxy+d5VJWFAr
	IIEPJOzR65N7Bde0PniA85JQSXDHaxo6zVwiJHHu94L9Vcdiuz22WRzjrM4fryK5
	nmWUg9z0jhzpuAm8pQwx74DQfv+MiI6dDCG62k7y9J4u3QdZHTc+/9Q4i80c0SvB
	ieMT+enIhmjJTku5bpUaH6R7YRskjjouuF84zDtDfe7rGdIQk45hJ/HgFjhWeZAW
	dEcrvSMnk2ZDlu5tvMgRrg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhf1mntv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 23:35:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45EM3UR5020154;
	Fri, 14 Jun 2024 23:35:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync9371sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 23:35:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/e3LQATTr5O3lq22FFX6Mu6Tzox8FHsZR7te+qLuya5gbvZzSqJrKEbtPqFNeJNSMJt/4j8dstwPy3ZaMv18UvptAdNW35Pct9hQOQeR/jzksz5CkMVu/jFwAgUKr0U9M/aXkFtKW3uoljbbvwWZzerERQY/di2e6blyilrimQTAhuFcqFk7TKZZrr6pR5sozDbi+i6O6Ljs4bisrvCStnFIqNU9L7CKuITL8TglASgqRxEEd8gEr/5rCe0ej7fjlo+Mao32TojlDioyX6wemxDc2z0S8/9r3v7lAz/qpeegmv9yopT6ivgAhGbP23IlrKcdxlo7KmbmfnJbak9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZyf8dJwJhyMD6AbwC5T6g0/sasALbmvgCdaBt520FQ=;
 b=U02K24GGBSNjCbTq2aQjAfaTBCEK2X4jMAXDB6FGJB3gpjo1UR4YGGcjKn3GrIFDaRQ1sTbOPPuK6C7qSmbSiyPm1QodXFfiMfLtPnBqTwkiEaHNnRLhLfnnMUzAoX3i/A7YfCKTtXgQH3svUrjZiG7qo5c/j97RkH6NJkpXE1sHSv80NmmiyfEQFMInA5DtGqWDa2D2OGWoH+TNg4UhFt4fya7RygtCh8g3yjzFZikin3JuPJC5O45MHqZfGogNsYMeQ/iwEa+sb5lBZKs5I3O0dBN72NHt0y8gaHp3e+i1YkKNVBXQtg3GGYC/tTbm/UzT8FQoqGPCRSnL97/alg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZyf8dJwJhyMD6AbwC5T6g0/sasALbmvgCdaBt520FQ=;
 b=kmC4TS1F7RaET4brjESp0QKF0GmKga6ZRGBYdHzE3IO5WwY5Q1K8uIYJMsfElcXB/cjtksK6rM8ITQZ+laGGeJKN4aPz7/Erh1GjINHyKtYigPtDmNA1tVz23wOzRrCsMdEVjoWC+1KUrhvq74+kwhE3VumklK6+4+WaLKq+puc=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by CO1PR10MB4660.namprd10.prod.outlook.com (2603:10b6:303:6d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Fri, 14 Jun
 2024 23:35:20 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%2]) with mapi id 15.20.7677.026; Fri, 14 Jun 2024
 23:35:20 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: "hch@lst.de" <hch@lst.de>
CC: kernel test robot <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev"
	<oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "yukuai1@huaweicloud.com"
	<yukuai1@huaweicloud.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: RE: [PATCH V4 for-6.10/block] loop: Fix a race between loop detach
 and loop open
Thread-Topic: [PATCH V4 for-6.10/block] loop: Fix a race between loop detach
 and loop open
Thread-Index: AQHavA/KpPG1Y2G/i0Skj77IBfr3QrHGM6eQgACQXwCAASpzQA==
Date: Fri, 14 Jun 2024 23:35:20 +0000
Message-ID: 
 <IA1PR10MB724052E773F52C756F4F295F98C22@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240607190607.17705-1-gulam.mohamed@oracle.com>
 <202406112130.a572f72-oliver.sang@intel.com>
 <IA1PR10MB7240B2686664744DB0D8867F98C12@IA1PR10MB7240.namprd10.prod.outlook.com>
 <20240614054534.GA9969@lst.de>
In-Reply-To: <20240614054534.GA9969@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|CO1PR10MB4660:EE_
x-ms-office365-filtering-correlation-id: 21a49f5c-9a51-4758-3598-08dc8ccaa7bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?/qC82Xmjuz6PbY3b2ijHaRHso9ZPepEV1plWwZZcM6O9p/8DZbuz7uha493Q?=
 =?us-ascii?Q?fBk9DmjhpQ+5TQ6LLro1aZeW16v9iwXjLUGW1FymE1YmDAalc7IFSV69/Bg9?=
 =?us-ascii?Q?lVohRR8+X5Gf7yG1dNkuoMf4YJn9nsprNsHIN75/iVooxeoC5qCVldbTeRcj?=
 =?us-ascii?Q?UDRP/YKFePQMHVxz62DsnUia3tM0oiYIoY5To3f+jcGtbNe0/dqBdDgpUP3o?=
 =?us-ascii?Q?FQ//Wx6C4AR6Wxdw/4nmNOi38apl0AXhr1IPJSitHAXpzoKdbL7e14pO9V9O?=
 =?us-ascii?Q?9bAG7s5bTdvmIuCdMuZ3DBl0ptU5AvfXJvXy0KnTQguT8dkwL7f1OSIJ701v?=
 =?us-ascii?Q?yJ3EiSkrP/l0YO9s80DvllIYcN0sAa69zBj1D7ZEx29AgKYIZXy+fCeE2bE6?=
 =?us-ascii?Q?tExcTfSZJ+8jCV51kM+K8dc7aUdiurPPCIi6OVeq1TCqeDVRvxtGhZMYQ+RX?=
 =?us-ascii?Q?cCyqqYZLVOWQ28S7X0XozVvNyURGQeLEqEg/k9P6XT7MjgBmzmW5sxuhgTvl?=
 =?us-ascii?Q?k3DBziNefcXFlKUuT8uqZ04Au8WBmh5x9ACkrx0bhFNEsglV7pPZhlnGBAK4?=
 =?us-ascii?Q?LJbSdKtmkqMUqlQMD+07VyZPdN7QHc45uWwFdDMhtXIANVfNLK3kumgsPRvR?=
 =?us-ascii?Q?YSPukRGphl9nsjE1e18CEL1tgCbHB0jK0zkIlRLge5o2zqzxdJv7XGDxoyKS?=
 =?us-ascii?Q?zh0IGOffMwEUU5h/7jX9Bwt2z20q4+Gz3APzMmKRjwioPd3Ml9UFBfLT5VW1?=
 =?us-ascii?Q?x7V1PncoJ85EclpzQfeQ+NVpP9/UnaUI5j8PrOcNYH5bbzQeAjdCJa1mqZeh?=
 =?us-ascii?Q?Xd01W8LnZOPuIdM9qvDaMQ0bS4yRp13c+0xzyOgWWv21AVxKAXpxMMlca5qz?=
 =?us-ascii?Q?fToQhplcgi6Os+hpq8P6dHq8HHuNAC9DK94+E3XFfXTGm2IjwurK7l5mBi6x?=
 =?us-ascii?Q?TI2slLopcag2rfRP8BOOxSnblpb4NS2ZGM9qLJSmUJqriVmMANHSdpDfsSEl?=
 =?us-ascii?Q?WVuOZTGKgQdE9SpGJMQATuvXlYxpoJLCq1o+3PUWsaINHIaGtroDqzfEY1Rb?=
 =?us-ascii?Q?K1Vm5En+KMijKGGySPx1Ih7U/c2FZGvbYcKlfcbILcmlp27d7PZvSB3Fa/HA?=
 =?us-ascii?Q?TfXyuWipj3Ybi68Bw/SlVmn6fNoDuMVuetrxvudMxYxnz4CoGK60xvJGCPcv?=
 =?us-ascii?Q?XBzyRgmajLvBosV6DlWL+o7dhiIzweDNxrDvJHsjSYhXkp9n5NuiQ80p6ptA?=
 =?us-ascii?Q?Hy8itAtIDJUUKzCJzLN0if6dEUNxm4zy4zQkSZxN6bxweIw2d3Qk/lZwxP4r?=
 =?us-ascii?Q?YvM/0/Oc8XiZTktbUOtWcLbyKMkh6uwFvDE1JA0BKLew94lDEyUW0IFJKqdG?=
 =?us-ascii?Q?91XIrGw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+X3vrL16KgCIDARKA9x6yf/dL5+sb7OArgKQOPfKdCiUDZWSK8VHFy39O1H4?=
 =?us-ascii?Q?qRHj3O25C/GMiNBy3zJ+NC85KyasJVbI8t32ko92IesoVacN6eyM1tlheCAQ?=
 =?us-ascii?Q?gms5Gg/WtuiO2cw/zWfUlL1imjdZ++UKcr1DueR4UCTWc5D4XOMBeNflvf88?=
 =?us-ascii?Q?SBNN5DsoNHUONQ8iTX2AO5v8DXRn20WZ1odfivXgEkeRcTiEbTfMMmC0sbJu?=
 =?us-ascii?Q?/a6MIhgWOuzMk1fu/VwTaheoHphdzjyOGS5gQ2bo+MuWUrgyqlY2Af4HOG3W?=
 =?us-ascii?Q?qteQeWNO1lhBT2MyUILsZ7kmain0FA+IQQN6E0wABiY1Nn182Aqmq46F1yZ7?=
 =?us-ascii?Q?Ihm8CQGBu0wXSdclddKNgf4H76cpIoZG9l1eSySNeFCLNe1lvXbbRaI/vz7d?=
 =?us-ascii?Q?HgKYYQ8hsZ+VefEP3SQwZVrvvCJ5rX7I5O1g+ltCN3cwqjlLAN7Z7gGOwT86?=
 =?us-ascii?Q?eO83FD/Udps1Qo4JgD4K6xs08HzqMIc8mGPb1rkiNXzVIwm5VgfpN9FJguh5?=
 =?us-ascii?Q?NS87JsW1aJ3gAzrz/MrRDWWvpAMNfh7+hIyAbKI4JC/ptOwVXy532sKBXNj9?=
 =?us-ascii?Q?7jg2oggajgcASH7R443Lgp1+NngtbvkIxwKjmHiJgxxdCGzhqg8k+WcNEHgN?=
 =?us-ascii?Q?bpGa6bnGwF5mr1oRtSty1UQIuNlXfPhrUWXHhwyELOpVXjlst8NnklU6HzIM?=
 =?us-ascii?Q?NMZ6pfjK8BHYto5Bk1bMM+GpqNFZffpAtg7DJTF+InRGgUcrdkeVcYxfO+bp?=
 =?us-ascii?Q?hBUTDCjo+I2GXVHiV8leub7Ycjq85/FojsNfSbplX2u5q5Tv2fKz/zTL48sP?=
 =?us-ascii?Q?377nop8YULo1JDO52y1heCnzIh2IwGCGDn/c2wbvWs/Pp81VIkWIk5z7uoU8?=
 =?us-ascii?Q?GfPo6LPgl1pLjGCKrnIR615V//AV617qAOJNiWAQxwWuVJEPhOVQ4awsffbF?=
 =?us-ascii?Q?yTQmQtHMBuJatrs0aEajiQNgClBiiEi4eE174csAJK6w0Ax2I8kclOXUTk5T?=
 =?us-ascii?Q?LhSbaPqdhXVQaAIKWgLKQigZLyCkFvTjQbbsyhdsAMmTIHwmgOxJ4g8yAWfZ?=
 =?us-ascii?Q?8XZ+yo/KHtQjptnE2D+FVgT/FU6D9bmmQlX7qa5YwxopkvS9iywurEAj0DyK?=
 =?us-ascii?Q?nprNiTEpEVdnxbhGp90QldDBlxTBqM9i4MxkJ1hDVtdUoctoVyftwsjylpvW?=
 =?us-ascii?Q?73oYzuh9dLhLEvY77CS1ikaCRW3jcC4FY5tfH9Hc1BKEnHPtFgfeIzhrhD2N?=
 =?us-ascii?Q?VuVALm2aBfs4puSotmEH7QYMHmyctJB6XOcQcbHBOv+sl8MttAlcSUfV/b9o?=
 =?us-ascii?Q?RUrTc0G1uHGFfqX5k/RfgLF8T98OOHSP0fRH9/sALRtlZRQgXHdt8XsfjCrf?=
 =?us-ascii?Q?4hGKvBUCD3sqUiZXVeEfasNMBMu9pRyqe6//0hSZmkD0mchUxsaRAiCBWmXX?=
 =?us-ascii?Q?cqq+BCgMjnwWMio4oY3DZBGzCBwsgAzKYR/yqoA40+9WJK+Jcfept/mWvuL+?=
 =?us-ascii?Q?hOZiyuOm3JTPTObsTk5uw6LEInYPM4b6qaG8LiikhzcKBTO1uj8cTkKtIOnp?=
 =?us-ascii?Q?pmvrCub3Iv9xfZ3BiGpsAkf1xWMhWU57IDF2CS0l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PSrreaHe0SagImVaDwD5X2I8pL0IuAjg0sn0E7AFe9eS76t2L9juB6SF64tb/TUZm505Hnk5bKfRMP9tu0vggZYNXlZvQzjuQGlefp1MxXIde+XeXVGw016sH8ib6ID4zuzWsxy6peM+NCnr3n6zH6Q+s7FrGZkw5lFBFZNC1vwbsfZwRHvo9nAtUJsfujVv7oS9FnIQ5vED+TeqY66ZR5uMdmb0JmdglR7o0QZncKyQCJ2kAZUIpVm1CdIpIkQDQauz7n6qdVxyCr03k+H1u+XLcMI1Nc2jHZdG7kFLgHbARgr5PGydgPwngxmlxJBuk0zbk9DaBy6nw7b/CJ8J3TMDv5c2K8n7n1IMGEISoYRZnsWyae+yjE+c2nKGZE3V0decfrstp8rU+ZLSWNlwA6nLbjjzEqxCmY35OD8zR0G5jJJ080Ube4QIzsTBCr7PE1BeVyBGq5iahU9HYd3mJ6iPeSmlWcU0yW6qldtPMqQQTdDJaxmOwXsv1h3s9M1+pqqkBOR0GYVvcsLoNgNmb70gY97j84NZDmjFRrhaHzD8VGU6zD89FwZJjdQs5NE3evsEveH/NALqzidQrkw7S/ybTV9JkL3NcoF3ASrpTZs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a49f5c-9a51-4758-3598-08dc8ccaa7bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 23:35:20.4762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oeg69Nntjyn1Dr5Yhc5WBnOIAGNRUiF5z7HzdVO9y3GrHiajblsw3YTIVIOYuHd5xp7vZbwEC3jIw4yIjvB9BBL+NvWyrw/0cPXckJimm4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_17,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406140166
X-Proofpoint-ORIG-GUID: jcBhRzrEpXR3yWUx8Hy5WqnjAXyfLXH0
X-Proofpoint-GUID: jcBhRzrEpXR3yWUx8Hy5WqnjAXyfLXH0

Hi Christoph,

> -----Original Message-----
> From: hch@lst.de <hch@lst.de>
> Sent: Friday, June 14, 2024 11:16 AM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>
> Cc: kernel test robot <oliver.sang@intel.com>; oe-lkp@lists.linux.dev;
> lkp@intel.com; linux-block@vger.kernel.org; ltp@lists.linux.it; linux-
> kernel@vger.kernel.org; yukuai1@huaweicloud.com; hch@lst.de;
> axboe@kernel.dk
> Subject: Re: [PATCH V4 for-6.10/block] loop: Fix a race between loop deta=
ch
> and loop open
>=20
> On Thu, Jun 13, 2024 at 09:10:37PM +0000, Gulam Mohamed wrote:
> > I looked at the LTP test case failure and also the function
> tst_detach_device_by_fd() which failed. Our kernel patch will defer all t=
he
> attempts to detach a loop device to the last close, to fix an issue.
> > The tst_detach_device_by_fd() in LTP test case will open the loop devic=
e
> and repeatedly checks for error code ENXIO. As the new approach, as I
> mentioned above, will defer the detach to last close and the last close
> happens *only* when the LTP test function tst_detach_device_by_fd()
> returns, the test will obviously fail. So, Can you please modify the LTP =
test case
> to accommodate the new behaviour of kernel code for loop detach?
> > Please let us know your comments.
>=20
> I still think simply setting the rundown state is the better approach..

Thanks for the review Christoph. I am sending the V5 as you suggested.

Regards,
Gulam Mohamed.

