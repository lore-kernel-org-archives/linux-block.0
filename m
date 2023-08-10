Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60A8C001DB
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 13:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjHJNsY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 09:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjHJNsX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 09:48:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239E2E54
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 06:48:22 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ADiNjl012686;
        Thu, 10 Aug 2023 13:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ISUdUqQ9ciZ/WdQ2bvHMCKKtEUqiOBriQC/9u3DMK3g=;
 b=iWuSiM0ZYrIgJVwCVruNg0MrJpmEMZX5PIoC7zX2Hzc9+dK/PUfaxGBaJXAll3+kypaR
 SmYLXcrt5rXERF7mEPz6xdEixBwVtUpKXrXbG8JkiUv/71oqiVe6neeVHTuH2buKoOI6
 AQq1Fq0J6a3NCOLIHHK38dvzJ0ioJbZWsQUOn+hcwSWNG4CpbYbNCIZAOD0vY5QJ+RG8
 wC5+ruQpDDM0d6X4eljLx5Y7F24Gz+Otjb9LtvtOlyJ3PXoCkSuE8pgYfni4Dg7rUQiM
 ZD3dELnLGCHf6CZd2D9IGk7R+BLQ3tZIpjPPuVuuUmkygq64BsdEYI9ZPcBr/rZL/p2J Gg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9efdb969-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 13:47:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ADUi56018681;
        Thu, 10 Aug 2023 13:47:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvf11vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 13:47:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6pXpA2LeJVKMQZz5jsMOl9GwXoi6AVR+OEPOu2OF2Ud5B5wP+TP36i5V8hZxBajyw4sz3pStTavrue4XrhH8L01gf1c2gXSeaW8D+d4kgGyzRc7/qC/jvvhGzYeB19EhGn/Ib7i540H00JxIoiKNZMdgPbW3QxGfPQNVTfo2tp7R2VRGvhKdldksXcsZfujv5aJwhm905eZ/oRLtW7LanXtPTjkCvcLTNi9Ak/yAFLeCPyPjCFpupXO0+mVHhf64tUe+0PpIwUQ5EIM86zPv8oZGqyHOTBl3o7OIMIGOAjE2CeVvef7lMR1Pli2yuzY6z2NTlikLAtR/GzEPEeEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISUdUqQ9ciZ/WdQ2bvHMCKKtEUqiOBriQC/9u3DMK3g=;
 b=OxC9WKE2aqSo0c+guNighhyTeKMc3SmkHK4WXF4uZrNmaVnk3pA64M7uFpmkX8Z7gIrhvL2kKORpxnI/3MPzbB4SaasAmP6YHPmfXswlQauwRu9jVWFm5FLCRneZcrxoIGvziUnJlxTuUPIr9OrJ48jdovhAlVfWvFkKR84rnhNSxoudWUZCEloel/3WegXREvPK5/RQPpTbkFM/u0ovD9UiNrSqsJKT3lu5h3Jx++3/5X/vlfHtPqkmZIIZeOhesqabbjh6YawM9zvORSdAW+7YKX/sLwwbLLUdx+1OZ9Z0NnmND/kAgCdfVNpX/Z3sdKRk7uqr5YU+kAjR9I45kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISUdUqQ9ciZ/WdQ2bvHMCKKtEUqiOBriQC/9u3DMK3g=;
 b=XiN6H0uLiQsg151umNPYS4djpZy2oAf5/j+qB7TSsEoCh5CR68TQx0HVKOHlo5Xj/31Cjw+Ypm88aMuiLAnn/ZgAIhUBgnIsPjV5KGzaTFjEZGXbnz9XaYQVKFVt+iTjzL4sYzFDT0hdmo31rvq4NFscTyMb3SCKeDaBS7AZ7Ww=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6340.namprd10.prod.outlook.com (2603:10b6:510:1cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 13:47:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 13:47:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
CC:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Chuck Lever <cel@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH RFC] block: Revert 615939a2ae73
Thread-Topic: [PATCH RFC] block: Revert 615939a2ae73
Thread-Index: AQHZysKon/4tBl92N0CaQb4cFhU7aK/iHSYAgAAFh4CAAAQ/gIAAWjqAgABizQCAAKj6AA==
Date:   Thu, 10 Aug 2023 13:47:49 +0000
Message-ID: <F787AB84-0A0E-4370-A7FD-D80FC3B6BF71@oracle.com>
References: <169158653156.2034.8363987273532378512.stgit@bazille.1015granger.net>
 <d51b0683-8872-4e10-8589-5c6de8db61d4@kernel.dk>
 <20230809161105.GA2304@lst.de>
 <9BADCC53-72E9-44FB-80C8-CEBC9897809D@oracle.com>
 <20230809214913.GA9902@lst.de>
 <86ce2299-ce42-c0bb-e577-9d23f8af494c@bytedance.com>
In-Reply-To: <86ce2299-ce42-c0bb-e577-9d23f8af494c@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6340:EE_
x-ms-office365-filtering-correlation-id: a0976720-6fd0-4d40-efbb-08db99a862e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zH8B2Ku/A1f7EJSMtoaciwtWZF46bTJ3L9M970cmliKTGeZKIqKRI1PAxwoaHGaVwlE/165bkdbWRi374dupx6a13NxLHuMy095gijAvFj4mAqf0JaYue2zngF3Z9jEhXeG3NY5ToD24WTLs92KJBrgymIgsKj2FHt2R5+jsKZfXZFT8zaIYIj8HmGO92qo8khJaySVn0sRE6BJXsPylEJSstwnVMKT4/5wUVfAtBY6JI3JzV6CG6Tu3VZIZEtsfJQ5MV2eBUm+2X8wkcA17n1RZofEs8k5kxUFfXBsvIPgCtsVULoaNd0c//zjdFLAf/Dn7cDo3nDNhnxsVw6N/CxrodVpYwmaRZZIqNlE3JJSEz/dYrA7yMf5Kx/XLkcbY/FHXr7dapiBHtQjYclGZHg9vAQi9L7DAuKpNTJEfOWHs7XV+GtPMX6FTpb+eYNSi4MUOx7m4Xlnao/ZNokOJAK4cqs16Oi2Dyee8OvoOLCimIYKRSm/q8FEdrxwEBy6+F/iuIPg0sfdkKYLeKGebDl3X5g6pu8l7I1MKGMkuSCTXwgVA8/sJverPa0brIjkf4vlKyabiuTbi9Dy25ixtSPl8Y0XLiBIoHzfut7Xal5RMYl35EfFCpaTAAM1SPr25DI/vjDqmP4yfWd2kRkU+Kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(1800799006)(186006)(66556008)(66476007)(316002)(2616005)(64756008)(66446008)(83380400001)(6916009)(4326008)(91956017)(76116006)(66946007)(41300700001)(26005)(53546011)(122000001)(38100700002)(6506007)(86362001)(2906002)(71200400001)(38070700005)(5660300002)(6512007)(33656002)(6486002)(478600001)(54906003)(8676002)(36756003)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zLZ3HzxBO9n7M3XmlpEpfI3qlGINnAAjTgB5iKDmhc+U/Nkk36H2EKHQJgpj?=
 =?us-ascii?Q?B94W1yax8COJ9R20dHH2BE8vLiS8J5yIUNzTho0aj3egD2m+vO446Hc4z/ZQ?=
 =?us-ascii?Q?GGUk6r6nJNfOQGSuIIKtwGb0wlJLCUvBhhrpcbM12iPKoPYBThFFbfetv4v/?=
 =?us-ascii?Q?k378l3kEc8cy8oq/Q0bAIOPkwBqDpahfZu8aWtOuT/GfNXLcnldTe69+WUYo?=
 =?us-ascii?Q?Y6nxC2rO9ic4lsiJe3Hq3pCPS1wZ8A0ZHNHX41IbCsQnx5VDff5DQz98/Dk6?=
 =?us-ascii?Q?S3vAWux3xWEn9bj/sikBwxevGhlAwEnTgXbIY79RSW+AZ1xcl5zUjXYQP8EN?=
 =?us-ascii?Q?hExnKUs65iKIZ5MUURrclb8iZ+P5gxoRJ5YKBX847bsn949IKxizdDBkYcSS?=
 =?us-ascii?Q?Dm95VqUketo4MdIlFCSq0oWNoC+sgNJ3Akw3GQam3KvufuX3JTmfnD1dOsI3?=
 =?us-ascii?Q?esxiHXKHl4/yyAFj3SS93bgEMIx83woDCiG2PgwJH2J9w4x4vTp8h6H/KYaO?=
 =?us-ascii?Q?/OZvu5jNfHTmhnKdA/jyNFLL4Jmja7EmQdyufKo74KJJllDynzPWGuKHsn7p?=
 =?us-ascii?Q?GtxIOX79nWtipfuCqnDpdmf0seqsGOOPP37oS2q3UcgCcmslHdQ91ZumLeVL?=
 =?us-ascii?Q?aMiHI3VZ/jHGiq0VjbNYEbXJU1lQoCgR7Hx+Ch8ljgTGXqL8Err3sXaMjQ1R?=
 =?us-ascii?Q?MfWkuSCO2hssqV9QkAipk5dssTcjTbJmUEdhvWvwavL9Ekr5XNaBHi4MeLgX?=
 =?us-ascii?Q?hsLUbTbJ1frbibtABmPp8cmfxcrgMzHaVgfAD8enzc9/hQFz2zHlTHwHc8JV?=
 =?us-ascii?Q?L62x31X+zZWon3P24P/tiLbHYZoRxiBW6QuNswu6joylMknHRSb7bDhPSY0t?=
 =?us-ascii?Q?xf/1XZgMBfleEvmbZXEJrCHfR7TbpPhi4Qdx2C65hHfERlkUYrmOG9eShn/x?=
 =?us-ascii?Q?NFl+tFkWw77maq9oCMwKZAcCLV8MZl8krQRyx9Z+MXO4PYBiEb0HwfzlmURs?=
 =?us-ascii?Q?vaTS44hIzR+4EWPgjj+2emxCemLZBOMtxRYPAW2qzJwPkmxxgb0RPrrLyjxP?=
 =?us-ascii?Q?y7EyqvhoCEy+diztR0WhvIO4IDUEkItCvmFHyLcjMUoBsiz6reERf0PWPj2Y?=
 =?us-ascii?Q?n33zO+Lyioa/z/+gckX7MnPJG0nfSFpY5up7MBsoGDfFHiFPsVuR1lkm0sSU?=
 =?us-ascii?Q?wwtCeqGHqwexOlKgzeK6dzVdZAWjRm+D57bgzlEnDj3VIyTaw0HqfukI8q3u?=
 =?us-ascii?Q?A5MI9mznlObgy57Job5gfbAmlbtfoNIkJlBnBzyBZjZmARMdfPitbaULl21w?=
 =?us-ascii?Q?Lj9LHU1o7sZsNEcJ2izdjzflkiiLXdB5uRVRcY46f2EAG21pLN+f3P9D80Pt?=
 =?us-ascii?Q?QKtDgCsEnjpND7BFbiQZzQRV+NxnE0L+psJ/mmLGniS73PovQeN3yOcciQ7i?=
 =?us-ascii?Q?xMSjYK+UQRaHhcyPjZDp8elOnjsT68tEZkhBHGoIhC08mtJIXXm4n0Daqfp8?=
 =?us-ascii?Q?TrARxjaqsIKX8yc+BApXEvZgHR1wjL1IfdWAAnC3IcSGgHSwQQfX98D9DnWj?=
 =?us-ascii?Q?ZO8Li36hnZfP/D/U5u3QOUK7Da3SV3F6FK1BG5zHHit3h5P6pfvqYUDJGZ8Y?=
 =?us-ascii?Q?qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <119A72C74E4DB343AF78D7AED481AEC9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7jNdQm8yC6vdR/LnNXmd0hZ2+TJIj4SVTDUamhlngn7OOm+BaN5eIYPNeK9IDukzqysImka4SEDeyBivcfMvoseH9PBEsjxktmT8LqNv7HmrUvse6kbUTPKmX3PMD7WY2KOY+aytGhmtfDCx9WE9okXP5X8vTYuxCR8wkODxZVAwyb8GUhErMLcxzxqF8NowNXZsckRW8UVHQDJulSqJ7vNH+NuuyDTtZ/SWqxerzuaoni5Avu/ZNDfvFH5LHEWoVEcwHlVoJgtcRV5YDXedvbtt6gssUNrURIKaJfQB+EfPqP0BbqvWLhBLQrS3BEBC1a+jnHvaZbI74WiZHJTEfXlbDyj7dxUwTHfdREnO/gfchO2SdDECsCMWCkfEYpappXIqV/zBLf9JJN/EFTMje42dxdDNUapoWNWsERCJE5ITkjqksApXL/fZTlDRSTKeAnFEKG+HuLRuwYXy+25LLPkSf3AQRP7ZkLXh9mgtIHyeblgIdFuZqKa6lDEHoxU2fPYjbQ0T14HEb6XXw23OYd2SGJscL9BN16JgxT8/UhL2BTZWsDBj2QlNOMYFLzlV2cka7IFsbKL5okcCUiHv8yjHTpd4h2Lu8++wy2qsksPf7yrFjejKxUbAS7tJf3bXIDvz6bKpW+wDf7iVV+fhSA5nQC2hEOCvNiYQ6lbNt2iISAg/5kiJx8zQhyP9JQ07XwZjVfBDHYphwrehLIe4gPwxwMHrlT6HRoL65VPIXxVuCDmDKudlnhP1bITnn8wZviAC2im9BfETkOVbI30Vky6lvlPMMTJpq0Z4uO3Ts/Eml1IKcbYGwi1IrTYb3shCwtKq1tvaoBBrdYqN8Z4DUuQWrnhm+30rvezvD4UgAb82l8GxON8thdDrJU8LqW1K
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0976720-6fd0-4d40-efbb-08db99a862e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 13:47:49.5657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bPRHsrCB442Y8PZpfxDcrIBP2RlNWOZB+9Cfd+poQn7QJx99vtmlfimXg3Vsz/13SakL27H2Yd1toQ9Avq8FtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6340
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100117
X-Proofpoint-GUID: DCK2O-P-tw1unDwcNXKxFEg06dRZgrU4
X-Proofpoint-ORIG-GUID: DCK2O-P-tw1unDwcNXKxFEg06dRZgrU4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Aug 9, 2023, at 11:42 PM, Chengming Zhou <zhouchengming@bytedance.com>=
 wrote:
>=20
> On 2023/8/10 05:49, Christoph Hellwig wrote:
>> Oh well.  I don't feel like we're going to find the root cause
>> given that its late in the merge window and I'm running out of
>> time I have to work due to the annual summer vacation.  Unless
>> someone like Chengming who knows the flush code pretty well
>> feels like working with chuck on a few more iterations we'll
>=20
> Hi,
>=20
> No problem, I can work with Chuck to find the root cause if Chuck
> has time too, since I still can't reproduce it by myself.

Yes, I have some time to help.


> Maybe we should first find what's the status of the hang request?
> I can write a Drgn script to find if any request hang in the queue.
>=20
> Christoph, it would be very helpful if you share some thoughts
> and directions.
>=20
>=20
>> have to revert it.  Which is going to be a very painful merge
>> with Chengming's work in the for-6.6 branch.
>>=20
>=20
> Maybe we can revert it manually if we still fail since that commit
> just let postflushes go to the normal I/O path, instead of going to
> the flush state machine.
>=20
> So I think it should be fine if we just delete that case?

That's basically the fix I have been testing on v6.5-rc5 and earlier.


> Chuck, could you please help to check this change on block/for-next?

I'll set up a block/for-next kernel and try this out.


> Thanks!
>=20
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index e73dc22d05c1..7ea3c00f40ce 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -442,17 +442,6 @@ bool blk_insert_flush(struct request *rq)
>                 * Queue for normal execution.
>                 */
>                return false;
> -       case REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH:
> -               /*
> -                * Initialize the flush fields and completion handler to =
trigger
> -                * the post flush, and then just pass the command on.
> -                */
> -               blk_rq_init_flush(rq);
> -               rq->flush.seq |=3D REQ_FSEQ_PREFLUSH;
> -               spin_lock_irq(&fq->mq_flush_lock);
> -               fq->flush_data_in_flight++;
> -               spin_unlock_irq(&fq->mq_flush_lock);
> -               return false;
>        default:
>                /*
>                 * Mark the request as part of a flush sequence and submit=
 it

--
Chuck Lever


