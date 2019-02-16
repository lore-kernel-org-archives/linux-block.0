Return-Path: <SRS0=0P76=QX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0500CC43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 17:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2502192B
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 17:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="B+fwx7PG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbfBPRpn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Feb 2019 12:45:43 -0500
Received: from mail-eopbgr790131.outbound.protection.outlook.com ([40.107.79.131]:38878
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726391AbfBPRpn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Feb 2019 12:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCLVr1lpXaEao7TBabQv6xMARFml7qIzbAltAhUxWQg=;
 b=B+fwx7PG6boFSFf4NQUZWFBQvbUYMHytdB4cRHXf9FySwk/mOWJoM9BRUGpShyI4TonzoB/xe4VDvG6NjM4vzVWS59zNISKCkOgN47J0oceHhbMoWHZ+Yih1NOgsYhM32FLOtS5PyrnbWj22w75S8rYXCJKRVRjsqCKycuEr2wU=
Received: from SN2PR01CA0030.prod.exchangelabs.com (2603:10b6:804:2::40) by
 BN8PR01MB5604.prod.exchangelabs.com (2603:10b6:408:be::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Sat, 16 Feb 2019 17:45:40 +0000
Received: from DM3NAM03FT009.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::206) by SN2PR01CA0030.outlook.office365.com
 (2603:10b6:804:2::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Sat, 16 Feb 2019 17:45:40 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 DM3NAM03FT009.mail.protection.outlook.com (10.152.82.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Sat, 16 Feb 2019 17:45:39 +0000
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x1GHjbS8028130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Feb 2019 12:45:38 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E51617A5779; Sat, 16 Feb 2019 12:45:36 -0500 (EST)
Date:   Sat, 16 Feb 2019 12:45:36 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Meelis Roos <mroos@linux.ee>
CC:     <linux-alpha@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: ext4 corruption on alpha with 4.20.0-09062-gd8372ba8ce28
Message-ID: <20190216174536.GC23000@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Meelis Roos <mroos@linux.ee>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>
References: <fb63a4d0-d124-21c8-7395-90b34b57c85a@linux.ee>
 <1c26eab4-3277-9066-5dce-6734ca9abb96@linux.ee>
 <076b8b72-fab0-ea98-f32f-f48949585f9d@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <076b8b72-fab0-ea98-f32f-f48949585f9d@linux.ee>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(346002)(39860400002)(2980300002)(199004)(189003)(246002)(8676002)(88552002)(1076003)(11346002)(446003)(2616005)(126002)(186003)(4326008)(486006)(26005)(106466001)(476003)(336012)(36906005)(47776003)(76176011)(58126008)(316002)(54906003)(50466002)(42186006)(16586007)(86362001)(46406003)(90966002)(786003)(52956003)(305945005)(2906002)(97756001)(356004)(33656002)(75432002)(36756003)(106002)(6916009)(8936002)(23726003)(229853002)(103686004)(4744005)(478600001)(6266002)(6246003)(26826003)(5660300002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR01MB5604;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73c9ca74-28b1-4ddc-9f4b-08d6943690fc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN8PR01MB5604;
X-MS-TrafficTypeDiagnostic: BN8PR01MB5604:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN8PR01MB5604;20:i6cnGP+MGkxwxt/tUxOurnUtgmN5EC/nHThOsZ5i9WTwwSjftZG1g+hKuYvfZ7HLD6mqCasqx2Uq+eV7+pqm3fVUxs20LahatwRLJR4FA56jgq3tuMJtw2hnxMWaRavhh2lmdDi7lqAnNyufGABiSpmGX7zlN6b3bfVdY+tKLaIQhBkaPQaKidIPLh/m1CDUOxRWzDs/dLI0dKPg6qCqYvKaj97zc0yZYpj9SCvyuJz+5pNONb86vgrztZcLzrit71Wu7JZstZXCex1dAxfzab9axGw8TEArC2aSvK75P6pVsTvMDtS5LKYk1TSSGCRJ9LInFtu453GkPQHklOPDd+Ekb9sW1A2TZZOXfwnbcsFI0PGsvl5Ih+3AUqLKVoXXrI2A1qg7SG+WlrBRtGmsqwb2ouLTRvHPs/8j1LQWUEf2lRYZVHLxTKb+s6X8MPrOfNKMWWlZZsOlQTa/T8xfOWSgI4G1owZzhDB8UmS1GqM5UYBfvlc/OHM1yQlDs5SEMd2vyVZUlVCcKilyomJSduU/UQsU1sKIzNfTWNr2ERvJN83YAjNZpOg7Ssdgk2ARNBL6XE9WQBJPk50XFYxYkf5j8ogWzgBKNxTHOFisns0=
X-Microsoft-Antispam-PRVS: <BN8PR01MB560452BB6E679B14E0BEF257B5610@BN8PR01MB5604.prod.exchangelabs.com>
X-Forefront-PRVS: 0950706AC1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN8PR01MB5604;23:yRWLhrb6oseS7TqYOShlkAyDQP9+zAbmMbGZDg+sI?=
 =?us-ascii?Q?tLl1TEWjV3+9nl8Xgq/4w/T0pGGqCamlE+yGJfxFBL8D2b2C1fq0GwuKsH+0?=
 =?us-ascii?Q?zyFSUXJI8q3Nzx+A3DbELjknk+FrklHxjX+cU6ipwjlVdJHYPHT+Go72UwZ8?=
 =?us-ascii?Q?ZgetTD/ap/B5Cb/0bmZVXXchklxDBAZ0nGjhtEIzSJjkerdhrOpOUTM8+R8P?=
 =?us-ascii?Q?H/zQnA8+qb/uF0u9wwVITOI92gcSO4IkcZKqajPKk8S6NDaFd4cCydLAJ1bl?=
 =?us-ascii?Q?taXtnG1B689fYAS1vX2WPACzLi5N+syXBmG39P1/8IzUIQWI62ywUAhZ5yCW?=
 =?us-ascii?Q?FoSTd+K+iU7malfd0cjXKPnQHWO0ahbHupeilsiSFcDAoIlUAddk010SSGca?=
 =?us-ascii?Q?bUTVjc2z+9cGXf5fh1cBk0MF6WgF6yy0QnVS0DEs6ALUiyzu92bBlSb1jzEn?=
 =?us-ascii?Q?oHx1DY4nk8MDGQnT2s4K7e6mFlMWsNJdiII9h1c0h+9ZjP/fqvlNTwtyB0u0?=
 =?us-ascii?Q?I8ZuVRMBSxWJSbXJmMdEAfo+zsHvaZzXAFOEbLFX2TiB/Bq3ZgFYH1xus4RZ?=
 =?us-ascii?Q?BwJdgDcuwIE2YXn6xxxDN07JaMwK0sJHsIbdwb6tE15sNlyPErnaEYl6lkIq?=
 =?us-ascii?Q?6aQihHZbGJnIDZckgBlGAHJ/f6rxr+2ZRB+4xeseoy0kr4OlatgB1ynQZC/i?=
 =?us-ascii?Q?eX/aopr7sG+cFFYoYf8SXU+MZB6SEpc1oJBPgwCgCfYCk3DTAukhNR/y93zG?=
 =?us-ascii?Q?WrP3tC3xTQ1sIEisXix5aTwq2eFclFnX3c4nuT8lb4ZdLWRvbMm9idFE3dsf?=
 =?us-ascii?Q?iTTntc86RO+QpIISsIK23uY+xvl4v7GkIDqghV1cL4LYuPBll1XQQ5k7cYGV?=
 =?us-ascii?Q?IHRkxr0icLclYKlRnHKaIH98YvSeEOoz6Fh2Sg2BpLMX21hbAbLbYl3dPQFa?=
 =?us-ascii?Q?UhkrcwsTGaa3KL/J97GUkEcmBft2TUgNDhrO5hYXBwX+wikeFmg6PcLNPjMw?=
 =?us-ascii?Q?8wwhQaRms/vuzcm5CwWG/6wbWR1pdsu4ESoG2vVmalyNqNisnfCF234ZWDXy?=
 =?us-ascii?Q?XqOwgNXh4OWLEPeGZaQ8f1CXfNSi4XbHD8uHOdBl4Sv8TdrSvdUW91eY1T3v?=
 =?us-ascii?Q?AYqSlvMHyBHJQHC1EtpGg7SH5c/eCL23O7k1/LujOUMhz8tofun9pc/CPssl?=
 =?us-ascii?Q?LB2/yNhRYBI/sVNIu3RgBVc13CZxkKq9RWabQix/Bn5FfEf5Z/s4GMAQJO+n?=
 =?us-ascii?Q?psuAyaCV6lMC1sDsDM=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 3eoLt8azQotth8emrYhEUeis/L5NctRQO0tefVx4EDG6SRLK045GLsA/PztkD44alyrF/po4/ilZb2zTsM+9z9Ttbvfk2qr9/FLi9i2dq5/mfagICpd8q2q8tGa1olBTpRsgo0cyUbdEM5wLy/JSeRUtLdQrAqc7jVByY2XO915iN9ELlzOHIrGEQzGLEAtazMqife856nlAVrAlMObCX83WR/LjaccCoDHs+QOOYGt5eN4B27u+nZEKfMp4nyIhoCa+3Ch5wqtq3iomAMCRtc/nHlNHeHBoGE0/Y9PRxAlmU3ZGt3bH8VV48PMK8ILdpcL5MZomiEki+uHKZd37Vt/JoVLKOPV2PDx3FqALR2OYjwSqURuS6QlRC4GL4Aveov2OlG5Dcezc2Yxni0cBPBueYKXZXOAOaBCMECM2Nyk=
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2019 17:45:39.5699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c9ca74-28b1-4ddc-9f4b-08d6943690fc
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR01MB5604
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 15, 2019 at 06:59:48PM +0200, Meelis Roos wrote:
> The result of the bisection is
> [88dbcbb3a4847f5e6dfeae952d3105497700c128] blkdev: avoid migration stalls for blkdev pages
> 
> Is that result relevant for the problem or should I continue bisecting between 4.20.0 and the so far first bad commit?

Can you try reverting the commit and see if it makes the problem go away?

    	    	      	  	     - Ted
