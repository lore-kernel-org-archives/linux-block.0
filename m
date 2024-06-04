Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010001.outbound.protection.outlook.com [52.101.128.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E6213D886;
	Tue,  4 Jun 2024 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717467551; cv=fail; b=qWGGl6bNWOjkzRFzcQ2ce7uSSQ4ZlawzN0j+NdcIj7izZSh4QCZQtyah78K1htKHeulPsMncD0eoA3qE7+QamUqZz+AnIExsrSf0z2/H2h8IjuMVCpZIxBEF7qHPly8A3JMYpntCQW5NlA9N0bOhZObwOUD5WgLTlKErCNERSns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717467551; c=relaxed/simple;
	bh=gOcZkaJwvkmT7oEE1lzEI5iQoTY15+nnHRJV9h5aF6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I3wvTzWXPEQp8Hlw9PDGFlDu8QQqnjUI85TdBZUVxJIMgLvhixzDl5mTS9GDBdxivarGGz8uL5fA/XIa0WIDARQyA+WoJ+qxU26unf5MDtGkB11b82NZgMv0cVaEWD5caIDKCtIW+P4jMJYEj2OrPmD3xaGXWtKJEaKw24M/fz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZYHhTJok; arc=fail smtp.client-ip=52.101.128.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZYHhTJok"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N56mr3DUr+VJmEMHi69REIngL+TxYAqsmHu+NVRr5uNh7IWpX4oIyNBGgzI4ygCkrqGTh+rn5FSvmWQ8mlcoqZbthLUtyvbukfFRGW9mlMfq8ZETXLkVARifqptcZWpAFahLzZAfAV1BXzDZg6Kfb1QVxj6BWwwfBLc9sTZjcCHu4cIiwso4+FiGc7saM24LmTwOjkhOjBiihOOMsM2cuRob/BeyP7QPbBA8n9uRyEPdDDkGXQcNDMPxUjKhr4joG0UWPQjXinalAOwA/LUJWrCuJ9Ljo32W5FRKFK2EPNY02h9DlEOR7z5n+gocHXV4ejPq++QpbAzdq4/7Sun4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDuI3S4oC3/uupXWLOF+caYuZ5D8gNLb1ccESyRaWws=;
 b=XtDyShXBkdtIKsjpBjbs/XNImsI8A54wwD/+o14pzzi9qvAANqts5aMsiBtC0vnLxLfQVlR1IpDHE+5JZYgPWN64brpoaogrVewv4CZCaUfjNektiD+9twUip80gunthaWhPK/XWWcWX420c0I1ZjGsSRgLyj2q/KFG8zN1HQlOIspY+h9upvevQJMH6eW7i3V0XhsWsCiR4uUFG7JiLnzqHmnJD2WCAtB4uzYjDC4eWPGbJWjvOQEsR++huKMH6k/cYs0dbmjqhMGcSbgi3peKgZpGaiiS+k7jalRo/licLUvFEhmUnebHHcSHk9FGP/KvUNXUUztcY3PdTTWJP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDuI3S4oC3/uupXWLOF+caYuZ5D8gNLb1ccESyRaWws=;
 b=ZYHhTJokScPFeBsxYb6X1g7ukUkhXVfNH1cUr0w2EbVlLuQrs/1oSoOREwesYsoePH16Cyeq/FMNd/ebt2RTKROX7n6/iMdaWlXP9gVbbXd31T2Qu0DDNZn4FCZi5YxXV4Z6dSMvLBZ2C9A8mrFFhlwzngmtkCSSuFXwCslWu5cgCHz0fmBC3ctT3kvdoUnSl1WZvKbcY+Zm09rvPIdJ6pgn7yxFb1xAjPpU/42lHkpjHJyAud3x88kXYIoFdkOzNmaWAk21IQhkjpuFH8yTDlmf4Vxxsw0vfe4ZHPlgu+r0mJNClUBD2oAbXlqKHN/pSR67J7pOU0N2jlxre3EWxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by PUZPR06MB5452.apcprd06.prod.outlook.com (2603:1096:301:ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 02:19:06 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 02:19:06 +0000
Message-ID: <3f1b7f90-5de3-45c5-87c1-c09687d9e623@vivo.com>
Date: Tue, 4 Jun 2024 10:19:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20240527042654.2404-1-yang.yang@vivo.com>
 <Zl5sj6IC5sBqgAF2@fedora>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <Zl5sj6IC5sBqgAF2@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0077.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::17) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|PUZPR06MB5452:EE_
X-MS-Office365-Filtering-Correlation-Id: 36dcea3c-c60e-4e51-3f89-08dc843cb5a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUh1NHlZNHZTeU5UcHFyTU1YbEVqMFkwRi9LbDJadlhnNlJUbGh6aWVLWEox?=
 =?utf-8?B?ZEdtc0lSMm0rNllOMVdqRE1FbjNscGY1bzRkTDRMTlNCeVd4eUFrak05TE9Q?=
 =?utf-8?B?Uk5rd1lsZ21KdWVXRVArTFRoWWRFYzk5a1N4SXpXanhsbEltOWh4UE9EQXFX?=
 =?utf-8?B?VE8zL3ZIamFnVGxGQmJMdEtYcndWajhwWjhFUjE1UmRrZ3hVaFJJcGc3dnlt?=
 =?utf-8?B?aXJ4L3ZQb3ZxNkJqTEJRVG8wQnRmV3cwd3UycXZ1WFVXREtuMGdtQWwvSE56?=
 =?utf-8?B?MHV0VzBsUFhrK0dLbHc3RXlOOE5USWpHNU1XMTk1MUFqOTNGWCtUYnNyb091?=
 =?utf-8?B?VWMwdXpRVm5KNG84TEVnQWhjdVh5S2FaY0pDblY1cElyVTZPaWhWRkpxWSs4?=
 =?utf-8?B?V05TSE10V3NpcTl6K2tKMTZoVEFvRXdOMWY3OEVtNmMxZG1iRXNlVDBvdito?=
 =?utf-8?B?YnlObWEvOHNJZDRIdFNmeUM2Y1JBVmhZYWdwVUtqS202RktTVVpCRW9pemV6?=
 =?utf-8?B?YXpHSXkrNm9LS0YwVmxUZTNNNXdYSFRiUHR0bU4xUGdmbW53M1BjM2V4bmt2?=
 =?utf-8?B?anVNdmFCUWF2d2piNW1RU2RxM2g2QjJZRFhFd0ZCcW1EUWVyNjFYNFkvb2c4?=
 =?utf-8?B?dFpzMU5FN1BqOWtKNy9xTEN4ZlJackhzWE9IWkpnRUxEN3g3Y0UxRXNqdlpY?=
 =?utf-8?B?VlVMZytmT281eTJyTmtVeVVRUG5zOCtDbzF6bk5LWGNaTVpqUGdDcXJTeWVo?=
 =?utf-8?B?RGlrSURHWmxCZTZZenRzSEtYUHhLUmJHZURYbTFiTE5XNHI1ZlY5dHJPY2Yx?=
 =?utf-8?B?MU14R2pvRk9jekRRakdGQXZKNlpKUVczOFQrV1BreTVSL21Ia1RLYkRKOW9s?=
 =?utf-8?B?dmQwL1ZsYlJRNENsbmNhWks0ODJjWTB6QjZKdU1hOFU5QllzOTdSS0VBaWh5?=
 =?utf-8?B?eUVGTUhOdHUwM2s4WVp5WFJXUnNFdEZVN3gvYk5UWHNMV3NONHhRNGRpTFIr?=
 =?utf-8?B?NHBMa3NONHVOaUNaazgvdjRRaGsxbFRtekNsOEdyTGtZNUQvanE3L2g2UEhE?=
 =?utf-8?B?RnJma0kwRUxsQkgzR0pBT3o0dWk0Nm1wSnZXVFNWQ284ZmUrVW9UTWplOGFQ?=
 =?utf-8?B?bWVKOUd2WlNpOHlJbmpkLzczQmpzVmFTa1NjT3lJWGdST3M3ZVpBK295VjdK?=
 =?utf-8?B?Yk1ZTW9lcy85ZUw2NXpDWTczaVJFd3RxcVEwY2RUTGIrVXdnNXNwR1NJMnBq?=
 =?utf-8?B?MmRUOENaeEZBTERKOWlyQ0xZTmVsYTJUV3Q2TXREU2E5OTA2OHJ3YXNHdDZ2?=
 =?utf-8?B?aU9TRzV6WHlVRUJTemFyT1NGejR0YUh6MkZmU2ZtQ01HRFFXVWlyWEJsRElK?=
 =?utf-8?B?YmsyM1gxQU9LWG1wS0svUER1MU5wQUxvUllZZEZ5MTBvbHg5UlZKc3FIc0Mr?=
 =?utf-8?B?NS9EWnNXT3NJU3NkVDNEdmYzaWo0emRnK1F0TlNoWXpaVTlmNnYvTTc5V1lP?=
 =?utf-8?B?QSs3T1U1MWJCK2RnZFpBei9SSmNWV1ptcEh4c3BORUpORElPS29zTTVNdWJn?=
 =?utf-8?B?bldoWThtY2NFMlloOEFVblU2NWxjSkpKcHBZTEZYNThYUDEydlVlOTBPai8x?=
 =?utf-8?B?dkR3eVdLQW5SU202V21keVFzNWl3NmphZVppakxqNitFdC9TWnFCZ3JKQVJa?=
 =?utf-8?B?Vm9Bd3NHSmlWelhvaHJVakU4blIvQVp1NlNYWmViL2pBaC9yaTBDc0t3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlB6bjZyKzhHV24zaURDU1JSTmJxT3dCZ21QdnBVdG04czdSNGlQLzIwVndl?=
 =?utf-8?B?SjhoSEsySHJPWW9NcXZmNU5NT0QvbERlZ1B0dXJWc0ZOSjlucHVPWHhha08y?=
 =?utf-8?B?bGJXdFNWaG9XMmk3eW9yQlNDK2xHZ051NzNZZDB1VDhSUFJza3JzdGVsUXBH?=
 =?utf-8?B?VGNCSzRvSDdzeENWSG51SE4rZThncEJlM3doT3psNzBBZUU3ZlVJaWJkcjZB?=
 =?utf-8?B?YlFlbk9jZ0ZOQnR4cGEwRzlYY3Q5VDhLZzZDOHhycjR4WG9jdTFNWjgzSUhF?=
 =?utf-8?B?bll4dkxZRzFRbDZOanUvdEp0ejlxNkJFNnJjQmNmcEJ0R0wzdVNJZWpwWWVJ?=
 =?utf-8?B?T0p4S1l4SDVjSVhsRDYyTjZaNjlMazBPUjE0QU5va0hzSWwzZ2VQdXNMOEI4?=
 =?utf-8?B?WURhODdOQnhpS0NTNXFudkNGM3MzY1pnQlRhdnNwWHNRUHRMbnR2aEw4L3B0?=
 =?utf-8?B?Y2VmK0o5bDZhT0YzTnVmNlcvdkhmQnFJQ3dybXc5Z1lvTmhRSXlHaExobGc3?=
 =?utf-8?B?c3pxQWRIREVmRzgrTTFWaEZrMmFHNXpOUGZyaU05TWpzTTBhU0RIc3lqdXF3?=
 =?utf-8?B?c1ptdWx3UUF2a3k3MW5kdWRYWXpwYnFtaVpINURoUHhXUmErbHkvL1N6cjN3?=
 =?utf-8?B?YXFKOWlYWVhNOGllN3BBUVhjL1ptU3ZPRmxiWFUwcHBiWldjaFhyQ0lURVJu?=
 =?utf-8?B?cCs3aGV1VGU1UzBYZHJhUEwrWG56N244VVl5VTlVNkhIVld1TzBaV2JlMWxI?=
 =?utf-8?B?YTg2cmRiOVNpbmdKbFkvM0Rld1R3M2k5TmNYMzBXeWlNQXBHWFJJMDl6bkJN?=
 =?utf-8?B?VmNFeTluMkRQTnV1T3BmKzlCcVh5dlByMnk3dGJ6cEN5QXJ6YkpsdTM2OWsx?=
 =?utf-8?B?bDY4YU8zYklSaGNZbXFqejZpc1pHbXBXdkFGU3N0WDZ3YjE3ZHRFTy9neWF2?=
 =?utf-8?B?WC8wZkM1TW1VK25Wak95S1VTbTczYUUvWGQ3MER4OFErMlRuTS9hRkhURlRE?=
 =?utf-8?B?OGpoVHBhSzZVTU5adEYvVHh0aStxVVZGVk52SG02dWVqLzNtNStXNUhuTUZW?=
 =?utf-8?B?WkZ2ZmR1bUpLUUR5SU10UzBPajJaWEF0b3pNenI0WUQ1bG9SVkpXQTJSTFZ0?=
 =?utf-8?B?RkdzTkx2TllLa2pZWXBJUSs5RmFHdVM5WS9qZGlSenRRcXJqR0dsdEo4Wlpa?=
 =?utf-8?B?dmZSSS92R0xvYXp0QU1vaTVIcDNYLy9ETW5idUJLWEZEZnhTSzZ3MExHM0x4?=
 =?utf-8?B?ZjdMb3ZTc2pYbUptRW9EaVE5WmRUaThEL2doMUdTQnhrYkk4ME9ybEk0Z05u?=
 =?utf-8?B?Mm1Fc1d1ZWxQZVhpOWY5R2M1bG1DMzNpRTcySmEzaFVqMlBaakorQWkzVDYx?=
 =?utf-8?B?djFzZ3NNdWNqZ1RUWnpibm5GK1NKbE0zQ3dnQlVjK08wWVlIWlpNc3NNU0tT?=
 =?utf-8?B?blBZTWsvQlRCa2FmaGgwVE5vV0xWQ2d5bWNNZVlUUWJPWGx2MElFZW9iUzZj?=
 =?utf-8?B?b3c1NlpNZE9wbWd4UTd4b3hndHZ4NndVenVsN1MySW1TNEppaXJyTUJhT1U0?=
 =?utf-8?B?TW1LS2hkajdBRVFQazVvZVBMYnBqcEE0dTIyalJwUVQzUHVGZ09QT0x3QVQ5?=
 =?utf-8?B?dUJoYjdoQmhTazI2Qml4N3BoVkYyWkljU1lMZVJWcUl5U0U4Y3FQTUxIZU5q?=
 =?utf-8?B?NEJ1ZlRMdWVIa2dmcitEckZDMXNqamhyWUhIWHIxY0FWZWRHL05ydERza2xa?=
 =?utf-8?B?azVzSy9kM2hTcW15OFNsWkJTTXd0bFM0OHBDZEtsMVoyd0V2amFpUjZWek1L?=
 =?utf-8?B?RGR5Q0Evb0lsSmFFNUptN0JsaXJaSlBaVnNmanlXTTROU3VHc0RVQ3hwL3lh?=
 =?utf-8?B?aVl4YWwxZGNCaWNDbHRIS3BTdFQveTRKNkV3WDNSb1FJL2lxRzdYbE5vWnk1?=
 =?utf-8?B?anQycy9UL0F3YVU0SjhmcExkSll2VGUrazlWUFhJMkUvbk8ycWlUamlQOFJC?=
 =?utf-8?B?WmxmUVAvQTYwWWt2TnhmNTJLZVVtTGdvNmJyMzdXczUrYzB6Vm1RWWd1Y29L?=
 =?utf-8?B?bGhZaXlJNUlzMnlmeHAweGozZHp0ZTBsRXB3Ui83SXA3bjZraVo4MG4zQWkr?=
 =?utf-8?Q?yF1EqvdIigJZNUlH6q+t7npgv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36dcea3c-c60e-4e51-3f89-08dc843cb5a8
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 02:19:06.2183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FV33m8B7p6X+Iy3oTkGztcjmcfE0qreXkQs71hIdFAwOJojGmiTmzan8FVYRxD4HGpLgFXbIwTqh9tJB0/d4ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5452

On 2024/6/4 9:23, Ming Lei wrote:
> On Mon, May 27, 2024 at 12:26:50PM +0800, Yang Yang wrote:
>> Configuration for sbq:
>>    depth=64, wake_batch=6, shift=6, map_nr=1
>>
>> 1. There are 64 requests in progress:
>>    map->word = 0xFFFFFFFFFFFFFFFF
>> 2. After all the 64 requests complete, and no more requests come:
>>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
>> 3. Now two tasks try to allocate requests:
>>    T1:                                       T2:
>>    __blk_mq_get_tag                          .
>>    __sbitmap_queue_get                       .
>>    sbitmap_get                               .
>>    sbitmap_find_bit                          .
>>    sbitmap_find_bit_in_word                  .
>>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>>    sbitmap_deferred_clear                    __sbitmap_queue_get
>>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>>        return false;                         __sbitmap_get_word -> nr=-1
>>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>>      atomic_long_andnot()                    /* map->cleared=0 */
>>                                                if (!(map->cleared))
>>                                                  return false;
>>                                       /*
>>                                        * map->cleared is cleared by T1
>>                                        * T2 fail to acquire the tag
>>                                        */
>>
>> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
>> up due to the wake_batch being set at 6. If no more requests come, T1
>> will wait here indefinitely.
>>
>> Fix this issue by adding a new flag swap_inprogress to indicate whether
>> the swap is ongoing.
>>
>> Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
> 
> Indeed, commit 661d4f55a794 ("sbitmap: remove swap_lock") causes this
> issue, and ->cleared and ->word should have been checked & updated
> atomically.
> 
>> Signed-off-by: Yang Yang <yang.yang@vivo.com>
>> ---
>>   include/linux/sbitmap.h |  5 +++++
>>   lib/sbitmap.c           | 22 ++++++++++++++++++++--
>>   2 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
>> index d662cf136021..b88a9e4997ab 100644
>> --- a/include/linux/sbitmap.h
>> +++ b/include/linux/sbitmap.h
>> @@ -36,6 +36,11 @@ struct sbitmap_word {
>>   	 * @cleared: word holding cleared bits
>>   	 */
>>   	unsigned long cleared ____cacheline_aligned_in_smp;
>> +
>> +	/**
>> +	 * @swap_inprogress: set to 1 when swapping word <-> cleared
>> +	 */
>> +	atomic_t swap_inprogress;
>>   } ____cacheline_aligned_in_smp;
>>   
>>   /**
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index 1e453f825c05..d4bb258fe8b0 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -62,10 +62,19 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
>>    */
>>   static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>>   {
>> -	unsigned long mask;
>> +	unsigned long mask, flags;
>> +	int zero = 0;
>>   
>> -	if (!READ_ONCE(map->cleared))
>> +	if (!READ_ONCE(map->cleared)) {
>> +		if (atomic_read(&map->swap_inprogress))
>> +			goto out_wait;
>>   		return false;
>> +	}
>> +
>> +	if (!atomic_try_cmpxchg(&map->swap_inprogress, &zero, 1))
>> +		goto out_wait;
>> +
>> +	local_irq_save(flags);
>>   
>>   	/*
>>   	 * First get a stable cleared mask, setting the old mask to 0.
>> @@ -77,6 +86,15 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>>   	 */
>>   	atomic_long_andnot(mask, (atomic_long_t *)&map->word);
>>   	BUILD_BUG_ON(sizeof(atomic_long_t) != sizeof(map->word));
>> +
>> +	atomic_set(&map->swap_inprogress, 0);
>> +	smp_mb__after_atomic();
>> +	local_irq_restore(flags);
>> +	return true;
>> +
>> +out_wait:
>> +	while (atomic_read(&map->swap_inprogress))
>> +		;
>>   	return true;
>>   }
> 
> IMO, the above fix looks a bit complicated, and I'd suggest to revert
> 661d4f55a794 ("sbitmap: remove swap_lock") if no clean & simple solution
> can be figured out.

Thanks. I will send a patch to revert that change.

> 
> Thanks,
> Ming
> 

