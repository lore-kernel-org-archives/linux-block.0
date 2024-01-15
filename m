Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0920E46B4
	for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 05:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rP3A7vWf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="je0q2SXH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705295827; x=1736831827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LgSfDKIaRx6Tbi4lP6aZsY90tM/nwMxVMWhDNFDZenc=;
  b=rP3A7vWfVqMWv5EUqJ/J9LHpx5vpmSwjnF4qY06fJZl4t9htdIiGK1y8
   Auhn8/vNsjuBO80hFBni7hPP/12M4Bq/bdvFaBdhzhKge3aoS4fGJVmfX
   BDTsf7EQqCsdqWFYJP2+4vU4XKj+rdFYX1kh04Wa2fYWsjHOKQFdvZvnW
   LmgkFB2WV5ZmESp4HxGV/EPBtLIz7ygxSN5e+Rd7XRdk7EJIMTsvoSA8/
   +tB8CuhFq7+EGxFbsui5SjAS31fNZtchwLscTwD3uxVirpMqVgpqxnueB
   8mrTTnbYm7FdQqWr+X5noRyFkRSMaqMIMIetAystwIQkWc093vX91s+1d
   g==;
X-CSE-ConnectionGUID: kzjn/nGdSVK7CX62FSeayQ==
X-CSE-MsgGUID: I1GuQ6odQNi7cGGJwOey+A==
X-IronPort-AV: E=Sophos;i="6.04,195,1695657600"; 
   d="scan'208";a="6885985"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2024 13:15:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+rFh9pAX92J5FhtE6ZECFQzvNnnW5gPWet6W9DtEeg8ciRFrf2Ax2SOOFhslLxEZAdTwFY90j2yVrwbGxCUHVKBNxaIRCWFuDNUnVndO7bMV/ZvcpVq04HQ/d9cMCbmb65e8vsb7otaso2W1ca3l8TjnpzbyNNly3AJqBHOdHEVk+RIoJtzQHH8gy2W/W7OTLHb82ic/9YQVwROdnWD2BmFaaEHeSva4HIAlGvfS63e9FqQ2eXkVON2s2L0IsLJNjkXNv0Ix03SimMtLWXkfkxqVq34t/Si1CCnhA0TTt7iNkTGp0Uf/B8plAtFzKG/wVFqW3m45nB4z9JnznCMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVn3/0SUDTwVdEwMW2XdjiuK33Fdzn+Yvs8K1CavOTE=;
 b=iXAPFqlpqjTfWKPb9jRGPQUxsuzl3BNo0abNV6zdjg4JrnwpXM37nCa0vnXMT8hmJh8h8uamMsjpAkOJmHt9/A4OlWl7kM083hG2Jf1C4JF43yTyicmNIuCK0CrP8qm6lUB7abxVfzoGbLzMOE+8wuxVQOq+r4cVmnoZyGlI6ukStGcAz4cj2QRMtWZm6uVkS2bu1vU0vqcWtXUenYBR/qFKH+M5GNIlKb5kod0KMobUEwihXg3TM9ohmMfUrBjc5xednnmn6EVNAyDUTu6SrhJxz4r8sxvhDAYzzdmb1XvJKBKs7Jf/0jNrx2ud5wWUlpK8OlJ1b+d+UpXByt3t2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVn3/0SUDTwVdEwMW2XdjiuK33Fdzn+Yvs8K1CavOTE=;
 b=je0q2SXHFQHHCN6UDcA+CbD2W2kE7zcWLQvJND/w2i3qPuqi/20wO84w9hMAUsPiGDqKZrcEF+z8N8wEPmHh9RV4EgZPiSxdcM19sc4mubjTQxGqJwlGVVS38vG5q925+rwirqH7HeOLfctCIF4P6I8B7aUnyTGmPeHi7jsz+1E=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6682.namprd04.prod.outlook.com (2603:10b6:5:247::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.23; Mon, 15 Jan 2024 05:15:55 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7181.022; Mon, 15 Jan 2024
 05:15:55 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"kch@nvidia.com" <kch@nvidia.com>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] test/nvme/050: test the reservation feature
Thread-Topic: [PATCH blktests] test/nvme/050: test the reservation feature
Thread-Index: AQHaRsu+jlEmZx5guEKdkzcPcVutXbDaVj2A
Date: Mon, 15 Jan 2024 05:15:55 +0000
Message-ID: <5ktqzlnoez2ux2loizs7zcr3eix4om5a2hscopbm4uhcpftber@ohbagb53mkgb>
References: <20240114092611.69075-1-kanie@linux.alibaba.com>
In-Reply-To: <20240114092611.69075-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6682:EE_
x-ms-office365-filtering-correlation-id: 551f871f-dd7b-47f0-8495-08dc15890d4c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Bdps7n/aXsLmzxKHas8RxMTUlGu+sC4j2lhAA1Ic8NitN+25MA0Lq0khKjsGHhDscRuVz9356qGlzlzOyiXqwkyVhxt6OnoeEUb8Et4uf+VEcMJ+1ngrRwhpNZMh10/5jkxGmMVhSvaLRKY+oyOVpjx9GyK3LN7O1b60AcZGK+nabBTDOu8zfYCo5B0JpKgzryyT+qalkWup4E+x9rXTKTHeHE/GzLS7oBedcPGuqy6CWMTUPq3VzwInFXp5bP+2+msU5Ed+rRSEXgI7yGX2KqjWR0spzdohwC9UCny1OHfu9eLfiSAbG2xGurEgdexU/8wdLHsdtY7JWYjxF+J6yLFd9fcQ2ucm0dncOV76AAX627A2F2tXIH2XvSQ0jY8czGIhNLXirdOwWFHZMHBBrA6q0RkTlQoV13jn9DF7xVvwJtPcnPzfqHRH8QO2E2tNz6GbGaIQR+B59IaT6IdKGwLOctZU88bbpOaEOZo8TIa732s4SRpF3qmALMOS4nk9n8zbBBnDr5cJzQPHeN7FU0KAU68AiboViBAAKR5cJpKLuSHQIYbLAQD2HAaVxCpXHvTBd1jp29BHrATk1VsxOIiplMcHveGtaLw4a+7hn6M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(76116006)(82960400001)(86362001)(38070700009)(91956017)(38100700002)(122000001)(26005)(9686003)(6512007)(4326008)(478600001)(966005)(66446008)(66556008)(6486002)(8936002)(6916009)(2906002)(64756008)(316002)(54906003)(6506007)(66946007)(66476007)(71200400001)(44832011)(8676002)(5660300002)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jrJHTZlEtqNvpejq3fERjTPdOscY9eZz+GnzJFhM8C81A/KVo/mMYYRuIgC0?=
 =?us-ascii?Q?JqRQ0fMgYGvho5+DNEtuPz+MQGgIYjCQL5Vx87VtFLBiT2VZoVs1WtlnM/ib?=
 =?us-ascii?Q?QuZY0Z3URMA8XuX7XXoYN+vS2IY6ZwxtTj1crYXds2HkbYXykiuRKZsVYcb4?=
 =?us-ascii?Q?hhIj2kza1cjrGj+7sZlPh2QwODfgp0kUDMc2fEL6nCrKovKIIlTbH5lbNk5h?=
 =?us-ascii?Q?xXiD79ieDYpshz3C+8A+JVCDGLzpYqWghNvc3ZDNNSzRQIYtjnx9+NzeVpu8?=
 =?us-ascii?Q?Nf594EMx5TYm97tKM5E740SBOm+q8XKF7v5Rhgee8r/QMVTjS9Z8/mpJM2Oz?=
 =?us-ascii?Q?hTzEONZ+igMenpaRAOpsxjMrx+STS82Sk5xRuG6p/BqQN9r0Ou1B+5c8Z/kj?=
 =?us-ascii?Q?oLXSOQrrc3uOEbnH/yMd0cTfgVEwmeK9Dbjm1m3aZab7sOtdf3KnWGxpfo4j?=
 =?us-ascii?Q?cXVp2qenrRulOF9BKE6yMcXmpocdBRcClX+Iv6fhOivAXP/2iELoeqEimYnj?=
 =?us-ascii?Q?odHyQGkFNxm3w0oiH8SKmIiu7dm7cpPiA8sC60l5YQSnhas6oXqJDIO2LHm9?=
 =?us-ascii?Q?pqEUrvTv6Sj0W4grWCHq/72MWhDByThT/8lWwfTyKGHXAPJlUMhwZN+wb4FC?=
 =?us-ascii?Q?L3iUvzF8o7CRJIhRa0IWSsTtPObPyAyCNMbTyhIGYpXNXj5Rykdpk+jB+aIY?=
 =?us-ascii?Q?jVhVkoR8/N477GBru16w59vbAdFYU/yF0L0STDmhDy00fRI7UIMz5eKOuPqP?=
 =?us-ascii?Q?OQX09QwER2gnK8gYpJA248LWQ5uqFTLuzNs4eSWAM9GSmUcxH9ics2kzWoU9?=
 =?us-ascii?Q?AJDh+xi6b27PXKb9tRaXyvfVehFiQLzEt+/Cfpu5oXb7CQ75kX2rUGHXChtg?=
 =?us-ascii?Q?SJC/dOXP3uLrIWeT/5zkQ21DOYZ14eCj0zrqlNx2A8Kr8sMRQuuMpqyyfD7p?=
 =?us-ascii?Q?97CqfWTtswLrDX6MoDYOk4sc2lW3XH/QW69o4aDbHRslDqcppCngxfIU4Wqp?=
 =?us-ascii?Q?pyS1Skqohp4FYv3xUaTP0plSZk5frWONoUOx59Mp68UX7xyJrNXGS7FNt6W3?=
 =?us-ascii?Q?8JXWupT0HRCV6R6m0QXz5sppPbhzJEnIQ5/OqP/nhgb/Pv+ZBQFMdvqkrSuM?=
 =?us-ascii?Q?IlVURUJGoL2hoQ6Fj4wRhYFlzeTrSn8lV43BjvIgt+6tozP0ih1kUpiq/pGy?=
 =?us-ascii?Q?dzaWr4YrnPRO7vX5ThgH0Id1KeIkkb6RA3v8sqP5Cd1A6Q9GCrrsPqpEmtrV?=
 =?us-ascii?Q?+HdcE6axsk5+oWTvMA2mKZ7ANjTH5YtxDjxoiD+UMKPtUN/PVxeQy0IaVbYl?=
 =?us-ascii?Q?vldQI5VVqw99RQW64DxaIch8n3r8fMjndIePOtSP4k6RjWulDy8AYCDGjQGG?=
 =?us-ascii?Q?/gCC82TdHONVXddDC6/Ewnec8hnll++2MnEJc+xWEHOWbeUx7qyYrZPUd5G1?=
 =?us-ascii?Q?mnlOcote6j4Vqs/dRIGMQzeKEY3+QYQNQEQXeUhqoOlvoS0GJqjfr0gSgJPI?=
 =?us-ascii?Q?8QKnybnt0jfq0I7j2K8KMbWGrFr+46RwA0YTjwUvp4rf85CYSHah8g/iGsZA?=
 =?us-ascii?Q?EPLRk3BTfI3cGBQ8nr/7CYRuYMw13jYishDDtRJEMeV0k9NC80mIBJb0DLDx?=
 =?us-ascii?Q?YnHCdSvzeYRFI06l3gm35Z0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B239B7FD3EAE774485B4A7E2A90FB8CE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QO6Bk/mNiIWppwZh+qpujXF5ZNwg146PnpNUUFObUA/QT9RjgluWHjZzXGoZE3uXPc+GG5SvcAGgZMMdLBAVaCSFjAtlX8iaAUTCRolPvGtKilxdHxaXPEm3KVzxQ3yms5BRGb+8bKiXozazaUTEtjnQhB8EwHc0hr2r7LLbrchrmbiRwh6eU89UNbp9TR00LyZulOmCTb1RjwgJBP0pJDdwtwSa1A7RcHd5xrI78M1M35fj56mB6SK1pJEHIFtXG1bnVtbxij7iYmKhRMqrlt2csP3+KzNYBmPtIWkthpGvJlHMp3t7px63MwAytZGNhA4UVjDj8WN5AVsdQXvwn3xTlsmOnIwVGKcfKYEjrrnN9onQvXVFHxu88OKwVXKG/HALWbGzlcoD9FQx5xnQXb8xJ/AIsiySdHFJwoZZIvlw9L4anx1gj7VI1q9I0UwBZEbyJtqr6QF3wRdxH/dzRIbzs9sadQB/jq3xj474iHXIPYXB79HZ3/LyTijoP6EbG9y4DFHkqlPMcDowoF/JgIMPFOFnfj4+M5Q89qS6Tg5AXoGA/3Y0yrk8n0ZmtYO/YcelMzHCwzMfSSzU2OnKoLRKiLODRuBm5852HkEES8tfld0opM3ZXDjAE58AT0NP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551f871f-dd7b-47f0-8495-08dc15890d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 05:15:55.7125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUh3nIow4vtag2NypoY0TciAfWHvR6kC5CwUOVQVHCvnlEf2kbUlCCQ6VZaO+cQT3+Vlf1xykp3VW2eXXaluAOQ/DG7xUSG1mSuPZlDRF+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6682

Hello Guixin, thanks for the patch. Good to have new tests for new features=
 :)

I think this test depends on the kernel side patches you posted [1]. So the=
 test
case should be skipped when the kernel does not have the patches. I suggest=
 to
check it using "resv_enable" configfs file. Please refer to nvme/048 which =
does
similar check and sets SKIP_REASONS.

[1] https://lore.kernel.org/linux-nvme/20240114092314.63694-1-kanie@linux.a=
libaba.com/

When I ran the test case on my system using the kernel v6.7 + the [1] patch=
es,
I observed the kernel BUG below. It looks kmalloc() in nvmet_execute_pr_rep=
ort()
needs care.

[  262.402130] run blktests nvme/050 at 2024-01-15 13:21:44
[  262.465068] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  262.520959] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e=
60b8de349.
[  262.525398] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full sup=
port of multi-port devices.
[  262.528334] nvme nvme1: creating 4 I/O queues.
[  262.531269] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  262.655310] BUG: sleeping function called from invalid context at includ=
e/linux/sched/mm.h:306
[  262.657489] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 233, =
name: kworker/1:3
[  262.658976] preempt_count: 1, expected: 0
[  262.660158] RCU nest depth: 0, expected: 0
[  262.661372] 4 locks held by kworker/1:3/233:
[  262.662526]  #0: ffff888135f04538 ((wq_completion)nvmet-wq){+.+.}-{0:0},=
 at: process_one_work+0x679/0x1260
[  262.664235]  #1: ffff88812524fd90 ((work_completion)(&iod->work)){+.+.}-=
{0:0}, at: process_one_work+0x6da/0x1260
[  262.665963]  #2: ffff888133caa870 (&subsys->lock#2){+.+.}-{3:3}, at: nvm=
et_execute_pr_report+0x197/0xbd0 [nvmet]
[  262.667622]  #3: ffff888136cdd230 (&ns->pr.pr_lock){.+.+}-{2:2}, at: nvm=
et_execute_pr_report+0x1b4/0xbd0 [nvmet]
[  262.669369] Preemption disabled at:
[  262.669371] [<0000000000000000>] 0x0
[  262.671748] CPU: 1 PID: 233 Comm: kworker/1:3 Tainted: G        W       =
   6.7.0+ #141
[  262.673226] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.3-1.fc39 04/01/2014
[  262.674789] Workqueue: nvmet-wq nvme_loop_execute_work [nvme_loop]
[  262.676142] Call Trace:
[  262.677234]  <TASK>
[  262.678241]  dump_stack_lvl+0x71/0x90
[  262.679336]  __might_resched+0x3d5/0x5f0
[  262.680482]  ? __pfx___might_resched+0x10/0x10
[  262.681675]  __kmem_cache_alloc_node+0x2ef/0x340
[  262.682960]  ? nvmet_execute_pr_report+0x313/0xbd0 [nvmet]
[  262.684275]  ? nvmet_execute_pr_report+0x313/0xbd0 [nvmet]
[  262.685638]  __kmalloc+0x50/0x160
[  262.686779]  nvmet_execute_pr_report+0x313/0xbd0 [nvmet]
[  262.688040]  ? lock_is_held_type+0xce/0x120
[  262.689221]  process_one_work+0x74c/0x1260
[  262.690480]  ? __pfx_lock_acquire+0x10/0x10
[  262.691644]  ? __pfx_process_one_work+0x10/0x10
[  262.692893]  ? assign_work+0x16c/0x240
[  262.694063]  worker_thread+0x723/0x1300
[  262.695216]  ? lockdep_hardirqs_on+0x7d/0x100
[  262.696461]  ? __kthread_parkme+0xbd/0x1f0
[  262.697587]  ? __pfx_worker_thread+0x10/0x10
[  262.698812]  kthread+0x2f1/0x3d0
[  262.700000]  ? _raw_spin_unlock_irq+0x24/0x50
[  262.701179]  ? __pfx_kthread+0x10/0x10
[  262.702340]  ret_from_fork+0x30/0x70
[  262.703427]  ? __pfx_kthread+0x10/0x10
[  262.704560]  ret_from_fork_asm+0x1b/0x30
[  262.705718]  </TASK>
[  262.891548] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"


Also please find my comments in line.

On Jan 14, 2024 / 17:26, Guixin Liu wrote:
> Test the reservation feature, includes register, acquire, release
> and report.
>=20
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  tests/nvme/050     |  67 ++++++++++++++++++++++++++
>  tests/nvme/050.out | 114 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/rc      |   3 ++
>  3 files changed, 184 insertions(+)
>  create mode 100644 tests/nvme/050
>  create mode 100644 tests/nvme/050.out
>=20
> diff --git a/tests/nvme/050 b/tests/nvme/050
> new file mode 100644
> index 0000000..a499f66
> --- /dev/null
> +++ b/tests/nvme/050
> @@ -0,0 +1,67 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Guixin Liu
> +# Copyright (C) 2024 Alibaba Group.
> +#
> +# Test the reservation

Nit: looks too short. How about "Test the NVMe reservaction feature"?

> +#
> +. tests/nvme/rc
> +
> +DESCRIPTION=3D"test the reservation"

Nit: How about "test the reservation feature"?

> +QUICK=3D1
> +
> +requires() {
> +	_nvme_requires
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	local nvmedev
> +
> +	_nvmet_target_setup --blkdev file
> +
> +	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> +
> +	nvmedev=3D$(_find_nvme_dev "${def_subsysnqn}")
> +
> +	echo "Register"
> +	nvme resv-report "/dev/${nvmedev}n1" --cdw11=3D1

Recent nvme-cli, probably since v2.0 in Apr/2022, replaced this --cdw11 opt=
ion
of the "nvme resv-report" command with --eds option. To allow this test cas=
e
run regardless of the nvme-cli version, I suggest to check "nvme resv-repor=
t"
command output at the beginning of the test case and see if it contains the
string "--eds". Depending on the check result, we can change the option for=
 the
"nvme resv-report" commands in this test case.

> +	nvme resv-register "/dev/${nvmedev}n1" --nrkey=3D4 --rrega=3D0
> +	nvme resv-report "/dev/${nvmedev}n1" --cdw11=3D1
> +
> +	echo "Replace"
> +	nvme resv-register "/dev/${nvmedev}n1" --crkey=3D4 --nrkey=3D5 --rrega=
=3D2
> +	nvme resv-report "/dev/${nvmedev}n1" --cdw11=3D1
> +
> +	echo "Unregister"
> +	nvme resv-register "/dev/${nvmedev}n1" --crkey=3D5 --rrega=3D1
> +	nvme resv-report "/dev/${nvmedev}n1" --cdw11=3D1
> +
> +	echo "Acquire"
> +	nvme resv-register "/dev/${nvmedev}n1" --nrkey=3D4 --rrega=3D0
> +	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=3D4 --rtype=3D1 --racqa=
=3D0
> +	nvme resv-report "/dev/${nvmedev}n1" --cdw11=3D1
> +
> +	echo "Preempt"
> +	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=3D4 --rtype=3D2 --racqa=
=3D1
> +	nvme resv-report "/dev/${nvmedev}n1" --cdw11=3D1
> +
> +	echo "Release"
> +	nvme resv-release "/dev/${nvmedev}n1" --crkey=3D4 --rtype=3D2 --rrela=
=3D0
> +	nvme resv-report "/dev/${nvmedev}n1" --cdw11=3D1
> +
> +	echo "Clear"
> +	nvme resv-register "/dev/${nvmedev}n1" --nrkey=3D4 --rrega=3D0
> +	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=3D4 --rtype=3D1 --racqa=
=3D0
> +	nvme resv-report "/dev/${nvmedev}n1" --cdw11=3D1
> +	nvme resv-release "/dev/${nvmedev}n1" --crkey=3D4 --rrela=3D1
> +
> +	_nvme_disconnect_subsys "${def_subsysnqn}"
> +
> +	_nvmet_target_cleanup
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/050.out b/tests/nvme/050.out
> new file mode 100644
> index 0000000..3be417d
> --- /dev/null
> +++ b/tests/nvme/050.out
> @@ -0,0 +1,114 @@
> +Running nvme/050
> +Register
> +
> +NVME Reservation status:
> +
> +gen       : 0
> +rtype     : 0
> +regctl    : 0
> +ptpls     : 0
> +
> +NVME Reservation  success
> +
> +NVME Reservation status:
> +
> +gen       : 1
> +rtype     : 0
> +regctl    : 1
> +ptpls     : 0
> +regctlext[0] :
> +  cntlid     : 1
> +  rcsts      : 0
> +  rkey       : 4
> +  hostid     : f1fb429f7f4856b0b351e6b8de349

When I ran the test case on my system, it failed because of hostid mismatch=
.
Actually, we are trying to make the nvme test cases independent from hostid=
. To
not check the hostid lines for this test case, I suggest to add
"| grep -v hostid" to the "nvme resv-report" commands.

> +
> +Replace
> +NVME Reservation  success
> +
> +NVME Reservation status:
> +
> +gen       : 2
> +rtype     : 0
> +regctl    : 1
> +ptpls     : 0
> +regctlext[0] :
> +  cntlid     : 1
> +  rcsts      : 0
> +  rkey       : 5
> +  hostid     : f1fb429f7f4856b0b351e6b8de349
> +
> +Unregister
> +NVME Reservation  success
> +
> +NVME Reservation status:
> +
> +gen       : 3
> +rtype     : 0
> +regctl    : 0
> +ptpls     : 0
> +
> +Acquire
> +NVME Reservation  success
> +NVME Reservation Acquire success
> +
> +NVME Reservation status:
> +
> +gen       : 4
> +rtype     : 1
> +regctl    : 1
> +ptpls     : 0
> +regctlext[0] :
> +  cntlid     : 1
> +  rcsts      : 1
> +  rkey       : 4
> +  hostid     : f1fb429f7f4856b0b351e6b8de349
> +
> +Preempt
> +NVME Reservation Acquire success
> +
> +NVME Reservation status:
> +
> +gen       : 5
> +rtype     : 2
> +regctl    : 1
> +ptpls     : 0
> +regctlext[0] :
> +  cntlid     : 1
> +  rcsts      : 1
> +  rkey       : 4
> +  hostid     : f1fb429f7f4856b0b351e6b8de349
> +
> +Release
> +NVME Reservation Release success
> +
> +NVME Reservation status:
> +
> +gen       : 5
> +rtype     : 0
> +regctl    : 1
> +ptpls     : 0
> +regctlext[0] :
> +  cntlid     : 1
> +  rcsts      : 0
> +  rkey       : 4
> +  hostid     : f1fb429f7f4856b0b351e6b8de349
> +
> +Clear
> +NVME Reservation  success
> +NVME Reservation Acquire success
> +
> +NVME Reservation status:
> +
> +gen       : 6
> +rtype     : 1
> +regctl    : 1
> +ptpls     : 0
> +regctlext[0] :
> +  cntlid     : 1
> +  rcsts      : 1
> +  rkey       : 4
> +  hostid     : f1fb429f7f4856b0b351e6b8de349
> +
> +NVME Reservation Release success
> +disconnected 1 controller(s)
> +Test complete
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index b0ef1ee..8de59e2 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -670,6 +670,9 @@ _create_nvmet_ns() {
>  	mkdir "${ns_path}"
>  	printf "%s" "${blkdev}" > "${ns_path}/device_path"
>  	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
> +	if [[ -f "${ns_path}/resv_enable" ]]; then
> +		printf 1 > "${ns_path}/resv_enable"
> +	fi

I think this operation is required only for this test case, so resv_enable
should not be set for other test cases. So, it is the better to add an opti=
onal
argument like "--resv_enable" to _nvmet_target_setup() and propagate it to
_create_nvmet_subsystem() and _create_nvmet_ns(). It's the better to make
it a separated patch.

>  	printf 1 > "${ns_path}/enable"
>  }
> =20
> --=20
> 2.30.1 (Apple Git-130)
>=20
> =
