Return-Path: <SRS0=gXx0=YU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375F0CA9EBD
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 19:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC9C20650
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 19:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="U4eHsFpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfJ0Tvi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 15:51:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43287 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfJ0Tvi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 15:51:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id 3so5128980pfb.10
        for <linux-block@vger.kernel.org>; Sun, 27 Oct 2019 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cQSTfOLjfDbfxLSX98qKnRcVqxW4gsyw1IBc/12j3FI=;
        b=U4eHsFpHVC6NVLadllfJVPTF1zI0tOLco2eoKyzSK8fABH++iKb6gPej7PtopTHYlE
         wJObJdvVa3R7V9x6nzgxFzs4mqZiAHSAooA2oKrVfvP5pYVRDti2bw6OHpzyX0hNWFjn
         h1rShHBE7NrVt5QaZYCQKtCHZJKHKP8YUj8UtApQfEWNs0bxfHVO5OJFon+kRiKAq0az
         8BQRf63rNz4bXSxSo8D+J2CoFuJCGlN6/49cjWwX354fIQs3hIE7QcKLiJ69+XjYs++Y
         H9cn+tqokIYys0Y71DK1Mi/oWF+fQO78y76kFgklThn9smSdtRo7j50lP5bSPIAb4qJv
         /o4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cQSTfOLjfDbfxLSX98qKnRcVqxW4gsyw1IBc/12j3FI=;
        b=ZFFhS6cyIlJXNstbcPD5+S8Etb3kZZnv+QLGSDR0VaRZlXfXanmbiFtk8Wl3dYrhW1
         Yz4heL93sUOLZcsN7jYPA+z+gmacaYWbmsFwxEmIjjoq4f06+3M+zb7ARD6/h8J+RbIs
         DOktNKArbjX1JnbHg7h8VrYD8D/WfArvGEkjm0rSVUghi9155f59u/OYVXmQu5NLI6Bn
         Vq1635YrEFAb8oL3Lm3gn5jUg/ZxsBljoQVQWL2QUBC4KK56dG8LE90H8GkQZqdzy7JR
         XHwmOtd5D+kPbMQw+HZPD65ou+Np2ELAG/woK983C4gSiFWURmqVL/3h4ntFLMpg0b5i
         +cEQ==
X-Gm-Message-State: APjAAAWAWUpqG4zfNx4TuTl6t93GdXEzAvrRZZmaAJseG+0Ygba21Rn1
        z3ZN/CoT7rGR0cgi6sWGSAw0ng==
X-Google-Smtp-Source: APXvYqyD5wGiykhjuXfco548VRffM9nDrUsNeXenPdMnRTu5PuNUPCa6AcUKF10DHLKDe0+cgpZWrQ==
X-Received: by 2002:a17:90a:62cc:: with SMTP id k12mr18797564pjs.142.1572205896221;
        Sun, 27 Oct 2019 12:51:36 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id u36sm10075598pgn.29.2019.10.27.12.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 12:51:35 -0700 (PDT)
Subject: Re: [PATCH 0/2][for-next] cleanup submission path
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1572189860.git.asml.silence@gmail.com>
 <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>
 <5ec9bd14-d8f2-32e6-7f25-0ca7256c408a@gmail.com>
 <aac65fe2-6c51-3baf-eee7-af5a8f633bf2@kernel.dk>
 <d39a878f-9dac-1457-6bba-01afc6268a84@kernel.dk>
 <57db9960-0b31-9f40-c13b-1db6dcc88920@gmail.com>
 <02a25d12-1f44-de18-f233-b5421c608469@kernel.dk>
 <63f93f8a-4207-3ac4-a301-4907882009c9@gmail.com>
 <728dec9c-465c-2341-d7b5-929a50400e9c@kernel.dk>
 <3b8b84d0-cde2-6bb0-c903-a1d71f9b83e2@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3957148b-0dac-a621-8f12-5d2d45557e24@kernel.dk>
Date:   Sun, 27 Oct 2019 13:51:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3b8b84d0-cde2-6bb0-c903-a1d71f9b83e2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/19 1:17 PM, Pavel Begunkov wrote:
> On 27/10/2019 22:02, Jens Axboe wrote:
>> On 10/27/19 12:56 PM, Pavel Begunkov wrote:
>>> On 27/10/2019 20:26, Jens Axboe wrote:
>>>> On 10/27/19 11:19 AM, Pavel Begunkov wrote:
>>>>> On 27/10/2019 19:56, Jens Axboe wrote:
>>>>>> On 10/27/19 10:49 AM, Jens Axboe wrote:
>>>>>>> On 10/27/19 10:44 AM, Pavel Begunkov wrote:
>>>>>>>> On 27/10/2019 19:32, Jens Axboe wrote:
>>>>>>>>> On 10/27/19 9:35 AM, Pavel Begunkov wrote:
>>>>>>>>>> A small cleanup of very similar but diverged io_submit_sqes() and
>>>>>>>>>> io_ring_submit()
>>>>>>>>>>
>>>>>>>>>> Pavel Begunkov (2):
>>>>>>>>>>         io_uring: handle mm_fault outside of submission
>>>>>>>>>>         io_uring: merge io_submit_sqes and io_ring_submit
>>>>>>>>>>
>>>>>>>>>>        fs/io_uring.c | 116 ++++++++++++++------------------------------------
>>>>>>>>>>        1 file changed, 33 insertions(+), 83 deletions(-)
>>>>>>>>>
>>>>>>>>> I like the cleanups here, but one thing that seems off is the
>>>>>>>>> assumption that io_sq_thread() always needs to grab the mm. If
>>>>>>>>> the sqes processed are just READ/WRITE_FIXED, then it never needs
>>>>>>>>> to grab the mm.
>>>>>>>>> Yeah, we removed it to fix bugs. Personally, I think it would be
>>>>>>>> clearer to do lazy grabbing conditionally, rather than have two
>>>>>>>> functions. And in this case it's easier to do after merging.
>>>>>>>>
>>>>>>>> Do you prefer to return it back first?
>>>>>>>
>>>>>>> Ah I see, no I don't care about that.
>>>>>>
>>>>>> OK, looked at the post-patches state. It's still not correct. You are
>>>>>> grabbing the mm from io_sq_thread() unconditionally. We should not do
>>>>>> that, only if the sqes we need to submit need mm context.
>>>>>>
>>>>> That's what my question to the fix was about :)
>>>>> 1. Then, what the case it could fail?
>>>>> 2. Is it ok to hold it while polling? It could keep it for quite
>>>>> a long time if host is swift, e.g. submit->poll->submit->poll-> ...
>>>>>
>>>>> Anyway, I will add it back and resend the patchset.
>>>>
>>>> If possible in a simple way, I'd prefer if we do it as a prep patch and
>>>> then queue that up for 5.4 since we now lost that optimization.  Then
>>>> layer the other 2 on top of that, since I'll just rebase the 5.5 stuff
>>>> on top of that.
>>>>
>>>> If not trivially possible for 5.4, then we'll just have to leave with it
>>>> in that release. For that case, you can fold the change in with these
>>>> two patches.
>>>>
>>> Hmm, what's the semantics? I think we should fail only those who need
>>> mm, but can't get it. The alternative is to fail all subsequent after
>>> the first mm_fault.
>>
>> For the sqthread setup, there's no notion of "do this many". It just
>> grabs whatever it can and issues it. This means that the mm assign
>> is really per-sqe. What we did before, with the batching, just optimized
>> it so we'd only grab it for one batch IFF at least one sqe in that batch
>> needed the mm.
>>
>> Since you've killed the batching, I think the logic should be something
>> ala:
>>
>> if (io_sqe_needs_user(sqe) && !cur_mm)) {
>> 	if (already_attempted_mmget_and_failed_ {
>> 		-EFAULT end sqe
>> 	} else {
>> 		do mm_get and mmuse dance
>> 	}
>> }
>>
>> Hence if the sqe doesn't need the mm, doesn't matter if we previously
>> failed. If we need the mm and previously failed, -EFAULT.
>>
> That makes sense, but a bit hard to implement honoring links and drains

If it becomes too complicated or convoluted, just drop it. It's not
worth spending that much time on.

-- 
Jens Axboe

