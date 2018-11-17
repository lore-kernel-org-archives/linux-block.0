Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EA4C43441
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 22:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB362080F
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 22:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="UGazsGkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB362080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbeKRIgi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 03:36:38 -0500
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:34592
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbeKRIgi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 03:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eqr/mAODIqNvzHCEpP+Hwgd81qERJw1aQdUvMy6xn+o=;
 b=UGazsGkDcnPFWxeO4BtVzhbAkwhjs7VuZk1fdPPPy/kj7OglVa78feYJ7zrkDeKM78v3DB6Bkm3o8YQwmMoIjUoyeIuZtnYW6XGSjYfMU1S3AdnmIgGotRbTnkWIuyTf6nHIwQYb5qiI7Ia0mfDsUfnBdrkRrEVwmgdYbLcEdIk=
Received: from AM6PR0502CA0003.eurprd05.prod.outlook.com (2603:10a6:209:1::16)
 by DB6PR0501MB2150.eurprd05.prod.outlook.com (2603:10a6:4:7::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26; Sat, 17 Nov
 2018 22:18:20 +0000
Received: from DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by AM6PR0502CA0003.outlook.office365.com
 (2603:10a6:209:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.20 via Frontend
 Transport; Sat, 17 Nov 2018 22:18:20 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 DB5EUR03FT051.mail.protection.outlook.com (10.152.21.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Sat, 17 Nov 2018 22:18:20 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 18 Nov 2018 00:18:18
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 18 Nov 2018 00:18:18 +0200
Received: from [172.16.0.166] (172.16.0.166) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Sun, 18 Nov 2018 00:18:17
 +0200
Subject: Re: [PATCH 04/11] nvme-core: add work elements to struct nvme_ctrl
To:     Sagi Grimberg <sagi@lightbitslabs.com>,
        <linux-nvme@lists.infradead.org>
CC:     <linux-block@vger.kernel.org>, <netdev@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
 <20181115171626.9306-5-sagi@lightbitslabs.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <3fb868a5-2887-4fa1-d963-05c379ba8a4a@mellanox.com>
Date:   Sun, 18 Nov 2018 00:18:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181115171626.9306-5-sagi@lightbitslabs.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.166]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(2980300002)(438002)(189003)(199004)(8936002)(486006)(3260700006)(126002)(11346002)(4326008)(47776003)(64126003)(2616005)(476003)(336012)(446003)(65806001)(478600001)(6666004)(356004)(186003)(50466002)(6246003)(16526019)(8676002)(81166006)(81156014)(6116002)(230700001)(3846002)(65956001)(2906002)(65826007)(36756003)(2486003)(23676004)(53546011)(5660300001)(76176011)(31696002)(86362001)(106002)(26005)(77096007)(7736002)(67846002)(54906003)(110136005)(229853002)(106466001)(16576012)(316002)(305945005)(31686004)(58126008)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2150;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT051;1:vGRVvi+3tGvcVZFYVglE9zZrQOG+4pPCADbGwlE2riNzXKCWAP9E1tzI9cY1E4u09MktDkT7Vq6LCqCIIci4LrdmJzI+oZOdp6wwddUD98kRmu9de1zJbSdse8YYHIxf
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a543e544-d9cd-474d-ca82-08d64cda94d0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2150;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2150;3:5Y7EsQb28KqN1/tRFPQh8wlNBIbqAESZGp07xMNYJ6cxj3ybY0GDLj6Nf6SBShLnwTz1UJGD5C7vI+7/nzYQPshkgrtBW2L2Ub2Zssr70sPuyKmF/j3F99Vpkps30ay9VkYpTUMdvjdP/UQWM1wm66tuAz8DtZKOL7r9oKfx4n6k9H1g2UCm9ESI5ABKUpQvLaQIJ7GorBx6xdR9pDgbbXIidEuuD8TeQ+Xn8g+ZsGS6pEhQlA4ywe1grzFV6xWDDK0vA76zwjtmmwTtulS/Q+WR6QNxXTaLsOe2Dv4XwbWhvlaWe71QmS88p/z3sngNl+GfyKFbsZJUOgGJ+iptBJq+S5wYtU0KA0tbCntf72U=;25:/OLAezL4H1B/tPsLlHgMjnuR2TDRT9iE4F38Czt+BnKbuPLQK4qxUFPAhstmtrZZQNkHnaosZ6JPO9fnTN08WzSLhGghS531BBvXu871s8b6nk8lE8maP4smEQsP2+HAq2/VKwjV0GVQGM/u+O1RDIRdUIs9a+xfeeeP9RhC1kNypns+Uunc5TySYeYNhjXetJe2PZBv+/y33ps2kAUefWnjo25jP5mz3PGrjSDgzRXoRtlHYSv7ur2G49/sg1wB0F0FNJuXiUC+BuCUXoLOM7f6XNCzLcWm15D9ADCgvp1n26jpQVzs7bbxtPY4hrt5enkSChSqok1tmxr7IbaIqw==
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2150:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2150;31:QJKrxy+B/dJI9Eufr0m24KDBd7oV1UjiKCmt2DBUPN7wcTK2BVq/T6jo1NefBi7vGEKadmjqulecvKa2ytFVGX62HjDa27E8epLNh2CP+SYo9IDNnCGugqjGvTu99WOzECh4fR1dSuXcASM2RX8GwIy5rM0PxQGrDELWvQmxzxgtYbKD0dVkNKvGBug8sqw+gYdmcNM/Onx46Dv0FTiPnT+kLrji7UrJzmNsSUy0nwk=;20:dtuHezZZUxlq5zMidzocCRNLVyIliGR1B5hnG0sA845xljY1Encd7EtG2SpIGVhqK+aJSwrEtZuP/Y3jtFAPCYsqKYfzSUXbvJM56jRkisJ0ceHTUn4LbiyETTmFUxqT1kk6IqO+4u2IsXXrswwar6li4ewV44vSzMbi/d/huTpScAR+7cjsWyPRSf3NHAIiM4eH6dqeK9V7EO5GkqDr5wXhGcpTSawa8u4q6kh34isKzLpH3PPREwpGPZEvQuwDJsAy9c9cMw/CJjc40n0Nek1IVofqCVrashd83YBP3uqB4UGRPtRa1dD0tQC8avrU07LiV3s7tBV+DUEGxCLWV0uRyEqsnYiUrA6KWVfIF+L9JiLKVLNCtu016xhRZ3U42y/t/qR8Xd32Took8CZ8dc30xPCQ6UDrTFaJ7ut2OV9Xl6aeZJnn+POJaEX9RTU6vdH+I1DsUE5u6yMpGykp7dD8XoS5Fd9NMBF9pOQ9dCE0EPfIsRDipnrT6ffGiXEM
X-Microsoft-Antispam-PRVS: <DB6PR0501MB2150CDE0F495BB29C289B498B6DE0@DB6PR0501MB2150.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(21532816269658);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231431)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB6PR0501MB2150;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2150;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2150;4:PiPhAFpUfvG/x6vXeAuI5ZRCRZaaQhp/1hdlHIQEcx8HpEgJhsInj79LEoq/mWMFkwUoiTjS5oHvC5paVdOPlOMum5Uqm7K21gnukNftuB2Pw0EXm4wyb/4Y7Vof4oDUcLDr2+bfzsiTBGX8AP9ypcG4aETcJoK9pCVVvHvay72o/ncfuG7PX8Li+Bw3mOdhsGqCzThPpgU7DR3wz4XBlLpGnqzgOVPBXK2+Gu/GMnif7KGgLiUwi1XIf1cW5UPGIuL9YnXvE0cNA3H5CU8CboIHfH0dQCAF6LptUfmedCCD84G7AR4BNJd+zf91cPo/zYqU7DGrYfjwtkWUMl6U5nVdxRK0VtXiZ2nqHauyrF8=
X-Forefront-PRVS: 085956473E
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1MDFNQjIxNTA7MjM6MEIrK3dNYURYUUZydGlMVVh6SGd6eWRq?=
 =?utf-8?B?TFNEYy9HR0MrL0JQMVBiSGxnYXdzM3JPWlFMc3hrckMvdDBUZ0lGNStNdHcy?=
 =?utf-8?B?WDVKYUJHK1BZUkpYWGRFMXpCOTBIUmtJSGUvcVIyZDEyc0NLU21sWXJ2NUlK?=
 =?utf-8?B?Z0ltSEMweFNaT1VsRkVPeFlQN2pjUVZadnYrcVdycktsUFlTSFVsM1Z0U3Fj?=
 =?utf-8?B?dmk5TjZhSWxXZWcyV0VoL2pudkN2Tjg4d3NMR09ub2FnSk1RcFBPTGJnMWFv?=
 =?utf-8?B?ZGJrakxmVzFxQjh5ZXNoZkRQRDg1dWpwbjJrS1RVcGlreHlZS1dpeXZwZkl4?=
 =?utf-8?B?TUU3NGoza0xuUzdKNEpLSExabUJHdjNML1RIUGoxNUVFVVMzMTlCTlRaL0lG?=
 =?utf-8?B?TldWVDhrTXo5ZnRPQUJvUmxKOHhhdTArR3A4R05yRmJ2SlBFN2tDOFVyTUcx?=
 =?utf-8?B?VmYvSjYySGo3ZGRDRG1Ja2pBaGI0bVlMN2tUUTZxQ1JZQjB5aW9PYVNxSTNt?=
 =?utf-8?B?OEVmSHJYdnFxeC9lNFpPWW00cWdrMnVMVmUyenpFczlmS2Y4N3J0M1RLRzBj?=
 =?utf-8?B?TXBVY1hnQy9XYlBqWU4vSWNXKzQ0aDRwSm1UYzhiWlVTTjFDdTVSZ2lQMWsw?=
 =?utf-8?B?dHNIVUFzSFBoY3BNcXVlc0pzR0dnbGtVMTAxb3JOUEZtcmc3L09DcDN2NmJ3?=
 =?utf-8?B?akF6RTNPVkJheHp1OU03eUJQUFFqK2hwT0QvQ3JTY0IycCtMSUU5Wm9MZG91?=
 =?utf-8?B?SnJiODdRUkRrRzY2d3VEeHNadCtoTVI4YlBGRnMxdWYyOFg0R3NocHloc1Jh?=
 =?utf-8?B?REFoTisyUWNjVkM5ZndVbytQS2FSL3ZTajJwSmJyOWZ2dnpWY29UMDBDQWYx?=
 =?utf-8?B?aXRWU1RIWHFGdGt2SExkQVptTTFEdHFjVXFVQ2MrVTlUTWRQRGdOeEtIZFJO?=
 =?utf-8?B?eTVoQ294c3dUMytsWkJzZmlQTjV6dzNOcmRKYkFERkt2b0Rhemhkb1UwSXdq?=
 =?utf-8?B?NWJsSEg1NVZJM0NGYlZWVmJTUmpvQUxNR2ppUVc4eWpvSDlOK0RQb3BSS0dH?=
 =?utf-8?B?OXJLSmltV2ZuNi9RZ1RDYXczL1g5NWZWN0VDNXZYb0twR2ZieGs1RUVWQ3NV?=
 =?utf-8?B?bWFUOEUrcGIrczhWYkhNZGkxaysvODQ1RWJISEdPNmVPTHRLbDZDT1J5Tjds?=
 =?utf-8?B?WlhVbVlsRVMvU05WWVJXV016RGx5WkgvR043eG5aekV5N3hFc1VYVFlMT2xS?=
 =?utf-8?B?aFdmV1BRcU15WnJDb2dLVHBraFN4ZE1NTnl3dENSZFBRbTM0REZWYmFzOGJ5?=
 =?utf-8?B?d2JSNzdHZ3FTY0lTSnA0OHd0S3ovL2hWaVdVd09iTXhsd1RzbmtvRlMzTEx2?=
 =?utf-8?B?RVJhd0FoK285d1hjclhYc0ZKVlMvdmlKWWh5R1l6Zk5peWpQZndDUTVLSUxz?=
 =?utf-8?B?Nzdxd3FVWUxjOXZ0dk5YTWVNcE5TQVB0Z0diMGdwd29LNlZjKzl5V3UwYzBV?=
 =?utf-8?B?bjQvQVhNNEYyWUFVREFoaUJDaFpYOXhBcUdDUDU5cU1acHR2TzF1ZFlDaDA4?=
 =?utf-8?B?MUZLODdQL0hKYk9UZ2ZHYlF6Vk5FeTBhOEVDNGpydElhZkZZM2FpNTlWR2tn?=
 =?utf-8?B?OW9aSW9lb1BnaUhLZ1A0aUNlYXZGb29na3JlMnNQb05tbS9GNmhoaTRaNEJa?=
 =?utf-8?B?YVJJQ1lNN2d5cUQ1Vnkzd3EyMGVXTVlmWEE3U09DNVBxY3BwNVVWUXN1aWFW?=
 =?utf-8?B?a2g4N1JRYkRremJCZ0Y4K0FPaitxWE11Vnhoa2w1SFFEcVB4S2xxTUFkWTIy?=
 =?utf-8?Q?c9lsUs4sKr7rnzh?=
X-Microsoft-Antispam-Message-Info: TvXK+ig+blsBLYs/0O0SCKnEf3B6UIlTwCt68S9VpWhinZQybnKJQOaAIYJ5P8hK8iQc0tW6PVjDuL5+QBjAXGbBwOUUmfiIizWHdOJ8uRl1psDru8ZvVAGzIe9kvVAUqsbSqlYUA8j9hyPXKRcJJxX0k3FwvOxNZEBTpFyAhVrC0BZfDiS65xt4rYt+cwpm7HfVAaH2khplj7zqshYFms2PgaNx34WC+CxITx7AIxW9uPokQpl0DAA7i2fAD62kft8fPLPrHouQrY9gwtGoWQ3t+1hu9soqnT268xpFDSTyYetaF5ARVJR2i0E+79r5tUfKdPs26feO2e78l+RugsS4rLnyIo04CvUPO2Ih6Nk=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2150;6:AtzwNmHg4uKiZuue1tNYk5+VowjoXOZXa3+pOwhfW5soHLCdME25TNU2NQxBGfaSg+NeOdwa3pKh1OD9JfUPs+4ZEZdmA3UPm7cP0v83wtYHjFTzLB9GENhwuuX8E0cGXUGf5Ub7+0Zz9eUIx4JrAfmkuXow3W32qEOz1+9Ipjxr4GXje689AjtoQ9boJCTWeE0NSYarDG911/GVBDVf0c3CruZMht6zj9dKAi+Po0IUFv/+U1RkAEP07gjyndcpRn+hN+x4AU0PtKTgan0VSQmNlM0dlN2dbf/wonD0AImSxp7NY8/EsoyEKHGtGUWDA0yXQ9HrPrz3JpIkfsKDvzSFF4pikMaSixRFcsoFw4eXat270fofqrgzBZxF+UffUWKNXq3xmWqu2hoJ7I3EKZB9Xj2LXwf6K7Te4xHlGfr/Lo76fCQBapvNhzDzMCilcSRxUszfs6boSf0tgnoa8w==;5:eqBunkR5nY8LOJ3CgV9LpT4YL77zOuyTpR7YA3Ksg53qgw942Q00bv+5olCm5ZsWwNrhkwyzz6iBd7qt9/BxTVHEvb2HfGhQpNkCWadyuy8Mdcg5l0iGMQNNKWvn1LyngS8mqwngFNP/qLDuJiA4TOtHy0qguk2Zp0G45QGzeEA=;7:SghTtMT/6lAALWZ/5wWyYdw7C8WuQ09/zCKfIS/jARaqJ2lXGnTJTo7hh0M3Ggpu8F3U/j3to/kUDDrx+cU7YcVyH9LGuVygRtOemgzpf5Cn+uSY77qnDPOxJ3QMH63Pdzhvmi8bN+M6u4Wi/nEjng==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2018 22:18:20.1077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a543e544-d9cd-474d-ca82-08d64cda94d0
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2150
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 11/15/2018 7:16 PM, Sagi Grimberg wrote:
> connect_work and err_work will be reused by nvme-tcp so
> share those in nvme_ctrl for rdma and fc to share.
>
> Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>


looks good (and I see that more sharing should be made in the future as 
well :) )

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>

