Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAE3C0015E
	for <linux-block@archiver.kernel.org>; Tue, 15 Aug 2023 10:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjHOKGj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Aug 2023 06:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbjHOKGQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2023 06:06:16 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFE0E65
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2023 03:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692093974; x=1723629974;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=5PlrnjQ2Y5Pc1ytjm278CW2kgqCJ3hFL2Wi7ZBa++7E=;
  b=Gy6QKCVjMvyyxh7Td6aQkjqNLT9lUz4sqCdKvZtQIg53+SBqpF4XJx/J
   WPjE3STZrM9OyjGBOhQSsuTg3+TQ5lLPxwC8hJ7fmn4A7GBGdvX/gs3Zy
   zYFWV4z5rtN61dyYRrM/P2drzFlT8vAEY6sqWTTJVPs/ATMWMOPmBgkBv
   HDVfuorfbv517cqL2pq4QhcseTZnwKzIZRP/OqBJy7s5T9i5IhFA3iSGt
   ak10aab2H6u9O6R/qy1Q2sK80NtwszDrqVadwKDwu8B/pJYo9VA3afdmd
   3NGOCh49/43rkjnQbNF7LSCmD1GMhVGw9vjgbQ2xvXCbbEhS/7oQXqIDF
   g==;
X-IronPort-AV: E=Sophos;i="6.01,174,1684771200"; 
   d="scan'208";a="346340416"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2023 18:06:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7lemlx9cW6yqx42cJFOR/sha2spoH/Yj8Fh5BpgQpdZYUh/n60cfywTUrgdl+MHKf3S0qiuULR29OswkMpps1iRKfyNXzIoWyNcSK0Ln23/9+J6VlYJVqUETQPhYf5S1HQVEzQmy6MvgAZ3LAo+R/Wg5Y+RuwpAwYSBIAIP7YXxlYmaylDMWMNoAmNj7d4Z5h9k9edu8fz7P+bZxlt8sppAZNi4tSMN61P3HVhQI/hfq8uNeHhE4p3IXB1TFmJtXQsQMAob1VmDirAjs8ab86LnpgT8FlX0KwxAAN7X30R4VjMvrupHhB+ivYSNKVbmhZL/j+VtokX0jXpiZobfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PlrnjQ2Y5Pc1ytjm278CW2kgqCJ3hFL2Wi7ZBa++7E=;
 b=VkojrFVpsFURX2PpzWBKqzjZpQlr+ucskjc7oDlQc+w2SL1IY9A1diEeogxH12ejfwW68i93zm8DMPTJcvCuP2yW9CGrRoOX9UzxT0HwOgE5zFtfPnBXpqi8exmDMdTxyRgYacSFG9y6QGkulwirNwpIdbtz1iVox3cZ54C++2cbOdjRhd/B00E8Oo8gP3WV55PP+RQzB2gJqqZ5PqumtW7ah5o0DtxfQMmII4FnY/u8WblVipzLClOrWp06FZj9OjAt/HjGJEVq6hNMwrndYtKjwtzKC5TqfSRp9Gq/cMi6rCISBQCSbdr32Vjygm/YhYG6RVYzGzHJyhPeMSggbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PlrnjQ2Y5Pc1ytjm278CW2kgqCJ3hFL2Wi7ZBa++7E=;
 b=GUQke/dZsLq8x0HmjJ2Ty0veVjm1MZBCF2MtHz45uoo8emEwCS5eeLBKkGR64tE4bq/aFpwq5waM61EQ+AGiczfj6TfwmlOHInyVv+gUlGFnjMNpY44sgoOEtQ6utRtwnfx+TPtGslTkrUrlg5buVb6uoWNYqJXYZSMsyqZdOxg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6284.namprd04.prod.outlook.com (2603:10b6:5:1e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:06:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 10:06:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 5/5] block: switch ldm partition code to use pr_xxx()
 functions
Thread-Topic: [PATCH 5/5] block: switch ldm partition code to use pr_xxx()
 functions
Thread-Index: AQHZyiGmFNgNOCVojESc2SVN+SY0Ja/rK/iA
Date:   Tue, 15 Aug 2023 10:06:12 +0000
Message-ID: <790b86db-da57-4997-86f4-98796bcca8b1@wdc.com>
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-6-dlemoal@kernel.org>
In-Reply-To: <20230808135702.628588-6-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6284:EE_
x-ms-office365-filtering-correlation-id: c31bfaeb-e010-4fe8-260a-08db9d77412e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wMZcE00Nsl3u6109rE1yySC9J1GWiSz/g5LMGojUu2C6Dzk7ltReYyTIjrpFD5+HruOyc+upLS/11GfXbI3RsOdYsR8TsJPTxRK3uPW15DEXCUkaqCHxtMDTzW1UH4Bs6xFatvzv0HsY5NKV2pLlCxCOH71oC27SRMFxBDSyjRs1kGeKq1IPomqeiewybB8NACCYNVBdXPIcJhE5kvXr8W2Bpo5sPQxBwJcIY7kAgXZ/XFpqH9V6fydNnjNX44yI20Jl1zeeSQHMuosDL/XefMc/KdDJbiQjx8LwDyp8qxjarnTJc+5PDdZPBEEVYKzjytuLDDFh8C1e6xkpjXYHyYdW23pq5ThheLnHOrAL2OEPQXk9LtCJQPrD0WseMj0/oM/NM0Yr/Rio2T3+H8qh2ln9mZMokj6NwSY8ZL388vmSFMvM+a/M6mtctVjERZR7sxI3FdAkJMwtj7O5vIgoQTI0cLnkw/w9WYIyy/l72+adLOpJ28rZ0mPCdjQxJfGNGfn/7h/L7dr/D9Z5sRouMMzN8rRl4ntPU3Sf9iSoI2SiS2brYjtDJuvKYwTKMrOiIkYlbRtsc/yd8v3kC2jt3xF5Iy0UxavCAms0x5lJDxo5/EKc+2N8jdg7CCGoaDQkS+HskAmvj77oyh9Q7UpB5otETH7pJx/Ix0QvUOndYWPur1L+q+0VGCXe0HGDxtSNCcY9gXq9weHVTebLSEkIMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(186006)(1800799006)(4744005)(2906002)(53546011)(6506007)(2616005)(38070700005)(478600001)(41300700001)(5660300002)(8936002)(6486002)(8676002)(71200400001)(31696002)(31686004)(86362001)(110136005)(316002)(91956017)(66946007)(66556008)(66446008)(76116006)(66476007)(122000001)(38100700002)(64756008)(36756003)(82960400001)(6512007)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkpSSWtrVEFVdVljbFA3YytPejFFMmhRNWpzQ21ZZHpHeTdySlFZSWsyeStW?=
 =?utf-8?B?QXNTY1BTNC9GTVcvYm4wYSt1TnZWOUV0UytRZVMzRThXTWZjV0FSenJaLzhC?=
 =?utf-8?B?Rjg5Z1YwNmg2SU1tMkZMY05JRVFjYlBycTcvdXhzVDV6aWxpWkpzUE1Rb3ZT?=
 =?utf-8?B?Ujl6Y2s4R2hyVUgyKzhCbGdVU0FXU0NUVjM3MnlDMWM5VDhUTUtwYlZqcldV?=
 =?utf-8?B?SUJIeE5qZmlvTGtkdUtsY3hBRlBRZzB3VDZCMXNDQVpZUjl5cldzNFJua3lL?=
 =?utf-8?B?b0Q4OUh5by9LSS9IYmF5bHlTYUNWcXJ5Nk84d1BsSnZZK1dtTXJzdlVscVFR?=
 =?utf-8?B?SnliMXU4Z2dZcGNhMkhkRzhWSG01VnFZSXJoQjVoWlEySzBRUXF1TWZFck5i?=
 =?utf-8?B?Q1FNR2NwTjAxTzFva0Fhb3h4THJhemEwVjIyLzdyQThxS1BGWWt6U3g3a2Yv?=
 =?utf-8?B?M0Q1ZCs3MlU4SnRadVI0Tm9jWmNjUXYvYlc3UGFGOURkK1RPTTVMTHU4bmVO?=
 =?utf-8?B?RENoSHFUb1luYXJuMVFwTDJpMlZiemlpZUlQeG0zZ2xlRHMwSG1XSVNITUpl?=
 =?utf-8?B?V1RPWVBSTG1PZWh2TWxKejJTZDVLejFmZjgySkRob1MxbVh0VXgrbGpPZFhs?=
 =?utf-8?B?RStZemRXRVNtU0ZPN1o0c0krcGk3Y3pjemFBL1loLzBxWnV2VmlQaExFbjAz?=
 =?utf-8?B?eDFFR0NBcE51ZEpieUNqaVBITnR6NXpNYlJOb2VLRmZ2blpqTzd2elk1K1Ba?=
 =?utf-8?B?d3E5VjBHclBOV0h2MU01Z21ZelNLNU5lS3RBUFBQeDBCOG9OdldOem1JdURy?=
 =?utf-8?B?QkxKd2g1MnVWNCtaenh5SWpQNXZwOWllcHVqOUpjNVd5UjN2WDlOUGUxNGp3?=
 =?utf-8?B?WXNud3phdlQzOTc0UlA4TE9DYS96dXdoZjZubldmVExua3NSYUZQMW91OFNk?=
 =?utf-8?B?SEVvZWc3STFDR2dCVW15YVVHTHphRUQxcDRORFZTVjQ1MkRZYm90ZTZCQTdy?=
 =?utf-8?B?TkRralRZTVczZ0dpc3c2N2dMb1VYaGo0MTNDZ3lYcDdIMTFJeUVieXZXZHdv?=
 =?utf-8?B?SUM5YjV5ek4wd0FVREtSNFJQenZoeEpDVDhmSFhaa2dWVjJoMitVNEJQc1BI?=
 =?utf-8?B?Vm92alZHS0hNZ2oyWEl0am82eFQ1Ukw0UjkzRGtsWkwyNzVKRGZiaU1wU0dB?=
 =?utf-8?B?WEhpMmpESFF0eG5xWDA1aHhPUUd6em9lN0lHQkxqYUR4N1d0WkhOVXRWN09J?=
 =?utf-8?B?bVNRc0NCbHpldENrOEdWVzNaTnVMM041TzFTV2RHeDBlN1FlR214ZjZnbyt4?=
 =?utf-8?B?emwvc0ZZcXZKQnE2bEJlMGVNQzEzVHMydjJ4dzh4MnF3cGpseE9HaGxOemhN?=
 =?utf-8?B?Qk9xdkxJVmJjdk9IZU43VUpDd05tbVdoSTIvbS92Wk5PSUp4OEs1QzZEa01Z?=
 =?utf-8?B?NmJrZmJJRVE3WjJzK1JKcTcwUkY1WmdiajZoeEhZUUxZTkppdkVycldtZGRG?=
 =?utf-8?B?bU10VGhBdlFKbTlXamVRL0ZKMmRMaSs0YVI5a2t0cEZ1YUQzZDJjWlh6UU5D?=
 =?utf-8?B?RS9udXdmTjJOZGRlTUFGNitpOGdtVGZMbGxuQmVUQnJXZFViMmcrRk90WStD?=
 =?utf-8?B?cEN6Ulc5RWhaU3F2Uzhjd3o0NUpGNWF6M1NFRDFEZUk0V25aWHkwRGVsNXo0?=
 =?utf-8?B?Y0JPTnBaYW9yWkhmcnU4Vlpzck9yUmo3MTgvTlhpaGgwUzhCSzZqM1Y2UHl3?=
 =?utf-8?B?aXpWNUJPMnZKc3JyZytYMVRHTUxWWG11U0pyMXNwN3E2MDVSTjNSKzhFUGU4?=
 =?utf-8?B?U2Vkd0YrcjUvc1VoUFp3QS9vREJNQnhrRWErNXR3bDZzV1pRR3VPTG9XSDJM?=
 =?utf-8?B?Y2tRWHRHSTRxbmthb3JVUUl4Y0cxazNucFowL2o0Q2xuR29hWjNGYmpkNk9S?=
 =?utf-8?B?OWYraU81UHByK0dockFYS1I1MFY2bFIrVjFTdXU3S09ZcERsWWtkdHN1b2FM?=
 =?utf-8?B?QXUvVFNvN0NtMHRIUGpzZmlOdzRZVnBrRWp3VWhzQ1RBV1BWblpvNVQ3eC9t?=
 =?utf-8?B?UHNYS0phcEFJZEhReHNkS3JLbldUM3pGUDZTNkovVEZTRU1PQktuWkYrcFVz?=
 =?utf-8?B?U29QNmhzMERIZVhTTXRUZ0paMTI5ZmdNckRLYnNWMW91ZUsyczFYQi9hNmlK?=
 =?utf-8?B?c2hKcXRCU0ZzbUthMWVaM1VvYmhkYVpGVnV0dEdlYlk4WmNzb3N5UHZCMmxK?=
 =?utf-8?B?SlRUeUt1WUViQWVEaXVEcnZSeTF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC3CEA12F3561045ACD995113A4F555B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 48x+/wzQ/WGLVwxxssPGq4hh92IOREtAxTEJ+KGu+OQSAyM/o+zpDjUUC6ZmUgH8kgJGlz8DJq9z16dscF0pmVstpxOB6C5gEpmXbUL7S4oGRaoNFoblAROm34x2u/fqNfcM0dSVnS9dcK7+CU8kjLbNAGI8P3I7yAeTDXYsGmShi33+Y9vUt4kzgkQorHJmWXHTdfV06GtJJPz5SE3VvQb4SbNlchI/TxV+r/jtDcDujsgaGZFUdeWikaWjTUa7/CV9FjjH00iWsgk47B66yDm6oUwruTL2/Es3swnZrIVqaF/6UvDyXhyRdBIcqQC/pqcpYhA/MAvhQsaAPKDUOGtPv0kBR1TW3JCdiWFAvFhc+68cKE/HNUMC3fW45KR1Rm8iLNYQFxnXIk9MJZ1u0boOoEZaOQmWSFzTVWMIjdwPhevvcVhCrmFBf509pxI2G1+ZHe7Pg9CBLfrlcwf6QHTMxxnK4QHaDwhKs+0gM4EBkpb8WHflQaFvqU4mHK0vJMoCqITcNrm3mxTuflrsYMpk7/T+yw88sHFJX2H36lXZEvY0lheyjgmiSQzzHyZfmrELrPHh0gwd6EVp1nvkHBFIe/CGb3Yt96zOx7XkSJBtziAM6q/YDk9dDKrMr6wgU20oAq96xy5ojzbfNMkKW/xkz7ho+moV0O6GIgTx2wFbPsiMUZSyr1jLqnESbAv/MH7iKQzHTcVZC5un1QURx1XNWll8AVetFoNShVYl2b0W9zy4NdEdUple/LLDdiYM2awS13ko5LLLlvoFFlWgUFHElCb034W/aj2/amOu1G3Gq3nG8dqgw2MFC07fNCKZxcl8uHhMMTaM5ktO8N2Qeg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31bfaeb-e010-4fe8-260a-08db9d77412e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 10:06:12.3262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDUaYuX6bz4pTXGaRqzcVd7DuNOjcSjH6r51YHK0wG34C7cI++gn21A7pin8HQUtOg+mVmfLYQxEp8HsePdxN3WG3qwmxLv0oWFMq5Mj67k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6284
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMDguMDguMjMgMTk6NTYsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiArI2RlZmluZSBsZG1f
ZGVidWcoZiwgYS4uLikgcHJfZGVidWcoIiVzKCk6ICIgZiwgX19mdW5jX18sICMjYSkgKyNkZWZp
bmUgDQo+IGxkbV9jcml0KGYsIGEuLi4pIHByX2NyaXQoIiVzKCk6ICIgZiwgX19mdW5jX18sICMj
YSkgKyNkZWZpbmUgDQo+IGxkbV9lcnJvcihmLCBhLi4uKSBwcl9lcnIoIiVzKCk6ICIgZiwgX19m
dW5jX18sICMjYSkgKyNkZWZpbmUgDQo+IGxkbV9pbmZvKGYsIGEuLi4pIHByX2luZm8oIiVzKCk6
ICIgZiwgX19mdW5jX18sICMjYSkNCg0KSXMgdGhlcmUgYW55IHZhbHVlIGluIGtlZXBpbmcgdGhl
c2UgbGRtX1hYWCgpIG1hY3JvcyBhcm91bmQsIG90aGVyIHRoYW4gDQpwcmludGluZyB0aGUgZnVu
Y3Rpb24gbmFtZT8NCg0KSSdkIGp1c3QgZ2V0IHJpZCBvZiB0aGVtIGFzIHdlbGwgYW5kIHJlcGxh
Y2Ugd2l0aCB0aGUgYWNjb3JkaW5nIHByX1hYWCgpIA0KY2FsbHMuDQo=
