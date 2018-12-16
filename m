Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61164C43612
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249692086C
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XxZstJ3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbeLPQEl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:04:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33739 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPQEk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:04:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so5149847pfb.0
        for <linux-block@vger.kernel.org>; Sun, 16 Dec 2018 08:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fr8F847DYMRrb6okTnAerKiLAT31aoZh2MwdzXUf7C0=;
        b=XxZstJ3OpcZVsn/KjBZbOlm1zgNadcIo073KwbTP6iezq6vve/euHNMq4KnexNJDWw
         Lv+Mrfun55gRb6FoDnfmTpxFLIJh5l7PIWw5a+/yAyGGdDJJfyc+SxOKLC/4qlqreQnN
         WN1lvjroqTRZ+raQCaqBBrnuBkuq/DfJTkGkj1wZlCMMNINx2U9ASlpkP3r2WcobnPMG
         QDkTZZrei6ILCXZ/V944CCQ+WYjmjy1I2rJ+0dQRPVJAjT7euYJSgYShJaVqP56h9jn9
         SFOIXFyn0gqaeG8OcGJAUdzA8zolUm5aTq3tBFuv7FIOs+NI6zkv3SP/IS1fdC7Yl73x
         D1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fr8F847DYMRrb6okTnAerKiLAT31aoZh2MwdzXUf7C0=;
        b=jyLc6fLE3wtz3R1Q3Td/e61LgYe2pCaUJp3Xmz6nrRmk9laih29bW/dt4CQd1NawGb
         d8pw0zbkPzcMq4eaKYjzbO9osz9T0u7lxoeCoRYRq79Aj8lrUMlgj1siQ3AKfDGcnMYh
         XTe3zoIfFXGfTtlwW+SWlmrw08Yk7SmnuH6z00bQHAWozZLVV34xR9dkvzYZEMrirv0e
         nOCRBuc071Fj5OtYs/rXCH/1Qt0aLbKNXZOPZlLZBPFWKn7PL4vEhTFF8NmGvoV6vk+4
         uwAcKI6CrbuUgwAintF2lESskJjFoWPzNDJULW+JS9cLcaTjiFlJ84g1egi2NKZhwiOv
         C5dw==
X-Gm-Message-State: AA+aEWb8WsEt1OSKQfdtBAC8t8h/p9phOkM15yw3WBUdDKZ7EwQhOl3n
        JE7QagVFizd75kBDhRd5LlBOzQ==
X-Google-Smtp-Source: AFSGD/UecBChAMwFHCRt1/ZMCUEstOLQ98q71WMVcBJ/P1X9kECeeIDZak5IqCj+NOfex1VgRk622w==
X-Received: by 2002:a62:ce0e:: with SMTP id y14mr10269267pfg.100.1544976279847;
        Sun, 16 Dec 2018 08:04:39 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p67sm18354851pfg.44.2018.12.16.08.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 08:04:38 -0800 (PST)
Subject: Re: [PATCH 1/2] blk-mq-debugfs: support rq_qos
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
References: <20181214113926.7451-1-ming.lei@redhat.com>
 <20181214113926.7451-2-ming.lei@redhat.com>
 <1544814707.185366.425.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <68f580d7-b704-c4cf-dbca-558ad5b5ea98@kernel.dk>
Date:   Sun, 16 Dec 2018 09:04:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544814707.185366.425.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/14/18 12:11 PM, Bart Van Assche wrote:
> On Fri, 2018-12-14 at 19:39 +0800, Ming Lei wrote:
>>  static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
>>  {
>> @@ -856,6 +857,15 @@ int blk_mq_debugfs_register(struct request_queue *q)
>>  			goto err;
>>  	}
>>  
>> +	if (q->rq_qos) {
>> +		struct rq_qos *rqos = q->rq_qos;
>> +
>> +		while (rqos) {
>> +			blk_mq_debugfs_register_rqos(rqos);
>> +			rqos = rqos->next;
>> +		}
>> +	}
> 
> Have you considered to use a for-loop instead of a while loop? That would
> allow to remove the if-statement and hence would make the code more compact.

It would fit better with the style in that code do to:

rqos = q->rq_qos;
while (rqos) {
    ....
    rqos = rqos->next;
}

> 
>> +int blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
>> +{
>> +	struct request_queue *q = rqos->q;
>> +	char *dir_name = rq_qos_id_to_name(rqos->id);
> 
> Please change "char *" into "const char *".
> 
>>  enum rq_qos_id {
>>  	RQ_QOS_WBT,
>>  	RQ_QOS_CGROUP,
>> @@ -22,6 +26,9 @@ struct rq_qos {
>>  	struct request_queue *q;
>>  	enum rq_qos_id id;
>>  	struct rq_qos *next;
>> +#ifdef CONFIG_BLK_DEBUG_FS
>> +	struct dentry		*debugfs_dir;
>> +#endif
>>  };
> 
> The indentation of "debugfs_dir" looks odd to me.
> 
>> +static inline char *rq_qos_id_to_name(enum rq_qos_id id)
>> +{
>> +	switch (id) {
>> +	case RQ_QOS_WBT:
>> +		return "wbt";
>> +	case RQ_QOS_CGROUP:
>> +		return "cgroup";
>> +	}
>> +	return "unknown";
>> +}
> 
> Same comment here as earlier: please use "const char *" instead of "char *"
> for constant strings. Otherwise this patch looks fine to me.

Agree on the rest of your comments.


-- 
Jens Axboe

