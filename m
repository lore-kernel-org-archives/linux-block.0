Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA29DE7AD76
	for <linux-block@archiver.kernel.org>; Tue,  3 Oct 2023 16:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbjJCQHy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Oct 2023 12:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjJCQHy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2023 12:07:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A93A9E
        for <linux-block@vger.kernel.org>; Tue,  3 Oct 2023 09:07:51 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393Dtl87017890;
        Tue, 3 Oct 2023 16:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=IlTs/KTZNGBVezCnevb+B3eXtXt8JtkwT6TsUqgkfNM=;
 b=E5RBq5TkBvEbTtC0Xc0P+1hvcMJel4efN7Zjt/ymkwup0rUK6cMzGNdIDmGdyA0gC1/D
 jEvOtA/WrE4lGqWcXKbgEldqaB5TwwPZ3ITBH5vNX2OqSKQtinFZvMMa0cffAbHNBPJu
 kStXKK4tGMlJBOexWbUMMNQ/x/I7D/qbxATc1GkDQgkwziOI9teWq5xvPyeCGSO+cBs2
 o2dtmEWS7Nr5KiAqaqzrFrfR6fbC73uwcJIwJMPipNEOrdxTgQ2ZLmaxgYlfW8d6TZk9
 gKmgk2/H4MiT2WLjHaz+JvELUn+5xiQj/PZyEbZoWnJAbWRwAb6JBLvBtL3bkli/0GUA kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakcd65v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 16:07:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393FESL1000448;
        Tue, 3 Oct 2023 16:07:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea466q8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 16:07:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIyiuTZL9ypzY8fuZRRMSNcwkDjr0qr71gYRcshpiSM4OTe3HPBamWfybWAkPL+BC7x8guHTViIZ+98FB5xFZNo5uEM1gbliNFcCPut8tjFA8CbE1qQZ4xQtKlW+osYx3YpDBlH9SwvwwYn5fh1OkymKM+rmf1mQl43YujwjTwH7uhMTpe3Soa7CM/8QzmrLGLmnjppK5u9SMs0vzMCo9QxW3Fa7/EZeNDrt8kQLfRNwq+y5l10ygzQ2/xFiJZfwlGsA3/2OIisQj0l+dXaAsbj8wSA8YnVsU3l5XBLjq7MwYCKoZmWS7KO8ecpYvd/wZeQwbnEAZQnWiSLaWkOVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlTs/KTZNGBVezCnevb+B3eXtXt8JtkwT6TsUqgkfNM=;
 b=jXRs+qnbsi4ruvec6zVx5D9veEkOfZY12ocxsZ6ab99E1sQiWq3xlcAAImal9d9L9W76hZol6DrufsEQobikpjAdOZP5Rey9qYL4Ov3RLP/1SBcwMXEWAjrUD7VXCYqhbVgJfyLBIj0Ng2I8lqjTX8mR9P+4kfVpQnDdEivn9ayJKqhk73Hk2DVpsjdmyNKdCJM91yvAcr0lDwTs16CF+o+xNbR4Ff+QSjlcTNDttOW2o3Dlu3AN+CSegRjmy541mK0K9PgSr+5szcvNXC8wbz6WJ0JREjz1UEW/a24tbh9jiRKGSW+TAh4F15TVy0VPez0hRIMuJOLlZw4YpPljJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlTs/KTZNGBVezCnevb+B3eXtXt8JtkwT6TsUqgkfNM=;
 b=YBj1OCdC1geF5Re4CzJLuSD790tJ4rCdhlW4l2hxKRclWPSFmNuJNrD/8IByi+N/yLUgaNHSbwGWsZl00rsDEJH85gtC7jWh7whLYwHMRILIlusUeHw1EZIfPIUaZ8cbwBlUI5s2t1hqFm4dHPR8WNc1iRqyP9EYqIKgqC240nw=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH3PR10MB6764.namprd10.prod.outlook.com (2603:10b6:610:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Tue, 3 Oct
 2023 16:07:39 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8%7]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 16:07:38 +0000
Message-ID: <8c37dabb-46e9-4f8c-ad19-eee3163e3075@oracle.com>
Date:   Tue, 3 Oct 2023 11:07:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ublk: Limit dev_id/ub_number values
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Hannes Reinecke <hare@suse.de>
References: <20231001185448.48893-1-michael.christie@oracle.com>
 <20231001185448.48893-2-michael.christie@oracle.com>
 <ZRw1GvSwh+49SmL/@fedora>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <ZRw1GvSwh+49SmL/@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::20) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH3PR10MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: 564cd993-e7af-44de-c36d-08dbc42add94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RtiW4w05e+m6Q0pmN2OoYWQ2l073ry7qSsFSxld8NPMtBwdKv9WZX6LldQTyUkgtlDXyAaVj82/eVwn8lFjiBNKhtyBEZLyb9pClqxtk+zqJZcx7XOqC9MkuFKDUec64l+7lRiF2nWCbKakI7w+H9EP1uQeShemVZcOQ0mOHLnsO2dgpEShnF7MmEFyKV4RC0/el9nE/sQIeiKooUy8P2uegz0As69XkxOLRoLisEns5DHAz9TxMPAfhmUFRfbprE2DgsGnW5f4y4SsPC2L0/HU6omNFtngcvZoMOnwIk1VAMqOuoJDj02srhj9B9nLcMNOnsdoNBqs78Bm1a+QFXyJkScnHGG1G0TAVzfbHvS1sv/gGLWW4w49jyl0nKPyiwhLWyNyjohDOAwjTlcx0K/nqte/MhvORI0+lxhpFllxoDwbhRhyBJMyvudvHHM/ZeUXSnWR2aHCrW1Iup5IqbjiLeCkrcy3ZnG7hfpGnoV7hzWgjvV0MN1KWrqP13krNO6bPoaNoRTY/ChYJHNtu95ruQCq5pC8Sn040l1ArXq0wrp4gQppyOuvRq/sNgUIw8Ba8yzmQV419PRaZP2FWcgsFFPZXlg5WbtabTah895zrrXUn1HIm+FNmc3ZwvlVAp1UtJslrxKEsctgOKsawQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(316002)(2906002)(6916009)(5660300002)(41300700001)(36756003)(83380400001)(4326008)(8676002)(8936002)(66476007)(66556008)(86362001)(31696002)(26005)(6486002)(53546011)(6506007)(6512007)(66946007)(2616005)(38100700002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVJnWVJEbDF4SUZkQ0dGWUNwSG1qTkMvQ1VoMDZjL1dSZ0FadzVrM3k2VmMz?=
 =?utf-8?B?bVB2cnpkcmtseGI2N2ZLRFJBbXRRb2ZZdjBocTZvcy95M1JrYzJIemh6T3VQ?=
 =?utf-8?B?cmdxYlpjbHd4amZpNExuNjFBbkRQTy9yQ1NmZENpWmFVVVIrNFhQbFFVTUt5?=
 =?utf-8?B?ZEl2RHd5TjJ2TnFDT2wyak1ucEFsYXVzWTVmdy83bXgwcEZ5T1A0UXNyWFI3?=
 =?utf-8?B?UUxYR1A0Q3lMbnRDV1JkS3JaSjFvcmhFZmhmeVg2T0NRd0IxaXVuSXVTOUJh?=
 =?utf-8?B?KzA4ZUlLYkFBOXN6VTY3dXY1MXUweXYyT3lsalZPOTdTdzlyZk5kcG5vRGpH?=
 =?utf-8?B?K2NnMFR0ejBkOW9zREF1Uml2V2lTTEZxR0ZtcE5qWFFpRVFiLzhOWTUzUWx3?=
 =?utf-8?B?djNoWksrZ0Y5eXhIVXUvdXh3b1A1bWthWnZkbDNMVWxTVW16eTZOdHd0Tjdj?=
 =?utf-8?B?VVpPeWRLYUw4YXU2M09YempRVVlVL2F3UXBPMlhaRjN3UFA5bjdRNHdTREJ0?=
 =?utf-8?B?c0tkSHJaQW83Z1A5dFEwcG5ZNk03cStHVHhnVjRnRFVLUjc4b2Fvck8vSzBh?=
 =?utf-8?B?Qkd4dlFtU2hCNzBQY0s0YUdvdGc3YVoxVlg4emh5dUhIckJJRTV1eFJGTVZr?=
 =?utf-8?B?Y291WGRFQ3E3S1ZieUdwKzhxK0ZpNXRHbGpsRXkwV0dwSklDcHdsMDYzV1Ba?=
 =?utf-8?B?QlErbTMwSmdXL2xzT0dyejcyb0ZheHNxU0JFWDkwc0p1UCtWWU1UZ2liU25E?=
 =?utf-8?B?ckJueElMNWMwb0Z3Rzg5Y1U0WHFDVGthaHBwSGhiWjY4ZU5UR2lEcUJwbkg0?=
 =?utf-8?B?dXlWWGd3Z1FjMFRiTmVyUzVpVkxLeXBVWDdIUFVMZGtsckd0OEZLS01Tdjli?=
 =?utf-8?B?eVJDWDcvTVQrNE5DUGlHOVhjZDNGQ0RmR3BSamgzRmtNTkt2NFFWWWNLeXkr?=
 =?utf-8?B?cGNyQ2NNejZVM1J1Y1lMNlZjSW5rS0hsb216WGhEMHptSmFzdFR5cVZObzhW?=
 =?utf-8?B?UU4xamJaTE1uUnBKY3NjSHFqc29nSEQrV0NsclFHTkVCWWNiNDQ3NGFKbFRz?=
 =?utf-8?B?Y1NNRlpIemowUGNma0I0cUpjQ3pyZkNGV3R3NUR4bUVsZlh2dStvRFVqeHBq?=
 =?utf-8?B?OWpPUnNLSEQ1V2lheUpZMEM1NjExeUZ5dTNLUlBtcDBBc3BEcXVlL3ErVTlH?=
 =?utf-8?B?RDdnYWNsUVZyOHgvZmVLQnBNK0htODlHMEFUcFFmcUpRK3Uzd2xqcmFkK0xK?=
 =?utf-8?B?Vkd5eXB5QlVrcXV0VW5WcG8ranJRVXFydSs4MlQ1UmgrenNwRmNkOE1Rblpy?=
 =?utf-8?B?Vnk5dkQ1YkMrcitLZUR5bHdzdVlxeTNSQ2hVSGlVWVh4R1l0ekhGTDJrL3hK?=
 =?utf-8?B?N2pmTWlLbVNRMVhLeUdGMDIzV0RNcUl2SHljVm92TzlSY054QmlOME1YWDFi?=
 =?utf-8?B?SzBFWnk3M28zbXVTdW0yLzlOVkZ0Z3MwdjRucC9mYkVMeTJ5Slk0LzcyUENk?=
 =?utf-8?B?OXplQzIxcURXOHkzWHV4bS9UQVppaVhZZ2I3cEFXYnZKTXBnYU5CS2todDQ4?=
 =?utf-8?B?eC83bkw1dGFzY2tIamZtZk9RUitTWTl3bGRGNTR4cmR0LzEyL2dBWDgzQ3d4?=
 =?utf-8?B?b3MrcFdDeE9LUW45d0d4VnR6SEF6RDZOem1ObnBMM3BIdEh5TldHSFlOZ255?=
 =?utf-8?B?b245ZnVvMnczWTlCUTUrdEwxK0VVQzJiMnZpZy84djVhbXBCb0lJV0Z3S3Fm?=
 =?utf-8?B?TUhjVHNtWHdjdG1kUmcvWEhRMzJjN1Yyb09pdllsM0pFcXU1TWVXQlBoaHFx?=
 =?utf-8?B?dURsTDFrMktvbFlwaGsySjlIRVBlUXVENGJHWitIZ2NVTnRXYjlOUmVMZlB1?=
 =?utf-8?B?R0dpUk43VUdJZlNhOHd4RFo3NUkvZnBSa1JreE9JYlZtRXJSMk5rTlp4Q3Jo?=
 =?utf-8?B?d2hBWkJMSlVPcDJEcXhvd1owOXlJWS9LTEZrV0pYQ2p1M3lSSXBDbEJva0hH?=
 =?utf-8?B?QzFrcTUxSW50TjU3c2xNdmZTcmk2TDhzbVdhWXB4RSt2UXdtVFRYUFVQb05K?=
 =?utf-8?B?RkJqVXZDU0lpVHdENStTeVdyMFVPVlg0MXRPYmM5RFAwVFJhTTh1Vk1VR05y?=
 =?utf-8?B?anZQMzU5N3kwWk9EbEFiWVh4T2xPdVFHU1kzU2NhaXhzangzdHllSVhIZ213?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5rQ/+ZyEXWMsqlh9Fy8GXN7AIaVK+7W8Hn3XjvyMP2JFcqpZu2rYy26OmJGx3fsjD/IE50b8u/DZtI4IqcGi35Zh0VqJ0juRoVFRj5jVEfYsWtB1+0W3vcVzPO1/98toh94CtAc1KJbcsoEy2Gq71kObqE3dV6S7f4y9hOYQiXmnP2oKNCe31dkPEL4/LhVbdJbJeZJQpZrQ7KzNh0RSyokGQmMUcp7ouqHmj2AZYba0XxEBaL8ao622w3pca5XV2mynJKmuFsqBgjUaelMCcLo5lLzlb35kwEsSmZlqeHYnpptEK4Kv7TmmTghsSsdvoP44W0d2OYar9UcYk+VJhNpnt3cnmEmRBS8W4ORLV8dHm6OzZJy5qW1nJ3pBXR8DcQwAiC+tPT9qGyvzU/HXXH2UD1nN9Ts+z3hzWlGvkd25f2/9T2wcaFEhSUVyUAXEq0s1RcXHKn9imkhv4ALtyXAaSavbLZfovdDOzuGm6cH+yThDdNqqlVcFDa+rqACihjr6GY7scGauCQS7IaaTL7ISZ7fILVrYuJ+tHG6TIWtuj2wVtsSw2lu/O4LkHFd+MLu4IvUN9GumJW5ZU6zDWku4hitmAC1y7NuvSwhBhPd1FsJMBbmTPchQD1duT7Cg+iAXqtdrnzcTu9ZvDKlScH6ryb7kMykrK9TC6RcOzzLb1OvyGA5axnWwx5bfP447zMVzqrJ0QrVge/y4ZI87UkuWReNR602AkKkAmlK5SxGfAJjC9vA1cetAv6qD7eggjUFOZ7VXMspiWgfZ1xmJXqf/7R1U7HuNJnC46BeF9fFTQwAe6ANEpU6AdE5ptUqgALLjWFrnZd4KjlkM3omBEw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564cd993-e7af-44de-c36d-08dbc42add94
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 16:07:38.9202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sYNp5ug6OHDtNKfhoIVOwx7JB9uxGVfbuGaSwWkDV3rz0uXYT8MCaXaZj3RAfuAK34XBxNmzeWKmGuJMSa/gcXETheEUgsBlh+1EQOTVsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_13,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030121
X-Proofpoint-GUID: t5TIhdEqS8TmYXdyHmbqkO8MmUn0MSZy
X-Proofpoint-ORIG-GUID: t5TIhdEqS8TmYXdyHmbqkO8MmUn0MSZy
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/3/23 10:36 AM, Ming Lei wrote:
> On Sun, Oct 01, 2023 at 01:54:47PM -0500, Mike Christie wrote:
>> The dev_id/ub_number is used for the ublk dev's char device's minor
>> number so it has to fit into MINORMASK. This patch adds checks to prevent
>> userspace from passing a number that's too large and limits what can be
>> allocated by the ublk_index_idr for the case where userspace has the
>> kernel allocate the dev_id/ub_number.
>>
>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>> ---
>>  drivers/block/ublk_drv.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 630ddfe6657b..18e352f8cd6d 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -470,6 +470,7 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
>>   * It can be extended to one per-user limit in future or even controlled
>>   * by cgroup.
>>   */
>> +#define UBLK_MAX_UBLKS (UBLK_MINORS - 1)
>>  static unsigned int ublks_max = 64;
>>  static unsigned int ublks_added;	/* protected by ublk_ctl_mutex */
>>  
>> @@ -2026,7 +2027,8 @@ static int ublk_alloc_dev_number(struct ublk_device *ub, int idx)
>>  		if (err == -ENOSPC)
>>  			err = -EEXIST;
>>  	} else {
>> -		err = idr_alloc(&ublk_index_idr, ub, 0, 0, GFP_NOWAIT);
>> +		err = idr_alloc(&ublk_index_idr, ub, 0, UBLK_MAX_UBLKS,
> 
> 'end' parameter of idr_alloc() is exclusive, so I think UBLK_MAX_UBLKS should
> be defined as UBLK_MINORS?

We can use UBLK_MINORS. I just used UBLK_MAX_UBLKS because it was only
a difference of one device and I thought using UBLK_MAX_UBLKS in the
all the checks was more consistent.

But yeah, I can see the opposite where it's more clear to use the
exact limit and will change it.


> 
>> +				GFP_NOWAIT);
>>  	}
>>  	spin_unlock(&ublk_idr_lock);
>>  
>> @@ -2305,6 +2307,12 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>>  		return -EINVAL;
>>  	}
>>  
>> +	if (header->dev_id != U32_MAX && header->dev_id > UBLK_MAX_UBLKS) {
> 
> I guess 'if (header->dev_id >= UBLK_MAX_UBLKS)' should be enough.

I can't drop the first part of the check because header->dev_id is a
u32:

struct ublksrv_ctrl_cmd {
        /* sent to which device, must be valid */
        __u32   dev_id;

and userspace is passing in:

dev_id = U32_MAX

to indicate for the kernel to allocate the dev_id.


The weirdness is that we convert dev_id to a int later:

ret = ublk_alloc_dev_number(ub, header->dev_id);

....

static int ublk_alloc_dev_number(struct ublk_device *ub, int idx)

so the header->dev_id gets converted to a signed int and in
ublk_alloc_dev_number U32_MAX gets turned into -1. There
we check the idx/dev_id more similar to what you suggested above.


If you prefer your test, then I can convert it in ublk_ctrl_add_dev:

int dev_id = header->dev_id;

if (dev_id >= UBLK_MAX_UBLKS)
....


ret = ublk_alloc_dev_number(ub, dev_id);

and then all the code will be similar.


> 
> Otherwise, this patch looks fine.
> 
> 
> On Mon, Oct 2, 2023 at 2:08 PM Hannes Reinecke <hare@suse.de> wrote:
> ...
>> Why don't you do away with ublks_max and switch to dynamic minors once
>> UBLK_MAX_UBLKS is reached?
> 
> The current approach follows nvme cdev(see nvme_cdev_add()), and I don't
> see any benefit with dynamic minors, especially MINORBITS is 20, and max
> minors is 1M, which should be big enough for any use cases.
> 
> BTW, looks nvme_cdev_add() needs similar fix too.
> 
> Thanks,
> Ming
> 

