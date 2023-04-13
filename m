Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0108C77B6E
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 17:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDMRTW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 13:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDMRTV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 13:19:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B2211C
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 10:19:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DGSrrT017864;
        Thu, 13 Apr 2023 17:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xdbixUbKDbWQcce21VE5lbhjTLfhadCyWBa5XH7683A=;
 b=sRKScG2t7JmdQ2JIYigUs//GYqzApsj9Ulot9tzTD2LTkRZPA1kfKEoq2mSTufb3zO0S
 TO7E43BOSROtDCNGwxB6wBlmF2aQyckCFZtL+P1oOXo7Wt0UAjWPDGTI/pjgFBcLVqi0
 ic6Bg9H5SdNfsGoboLv1VJ0oidqdMUpsBJ+dAppr4rZ7sh7hv6OzmRQVAU2/x8E96XFp
 Vu/+HZtyS5GgO8aje6f1iY3uk3mWCaQ8JmqMtrUQ2nj1jDyCTFl1xjnuNqjMYFdpis4X
 sn57MGVzG3M/WDFv/vV5lurEPxh7zIeOFRG/uVincbP2kndlo//IZ+rXjdD9Lm5BefXp 9g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0eqbumd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 17:19:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33DH6OUd012688;
        Thu, 13 Apr 2023 17:19:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puweb3wnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 17:19:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/oXGlcJ7AbLQNFRNTvHqgmVzqRZescqirhSD4gCX56Th/YvfY6nht/THdN4QanJ/SiKFOoYUlqadviFEjIS+/ePji05qahlvKVU7SN7oZGhRDLeMd1QRRKNYPu1z1gxa4dLoTHEaQqMv1MsS3+sn3fbmlU0bBFwHkPXK0bfg5RYhTqHqxK7ZptC8oxG6tdb1CsQIna4M1NHmPrZxxiztjkAfxc3uW2fRYVg6qNs4tztjst1pyPKAbouuKd96XcHcED9fnhBqindvUdSP+XLNV1KPtW/2s1372c5DWKaoBYGff4VRzhZ6cAK1d/4FvXn1YKbDaBK93Rfe8GLcBtZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdbixUbKDbWQcce21VE5lbhjTLfhadCyWBa5XH7683A=;
 b=hRwjqEHll30IhKm4KtNAQ9YCvisd8FtsKWl8jMYi9mXDzPlpFR0DxO17uUO791jDkFkgkS4qMEuE+Uq2lMIr1oxZ4dyO7tgsGcCTIheT4Imy9cXmMloF5K0XdtFdfB7UNYThbDYX98ehj2Hbbdm/mMxDtpmJrr1S2cFD6Ax5BW5haiVlqsvF7I+oet7ooO1Rt5Rd76vmupqMJBErvF7OA6jA6X5DL0uJFgnKJxJIVxPFQ3xWxsK5jvWFpvOTZqB9YYGIuO+WZdYxK9rGYq2mj54aPrPQ4XDzGgx7itoZKZxIRumo39HpbryV09ZzVqOtVOpa74tCruczrvU1IP1aPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdbixUbKDbWQcce21VE5lbhjTLfhadCyWBa5XH7683A=;
 b=wHnp6jO1JIM4HxvB4OOkLkehwKL5NCVPJ+DOt2y1zeA9yl6j5TU3MGwnCfgpqfGX6JyYktS+bljtXusTKJzoajTC71uvJdfSobrcT1BHywbqxUHgr6VWxpaIynQTqzX3A5vqk3K4B93zgGNmuc4y7LPbiNm13zuStRlL1UdV6lc=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CH2PR10MB4294.namprd10.prod.outlook.com (2603:10b6:610:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 17:19:06 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c%7]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 17:19:06 +0000
Message-ID: <3216ff1f-ecde-967b-75b1-7da643570ed9@oracle.com>
Date:   Thu, 13 Apr 2023 10:19:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH blktests] nvme/039: avoid failure by error message rate
 limit
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230412085923.1616977-1-shinichiro@fastmail.com>
 <34019736-06eb-b5dd-b6a1-101907c38917@oracle.com>
 <saejpr554r5sxjhqjps3yqgdwhrgufauki2f5npp2yzu6xtvum@q7oz2nwzic3r>
 <lhy27pg5my4fw7a7lyt5ag6zms4vnnaoab2laylatjqwkckdzv@55ebsbgtgpbs>
From:   alan.adamson@oracle.com
In-Reply-To: <lhy27pg5my4fw7a7lyt5ag6zms4vnnaoab2laylatjqwkckdzv@55ebsbgtgpbs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:806:21::11) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|CH2PR10MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4fff12-f371-49ae-ae3c-08db3c432f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YetTcDnoGdJVHEiPxhsGq8VQ5QavIureOILQQk6//gpo+9lnOxZWpBs22pA9FNOf1yqTFiTAr6zG1aZR4mLiyOWJU6TlhdqgO+RdbsDoEq7qfCjLgw72LmlNHZhPRLCK1Bd+sUqWf0f3eZEketmBo+iHqdIKOjf8hcaz5UeRI7aqy7Ma4+mJO1xEt7q9GUJkCFtgLR4/7XN6XV3L6RoRYNTdDNzLepZ7e09dd4Sm8s+GiBF0ueRr4XzeiLh1azBxwz9aSQVb2+L1NunAE9MNLi08MJmLsLHcKAilrLORiDf3I0rLck52zEQeJKjhCFeFXhsmBqCLmSQRSNY67XdrqeF0H4IqTGhqexUgM8aCCZ4ykX1bbBO7vy/JRj/OsoRu95NSQjjBTWmKpFnU0cHbS0BpGYNPjcw8LG+1VvJyhHHMseUCzyvBEWDC3Ufe1K7kaDS+jaBZSzGvkgqxNtOqYeEtlt2l/7P8joAzJt7hxd6IIWH0LTS/iTyg9zoWLMWrAKk+U4WlmeuS4quhAovCToyOTXptJK3SJmNSeo0M4ZgBraorC5q97XTB/vcBkeid2OG+fncsG9FQSsZxSxqjnR9NeU2CXa8a+BV5BGtxnobE8+H0siAvw4y3Xf4SxGZ3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(31686004)(83380400001)(38100700002)(186003)(6666004)(66556008)(31696002)(66476007)(6916009)(316002)(4326008)(6486002)(86362001)(36756003)(41300700001)(478600001)(66946007)(53546011)(26005)(9686003)(6512007)(6506007)(8676002)(5660300002)(8936002)(2616005)(15650500001)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjZsSGV0S0RIbFo2dHNzZi96enozZW9kbmI3Ujh0R2dDRjFRd1M1QnJ6amJt?=
 =?utf-8?B?SnJGVXNyeUlPZk1NSmxsNzJlU1NSZk4vOTJVUlJmb0I0dlVBL29tMHNBc0NM?=
 =?utf-8?B?MVZXU0JWZkFpVGtGYmpGazUxdDRpbG9uMnJ5WU8zM0NwV2tKMTkrSXcxdWtu?=
 =?utf-8?B?SUNuR2FoSGZLcks1bTIyVlp0RmFHUEhPcGl3dUVXdHpvVEpWeVJOMlRvSzFx?=
 =?utf-8?B?clltaktnY29Wcy9LVUovZm5zVGE5T0xxQ0lCcTdqaU4reFcvWXNsY281Y2dL?=
 =?utf-8?B?WEpObC9Ody95SVRibkZpQ09PN3o1VGdsZU4xRFdWK1lDbmI4TXFiZXFZU0pi?=
 =?utf-8?B?b3hDSW5jWThKVGQwcEhoalZDNzVOZDNMUFRldlVCcE82akZYcmFqbmpVNTRr?=
 =?utf-8?B?ZTNHejVueStmN1ZqT1V2REJvM3VUWmxSbHQ3YmphZGRoTXk5UlY3eUtoaWxB?=
 =?utf-8?B?Y045V0FZdVVFODVzSm4xVm5BY3BySWVSV3N5RjdtQnhrREpOK254dGY5VGVS?=
 =?utf-8?B?TllibG12ZkxYVWpZcGJiZGRpdzh5ajdvRDl1U2lCNmFIZWw1TGdsN1VQT2Rt?=
 =?utf-8?B?OUxqMW50dmE4cis5RG82WFozZ0JCemowVlhoWTFGNTIwWC9McVdKNm56cll2?=
 =?utf-8?B?Sm1XRzl4cWozTUEzeUFPNUxkZjNubUVXMEo3b2RiVWVYODZWRCt2N1BaVlZU?=
 =?utf-8?B?MGFCZ0pzcFdrK3lraUZscjNQQ3E1QjgvTWl4d1dXcmdOREpuWm52RTBpZE4y?=
 =?utf-8?B?bzNzVlhPNUM1Y2dsSEpERjZQa1dsTmxqY0ZVKzl0d3hrRDdYZ2s3c1hUWmQ4?=
 =?utf-8?B?U0c2UWx4SUhxSkQ4Ky96VUZ5TkVUVDNYNVJwUHdzQXVHMHoxc0FFckV2MGxu?=
 =?utf-8?B?RTNRWXJwODFlMHdNU2lkSGtOSndKNkZvTWRDVkR1ZE5qSVArcittY3JBRDJK?=
 =?utf-8?B?SGdnSE1ZYXBCOEZjaG0vL1RKRTdyK3lCMUswVzBSRWV0SVRyQjRzVGpzanVV?=
 =?utf-8?B?WXdldTlSbWd3cnZuWVFMR2J4Znk1aUplZ2pUUVRTTUxDMGJsTlJ2OU91cHUw?=
 =?utf-8?B?VDN2R0RncU9QYzRUdXR1ckluUUlrWlh3NXBaeDVyMUQ2ZkJWcHNQTW5nTDVz?=
 =?utf-8?B?QktWNDRRU2RhazgraUVrOUpEUisrMW8xQ25aYmFZMXZtWGVpTlVhOEViL0Fp?=
 =?utf-8?B?enRucE5EYnl5anVYZDRjenp3TnQ5ZE85WE9BdXErbjZ5RzVOV0psMXJoc0hH?=
 =?utf-8?B?d1dYamJRWm1aMVgzbVl2YjFwSkJpK0F2bVJyaElPSEFSL2tIbTQwSmtIa1RM?=
 =?utf-8?B?VFlSWCtpeFNJcG1Bd0RpTjRybUJVa2I0Y0hlbkdoNmlzd2ZMTEx2L29mc3pI?=
 =?utf-8?B?djNmbDYvYkhyUWJPSC9UMDN3MjYxeU1JMFhCenY2QS9zVlNabUpJMFUwcitx?=
 =?utf-8?B?cUNkdm5adnREV0luaVFhNEw1V0llVHdDSEoxVXJNcHpMUXY5dzFXZlRHZ1pn?=
 =?utf-8?B?TWszRGpieDZ4Uk1DN2NJeDl2cFhjcCswVkhvbzRzMkcwWHhwNTBIYUs2TUhX?=
 =?utf-8?B?UTI0SFQySSt6SEtBUlE5UnNyK0FpZHFBYStNQWx5REdsbFVrUVA2dUxXdVpG?=
 =?utf-8?B?SnR1aDRJbGdOSEpZbVNhbEhqbmhFd3ZlUTdORm5ZU21xQldlNmE2VXo4ODFh?=
 =?utf-8?B?MlpYeGlpNEppRktJYzRTd2t2dk9OcG51dHREaU9CNWxlL3VOVk5TYTN6ZkZo?=
 =?utf-8?B?cnNhMlhZVnpoaWhZTEJxamlOa3owRXpqT2x1cVdJTWNZTlhLTnNINC80cEdl?=
 =?utf-8?B?SnRSWGFleml0bGk3bkNRRk80TFFNdDVPaDljUnNkOEIwdnhMSm5NMHY0QTNH?=
 =?utf-8?B?U3RlZDFJMjFwQldkdEFsbFVkRzU0WFF0RWRBSWZaSExHSmJhTzBzYnEyQUdQ?=
 =?utf-8?B?Und3RWJzcXoveGtMcGNseDV1bitKZEtWaWRqSDVKL0JlQXlIcHdXeDNIa1I4?=
 =?utf-8?B?VE1GdGNvcTBaSUpZeUh6YWRhY1doVE5FaEpYSEI4cFp2VmpXYnZmZWtCOFNp?=
 =?utf-8?B?VlNpcHd6THoyZVJ5aW9HN0xaSU9aWDZhMEZzN1JLZFlaa2JkVkNoUXc3RytY?=
 =?utf-8?Q?/lvV3OFFCIZx6KRlHJQ/n/WeS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +RpJMRlq4aHeIy4+PR48JXCgL4hPPV1T6gVLSUTDZTXgwk7en9e4mXq7BO1stYpITNkIgvIsVXNu9Weaus14sP9H5MhI3Yw1F1NZcdFiQ1un6nnIWRIGJTNneg5wscxlPZVLt6BdIBZrKIiaRcILYNOqWTMXX5/QAVgeL2itxTtOZVWodbMY6cJ+9OyNIF4TJKhC/8jEcvssFEFLWwMvdpkhAwEloGOU8v8pOH2uj3+eRNAUqqUM7qpZuI9BBz/qQPcsfocDKGgxlfmalpOu6ifzcV+t9x0KGDtxI3yykeX9UmV3vIuOUvTYNdvUk7603SQf0O7hEhl218x7xXLakZfDupi9YsElM0JL7sn0eIautjZr/yXCmh3MozPxi3uaIXvVTJCrTbadQPVOyO/M1FW8h491oBbn2NyRCliEqsva9xK3VX7NUu4bqQD2BntVEAYlNUc7m0gisNGT6562C2MAg32LyfwZB1Y3fETELeTDnkrGJ5DvurnzC1Xeb4CxpHSGX+oMsiAsN484FfiObyr5FiLPo9aSJHb96t6uiJSLSoYhYl0+hKWiFzg4fFcHv5lCVx2sgeiWz2ZYdoHhJtdCYxrYPDff4m4ud2VX1V44LfBp7prLr/4D3zzRxgQfQMuyTyuQkYGt3N5c0v3k7sxFsWRSsQWkZXWVAASW4Sg2r6fq1s89sdc2h6hqbEjywVa511hlGorTG9H+B+AMX3IYLqyV4j8Fdq4X3AWlsWcNjHj/nSB3kKfM6JFGQsk2+mTOK82P6dVAcfoLb2VOW8W8yeGa2GB5S872E6CkypmFh/ZkpNFmYD0xEfLb5BmB1G2DphmdCFJY0RszVx8yxPgC3KKx8CdPK1BdW+uWQ3joh+xniO7nfXvtUBcEbmEL
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4fff12-f371-49ae-ae3c-08db3c432f7f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 17:19:06.3172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyWkrIVBg5JVDxxF7ecduGLtTmKKXCIPCMebwXrMZSQYCIBfMLjj87638uqOoRALdhCf/xULdON4uqTGXzW49Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_12,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130153
X-Proofpoint-GUID: RhcPPfkALGkS5b9rhTSw4oJ5Ul-Pw-rM
X-Proofpoint-ORIG-GUID: RhcPPfkALGkS5b9rhTSw4oJ5Ul-Pw-rM
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 4/12/23 8:56 PM, Shin'ichiro Kawasaki wrote:
> On Apr 13, 2023 / 09:20, Shin'ichiro Kawasaki wrote:
>> On Apr 12, 2023 / 10:49, alan.adamson@oracle.com wrote:
>>> On 4/12/23 1:59 AM, Shin'ichiro Kawasaki wrote:
>>>> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>>
>>>> The test case nvme/039 tests that expected error messages are printed
>>>> for errors injected to the nvme driver. However, the test case fails by
>>>> chance when previous test cases generate many error messages. In this
>>>> case, the kernel function pr_err_ratelimited() may suppress the error
>>>> messages that the test case expects. Also, it may print messages that
>>>> the test case does not expect, such as "blk_print_req_error: xxxx
>>>> callbacks suppressed".
>>>>
>>>> To avoid the failure, make two improvements for the test case. Firstly,
>>>> wait DEFAULT_RATE_LIMIT seconds at the beginning of the test to ensure
>>>> the expected error messages are not suppressed. Secondly, exclude the
>>>> unexpected message for the error message check. Introduce a helper
>>>> function last_dmesg() for the second improvement.
>>> Why are we seeing the callback messages?  By the time the test starts
>>> generating errors (after a 5 sec delay) we should be able to log 10 messages
>>> without any being suppressed.
>> That is because other test cases before nvme/039 can generate errors. For
>> instance, block/014 generates many errors. When I ran block/014 and nvme/039 in
>> sequence, I always observe nvme/039 failure even with the 5 seconds wait in
>> nvme/039. I suggest to excldue the "callbacks message" to avoid the nvme/038
>> failure regardless of the errors generated before nvme/039.
> Reading back my explanation above, I found it may not be clear enough. Let me
> ammend it. My understanding is as follows.
>
> The test case block/014 generates many error messages by blk_print_req_error().
> The messages are rate limited and some of them are suppressed. At that time,
> __ratelimit() calls printk_deferred() to print the "callbacks suppressed"
> message, which is deferred and not printed during block/014. When nvme/039
> triggers an error message (after the 5 sec delay), the "callbacks suppressed"
> message for blk_print_req_error() and block/014 is printed. It makes the
> nvme/039 fail, since nvme/039 expects the error message it triggered, but it
> finds the "callbacks suppressed" message instead. In theory, not only block/014
> but also other workload with rate limited error messages can cause this nvme/039
> failure.
>
> The 5 sec delay in nvme/039 ensures that the error messages for nvme/039 are not
> suppressed, but it can not avoid the "callbacks suppressed" messages that
> deferred before nvme/039.

That's right.  I went through the rate limit code and that's how it 
works, you will get a "callback suppressed" message along with the first 
message nvme/039 logs.

I ran the following for a while:

while true

do

./check block/014

./check nvme/039

done


Reviewed-by: Alan Adamson <alan.adamson@oracle.com>

Tested-by: Alan Adamson <alan.adamson@oracle.com>


Alan


