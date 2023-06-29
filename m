Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFEEEB64D9
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 12:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjF2MSn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 08:18:43 -0400
Received: from mail-dm6nam12on2075.outbound.protection.outlook.com ([40.107.243.75]:3808
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231874AbjF2MSf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 08:18:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4tDZXO2fx9V/4yen0gflc2h4wWsi69X+cQ6mN9WWFdNWioaRvXiL9tlbQ9p1+UXBjOD5a+dyfz4+F5I6oxBNApF+Hmiv4iF9jkXjwBWhzF3xHlKmCqyy2b/FBD/N0WSCJj/FJWrROqXaFkCFGkAFiyZtTyYtI0nWweJyjGw4FS32qdpOYb13bIwXlZGZ+MagEwzCcIGFIvozqJDA7RgGu+dHDiCkkCzPsSSfhqxVCvgJ7J931Hzsk732a4v+hODIQYKbV/VkuksEEu6zR2uiIAdcvqD1w+fMYEiPuBuQfh/9qWuZZwp9qmYvr+CEOn0krySXNqclhXTYocXVXxPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsXwAKY2K4HUsz3rBODNhZ2B8BGrbl78z4c39R01pXU=;
 b=glivWIkMQKwVsDeaTaSXHkVwigoCEqsM3dQuSMkVI37jXqnt17IJVEWi2OcmQXwMu9rx1DB4nTppYHrHEXf3taZOgZeHKavDk3uk5zj/04WpagAmlVP28e0pm8ioCif6oWw3XUe1QMATIShg8PasQOyA+Gs0AcdCDgieWgjBjq48wNIwOpdHT2fmmoOTsVl7QelsS+TnsHlCntmw2ObWNiL1FqW4SxBBcxhLkqYfXOsPdho9L/shzoshn6pE+IWts28UgBtYU3+z4vkDxLLtPoXvpgiIi4OwpTFFkUR8ApKTELXoR+2Wg0kMzt/6gNikgQOo8yNWTlgk46Z1Z+2naw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsXwAKY2K4HUsz3rBODNhZ2B8BGrbl78z4c39R01pXU=;
 b=dacqfRDPoh7JlCvNxfStkKLHuZYeachvU5C79f6teCxc1ByFslWK9kvoOWmWGhKl5mgjcFKC35UW+z81M0ydWWDJurfBjQiIWo5R5l/OENXTXkgtpMll1j3f8MBwYVClYOns30BGoV4qd+wZ/MEMbPnFIo8DXJ85xEK6Ti9SA7oOvAZIEkVeq3ozmfNOC3mnc+8VsHDE64Evo/kDrHPNJXjPzyruZV6GF8uyeFzr/9Tu5ajprRrfwPsillSHUzdG+JTcwDfW6SQdAgbTptFU+ZEEe7msKJ83pzM92XJZQNGxptOKb2khEwrE7FDra+Otb2h8sXnniZeideiGwQMHzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 12:18:33 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 12:18:33 +0000
Message-ID: <f2dbfd74-32ec-6a4a-bec3-2007b3588154@nvidia.com>
Date:   Thu, 29 Jun 2023 15:18:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
References: <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
 <83ef44fb-fcef-4b61-9de1-bc24e3c0f4d2@nvidia.com>
 <000e3d0c-0022-c199-1f8d-97e191345197@grimberg.me>
 <d5d9bd87-1d5b-d66c-39c4-e35c0e5ddc48@nvidia.com>
 <94785130-4f40-aa29-9232-af8a8f1ca1c9@nvidia.com>
 <7d6m3ha3rqc73q22d4bsxtc4u2cqb4ryp6f4q7ajvazdpek2ko@nh6a6biyryxd>
 <0ad16fbf-6835-50ac-443b-46443c8656e8@nvidia.com>
 <yqwto3tm4wjgowmavc3unucq47hf5xeeqsp5baqggtzo75nmu2@4o5pbethrqcw>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <yqwto3tm4wjgowmavc3unucq47hf5xeeqsp5baqggtzo75nmu2@4o5pbethrqcw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::14) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 157ed7b3-0ef0-4332-52d7-08db789af511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lz8fPeUO83V5pzaFOUnJ0hcojG24t8pymahqWRSeJWcfePxsZ0rpE5LxCE09gvX6alEXyS0Kg6hGx+x9euxemC32Q21hpCQnkRJW/hyo5S3YbMlNAyQLJ8a8np9ISwPWFCec3CIeCGSLYzJFclqnR52GTUkDUjxg/7AdpzchbRBnwnkMDWLwANheyzeHPZ/YbNb0lX66sMq1s20nzSYAayfuXWu/M9buOgE4MBib8eXd2sG9H73+RT+PSC1xBsz8kRCrH1IMc0BfMTo2J2nDoc4Avx5OhSjNMszkvaHUU+czZ7vgY+g7aP2aGzwV7qsgiOjDVkmEqIlXb3Z76eKt1uKbPjY9Xop9p5NXstAsCn9SLokSLAE4jcZ9T+k7siyanYn//Cars2K/6bh/MvoSGf9qzc3y81AuW5ipEhak2qrR9+ByFoAnBjI6KAonMuGGMd3qzvvE2SdXZfjcBg1Iw3NDknoIEtWWe0ffny287dvvx98P4BYNhLvuFTD/yYXyCoq3I4M7PN4gWPeP4nHNYTwPGzQj2pWg2UpcTl0TcG04Rm4qcT+rhAYq2Kk2Cb7retuVP1KQyNB4ek13DXlt9XITrssK0LZ1lmOrVCEnrygtyk8AoSzjUeuu9jDXWEFj+nXscQkw7NStwkLj8QdgpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(6666004)(53546011)(6486002)(38100700002)(2616005)(26005)(6506007)(6512007)(186003)(41300700001)(31696002)(86362001)(54906003)(2906002)(4326008)(478600001)(66946007)(316002)(6916009)(66556008)(66476007)(36756003)(8936002)(31686004)(5660300002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3krL3pMNmhWWjRDYVFXb0VOYzMvclhQVkFkblJTeUVsRm1rUUJRT2d0dnRt?=
 =?utf-8?B?UzAwTWg1b0VsRm9YQ3VuNktQRmxNR001VzNKVzdNanpNOExGZUV0WDIwUVFK?=
 =?utf-8?B?ZjNJb1RXYjlLaXBBYXl1NitvM05Hbzd3TmN3OU0xaG1lYk9uZitHcittQ2gx?=
 =?utf-8?B?YUxkQnBjUU9ha0JNeG5oY1ovclc2NlVLOVVhZVJxd2FVQlJNL1JpUkkxMXFs?=
 =?utf-8?B?N0pRdEdUWVJJNld2Sm1DUzBKZ2VhQUo0NEM5NkMwZ093N0R2a3BqSnpqUmY5?=
 =?utf-8?B?Ny93UFJpdHJlNVpVeTlndGRocmpwUTFQRVpuQVNyRFJKQ1BUSGd6b0swR3lX?=
 =?utf-8?B?ZGV5RTUvNG0wUkdrRkEvZlZRU3BHejBodUFrd0NPb0JWQUpKdlExU2FLR2Zm?=
 =?utf-8?B?OFV1cisxNmZ4cW1YbVdzNmdaWHFhR05reGtoMU9NMFRBUG9tQ3ZDSHI0aGd6?=
 =?utf-8?B?U1VkU2xpSXRveW5WQkwya3dJTHZuOTRCdGVWRHhlQ2pIS1RSRUlwYk5qR3hU?=
 =?utf-8?B?TmNuWi9pd0pneXFsN3QwSU40TUxRMEVCZjhlWlNOUmJsRitEMEpVZzIvSTJE?=
 =?utf-8?B?R0NPeEpwbVJVc1h2NTNCWW1XdWdyYUFZSmQ3REZnNCtiRTA5RlhjY3c0SlRM?=
 =?utf-8?B?MVVBTUFoeFZUb1I5c1lFQ2JpbnA3cWhDN08xU1doU2UzbjNqSzdVMEdvTG9E?=
 =?utf-8?B?czlKUE1OaU1LWmZVUThvU1lKWCt0TnREaWtWbDlrWmpGT2JZNnZaRlVzMm5D?=
 =?utf-8?B?cUF0U1QxejFVSkRWNUg5Y0JGUFFpV3pjVEN4UnRwRyt2V1J2U1V5RzNacm1T?=
 =?utf-8?B?aW1FaytrdUg3dEV5OVluNndWaVhMd2IzeCtqVThXT3M5T2lKeWR6cVNZbXJz?=
 =?utf-8?B?d29ueG15Rkd3SmRhQnd2ZXNpRVFIdkJHd09wZFJGQ0o2aDRCS2hFYzZKMzFt?=
 =?utf-8?B?WGcrR0pQT05RWkE5dzZKWWMyZGdBV0dqOVV0WE9xRlJVVGlnaFdXb0JkZkxa?=
 =?utf-8?B?eThQeUpGRElEejEydENCYml0SXY0aUJqcWxBL091NENpb08xNkVjTHlZVUMr?=
 =?utf-8?B?b0FqR2FRMWlyTUt3Sm1VZXNHdllpdzViVTRQSTBELy9UU0RkSkQyWVVCRVpw?=
 =?utf-8?B?bmpxbWNhVENMbW1vblBtcjRqTmJVa2xObHdvQkxidlZyUDZGSDBzeVltN3g5?=
 =?utf-8?B?d29xNnplU2VmNXpuUm1ERW1nQ0l1WDY5WWdrTmxtSXB5Z1VGRWxkbDF4c0t3?=
 =?utf-8?B?a3FsZ2NNMi9LR0lreGMwUjlFT011L2tXajJwTzc2ZTI1UkhzcGg1djlWVWlq?=
 =?utf-8?B?MFRCdzlMUFFoTklSa3NnK1BVSHArUjhaeklhV0hkS0tjVkF0aU5VZjBXSlpm?=
 =?utf-8?B?d253NlQxakJqTnZzay9BQjBwZ09WYmJSZVYwV2EzQmZ6bXl3STRTaE9KMG9R?=
 =?utf-8?B?SzF3RXc5a3FIOW5KQm5ENm9PNS94d2lNY1RKZEJScm1mR1NJeVp2MkxOVEQz?=
 =?utf-8?B?TFZmQUhQckhobnEzVkluZXVhc3RsV0tpcnZNelA2K3VaNlU5MmVMcE83ZGo2?=
 =?utf-8?B?a0JIc21OVUVkaUZVeWd0Y0ZSemVQNHB3MUVPRkhrV1lrZit2NkJGRTcyRVo4?=
 =?utf-8?B?b2lNWTJLT0V6S3h2OGNyOW5CZWZKTUFDb3BIQlY0bE1BZ3J5bjRBNithMXZw?=
 =?utf-8?B?RDBqK0NnbGRtQVd5UHpnczFDSFJWWGdJSUlZNUFkaDdVQTRFZTlMZzV5ZkpX?=
 =?utf-8?B?dkE2Z3lsbDY2SHkxcVJtaFRzbVRad0N6N3lhdGpPd3RHL1ZHa0RaOWh5TWZj?=
 =?utf-8?B?QU4yWVRnbi9QWThoNVIwUkRNdGI5TUJ1R210TzNMSkJHNWs5MTgvQkVYWEhm?=
 =?utf-8?B?US9tRzMwZDFjRTdrN2NlMXJzcTZMTU5kYVg2Vm1QQnNmOWxscVJsdkhTa0ZP?=
 =?utf-8?B?UFdzM05lTU1OWTFTVlp4bU15T0ZnalozVEYzMW9HZDhLOVhkRWttdVhCT1Rm?=
 =?utf-8?B?UjVXRFJLaStMRTA4T0xTOGhKTFBhcWY2VWdGR2pZUkFtSERTU0I1TEh3YnpT?=
 =?utf-8?B?T08wblVNekk1WjJGNk9DWSs3U3ZnWHREc2pQTnRtTWI5aldSa2dXK3hQZTlH?=
 =?utf-8?Q?1ksCBi/Mpc1yGw8mVnWDZdNIu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157ed7b3-0ef0-4332-52d7-08db789af511
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 12:18:33.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhgY31ENEcaYVB74taxC7phLV0PSm/adK1IFnx04ev1BlEcXZGgjRIh5P/x6kp+fP0uk+30mIBM2ie0xeEKE2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 29/06/2023 10:36, Daniel Wagner wrote:
> On Wed, Jun 28, 2023 at 02:00:57PM +0300, Max Gurtovoy wrote:
>   > --- a/tests/nvme/rc
>>> +++ b/tests/nvme/rc
>>> @@ -14,8 +14,23 @@ def_remote_wwnn="0x10001100aa000001"
>>>    def_remote_wwpn="0x20001100aa000001"
>>>    def_local_wwnn="0x10001100aa000002"
>>>    def_local_wwpn="0x20001100aa000002"
>>> -def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
>>> -def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
>>> +
>>> +if [ -f "/etc/nvme/hostid" ]; then
>>> +	def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
>>> +else
>>> +	def_hostid="$(uuidgen)"
>>> +fi
>>> +if [ -z "$def_hostid" ] ; then
>>> +	def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
>>> +fi
>>> +
>>> +if [ -f "/etc/nvme/hostnqn" ]; then
>>> +	def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
>>> +fi
>>> +if [ -z "$def_hostnqn" ] ; then
>>> +	def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
>>> +fi
> 
> Is there a specific reason why we want to read the /etc/nvme/hostnqn file at
> all? Can't we just use a fixes hostid/hostnqn?

Yes, this will do the job but I guess the initial thought was to use the 
same hostnqn/hostid that one configured to the host also for testing.

I don't have a real preference between the two.
