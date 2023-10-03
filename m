Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72C6E8FDBA
	for <linux-block@archiver.kernel.org>; Tue,  3 Oct 2023 21:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbjJCVZ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Oct 2023 17:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjJCVZZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2023 17:25:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6D0A1
        for <linux-block@vger.kernel.org>; Tue,  3 Oct 2023 14:25:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I4NIp004034;
        Tue, 3 Oct 2023 21:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kdUM1hfxIThKwzxbJ5cyouB4c40vAm9UDINyDGNPME0=;
 b=RCBkVyqsO/+0wSPYPfjiQPFPDvSTqrO5QQAOB7Pp4AaVSYqj8/HFwovyeCunGv2eBfOn
 NSiY/1a+BVicPschDtfqIgL/gmkZNRVvxqChA6+C0oo+0V0Dnuwge14YZW+mHpahZ8aN
 /rX0FvWI5/WjylqK1IQs9W3TKqXt5vfw/O0ppSU9tAc0mb6Bq8z2wvG6VDUPMfWeO/mr
 2Jc0GFk2V2GH2UJ66qRynzr8creUqNAiVjoGiqKq96JzRHtQsS0WM2y7tA64IdKYElnW
 BJP1dBbE651H3HQ7Kwsox+i+0KI7FMw+siSFF7NfN1tqlo8+GouqxwnNqP52DIRDlq1l Dg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9uds2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 21:25:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393KNrr7008682;
        Tue, 3 Oct 2023 21:25:15 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea475760-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 21:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8AcfppU9KhAePevpRp5ufReZRHAy8BXlp5yns0xsrD9rZVyEFWQ5GCtqdTf5+tSHSOewEYXK6XvXLSkJNjdh+A4beIKssYdEONAu2MdpF3HjXIvDgVr42aKleJulDd0Dzi3FYOjWBh7un+iloDKFVCBAqWR98IWBzUvhk2tpayX5eujA9VVV5yaWUglHZv5DN8fGhAC4ANd1maVZ+6YfCAeoYz87NbUjeBiKVm0HA38olTsC/oUM8OA3i909scTC1gP+rtRhw4oh+gkycPml+0aGdaxgVI4QFM/e+BwCwdMoZJvAvZz9WpXLa9dauafkZW7rHXT7Lpi+FaTcXSxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdUM1hfxIThKwzxbJ5cyouB4c40vAm9UDINyDGNPME0=;
 b=DFdXXmTES4ze9doni/FC62arHAuClcpFXSGEFyc2K3hO6/91yfk1VSFufPPAJHlVPfhkfSaT2u5sE2VJZaPMLACF1nUc6u+FgwHm0UoEf16FjQExqci6thtD2iZhjcFh7/UY+GxQ8etal7gVZhqd7URtpv4tjyXAQ2p3b8+EwiXxXPbAr1HbwpB9wVhBkGy7BnQMmeutiOxkD7QqS5oZsmG8fWETyWr9joZ/ui8z5F9rOymd8y8yGDtp7+YSwP6LnjBzeuKJQ70/UCqE38E/Q3k6SASIxCXFIvMTRYMtOdZ972IXU6b15Y9BUL18pPTCqlmjQ5cqCbsMUekStEN6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdUM1hfxIThKwzxbJ5cyouB4c40vAm9UDINyDGNPME0=;
 b=iIBvtK9yw3xK9TXCqu3j4V067w9j6urkGIKat/N3UENCvRS98eC7FKputfTFFQ1wwuIlMUPTKcM/1Usgnb9qr5OLCuVxsDSuCBm62AZYWeolZGpabrOgfxcVZXfmihmiEutE19b97ZpdQRDk1SpfbvAzAbggxHenam0/RIWVFZw=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 21:25:12 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8%7]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 21:25:12 +0000
Message-ID: <f994d3db-1971-4291-8a12-4b794eefa6c6@oracle.com>
Date:   Tue, 3 Oct 2023 16:25:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ublk: Limit dev_id/ub_number values
From:   Mike Christie <michael.christie@oracle.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Hannes Reinecke <hare@suse.de>
References: <20231001185448.48893-1-michael.christie@oracle.com>
 <20231001185448.48893-2-michael.christie@oracle.com>
 <ZRw1GvSwh+49SmL/@fedora> <8c37dabb-46e9-4f8c-ad19-eee3163e3075@oracle.com>
Content-Language: en-US
In-Reply-To: <8c37dabb-46e9-4f8c-ad19-eee3163e3075@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::24) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: d563e2eb-8108-45ae-35ee-08dbc4573a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iobNBcuPO9RS1ZsVyryMaoD3KA3eMjt6LM7tBcuupUxJUqdtOCUp07wililXKRbsuAbpNO2V39XroRrzLTprUVuiy+OVcBPJfV43+RbnehpSXtWuIXMKEMOVA8qeLs9XABCFBhd7sOV6wmw5VAD7kjfhGRv5CRJ0LguFnTkiGWaU0pi2Ccz4UxpBEdlZexIRrRffPIE7Ob9o4/axn5fjLTH6DjVhfhczcnptX5FTUoUiSUqpswBDQBxWq6+f9YymHbM5n5XOmbKyLl8hHEnK099dXtJ4r+AihX52nU8BuPMgNXOOECejo63zxGEic2gherszOmO7Ea6GSCh4jOSCzKtGznUKLFuy9xJGgwpR88hVbaCNOfgTwB6zWhouW1uDNn6DwszpDa19/WnwIqYsZaZMo8KQZtkm2Jx2MwfOtWE6CV1KpoBAv9J6owOiOBj7jNMxadp8QPr4SLCDbLIiMBLJwQdt4mngyJ3CKS7XNdMo5sdiQvC1k3sp/lhbwrFzDFeGl+jwMC7JT6ArGvID+QtwveGnLWpRxUSyJbDVADoFdcHhdtGTIZKMUOsQe/mUGjuhyJqbb0GeHE5gO6cIXGyoy1CtM30bB4nLUVAmk2vT129YmeEQ+XkhNKx/wHRc5JwQ+jde9afnKRI+8g7ayA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(316002)(2616005)(38100700002)(36756003)(31696002)(86362001)(83380400001)(41300700001)(5660300002)(6916009)(8676002)(4326008)(66476007)(66556008)(8936002)(66946007)(2906002)(26005)(31686004)(6512007)(6506007)(53546011)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmhBWVpNUUJlVzluTC9LZmxOakF1cFhUdEhGSVo2RFNXOEtPcm9MY3pPU0d2?=
 =?utf-8?B?NlJrOE01a2xnTFNoRFNSeDFWRlNPL3RUS0dKQVJJSkhzN0NoQjJpQ3NUM0E0?=
 =?utf-8?B?SEF2aHN1N3BkR3N3eHFDaXBBTlhEUVp6TjllRjRjNVptMmR3a2lCQ1BhckRE?=
 =?utf-8?B?bUpQcU9ITHJnbUJKVEVrd1d3YTh1MzZmZzBQbzBtMkFYQi9hNnhHUlhyUUlu?=
 =?utf-8?B?ZHFaaTlJZ1pMOGFVOEN6WGZlcDZoQjQ2ZkFXTkFWRFhLaks3cGliYm9DUURC?=
 =?utf-8?B?Mm04RU1sOXpoZWxONE9FdnBlZUtWK3NEUDdNK0QvT20vTHBkQ2xmTTAvaUIw?=
 =?utf-8?B?UlRBL01XVWlTaW52VnBqcWNtSG9rQm90bVF3U0FXVTlRM09FbXVJWDZPQWpJ?=
 =?utf-8?B?VkNxdzVya1h6NFJmVlNGMWdRSGNSQnpTckxscDJkNEt2L1BIcWVqeENrSStz?=
 =?utf-8?B?WGpRMTU1eWxQSEZnTGtvd3o3bm9rVjJDcXp1RlVLV2VOM25MVG9DbUZpZTg1?=
 =?utf-8?B?RHFRZEpINXRpcEpNNFNWUHB0THFYaGZtRXA5QWFZYW9sVVNaVWt4Tlc2WDVa?=
 =?utf-8?B?ejJORFZiT0hXL2RaUVJocXFnVno3QldmWGlhN1RrendobGMzNTZkV1ExN1Vv?=
 =?utf-8?B?cDRtUGh3cHc4L3JvT2pPOEw0ZHA2RlZSTnlOL090d2tyTjg5WFlQMEJROG44?=
 =?utf-8?B?eUxYSndUcWhlWXhHdUJRNTlWV2R4NnZnZHJCZmlqVDFxS1ZVTjlrdHpHb0Rv?=
 =?utf-8?B?VnZRYTlJNm9OVk80RlJHVWhrbVRUT2R4SzRGK3JYVnRMNTE4bWRrb2xuckJk?=
 =?utf-8?B?UFdQNkVkUFFYTHdHU2FJQmtBb0VneGV5b1NCMjdYc1BsVUxQc3FBeHhOckhQ?=
 =?utf-8?B?TUlCVUZaOFhhUnp3K2dZazJmaHQzcjlaV0J1dUdoaktnSWxDSXl3a1YxMnEv?=
 =?utf-8?B?OTZnVmxDUmxIa2Nsb1RLWm05VS9jM3dnWVVKVlNnb2JseGhCZkpQRktJZmFr?=
 =?utf-8?B?dDRaM3o4QTVOSU4zWXBZNitPYUxjVnRkdnFnZzZIakhTaENBVGZqZU43MlM0?=
 =?utf-8?B?ZEVtSDhmSXZFSGM3a3JlWEg2NkZSVXJJYlZQNnBQbDdmaWlic1pNVGFwZVhU?=
 =?utf-8?B?NDRzaXZGS3lPWTVhak9xQWtqOEVhYklUQllQdjdNelE3Z09uY291M3VGc2Rw?=
 =?utf-8?B?aDFmMEFpRjZkYjc2K1k5dmVvY29OZXQ3dGJpY25aY1NGWDgxQ1lvS0NuRXBN?=
 =?utf-8?B?RjBTL3NKank3cHNoaEdqMVF1WDdIeVBITGM1Umg4c1F4K0xzZ3ZoQUNDdDBB?=
 =?utf-8?B?Q3hINlVYdWlrTnByQTFNaTlCbC83MUorcTJJd1VCM2Q3a0VORzhMbHVnL1Vh?=
 =?utf-8?B?MW9Ua3FTb3VhWTJjZ3J4V0R4WEtlRTEzMm92UzVjbmRRZmErUGJ3N0huQWxN?=
 =?utf-8?B?cWpiWVpNTklRTDhHL0lCS1B5U0VGQnpFVDJZK3BLbFFVczhUVGhFWEE4NUxo?=
 =?utf-8?B?V0lMRjdNTFpnYW5qREZ6b0VIaW43YUQyOTdURHpLNU80eEY5elZKdzI0U21N?=
 =?utf-8?B?T1hnQWJzTFYrZjBiK0lnVGNRenR5RWJCbCtEMDlVNVc3dW9Qb0FleGNVdHJr?=
 =?utf-8?B?SFl5MkV3c0xzN1BoYVFwbHhwNHlqMk5vaCthbDhoUGlSWVB6Z3dBM29sMDgx?=
 =?utf-8?B?OFZMOWZVNjNaM3A1TUNkV1UvLzhBTTIxWU0yK3V1aWRXTXBOaC9KV1hOQnhu?=
 =?utf-8?B?MjBkNjBmSTUwT3h6SDlXdFBmcjZtbTBUWU0zOVR5TTF5SSs5ZENIZXN3N2VI?=
 =?utf-8?B?M0NWTWJFMEViL2p1Skk5ZkFzeVdLN0RSR1ZqeVZxclVvdGYxNXBJV3NMdDRQ?=
 =?utf-8?B?MTJMSFZ0em1OaTVPTWhPcjEyeERlMStDSklKSWFiQkgrUWF4MkN5VkJnUXR6?=
 =?utf-8?B?UzNqU3Mwd0VvUS9Xd2NqVTBGbit4Mkx1UWJjcTBiYmhkKzhqUk03VjNBQjFq?=
 =?utf-8?B?dXZuandGTjRrN05iVVhmU0RqYlhLdE1rdFFnRzIrOWNmTWFSWHFqSURoUjNk?=
 =?utf-8?B?MEdVcXlTbWtUY2UxNVluL3NkTE5LRk5wc08wUFpLVStGRzNQaW1jQk9NVVZ2?=
 =?utf-8?B?SWgrSTZLSW9GQ3JFVHhucEppUFUyOHp4Wjl6bjd4S1hiNzhHRlRTMjFYSXcv?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZThauVSiOKPaNx7g1qffL2ShjGoHvJ6PeABbMHs8QZR8rDneq6hDGkLIoW/bFs5lBeMOHkDXON3R/vuSDNYhUrusTFAh+bhF/jUOfbNCC3Y/5XMm8ZNQYyM+bt9FCvD6K7pBzJkE9knx2peL3p4dSUhjl9B6+eiTK9bp3TwANbjvk5hkdBLIPxB6rmNZfJLJg32yRowCZDFPGkGS+fTkEW5kEBLKAY7RqSfg995AOgTS+nVCALa8WIQfNnibnszSdsMOvQ6Lz/GmPFxInlicDgbktEeaOLuk2t02yybWkHi/AnKybiSHctUq0X2YfMxeKmm8KEYbvPsa2u9K2ej6aZbjbca3GWDZJTU69Akz9iiXWfCwdKXdKktPR4x1SKZCImyJtMohsbeoPRiu4BsWlZx+EITyz6OfNzVDqPwaYZY8DEy046swtZLnEaaRKLZRmiyXbuOEG0Imfzoyijxu59CDndwSYmTGngsHileySS3KT/eL0qv1AfBsmgDSoI2aQ0EkrjiQD/BWt9iR3pWY4eo8Iq5liEk0e/8Ka0EHoaXZJRZzgLqylLawMpUIW8NvMwfPnctlZrqjp7SB5hNzGHERbzbFYtT9g0db+Oy3m9YmuMzosSylyZy/hangYpO01TAhPDsCHq0SJ+U3wDymflEnMA/ScGpSodZBob+2kcyxBEYRwfjkFlCPuzo4DI90wEz4AkhShgDUv1aa8dl+SMUkQPRicsnk6rNifGM1Jzqo3T+XQnU4tvxULQXMxsQUU4mq2JjtZ/0nWAvG0XrgJ7Sa9oIA14qwcgzO2zvX0VYoggO9sGIiqKb6PnVnnZgEIR/XDriQoDX5R1DPSFJFqw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d563e2eb-8108-45ae-35ee-08dbc4573a6a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:25:12.5288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/EGLRcTTjDWMk/Dkaqid0qCMnWOuQotQDZiBPbeqMco61j/XE4x1mikShEeK5/+OvheJs3xVWD/kLJ+gts4XIh+JNVQh0exUG1/v21kTiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_18,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030161
X-Proofpoint-ORIG-GUID: JmXl1IfcAjjTIwHH3pB_CXu4jG3IPpLf
X-Proofpoint-GUID: JmXl1IfcAjjTIwHH3pB_CXu4jG3IPpLf
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/3/23 11:07 AM, Mike Christie wrote:
> On 10/3/23 10:36 AM, Ming Lei wrote:
>> On Sun, Oct 01, 2023 at 01:54:47PM -0500, Mike Christie wrote:
>>> The dev_id/ub_number is used for the ublk dev's char device's minor
>>> number so it has to fit into MINORMASK. This patch adds checks to prevent
>>> userspace from passing a number that's too large and limits what can be
>>> allocated by the ublk_index_idr for the case where userspace has the
>>> kernel allocate the dev_id/ub_number.
>>>
>>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>>> ---
>>>  drivers/block/ublk_drv.c | 10 +++++++++-
>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>>> index 630ddfe6657b..18e352f8cd6d 100644
>>> --- a/drivers/block/ublk_drv.c
>>> +++ b/drivers/block/ublk_drv.c
>>> @@ -470,6 +470,7 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
>>>   * It can be extended to one per-user limit in future or even controlled
>>>   * by cgroup.
>>>   */
>>> +#define UBLK_MAX_UBLKS (UBLK_MINORS - 1)
>>>  static unsigned int ublks_max = 64;
>>>  static unsigned int ublks_added;	/* protected by ublk_ctl_mutex */
>>>  
>>> @@ -2026,7 +2027,8 @@ static int ublk_alloc_dev_number(struct ublk_device *ub, int idx)
>>>  		if (err == -ENOSPC)
>>>  			err = -EEXIST;
>>>  	} else {
>>> -		err = idr_alloc(&ublk_index_idr, ub, 0, 0, GFP_NOWAIT);
>>> +		err = idr_alloc(&ublk_index_idr, ub, 0, UBLK_MAX_UBLKS,
>> 'end' parameter of idr_alloc() is exclusive, so I think UBLK_MAX_UBLKS should
>> be defined as UBLK_MINORS?
> We can use UBLK_MINORS. I just used UBLK_MAX_UBLKS because it was only
> a difference of one device and I thought using UBLK_MAX_UBLKS in the
> all the checks was more consistent.
> 
Ignore this. I misread your comment. Will define UBLK_MAX_UBLKS as UBLK_MINORS.
