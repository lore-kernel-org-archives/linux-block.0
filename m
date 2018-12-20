Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0DEC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 21:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3C4218FD
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 21:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbeLTVkr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:40:47 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:46856 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbeLTVkr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 16:40:47 -0500
Received: by mail-pg1-f171.google.com with SMTP id w7so1459485pgp.13
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 13:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yeQh7i8dbepu2C0Yz/QhSIjyws5hJYI37dpegN0P63g=;
        b=S4nhY29Hnx/hNFfSBwlRDqDcpd73CyZdYJu6BnbHml2Wvvm+qVcSnYEUY2pbKmQL0b
         Rp8/tNJfENnoJAqEbKc6E9snHxcD+bUQ9Im/fJwH2LZ5YgEujILopW9SB/BfxgkkLkCt
         rNuj4aeB2/j5GwoCl1YOJXIxrJP2ijXoKdFiRVzF7ReaChWAIRs814QEFEehZYyHdufN
         wi2McIWmeMuEgkU+pxWkZCUvGTtuuGiXJfRDZq0XfdjXJX71GhrtzlKnvJAzxnX8a+sv
         xlHQpFbFDZfYPXHKCO5fuForl/e0jyJdiTbrMi7Ozow1vYjBmQH4NtfVHkQX+gmaV4tC
         gdyA==
X-Gm-Message-State: AA+aEWaDYmAdvThSnedHVqw8YKx61oeLeoeE4q4WBHJrQi/v3S72bRAm
        /wpH83wcwAEgDBjaenYvZSyqlA8VA0M=
X-Google-Smtp-Source: AFSGD/X5GHN1I3orbXRi1IARhx0jN3/LVg6k37HpWjni10uVhoXvZltXyo8BjskOBuuEBG3UQpCa1Q==
X-Received: by 2002:a62:de06:: with SMTP id h6mr26656842pfg.158.1545342045351;
        Thu, 20 Dec 2018 13:40:45 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id c72sm21015611pfb.107.2018.12.20.13.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 13:40:44 -0800 (PST)
Message-ID: <1545342043.185366.523.camel@acm.org>
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Thu, 20 Dec 2018 13:40:43 -0800
In-Reply-To: <61515137-0565-e3b7-e6de-554af7d49753@kernel.dk>
References: <1545261885.185366.488.camel@acm.org>
         <74c0280c-e557-ad03-cd75-98dd6d868da3@kernel.dk>
         <1545265001.185366.496.camel@acm.org>
         <1ca5cd37-87ce-8cff-6cb4-1fdb29bd4da2@kernel.dk>
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
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-20 at 14:34 -0700, Jens Axboe wrote:
+AD4 Yeah, I don't think it's bullet proof either, it just closes the gap.
+AD4 I'm fine with fiddling with the tag iteration. On top of what I sent, we
+AD4 could have tag iteration hold the RCU read lock, and then we just need
+AD4 to ensure that the tags are freed with RCU.

Do you mean using call+AF8-rcu() to free tags? Would that require to add a
struct rcu+AF8-head to every request? Would it be acceptable to increase the
size of struct request with an rcu+AF8-head? Additionally, could that reduce
the queue depth if the time between grace periods is larger than the time
between I/O submissions?

Thanks,

Bart.
