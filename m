Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4310C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 13:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350237AbiFUNFf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347838AbiFUNFe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 09:05:34 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF8321E2B
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655816733; x=1687352733;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hi3MPTS3s97qh8CTZj5p7fwgALYULA3/xSJdriKFNjE=;
  b=FUuMs2IgIbmThx+dFWii47e3n3ANUfni4JdUGAEQbmYquZ4Bltw4IT88
   acxIT2a3eD8AcunV2hu11BbWhc09tXFZqN/HQI+l+3pYRkVLFa+JbDfhN
   5MDmxrzgMYVglT/wx6B6kRf5oqRIFsemWOZMae0X/3PoNfkvCpuYmtaNO
   stRpbWpRSpHca3+Rq6gXctJnx7HpQgDlYjVzyokJMfNfq6uJPPDrADsXt
   e2nERbDty7tBot+tccDhdoYoTfLcxBpJNTGik7C+sIXuoe0qV/5jY4KL4
   bFbu8qCJHvcCUF95RznxyzlWl+tPibxJvDFhjb5VefPx8s3m0A589H+EH
   A==;
X-IronPort-AV: E=Sophos;i="5.92,209,1650902400"; 
   d="scan'208";a="202416672"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 21:05:33 +0800
IronPort-SDR: 8X4TFiH5qG74sqiNp4BLg9gQcC1I+HjsgK93V5LE1wGT4Slu8UJt9D2aCpA5Xk3tMq25oenIJx
 4gUkyfOaiNgixVqDt28ZIwyZsaC21+qKDpxynjp1u8S8kpcBrWkCYfVCF2erh4Bt/zwO5nx2iL
 fwac/k0ENTKA7fl04R8HhCe3QdfNrR93G+ZGMmqp2AnH6TSVRe547hq1jL2/zzT9loAyHzJHES
 47VMiNkg+exj2kHYY/z8vQRrDSziUZpqT2/9ms5tZzHSNUwPq4d1De5coeA3C/4RO8ikwLPDt2
 RSfvQV7+oE9/fcfE8X2ve9OS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2022 05:28:03 -0700
IronPort-SDR: 6T4zc7kMk9mo4lgCM0sWKh1CwG3tw9mVEON4HKndcbfhA8ZTF7v/4UopMbGxoNZzsfcRW9nydh
 TxsOYLAmlr2pqkrbm/0qvBRYKt/Ou23jHiJuj6I+56vW9p+p1t/exmO0GkiUGJhM+hXrDJQdCL
 aqkB3NaMlRxYT+YjPpCkAOLSOEnOeyKbkMcJ6Jw9+iB6GsBbgG0oD1AuyRYYS8SQEB7Fk7UPDW
 Bt1zt1C1nQHnMgJCxisZNHES8lC1JVGQjJ9z/Ke3tEp8xQrUgnAHNFZn7RClwn/VrRFbfF/mTE
 jm8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2022 06:05:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LS6FS6ct9z1Rwnl
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 06:05:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655816732; x=1658408733; bh=hi3MPTS3s97qh8CTZj5p7fwgALYULA3/xSJ
        driKFNjE=; b=qNpq0WC0v6ZlzzHb3VnLzEvkfLLnXuk517iFHDtw6Tel4xviW8M
        crrmYlWvkdxEbVx2L82f8iABZQdTzgQSv4zfKYUymMUjCz9OMb/fcEH53J3cC+h2
        SlLtq7YvWwR5Urk3GXsh+lIEndc0QvMLd6yFO+8OrqDmA9PnzbZYxGEXDgF8Bz/2
        gO0/OQvgBO33Wb2QEtZAe5Y9fBk8crPs082H3Y6xketKvakOl+7qyq2vxEes9rpL
        UeHaMNlaPlatVczFIDG2r/hPq/6gN6rG3IN8x28hrZg1jjnZW23hPu7MShtxaFgP
        3Y+WFrEoZwxo48Sp1q9zwz+6bOZAksfo5jA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id v5NBZ4gokG9Y for <linux-block@vger.kernel.org>;
        Tue, 21 Jun 2022 06:05:32 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LS6FR4hPvz1RtVk;
        Tue, 21 Jun 2022 06:05:31 -0700 (PDT)
Message-ID: <30c83f51-d97a-af9f-fa9e-b80e0240e160@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 22:05:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/9] block: Generalize get_current_ioprio() for any task
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20220621102201.26337-1-jack@suse.cz>
 <20220621102455.13183-3-jack@suse.cz>
 <20220621123637.7jp3ifk2wmbmueur@quack3.lan>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220621123637.7jp3ifk2wmbmueur@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/22 21:36, Jan Kara wrote:
> On Tue 21-06-22 12:24:40, Jan Kara wrote:
>> get_current_ioprio() operates only on current task. We will need the
>> same functionality for other tasks as well. Generalize
>> get_current_ioprio() for that and also move the bulk out of the header
>> file because it is large enough.
>>
>> Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Bah, I've messed up the prototype of the stub function for !CONFIG_BLOCK.
> One more fixup will be needed here but let me wait if people have more
> comments...

Oops. Missed it :)

> 
> 								Honza
> 
>> ---
>>  block/ioprio.c         | 26 ++++++++++++++++++++++++++
>>  include/linux/ioprio.h | 26 ++++++++++----------------
>>  2 files changed, 36 insertions(+), 16 deletions(-)
>>
>> diff --git a/block/ioprio.c b/block/ioprio.c
>> index 2a34cbca18ae..c4e3476155a1 100644
>> --- a/block/ioprio.c
>> +++ b/block/ioprio.c
>> @@ -138,6 +138,32 @@ SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
>>  	return ret;
>>  }
>>  
>> +/*
>> + * If the task has set an I/O priority, use that. Otherwise, return
>> + * the default I/O priority.
>> + *
>> + * Expected to be called for current task or with task_lock() held to keep
>> + * io_context stable.
>> + */
>> +int __get_task_ioprio(struct task_struct *p)
>> +{
>> +	struct io_context *ioc = p->io_context;
>> +	int prio;
>> +
>> +	if (p != current)
>> +		lockdep_assert_held(&p->alloc_lock);
>> +	if (ioc)
>> +		prio = ioc->ioprio;
>> +	else
>> +		prio = IOPRIO_DEFAULT;
>> +
>> +	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
>> +		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
>> +					 task_nice_ioprio(p));
>> +	return prio;
>> +}
>> +EXPORT_SYMBOL_GPL(__get_task_ioprio);
>> +
>>  static int get_task_ioprio(struct task_struct *p)
>>  {
>>  	int ret;
>> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
>> index 61ed6bb4998e..788a8ff57068 100644
>> --- a/include/linux/ioprio.h
>> +++ b/include/linux/ioprio.h
>> @@ -46,24 +46,18 @@ static inline int task_nice_ioclass(struct task_struct *task)
>>  		return IOPRIO_CLASS_BE;
>>  }
>>  
>> -/*
>> - * If the calling process has set an I/O priority, use that. Otherwise, return
>> - * the default I/O priority.
>> - */
>> -static inline int get_current_ioprio(void)
>> +#ifdef CONFIG_BLOCK
>> +int __get_task_ioprio(struct task_struct *p);
>> +#else
>> +static inline int __get_task_ioprio(int ioprio)
>>  {
>> -	struct io_context *ioc = current->io_context;
>> -	int prio;
>> -
>> -	if (ioc)
>> -		prio = ioc->ioprio;
>> -	else
>> -		prio = IOPRIO_DEFAULT;
>> +	return IOPRIO_DEFAULT;
>> +}
>> +#endif /* CONFIG_BLOCK */
>>  
>> -	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
>> -		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
>> -					 task_nice_ioprio(current));
>> -	return prio;
>> +static inline int get_current_ioprio(void)
>> +{
>> +	return __get_task_ioprio(current);
>>  }
>>  
>>  /*
>> -- 
>> 2.35.3
>>


-- 
Damien Le Moal
Western Digital Research
