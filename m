Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3205C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 13:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3B761052
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 13:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhJTNlg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 09:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTNlg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 09:41:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A20CC06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 06:39:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y12so28680176eda.4
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IODY3vyl1Uu2IZDQmxJDkUTLdpOxpO6iLFy3noP7DIc=;
        b=Q3rdYPNnHuYMvbEVdWMAxIR/CEU6MUN3BBex91WtIWCtCxEgcTAAaigM0Voua7+EDs
         R8EYhtIunHz0GJRi6FDsc/tBLrV+ajI/bU9ZGDc1oaUlEbjbFcHp5ARIV8NnZciC9Xqm
         3Qw8nZCSerr7lofGz2a8FeEGUFJksm8aq0LijWW287iL5s1Rve9xLayZ4YS9V7BEfP4i
         8JH02TfIORZ+awNTsI6s9cUCrApav7fkXsPGKrkuW9aRyQBM8+6CgHGFulGXMDxKEh6H
         ltE8/O03zXbkzc+OUUPyR+7U4SJQEyG9zZQC6JKCxXsfdKjk+UejOSiuTqEIXWx5VRLc
         uWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IODY3vyl1Uu2IZDQmxJDkUTLdpOxpO6iLFy3noP7DIc=;
        b=tPdrDlx/+TI77amif7vieE1+EsbzOxWV/XJzQG7Q3uAiUPy68urQ544M0lTVaKjvHh
         GG/KHadXsWR4jEaf0iZIhcv04pdpn584lKzWl5BNhYbJWQ8c9hzxdHvplkcqgEoVYEZP
         +6Zkt6iUWTwQ8YxP4X2VOOSSfmTx3d+prJmryGStxk99DkFf7Cn8lA4kkZqWWrUl6vrM
         B50V0Sdh/GcMTqT5o+h69LHYRRTpiobtWbZXh8QMsSL2rQLIX2RLXnk8CHci5p5PB2xT
         Fuc/wMeG3mA7U78jHUM08h1VkuejNeF+Iqi9hOQzWXVOERsuNjKSVQZ3qlWQ0o7y0qCw
         1g+Q==
X-Gm-Message-State: AOAM5319Ym1D61r1ECRjn2Nq9uo2aGhryj/E9kkZdMb2h2zZgrN7rmSh
        oNxW/ul00tDVFJ6Nj6kAM2TALtHqE5s=
X-Google-Smtp-Source: ABdhPJzBegZH+vHSpk6dBpTv130v85tauSHnElpnKILmQODEHeyoOLC8scVOcaUunaKeTWvaHfAoTA==
X-Received: by 2002:a50:cdca:: with SMTP id h10mr69103edj.9.1634737112576;
        Wed, 20 Oct 2021 06:38:32 -0700 (PDT)
Received: from [192.168.43.77] (82-132-229-137.dab.02.net. [82.132.229.137])
        by smtp.gmail.com with ESMTPSA id r3sm1178533edo.59.2021.10.20.06.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 06:38:32 -0700 (PDT)
Message-ID: <29d08366-fc2f-56e0-c25f-4044fdf78480@gmail.com>
Date:   Wed, 20 Oct 2021 14:38:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 15/16] block: optimise blk_may_split for normal rw
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <9ded7cf6a3af7e6e577d12a835a385657da4a69e.1634676157.git.asml.silence@gmail.com>
 <YW+2aLXepTC3uMW7@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YW+2aLXepTC3uMW7@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 07:25, Christoph Hellwig wrote:
> On Tue, Oct 19, 2021 at 10:24:24PM +0100, Pavel Begunkov wrote:
>> +	unsigned int op = bio_op(bio);
>> +
>> +	if (op != REQ_OP_READ && op != REQ_OP_WRITE && op != REQ_OP_FLUSH) {
>> +		switch (op) {
>> +		case REQ_OP_DISCARD:
>> +		case REQ_OP_SECURE_ERASE:
>> +		case REQ_OP_WRITE_ZEROES:
>> +		case REQ_OP_WRITE_SAME:
>> +			return true; /* non-trivial splitting decisions */
>> +		default:
>> +			break;
>> +		}
> 
> Nesting the if and the switch is too ugly to live.  If you want ifs do
> just them.  But I'd really like to see numbers for this, also compared
> to epxlicitly checking for REQ_OP_READ and REQ_OP_WRITE and maybe using
> __builtin_expect for those values.

What I want to get from the compiler is:

if (op <= REQ_OP_FLUSH)
	goto after_switch_label;
else switch () { ... }


Was trying to hint it somehow (gcc 11.1),

(void)__builtin_expect(op <= FLUSH, 1);

No luck, asm doesn't change. Not sure why people don't like
it, so let me ask which one is better?

1)

if (op == read || op == write ...)
	goto label;
else switch () { }

2)

if (op == read || op == write ...)
	goto label;
else if () ...
else if () ...
else if () ...


For the numbers, had profiling for the whole series (nullblk):

+    2.82%     2.82%  io_uring  [kernel.vmlinux]    [k] submit_bio_checks
+    2.51%     2.50%  io_uring  [kernel.vmlinux]    [k] submit_bio_checks

Because the relative % for "after" should grow because of other
optimisations, so the difference should be _a bit_ larger. Need to
retest.

And some asm (for submit_bio_checks()) for comparison. Before:

# block/blk-core.c:823: 		switch (op) {
	cmpl	$9, %eax	#, op
	je	.L616	#,
	ja	.L617	#,
	cmpl	$5, %eax	#, op
	je	.L618	#,
	cmpl	$7, %eax	#, op
	jne	.L696	#,
	...
.L696:
	cmpl	$3, %eax	#, op
	jne	.L621	#,
	...
.L621 (label after switch)

After:

# block/blk-core.c:822: 	if (op != REQ_OP_READ && op != REQ_OP_WRITE && op != REQ_OP_FLUSH) {
	cmpb	$2, %al	#, _18
# block/blk-core.c:822: 	if (op != REQ_OP_READ && op != REQ_OP_WRITE && op != REQ_OP_FLUSH) {
	jbe	.L616	#,
	...
.L616 (label after switch)


-- 
Pavel Begunkov
