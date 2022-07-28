Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A485BC04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 16:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiG1Q01 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiG1Q00 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 12:26:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D78422C9
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 09:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFOz7S3vyMcDUNrFOD/UHPJrR/0nwnfKGRJ0wBXK4QZpWwPw3zdIpgp8fl/eddmK6/TkEz9oFXj0pD7O3xiB7oF3V9zcpAvEsEntvoZxCpy4eICPqDCIHh/EN6jHqSKW6qxK1bFOgiF/yrpAwLt2jrByXnJDusHCA2t4wqipW3w9SdcdLBB7D/Uuc0IaYTVzkE/zjtsXFnUMXx7E0ZxDvHJ8tZiq0S/LGEp/yU+4a4FkY8a9Y7ylJCcDeEXh08S2+5RsgbNAMQmm3H+pvknqpDtCG3/gsKFaifsz7gMpO5aHuajHbsAPwJBwZGUsZgZP5Z1I8u5KpWB7SCANkb+ySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVSqLm4HDOZ+Ix9ruGJUeSG/6UKAE3AeOuR4grTadhA=;
 b=FZw+gts2Op5rIwZ+WkfXmbzcAaTKT2MveWXeS3n9L1Lzp492mC5zxmSLxP1EhKtmzRSfR9PmLv2Ln+DrMlr8x12Ae5bZcXklBWROWHpmG8w3eGvRbo7E12kryUtDUeel0e+DylyXECHahtFr4pFaOcs1n7OK9kRBRNoy8yxC0iurJPo5NjMnQX+03qKFWBk2TUIl5w4aLJnCMD7A8WwTJKrp8e3MBkAhYtiDd61Dur9MIBLt9G7fGwkEy4N9AG6le7iqhxpA6iDvuEWnzcoyMxRMaCoS/BmFarEexMqlKc+uo0sAii97AyP84p+dwvJqe9NOEfXjiztTMEXmn2TCKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVSqLm4HDOZ+Ix9ruGJUeSG/6UKAE3AeOuR4grTadhA=;
 b=PNOZVSHS2zTZrVghonj7cDUN4HPWsCa5fkB3JjfzXlMmLz66XrngP022xFJZ3vBpS6mOj75z28yc8n5JwpOr04p2db21vg3IDwNJKbE++gLOHK2RZTJpQYOBjxJPjNfwfpXqIdOAEA649+kviZ8f2Fa7ERL4vyhqFSGVTTzjbMzohQQXKe+KN+S0m3vDTCvTjO50EqD13/U5+DlQ9S+v0ZiwFXOgu+gOampxAec0acQSnf30Z7+aYefXKiVq6okXsYOo8YzpyFxR63Y1TIB1u39w5GD/EzPATA3Yd7s4c6viSa3KbXfBMPWTGpJ3cptD6aA2MsWwNmd+Sg9VQ5zoWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 by BN6PR12MB1828.namprd12.prod.outlook.com (2603:10b6:404:108::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Thu, 28 Jul
 2022 16:26:23 +0000
Received: from MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::b02b:b6c1:6cd9:814d]) by MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::b02b:b6c1:6cd9:814d%3]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 16:26:23 +0000
Message-ID: <f4495be4-7ee8-9586-3159-c1180fd41bc9@nvidia.com>
Date:   Thu, 28 Jul 2022 19:26:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] block: Add support for setting inline encryption key
 per block device
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Nitzan Carmi <nitzanc@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <1658316391-13472-1-git-send-email-israelr@nvidia.com>
 <1658316391-13472-2-git-send-email-israelr@nvidia.com>
 <Yt84ihS95qsGWv1K@sol.localdomain>
From:   Israel Rukshin <israelr@nvidia.com>
In-Reply-To: <Yt84ihS95qsGWv1K@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::8) To MW3PR12MB4409.namprd12.prod.outlook.com
 (2603:10b6:303:2d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fd2ac0d-f425-486b-7833-08da70b5e8fe
X-MS-TrafficTypeDiagnostic: BN6PR12MB1828:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUg5+B0dUkixHlqwpdWbg9b5fbakw4/ecKLh8DjZ5pQ5n6oxFz9ghR6mxLrdKHdcPZpCddz3e4+2S9en4P19B1sixf+GGY5nLBwPqd+6/n+f5BIu5OJNRS9RRkDBKutKnLeOE8FCZ77+3DJefjaB+O5feo2Uef/sTEhIPljzd9mHJOWhLNX3juWK5qhkctPl7ljIg+/zEpw5JtWUZwOudJ3IdSWlIDNFrJdvL0UFvXb436GJy3e+MlMklOmqq6idRRflBxP6TGg2LH1Bk9J0d1DUGI5PBe6b4EgV4jGe2Y915MGAuKg0VWkU6uAxZ6dmYUOEFwqjylDLcxBkWpmSy4bm5eHd2foTZXBTv1TRb6UonAccMyaWugBTpF1BWdWsQPFCOEeJ5IRZWK+vfTWYqXeEhL/Eqch/UVdk9rmVDLwiyKBlU98FzGjUEty2nrdXJzhqRTMKYtrmZVGPjlz1EetHD/n/yFqV4GexR0zkpYQHg/X+goQd1xc6J5/j2pH2uuovzvt4uH2rjNUMitHZ6FH/NQUzWmWn9qDXji6ZTAitUvwAlyRvyEbsz+om+T7RlAI5RJzG49Dd+ufIw15JMEDeiR7SucAnkOQoFe/JfitpzcStUrYeY9W1G5VJMqru0FUbZmt+Hzg0UiSaD4F77CYVbzcBGr1YGJnbwSocDmbh1Pdhl6zLn2ktH+yRghaiAWyZu+MMlks7jHrhMVwp5gitM/emHHv5B2YctwM5h5rWZu66MF9Oj+Xkd52kcJH7YNW65c1iHKRqUbVv4yUqe+aHOYY3AqM6DZYHlm/QiM4XO4uwwikXh850E4XuusBwDaffD/9IXA9fn/Tw2Tmq+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4409.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(107886003)(6486002)(53546011)(2616005)(478600001)(6506007)(6512007)(26005)(41300700001)(38100700002)(186003)(83380400001)(2906002)(66476007)(5660300002)(66556008)(8936002)(4326008)(66946007)(8676002)(6666004)(36756003)(31686004)(6916009)(54906003)(86362001)(316002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDJSSU5PNEdtSk93K2UyY2lzbk1nb3BhMHBIcHlVaU9UMTZXS1d5TTJLck9m?=
 =?utf-8?B?REFWMTZ4TmQzdjZMZ1lmTG9ZV1QwdTRlMWkvQ1pIOEJKT2FOU2FmdHFFV2FO?=
 =?utf-8?B?bzNXMnZ5MVVGZ01vSWd2VUVWMThxczlRSTFoL2VSbVJOZjFESm5MTVFXRUZG?=
 =?utf-8?B?SnNjMlNJbFY1SzZYRTVJTFdEekltc2xWaEE2SXQ4bmllMzZLRmx2YVZRQnFL?=
 =?utf-8?B?bEIyMit2alZPaEJnWTFrVVBzb0VwZU5YTURzTXBtVVUrNTdkQkpWb1JQL2lN?=
 =?utf-8?B?U2l3VnhOZjJBcDlQdmM1emRLRm9yNzIwV001cGFCL2w5MG92bE1UVE1QQ3VD?=
 =?utf-8?B?dkpJTmZyNVlyWVJqaVprb3ZSM1YrQ0FhWUdydnpYQWZKMEk4S0JtZ1psMlhw?=
 =?utf-8?B?aVRrSHFYcnR1Um1pbXk2NmZ6Ni9PME1QQXpoVW8zMDRMbFFqTUtSLytPSjBT?=
 =?utf-8?B?V24xK1dUTFRoVjNXeUNUYjVzTlpTT3E4OGovVTJVMmllOERBbnN1TTBIdHpp?=
 =?utf-8?B?dUN3d3VuRGhqakZkUWkwVTlRU2w0elV2TUtONXRCcXJTbEZsV2FSQVhzdWx5?=
 =?utf-8?B?VXZyeW9xYlhtbVh4VEl0VUVkUkJuUHZrNjA4Y1NlMmNpelpMVVV3QUJPUGoy?=
 =?utf-8?B?N25jcStxbHBqRlpCcGU0amQzWDh6dzF1Nzlta0VLcjdFQWV2aTZLRldydUdi?=
 =?utf-8?B?SWhnQWx3Ui9GanBFR2FPZ1ZIYTd0ZkFzQUpuaHkwbFV3MWJDbFA1Q3VMeDB2?=
 =?utf-8?B?cW12NzZtQjJoVGI0L202b0pkQzhON3dGaHJmd1hGWCtOWDhtdFA4UHBWUENW?=
 =?utf-8?B?OWMwSmZGQjYxWkIxZG1GWUFCMjkyUlJRZm9UZWhUbUZqYWRJczA0ano0Z1RI?=
 =?utf-8?B?MUUrVmpsSm81MFgydU9ubTNrSjhveHJ1dEZIVnZrajR1OXVvc1BnWklFa1lR?=
 =?utf-8?B?ZTBaTjdUK3ZWK3pwbFlJK2lFRzVUUkRmTzJXaTBSOW5qZDJOaS9UUHRldnhl?=
 =?utf-8?B?dVpFZldtUmRuWURDYmtxZ3JjMmYvYTJ3VFZrcjNoTGVqYnJLNDBhSFAzdWN4?=
 =?utf-8?B?OVBPZHJacWpJSllEVGV2OGV2eGJ0dXg0MGZ2VUZ5VDdEbk1rWlJzOFNNYlV1?=
 =?utf-8?B?V0xFckNLcWVlWUFsQVZjUEJmNlNNbnNjSGQ1N1VCcUNHUEx5YUl6Y0c5Zm5I?=
 =?utf-8?B?NXZ2OWx5cUZwRVFUSmFpbUpDbk1YRkhyakd2Y2FIQy9hUys5RCticEZvbmJM?=
 =?utf-8?B?bXdUZkVza1F2U1NDYmZIejhTZ2J5U1RDL0xkZHEzYXRkQW1TSkFMZks1dGd6?=
 =?utf-8?B?aUFJOUtMSS93RDlKZE9ZZXFKVUJra1p3RUh4anVKM21qR0lOSEpwNSs3U3JJ?=
 =?utf-8?B?TVEvc0hERnJSTHVwRWZqak5ab2ZGeEE4WCsxRG9EZ1M5SCtmZzBDdW93SXlM?=
 =?utf-8?B?dU4zVmZQWlc2UHh4SW5Yd2dIenhJWWpJNVNTSll2MXFRZzgzTGtaNmp4QXZ1?=
 =?utf-8?B?L1JUV1dyaW5WQ2FlakEvcXRudWxnMFBWNHpWTlp5cGo2MXVybHdLNHVxaEZX?=
 =?utf-8?B?NWt0OVphNUtVOWpWcVBReEdGT1ViL1ZWQWI4R083V0sxdkUyWnFvQ0M5aUM3?=
 =?utf-8?B?UnRxRnlrRWV3czVpSHQ0Szl4dXNwd0FQNFI4QUMxTk5uZ0NPYTUvbmE5SVpV?=
 =?utf-8?B?ZTY5U2pDWHQ4TFp4dnduMG1uaHQyVFhlSUFzUUw2a0pITzBsVUdoTXFLR3E0?=
 =?utf-8?B?TmZIYTNWVytMM0JNdUMrVGFwNlFwSHh5SEdhNGtGc2JMREZoL08zNllUT094?=
 =?utf-8?B?eUh5bk1HSTEwbENmd2JibHZxL2hNL0JlRWUzRlhWWS8wU2JVWkUreWtSTDQv?=
 =?utf-8?B?MXNqcEhMWFo1Z2luR0g0bm41cUVScjlzaWhhdm5wdUtsL0tiYXJiVWJFZDh0?=
 =?utf-8?B?bE9PY1QzeWU0a01DWitrMHIxeXFqN2xtTFA3V2NqTmhRNEhDbG9xejEwR3VO?=
 =?utf-8?B?VnhpOVRuQ2NQL2F0VzZJMEx2MGJ0RW9QUWN3aWJHNWswcVJISjFFdmYvUjNj?=
 =?utf-8?B?dloyQ3VtRERkbFhMU0QvNXVBbzhKUE9FNC83RXlkdTBrRThnVlRVQTdVclFp?=
 =?utf-8?Q?siZe/cbNfX3wYISEuTyVwRHMv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd2ac0d-f425-486b-7833-08da70b5e8fe
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 16:26:22.9711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ys8lACTQndl9GKr2Zx4gMI2ZojiLdiSC4dAPooUwIcOxto6Krfk3W/2JQ/CKqDzID56tOiJBBAkEH7ZSKueI8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1828
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Eric,

Thanks for the review!

On 7/26/2022 3:42 AM, Eric Biggers wrote:
> On Wed, Jul 20, 2022 at 02:26:31PM +0300, Israel Rukshin wrote:
>> +static int blk_crypto_ioctl_create_key(struct request_queue *q,
>> +				       void __user *argp)
>> +{
>> +	struct blk_crypto_set_key_arg arg;
>> +	u8 raw_key[BLK_CRYPTO_MAX_KEY_SIZE];
>> +	struct blk_crypto_key *blk_key;
>> +	int ret;
>> +
>> +	if (copy_from_user(&arg, argp, sizeof(arg)))
>> +		return -EFAULT;
>> +
>> +	if (memchr_inv(arg.reserved, 0, sizeof(arg.reserved)))
>> +		return -EINVAL;
>> +
>> +	if (!arg.raw_key_size)
>> +		return blk_crypto_destroy_default_key(q);
>> +
>> +	if (q->blk_key) {
>> +		pr_err("Crypto key is already configured\n");
>> +		return -EBUSY;
>> +	}
> Doesn't this need locking so that multiple executions of this ioctl can't run on
> the block device at the same time?
Yes, it should and I will add on V2.
>
> Also, the key is actually being associated with the request_queue.  I thought it
> was going to be the block_device?  Doesn't it have to be the block_device so
> that different partitions on the same disk can have different settings?
I will check your suggestion.
Currently, all the partitions on the disk have the same key.
>
> Also, the pr_err should be removed.  Likewise in several places below.
>
>> +
>> +	if (arg.raw_key_size > sizeof(raw_key))
>> +		return -EINVAL;
>> +
>> +	if (arg.data_unit_size > queue_logical_block_size(q)) {
>> +		pr_err("Data unit size is bigger than logical block size\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (copy_from_user(raw_key, u64_to_user_ptr(arg.raw_key_ptr),
>> +			   arg.raw_key_size)) {
>> +		ret = -EFAULT;
>> +		goto err;
>> +	}
>> +
>> +	blk_key = kzalloc(sizeof(*blk_key), GFP_KERNEL);
>> +	if (!blk_key) {
>> +		ret = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	ret = blk_crypto_init_key(blk_key, raw_key, arg.crypto_mode,
>> +				  sizeof(u64), arg.data_unit_size);
>> +	if (ret) {
>> +		pr_err("Failed to init inline encryption key\n");
>> +		goto key_err;
>> +	}
>> +
>> +	/* Block key size is taken from crypto mode */
>> +	if (arg.raw_key_size != blk_key->size) {
>> +		ret = -EINVAL;
>> +		goto key_err;
>> +	}
> The key size check above happens too late.  The easiest solution would be to add
> the key size as an argument to blk_crypto_init_key(), and make it validate the
> key size.
>
>> +	}
>> +	blk_key->q = q;
>> +	q->blk_key = blk_key;
> How does this interact with concurrent I/O?  Also, doesn't the block device's
> page cache need to be invalidated when a key is set or removed?
In case of removing the key, I am freezing the queue to avoid concurrent 
I/O.
I can do the same thing when setting the key.
Setting a key when running I/O is not well defined.
At this implementation, only part the concurrent I/O will be encrypted.
After the ioctl is done then all the new I/O will be encrypted.
>> diff --git a/include/uapi/linux/blk-crypto.h b/include/uapi/linux/blk-crypto.h
>> new file mode 100644
>> index 000000000000..5a65ebaf6038
>> --- /dev/null
>> +++ b/include/uapi/linux/blk-crypto.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +
>> +#ifndef __UAPI_LINUX_BLK_CRYPTO_H
>> +#define __UAPI_LINUX_BLK_CRYPTO_H
>> +
>> +enum blk_crypto_mode_num {
>> +	BLK_ENCRYPTION_MODE_INVALID,
>> +	BLK_ENCRYPTION_MODE_AES_256_XTS,
>> +	BLK_ENCRYPTION_MODE_AES_128_CBC_ESSIV,
>> +	BLK_ENCRYPTION_MODE_ADIANTUM,
>> +	BLK_ENCRYPTION_MODE_MAX,
>> +};
> Instead of an enum, these should use #define's with explicit numbers.  Also,
> INVALID and MAX shouldn't be included.
>
>> +
>> +#endif /* __UAPI_LINUX_BLK_CRYPTO_H */
>> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
>> index bdf7b404b3e7..398a77895e96 100644
>> --- a/include/uapi/linux/fs.h
>> +++ b/include/uapi/linux/fs.h
>> @@ -121,6 +121,14 @@ struct fsxattr {
>>   	unsigned char	fsx_pad[8];
>>   };
>>   
>> +struct blk_crypto_set_key_arg {
>> +	__u32 crypto_mode;
>> +	__u64 raw_key_ptr;
>> +	__u32 raw_key_size;
>> +	__u32 data_unit_size;
>> +	__u32 reserved[9];	/* must be zero */
>> +};
> The reserved fields should be __u64 so that it's easy to use them for pointers
> or other 64-bit data later if it becomes necessary.  Also, reserved fields
> should also be prefixed with "__".  Also, a padding field is needed between
> crypto_mode and raw_key_ptr.  Also, it would be a good idea to make the reserved
> space even larger, as people may want to add all sorts of weird settings here in
> the future (look at dm-crypt).
>
> The following might be good; it makes the whole struct a nice round size, 128
> bytes:
>
> struct blk_crypto_set_key_arg {
> 	__u32 crypto_mode;
> 	__u32 __reserved1;
> 	__u64 raw_key_ptr;
> 	__u32 raw_key_size;
> 	__u32 data_unit_size;
> 	__u64 __reserved2[13];
> };
>
> - Eric
Israel
