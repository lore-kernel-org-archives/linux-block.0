Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1426C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 22:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62ADD218FD
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 22:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NedpAzbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390140AbeLTWXw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 17:23:52 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42418 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLTWXv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 17:23:51 -0500
Received: by mail-io1-f68.google.com with SMTP id x6so2122900ioa.9
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 14:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Y8Y8Ybs7A7MPZqXTQZiZm3gc8lXkmNuOJkVqx97Xu0c=;
        b=NedpAzbBxQB6y++QnQiJdmwSY5rkYcftSeYbBRb8KCJKbb0fHrkQh2P0mpcbmEbhng
         /9/RtDNys955WcjdJ7h++uZ+HmmpHiBJyRqGA4y6lyvI/jAxHWoE5ZgeaaAhk0fA6K3/
         qQxBM1pZZfv8B5NYa7FbsqqIdDZJVSj0zAeNyoqA24wWYdoSqJ21tDRwkUA/LUtkp6D0
         /7OtPg8B0I+lIt/8jpkahW3jeEWC8i2RoxfjggD5uvgEXgdrjU7DU7pR7MTJzYZRF7uX
         6TR2BC1jf8Fj0mXQlGb+t3gkPnrf3XuerJ/miu7cjJF5dKpXX7HnhxpQdZctzpnMrJn2
         PbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y8Y8Ybs7A7MPZqXTQZiZm3gc8lXkmNuOJkVqx97Xu0c=;
        b=fNGk4qNeXPv95tT9OdBaeD2rb3CDrIHA6ZcPnbBeh6y6EVN7VwlQatClfBnBsg0HCZ
         d1B63+ZZO2U2r3mIaewgxsqESy/32pC6e3AVOfruYviUrhrhKs9z7xOaqlMG7lsksHez
         P0Mh07PlFCpC/UOWGc4N5hHswL9G7WMIulk8cPHyaI5YXPrXudQ/tiYVWUywAH+oeTSg
         jFmzKtlogIRmgecZVpyFg22cwLcqxRS0M/rODa5XgBB8igH1PY3kEksp13Rpf2Xyub7h
         6UJ/8Ha3iWagu+TDnatJ2DkGqUMDZLqWv7eFZvfFwNYyn8tXOJZpXsoa0dxvzfA9h/L3
         lb7A==
X-Gm-Message-State: AJcUukeJF9jJ4I4KLKapzzdJ+2R0JbwZFe79DXEAAABFrdNWtJNqnpme
        huMtu5+cT++PuBys2B81aMksJ0fPr65jaA==
X-Google-Smtp-Source: ALg8bN6l+q+d2qTzoNb38k3wfPiPGOLQjX9PviU0gOSnE5IG581u4HPXMFq1mTMc6Xucw5RoqruzwQ==
X-Received: by 2002:a6b:b7ce:: with SMTP id h197mr14606iof.274.1545344630571;
        Thu, 20 Dec 2018 14:23:50 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w8sm888538iom.26.2018.12.20.14.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 14:23:49 -0800 (PST)
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
To:     Bart Van Assche <bvanassche@acm.org>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1545261885.185366.488.camel@acm.org>
 <0560802f-efc0-e9ec-99f7-4bdbdbc234f8@oracle.com>
 <c078750c-ff6b-4939-281b-7556d31dc74d@kernel.dk>
 <fe9dfe60-3cfc-9cfa-56c3-1365cbe8ec53@oracle.com>
 <a45c9931-ce8b-0ac8-f304-412c6042eff9@kernel.dk>
 <372d2960-ff0c-1135-28f9-23eea8670463@oracle.com>
 <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
 <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk>
 <1545328865.185366.508.camel@acm.org>
 <bd78b521-d0d4-22ec-ff7f-2d70709ca742@kernel.dk>
 <b9c3bd7c-9e82-7300-d525-0bd72ed66f66@kernel.dk>
 <1545339362.185366.511.camel@acm.org>
 <e7d6d857-b20a-245c-c6c7-fb9b110215e9@kernel.dk>
 <1545340987.185366.515.camel@acm.org>
 <120bb59a-af93-7d8c-9afc-7087973632bf@kernel.dk>
 <1545341470.185366.519.camel@acm.org>
 <61515137-0565-e3b7-e6de-554af7d49753@kernel.dk>
 <1545342043.185366.523.camel@acm.org>
 <60b4819c-4c19-a4e3-41f3-e21b0544c9a4@kernel.dk>
 <68c73daa-10e7-29da-b890-bf167ec164c2@kernel.dk>
 <1545344398.185366.531.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1864f5b8-cf64-a406-a3e0-9f5124ff95b5@kernel.dk>
Date:   Thu, 20 Dec 2018 15:23:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545344398.185366.531.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/18 3:19 PM, Bart Van Assche wrote:
> On Thu, 2018-12-20 at 14:48 -0700, Jens Axboe wrote:
>> -void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>> -		     unsigned int hctx_idx)
>> +static void blk_mq_rcu_free_pages(struct work_struct *work)
>>  {
>> +	struct blk_mq_tags *tags = container_of(to_rcu_work(work),
>> +						struct blk_mq_tags, rcu_work);
>>  	struct page *page;
>>  
>> +	while (!list_empty(&tags->page_list)) {
>> +		page = list_first_entry(&tags->page_list, struct page, lru);
>> +		list_del_init(&page->lru);
>> +		/*
>> +		 * Remove kmemleak object previously allocated in
>> +		 * blk_mq_init_rq_map().
>> +		 */
>> +		kmemleak_free(page_address(page));
>> +		__free_pages(page, page->private);
>> +	}
>> +}
>> +
>> +void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>> +		     unsigned int hctx_idx)
>> +{
>>  	if (tags->rqs && set->ops->exit_request) {
>>  		int i;
>>  
>> @@ -2038,16 +2061,9 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>>  		}
>>  	}
>>  
>> -	while (!list_empty(&tags->page_list)) {
>> -		page = list_first_entry(&tags->page_list, struct page, lru);
>> -		list_del_init(&page->lru);
>> -		/*
>> -		 * Remove kmemleak object previously allocated in
>> -		 * blk_mq_init_rq_map().
>> -		 */
>> -		kmemleak_free(page_address(page));
>> -		__free_pages(page, page->private);
>> -	}
>> +	/* Punt to RCU free, so we don't race with tag iteration */
>> +	INIT_RCU_WORK(&tags->rcu_work, blk_mq_rcu_free_pages);
>> +	queue_rcu_work(system_wq, &tags->rcu_work);
>>  }
> 
> This can only work correctly if blk_mq_rcu_free_pages() is called before
> INIT_RCU_WORK() is called a second time for the same bkl_mq_tags structure
> and if blk_mq_rcu_free_pages() is called before struct blk_mq_tags is freed.
> What provides these guarantees? Did I perhaps miss something?

We don't call it twice. Protecting against that is outside the scope
of this function. But we call and clear form the regular shutdown path,
and the rest is error handling on setup.

But yes, we do need to ensure that 'tags' doesn't go away. Probably best
to rework it to shove it somewhere else for freeing for that case, and
leave the rest of the shutdown alone. I'll update the patch.

-- 
Jens Axboe

