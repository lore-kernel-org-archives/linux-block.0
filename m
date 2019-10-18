Return-Path: <SRS0=h0yA=YL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A161ECA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 17:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6991D2064A
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 17:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="T3CUw3dP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442958AbfJRRGA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:06:00 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44855 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439688AbfJRRGA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 13:06:00 -0400
Received: by mail-il1-f194.google.com with SMTP id f13so6165502ils.11
        for <linux-block@vger.kernel.org>; Fri, 18 Oct 2019 10:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LI0KxJ0BHHV0qOVxpsWWOfoVB8Z4JfOaAF9APqn8fNg=;
        b=T3CUw3dPgZwmDwwdcN832bKz36vNnzXidvy52d5iIV74zfQ//yrWXrSx53y4JUyIXw
         vSKMKAKDhP32tLeXHO5ZbfLeM2oyW9tzo1z8W7hQE9d5ud+8wa5ryZFKQMgFFjiF86vM
         vbfDheQ9CUGY+nrCV95P47mMOhItpYMfjnY2oz4GdGM7IiGS3bAYEjWp9GqkYgxtMtfm
         cgHahXi0ykBpdiAbqHtr8GjmIcrmz8PvNcGqxhoKaZ62XrFpz+mPSPQnEbMYz5/+mB5V
         fDhz5Vp9TySTDVg9HbN+WqSlfpRSxU5r/PFAE0ecpZGS/Dw43peQ6sjIFzOIh9qs2OQL
         yEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LI0KxJ0BHHV0qOVxpsWWOfoVB8Z4JfOaAF9APqn8fNg=;
        b=uMY9tOQK7mdNknX6b1UcsH/gTacVYMz35JmGwhkiu3sbiZXfCYH8y98eW1VUpqgvjY
         WiKGgX4+z3aE0ceGPKSJFg744ulDD5Zmki+EB7HlGSCSPwZffV0Rcs6V9s+NLKDic3LB
         YBwHWBn6KLkS1Za2odQzs4LUk5DulWzdL/PDF7LvCtfWvLEVxyilHpbZ7hn1cygZkCtp
         6AtNAXYrMzUOC7CDLd57NrWHFiQPs9LQj/TPUSgnZaXaq3Ho1JiSMU9XNW+2oyxCQ46i
         EczeF8Xqza+SPyr4U6txYiFJtkw+3yo9fv/lwTWpy1CHN7I5UOrZsbeMpaa2M1kiToj6
         mxQA==
X-Gm-Message-State: APjAAAX4JsviMLBpcy9JDD1d/a1TzmYAeo4BkyUjygeErlR818xXbXBS
        00DY8I3j3jXWhYMCFXjMr88Etw==
X-Google-Smtp-Source: APXvYqxMqVdFt/COF3gZpVYYaa8mtogBI2LIr1/mba/q1e39RybCYbGnKrKtWFyEafm+vJcaTq60TQ==
X-Received: by 2002:a92:8591:: with SMTP id f139mr11789437ilh.87.1571418357947;
        Fri, 18 Oct 2019 10:05:57 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r5sm2755626ill.12.2019.10.18.10.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 10:05:56 -0700 (PDT)
Subject: Re: [PATCH 1/3] io_uring: add support for async work inheriting files
 table
From:   Jens Axboe <axboe@kernel.dk>
To:     Jann Horn <jannh@google.com>
Cc:     linux-block@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
References: <20191017212858.13230-1-axboe@kernel.dk>
 <20191017212858.13230-2-axboe@kernel.dk>
 <CAG48ez0G2y0JS9=S2KmePO3xq-5DuzgovrLFiX4TJL-G897LCA@mail.gmail.com>
 <0fb9d9a0-6251-c4bd-71b0-6e34c6a1aab8@kernel.dk>
 <CAG48ez181=JoYudXee0KbU0vDZ=EbxmgB7q0mmjaA0gyp6MFBQ@mail.gmail.com>
 <a54329d5-a128-3ccd-7a12-f6cadaa20dbf@kernel.dk>
 <CAG48ez1SDQNHjgFku4ft4qw9hdv1g6-sf7-dxuU_tJSx+ofV-w@mail.gmail.com>
 <dbcf874d-8484-9c27-157a-c2752181acb5@kernel.dk>
 <CAG48ez3KwaQ3DVH1VoWxFWTG2ZfCQ6M0oyv5vZqkLgY0QDEdiw@mail.gmail.com>
 <a8fb7a1f-69c7-bf2a-b3dd-7886077d234b@kernel.dk>
 <572f40fb-201c-99ce-b3f5-05ff9369b895@kernel.dk>
 <CAG48ez12pteHyZasU8Smup-0Mn3BWNMCVjybd1jvXsPrJ7OmYg@mail.gmail.com>
 <20b44cc0-87b1-7bf8-d20e-f6131da9d130@kernel.dk>
Message-ID: <2d208fc8-7c24-bca5-3d4a-796a5a8267eb@kernel.dk>
Date:   Fri, 18 Oct 2019 11:05:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20b44cc0-87b1-7bf8-d20e-f6131da9d130@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/19 10:36 AM, Jens Axboe wrote:
>> Ignoring the locking elision, basically the logic is now this:
>>
>> static void io_sq_wq_submit_work(struct work_struct *work)
>> {
>>           struct io_kiocb *req = container_of(work, struct io_kiocb, work);
>>           struct files_struct *cur_files = NULL, *old_files;
>>           [...]
>>           old_files = current->files;
>>           [...]
>>           do {
>>                   struct sqe_submit *s = &req->submit;
>>                   [...]
>>                   if (cur_files)
>>                           /* drop cur_files reference; borrow lifetime must
>>                            * end before here */
>>                           put_files_struct(cur_files);
>>                   /* move reference ownership to cur_files */
>>                   cur_files = s->files;
>>                   if (cur_files) {
>>                           task_lock(current);
>>                           /* current->files borrows reference from cur_files;
>>                            * existing borrow from previous loop ends here */
>>                           current->files = cur_files;
>>                           task_unlock(current);
>>                   }
>>
>>                   [call __io_submit_sqe()]
>>                   [...]
>>           } while (req);
>>           [...]
>>           /* existing borrow ends here */
>>           task_lock(current);
>>           current->files = old_files;
>>           task_unlock(current);
>>           if (cur_files)
>>                   /* drop cur_files reference; borrow lifetime must
>>                    * end before here */
>>                   put_files_struct(cur_files);
>> }
>>
>> If you run two iterations of this loop, with a first element that has
>> a ->files pointer and a second element that doesn't, then in the
>> second run through the loop, the reference to the files_struct will be
>> dropped while current->files still points to it; current->files is
>> only reset after the loop has ended. If someone accesses
>> current->files through procfs directly after that, AFAICS you'd get a
>> use-after-free.
> 
> Amazing how this is still broken. You are right, and it's especially
> annoying since that's exactly the case I originally talked about (not
> flipping current->files if we don't have to). I just did it wrong, so
> we'll leave a dangling pointer in ->files.
> 
> The by far most common case is if one sqe has a files it needs to
> attach, then others that also have files will be the same set. So I want
> to optimize for the case where we only flip current->files once when we
> see the files, and once when we're done with the loop.
> 
> Let me see if I can get this right...

I _think_ the simplest way to do it is simply to have both cur_files and
current->files hold a reference to the file table. That won't really add
any extra cost as the double increments / decrements are following each
other. Something like this incremental, totally untested.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2fed0badad38..b3cf3f3d7911 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2293,9 +2293,14 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 			put_files_struct(cur_files);
 		cur_files = s->files;
 		if (cur_files && cur_files != current->files) {
+			struct files_struct *old;
+
+			atomic_inc(&cur_files->count);
 			task_lock(current);
+			old = current->files;
 			current->files = cur_files;
 			task_unlock(current);
+			put_files_struct(old);
 		}
 
 		if (!ret) {
@@ -2390,9 +2395,13 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 		mmput(cur_mm);
 	}
 	if (old_files != current->files) {
+		struct files_struct *old;
+
 		task_lock(current);
+		old = current->files;
 		current->files = old_files;
 		task_unlock(current);
+		put_files_struct(old);
 	}
 	if (cur_files)
 		put_files_struct(cur_files);

-- 
Jens Axboe

