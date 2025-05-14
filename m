Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFACA28EC
	for <linux-block@vger.kernel.org>; Wed, 14 May 2025 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747187459; cv=fail; b=LpR4YMIy3fr8dqtUNPJV33buDaS2R7J4IJ5bKk5ZeK3eVPaUuS5zppiVpgfVNwKNJ9YuTHkSASZ89FxpTsGclj7luFQWIQEPnZcR2JSGdZe11DqP8bkWmUPnlUQTljQKPQjDHVCOlJrm5fLGozEt1MZHcTCawdKNxfkSK5D0nAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747187459; c=relaxed/simple;
	bh=j6VF/BOigdvC487/eFo1NDAu/ZmGkqWLJ0QuZL3Px60=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xnfv9/1kpF5HsLB6XbnFw55KZfULndKOF2fuaCGotcdkzUiINeg8PF4PiD7iGkvkv1YRjcnyFGqib5fcLPqy9SP0xGdig3+/ZGWNmdzxHO4BuX2P5OMKWuXcWYNE5uLLeH3ocht4WL+JHRNQmvVBxp8KnvD5dSplHna9qQ/iVFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gsxjoNpa; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bJzrna77; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gsxjoNpa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bJzrna77"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747187456; x=1778723456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=j6VF/BOigdvC487/eFo1NDAu/ZmGkqWLJ0QuZL3Px60=;
  b=gsxjoNpaUvi5Zqozwbj8jBifV3CGprW0dL3RkNOpxpGnAgsrxlC2qyqC
   GIl8vHMLx9JcePhKmJJSaRo44yndMmI1FLQs2Fc2ilUKGPdmYuo1P3okM
   6ExXAYKXgMFm8X+E4K/hlFJPmZJJ5lSM0/xozNXX9zO0sLtnpzV/0O9Bl
   T6Y+ynQh9Bz5yLpFt8gptXiAd286CQJSLg9eAjCwmcJgl5LboWLhkBe2s
   jxf9G0Hxo0Bfv6unjxyL9yxCuch3Yeq/DICpguLdrnTD5EaveTe4nuDKq
   VNUZRNp49VitEMXYz8eSZ2f3xyG66YOS7FsZZ8Gtvat1dB96pv8PkyIsf
   Q==;
X-CSE-ConnectionGUID: 5numZWafRiKyHjDa7DsXqA==
X-CSE-MsgGUID: ZNAf64eTTIqnBELAhbTrow==
X-IronPort-AV: E=Sophos;i="6.15,286,1739808000"; 
   d="scan'208";a="80897300"
Received: from mail-westcentralusazlp17011027.outbound.protection.outlook.com (HELO CY4PR02CU008.outbound.protection.outlook.com) ([40.93.6.27])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2025 09:50:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCJaYAfqi9nnIqYhDolkhgyJM2RkWHqdETG6jvYA1LkAU6ISaPnfyuEgc9LvR9WDsfqLNK25aAZ8IQJGOtFgHKmSNi7VVriCNy48rHGTcXf6xb1MUGOGrOJpxnppkBdHXcN5RTcvV5yLyVyl8a4JfdcAtT3FQDPZ7Z8t3OUr5p5gh28qa2tfUFj+7/hFJRbjzaXCz/uxtedv15WclZxEMFgNbrcueXb9rrxnBHy8LAowuARn39HvxIUZg2gXKOyIqB15kyOT5Rt3SsAwmraCWc1eCSvV8uvsK+D+cmEWBt2wjb9Wsp0FlBKrEvGZUoMX9juk6GAXfiFeBbRhtwyxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzVWbq8kqhJFdb3XAJgv88fFQSWwjriBLPfOKgv43MU=;
 b=bpLf/MaKbtxoSIzVVINEDL6WIN/as0SfZ+wya+jaGCz2SrPxThdH8s1JGw/tCF5VzuPC7XOtBh18/+f00DDxylXzdGyBUN0Sh7TFGI6hj70j0LqWvzkBSzC9ErgOqKoB6hZfDodST3FB0HNPaRHoFRGZg1SfgGTwz5vR92N263z+MNfoaHOSBs09PZU+7pI7Y2tw6m2ztQWAptgAy31Vruy8+uwnRCpa6aWLihzPdBTMrwg+U/SbJoXvMj9Z75MnqoQUsWoFqL5PrlF7ZpoB1rSddGE5Ky+brTRK8U7vG/WuNUfmDlRx0lG5PHPXH5l8YY7v+g/4bauUkn8J3AXI+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzVWbq8kqhJFdb3XAJgv88fFQSWwjriBLPfOKgv43MU=;
 b=bJzrna776mbCcY0zx5t3FgEjQvclnTHFO+bC12ArvTnacjfczfAj5A7iso27nrMfcoLEECcT8Erjl0Pne+/J4tf6+qScGckFad3EK9gABplTQqdxTk6xm+xOZ6Huw078HUxFuDXxIvi9JJIik4v/+GuRd9P9xJZ2l6SN7u/Xf7I=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH0PR04MB7159.namprd04.prod.outlook.com (2603:10b6:510:15::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 01:50:47 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 01:50:47 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Uday Shankar <ushankar@purestorage.com>, Caleb
 Sander Mateos <csander@purestorage.com>, Guy Eisenberg
	<geisenberg@nvidia.com>, Jared Holzman <jholzman@nvidia.com>, Yoav Cohen
	<yoav@nvidia.com>, Omri Levi <omril@nvidia.com>, Ofer Oshri <ofer@nvidia.com>
Subject: Re: [PATCH V2 2/2] ublk: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
Thread-Topic: [PATCH V2 2/2] ublk: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
Thread-Index: AQHbxHKce2MexPIDakWQe+5pgo68qw==
Date: Wed, 14 May 2025 01:50:47 +0000
Message-ID: <mruqwpf4tqenkbtgezv5oxwq7ngyq24jzeyqy4ixzvivatbbxv@4oh2wzz4e6qn>
References: <20250425013742.1079549-1-ming.lei@redhat.com>
 <20250425013742.1079549-3-ming.lei@redhat.com>
In-Reply-To: <20250425013742.1079549-3-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH0PR04MB7159:EE_
x-ms-office365-filtering-correlation-id: 37869941-81ce-440d-bc06-08dd9289bf20
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zi93jdZS1PZKkRHEhlLq/0u3jJwKYPk/YOsaiZvcElLQJ3063zf2thWuYNWa?=
 =?us-ascii?Q?EVHUYSFlDE6ZSCWpfJUi1LOwllrsO2YvPaAqtRHY9t0T1XKACKsLGrG3jVrF?=
 =?us-ascii?Q?7upt+ijvSifH9OfHKIIHN9hHCivg5Ist4SS3KEp/KTs8Jy66V9TWH7l4F3LZ?=
 =?us-ascii?Q?THW/jfAoY4Ce8UcVvMT4a2ey+Z0eYPYb+UfCnnfLiAseJ2lm0ewf5CbmNSk9?=
 =?us-ascii?Q?pInJLhfT5Gor78mXSvmE61zCq1Ds3+ymFzDij99+lLGlUy4gPq6+2uQCmijv?=
 =?us-ascii?Q?GWSlp6SURBKLqfwBSz3rIza1Lgpfbahx9zaUb3Ie8Cvh+8TjwRh2f6Ku4des?=
 =?us-ascii?Q?IpGf1zguUSeAExAYWdRPcm5sNe6id3Os9PHFzs9FEnnYuoA2JVFnzCtVofnP?=
 =?us-ascii?Q?o1UqSRSimtmp3v4j1vLvy5gI4wZWD5xXoSe2/lNx2crjkpdDV65P8026gUz5?=
 =?us-ascii?Q?ObGbWkS+PDn5+gBx9UW3yc5bm/ZIpyZfEmMJh1FTCoa5bvVaJIcKzxBKRRzy?=
 =?us-ascii?Q?JG4Fip0EU79+AeKyr0ctl+GVXotGKGxczMCz+Ee/e2kW5eTI1RanM8ieRWM7?=
 =?us-ascii?Q?fPKV5DMyPC9kK567v/c1eYlEdLU6by06JL1zqIaDAYpiVU8EIt20G2vLf1bv?=
 =?us-ascii?Q?X3/cImunZdqP2G++rulzWmYdwaFzmo2LMgFnYdsEPxCOttgWkC0wFtf04gSa?=
 =?us-ascii?Q?U+nRSQeFh6cumzK10fX0HRc1D5L4O60+68fCvhMMBcYSJSgeICjuZnw5H/ig?=
 =?us-ascii?Q?5QwUpxQM626r4IdhdvH1XFwwbx5bXPqaPM6/NnX2dqrF6sT/jDGM9qqZnihH?=
 =?us-ascii?Q?qWDiLmAjIi+V5HUk1zqz7lwI/jS2EBYtlmRSt2F4s+LHdfjA6TMVTNEGO4xe?=
 =?us-ascii?Q?iW8QsBAi1G5L9BGNQ3Vvk/2i0qFoJBtIQ/BDZOOR3wgofTvu9YwaHMPnD5kb?=
 =?us-ascii?Q?8fgBHTss2WVgVTLaJYcai+O347LE6Umf3+3cC91jCTbyeilAFMA0pRYmikfq?=
 =?us-ascii?Q?imlqLrGnl4daM49IRiUuEpIEDLxXCVP+OUigxZwP0F7XvW3gJXL/FIv7ddLZ?=
 =?us-ascii?Q?+QA3QfuSfS9SpO+MiV0Dee7eUky44DF5t9J88LGTa5HNFtj9bICzL8nkmTlC?=
 =?us-ascii?Q?ql00PBu6hsGeGAKVeOdtMJECWvSBK8LW6zuG+NRjir/tmg2PgAtGBTYliewh?=
 =?us-ascii?Q?D9WbClEpRKCBoN6cPomZlaDpkxYGOf6jtJ3nCw3Ktv/BbXNxIoKTfSX1xZve?=
 =?us-ascii?Q?75RhFzQ+3F6fdJJGI4KYZMrGP6Ue4LWlDvQp+/XMRz5BilzCW4RY4+LvhHOl?=
 =?us-ascii?Q?FeLEf4Ax4Agifm67Y6S/edrfFMdiafXoOgCRN8K0qP/z2e255OQhUm7MBMxt?=
 =?us-ascii?Q?bspIbj9jDUZ7wsS99PRiumnZ/jTRVM9x/WcjRWUPDvcQhV9iPfXFVVQ335sl?=
 =?us-ascii?Q?tksoiP6C+gevZaV+6Avgcu259EOEmqrD3kshKA806x7nMDubiV3ZQ9bxPMV8?=
 =?us-ascii?Q?oCKQ4jwwuTQI5uE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?852XIWbJaLNDIJcZK5GDaFBslA9j5HyZqyXV/YxcleUUqTZX4sT89tDE1HNd?=
 =?us-ascii?Q?l7+Wea8J6KttttJHsbe5dpcG9UFUhXeu9JYzb4lguKa+sULwbKOJqYPAN75F?=
 =?us-ascii?Q?9MQDLA7zV1QoyFnmPwxEzM291MCNz7hc7u1EWujjUdY0H9EcykFLB2cO3W/d?=
 =?us-ascii?Q?hMmqJoF51hlPWZCpygMXRMWp8iAjKE1np1+De32tmjNTYjI6EDvDtTWHt9PS?=
 =?us-ascii?Q?H0WDx58JnaUdwPXMvyxkKrDWaB7KKymwOcDitIfgHFX2UwA6M1JHXX85oyCd?=
 =?us-ascii?Q?+LHXSBHcxh/pyOLPsnUtYSBSXx6XsblaE7josenKXCs+6lg4HlePUZGCzrPh?=
 =?us-ascii?Q?IGEtZnhKgIEyOCrVeubHeizVW9tFHlzQqo35BxbCtRO27TsFyTWeFyvU2DB8?=
 =?us-ascii?Q?unn+477U/6dpnCSpkheiJTOH0C7YxnJ4nJZFNHyRgNVP2ugXh6zzufVRXVbQ?=
 =?us-ascii?Q?b6zCfnnkuXhSWzaI7teIXUS/Ysdgn9MEEdSnp2cR6bGyg3vYJh8Y0E1Kdvzn?=
 =?us-ascii?Q?qTO0FulI+1LKPbCAgikYJjj17thKv7hNke5W+cS8vpHDLzb3veuV+uKho122?=
 =?us-ascii?Q?kITWtgBmuqq8H/u/NsulYti8QSGbp4YtSCBYTte+wls3wSkR5p2eAOgGLND/?=
 =?us-ascii?Q?IKg04KS1nl/QZhBsmcJ1OYa3W5DPNS3+MmchAR6aUXgD7Y9QxyaLzV7SgwFg?=
 =?us-ascii?Q?Fz88clO8/x/JE+fgsbtCYQhadA3aF/V0mbUTFxcU2FCI5+4sirMbpflyqGYQ?=
 =?us-ascii?Q?89pgNqB3HweT6uA5nF3XCv1Rtfxo0b8aqDsqtz8IXw3Xv+OmDoiykbpzflNs?=
 =?us-ascii?Q?btjeJdCJfWV+mrUUF6KTQWbRR6e8SJnVsaYXXQNFcTDTuQIKXmeTuWc/VNlI?=
 =?us-ascii?Q?C1VJ0SOnQuyr8kDu1Xboq7Bl4qVkjwfQE4sWw5nn/E4JZiTQQ7uZfr8t7lle?=
 =?us-ascii?Q?Ap1V2KSPFP3L6mwXtauqQUbK5HIqYGxEJx7aOOzq9m0yicL71tgo5UEz1xB4?=
 =?us-ascii?Q?rJNXg5XjcNKiREgE3eyTmuVg1To3UO76eQyyZZ4uc9+gsnLRHohdFvVUk4zB?=
 =?us-ascii?Q?KHaKEp91KQY4o3oOpen9guxepb/uIF1rCAl3pxvNLkt6PGBbHRBWBH11oEOA?=
 =?us-ascii?Q?n3Yf4XdQy98iCizxDzD4m4iK6lz0CXB9DtgPNdpqs3tSUXXBgPknKEEo4SEH?=
 =?us-ascii?Q?BXjgZ13gg/98d3MvgAMBgM36RE8fb6hDsP8g6wxO4eUvJU6uBXCjOjkqG4Qt?=
 =?us-ascii?Q?4Q3R26lw1BuZHxG0IKEFtcaBrBZqzs+dUqm0AhAm3Di7wROaIOfURYv2jpk2?=
 =?us-ascii?Q?7JNrdzz1nJV1ux1kivdNFAhYI0BhuO1sFxxWRpG3ix1YciYay7HuRl5zJ1f2?=
 =?us-ascii?Q?PA73EZkIzphh8l37EZwp1GOEHJ/VkYDzU6McnmDDHCsFOLgeAU7s1un4CK27?=
 =?us-ascii?Q?5IkYZ0+N9y75pxRP2J5qYm3ZxDBDXHoc7uzDhR8S6ZkjXLpPIgDtaiIJZFSP?=
 =?us-ascii?Q?ycR80wtw6lDCEHEc1+EAr0UVQ0k1CtCtJdpT4IQH/5fopU7d/onb7ImNibaL?=
 =?us-ascii?Q?Nl8YXkrTr3dsqJsWrBZEg++AYh9IghvJ+XfY/xLIgevAR51mZntAlS4a5agQ?=
 =?us-ascii?Q?/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1459CEB62AC7B94EAA8B6C229AD68C0A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fej0Y8Lxn3/vljfpeKW9BT77bMkZ7RjLknBB6NDrCfeiVWWPJm7nRNPpdt19HGAIYGv4FMlk13CV3FczW5LrtmFHWYhJcfXAT4UAAkEXo3yIItetMQCFU+b9Qs4G3n5gDnxnvw5vY7KTDMYrys6tXFksO3lM7lzv+M7w1N7GtBJfT9+xsZLscVgy0An55OQPewTPlGkL7OW+jtA0QTgvz/vyyOGKTVdP8FsQckic/C563xKLsBLJ+kbTNMOGTre7MPVxMogHTNU7SCKr3x0Utg05bMID/W/9wotuumdtaiURJbLe+qJhy9oik1tHd8Iyi2lWzhoEigNcRYT1yifXnKWzHtlkkyJtakZU85LFLJdAxjDcTv1uHDvbZaQ5xAmJ0/sBtuyPoL+p3Y8fQHnMovGSbNFS6rcqaaG9ygXMthUGvKvheap7Vi5ggk3bQwFvYb8RI64PmmDp5NrWRH1asRBoKKbFAL74uUTeCunON8Y+8LyOssijkX46Ldd3rUgktHPC/i6CZATqpXOXqgdtMj3EbLtSa4QdPH3q9/n3XCZfxs7sKbnCZfXhVz/OWgkOZW8zhnmJqqWnkvFXBbHyC50vD0pcG87EZFeRz9gk65c7ztOmr5TwyMrb3pE7kVpt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37869941-81ce-440d-bc06-08dd9289bf20
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 01:50:47.0833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7OScv7SVg242bge4gsKc6qdlAOUHMqEhe8sR/qJ9EHAsJ+0eu7WqdY/M4tz33gGyG+cflsNQlSA/BT9PJ0/g14yQPcJgz5t5t7vChxqWTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7159

On Apr 25, 2025 / 09:37, Ming Lei wrote:
> ublk_cancel_cmd() calls io_uring_cmd_done() to complete uring_cmd, but
> we may have scheduled task work via io_uring_cmd_complete_in_task() for
> dispatching request, then kernel crash can be triggered.
>=20
> Fix it by not trying to canceling the command if ublk block request is
> started.

I found that the blktests test case ublk/002 often hangs with the recent
v6.15-rcX kernel tags with the INFO at iou-wrk-X [1]. The hang is recreated
in stable manner when I repeat the test case a few times.

I bisected and this patch as the commit f40139fde527 triggers the hang.
When I reverted the commit from the kernel v6.15-rc6, the hang disappeared.
(I repeated ublk/002 20 times, and observed no hang.)

The hang was observed with test systems with Fedora 42. I do not observe
the hang with Fedora 41, but not sure why. liburing version difference
could be the reason (v2.6 for Fedora 41, v2.9 for Fedora 42).

Actions for fix will be appreciated.

[1]

[ 4497.777695] [ T130863] run blktests ublk/002 at 2025-05-07 14:48:32
[ 4499.983130] [  T67084] blk_print_req_error: 58 callbacks suppressed
[ 4499.983136] [  T67084] I/O error, dev ublkb0, sector 106830432 op 0x0:(R=
EAD) flags 0x800 phys_seg 1 prio class 0
[ 4499.985230] [  T67084] I/O error, dev ublkb0, sector 165364248 op 0x0:(R=
EAD) flags 0x800 phys_seg 1 prio class 0
[ 4499.998194] [  T57173] I/O error, dev ublkb0, sector 251279584 op 0x0:(R=
EAD) flags 0x800 phys_seg 1 prio class 0
[ 4671.208372] [     T46] INFO: task iou-wrk-131061:131062 blocked for more=
 than 122 seconds.
[ 4671.209417] [     T46]       Not tainted 6.15.0-rc5 #317
[ 4671.210182] [     T46] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs=
" disables this message.
[ 4671.211194] [     T46] task:iou-wrk-131061  state:D stack:0     pid:1310=
62 tgid:131061 ppid:131060 task_flags:0x404150 flags:0x00004000
[ 4671.212573] [     T46] Call Trace:
[ 4671.213364] [     T46]  <TASK>
[ 4671.214047] [     T46]  __schedule+0xf8c/0x5c80
[ 4671.214920] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4671.215831] [     T46]  ? __mutex_lock+0x2d9/0x1b50
[ 4671.216760] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4671.217718] [     T46]  ? lock_release+0x244/0x300
[ 4671.218621] [     T46]  ? lock_release+0x244/0x300
[ 4671.219521] [     T46]  ? __pfx___schedule+0x10/0x10
[ 4671.220433] [     T46]  ? do_raw_spin_lock+0x124/0x260
[ 4671.221425] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4671.222292] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4671.223121] [     T46]  ? lock_release+0x244/0x300
[ 4671.223984] [     T46]  ? lock_release+0x244/0x300
[ 4671.224844] [     T46]  schedule+0xda/0x390
[ 4671.225667] [     T46]  blk_mq_freeze_queue_wait+0x121/0x170
[ 4671.226653] [     T46]  ? __pfx_blk_mq_freeze_queue_wait+0x10/0x10
[ 4671.227656] [     T46]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 4671.228656] [     T46]  ? trace_hardirqs_on+0x14/0x150
[ 4671.229564] [     T46]  ? _raw_spin_unlock_irq+0x34/0x50
[ 4671.230484] [     T46]  del_gendisk+0x4f9/0xa20
[ 4671.231320] [     T46]  ? ublk_stop_dev+0x24/0x200 [ublk_drv]
[ 4671.232379] [     T46]  ? __pfx_del_gendisk+0x10/0x10
[ 4671.233197] [     T46]  ? __pfx___mutex_lock+0x10/0x10
[ 4671.234094] [     T46]  ublk_stop_dev_unlocked.part.0+0xb6/0x580 [ublk_d=
rv]
[ 4671.235153] [     T46]  ? __pfx_ublk_stop_dev_unlocked.part.0+0x10/0x10 =
[ublk_drv]
[ 4671.236303] [     T46]  ? kvm_sched_clock_read+0xd/0x20
[ 4671.237156] [     T46]  ublk_stop_dev+0x62/0x200 [ublk_drv]
[ 4671.238081] [     T46]  ? security_capable+0x79/0x110
[ 4671.238964] [     T46]  ublk_ctrl_uring_cmd+0xe87/0x2a70 [ublk_drv]
[ 4671.239967] [     T46]  ? __pfx_avc_has_perm+0x10/0x10
[ 4671.240858] [     T46]  ? lock_release+0x244/0x300
[ 4671.241759] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4671.242677] [     T46]  ? __pfx_ublk_ctrl_uring_cmd+0x10/0x10 [ublk_drv]
[ 4671.243751] [     T46]  ? finish_task_switch.isra.0+0x202/0x850
[ 4671.244728] [     T46]  ? selinux_uring_cmd+0x1c3/0x280
[ 4671.245623] [     T46]  ? __schedule+0x2f21/0x5c80
[ 4671.246504] [     T46]  ? __pfx_selinux_uring_cmd+0x10/0x10
[ 4671.247438] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4671.248228] [     T46]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 4671.249109] [     T46]  io_uring_cmd+0x221/0x3c0
[ 4671.249952] [     T46]  io_issue_sqe+0x6ab/0x1800
[ 4671.250767] [     T46]  ? trace_hardirqs_on+0x14/0x150
[ 4671.251634] [     T46]  ? __pfx_io_issue_sqe+0x10/0x10
[ 4671.252502] [     T46]  ? __timer_delete_sync+0x16c/0x270
[ 4671.253392] [     T46]  ? __pfx___timer_delete_sync+0x10/0x10
[ 4671.254402] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4671.255162] [     T46]  io_wq_submit_work+0x3ea/0xf70
[ 4671.255990] [     T46]  io_worker_handle_work+0x615/0x1280
[ 4671.256854] [     T46]  io_wq_worker+0x2ee/0xbd0
[ 4671.257670] [     T46]  ? __pfx_io_wq_worker+0x10/0x10
[ 4671.258491] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4671.259285] [     T46]  ? lock_acquire+0x2af/0x310
[ 4671.260035] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4671.260800] [     T46]  ? do_raw_spin_lock+0x124/0x260
[ 4671.261604] [     T46]  ? lock_acquire+0x2af/0x310
[ 4671.262376] [     T46]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 4671.263186] [     T46]  ? lock_release+0x244/0x300
[ 4671.263947] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4671.264718] [     T46]  ? __pfx_io_wq_worker+0x10/0x10
[ 4671.265529] [     T46]  ret_from_fork+0x30/0x70
[ 4671.266277] [     T46]  ? __pfx_io_wq_worker+0x10/0x10
[ 4671.267070] [     T46]  ret_from_fork_asm+0x1a/0x30
[ 4671.267855] [     T46]  </TASK>
[ 4671.268495] [     T46] INFO: lockdep is turned off.
[ 4794.088765] [     T46] INFO: task iou-wrk-131061:131062 blocked for more=
 than 245 seconds.
[ 4794.090310] [     T46]       Not tainted 6.15.0-rc5 #317
[ 4794.091453] [     T46] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs=
" disables this message.
[ 4794.093379] [     T46] task:iou-wrk-131061  state:D stack:0     pid:1310=
62 tgid:131061 ppid:131060 task_flags:0x404150 flags:0x00004000
[ 4794.095353] [     T46] Call Trace:
[ 4794.096142] [     T46]  <TASK>
[ 4794.096929] [     T46]  __schedule+0xf8c/0x5c80
[ 4794.097878] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4794.098869] [     T46]  ? __mutex_lock+0x2d9/0x1b50
[ 4794.099866] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4794.100870] [     T46]  ? lock_release+0x244/0x300
[ 4794.101857] [     T46]  ? lock_release+0x244/0x300
[ 4794.102797] [     T46]  ? __pfx___schedule+0x10/0x10
[ 4794.103726] [     T46]  ? do_raw_spin_lock+0x124/0x260
[ 4794.104752] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4794.105744] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4794.106678] [     T46]  ? lock_release+0x244/0x300
[ 4794.107575] [     T46]  ? lock_release+0x244/0x300
[ 4794.108528] [     T46]  schedule+0xda/0x390
[ 4794.109391] [     T46]  blk_mq_freeze_queue_wait+0x121/0x170
[ 4794.110437] [     T46]  ? __pfx_blk_mq_freeze_queue_wait+0x10/0x10
[ 4794.111527] [     T46]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 4794.112662] [     T46]  ? trace_hardirqs_on+0x14/0x150
[ 4794.113626] [     T46]  ? _raw_spin_unlock_irq+0x34/0x50
[ 4794.114644] [     T46]  del_gendisk+0x4f9/0xa20
[ 4794.115518] [     T46]  ? ublk_stop_dev+0x24/0x200 [ublk_drv]
[ 4794.116548] [     T46]  ? __pfx_del_gendisk+0x10/0x10
[ 4794.117536] [     T46]  ? __pfx___mutex_lock+0x10/0x10
[ 4794.118521] [     T46]  ublk_stop_dev_unlocked.part.0+0xb6/0x580 [ublk_d=
rv]
[ 4794.119749] [     T46]  ? __pfx_ublk_stop_dev_unlocked.part.0+0x10/0x10 =
[ublk_drv]
[ 4794.121060] [     T46]  ? kvm_sched_clock_read+0xd/0x20
[ 4794.122081] [     T46]  ublk_stop_dev+0x62/0x200 [ublk_drv]
[ 4794.123102] [     T46]  ? security_capable+0x79/0x110
[ 4794.124139] [     T46]  ublk_ctrl_uring_cmd+0xe87/0x2a70 [ublk_drv]
[ 4794.125225] [     T46]  ? __pfx_avc_has_perm+0x10/0x10
[ 4794.126054] [     T46]  ? lock_release+0x244/0x300
[ 4794.126850] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4794.127579] [     T46]  ? __pfx_ublk_ctrl_uring_cmd+0x10/0x10 [ublk_drv]
[ 4794.128512] [     T46]  ? finish_task_switch.isra.0+0x202/0x850
[ 4794.129379] [     T46]  ? selinux_uring_cmd+0x1c3/0x280
[ 4794.130178] [     T46]  ? __schedule+0x2f21/0x5c80
[ 4794.130926] [     T46]  ? __pfx_selinux_uring_cmd+0x10/0x10
[ 4794.131701] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4794.132357] [     T46]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 4794.133159] [     T46]  io_uring_cmd+0x221/0x3c0
[ 4794.133931] [     T46]  io_issue_sqe+0x6ab/0x1800
[ 4794.134653] [     T46]  ? trace_hardirqs_on+0x14/0x150
[ 4794.135417] [     T46]  ? __pfx_io_issue_sqe+0x10/0x10
[ 4794.136191] [     T46]  ? __timer_delete_sync+0x16c/0x270
[ 4794.136984] [     T46]  ? __pfx___timer_delete_sync+0x10/0x10
[ 4794.137833] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4794.138527] [     T46]  io_wq_submit_work+0x3ea/0xf70
[ 4794.139268] [     T46]  io_worker_handle_work+0x615/0x1280
[ 4794.140062] [     T46]  io_wq_worker+0x2ee/0xbd0
[ 4794.140806] [     T46]  ? __pfx_io_wq_worker+0x10/0x10
[ 4794.141478] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4794.142189] [     T46]  ? lock_acquire+0x2af/0x310
[ 4794.142930] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4794.143663] [     T46]  ? do_raw_spin_lock+0x124/0x260
[ 4794.144363] [     T46]  ? lock_acquire+0x2af/0x310
[ 4794.145087] [     T46]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 4794.145897] [     T46]  ? lock_release+0x244/0x300
[ 4794.146617] [     T46]  ? rcu_is_watching+0x11/0xb0
[ 4794.147340] [     T46]  ? __pfx_io_wq_worker+0x10/0x10
[ 4794.148070] [     T46]  ret_from_fork+0x30/0x70
[ 4794.148817] [     T46]  ? __pfx_io_wq_worker+0x10/0x10
[ 4794.149576] [     T46]  ret_from_fork_asm+0x1a/0x30
[ 4794.150307] [     T46]  </TASK>
[ 4794.150959] [     T46] INFO: lockdep is turned off.
...=
