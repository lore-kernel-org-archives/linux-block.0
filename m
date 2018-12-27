Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064DDC43387
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 20:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B7C21741
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 20:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KzHi2Wr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbeL0U1W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:27:22 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38600 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbeL0U1W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Dec 2018 15:27:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so9151922plb.5
        for <linux-block@vger.kernel.org>; Thu, 27 Dec 2018 12:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=36KXgKbJzuAXhYHJ0B1wYo2C67S/lca8+nh4Z3NxHQY=;
        b=KzHi2Wr1uSjpflJja3Vh+a01EAA0YbZL1xp3l4vBiwAOziDJPATY/6PmQSxds05bXd
         4o+XYXnHQGlz3K4/DLPVlRNh65binAjNnlkL+ZCrVYp1KW7GppfbrZkP9lXa0JLquIVq
         S5rDxPD2dB8BhhzCxSCmd9oUWKaBXIkBNM5LCn7fcsGiES251dHPmUfE97faTU4XK44t
         lopjsHtb6a37T4+EOHjhr3FQIQdnl5FrQ0LJCrmt6LS/RVL+/ggKxW+Nd+1dYKOhp9Ro
         qA3Tf3cebytZjgjzWB2eJVy4aWhKGeGU+whh0WkC4DFigZOPf4IXvF6o87ui5IblKX8c
         wI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=36KXgKbJzuAXhYHJ0B1wYo2C67S/lca8+nh4Z3NxHQY=;
        b=gGAFzmaob5BSYx/kL9O/4RACSEiG8x5L5cAJO8J+L0bWDfCvB3J+DtGdJGoSWr0EQH
         r/2G91YFHNcENLaPwO76Uy7xGI/VI4+uMLwnkczI/I+LtHG2D4b3BtFQ7iJ0O2xK3jn1
         Bn08c25J7hbs6owEvmrtLW1+i1rxpnPpq4pll69ALTL/3X70LNChUXsFwgCc/rqyaMAT
         vxgaQ9gqc+sfeCe0vEA7rJWHZMgSP9mNxNqHQBga7izUWV5K+uX0C8W3/FbEvaYGuLZK
         ceWUgRdg4Xodjqqv/Ieyyvx8VS8gJrHIlXvIg8jlDoIu2nSkiu07tku2YlEJzTL7rvc0
         uurg==
X-Gm-Message-State: AJcUukeSE4BbGo/ZcBJ8UFqNaXimzMnPbOjOQypIODlvy1l1cdLlhK8Z
        i4ZLeVxYE08+BOVUK+MdxvAiLg==
X-Google-Smtp-Source: ALg8bN7SuqLavdVuyQJa2ikarZ+UsEdIgP4od0A1zsZMFTY7jagEGgiz6J4nSecKeOuC/Em/DJTI6Q==
X-Received: by 2002:a17:902:7201:: with SMTP id ba1mr24861746plb.105.1545942441450;
        Thu, 27 Dec 2018 12:27:21 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u186sm57923536pfu.51.2018.12.27.12.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 12:27:20 -0800 (PST)
Subject: Re: [PATCH 07/22] aio: add io_setup2() system call
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk
References: <20181221192236.12866-1-axboe@kernel.dk>
 <20181221192236.12866-8-axboe@kernel.dk>
 <20181227135509.GA25525@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a642ec29-4894-d75e-5040-47f3eda8f759@kernel.dk>
Date:   Thu, 27 Dec 2018 13:27:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181227135509.GA25525@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/27/18 6:55 AM, Christoph Hellwig wrote:
> On Fri, Dec 21, 2018 at 12:22:21PM -0700, Jens Axboe wrote:
>> This is just like io_setup(), except add a flags argument to let the
>> caller control/define some of the io_context behavior.
>>
>> Outside of the flags, we add two user pointers for future use.
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Hmm, I don't think think I was fine with the current version..

https://marc.info/?l=linux-fsdevel&m=154539128525404&w=2

>> +/* sys_io_setup2:
>> + *	Like sys_io_setup(), except that it takes a set of flags
>> + *	(IOCTX_FLAG_*), and some pointers to user structures:
>> + *
>> + *	*user1 - reserved for future use
>> + *
>> + *	*user2 - reserved for future use.
>> + */
>> +SYSCALL_DEFINE5(io_setup2, u32, nr_events, u32, flags, void __user *, user1,
>> +		void __user *, user2, aio_context_t __user *, ctxp)
> 
> Most importantly I'm really worried about these new user1 and user2
> fields, which aren't really used for aio poll.  They are used for
> the I/O ring, which while I think is a really great concept, I am also
> worried about overlaying into the aio interface just creating confusion..

As I said before, I don't want to create something entirely new just for
the sake of it. We end up reusing basically all aio data structures and
code paths, of course with some deviations here and there.

I don't see why it would cause confusion. Existing aio users are going
to be using io_setup(2) and nothing changes on that front. If you want
polled aio without using the ring, you can do so with io_setup2(2).
The fact that the ring addition ends up being setup in the same
fashion doesn't seem problematic to me. For the polled part, 99%
of the code ends up being the same.

-- 
Jens Axboe

