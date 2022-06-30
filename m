Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A0CC433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 07:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiF3HS0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 03:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiF3HSZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 03:18:25 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 00:18:23 PDT
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C6911A2C
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 00:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1656573503;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NWkjSvLNQ5I9aeYItIXWwodURLybtssDCZAfCsDPPUU=;
  b=EvBSZ6Lrkth5ZGMduCmFSpwuKfWtySOLA+Td8JdPPSwAAUR51YtMGv6m
   RZgY9EEQwedO5ii2Mg5oyIqVwPzNJdg6kcMc1wZFNt8w2v3VJeqFlDHX9
   1OzTgyIOlUfSEkQxUH+2QNNICVpq5FDEJ0fhUAYi5v3eVOUoKKAKWHBtR
   8=;
X-IronPort-RemoteIP: 104.47.55.174
X-IronPort-MID: 75188713
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:m7H6U6CXsPJxShVW/yziw5YqxClBgxIJ4kV8jS/XYbTApGwh02cOz
 jMcUDrQOPuIMWbycotzbY/gpkJQsMSBmoBjQQY4rX1jcSlH+JHPbTi7wuYcHM8wwunrFh8PA
 xA2M4GYRCwMZiaA4E/raNANlFEkvU2ybuOU5NXsZ2YgH2eIdA970Ug5w7Bi2tYx6TSEK1jlV
 e3a8pW31GCNg1aYAkpMg05UgEoy1BhakGpwUm0WPZinjneH/5UmJMt3yZWKB2n5WuFp8tuSH
 I4v+l0bElTxpH/BAvv9+lryn9ZjrrT6ZWBigVIOM0Sub4QrSoXfHc/XOdJFAXq7hQllkPhfy
 49un66Vczs3J5CXufkWajdKMDlhaPguFL/veRBTsOS15mifKT7G5aUrC0s7e4oF5uxwHGdCs
 +QCLywAZQyCgOTwx6+nTu5rhYIoK8yD0IE34yk8i22GS6t7B8mcH80m5vcBtNs0rtpJEvvEI
 dIQdBJkbQjaYg0JMVASYH47tLj13ymvLGQDwL6TjY4d/jPW1zNe7KmzPuDTVsakfsV0rn/N8
 woq+Ey8WHn2Lue3wySM9Hu3neTPkAvyU4dUE6e3ntZjkFeUy0QQBQcQWF/9rfrRokq/Xc9Pb
 kYQ/SEthbY9+VbtTdTnWRC85nmesXY0W9FQO+kh9EeBx8LpDx2xA2EFSntLbowgvcpvHzgyj
 AbWw5XuGCBlt6CTRTSF7LCIoDiuOC8Ta2gfeSsDSghD6N7myG0usi/yoh9YOPbdprXI9fvYm
 lhmcABWa20vsPM2
IronPort-HdrOrdr: A9a23:GjrPB6q5cydr3ib4bp4VB+8aV5uwL9V00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssREb9uxo9pPwJE800aQFmbX5Wo3SJzUO2VHYVb2KiLGP/9SOIU3DH4JmpM
 Rdmu1FeafN5DtB/LnHCWuDYrEdKbC8mcjH5Ns2jU0dKz2CA5sQkzuRYTzrdnGeKjM2Z6bQQ/
 Gnl7d6TnebCAIqR/X+IkNAc/nIptXNmp6jSRkaByQ/4A3LqT+z8rb1HzWRwx9bClp0sP8f2F
 mAtza8yrSosvm9xBOZ/2jP765OkN+k7tdYHsSDhuUcNz2poAe1Y4ZKXaGEoVkO0aiSwWdvtO
 OJjwYrPsx15X+UVmapoSH10w2l6zoq42+K8y7svVLT5ejCAB4qActIgoxUNjHD7VA7gd162K
 VXm0qEqpt+F3r77WjAzumNcysvulu/oHIkn+JWpWdYS5EiZLhYqpFa1F9JEa0HADnx5OkcYa
 RT5fnnlbhrmG6hHjHkVjEF+q3tYp1zJGbNfqE6gL3b79AM90oJjHfxx6Qk7wU9HdwGOtt5Dt
 //Q9VVfYF1P7ErhJ1GdZc8qOuMexjwqEH3QRWvCGWiMp07EFTwjLOyyIkJxYiRCe81Jd0J6d
 /8bG8=
X-IronPort-AV: E=Sophos;i="5.92,233,1650945600"; 
   d="scan'208";a="75188713"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 03:17:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKLvIpC5z4754uNEjhjFMqZhHwC4iJjf2pcKzpA6teB371q1f5hgPeuoHLdY9pwtywyAqirTbYSoFpKFt2i++rAmJ+Cir+yh9MdmFNDZfqIhtr/2HibELcY9+/0KvOsoBJCaBR8a0llCNwBw1tXYJ4UDn2q1jbn53FWYLr8pfgW0379chUk4nizekA90Ss4+AmDd077Ve8LxKnYbeSiQIT6f1U/MhJ5qng1KIGpFeDMu6n3f0d/Q1t3xrTEWVlLSUUjieJ0x+J4ESctJWayqsCRQfyJxf+hLnJkyt1uLF7CEWyzCNuzDxgjV97T+fjg4zFCnTdFU5SBPjoVN1JpMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDDtLMD077+tj8Mar6CxPc+KmZuoozsD4X295u8MeuY=;
 b=WHJDQ33xO8tiAN/7kuL6D0a7LJRBHyFQCnsAkXHSIECpXe022eonoIZIbe5jesR4EMj26EnxigHhlYkcav5HP06/Lc2WCaIQ6tsooGei5ryWvviSAvkwoVJuChUun4Z7KnEfnDu3S624AzynTrxyvZq0RqSG/ZFITS93ucVH1xSWg3dj7CJ3AiFoxxkS3oWLZOaKvxyM2xEjq1REJNWL4H4YZ1hQ4CIccczn1QuuKce72ulHUrs/sVa7WDQfKFDnwfxF8SfQLWUz9Z9m3zH44oz/kHiWLw3rxqAsn+kaOAwgc7To4Z8ofasHxOulR0ERjzW8idKcxwOwPwP6619hFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDDtLMD077+tj8Mar6CxPc+KmZuoozsD4X295u8MeuY=;
 b=ZG1f1OaS6zOkPC88erbnBURk8en5FXUybnt26qJeOlXd7anuHhs0S0RR2ujApZd4sAP7ypxyi3/pU9gbUDR0j9PH6Og21elxFCsjo95MP7Gs6XbyM/coBNbV4MPpmnR4/Jw3+2VQEtTeI03tVDB+M4JzvutZRpojEUkCT1kqizo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from DS7PR03MB5608.namprd03.prod.outlook.com (2603:10b6:5:2c9::18)
 by SJ0PR03MB6747.namprd03.prod.outlook.com (2603:10b6:a03:40a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 30 Jun
 2022 07:17:18 +0000
Received: from DS7PR03MB5608.namprd03.prod.outlook.com
 ([fe80::40af:d5f4:95eb:d534]) by DS7PR03MB5608.namprd03.prod.outlook.com
 ([fe80::40af:d5f4:95eb:d534%7]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 07:17:17 +0000
Date:   Thu, 30 Jun 2022 09:17:12 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 17/63] xen-blkback: Use the enum req_op and blk_opf_t
 types
Message-ID: <Yr1N+NMrPiJ8GbMx@Air-de-Roger>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-18-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629233145.2779494-18-bvanassche@acm.org>
X-ClientProxiedBy: MR1P264CA0156.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::17) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efd091a1-4f1e-4097-324f-08da5a689066
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6747:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vfggj0EpD2Pam7efx8YOGEcqkxN64bv3QlY+2dbZuJoiA/NWqCaEsREOpMBslHCxVkIr3APi4ZfY75i2/47aEu1OBaHwTH8usYihOh3Ts4BU/L6ZQHhpbWzvUzuAzlhCLXfYjtuInTvn/cf1EExIFL/TBY1LUXmbX+MIIdoGiv9w2cCiMTTQEiDOBcN3hQU5JLocBOa+Lb04r8GjilD3vEFV8VpSFtEth+RIlexjz8m7++K8yuFcRNx2fNM/frx/nWVC+ZZ1/WZ6AaZU6EKMoLq0PqzNTnox1fKtL/6YJbMJZvi8XCJZ9sdJ0FCRtLwHgwS/2FAzd/9LjwkQzrVM7vGLyGuf80BFNtIoeyQTyzhuPyMmW+8nny4EcDcfojad+TvjPI7N3v6gFWRuDQS2BsYiXnv2ElI6+YtNPCIbAHJ87s3xfxLPWT+rr/6bFoqAxOTz2ZG8MuoAFm5GZtHD1ZS4EC7HgeVM65aQu1vh5jLxa7QhHR8dxHU4xEsV/nqriAHbpNRT5lPnetmuAVdTqywwUW1I+SI1I2SSGDcHV5zjSv+xde0598dqNNi1LmbZOOmaSbx1LYtoJN0VuhXNR/9nVzWva9Q6jN57KvmlfopOrW24e2rbPEfKmqxVG6ZzPbPSs/SCKaEyj05X3Y81ztmxHyXFSDZoX05zhFy9xdC+iZCDEDf2GEgLHQeRkHeADs9D/JNweTuZs7kxKZDIWDFKS9pidO1iM0GWaVAAXFCpA2VmlBxT8Gngwr+ORbifwUzTNHXDh1RRLEvwbRlP3j50XMdH2Qaqss3at2U59PKIIrZra8BgnwJldFkCk9n8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(136003)(396003)(346002)(366004)(39860400002)(33716001)(5660300002)(9686003)(6506007)(6666004)(66556008)(83380400001)(41300700001)(26005)(86362001)(4744005)(186003)(82960400001)(2906002)(8936002)(478600001)(38100700002)(6512007)(66946007)(66476007)(4326008)(8676002)(85182001)(6916009)(316002)(54906003)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2ZNWkxyTGtuOHAyUWs3S0lNWUFORmNuOWNBTS9Db054bE9nckpDbGtyeTZW?=
 =?utf-8?B?aE9SdEw1Yzl6ZTJ6dTZGTzFwclpHZGQ0UHJUbkd3YnVIR1lBVGtzK0UwYmlt?=
 =?utf-8?B?RytORmVWbk5uQ0loUTlLSDd3VU5Vbm05TGpSWTFmcTdTKzgyK0VwekxmdzFZ?=
 =?utf-8?B?dkxYK3BzQ2xEUW1IcXVBbncxVWVKUHU1MmVlR3B2RnRqVU4zN0J5azlXUlZ3?=
 =?utf-8?B?VXJHbXQxaGdadlJ3ampyN0I5eFpTZ1Z1ZVNUeUpoU1FzNWtFdEgrZUp6OVVY?=
 =?utf-8?B?dmhyR1lpb1o2V3BsTVpRNVBiZURPeGV5K05JWFFjWlhOY2p1YkRDamdnb2R1?=
 =?utf-8?B?YngwK2FMVGlzRTZpWFY2bTZEM1JnKzRja09VcDZaZ0o3VkhZMlhQZ05WT2R5?=
 =?utf-8?B?alB1YXZqbDkwS3ZwOU5QcXJsK1JhL1BrV1R3YzZ2V0poUHpscGFPemNKQ2U2?=
 =?utf-8?B?SGhBN25mQUFvYUQ5dkt4bUd1bHlWdk1sY3lUTFRhQ1MzOHhoV084d2NsWmFu?=
 =?utf-8?B?NVo2dzBWN0FPdnpQUkUxd3Zwb2wrcmxrM3J3UzdtZGk1bkxVSXVCU2VkT3VF?=
 =?utf-8?B?Vm9mM1FVeVp3dGVEcmZwZkJvUnVxMjd1bDZxT2gwT2h3TXhLZTJULzZsUWJO?=
 =?utf-8?B?NlZVa0x4WWZDckpLaW9nUUVqNHNXaDBsOUxTVWsrOG5BUlpWRFFscEk2M1Rh?=
 =?utf-8?B?VWs4dkZFMVUrSDJDajdQUHVDY2ptZVNPbkh6c25sRTNQTFFocjV2REduSnQ0?=
 =?utf-8?B?TEpLVXlPUEl4M1ZuNmQ4SllXWHdwYXhXUFJYV092QVdtWnZMV2QxK0EwWDR1?=
 =?utf-8?B?ZldlZzJxVlBCMmNvSVcyS0NVMnZlbDJ6SDBndnhqWVBpaXh1ZGVYcGpCNnRZ?=
 =?utf-8?B?eldndVlxRm5QbWMwMWF5SW1PRlFVeXpxZVBVeEVQVVlmdmlnY3g5ZDlJS1FG?=
 =?utf-8?B?QTNtV2h5ZjMrZ3hTUVU4QTdsQ0xSU2FQZFc4azlROGMyTUw0cnExbnhpdnVE?=
 =?utf-8?B?NnBJb1c5RWxJc2NsakRrQU9PeUVqMUhxdW1peDVud0R2RmlBeXdTc1UyWEZj?=
 =?utf-8?B?RmZNNU1YVG5NY0YyS3dlOEV1c2RnUTZnZkdpTEVDRzZ0OW42WmczQWQ3ZXE0?=
 =?utf-8?B?UHlidDBhcmJwZGJRczcrWFdjSUtpcWhKMVU5N3NiL3AwSjRhS2g3UmQ2c01H?=
 =?utf-8?B?QnBRQklHUG9nYW96ZFVSdkVESm1WZWdzK2VrUWZ2MDFlZGJDQkdzS1FGRHdV?=
 =?utf-8?B?c1dKN204OVhMVUZoRW5HcjUvdzVDTlllMTZEZGVqcExqN1VsY25hQTAyK1g2?=
 =?utf-8?B?bENlS0lpdW5QU0Jqd3N2VUM1aTBraUo0L0ErTmhIQk95K1RMalBETFFDUnM2?=
 =?utf-8?B?OFY3b0lUTjdGQk9BMTJpQWtrSUFDLy9MZVJ3YllLNGVwcVE4VXNXYXdkQVA2?=
 =?utf-8?B?WFY0OGZzd2J5d3N6ZEhYODJYbkY4dUE5Vzh3V0h5U0hYT2tNWmFSdHBTaXVU?=
 =?utf-8?B?KzZaWTlldW5JR3BrWWxxTVluQ1dCTCt2Z1hFVzZPWWhtT0Nhc0dUMDVSUkhr?=
 =?utf-8?B?c3ZwMnhHTEY1RjUxU0ZKTWpvNkcwdlZBdGtQSFY0RWYxdGxCcU00bitLNnB6?=
 =?utf-8?B?MDRaMTRBMUhsQks2bURZdC9DU2NkR1VRaWJEWHB5V0FSbkZWeDhRTVRGSThj?=
 =?utf-8?B?SDRMcTNXeXhFeXR1TURSYklLNk5xQ0tYdXQ1dEl5a0lzaDczY0FTU0hXTnRL?=
 =?utf-8?B?bmYzWWtGalV1YlRsME9LVUppNFZlNW9CYVF2QzNxUkJUeENWT1M2QUhKMTFx?=
 =?utf-8?B?aEJKa3F1WDJwQ3AwcW1KdWJwQ0hMNjRhQ1pDQ0g1d3poQmJPdjFPOVl1cEZW?=
 =?utf-8?B?MSt4YnQ2L1RwNFB2dFIvTGtuWHkxNFNYanFmYU92ckJPeC9wRllqOEsrYTQr?=
 =?utf-8?B?aHZpTjBabU9WM3lVd1pIT0J3OTNtbFUxUG11OXZ1bmV4Vmh4WnU0TWpTU1p1?=
 =?utf-8?B?Uld2NVlZaUtSVDBtRitOZHJ4RnRmUDgvQjhpSUxXemVtNXQ0cmt6ZEtwanRv?=
 =?utf-8?B?U3BYbEtQdjlyb3RGL1NnZ2hNcUtWK3REVk9CcXNNVHAyeG5ldVZlYjFad21h?=
 =?utf-8?B?c1o0aS9wd2FVajlxd2pPZGpDKzNQU0V4bnF4VTVPNmRIdTAxTHR2akwrU0dK?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd091a1-4f1e-4097-324f-08da5a689066
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 07:17:17.2842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVaUTpryu6w+Blbqy3R+ISuBa9E1F42tNmToUEuazYeO66p/jlk0QIWZgewMlEyo5VqfcLjSIl0167lJFudUAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6747
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 29, 2022 at 04:30:59PM -0700, Bart Van Assche wrote:
> Improve static type checking by using the enum req_op type for request
> operations and the new blk_opf_t type for request flags.
> 
> Cc: Roger Pau Monné <roger.pau@citrix.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Seems sensible:

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
