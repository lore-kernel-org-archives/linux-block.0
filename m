Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE97C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 15:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE7C2083B
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 15:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="GQwms/vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfBUPEa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:04:30 -0500
Received: from mail-eopbgr820122.outbound.protection.outlook.com ([40.107.82.122]:31040
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbfBUPEa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 10:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYVMU5OBkzVhQHlxVtuIaGCpULMe8DtRyYSr1shIDVw=;
 b=GQwms/vgO0o9FYEPIlyGZ43pJG+MnF0BvwlzWEv0mNJjmbpwcrbERrDhpEvvgX9szeMm69V20IbW/xmbCOezHFtznxsEddr5w5nUeoO65ci6MQ0LfK+ntw42S94FnZ5YzivxG4Q0K2ayNybR2az/FWKebF3QGMyCv1V4l7wt6fg=
Received: from BYAPR01CA0053.prod.exchangelabs.com (2603:10b6:a03:94::30) by
 BN7PR01MB3985.prod.exchangelabs.com (2603:10b6:406:92::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 15:04:23 +0000
Received: from DM3NAM03FT010.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::202) by BYAPR01CA0053.outlook.office365.com
 (2603:10b6:a03:94::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 21 Feb 2019 15:04:22 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 DM3NAM03FT010.mail.protection.outlook.com (10.152.82.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1643.13 via Frontend Transport; Thu, 21 Feb 2019 15:04:22 +0000
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x1LF4JU5006913
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Feb 2019 10:04:20 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 958CB7A3F83; Thu, 21 Feb 2019 10:04:18 -0500 (EST)
Date:   Thu, 21 Feb 2019 10:04:18 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Omar Sandoval <osandov@osandov.com>
CC:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH BLKTESTS V2 1/3] nvme/002: fix output format
Message-ID: <20190221150418.GB4062@mit.edu>
References: <1550607835-11755-1-git-send-email-chaitanya.kulkarni@wdc.com>
 <1550607835-11755-2-git-send-email-chaitanya.kulkarni@wdc.com>
 <20190220180327.GA8325@vader>
 <SN6PR04MB4527D0FAE8B353AEA45E0CD8867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <20190220193500.GE8325@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190220193500.GE8325@vader>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(189003)(199004)(486006)(305945005)(75432002)(90966002)(93886005)(50466002)(476003)(6246003)(4326008)(126002)(186003)(106466001)(229853002)(11346002)(26005)(47776003)(46406003)(103686004)(446003)(6266002)(36756003)(2616005)(33656002)(336012)(76176011)(786003)(316002)(246002)(8676002)(5660300002)(2906002)(88552002)(16586007)(58126008)(86362001)(8936002)(54906003)(6916009)(42186006)(106002)(356004)(26826003)(97756001)(36906005)(1076003)(478600001)(52956003)(23726003)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR01MB3985;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11a8e69f-35e3-4cb8-6814-08d6980ddcd4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BN7PR01MB3985;
X-MS-TrafficTypeDiagnostic: BN7PR01MB3985:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN7PR01MB3985;20:tDEUjK85sfzTwuVWP+RjGA3sk1AZF6X3AVy6PUuEgcqJux93i9aP+WTPKmVVfOjoaW8isn6M4+z5Ji68Ha6h9MZfygFhoHW9p+pB/bwJIg7XqLelj2Z2vc8pOrZNaDQzQ9HgaMUuleTTui1hHznHDe68dwZhN4wWUSyE1D8L/0DyCxUjHp9TvalRksEz4X048y3L0wrHRGLoRCFPR75ZTASN0jswAL3sCAzyPQ7BWA7E/fQJHmWTmi+g5NBHQo6EJGGS/ky5cm/ONlzjM2UqUp0S5FSsa8qzc0rb7FPn4NU9ZFLrkPmm0u1t2Kjx7OR8XJwLYYd8grM3pYaWMwag6JnsZ50WCS8uNQiXl/8DIV3OJE/x85zraKi0q9Mj1e+6hgbZKRypVjmJ0ULcN8VerLGYoiF9PBElNpCL53UdD1+l6NLrlIh1ltx3jhMQjEfCKGjBrTqD9ppsqcxWEXMAMlQutQzN+ZTswXZBPMfDRv7MFlsZG8zvDH5t/dUkd8yyq+ibKpKl65XunNriKKq+sFMLSc264RhMVBjP4m2jGayzj+RlRI7qvLUV/1Sm6fSsLEbPN2gjyu1SSLW2sHv8DWzWCVvDauUF13FJGxDf29o=
X-Microsoft-Antispam-PRVS: <BN7PR01MB39850772B8461DC3C149E93FB57E0@BN7PR01MB3985.prod.exchangelabs.com>
X-Forefront-PRVS: 09555FB1AD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR01MB3985;23:62P6yJ1miGGvm35GjtY+Moe1T6kkxA0lrIDyfAZes?=
 =?us-ascii?Q?gBSkQIKWlKXCbN4gjL5iXgNDiRl0GLqcX0E//5AoealFTFed8K1CN21VxrJc?=
 =?us-ascii?Q?ezPxoYqROzB+8dRGcw4IPbbsw4G2+J9zUkmpsFL8TNt5WDAV/Ohvi+ry1tDU?=
 =?us-ascii?Q?HADSMauiq6qoOyy+NbuXAqajh2kJeEyZfx3WDl89QAyChh5cdjV0atrRSPop?=
 =?us-ascii?Q?E4qtGWcxhSR9NYei0Y9pmINt24zVy3tUvKPBzyT2WaNKza9NnyPlo/FFLmja?=
 =?us-ascii?Q?vGbBlt+4YxJHm+/DQFqLP5qfNNMd93296pFKAc24tKmQ3+xlitRwyMxvxLMq?=
 =?us-ascii?Q?8DmAAS6mMwM8NML9CkRo/0mirKaeyZ7leFSpSqnX0nzhTms5UBRLXJaCAunc?=
 =?us-ascii?Q?g9EhAgUb7v41U6M3yzMMRaZFbNnek1n6TnM+JdXjIQsVxWuBCKuy3fXT7k/2?=
 =?us-ascii?Q?uHaofYqeGKcZZ8/lZhhMYgXxbwMBKFsZVqILio+rbNS+4EyDtnl32wJ8e1DF?=
 =?us-ascii?Q?2x1R8KkzsJHJNNrFrAZi0EL6S1oj2zEnwx67vZOVLt6OpC0cPhip2Kw2m90m?=
 =?us-ascii?Q?mfUkZU7Jfseqd4eM29NYqotCUVdIGGLwa5PZqm+LkvcKOKoUIxm5TsBJhYQp?=
 =?us-ascii?Q?uD+6iMuCrkSKfhTJrVhZDyagp+YHaLkJeDq3FAg0oI5ZYqYX3/joHb4inDN+?=
 =?us-ascii?Q?5/WptrTyBmMPQ18cm/1h7xiwOmzV0JY+USvoxiJsDjtuCijfvmBG+urwfkQt?=
 =?us-ascii?Q?gaZdVL4C+2o4IgTC6P9zDYueop9TnJw4Y9JBFDBHWo/5J0etjDe0Ak0y593W?=
 =?us-ascii?Q?3+Q8U/v6mi4mZDz47KEL9QnuqrLSzwE4OCL3m3iPLlsdIDoGfTJS+Ez/3aqw?=
 =?us-ascii?Q?zbtdPAEw+6moDHNArBD3iiUt3VLb/yOSCzX/4GxDxpt3b8fzQ7qRqtnV2pjJ?=
 =?us-ascii?Q?vZH9waNmYphY8LKTnFTaIPJIGGg8ysSSDJYaQNvzfor7fI1SeFFc4FiLIDbC?=
 =?us-ascii?Q?/W2eCiq91PcHpAwbpGbdM+kefpLMfGOFWF2LtEnxOWZjwy7GWj6fhbj2SQw1?=
 =?us-ascii?Q?tzn2itvQ6549gBA4Zbh+xm4ytAm+/R0m/yNHYXwrT/cg768cKrpNYrtYr/dM?=
 =?us-ascii?Q?BIlGLZsvOFzwE0aXX0wA84dHK1GgAl4wbZnykl+zHHOYdZW0p5cZ84UmaGIC?=
 =?us-ascii?Q?8CFhmRzbw3yQ9ymdK9mTEMvecqk8nRrg6UKDFLyh3ItSkbYWsic5CvZFA1TM?=
 =?us-ascii?Q?vQ6NauHyhLtTBHCUw0+dqU+v2MfHNr/viOjEHlVWyzxTJXU/aMkTejstt0Mm?=
 =?us-ascii?B?UT09?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RyZ5e9/TLMWzRR3vNrwXtuDwpdpeHa+rMg7bzxJXzeKHHD/NuSLqfKKVoPUdM6G7gG1iRxINz3FZVedMsSVRLTnrs1jXLYvvsppWYcq3J6oHZeCiqkWfedGyUECtNJVHq6oAR5/HIJQK+kjxTo9eq1uwjO9TldieozeLjCuCFdB5N0yM2VdzrTsJcI1FSuSPyLxtwud7yhfZ1d+Sdrfhj734Bwl09xHBdmStCGLgCS8EpdQordJYs8pqpwHkPt1KdEtUvXaLGpALkC1YJM9uV4LfNq7AKpp4yXpiCNuur7u56iB68w9hO9hKB7U4OMLNYJyZeT9F3hlEhjHOzwdB+H5RIrqP88gz4qqpBNIVpthIlc2mJoqBVIpb3ll77W+oH6DZAlXaHt+sbsGvVrzcG/EtNHADM8/Yb/jPGPj+pE0=
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2019 15:04:22.2685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a8e69f-35e3-4cb8-6814-08d6980ddcd4
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR01MB3985
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 20, 2019 at 11:35:00AM -0800, Omar Sandoval wrote:
> > It should fail on older cli versions, we want latest cli/tools to be 
> > used when running these testcases so that all the latest tools are
> > also been tested for the compliance, else we might be running tests
> > with any bugs with older version(s) which are fixed already.
> > 
> > Actually I'd like to add quick nvme-cli version check at the start of 
> > each test that will certainly help/force user to have a latest version.
> 
> Perfect, I was going to suggest adding a check for the minimum version
> needed for each test.

It would be great if we could document what is (a) the minimum version
for things to work at all, and (b) the ideal version to use so that
tests aren't being skipped due to version constraints and so we are
testing the kernel as much as possible.

Ideally, tests should either be designed primarily to test userspace,
or to test the kernel, so that people who want to use blktests aren't
having to build the latest versions of userspace.

(As an aside, Bart has told me that the failures I'm seeing with
srp/002 and srp/011 are due to the fact that I'm using a version of
multipathd which is too old.  Apparently both the version of
multipathd in Debian stable *and* Debian unstable are still too old,
since they are still failing.  Next stop, building multipathd from
the git repo....   Grrr......)

						- Ted
