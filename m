Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB97C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 23:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB99720823
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 23:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB99720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbeKTJkr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:40:47 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45825 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeKTJkr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 04:40:47 -0500
Received: by mail-oi1-f196.google.com with SMTP id b141so17706745oii.12;
        Mon, 19 Nov 2018 15:14:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H+vwkw4s3HWTlmePMdcER3xmyz7Je6QOFuVTtTFIqB4=;
        b=A0tC/m0z7WucSn+N7cJFJFkaImPcARQIJTi6DnesOjnkt+hpZxbhwiZWhOlqeuT3eI
         GwJyUfLm0orop7aPO3FR8xU6LdUPBNwwxFKbQf+mCgm7nEh5BZjpjWhT8r22N+tFUDK9
         b2j2Fg3HqUmgL7ErrXN72lB61/EFw2X+ByudvUav/m12xCAXxrrK4sxvwV1fqkEPuPGc
         4+UATU9elVUrxaCNvIBhNSef+ojVJ6viocPp4Qews44w0lwf4aofsdaf6LK4T8E+OOsP
         87e/6dVx+++LuIWdsLrB18TtyRFq6bL8MIzeSA1XzqYB5FKEdrRFsfbmIIbtI6cS23oy
         jd/A==
X-Gm-Message-State: AGRZ1gLKCGw+q8LsCdr777uGqjukdcY5pPif+wsUCxn4pSoIm+whUg5H
        Uuz9oRwn/x/aNPOmXFigrmM=
X-Google-Smtp-Source: AJdET5f0GLcoEk9Xvz+PeS9jXE7xsyw64EyyZrQQs9/QeULpuNJ+/cb6drl4xQISXi4qbd/T4ZYytA==
X-Received: by 2002:aca:5e0b:: with SMTP id s11mr1538029oib.62.1542669286959;
        Mon, 19 Nov 2018 15:14:46 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id p7sm16195937ote.75.2018.11.19.15.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 15:14:46 -0800 (PST)
Subject: Re: [PATCH 10/11] nvmet-tcp: add NVMe over TCP target driver
To:     David Miller <davem@davemloft.net>
Cc:     sagi@lightbitslabs.com, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, keith.busch@intel.com, hch@lst.de,
        linux-nvme@lists.infradead.org
References: <20181115171626.9306-11-sagi@lightbitslabs.com>
 <20181117.121510.1754018619653365187.davem@davemloft.net>
 <21b60ffc-d9eb-2f2e-fa1a-891f7f8d5239@grimberg.me>
 <20181119.145343.2254073323355763213.davem@davemloft.net>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f4997fa5-a0f1-2783-4732-15fbd7fcafd8@grimberg.me>
Date:   Mon, 19 Nov 2018 15:14:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119.145343.2254073323355763213.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> I would love you to look at skb_copy_and_hash_datagram_iter as these
>> changes will require an ack from you.
> 
> My first impression is that we now have this kind of code pattern
> in at least two main places and now this will be a third.
> 
> I know that nobody likes callbacks because of spectre, but all of
> these cases could be done with something like:
> 
> int __skb_datagram_iter(const struct sk_buff *skb, int offset,
> 			struct iov_iter *to, int len,
> 			int (*cb)(void *, int, struct iov_iter *, void *),
> 			void *data)
> {
> 	...
> 		n = cb(skb->data + offset, copy, to, data);
> 	...
> }
> 
> You get the idea.  Then we have one version of all the loops and
> the different (copy, copy+csum, copy+hash) cases all can be
> handled by __skb_datagram_iter() but just with a different 'cb'
> and private 'data'.

I already thought about that, but the fact that we copy both a buffer
and a page to the iter (in the most general case) we'd have to carry
two callbacks for indirection.. That wasn't something I thought as
acceptable...

I guess we could rework skb_copy_datagram_iter to not call
copy_page_to_iter and open-code kmapping so we can get away with a
single code path? Unless I'm missing something?

Also, looking a bit closer there is a slight difference between the copy
vs. the copy_and_csum variants. copy allows for a short_copy if we copy
less than we expect while the csum faults it. I'm thinking that the
copy_and_hash variant should also fault? Although I'm not sure I
understand the fault entirely as csum is supposed to be cumulative, any
insight?
