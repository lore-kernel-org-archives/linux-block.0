Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2C2EB64DA
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 11:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjF1LB3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 07:01:29 -0400
Received: from mail-bn8nam04on2041.outbound.protection.outlook.com ([40.107.100.41]:5718
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231574AbjF1LBJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 07:01:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAYgd6gSBWlGaANioB0VCK5nDdPD/ERQd5egoHD4z4zh5jBplurYvbrDKJpJXhWp9Qrk2P0Kz2I8Qq1+N06aVXyJmj8nPMXUPMne89D/MDMmDreWx22ofyFJwdWU22THhu8GYyNOvGEf++UMisHFsiExGCJj3BbjOHwbjOcMPR+KaReybHX8xLa3TEXJkirFwzCOB/BGDPqS6AQLh3ehsVLYbBXrOJ/GT1rfePze+u/nubiYF+z1KRa5yugELpi1SymzgjSDReEAe79URO3iKLfepLyKUUOmiM/WgeJmlc22dimitpjZ4Nre8iuM8ZhiBQWmNuocl5JQQLKKOqDOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQa9iCiLe/BTJrXhZzHNwbm0sVgISblaJgqF/LVg008=;
 b=TCfjCpyYtlo1TqKcSVvtn2UH5rDZIM/FYQ5ECKUDY2iZq/V/nTc5moBxzuzxa/wmo8crRhIvhvcQVb+j+2pyQQVX/ei/wzBhEosiSAHvZXsrc/2hy3mJb2BkzroDaCd7r2H1nMF8aGe9h37iyF4zSq9AjAlD6OXBrJcDZaIoK3+l7ZkChyhCFMH1gWARLlQ6NFlm72fX50slAv8xbiZzSWll3wml1cgdaC1HfwLVuoAN2BexIsHJDcWUqDXDs/4pAjmNVqIoWl3v673BL6vx7IOtshgtaz1RzFmT55ZonFZpuucUF7E372SC9MkDJHvICWMnvnSc4Ktmk2KzwcwlWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQa9iCiLe/BTJrXhZzHNwbm0sVgISblaJgqF/LVg008=;
 b=XhI/Ud4JAja8+GDh2UkvGhB0F+VwkKfzkHpZRJFSwrddYhfi4/CVKV2QRkzWbXdh5joCba98I27HFmZccUg81FiIj4fJsPTZ89ewlydd8KEHYQtYb25aQ7nU3oRhiTr/JhS2inUr1x1RvtwmOD/cM74c2ui3wYesichcfsNl+j5g+3+YIDdX/gykn10NKkfLqIH8w1b+wCJoqobqVK93PiD2PtnzQ9mCs55qQ1Jds0Ud4HZrRR6Wfw7xr8odOhH+SMnRwV++EacDqe+jKWgNWRSR+UWOYyeajyfdFqcGAijSr6bfhWdsMJpguhYr64L90aZjf59as9sMyf5S4HClwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 11:01:04 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 11:01:04 +0000
Message-ID: <0ad16fbf-6835-50ac-443b-46443c8656e8@nvidia.com>
Date:   Wed, 28 Jun 2023 14:00:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
References: <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
 <83ef44fb-fcef-4b61-9de1-bc24e3c0f4d2@nvidia.com>
 <000e3d0c-0022-c199-1f8d-97e191345197@grimberg.me>
 <d5d9bd87-1d5b-d66c-39c4-e35c0e5ddc48@nvidia.com>
 <94785130-4f40-aa29-9232-af8a8f1ca1c9@nvidia.com>
 <7d6m3ha3rqc73q22d4bsxtc4u2cqb4ryp6f4q7ajvazdpek2ko@nh6a6biyryxd>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <7d6m3ha3rqc73q22d4bsxtc4u2cqb4ryp6f4q7ajvazdpek2ko@nh6a6biyryxd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::10) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 030cb99b-f834-4290-443e-08db77c6f753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLBUl8s/ebl8iheSwpDnLbk83DA/LKAC7lFA1zY1hc7iA03YGt+mHltpB4iArKxq8qyX7wuSKGqE7CL+2LVgT/3NxMEOFPnn8RQJ5GFfa5TGXHKEx3Jh1cSgI170eRRbMKG7lMULAbcL4NCULWeu0CutdLOC6Sa0bTMXjOQ+SnvOmHToQCc8oRsFEtGCR+Tcv9V3xMDaYQv1sAAz4RuKnFN7/Pel8il9F0H7JUTkFicjtBYTbsdHiRQqQ1PdYVPpDt6N55tZ7ob+xbRnyKimUgdjz6hYhrGXM/UG9CP1JnneBNIpyxQRamn7rmJ2OKbqh6AG+NvOcJKbKGMKOeEADEg+TubpuJC7wzhtIPqHYUCBWrN800E4yIBVZT5vQHDYEW2b/TKt+L8BmmwmR0KBVd1d1smytHKNMGSM5xxy1PznjLlWWYemog7ovTcQNZb+xUDIh9+nbvvalCqxMXrlymeWNEwWJdKxwAmyzoO6yI3xOcyK7lTwQCoX4oWAnCEPwo8nJCpP/R5igrfO4LwXGvLK6r1v6kzxzkgUmbho4KlMOZwG0KoPLCTlZNFwVMT7CCGJSAAb1c/+dYEH0Ht3Ne00P1VnfZKJ/5eY/vayKwMYg1139RPikeEpkikDNpCVYc7sOiYUNOJneyCP/yVEUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(8676002)(83380400001)(8936002)(316002)(66946007)(41300700001)(66556008)(53546011)(6512007)(6506007)(6916009)(4326008)(66476007)(186003)(26005)(2616005)(54906003)(6666004)(6486002)(2906002)(5660300002)(478600001)(38100700002)(31696002)(86362001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vi9BM09aemFwQVBYVDA5SUZ1aDhERmpjajZPdVN5dUtacEhreHhzU2ppMHND?=
 =?utf-8?B?UU1KV3hRdE5qeUxYRExUWDNobFhxNWpLY09FZWM1L244K0ZIaWZmd3ZleUJQ?=
 =?utf-8?B?NWptdG5jSDJXb2x4cHd5UWQ3bVUvV2k0RllHRjNjcEQ0cm9KMUI3TmhBOVJH?=
 =?utf-8?B?eGlLbE1DNDBZQ0Q1WDFIK0tkYVpRbmNnbjRRTlltaXA3NDFQRVJlREFGS3FP?=
 =?utf-8?B?enFrY3dZSkVLVjViRy9wOXNtSUFWdGhKT3N5WklNTXJyK1pmTlJiK3c4QmlV?=
 =?utf-8?B?bFc5OUJmZVh3cXdvay9KMW1RY21hdEZVdWNlTmdlOUl1YjRncFBmaURsbUcv?=
 =?utf-8?B?K1hQKzlVdFZjYnBrWXNzL2tXWFhHNnp5OEo3Q05pOG5CNFIxb3daRmlySW5H?=
 =?utf-8?B?Q3JlL0RHbk0wekNEbjMvOEhoM21mdlRJOVJvZzN2TlZnRkxDWE5YektYeTlQ?=
 =?utf-8?B?dE8rcGQzYnFWcFVPbVVFd085NjgxTUg0SFViUVJQQ0lLb3BKM1pIRFN3ZmVM?=
 =?utf-8?B?MVk1SXhPd0x4NU0ybEFUQndEZDJkVThRV3JDOE1JbFBVcEQwempuVHRQRUd6?=
 =?utf-8?B?RVRFTGx5TGhydUhKbmZEQWJPUkFRa3ZKQkEzbmJKMFhrT0p3NncwMWZtVlky?=
 =?utf-8?B?YkdYMFlzRVpFek9rU2VNenpLQVQvd2diZHNOYnE0S1UvaDFVZHBxRFdXaW1s?=
 =?utf-8?B?SVRURFE5c0JRbnVISFAvd1NwZnpoNUczNU94aHQvVnlxWllYVkcyRW54anJy?=
 =?utf-8?B?bVFuRnpvSmRWblFPMSsvYUdreE1wTVlTSGlNOStOM0JPYXFNdzlmS1M3QUJK?=
 =?utf-8?B?dFRlbng3bGJ3elIzc1ZKaVVHdFZHNXNBVHYwYzU1V0ZRVDFEYVk1Q1NmNEFS?=
 =?utf-8?B?TlJGREV5TFBzSWplWUs4akpXRVVTWTVSME1OdXE1dlBWNGcxZGIwSzFXU0ZG?=
 =?utf-8?B?dnBXNk1ka1FrU2tnU2pqQjBOVmhkaWdYdVhUZXdQRWU3VVpsU3p2aFJscXJL?=
 =?utf-8?B?bEZQK1ZsdnJOY3JnaHJ0dTFhTWo0YnhGcjQ5bTNmNktuOTdRUTJXelFkOU56?=
 =?utf-8?B?UjAyaEFHWHFtbGhvNnJtelFoWC9NaTVER05IZ0RiY3d0SEp0TTRBbEJJTDBw?=
 =?utf-8?B?MllMQWVqSklFbzJFNDM3VVBjNjMzTmU5NUN2c2w2UHh0SDVtSlIycGt1MU5a?=
 =?utf-8?B?RE9JUys2eFM5d1V3Z08rZkl0MUh2QVppWWJqcUVrWlZiUWhLL1U0cVF6OTVO?=
 =?utf-8?B?eDhQMTl5NGJaY2UxVE1YeWRIaS9tWUxtS1B6djJnSGVSSjdPN3Frc3JHU0lI?=
 =?utf-8?B?YTd0ZUFFSGdDRDRTU0ZDWlpseWNVOVhpcDNZRkxVaGE2S3B2VTZVeXlyODBi?=
 =?utf-8?B?K0M1UVBEMWdPUFlQeUZXdW5zRTNQZDFYM0JDWENHUzQzbjlYcXVxYTFtVnow?=
 =?utf-8?B?bm9JTTBBQWNTOGFSa0lqTUN3SkV0dXV6OTFyb2tyVTZYL0lpa1lzQkc2YTdI?=
 =?utf-8?B?QndMM1ZnK0JOL0l3Z2RmOHZ2dE5OZndQTU0vcVg1cE1jN242M3hndVdXMk5V?=
 =?utf-8?B?WE5OQlpFUWVuc0FJcmxPTEtHMTlka0ZWYjhGZW12UVl5ME1wZy9GMjU3d0VR?=
 =?utf-8?B?YktQRkdQazdFbjJCNjZYVE9WUDlGVmYwazBMMzVFTEdCZFFWTEl3T2tiUHlu?=
 =?utf-8?B?ZmdKcHJCMmpmUWRJMVhKb0xCSkNHZFAra3lmV2xCbTFoVmxXNDQ4MEpnemJV?=
 =?utf-8?B?S2JnL2RmdWo5NENhWk5nL2RSU3BKU2NHYndhUlZmbDBGNUtyY2kyVk04ZEt6?=
 =?utf-8?B?dnpEMUF5S2xhOXc2RFlVdjVreks3djEwd1h4NEpMRi9Iam5XMW5id0NRd3ow?=
 =?utf-8?B?bG5BSThtalJJaUZNZktNYWswc1B6YUtWNEcyZUFMV1FqaUdydFVXbjV1Y3py?=
 =?utf-8?B?dXZEbVpTUlRranlVWTh6Mnc4eGhOOUtuaXJjT2V2c1JCK3JaTkxDNDJtNmxD?=
 =?utf-8?B?elpnd201a3E1anNCYXg5cHRlK1JweDdEOHVNS2t4SDdhN3AwM2s4T3JEZVBV?=
 =?utf-8?B?cmVoRURtSFVuek92eFpOWS9QUHc2RWFhMEM4Zk9mNFZCcFYxWTVja2tXQmlL?=
 =?utf-8?B?STYxY1g4UXFaOHYyUVRXeUdNTi9FYzNJdUVTUjZBVlhBaC9BQm8xdUlzUG93?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030cb99b-f834-4290-443e-08db77c6f753
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 11:01:04.2110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TMN5mLXObR39D9f4ZE0A2HgilyANOQ9Vicid+qjAlB0qKi/nGLrCPCI7kVA2uUkSYRExPPnPIwuDlNFlZveUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 28/06/2023 13:34, Shinichiro Kawasaki wrote:
> On Jun 28, 2023 / 12:52, Max Gurtovoy wrote:
>> Hi Yi,
>>
>> On 28/06/2023 12:21, Max Gurtovoy wrote:
>>>
>>>
>>> On 28/06/2023 11:14, Sagi Grimberg wrote:
>>>>
>>>>>>
>>>>>>>> Yi,
>>>>>>>>
>>>>>>>> Do you have hostnqn and hostid files in your /etc/nvme directory?
>>>>>>>>
>>>>>>>
>>>>>>> No, only one discovery.conf there.
>>>>>>>
>>>>>>> # ls /etc/nvme/
>>>>>>> discovery.conf
>>>>>>
>>>>>> So the hostid is generated every time if it is not passed.
>>>>>> We should probably revert the patch and add it back when
>>>>>> blktests are passing.
>>>>>
>>>>> Seems like the patch is doing exactly what it should do - fix
>>>>> wrong behavior of users that override hostid.
>>>>> Can we fix the tests instead ?
>>>>
>>>> Right, I got confused between a provided host and the default host...
>>>>
>>>> I think we need to add check that /etc/nvme/[hostnqn,hostid] exist
>>>> in the test cases.
>>>
>>> Right.
>>> And if one of the files doesn't exist, generate the value.
>>>
>>> Should it go to tests/nvme/rc ?
>>
>> Can you please try adding the bellow un-tested code to blktests and re-run:
>>
>> [root@r-arch-stor03 blktests]# git diff
>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index 191f3e2..88e6fa1 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -14,8 +14,23 @@ def_remote_wwnn="0x10001100aa000001"
>>   def_remote_wwpn="0x20001100aa000001"
>>   def_local_wwnn="0x10001100aa000002"
>>   def_local_wwpn="0x20001100aa000002"
>> -def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
>> -def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
>> +
>> +if [ -f "/etc/nvme/hostid" ]; then
>> +       def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
>> +else
>> +       def_hostid="$(uuidgen)"
>> +fi
>> +if [ -z "$def_hostid" ] ; then
>> +       def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
>> +fi
>> +
>> +if [ -f "/etc/nvme/hostnqn" ]; then
>> +       def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
>> +fi
>> +if [ -z "$def_hostnqn" ] ; then
>> +       def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
>> +fi
>> +
>>   nvme_trtype=${nvme_trtype:-"loop"}
>>   nvme_img_size=${nvme_img_size:-"1G"}
>>   nvme_num_iter=${nvme_num_iter:-"1000"}
>>
> 
> I tried the patch above, and still see the errors. def_hostnqn and def_hostid
> were not passed to 'nvme discover' and 'nvme connect'. I added some more change
> as below patch and confirmed the nvme test group failures were avoided
> (nvme_trtype=loop).
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 191f3e2..1c2c2fa 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -14,8 +14,23 @@ def_remote_wwnn="0x10001100aa000001"
>   def_remote_wwpn="0x20001100aa000001"
>   def_local_wwnn="0x10001100aa000002"
>   def_local_wwpn="0x20001100aa000002"
> -def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
> -def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
> +
> +if [ -f "/etc/nvme/hostid" ]; then
> +	def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
> +else
> +	def_hostid="$(uuidgen)"
> +fi
> +if [ -z "$def_hostid" ] ; then
> +	def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
> +fi
> +
> +if [ -f "/etc/nvme/hostnqn" ]; then
> +	def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
> +fi
> +if [ -z "$def_hostnqn" ] ; then
> +	def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
> +fi
> +
>   nvme_trtype=${nvme_trtype:-"loop"}
>   nvme_img_size=${nvme_img_size:-"1G"}
>   nvme_num_iter=${nvme_num_iter:-"1000"}
> @@ -442,12 +457,8 @@ _nvme_connect_subsys() {
>   	elif [[ "${trtype}" != "loop" ]]; then
>   		ARGS+=(-a "${traddr}" -s "${trsvcid}")
>   	fi
> -	if [[ "${hostnqn}" != "$def_hostnqn" ]]; then
> -		ARGS+=(--hostnqn="${hostnqn}")
> -	fi
> -	if [[ "${hostid}" != "$def_hostid" ]]; then
> -		ARGS+=(--hostid="${hostid}")
> -	fi
> +	ARGS+=(--hostnqn="${hostnqn}")
> +	ARGS+=(--hostid="${hostid}")
>   	if [[ -n "${hostkey}" ]]; then
>   		ARGS+=(--dhchap-secret="${hostkey}")
>   	fi
> @@ -483,6 +494,8 @@ _nvme_discover() {
>   	local trsvcid="${3:-$def_trsvcid}"
>   
>   	ARGS=(-t "${trtype}")
> +	ARGS+=(--hostnqn="${def_hostnqn}")
> +	ARGS+=(--hostid="${def_hostid}")
>   	if [[ "${trtype}" = "fc" ]]; then
>   		ARGS+=(-a "${traddr}" -w "${host_traddr}")
>   	elif [[ "${trtype}" != "loop" ]]; then

Looks good.
can you please send a patch with the above ?
you can add my
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
