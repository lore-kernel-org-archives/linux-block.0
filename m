Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F89C05027
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 18:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjBBStb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 13:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjBBSt0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 13:49:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A1AF76C
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 10:49:15 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IDpOa011693;
        Thu, 2 Feb 2023 18:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kMU/F0c/wyqfruFk3vC8jk28L/VCR4d6zzlsLsDtJ6s=;
 b=x9Q1Wahe5yNqpT49Tt0ns25Tk1NeieLqr2g4lOKyZUn0bAY8TK49svQi5SNivB/rHxVJ
 itWewHevre55ZPPr3U9GftBX3LJoCr7FlMrSitknstP8o01ZQGc9WcH/881h/+dixOfo
 g6u+3Xku9x7M5/aIDNh2JqZbd0RTJ+QFZXrj3ri/fSvCGWYVX+3ddXL/QtIDtnnbp/Pq
 7OqYIfPCErk6kr+FkW7ppjEB3Jvy9DLFgtOCmHKRlFYMoRCaLwRHQ1P5GV2VAJpQlDFk
 uCGqx4tiyf5JHL5kkoYlukh9GifMAeAHHt85DpT4gxWpqeG2ASVvJS8bQ+iTzLHVxoEw xA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfkd1v3ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 18:49:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312HkZdI034241;
        Thu, 2 Feb 2023 18:49:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5g1763-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 18:49:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROCDqfFvoTwLSH6+tddqKAmRcwfb75UA32WE75GxzwdcJY1EM+0g3OCi9s/aAfY7knklNE7DxsyOhDxLNEwodCEL9kj8HfkzfyQ0VD+D8TcaeA4bwEANlPcK+9lvKjf9tNoxn74LRMp9iIqSuXZGPH50azVlPAq3d0cxZUT13XsvBTn4UYy0Uh8OTXwDeno/xY3qH9rH924drvn2wvjR6UK3WUPKrPMKJBduYc0wlsEf50Cs9KWrIwUCOe6gIhCZjDS9qDve3dy7XrttHQtXII03AzOtNvVUNUj6TJIdEKl4vS3jLAKudEIHhy7rHbuNFnpUr6H8SiCqukptOgNl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMU/F0c/wyqfruFk3vC8jk28L/VCR4d6zzlsLsDtJ6s=;
 b=gNkz1ncooLnUe7APepgt5CaUZZpAB3kXz/9N5A5gbsXvozcOMyr6TJSM4RDbnDB7Lj0K9aV+JBvBMv6cq0Hv2PKN2l3iTg0xekhJtSQkshJ12PUcrUbHKBFelrZLCB+2BqKAMXJco7ZNZtW1OmftTVbgH1QgedW0AkzkWMLDgcUv3/t43Vy4enIJ5il0aKS4SF6M2vBdNuQEczON9tunrLa0kGfZofkhcCkab3mPqQKzb5QnvsBsfE8b/II6q0ZLOAIyDlEC4N+xBH0AgC8G+/2cjtDwxe8vezAuSWcPZId97Vpqmg6MUfsY/yEJ7ZPqvfA0Tgz9O5NBgjiQrb6vLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMU/F0c/wyqfruFk3vC8jk28L/VCR4d6zzlsLsDtJ6s=;
 b=haN7j854a5yTE5mPHqHnd0hTeEF69GnQEF3ZXAbwhu5a1J21xSYbsaKbG0PvLqDEYkpT/k9FFhx76eZ1gbvZuAmmyl6w1aura41eTipGdPDGcUVqKvZUn0FspOoMn75vY1/43ex6xk17k/8plefJ+ASHPY1h0dhPowDrtvOoxlU=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by CH0PR10MB4969.namprd10.prod.outlook.com (2603:10b6:610:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Thu, 2 Feb
 2023 18:48:57 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::c033:cdf1:279a:4bba]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::c033:cdf1:279a:4bba%4]) with mapi id 15.20.6086.007; Thu, 2 Feb 2023
 18:48:57 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] loop: Improve the hw_queue_depth kernel module parameter
 implementation
Thread-Topic: [PATCH] loop: Improve the hw_queue_depth kernel module parameter
 implementation
Thread-Index: AQHZNO/FS+uKRnSUZE6ELfxm5rEro668BBYA
Date:   Thu, 2 Feb 2023 18:48:57 +0000
Message-ID: <C668BAC1-13FF-4A28-8391-8972D0541804@oracle.com>
References: <20230130211347.832110-1-bvanassche@acm.org>
In-Reply-To: <20230130211347.832110-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|CH0PR10MB4969:EE_
x-ms-office365-filtering-correlation-id: 37ae83ca-427b-4524-b699-08db054e2417
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mjk7dH9+iHNVuSwFxLbaoh4q9uEZA+bgNFcoXLiO6PBN6MirDz+vgXeyhh/VY0t3+BrCX9GtdmH3/2gojdYY3ulp9YLK9RgAzrcj6Tz8ixkivgQKGJXYLXrX45BxEGWYbsVG9GKkGVtWxYXGRlZyBnT+JDbTqXeMPtK4KmRLh1REhjbVmTxWpPjHB5NzXtvY+zcpxFZd3BPO0hytiVcHDt9tYb9h0r5LISztfh3wkpxZRmEIjs5iLswO1Ilziqhv6e7Lx5z8+P2Iu6J3EHtBLXc4MIi8x9oooQxR1gahzJlL7ottSn9zLQxSdtIr0RucVajdNysg3orRaQ5LKWrnxikdLJkGYqv3DwdPoN3KsnIQQ5QqLmv4MLoypBrWqHWpYvpFivdKbk1gi6tPNBTerYP4Jfla2VjMRe71rilWyXlnBIKtWbmHdj+DRz9vkQgrdhuXUY6arriHWB0o/UO1mn7xRcXGG9Gaxvwgf7gTbC0TRMQD2qPv3zSZMoZJxSdPU4YKWFEZQMz+KpPib9UiFUKNx+pjZ401/R9zILRIf3od6euC+PKHLTNfdOE4Mfo6+aRv/WlHuvLBzNm52TkMZEirCUnQDGQ1OJOvNCy2OvEII1JxQEaxH3PElTPdykUApQWnu8cj46YRBpa+ir3xeEaAUouFP+SUOf6omGJ/3koENLaLuUYR/DIRFD7kZvBQRfDF+Dfh+RMpsO/SHnyFWEBsiipa2cvyii5X5q6tgek=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199018)(6512007)(53546011)(122000001)(38100700002)(44832011)(6506007)(186003)(2906002)(8676002)(8936002)(86362001)(4326008)(66446008)(64756008)(66476007)(66556008)(76116006)(66946007)(91956017)(6916009)(83380400001)(2616005)(6486002)(478600001)(316002)(33656002)(5660300002)(54906003)(41300700001)(38070700005)(36756003)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a9vi4m3Wq560FU1XuiWL21gXnGigQ5+ILPDo67Wi6gp4bAvJ9QxOe88BfN6g?=
 =?us-ascii?Q?tMwFIpJlQnLFr1JYYZoteXYD9kaBlOGKDxbAMkDFkYniItkZjX7uEWxOq8bE?=
 =?us-ascii?Q?ivo1R3VvorW6pDxb6aP9/gkn4ttTOnOKhqp5ASeDZqmz4v5p2XUg3Iyfwb+V?=
 =?us-ascii?Q?jFlQT9/99ZTOGPG1bOFYErxbJVTYVAUX1CWLknuCua+pp1CwlQJo6FdUDKer?=
 =?us-ascii?Q?uAoL59ZR0xNpmO7Q4XjUW/FJsFB1Zl1nes0tV4PVQcU9cAHLvwSfBCxPFIhV?=
 =?us-ascii?Q?lrdIzhjE4chmIb0TelHEmX2+2AIVWLLgRQMDBy/x4rt6qBgDA9UsMRIUeV/J?=
 =?us-ascii?Q?5NB3c9CO76F770PXAPtKdtF9DBzCqYqdFV3zeGKseyCBiw2ygQ6iK4cgfBAL?=
 =?us-ascii?Q?C4KUGQa/D1wY0SfsOUzLmkK856zZfsMIjKpWmiyX7CT0VygxJubd3QZQcKb1?=
 =?us-ascii?Q?XSr+npkfKKXd4nlbvdlPZffz3knAgqIdkhph8nGIVkWQYwstBP8zUtEfYXYI?=
 =?us-ascii?Q?Fut5NSY9OnN3KXOptgesDTgYfMQBhR562dgLSU+oHgrSt4Irm+8XZwMICLbd?=
 =?us-ascii?Q?91QGGLBvAhHrPfXkDzU+RZBYc90UajpmwWYJvlYGRnzjWuxfOiC9TAUm34MC?=
 =?us-ascii?Q?tATHtq6FSdmdCRFtQAebdWBGqAR6oOmuKnfBWTwDwEOq36IEQURX0UKM+mgo?=
 =?us-ascii?Q?ECWPPVkQSIs7/x2YzqrMRl6vBtbye2ZB+Woe00hkBIoTNXSHs57ABZ2gV0gE?=
 =?us-ascii?Q?R99d1V3+ks+lKjowsdtJBFToRP9zwWyaK287s8MMkwwkAr+gwuerhd7sI4C3?=
 =?us-ascii?Q?jrT7zvRhIqnOxj9sMSTIpKTHhxfpAvfZpsG2au6DV47zJYK1ZWc0RM9K3yYL?=
 =?us-ascii?Q?xhilcoKL59O4tUeMQ3odvI1B+o1RcoYelMZp14VT25FPgwqk+NsMMsQ+g72U?=
 =?us-ascii?Q?tFZkiSdmIRpBiOrZ1V8LOezWfRF06+chkkNsB4NUVG36PYHejTdn5TkEVqcK?=
 =?us-ascii?Q?HHF/8McV76Qm225+pJ+v8km3ZwrN161UUgApvbmfvoODJJMN3oRnFxMnT/7Z?=
 =?us-ascii?Q?GQdZtnnarLePFKea/ROTJ3WUfYq/6NvHVRe3NN2NJ4D4UzFc8lRsYYMZpclJ?=
 =?us-ascii?Q?JX/S7mrNVHMcVaHh6/cGE0R6HAeP+D46i6M7e7XzRXHUf9Me6m2osR8ZQZic?=
 =?us-ascii?Q?LmLJ25jDckiTjysC+KqZmXz6jLUysN8WCpbgR8exOFNzKEYr1ncVFO3P/pUm?=
 =?us-ascii?Q?qrPkIcrlVadFECqZ220RLYXg8EbvMBTdARMVUMjB5i/rfp2eCCn5JvduDUb2?=
 =?us-ascii?Q?jZ9oK9oBqKALyj/PP1PLf5geiz3eOANyoKzDc4jfjvhP5TbE2EDP5UPKBZRs?=
 =?us-ascii?Q?vVQnT7QP1v+HVrCHeFsrB3uh6RiiINvkIIpTl11/4jQUnq31M+mpZbcJdM+5?=
 =?us-ascii?Q?VpfFV1OXvceyuIlodDuzB+pbiNlv3gUYd7/xw1/m5LG6N0dIGwL1TvqI1IfK?=
 =?us-ascii?Q?qeDDmkCDYu44FNjXcEEDyRmvbk5qTx6SoMa3+Jaf5/mu8DMqN+D8M+0QgXm8?=
 =?us-ascii?Q?gfAOwbts9G6MC25mRkzDLHKy/FEMdX6Q4pKHWuBTos9SMemZdsdxDEm2quYk?=
 =?us-ascii?Q?0Qo10u+ADnQpmXbLrhvFsoqZPyaXCPajsSzGg319+LgVgt3EUOQ2S2X63GOr?=
 =?us-ascii?Q?2mnLUp1aapQ9kcLKOgScAryyuQI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB5FED7A5DBCEF46A80446B5FD76CCA0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 85SIUXEvCltVBkNh2PcuaS53fXWZY0FNa3Hzmban9LR4dOzDT1vPHgkosdqRuGLsfDUVOXmus12BS8YYbgKF45awhdYzZLvEZKSv3LR2O/2NX5LbframhRxBvux+XLluOsqgNEWrycj16X8npzGbpYBXLhfH8Qi92/GcpqAhOmWDRZY/vvsJK+lLbmEQIa9yaVavIrHcpOPsfEjB3HmntWjYBqN2ueXw1akGHDlOn5eFri0wSu1wCbQKdnYaLH96HTgVcR71Z6AYdQ4+mg8H6urrJZqaYXKSvvPTmCbxfI3an9LkE/RR6XXe3T1UqXa+MDY+7Y9xGKslL906Z+ZpPccZdjJkM+P4SkK3FxsEIBcRh8HRxe+TjRxKbXcTkcpds66HZ4oTYCefb+WQK2jjkTotIL/kCSetaeAVlhQ4bhGhrcrCQvH6Unbd1JjXWH/dPuwcz28WF/baKQooeFsUeSNaJ6CvDrKADBzfsbUtA5X9lfioXWgECY1Y2CR1HRf0U2xy+pF3IRnOKe304pysaP+OvFGVlOIwSU//kqDAn1x9JohYJ0rc+vyp0y5XLgBXA3QvNclolZ2BKoNhF8Y3kaCXy7Rf3oc0N2xVEIt+f9J/UBVh7CMRtCfrhiKcvjyRsae+jCXIdDb/zgGOoZqphMB7clBhLlTLVxW1RM7mBg7hZINycheSblfFeiKQCOInZxTM3IRtflxJDvubg1yaBWWQjXBQ2Qu+dNVpz4x/K+hNINJOplOYyMiiZz+GiqbcJSdXRtnccvvclXvh7dD1vHk70u5aF1b/DBc6Pa+8xVSoTxM6xUGoWnXM54K8+Xu1i/TdPeAj6qC3ay0iAaBKPw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ae83ca-427b-4524-b699-08db054e2417
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 18:48:57.3710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMMsNEEDDNkMEFMy0vGo3eIvf33ct5fApMm/jmqqRVv/Lj/ycucGLzfBme9NzNus1L2LWRc+9bEDNaaMLGfcMLWulEXXjcrYZNrkffyAESQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_12,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020168
X-Proofpoint-GUID: 48MVLbknH9zriSFusYQoQkJKnDoYXo3V
X-Proofpoint-ORIG-GUID: 48MVLbknH9zriSFusYQoQkJKnDoYXo3V
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Jan 30, 2023, at 1:13 PM, Bart Van Assche <bvanassche@acm.org> wrote:
>=20
> Make the following minor changes which were reported by colleagues
> while reviewing this code:
> - Remove the parentheses from around the LOOP_DEFAULT_HW_Q_DEPTH
>  definition since these are superfluous.
> - Accept other number formats than decimal, e.g. hexadecimal.
> - Do not set hw_queue_depth to an out-of-range value, even if that value
>  won't be used.
> - Use the LOOP_DEFAULT_HW_Q_DEPTH macro in the kernel module parameter
>  description to prevent that the description gets out of sync.
>=20
> This patch has been tested as follows:
>=20
> # modprobe -r loop
> # modprobe loop hw_queue_depth=3D-1
> modprobe: ERROR: could not insert 'loop': Invalid argument
> # modprobe loop hw_queue_depth=3D0
> modprobe: ERROR: could not insert 'loop': Invalid argument
> # modprobe loop hw_queue_depth=3D1; cat /sys/module/loop/parameters/hw_qu=
eue_depth
> 1
> # modprobe -r loop; modprobe loop; cat /sys/module/loop/parameters/hw_que=
ue_depth hw_queue_depth=3D0x10
> 16
> # modprobe -r loop; modprobe loop; cat /sys/module/loop/parameters/hw_que=
ue_depth hw_queue_depth=3D128
> 128
> # modprobe -r loop; modprobe loop hw_queue_depth=3D129; cat /sys/module/l=
oop/parameters/hw_queue_depth
> 129
> # modprobe -r loop; modprobe loop hw_queue_depth=3D$((1<<32))
> modprobe: ERROR: could not insert 'loop': Numerical result out of range
>=20
> See also commit ef44c50837ab ("loop: allow user to set the queue
> depth").
>=20
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
> drivers/block/loop.c | 14 ++++++++++----
> 1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 1518a6423279..5f04235e4ff7 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -90,7 +90,7 @@ struct loop_cmd {
> };
>=20
> #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
> -#define LOOP_DEFAULT_HW_Q_DEPTH (128)
> +#define LOOP_DEFAULT_HW_Q_DEPTH 128
>=20
> static DEFINE_IDR(loop_index_idr);
> static DEFINE_MUTEX(loop_ctl_mutex);
> @@ -1792,9 +1792,15 @@ static int hw_queue_depth =3D LOOP_DEFAULT_HW_Q_DE=
PTH;
>=20
> static int loop_set_hw_queue_depth(const char *s, const struct kernel_par=
am *p)
> {
> - int ret =3D kstrtoint(s, 10, &hw_queue_depth);
> + int qd, ret;
>=20
> - return (ret || (hw_queue_depth < 1)) ? -EINVAL : 0;
> + ret =3D kstrtoint(s, 0, &qd);
> + if (ret < 0)
> + return ret;
> + if (qd < 1)
> + return -EINVAL;
> + hw_queue_depth =3D qd;
> + return 0;
> }
>=20
> static const struct kernel_param_ops loop_hw_qdepth_param_ops =3D {
> @@ -1803,7 +1809,7 @@ static const struct kernel_param_ops loop_hw_qdepth=
_param_ops =3D {
> };
>=20
> device_param_cb(hw_queue_depth, &loop_hw_qdepth_param_ops, &hw_queue_dept=
h, 0444);
> -MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. D=
efault: 128");
> +MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. D=
efault: " __stringify(LOOP_DEFAULT_HW_Q_DEPTH));
>=20
> MODULE_LICENSE("GPL");
> MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com <mailto:himanshu=
.madhani@oracle.com>>

--=20
Himanshu Madhani Oracle Linux Engineering

