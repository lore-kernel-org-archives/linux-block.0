Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BDB31618B
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126683; cv=fail; b=PE1cLqDalqcjLoPTzum8LLMG5LGq7mrVx/6xLOmuSlYu+Lw05LE08WD423TT+NMatWxFbp/sSG88MpWT1qa/PZfLyDtRsyBHmxKs4+JqniMKvgNjygg2MbOaDDjgJb5wu6cRC/077YZe2rBDjlRyldE+g/s8tDLgucJSdBzpboI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126683; c=relaxed/simple;
	bh=Oq84KdPPp2mQvRBFaJl8z/3gTeVy5tznc6pKijTOyzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EZzNnk9bBxVldS4chCWliWH3CjaMjBiUjVJo/1itHOBRtqJHPQFk13bbDlYxJ07bmZJAY0+76S5k1WBE+br/o57lHom71PCaP236gCko2nJIvIXV4gJCMkUzYYT7zSXBmw76r7gtCHfuqM1RYFhAv2KwSXnFT6rYXB44mcl2zw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BgDh1avS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qwFfIpMM; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BgDh1avS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qwFfIpMM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1789126687; x=1820662687;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Oq84KdPPp2mQvRBFaJl8z/3gTeVy5tznc6pKijTOyzQ=;
  b=BgDh1avSZ0mYdJE9ZQOUsmMBhG0Hk/N6fxvWLG6uF1eObJsAH4oNnQth
   jsOOAWVG05d7PFik6YgqilNihYJ6H0snCoZhgW1mIkD/LvSfQ4W/1hZ5V
   gMOpxeZ18rFt8+/WQkJdfSdy2bpAr1EzUei5yGSZSZR38C+mfKQzUfT4u
   03jiX+ojZMzTfqv8bEe9g/rHa1PoQOAmAkelZ2ntT/D6aY+Xu+hfb4/gg
   lN41ul9DrJpSIdCf00wJtJtFY8VXmgg7UJEtGGXfAqao/UopE7t4adiLn
   IdcHPA96I5L5cvlt1qQjT5dHj4XvWw74daR0dcWf1wPeR49zARqNO/OWa
   A==;
X-CSE-ConnectionGUID: OApsOe9kQRuXCpyJiJyO2A==
X-CSE-MsgGUID: 79n3OKD1Sk60zfFElYdYjQ==
X-IronPort-AV: E=Sophos;i="6.27,97,1786982400"; 
   d="scan'208";a="155448841"
Received: from mail-southcentralusazon11013028.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.28])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2026 19:36:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWWMNkUWX+hhjNbe3Yocuw8RfBkP+6tbIRVMIGBU+SHTsTKrRXkxjH/+nyiLUHxaDf9OdzTjsn9k12ZkLIcLypaJ76cub1t6xW/WsjJ1d7w2W37VhV+WsREqH3cuIF9AHUkIss3MIY0b1bHwqy6fwr0MI/PlRxUbCsiY4kyJqU3yDiwB4mzH6DNrkKfOOjOhXH+fTH8rf6WK17pp6+XxN6TrUecFb1jhCJQoYTc43EFefLGJ7wxoKbfx6rqL4TDnTrWNES87aDH8f9Klz9D2tKwc0f9Qoju7FF/qrPqjXGsrCoDHiA7p2wgKHm1z4AKvKp8BSOvG9Q//FHcOfhAT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8UxkIocrOggElHOh+zBaLZ1Ujq+nrq5uE3IdnyIyYc=;
 b=ihTIcCdCypkZr0tKSvDloEyahXRGPFdi72h7itPDFZ5hveBcRWIAS+NDuGwo7GvlEgqqoC8uGdPzYsQzNapnP7UBguOP0Yxa8vu1mdenKePHYZpy5geWDrSKswBQsCLjenQs8OudD8prtyG3yXXp4hg3+HNW3v1DURpl0z7jpo/jteoT9WgtZ9DT+WIZkKq0PB6oBo79KCgr5WpninPFowi8rW9uIavGFRDd/FKXp/nhsYdWjnKF1XRU0PA+8qZw/6dClBQn1KiLWMS59PPQCwixRm69+Ka+MtvSePPzVZaJedFcN1V10fm8hIU+EtB/p7+b3tgbZFXmMQW4X33tNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8UxkIocrOggElHOh+zBaLZ1Ujq+nrq5uE3IdnyIyYc=;
 b=qwFfIpMMoREyIcNHGx1ZFgnTINUvfV0ChKH2GwSml7W5fTohpaS1fpJp56SAOfkhV/yeZe7aLJmk2XDiGR5M2jD0uE4d28Cel1TmCK/M8IX0TOSBN+PNVvgtmRtFk4YmwfEli/GjTB5y3sxuRfUVWolgDB5hgIrjPHfCBKEQeYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BY5PR04MB6802.namprd04.prod.outlook.com
 (2603:10b6:a03:22d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 11:36:50 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 11:36:50 +0000
Date: Fri, 11 Sep 2026 20:36:44 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-block@vger.kernel.org, Randy Jennings <randyj@purestorage.com>
Subject: Re: [PATCH blktests] src/Makefile: fix HAVE_C_DEF probe under a
 non-bash /bin/sh
Message-ID: <aqPnqZy5HKiNWxlt@shinmob>
References: <20260908214823.2366812-1-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908214823.2366812-1-mkhalfella@purestorage.com>
X-ClientProxiedBy: TY4P301CA0075.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::13) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BY5PR04MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e566e95-890b-4c74-3f3f-08df0ff8f867
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|19092799006|366016|10067099003|3023799007|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sqHyd+T5XfN+/zeoOi++/5MqP3dRT1gTgTlq92QUZCmRMGFEVHKKegH0gsMt0/V89dv3/l+NbaFndpZ7DkvfI+CXWQfAYFUe2ZAQbc+5cIUP1cqZRU709qu24ln/d/ePphMtkwbslWBVmCvGkFXk+lH3hl06hIV/lJe0v4yW7do/QJ1Cj6G0sSS/NMH+C+nilIVakPln+OkhE95AaY3xidkFKAiAydTjQKlHFbnwKYmJRGzzdAM2HnDIRuUEwDmxb+x+tQLhHPhmRyDOp5O85evXA3lligiT7N0iNa1hVNTmdPNVQwW2oPXe5GPvfCLdFLZlQ7DziobdIfVCc/Kn6qoSKl9yQDE9AvuLz3ztpAL0VZ4YytxxOGMiY73jIE7I2bqk5rnHkNsfqAIXiPe2zgmXkqA4YcY847IvM0alKbxOAQE0VIC++XOLrIIM7+ICdTQSa7gHw1Nu0F19X40j5rlVt5bCjyHRvzG7u2+fCBoli+apT+6EEgkIWzrhiedwypKfsaXrhwKZ6i2UlXHYE9/I7KCvE8F2VpzHXST4C2cAIhzrNjOf2IPKRGphqMfbs2n2bm3qZcvg+2HzJyQHF11l+DYc4IU7DD6GqVAXNHHTioLUqYqxk2eLU9xAjdmv+/i19PyJknuOx9XiL+65hZxWbTAxiqhq8OCf5c4KdC4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(19092799006)(366016)(10067099003)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v+N2/Ycw4WV4fn/U5KNNOgVRrmiULxUrECQ1MLXgDMu1XdhtZevARjge2fS5?=
 =?us-ascii?Q?VKpnhGXNu4HeDkVndb3mp+/+1sTsJDG2IlMfM6Mp5jwl67IbZMp/OrI/6jMu?=
 =?us-ascii?Q?JU7JAzyJmN00hJ4jnRUVHwaARlP1fdtzuffl6UxzCbzYbFygb/xIFvppxmJI?=
 =?us-ascii?Q?Y3CGJ5cWx062lA+2EbQAQCeTFHTF8T3Rp2EE1UBWoN2f1puVL74Uy+Fhv63l?=
 =?us-ascii?Q?+cX4KGBIXTLNKfwP2nSikzS/zQljrbJk68qv1zMAj1U0qWZ3dhepy5dgPVQz?=
 =?us-ascii?Q?RbDoDKtvYezdzIku2joCf0y5uTYJgn6u52LH7gycZbD6KOuMDBbb4pfI8ItH?=
 =?us-ascii?Q?1xOHAyS3q37cMRsp8vDdMhUWrmoLaS9OujY3GtjnusWYIbLMVD/dnHv8Gt8E?=
 =?us-ascii?Q?8H+5D7TDp+kU7eicsQ3eCKJ1OF6gpl9IoemS1yXe9PeUsIomxe7/NDYApfVZ?=
 =?us-ascii?Q?31O8aX3pQ+/jvreVxq4XA6btKW/MyEJ7fLWi8wJ+XqYoW5MDfm9GGQ6eozC6?=
 =?us-ascii?Q?1mqBV5uFo+Q4SokYDQiKawKSE6/CCP+Un69JNsEOyWjQViFEHXBkmlVYZKzL?=
 =?us-ascii?Q?R1hu80/zDr7E9sXbaG2CTrSNy0P+Tb9d6UeuZHLGLmc1JzONr4t865eu3eic?=
 =?us-ascii?Q?p6tm5DXs8FXnYoxP3hrRb+dYBOh0a297HLN6QhdQySATvxOGSpibEXAa8muF?=
 =?us-ascii?Q?K9g2u+tq6zVz2gD2vsbd4w5lj6+OdJiO0axaY47G1ZUtd6ai+ou4A3atq3QW?=
 =?us-ascii?Q?78erpVExd3WG+hZHx/nHFcUVR2iD8AYZ71RUP4caHI3UsYhHkGLa0J4+BJNV?=
 =?us-ascii?Q?jPq/oRYs4um6pC955VvH8MvviSlslr9lyXjSIB/2jeEFMV+GqcnPAhAWFTz3?=
 =?us-ascii?Q?Mo3udAtq2B3jzK9dNywLFxnZcdQw3SItTSOYN4gKqZ8/r5dkj6GVmzB11tuF?=
 =?us-ascii?Q?ehLHtc0+iWKPuAeOoaAHDUtLs6xOWHoLbOVHobED1yuNDf64suKy8ju4lyu4?=
 =?us-ascii?Q?4ksEf3/Gm9KnkIxNFwFLLF3ucBvQ1dfpniWc9Z/Pdrb7I0DzY2ldspiB3sa3?=
 =?us-ascii?Q?ektacr1JV7kRMcqktQI3G/TEKHxmqemy068qmqYNPnvuY6kB3SjPdCYl49Oy?=
 =?us-ascii?Q?ftq0oxSCRq3HZqOAojiJcYE848wJ8+hqUrFtqpvbGH6WdOHTAtqiMsnHmlpL?=
 =?us-ascii?Q?8fp0Vj4tn5OhONp0VieS4ny7Iqs3Bz2Vbv+m/p7nWV+7GkK0KM7cXiTHIy5v?=
 =?us-ascii?Q?uDfYa17K1PZIfh9YaTQ1Ia4Ut8jke5di0CYZttQIbDP3Kd2qo9H6HiRK3kGU?=
 =?us-ascii?Q?JTdnfrXkFBCWBS3uRKRU8X/n+Yu8Us4Y0GrdnCPk/0XhJiBx94pJIIxNW5E5?=
 =?us-ascii?Q?SDk0LE0U8Qbm/kXr4LfK1AIo5zBvnYNuvPnNp9eeVdB8ViDefPjqfw4q98dW?=
 =?us-ascii?Q?ZyuiBuOj9nPrgzdDPA/LXQwTatU0YNwPCf9wmVPl0nVILCWY4iIJmvlVB5Al?=
 =?us-ascii?Q?X38T2JEY8UTRzUqmu5k+y5DY5uQOH/uWdNz37iIKquCyl6hamgZAASHBcwsN?=
 =?us-ascii?Q?ES5Hg4dm/1VVcSM7XBQ5O7XKitW7CFXiByp7wyC+yOH361JL6m3gNPvDTjSD?=
 =?us-ascii?Q?1kUgUTDQWD+8tr0HLwmJcF6FDZ0zvBhk6LjpsqzonGPEDUKx0rVzArz2L7NH?=
 =?us-ascii?Q?Vx3IxCD9nqAO9HZB8OoDv/JCMEdFFCuIMAPxLGzavktJdvSWhYsrA/135QMU?=
 =?us-ascii?Q?QiVRa+2KxeijOKEQ/v3VIwFP6BnRTr0=3D?=
X-Exchange-RoutingPolicyChecked:
	1JDcjZlzWIvDCkq75y9gl127sBcgy8/QzRS7GfeJBHuAgSJ3zOAb5IbhjK/mUYN8KXKP02m6YNbc/SnqQ1WpBTJ9c63xlKZETwLXC6qqkz7n5Um/O88HlBcrqtUmCTsum0SmwhtDQhZdaCS/ENaimHNGrKLO8oTDVgoZEHfwbsm3ea+l+v4ln6hgyD4wfxUMjJnIOa6N7PGUCQey6WNp8ZYBZHmuck2sT9xK5hR8mJjuGxS6GZHbVp5a6aZxbsNg8Enxc0TYAj8mCHWd2DoGqMGYEWfU+pdvW94iLIORzDX+8I4+R50gEpUyChA+RDBjOytiMV/WEUThA2buU0hh/w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+HbTOwv+Vh+hr5rySizYgNrmwBCI8mX9/F4oUQVtCf+3dNNcxt6ymB37yXmRuJFn5ZRD5jScHH/8TmMmRTeRxAdt26WjVTen5Fqauz3hzd+CDN/m1cux+9AudfMuqMHV2rDwn85IsxfjpC6TH61SALaDIf76j2uSdl5SYnW+JZwKKec3hQ0jfqXCJ9cDetDmA8+wFVsFlK24u3YWw6rQD7SfoHuTqf/hK3F3MBA1z9n7O58TE0hamVGkD30OzLwWOHB6J98XnciQpYDt7xt3Z/sfJ+ZSqp9Od7YqFH2DL3NA7wbJ4VjOFXgmV40SGJDr3d/9z04hejMFEh/4cxh2ZePxIja3TBfIrwDimTfLvkSsRCIipeUTfwdYn5UFwPt2T9pOAPJenfUwVm179P9gvsSigD0U5Or81CHQGksuJqC0tmXB25gGHQY0kZsMOgyTbyq2B8MClAMoJOOBm+ghyIHlQdCH5PC+zgLqQEGHz/zkK0/O4cpQ4WNVknV4oL6FF2vBZCUbEDrwRpCMevL0/DLaNiT90TbN/++xWattzkmj5zYt9d5jIRJAgd1+lTAQh3GE4EhxQ20lbzuUhpd55MBfErnnyvIWkoV41JnAMfHTP5sQKjhC4j3kA0h+Rpjm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e566e95-890b-4c74-3f3f-08df0ff8f867
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 11:36:50.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lNTgfE5CZGYu6QznumU2QRrCO51pPiw0DBRnUUhTID821sl4NLj+EgV8xPYcggX1+O+VAgGMj995Zb3+aildwKDSEjvdGbRdzmmAw6AyEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6802

On Sep 08, 2026 / 14:48, Mohamed Khalfella wrote:
> HAVE_C_DEF feeds its test program to the compiler with "echo -e". The
> $(shell ...) function runs under /bin/sh, which is dash on Debian and
> Ubuntu, and dash's echo has no -e option. It prints the flag literally,
> so the first line of the probe becomes
> 
>     -e #include <linux/ublk_cmd.h>
> 
> which is no longer a preprocessor directive. The header is never
> included, the tested macro is never defined, and the probe reports 0
> regardless of what the installed headers contain.
> 
> The only user is HAVE_NEW_UBLK_INTF, so miniublk is skipped with
> 
>     Skip miniublk build due to missing new ublk interface(v6.4+)
> 
> Use printf instead, which expands \n in any POSIX shell, and pass the
> substituted names as arguments so they are not reinterpreted.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

I applied the patch. Thanks!
