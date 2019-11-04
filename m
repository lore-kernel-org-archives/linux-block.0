Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CFCCA9EB5
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 18:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242B720578
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 18:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UyH0XuoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfKDSXr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:23:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44710 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfKDSXr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 13:23:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id q16so7964986pll.11
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2019 10:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0PudgELIKz23iWWj0G+9TkjgTg6/+BI92KrWbv8S9Cc=;
        b=UyH0XuoIdkWPqEEKsS6ilxYOgziqPt+ew3P79egImkXU+29pR4XWQCGsY37Y5CxtTo
         YRq7Ytxwz26riLAca8uTo1Rdpz6THc1us2XyDPSHDYFm+vA9bchhTRNSBlvkMv04zIRY
         IhT81TLLQelgMuKtwTDSG8DGcdK88sf68Tg3ckQWEEOJgv0HczIy844+r3PdltTpzoLD
         YEZkUqGbpYmOWDwFH/XYylUJ/NYsB342EzUrw99+bzL7tIzJac+cUNz+VTS3599OSZ+r
         egxlVJdw8q/L7tmT62mog+hrw9e2kvcX+P4dPgEMJ4kpZf6ZH3hvAymg0rOwIQVocPo6
         g/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0PudgELIKz23iWWj0G+9TkjgTg6/+BI92KrWbv8S9Cc=;
        b=Lir1NW9SAPK/1vWq7U96idKC5fof0PtmggYM9fN+hW+4H32zApItiP3sBCgTTUBNwx
         w7fXjbL9UB5H8zL3RjlmqURyz2zm9NeTpw9GJ5IWPf8DQkfvXqWPH7A4xGMmjogNTZBm
         JAHypWyoEZS8Lt/QW/+pENGn/C7x57UtaS2NtThDZQNJpJHGuZFA7NbrYUa5RnfGGmnu
         TBf2VF0Vg5dxCf9uebcMKW4npAQCefzE4ExY3H95EeTPkGbwVPq/znEBbHNC6xmFcqV1
         lWjFSVsSn4cE5qCw+do0LmbwPBwzBq82b8JBmQOx61Qpbyp5gtUYozk3r0VzjFESvVcz
         LR3g==
X-Gm-Message-State: APjAAAWi0U09jdEty/U90M04/hxTd2e7Onr9tq1ofo1pmafs0NZGSWAg
        DurmRmXapGwnmd0TLyJyQk+vHQ==
X-Google-Smtp-Source: APXvYqwfTxu/XteQan9t729LTkspLfPiXgTK19oiIYlbiqkKQn+MM9fyVmW2o26rcmpZhZ6iaIgtxw==
X-Received: by 2002:a17:902:d70b:: with SMTP id w11mr29398807ply.128.1572891826520;
        Mon, 04 Nov 2019 10:23:46 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1133::11f0? ([2620:10d:c090:180::8a43])
        by smtp.gmail.com with ESMTPSA id c62sm17242068pfa.92.2019.11.04.10.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 10:23:45 -0800 (PST)
Subject: Re: [PATCH V4] block: optimize for small block size IO
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>, Keith Busch <kbusch@kernel.org>,
        linux-bcache@vger.kernel.org
References: <20191102072911.24817-1-ming.lei@redhat.com>
 <20191104181403.GA8984@kmo-pixel> <20191104181541.GA21116@infradead.org>
 <20191104181742.GC8984@kmo-pixel>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f7fab4e0-58e4-76e4-a503-bb535b2a3da6@kernel.dk>
Date:   Mon, 4 Nov 2019 11:23:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104181742.GC8984@kmo-pixel>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/19 11:17 AM, Kent Overstreet wrote:
> On Mon, Nov 04, 2019 at 10:15:41AM -0800, Christoph Hellwig wrote:
>> On Mon, Nov 04, 2019 at 01:14:03PM -0500, Kent Overstreet wrote:
>>> On Sat, Nov 02, 2019 at 03:29:11PM +0800, Ming Lei wrote:
>>>> __blk_queue_split() may be a bit heavy for small block size(such as
>>>> 512B, or 4KB) IO, so introduce one flag to decide if this bio includes
>>>> multiple page. And only consider to try splitting this bio in case
>>>> that the multiple page flag is set.
>>>
>>> So, back in the day I had an alternative approach in mind: get rid of
>>> blk_queue_split entirely, by pushing splitting down to the request layer - when
>>> we map the bio/request to sgl, just have it map as much as will fit in the sgl
>>> and if it doesn't entirely fit bump bi_remaining and leave it on the request
>>> queue.
>>>
>>> This would mean there'd be no need for counting segments at all, and would cut a
>>> fair amount of code out of the io path.
>>
>> I thought about that to, but it will take a lot more effort.  Mostly
>> because md/dm heavily rely on splitting as well.  I still think it is
>> worthwhile, it will just take a significant amount of time and we
>> should have the quick improvement now.
> 
> We can do it one driver at a time - driver sets a flag to disable
> blk_queue_split(). Obvious one to do first would be nvme since that's where it
> shows up the most.
> 
> And md/md do splitting internally, but I'm not so sure they need
> blk_queue_split().

I'm a big proponent of doing something like that instead, but it is a
lot of work. I absolutely hate the splitting we're doing now, even
though the original "let's work as hard as we add add page time to get
things right" was pretty abysmal as well.

-- 
Jens Axboe

