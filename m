Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAADEB64D7
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 13:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjF1NLZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 09:11:25 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:3297
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231218AbjF1NLU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 09:11:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwgerG2/83u3Bjtd1pP3Li5UVFLHISZhlP4UEByHbKhGNsFceX1Zi78MHv2+jkakYu43M+NkZbi0II94cq601MAG/tULo1+mpOBf1eMNjTuB8ggSIYIVBDUm52VP0qvTiOqSkSlAkW2aV1loqUtTd1b10GwWbTNk426dSApB1ZvmoCvSvCdmujHim9RSyg0DCeG2ONms7k+Uvg4jdYKOaznTe1pSvF6xlN1osCgbZoehqkMNjIJxDoSgzTDddwp4/GU0f9SGYYCe6XNAT/c61Z3zo3mr5ArJmAUtZKoi5SVm6JWT4qRjfNLL3CKwbQjYytAaUIrum06+PktabRap2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTHnKbRODYsuLSjGTJV0nDoOEzG5zQQDSY6r/xHAbyo=;
 b=AZo216mi+p5PegLhak4CWlIhYS+kYbSQaqCfQCYLoFObBNd3EDsQ8ugoX5xtWaKlP8UPTga6EJBfQRQO7Hho05tSol9cIU40LY0mZkUgLt1LYQnkIiXPpbB/NgNsiK/QUR5B+TMf63cECZpR7nqDURZ3cPRbb8jMGaGybZX/BeeGHhG87lRHPmeabrCXJjOSkRqhUDER46FqusvIhGDDtxBPFxrlNc6Y8UsSxAQOaPNvIJgM6k5D5rOOXWlmngoKR308o/TOb04pncA5cStWJOVZGDpCYGrT6dENzzXkuBDBW61c5Q5vBbcZ5l1E88YXEt9OXTz3k6ggLk/CFy0nUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTHnKbRODYsuLSjGTJV0nDoOEzG5zQQDSY6r/xHAbyo=;
 b=rjLdND7QCvFa2+R59cY8Xcs+TIdiKfnNsarPb8fLALf/rJSPkONtsFZLW36YYAVGFn2nai0CsNgOhDK72cauP+v3FEmM2oaX6wiThdjLnq+tmbF6l2V/SYDv1s3ZqFT5GNk9P9T50SsO/GuPNklU7h8D/5peq13+pkol2J2tMAOM/VKBiC52eyHGpYEsuIFOtdXS+MiwF912ptBUraI5sYHYtnutiV6bLiSnT6and134VTB8o40igb1x0ybQIDcURkRHKZGXW9Y1L9LpEtlOp45Ikqb3Yb7QcrJmQEaI+mUnSLeZBNpWNEvNTtecFI2Ia6r+azIyt1wfdr1VolUxpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 13:11:18 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 13:11:18 +0000
Message-ID: <4ef35cbb-2ea2-e5c6-98e4-f6e293be695a@nvidia.com>
Date:   Wed, 28 Jun 2023 16:11:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests] nvme/rc: specify hostnqn to hostid to nvme
 discover and connect
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20230628124343.2900339-1-shinichiro.kawasaki@wdc.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230628124343.2900339-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::13) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SN7PR12MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 635ca67e-e589-4bd2-da28-08db77d928b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nsd3HNsZeGPgATmhuXD+F9a12bZdaW7A1h+I1H/s6q8upfUc5c9ZX+NjUZeSXja939RaRAoBc6wJ3+DzYChp/ZrU1wWa/snrR7XXXQxvPenUhnOmHwmncbUFYPJRouvwS1h2rXZGx3E9rdlm2NVsVgEo0ojr5r27LybTfAsuscjR+NsewtcjUMcZqsrJi7/IaaCIGCxiXhZEzdyh404FTyZpDwZ/dzgS/5SEXdBnsxLNm044HotNWsjt1E2dRSn5AK34xxUATdhlaBgZiEkLXWN7RIzmwL+txU9k+rTcB7OVSdXOAJZCbGn8oTX2XF1Y8aS1YLBxaJCcDfSf2I26l6tqrqQ1VCQgNXjmbSfZmF0oHxx6CbY4VouHbVVzFgtmuF6OxMwkotITwi+RFoWd7jFu3i0MaoDtVrb3C+QB17OGKsF5T57e3APZ5IOLNF0WtHl0+lMQjKwduRDCzX9JIjudKPB8paT22eyn3cKf3Hrd/3kfkHKU6tOQ3Aeq0f6JJcxR/KZZagsKm9YKgsFQK5B4Q2g1RvNoHO3NkuQHca4yMgHFhk923zyYT007Js102YcwtakNwb6yK/FZbuTdf3hjxRSMXRA23XxQVhNflsU4jcDzvSPbZki2NMsN1AmrKorSSrJSu/nA+AgJu8OlQrNtYtcenkV7u+uBbPXS2IUcqJ4uZQTbJdEiBl2/EPnV0WwbW0ifj2iGPK5zwIOjHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(6506007)(5660300002)(31686004)(66556008)(316002)(66946007)(36756003)(478600001)(4326008)(66476007)(8676002)(8936002)(86362001)(2906002)(6512007)(26005)(966005)(54906003)(31696002)(41300700001)(6666004)(6486002)(186003)(107886003)(38100700002)(53546011)(2616005)(83380400001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVVSc3dhbWkyazQrYUlQc1NROXNtcnEyMzFMUjdqSGlKaXBucGRWbU42ME1Q?=
 =?utf-8?B?QmpWekp5M3lFalJpOWpPZ3V5cEJPT1RVaHlKWC9SSEFldVZjNkk0TWtlQlhH?=
 =?utf-8?B?bDFaVTVvWWI4bXFZT0x1dlRPd3d3d0dRUlVLZnZvYi9XYnJxVnY2dnFiUE9C?=
 =?utf-8?B?djhBZ3dVWHV0cGxsOStycTNtNW1xSGVlVmxWbU1UeDdiVHh4bTIvclZMOVpZ?=
 =?utf-8?B?YllXbkJDRExpWDNqbFVFU1lQaENJbTkyc0g4WEw4RThqNHZ6WUlqUTlHcWJw?=
 =?utf-8?B?amtERUhnVUk2ekZFRG5WWStZeHBhaEhseEdNbGdkeTI4VldQYWdoSlVTQmg0?=
 =?utf-8?B?Ulh1elVHSUpQclI1YUo5cVlwcmhpcmFnSlBmRkxFQVpkZDZyYWJzQzNISkN1?=
 =?utf-8?B?V3J5dlJSWjJ2TEo4QzNGMUVaUGxqa0lwSUYyY3NNN3VmYzRFQkk5eXNEbURa?=
 =?utf-8?B?WnVuOHpreExNU0JRM245RVZqcmhlRFhuME9HL3JkSCtxUXVYeS8zRDFqUVdI?=
 =?utf-8?B?WldmLzRrMk8vU3ExZEpIcmpURHRwZklrK3lQakJYMUdjcXVENVNjZEJJR1da?=
 =?utf-8?B?bjg5TUJzeGQzdnhtOURJNFJ0c3R4R29NR2J3aXB1SU5rQllBcnVndDFjY2g3?=
 =?utf-8?B?N0w5aklsZUFJSi96RmxmOWxEcnNUdUVhdWlySkNIa0tCK2hBcXBtNjRzZnlt?=
 =?utf-8?B?TTdqSjJiOHI4a09xZWkzSTd6cjhsRUZFNUd2N2ZRWXhCZGorUmExbWFMZXpo?=
 =?utf-8?B?YUw0UlYwQlhKNGZoczJJSU44UDBrdkJvMjJPQUVlNTMwaFhySXM5bjBoREp6?=
 =?utf-8?B?OVI0NWlTeVZuOGNIYXBIUVgxQXFkaWFZc2pUTGFlZjFpVDNvOWhBT01FNkNM?=
 =?utf-8?B?d3pOc0JGdEdjU3FSUmRBaDdKTjZtb0d2QmNPcjl4dTlYdlQ4TzNXNEJNWDQy?=
 =?utf-8?B?SnpxZ1ZSWC9oWCtsUDBOblF4cEpqVE8xbFI3cDlrejdjN3RFcDlCNndKQnVt?=
 =?utf-8?B?TzB5M3lTdVlabVRCL0RwNktoRTdueTdSNU5icU9LL3JoSFRMb2NoTkxoYXRT?=
 =?utf-8?B?WEtkOW8xSE9CZnlRVDFHbFFqamRlb29NdEtkdnR2WElnSHhuNm0vbU54eVZ5?=
 =?utf-8?B?bEZqQjVCSUpWL1liTmVCeEM1TDRrdEN0b3h3OHhNakp5TDVjN1RTQW1VV3Nw?=
 =?utf-8?B?VU0wdGw5SVduRWlYSGFiVmpKTy9iWmR3TlhuQ1ZmQmMvSkI0WDlyWE5tYnRR?=
 =?utf-8?B?cTc3MTN6N25IbW1oRTY5b05lS1Fma1JWVWpLNllnOG9oaUsybGo3RFMrZWFB?=
 =?utf-8?B?Y2RKWWpjTHYxRmlQRlAwUHJRYkc5SnFhU2M5L3RtWVFrWm1GS3lmQjZGY0M0?=
 =?utf-8?B?aWdLSm1SMmg2Q2pmYk5ONG9rOU5QRE5wZ0tGeUZITGc5ekd2Qk5KcXN6ek5l?=
 =?utf-8?B?WVVYV25XMkEza0tCWGdxOUQ5amorYjVLeEdMQS8xajBZUjFReHYvY1JhZnVT?=
 =?utf-8?B?T25zTndMQStRb3VRTzRJN1F6WmpnekxybVF1dk9ISnJ0MUVja1V6cnorTW1H?=
 =?utf-8?B?QnQvQW5oSk9IUHBHc0VSdWZWS0pYV200bzNOTDg3Nm1FVnZLYW5PdjNrak54?=
 =?utf-8?B?TitscFhRekpKa0RWZjlTb2VFdTkwUDdCSGEyN0xlbGUwcFVYZEczYjVLRWRi?=
 =?utf-8?B?T0JRQ0F4UHord2xXc0VWUG5ydVRDejJ2dExmT1N2T3FYb0ZlZFByNnN2c2VZ?=
 =?utf-8?B?UDgzakkwMDZaK2wrNlZlZS9EV3h6STFkanBwcDc0YUgzblRXb1lseW1FL3lu?=
 =?utf-8?B?Zkliam1HaDVYU2R3MzE0R0tmTkRmdFZvUktzSVAxaEExWVFpZi81cFZjMThK?=
 =?utf-8?B?U2pVTjVJa0xFZU9qWjNQbnd3TmZZMi9yTkVMSjh3RXF6VWZrMmIrTGd1eW50?=
 =?utf-8?B?NGhNVGpBdkZsTGNzb1JjRURzT2UyT0JlQmVId1hKeG5ZZEJrUHJvRUZuWUZm?=
 =?utf-8?B?M3dJWU5vQmxQUXJ5c1JRUHNIZ3k0VU5SUHBMVlFjbzJFTnArWDdJb2F0SWlY?=
 =?utf-8?B?Q0ZzRFdsdUJDSHNETkovQXlSQWxJY0pyWU9INFhYSVovOHlYbnI4SVpQRjhT?=
 =?utf-8?B?aXptakhtOE9Vc2szTk8waHA5bTh5YkNWU1plMllscmliQkV5RVdDUVlmVFo0?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635ca67e-e589-4bd2-da28-08db77d928b4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 13:11:17.9885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CX791B5xK8dmeTqSzF0/RilQ+uArgxS7+fkyOVRFvCMnB9B6x4K+lRVEu3IZFn2yJLFUCLgnJ22y4i0Kg9gutA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Shin'ichiro,

On 28/06/2023 15:43, Shin'ichiro Kawasaki wrote:
> From: Max Gurtovoy <mgurtovoy@nvidia.com>

please set yourself as the author. You deserve the credit :)

> 
> After the kernel commit ae8bd606e09b ("nvme-fabrics: prevent overriding
> of existing host"), 'nvme discover' and 'nvme connect' commands fail

"... 'nvme discover' and 'nvme connect' commands will fail in case 
hostid and hostnqn don't maintain 1:1 mapping in the system. This caused 
..."

> when pair of hostid and hostnqn is not provide. This caused failure of
> many test cases in the nvme group with kernel messages "nvme_fabrics:
> found same hostid XXX but different hostnqn YYY".
> 
> To avoid the failure, specify valid hostnqn and hostid to the nvme
> commands always. Prepare def_hostnqn and def_hostid even when
> /etc/nvme/hostnqn or /etc/nvme/hostid is not available. Using these
> values, add --hostnqn and --hostid options to the nvme commands in
> _nvme_discover() and _nvme_connect_subsys().
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>

Yi,
can we get your Tested-by here please ?

> Link: https://lore.kernel.org/linux-nvme/CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com/
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   tests/nvme/rc | 29 +++++++++++++++++++++--------
>   1 file changed, 21 insertions(+), 8 deletions(-)
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
