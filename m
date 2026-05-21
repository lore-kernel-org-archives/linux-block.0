Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020085.outbound.protection.outlook.com [52.101.196.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7715E315D49;
	Thu, 21 May 2026 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329282; cv=fail; b=gOTErAC7jisHaXrWoqO6sOjysxMWRPvTNnTgaff4OtJdO0mTZRDirXZmrC1wo1wD/h8U3dC29rxqeSst294kFF3432T8gjiS+cSj5J7XRYIWEt4CYrjhnDk8ag79h2KAFOhlWO2V55CBu6oa4AF/uCMRuLHBkYPfzxJVwtTdmOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329282; c=relaxed/simple;
	bh=FRsCNZ3UHXdHRiqEjdNpIuCmmYEMT8alD654xJGKIbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=th9XCTNHGokTKZTfbmUWlia6Ns1NToA0wHGBZOsgGHQvQg3BvO9a+2EQz3zF+51Glrmxdav+VCfDXzafesq/Zw+PbCb2hblr8JhfASlpugYQOOwxBobk1eHLN12WU4ojlpTLgUxo3gfED/LbPVX03eGbXAzx44B+edNqWuo37Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaFhqle5T8IIqb/g4ZqAE4n67oK87Ec2B5VG2sR7MN5x4gxKvfCPEw7q2QxJgxVm8WsK3pzqw0kzBi2mr5ss6KV4T7swtVt01Q+f6Mq/TNsou7V4gedx0+IUsSKTCGmdtqI4dAk5rUDrzmC3TahkfTRvRyV6WLZKoBxoFbFNc5bueN1fiZwj7UlKLSYU1kjZGs70cxgCx5e+GWky7dUpNjc0KWPCIH6cAzfiZAcYsmagkYBw+CBwUHE5q9wbEIczTx3qN9YYVAHgiP4LgVc8qa3amOlLuk6K492sm7aldrvKw6iBGzK+4qD5qcPPEe0rlCvf2r9eVpO1lsyKiCeeOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XXNp1wpaLOn++dqEnsiUnX+vV3xhFmvT8I3pZWmPQ0=;
 b=E0OZrhxPhpvI6m4j3BvQiDzNugEf/zbC6mgQgN/VXZ7dAxrmKOhoKrgEZJgq5wtxKNx0X1cbF3NxBAF+y353eJ/GEt+P+AAqNk8PkPMxde9y2CQOjIOis87qHYfdvyIVqNHtkJTeaZyvDOLPB8+Gk8yVLJ3cKufeF7sY3LlrUYHGwZM1R3fgAhcAId6aNnsH1nIkYm2246MCzEstWp6eoa+bOUltW6XBQ3x3xmcw0iA7BCPtf4du2FkJtadm6ojIV/84AP8C2RQYt+DI77jkHo/BJhoMBannRMFneMt0r4L6TLyhSnzy++FjxZEbxJeSIFEwQmVzxJF333BMRw3xcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB6288.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 02:07:56 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Thu, 21 May 2026
 02:07:55 +0000
Date: Wed, 20 May 2026 22:07:47 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, bvanassche@acm.org, johannes.thumshirn@wdc.com, kch@nvidia.com, 
	dlemoal@kernel.org, ritesh.list@gmail.com, loberman@redhat.com, neelx@suse.com, 
	sean@ashe.io, mproche@gmail.com, chjohnst@gmail.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] blk-mq: introduce tag starvation observability
Message-ID: <t47wegcgfc43nimo4vqfdedqih43ydfietb7tsaobeitxgdhxs@6lnzvbj5rhab>
References: <20260517213614.350367-1-atomlin@atomlin.com>
 <189ddfd7-f579-4c86-bcfc-334cf574bdfc@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <189ddfd7-f579-4c86-bcfc-334cf574bdfc@kernel.dk>
X-ClientProxiedBy: BN9PR03CA0736.namprd03.prod.outlook.com
 (2603:10b6:408:110::21) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 94cc8dce-082f-43e4-1455-08deb6ddc2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fm+biMhXxeuuzJH49+tuiZgx2sD3LnRFxk8CcOm+JrjVQlRext/StG1Ex97z2jhQVcQhFKydsxvbFRjug6mQhEVy7DuAm66FoScJ4DJrwIz92oM4sEj0KPFax34lCxaX7a32JFPmzwEzAhpFL6uiq48+1Q9GKbZ20QfaKOlaBRTud8iYk+2pS3uHtYaiEejnovkMLPDB4xYh6PUWdDYkCi6iORN4ACvkcrht0/5GhR2e8+fmwJrOXqLI+mXPcaLzP+4W03Ni2OAWwsrsjzwEDpD9JHCfk1WryM0RLgqCW+qye6KUHlmEYUTG+CiFbzREa5UFl6g+Ap1H9tS6IWdHcqSu1aFphtwKIMQ+mrwbl8BmdvjNEryPLnV6qxdpjaOb8gv7BuDTwceVfXs5aCwRPjMyyzjHxSl9HaJwGpoQ6ACV1dA3PFhAXwjiOmEdk4bGhzDSiatlY45Bisa+aeYklt2p5EkLSa2vUxCEnW3rMA7Yg2d2l7oY6x/gWKMymC/J/2XF0gsL2IlZg8o8MyzFIewY93OEIgAngkRBTFa2KDbtWZqZYoukhgN7luPGDA2E6w7cXgV4qiULxqazEkBEQj6LUAuaSjFel9GLbtMCQpcGSAtDvX68FY1u14pdoSGi1GlcpGJ7BqttwpxmYuku19MpNsNoKznAdoINb3zUywykP8UjX3AvpIPkt7OkmUTr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(4143699003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3ljU1AwVzhyVUxaZ2xpbDVGbHo4SElqQXV4RFdMaU1UbFhiY2h5MFh0dkkz?=
 =?utf-8?B?NlhGTmllVHg0bFR3MFpXTWJudElnZnlBeDRZL0lDOTQvUjg0OWpUNlVjUGE1?=
 =?utf-8?B?WU8wRGJSaDdOZDVaRHVBQnpBb1ZMTy9ZK1lvTTBPTm44dmc3WUtXdy9pcFpj?=
 =?utf-8?B?dm0zam1nUXoraCt4UzdJTDJMdE9kVFlDdWd0NllOYXJBamp1QkJ0T2h3V2ZL?=
 =?utf-8?B?QVp2M1RXYnpzbk8rcjdNSUxXcWp6RWR2MlpObzQ4a0hJUEo0dmtDSTVQT3lK?=
 =?utf-8?B?ODd0TWE1RE5wazdsZ0taSndUc2xBYklqWlc3VU1udm5xLy8zS1c3YlYvV0V4?=
 =?utf-8?B?cHlIS1JRNHZrVDEwWWJvdlhHdFJFQkdMbUNZd05QSE5ISGR5eE5qWHVOWkQ5?=
 =?utf-8?B?RGV3RHExUTRxTmxpSmNRemFONzFnOEgwaDBwalpFV3B2RVBxYW8xWEJ0SlVD?=
 =?utf-8?B?c1RwRkZpQ29vZU1HZlBCdzEzbDJOQ2l6K3cxNlp6S25ySlpERmpERjNRRXh1?=
 =?utf-8?B?dW52bGIzelF6RjYvclhDRGtwSjkrTXpadHVrWlN6MGxOUzM3aDQ2V2lQdjkz?=
 =?utf-8?B?Q2RCLzZndGVCazF1TE5zWnh5SCt5Q0ljV2J3VUdWU3NKdDMrM1hvelZ3NllS?=
 =?utf-8?B?bG5ZM2VrOTczejZxdVRGUVBEdXhUQTA2a05za2d2ZzNLaVc0V2J4SC8zcXFP?=
 =?utf-8?B?UnYxYXQ0WS95WGJqazlQaFBuV2JmRkQwOGR5MWJlS0ZhcVY2QjZtVDM5UGtr?=
 =?utf-8?B?R2l0MVBESHJnYVZrb2ZDN1duQ3Y3YlNUR2FvNit5VHdRcm0xVWhlc2YwVFQw?=
 =?utf-8?B?NFoza3ppcjcxUlVBTzVqVzEySWFWalQwVjRPZ1FhQlNiNGgyRk5NTmtZVDFk?=
 =?utf-8?B?Y01xb2dmOFRhYWZ5VmlyRTRjOGRjMFk1d1hkdjhmd0FrVVNlQ1g0SWJCTE1w?=
 =?utf-8?B?VW56RERxbE81eXVzQjh0T1VFcDhkb2paeVVKamJPMC9LYTR0b3B0eWhkYktK?=
 =?utf-8?B?QzA3bzJhS2RhQmZhTlJHYXZjb1JER3VqZ2QwZy9iWThXcjVSVzJNamRocFFZ?=
 =?utf-8?B?Smp6cnkvb3cxTnUzSllwU1o1b09qT3o0NUFBUG9rVlJsdys3bEtyUTZCdGR5?=
 =?utf-8?B?d2pKZ3ZTVGJkOU94eVdPajZOYnAxQlhDM0Q4eWMrakNBMTc5Z2MrWXR3bjht?=
 =?utf-8?B?SWVSSUxIa1BEU0pPQnNEcWlhUjdscjJudXFSakpiSjFLd3N1Mno0UE54a3lk?=
 =?utf-8?B?bVI3b1RwZ3NmVG5hNHZ3TisyOGFyNWM2Uis1R04ya29sRFBSZUwxeFh5R3pR?=
 =?utf-8?B?NUszVGhLNGpTU1NXQk95cUcyT2wzTi9JaitBUkwyVmRhd3RuYjFYcHBEQTdB?=
 =?utf-8?B?clBlMFhFUHNPUzZxbDZ3NHRNNm9mczNzN0VxZGY4OGNNOHVTd2NrL1B0QmtY?=
 =?utf-8?B?WDROVzVwTFdaT0JKRUJSbTQ3QWtYOGg1Y0NRWkVrWXBrdWNxU3pIRDFBMVdz?=
 =?utf-8?B?MkF6Z0ZTM2FUYVRWUnNzcnBWZTRFKzl0NzBJTGMveXZtUkZzdzRXa3djcXJi?=
 =?utf-8?B?RFhTc094ZzJMVno3clNrd0o4VXNicVlwQis2NU9PMmlkRHJHYldYODRKQWlu?=
 =?utf-8?B?UUFKWko1REFiVEp2UmNVSjIzaWc5b1ZRUzlNRUFpbkxHUUpLVHBWYmJWcVMy?=
 =?utf-8?B?ZzR6SnVUaFJvaTJpZ2g2RnVkcm9kUG5wLzZQNlBqeHZ5Y0lkUGxUbmxiOEZH?=
 =?utf-8?B?NUJjL3ZvRnduYmxYSFlQNE9MK3FKdHNJNXJvZ2RhempZSDl3Q1FiWDVmLytM?=
 =?utf-8?B?TklJUS8zOXpSeHhXQVVteDVBWklJSEd0ZzRWdGtqSzRPcTNSVmRqc2Zydkgv?=
 =?utf-8?B?dTlkWXdrdFVQcGtFaCtzTXFUdW5PTFRtL3dLNTFSUFdrdW95UEk4Wkplbjdz?=
 =?utf-8?B?bVlTaHd0bnJXMmN4STdQWkErYU5DREhRczVZYk8vS2E1R2hIWVFkUGpBbWVX?=
 =?utf-8?B?MXRCQzZKM004Q2YxUkxWUy9TN2xHNDNtckhRU29kY3RacXRXVTBKb2FmRUpF?=
 =?utf-8?B?ZVJIME1EbVdIUHVwYXA5MEpLeFd4Nkk0K3NXRmtVT0tRczdkNDA1Nis2a2tI?=
 =?utf-8?B?cGJWSGl0OFZpc0F0dWJyTmxqTVVGTzhVcXZkVCtsd3o0cTB6amhWbWVQWGZF?=
 =?utf-8?B?L2p2T05iMTI1N3RjRFJtMDdmMnlQakF6RkNxUDBRNG1OV0lYajVYVGcvcHU2?=
 =?utf-8?B?bzhQMmxPQXJqZkdrTW5Ed0FMS3lPWktTbGludjdLSCtSUEFjd3Zwc1Y3VjNN?=
 =?utf-8?B?Zm1iNWYvQUZHUVNCVGRtMzloay9Ld0lwQmh1VXVuOGdadVNOUDVPdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cc8dce-082f-43e4-1455-08deb6ddc2b6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 02:07:55.2109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U78iZH1LCt3Ed9KVDoZR5fSfz+fHgypY0DY7PSTwfatVjHHSUTEc1vgjoPmLa/UcBnnZvuEZ2TZeM/VWTZPphQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB6288

On Mon, May 18, 2026 at 07:31:45AM -0600, Jens Axboe wrote:
> Why not just issue the trace points? Then there's close to zero
> overhead, rather than needing to need added counters for this, and the
> kernel to keep track. If you just issue the get/put tag kind of traces,
> then userspace can keep track. That's what blktrace has done for decades
> for things like inflight/queue depth accounting.
> 
> IOW, seems to me, this could be done with basically zero kernel
> additions outside of perhaps a trace point or two.

Hi Jens,

Thanks for taking a look.

You make a completely fair point.
I agree that pushing the accounting to userspace is the right approach,
especially given the proposed hard-coded tracepoint. For example, with
bpftrace(8):

# bpftrace -e 'tracepoint:block:block_rq_tag_wait { @tag_waits[cpu] = count(); }'
  Attaching 1 probe...
  ^C
  @tag_waits[4]: 12
  @tag_waits[12]: 87


I will drop Patch 2 from this series, in the next iteration.


Kind regards,
-- 
Aaron Tomlin
