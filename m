Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021110.outbound.protection.outlook.com [52.101.95.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C5B3DEFE7;
	Wed,  5 Aug 2026 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957636; cv=fail; b=TjpYiLicvuJ3w9FY3/57a0D6hNPk4gJjg6QH7oiblT4rnLwSyOnMRmpSVMQ/NrOx1ruR1P2TImVLzc2HZcGa0Q03Fc3zBx4Rtnn8IRxSqPfb5M/ILUPITd+o+RldM/3soE8Y5wC9hQsYq9uxinYXmua0lN4/8+RLUBPPvUCS8m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957636; c=relaxed/simple;
	bh=AfwtT1NjEFZyi+ZOtAuGE/2Wm5kzytc2l94elqewTig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QF6OmEL6Gn1wAPnsTichOY6z8iUbismkoLlmOAyQfbvQkWQnGqv/fYn1W6TsNaVKQqjO7pDr9yoqPqNFnegjHeomxs3BfnzPzsmlQhUi1VDWq4+5t0LoysnD8lWM506zWZCX9kJ6jPsbI2CqdGyaTdIvK1+KuzWRuYC5KrCISxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGuznVc1J6VCquiKHFxg72f57D94cEUshaPqZv3D+m3ROm6z9UxGHAb8FZeQpj8YpEg0mTPyFDf7aumMnGIuu+knQVQcmCb2YQnNSKv5XP0Z4Tf3sVyrp3F1YyvolzRPccTz4l6aqXbKwLnHrPk3FUKSZXGsGG2rZtbH7R7B/HAdTEelfMuBv4g0952MFXOXtM8JiTcTASgzLSpbWad9bfmdopLde/phAGb+7y+929fn2WQgOYNhEoF5rK1Qf1HOvhjF/sXVLpNsrg7QL0wZETsRJzOV2RyfgfNAjrYfLQnXcXMluNFJDU3L0V1zPtU+RIiO2icWlMxyIsFcr4SA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=wsO7a6EtlDH9CL33vq1oL3JHavosf4n9+Vn4Kqfl5bw=;
 b=gsD0gZEnWvIXY2h2NtvN4fXYJ/lf/EcghAhU7mui0B76OXH9iFtG9QxiAeADiJuY9ZNrIUl6qzfWfSmjce9hpXAnZIyNGFUQehdh3g95B40hxHS237paJk3Q3RxC6rm27BNDXXELurXLtew4CJgtfKKuQVZbBT5uYa6VmIEFRDIM+VpQoMwO6SXPd+feYHDByM89vRqcQirsxCJjXoxvb5Q4Zxp3M/ssHiA3cw85O6Gv7gQ7O7KicIm4tlVDi2GS+VZL0tX8gBM0Qf8zItRFekfrosj/3mwngdyD2rr9ZAkzwtVFnXrzdMKoBKgW1dryU6C274akpKkYjWsq2CMH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB5770.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 19:20:29 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 19:20:29 +0000
Date: Wed, 5 Aug 2026 15:20:26 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	mst@redhat.com, aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, liyihang9@h-partners.com, kashyap.desai@broadcom.com, 
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com, 
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com, 
	suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com, 
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com, 
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org, 
	longman@redhat.com, chenridong@huawei.com, hare@suse.de, kch@nvidia.com, 
	ming.lei@redhat.com, tom.leiming@gmail.com, steve@abita.co, sean@ashe.io, 
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com, nick.lange@gmail.com, 
	rishil1999@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 6/8] blk-mq: prevent offlining hk CPUs with
 associated online isolated CPUs
Message-ID: <ujlw6w6npcy7hgmtdqqzjuy36l2cd7l2y7sxoq2fwhyujy6756@gabfeibsggym>
References: <20260521232956.553287-1-atomlin@atomlin.com>
 <20260521232956.553287-7-atomlin@atomlin.com>
 <CAAofZF6z-m9oikO6CEd_VUeBmgEq08E5RW0ED9C9m+xanOsdSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAofZF6z-m9oikO6CEd_VUeBmgEq08E5RW0ED9C9m+xanOsdSg@mail.gmail.com>
X-ClientProxiedBy: BN0PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:408:142::30) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e83e19e-bf32-4a55-6468-08def3269c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|22082099003|18002099003|56012099006|10067099003|4143699003|27256017;
X-Microsoft-Antispam-Message-Info:
	y2D7tZ/4DUb+ug/70bDLk/z8Ff7eI3CO/PD0CqDs41q4t2QIeukNMXRebBNcSp+Wp/Fz9E7o25V6VcC1boURX8g2jC+dTkVXKECmu0p/J4/RxECnCvbj2c65pRzWVM69SFTLhO4+7CtQ9ZSG+3UP6ABAyQpWiZZl/G1jJU2jI3EF/bIzG8GbVb9cXM5eSljIKAjskW5OjZoCaqGq9tRPd/5fGf5YGx4CS5e8VKoGt88TGAnMf5+//j5hP9DJqv9Au8ynQVvxMqMbA5MU+Wzk5/Hf64MvvxOFQXcUQ3g+jRRNajn/Ssp4a7nzhBLsQqSGSKV/+7j87rBBxEYqJl3Tck6aaFDPr/Aezak4UpQywW24HNilRn77dsIDBAtRYAuRfKlQ1TGUNgOaNtgR/QpZu9Ze0t7zcmQL6R9iT68Buni6KdD0E/TsrG9A2PPvpyR/SQagb2OWlK0BqAZZMhnnomBvMr8mzaD2yX116cWboA/9AD++xfNPPIu8P/7KBIuLiwfmJouxTfOasghWK/i3ewc5GwYbpSdWiNDwEDbALE8Z3JdyiIIKwowJdeIv/bDB3XTXIU4oLTov738KZTSmxZineljkOf8iY3BtS+UMfi8YjklERcrNPLAWWdKEIC4gqU2AtTPuo4rzJvFNDt9NEZzZ2rs4XfEpLPwbNiZ93Pkz36l0o12CJXbzD9MUsgLRIvFe4bYGTOuC4Tcs9KklOQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmNodFE5TW5qWmt2N2RVdDBNUlYwaEo1UnBRd0pXQXVmWXE2SEJFRUVscXNt?=
 =?utf-8?B?NXJBcG1UZVJvYWZrcURFQkNWbklYd2JxOGRyMVNtbURpZGdwdlMzaWs2ams3?=
 =?utf-8?B?bml6T1htdUoyWHoxYlNQeDl5U1hERGFXOEdEaTJDb3hwZVNBUGlrNGdTNU95?=
 =?utf-8?B?YjVhUEtaaG1sM1JUR1U4NW1qcFg1ZFV6cUlFZ2V5UVR2UmxzMklXek52Zmcy?=
 =?utf-8?B?dmxObW1JeERvbENZM2hrcUNwYlI0b0tBdTFPdks5dkFhdXNJeGR2bElkVy9O?=
 =?utf-8?B?TG56WWp2YmFteWNEang4M21ZUFFPTjhrQWp4YUtNaUNHMDd4d1FtM0FFWlBa?=
 =?utf-8?B?VDBVNktINUllNm1rRTRGbi9oK0VsMi9KYldBSnNwbE1QY3J2MXdGdzZVTEkv?=
 =?utf-8?B?UmpmZzNmMXdSdmErbUw1bVV2YlZJdVlIQ3RqQ2pYUEl4b1M0U21uWFRnOENz?=
 =?utf-8?B?QTI2cEhJNENvaFZFMUJ0akRWdU53aUlQbW5GU2dwY2hDd0ltMWFYYUc5aHhG?=
 =?utf-8?B?WHNkNjF0USs1MzRwYlBEc0IyMTJvN1MzcjFyTEJDbzhhTEZvMitEMk5MWGlu?=
 =?utf-8?B?Zk5vbjUyUmNpZTA5a0EzNUsrSFhoSUpPOTlMU0J0bzJhTFY3cGJBZlp0UGl4?=
 =?utf-8?B?Q1BERGNuNGdEWnU2bjVQYTJDTUhtbjE3SGpLTkpaK09LYVdnODVyMjk0K1BY?=
 =?utf-8?B?N2RaeWo4WFp1YXR6YWJudk0rZnpCdnNrdWwvb1BqUS9lbWYwL2QxcmxiSUFo?=
 =?utf-8?B?R1BNYUV2aE1NU28vaEdWblhWUVU0TlB6S2tHeE92U0hIS1g5L1dlMVlWZkNa?=
 =?utf-8?B?WlQ1M1BLbzdPU2IxcjJQZGo0cUJTMEREeVJwcXk2NG83eXlMMkRNWlpOZCtS?=
 =?utf-8?B?cTZjYjE3QWU1ZFVFa3pQZ0pYVEZEZTdCS29PcHQxTEI3Mjk0MHBHUWF6SGtF?=
 =?utf-8?B?YzNLelRtaGYwRUVBL3NYbjJiajkwN2ltWGhnSXpkRTBaK3A1bkhHQW04cUZn?=
 =?utf-8?B?ZVU2QXpVRkRxOWFhRE1HODlnTDdyNUNaaDBSNWRHdWw4bVY1TDlVNzE1dW9T?=
 =?utf-8?B?dUtsS3Z4Y2RsS05aUnNsS3B3enpSNFlydFVTTHdOc2wyYVR5ZWo5c1lOS2pq?=
 =?utf-8?B?T1d1bmhtemE3amtId2pkYUR1eS9RWTRwaENyTStyR29zb29uajhFRXpRZjV4?=
 =?utf-8?B?ZkQ0Vk94VDByaHcwYjZQU1VIVTNuZVd2UUg4bjloUUV2S0YwWkhpanROTDdG?=
 =?utf-8?B?dTJSQzk0bUwwNkhzbVNpMUFWaU91ZTBMR2NlNElUdkxrR1orU1lLaG1vZEJT?=
 =?utf-8?B?R2JUdFM4T2cxS3lLakJ4Tk1JTE9kdndLcURBN2R6ZEcwSW1OSWw5bW5ZUXVH?=
 =?utf-8?B?d00vNEpCdVZ3VmxXUlR2clAvWmZaNjFDdGdwSlc0bmFDaVJIZWF2NFdrZ3dt?=
 =?utf-8?B?ZlREcDBocjgvMGZYbEJEY1ZQV08xbkdiN2tzcjdKQ3RQdGpTSUtyNnlVYmVn?=
 =?utf-8?B?RE4wdHM5L2ljajJlbDFxRmpnZ1lhODM3ZExhSEw1dEQvOThJRnlUdFM5czJJ?=
 =?utf-8?B?bmdtWjgvZkcxeUErZC9EaVNCclZRdStvbDNGZGwxMzFQcmVtaG4veWhoTVFG?=
 =?utf-8?B?RXBsZEVSRDNLd0pvOWFIMWJDQ0RyMUR0Z1BDbXQ4NWFHSzhGWXI4ZmlJQVpL?=
 =?utf-8?B?K01FTGJuUFBjYkY0NDlFRXBMMzd3T1V1RitJNG0rdklNZXdpZys4by9jdU03?=
 =?utf-8?B?R0xFajB1MFo3R1dPWUdXUGFjYS94YXlFYUluR0RXVHl5QTl5VmRBZnBXVGN3?=
 =?utf-8?B?TWdUQVkzZWFhQzVlMzMyQno2WlB6VFAvTEdXQmlKY28wN1Z4eTcrT0ZWZnZ4?=
 =?utf-8?B?Sk1OUEpVaEpXYy94dEdvbFE3LzBKYVJCdWN5UG94U2YrY0wyS1Y1MWQ0Y21q?=
 =?utf-8?B?NUxxTEplOXRWdkxOTTRKZlFNSEJEeDkzbVpSNGVYYm5nWFU0YitUY2IyeEd4?=
 =?utf-8?B?UG9Fb0ZKWkJsRGtPWDVlZ3NzTENMM1FER0xzZVU1VTZWMm1zSTZiS1crT3hB?=
 =?utf-8?B?VEZVMXVoUEthbnh4R0l5aXRzSVllWEdld0dma1gwblBuNy84Mkh2R2NmRDVy?=
 =?utf-8?B?L29tZ1VSSjN0Q1FTTDBkZzN4SWxiMUJrckNNb3M2Uk5HZ1JjOXpad3pDZlIr?=
 =?utf-8?B?QjQ0UndMb1YyM0ZtR2QvTmNrMi9SeFdsNE5DLzJxQVpUd09GUGpiN1pHeXRY?=
 =?utf-8?B?ZHV1ZmF1WUY0WG5sY3VqZ3FLV3pxWEhjdnMvUEJKMW5RaFBXemRQMXk0MW44?=
 =?utf-8?B?TGJUcWhZSnFOTEtjeksrYXI2NEZyc0pzTHo4eXFoc2JKdDc2eWhNdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e83e19e-bf32-4a55-6468-08def3269c5f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 19:20:29.3161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiIoVu8XJiQ9d0u5Ct7kaF53tOH9gAwpZkxIPz2KAgB7w57JkOTNXFO00zeMA8qtNQMWBUk58t0/EuAFBb2WNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5770

On Tue, Jul 21, 2026 at 04:19:26PM +0200, Marco Crivellari wrote:
> Hi,
> 
> On Fri, May 22, 2026 at 1:30 AM Aaron Tomlin <atomlin@atomlin.com> wrote:
> > [...]
> >  static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
> >                 unsigned int this_cpu)
> >  {
> > @@ -3771,6 +3821,11 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
> >                         struct blk_mq_hw_ctx, cpuhp_online);
> >         int ret = 0;
> >
> > +       if (housekeeping_enabled(HK_TYPE_IO_QUEUE)) {
> > +               if (!blk_mq_hctx_can_offline_hk_cpu(hctx, cpu))
> > +                       return -EINVAL;
> > +       }
> > +
> >         if (!hctx->nr_ctx || blk_mq_hctx_has_online_cpu(hctx, cpu))
> >                 return 0;
> 
> I noticed the existing `if` returns 0, while the added code returns
> -EINVAL. I'm wondering if this will prevent the system from suspending
> because of the -EINVAL error.
> Should ` !cpuhp_tasks_frozen` be added to the if statement?
> 
> eg.
> 
> if (housekeeping_enabled(HK_TYPE_IO_QUEUE) && !cpuhp_tasks_frozen) {
>     if (!blk_mq_hctx_can_offline_hk_cpu(hctx, cpu))
>         return -EINVAL;
> }
> 
> Or maybe just handling this inside blk_mq_hctx_can_offline_hk_cpu()
> returning true.
> 
> Does it make sense?

Hi Marco,

Absolutely!

During system suspend/hibernation I/O is quiesced, and all CPUs are being
taken down for system sleep. Returning -EINVAL breaks system power
management. Offlining must be allowed to proceed.

Yes, we should test for cpuhp_tasks_frozen in
blk_mq_hctx_can_offline_hk_cpu().


Kind regards,
-- 
Aaron Tomlin
