Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D282FFFA5;
	Sun, 19 Jul 2026 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784463966; cv=fail; b=m81OhVxMkqtACe2MyD9WH26gkMc0bw2k38Alt1p7UaF0PywHsPiZNBtPKYJT/o5o+lwPGwu8hoKDWNdTXW02PtsE0mAjyD3UQadGqWwnb4AX7fOVoKKBCUrixEtuWXMJhm6SyJQNvlk6hM/6NwV7I+EtVCBrLd09p/OqgTZzAHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784463966; c=relaxed/simple;
	bh=vq6M3EM7GvcAFRKf0W6cQ4Kf+1wlCTZrP6gK+KZxtzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ErRauS0BXOzHzs84uwCvZbRClFwbq9QCpe3lu4HZR/Aks+j0dTMzSLaQoSlM1NYIOOEH0lbRjg66kxAtq34w0AqINY7f2+DB3tAvoqU5I9slb4r45W0Cecvsy440eVNYBe+Z3W6O5guKr6QZcb9tIaLSy4utJOpWbfrrXJRtTw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=CCWqeo7W; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="CCWqeo7W"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JCP2vE1723172;
	Sun, 19 Jul 2026 05:25:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=z9eZJ1o/MWDs5DI2x1z+8mByCiuYziJwSdtIvgau9QI=; b=
	CCWqeo7WQ43eIE9fxX/1yrlvaFS2WsW63eL0PYfBecgLncVFsZzVSlU12qfyfPIs
	O4pTJK32LydUdNL2SK3MZ0RMLpLF/nK+SWDwOEURnHDc7npEHM3PpUttG4XE9Jp5
	TTa9Tv+Qq3N1qs1pq4aNYbJHlEDiY9QUqqUuT3YnjokUKzWG3LGXk8Yq3k7X9cOR
	VVfnSkmFW+LfHZRR2d6eMDRJ9qh9BcBxishQtnT5zecpMnOtZYxsOL61n0H1HBlc
	0a+ANy+jNG3Izd2EoRp3fRL8GT7j8Z1wJ1rZ8ac+iEtdd0mG3/AZG7o737DqoJqr
	zpuzsR/1PaOggAPOlcqqeA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fg90crshw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 05:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPUE4wqeyF84mu+VCWudenO/SoL642ix4gbLP2/hDtix97GrlwwzMu5yI4OvjtezHqneXlAHy6vbpIGx2VPV506BzH3FnwzCjoKYXSEpjMpiVTlG2jaccm7HnB4y5NN3kloG8e0Iipw/Sinvf2rjSZ36V6VHtMJLlOLfpT8Iz0lypHv8/6xtf/r1B6oirVQtsL5LOxoDX4K4ztFd7+27DSqeA28RpXfx0oDR7Zd744zBxwD4K3xXmCzAWJ8kw6tJ6X+6ycuC4/AfzQTtK5cTg4SW8lpy4NS8YD4cx3w5L4Hg6xGROcaB2rbTnbiUYs0djluaLX3GCPaBlb6tgtaqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9eZJ1o/MWDs5DI2x1z+8mByCiuYziJwSdtIvgau9QI=;
 b=OV/QYbr3FscuIlu7QVm0494e0Jc3xqy5vTmiObpaCqQ/pKbnV82K2Bugmlt2PbP2H5cWeAzaOh5ozEYtT946WDnnEaFlbaMHN1ZmS36TfbWEbLd+Yg90CDowh15AdcdwRcWhMBQKdmYonXH8I/R+rgjOFdMYTKwN88tHVvjJt9pgdJM/ztnW1QXeNb1pcdf1KJj2kJ5pAeCiTu9zgKrH3yUFcJCDSEgWGH956aaaAdHwd39So+T5sSzn2KGDr1lGNTdiBB9i7QnZXBnitOTzPhlQNjEEQgoOi2q8ftZDWn7uNZ0lGgRkhLT0iW5K5NdpTuItvMgw1XHggYnAsaiHqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by DS0PR11MB8688.namprd11.prod.outlook.com (2603:10b6:8:1a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sun, 19 Jul
 2026 12:25:49 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0223.015; Sun, 19 Jul 2026
 12:25:49 +0000
Message-ID: <f2e5e5b4-ed03-44a7-8e4f-0cbeafa53ad3@windriver.com>
Date: Sun, 19 Jul 2026 20:25:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: fix circular lock dependency in nbd_reconnect_socket
To: josef@toxicpanda.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yun.zhou@windriver.com
References: <20260629060336.1654834-1-yun.zhou@windriver.com>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260629060336.1654834-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|DS0PR11MB8688:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab09ce6-514f-43ad-64f9-08dee590dd8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	keJ7ZJ2FZ3r0FmSpgJSBL3cy99zAccb+7AgxWuv0b4yLtOxjNhT4Z3K/qRGUU/uoTqwWm7h+nxzPaKmSLRC6F6g5j2rW6ympuugIb+m7V80mDuM6agdGs8jKJwGdVzfrXoywV+Hh7Vv5loU1iVEvLwm9JCrZ5fE+UbYeA8pLsV1ykESR1NWzP9A052nf/zLH5wQCE6GYZNBkdmucOmg+UQgTsX74RIZohZ34rNq+v8Ag0JWryKhhWgc/3bO9Hh+Lx1IZixzrB8js9rJppoVSAHBsZV3HxYcZ8Nz+1z6TSfdaQSP+SotvPhLvuRnImLWiZTSrknvH3FZklCRPyeXYtjw7KuV8BgQ7g6hHbAjbTRywMaH2SlNA1lNdV1g+2AkQUhZR0I7zwAkVE43g2650Nod7VRPa7/vHu634O4X0XOG3jeZONC11MqO4XOdfD6ADNUxZajctOPMsynO7R8bbJ5l+Tp+Xi3ZLKITsamhtm4PiyW5PnHPMZ9hoZpdpJVh1GQjES24sgiuKy5I0dnjDaSWCvJCybWkM05GDatqnzICZFC6ZkZPCbr2PPJd2sqPYQShIUd5yEcr0LPZXcT7GtYmBiaPtLo/urxHwiNTbgfmPw0y+jecZuuGi9nZV9Q6e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU11NCswMVZVQkRzSXZmeWFFNFYxK0tDaXJKcnVJWHRVZDNBaTgzOEh5bDR4?=
 =?utf-8?B?MWZ1YStuU0t1SkJTd3MzZ1ZiUFRIcGtJZktxWUpJR1pQM1hpMHh3bTVHdmx1?=
 =?utf-8?B?RlpuZUsxR3Jpd3E1R0JlUTJSWGY0TkpjVzBzVjNXcDBOcWlQU1hCalB2UCtu?=
 =?utf-8?B?NmpLN29QcG0yZVUzYkVXbGFCUUtkMEF2SGlxRFYvdzZpcXliYlpncFVGTm5Q?=
 =?utf-8?B?NmNGNWd1OFRuQlNYalR2ZmZYamY5MWpSQUxXR2hEaGdzY3l0Y2FYQ0QxVTRF?=
 =?utf-8?B?eVNuTy85b0JhT1RoTElWd3hQUlRib3pQcHQrZEJsK3FzUThQQW9ZcnFIeWYr?=
 =?utf-8?B?LzBFYzh5Z2syc0pjSmxmVkpsUEkzN0hHMy84SjJ4Zis0WHNETlA5dmxITVJn?=
 =?utf-8?B?dFRIdXRYekRZN3FFRlJ1ZWQ4Z0ZLak9MNDJScGMwZ1gvRWhKRlVvK2Y1Nkda?=
 =?utf-8?B?eitGUTJQbXVwcE84d2NLdW1kQ2tWMndMRzJSdHU4UXRxUjk2ZHowOG8zbzJJ?=
 =?utf-8?B?NnF1cXFmQTRGaFl0clVsWDRBME0zdGcxQndGdzBGNXNCTzUrQ010MEhxL09j?=
 =?utf-8?B?cEJqWjZxUGNwYmRoeTlwa2d5VkxSY1BTc3l5WFZ0SjlLWHFaV0hjZ3gzNkdl?=
 =?utf-8?B?Q0ZCNnMzeDJ0dnp1MWlFdUhkWmtkUjV1dmEvL1VnZm1jUUoxNFBjeElHSjBY?=
 =?utf-8?B?ZUF5RFJITm5FNW9hYTY2T1pTTHFpZytDcjRaTG1DN2M4V2RVcGJtbGRVWFZR?=
 =?utf-8?B?ckFneWZqSlpoeXhzbkRrWlNJeUlUS256ZEdtT0NjUmg1S0RXVjFhNXZzWEYv?=
 =?utf-8?B?eStlQStPM2dMVmVSUm5aR051c0hTdnprSU9PNUtYcFdtTXBhVUxzVytNREJH?=
 =?utf-8?B?VHJJbWFjdXI4bklnZk5wZjVjN1NXWnBvWVZuSDJtZUxTU1JKeFMzb2dYUXZj?=
 =?utf-8?B?ZnZTM1ZYdVFSUVpUU0w3NnpvZlY3YkNUZHlDdGJZcmdUS0F3cndYTUZXTFpw?=
 =?utf-8?B?VGdHbmUzYU9jV3lPbXRrZENVcjhFY0ljMlJUWFprOC9pdGlUMjd1K1hHQXEw?=
 =?utf-8?B?c0FNQzlhaEVOTVVFOVpkbW4wUDNQcko0QjZVbVlGbnRoUXVNdnA3NGFnQjZR?=
 =?utf-8?B?ci8vUzBGdGhWUjBmb09BZmtaWjVpTW8wckxqdVltTnNHUUhQWW1ySEpScUls?=
 =?utf-8?B?NGhnVGFyMEVRZXhzYzhTcjNYV1dPZVhSOUpQcnJoR2JPVFJBQjMzaVlOSVFT?=
 =?utf-8?B?VWQ4U3VoSkowc2swWW9DRkdLcWhGSlpLRkZlejJmcDB2M1FVbXlFYnMvYWs4?=
 =?utf-8?B?NEVVVVJ0bEltQ1k3RUN3bkZBTlhiYjVudnkxbkNQK2NNTGlISmNyNFlQMXJN?=
 =?utf-8?B?MlpQRWNSaGJBZDBWeHNYeFdaWFdvcFZ4dTlQZVNCb2pnL3dySUFLZXBNUVYw?=
 =?utf-8?B?Uys3KzFkc3BPb1lCb3RUbjNoTDREdVJLOGxPWkVMR1g0VlEwMTluWUdZdC9X?=
 =?utf-8?B?bHdNbHE4bThBRFFVcDZnTzcxUElpY1JlQi9WSkJ5b1FLTXFYU3BEZXoyQUIw?=
 =?utf-8?B?cEsxYm1iOEJKZFgxZEhPdmIzdzhKLzZCUW9YaFpvSVdhS1Z4ZUtaSjBldGo1?=
 =?utf-8?B?S0kxSHNWSjZ0OHo2Zk1xTlRDa3BDYTRSZ2FVSjZVU0ovamZOeFArNzZ3L1VS?=
 =?utf-8?B?emEwRXBxdXliRHZSTXd6U2FVN0liTmlZNHJKWUd2emViUUlTckl2aFFsWWpk?=
 =?utf-8?B?TDFYR1Zhbk1iOEViaytucmNZOVlBU1hrVU9IT0ZzWk9HOUhmbktxVTdKQmJ5?=
 =?utf-8?B?R05VUlgyRkhGQjZkbmZ5Y3dwT2QzcTVxR2NQS21MandJT2RqSDY0UjlVeFZn?=
 =?utf-8?B?WCthZWJUVEtxa3A5Vm92YW1wTmlwN0JRemVmRDUwSk9UZWpidWZzQUY1VTJV?=
 =?utf-8?B?T2hEMzJGdFNwTExHT1Y0YVgvMUxrcnBtYThudlFvRnRwNTFiUGViQ2dBTFNN?=
 =?utf-8?B?Mk1yZWhHQVdNeWc4cU55L0YxUThDdi9PY0gwMWRuVnJGWTMwanNZOEIxOEIr?=
 =?utf-8?B?dTFiU3I3dk9NV0oxUEI0MGE3Ymh1SUd1SnRsQTkzalJiZnVjVU9EZnpsOWRF?=
 =?utf-8?B?YXlPMWhRbENnSXVadG5rOVpRMnMrMklxcmNLZjhxNjdmWUpFU08rR1pYRUFm?=
 =?utf-8?B?MmQvQW9xakZScDhTWDlYYjk3K2dTQ1pWMkxJMXAzQ0djakFxL29ybi9FT1Jr?=
 =?utf-8?B?NmRJZDhla2xVUVpLd0lDUHB2VjlReVN2NnI3RGdKampuMEFtcURkNGl3QW1o?=
 =?utf-8?B?OHdTVlMwTU55ZVdCZDRiVXBvejhYKzlJWjNJb1hjL1V4NkRZbEg1dz09?=
X-Exchange-RoutingPolicyChecked:
	QkCAfeeytokUGIdZIcSzxaL5KF4ue3vVbqPFV8/spZjPsHkIWBCRS6nlFIVQMyyKtnDQytPdT/V8UJiWldQ6clC/Mgzfy5qw5Yr1EZ9cd/Fqyf3gVwf+6+0t7HiME1Sq6TzmMYaiOZvF69oHkutrTHLcheuIAFyFKymNFOUGzm5OsmNTPT8auG3wFQ5cq5pgyX8LVG4P8U7SG/enpPo6V29eqhI4anHjG/WFURwvQTi/XoG+7xj0PTJNXPZeuoVrPmChWOjjnxIQ2HV4UTuQRtOomu6e67G16eLHrklW/+kAXaNohYImxQnP/i6gEbAXcERG6jb5I6usCuLEpC+otg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab09ce6-514f-43ad-64f9-08dee590dd8d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 12:25:49.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4donFzF3TRZl188pRzTd14F6dfvjdkSe8fmnBTXLjboUNOmJvUiIo8SNQgtQgV2A2xwijedStu4odksAqBqxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8688
X-Proofpoint-ORIG-GUID: fR2dpU0INZLwjd5Fhg9_-DNucd8e0V60
X-Proofpoint-GUID: fR2dpU0INZLwjd5Fhg9_-DNucd8e0V60
X-Authority-Analysis: v=2.4 cv=AOkSgtoa c=1 sm=1 tr=0 ts=6a5cc250 cx=c_pps
 a=jknTlamspUmmG4HRyne6iw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=-sJUIYb0PGG2PyvtQIoA:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzNSBTYWx0ZWRfXxnOzZegLiZRQ
 uWV/TWudYqizYdGO/uyHVlRdGYy62xosvT9ClBy5l7i0lYo1TvhD766zDWpRZunO/+sVGcnlTuc
 j6vN//XOfT8OP3o6WZFmAwyh6VHtv99SCt+iUgDWfcnyxFcnlYlC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzNSBTYWx0ZWRfX6bE+nU2WcOGx
 ZvDXFJLiRjKtkYTA4MrfrfQUZXrK4WKaVrnB40Z1lf22g8ABE38tLI8mpvmO/6/72GL7wJf2vbX
 pmVyRmnwC5QgRgNFCejNWAJLiUX60SwVy7MRAT3lBP0nc4zV2ee2/KCL9MlYJXOAGKZO3uL+6Hu
 FZpGK7yb+27T2hBrjXK5lPRgTww/v9J/8+ov5aHa1YX5/KjPZRqQb1NsSLpGr9p9kuI2Z1ffTQO
 jL2aJjlbitDYgFtD6wCYJUGgOcoV4NUNdnveIVKeUcowrbKX0SaMvHmDZOFscmuME1/jh8pUkAm
 0zWUVTT/2Ocn9y8/Z80RYXsFk6Hr0FctK08iELpZwcNo1apsEvGOvqhcZYJ5APg/GNr++NlRswH
 YqBbnSvW+StBag1D/CIify8Bq7ifObS6+/epOdFr4tF5gXLewSS7f2I6E/Fl84nOfWprXKyKSMs
 zcoyXbDqbjGwaZGLYWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190135

Friendly ping.

On 6/29/2026 2:03 PM, Yun Zhou wrote:
> Move sk_set_memalloc() out of the tx_lock critical section in
> nbd_reconnect_socket() to break a circular lock dependency.
> 
> sk_set_memalloc() internally calls static_branch_inc() which acquires
> cpu_hotplug_lock. When called under tx_lock, this creates the dependency:
> 
>    tx_lock -> cpu_hotplug_lock
> 
> The lockdep splat shows the following circular chain:
> 
>    cmd->lock -> tx_lock
>      from nbd_queue_rq() in the block I/O dispatch path.
> 
>    tx_lock -> cpu_hotplug_lock
>      from nbd_reconnect_socket() calling sk_set_memalloc() under tx_lock.
> 
>    cpu_hotplug_lock -> fs_reclaim -> q_usage_counter(io)
>      from create_worker() during CPU hotplug needing memory allocation,
>      which depends on block I/O completion to reclaim memory.
> 
>    q_usage_counter(io) -> elevator_lock
>      from nbd_start_device() -> blk_mq_update_nr_hw_queues() ->
>      elevator_change() which freezes the queue then acquires elevator_lock.
> 
>    elevator_lock -> set->srcu -> cmd->lock
>      from elevator_switch() -> blk_mq_quiesce_queue() waiting for srcu,
>      which waits for the I/O dispatch path holding cmd->lock.
> 
> Fix this by moving sk_set_memalloc() and sk_sndtimeo setup before the
> tx_lock acquisition. This is safe because the new socket has not yet
> been assigned to nsock->sock and is invisible to other code paths. In
> the failure path (no dead connection found), sk_clear_memalloc() is
> called to undo the setup before releasing the socket.
> 
> Fixes: b7aa3d39385d ("nbd: add a reconfigure netlink command")
> Reported-by: syzbot+3dbc6142c85cc77eaf04@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3dbc6142c85cc77eaf04
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>   drivers/block/nbd.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 497f3bbe5795..c5d3ae8f5fc5 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1392,6 +1392,14 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
>   		return -ENOMEM;
>   	}
>   
> +	/* Setup new socket properties before taking tx_lock to avoid
> +	 * circular dependency: tx_lock -> cpu_hotplug_lock (via
> +	 * sk_set_memalloc -> static_branch_inc).
> +	 */
> +	sk_set_memalloc(sock->sk);
> +	if (nbd->tag_set.timeout)
> +		sock->sk->sk_sndtimeo = nbd->tag_set.timeout;
> +
>   	for (i = 0; i < config->num_connections; i++) {
>   		struct nbd_sock *nsock = config->socks[i];
>   
> @@ -1403,9 +1411,6 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
>   			mutex_unlock(&nsock->tx_lock);
>   			continue;
>   		}
> -		sk_set_memalloc(sock->sk);
> -		if (nbd->tag_set.timeout)
> -			sock->sk->sk_sndtimeo = nbd->tag_set.timeout;
>   		atomic_inc(&config->recv_threads);
>   		refcount_inc(&nbd->config_refs);
>   		old = nsock->sock;
> @@ -1433,6 +1438,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
>   		wake_up(&config->conn_wait);
>   		return 0;
>   	}
> +	sk_clear_memalloc(sock->sk);
>   	sockfd_put(sock);
>   	kfree(args);
>   	return -ENOSPC;

