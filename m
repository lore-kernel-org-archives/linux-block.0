Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAF0C6379F
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 23:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjBNXGM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Feb 2023 18:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjBNXGJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2023 18:06:09 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808391A48A
        for <linux-block@vger.kernel.org>; Tue, 14 Feb 2023 15:05:43 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id y8so1206439ilv.1
        for <linux-block@vger.kernel.org>; Tue, 14 Feb 2023 15:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rm0NgkeBMMJp25GutovHDy5uGqqIv+F0wnILJzPaqVk=;
        b=D86ZlEmgPn6zYt3h9LajOUBIj2lvYD/XRL387/aIgai9cGLaVo7W+YT6/UFZKMx6tZ
         HzN/V11U6WHzjiu9lexALsC+tsagFh6XUFVXDvOO8C83W2GtEm2YwggXWicEO1kaGfzr
         1zQNQhmbEWp0e57sHLzueTwkD417gRp5NHhEttVzDeJfgmt1qNNkzv+tlG9rbZst3zbj
         1K95FQ6n5QVsqZgsPMKk03iFqrqEyr3X/gPH4e6GY8IeeWLlg1+DYwK3lIX958W373i6
         dFJv7jP+9u9e6kBNwIg0kWamyyc0wfAeD9Z/LqAyu7fbjcC4zTcIx9J6UVIMzdGPp9YE
         otCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rm0NgkeBMMJp25GutovHDy5uGqqIv+F0wnILJzPaqVk=;
        b=dfWk9afMmHmD5SAj7x+bKTq/GVZV6TCwRB7bA5w60izCUcO4+NaevRN7t/9wmd4506
         0xdJBTvOIiV9GYnueAhzZtqE5P/q+P17aW6q4YH9X4dXI3DF7jL8Lw8MnYquShVYhjbA
         iAS2d6naG53IzLk4fSEcVsqTiC7DpJ8O5iQPyh1N5Fmf8b8D71PwOJB5XHbfj0TrSBEW
         FX2GLwpH9hPwe+gCOQULckpFdIw/kCuyfFclkKitvkkogkrELNW8zPROnBqeJRAkxuNY
         tq3Q5zoCzyMkYcFGxYGiUJjFxm3lMWnDBBAa+DXi4PX3+6Cccr1cnfgucW53Gphdz3VE
         KTAw==
X-Gm-Message-State: AO0yUKVYuMteYMyQCJ2g4viu+jNUGy60qv+b2sMiGxfTARiNHGwcj7Kj
        zKiLUXDcrPZA8zn2I/Cskw4YKw==
X-Google-Smtp-Source: AK7set87wxmTDwtJRW0ye8r7q7aTzqoBfwNDT61LNDbHNlSoCq27WRJgV4Hmj4Wykio2W70BOuSA8w==
X-Received: by 2002:a05:6e02:1e05:b0:315:579c:9b77 with SMTP id g5-20020a056e021e0500b00315579c9b77mr308762ila.1.1676415931247;
        Tue, 14 Feb 2023 15:05:31 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t5-20020a02cca5000000b003b1f0afe484sm5239206jap.141.2023.02.14.15.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 15:05:30 -0800 (PST)
Message-ID: <867e1e3e-681b-843b-1704-effed736e13d@kernel.dk>
Date:   Tue, 14 Feb 2023 16:05:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v14 00/17] iov_iter: Improve page extraction (pin or just
 list)
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, smfrench@gmail.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230214171330.2722188-1-dhowells@redhat.com>
 <2877092.1676415412@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2877092.1676415412@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/14/23 3:56 PM, David Howells wrote:
> Hi Jens,
> 
> If you decide not to take my patches in this merge window, would you have any
> objection to my patches 1-3 and 10-11 in this series going through Steve
> French's cifs tree so that he can take my cifs iteratorisation patches?
> 
> Patches 1-3 would add filemap_splice_read() and direct_splice_read(), but not
> connect them up to anything and 10-11 would add iov_iter_extract_pages().  I
> can then give Steve a patch to make cifs use them as part of my patches for
> that.
> 
> This would only affect cifs.  See my iov-cifs branch:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-cifs
> 
> for an example of how this would look.

Let's update the branch and see how it goes... If there's more fallout, then
let's make a fallback plan for the first few.

-- 
Jens Axboe


