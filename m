Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4C39A076
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751401; cv=fail; b=SOfTEaklh3iRzI4bvW1DZpDbIW/H2oU/aOxiLbuQZL/pHKpbijIeT1Hqpzsnubd4W2kezclv6ro7DXwDKA8duYQno8kBFSfInrp0UulDFpFDrTRlI3o5lTVB9U7cSf5KiXGOj+VnOlFnmJDrEW8mM3jWm3W9PD6HCyMnxu+MwnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751401; c=relaxed/simple;
	bh=YB9Bxr9QqKukBxUj2NBgif19J11K7N/KanQBoXFXPbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t7YP4Xrna/AIZs/ySF544VVV5ooEk/qcJi+9xeSu1BAFCOBzDeO0HrgW3Gg3UTO27EIoRzTK4oQY07AU+uVtWL79BqQRO3m752awiZ/mfizU2C3gI4t8WKntzZIxujfEyrMyGLIqtWgKW71JwlpUc7xhi6InZA7IFCDWvqiy/D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iJCrn19V; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=NAcBs1a6; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iJCrn19V";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NAcBs1a6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778751400; x=1810287400;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YB9Bxr9QqKukBxUj2NBgif19J11K7N/KanQBoXFXPbs=;
  b=iJCrn19VD+c4FktyHvnfRAc4iBY5rfNnmmG2qns45NLwVcXpCiieVvTe
   OfEQMT9wAMXuG+Ij/gNzH94dbISPrXD8hKqIozkkktWhlrSewjaO0yxlM
   Ksc6oEqOiDzb4fQfN++4HQllA7rOSjSTfMVGX1u0LGVdXfdsAu4w/UBwa
   EGvnGVR8m1qzPqeeFhjSZETB+0Acnszj65hbA+Twwoz6BlSrLZyML8i7V
   5xmDluC8qXdzaioHIhNiUPiJlxgnDmz0LwYI2DUlOanLhzIp0lA+UlniP
   igZM9C61DyS/7hgzq/2tCeirlhSV4nHMQx5fPVHXtrbnThUTz4u1mVUFD
   Q==;
X-CSE-ConnectionGUID: LAcPT/A7RjiAzqsYTJzNjg==
X-CSE-MsgGUID: apJxNW9cTQqVMRXZRYCzsA==
X-IronPort-AV: E=Sophos;i="6.23,234,1770566400"; 
   d="scan'208";a="146935520"
Received: from mail-westcentralusazon11013068.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.68])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2026 17:36:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCmZ5HsjpSg5dVt4bkballHskuWeLTyyKtl8F+lnxoTJo7IlLIe5yerkYyZBEnjuYSKhTmNaqt0X8smigQEO4GmlPquJfdpuNDjkeyY0wf4PqUtMcl/Q+XoUnSyrSot1K/vLCx07mwFwhuwZnHmuDt15F1xen8tGYPxWXLIOWxIvJ1/vFV4t1o0FILlzOCDzrB5dbD+jMaYUGSJmls467VkDcnQJdwn7D2uEvjku4yjoNnc8+KkEvJqNCOpgyxzTg8yPBP7TunpAxQk153H7Sv7X5KEMz5UfrVvLnNqkDzNj2+0FO35LOFDoYe2F4VmxkxKbZrtGqMXWCNqJmdOmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AQidFXwBg+Ednu5N7+pw48+SqgS19x/hwFF5gykYUQ=;
 b=Di4G8vbVsQAMolSA130bgwEX1rS+eUv/BEAqd9JzcG1FoAXYFzNkaLTk54B1wtNsFfzy2DO3urwt20EWMBbBTRoU6cabirlCpgXs+FkD8S2MqJp4vG82LwRK+o62VOPzokRh9EkJciHkvUslXqY5SMBtnnDyPOKvWRdC3oLfplhM+/aNzin8GxWXQCu1NRb1lvVexJUus2HfT498JWQpOdJm2Lr3jTkng0SArQdYfs0JmoUxbZxTujZH5J3y/iN4zlzlx2Yew8VTM2HtUfGTXinFqFN3WyJzzOSu4CC1u3Sbw1YHPr78PsNCxUQE9GmKrl5qshMemub6O2mp0KbHnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AQidFXwBg+Ednu5N7+pw48+SqgS19x/hwFF5gykYUQ=;
 b=NAcBs1a6Rot/G0flAW6bdv0yO8DSQOPxzYYYWV3yCZNgJBdcfTWn9rBf6iSY269gV5OwQZvR8Xt1/K1GcEb6HmxSYcNCoo4iyVYa1e6clscNuRo7D6lbnGW3Z5Wwox+ASI+Nn3uReTC+0TFxSpxPdE6DgJGaJQnEIuidt+Vo8k0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from PH8PR04MB10005.namprd04.prod.outlook.com
 (2603:10b6:510:3b2::24) by MN2PR04MB6718.namprd04.prod.outlook.com
 (2603:10b6:208:1e2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 09:36:37 +0000
Received: from PH8PR04MB10005.namprd04.prod.outlook.com
 ([fe80::1f70:77:cbfa:e80f]) by PH8PR04MB10005.namprd04.prod.outlook.com
 ([fe80::1f70:77:cbfa:e80f%4]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 09:36:37 +0000
Date: Thu, 14 May 2026 18:36:31 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>, 
	John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH blktests 1/3] check: add --cmd-trace option
Message-ID: <agWWgSBS2v0sSlUl@shinmob>
References: <20260513112326.584256-1-shinichiro.kawasaki@wdc.com>
 <20260513112326.584256-2-shinichiro.kawasaki@wdc.com>
 <10bc69b1-762f-40a1-94b0-9ce6580b17e1@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10bc69b1-762f-40a1-94b0-9ce6580b17e1@acm.org>
X-ClientProxiedBy: TYCP286CA0056.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::17) To PH8PR04MB10005.namprd04.prod.outlook.com
 (2603:10b6:510:3b2::24)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR04MB10005:EE_|MN2PR04MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: e0252087-1920-4674-a57d-08deb19c4b5c
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|18002099003|56012099003|22082099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	MlydjkynD8JFq1PB8zZPN2v0FGFQZ4Payk6gDvAXzzcusK0HSoRa2BDBCMIm/zVxnxU8rLrjPbwg/SMrLGFdWSbVW6weLMvex0U8X+WFMrSp+5pYDV9+FINxJ/Fez0mxjKOC4pJePo/6eq/meENfQm0P5U8/oUAqMEtfmHBElWKxJ1eHlxaR6XkZ+n9LWyrXI1ddR2B4ZLYZy0lG9Wnuxm6QAg00n3AMYsLkMh/iPbkBmm3XoxdcZk3y3kUwvDJ69FbRJ/+CdHQlQQQtKkdb5nyewxxsq22Z4PgZpK62j0v9lYMjmvhVVldULxqlCoQ687qvWilhDhcT5KoYcEMfrdN4qAP393bZUDHHpHMo21znCgB610IpRwzrfqyA8ehMs4vmfsltxkt+MtIoevWrzEokgi6uaI1TxHGQMfnGAvj7lgVFy8VjxQVXMOAXJNK3qYbSNHSPNTlE6H6pmdyZ3qbuBa3NzhAYxQmJ+jnNgcDX8RGWIDvphjQIxu6EdWtoNrNYHXCSBt7YoV0h7Y7ygHr3yOUdLfA91BsQh8fGDdP19B1xVRKSS8WUgQ6hktH+5aUSOBluOS+2oZSP7fwxSi0gNp806VmpuAwemqhRyMJbKODrFD+ZOIvj0xKLtu3L811+AyHxSGanjD8hcV9HY04EVVbOaRpEROe0e7yto3u9e6vqZbpc/APVbS15HJju
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR04MB10005.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(18002099003)(56012099003)(22082099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H3/tAraNoGyYVhRyjimZP/t9UJopy+gmF4tibE73//bxYMPWr7gfSEjNTc+I?=
 =?us-ascii?Q?I6vWHx5k/9TM0J+yEi+k8RNP7PNPy0Hx3e6IR8H7OaRQVQh86AzL9DV6yweY?=
 =?us-ascii?Q?T80GozCbcTBfOEMWwaw4eXYovrOFoeepuWrc8k15HAjbfKjs/S1WStTSvUff?=
 =?us-ascii?Q?9tQVmraWKFm0qf5o6fiGAw5jeowfqF8laXMvdvxc0pcycYD8M5JElSt4ca3j?=
 =?us-ascii?Q?lx8PpeEhMSi4fMFyq1JMr5gt//PCMvNooZYd6QLU8rOzaXhisf/SR9iWFtH0?=
 =?us-ascii?Q?28m3Y7XO82QFv9ZtCewGqBjvcuty7aXwna+IqsLpRH/fAc4QukV0x0ZXxsga?=
 =?us-ascii?Q?ewayKhzzSZ081Z14XXitj5j3CE8rAKf0i8HyGYIFb0JKcVuyXBjSdB3j1ioF?=
 =?us-ascii?Q?sWvgh6w76YcjrYihaWEtzrrPR/1AsoF9CDeoI52NmzvttSU6sEagw8t0V/DI?=
 =?us-ascii?Q?umZITn30DJaeL/2xSJSlZx8X8j9xbqMpBxStmmuVCH1L1ea/G9Axox/Ae8Hr?=
 =?us-ascii?Q?KMmD28+Z7ayZhGqv5H4pvbKITgbKEfzBevkGwpiUNEE9u5CfgZWT6UqAwi9B?=
 =?us-ascii?Q?PQMiQ3JFOJyttmRI3t/YGDTCU2qODlJbPq6+iUKFgZ/kFwGXwvBnPRKtZq88?=
 =?us-ascii?Q?x0iDKxXQ6qe81cOPv7h1PxTWC0vAhT+hQzuI0g1SewfNFLm9ngfq38TevVSw?=
 =?us-ascii?Q?P5QS3WV0RAdiWan6KfIFUUgVjWcaB8ZKBUaeOyVeJkQLucEivit027vVUw6T?=
 =?us-ascii?Q?ZtGeLgQcycn1ddIOY2BHSZXd98/vMP3H6JwRpfI4kch9lHNKuXFLT2veLv5K?=
 =?us-ascii?Q?KCOolFIz73csij21Tg9fOHloG8goakDRyHMTS75h/7VQBkilAyAH8fimvGp3?=
 =?us-ascii?Q?kXW04upwci8H7GIwWvgHRDduc2Eranu5BBMq+ezu7z7P0ox5O7vEDethLScX?=
 =?us-ascii?Q?P8iYl1+Tsklj02cepCRkGz19Vqf+XYPLiGrgJNewdDuww0ruU0cyZVsk2tlL?=
 =?us-ascii?Q?DkvwMeCUcNf3zYQa2gpLFHAlaCn2bIcMjbTzECsxOgEhZuyf0kaRlbK5nPhc?=
 =?us-ascii?Q?boKj5U8TfmxuZaHOifVrjbZqx1stSgwwMOI9efyOhrJl0hlwjb7iVz0+ZPOl?=
 =?us-ascii?Q?3gfTqh6VMIoYGMo6lLRGuIHHE4zWh3hIaoW/HDnNHUVi1Cb1Xv0i2YPW1Hyk?=
 =?us-ascii?Q?8w/Shd1WY1n388brjzXeBJcCEuXH+DQox9jwpDT6OvZ86QUl+uMXVIFdycsC?=
 =?us-ascii?Q?0Rj4cCyBf88Q5vWEiCfxLyszJtzjd0bQcgeKD4k26gOmTVa9NJLEaWfubFqh?=
 =?us-ascii?Q?RgXWGBqGtl6cyaRi5t0Y5fDkptQGWAhkui7hqrUVTknrWXef53CM3ABYjPmw?=
 =?us-ascii?Q?XP5zULJBcTD6CkfiVnE5RWBZXKJ97E/ZEBJq87MfH7CiOpQJ+vREOvY1958n?=
 =?us-ascii?Q?HMnxeClnRnK/RZ9kmuMWQDeWbf6OMEMMsSR54op8D+gIdaI0LPMZDIdn4blA?=
 =?us-ascii?Q?ZEgOKXtPj4oEO6ZypFL7I/uGCp1iwJ+cdanykdH7vwGanbE8a/WJ9U1ngtJC?=
 =?us-ascii?Q?BQVb3RibKxL9LOJ8eUGk0HV/aiyExL8imSmZHb/1KspTQPk8hLyc9thihJEU?=
 =?us-ascii?Q?m2KJhSY8FobNqRx4uH7qPoZZv/xQggXpt9SQYiMKOhC3QE3pCxhPRKRZ0VKA?=
 =?us-ascii?Q?Vuw18hvuQvet1yStNh1/qpPjGzLBLQ6Y519aC5CBORtcLXiSDwUoL5B/HtjV?=
 =?us-ascii?Q?/g7PVAO3oGgAdc6TIg1JAGBVfhiksT0=3D?=
X-Exchange-RoutingPolicyChecked:
	UFUkiPUG3F68W8rSSCvBdxwFVu9fOPt6i0K6DZMCxG9qLPjiBaJI8ERyVG2ezGZuidAYfl1W1wmqxw+J4DWnmnLvQ0LoCnufxmSq+VWuDm5eIs+/sbFlUXPQQvlDZEYAC77+LkvM+qQakz6+nTNdTUCKusKaS4BG561tbeYDNtpZzeUO0Xpkj0TBJIZqUeMnTX8ocogbaolfMTkFn8A/Qe2eWcOQTOaCYhkRDAgKlV4ySnq6/8m3sp9Bt5jtgj7mK33AqL6NgjRq7XPB78bEN6wYLOAfK91vPphaudnA028HC2mnaXAT5XYCN/bdOD8V01/kghJBQzOkxljisITDvA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X/j55IrID9nU2KBkF3BKEuPRdRVZlDO9sRqzDu8pLZZ4X4qy6mY2kEqC98qXOwRyFlsLN2Kq/g8bFsL+zttLWGvoHHScxDwt9o2sh5vpszEWK6AxdyQ+oJnkvx9ljcFeDgzqcZ7F/8Zrk1rZFGo+YbUqnIL8XPp9jN3KlAz8vYIhyhUiZhz+K8pm2nkN2IpjPIVowdBn6s2Y/qpqlzspvuCY9Ybrk/BP05H0ASZgU80ZH1nvrtNchZCH+R7Z3rpfKRWccFKR2sdUQFZs2PghVm+3J72N9w6Wx7/cqWpqd+9lMfiHea21dUdrh6lawcSgzdA9GQoLPGTyEYLBfBPo8fqzLXNpYZA3ehWkftY7aR6CfEe0B0Egh2iXgeo++gjA9tVwhe0BPIshSNFfAsz7AogAlrHR1vAAMGubmzFIMjV3CqPIuob+RcXswD4znSvZ+s/R2XIyJpUNqFwhD9cBLfLrRvL+wNtBG0WjzzJQQle5h8us4lKpm5ZAJNj6a4LAxQwAbc4PtSO2yTGFbabVdBTLa21SYh/9AlcgjbwIqd9vMTf/1F4syY88f1pmS7l5I0BZXN8ZID8YN2midsHGZ4W2zMvQB3So8tKScAdNUZ945jdEzae5wN5Uqc5kh8ga
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0252087-1920-4674-a57d-08deb19c4b5c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR04MB10005.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:36:37.1217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qezi+tRWA5qsgTF9oMJCPf9K70sD7BWJtG5HWtNFRJQpZOY8JSdE8qIJbh89lMSojLseSMWjRQWuiTOf/YogE0iUVmrmQFmDn8An+OxVyPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6718

On May 13, 2026 / 10:08, Bart Van Assche wrote:
> On 5/13/26 4:23 AM, Shin'ichiro Kawasaki wrote:
> > diff --git a/check b/check
> > index c166fae..a68049b 100755
> > --- a/check
> > +++ b/check
> > @@ -458,7 +458,17 @@ _call_test() {
> >   		TIMEFORMAT="%Rs"
> >   		pushd . >/dev/null || return
> > +		if ((CMD_TRACE)); then
> > +			exec 8>"${seqres}.cmdtrace"
> > +			export BASH_XTRACEFD=8
> > +			set -x
> > +		fi
> 
> Hmm ... my experience is that set -x breaks most tests.

I ran whole blktests in my test environment with this series and the --cmd-trace
option, and observed no new failure. If the bash xtrace feature does not work in
any environment, I would like to understand the condition.

