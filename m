Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021094.outbound.protection.outlook.com [52.101.95.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D254D3DDB1C;
	Wed,  5 Aug 2026 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957735; cv=fail; b=PoqQ4cA+OUh6GmiHwL2VSZsxLer78phR9H0/EJHOU2xWDb10JSlhDD8X4NjA474uj0T+KmbTabiYl24dfnVQRjyyCgfBvAhZAO6ixxHQY4gDhEx0vdMIer2yxHdxZuGaFqqy3xrTpR98PiYQ6Ycz/iaLSacmmFPvfwHfZ5YO7+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957735; c=relaxed/simple;
	bh=ZxYUNWeVxHkLNrkas6SfBwAB+92qRYiCerkLoecodks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YnmXDtN9iR1+cZA63JCW6ZTNqw37Er3QyyCq8lMywr9qT27IlDwJ+fwc81IGJGcGPsQe76WAkKR5Cu23ZnSkSQzk/HGnFZFnEmxHRZ61KW35JPwlvDKZYATjIoS1zMe97fxJeMzb09MgZ4qPrW2XLTkZUk5jcOpDi1GeJfn7U4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQSiVAWzlHqZVGKYEFrr8Atn13MrcuSYDr+Gls3y9VlkYksjpNCYgco/ah9Na3guG7X3eu39VMeVnt/8FIqnsCCnAplyhrvTY9iOzHP+K8hz/5sVz0E7lNReJMOVSTzf4XGiHLIN5DE07veBIt/xOwqC7B30GxBfjgRri5NkLH8+1jlHrSHilN+TTeduTLYn+FZx2ZULdShep2qvrBD5a+qhitwq9cZdvi9Uk7IKQtmi6RNHvGm54PJhQwQ1kF19A6lFicRFewQznvEDaOqCWd80Cjv9Wezq8Gzns7rHsAyQiqPAqwG37VHZ9sWjDsvsGprMJ+f5G0cRXfuHke1JmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=7BwAZQm5EvZgZMD/ZHmGqY40ucw4VWx94fAIHlCv6A8=;
 b=sW4HAlbXfLf3Q7XEeteODSdcbIzIY3qUQFzDBgW8zA5rzalrxBqr65V4te7oHbxbgYSoMb9DMIRenlZlkV2hKi/+pCl4lDMgyaCYG51qTkRGdpzdA+PfgcW9e5TODvkKv14OZf2qrGQ7xqL5sg/PTM3zuy+pB2qtCMafMpRbdFwl0hf3TI9TPXOdAmY4oNc4TPuKNmYBoLB6sh5sGPLEZ+Ht4gd7nynqTDqjFEGgn1ZqxSptElbV13r4hHjZuqa9OcEtD4e+qPhGhl6JuAzaCIXXsw08iSY/r9BjGWRQ971zSdJIW697Vcr1pcIYZyimVIPKcnt554zaTTzqxaoSuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB5770.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 19:22:09 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 19:22:08 +0000
Date: Wed, 5 Aug 2026 15:22:05 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	mst@redhat.com, aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, liyihang9@h-partners.com, kashyap.desai@broadcom.com, 
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com, 
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com, 
	suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com, 
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com, 
	yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org, longman@redhat.com, 
	chenridong@huawei.com, hare@suse.de, kch@nvidia.com, ming.lei@redhat.com, 
	tom.leiming@gmail.com, steve@abita.co, sean@ashe.io, chjohnst@gmail.com, neelx@suse.com, 
	mproche@gmail.com, nick.lange@gmail.com, marco.crivellari@suse.com, 
	rishil1999@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 0/8] blk: honor isolcpus configuration
Message-ID: <my7nrgu6hc6uxpqxnupi6cjbs6cccaksbghoccyufolbujpdto@zznx6dvxlci2>
References: <20260521232956.553287-1-atomlin@atomlin.com>
 <20260710152159.Xl-dY-J6@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710152159.Xl-dY-J6@linutronix.de>
X-ClientProxiedBy: BN9PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:408:f5::10) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e9ff55-3796-4e61-c041-08def326d7ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|22082099003|18002099003|56012099006|10067099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	uOx3Ub6wUHVBCxslqWeBb79X2dKsa4VBZVu51eTFyDYwd9G7eCUK/WAEBV5/IDNshrOgMNLF+vnOKJnt5k3CjkPDXFMMOXS9CEiy4Jvw0vNVoaFfQp5p+/amD3yprU+OFh4Jt1tiJCwGGO13OKRd2Xg06lrdx5B6dzEfmW0MrBY3+J5N8I0P6sfX476CGeVk/x4g/B22LOHPNLt6mKSKdGMMAkTzSU2UwdLM1r4sQqZjTtHh6hrq3Xmv87TijRIcJUtlmJuFHaxf97gGJknHlzj/+FN7wSSuZ7o10ujMx/rzBDL+fMSPjGMWzWpLQjFF9t+JXop0WfwPpoAV+zq2bcbZOeVXQhonJeHEBqQ0mTMLHY2Z5kVveC/OkaFWzSjkjmmpTSUYhM5W8p2jr4AGwXgG0yGrRpybbcnoogC7OZxPsytcJCogXRQdKcRzHG8opUwO30Qbz31ywIip5CNB6nWdGEdj4FoiIoY4f0qdvSv0CzDvIUCfif85scGG5dtQE1OrfJYY9VPupkmE7ClrbDwwzrLtlaSGm0UmKxfSjXDiYsN2G7Smo3MlsKyP+ZjN8kv1uiDkyxbAJ96gvGR0dqur41klfbyQW/uaOtOgfd/Iq4yanNHFXblSsL2En9tHTitstcCyEeQk1896nk/4u1VJt2NcoROxiXsGxe6AXAk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXBPNmZuMGtVL3ByeGJSTGFOdlFKeDA2K1k1MGx0VXJYRUxWZDBNSnZTTzhU?=
 =?utf-8?B?RmU2MHhuRVFPRkxFZStobFRUVjc1a1VBTHpmSVRFVytqWmxvcTBxNjBUVjIz?=
 =?utf-8?B?a2JiK3Z1K0VFQ0J6SklhQmhCT25QN0Q4NzlGUS9Od1RqZGhDa0VNbk1FNTFu?=
 =?utf-8?B?NEtaL09maitzbzRnUmwzWTFMZEw2L3ZicW5lb1haVk9LZjZFYnEwVnBsbUFh?=
 =?utf-8?B?bVlNb3ZCZnZiVjVaSkx3YmgrTXhIaHltZU9ZRE5RYXVRanEwL1k1cHFDZ2Fw?=
 =?utf-8?B?UWJ1M0R1aVIxMDZmM2o0V2JkeVRrVjNxdlY2dEEvMUFtckg1Nm5KTWRwSDRm?=
 =?utf-8?B?TEtjdXovaHQydGRYa1pjZnZMUUp5N1ZHQlV2ODIycU02bkJ1K0RDSlVCN3dk?=
 =?utf-8?B?Vzg0RGoyamt5SDVDTEpBSUQ4aHNocENTSVZDWFNYZzZnODhndU53UGhYVnBJ?=
 =?utf-8?B?M2tITW9TM0Y1bFdCK3hKVjVkVEFxK3gwVnFGdmhwUnlHRTIyYUl5eG1kTHhr?=
 =?utf-8?B?REpvTnRsb1U2ZlNWOFFhN2hUemV0a1BBTGR5ek53VXhJL1pQMm8zNEh3bTln?=
 =?utf-8?B?S2RjYjZsR083R0RWV2xJQlRwY0V4VS84SmUzaUtFaGpQTGFEMWx3UVRxZzJN?=
 =?utf-8?B?M0RCTXBIRHlWUEovRGE4WU9aS1duUXJtMEdSc04rRGZ5VXREdXFZa282aGQ3?=
 =?utf-8?B?Vk9BRk16bVFqN1djZGNub0J2ejc4UzJBS1JqUFlMNHlWNmo4U2x6cDYrL0pw?=
 =?utf-8?B?b1grUVowdU5xQUZQWXlXSytJTkZVcGNGa3UzMnpTUzI3NGtOaWFzZG9wTUNl?=
 =?utf-8?B?Ry9xNFFNQ2dJS0svTnVUMnlOK0svTmtydXJkOHhCVUNHV3l4NmpMNVozWks4?=
 =?utf-8?B?c2xSQnhSZCtLcHI4dE9RSkFTcmMwNkd0aGRuUHF5U3BuL0ErRkN3WEpHTExm?=
 =?utf-8?B?VmFaN1hnSThFZFVqY21qSjNWUWwzQUYxTU5IVTFrRUJzV3daMVVxZDEvMm8r?=
 =?utf-8?B?RzRjVkZJQTA1VWJhQWJCZGgvUjBJTDFLUVFLeERkU1IrVGFMVDV5b3dxSlhI?=
 =?utf-8?B?ak55YjdlN0tUOWlzSkVCczZrUVlqdUdrTDRyZGZMWE4zL1ZSRHJxTytMYXVU?=
 =?utf-8?B?NGNiWjRYSmZQYUYyRkZ1a1NJTk56UFZaemFtQnBuZTVkbEFlQmhNbmxEZDR3?=
 =?utf-8?B?UmRMYWJ0cndqZDU3dldpTld1V29EamQ2R3lkR2dTZG5IU2N0SXFrZEhmUGJD?=
 =?utf-8?B?SHZ2VS93QlVVVlVQSkhiRXFoUi9qUGg2aVZBYTNudDdVc1hCY2p6aVpmbnZY?=
 =?utf-8?B?NWhLRU9iZjVrU001UEk2ZFJxc3ZvQ2p2a29paEpMRngxdEJydGJ3bHVFbXhE?=
 =?utf-8?B?TDBINDh6YUhsNGdXNEJEaUtrSjhYcGpLY01GNHg1Zm5HUFB0U1JzZW5KQlds?=
 =?utf-8?B?TCsvV3hURTJFZHVTN2toZjlLUkxsdWZ3cFRLK3FycWhWVnhPT2xBVTdFS29F?=
 =?utf-8?B?MXB6MHNSUWpNQXF5RWlvd3hXaTFZVStXVUFvVXFFaUtPczFqR0grWFp2VzhJ?=
 =?utf-8?B?TGFkZHRLc2dSVTBRa3BBdXZxcm1DNFJZWGJZYkRReDFMQnE5V1Z3bkZlVDQ5?=
 =?utf-8?B?VUg2Nk5TdngxbGxza29adnpNNDV1MW5paTQyY0ZGMWhUdUVBcnRWeGRlV0ZM?=
 =?utf-8?B?TTIra253d2RvRmFTMkNLaE9YTTlKV3hpOVlQVkJiSjVFL2NjbEpvM05Lbk90?=
 =?utf-8?B?blhXZ2hOb0tRN0s3N3NneVUvTGhZQkV4Y3dMR1ZRR29zRXNOL2FQcmxjUzlr?=
 =?utf-8?B?c1AvTUdHQ3BVMjJtSjRLU0lybHhBRkpxeGpjOVpEQ3UxbnVjd2lLdlI4SGcz?=
 =?utf-8?B?T3RlK0dIdTJzZW1NaERuNDJ1b2ZIaitNMFR5Kzl4d1FERWlTM3UwUERsdndj?=
 =?utf-8?B?Z0RiNXUwc05WeDhZT0MwdGdOdndxMlJMVHVpZnFjQmhORDl5R0NEZUFEVkd2?=
 =?utf-8?B?dmt0eFI2SzUwT3BMTDl5NHkwWmdmSG4yTFVLQUNZUVM5Ujg2VTkySldCMHNF?=
 =?utf-8?B?M0ZwRDlnWENLRjNPcjhhbUN6ajF2NDBSNHAvUG0yT25QWitzQm1YbStlM1Zi?=
 =?utf-8?B?S2h1YTZod2tVRjNwM1IwRkFncXdxZnRRejRFVWhzR25FNG1nU2FBNG1ERkJ4?=
 =?utf-8?B?TzlQV3Q4K2tadXpIYXAvYXBMSm9SRWlhSlBDelRmTkc4SHV0VTBDREFHd25t?=
 =?utf-8?B?aE1oSkd5WWpVRmFtYXBaaWxFVnBXWFBYcFBzSzR0aXA0NGhmK0dkVWNndHUw?=
 =?utf-8?B?WFo5a3NmblhEWWV0ZCtrUy9sQWpqaG9Hb01CaDU4akdlSFZYRTVGdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e9ff55-3796-4e61-c041-08def326d7ae
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 19:22:08.8325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3tyMKSJTACxyCOaCQeYPPND7iR7usPGxq79FLvOlFttbULnL93BSsdxmoRQ+R0tVV/kAnPEi7VR/Y1D//SiBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5770

On Fri, Jul 10, 2026 at 05:21:59PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-05-21 19:29:48 [-0400], Aaron Tomlin wrote:
> > Hi,
> Hi,
> 
> > I have decided to drive this series forward on behalf of Daniel Wagner, the
> > original author. The series has been rebased on v7.1-rc4-100-g8bc67e4db64a.
> > 
> > This series introduces a new CPU isolation feature, "isolcpus=io_queue",
> > designed to protect isolated cores from the disruptive hardware interrupts
> > generated by high-performance multi-queue devices.
> > 
> > When enabled, it fundamentally alters how the generic IRQ subsystem and the
> > block layer (blk-mq) map hardware queues:
> > 
> >     1.  Restricted IRQ Affinity: Managed hardware interrupts are strictly
> >         confined to online housekeeping CPUs.
> > 
> >     2.  Transparent I/O Submission: Applications running on isolated CPUs
> >         can still seamlessly submit I/O requests; however, the resulting
> >         hardware completion interrupts are safely routed to a designated
> >         housekeeping CPU.
> > 
> >     3.  Topology-Aware Queue Allocation: The generic CPU-to-hardware-queue
> >         mapping logic is extended to distribute hardware contexts evenly
> >         among the available housekeeping CPUs, preventing MSI-X vector
> >         exhaustion while maintaining optimal cache locality where possible.
> > 
> > To prevent I/O stalls, the block layer is additionally hardened to reject
> > hot-plug requests that attempt to offline a housekeeping CPU if it is the
> > last remaining CPU actively serving an online isolated core.
> > 
> > The complex "top-down" mask plumbing introduced in v12, which modified
> > struct irq_affinity and expanded block layer APIs, has been abandoned. It
> > is replaced by a centralised approach: direct isolation querying via
> > housekeeping_cpumask(HK_TYPE_IO_QUEUE) within the genirq/affinity
> > subsystem. This architectural simplification successfully decouples core
> > changes from driver-specific implementations.
> > 
> > Please let me know your thoughts.
> 
> I think I asked this or wanted to: Why not mage managed_irqs consider
> this? Or is there a case where those two options want a different thing?
> With managed_irqs you specify a mask but this is may not be respected if
> you have more IRQs than you specify. This means the IRQs will still be
> routed to isolated CPUs.
> This option is intended to avoid any interrupts on isolated CPUs.
> Wouldn't it be possible to allow managed_irqs to restrict a device to
> two CPUs only and use two queues only instead of the available 64 or do
> I miss something fundamental why those two need to be separate?

Hi Sebastian,

Please see my response here [1].

[1]: https://lore.kernel.org/lkml/xjcwes5caiwh3eumqfuvankokb7wzzokleqfkfmkh5sgl333sg@nwlgqvj4vdet/

Kind regards,
-- 
Aaron Tomlin
