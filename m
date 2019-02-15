Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CE4C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 21:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362E3222D7
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 21:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="hDNqfYij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbfBOVkg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:40:36 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:52198 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732787AbfBOVkg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 16:40:36 -0500
X-Greylist: delayed 1282 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Feb 2019 16:40:35 EST
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FLE5T6025372;
        Fri, 15 Feb 2019 13:19:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=EUxBkeX6qUxJPavx6+hJTyfejlM8OEPcz6i3uIsVFH4=;
 b=hDNqfYijEGYPei1ijhypFMTUgnjCciBY759NfpUd+YxVUEqOsVRBEW8sVO7+SQy2b/Wv
 tAv/0dqukVtEpE6tD0+Qr0lvZHMf4icfE1H3FFU372o6o5yDKXr2+Gtmb/D+1WiTxaLN
 mZyOI+HAqLCau+WyB1muwTySWHhIBJpqWV75IFZN0h/9yAIZJQyrPXOWKcg/l2k7osWo
 LDUoP4ifvwTzTAsms0Xa1hcE8DOcbB8+vtCqXP91JYUa/842T5OgbGqo/Gzur04nDDez
 Dgw7TE5syPiA74y90SiCfgmJj6T63rHplQeHUPR60KO9KXtXqL5PzdXLCHjswJwPnllm KA== 
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2051.outbound.protection.outlook.com [104.47.48.51])
        by mx0a-002c1b01.pphosted.com with ESMTP id 2qp1uh8rxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Feb 2019 13:19:05 -0800
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.18) by
 MWHPR02MB2639.namprd02.prod.outlook.com (10.168.206.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Fri, 15 Feb 2019 21:19:03 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f54f:a1c0:e5e4:699b]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f54f:a1c0:e5e4:699b%8]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 21:19:03 +0000
From:   Felipe Franciosi <felipe@nutanix.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [LSF/MM TOPIC] NVMe Performance: Userspace vs Kernel
Thread-Topic: [LSF/MM TOPIC] NVMe Performance: Userspace vs Kernel
Thread-Index: AQHUxXQT2A4DbcGa+EyfB0ls4xGO/A==
Date:   Fri, 15 Feb 2019 21:19:02 +0000
Message-ID: <DAB8A2DA-37D3-4CBE-8AD7-356E3CE8B0D3@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 575de7ef-996e-4060-df5a-08d6938b35de
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2639;
x-ms-traffictypediagnostic: MWHPR02MB2639:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR02MB2639;23:tOu5jjH7nHM/1FNNiZ7BbM8YFHTwtYuwawKdYe8u1?=
 =?us-ascii?Q?nIF+2OnG1ZSCzOPy0qcVNI550qyp+BjuJku10qFvbFKax7GnJihgJyZOr5mz?=
 =?us-ascii?Q?xoINJk3W6/xqec1BwC22ky9uny6pX+6bZzpQh3/rtgIWIljVzZtfq87Yh11W?=
 =?us-ascii?Q?JpImYjBXzThKhYIQQiw69cB25FmqZ54E+AsmJL7575j9X3HUb0lgXK6c4/lP?=
 =?us-ascii?Q?lkWcCB6mlgdfbmZmYm77CqC1LXguZDGMEik3LEaQDLYdwcJaNN8lxhrICBkY?=
 =?us-ascii?Q?RIAZrj8NCdb2lsmamcJztYDFeaxU9VhMRmYy67LeYsMTb2reMwZFBjmjierz?=
 =?us-ascii?Q?ljGzi3yqBeUayTl4fsiHBcMZAcfuX14haBuqmwaCAYww0jaXVPO2k7GYfvvR?=
 =?us-ascii?Q?KrnC359o1SPLjfx0gQC5+pD5TLECyvXofuukvCpcctkXR3d/c3Zd1kZ/Np2V?=
 =?us-ascii?Q?yJX6XTn46xyhDtZ/EsiePJUz0xs4TzT9sV8BcsRVDIcfCNoJtOwunTHh0m9q?=
 =?us-ascii?Q?+TjqVW+PCliVT0CBbfwos3cgnseCUN39xMniCY6gfdSa8uN6+zzel2tpQh+6?=
 =?us-ascii?Q?WYOjD9/im2EkcArZARMjdGqZzDZlopLlaXToTilJccNtRA3uGJZLlzekImvW?=
 =?us-ascii?Q?biuuPju4ZQ4+VMNVh7ETiXV4LysOVJVRMCkEAchtlagCrxhgkD61/nkyYwTT?=
 =?us-ascii?Q?rfklFOiKSEHUMRTxcZ7AbEg6shov6nCnbkVBEwTK/gi8tXO4831eoPGx46Yh?=
 =?us-ascii?Q?1xHrizG95TEnEg19Ir1mwcZRH8Fm+80AToBDUph9l+E1jo06cgd04JklVt29?=
 =?us-ascii?Q?BbK8KOukpOOt3Ed332auN2zMyDSWA8S5aD1vnf6YZEs584PPZ1tUGUdPnvei?=
 =?us-ascii?Q?kJ8S+Og1ooe4ItAeLMl/FjVBMtojgOpo2A6Zq5XBIVU1rULPkQzJwCguZCxb?=
 =?us-ascii?Q?2TrtO6YldarTQoO9HdcdN+ri/pJm5EpIcYfLsdTMjbu7qU4ovMmTV6784End?=
 =?us-ascii?Q?yfaPjbhaBJd0NWbaMc+b+k0TmOkyk0NWCdDCwKHuxL53JXFfNa6MX5CEU+SW?=
 =?us-ascii?Q?WeCyyL49j3xADORKXiHB3qTLJWiRCJHvLt6h1ZB8lStBsO2b2dl5YP2T04gs?=
 =?us-ascii?Q?NhVECvH8Hw8EuScGborhYjqlOL0wo2DlEb7Y0dgoH5hdpzdEXcZn32D5KxI2?=
 =?us-ascii?Q?ABJUEHWcUyekdI2w0Hr1H8sGo9R3iq5WYocR+idf9VuSIfi4WqCbO1tSff+a?=
 =?us-ascii?Q?qbkIANCuHsovKy0U8rxbRfKiCPng44YdVW0SgFkUBBbNaKffHdkY7BsuVKaR?=
 =?us-ascii?Q?kwZlU0ahovWz1o1hpkVeOg=3D?=
x-microsoft-antispam-prvs: <MWHPR02MB2639FDE29A728DBFDBAEFECCD7600@MWHPR02MB2639.namprd02.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(53754006)(966005)(7736002)(478600001)(6116002)(3846002)(305945005)(2906002)(82746002)(316002)(36756003)(14444005)(14454004)(8676002)(81156014)(186003)(2616005)(81166006)(256004)(8936002)(5024004)(6506007)(486006)(2501003)(476003)(102836004)(83716004)(26005)(71190400001)(71200400001)(6346003)(6436002)(33656002)(6512007)(6486002)(97736004)(68736007)(86362001)(6916009)(5640700003)(53936002)(6306002)(66066001)(54906003)(4326008)(99286004)(25786009)(2351001)(106356001)(105586002)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR02MB2639;H:MWHPR02MB2656.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BDvLS7+d4VxpIoY9egMJ9trG59b707LKxcI8MBkKlVFsSbNirzYio2yH620ogc3xifZzZe9TNI3iFRNSTKdQ7E12PPOXJlGDkwKqzHPvZFoVgj8l+U4zf8AAI12TzP57Oi51Yhzg7v8nnEUESRqOnrOMJyHRZ0/J4nIoSSg/SJej6yD3TKPhphVKsII2lCmkIyg4DXK5D60rZCFVvjY8qcAdtaw7lkPSEFnsq5GuvsnXnTfoKinyldTy0ubsx71tUJjptn7hxa+Cu/L2TbZc1pU1ZDFPFQj6B0eoW24HbBMC9sTiCNpr1irIXkNOwyNMThGymKvi59Ii8v+Jn03aeIDu7jTu8F3JR+EcTGqx50oU0IZbwJxJ2y/PHR78CcVVH4whJvqY8eNw08+yZi5ZUcIlwGlgfDQRkUABEYF3p84=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E07921BFB16BA8409F875EDB0DA35FE5@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575de7ef-996e-4060-df5a-08d6938b35de
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 21:19:02.9957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2639
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi All,

I'd like to attend LSF/MM this year and discuss the kernel performance when=
 accessing NVMe devices, specifically (but not limited to) Intel Optane Mem=
ory (which boasts very low latency and high iops/throughput per NVMe contro=
ller).

Over the last year or two, I have done extensive experimentation comparing =
applications using libaio to those using SDPK. For hypervisors, where stora=
ge devices can be exclusively accessed with userspace drivers (given the de=
vice can be dedicated to a single process), using SPDK has proven to be sig=
nificantly faster and more efficient. That remains true even in the latest =
versions of the kernel.

I have presented work focusing on hypervisors in several conferences during=
 this time. Although I appreciate the LSF/MM is more discussion-oriented, I=
 am linking a couple of these presentations for reference:

Flash Memory Summit 2018
https://www.flashmemorysummit.com/English/Collaterals/Proceedings/2018/2018=
0808_SOFT-202-1_Franciosi.pdf

Linux Piter 2018
https://linuxpiter.com/system/attachments/files/000/001/558/original/201811=
03_-_AHV_and_SPDK.pdf

For LSF/MM, instead of focusing on hypervisors, I would like to discuss wha=
t can be done to achieve better efficiency and performance when using the k=
ernel. My data include detailed results considering various scenarios like =
different NUMA configurations, IRQ affinity and polling modes.

Thanks,
Felipe=
