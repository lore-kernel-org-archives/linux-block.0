Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F40C43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 21:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94945204FD
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 21:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfEBVv4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 17:51:56 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:34954 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbfEBVv4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 May 2019 17:51:56 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42Lp1lN006788;
        Thu, 2 May 2019 21:51:49 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2s84x29x8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 May 2019 21:51:49 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5009.houston.hpe.com (Postfix) with ESMTPS id 0819D65;
        Thu,  2 May 2019 21:51:48 +0000 (UTC)
Received: from G4W9334.americas.hpqcorp.net (16.208.32.120) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 May 2019 21:51:47 +0000
Received: from G4W10204.americas.hpqcorp.net (2002:10cf:5210::10cf:5210) by
 G4W9334.americas.hpqcorp.net (2002:10d0:2078::10d0:2078) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Thu, 2 May 2019 21:51:47 +0000
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (15.241.52.11) by
 G4W10204.americas.hpqcorp.net (16.207.82.16) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Thu, 2 May 2019 21:51:47 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.147) by
 AT5PR8401MB1314.NAMPRD84.PROD.OUTLOOK.COM (10.169.9.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Thu, 2 May 2019 21:51:44 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2884:44eb:25bf:b376]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2884:44eb:25bf:b376%12]) with mapi id 15.20.1856.012; Thu, 2 May 2019
 21:51:44 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        "Omar Sandoval" <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Edwards <gedwards@ddn.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] blkdev.h: Introduce size_to_sectors hlper function
Thread-Topic: [PATCH 1/2] blkdev.h: Introduce size_to_sectors hlper function
Thread-Index: AQHU/vSYwfJTOAaXv0uIxnt7/osef6ZYYxZg
Date:   Thu, 2 May 2019 21:51:44 +0000
Message-ID: <AT5PR8401MB11694BE736D8E344C94C2FFCAB340@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20190430013205.1561708-1-marcos.souza.org@gmail.com>
 <20190430013205.1561708-2-marcos.souza.org@gmail.com>
In-Reply-To: <20190430013205.1561708-2-marcos.souza.org@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.211.195.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65d69356-7f57-448f-3be9-08d6cf485e0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AT5PR8401MB1314;
x-ms-traffictypediagnostic: AT5PR8401MB1314:
x-microsoft-antispam-prvs: <AT5PR8401MB1314FD5C94BDDBF7D30ABC7BAB340@AT5PR8401MB1314.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(396003)(376002)(366004)(13464003)(189003)(199004)(14454004)(478600001)(305945005)(7736002)(229853002)(54906003)(68736007)(7416002)(8936002)(71190400001)(52536014)(5660300002)(11346002)(4744005)(476003)(73956011)(66446008)(64756008)(66556008)(66476007)(66946007)(486006)(76116006)(256004)(71200400001)(26005)(186003)(446003)(74316002)(76176011)(4326008)(53546011)(6116002)(3846002)(53936002)(2906002)(6246003)(99286004)(25786009)(316002)(110136005)(6506007)(102836004)(7696005)(86362001)(33656002)(8676002)(6436002)(81166006)(81156014)(2501003)(9686003)(55016002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1314;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BiKFbIGZiPBIKfWJEFoqkyzKEnpoHRBReIPGQzE8oGD50Eqo7hCxQviUBxnVqjno6toRBdlMyh8FCG7+amnlORv1DTktj4pA91YCKCkSQ4zSzaQNxiABozRSZ66fq8QyvdHmbmgZnB0E+Vte3hCoT9iCjTX3KSdpilOOA9BPDCMmZci6MHLhCuGRLQQ+PatZWDq2sqkpN7wBLUdmnDjeTGkctEbqxENdsSkTgM/9TsNx4oUdKy7eFXrxj/MflKKV2tiCjeT9jhXep6ALwjcyMmUgyBTl4QX/isABC7rYsJyP551+V9qX4whaIe9q9VHgJ4FqdNS3Pvj+QrlscCy8wr2NbIfU8cYGK6oidYyXjP/pEF8MUCs1V40aTbgAr/KIARa4WMjBfEPjXA+0r9WE0B+yF21Uh+QnDi1OJp5WjQ8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d69356-7f57-448f-3be9-08d6cf485e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 21:51:44.0758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1314
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=804 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020136
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of
> Marcos Paulo de Souza
> Sent: Monday, April 29, 2019 8:32 PM
> Subject: [PATCH 1/2] blkdev.h: Introduce size_to_sectors hlper function
> 
> This function takes an argument to specify the size of a block device,
> in bytes, and return the number of sectors of 512 bytes.
> 
...
> +static inline sector_t size_to_sectors(long long size)
> +{
> +	return size >> SECTOR_SHIFT;
> +}

At least one of the users in PATCH 2/2 passes an unsigned value that won't
fit in a signed argument:

-	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
+	blk_queue_max_discard_sectors(nullb->q, size_to_sectors(UINT_MAX));




