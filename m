Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBF2C2D0F6
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 02:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4490206F5
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 02:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="hgVDjH4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEMCmS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 22:42:18 -0400
Received: from mail-co1nam11on2071.outbound.protection.outlook.com ([40.107.220.71]:6044
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbgEMCmQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 22:42:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAP4bKfM7c78178VLESafdZkP8rKKiuL7g+OooRGhAdoKRk01m1NhrqZJik6x9QyxCkfWHBnaQ79TOwHxbGW5+U5LOEDHZ/90KnCAvnEVdouCIgZlEOV1tmrhD04RUCkVlpZ/o5VwtM9kPkBuw1qPMkejg3fFc/f3rOOb8Ig7aDtJfjZA5dOJ8nFoUOL5K0rUOMOXn26zIGW5AxwLQFoptfXCcRwKHoqatt4oBcbPVUcmm4l7k1Dpo4kH8pKRSickoWNg+BZXDFgLlUdFq2sTmVvIPjjWN+x/WbgNKdF8XfIG4v8A1djnI2eqGe6sanKIKWvo3l7Tayl3IXm7z4V8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKh6GJ4hX7qEOZAij/iGFCcbh4HlEgXnaObz5tB8Beo=;
 b=AGCntAP9gkORucdDdzoool0g0kJBG+TtC1RYkooCZJLKH85PqJ1dnLkFdB7VqnLwRO/aJSaKah2nME/zgoos5DqjMg+sjzR5WgjDNDsecQPaz6zhOx9vldSDfmATIxyU35FqQPlS6P81OWHMVepkRCUMNS1hRZIVB3ZDBP7/HsF2uZo4VUxVv10hCjFbjCuAibVwVgSgb1GhJ8rc8xNQhAb3ifyuuo2MxxVHMNvh+4/NN96VBLoCqqJHjneEWJQqP+cl0DPQVVxvWToEWSVuYK3sZvzxzgKizqhXflz2zC2xpadh/xIg5taLwZdybwrIaXyz5q4hYNlDzkeXgIMhmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKh6GJ4hX7qEOZAij/iGFCcbh4HlEgXnaObz5tB8Beo=;
 b=hgVDjH4/aGjwryEXjkUIKNGpLkHiNjPm7zvyAEcViYpgi5q2LuhkLlp0OZs73pB+2bYZjZe6BLagbLAauA7gUh2I0UCRo/Ovj2XoySQbAwGH3dlp4iYYNUZyf8SJEpxZkbKas5OFE4q0TuXEadr45867e3NLq0F1Aieudlrmhvo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB3909.namprd11.prod.outlook.com (2603:10b6:a03:191::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Wed, 13 May
 2020 02:42:14 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::21d0:98fe:1248:b562]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::21d0:98fe:1248:b562%7]) with mapi id 15.20.3000.016; Wed, 13 May 2020
 02:42:14 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Subject: [loop]efcfec579: BUG:blk_update_request: I/O error, dev loop6, sector
 49674 op 0x9:(WRITE_ZEROES)
Message-ID: <3df7e30a-2495-544e-1ac2-3b0afd3e7324@windriver.com>
Date:   Wed, 13 May 2020 10:42:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Wed, 13 May 2020 02:42:13 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5487637-59a0-4d73-6490-08d7f6e73e80
X-MS-TrafficTypeDiagnostic: BY5PR11MB3909:
X-Microsoft-Antispam-PRVS: <BY5PR11MB39099EED05D127064ACF2243E4BF0@BY5PR11MB3909.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHFI7AJ/R5WTaDexGIQs0qWOPhYk4/yffhg4FZG55xebQtumScy7PTHY1JSjiygL/7IhgYvknNrTRBOuRAc17iygGnYGxAkTCnkQvpsL3L1h3pCWoiMm32w8OJh3Fi4y2VauYLQZYKcwapGnFpbRhxm3oZrSO+bnDawwnQQLBtzPBHj36Apg3XYT4LsVK91ZKXOHWX2+Ch+PVK0oar867FoxAQKZkVataA/asGDSNHQOIZBfpWCQh/9aISPnPtJzvGqMVxQvt5kqqDIcwRKE00QV+/Mk3hLLvB2DZ+T4LVmRPSt0UXL+oP0QcPPWQzOgGH7W+kW2eNlPeofQ8G5MSgiNH6bFRBCSszDW2UlMmKLqaPmVcmYNnwvGkY4h8lOCnupv5Nyb/ssHqkD6Y+Rb+R9CRnQs0KHjJhwnFhuKN/32tgfkK4o1ZXuZEeXYyeleIT9CgWFUEvIuMv2y6pwNhue/zBP9p910hW9jMv5Z3irm2GKdhJ5fPGQrMI6g487mfncZDjKwo5BY95WKJAAJWqcojhgA+uZKSyvASpxF//anzYUiRbOWJtdRM3h7JzxHEUabeDuHJwsft3xMNh7CevLbVBRGVidX9oJRN+Y+0wFJSgBC3ZiTj1yUk2pyZI/v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(136003)(396003)(376002)(39850400004)(33430700001)(956004)(16526019)(2906002)(8936002)(66556008)(2616005)(8676002)(31686004)(6706004)(66946007)(316002)(186003)(16576012)(26005)(66476007)(31696002)(478600001)(36756003)(6916009)(52116002)(86362001)(5660300002)(33440700001)(4326008)(6486002)(6666004)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uPpKKYaz5TMQ9uoxxYj1ev72HkasS/BuUDfvC8vgsiMO2RVNpeSWyyGCcLcOBdTRipD7xCAeo6l54CzWR+ctE9t5inZ1cVmfG9+xQXPI1G3YuQ/SagdSThNBehh2OXIhUSh+lFSx5fSQnKEl4UOTYlXqE4WCbxAnKXmMnN0KST4n+AXdYW5UelHLQAE/JcFNo29CFjJxInCf2nqgrhu6y4K6qIW7pAHlacF1jcXgQx7OtOeBDeLcUiO2vocInne4RzzKWUs0OWWycEZdmVJKFACTjg7gQm6TY73zaqu1nH5SVZNIAjxTMt9stUgPSnCX3jYLGPJ8NqiyrUGBSp4jNALYWdgH1+jKyAGkomPn4ku2kpIKl1FMb8jsfmBEAx7BUk34T2DnZug03Q9pSNHb9AhGXOUMePrUjOl183NGivrwN7JNdCmKXlV4aKBd+W3o0WFfn42M6DSN7CgS+TQY2zzqJn6q//1CBoFU0HBT970=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5487637-59a0-4d73-6490-08d7f6e73e80
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 02:42:14.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4VYmLc8/zWPHq0208Po+6DkiH7Xk+u9Qlcx/X8wBe+V4+XPBjk15vuXW+B6A2EMc18bDZXv70cDr22KV2sw7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3909
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

After operating the /dev/loop which losetup with an image placed in tmpfs,

I got the following ERROR messages:

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


Kernrel version: Linux version 5.6.0

Frequency: every time

steps to reproduce:

   1.git clone mainline kernel

   2.compile kernel with ARCH=x86_64, and then boot the system with it

     (seems other arch also can reproduce it )

   3.make an image by "dd of=/tmp/image if=/dev/zero bs=1M count=256"

   4.place the image in tmpfs directory

   5.losetup /dev/loop6 /PATH/image

   6.mkfs.ext2 /dev/loop6


Any comments will be appreciated.


Thanks,

Yanfei
