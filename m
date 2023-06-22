Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2FDEB64DA
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 07:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjFVHbp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 03:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjFVHbn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 03:31:43 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA8F1BD8
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 00:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1687419100;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=AG4LM9LE/7Hb95M/si32+joDWjgyMBQUGI1eF8nR0lc=;
  b=GO7lZYCseBuwWKs+KUKkFcMAI9lpMqAOj6Y35SImGkTFV77x0xqU8OI9
   Zbe0QaKjRPNt+Kp8gV51giHxd/6nHb7Om87eF7lvTkSpJUJALCnpePqai
   VgkUK0kNVjMlZfRbtq2UgL8I+olregjPvknUzkaxAnLVDyzLv5iNP3UgR
   8=;
X-IronPort-RemoteIP: 104.47.55.176
X-IronPort-MID: 112451314
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:QPteUKLU3kPtFWuqFE+RM5UlxSXFcZb7ZxGr2PjKsXjdYENSgjIGn
 GofDW2PbPqOamf8L9x/YIizoUMHvpPSmIUxSwtlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/rOHvykU7Ss1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpKrfrbwP9TlK6q4mhA4AZkPaojUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c4vMH1i5
 /xIKgkVRU+GheGszZ6JFbZF05FLwMnDZOvzu1lG5BSAV7MMZ8CGRK/Ho9hFwD03m8ZCW+7EY
 NYUYiZuaxKGZABTPlAQC9Q1m+LAanvXKmUE7g7K4/dqpTGMkmSd05C0WDbRUsaNSshP2F6Ru
 0rN/njjAwFcP9uaodaA2iv13LOSxHiiBOr+EpWlpsRlv1LDyVc2K0Q9SUmjqMGDkUqhDoc3x
 0s8v3BGQbIJ3Ea1R9/0RAazoHOstxUZHd1KHIUS4Q6K0KbZ7hixAmkCUy4HadYj8sQxQFQC2
 ViTt9foAyF/9ryfTDSW8bL8hTO5MAARLGkfdWkFRw5D6N7myKkohx3OZtl5Eau/g8f6XzT9q
 xiJpjUljLU7jsMR0ai/u1fdjFqEqp2MQgMr6wH/RG+p7gplIoWiYuSA4FfYxexNIIaQUh+Ku
 31ss8qT7uomCZCLiTzLQe8IWrqu4p6tKybAiFRiG50g8TWF+HO5e41UpjZkKy9BKcAFZS3ke
 mfQtBlX6ZsVO2GlBYdyYoS+TcAnzID6GNjlX+ySZd1LCrB9cAKC+yhqTU2dxWbglA4ri65XE
 YmdfMuwDWgyDaVh0SrwRu0Yl7Qsw0gWxWjTbZTg01Kr3NK2YH+TVKdAOl+JZeMR8qyJukPW/
 sxZOs/MzA9QOMX3ciPQ/KYQIEoMIHx9CZOeg85YbOmYOSJ9BXosTfTWxNsJfoV/g6VT0P/F4
 nynQUJe4F3ljHbDJEOBbXULVV/0dZN2rHZ+Nyp8O1+tgiInedz2s/lZcIYrd7468uAl1eRzU
 /QOZ8SHBLJIVyjD/DMeK5L6qeSOaSiWuO5HBAL9CBBXQnKqb1ehFgPMFuc3yBQzMw==
IronPort-HdrOrdr: A9a23:smDzPa9nch/kvRImwsVuk+DpI+orL9Y04lQ7vn2ZKCY4TiX8ra
 uTdZsguiMc5Ax+ZJhko6HkBEDjexPhHO9OgLX5VI3KNGOKhILrFvAH0WKI+UyCJ8SRzJ866Y
 5QN4R4Fd3sHRxboK/BkXCF+15M+qjkzElwv5a480tQ
X-Talos-CUID: 9a23:fXMUfW7Kd72qpY4onNssrH8INtIlIn/k1FyPJk27E2tFeuLKYArF
X-Talos-MUID: 9a23:9/W5lgrNfJOXgXS1HuwezywyDshX7PShM2UuyL4aqdGNDRZrPyjI2Q==
X-IronPort-AV: E=Sophos;i="6.00,263,1681185600"; 
   d="scan'208";a="112451314"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jun 2023 03:31:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxKXK7T7cjfJsidrSJ2EUqIeA8MPkFQ5ALktxri8N9RufD7oU/4YjmJd5jF8h+nyof4BrEC4O/l5b/fwNluyiFg00u2mOl2S5BJC5TJkTipV62AET5RXB07yDhLCw/yPyu8S1dD3ouLPq/DKq/WHaImMIkwR9Ypmjc7dI1FpFruPaUZCCGZmq0EMOvtHA5pqm4SmSlr0jUx3UFf0fCeEIXUBVnmkgHfK7FLO6m4htCo3bKJKYsgoe1nHXMu2S051G1ZlxIn5m9Bh5ujY9560XfPdL/ffr82XnbodZvmxzrYzIojg/5LKnYxbzq/kDA6MeA4oUsc6/sbgqeuw3N/xPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r1S3/MPlivLXwZnJP5sTPBOu6fG2spm74NEi2e3VPo=;
 b=GoVuxAgT1elYagv6GmBwwb2OSZTA2BYra8ADSfHyY64XfvvysEnQEnygzzCgYQnVtrcevgbIYz4D7WPbH96y9ZNAQh13sB3O75Kate+Z2zrPR0UQHrmUChg9tA3/Wsa13hT3kpfNkxdiU/6tzoD/k1ZfffdXMIGrtRtRPDsWBFn8eA7kKNqks26Jqvaa6FV5EM3oTkoqzC+fxgFn+XuHIKOBBRb62jUlFIeNiLlLEiM2Rmrdn35l5Upyn3VeK6du8S7WqbcQqS8ecVP9zU/32XZOGSaYhqINEOD3NCl4HvtAAeieKscT7BB5pumddYA0jwOUhRRN2OG8wcbmNoP+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r1S3/MPlivLXwZnJP5sTPBOu6fG2spm74NEi2e3VPo=;
 b=HDQfyU0HQ8qGnhEWKWH+hinZoFrlY2NdL1ad3VEiDo+E1OjBSZ5fcwELrgXxC+2gdsT3PCDQonjxurORJranYe6ok0o+FGH0agz1II6QucUdrg2xNYCK5Awyi2iTId/NFHN3XmiZ+TEpCLxXj8d9rqflfpiczgWuW5XwTWgsdyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by BY5PR03MB4999.namprd03.prod.outlook.com (2603:10b6:a03:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 07:31:17 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::1c83:1877:a68b:8902]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::1c83:1877:a68b:8902%6]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 07:31:17 +0000
Date:   Thu, 22 Jun 2023 09:31:10 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 7/7] block: Inline blk_mq_{,delay_}kick_requeue_list()
Message-ID: <ZJP4vq6uol+4dSI4@Air-de-Roger>
References: <20230621201237.796902-1-bvanassche@acm.org>
 <20230621201237.796902-8-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230621201237.796902-8-bvanassche@acm.org>
X-ClientProxiedBy: LO3P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::7) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|BY5PR03MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd0e94e-8294-43b4-15e3-08db72f2aa0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwPpC4c6MYf5AK6Vvmpuxs9j47UfpKDsj87guNNbFVe6s2VV230i4KgBSWYy5M5JtFRXGAL25RuDBp6Y7DX50qQFlRgVV00RyD+zoRrpOz0XW0U2MrsewE7sWuGNgwQLTIxqOc+pGpEnn1YK6cwemeC/FZUtB8WhH+6OkdK35tOgvrNsInrvQaYlAVhk1ueFbNniXepMreAf96NNvPGZYuoftfTx8uRiG+oE/Uzu4zrGog7xfCDMbgCLNOHElLhFpTO/V0iEOsl58kq3iLs5kMjkIO0oJc7L9NXaxWQ58iz1HRFjOhztJLkT6g1fdoZVwojIzQdvlB6Bd84u+EWxCw7HiOiBqu0pQXTRsPQmVW9XBEqvdoOqKOzhKLFtACZAr2IMvKnyx5UoHm8M+PTqC6BMoQ2Q8LupCFZeRhDjYnuRwFiC0Ibjs8qwk4Of8KUGE0XLyKLv0r6mQdisbg4vMqai8oV3YaO8GtWeV7WCSRxOUNbb1JNg5JOaPtIt5epIsJo38DXL2Tbbl5ir7Jem1LA3r97nXDoWyXl/cQYenBIq3VU/za1t8vOmCPohsD0tsEHJ74CS/VV63tb2eTEfPNFMO52DLwWbowKkMU2EaQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199021)(316002)(83380400001)(41300700001)(7416002)(5660300002)(2906002)(4744005)(85182001)(8936002)(8676002)(38100700002)(26005)(6506007)(6512007)(9686003)(6666004)(186003)(6486002)(66476007)(6916009)(4326008)(66556008)(66946007)(33716001)(82960400001)(478600001)(54906003)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDgremlMM0wwa28rZDhNdnFsTU9tbXFabzVFM2xpMlcvMitEa0Z4TUJubEdS?=
 =?utf-8?B?elNPV0N6cjVqMHkzM0pqY25kNmpURC81S0ZuU2hLSmJHMlVjMytkUmFCdHZp?=
 =?utf-8?B?Z2RlL29PclRsbklKRnhLaWFmNjlqRS85cUNhdFk2MUlqNHcyWTEydSsyYThK?=
 =?utf-8?B?Y0NtUFJraDZDWVZ4MWI3UzNCb0dtWFovNm1TUDIzQzdhcVVtOVZ0emxZNWQv?=
 =?utf-8?B?cDJ1YVQ5VFN0cy81b2lIRnlMaTV0Z2ZUNDhTVlFWbzFOaTJyeDNkOVlwLytp?=
 =?utf-8?B?NnlMbUp2c3FsaW9nSzN5V1oxWEllTEwwNktRNm03TUp2VHpOSzB5bVJNNi9u?=
 =?utf-8?B?YUdoaHRPQThyK1lRR2N3T1VaRXdCbE9LVkk0OGV0aVcvdlE5TFY3N1o5MDJm?=
 =?utf-8?B?MnRvaklrTnZIMHRCWnJ4c0NCU2ZLc3ZzRTdReXRrdmVMbHhFWktlT0FGdU9G?=
 =?utf-8?B?ZDdIWUtwMzJaN3BTanFXZVB2dCtpSlhOTHdPRDk4ZHUzVXViQ2JBeHVaOFlB?=
 =?utf-8?B?czBmRlhmSS9IU0tvR0xQeHl0OUNZWlhuNjJibGg1TzZyd0hoVW1OeTlqZlpS?=
 =?utf-8?B?Q1FjZ1cwV1BpMDRxQmpTQzViTTRqREFvWDA0MEYyd2Ztb0pEUC8rMUQ4RnBM?=
 =?utf-8?B?ZnFHa3N2NmUwenUvU0VKV3FPNzFUbnppYVk3MEE1T1JOM3pJRGlQd3BONG5s?=
 =?utf-8?B?ais5dWhOQUxTeHFwaFEzb3BxUGljMVpXVTBYOGphNFJiZGp6VlZQa3NwUXM3?=
 =?utf-8?B?OURuQUpPbC9XcytDb2JRSjBpVCt6dXRoUDQ3ekxWaFpZQW40bi9NelpaZ0tY?=
 =?utf-8?B?eVlLMTFSUWdyMzczN0ZCTFlnQk55MDR5dHg0MkpzUkVJNS85WHJlaGc3cldm?=
 =?utf-8?B?S2cyQmJMRGp6L1hXdFQ3cS9lb0h3US9sRHlHRTdDbTBjU0FMTUc1OU9QdW9y?=
 =?utf-8?B?NUhKVXFFOStUWjJjYVdTUW50aDR5TEdidGJrdlF4ZDVjaTl3akRaRU9DZG42?=
 =?utf-8?B?QnpJOFBFZllSSjZBY2R0bTF3ZFNKTlNLckFWaVUwd0MzeDVrM1VncDZFaWlr?=
 =?utf-8?B?QVdKNy9sTFNjMGFFQ1ppWFZnN2JEdXZsL3NPeUtEeWJYVnIwMlZZNkNZSTFo?=
 =?utf-8?B?cXgyRm1WT3VZNStyNFZlSXdhWjUzVENHNEErVnN2WXlDVmVPZUNmV1gyT2dI?=
 =?utf-8?B?SVNmU0g2SEFibXNiTHhsWkFLY0NwZ2trQ0ZOellWTVArZWZ2bzhTR1VvRFkx?=
 =?utf-8?B?N2RlbGFsaHFFT2JhZ2pxQnF6c09meWt2UW1kbzR0UTUxUE9vN1B3VlR2VG5N?=
 =?utf-8?B?SmxZTzM0U25NM3FRS3hDVEdxMUU1OU05WEQwaEtBSGdKYUVvQW5YcEtwSTlI?=
 =?utf-8?B?eUJ2NjJMWFM5ZDhpTStkMDUrb1JjbXdkMXpIT2V1M1BQRFJQVit1RUVicjZU?=
 =?utf-8?B?RlBkcDk0SHpRV1lzNUpQSENjTVZrMlhKY2Z4ekhQcWFHeC9SeUtKMWFSWUFG?=
 =?utf-8?B?THBvRzBueEZBQkp4Rm0zaTM0KzNXNGh4TDA1dzVqTmxpN25tWC9HdUZsVDhK?=
 =?utf-8?B?cGF0MkNORzdrTGJjNGxOc2pEN3U4UkJOdUZBVS9UbFNSUDM2eGFrRG9BRWx1?=
 =?utf-8?B?Rnc2R0tmMGYvT05QTzZPbWoxT01zRmhSRXBFSEh0N0ZWdlhMdFhSNFhFSThO?=
 =?utf-8?B?MElHOUxmWU1GenNkb2txWXNLYTc5YWFML0RXM1RNZC9vbVNqU3cvOWlxbzJV?=
 =?utf-8?B?VUxmTHdVZ1Q0Zm9lVVkxcE5rVTZBRFFhVEFpNXB4dFdYL1JDSGZVcUxOL1ZF?=
 =?utf-8?B?RmR3VkwrSkZKYkVYU0EwN0NReWluSFFCZWxqVzNnQ3d0SmdpQXNZS0tLTGEz?=
 =?utf-8?B?Tk8zSVd1L3N2L3BUbzgzQlZ2cFJjTTd3bFpXS3FTOENuWWh5UXdweW9JOXRB?=
 =?utf-8?B?cUxxZk1YdzFvenpWd3c2dWV4V0ZQbEcyTDhrUmpNZDM0YXdXSS9wcmxCOE9n?=
 =?utf-8?B?YjRXNnlhbkNqZHBQSmROeTl0LzNWZFlZY2pTQjVYcFEvblBGNTFBTmVlWUE5?=
 =?utf-8?B?dWdHQU4yNlVxeFVjVVZkZG5Nb0I2aHVES2VVazVkd0dEd2dMRVo0dnZuNkY5?=
 =?utf-8?Q?DSKnrAImnazTbFzeKzkapBfaq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cXhvRm1jTzQ5ZlhLYlpScG55amFNUVYrQlhyY3RpVmtiOEVPMDR0RkJUamhp?=
 =?utf-8?B?aU8vL0ZRdVNLYjNtUE1VRTFnSkc0UmZxSk0xbWdra2YxQ2RzRGtxN0VGckxx?=
 =?utf-8?B?Q2JFRExKWmxXVHVpcFNvQU0ydkkwYzUwbEZFeTNhcWd6dG5yL1VQK1JEekFU?=
 =?utf-8?B?RmUwSnFXdEMvamZlWUN6S3A5cUVGK2liVVpIdXRuTmRYYU9mdVBmODRUSHg2?=
 =?utf-8?B?Z3p2NU1VUnQ0SFpJTlZtdkxnc1dCWWx3VWFsNVBsVE8rR0F6NW9UMGUvM2dl?=
 =?utf-8?B?dmJudVNRU1ByZlJSZXExUldqcDB3cHo3OE1JaEdBL04zNkhZS1ZleEs3UXZQ?=
 =?utf-8?B?R0l5SThHSjJiYThnOVBWd0dLR3NEbFA2c1FKb1UyTTQzUnBLRThGVlFmb1VY?=
 =?utf-8?B?OWZCNnlwVDl3S25LdzVVaEpLbEtxWUJpMWpud1ZVQlNrV1lUS0w3bXNjd3dm?=
 =?utf-8?B?NkxELzF5TWVOVWxva2FHSkcvTFA4MHVpYXRWL2JSM0dyL3Z0RURPSHpVL1ZS?=
 =?utf-8?B?cEZWend1eEpGMGpjVE9OcGJqVHppYlorUy9FdjQ5YTh5cENESzI3ZmZ3ZExX?=
 =?utf-8?B?ZkVJd2VMWS8wVmI1Q2hUV3dQdTA0b1lGODJPMytiaEluMU1ENGZYVnE2MU9y?=
 =?utf-8?B?dE5uaHNpOHVGZHpkYU84M3ZzOXRUaHFsdm5IN21mdnJBUnR3cUxSbGF1b0R1?=
 =?utf-8?B?WStpbFFzK0lLOVdGMkJQVUJvQk9pSkYxTUZhWmVmSDhlNXZ1SHdncHVqZTBu?=
 =?utf-8?B?ZVRmVjlEbU80bUNEak9UZHcvNzdLdW1aQnoxNFE2Z1hVQVFESFZxR3AwdXlQ?=
 =?utf-8?B?ZGxRczZYbXZDRWhwbUdHeUc2eGhMSWJRU1dTaFFLRFVyTWh2L1NSY3hVYS91?=
 =?utf-8?B?dG1oMXF0RWNoTkN2dWJiRTE4NzJFbEp2Uy9KOCt1WXhFc09jNHY0dkVOd2x4?=
 =?utf-8?B?N0ZYUEU2bFRMM0EyQTQyRCtQTy9WUnY5QW9nSUpEd0R4REY4ai9RcGRVMVJp?=
 =?utf-8?B?ajErTTZvSFlxaUdEL0hDNXRMcWVuU1Y2R3NPSDNsc1JYR2srVTZqNytmWXhm?=
 =?utf-8?B?MnhROWFTL29rQThBSTQ2bi9uWUtzNlppaUwvYWl0dFJyRHJpaEpyekM5VTRP?=
 =?utf-8?B?NVlsRkVmRld3c25iQWZCVE94c3pzWk52eUpydERnV0NqZ1YrdXR0ZkhIN1I0?=
 =?utf-8?B?RjA2RXdia0h0VzlNeCtEcW5TN3pObWE1V1I1NzlNSVhiTGlQZS9ja0JoZ3J0?=
 =?utf-8?B?VEJSNkFVc1hkamFJTHZua3E5NU1TSmVGMjl2M09uL25zVVFoVm9ybzRBOXZn?=
 =?utf-8?Q?r4+M2IXxCalrZCgnPMgH7iDZKAsmYWD9vY?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd0e94e-8294-43b4-15e3-08db72f2aa0e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 07:31:16.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iHjjPlZYx7iQD3cl6lg9PDELSowqHR+6OOv8J7jFsirjw5TXTXHAJjd0VoNjRoAH0U2+Jw85Ed/Eoi/WD/8ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4999
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 21, 2023 at 01:12:34PM -0700, Bart Van Assche wrote:
> Patch "block: Preserve the order of requeued requests" changed
> blk_mq_kick_requeue_list() and blk_mq_delay_kick_requeue_list() into
> blk_mq_run_hw_queues() and blk_mq_delay_run_hw_queues() calls
> respectively. Inline blk_mq_{,delay_}kick_requeue_list() because these
> functions are now too short to keep these as separate functions.
> 
> Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com> [ for the s390 changes ]
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

For the blkfront change:

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
