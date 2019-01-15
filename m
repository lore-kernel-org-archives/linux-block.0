Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2A1C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 04:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CA22085A
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 04:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lx6YXLf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfAOEel (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:34:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43774 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfAOEel (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 23:34:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so653084pgk.10
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 20:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zK501jD2/GZKzdJMzveevnFqSdl6gSxA278Ms2OysRc=;
        b=lx6YXLf7vYtR69neQ/wznBdW33BkxHtu1GOR/6phbiU5d4Le8Gi/TWdlfCC0f9opmi
         stI5lLqq4DeddpUW/FobFmv5BfSZR83CdNOtsgNSdwQFfoOmgavLggTB4b+1zEslPTxA
         Itoal9UfSW3BvnMS+Ol7++GWLzH15Wx0qPyxt8rijTopmwm/0RnfMt8LE7EfH2AtI4Zr
         jVjjInWgaqXr+hnW4M3s0rl+A/RO6WKnJTIrW7FaWk48BzdTtFWIJHxWqznisvBS9Uqi
         3teTwGaCYor+zppxfmp1Ur4l918tivNQ77gU1VhY+8XQuxMXAdGSyhbpOGOo+6ZW371w
         FCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zK501jD2/GZKzdJMzveevnFqSdl6gSxA278Ms2OysRc=;
        b=eG2L0GinNYrwU9zEiTB71MxzJjzjq5OLSkXFJqNnNJCA4cXgJhcpBUJmQ2XSNK+K0u
         B4UpvnOfGL44nLP3r8AL0QDNA6Q/z1QcbR6lSMhMi0hDanY8hJB1uEL5klm9ny7+juss
         zLrZrD7W4p9nUkXIx6bxU6JJ9DEPUZRnG/iGIOfUeEUe4UZAwbfrl/oyPqR9vgab8+5V
         aOvuIUa4KPxJJwxIuJ9zqiUzt3vGyHMzNXh9BrIPzOLaw9ThP1ErbsABR0IiwOOJraY7
         XAVLV6p4ZwdlS2stzuVM2PoeM1UFTzb4JhGSlwt8XTVyIOqW+aNXdXMX72GQ5OuflYtN
         RBNA==
X-Gm-Message-State: AJcUukdhmwypH8EQvPzlmADpjQZ0r9GBSxdR93bp6CHU3Sg8Sn7vmWVx
        ugZDvBJVf/LqP+WruMAlhhtYeQ==
X-Google-Smtp-Source: ALg8bN64ktdiCTl++L9YfbxJDVKKI+mT3Bc65KMmq3mvY1RUrWzWG7DI9RBGDf+pgLB30Ctr6ia+vg==
X-Received: by 2002:aa7:8802:: with SMTP id c2mr2059833pfo.20.1547526880807;
        Mon, 14 Jan 2019 20:34:40 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v89sm2449973pfk.12.2019.01.14.20.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 20:34:39 -0800 (PST)
Subject: Re: [PATCH] sbitmap: Protect swap_lock from hardirq
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190115035952.13325-1-ming.lei@redhat.com>
 <e2bebd6a-cc89-d6c2-8203-718b5c12ea4f@kernel.dk>
 <CAHk-=wg76gE51qx6erfMxNh4B_cYvwxgVr1ReqEyzpNjkpMJQw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a8659157-652d-c66e-8d9d-6ff2133645c0@kernel.dk>
Date:   Mon, 14 Jan 2019 21:34:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg76gE51qx6erfMxNh4B_cYvwxgVr1ReqEyzpNjkpMJQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/14/19 9:31 PM, Linus Torvalds wrote:
> On Tue, Jan 15, 2019 at 4:28 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Thanks Ming, I'll queue this up for shipping this week.
> 
> Oops. I _just_ applied it to my tree as a follow-up to Steven's
> softirq version. I just hadn't had time to build test and push out
> yet.

No big deal, fwiw, this is what I queued up:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=8218a55b6b911d396565da4ed5ca8b18bf0d38fb

which has a spelling error fixed, and the indentation a bit nicer
for the locking scenario. But I can just drop it.

-- 
Jens Axboe

