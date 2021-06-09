Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D81C48BCD
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 17:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB44613CA
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 17:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhFIRB7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 13:01:59 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:44990 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFIRB6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 13:01:58 -0400
Received: by mail-pf1-f178.google.com with SMTP id u18so18833293pfk.11
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 09:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aJbb24CYOSpj/K6vGY9QDRQSFa0sxnuqji2MPt4xQRo=;
        b=Qc6avV5EOpDFXYznVQ/wbGtEaMErsuhqG8C6tsLcJxmLxGNw+pE9mS0FnbdGDSSaBw
         DZA/a3jQGShxwm2mu9D8tKKYOAYsBB+s2MgjSGI7z/Wbuf9MuJqPtonwPFcOWJ5iwn5P
         I7jvbDatCKb2zQs3PtHN+B1Pfeh5p71dL55Dlh+w3L93ntR1L6JFw9oYD8CWadTbUWRJ
         JLsMfLydxbPoNvX4JBymJ6grRR76TYHh34mm0EntqHoBZqqDdlKED5WixTLakqz6u/Uf
         DuPYfovKluZK4Jbh2HxevdjZFBCy5eHEcvgXnxFZ4jpgrQVgV4ucvdUFVK6Rv9vANbwf
         fWJg==
X-Gm-Message-State: AOAM533Te1xKpXNKdNQNNeW4DwK6wk7779KN4fAmdt4wWIcYsiOlEmiF
        2t2bJG6GFgsreuva2ui/Phk=
X-Google-Smtp-Source: ABdhPJzXcV/H0x6qc7i+Q5NFMILxYzh4fFyCCWnkQrPu8VzH7fUbon8u8TuPO4zO1T/FVuHGajqOiQ==
X-Received: by 2002:a63:fd17:: with SMTP id d23mr687783pgh.68.1623257989289;
        Wed, 09 Jun 2021 09:59:49 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s20sm5680859pjn.23.2021.06.09.09.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 09:59:42 -0700 (PDT)
Subject: Re: [PATCH 10/14] block/mq-deadline: Improve the sysfs show and store
 macros
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-11-bvanassche@acm.org>
 <PH0PR04MB74169450017D5A976BA91E1E9B369@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <cfc07d2f-ff4d-47dc-2f5b-9add0cc78cb3@acm.org>
Date:   Wed, 9 Jun 2021 09:59:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <PH0PR04MB74169450017D5A976BA91E1E9B369@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 12:11 AM, Johannes Thumshirn wrote:
> On 09/06/2021 01:07, Bart Van Assche wrote:
>> +#define SHOW_INT(__FUNC, __VAR)						\
>>  static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
>>  {									\
>>  	struct deadline_data *dd = e->elevator_data;			\
>> -	int __data = __VAR;						\
>> -	if (__CONV)							\
>> -		__data = jiffies_to_msecs(__data);			\
>> -	return deadline_var_show(__data, (page));			\
>> -}
>> -SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[DD_READ], 1);
>> -SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[DD_WRITE], 1);
>> -SHOW_FUNCTION(deadline_writes_starved_show, dd->writes_starved, 0);
>> -SHOW_FUNCTION(deadline_front_merges_show, dd->front_merges, 0);
>> -SHOW_FUNCTION(deadline_fifo_batch_show, dd->fifo_batch, 0);
>> -#undef SHOW_FUNCTION
>> +									\
>> +	return sysfs_emit((page), "%d\n", __VAR);			\
>> +}
> 
> Nit: the () around page aren't needed

Right, I will remove these parentheses.

Thanks,

Bart.


