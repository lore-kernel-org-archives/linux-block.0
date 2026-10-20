Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792492808;
	b=VNRuNNad2kuxXI9xvGxax67igdkpEwyiiGwYd46bo4HtBcx/BSZ/TNlq1n9EH+/NGnrR
	 J4pl9/OUcxHVAxku16oluP+9Uyu8DpX685lDwzc3EZSbu4z/Jok9nY7z7N7H5UPY8Fxs5
	 Hf56Jn9saN3SuBE1MTxWaYOT0988PZZHd1LqD4PJnSPiQRXWOVJB3cE93i38lCOhZSVTv
	 sa844mSJMuRUsvzRSbipIDUrMTuZWTD8SI7431CJ1INCRcfp596FPuSH44HOCxorg4MLC
	 JJf3VzF/h/r9Q5sE4OEWEWRHrBnY/uJJEfYTO+btCNWlSbmYDpl4/5XjmAlsbIRkhmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492808;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Y+wwOF0TZCiCY+GDhQ0u7c9R8UM6sKr7EinCNaJIIn0=;
	b=YH/ofpWIIq/v/SCc+H0vyX5ty0y+N9LVSoo/729UPi7TR7XZnKEVlSK9kY7vmTVrF4bJ
	 lxcqsbfkybtfGnYAX9QPqrYLuBmY8yaNKrb1Gqu1VmtkiGnx4dcpm2Jx9Vt3wahMHkwjK
	 jVHJtUGYseyYKjtQ+fOOIgyWENgsBgbclxpq4n6rdn9Oa3ycbhh8hOA+Gcm1mkLm3f3qP
	 aTjQKeobrgXgyp0lPz1k+JKU8bsc9dROULtPUfrYgRQ6XhseZnjsBoBSbIHbT9iiKlHg7
	 yNeR45UQTeT6hJkad+pxNui4Szj4qXmpbs7Tdka5AWQgEQxfJj+PowhS0f+nfwb3doA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=RVRx+dXQ;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=e5cwiCRG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D411606A319
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 10:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D411606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=RVRx+dXQ;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=e5cwiCRG
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792492808; x=1824028808;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pcwAhETsClKpshqsr4iIu6t1W3RIChql3cCUmGC6zlE=;
  b=RVRx+dXQRiLyAzknizRM+6vyfZfLAQCleysq5z9jAAy2zRKLlyL9LvdM
   /Yw7XZPUg7uetujtFHnyGizzXC4cd13xWNZElBapgOOFB/9rtHWmnCzxf
   oVKQKg0Ad2nKupQItOU/Cw/Bd6+HZui8bXmiijG7w+dHOBACQmcKdmpjN
   xNoRvV5OazBWbIZH+BIbfkUJE+CcnJoQe+TfKZu4rVdU8nfykUAcfo6Mi
   +DV0wUqtVfl1hD9JsJGQ1R+I7gjRhohIrfZzc47i1oMIn8VqsDuQSRknk
   dA2t915xLZcg7YCyJzQmvKfFMDcX/IQA6d+UAlmnK2ykcDsCZidkAz24F
   g==;
X-CSE-ConnectionGUID: L+nf/xiRS3qIkIy568WWDQ==
X-CSE-MsgGUID: IesGb1FsRsuUIPdRqj1d8w==
X-IronPort-AV: E=Sophos;i="6.27,168,1786982400"; 
   d="scan'208";a="157580611"
Received: from mail-westcentralusazon11010071.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.71])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2026 18:40:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqmUE0UaZVnurl5iFiISn9roYByK2+nc6Kb6DTon+MSPvK++DvOP/K5FY6RkEYIVnumidB7WG10q/mg5M8raiWrreyqmGp4nbG+byXIxYyb8BpazMaP788EfWeGVVzmzgOPlpe2gepbtvsWqhvl8iqUiZYSrrF/uQECJ7y7CgjCBiHBxlEarv0Aj5OzYRtFRfSZklpqoejOUcmR0LCLD2pAkFEROZk3pA/7PU9Q1bJU92a1+JjfK7u/rLH0ocM04Mn11NusGXKYQClCZ5C8G8CXHP7v2GEH4SUP5cN8X8qiwtZSL6l1/WUnCqhO+1wLGEaqroGddJ+UopZoZgbs5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+wwOF0TZCiCY+GDhQ0u7c9R8UM6sKr7EinCNaJIIn0=;
 b=uFFx0u8QjSXy4kKdulehB9M1pMx2PpAMAE2tmsGQsP8jJP639Tfrl3SZArwyB5yOtAmzBdy+1UZkkYnfQphiqcFZTSE+bUPSd4jSvhyTCIizJyU3YBVnpwjEVsb86VsmZyiD8kx80JBnA6Og39U9yqNWprdHHfTgIjtGgGnvh7WGw4Ss8RusXpelAts7lVXo8H2AM/Scq3ElRaF/mhJqLggdXuRYcnNOVl/sfSol6J54JNYzFYAfVoFFRztYhhUtktCh15eqXnv3rlGP0vjKIq4rfysw/AZ/Y5K6tM465RhXvy8HE1kv3+WFm8d5N0ZR21ykKR9rZw7GtNKoHUiweA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+wwOF0TZCiCY+GDhQ0u7c9R8UM6sKr7EinCNaJIIn0=;
 b=e5cwiCRGPD+hvx0sDuuapH6FxtPdWvTzVdOa6oJ6W324GEbFIOvbbhgAu+32L/VtG/G4bSRWuXKHmeBdhc5rIyFVd/kjFehutz6rGMcU51Xg1H2YM7SnM5Mm/J4Ocb5yHsDpZQMNF5w+pkPReESXsZ47T/GHuxMxMb5pwopwYyI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA2PR04MB7513.namprd04.prod.outlook.com
 (2603:10b6:806:147::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:38:16 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 10:38:16 +0000
Date: Tue, 20 Oct 2026 19:38:10 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 3/4] nvme/072: test nvmet zone report
 initialization and length
Message-ID: <atdEJT_j9ciVuAiY@shinmob>
References: <20261014170046.2516-1-parri.andrea@gmail.com>
 <20261014170046.2516-4-parri.andrea@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014170046.2516-4-parri.andrea@gmail.com>
X-ClientProxiedBy: TYCP286CA0321.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::14) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA2PR04MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c42f00b-112d-4fed-2653-08df2e964007
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|23010399003|1800799024|261009223027099003|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	lGTTGvNaokzubZKraue8VUuUB2bv4/LRGcLv8KYfiFIYFAIlexT2xzOnIMXTn7FyASWINUNIhC5WX1eKQ3DcNaQ0wytPZblxVnTkf0t7ric0HpD1+F52s4AWi9sCFPVV9ToLi3voE0PN4o5dWlRT07UZ7YxwlaoyY5ZoKvissEbZ9wKNtsclMJtGeGkrrEFcvEYbAbGhJPckbTfm0+IOngzajGC/ooAa7PdW0OF282XMrncPMBU7tMRh1jX7LiWgltAIbq4phbwf59ZpzOwR96KY3urfNMAU2/UVCrwAiOxWAHa3jJZZ2HTJp5POfciuE7drCgHC0bU5y+D2Cu2PrGdXi6LJP52JtaxdLaY9vQWe48M6AWZTzsTdvUXRiJ049RwvX+q68qncbZY5sOZAP0f1aKG5+tXry4JGgWAV7Ag6le1n2Rvz2bxeDDNNK8nsprn9BGgVAJZxnjZw7lPO+R9g4McO81nwhbTD9ht/Z5EMA4KG0k2fxscUvGhhGYzBvPaWpGozZ3XV4HzETYhHV8/dp0/OlJLElaIg5AbkSOA5nHtWU7poUXMKW7aNZ6gGbt+v/RrUzEmMWF0NjxYrUg9hl5S7GJTm7MiZAd4ijCbhn3w4HcgfmtBfx6Nr1E7Aq5CV+J5xTSQ9WM9QYidVmcRDs72nw1yXvgLzl4UiNYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i1Aei+WNliVUpKPqpo4MWIuE1rb8ZHDpSgKalhhoujd0j1PfBp4dD7IzU7ru?=
 =?us-ascii?Q?LD2OUpt9hO8vlwpcF9BlNiCHbEVisVlvHmiDQU4HA1W2AIAt/ghZ2d7shWqq?=
 =?us-ascii?Q?DIjkJEeg1oFPyfiLOeqfmR42QPisd7vU1sbo1VAMjx6JKM8G977ANGmTe6T1?=
 =?us-ascii?Q?9q1H+83c8hQSvNYfZjCwIyr3EP4ATB/ktiY6KKqDzJ9MXM+90dCtOhajkPoU?=
 =?us-ascii?Q?9IV5P3osA7lD7CPg1QWwavkd6EaVsz9fbEdgVNwYWJ38k2DTQc2iV9hQgra2?=
 =?us-ascii?Q?aHnwqwudSSYJqI2Mk4n8A2qY5TvZLascz1LGBVGLh+sZ6EbmGYbRvOKxC6Su?=
 =?us-ascii?Q?7p8OThjCR+dGw31H//oEQ0lL5sxTWfXSBeVJ4Cuq7kcd5yMd1gTfWQ+ZHOkp?=
 =?us-ascii?Q?BvSzFyis2DVzunfQ5yshceLAgm1h+vsD0AbOLhfWjSpr60WQO3lWXYdQ7Bm6?=
 =?us-ascii?Q?dA8ho/IPmSReMYqmCpxGJskAkwPmkYFZ+kmah4YSXazOqvcGGMikEeZUhcko?=
 =?us-ascii?Q?jHPftM8FBF7CXaUsj4V04EGESc8LtKUHlNeA+ob4oc2LKyrjehN4QAIC++pr?=
 =?us-ascii?Q?Ix32MCgN4xBnz6PPfGwxyjfAdswPk7D8KVubodYxIpKoAOeQyRpKnuXEkh48?=
 =?us-ascii?Q?THmJOmPm2kALwFZExvva0pjrI4X8Oa1r9MYEvxiOiG4ud3Mm4N5DcG4rPb8a?=
 =?us-ascii?Q?0dXVVYTBqvNOwG4YlVa+izpiG19i+opY5+cSnO4Z5GqFW0V4e9OCSeuLQh5c?=
 =?us-ascii?Q?gHZ7asFeW0kwLf9mjf86KykEsTZvwe6cyOvOvDdqTEk5E1G+Fng9ZB8fLY3a?=
 =?us-ascii?Q?r+CdiiuQHmiZGTrNbfcxPtLTlCKNTNUs5j7I9bVFKI9xxdqy4vUgshYFCOxm?=
 =?us-ascii?Q?v9O6mwPhSyfRaiWz6Vh6qd91XrFOzveOrDflqLpYwN05Ahm3Mb2S352+lbni?=
 =?us-ascii?Q?7P3EJSKjq1v1FxA4X5nc8mbG2BXUej3B1rLSdTLj2WkM7RYYIFmjng3uELbk?=
 =?us-ascii?Q?1MuRnyJOoc3F3ucdc/Go1JBVc059a1hn34/or7NJ/X+oXI1EpvhWKLRRAMCV?=
 =?us-ascii?Q?NA4NP0jsHxi6WGXtFMldn6L/u7tUKBo5OQylDBt061Kpcsg6WMnv+3wOfOdC?=
 =?us-ascii?Q?WXt/FOexFuqV+D5WqaVO9HM+QTaVmgYC1tzcmrRu0BRlVN3uq3Ku/W2GSi9H?=
 =?us-ascii?Q?2UfSEcZck6G4/mQwFDZ2p35TkeVJKZNkS2/7zX8tn+J4XYb3H2y41gtXmKNY?=
 =?us-ascii?Q?EYWd/rqoAB+gGbv19cBmuyHj9+oli7pjZUt8+5pMyv7qAymsF7ThBneheKZt?=
 =?us-ascii?Q?q+2LQy4ttRN7Je/7wOOyJnemhFokrT7FFhCoxd7CjbPhrGlsttA5zFJAWT/M?=
 =?us-ascii?Q?XLJ2bZmprfiZPAEE0CqKsugIy6NDPdOG771htq/eS0cOK4MkRSL4oHZpQfeE?=
 =?us-ascii?Q?Fd730KrO5b60jM7UbqOu8GimZ+ZqA0ysBjfou4nnaWuTWP+qixir5yrrE+g6?=
 =?us-ascii?Q?dkf1D0pAz21f2jTIAEmE4bfegjuaAFgnnQ8jPsSt9a4ltkvzmPQtE1VXUAaO?=
 =?us-ascii?Q?FX6OOrjhg/ymJLuO2KKlExRtaWohhirzgm9EatCZDG3ijt6sd8eVik4haqzh?=
 =?us-ascii?Q?HYg7Z5BdZNG8fDrLJQj0i7FL7b0N6n3CmbhifQLhwOaENXv35Q6uzYheO3Rx?=
 =?us-ascii?Q?mdgpmiN1OjNJBwTAwGfVdX8fYFkAXRgJSv9WSyKH07caK/EnRbixipZDe8pi?=
 =?us-ascii?Q?xbMN9CDbbJry14J6TmRW0uVfQqtMmOk=3D?=
X-Exchange-RoutingPolicyChecked:
	CudEaU0nnI/lzIhETV1a+HM2wXhoaNDr/u+Wqp2Dm+UMto7Ct0WBjhfQbeFOKvSQAjfxkbP/De+n7TlvCxfErdBBGAyD7RoG8U+raA6pU75O4Y+VhROZkSrqsckw6sHe7MLznyoRFFl2fhZtx8xKtHghhrPvRjeh13I/FKXVUJgm4KE5WfVqAE03CLbcVlUrT/BdcaPcv9FNGDAnyNWOr1TcE2T2r2WBXakAevZ1W35+ulAk5WB5E2vkQZo2tWN+iG3qBa4gsWrwjJRC51UQs0YnKqQeBHsuOHGNo86sLyLzbgT1CF1CBkhK52j9ohn4aA2xPSnv1lwzc2UiPKESjA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vi9FNAySwy4rJBZppwPoToMufn3kkJPjgD/htHYYgovPDV6/VOKqdn6GbhGRrYv9xXt/McFxRu0QtW7NY5/eWOaavb5Y4YyM0qKIVKzuWrMSaBD6QioG4YtnAsHo+4QA0Rlnumwp6TPKBFKKsyy8VUWhAqYozr4bdsl/1t0LftK7Ku5IOwkrDQin07xNRWjPjYrwvg3O8BXoY9koWcMyln/o4WspKEunQpLxtQD11G0q9Mem+uHjQM6GsytYkURWK3hwZctHZ0knuswFUyS8QEbleOMZCeXGCAzt5VoRmOU2JLrnDQeHyEA0SIjF6ahjqT0IjbCETbcbx9M7tm2lELy3mgaALtblNRQtBubYGGZ+hA3Qp6t+CwaGLwHCD7LqPjxigZhhvu3IrTAgXhcHaqkDNfxES5PPRdhEl6WNVgQlH3NhLxxw2YE36gMTnWo8Ti3IErYhK9BkzN+ZQemWuUF9H6ESdWpZFdPiL8aZoCvAQBrSaeseT3EtzUthGNUE0mKiJ3wqOrezLYc0j0Sj8RRUEisS5+ZwfxYJILUqP+iF3v8CMupuffXFmHGTruhzfdaC27OG35NJGpEHSr01Ynmz12G4TNZ1RWSMdHKMGCDiE6Uky/8eavwFFy2MZeEt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c42f00b-112d-4fed-2653-08df2e964007
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:38:16.5988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBrB3/8AwkydYo7x443fIQTLoL2TMMY5Xrglt+p+bJU8P6g9d0f9OFdXAMjzB/q95VF65PfSjFAJmiBLEQI/HaeBZ1dCIJI62cKrp20eSoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7513

On Oct 14, 2026 / 19:00, Andrea Parri wrote:
> Export a zoned null_blk device through the NVMe target and verify that
> Zone Management Receive zeroes reserved and unused report bytes and
> rejects a transfer length inconsistent with NUMD. The test runs on every
> configured transport, with RDMA restricted to 4 KiB page kernels so that
> the preparatory write exceeds the default inline-data limit. Add a small
> passthrough helper because nvme-cli does not expose the reserved report
> bytes.
> 
> The test fails on the unpatched kernel and passes with the fix applied.
> 
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

[...]

> diff --git a/tests/nvme/072 b/tests/nvme/072
> new file mode 100755
> index 0000000000000..c7bcf93ab4d20
> --- /dev/null
> +++ b/tests/nvme/072
> @@ -0,0 +1,68 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Andrea Parri
> +#
> +# Check that NVMe target zone reports are fully initialized and that their
> +# transfer length matches NUMD.
> +#
> +# Regression test for patch "nvmet: zns: don't leak stale memory in zone
> +# management receive".
> +
> +. tests/nvme/rc
> +. common/null_blk
> +
> +DESCRIPTION="check NVMe target zone report initialization and length"
> +QUICK=1
> +
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_require_kernel_nvme_target
> +	_have_module null_blk

I suggest to call _have_null_blk instead of the line above. It will allow
built-in null_blk module.

> +	_have_kernel_options BLK_DEV_ZONED
> +	_have_src_program nvme-zone-report
> +
> +	# RDMA defaults to PAGE_SIZE bytes of inline data. The helper's
> +	# 8 KiB preparatory write must exceed that limit.
> +	if [[ "$nvme_trtype" == "rdma" ]]; then
> +		_page_size_equals 4096
> +	fi
> +}
> +
> +set_conditions() {
> +	_set_nvme_trtype "$@"
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	local block_size dev last_sector ret sectors slba zone_sectors
> +
> +	_setup_nvmet
> +	_register_test_cleanup _cleanup_nvmet_zoned_target
> +	if ! _nvmet_zoned_target_setup; then
> +		return 1
> +	fi
> +	dev="/dev/$(_find_nvme_ns "$def_subsys_uuid")"
> +
> +	sectors=$(cat /sys/block/nullb0/size)
> +	zone_sectors=$(cat /sys/block/nullb0/queue/chunk_sectors)
> +	block_size=$(cat /sys/block/nullb0/queue/logical_block_size)

Again, I suggest s/nullb0/nullb1/

> +	last_sector=$(((sectors - 1) / zone_sectors * zone_sectors))
> +	slba=$((last_sector * 512 / block_size))
> +
> +	src/nvme-zone-report "$dev" "$slba" >>"$FULL" 2>&1
> +	ret=$?
> +	case $ret in
> +	0) ;;
> +	1) echo "zone report contained stale data" ;;
> +	*) echo "zone report checker failed" ;;
> +	esac
> +
> +	_check_zone_report "$dev" 4096 1023 0
> +	_check_zone_report "$dev" 8192 1023 15
> +
> +	_nvmet_zoned_target_cleanup
> +
> +	echo "Test complete"
> +}
