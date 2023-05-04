Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F6FC77B7C
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 07:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjEDHQn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 May 2023 03:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDHQm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 03:16:42 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD8C26B5
        for <linux-block@vger.kernel.org>; Thu,  4 May 2023 00:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683184598; x=1714720598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=dObsPAYaAsk36zYJqWIgmn9/irvXlPR4Xfj6ahD7B6WkhgYPcIX6HT6D
   aj5Z/F72UyB4/q2kNEBqtb7Dy2Ql01epXfhSb5Xo9FhYXljnSkZjz77V9
   0KGl6+A00abLxkmA2UqNiDcoqVprZ4gob/SGc8VcCRICgV7qrlPOTCk/w
   Tt5Y3YlDnolTqDpnQACEnbna9dD1dOZfiraXo/YmVnzPWQnqEp+kl2ueI
   60vEkw29YPRpXU3Ub9PcUQ+ks+W+KdYf98EcNiVDUN3jn4MIJHj6jBllm
   txqjRzN+us1U4BQY91F9zqyOR+BCtvYTASUGiu1dmFgK6OAK8Hqu9uvHZ
   w==;
X-IronPort-AV: E=Sophos;i="5.99,249,1677513600"; 
   d="scan'208";a="228065677"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2023 15:16:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTC0DpAo2bOMdGq/YU2EPtBIFbuCVWVOQpTyPJyi9LJ9NO3UIXqibkju6XJKWv3/q4s8FrhoUYTeNdbm7TZt+i+5sxyfXlQ3YilcPe5SaiGGF6/slq5vEddwLyIf7lzcNlXLcjw7BZUsTioRk6navlvbLtigqlKQ67P0K8UT/axi159Ibr6ZBuQTAwppBAFFWffc0SPWkk8FVLUjCJYFVo9A6A+Moc2dxU88nRfQ/kZY2qrgHR36qs/drDLI1snBXntCuAIbm3/ljcfk2EfrJz+iiUkHhj6A3Z4KJV2S4yFjz6quhRK2zdsnbn1yu6Z7rlEeRpQBRoj1wcVbIuVaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=OSjCTryUcuLXyW/jcAUZpBUUOD3Q112/qDkoW5PscM4ygmBAiVHJLLMgXzJBRzsr2d/nADtEsbpzzTyK5WSWsUtUnyVHcgkTxqs7IsYi7EbNlj4Wf1F6G/VNf+/jTminzcRJg4Auv6ffvydc+CjM2lggP8yVpKx+zz2uV7+C/I0oC+qUJD07AZiQgtSDL9qnUBn9bX5S2xDf8UaY/q1HoRUby1p79v0WYDN1bxmyeiCeI0ybRqQlgkkBv1p6D+dpv1dGJWriyUCq2YFbt/wTjpz/kSjC+9B3sq0DF8zlj95G23Uqx8L0IBGzyeXm12z0Yhh6+DFp33qw12Q/8HOB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ya0HB3Evzfr0vGphsMHQapvyl6eOHZPY+JwL26e+PDd3nFcDNfywmeEobwh7cVKvXwGHz0KEleddYZkLcMNKnKn339J1PzCvoZ5n9LtudwOtwxGKrH4BS7nDbNw9TejL+nn6FaKrV+9cyuJvrYqs0Vb+y2IWAwvaxHmGhB5Cdio=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7687.namprd04.prod.outlook.com (2603:10b6:510:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 07:16:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 07:16:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v4 02/11] block: Fix the type of the second
 bdev_op_is_zoned_write() argument
Thread-Topic: [PATCH v4 02/11] block: Fix the type of the second
 bdev_op_is_zoned_write() argument
Thread-Index: AQHZfhHr2/Qn8m1Q/kGTXy7yq+CnYK9JtI+A
Date:   Thu, 4 May 2023 07:16:32 +0000
Message-ID: <29d8310d-62bb-5245-ca7b-7a4de0aded6b@wdc.com>
References: <20230503225208.2439206-1-bvanassche@acm.org>
 <20230503225208.2439206-3-bvanassche@acm.org>
In-Reply-To: <20230503225208.2439206-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7687:EE_
x-ms-office365-filtering-correlation-id: be0b47e0-43ba-4514-d107-08db4c6f7cd3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oWSokRBpEr3Q0QIpnN7nCvrAR6aGPETdXG3ousy23f8UXmEvbUUqewWJxJLSTAdiAsCwR3G+Q7RAHMq/gyVbBHAjTXINMrPFwd4Sbz98xoSPKSle8X4cINayKYiK2EdYdSY3J7zcew3AE0u9WC4LNN97GwJYcUTnXVhSayKq2LQX39xYhww0w7uySVvDajZf+LJY839XVPex6w6Mv6XF2sEkTpTTolYLz2YT38oyragi8fXzgaC2JL7DBTuL8U/UvskLw4E33sLXQ5W+/1V6V6GYpGA6DyDOcVWpKSwgqzDQX0fIcava2U2UHZm6Pfd1517QkD9IE3POA/5guWpUpwZZFYmCr/32pKG2fs2JGFAfJsi25vZ2/n7VeEwSc9CpSdGxrYBOG72cBGRxoXYxsMrJ0hfYyHepiGs0Pz1klayvZBMZObOKFWcNqga+yc8J0tbruzMNC71ZVpSuiWn6d/ZaryTbeyFzgnfjj/Z51wy/QgviQ9ijPd5TmA8zdOCM8N+zi4g1PmYzPWMFUMxuV9NQoXxgdSoLTo9IX2GipWkA4dstYnW3gnqSBTN/WddNET7c4cQLJ6kVBDJPNfdHZLX1L7Oej5q9aA/HypMkVQkL6PGAccpMdc+vsveAh1UbB9eKTLlyXsy/P6lN+szF0IOM2qXCeUxAx3VDp8sHpgkeBSn8QuOuTf0ohlSi+93G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(478600001)(122000001)(38100700002)(82960400001)(5660300002)(8676002)(8936002)(54906003)(2616005)(110136005)(6506007)(26005)(31696002)(86362001)(64756008)(66446008)(66476007)(66946007)(76116006)(91956017)(66556008)(4326008)(6486002)(6512007)(558084003)(316002)(19618925003)(4270600006)(2906002)(186003)(71200400001)(41300700001)(38070700005)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1o4L1RtRmFtbUpWMC9IZkxFNVhMaEtrMkN0cTk5Zk95ZXZCZWRRNlVWMFow?=
 =?utf-8?B?eXNkU01VNXhwWkNzN3plb2plYzlGQUlWL1pxMGU0QThHTi9JaU1ONVFHZHI0?=
 =?utf-8?B?TUY1bEc4V1hreHpNQzFjUCt5cllXZ1NPWHk0K0ltSWVBVTlzbngzVlFXMmI5?=
 =?utf-8?B?ZHU2RU9Ic1ZXYW5zREd6Wm1nclg2emE5QVVpRG1PeHdIMlFoQW1RS044RnB1?=
 =?utf-8?B?WGNHU2MvSWtWL3pHRzhOL0ZxT2hBNVdVYllGUi9ucWpsTVZnRURtNTF4TlVl?=
 =?utf-8?B?c2dyUWk4R1BDdjRXbk4wSU8wbTBWYm9UNXZaMlFTTzY5TDhCWndXOUZDRXV3?=
 =?utf-8?B?dUR1Vno3Nnp5dGtNazlFRWZyQ2YwZk1VZDMwaTlsQzI4MENXMmpsQVN4WTJB?=
 =?utf-8?B?cytMTHduZkFaenRwS0J1VkdqQ3NCSlN6TFh6by84OEpLNWU3SFExaStvVS9i?=
 =?utf-8?B?NEE0VDZvdzNsakpFM0dyWkxSVUttd2t2K05YanNOM3dySjRpVzA1cVZTOC9O?=
 =?utf-8?B?SUVXMnpzSnA0OVNobTFxWmtaVnh6dG1yc2pYc2lpVzVnUlRMOUtnTEN6cW9j?=
 =?utf-8?B?UlBRcVREYXBqN0tNSkVBeHZvVmR1d2ViZFd1dkdRK0hwa1p3V2FodHJ0b1M4?=
 =?utf-8?B?UXFjSUNWKzZpaEhjOG01cFNxemNjV0IrWE5vTmlBYzI1dzd0Y3JPMUUrMk1B?=
 =?utf-8?B?VFVEK1V3VzRhQUhmVi8rdkZpUEl3R0svc0grTTgwVlBMK29MUlFJRXhWTFFN?=
 =?utf-8?B?WHFuZERYME5ISWF0eTEyRWx5L3g5SGd4YUNOWXJGeEVkWU9BVHNhUXhOWDhk?=
 =?utf-8?B?aTBsZWwwT1l6dzB1R1lJYjJyNU9McC9NKzJ3RE4wVEQ0Y2pCemRFZnkzRit2?=
 =?utf-8?B?UmJYVDFLSW1hOHUvL2hJTUh6c2lGTkFLeUxPMXVwSlpPejY3bGhCRmhzanlj?=
 =?utf-8?B?aWdWQzRKYTI4N3A2Z3IvbGc0WXNNNVZQSkpUdUxHYXA1NUtUR2F5UHJCc2kr?=
 =?utf-8?B?R3d1TGRBQjdTem9vdWVXRGI1aUpQV21OcHdyUGZsLzE2aXRxbFlaK043dDVu?=
 =?utf-8?B?ZWFXMzRCeE5hb2YyVkwwRnhyZW0rbW5Cam44NFBMRDFCTnlUcUxMK2NmdlR4?=
 =?utf-8?B?OTEwWjRveTFPSDZ3bjZ1cHpoOG9SUW45MkVRNGQ1V014bXliMjl3bDM2UkNU?=
 =?utf-8?B?NmFQZUdjenRQQ2tYWTZ1cFFXUSsxSWRjbTI3aGVkclR6WjFEYWEvNTRTbUl4?=
 =?utf-8?B?c3E2N0tZcWUyYmxRRmxLUnk4TVNRWWE3OUpaUmNpaTR5MVYyNXZDVlh5VUlr?=
 =?utf-8?B?STBWMXNoZkRsQWR1TENOUmRiVEpaUXlBb1RaNkhKYTFoa1JwRm1JdnVacnpa?=
 =?utf-8?B?ZXhCaTNnczYvK0M5a21yNWwyUkcwTms0U28xbnJFSjhXVWZKc1FGc0JOd1Bj?=
 =?utf-8?B?ek9XZUxkQ2d0V242ajJhditJME16SlNoaERSZzk0dDJUUy9uRkFaNnlFUjZ5?=
 =?utf-8?B?ZVFMNGNRNUFKbStxcmdqdVBoaG9uNUEzQkVVVVlEL0dXR2tCZFdra2FKSkpD?=
 =?utf-8?B?eEVrTThpNzBOa1hnZnhWSGtKQnhCR0Y1ZU9aYUZzSjBwK0xmbmQzcVBXa1hq?=
 =?utf-8?B?aGxNVkgyY092UWt1dDVxQmdGTHRVZk5FcGp3RGtlaWEyQlhQd3lLKzNYU2Rx?=
 =?utf-8?B?MXNtNDQzZTlOdHpDM2tvQnZrOHhlRk9xeVlST1ZXeGpyb0hIY0UwUWVKWkNY?=
 =?utf-8?B?YUhSczVPZlUvaFB2cmVPSDdITXEvQmc0a2wzcytxSTFFWUt2RHg4UFlXWUJl?=
 =?utf-8?B?bHFZbEFtalp6ZWZEbWhKQ0orTkhtWlRZL0VuUjVuYytwcVQ3QWdlUzRGZ3Nk?=
 =?utf-8?B?eUF1N1UzTGFSVUk1bmdoR1hrQTVCaGRwaWowaU00SkV5eTFNSmd0NVFJbVhz?=
 =?utf-8?B?YjM3bkIyTmN5Nys1MkQxcHdlTVBJejRqRFg1UW5FNHFDQ05ubEMzS1NTUTdK?=
 =?utf-8?B?ZGVoeWVaaTVDRGN0d3BMLy9lakVMODRTL3ArcCtzeWpITDdyd2NDSEJ4NlBt?=
 =?utf-8?B?eG4rYTl1Zk9MdXBIRy9uZkN0SjVpWVZUbHIyYVBEcy9TUnFTUVVCZnQwWVNP?=
 =?utf-8?B?b1NxUEZ2aXhDcFRNenJBazlJV2xXRjR2SlBtL3d2Y2Y5K3A3R3pyWG04Qlox?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BEA2B9D83BC874C90EAA18FA9547E4A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WEY0ZXB1RmNmYlBFbDV5R2NwQ0NuS2EvRjRsdTM2ZUNyaWZJYWFCNHJ3ZzhJ?=
 =?utf-8?B?dVdLQk5IeVFwNGdFTllrOW5vMkxZa0w3YlU4TkxoOFNneFpPUlZmT3BJL1FF?=
 =?utf-8?B?ckpJNWdlQVprK01BV1RRcnhSZ3FDdjkzZE5HNTVqc3hFY2F0Z2d4WHF1am5N?=
 =?utf-8?B?VDZNdXdPbXYza2ZLUmRLczJFN2hnLzdwOEdYR3R6amRtSzBUWkZTMVc4cUZx?=
 =?utf-8?B?NzczWDN5b0FkajZNbWJQaVlzSExsZlY0QzlYRGt5d2ZMZkdzb2hwMlFrUENz?=
 =?utf-8?B?eUorM2VGdzl0bXVCdTlWampXeGkwT0JTRGRENitFMjlLbWdRenJzZE1ZSGZC?=
 =?utf-8?B?VE9peDJrVE9TVWFONHZFc2l3a1ZLWWgwakZXbUswRnNxdjE3TXdtMWtHY2hS?=
 =?utf-8?B?ZUMyMkNkWVo0b25oTVpRV0hqbmRqd2FVTXFNZGp5VnpqaTBCZmFsU0M4Q0wz?=
 =?utf-8?B?RHdHTSs1VWhqV0Z3WkovL09WcWhBNExJdGlLK0N0V0ppeTNQTXNPV24yNVov?=
 =?utf-8?B?aEYyMDZmL1JkSy9LSGFTcjdGYjI3ZCtFRHNsRXFQRzRjZll5TGFxY3czemdn?=
 =?utf-8?B?cG8rSEl2UjBYcXhhUHlUdmtPQ3RDTkpUTGd4NnZ1RWszdm9IRVlPUUhrcFJK?=
 =?utf-8?B?Rkt1RU81VjNjYnR5RnhKNUxGbjhQSlBoMmorUnFWSEJBazBBQk96UWFaSW9Q?=
 =?utf-8?B?Y1NOMVpNcXk1a3BJSUlROWg5ZHp1eUpCQVNpWTAvNUpsOUJoVWQzUjh4N05Z?=
 =?utf-8?B?NXd5QysyRTNWOUE4WjhTSllCMFVqc2NHem5SMVBlVTI5TkR3cGtyZmF6N2NQ?=
 =?utf-8?B?ZDFjSGZQMU5CRTVVRW9MOTU1cEpqU1ZlUEQ2T2J1bXNZbFdLTE82SlhFNkFC?=
 =?utf-8?B?RStnRHl5bzRtWTdMN05JYzdTOG52Y2hkc1dmOVpKZTV2SGpRSFMrenFHcW9Y?=
 =?utf-8?B?L2pyeDJzQk1xN29rblFaeVIyT1NtZzRTaUVWNEN4Sy9CUEJwMzZFQnBIUk01?=
 =?utf-8?B?VE9jdmF3OWN0UkZZU1RPM2pGaGtVNVpqa2pYZUYrWTJObkFEanNVN1NKWG9u?=
 =?utf-8?B?MStNaGc4d2dvSW40bjBnL3FubDlncFY5UzZ6RGM5eGp6OE9nalFkbDRGZmdp?=
 =?utf-8?B?d2hsL3FWY0RFMjRPWGt5cEx2NUFCd05sQVYrT0VsNEpOK1ZKZ21RekhkakZE?=
 =?utf-8?B?WTVTcUdRS2ZsSkNMaXNrUzl6YlVFNHZjVlF0MDliWWRpRnFiQzE5Q1ZWa2x0?=
 =?utf-8?Q?+eXQfOuqHnyagNg?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0b47e0-43ba-4514-d107-08db4c6f7cd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 07:16:32.2159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nE0xZJ9NE97OI+QolZD3rC1nRohkFxDD+m6eXeFUgisiSj9h7rOFLQXMyeBvrRj/YPakjphmfYS9giIN4fSqe6ABr/XP/qKyLeA8inJ9Z8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7687
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
