Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B0486651
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327991; cv=fail; b=m3UKDyC8oLtM8pCkJ1fqeEvEWuyTisnLy7mrf/M+deFauJARcL9jUNHNrD8MFT4TcaYjUz5Vvikxu+wIsH/1Za986YF2ilda232VG/uWvcyxNCHUvOBFFeL2fiM3VL1KUVOKlw0oRQpbU7q1tM6jn3RkKWBzesyknueo5mpJHGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327991; c=relaxed/simple;
	bh=kz0LWdDDkaGph2stJWaZYQ8kpz+DiOp6PPRmvnsVgTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N+bLKJpWHswcJmGjY+jG7ewjwP8/aJ0JyGYgmBWpBbu2O/XpGEQHAC6Cg773C6NSKBarP+vj6ORcuJchI2ui/Y1aAcroNr5Nm3kElHm+RgQ09NjINIIIKpRoE7niQZrjhFLbKYOYa93lSTWsUzWEXTF7k8AwsQla9JPlhRX8mck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qiDoYN3g; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tcYq9vCT; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qiDoYN3g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tcYq9vCT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1785327989; x=1816863989;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kz0LWdDDkaGph2stJWaZYQ8kpz+DiOp6PPRmvnsVgTg=;
  b=qiDoYN3g5u0CFtr9r587V20P1+8Hv9jTFgdiSU45e4H6b7vHL79IYRhV
   jUKc7c+J110Kx/8ldN8ymb1gsz4ea3u9FendYe04wSe/8+KnNr/S/6rdo
   RbvOMfxOEDnSjyHZoiGZuOXepwj4r00cpPe4Nr3CmTdlM8kYwfWHvSv32
   XR2/Zv3KTr2rRpe8WqQKnTA1WeqYkkSm536L6xKIq+LaA06YvieudPGHX
   00Mw7iLNoZB5hWPBt3yMYcEWSuNN0zaYfj6XncfJXpNR4lfx74lQTtpwo
   dvw+jYv/vN22NzQ2frpxsgbI+3dzwEqwHi23t8d6Q4PjiZSIGVgwGhLPa
   A==;
X-CSE-ConnectionGUID: hq5XGm81Q5+KhiADccvGvw==
X-CSE-MsgGUID: YRGl3aMLQbSa8wJE9WaWuw==
X-IronPort-AV: E=Sophos;i="6.25,192,1779120000"; 
   d="scan'208";a="151741844"
Received: from mail-eastusazon11012007.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.7])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2026 20:26:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIrLdvE9bpKbbQJ+Evjxjqz5imfD+pwfTC8g4Tq/xxWbd8t6VcgVCFu+D1zhkX8BsfIV/RdbJf0ulutOmsCvyJmBnb3BLvXE13W5sJ1l08bXpbzMHLGJIgoG8gDbBEIyJAuscL3pvdDJm4T7Wpsq/aQ5xkZnvMS79pg95TJQNv5IZPbsqLaJzJ1ww805gnpPALiaGq6gjAAbrnyb0L/bJnDyo+9MCiQ4mnS5O+5PWxlBACDHUzoQ21XUStHV0KlnEt1Ry9vXPTSAikImu2QOiB6Gox1FBENuisB+gSH+KvwMLcis89JL32T5nG2WqRd/9j+l7VTPEdhJe23CfT2arQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIfv5VQHi3LaWPdXbOyGOAH7mvo/oWCxK57txKWe2iI=;
 b=fnJfUihXTUdBw44+3CCWLHRRthk6sHRBih+DA77Zsy2EL2SPyt2vsRHlxXbvtiBZVJiyG9HGycQtdBWX04R26hLWGpJw0o9spEs6SSn04iL9uPAAGwvUZo7aQC8f1BdnNU7AZry2rGveSV9gsvr/3r4+p0NWd+y7BP8URM29bH0CHa4rJspVjKQVji45eEz/7tiJ2ZyRL81Dv2NbefdaZHZAqoRJURNg5PvHlHDUbWZnQVdbNyfuWm9dPhEgId2yDWRri4BMd01EENUEax2UG/WfeathVimNRnf1dEe/ealX4A9aKPCzyQeIFgdyzvaaxM9Q89pj1ZCn1fwApnc+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIfv5VQHi3LaWPdXbOyGOAH7mvo/oWCxK57txKWe2iI=;
 b=tcYq9vCTQ8FJ9HCj9dB5UsFXn1v35x83C4x9JSQfUyfVUa0GAvS68QoF3ChZPKVwG0WZFkalPPW1sz6Fhqn9fRysxmYxBH6fGFgd6yxBaeIGl527y5STCFJI4DVpzytEDtF4+6whGPFZ42K7kDDzgmCRbrPttAO1DcuWSVScu7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by PH0PR04MB7462.namprd04.prod.outlook.com
 (2603:10b6:510:15::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 12:26:20 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 12:26:20 +0000
Date: Wed, 29 Jul 2026 21:26:14 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Neptune <z1281552865@gmail.com>, 0wnerD1ed <l7z@0b1t.tech>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: fix aligning of bounced dio read bios
Message-ID: <amnwHyJFp0XCXHEp@shinmob>
References: <20260716091306.316625-1-hch@lst.de>
 <20260716091306.316625-3-hch@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716091306.316625-3-hch@lst.de>
X-ClientProxiedBy: TY6PR01CA0024.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::8) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|PH0PR04MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: dc22739d-c8e3-43b3-7c42-08deed6c9863
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|23010399003|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZK+yu0YeN8hHfwUrkIsrMo/MVwX5qpEDamFh2HsG/RYQw/frtx1tUe1fCTr4rE0smGXp9+89z77tCNdo1eSXQW9BnnHRkpIFrelrjXgPF85lTjZyH496lFZDwanUEnp3NpfnUk1kYfeLjMn6IayViJhNhcHGU4lUHmLTrspehg2eZ6gGKR1X7E/ECiEsm9P/DQqRc++cFI5xegOpBWts4JRZIDxg/ozztDVN3J4mhjFBRyKm5dU8Sz5JoE4LGUZZqkafJ8H5gGDaPNzhU+vaHq4l0BMdmylaxqg7GyN/I8o7FML1jd1g4tVMUpbDsi8UtU91bTJWOTvxKkXTKna4PsFh2xvHfa9W7yB4SetwIXDn/KYnW5zb4V5j26+beAZgg4W6rHPoRohtXD3eHT8o686vDxCvoDLZVZz+vRH7jPmSgb4pEiT3rYKe8hNQwPd0LAnDCKXqha9Aha9cQwI2F+Y/0Ii0lw2yvXaFsefK2tbr7YybOplJ+j91DEZqmpuvHuH2ATwZXDo+u2fPlByR9vkbhISajMUhEeI5dfMZkkQi8kTxDfgci1ahCk15yvJwoxA46tnxOhKjRUVPIWdG6XBrFvjoJUTlXy2mcAWvKg/tFxAWoONyEmFst+9pyGRxjT9afD+DjiLoee8Zap4K5rHEwvvNqVLLMHijDNgJYFM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eNnXXdGEN0xL2t7BGH/r593cWP+FeBphPmclw+dAjSr9shHfUFW+OWnkmJGB?=
 =?us-ascii?Q?PqSHdO2goLegu7aMwsabZSjD8k/3wU65ChWt1FT/levN2rQ87WC0jTLrvEmj?=
 =?us-ascii?Q?Ypba/dop85P2lOUmZ2G7i34nANSI14+uoOO6ElHYGHxq8/VdCNxB8rhSo80V?=
 =?us-ascii?Q?rkasnb4sneoT3dfP/QibUxORhXYPyGS3TNAmrx0Z5aWjoc/cM9C++CgKmuQT?=
 =?us-ascii?Q?rGDeXMVw1P1N96fbc6grTKn83xNJx8xw+j/gXkRORotGaL77scMsI05ELg+0?=
 =?us-ascii?Q?0Rtr3q5H/HERun7R3f67xfNK8OQPB8ItSIRNfbAzlYl4cQvICFWi01dwpc7s?=
 =?us-ascii?Q?sazXO6Cr7EUkdJ1/8NOY5BaTlgCCyfvW0e5ZFSmOIZRQZBa6mTEhgq8jt/iW?=
 =?us-ascii?Q?CeLsbIqYAj34fkKNJzw+2/esnBic8y9e9hu5Jas9axTOdXRhqOKV0z8aatn4?=
 =?us-ascii?Q?L1/4lic+pJd4XQMaIBtSdv2oRXmosXV7nHcKO5SbEaVR6mw7YBfNg2FAtp9O?=
 =?us-ascii?Q?rfUWoYLoFTx0lHzZDAmMm35O5dda1ZglYHcvJwaFPaICxFpiPM+ROSTJzLXG?=
 =?us-ascii?Q?BmSLph/eOQoF3haDE7Lx9sX3d/02Are090tF3Z1RqY53Al/Q8xQLqccwpYav?=
 =?us-ascii?Q?EDCcOzwkXtHn668sJ7tBVR6foqzASDLlXZLeGx9rD4htffKjP8HtasVVyB6n?=
 =?us-ascii?Q?TalaIbCWQQrXcYmG1HireI3IMsTA8jRSwOW7P++4LdQnu+a83XR4TVyNeCAJ?=
 =?us-ascii?Q?xAGysJsCExtFuHCwgrJvsfwIPg3RMivpVzF0AQVlqRRz7ecOm/L5ITluRvjM?=
 =?us-ascii?Q?REwDUmb6CN9++vBRKZkSZkOXTZUdWeEGR8JUPDKwfb4aYQq0wYrSdy6owh+/?=
 =?us-ascii?Q?WOZjT4q6NmjMyPSkx0yHzU81kZzfeFob12Yt8kIGzpyCObn2LUl3CiQj/ti/?=
 =?us-ascii?Q?oJdNyfy91C+1/s0jVsjlDEXc+Qo8752YrAN3MZmHDfvjqJ3YSEdOGAcxCdNM?=
 =?us-ascii?Q?317/f8JsBbk1Pt1V2ZH3pfC5Fz/x/yzTR8wlBKLUyyVOJlKyCbxYiwMXwjFb?=
 =?us-ascii?Q?BwcXITX/gOxdNRsvY4wEeefS0Wp4DaWq5b1yzuCnExScc5YxsFRFS05swZo9?=
 =?us-ascii?Q?Soe5Kk8k8aPjJQGo0sETe24+XxFw/ixhmokTqzhYwdQoy4Ck/desaPjMfkZk?=
 =?us-ascii?Q?rSHuVxicu02xp5jKMjkTpBwjF8vg2s9341ck2uP2LHdBaHSbFSa0q9wDtF/V?=
 =?us-ascii?Q?G+pX/XyVK0rBybfH2vZ3X0vJEwtEnEdomzh5mvsxHPrls531MBuT7EQgl0es?=
 =?us-ascii?Q?74v/bZ+LcQMwQadi5tgGJDQtzmaD3Gr8UooDpqR8tZxnsO3hHGRPmdeZzXXv?=
 =?us-ascii?Q?ODAwv+slV2U9s3akZJwKiWjbnmg94NmfYHs3qS0Que0kbm8ECv1di8xfvJJT?=
 =?us-ascii?Q?XQv159Vmn9Uq8Jsc8OULfecwe/siQOx2J4/9yjOXyDboESP22+qP9AB2hIMO?=
 =?us-ascii?Q?qfjUO9QNxZnuc6YslMp3UjbOBXtb9CAzazHmkf9L1xDgInBB7dY3uGEH54Yl?=
 =?us-ascii?Q?yYSEYMLSmcHOueHS9d7Wr8KSIzCN3cvw8++7lZ0zlUFYxmN9nKEJ1VZ5jOUi?=
 =?us-ascii?Q?GFfE8Uw0YXJDkZOAFSbcoKPXmDrP4O3VZ+uzpS1AFHAG4H//kHlHp7ggEocr?=
 =?us-ascii?Q?02Hl/9u9fH+RXNesDr4he63IZLH7SJPvm46BEHainMb70jle64mqqP9cjp01?=
 =?us-ascii?Q?Gcl3kkUoPwoc6PcRoaBbNTE+4XBA9kU=3D?=
X-Exchange-RoutingPolicyChecked:
	IDlwzakYTqvYMFvdiWTBuOdp5HSoGfKvS61jb015qaUzwb3BPedPJJZGWSvuNCsrZs+8q3RO0JY8WwqFVL+dhmSMcI7KCibyQnwaVIqpmnvfDRUYzFUbJ8DoSF5yUAXNFzYML7h35xBe7WR5hIYFPdcMORa5TN5fmugGJC4mvg3GOtfLS4zMf2qDPwt3x0ZmIyCVM4bWm+/MrO6EqiVw4+r3f5PqKW/oQjSik9kIQ945r+Z5NQejJhtalkCsyeS+xmvC/pZ7aRVknDRwub1JZFuJ+pAlAl2CU4LZNIms9JvOkKSGBzVIAr+N0fWsC1mh3svsSzUrXTG4Q29vYBp26g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L7/OGefsvI6E+lOJ9pXuDEZBCHySvorOyspZPg21tqUyGjNvkS9HihdQsUvxiDm2cbIzD9cGroKKKnFmKh3nG6Qqk/rBLDnzoHaPtUR+hJS8eeQdxmjW4DFvWM6Mt3Fq+KVHoi8cVM2yqm1K6ZneDQMhL0sDPgr5oLA/bNwDXxCnq1PqMTEtnllvpW5CuXyPKQ+H9wHg+J1B4fs3TBlNI4AA5sChBQsjhGGyy0buicIPFWOXsR/E9kZC4KCrGtt7ZFlFC8Z42hcZ7Pwom8HBMsi5VJZUmgiulpxhSjBiSfAjOE4oIosSjTS0EJ848CMpUq9KqsQ1RNxaYXaG08qhBVNZmV17dBDVqP2hP3y8Dn6RkSjKnfnSut9MmPhb4bcBKjoNAOxt2sPEJ7W7H08jBKWVkKV4fxLoalGaiuVbWglbX21T5grbDo40Jz1bB8cfRPA2qQfxSkJWLITBD4LHs0JLlyx9mCbNftGbdEn64DMX+e4ulsmR0/ek6A9pqrNQ9+UghFYVvUg1GWTgZWMQKHmtPM6f/JGjR4aOW5R3dPdJQPQ7zx0vM5MapLHJBnqM04n70MKUKK7NmO/Wf6TKVGQD9wZVjeqrzFnv/QeWfeIiqqToVBk10/1Z1N7P3aUH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc22739d-c8e3-43b3-7c42-08deed6c9863
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:26:20.3105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoaomZNCr4Go5L5mNGcwZ4IJMTn8+XYmSC6qONen7dXQJ5XQ/1qMnrGT96LIBjZD2gOqgxlrJVvyVorKTML4Gnmsv0rLFnRGDOuiRF7sXk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7462

On Jul 16, 2026 / 11:12, Christoph Hellwig wrote:
> bio_iov_iter_align_down expects the "normal" biovec layout from vector 0,
> while bio_iov_iter_bounce_read abuses vector 0 for a bounce buffer
> allocation.  Pass an explicit bvec to bio_iov_iter_align_down to deal
> with this case to avoid a double unpin.
> 
> Additionally we need to free the folio if no bio_vec could be added,
> and adjust the size of the first bio_vec that contains the bounce buffer
> when the I/O size is aligned down.
> 
> Fixes: e7b8b3c5b2a6 ("block: align down bounces bios")
> Reported-by: 0wnerD1ed <l7z@0b1t.tech>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: 0wnerD1ed <l7z@0b1t.tech>
> Reviewed-by: Keith Busch <kbusch@kernel.org>

FYI, 0wnerDied created a GitHub Pull Request to add new blktests test cases as
the regression tests of this fix patch [*]. Now review is ongoing for the test
cases. If any one is interested in, feel free to chime in the review.

[*] https://github.com/linux-blktests/blktests/pull/251
