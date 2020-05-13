Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8094CA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 13:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B457824F7E
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 13:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="VRjt7mEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgEMNKk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 09:10:40 -0400
Received: from mail-eopbgr680076.outbound.protection.outlook.com ([40.107.68.76]:1352
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbgEMNKj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 09:10:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHQsc4Ht4pKPJJ3zJF47zmVtvceRfnIcCHJlWBbWtXXv0LM2TopGRexdTKfy1rgrPOwdqtFOzFq158fl44cN4pDfBRmiPHvK+GBqsTxTLFoGAbU4tu82vFetZDReLu7TOBIez7xM35WOIXB2pJV2XjcdupFBPU8ACXiDTGy6+z+zELzZGHakInh6i97IIq/PFJnvKsn4PS5x37HJywD2MsoJURQjRouJNriew8PitdB3nFlM2mgnTSO3Yvk0OXSosmIwB71EX+2lmlaLt2wt/LE4GOdAJ33HWfW1FMZJK6QWSNzlqXQV2B8LwLaLQdF3Yc2TmiOXJSHw/OHW4CydZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKuaeX6lOm+prqwwJYu/B/0uAOyx7aUVAegR5287Xzw=;
 b=RBJ6mv4/1d0RNlA3DhyBGsU6TmCmrDHem7Dabbsl5LJ8R0EYq/zTIR3IdL/AY6YzHLJVZWnE0eAOUmTh1x26lOkBW3HlgAqe1l24YBmdM/ajBdDrYwY9Lf+mRl0apxuQr7J9k9+eaeJZ34O+x7vxMXqZpYAR0RNgSD1D5oeq222ejnVVzSTRTPxIW0Ya+SBNdf6VwHTSiUoGVxCkUe/GfA+LvaQL8b3JGzHSu9T2N09L7gZgFvLSJkqS8WVzViQlZEnbY+9q1pf8Ppfj05kZh+WUvp04+TiqloUtPilY74Dk93ADpSL1NXymaR6aUZLns+6L2i+ydba9Yu3sevl43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKuaeX6lOm+prqwwJYu/B/0uAOyx7aUVAegR5287Xzw=;
 b=VRjt7mEVkWerTNqZgGIAoOww8/Vt7AxfubnvBJlT8133NWlkJoSw92ANSSeuw2SMKxjH3l5GUTJkAJlAAl8byy39So1CjzOOFD4bI6EAXF4DduI/rL80+bTu6MMXJnXBEpA+iuWYtiauvUPFnrI4nE163hhItTCPY/8dEGv0YBk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4372.namprd11.prod.outlook.com (2603:10b6:a03:1bb::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Wed, 13 May
 2020 13:10:36 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::21d0:98fe:1248:b562]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::21d0:98fe:1248:b562%7]) with mapi id 15.20.3000.016; Wed, 13 May 2020
 13:10:36 +0000
To:     Jens Axboe <axboe@kernel.dk>, darrick.wong@oracle.com
Cc:     linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Subject: BUG:loop:blk_update_request: I/O error, dev loop6, sector 49674 op
 0x9:(WRITE_ZEROES)
Message-ID: <efca40f8-9900-6699-a4b3-b6dbd35bdc69@windriver.com>
Date:   Wed, 13 May 2020 21:10:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:202:2e::22) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR06CA0010.apcprd06.prod.outlook.com (2603:1096:202:2e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Wed, 13 May 2020 13:10:35 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 081596eb-caea-4e0b-5689-08d7f73f06b4
X-MS-TrafficTypeDiagnostic: BY5PR11MB4372:
X-Microsoft-Antispam-PRVS: <BY5PR11MB437291F4C3FCF34F880F9387E4BF0@BY5PR11MB4372.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDjQL582hyvxsOgk32JMxn7E+jVSQWww0tEgVrTSN1goSCIVeQbBQo/mkDg13ojtwdqXaOtnaXYkbaKGbDjA+iM7vWrPHWOUlWTwl4glhoAuOvgrrEprlTXCFBNyAt3Pba2fDMpl+p0JW1M/ut4EYMlWSM5HhhnFM3Qiv9b6YrAtxOT6IymMNtamoKkCfaFgc6JZFumKnulUYK6JtXVQ0wSIB7UhRQzKqibI2XTGNdXV8aH8P9w19attuhCegmOH7Bmslv7mtO7iUFXp9SVjPl2ub2YHZxRPBFXxv5ieffuVZSThTT/XhyqUEcAz8SoI9U2OjZz1CM2z3qULvVbWmLgk+/Jdk/TTdQPEyaEzA5uM9Ek3M4kUiyL7rZmf8G9EhgNvYO/dIWdW2bMndw6tUNDpkmYwH1yZP/Z2Ra48vZ+ExODIpXzpqg78LaFW8/9l+IcXHCGPOcWv+VSE9BbqZWM/9BqGnrkMc4ZgFb+3VDbfDGINANXzfgS7NSzer/lwjqHJbDqfsyzSZMXm0aQ0RoC5yrk46ueXAhLI31+0SjXXnwQfhrbFvw9dRiT6yuiFnc3abfN7tPoUw2vmdM58lNZrsdl2PXn9bGOunwRmfFxMtO4z+6jGegigRuBXZCYp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(366004)(39850400004)(346002)(396003)(33430700001)(86362001)(33440700001)(186003)(52116002)(66946007)(66556008)(16526019)(66476007)(8676002)(8936002)(31696002)(36756003)(2906002)(16576012)(4326008)(6486002)(26005)(316002)(956004)(6706004)(5660300002)(31686004)(478600001)(6666004)(2616005)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ULQnEvIiOCFMDkfqcYkLKLaMWGuzsgDSeAm90yaUxLaY+tWc8pEj/BFwLChAQJ+zZbwJjh6r3idtK9JuGCU6T5uVBJ3IrcD6UZemdn8UiiSnG4Ob0m+wsQm9jye4EnRq6pAt9hsp6gJbIXoVhZdVMxbr24BjLSyFTyZLOkajbriZ8ZYP2bOr+/32WLhf5XVcDZ3K7wJihqLlGSUI0BkngRF8/eQQ0hPeAolusodKr9RwBpzM4Kql/DYbTVAdfTVMLPuDPvzrspFb7el2rGgiQVJoSI3NZOm/LGT4tsumcU/mvjcSiwdyMXvjakXxpnezVvf96KD9gtD9l8mZF+1I/mgD66y19Z1oC0dvYrman2dKE90CbQ8DuEu69WlYEBqK7VLRC/fWequg3Maccmz2QTOrp/NBaRNOisM/HZwVOqrJcvn7wbmzezlh6hJxU/7fLJamVn1UD09udT/PGJbqA/pEhfg5dK7W6y3bcjQGTjs=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081596eb-caea-4e0b-5689-08d7f73f06b4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 13:10:36.5245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fINA91SLSLbkWnT0TQoowVSxlrN9bCITha693l6wqSlAiF/ZtqiL2qpmebGqfcpHSNxFmeXJ9We0MwRSfc8RmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4372
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

After operating the /dev/loop which losetup with an image placed in 
tmpfs. I got the following ERROR messages:

----------------[cut here]---------------------

[  183.110770] blk_update_request: I/O error, dev loop6, sector 524160 
op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
[  183.123949] blk_update_request: I/O error, dev loop6, sector 522 op 
0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
[  183.137123] blk_update_request: I/O error, dev loop6, sector 16906 op 
0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
[  183.150314] blk_update_request: I/O error, dev loop6, sector 32774 op 
0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
[  183.163551] blk_update_request: I/O error, dev loop6, sector 49674 op 
0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
[  183.176824] blk_update_request: I/O error, dev loop6, sector 65542 op 
0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
[  183.190029] blk_update_request: I/O error, dev loop6, sector 82442 op 
0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
[  183.203281] blk_update_request: I/O error, dev loop6, sector 98310 op 
0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
[  183.216531] blk_update_request: I/O error, dev loop6, sector 115210 
op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
[  183.229914] blk_update_request: I/O error, dev loop6, sector 131078 
op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0


I have found the commit which introduce this issue by git bisect :

     commit :efcfec57[loop: fix no-unmap write-zeroes request behavior]

Tips: My reproduce command: mkfs.ext2 /dev/loop6


Thanks,
Yanfei
