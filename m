Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017A2C7618E
	for <linux-block@archiver.kernel.org>; Tue, 25 Apr 2023 02:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjDYCNY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 22:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjDYCNX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 22:13:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF90CA249
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 19:13:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P0i17H026506;
        Tue, 25 Apr 2023 02:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=wxgGJHs2rtrVBq6PK+ommuAN101uxqhgAUpJ5kCqTpk=;
 b=twYz0NRaunqvbzuiFkvyOMQHoCS4RD+bW6nqawwCvuats636IUPtDSZeJZwsB1r+8hRS
 93M9UXuXCWvdwBXjus9g/Ve/y3whTJJ2fpkdsk/3bEFNcuZbepaDKdFyMmgnQr7P14sH
 pND71gjXB+3F0CUa3UnO7n6NfGtYYi+amNhcbywFn4KT7z+7OsTe2kDsBrMumXijPP7o
 Y6/d0jbsdA+yON+uykhNt0InHvgjPD/HrX/3prNxQWrEuZ1GBod6HG4MEVO2Tp98ZG7f
 CUyaRpXJKGTRnhUui5bFhQk5qr+hwQcuqSKUUGZMa3w+OVoVKQmmUkczwl9vLWBDOz9q 1w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460d492t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 02:12:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33ONBChw007353;
        Tue, 25 Apr 2023 02:12:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4615tf3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 02:12:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIGnF0+dTFSCeyD3o4Miaj4GUwS4S1OVyqgf98nDcl9Lnht7eLDVp0EoLrCyQsOuDcMGO2yA8kjBSsmnWY7iMM9aBSt79TBK/w0+ZQLWEgWoa4ZJiUhL33iRuK9U1n/ehyUxpiFdeCPlhxwe/2aGEpooB0Dk7X/npCc91wAkVDir5pKAt8+Rtis7Ye1uAa/PBfhFnv3LDDhzer7HoooB2eq9UQl3ctYs8HTUo3w1Pma+mHNo+xU6ntB1PUCxBwiBi6shXSzVA1ugpKzwAc2pdvXj2Y4ruF0xxgvZPXYWblfYhBY2nt6lZt6TM9ky5mb+RB17BQlXDWU1PalkcZLAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxgGJHs2rtrVBq6PK+ommuAN101uxqhgAUpJ5kCqTpk=;
 b=JZ86seVfXbWA76RkR0CDyXKcoU1VsRE5L7U6LWwbmKsjd5yhBhjMicWOaZhSftjqWVzOUvdqHuD0RSm3vpt3wjlRfr6xQZu9yb9nQ+n1WRGEztlKKsimyzzOitWvAoW3gwo0ghexP4xyl7CsvMDKp0vptDV+rRYR4Sd1H+VQwkTpLYo2iDPQscwAHu9N+IlxFuhNNr98Hw+ts7Vj5KfnMqFG7zrcPnG/O9Hhnj1mtuIq3DR2Vek31dyBfTt0jXRlJ2YJPhFqCjq5NTSOScglJTYTMpXTjV+vrdj+ZSmvCSuL97xeiCv2mQfJYWF9tS0CQqhQznC5L+HnP+p6XzrgpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxgGJHs2rtrVBq6PK+ommuAN101uxqhgAUpJ5kCqTpk=;
 b=bEUdTOUiwU8pm/rKLPKdwRFJkZFKWg9YrUkQ5A15XlR81gWu5aebYWZSNX06ippW0NpHmdWVXAjCHfEaG3iTqGp7vELrjeDK46oABqog1rokGQURvk5Y627rDvKSQMtN6FbR2enBY3H3rnM7AjNgtY1t4tbDUZmjkDMcuK+OkQw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB5782.namprd10.prod.outlook.com (2603:10b6:806:23f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 02:12:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 02:12:55 +0000
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     <martin.petersen@oracle.com>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <hare@suse.de>,
        <kbusch@kernel.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <oren@nvidia.com>,
        <oevron@nvidia.com>, <israelr@nvidia.com>
Subject: Re: [PATCH v2 2/2] nvme-multipath: fix path failover for integrity ns
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1jzy0lnyl.fsf@ca-mkp.ca.oracle.com>
References: <20230424225442.18916-1-mgurtovoy@nvidia.com>
        <20230424225442.18916-3-mgurtovoy@nvidia.com>
Date:   Mon, 24 Apr 2023 22:12:52 -0400
In-Reply-To: <20230424225442.18916-3-mgurtovoy@nvidia.com> (Max Gurtovoy's
        message of "Tue, 25 Apr 2023 01:54:42 +0300")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:5:54::37) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: f57c0444-8105-45e6-a2d5-08db453294d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DWjp4oS6YJKJMN2lW+piW8yFfvMo4jBgkLBDgKMhoLoH18HTrjHZLVE/m2/wqwVW5kJbZG8SBF/5SRnD8IOhbtjSM+htdZbcoXMieEHErWBQR7Vr7htDE+THECYTzaLuEeJqdDX3k5HxpQugvM3VdsaxKF15cg2HtZBiXz8D1zOt95N/0/5XGqxFpqEXlcqHK+2UXrq8Fa95EvjXfI7IPIyXmWJKbK8SJo9VmhT7PwYNIZFPElI9kiMcVEb7Ku5/JFvuq1v10KqLg1GCmzCtWK3ypADDDSVBuS2r2vLGfNqyelwpdXYQQxVkkH43Ta784QvRRzmpO99yD1XgQ/Jv542IEjPgaHsSFT7i96yzAEiF+oBEO8mqsxeFtzgm5YflqxmeKq9/3rWkOWxnezsbvVWv9iK37E0sJVnayEENwT6btMJb5lg8YVdB16QqpJmt1PzANUcV1BaLFyYICWJ01MaloQcSlnFy05tIypJbjm3ffnl2t2pMSSQQQggcCH0JIfAuhLFxrTQCEhQ/+74G544Tgh6VrGHYy1okpIvRorJ3TUA8QALLFn3ZoJARBHh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199021)(8676002)(8936002)(5660300002)(6486002)(6666004)(36916002)(38100700002)(4326008)(66476007)(66556008)(66946007)(316002)(478600001)(54906003)(41300700001)(26005)(6512007)(6506007)(2906002)(4744005)(186003)(86362001)(83380400001)(7416002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ilAdC5fOhQO/Nl7ULPca12wGMYncb/ElJ/Ir0BlvI4w8Pn5QnlB3Q6nm7gMD?=
 =?us-ascii?Q?DTuji1wwsYjzlBmM43jEzAu3MYIvfXGY2BoqmLl69waparMO+O2PeGWPiqFd?=
 =?us-ascii?Q?w+NRxykg1gIus7+idS9YOE8kNgx0N9KVHp58Ze0ohRaD2jWa+SNFTdONY+UF?=
 =?us-ascii?Q?l7hbHpWvzGybbL1kYoywxSsXeW0duU27uN9DaBMb7ZdB7pP6JhFzZzbGon/V?=
 =?us-ascii?Q?F1ZSGbW4mq5+2+0GTQe6X66ftgzV2nVsmD5AWA8L0Xs21chO7w+UAJxD7+iD?=
 =?us-ascii?Q?2Jr1EwMCFoI+4c+rUIxQSjZ5AlDRNlQlW66jOIQPvpZWPX5V6CLD2So8Ns2Z?=
 =?us-ascii?Q?nWM+JVIFlBPQT6cVG3/vgcQRLXKFLTWQv2ZofBuidousd0mrCPISAoCGe2Sc?=
 =?us-ascii?Q?sGagujDccn0Fb4v1MIeUuwObi1IIMPcpmFECX10lY/NmFLjMje5KCfMrnZXm?=
 =?us-ascii?Q?63llW1odtHgv0vazk21qWGJ5PDNd3P+L6en+bzohGL3I+v3szjL+q6l//O+C?=
 =?us-ascii?Q?+ZRrfK9tfJot/q4cYL7h+z0t3qUb7HdHU5Wx8S9arsHQxMwaChKZw+/+DfCH?=
 =?us-ascii?Q?3LVGbW4oaz+O37+BP/AByVzU09z2brW/pactEkE/sFci+fu93Ow7ZqAX2lL8?=
 =?us-ascii?Q?DQo5AwheKB1LL91tFMY4JcPWaKmjsKSngv1K6LXnUosa5tmw84Z9JRbxBDP5?=
 =?us-ascii?Q?iUixRb1tG0yYBjdW6zZU9vHt7dPDeTpriCXfKqHSbMulaR/wsfGhZc9Srh95?=
 =?us-ascii?Q?gaCUtRLkh8eg1GF/VR2sISsx7XFkSxOT9k2pgv5S+tsJRDaAFIcjWK3fxBsR?=
 =?us-ascii?Q?lmpkNUNkiXf6+xgYb3/gJrLVBx7kx/wzZL81KDKx9skq4M3A9mPDxKqQDeZf?=
 =?us-ascii?Q?h/IrkgJZhjH3S31hgSDFIbN0R8hwa7tCCX16fY9Fq0QkiwSrUl0fEf3vG2rI?=
 =?us-ascii?Q?61/yanLb8PenyzQMSPFXfy2PrUXwRhqii5nzp9ku5Pjn6HGx0qDe3EmzPJlO?=
 =?us-ascii?Q?bTnSfB/+/VNgoJq+On4NRE3FZnK/CWbg9BWHR5VSX5MIlnKX+RfZbptWmh5T?=
 =?us-ascii?Q?hNijWuMI/0+gKvaujeYtnzKNAFinHTQ0JoZmkNdzq8HiW68G/Ki4k0U0a0KO?=
 =?us-ascii?Q?Fczb/SXzrJ8ej+514TIqbS9i4/R9oxLHD5GetLbdyzkG8bhZAMvH2/bcLOkH?=
 =?us-ascii?Q?e55u9YyRfahkgvmmjjwlm1hqXutjfuLkbSk0NV8+zlJw3pApKaF8sZ4wsymX?=
 =?us-ascii?Q?pv2ayk7VzQpWUpgk1q9ta8lw7gOqkIo/gnymdFK22wV3/7tQYpecVYaEegTo?=
 =?us-ascii?Q?PGj6A6YLp6aHm8Xw/n8abCetp4SMCfIBGBfiLpSFITWpi2EpUillikcQQk/x?=
 =?us-ascii?Q?X+ER/Ch7UR9AAojRrVjB3mwQg9gKbIfYoEZa5lFw9ZwbxXHEx5QrGcArCIBE?=
 =?us-ascii?Q?SvxrBLKv5q+n1lGXTJnMAzq/RVfXfDWasYYlUhjZDPMkA8i02fraepEnNW5f?=
 =?us-ascii?Q?d/35VQMAlrY/kIABjXwgfT2NDC9WzQwo1VwgCMAiJoqVWgmmCqm3TwqdbnGP?=
 =?us-ascii?Q?FUnsJcP/jEyh7xb17TAMxnl5lvvA9COm6j5CwX9zHC3qnQL6VhxhjOChmneH?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/MxcWAkP+nuC7wWv3U+NQkNUJZ1E0nyTpwL5IIWvw0fiDYqbYDsHBBETCuUf?=
 =?us-ascii?Q?viXocyooKeBjIxakp3UyclGP53ViLsCfcysr5tSXuyUg4d+OZrCdY/Is1L03?=
 =?us-ascii?Q?YKzmTv8EE52eROxq7KE+t7rCKP+bkI+ctl0KJWsTjRyri5uEPO38+b0BXjas?=
 =?us-ascii?Q?mt1HxBE2gBgHhw+Xs2IGfgW9aUfAEIv9TEWOPIG52dYsAzkD1/igS91A4cPm?=
 =?us-ascii?Q?UP7ew4k+IfMrNU4CTT/IRzQg9w3OGxV57m0d4icswoduml8e/K5R/lQFoU1N?=
 =?us-ascii?Q?3eJKfbxworFbfkALHkZvYTAf7vZSRBJJT3qa9XVn7xGbslRjEmA51ZoyuYkz?=
 =?us-ascii?Q?exwpVS79r4IMlgmECIcgin3jc8PiQd5+OR75DMF3toh4meYJgpHhs3hSa9T5?=
 =?us-ascii?Q?XliYMefp17Opc6zzhLLVK2uPbIRsyT2XOhXHA/mEpJ+w3lkzC8e86yyt4miD?=
 =?us-ascii?Q?zoRiOK3Xytn9czjOMm7HoedSCKCLkSEcl4obxwW0JEEmeSgI4nEt3KBWtY9K?=
 =?us-ascii?Q?RC17nJ1CeVf60H/4cQCYmU12JjBNDFe8bNFZVrh8bv9/fyzZJBlBc+AgSHZ1?=
 =?us-ascii?Q?4VUoSL5hkfR7OPmO0uRtZAhyYK0Nrh1WgBfOg4GJ7UZ/jIAJMiYuudC8KZ2b?=
 =?us-ascii?Q?ec0l7Nj//00xfapKuLKlNL8s/rwZ4Dezvcy3M3v0eRqlIUh0Wa2+M5Gbeu9D?=
 =?us-ascii?Q?w9eiw4sIlBOOsfln/n6zZMWLp4ZmTkcXrnXYr6rdj7fJaqpnqXyKKi/1ERYd?=
 =?us-ascii?Q?77kyCFS95OFiRTSuZRo/nbff7rG8d5BQD9y00Q2fJXEtSK1q/6aQwZ1buQQH?=
 =?us-ascii?Q?+6QWsiYgTACm6WeHbYSOYAKJEoMYFWUwwTkdT5NSeueQQYrzeRSR3fMeovio?=
 =?us-ascii?Q?RI84j+oMfNLAmxEICgt4LEU3Tk9+reAmTL2PPnpt4/Eo1hpb9EmQjl+eC1RS?=
 =?us-ascii?Q?Oy+Lg6iM/6XE5T13pbAFZ3fxpXcJyYWVSBb3NHGftZE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57c0444-8105-45e6-a2d5-08db453294d7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 02:12:55.2095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ef2IfMOQQEa0zhvwM2pKV+IYsnmnw2WeG52OsOLRt9QzkuFCUqW3E1UbgIVErbl4WgGNhxwvjVPEi3rqOFN4kAOggNMcVRqffZ9ffWPrCAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_01,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=542 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250018
X-Proofpoint-GUID: QlVlDpSso_3x0sqVKKY0TSIDJFkrQyMU
X-Proofpoint-ORIG-GUID: QlVlDpSso_3x0sqVKKY0TSIDJFkrQyMU
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Max!

> In case the integrity capabilities of the failed path and the failover
> path don't match, we may run into NULL dereference. Free the integrity
> context during the path failover and let the block layer prepare it
> again if needed during bio_submit.

This assumes that the protection information is just an ephemeral
checksum. However, that is not always the case. The application may
store values in the application or storage tags which must be returned
on a subsequent read.

In addition, in some overseas markets (financial, government), PI is a
regulatory requirement. It would be really bad for us to expose a device
claiming PI support and then it turns out the protection isn't actually
always active.

DM multipathing doesn't allow mismatched integrity profiles. I don't
think NVMe should either.

-- 
Martin K. Petersen	Oracle Linux Engineering
