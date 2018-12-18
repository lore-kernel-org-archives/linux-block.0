Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DBFC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2433921873
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="A5ldIVq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeLRSVN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:21:13 -0500
Received: from mail-it1-f175.google.com ([209.85.166.175]:51442 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeLRSVN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 13:21:13 -0500
Received: by mail-it1-f175.google.com with SMTP id w18so5288610ite.1
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 10:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g2t3b+q2t8Rp/zQLmwn2+Y0DJ+ZhJw0oOhMYKGVq4Ps=;
        b=A5ldIVq1KBIZKkrBGc+5eGQfQOWmLWcTumTLQtHVarqjh9lFJgVAF7BR/L384sKhnN
         DmTA37Akqd10hqSZ5d5eTqBwJHtX+CYMBnJI/cRcocJLow253ODQW5E3kp13CUiTkpQR
         XQekBJY/XQkhZ9wFAwH38As+3m4I1Xz5NOQS4Wd2CAJhlppZgYPWHTSZVp1RbuVD/BXb
         vkwjnSDUSUzQpScgBw4nT0VGyvpedtaCavDFm2f6g1urFK2FFf9sTS089dgKcDQs3NoD
         oS929vx/OP/fAJxF0DGWGaiXM6jdBF4J+OG+azPZpmKUbH2gTpsTP0JJCu8eha2xbrSH
         dGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g2t3b+q2t8Rp/zQLmwn2+Y0DJ+ZhJw0oOhMYKGVq4Ps=;
        b=iMKGIQsxilMgY2LBZ6b5HPyp66pnmavDYcZBvwmjn38tJ1WrLjS1mj7QXo7Aui9qBg
         tJ15q376XfbFGg578B98/rFqhyYTHgDJ9MGSjtEUn5vVWXv0rymcythJXy8u18GIbgWU
         vSWUOgtto7N1bAbxAes7847iy6qqtz7lNLzoH/2iqiaapZIqk7RWyK6XqaKIPkeRp8J7
         4hxRp4yl4+7AAxMkimoPqRhsv9CXp62qf6lXJXgmerRTVUG4ZXXIPinS2jHBCccWxdwT
         4Kj5C4F3KzdIBOqRmYag6sqNJVpgW5ZmlODXQ5Lzc822uYbd1nT5QcpMlp5uyqLjm7YZ
         6FXg==
X-Gm-Message-State: AA+aEWY5a406k2YGkXXKXJ9IGQAFwtkyPCmXeuxGPtQVZR23p5MPFEdm
        0WbZCGpc/aWvLdau01KDiFgH2g==
X-Google-Smtp-Source: AFSGD/XkiDMEVrUw2aXfaZUAjps73QFPquLHeE+IeXiwnaenzOcI6l9p7dS9w4khBRNA7Rj+CRxOlQ==
X-Received: by 2002:a24:b34f:: with SMTP id z15mr3285469iti.61.1545157272123;
        Tue, 18 Dec 2018 10:21:12 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q197sm1967372itb.22.2018.12.18.10.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:21:11 -0800 (PST)
Subject: Re: Unintuitive scheduling results using BFQ
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Madhav Ancha <mancha@tower-research.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <CA+XCsb-0M8PXB30zd22c_nmww5OvMs4mKEcsFahMR7jV+9+01g@mail.gmail.com>
 <8FCED0AE-6BE7-42EE-92ED-58E2B622A165@linaro.org>
 <CA+XCsb-0vY+x1+jSSRYcLdYz+U_T77QefQVWEoikSS5bfevjpg@mail.gmail.com>
 <C8B5F877-6F4B-46AD-9AC9-BAE91C754A5F@linaro.org>
 <CA+XCsb8eiq7w-W5ecPNdnqvrv1dU4Vkq=HfKCG=MoQi_CekPBg@mail.gmail.com>
 <255AD47C-65DD-4F22-9E64-8DF9DD81B83B@linaro.org>
 <eb245572-a504-37d6-dd15-d1b502816940@kernel.dk>
 <0CEF3DD1-E360-4366-A756-78274F306AE4@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1589bb87-487a-4394-cbbc-6d25a21771fa@kernel.dk>
Date:   Tue, 18 Dec 2018 11:21:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0CEF3DD1-E360-4366-A756-78274F306AE4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/18 11:19 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 18 dic 2018, alle ore 19:08, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 12/18/18 11:04 AM, Paolo Valente wrote:
>>> static bool bfq_symmetric_scenario(struct bfq_data *bfqd)
>>> {
>>> -	return !bfq_varied_queue_weights_or_active_groups(bfqd);
>>> +	/*
>>> +	 * For queue weights to differ, queue_weights_tree must contain
>>> +	 * at least two nodes.
>>> +	 */
>>> +	bool varied_queue_weights = !RB_EMPTY_ROOT(&bfqd->queue_weights_tree) &&
>>> +		(bfqd->queue_weights_tree.rb_node->rb_left ||
>>> +		 bfqd->queue_weights_tree.rb_node->rb_right);
>>> +
>>> +	bool multiple_classes_busy =
>>> +		(bfqd->busy_queues[0] & bfqd->busy_queues[1]) |
>>> +		(bfqd->busy_queues[0] & bfqd->busy_queues[2]) |
>>> +		(bfqd->busy_queues[1] & bfqd->busy_queues[2]);
>>
>> I don't think this does what you want it to, looks like these should be
>> logical AND and OR.
>>
> 
> Absolutely, sorry. Fortunately, the end result is still correct :)

Is it? What if ->busy_queues[0] is 1 and ->busy_queues[1] is 2. You'd
expect the first comparison to be true, but it'd be false. Ditto for
the rest of them, of course.

-- 
Jens Axboe

