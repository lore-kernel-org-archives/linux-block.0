Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0211C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 16:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8995F21773
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 16:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfBSQsM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:48:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36075 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfBSQsM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 11:48:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id n22so10494372pfa.3
        for <linux-block@vger.kernel.org>; Tue, 19 Feb 2019 08:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uaraASNSnWwxjSvT5Cp6zL7Rz8GkYfmy/keGzwwuZOo=;
        b=iYgwj3YOjXDOh7WwYlQNM5M1IhxfSa0sEbMOmg6f0jh4SI7IA9/f4Egw4u3AGcj0gT
         eyjouOTIpUtrS9nXk/Cc5r3CNMcSAoQ3K84cGzM2yZzmBYmjdelUJB/VktluoT4Lvqes
         0s2md3cHIsUvXXDMNeuGBvl7KLCbXWhbFSA/XwkRnC5wNxOatCh2G3EPwcgamE/Aa/u4
         Bc6kv+lmRQXZv5aTTXLdijHSbryXirYbeBKs1Y66DW8mefDxbc+YBI1miTG712CgNyvk
         njcub59XLUleFG95PhxyL5rlHvzRG4evX8atqDIcxl0bYu6ASebPTXQb/8IvzlP4NOie
         b6hw==
X-Gm-Message-State: AHQUAuYdm+X9jfHqdj0othWao2SkNmwESgRL/2JRrN4vae69nVmT4jgW
        GF2oEk7y90D0nkWn9nFFRMY=
X-Google-Smtp-Source: AHgI3Ia8mVV45bGdA9hvxp0IlDhBHaVEMkB7ShOCx43/9ZKiqCrkNWTYNX2FXND7438udacDJ34QVQ==
X-Received: by 2002:a63:be4d:: with SMTP id g13mr24864485pgo.378.1550594891619;
        Tue, 19 Feb 2019 08:48:11 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id c124sm23932086pfb.3.2019.02.19.08.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 08:48:10 -0800 (PST)
Message-ID: <1550594889.31902.126.camel@acm.org>
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Evan Green <evgreen@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Tue, 19 Feb 2019 08:48:09 -0800
In-Reply-To: <CAE=gft5H83gC2ay63druSr4sCznrXKvKd=FCTXpx_c2F3Z+icA@mail.gmail.com>
References: <1545261885.185366.488.camel@acm.org>
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
         <1864f5b8-cf64-a406-a3e0-9f5124ff95b5@kernel.dk>
         <a04dee3c-f355-4d28-caa4-21c7265ccae4@kernel.dk>
         <5869f2ed-dc65-135f-f12f-c14a1184125e@kernel.dk>
         <71fb9eff-43eb-24aa-fb67-be56a3a97983@kernel.dk>
         <1550187391.31902.87.camel@acm.org>
         <CAE=gft5H83gC2ay63druSr4sCznrXKvKd=FCTXpx_c2F3Z+icA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-02-15 at 10:29 -0800, Evan Green wrote:
+AD4 I got all turned around while trying to understand this fix, and I'll
+AD4 admit it's probably just me. It looks like you're trying to use an rcu
+AD4 lock to prevent the iter functions from racing with free. Is that
+AD4 true? But then the race at least as I understand it wasn't that there
+AD4 was a free in-flight, it's that the free had happened a long time ago,
+AD4 and there was still a stale value in tags-+AD4-rqs+AFs-bitnr+AF0. So maybe
+AD4 there's some other issue that part is solving?
+AD4 
+AD4 And then it looks like you added a new struct where tags-+AD4-rqs was so
+AD4 that you could compare hctx-+AD4-queue without reaching through rq. I have
+AD4 no idea if that's sufficient to prevent stale accesses through rq.
+AD4 Since you're changing multiple values I think where you populate that
+AD4 structure you'd at least need to do something like: clear rq, barrier,
+AD4 set hctx, barrier, set rq. But like Bart said, that's probably not the
+AD4 right way to go.
+AD4 
+AD4 Finally, I didn't really get why the conditional in
+AD4 blk+AF8-mq+AF8-rq+AF8-inflight() changed. Is that guarding against some other
+AD4 identified problem, or just an additional check you can do when you
+AD4 convert rqs into a struct?
+AD4 
+AD4 It looks like blk+AF8-mq+AF8-free+AF8-rqs() might be the magic function I was
+AD4 looking for earlier. Would it be possible to just clear tags+AFs-rq-+AD4-tag+AF0
+AD4 for each static+AF8-rq? Or is it possible for rqs from one set to end up
+AD4 in the tags array of another set? (Which would make what I just
+AD4 suggested insufficient).

Hi Evan,

Multiple request queues can share a single tag set. Examples of use cases
are NVMe namespaces associated with the same NVMe controller and SCSI LUNs
associated with the same SCSI host. The code that allocates a request not
only marks a tag as allocated but also updates the rqs+AFsAXQ array in the
tag set (see also blk+AF8-mq+AF8-get+AF8-request()). The code that iterates over a
tag set examines both the tag bitmap and the rqs+AFsAXQ array. The code that
allocates requests and the code that iterates over requests are not
serialized against each other. That is why the association of a tag with a
request queue can change while iterating over a tag set.

Another race condition is that a request can be allocated or freed while
iterating over a tag set.

Fixing these race conditions would require a locking mechanism and I think
the performance overhead of such a locking mechanism is larger than
acceptable. So code that iterates over requests either must be able to
handle such race conditions or must suspend request processing before it
iterates over requests.

This is why I'm in favor of only modifying blk+AF8-mq+AF8-free+AF8-rqs() such that the
memory in which the tags are stored is delayed until a grace period has
occurred.

Bart.
