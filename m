Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BFDC0650E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 14:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18E921721
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 14:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NDZmZNXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfGAOUQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:20:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36426 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbfGAOUQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 10:20:16 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so29251043ioh.3
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 07:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gY2k8VIohQ3ovxqeqDMTJ6ugNx1qArSvmGqVd7Pptw4=;
        b=NDZmZNXBYjxdVurBwDt9g5WKl0ag//3VUaKT3FtinSCEP5Y94YcX/BINZsZ/Mu3tzi
         ZSBAxmh2aZkjJfDljLD3Ov9tHbhxX0xpfe8LghnrwYd5yACyUn1fjcssgoswM+UfRz2w
         pNzJjDgqUeXhutm+dYFFury6s38MOslCTgsNHRkUvW9258TEKv1i1fb+G/k3mzJjwC9w
         lg4fnlg3a5ETWFvz3FqAiQdUF9RYhlcCPxocYHjc2Tcz5ZtY/6JsRhUSxVVHljPak9lO
         JJABb2gemEOKBbob3AXWpoMzr5XSfC+HTj2lv5NFKWqaaDa6fe/t4eHyjrI/j8ywZAnG
         68Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gY2k8VIohQ3ovxqeqDMTJ6ugNx1qArSvmGqVd7Pptw4=;
        b=tsFbJDdH3AoxliNXGADWOoUTfTdiY4wX6rfF5a80rbgzZAHvfW33aC0S1CKvIXG/5J
         EPJ8cRGHLeTw7xrI/H/L55yepccCpBthVYPdD7CJ+R2XrPJM+h9jWGXKRFYO3fww1376
         43cM3OgGRjgmrwpbS+WdclnbFNLWzbMtGh7AikmJzmEd4164NRYnM8aTRvzjKOZtf6zh
         piX/ezdOTyaZL7r84Ifiep0ZmYBDs4piUX2c0QA1BUI8C4OFsNRA9mWtHxUiIl0s/w+U
         sksg+RQtFZwSXLidVaMjmw6SIPFSD89TByRFEws4iY6Ztv76qt9KgKfO0/7FncDEvdL7
         bOXQ==
X-Gm-Message-State: APjAAAV2KJ5iftE5SVgxu+4goQAxhrY4VrRYTiUYPNpFvpQq90CMRAys
        d58h8W753KwoGVTL4L3YBt9vyQ==
X-Google-Smtp-Source: APXvYqwSj4J+56s9p49bTmZyPQaGM1CAyE3LWgyIlQfGltnN7r1QlI1141Kni7B/XmjMjAjm5WgT7w==
X-Received: by 2002:a02:cd83:: with SMTP id l3mr26548737jap.66.1561990815765;
        Mon, 01 Jul 2019 07:20:15 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x13sm9765649ioj.18.2019.07.01.07.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 07:20:14 -0700 (PDT)
Subject: Re: [PATCH V2] block: fix .bi_size overflow
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>,
        kernel test robot <rong.a.chen@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
References: <20190701071446.22028-1-ming.lei@redhat.com>
 <8db73c5d-a0e2-00c9-59ab-64314097db26@kernel.dk>
 <bd45842a-e0fd-28a7-ac79-96f7cb9b66e4@kernel.dk>
Message-ID: <8b8dc953-e663-e3d8-b991-9d8dba9270be@kernel.dk>
Date:   Mon, 1 Jul 2019 08:20:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <bd45842a-e0fd-28a7-ac79-96f7cb9b66e4@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/19 8:14 AM, Jens Axboe wrote:
> On 7/1/19 8:05 AM, Jens Axboe wrote:
>> On 7/1/19 1:14 AM, Ming Lei wrote:
>>> 'bio->bi_iter.bi_size' is 'unsigned int', which at most hold 4G - 1
>>> bytes.
>>>
>>> Before 07173c3ec276 ("block: enable multipage bvecs"), one bio can
>>> include very limited pages, and usually at most 256, so the fs bio
>>> size won't be bigger than 1M bytes most of times.
>>>
>>> Since we support multi-page bvec, in theory one fs bio really can
>>> be added > 1M pages, especially in case of hugepage, or big writeback
>>> with too many dirty pages. Then there is chance in which .bi_size
>>> is overflowed.
>>>
>>> Fixes this issue by using bio_full() to check if the added segment may
>>> overflow .bi_size.
>>
>> Any objections to queuing this up for 5.3? It's not a new regression
>> this series.
> 
> I took a closer look, and applied for 5.3 and removed the stable tag.
> We'll need to apply your patch for stable, and I added an adapted
> one for 5.3. I don't want a huge merge hassle because of this.

OK, so we still get conflicts with that, due to both the same page
merge fix, and Christophs 5.3 changes.

I ended up pulling in 5.2-rc6 in for-5.3/block, which resolves at
least most of it, and kept the stable tag since now it's possible
to backport without too much trouble.

-- 
Jens Axboe

