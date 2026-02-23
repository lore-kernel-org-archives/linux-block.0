Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33504CA6F;
	Mon, 23 Feb 2026 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855910; cv=fail; b=ceBsIcT+I+YyErtiU92fAVF2UfNGU+CipOgj+Ayt0gAsWRcJtYCna9uIaDm1Wx8VdLbnxf2JvZMlGkyZJRGHhIMjtUNmHdddMRTZpc5GO42GFnbTdeaZLUhpEf4zlhBU8o2dITaVvwt/tFIYPaN/cQbtvcxJHB0/imbVPZRQP/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855910; c=relaxed/simple;
	bh=w/l4pTQetH401g41INg9eEt4O5TzW7kVY48NkVfCbBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OSL2DbrmMEukQkBZIJDcUo6fe7/X3fadpKBqDTRIZSu1+88ep51TYtBhLbYXV6G/+uqItWxgFZgXmrqnJVVRyHRU7IAHwWHI3ZIpaZuOVPdFGqF/VqJOoaB6fHqEpPzBb0UWO2UNA5JBLSvdUNCmZV9Itx0xw1pcLTihjAVi7Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bSSXykpx; arc=fail smtp.client-ip=52.101.62.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bSSXykpx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ty0OI3G6DUjBSaz6kbSVgUF3Qc42EX2LUiOyf60qxO9jtqfsCfoAQgKFU0647l8vFvjJ2EoYqylrL7Z0oxPS/Xz4wBYrstytVVbPg1sn5ONj2x1b3Ti1h+SIU1ys/yZp4EgW+MRBO3hlKtGDcVpBZTo79CnrVlhqS9LpLwr9wRXxThfyZo0dq524S0nglTSrDV37kX25C0n7rUCL9fBUaohYbh7UcBxXpaWMmzd4yKywPMnOGNJF4V60aLlCX02TNxrl0a1jMmtje0/D2guxMq1aqYyvvrKF1ePDN6M1dG7KyHKQ0lO6nV7sv2acZy8V5ViPppXXqMa60gfO1Jo34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTwQzlnpq/zTwQB97DcMCwiRxN8ipfAw5vO4cN2TRqE=;
 b=ExoY8bXief3uf1d8JbQkgTa1HfqpjrQp04XGMIjwJIOEhAKfcRtuEK/GF4vjlYSHabyfwHt5azl2zok+HXXUNlpo87vYAikQy6RLqt30zBM0nO2CnKYa6CxGBFNSQe0ojo6GTyGnBing/s4pNNYyDgqKeq7E5k7TiBFVHjQVTs5aG+Kv+DTDgHUDFyJg8FSCw+h4txw9JFlnKPJvxQk2ifYc6LX+uCEXBgmd49cqJiHOVGd/97zW77CrNmjT7C4HbRjzfj2G84hyh20L+QddAeNt/f8Gn480W5+XbrXtXclGJOLDlIuVI6/3K+CIrZL4Fq9WQTsYcwElHtrYUIN8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTwQzlnpq/zTwQB97DcMCwiRxN8ipfAw5vO4cN2TRqE=;
 b=bSSXykpxecfeN2TqPPFtDv3tKr5YaUd2XAI7Vn48giVRFKIQRCZ6+4dD/UZKxPrrBK1sKuHsrahpifSd6WglCCLp92LGoMFhFIFn/OnzBXGy2KE9cavU/zBa2u/D0Kgi4M343qr/9UpyaD5ivE0cqkViomwixQJTtkfnn5qpJIAs4sD72QWDb343fv64kohMQo2pQaNs8wTb6FZUWyCT0pieEWyg7aZTPKnOKKirxVqxsk4bMOfIaQ3DPylTykCnkABfJ4rd3BvNzkUnxWDLlhh6l8hU3Dp5PcTXofwXcXnBLm2pZSt/zA6wU8N5t+KLiyrwLvcSvHlPGnw9iS7R7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV9PR12MB9781.namprd12.prod.outlook.com (2603:10b6:408:2f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 14:11:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 14:11:44 +0000
From: Zi Yan <ziy@nvidia.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org,
 linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Eric Sandeen <sandeen@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?utf-8?b?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Carlos Llamas <cmllamas@google.com>,
 Alice Ryhl <aliceryhl@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Gao Xiang <xiang@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>,
 Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>
Subject: Re: [PATCH v1 00/11] Zero page->private when freeing pages
Date: Mon, 23 Feb 2026 09:11:40 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <8C6A82B9-F8DC-4CE6-8CA2-80E625A37419@nvidia.com>
In-Reply-To: <aZxeLmNyKKTrkSzn@infradead.org>
References: <20260223032641.1859381-1-ziy@nvidia.com>
 <aZxaIEFZr2NvO2eQ@infradead.org>
 <F1307EF8-7054-4135-B61A-62141A113394@nvidia.com>
 <aZxeLmNyKKTrkSzn@infradead.org>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:208:d4::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV9PR12MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f5fc11-0686-4ff3-4b35-08de72e57957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lXb5cPaLPk35xtZSznQND0lIiyPqHYOs9CE3R7cDrIgY8MUaTyMlNIavyWEQ?=
 =?us-ascii?Q?a1q1j2KOsq1j2wmkjtSvYmzMekGWp2jByyDwLXul+0kSxqubOvjN17V+DQsS?=
 =?us-ascii?Q?qRDa5hdypUrwi9w5qeLp9rCf9YiPgTt8kXylHfTocQvRnC+I3D6r4s/s7R6Y?=
 =?us-ascii?Q?HnQNAj0NmrhkZbBF3TmfqHEjVQC1wN4FcYqYOQWq2OFfI9tz6ar6Z8bnnpV/?=
 =?us-ascii?Q?vd9zB9C3CvMMj2BOSUtOfQcZyX5c7RvGrgpanENd+iW6ZdRQ/DqA0Q7Vo/op?=
 =?us-ascii?Q?5sRUJwO7ZN4wPFsz6gjSTrwf02GkFM/EUMKKdCnljfYkdoEN9VRkuCivSCW7?=
 =?us-ascii?Q?HXxh0uulq2+IUr93D/EdpDVvJ5W8BvrD0zz0NTKoZNz6HxTjos3WLXJnfOX2?=
 =?us-ascii?Q?Jbt3EfrAol5ZAapvu64sISmujgE0tOfyRDp2/9Sr6YQLj3koy2AMd3rs2TuP?=
 =?us-ascii?Q?EKiba0fPO30O5DLWXhVw18k8222ExkVV8bFKPRagtz60DV5l2JJffh59IYcd?=
 =?us-ascii?Q?BZ938mHacll6L7eunTTg6UWdzRNWC1XqCyXt2tH9fuhVasw/ySdljIrdBSV7?=
 =?us-ascii?Q?l6CFW8J6ZxwwcNihwd/N0Zd4sV6jxBGQOOn41o29QapR8Jm1fGfKyUoGbLRN?=
 =?us-ascii?Q?f/cJGHh0IYYM7oUszmNLBYPlVywRoqbvtXSIFeYbcnF9k+BQRCGE17ccxLIH?=
 =?us-ascii?Q?gXjZh/NO1v6J7IYqqgqt2PXrRLhxL68LOcUPr+RySUhgskNp324xPLNfdFTQ?=
 =?us-ascii?Q?8IAgnNTzhoD77SmgfACgREWv/ZPPSFk28sy9wo0sUA8cJ8SpLJWS8cWpXW9N?=
 =?us-ascii?Q?Nec9KVWJZznkVeRShhGaKw1tDw4L5P+5yDfnFNA5AH0Tw2bn9A6ewht3k0tb?=
 =?us-ascii?Q?dlcWr6nxc3aVlkGnJBpSQUsujVSXtDdPTLXJOWw1eu/1EZv7k7QVAhSndVRE?=
 =?us-ascii?Q?dmPs6cNnhEmoA3ck9IjG+n7wfIu4uZ+d4lJEOqP7t87+ixYvyT0lbYpzcBbM?=
 =?us-ascii?Q?YIGd6rwUeP93sNpfJSpVb5VyQ1gBz0UhE/ByhizV/KuIf6siNQtYFEVMZxjn?=
 =?us-ascii?Q?j/EhKC4K/RiRqubgeQUCgbWoX403J9LXv1czM9S/1pmkoi7laed6+rnQEuFR?=
 =?us-ascii?Q?C1s6KYmYaZUZ3RUDci1K9izmpkos0+F8b59QMnVCDJwO98gYv7h3ztnDYdQQ?=
 =?us-ascii?Q?68lO7PO9sZVnuJRacfL/MOhmg97uJjKL7iXj670OAleq7X6uCrrNjD3yiUqd?=
 =?us-ascii?Q?DTqHm+0C35BOOhhcl8Dv5ZnWUS6XMb02pMyTfYULZmSXCZ7HTr2eF3DR8u25?=
 =?us-ascii?Q?FUPNjMF3LioJir9k3KP/3x+G8dvPeCv45O1zLFZgL7YEsK7Mwkgf+tWtsL5c?=
 =?us-ascii?Q?bcb0TA+UG7W4mxePIr3jyCTcSFHIq3o1iHob+C+w0iC1n/Vmqj567gqw0PCg?=
 =?us-ascii?Q?tWV1xDj2QuLtQzaerboNuUI4QVhFWkJmCcnF7mTVmlAjclOJb0hLfFq0f9Br?=
 =?us-ascii?Q?dng+rHmLFjTn9QEw3AhfbGSzoK8Icqu7pciktBwUW2tavOvQ8EshcJ/HCXW2?=
 =?us-ascii?Q?2CD0v6xvDPmNoBQpnjA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c+xlTiN+92mh/QAHN4HhSsq01IaE/Q9NzpDwf2AdCVL+V+E1F+8eOlrNXnX3?=
 =?us-ascii?Q?aU/S4JuQadi1qsD5LR2aEr+u8WBsR+BDELC9xWlZuKMVbUxw9GvzYdg2k8tE?=
 =?us-ascii?Q?yFPVMoe525m2K3yiO44KuZmVLYk5P2seiJgGsqO0G4D1Yvsn4vykTQ3mLKq7?=
 =?us-ascii?Q?BJ3JCpDxTn6qG9PXZeWV6KO1659M3cBUHblQyASVuc7PHw8tFUE0auXWhu9T?=
 =?us-ascii?Q?rEsICGKXjYjix883GrXeze7ZgxnxdgZsryteeOuGZXQms9EpFs2Xlz5nEXz5?=
 =?us-ascii?Q?oSl57c+KpHOEKxt44oMk0l/E5EGMzSJjbhCpziHyJ60cgpJea6wS/RTtkjcM?=
 =?us-ascii?Q?0TdyTdvZQQA9Vgz4iTme2US6Zk62k3kk2CoTGY5ulKNLA1FYdQT4ALgH7cVg?=
 =?us-ascii?Q?bkMG1D+qYSFaJ1FOIIAsAUh1Tpwk2zXhSEhbZALtwtvuM4uc774VcYn26khu?=
 =?us-ascii?Q?YjrUmpkIvBgvJ5syir/GBZynW5klej26xw6J4+Dl1fjqWiXx8CY/+NOtJ3Yc?=
 =?us-ascii?Q?/jNOLoWVs5gB4R6aLaMtWqe7iA/Jc+z83BEQMix2/RdNL1D4XBquh2lUDVbl?=
 =?us-ascii?Q?gYdQso6ca354kvQuYKAfLVcO5SuPQ7uoW2NfSc1395LZ0MImF7vWmp6mXRNS?=
 =?us-ascii?Q?GSAlvRC6qRmOnIrSyuvzE9HoGdiRW+7B/fZYHJbbTEaGc/XAtM/UwP6Fh1e3?=
 =?us-ascii?Q?4fdMogd/O5hO8GHP43GdaFf8xA8vqxw0QB2xIwz3mxpb+1CAVPFpBm4Ddy6X?=
 =?us-ascii?Q?Gqb/MFI6mhQkg/iEu04fsh9pUv4PMxKRfTx+r2kwvL+xDd6tmULDcNQ8M+qQ?=
 =?us-ascii?Q?ZQEio9w2zQv4DO+QPfHg+GjzFD13vmUpSH47Hp31fOPOxFPuBeSjYF3hkc/P?=
 =?us-ascii?Q?mYHi0tAP05KPQffaGiqEvDUsmgjc7o81oNWQhpSsagDYGgXu4Q9YOQWfLiA6?=
 =?us-ascii?Q?wcLSXhFWI/JjlVg66AbOFoUtuw8omCtGuu9cYBxY1UsMXccinvVCea66ArHt?=
 =?us-ascii?Q?OU/FGGC9VC5zgexREfqXxj9hbezE2YFrs1OgZUASP/KLbzpZAiiQuHA0F82m?=
 =?us-ascii?Q?tnw1XmEu2O2Io2+DAp2GsTL9W22SCqPEBsgEk263vHEMPpfPLMtoD20NJJ4q?=
 =?us-ascii?Q?qwo5xNYC0PPNaRM3f6PKSonVvXMn2vsnh5fQabYqFtimqkbcwRNyro/mUzmm?=
 =?us-ascii?Q?i/4IShAtgHnqkff38MdHpm2NOgIgo7MPCWxrUW3T0ap+NGQr5NG5AJW2YwrO?=
 =?us-ascii?Q?G2EXwxS0u4KVU6wz9rUlcJQZO1KafD0qaTVM+TM0TipaLbjdLos8FmIlcEZU?=
 =?us-ascii?Q?k/t36bwsuJ3QVKYJlCDUCR8E57RY4urRjMhXnb8vUy8gnW3iLynm4x2BsnHu?=
 =?us-ascii?Q?sQSurz7yT5L4+UKkSqGCBhIR5vwTxkkS7bpC+XfeletxLYv+4fejfL/9GuBg?=
 =?us-ascii?Q?WTWGG4irNeNR9WuwUck8idmt88CSoXnm0jI/qDUvkb3sOpBPpUPslV+T34lc?=
 =?us-ascii?Q?gpQpG9CIQAJ3npYlsGbt+E6cENGozNGvSHTGVJF4I7sZ2166GdhvNIvMNdTd?=
 =?us-ascii?Q?nJWPqK0Mxg//OPGsd5UOfDp4mlM4XtD6y8AjaENyCVu+7txU6zAShwR+bid9?=
 =?us-ascii?Q?dCMi9xNWPUf0lBAYFSMtBrO3iPNEhhYzDHimY7EB5NqBilzqxHj6NHM+ldiG?=
 =?us-ascii?Q?TwMBkVLbdy9lal5UTwzDVe7w8YfaElqSg/PKf0lLAGhyYn13?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f5fc11-0686-4ff3-4b35-08de72e57957
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 14:11:44.3730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNKjWNy33+yuKhmxLlVEK7Lb+cny6cPeD34dq4PstU3F94yN8NRcLb7wZZpVGEnA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9781

On 23 Feb 2026, at 9:03, Christoph Hellwig wrote:

> On Mon, Feb 23, 2026 at 09:00:57AM -0500, Zi Yan wrote:
>>> awkward interface.  Don't do that.
>>
>> Page allocator hands the user a zero ->private. I think it is reasonable
>> to require the user to return a zero ->private. Restoring things back
>> to their original states is a common standard, isn't it? And most of
>> users do that.
>
> No other relevant interface requires private data pointers, as that would
> be silly and cause tons of bugs.

filesystems use ->private and zero it before freeing a page. Can you provide a concrete
example showing that requirement will cause bugs or make other functions hard to
implement? With good examples, we can document them and make sure MM handle them
properly (i.e., zeroing ->private for them).

--
Best Regards,
Yan, Zi
