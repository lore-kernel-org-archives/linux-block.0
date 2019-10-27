Return-Path: <SRS0=gXx0=YU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDC5CA9EAF
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 19:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C328A20679
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 19:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lgw5oiCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfJ0TCH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 15:02:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43206 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfJ0TCG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 15:02:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id l24so4969133pgh.10
        for <linux-block@vger.kernel.org>; Sun, 27 Oct 2019 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wgXJkM4LlINZksD97TnNf02/xyfzFX94gQb26FvFADg=;
        b=lgw5oiCksRFHX8luQUz4XSah8LRBE+YIx8H0AwT27EQX83lAmR8ql1WNKLWdEAVgyH
         widD4Dc8EUPHqYOs/JrfjdQSDtKbj8rM2DHKFIQiaM7S2bfDhllbBdrNyjiFPJfq3/JQ
         /SxGleTqUEbsgc/93PGQ35nfjrVpesxWsldnVvNjGN5hF9mSgEGJVL25hUt5nKto/+UB
         z7WFkuQWDgxvnTQwEO4Qotl2NIhrZ7m5dPYiQhPTNIHVYKa6hzOVAVwMrn/moMOxsfJW
         tMzKq6FYLWEt2s7tn08HxJwN77cEL2lJUO5uN0IN87vENWBJXNJg+c1qjlQz1zNRJfdo
         scbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wgXJkM4LlINZksD97TnNf02/xyfzFX94gQb26FvFADg=;
        b=MuWBr0rBIs3VDxY7mafVnU/0f0FRlMjXandYvAm3zfi4ZCK8/LQngpIq0AaeXS59fn
         XTsNEB1xO7BMEJV5AnGc7crYST6zTJKPr+yCeiIuB++y4/CJUrn+lhCcHp75lk11JfRw
         n6P/BB9/9aSm3Djgs6UgLMFay4Xn3hHOiTcPHI9tu0Vxo9VOE/GIYq2/KbERMabTcjy8
         oZDANGQYwH8FUFmTN88BYyt0EB3/GWn2kjDIJl+zenbNryVC5p0j/CbQW1hHG89BQoH0
         96WUqAQhunJtPhwA/P0HleYcn6gSGOQMjVvdmWsx0kdgZjMk+AAZ5xyoPpnxKRCUlPkg
         VJxQ==
X-Gm-Message-State: APjAAAW9K2rDdNUC5bU3pfTndsJ1XVrH4MKxxKrwlp/qINheDyXsq+I5
        0WBE5iChlS8l88FK70Nh5FWVgg==
X-Google-Smtp-Source: APXvYqwvrQ34A6w/KBTeYyz5Y5SXBFCdNOgKn9TyMiCQo+awUERZkXv0ZowDc4wRRkkt9VlBWvMJQQ==
X-Received: by 2002:a63:8f5e:: with SMTP id r30mr8302248pgn.146.1572202924538;
        Sun, 27 Oct 2019 12:02:04 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id b14sm8343477pfi.95.2019.10.27.12.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 12:02:03 -0700 (PDT)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <728dec9c-465c-2341-d7b5-929a50400e9c@kernel.dk>
Date:   Sun, 27 Oct 2019 13:02:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <63f93f8a-4207-3ac4-a301-4907882009c9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/19 12:56 PM, Pavel Begunkov wrote:
> On 27/10/2019 20:26, Jens Axboe wrote:
>> On 10/27/19 11:19 AM, Pavel Begunkov wrote:
>>> On 27/10/2019 19:56, Jens Axboe wrote:
>>>> On 10/27/19 10:49 AM, Jens Axboe wrote:
>>>>> On 10/27/19 10:44 AM, Pavel Begunkov wrote:
>>>>>> On 27/10/2019 19:32, Jens Axboe wrote:
>>>>>>> On 10/27/19 9:35 AM, Pavel Begunkov wrote:
>>>>>>>> A small cleanup of very similar but diverged io_submit_sqes() and
>>>>>>>> io_ring_submit()
>>>>>>>>
>>>>>>>> Pavel Begunkov (2):
>>>>>>>>        io_uring: handle mm_fault outside of submission
>>>>>>>>        io_uring: merge io_submit_sqes and io_ring_submit
>>>>>>>>
>>>>>>>>       fs/io_uring.c | 116 ++++++++++++++------------------------------------
>>>>>>>>       1 file changed, 33 insertions(+), 83 deletions(-)
>>>>>>>
>>>>>>> I like the cleanups here, but one thing that seems off is the
>>>>>>> assumption that io_sq_thread() always needs to grab the mm. If
>>>>>>> the sqes processed are just READ/WRITE_FIXED, then it never needs
>>>>>>> to grab the mm.
>>>>>>> Yeah, we removed it to fix bugs. Personally, I think it would be
>>>>>> clearer to do lazy grabbing conditionally, rather than have two
>>>>>> functions. And in this case it's easier to do after merging.
>>>>>>
>>>>>> Do you prefer to return it back first?
>>>>>
>>>>> Ah I see, no I don't care about that.
>>>>
>>>> OK, looked at the post-patches state. It's still not correct. You are
>>>> grabbing the mm from io_sq_thread() unconditionally. We should not do
>>>> that, only if the sqes we need to submit need mm context.
>>>>
>>> That's what my question to the fix was about :)
>>> 1. Then, what the case it could fail?
>>> 2. Is it ok to hold it while polling? It could keep it for quite
>>> a long time if host is swift, e.g. submit->poll->submit->poll-> ...
>>>
>>> Anyway, I will add it back and resend the patchset.
>>
>> If possible in a simple way, I'd prefer if we do it as a prep patch and
>> then queue that up for 5.4 since we now lost that optimization.  Then
>> layer the other 2 on top of that, since I'll just rebase the 5.5 stuff
>> on top of that.
>>
>> If not trivially possible for 5.4, then we'll just have to leave with it
>> in that release. For that case, you can fold the change in with these
>> two patches.
>>
> Hmm, what's the semantics? I think we should fail only those who need
> mm, but can't get it. The alternative is to fail all subsequent after
> the first mm_fault.

For the sqthread setup, there's no notion of "do this many". It just
grabs whatever it can and issues it. This means that the mm assign
is really per-sqe. What we did before, with the batching, just optimized
it so we'd only grab it for one batch IFF at least one sqe in that batch
needed the mm.

Since you've killed the batching, I think the logic should be something
ala:

if (io_sqe_needs_user(sqe) && !cur_mm)) {
	if (already_attempted_mmget_and_failed_ {
		-EFAULT end sqe
	} else {
		do mm_get and mmuse dance
	}
}

Hence if the sqe doesn't need the mm, doesn't matter if we previously
failed. If we need the mm and previously failed, -EFAULT.

-- 
Jens Axboe

