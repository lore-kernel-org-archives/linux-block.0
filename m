Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B5DC19F2A
	for <linux-block@archiver.kernel.org>; Thu, 11 Aug 2022 12:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiHKMcn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Aug 2022 08:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiHKMcl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Aug 2022 08:32:41 -0400
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C0DDEC7
        for <linux-block@vger.kernel.org>; Thu, 11 Aug 2022 05:32:40 -0700 (PDT)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B9hXmT016182;
        Thu, 11 Aug 2022 08:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Qxs1vho2h+FUn8ameAaYJ2Oh1xEPyXVR0V0tPzn3Jso=;
 b=B3AawymU8Ajn3WzobSA47cR0amciwMImTkNl6pHoAfq0CPHMNPvY/wJEyDBlXkm3O//G
 6SxemBtuxCjiGURwVdZ0eUBIurlDuflWvr48cnSlwR7JV1xgQo2YM1x/s4u9NR2svFgp
 HBzaWJeOMZ7N0GO/AJnceGFwatqXvqWEGYpoWLAAqX2eSzzTgxFDa5ppdcmDzPGd1qmm
 jR6cuGVSN5wlfDvjrMfkWbk6rMD5GHKNZEpQ4I5fLZk9Vp3nj3lTtdQQ4avQUR1W92Zc
 uzewE1lpFum0wX6C8ciUb9j4GwE5dGVRGuVZGTd/l906sxUWWuwyMUizqVU0kzy5q7kA iQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3huwr58qbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 08:32:05 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BCVXuR009241;
        Thu, 11 Aug 2022 08:32:04 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3huwqjd6rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 08:32:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R80qT2GhXSrEcXMN0YYsAhoWE0COjdPb4OTBDtKvyb54fp0hH5U4M4nJyTFhbCqWBeFIApftvfUvdy7rD0VLaiukEWKvsZNSRT9w7RgHMBYtCQl9kXCfw206dZI5jDQ7pBj7rZZm0TqMPzZzKF/ELqHpMW5wZWdNM+va3UYJAOcZ5+BNQ+7Va6svHlhxdDD+LKb7969GrahW4bnE9NmCIUemrptPxAZWC99/9QIhpl1lh4TmyGpSYgnLjOZYI5ioBau+Ey+1rKbt+nEkWZ0eh5I6wBusBbkNRAMNM/QslqDELExGdJECquISo6yvRsLdisvMIHURVuX4kEotlbXOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qxs1vho2h+FUn8ameAaYJ2Oh1xEPyXVR0V0tPzn3Jso=;
 b=Pu3o9gh6lwDmpaXK3oAyYwPlOcWsnUfcuuQUP2u4X/4pfKBygCwOE3BMwgYnaxIleb2aB6MuoaaRYuVZFQe5XHfFSgaBkr4OP6s1B5hHNiiQebeuKnIpgNKMEhh19LHGpZtk316j1lRmTF56L9BeOE3hTxptsgqMWnyvaJ/fjB6DY/fCOQ1jRcYnk74JMPvQleqep5TxlAjxW+Z128SRL+luF2i8KH3ph2xll/ZC8HlEQ6AcYbtJXCNEMs6/xPkqEod5LHBh6LmrZJYFsR78PEPIMq3/4f2pEfrn3lGxFopnxPOyb2fSuC/TVBX4ntyu6TRhaJRl4nIh38+FOEOL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by PH7PR19MB5633.namprd19.prod.outlook.com (2603:10b6:510:137::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 12:32:00 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::5ca9:af39:ce69:34e8]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::5ca9:af39:ce69:34e8%3]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 12:32:00 +0000
From:   "Belanger, Martin" <Martin.Belanger@dell.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>
CC:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: RE: [bug report][bisected] blktests nvme/tcp nvme/030 failed on
 latest linux-block/for-next
Thread-Topic: [bug report][bisected] blktests nvme/tcp nvme/030 failed on
 latest linux-block/for-next
Thread-Index: AQHYp1hHwIQsP1xhVEyJNVNK9FScMa2dkjyAgADuIYCAAIlHYIAAhDGAgAnvDACAABxPwIAAE86AgAAAOpA=
Date:   Thu, 11 Aug 2022 12:32:00 +0000
Message-ID: <SJ0PR19MB4544D2851FADC899DBDEF9EAF2649@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <CAHj4cs_7kR6DXi19CWh3veespFT=cJSTD0YGEFt8tw_Y8fEqZA@mail.gmail.com>
 <CAHj4cs8zXRTPpHt0Xu5BtSGtERK8cgniwrRPygEL9R=6qxjT5w@mail.gmail.com>
 <3af8153e-5e7a-f803-4dd4-cf7088a9d7d4@nvidia.com>
 <CAHj4cs90B+=Sjr43Xf+DWXw=oMCFLNPmMdenhyQn9fG=-ZXtVA@mail.gmail.com>
 <SJ0PR19MB45449CEC5FCA24EBE6C9BB90F29F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <CAHj4cs82ssuVX25yeHXhtqkkApxJbWDaoyOgq=0u5C4LWF2btg@mail.gmail.com>
 <53ed5142-f9ee-f373-25fc-69c14bc372b3@grimberg.me>
 <SJ0PR19MB4544485314F5FDAF0159C0ABF2649@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <8a510b95-96e3-433e-221e-ffff06e04cf6@grimberg.me>
In-Reply-To: <8a510b95-96e3-433e-221e-ffff06e04cf6@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-08-11T12:29:14Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=ab618a1f-84b1-4185-911b-f6f5df9b597e;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afdda7a7-0572-4d52-bf6b-08da7b957d39
x-ms-traffictypediagnostic: PH7PR19MB5633:EE_
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iz5GC48fG2Zo/eUiU9o3d74bcrEQOUxsB0ct+nE4mr9plQ/L2dSZev87G5ZCH3q95BLFgBM/W6j9IMw3tmZE0ITvjuFKKrEUKFuRcFYWMrnc+0Bo1zh1NyT1WmKQX3qX7k1o/otoxJ87Deg5UWSfWe55KkF1c2VKh9FQi2eO/+AWiQeSIw/pmKmbnJ55BJV+S+mj6EBhKCIKAO+cvhWD4RAQ705BcY5mdBQRfwCi54qlXQ+sKtaDrG/Q5P6fSmIUvHkMPiwrrNEMtoBIziKci8wqwnjhwitUKDiw/G6kGuU6b28pOwMGM2XHnq6HfjE5szzqaHcObs+GOw0saYdrqiFRyXbAhIX4krueMh0nDm3kSwjUQBniv563Ie6Nd4Wm3YSM7nBtz7ieDuclzIiwEVitbPM/WDwVIX3ZHVkeGKNu0KcJruopkk7boHNTNy9HffWcN7NPV8CNvDCqX39fAujgu8QajfVwVAGMAD1qaAB9HhKc+uDG5e8JuT/TNHnaFfGLmQhOlDNC4yM4lnlUKSY6LnKjDtm3HPOOt9k9edmdSZsvZSDHolyt2WU655hgPLNqHrTuYdS13O69BJfd8bzSX0ftt3kfef9+r3hwZn0tLPN19rs1dKfS2k23rJzDKh+wGCRjAcVVHMSrj56vkSJwQClLbGDqKB1kzYXbggvDnjFZDcjVQMRb1rgO+NqQ1xbM1o5esS9WN4cp68e6x7216j+VCUDU68uQfCw2GVxEoFX89NEedlqPC5z5KH0hpiF2r4PBDnDIHmY4y0yCGwOMvaHfKmSqzXZb+NRkz9UNVy9SBOYlnKFSGQHG8pRC8uTKkfjR5335h3H8YAgwqHwBN/IDk9thKI+m7ciBFz6lqxWcvjPeE3UXEhEkPgq9HunOI6SjPJRWyrSehByyBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4544.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(122000001)(316002)(786003)(71200400001)(33656002)(41300700001)(38070700005)(82960400001)(66446008)(2906002)(64756008)(66556008)(66476007)(66946007)(53546011)(26005)(6506007)(4326008)(7696005)(8676002)(38100700002)(76116006)(9686003)(5660300002)(83380400001)(86362001)(478600001)(186003)(8936002)(966005)(55016003)(110136005)(54906003)(52536014)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEtOanNQV01hSXk4TVNGOHZLdW5OSFptZkVacVBncWdEeWcxUzkwSEN6N2Ny?=
 =?utf-8?B?bkxhQUFSaW9QNW82NHcwRVh1YUM2K2w2T1JUb0ZJVTNZQkVUTGJaYUNHc0NM?=
 =?utf-8?B?eFBlWHA1SHNHalo0TXVMcFJVUXN3QUg0QXhjS3NHd1gwZkJ1TmJjNmliQ2xP?=
 =?utf-8?B?S2t2RVp5RXhwWmhpQzhNSEI3b3RkR0F6SVduZmdERG10Z1JSbUlGS00rVnpB?=
 =?utf-8?B?ejFWUzlwMHdiOWUwZFJ0S2ZyRWFhTVRSdTFzZlJ4cSthSnRyK1A3TmpKbVdT?=
 =?utf-8?B?b2x2Yk13SmZqeUdNYmwyZjlvL3c3N2sxd1pXUC9MTkFhbDVKNWVnVndJZDNo?=
 =?utf-8?B?b1NDWW8vUVZoWnhRQXJSTUYwOXhteDN1ZkpUZEl2V3BEM2cydWduNG5iem9v?=
 =?utf-8?B?RVhQSmNjekZORUIzZnNwU1FRTzRjd0RTZXBhS0xCY0UyaWkzY0lKRlhkQ2Qx?=
 =?utf-8?B?OS9pSjUzaUp1UEM3bmJEcDFjaTBLYklTRVdNckpSMFZXM1R6N3VaVTdEVWVL?=
 =?utf-8?B?bUJuMjc2c0tvZ2ZSRnhzU3FGcDRwenFodDNBa0F3dlRnL3dQTGt3VUNHOXZx?=
 =?utf-8?B?QWdkcWFnY1lidUlVbHpNUUJMWW0yT1R6dm9YWDZqU3ZsenplbndNUTd6SzRn?=
 =?utf-8?B?TEkvS0QxdXlDR0dyQllFM3pNUlZuYWJvWU9JZmhQQkdEenJaaWQ3eE1IVGxN?=
 =?utf-8?B?akozZ2J1VjdTTUZxZ1picHN5Wk9DVVlXd3B2YU92MHVJYVF1UjM1TFhTTm5W?=
 =?utf-8?B?TVBWSDYxcnJSdnFIY3lPdTlPYk4yYjRuSGlWMTQvaXZaVE5QaW5KSjFiSHg4?=
 =?utf-8?B?ckFleU8yM3d5d2RLM1FsS3BxaGxtK0JNLzNPN1l2aW91MndrRE1EYUFGUE5H?=
 =?utf-8?B?dW5ndHh3RkhPU0FFWUZ2L2cyVHhTNzlYek5KUmRVVUZBZmROQkdCQlFkdEJN?=
 =?utf-8?B?cVBhSDFJellJYXRERXM4d2ozQ2VPMk54U3VnYUR5djAxdTZtM0ExWGJ2Kzdj?=
 =?utf-8?B?YlpPYXlVSTdQOWFUdTRWV0k2RjBJY1R2djNTVUlYa2dIcnp2N3UzaW9DNDBN?=
 =?utf-8?B?SzJPM1hGTkxldFJMcjBiNFF0TTFaUDNHK2xqSlJLS1NlMk9oRmZGWlphalFS?=
 =?utf-8?B?a2V6TGV3TUQrMzZQeVp0eGxsWFhnRndHTkJDWU1KQ2Y3N2R1RVdUMUs3MnF5?=
 =?utf-8?B?NVJjdktmYThnMnR0U1FpaUlGd2M2NEpBSXB4TkZGWDl5aDRPdFFkUVhzRk4r?=
 =?utf-8?B?QWZBbTEwK0Z1Mkd2alNHWVNRR2ZjMS9HYW42cFZxeEJDci9ia2NGdzMvYXZp?=
 =?utf-8?B?S2hpNnpFdjJxTDRDSVFya0hIR0NMSTlnZ1NIRGpiNndNWGdjcVE3WVAwWVdX?=
 =?utf-8?B?NUJ4UnZFZWFLYnpFRzQ3RzFvTTN6bE9MdXBLTDl5d0dNMVJodzA4cGN6ajJu?=
 =?utf-8?B?M1BZRlJVMmtISnlzRW84cHBDRGxuWE1kRkZDZTNLU2hsWGZVN0FsS1hBbnpV?=
 =?utf-8?B?ZEFjcFlleUUxMDNVSmRJcktGaWtrak9SNURYcy9BMGpFaE5oalJ3UDlOZU5G?=
 =?utf-8?B?WUhRdXhvbkw1Y1ZEWU41aWxyc3JXeXhBOWNOUER6QkV0dldWRFprSyt6K09J?=
 =?utf-8?B?N29XVFNGM1NHeXdSaWQremR3SmpHWjVXZWpDekNSckdiaXhoZ0NlMHZZNEVH?=
 =?utf-8?B?T1pzajZCN0hJZVZJN1p6aUxEekorZS9VVWZuV2U3RXNDNldRaldtbSt3TnVp?=
 =?utf-8?B?aFZlQzMveU9WNW9zUmdYUldIdVBJTURLK1ptN1A3eHQ0S0Q1N2lzY0Q0UFJW?=
 =?utf-8?B?aHdDb1dMczBSZFZBVjhYM2FQYWlxek5NVGxuTFJOODBmSmlqOSszbHpXTk80?=
 =?utf-8?B?OS9QVzgydW5wbC9xbnBqcGt6NDArd0VmMDFOb2d0TE44bzNjZHp1NXhZRmVp?=
 =?utf-8?B?NGpYKzhXZDdhK1o2MjMrbm9yaVU5dkpuWGlzNDA4bHRDUGNLdStIMlVMQzlr?=
 =?utf-8?B?Y2ZTUFVndysyMzJjNndaUnFUcEI5YUgxUEZHY1U1czdkSHZPUUNjVXNITXI4?=
 =?utf-8?B?elVCcWUwd1MvcmtWUnR6NUN1akJTQzlSL3JEVkt1dzJQZHh3c2YwRGJKdkZh?=
 =?utf-8?Q?SHtH3HdQMEMwtMfKtdnzHQtGX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afdda7a7-0572-4d52-bf6b-08da7b957d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 12:32:00.7001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JnmgJMHfcBiNNuJ3dN1u6/m/OPU4x1pHmSaT2JPM3RpkvbMFUSCJ8++Tbb4C87So2KjG1iUeu/Bc3+6/eOvNFhzww3rtH7aT362ZeMf3Nn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_10,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110039
X-Proofpoint-ORIG-GUID: zPt8N1yzZbfIR7xz5H3ENNjyEPkMiU0g
X-Proofpoint-GUID: zPt8N1yzZbfIR7xz5H3ENNjyEPkMiU0g
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208110038
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYWdpIEdyaW1iZXJnIDxzYWdp
QGdyaW1iZXJnLm1lPg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDExLCAyMDIyIDg6MjggQU0N
Cj4gVG86IEJlbGFuZ2VyLCBNYXJ0aW47IFlpIFpoYW5nDQo+IENjOiBsaW51eC1ibG9jazsgb3Bl
biBsaXN0Ok5WTSBFWFBSRVNTIERSSVZFUjsgQ2hhaXRhbnlhIEt1bGthcm5pDQo+IFN1YmplY3Q6
IFJlOiBbYnVnIHJlcG9ydF1bYmlzZWN0ZWRdIGJsa3Rlc3RzIG52bWUvdGNwIG52bWUvMDMwIGZh
aWxlZCBvbg0KPiBsYXRlc3QgbGludXgtYmxvY2svZm9yLW5leHQNCj4gDQo+IA0KPiBbRVhURVJO
QUwgRU1BSUxdDQo+IA0KPiANCj4gPj4+Pj4+Pj4gbnZtZS8wMzAgdHJpZ2dlcmVkIHNldmVyYWwg
ZXJyb3JzIGR1cmluZyBDS0kgdGVzdHMgb24NCj4gPj4+Pj4+Pj4gbGludXgtYmxvY2svZm9yLW5l
eHQsIHBscyBoZWxwIGNoZWNrIGl0LCBhbmQgZmVlbCBmcmVlIHRvIGxldA0KPiA+Pj4+Pj4+PiBt
ZSBrbm93IGlmIHlvdSBuZWVkIGFueSB0ZXN0L2luZm8sIHRoYW5rcy4NCj4gPj4+Pg0KPiA+Pj4+
IEhpIENoYWl0YW55YSBhbmQgWWksDQo+ID4+Pj4NCj4gPj4+PiBUaGlzIGNvbW1pdCAoc3VibWl0
dGVkIGxhc3QgRmVicnVhcnkpIHNpbXBseSBleHBvc2VzIHR3byByZWFkLW9ubHkNCj4gPj4+PiBh
dHRyaWJ1dGVzIHRvIHRoZSBzeXNmcy4NCj4gPj4+DQo+ID4+PiBTZWVtcyBpdCB3YXMgbm90IHRo
ZSBjdWxwcml0LCBidXQgbnZtZS8wMzAgY2FuIHBhc3MgYWZ0ZXIgSSByZXZlcnQNCj4gPj4+IHRo
YXQgY29tbWl0IG9uIHY1LjE5Lg0KPiA+Pj4NCj4gPj4+IEhpIFNhZ2kNCj4gPj4+DQo+ID4+PiBJ
IGRpZCBtb3JlIHRlc3RpbmcgYW5kIGZpbmFsbHkgZm91bmQgdGhhdCByZXZlcnRpbmcgdGhpcyB1
ZGV2IHJ1bGUNCj4gPj4+IGNoYW5nZSBpbiBudm1lLWNsaSBmaXggdGhlIG52bWUvMDMwIGZhaWx1
cmUgaXNzdWUsICBjb3VsZCB5b3UgY2hlY2sNCj4gPj4+IGl0Pw0KPiA+Pj4NCj4gPj4+IGNvbW1p
dCBmODZmYWFhYTJhMWZmMzE5YmRlMTg4ZGM4OTg4YmUxZWMwNTRkMjM4IChyZWZzL2Jpc2VjdC9i
YWQpDQo+ID4+PiBBdXRob3I6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubQ0KPiA+Pj4g
RGF0ZTogICBNb24gSnVuIDI3IDExOjA2OjUwIDIwMjIgKzAzMDANCj4gPj4+DQo+ID4+PiAgICAg
ICB1ZGV2OiByZS1yZWFkIHRoZSBkaXNjb3ZlcnkgbG9nIHBhZ2Ugd2hlbiBhIGRpc2NvdmVyeQ0K
PiA+Pj4gY29udHJvbGxlciByZWNvbm5lY3RlZA0KPiA+Pj4NCj4gPj4+ICAgICAgIFdoZW4gdXNp
bmcgcGVyc2lzdGVudCBkaXNjb3ZlcnkgY29udHJvbGxlcnMsIGlmIHRoZSBkaXNjb3ZlcnkNCj4g
Pj4+ICAgICAgIGNvbnRyb2xsZXIgbG9zZXMgY29ubmVjdGl2aXR5IGFuZCBtYW5hZ2UgdG8gcmVj
b25uZWN0IGFmdGVyIGEgd2hpbGUsDQo+ID4+PiAgICAgICB3ZSBuZWVkIHRvIHJldHJpZXZlIGFn
YWluIHRoZSBkaXNjb3ZlcnkgbG9nIHBhZ2UgaW4gb3JkZXIgdG8gbGVhcm4NCj4gPj4+ICAgICAg
IGFib3V0IHBvc3NpYmxlIGNoYW5nZXMgdGhhdCBtYXkgaGF2ZSBvY2N1cnJlZCBkdXJpbmcgdGhp
cyB0aW1lIGFzDQo+ID4+PiAgICAgICBkaXNjb3ZlcnkgbG9nIGNoYW5nZSBldmVudHMgd2VyZSBs
b3N0Lg0KPiA+Pj4NCj4gPj4+ICAgICAgIFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNh
Z2lAZ3JpbWJlcmcubWU+DQo+ID4+PiAgICAgICBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2FnbmVy
IDxkd2FnbmVyQHN1c2UuZGU+DQo+ID4+PiAgICAgICBMaW5rOg0KPiA+Pj4gaHR0cHM6Ly91cmxk
ZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMjA2MjcwODA2NTAN
Cj4gPj4+IC4xDQo+ID4+PiAwODkzNi0xLQ0KPiA+PiBzYWdpQGdyaW1iZXJnLm1lX187ISFMcEtJ
IWxZRktlQnFJMGxtcDBBeWNTclo2a3JLeEVNVU5qU3dDTy10WQ0KPiA+Pj4gLUZ5TUF1NUtMaWQ1
YkJxWXBmRUJHYVJnZkd0azFjM0hMWFVla1NTUFhyNnBLdyQNCj4gPj4+IFtsb3JlWy5da2VybmVs
Wy5db3JnXQ0KPiA+Pg0KPiA+PiBZZXMsIHRoaXMgY2hhbmdlIGlzIHJldmVydGVkIG5vdyBmcm9t
IG52bWUtY2xpLi4uDQo+ID4+IEknbSB0aGlua2luZyBob3cgc2hvdWxkIHdlIHNvbHZlIHRoZSBv
cmlnaW5hbCBpc3N1ZSwgdGhlIG9ubHkgd2F5IEkNCj4gPj4gY2FuIHRoaW5rIG9mIGF0IHRoaXMg
bW9tZW50IGlzIGEgInJlY29ubmVjdGVkIiBldmVudC4gRG9lcyBhbnlvbmUNCj4gPj4gaGF2ZSBh
biBpZGVhIGhvdyB1c2Vyc3BhY2UgY2FuIGRvIHRoZSByaWdodCB0aGluZyBoZXJlIHdpdGhvdXQg
aXQ/DQo+ID4NCj4gPiBIaSBTYWdpLiBXZSBoYWQgYSBkaXNjdXNzaW9uIHJlZ2FyZGluZyB0aGlz
IGJhY2sgaW4gSmFudWFyeSAob3IgRmVicnVhcnk/KS4NCj4gPg0KPiA+IEkgbmVlZGVkIHN1Y2gg
YW4gZXZlbnQgb24gYSByZWNvbm5lY3QgZm9yIG15IHByb2plY3QsIG52bWUtc3RhczoNCj4gPiBo
dHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LW52bWUv
bnZtZS1zdGFzX187DQo+ID4gISFMcEtJIWlyWDZTNzZlaWI2NHhTdTczMURjSldxRnlIYWtQSWhS
TG1nRnIwem5BU21mMXk3c05tdVF1WVFyeA0KPiAtX3Q1S3MNCj4gPiA0WnowcTFkOVNjcl9KWTlS
TTRnJCBbZ2l0aHViWy5dY29tXQ0KPiA+DQo+ID4gVGhpcyBldmVudCB3YXMgbmVlZGVkIHNvIHRo
YXQgdGhlIGhvc3QgY291bGQgcmUtcmVnaXN0ZXIgd2l0aCBhIENEQyBvbg0KPiA+IGEgcmVjb25u
ZWN0IChwZXIgVFA4MDEwKS4gQXQgeW91ciBzdWdnZXN0aW9uLCBJIGFkZGVkDQo+ICJOVk1FX0VW
RU5UPWNvbm5lY3RlZCINCj4gPiBpbiBob3N0L2NvcmUuYy4gVGhpcyBoYXMgYmVlbiB3b3JraW5n
IGdyZWF0IGZvciBtZS4gTWF5YmUgdGhlIHVkZXYNCj4gPiBydWxlIGNvdWxkIGJlIG1vZGlmaWVk
IHRvIGxvb2sgZm9yIHRoaXMgZXZlbnQuDQo+IA0KPiBUaGF0IGlzIGV4YWN0bHkgd2hhdCBpdCBk
b2VzLCB0aGF0IGlzIHdoeSBudm1lIGRpc2NvdmVyIHVuZXhwZWN0ZWRseSBjb25uZWN0cw0KPiB0
byBhbGwgbG9nIGVudHJpZXMsIGJlY2F1c2UgdGhlIHVkZXYgZXZlbnQgdHJpZ2dlcnMuLg0KPiAN
Cj4gSW4gb3JkZXIgdG8gYWRkcmVzcyB0aGUgcHJvYmxlbSBvZiBtaXNzZWQgQUVOIHdoaWxlIGNv
bnRyb2xsZXIgd2FzDQo+IGRpc2Nvbm5lY3RlZCwgd2UgbmVlZCB0byByZS1pc3N1ZSB0aGUgbG9n
LXBhZ2Ugb24gYSByZS1jb25lY3QsIG5vdCBhIGZpcnN0DQo+IGNvbm5lY3QuDQoNCkFoISBHb3Qg
aXQuIFNvcnJ5IGZvciB0aGUgbm9pc2UuIC1NYXJ0aW4NCg==
