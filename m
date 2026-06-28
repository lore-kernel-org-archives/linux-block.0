Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021096.outbound.protection.outlook.com [40.107.130.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D072AD03
	for <linux-block@vger.kernel.org>; Sun, 28 Jun 2026 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664825; cv=fail; b=ILZZkhHmjMV7cIiudrlEXkhk55jeeEMQqkbGuCdJvLmWR85jRB9uHlq1LiIEJuVKhoWNayqDR93J361hc+2V68DopVv6621M04W0boz24bp342RXINkeRUD6OUqrP4Xue/5lMkhEltCUv+KESzEjKIx5SIauuVjHQpnFx9v3a70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664825; c=relaxed/simple;
	bh=vnNDWhfZ4WuQ1VZb0ymDoYsex/qRylOP8U8NYrolaHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tskdg8FQOk8scLss+SSfWTrI7YgXia+5uP3+h5jXSvlq+EJdSEt9zV8GFTm7IC9PH4NdQcKa+wU6RnY0hH7bGzjeD5ZbUhgZT5usFAbK3S7UIn/ChTNcN1Ezegj1t524tGhMrm+fQdfoaTw1IZm/J5w2N8SYamtR1GGp+jkwBqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=macqel.be; spf=pass smtp.mailfrom=macq.eu; dkim=pass (1024-bit key) header.d=macq.onmicrosoft.com header.i=@macq.onmicrosoft.com header.b=YeA+2jQM; arc=fail smtp.client-ip=40.107.130.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=macqel.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=macq.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=macq.onmicrosoft.com header.i=@macq.onmicrosoft.com header.b="YeA+2jQM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knXFYzakQqxn4MX855UOfj5d7iN6shAaM5cOUQ+trVeRn2mKNvztwUuKhdGat5X0XkTj5XXTMwe0BsOuvddVILxYcXIcObU50xmymPJCmWPG8aDpycmIbZL0z7y9+0mtn3Ph36U7LRtFEqOo1Djq3OAh8d0RlZC4TSpn8NxCd4sjwsx4QevRnCs4XAjAn4m+OZjChq30Gtv1Ir5IIJwp/tbD/cr9VAKIKekNhN4O9mFyvyFmMLR9EmU37tHhyAfcZN5O83agAqUDGyQrUwxXLgAJ1qSnqpiUKB7KVvCjeHNdlFVWJWgIEx+obaYVPAD32yJgZx+1lCsoJ4uyCF/oYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPgQy2WIaXu3OhOl7K7MJhzXdi2J4ZZBCq4zjw7ANqM=;
 b=CCIOPWnSLtD4CO0EmhRrykEn9E6HwNaAjhFjWxyq7GpuH9DDTTKX4K/kRbMD0kdnVbAUHJiZlQ1fs3t4oAg9mWCiq/FvQtAS9dYrxepqhlo1BENg0f6uJjD0X09rWC61C1YkWUPcqLoJPKC09s6sFH8frwyLPXok05C9UDwAbTdX+zw5mOB+CtfxlI9R5uO4EPMvRBKv4wla0KNsCeyrgyf24++Mi6UHxIQod+WxyuVQPQBsiLKB7fJ+bRTEQB42wFe+RhKyk2N46r7yy0sJblxF60WZn3xtqy32z6lHWQ+T/nriEBk5sN9pLM1b9QP8MW4v0wZUd/s0FXQ0vOULMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.183.173.212) smtp.rcpttodomain=gmail.com smtp.mailfrom=macqel.be;
 dmarc=none action=none header.from=macqel.be; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=macq.onmicrosoft.com;
 s=selector2-macq-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPgQy2WIaXu3OhOl7K7MJhzXdi2J4ZZBCq4zjw7ANqM=;
 b=YeA+2jQM3Bf0YoapUBBmqMyoFixWMoqqFBwEJP+Ao+G6os9tWYQSS1KaqWCwGEB5gs+aKY8FK5+gNRBbyQliRwEvDtAEYX6jljEZKmvJ3vLxY+Av8gHzpZUL5OH2HJLNcqoueE5H5+YdweHrvO1ydpCIs7zMzjX2Eh3CzErRZ5Q=
Received: from DUZPR01CA0297.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::8) by AS5PR05MB11071.eurprd05.prod.outlook.com
 (2603:10a6:20b:67f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Sun, 28 Jun
 2026 16:40:16 +0000
Received: from DB5PEPF00014B88.eurprd02.prod.outlook.com
 (2603:10a6:10:4b7:cafe::7f) by DUZPR01CA0297.outlook.office365.com
 (2603:10a6:10:4b7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Sun,
 28 Jun 2026 16:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 91.183.173.212) smtp.mailfrom=macqel.be; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=macqel.be;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 macqel.be discourages use of 91.183.173.212 as permitted sender)
Received: from frolo.macqel.be (91.183.173.212) by
 DB5PEPF00014B88.mail.protection.outlook.com (10.167.8.196) with Microsoft
 SMTP Server id 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 16:40:16
 +0000
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id 4742CDF00C7; Sun, 28 Jun 2026 18:40:16 +0200 (CEST)
Date: Sun, 28 Jun 2026 18:40:16 +0200
From: Philippe De Muyter <phdm@macqel.be>
To: tt roxy <roxy520tt@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, linux-block@vger.kernel.org,
	axboe@kernel.dk, kees@kernel.org, hexlabsecurity@proton.me,
	objecting@objecting.org, akpm@linux-foundation.org,
	yuantan098@gmail.com, bird@lzu.edu.cn
Subject: Re: [PATCH 1/1] block: partition: aix: bound LV name formatting
Message-ID: <20260628164016.GA23966@frolo.corp.macq.eu>
References: <cover.1782398104.git.roxy520tt@gmail.com> <6f381f63ccfe458e15067fd9b9428884cb8d5f97.1782407859.git.roxy520tt@gmail.com> <20260626090929.GA4627@frolo.corp.macq.eu> <CALMqdkS0arRS5FSsbPBiHAZzU-NeDEBhm01-r5v00GFQN=sx8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMqdkS0arRS5FSsbPBiHAZzU-NeDEBhm01-r5v00GFQN=sx8w@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B88:EE_|AS5PR05MB11071:EE_
X-MS-Office365-Filtering-Correlation-Id: 2657c2fe-9098-488f-161d-08ded533ef2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|82310400026|1800799024|18002099003|22082099003|11063799006|56012099006|3023799007|4143699003|14776008|75936004;
X-Microsoft-Antispam-Message-Info:
	YGg9ufX5fK2bhevBhshYLNcO1gGYQYemKyNn8+OycGFoGJqqvkSQ5CGh05sXx2bw3g7xikhG90GYYebfzDAWnP3Iyxb17QZ1PTgjc5EkhEwRSgVhUyIdj1muRchHFCRFSvIPpbwZ6C/+xd6lCk9c3eq2gcaI26r0fzVzO2PQe1MIBuHtMPIstDHi/DLP/HpN137/m5wdCdZ35hYzQHcG1v8bChLVsA8G/0xT/X7/Qo6aVRM0oB72y2vmiNHDkVk2rU+Oxrno2JZKIGSpwhTMlxF7ldqxc9SqO14IhHFe2e078ZkBopV/uCl69DsIq8+9vlxI5pfivnILoMkN5Efokp8gKZSOOfhDpjYcdpnNZ5+9AC1DkK6NHDz2LuVZQ4fYz7uMO9zpZ6p695xngUBsgvIiLxdUM+FO6v1chD26qRgpMbQGFbzZFdSEbGx3jc8U6zNJgj3TU0zqkM5s4VJulauvKBCgoAHjhlwZPCTCYJ38zJ/zup6DWUq0J3IGj8UpJ6cDH1o3p5jF3nlyXlGG6rTRODSwPTg5hT686h7UIJlM/vNNkgzwtRaHz6wNrZ4zVDuUaAxcEnd/iVe8hApG1z5G48137Tbv9rDcu+rIeJs3UflI4ttdI5c4qqjFsQiWTGvqQkgvz/TidIfmBGiVY6aTcLglbygiB5ZB3D4cayiFPFST9qBDFC/q9THiRxBXKZy/jhbiqwbglz4uco2JzY73QO5VYy0bWihYCUb0oSauKpuqu51wghQmFy71Eu06562SeuFT+p6KG7HzDL5Abw==
X-Forefront-Antispam-Report:
	CIP:91.183.173.212;CTRY:BE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:frolo.macqel.be;PTR:212.173-183-91.adsl-static.isp.belgacom.be;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(4143699003)(14776008)(75936004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MMUGMqtufrrF77Y728OJSuVmdVMfxIismSS7SEFpaIOZUbYK5Rd2ir+dyC5Iw7W8myB4BMRWMC7VpA4e2R8u4UXJdoyr1m7ml/F4QUfBiaODfX4jx664VxEJreY0AqCFZ6dT5hMQCk4qrSIFKlvgL80r+2z7KjjTgccOpp5fNnZTbz1OPOCOeDdmuQVx9aI2jRd3dDI5kAWanjuhmj/0TdkSe+MmeEY51b3MSmfICTkIxect53malTojdU7dL0K0XYmXsGW+K5yJ9i7onqeWiuWd3L7sroDcQn33aZTzbBxBfbca1NIO83rOIY/cHXNo0r5lSys1LLOFQdncar3oQQklDU6C//rf7CpJoeEPletwvmqmBGIYm/IYd7ZeYrOWgQ9D5ZE1Ps3Ep/YrhNLJ0F8q6ZHqNgEj6KIc06dZ/+VU0hfimlLtc8xELa6OjRfg
X-OriginatorOrg: macqel.be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 16:40:16.4930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2657c2fe-9098-488f-161d-08ded533ef2d
X-MS-Exchange-CrossTenant-Id: 5541087b-384c-4066-992a-42aa5fe171eb
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5541087b-384c-4066-992a-42aa5fe171eb;Ip=[91.183.173.212];Helo=[frolo.macqel.be]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B88.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR05MB11071

Hello tt roxy,

On Sat, Jun 27, 2026 at 12:37:50PM +0800, tt roxy wrote:
> On Sat, Jun 27, 2026 at 4:50 AM Philippe De Muyter <phdm@macqel.be> wrote:
> >
> > Hello Ren Wei,
> >
> > On Fri, Jun 26, 2026 at 03:21:22PM +0800, Ren Wei wrote:
> > > From: Zhiling Zou <roxy520tt@gmail.com>
> > > @@ -273,7 +274,8 @@ int aix_partition(struct parsed_partitions *state)
> > >                       if (lvip[i].pps_found && !lvip[i].lv_is_contiguous) {
> > >                               char tmp[sizeof(n[i].name) + 1]; // null char
> > >
> > > -                             snprintf(tmp, sizeof(tmp), "%s", n[i].name);
> > > +                             snprintf(tmp, sizeof(tmp), "%.*s",
> > > +                                      (int)sizeof(n[i].name), n[i].name);
> >
> > Is this change necessary ? snprintf always adds a NULL terminator and
> > truncates the input if needed, isn't it ?
> >
> 
> Yes, snprintf() guarantees that the destination buffer is
> NUL-terminated and truncates the output.
> 
> However, with %s and no precision, snprintf() still treats n[i].name as
> a NUL-terminated source string. If the on-disk fixed-size name field is
> not NUL-terminated, snprintf() can keep reading past the end of
> n[i].name while looking for the terminator, before truncating the output
> into tmp.
> 
> So the issue is not an overflow of tmp, but an out-of-bounds read from
> the fixed-width source field. The precision is needed to bound that
> source read to sizeof(n[i].name).
> 
> > >                               pr_warn("partition %s (%u pp's found) is "
> > >                                       "not contiguous\n",
> > >                                       tmp, lvip[i].pps_found);
> > > --

Actually the 'tmp' buffer is not needed.  Printing directky n[i].name
with '%.*s' in pr_warn would be enough to fix the problem IMHO.

Philippe
