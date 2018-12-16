Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39505C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074C02082F
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HsnZEQGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeLPQHm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:07:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44602 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPQHm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:07:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so5125631pfh.11
        for <linux-block@vger.kernel.org>; Sun, 16 Dec 2018 08:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3l05Qh9HpeiXgayJXkulZSfSbT9g++76WF9RUMRCGdk=;
        b=HsnZEQGx6ungKq2HPkAGm3pvTjAAqMsiY0BA9/Lj8YFxpbDRSCTJ5RPPb/MiUDaL+a
         T2M0TuyNAhYF1o0b/rlFvawYvGnFx5lmE5pQvoMT+xV6JqAGGYIGNq1U6QrxrZu6tV0e
         asW9xNcFIagX0MemoNiFN6W+hY4lrTcB9c5TaKRi2AGyqEf+Agzfe8TDjanqMtxXSADG
         jYoq+yXzx29cjxnqS8Wl8TubHAtZpWt5qXkVYuEvvQgw1d0zZNgorsLfEsTyymw14UOc
         o3kB07HsDc87Jrmd5B7TYpwO48ExaM/yBqGWmIWYhaRSnci3cz8rL4UCDu5H9jzKN3JH
         uJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3l05Qh9HpeiXgayJXkulZSfSbT9g++76WF9RUMRCGdk=;
        b=BAUNkgkNpwKVP1+cnhooJrzxc7GFJ+fDx4I19OggK4SK+gcYz+fqkxUQt9KMoLN/X7
         RsFWCFa7afJgBkvDDhbw0mWfKWfitN61LNnCxvgt3GRtKmtYi7F9CYLGOvVknX3lSd9w
         PyGRWWk3QrkuIjFYfpEnJidUFRKipuAgLH7ScpKtq5XfoFeeJiRt/5sDVRZryyqQgvJC
         w5wBIs1ARDHT8B13uU8d6y0wUVlH1ROi2ZEum+0tlFKyR40gjZWsACRr9TgKDogvGagh
         +K67OouhCSxRKdDz3Epm14Q3osRVVIkanSR8dV7bIu3inmsod84mCAjMy2dYoPqstxkD
         yibg==
X-Gm-Message-State: AA+aEWY61UEIq44LLr9/ur0Hct1wwJ4kaUOuXkXz89jtECGzoAW4wowt
        ZAGbGxaPYrTm1R7QJM+n04brrQ==
X-Google-Smtp-Source: AFSGD/VTiiteKfvrKmIcLG3n2+cD4rO0S+nsZZfzfka/Sz7o2WEG3fmggKV17HF/qRBa/3/V0PqVZw==
X-Received: by 2002:a63:6486:: with SMTP id y128mr8634148pgb.18.1544976461012;
        Sun, 16 Dec 2018 08:07:41 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v70sm16851054pfa.152.2018.12.16.08.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 08:07:40 -0800 (PST)
Subject: Re: [PATCH 2/2] blk-wbt: export internal state via debugfs
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
References: <20181214113926.7451-1-ming.lei@redhat.com>
 <20181214113926.7451-3-ming.lei@redhat.com>
 <1544814903.185366.427.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <35fd2388-21d2-3a15-cfe4-9564523aa0f1@kernel.dk>
Date:   Sun, 16 Dec 2018 09:07:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544814903.185366.427.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/14/18 12:15 PM, Bart Van Assche wrote:
> On Fri, 2018-12-14 at 19:39 +0800, Ming Lei wrote:
>> This information is helpful to either investigate issues, or understand
>> wbt's internal behaviour.
>>
>> Cc: Bart Van Assche <bart.vanassche@wdc.com>
>> Cc: Omar Sandoval <osandov@fb.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> ---
>>  block/blk-wbt.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 91 insertions(+)
>>
>> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
>> index 463e4eb80287..2684bf2d112f 100644
>> --- a/block/blk-wbt.c
>> +++ b/block/blk-wbt.c
>> @@ -715,6 +715,94 @@ void wbt_disable_default(struct request_queue *q)
>>  }
>>  EXPORT_SYMBOL_GPL(wbt_disable_default);
>>  
>> +#ifdef CONFIG_BLK_DEBUG_FS
>> +static int wbt_curr_window_show(void *data, struct seq_file *m)
>> +{
>> +	struct rq_qos *rqos = data;
>> +	struct rq_wb *rwb = RQWB(rqos);
>> +
>> +	seq_printf(m, "%llu ns\n", rwb->cur_win_nsec);
>> +	return 0;
>> +}
> 
> Please consider to embed the unit ("ns") in the attribute name instead of
> in the attribute value. That will make it easier to process this attribute
> in developer debug scripts.
> 
>> +static int wbt_min_latency_show(void *data, struct seq_file *m)
>> +{
>> +	struct rq_qos *rqos = data;
>> +	struct rq_wb *rwb = RQWB(rqos);
>> +
>> +	seq_printf(m, "%luns\n", rwb->min_lat_nsec);
>> +	return 0;
>> +}
> 
> Same comment here about the unit.
> 
>> +static const struct blk_mq_debugfs_attr wbt_debugfs_attrs[] = {
>> +	{"curr_window", 0400, wbt_curr_window_show},
>> +	{"enable_state", 0400, wbt_enable_state_show},
> 
> How about using "enabled" instead of "enable_state"?

Agree on all of these. Ming, I had to amend so I dropped the previous
commits, so I could also drop the compilation fixup for
!CONFIG_BLK_DEBUG_FS. Can you resend with those fixed, and also apply
this incremental?

diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index fd8a0c5debd3..210567ddfa40 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -40,9 +40,7 @@ struct rq_qos_ops {
 	void (*done_bio)(struct rq_qos *, struct bio *);
 	void (*cleanup)(struct rq_qos *, struct bio *);
 	void (*exit)(struct rq_qos *);
-#ifdef CONFIG_BLK_DEBUG_FS
 	const struct blk_mq_debugfs_attr *debugfs_attrs;
-#endif
 };
 
 struct rq_depth {

-- 
Jens Axboe

