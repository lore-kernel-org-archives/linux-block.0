Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1BCC5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 09:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD882082F
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 09:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="MtXsz5XN";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="TMwW6r+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD882082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbeLKJu7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:50:59 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:54078 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726201AbeLKJu6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 04:50:58 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBB9mIgf007754;
        Tue, 11 Dec 2018 01:50:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 cc : subject : message-id : mime-version : content-type; s=proofpoint;
 bh=k6K7LkHq6jG/Ua3yOR9aq3JQ+h6HV58PI4bDw6eVtCM=;
 b=MtXsz5XNMAfYSfGUV2jcDQy/St3AtIuzobHKF/ZmGZlQD/rfaUL1VP7RVHpkHvFgPuta
 8xREXGBg+l60/55DeSqQZGJ80smFXWZAIFXpUct1S1UfRiCF5xuCbM/X4Kk/26umqYUd
 cpnGDr+/O4OxDIQpPceQ44eLQ7i+BODYwjNZrh2JMZc/tzJhAH8CGgvzgQHHNamxMDAF
 0KIUaYE4mTYBDNgAgfNadbcej1vVDQuliQElgFkkFbj41ZjbTwAUpbRWJMS6SF/JP41W
 VdXtBIwvQPdCgnE7UeVO+IWXcRrGv7qOIhbf44DnIrEz1FBUBKx3FTVPRx6u1ugGm3Eg eg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2p9wg8bkjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 11 Dec 2018 01:50:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6K7LkHq6jG/Ua3yOR9aq3JQ+h6HV58PI4bDw6eVtCM=;
 b=TMwW6r+3WQz31j+1mL/sK19faUEgZoQ5yKsz/B8fRHrDMWrZhoB9XKxPX5wxNi2Zmi3QlzLJOpVnBcQQ+oOg61jACLPTVZe4EW9Fn5KWiltlpavBPsGp5+DYWsUwGx1P3yKIaeUjcZe1tSWvJOTjEhthzVYQiY7EmoY8GAQpboo=
Received: from CO2PR07CA0045.namprd07.prod.outlook.com (2603:10b6:100::13) by
 BN4PR07MB2163.namprd07.prod.outlook.com (2a01:111:e400:59c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.18; Tue, 11 Dec
 2018 09:50:32 +0000
Received: from BY2NAM05FT014.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::205) by CO2PR07CA0045.outlook.office365.com
 (2603:10b6:100::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.19 via Frontend
 Transport; Tue, 11 Dec 2018 09:50:32 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT014.mail.protection.outlook.com (10.152.100.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.5 via Frontend Transport; Tue, 11 Dec 2018 09:50:31 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wBB9oSmA029047
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 11 Dec 2018 01:50:29 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 11 Dec 2018 10:50:30 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 11 Dec 2018 10:50:30 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wBB9oRRD004358;
        Tue, 11 Dec 2018 09:50:27 GMT
Received: (from pthombar@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wBB9oRvt004352;
        Tue, 11 Dec 2018 09:50:27 GMT
Date:   Tue, 11 Dec 2018 09:50:27 +0000
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <axboe@kernel.dk>, <vinholikatti@gmail.com>,
        <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <davem@davemloft.net>, <akpm@linux-foundation.org>,
        <nicolas.ferre@microchip.com>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
CC:     <adouglas@cadence.com>, <jank@cadence.com>, <rafalc@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH 2/2] scsi: ufs: add inline crypto support to UFS HCD
Message-ID: <20181211095027.GA3316@lvlogina.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(2980300002)(199004)(189003)(36092001)(4744004)(86362001)(23726003)(426003)(26826003)(336012)(246002)(5660300001)(7636002)(105596002)(106466001)(8936002)(478600001)(1076002)(46406003)(356004)(47776003)(305945005)(2201001)(14444005)(2906002)(4326008)(107886003)(87636003)(486006)(476003)(126002)(33656002)(8676002)(186003)(26005)(7416002)(97756001)(50466002)(39060400002)(316002)(16586007)(110136005)(42186006)(54906003)(58126008)(18370500001)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR07MB2163;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT014;1:+4+A68TR3OU6MaAr5tI8yzHo0HmWuXlNK4f2pxRDtL91DcJUk1OnTk6D8cj2XxRbiiECiZy/Sj3Gyw+EB/8/8KbeZkKvK/7WyrHOBvRU+vSaZpauE7AWJco9mcFVghdB
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e96111ce-374e-403e-fddc-08d65f4e171f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:BN4PR07MB2163;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2163;3:PDWsFdCdXQ52TsnB+vGhJrUlWLZDNhCOZ1xxAXofzSpG3pQheXB4p+CqEonwsZIO59gcwQ8SP7mruawwlp55I20zZVi03s0iUIn3SKaj1Oz+N07FWn1AomjdhcIkGikGu7oLJrteIrOES1UQtzi6hKHzfVn1lSQEvmSodN9jY7OLBG4WjYq+9zP7uPe27ll2X6eEm4kRjen4qZ1YknJCVpqrblHLrZJf6Tv3jlySl60wHlIAOPfoYTzND8DZJypVQWtRR6vKERlTWQqMT1fPISSs4DUMpQtBBprNkAu6vc/Gms5jp5JJh8V+RS61ZV+OVaFPeQ/HIGZl/8ehhdqt30JupHKYPnfi0MX+JNyBnLw=;25:2CKmULp4uqqPw2ayfJJesLx80UWW3AmTVRRJoJISZp6w1+J3Zm/kNiGV2vxba/9u49+COLSHjsv7QFtodnRitNrVfB3MZeYu166YSJ57cvKhIsHxvtHq7Yq4cxK10ACy8+PKF/8UCEvJCPR3v+YS5EtmQpCzd4WhFjhOYGRbwHLeKLnR+e09CxuA//U3ZktBciyLvXH0IhcEp+u8vCSQueKjKsCSyqj0sBBHmTbpcOEihQLZtdG0skSeJC6sJuWDjEMk+2CtonUAzlsnbhy1xLPbxOOMme8muSz35nxl6ikm39PmE9kDTvjNUS+iHBYGJwiaMk1lj2GNavKFsFFoJg==
X-MS-TrafficTypeDiagnostic: BN4PR07MB2163:
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2163;31:VD4Ed+x39a3i6AGTl/y37FR1Clq/QrDEXPOAksYKryB58eJX6vUG3lSr/dIJxAZPrRHGKV5s3R75eu2tc6QfhVR/dLBiPSlFgudNLbQrs8KdZgb+uji9YoLTs89p1lsMCF2jYUQRArDVrdiWSnBgIfW7Pd4e2Yec/9kHZ5Aq2aIPsbGl/QtPLxJPhBf3aEZ01xOXVaNBfKMRkRQ/uvyX0tnUMrKBxcf3vHyLEhYw55s=;20:jXUPEkA1/A7X1nENMTo1esZf7UKUUT33+IA9gSbSMpvhLm9PFSuqOPw+/w2Li4muK1PrggdVgB9dydb7WBgIlKYklT6O0h+4WUuleXfhXQJ8joqh91U+m832Ois/OI08UPT+1URqkjbwqRkC6WsqRUTGaNhiIOevuVs5T9ipbc82HhDaeOxQxTJkJjD5lzHvpphbYDVQSc8/PYnP39h114qghJNoWpxgypv9D3cQsumoyo0rq+HGnrruP1rsd69y5hTuZLtT/Ua3++EOe07uhzr5F5lT9OXKPxi6yYgcvrTwCiHdg008hchZJ8wtxXohNFws5RAj3SGuKJDsKeRJusfHZpQjNxPMIz0QZkAGHjuyUL53Ae0E5UOAycMSRdKT4f44rjs3CFfPLzTlQ1jrva9IQfwpi81dvnwDNLcFK+5P8sHj4AkynmmzPvSh3r5hqKHwKsP3RPRrk+SKIAfmlvBHNYbh1ysZxzAt1N0AMgpHBjae4lcVyxnLhRs//Q+N
X-Microsoft-Antispam-PRVS: <BN4PR07MB21637101D2B8CFFAF6AE3421C1A60@BN4PR07MB2163.namprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93003095)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN4PR07MB2163;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2163;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2163;4:Y9JbfO+fC7YjfKucCnwmIksl+8ut6NADaxjLtIWKtvs38ciY3/q2dup5foWjthCVWQrqnm47JUTq6faoki0retT/JNM8QkFr0FUUbN98+O5iuq18t47dB4fX+ZKk6SK66HexPWPj//m7AArKPH6EhOsZ9EfD6uwZ7xtyWdxq7PgaJJUXFDPzge06t120I2hYooatCu+naS+BibGV7wT23Fz7uu8Q3ZD2uG9lHIHkZclIxVGtgZIK/pAF20189qokHzy0XF+GHzO3qquABCCAEQ==
X-Forefront-PRVS: 08831F51DC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN4PR07MB2163;23:6v11FVhUeaKhBCL5Y+T+T7yqLhmV6VDJ6Yt7b8kNa?=
 =?us-ascii?Q?0vCsnPduUwlRtC1PEG/ibrhWmOaa/hzBvDxC18D2WOIgu75Jc6uD8pPaFY7n?=
 =?us-ascii?Q?NdesZOdFfGt5GeyWz8Fp76sIjuFQW++9/M450CLnO4Hjdl+iTAOiYrDd8K3F?=
 =?us-ascii?Q?AjqosoW1VX890COTam3cX5JyHb7cxlcLwh0y4y2+S249D2nS8lQiv+grVVV/?=
 =?us-ascii?Q?9FKCOp28GNPobm86ZeZ3JtvFVUBvDV4m7z+3y39zOk5bthgatIQIa5AiYZ2f?=
 =?us-ascii?Q?HMrsfAtxO/F4tG41R8IPJovqJgZnlh3iuzchqtvgYcHM7OFPNqOjmfHIwk8H?=
 =?us-ascii?Q?1ied3kdJBwXv7fJxNxfAJ4REONXBxqf6Y+T3DzTTlHfsNL/KiQr5yx7C8Jp9?=
 =?us-ascii?Q?W9u15ThvQstND9g0X1kSTVyobmYsTBPzwzo8L+yyejjIisIQJTf73unqEszU?=
 =?us-ascii?Q?kLDAl2XkB9AyYBFTXqKupTPoox5cuBoLI+/RWnJlYLkbwtSSHzJWiBZV+6Sa?=
 =?us-ascii?Q?djYU3ULhYUdoUHmbKtLZHNP8AW+Ka4FSI+WbfsKEx5oEeu9+dfRrPJvbptbR?=
 =?us-ascii?Q?OeKdCJF/mrSRjsqz0hIStK7RT/w3WVoXqvkYIsWNd0MIrC47L8gcyQJbP+0m?=
 =?us-ascii?Q?gmidRSUCnjV+rtfJtKEvfhTxTHu31n800BnnjiRxrZIxufTIuNefAYcnC2Qj?=
 =?us-ascii?Q?TpGKiflG2F0I/9ROtXlClbkuSv2mKmkCHK1uaylJaZnHm1NMOJoBcXNaGoCG?=
 =?us-ascii?Q?r5J03qp0n/Hz7AUnYoCyw5OrAtFuZb67u+RziDM39W8JbgK+ze6iicD5aVES?=
 =?us-ascii?Q?BO7anJy5SdGs6mCBzQogUbHV4ksnVUeJQ8dwKnxhJtGQwXsSrd+yyc/PxXCp?=
 =?us-ascii?Q?IfyG8gkQV4LYvS8D6BwKC893VodxcSSLg+MjxzenChSiQr2LiXSXBZqgabAq?=
 =?us-ascii?Q?XMANknYx9Y8bOS5km+AkwvY31dEgePvqD4vI0CFgDREbcXwRE7TRTvMgriXG?=
 =?us-ascii?Q?Lxc0ayrGNpWGfpzrgup9QHm+22EJsPoOo7Vzt2QqtLs9LYRv37vHOh7zWWfX?=
 =?us-ascii?Q?NBZC7CCv1Uj8VvB0NDlABhPnTkzHSLmw8Wp6zAG7uKevhRhPNudvgFf/3KXt?=
 =?us-ascii?Q?Vf18ihCpUjHbf2VaIk4Lf4T16BdhM4Qtv2os/9svnuFV/0Rcgg4y5mJJZuiz?=
 =?us-ascii?Q?Y54odUAi8TCVc2YzD0kn3qpMpFf2azGGEscYVZVOKn5L3B6jNoaupVeSg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: N8K4WPUyGcCfel2vjSPqUX9ljxCkVFYAII+h18/qIOO0ajBxzdEiy/aDy2MXvEPL2o/qtIbtpMX5LN/yWpEmyToSmSAAu6KiMUxfCdSYIf9m2Uv5baIGKKTYjw/pIF5KbwevZm7jVPi1H3g6emuVzhYzU4WlWWOTSWfKVtld7x7Cw+epk1aJHlnTFEpc+KvL/86MpvwDh8J4UuU5X8aBDtl86F6L+RsC44ticKbaJ9vVxBOZysgMQ9pqz/bYYJe4cXLjMyQSZrPjcB2rG8t8V3lZiiXPzK9M9RQdnMQXicxO6zsXqVs1LRGH/7VvMpw7
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2163;6:X9diTbNe4FWfrnWJort5cEh0V97WV9nQ7TKCxPtQH/BNmYgyQ1G4/WM1ZCnd1g3sXsG+qQLPynF+KHhxLpd7DxY9odYk93dI+X2aG+8q76GZ/g8EpciurrcQ6PEV4ig4iJCF2qXpcvMfwbLvxLQf8iRX8qmQ9t2Fes4fU6Q/DDxF3HBevZUmAx29t6s3zkL+TCZxuRVVUEckVvsI5ao6dnb2BMx5+vFL0wBEvZka+DVNnnGLpW6gR5aZK+zsrR/vZ1hUigCL+e2MxIIb36fXqyusZjy9aL2Ew/bP4cNfamjKK+/QwltXaJLX6UVbhq/gq1HWxLFQtEMjm4/HbJAJkcnj7RE3533rq6lGUOKzEHnfH73c81qcn/WfFW7mKtBZ/c0Nse0P1d7bXgW63TU0N3hRCmsp8wv5rO91ETiez2hlctoGQ6dv7wT1yrFctHr2nV/ql2rwLVDcHKM5kpX2lw==;5:XQNxCvOjOM4lYFaoyTerGmHAoBetZgME9m+zFeV43mSUqo7ZB0JEC0ttPJ0/yE3avYIEtk6ZDT8YRQ2gD+EHmstACE48CcvQe8rgOOWtE5Z/7LS0WgPOcA8wGx7yr7c/MXIQgsBlb+b/qPwqlyjtOl0zknNjGgoL6YFbv7Vozwo=;7:GmA6QLEVjdOaHYdoA9TcJfGY/hve3m0f6VZSARlHIhsLLtep+qkGjVHQivXcd9QMDxsN26f79Z5rnfrwPiWwlIwzHUakyLHB1g0wwaWbJLZEVDlFhNZ5rqWZ2KAgDrkH3/3+IEWHRs6GvMKUykJT1w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2163;20:fA8HFY5ybSKKYe9MLjKiaUyhlnBEwpwL2Y3CGo1YKjcx0RTflnSTAmFl4KKbeAprA1Q6TRVPubNcy7NeXrsvmDWaELx2xUjfyKLx67c/Qh65+Y3PZLqetaqUAbr4sDq1rbXEAf8509OUVqSqNl3CV31z7QiWeHAaIG5dpFGeZn5XGNFwwMGd4HR4URg+VpSV1iwgsafLHpvZe+sY1yzHGRekbfAVH/fAfgW5zUK9xipb3iL892kCqHM0mE6I2CWv
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2018 09:50:31.8939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96111ce-374e-403e-fddc-08d65f4e171f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR07MB2163
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110093
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add real time crypto support to UFS HCD using new device
mapper 'crypto-ufs'. dmsetup tool can be used to enable
real time / inline crypto support using device mapper
'crypt-ufs'.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 MAINTAINERS                      |    7 +
 block/Kconfig                    |    5 +
 drivers/scsi/ufs/Kconfig         |   12 +
 drivers/scsi/ufs/Makefile        |    1 +
 drivers/scsi/ufs/ufshcd-crypto.c |  453 ++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd-crypto.h |  102 +++++++++
 drivers/scsi/ufs/ufshcd.c        |   27 +++-
 drivers/scsi/ufs/ufshcd.h        |    6 +
 drivers/scsi/ufs/ufshci.h        |    1 +
 9 files changed, 613 insertions(+), 1 deletions(-)
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f485597..3a68126 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15340,6 +15340,13 @@ S:	Supported
 F:	Documentation/scsi/ufs.txt
 F:	drivers/scsi/ufs/
 
+UNIVERSAL FLASH STORAGE HOST CONTROLLER CRYPTO DRIVER
+M:	Parshuram Thombare <pthombar@cadence.com>
+L:	linux-scsi@vger.kernel.org
+S:	Supported
+F:	drivers/scsi/ufs/ufshcd-crypto.c
+F:	drivers/scsi/ufs/ufshcd-crypto.h
+
 UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER DWC HOOKS
 M:	Joao Pinto <jpinto@synopsys.com>
 L:	linux-scsi@vger.kernel.org
diff --git a/block/Kconfig b/block/Kconfig
index f7045aa..6afe131 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -224,4 +224,9 @@ config BLK_MQ_RDMA
 config BLK_PM
 	def_bool BLOCK && PM
 
+config BLK_DEV_HW_RT_ENCRYPTION
+	bool
+	depends on SCSI_UFSHCD_RT_ENCRYPTION
+	default n
+
 source block/Kconfig.iosched
diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index 2ddbb26..09a3ec0 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -136,3 +136,15 @@ config SCSI_UFS_BSG
 
 	  Select this if you need a bsg device node for your UFS controller.
 	  If unsure, say N.
+
+config SCSI_UFSHCD_RT_ENCRYPTION
+	bool "Universal Flash Storage Controller RT encryption support"
+	depends on SCSI_UFSHCD
+	default n
+	select BLK_DEV_HW_RT_ENCRYPTION if SCSI_UFSHCD_RT_ENCRYPTION
+	select BLK_DEV_DM if SCSI_UFSHCD_RT_ENCRYPTION
+	help
+	Universal Flash Storage Controller RT encryption support
+
+	Select this if you want to enable real time encryption on UFS controller
+	If unsure, say N.
diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index a3bd70c..6169096 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_SCSI_UFS_QCOM) += ufs-qcom.o
 obj-$(CONFIG_SCSI_UFSHCD) += ufshcd-core.o
 ufshcd-core-y				+= ufshcd.o ufs-sysfs.o
 ufshcd-core-$(CONFIG_SCSI_UFS_BSG)	+= ufs_bsg.o
+ufshcd-core-$(CONFIG_SCSI_UFSHCD_RT_ENCRYPTION) += ufshcd-crypto.o
 obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
 obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_HISI) += ufs-hisi.o
diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
new file mode 100644
index 0000000..9c95ff3
--- /dev/null
+++ b/drivers/scsi/ufs/ufshcd-crypto.c
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * UFS Host controller crypto driver
+ *
+ * Copyright (C) 2018 Cadence Design Systems, Inc.
+ *
+ * Authors:
+ *	Parshuram Thombare <pthombar@cadence.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <crypto/aes.h>
+#include <linux/device-mapper.h>
+#include "ufshcd.h"
+#include "ufshcd-crypto.h"
+#include "scsi/scsi_device.h"
+#include "scsi/scsi_host.h"
+
+struct ufshcd_dm_ctx {
+	struct dm_dev *dev;
+	sector_t start;
+	unsigned short int sector_size;
+	unsigned char sector_shift;
+	int cci;
+	int cap_idx;
+	char key[AES_MAX_KEY_SIZE];
+	struct ufs_hba *hba;
+};
+
+static int dm_registered;
+
+static inline int
+ufshcd_key_id_to_len(int key_id)
+{
+	int key_len = -1;
+
+	switch (key_id) {
+	case UFS_CRYPTO_KEY_ID_128BITS:
+		key_len = AES_KEYSIZE_128;
+		break;
+	case UFS_CRYPTO_KEY_ID_192BITS:
+		key_len = AES_KEYSIZE_192;
+		break;
+	case UFS_CRYPTO_KEY_ID_256BITS:
+		key_len = AES_KEYSIZE_256;
+		break;
+	default:
+		break;
+	}
+	return key_len;
+}
+
+static inline int
+ufshcd_key_len_to_id(int key_len)
+{
+	int key_id = -1;
+
+	switch (key_len) {
+	case AES_KEYSIZE_128:
+		key_id = UFS_CRYPTO_KEY_ID_128BITS;
+		break;
+	case AES_KEYSIZE_192:
+		key_id = UFS_CRYPTO_KEY_ID_192BITS;
+		break;
+	case AES_KEYSIZE_256:
+		key_id = UFS_CRYPTO_KEY_ID_256BITS;
+		break;
+	default:
+		break;
+	}
+	return key_id;
+}
+
+static void
+ufshcd_read_crypto_capabilities(struct ufs_hba *hba)
+{
+	u32 tmp, i;
+	struct ufshcd_crypto_ctx *cctx = hba->cctx;
+
+	for (i = 0; i < cctx->cap_cnt; i++) {
+		tmp = ufshcd_readl(hba, REG_UFS_CRYPTOCAP + i);
+		cctx->ccaps[i].key_id = (tmp & CRYPTO_CAPS_KS_MASK) >>
+						CRYPTO_CAPS_KS_SHIFT;
+		cctx->ccaps[i].sdusb = (tmp & CRYPTO_CAPS_SDUSB_MASK) >>
+						CRYPTO_CAPS_SDUSB_SHIFT;
+		cctx->ccaps[i].alg_id = (tmp & CRYPTO_CAPS_ALG_ID_MASK) >>
+						CRYPTO_CAPS_ALG_ID_SHIFT;
+	}
+}
+
+static inline int
+ufshcd_get_cap_idx(struct ufshcd_crypto_ctx *cctx, int alg_id,
+	int key_id)
+{
+	int cap_idx;
+
+	for (cap_idx = 0; cap_idx < cctx->cap_cnt; cap_idx++) {
+		if (((cctx->ccaps[cap_idx].alg_id == alg_id) &&
+			cctx->ccaps[cap_idx].key_id == key_id))
+			break;
+	}
+	return ((cap_idx < cctx->cap_cnt) ? cap_idx : -1);
+}
+
+static inline int
+ufshcd_get_cci_slot(struct ufshcd_crypto_ctx *cctx)
+{
+	int  cci;
+
+	for (cci = 0; cci < cctx->config_cnt; cci++) {
+		if (!cctx->cconfigs[cci].cfge) {
+			cctx->cconfigs[cci].cfge = 1;
+			break;
+		}
+	}
+	return ((cci < cctx->config_cnt) ? cci : -1);
+}
+
+static void
+ufshcd_aes_ecb_set_key(struct ufshcd_dm_ctx *ctx)
+{
+	int i, key_size;
+	u32 val, cconfig16, crypto_config_addr;
+	struct ufshcd_crypto_ctx *cctx;
+	struct ufshcd_crypto_config *cconfig;
+	struct ufshcd_crypto_cap ccap;
+
+	cctx = ctx->hba->cctx;
+	if (ctx->cci <= 0)
+		ctx->cci = ufshcd_get_cci_slot(cctx);
+	/* If no slot is available, slot 0 is shared */
+	ctx->cci = ctx->cci < 0 ? 0 : ctx->cci;
+	cconfig = &(cctx->cconfigs[ctx->cci]);
+	ccap = cctx->ccaps[ctx->cap_idx];
+	key_size = ufshcd_key_id_to_len(ccap.key_id);
+
+	if ((cconfig->cap_idx != ctx->cap_idx) ||
+		((key_size > 0) &&
+		memcmp(cconfig->key, ctx->key, key_size))) {
+		cconfig->cap_idx = ctx->cap_idx;
+		memcpy(cconfig->key, ctx->key, key_size);
+		crypto_config_addr = cctx->crypto_config_base_addr +
+				ctx->cci * CRYPTO_CONFIG_SIZE;
+		cconfig16 = ccap.sdusb | (1 << CRYPTO_CCONFIG16_CFGE_SHIFT);
+		cconfig16 |= ((ctx->cap_idx << CRYPTO_CCONFIG16_CAP_IDX_SHIFT) &
+				CRYPTO_CCONFIG16_CAP_IDX_MASK);
+		spin_lock(&cctx->crypto_lock);
+		for (i = 0; i < key_size; i += 4) {
+			val = (ctx->key[i] | (ctx->key[i + 1] << 8) |
+				(ctx->key[i + 2] << 16) |
+				(ctx->key[i + 3] << 24));
+			ufshcd_writel(ctx->hba, val, crypto_config_addr + i);
+		}
+		ufshcd_writel(ctx->hba, cpu_to_le32(cconfig16),
+				crypto_config_addr + (4 * 16));
+		spin_unlock(&cctx->crypto_lock);
+		/* Make sure keys are programmed */
+		mb();
+	}
+}
+
+
+/*
+ * ufshcd_prepare_for_crypto - UFS HCD preparation before submitting UTP
+ * transfer request desc. Get crypto config index from block cipher contex
+ * which was set in set_key.
+ * @hba: host bus adapter instance per UFS HC
+ * @lrbp: UFS HCD local reference block
+ */
+void
+ufshcd_prepare_for_crypto(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
+{
+	struct bio *bio = lrbp->cmd->request->bio;
+	struct ufshcd_dm_ctx *ctx = NULL;
+	struct ufshcd_crypto_ctx *cctx;
+	int alg_id;
+
+#ifdef CONFIG_BLK_DEV_HW_RT_ENCRYPTION
+	if (bio)
+		ctx = (struct ufshcd_dm_ctx *)(bio->bi_crypto_ctx);
+#endif
+	if (unlikely(!bio) || !ctx)
+		return;
+
+	switch (lrbp->cmd->cmnd[0]) {
+	case READ_6:
+	case READ_10:
+	case READ_16:
+	case WRITE_6:
+	case WRITE_10:
+	case WRITE_16:
+		cctx = ctx->hba->cctx;
+		alg_id = cctx->ccaps[ctx->cap_idx].alg_id;
+		switch (alg_id) {
+		case UFS_CRYPTO_ALG_ID_AES_ECB:
+		ufshcd_aes_ecb_set_key(ctx);
+		lrbp->cci = ctx->cci;
+		break;
+		default:
+		break;
+		}
+	break;
+
+	default:
+	break;
+	}
+}
+EXPORT_SYMBOL_GPL(ufshcd_prepare_for_crypto);
+
+static int
+crypt_ctr_cipher(struct dm_target *ti, char *cipher_in, char *key)
+{
+	struct ufshcd_dm_ctx *ctx = ti->private;
+	int alg_id;
+	int ret = 0;
+
+	if (!memcmp(cipher_in, "aes-ecb", 7))
+		alg_id = UFS_CRYPTO_ALG_ID_AES_ECB;
+	else
+		alg_id = -1;
+	ctx->cap_idx = ufshcd_get_cap_idx(ctx->hba->cctx, alg_id,
+			ufshcd_key_len_to_id(strlen(key) >> 1));
+	if (ctx->cap_idx >= 0) {
+		switch (alg_id) {
+		case UFS_CRYPTO_ALG_ID_AES_ECB:
+		ret = hex2bin(ctx->key, key, (strlen(key) >> 1));
+		if (!ret)
+			ufshcd_aes_ecb_set_key(ctx);
+		break;
+		default:
+		ret = -EINVAL;
+		break;
+		}
+	} else
+		ret = -EINVAL;
+	return ret;
+}
+
+static int
+ufshcd_crypt_map(struct dm_target *ti, struct bio *bio)
+{
+	struct ufshcd_dm_ctx *ctx = ti->private;
+
+	/*
+	 * If bio is REQ_PREFLUSH or REQ_OP_DISCARD, just bypass crypt queues.
+	 * - for REQ_PREFLUSH device-mapper core ensures that no IO is in-flight
+	 * - for REQ_OP_DISCARD caller must use flush if IO ordering matters
+	 */
+	if (unlikely(bio->bi_opf & REQ_PREFLUSH ||
+	    bio_op(bio) == REQ_OP_DISCARD)) {
+		bio_set_dev(bio, ctx->dev->bdev);
+		if (bio_sectors(bio))
+			bio->bi_iter.bi_sector = ctx->start +
+				dm_target_offset(ti, bio->bi_iter.bi_sector);
+		return DM_MAPIO_REMAPPED;
+	}
+
+	/*
+	 * Check if bio is too large, split as needed.
+	 */
+	if (unlikely(bio->bi_iter.bi_size > (BIO_MAX_PAGES << PAGE_SHIFT)) &&
+	    (bio_data_dir(bio) == WRITE))
+		dm_accept_partial_bio(bio,
+			((BIO_MAX_PAGES << PAGE_SHIFT) >> SECTOR_SHIFT));
+	/*
+	 * Ensure that bio is a multiple of internal sector encryption size
+	 * and is aligned to this size as defined in IO hints.
+	 */
+	if (unlikely((bio->bi_iter.bi_sector &
+			((ctx->sector_size >> SECTOR_SHIFT) - 1)) != 0))
+		return DM_MAPIO_KILL;
+
+	if (unlikely(bio->bi_iter.bi_size & (ctx->sector_size - 1)))
+		return DM_MAPIO_KILL;
+#ifdef CONFIG_BLK_DEV_HW_RT_ENCRYPTION
+	bio->bi_crypto_ctx = ctx;
+	bio_set_dev(bio, ctx->dev->bdev);
+	if (bio_sectors(bio))
+		bio->bi_iter.bi_sector = ctx->start +
+			dm_target_offset(ti, bio->bi_iter.bi_sector);
+	generic_make_request(bio);
+#endif
+	return DM_MAPIO_SUBMITTED;
+
+}
+
+static int
+ufshcd_crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
+{
+	struct ufshcd_dm_ctx *ctx;
+	int ret;
+	unsigned long long tmpll;
+	char dummy;
+	struct block_device *bdev = NULL;
+	struct device *device = NULL;
+	struct Scsi_Host *shost = NULL;
+
+	if (argc != 5) {
+		ti->error = "Invalid no of arguments";
+		ret = -EINVAL;
+		goto err1;
+	}
+
+	ctx = kzalloc(sizeof(struct ufshcd_dm_ctx), GFP_KERNEL);
+	if (!ctx) {
+		ti->error = "Cannot allocate encryption context";
+		ret = -ENOMEM;
+		goto err1;
+	}
+	ti->private = ctx;
+
+	if (sscanf(argv[4], "%llu%c", &tmpll, &dummy) != 1) {
+		ti->error = "Invalid device sector";
+		ret = -EINVAL;
+		goto err2;
+	}
+	ctx->start = tmpll;
+	ctx->sector_size = (1 << SECTOR_SHIFT);
+	ctx->sector_shift = 0;
+
+	ret = dm_get_device(ti, argv[3],
+		dm_table_get_mode(ti->table), &ctx->dev);
+	if (ret) {
+		ti->error = "Device lookup failed";
+		ret = -ENOMEM;
+		goto err2;
+	}
+	bdev = ctx->dev->bdev;
+	ret = -EINVAL;
+	if (bdev) {
+		device = part_to_dev(bdev->bd_part);
+		if (device) {
+			shost = dev_to_shost(device);
+			if (shost && !memcmp(shost->hostt->name, "ufshcd", 6)) {
+				ctx->hba = shost_priv(shost);
+				ret = crypt_ctr_cipher(ti, argv[0], argv[1]);
+			}
+		}
+	}
+	if (ret)
+		goto err3;
+	return 0;
+err3:
+	dm_put_device(ti, ctx->dev);
+err2:
+	kfree(ctx);
+err1:
+	return ret;
+}
+
+static void
+ufshcd_crypt_dtr(struct dm_target *ti)
+{
+	struct ufshcd_dm_ctx *ctx = ti->private;
+
+	if (ctx) {
+		if (ctx->cci > 0 && ctx->hba)
+			ctx->hba->cctx->cconfigs[ctx->cci].cfge = 0;
+		dm_put_device(ti, ctx->dev);
+		kfree(ctx);
+		ti->private = NULL;
+	}
+}
+
+static struct target_type crypt_target = {
+	.name   = "crypt-ufs",
+	.version = {0, 0, 1},
+	.module = THIS_MODULE,
+	.ctr    = ufshcd_crypt_ctr,
+	.dtr    = ufshcd_crypt_dtr,
+	.map    = ufshcd_crypt_map,
+};
+
+/*
+ * ufshcd_crypto_init - UFS HCD crypto service initialization
+ * @hba: host bus adapter instance per UFS HC
+ */
+int ufshcd_crypto_init(struct ufs_hba *hba)
+{
+	int ret = 0;
+	unsigned int tmp;
+
+	hba->cctx = kzalloc(sizeof(struct ufshcd_crypto_ctx), GFP_KERNEL);
+	if (!hba->cctx) {
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	tmp = ufshcd_readl(hba, REG_CONTROLLER_ENABLE);
+	ufshcd_writel(hba, CRYPTO_GENERAL_ENABLE | tmp, REG_CONTROLLER_ENABLE);
+	tmp = ufshcd_readl(hba, REG_UFS_CCAP);
+	hba->cctx->crypto_config_base_addr =
+		((tmp & CRYPTO_CFGPTR_MASK) >> CRYPTO_CFGPTR_SHIFT) * 0x100;
+	hba->cctx->config_cnt =
+		(tmp & CRYPTO_CONFIG_CNT_MASK) >> CRYPTO_CONFIG_CNT_SHIFT;
+	hba->cctx->cap_cnt =
+		(tmp & CRYPTO_CAP_CNT_MASK) >> CRYPTO_CAP_CNT_SHIFT;
+	hba->cctx->ccaps = kcalloc(hba->cctx->cap_cnt,
+			sizeof(struct ufshcd_crypto_cap), GFP_KERNEL);
+	if (!hba->cctx->ccaps) {
+		ret = -ENOMEM;
+		goto err2;
+	}
+	hba->cctx->cconfigs = kcalloc(hba->cctx->config_cnt,
+			sizeof(struct ufshcd_crypto_config), GFP_KERNEL);
+	if (!hba->cctx->cconfigs) {
+		ret = -ENOMEM;
+		goto err3;
+	}
+	ufshcd_read_crypto_capabilities(hba);
+	spin_lock_init(&hba->cctx->crypto_lock);
+	if (!dm_registered) {
+		ret = dm_register_target(&crypt_target);
+		if (ret < 0) {
+			dev_err(hba->dev, "UFS DM register failed %d", ret);
+			goto err3;
+		}
+		dm_registered = 1;
+	}
+
+	return 0;
+err3:
+	kfree(hba->cctx->ccaps);
+	hba->cctx->ccaps = NULL;
+err2:
+	kfree(hba->cctx);
+	hba->cctx = NULL;
+err1:
+	dev_err(hba->dev, "AES ECB algo registration failed.\n");
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ufshcd_crypto_init);
+
+/*
+ * ufshcd_crypto_remove - UFS HCD crypto service cleanup
+ * @hba: host bus adapter instance per UFS HC
+ */
+void ufshcd_crypto_remove(struct ufs_hba *hba)
+{
+	dm_unregister_target(&crypt_target);
+	dm_registered = 0;
+	kfree(hba->cctx->ccaps);
+	kfree(hba->cctx->cconfigs);
+	kfree(hba->cctx);
+	hba->cctx = NULL;
+}
+EXPORT_SYMBOL_GPL(ufshcd_crypto_remove);
+
+MODULE_AUTHOR("Parshuram Thombare <pthombar@cadence.com>");
+MODULE_DESCRIPTION("UFS host controller crypto driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/scsi/ufs/ufshcd-crypto.h b/drivers/scsi/ufs/ufshcd-crypto.h
new file mode 100644
index 0000000..35688ac
--- /dev/null
+++ b/drivers/scsi/ufs/ufshcd-crypto.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * UFS Host controller crypto driver
+ *
+ * Copyright (C) 2018 Cadence Design Systems, Inc.
+ *
+ * Authors:
+ *	Parshuram Thombare <pthombar@cadence.com>
+ *
+ */
+
+#ifndef _UFSHCD_CRYPTO_H_
+#define _UFSHCD_CRYPTO_H_
+#include "crypto/aes.h"
+
+#define CRYPTO_CFGPTR_MASK 0xff000000
+#define CRYPTO_CFGPTR_SHIFT 24
+#define CRYPTO_CONFIG_CNT_MASK 0xff00
+#define CRYPTO_CONFIG_CNT_SHIFT 8
+#define CRYPTO_CAP_CNT_MASK 0xff
+#define CRYPTO_CAP_CNT_SHIFT 0
+
+#define CRYPTO_CAPS_KS_MASK 0xff0000
+#define CRYPTO_CAPS_KS_SHIFT 16
+#define CRYPTO_CAPS_SDUSB_MASK 0xff00
+#define CRYPTO_CAPS_SDUSB_SHIFT 8
+#define CRYPTO_CAPS_ALG_ID_MASK 0xff
+#define CRYPTO_CAPS_ALG_ID_SHIFT 0
+
+#define CRYPTO_CCONFIG16_CFGE_MASK 0x80000000
+#define CRYPTO_CCONFIG16_CFGE_SHIFT 31
+#define CRYPTO_CCONFIG16_CAP_IDX_MASK 0xff00
+#define CRYPTO_CCONFIG16_CAP_IDX_SHIFT 8
+#define CRYPTO_CONFIG_SIZE 0x80
+
+/* UTP transfer request descriptor DW0 crypto enable */
+#define CRYPTO_UTP_REQ_DESC_DWORD0_CE_MASK 0x800000
+#define CRYPTO_UTP_REQ_DESC_DWORD0_CE_SHIFT 23
+/* UTP transfer request descriptor DW0 crypto config index */
+#define CRYPTO_UTP_REQ_DESC_DWORD0_CCI_MASK 0xff
+#define CRYPTO_UTP_REQ_DESC_DWORD0_CCI_SHIFT 0
+
+enum key_size_e {
+	UFS_CRYPTO_KEY_ID_128BITS = 1,
+	UFS_CRYPTO_KEY_ID_192BITS = 2,
+	UFS_CRYPTO_KEY_ID_256BITS = 3,
+	UFS_CRYPTO_KEY_ID_512BITS = 4,
+};
+
+enum alg_id_e {
+	UFS_CRYPTO_ALG_ID_AES_XTS = 0,
+	UFS_CRYPTO_ALG_ID_BITLOCKER_AES_CBC = 1,
+	UFS_CRYPTO_ALG_ID_AES_ECB = 2,
+	UFS_CRYPTO_ALG_ID_ESSIV_AES_CBC = 3,
+};
+
+/*
+ * ufshcd_crypto_config - UFS HC config
+ * @cap_idx: index in ccaps array of crypto ctx
+ * @cfge: config enable bit
+ * @key: crypto key
+ */
+struct ufshcd_crypto_config {
+	u8 cap_idx;
+	u8 cfge;
+	u8 key[AES_MAX_KEY_SIZE];
+};
+
+/*
+ * ufshcd_crypto_cap - UFS HC capability structure
+ * @alg_id: algo id (alg_id_e) as per UFS spec
+ * @sdusb: Supported Data Unit Size Bitmask
+ * @key_id: key size id (key_size_e) as per UFS spec
+ */
+struct ufshcd_crypto_cap {
+	u8 alg_id;
+	u8 sdusb;
+	u8 key_id;
+};
+
+/*
+ * ufshcd_crypto_ctx - UFSHCD crypto context
+ * @ccaps: UFS HC crypto capabilities array
+ * @cconfigs: UFS HC configs array
+ * @crypto_lock: crypto lock
+ * @crypto_config_base_addr: UFS HC crypto config base address
+ * @config_cnt: supported configuration count
+ * @cap_cnt: supported capabilities count
+ */
+struct ufshcd_crypto_ctx {
+	struct ufshcd_crypto_cap *ccaps;
+	struct ufshcd_crypto_config *cconfigs;
+	spinlock_t crypto_lock;
+	unsigned int crypto_config_base_addr;
+	int config_cnt;
+	int cap_cnt;
+};
+
+int ufshcd_crypto_init(struct ufs_hba *hba);
+void ufshcd_crypto_remove(struct ufs_hba *hba);
+void ufshcd_prepare_for_crypto(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
+#endif
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 86fe114..a96b038 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -47,6 +47,9 @@
 #include "unipro.h"
 #include "ufs-sysfs.h"
 #include "ufs_bsg.h"
+#ifdef CONFIG_SCSI_UFSHCD_RT_ENCRYPTION
+#include "ufshcd-crypto.h"
+#endif
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/ufs.h>
@@ -2198,6 +2201,14 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
 
 	dword_0 = data_direction | (lrbp->command_type
 				<< UPIU_COMMAND_TYPE_OFFSET);
+#ifdef CONFIG_SCSI_UFSHCD_RT_ENCRYPTION
+	if (lrbp->cci >= 0) {
+		dword_0 |= (1 << CRYPTO_UTP_REQ_DESC_DWORD0_CE_SHIFT);
+		dword_0 |= ((lrbp->cci << CRYPTO_UTP_REQ_DESC_DWORD0_CCI_SHIFT)
+				& CRYPTO_UTP_REQ_DESC_DWORD0_CCI_MASK);
+	} else
+		dword_0 &= ~CRYPTO_UTP_REQ_DESC_DWORD0_CE_MASK;
+#endif
 	if (lrbp->intr_cmd)
 		dword_0 |= UTP_REQ_DESC_INT_CMD;
 
@@ -2462,6 +2473,12 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	lrbp->intr_cmd = !ufshcd_is_intr_aggr_allowed(hba) ? true : false;
 	lrbp->req_abort_skip = false;
 
+#ifdef CONFIG_SCSI_UFSHCD_RT_ENCRYPTION
+	lrbp->cci = -1;
+	/* prepare block for crypto */
+	if (hba->capabilities & MASK_CRYPTO_SUPPORT)
+		ufshcd_prepare_for_crypto(hba, lrbp);
+#endif
 	ufshcd_comp_scsi_upiu(hba, lrbp);
 
 	err = ufshcd_map_sg(hba, lrbp);
@@ -8119,6 +8136,11 @@ void ufshcd_remove(struct ufs_hba *hba)
 	ufs_bsg_remove(hba);
 	ufs_sysfs_remove_nodes(hba->dev);
 	scsi_remove_host(hba->host);
+#ifdef CONFIG_SCSI_UFSHCD_RT_ENCRYPTION
+	if (hba->capabilities & MASK_CRYPTO_SUPPORT)
+		ufshcd_crypto_remove(hba);
+#endif
+
 	/* disable interrupts */
 	ufshcd_disable_intr(hba, hba->intr_mask);
 	ufshcd_hba_stop(hba, true);
@@ -8346,7 +8368,10 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 		hba->ahit = FIELD_PREP(UFSHCI_AHIBERN8_TIMER_MASK, 150) |
 			    FIELD_PREP(UFSHCI_AHIBERN8_SCALE_MASK, 3);
 	}
-
+#ifdef CONFIG_SCSI_UFSHCD_RT_ENCRYPTION
+	if (hba->capabilities & MASK_CRYPTO_SUPPORT)
+		ufshcd_crypto_init(hba);
+#endif
 	/* Hold auto suspend until async scan completes */
 	pm_runtime_get_sync(dev);
 	atomic_set(&hba->scsi_block_reqs_cnt, 0);
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 69ba744..25755c8 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -193,6 +193,9 @@ struct ufshcd_lrb {
 	ktime_t compl_time_stamp;
 
 	bool req_abort_skip;
+#ifdef CONFIG_SCSI_UFSHCD_RT_ENCRYPTION
+	int cci;
+#endif
 };
 
 /**
@@ -706,6 +709,9 @@ struct ufs_hba {
 
 	struct device		bsg_dev;
 	struct request_queue	*bsg_queue;
+#ifdef CONFIG_SCSI_UFSHCD_RT_ENCRYPTION
+	struct ufshcd_crypto_ctx *cctx;
+#endif
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
index 6fa889d..fe5a92d 100644
--- a/drivers/scsi/ufs/ufshci.h
+++ b/drivers/scsi/ufs/ufshci.h
@@ -90,6 +90,7 @@ enum {
 	MASK_64_ADDRESSING_SUPPORT		= 0x01000000,
 	MASK_OUT_OF_ORDER_DATA_DELIVERY_SUPPORT	= 0x02000000,
 	MASK_UIC_DME_TEST_MODE_SUPPORT		= 0x04000000,
+	MASK_CRYPTO_SUPPORT                     = 0x10000000,
 };
 
 #define UFS_MASK(mask, offset)		((mask) << (offset))
-- 
1.7.1

