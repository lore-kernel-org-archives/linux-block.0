Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1923EC433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 16:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbiCBQxS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 11:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiCBQxR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 11:53:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CAC3BC
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 08:52:31 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222Eq6sT010129;
        Wed, 2 Mar 2022 16:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xoMqRb4wKc0mvev9O3Pk2TTTNd4eQgvoCghXCFTBS/E=;
 b=Q+nTlwOnai7AdOvlWZ21ksQoZgdj9aL1G7IuPOM7nF0EMCi7GTYNRcaGED64X1Bujr9u
 KiHVyFb6uRmAIyXsMxloorAan5v6uhzlY5Y+SvL6Klm1EyS4jskRX4qX7DZM/AqqmbC5
 D/PzT7dNph2UEcpcxCzP3SLsB4pptFmWPn2mN1vpw8x3O8bMuL72joABboA8ZSIeBhBJ
 KZ4yCc/MmO+fORCkwf5V+KQ1N/kNrKQWLgf8DDArcoXIirKbfrnjQySdOAOR1F0gFYk0
 zHJMlhEqHZDqjpXqpuUS7IxP0rVrefIoqnVcNa1LiE3XGZGkutgSkWXmxF5DHN5GTMzm kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehbk9cyhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 16:52:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 222Gq4aB037504;
        Wed, 2 Mar 2022 16:52:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3030.oracle.com with ESMTP id 3ef9b196vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 16:52:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2BbGHiqnRkQA7o4e1hAHiM4XLuwdzi2Xa4N5M52WXStGBwAfgb6i6pVUbJ1lzJrfPe/qXMYiAuT3ofemgBRI+1E6/ivaTCnPB7oubVtCM0q36kCwvVHn1Ve4aWQfArm4yArWpZPt5m8D1cqan9sUAIlKZ1Htn2OaNcSW11SBOAOCWVeUlpkBdX1tXo7sIIM8y4VcpeduUOUov4NDjfDol/syoSKLWUkLLoguBMIzwTf4Q3fq7KkDaZv6TNkABZHz5y3Na3pH64tMecvqHhIh3WGu2PpjBRChmi75Pz+7+37zyKQanjDaje5Q7emzfUSI1w6EJPANzJXjJ+Wal3s6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoMqRb4wKc0mvev9O3Pk2TTTNd4eQgvoCghXCFTBS/E=;
 b=PShc3dZOabEdZQAeTF75+qfaQey14tCo8vhBmWGJCSFcAQ3hY6zm8Sj4qJibXfQdqy6Y0aFpzLfMIbdZ8Cm4sSyWCw08W8Azsnt7/TiUlcMoswDCFGrrD3i/hyJaNgVDXsRdingpBPLaeoygyLxfxaeRe4YCM6cPR6dxq+vBBa/aBSmVAXFASAjOZqmhJHw3gzQdUYX7dNU+RxZIUkslKczLYzIkaiCeuAlDUblQlOZ3y+hGXei7TobDcpiCalV2B9bTKn+hZ1yhCUE6POqxOhMRjGVTbBS3/mFt3Q0atJ6VUzYlMX63UR6ZUBgTmxTzFBPch3zT+0UvatwaMdWVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoMqRb4wKc0mvev9O3Pk2TTTNd4eQgvoCghXCFTBS/E=;
 b=quCIQThUgxkTV66XGuos922gcHlXgqQAS1mTv/pGOYOENHmq9ez4RGEhvWQjYeslxY6FGUdy7EdFMi7cC78Q2/fU5ra6jwEsYZS+SbBysJCiGbdcXTAktU//9auD3oz49myCpdP8VmcgAaN0Y+8ltSjonv09CZSZ1A0uOy61fZ8=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CH2PR10MB3751.namprd10.prod.outlook.com (2603:10b6:610:1::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Wed, 2 Mar 2022 16:52:24 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2%12]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 16:52:24 +0000
Message-ID: <526a8360-d7d3-1211-087b-c86d5a68380b@oracle.com>
Date:   Wed, 2 Mar 2022 10:52:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <87tucsf0sr.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR1101CA0001.namprd11.prod.outlook.com
 (2603:10b6:4:4c::11) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac75dfff-32f7-445f-8fef-08d9fc6d06b1
X-MS-TrafficTypeDiagnostic: CH2PR10MB3751:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB3751239272BD81FBF55480FBF1039@CH2PR10MB3751.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTp0SncaQuMQnupIywy2wtO7G+dAX54tgnZmtzfEoy2VWRZaKXN1YPKrlrMRaDfmHR0GqZ2ADyKrkbW8Oziwhh+YRP2CNhmttlX6RRdmLA3CqB+w3jNNPA560EjBWOEsa0JH7hmRIb4OdfBcvrcykYFQp4JRC/jZblmEkK7Fyx2QZOS6LnjD1QZsJ6fYVr47csbM1RfEjhy3Tn4Zp4KF4vq4N0saWev83h0ijXtUYvHj/tR4h0jiqEcKvnuwas2XH2lxy5u0TnG0zecpRDTL1kbXwyFjut4bDAEcvwGyzXF1brj2nqVTV912iDPQb5tXP3YWXuyaNdA5Zm2GB8/K3Hw37nwqhs/GDSg1/h7qcmteZA9qMHgiT+8EyJAorDm3lHVXeUKaALN8BxMIbkoWVPrLttsb/Ev3NhiB4K6Tk1i7aBxirA+RPPLe291NU8vtMv6imAFE9XQoHNka2/hY+fKxe3r8FdK7xoMhDC6FdTYeq56z1D/QIiAsr1TwyusPqY89n3NTcacNS5O+SRTUNcLo3AwmallpBa2LXrTZPe0YdKgo3w3qP57o3VwYO/g0M+/T3gDAbH8vnwCtcGTYkjLM1/XXvUpKXhQJTQCZjkVQHyhXD/WODPCkc58cgdoamfoGGk+k3xVOmSjzxU3xSNpmAaiuj5cNTfveyRWmTggsQEDUgUWDYtbrn3uV/+9vYtwgePT0Jbbrwz+dhcQS6yfGd2Yyr/1AAk0/fd7shkcRCU1VraKv/gDOEPVMyKwQ6V1rBBdyhuOXaRlNGDV0rVi2uZ0wFhWt4bY91uONBhGkhm2UYOGabfoBPN0fUDFw+2JrfxYRqK4c2ePpca72cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(966005)(36756003)(53546011)(6506007)(316002)(38100700002)(66476007)(4326008)(8676002)(66946007)(8936002)(6512007)(66556008)(186003)(31686004)(86362001)(31696002)(2616005)(2906002)(83380400001)(26005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUZrK0Fhd0xBSnRvUjVrZkIwSjNmUTVCSUpaR2FlcksyRklVVVVwVUhpNVd1?=
 =?utf-8?B?NmdLaElrUEdmTGh1b2xYcFRPZXp3MFlkL2pwbitOa29TbGdKWWpJajhNa3FQ?=
 =?utf-8?B?YzZIVU8wdHFJc3FqVWJSeklXOTlFckVqb0MzMlNjSGhKUUhHYzBpQlNMU0N0?=
 =?utf-8?B?U21QVEhGQmdpRkQ3cU85SFBLdjFsbXJIWmJ3NFhBWjlRQ2lKUjBQampCNk1w?=
 =?utf-8?B?R2RlMGJuZStET2dIYlV6bHV1a1hBL1VBNHo5VUdhM3NQSXVCaDJuQ0ZCQ2lC?=
 =?utf-8?B?YVZCZjFtUXVhRGVoSFZCZTQ0YnZ0STFZMHFkSGVoODZRLzdTbHJXUDE5Tlp5?=
 =?utf-8?B?YjdoY3RzNUZlQURyMmNMY1ZqWk5ZenBEMjBrUFJueHhnNTJlem5NNGR0QkxQ?=
 =?utf-8?B?dmhTQnpHQzlObmZZZlExekp5UXpobEtBSDhhOW5kSDdpN3IrVXAzNjdFZTNU?=
 =?utf-8?B?QlloYnpLS2Z5Y3dWTkJaaGlmY3cwVEpDWDlJdXVwN2xyVnNlVlVNYUlsN28v?=
 =?utf-8?B?U2NTaFpYRTRjVzZWR0ppKzFjbEExbzlXdUR6YVh1dWFTUngyODE5L1JlTndz?=
 =?utf-8?B?andyMU5LL2UzaUZqMGFmWWJsTldySVN4Q3Z3cE1ncjRKWUtLZjBrdWU5UzJS?=
 =?utf-8?B?VW53MFA2Y2hJaDJHUlN6Vk1WWXl3b0FmUjR6MWhGcjBWYmZncXFjOGJQQVNX?=
 =?utf-8?B?NGYxM1N6VGJHUEJlRDRWWFRqYTArWnpYeUVFRXZVN29Bd2pyNEgyTWNaU3lr?=
 =?utf-8?B?NkhSWHpFYUcxTHRzVW9XajlTQTJmZVlvZkpYci9JaXh4OVBMMDdJV3BVYmg0?=
 =?utf-8?B?ays2ajVGVEJraDB6LzJCOXQ3OHpDa05UelI5bjBPVVN3VW1VNnI5S2R6YTN3?=
 =?utf-8?B?QzU0VjFwcTNBWWxCMm16UlhlOUYvZTRMRG9RT2ltOS9JM2FsTkJMYUFvYzRS?=
 =?utf-8?B?cW45SmtUMFcwMUh1WXJYRTM1VVRaR1F3R0djMnJLbjUvbmlFWWd4RGtJd1FO?=
 =?utf-8?B?Z2l5eHdLeHdsWSswWEtmUWF5SzdmUVM3M0ZLQjBhRGl3MGdHaitYWVJ5QXVK?=
 =?utf-8?B?U1Q1eGRoYk8xZWxCNnZHMTVIenUwT2c4R1R4M1RsK1ZWYWwzZHhvYzNudzIv?=
 =?utf-8?B?cDNnRnBHSnEwbkJHTS9ET1pyaWxmMTNzZVl0eG5sazk1NVZrd1dPY203SXdK?=
 =?utf-8?B?M2FSNlNPK0dLUGVBTXR5dlNORSt3RnVmQjVHMEpTK0ljZUdrN1UwQjh6Z29Y?=
 =?utf-8?B?Y0FveXhWcUhUS3hRL0JTSEZCUGJKcHp5bVV5cytaOGRzUkcrZXpNVEhiK2FX?=
 =?utf-8?B?SDlxMHRlUUV2Y3A4b3JWQUJvTkZYRlRiY0ZRZ2pkNXBHS1VRcEQxczhFVDA4?=
 =?utf-8?B?MXZTczlYdTdZS2ZYOS9QNTFQaXoxTzhaSzc4bHVTU3VRQVl3UG5obGxIT0xD?=
 =?utf-8?B?Smg2a0NyZCtKOWVZYWtxa2liZElTd0c0WkthVVBQbStwSmVrd0pYeGlPOTB4?=
 =?utf-8?B?eTJ0bTY3QWhzVkpMandLa1JnY2ZLb1FBOGRxSVlHRVFQVDhUTVg1Q3NvRmVu?=
 =?utf-8?B?SlI0OHFNTk9DN094VUtkRGVHV2hjV2RvYk83V0JpVFlkM1lOMzR3c28waDFI?=
 =?utf-8?B?WkNNakdtR3pWTDdmaFB6c0RjYmFmUjFYMlV6WUpWVGw1KysvRlFEc2orVytj?=
 =?utf-8?B?Yk1RaE4xdmJtZEl3U1BGNlh5cHRidlhwVGFNaytMUHlnQTRaOUoxUjh3TWU3?=
 =?utf-8?B?NXJ2aThHbmJ1V2duQVE0Zm5UcVI2MWoyNnNIank5cUlwNXdHdmVrTVphaTdh?=
 =?utf-8?B?ZEpMNnhTWnlsVjdXSkh4bGhBR2xLdisvRzhINytFaTJSbldKWHA1RklpYUxW?=
 =?utf-8?B?eVIvb3dDY1lDWnJQQkl1TTUwVEx6UFkzcmhLSm9xZEszbzVRVCs5bWJFamJO?=
 =?utf-8?B?Q2tFZUNSbGMyYXR3YVRLUDZ6OXhzRkllUVZhazFtaWRjWFB4VFQ5OXBBTHdF?=
 =?utf-8?B?eWVRRGsvY2hmK1Zod2h6Z3ZYcjJIbVNGSUoxREpRdVN5Z0xWK2g3bHNFdElL?=
 =?utf-8?B?UGJqYUFzVHFObkJiU1ZZaXlaWFNlK2RjeS9pYU5Vbmo1OHRhT0hNbzdUeHJK?=
 =?utf-8?B?YlhpTnV6Z0tTYnA4Ym5uSWNXRHdxZHlOUmtrdGxPSytWeExpRCtvUkZIN3NS?=
 =?utf-8?B?Y3NnQVVSTnBmS1VmL2VRa1hFeTZMUnhqMFNad3ROcGlraU5vYWMvRHV1WUts?=
 =?utf-8?B?N0JSekcxQVRteFk5MjZoVEhmQ0NRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac75dfff-32f7-445f-8fef-08d9fc6d06b1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 16:52:24.4820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjixcjbC57OTittpwoGTYracA3KvBrrl8qOGnGSKo/xAArXluiURRxtR/3YB06Lhk2DvruC288fmtT5n2VC2KEMslt/1d1lFnN7vemIIkP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3751
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203020075
X-Proofpoint-GUID: eP9-Y47XGN6eW8Ug_2jxmFAMZnTG91_8
X-Proofpoint-ORIG-GUID: eP9-Y47XGN6eW8Ug_2jxmFAMZnTG91_8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/21/22 1:59 PM, Gabriel Krisman Bertazi wrote:
> I'd like to discuss an interface to implement user space block devices,
> while avoiding local network NBD solutions.  There has been reiterated

Besides the tcmu approach, I've also worked on the local nbd based
solution like here:

https://github.com/gluster/nbd-runner

Have you looked into a modern take that uses io_uring's socket features
with the zero copy work that's being worked on for it? If so, what are
the issues you have hit with that? Was it mostly issues with the zero
copy part of it?


> interest in the topic, both from researchers [1] and from the community,
> including a proposed session in LSFMM2018 [2] (though I don't think it
> happened).
> 
> I've been working on top of the Google iblock implementation to find
> something upstreamable and would like to present my design and gather
> feedback on some points, in particular zero-copy and overall user space
> interface.
> 
> The design I'm pending towards uses special fds opened by the driver to
> transfer data to/from the block driver, preferably through direct
> splicing as much as possible, to keep data only in kernel space.  This
> is because, in my use case, the driver usually only manipulates
> metadata, while data is forwarded directly through the network, or
> similar. It would be neat if we can leverage the existing
> splice/copy_file_range syscalls such that we don't ever need to bring
> disk data to user space, if we can avoid it.  I've also experimented
> with regular pipes, But I found no way around keeping a lot of pipes
> opened, one for each possible command 'slot'.


