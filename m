Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A19A2627FE
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233439; cv=fail; b=i1YnxP2vlxN70cf0YSfcjrZTWbb0FXOc1sX/scR/0IdeRhUVsLN4drngHqvKgG4uF4KewvFLABfAbRsdXf/7WirI6+3DWbYXrfQ5rw4Ga5A/4uQpO8zOjf6EPh0giLnUHa+Ha6kVzbP3W6lrBEgsPUDm7UlRM7YWIDWDDaBNPdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233439; c=relaxed/simple;
	bh=toMpbwLszDWULxIASUe+05nBztVMQw5B0OmL0t1z5WQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TGOwReLpPqZgJgZQf6CbhN7tVFdIPKZjgwpoi0zc0kp4C2T88jzcqsyC4v2SDnFIANEsRQnWkOkoxS04CCqwxC98UlZYFKCkiwDehqqtctUIo9xdXnpjL5ApdQ9j413QAbdo0ZOQi7x6BKPxXUafmz2uZvGUHy/snJI15GOfU6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Up2Z3RHt; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Up2Z3RHt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbXuE7lMFa9t6GXOp3+hF+Rj1ZvKZRz6cRG/pvoPEpSzt0ZCvrO+Y9fqrWr5HZQZR9+C8LB6g6e62/tYoxi7C3w25aqh8rl+/ihC0iednfD/zsEhJeVjlZ2UBIoCOVE0FHv+gjBvev39qZFp8F0qmNSsOf8uiTqm2Hj0K3ymJm63wroHG9dmxw8JaFTU4ODdkphd88SNopXp9g9kWH6ncFBlfKpGuFrf0HpOmEcgz2KTUYNzrPu7sNcDYyHEdY8jPmrHpHLak0IJJTXD4l/jYha+Tt0m0irlNoCCC/7xkhYlIyVNRmyk3fWjM9eDHlo+E00FUy3j1wscqCDKhfPo/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cbHqg3IVZWFJ0+3FwRmoZx8uEIaWWJOayppyi0m5eo=;
 b=lYZEm6vhUW9CAL+pnRUYN0/Uzi4blG5W8hgJ0yHc8J5tMPu/Cbv1SrA9ibHN5ZACsHI5l+JVTcqBSNhysP56FNcY9rY+pixpi5qzg/BZEIeCYHc+3sLUlc9457hoSQ+hQV86OQJ3FkiKEi5Ro2bcSTQO2LrU7ZKODu/FrIxBEV43MTLRmcrlL8l/h8FBg31n69+lBqSJiSwSj2XNMI3Y771EowJN+QFIkjE652CqXmJwU1QSqf8uzvvkeWgL3MZnHckbNU8MvX0W83eFftaBekCs6th4+NHazOXas6xwkKN8ED07h/gqWKS5s5OoMvrkQsADs1uXfC/wUKNHiZ8Z3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cbHqg3IVZWFJ0+3FwRmoZx8uEIaWWJOayppyi0m5eo=;
 b=Up2Z3RHttGsxjpB9Vlk0RshY/RMaEPQW3CvjY7AtMQ5zqIbSkqEk3E0MDt0Wl6XjojAZgl8ZuBozV2f/QhjRoVy9uJ/Pq0SHVJmdKYUa+e1riA9EXkVKtN1Xm3UWUSPUPm0drBZQ/FR9KEKosDF1tbAD1pYX9P+8DtwpVBM6YMtwWvWMJO48qcPI0uWEec8kPrNmbCAWTb9RVaEUpEoUOc4B+ZYTrDqmAFCfa02ZHABcOqbQatQh80XavgEOOxdtDBut+vdygFNv8bwKNVNFB5055VFs97HZYCe7KRs5MYXYOsvFH0lcrSgaDC4K+KUrBruNRmmuoYzaxOY1Jgg8yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 11:03:53 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%3]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 11:03:53 +0000
Message-ID: <cf8b1de5-e60b-4ead-bbba-a4db4bb32cd5@nvidia.com>
Date: Mon, 21 Apr 2025 14:03:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4]: ublk: Add UBLK_U_CMD_UPDATE_SIZE
To: Ming Lei <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, csander@purestorage.com
References: <918750ec-42e8-46d4-bbfb-e01d3dce6ed0@nvidia.com>
 <aAGQLYDOFY5PyUMJ@fedora> <26675f4e-07c5-4a76-ba98-463c5bd0406c@nvidia.com>
 <aAWyy9qFlURHabHM@fedora>
Content-Language: en-US
From: Jared Holzman <jholzman@nvidia.com>
Organization: NVIDIA
In-Reply-To: <aAWyy9qFlURHabHM@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|CH3PR12MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d04f990-a3b9-4501-1f8a-08dd80c433f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajMwVk8rNmQ4WXlqZnhDTC9ZcGtXYUJhN3hWSlpTMlZycVRyc0I2dmxrMHpv?=
 =?utf-8?B?NnhoTnozWTRERFNqRHNoempJeUgwMyt2Qm1UVWZESHBkVHhqQkp4MWlLREZO?=
 =?utf-8?B?R1hoNDF4TEtJTFg1eHhwVzVPUG5qaFlQeFVuWVUvNGw0ek5GRVJzVy83U3M5?=
 =?utf-8?B?eTRObXI2OTFGTWFWS0tzbHZ6TmowU1hzSE1hNThSSldNVC9xejNaWStITThW?=
 =?utf-8?B?TlcvUDV6Vk5kb1U4WG9XOTZxcTBqdUhNdWZjdXYxbDFpSkJBWXF5M29hY2dS?=
 =?utf-8?B?OGcxQnRnY3F0TVFHM3N1TkFMV0pRWStSbUJEL3V3ZkpvdXduYzkvRHlJWWRU?=
 =?utf-8?B?TGV6bXpmVDZTcWRyb0JjRVdZdHkrMlhCbTFEb3ZPWG51ZURBYUlIQUo0WG1s?=
 =?utf-8?B?S21mRVNtU0hSNmtpZDc0N2YwVHJET0l3Z1dyTDFZZ1JYdTIyNStYaTNOeUtW?=
 =?utf-8?B?VUZHMHErUUlsRGl3L0JLN1FsQUd1dXhKaUJzaTVEdXlnY2Q4bFhPSVZ4VU5k?=
 =?utf-8?B?L2w5VE1lWUdyY3pRam8yTWU4dUl5RGgrWEtqOTJORzdSekFZeCt4ZytDeDdk?=
 =?utf-8?B?eWdlejZZcUZSaTBpazB2b20vNUZBeFhUNUFVK3dPZjR5cFl2RE9DTGJCZzR3?=
 =?utf-8?B?UmVPSXZDbVJOTUhZTDk5dVUza1AwU3Bvb3RaMjJvb2hMS2YvbzhKT3JCZ08y?=
 =?utf-8?B?bkNSYWFRQ1QyQ3E2Q2tWMHgvS0tjU1ZYWDNkMDk2b21PRE1SamE5NE5rQVVj?=
 =?utf-8?B?cFRpcVQ3V1lYektIdDJEOGpwUFhzVWMyNzZxWERQK1VZMWozMGlVajZTVGxJ?=
 =?utf-8?B?OWc1MGNEZEM0QnF4UU1FdXNuQjdDWnMyWGMrNnBEZGVFWDE3VHpybGladElj?=
 =?utf-8?B?YVNMWTNoSm5NUjNBYm9NaVJZdllyU0JQb09SRVo5MXI3Vm1vOE1rQ25wK1pX?=
 =?utf-8?B?Q1YzdFpVQ01SK0c1aXRLREl5QkRrV3pmVUtxSlNQa3NBSmxHMDNvbnExbzZT?=
 =?utf-8?B?UnlnNndLTHQ5YVg5bDMwbWRMMVBvNHVZQUdXMVN4aE12SDZvMlF1UDcrODBS?=
 =?utf-8?B?WW8zK2lvc2EyYkRiZ0p6d2RzN0dWR3AxVFU4dXVtWEJjeVVvTU1HY1ZEWEdv?=
 =?utf-8?B?dmFRWTdSRWo1cGVFc2RUazM0VFl5cGVHOE1XaW5QZmpZZ25naTBtTk9vSzJq?=
 =?utf-8?B?T3k0dFlEZ1E3aXdjMDd3TlBWZDRWeTg3eE14eElUSjEzK0drMng3WU9Lai92?=
 =?utf-8?B?NitFYldPZ3djRnpUQUxRc3BNTzRCbFZzVldhSnkvYUFWRDZObVRldXEzaFV2?=
 =?utf-8?B?OVo1VDkzRnZXWWlWYW1pZ3h2SEVWZy9YaUx2RHJTbUZ2V2NtdmxDbzZiaW5X?=
 =?utf-8?B?SGVpVTRLby9Vc1JqakFnK0pxU2JmZzhPWmNnOHFOVE1SVEVPTFNyWXdzTG5T?=
 =?utf-8?B?NjZUeFVidks0WmhNWjBrQ1MveGU5ZTVRUTl2eTNYWkQrT3hrSm9jK3pFM0w2?=
 =?utf-8?B?OE1PbUZQZ21iKzZZeHJsL2ZaaFhHejVDZmRjcEpmZExaWCtSbmRoY1RiOFhn?=
 =?utf-8?B?ZlA0NVljY1kxZGtsdE9xQ2R6NE1GdjIybFRnbkt6T3hkMHBaaHdnRFJWWUdv?=
 =?utf-8?B?Qnc0U2RJMHBuVHFSclhuQjU1ekpIR0w3YU5mamxEV0I4VUdPWEd2dEpkYldv?=
 =?utf-8?B?TkJoWkRTd2I2cllJcWdqTGsyaUk0dmZ0Y0NnSWlpKzJ3dklPWXRueHhvOElS?=
 =?utf-8?B?TUNxVFp1ZmY5ZEhmWWRoYUtUbTg4WE9OSFpBcEF0SWwza214anY1Zi9sVlBp?=
 =?utf-8?B?N1VuQlZFV0NmTlNERzF2MDBYVU90U2ZJaDVIL01MMGcyVE9QNDByeWZNMis0?=
 =?utf-8?B?NitXbHBJMnhaV2F4UW5rc0RiaktGVU5iSU5DRXBMWGwyWUw0UnZkQXYyM2ps?=
 =?utf-8?Q?qpuWDVYxQIY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW5VOHZEb2wyR243UVJVV1JBUFp3cERzeFU5VWpqenl3Tm0wbGhVQnBlcVJq?=
 =?utf-8?B?eXI2YURjYWZhZzR5TENhdVRhdlNiZG8rQUN3KzRHQjdZZ2ZpamdxR0dFdWRO?=
 =?utf-8?B?Nm81ZFdHRDhjdTRaZ1AvL3Q4SGMwb1YrRjBNR1ZQK2tYUkMvZnVGbmx6TzAz?=
 =?utf-8?B?aU5EY0ZzTVRrUkgyOHh1M3RmckVnM2FydzY4ajlJdHNlM0RZelhnTjVRQVh0?=
 =?utf-8?B?R1BmbjZjNDJKOW43Nk10aXljbEVTNlk2dzZGTW1ncHNxZU1VWDFzUUZ5aDZ4?=
 =?utf-8?B?ZnNIa2NQTmRJM1p2T25kTm45RVpKSHl3dW9icm9JNCtaT00yeGUvekZrcDl0?=
 =?utf-8?B?WU1RelE5MlhNek1TSmNOM3NxYlVTaWxJanZZOTN5NHJJKzdmQlkvS1B5Wmp6?=
 =?utf-8?B?blJWeld3ZW92b1hFRHFSazVnY0d1RzhSejJmSTJ1WG9vY0tpVFZFMWoySDNC?=
 =?utf-8?B?TUdpSEs3VWx0aFBsUkxSNFRVMHhTUjhsRmd3VWhVZktMUDRuK1VjUXRneU9X?=
 =?utf-8?B?d3ZoWTVleW1meWhUcmgwWkdYb244V2dNTlJDeGtMQW80UjI3cjlzYmdvSTAv?=
 =?utf-8?B?QkpielNsY2VTd0JqSWNZNElNcVJ1dmU4eHdyanplK2VEaDlMMHpIa0ZaSHZL?=
 =?utf-8?B?b01Sc2ttVzU3aUtQclpSN3BwYlczT0VpZkhFVU5ZbDZhVzVzb1hEK21CdzJQ?=
 =?utf-8?B?TjZreVZHNVdUcWdGZU5USjloN05VV2VscmxYako1TXpGWUVUZDlPR0xYZ0Qx?=
 =?utf-8?B?ZFNDa0drMmFIZWsycHBtRFM4Ry9ZWGc4UFRpTGlBcVNERzRXWGhCUkdwcWt2?=
 =?utf-8?B?Ymo5ZnFrcklBUkxHaC9jdVl2bHZCNWRuU2JJVDd1cCt3UVc5dlNxOXdoU0hv?=
 =?utf-8?B?eWtwL2xVZnhNdnhrVGdOUWNoTkpmeTE2MitVdFMrR3RrY1BSR1lHaVk0K3Iw?=
 =?utf-8?B?UjYwTUdmRGMzaElFeVFveG9aOVltODM1QlZCV2RCakVEUis2SC9nUmlUMVNV?=
 =?utf-8?B?TEtpcm5uM2htcHpkNW01UFBmYUs4VWlUdTlhZEc0UWw4NWxYOUZocDhTRkZZ?=
 =?utf-8?B?cHBzaXJ3eTdidENqVDlPZ0w1cVJKbVpVVWliMklVQ1ljZTV3ZXo4U084U1lC?=
 =?utf-8?B?NjFGQUVVTmJHcEZNWDBjdzA5MU5pdnU4ZG9rUVhhTmxzcGU4bmtvR0FuT3dD?=
 =?utf-8?B?cFZvb3lqSWRwb21Ka1R5cjRvSFc0VGNYcWdZb3kvU2FNUFB4aCs1VjF5Mjc0?=
 =?utf-8?B?YjI0bE82TmNHdW5TNjFLQTZGbVZOcmlEdWVmNmduWnRBYlNuK3pwZ292N3N6?=
 =?utf-8?B?ZWhUR2VLZU8zam5Rb1ArZE83YjkrdlFMc1V3VFJaY1ZBZFA4L1E4QnBTNDdp?=
 =?utf-8?B?WWNRWlNvc2ZHMDI2dGNqQXdlOGxCejc2bDA1c1h3a2JscjZFak95WmxIY1Vp?=
 =?utf-8?B?YWg2ekp5TWFTQ0xlNXRYdGRyOXRtc3NmNnFZaGdIeG9GVllzbmdCS3pOTnRC?=
 =?utf-8?B?Y2VhSTl1MFhMczgrT2ZwVUp4SnQyalI3cHNUMFM5TEVqdy9JMEY2VXJQTjdk?=
 =?utf-8?B?VkhkWmUvek95RGxtcmh4V0tobm5wQ01wREN3anhVcjlLS0JCd2FnbXVzZHNE?=
 =?utf-8?B?Nlh0c3lUN0xiM1prNzdHZUNGeUVVZDNuZHpTbFpieEEzdHllUFQyZ2dwWWsv?=
 =?utf-8?B?NEVmVnpUYWprNVNIV3V1eWFyQVJ0SHhCYVN3TWppQXhyck5DTFJUN0dERUZ3?=
 =?utf-8?B?V1FlRmppRXNzcWtMQUlFZXBlWHd2dm5lVno4TUVVS1RBVVhsWW16bXBmVTVp?=
 =?utf-8?B?YUw1Q0ZFV1RvRURYUjVXOGtKNHpRTUZlRGY4SjBGZ3lWMlQwRk1QQk9sclBP?=
 =?utf-8?B?YjZFbm5SMUJPMCtUY0hHUDZqSkQwcG93eWxSYVgvc09yREJTS2pGTkw1d0VQ?=
 =?utf-8?B?ZnV1ZDRvZ1UvRndxdEhIamNGMHlqc3VLS3ZWcXVPZVBDK3c3M3VOSEtsYWky?=
 =?utf-8?B?UlgvT1VEOGRKTWZORmkvV1pZbVBEZ1lkOVF3bEZmeG4zRjIrYmVreXZnNFg4?=
 =?utf-8?B?QWxKOVlCVjFjYXF2TEJwTWxZZE9ZYWN3Q0dqTkR4L2JuMjFrZXRuWk5YRjhW?=
 =?utf-8?Q?JBwbRLuESuSH6fyLfKcRsCeqq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d04f990-a3b9-4501-1f8a-08dd80c433f7
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 11:03:53.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQgpLDszA9V9vfEsKEiKWH0k8MkMMCtylW8+HdlGIb8/DuT1r04HhrrtOit9VTenP17fdHaYwSTjDUsXBnPjvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500

On 21/04/2025 5:51, Ming Lei wrote:
> On Sun, Apr 20, 2025 at 11:06:17AM +0300, Jared Holzman wrote:
>>
>>
>> On 18/04/2025 2:35, Ming Lei wrote:
>>> On Wed, Apr 16, 2025 at 01:07:47PM +0300, Jared Holzman wrote:
>>>> Currently ublk only allows the size of the ublkb block device to be
>>>> set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.
>>>>
>>>> This does not provide support for extendable user-space block devices
>>>> without having to stop and restart the underlying ublkb block device
>>>> causing IO interruption.
>>>>
>>>> This patch adds a new ublk command UBLK_U_CMD_UPDATE_SIZE to allow the
>>>> ublk block device to be resized on-the-fly.
>>>>
>>>> Feature flag UBLK_F_UPDATE_SIZE is also added to indicate support for this
>>>> command.
>>>>
>>>> Signed-off-by: Omri Mann <omri@nvidia.com>
>>>> ---
>>>>   drivers/block/ublk_drv.c      | 18 +++++++++++++++++-
>>>>   include/uapi/linux/ublk_cmd.h |  7 +++++++
>>>>   2 files changed, 24 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>>>> index cdb1543fa4a9..128f094efbad 100644
>>>> --- a/drivers/block/ublk_drv.c
>>>> +++ b/drivers/block/ublk_drv.c
>>>> @@ -64,7 +64,8 @@
>>>>           | UBLK_F_CMD_IOCTL_ENCODE \
>>>>           | UBLK_F_USER_COPY \
>>>>           | UBLK_F_ZONED \
>>>> -        | UBLK_F_USER_RECOVERY_FAIL_IO)
>>>> +        | UBLK_F_USER_RECOVERY_FAIL_IO \
>>>> +        | UBLK_F_UPDATE_SIZE)
>>>>
>>>>   #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>>>>           | UBLK_F_USER_RECOVERY_REISSUE \
>>>> @@ -3067,6 +3068,16 @@ static int ublk_ctrl_get_features(const struct
>>>> ublksrv_ctrl_cmd *header)
>>>
>>> I try to apply this patch downloaded from both lore or patchwork, and 'git
>>> am' always complains the patch is broken:
>>
>> I think this is because of my workflow. I cannot send email outside of our
>> network using git send-mail so I've been copy-pasting the patch into
>> Thunderbird.
> 
> oops, copy-paste usually breaks patch style, probably `xclip` can help you
> if copy-paste can't be avoided.

Apparently Thunderbird also breaks patch style by default. I had to change some settings.

> 
> You probably need to find one email client to support importing patch plain
> text from file or sending patch directly, such as mutt/msmtp,...

Should be good now. Please see v6 of the patch I just sent. I already tried downloading and applying it myself and it works.

Apologies for the noise.


> 
> Thanks,
> Ming
> 

