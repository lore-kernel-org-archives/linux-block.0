Return-Path: <SRS0=IUku=4S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F152AC3F2CD
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 16:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C368621775
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 16:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="ZBzixAfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgCAQsU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Mar 2020 11:48:20 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:41728 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCAQsU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 1 Mar 2020 11:48:20 -0500
Received: by mail-pg1-f180.google.com with SMTP id b1so4165164pgm.8
        for <linux-block@vger.kernel.org>; Sun, 01 Mar 2020 08:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g0M58whjeevKdNXpdqVuYM9fLOXElDGn7qTZGQfCpLc=;
        b=ZBzixAfoW7WmW3k4veje1nP6j7A0PbP70J3pBahDWYAkQepaC1HdpmvegIivTe96u7
         nL8IqXA2TTurZuZw8xUBpm9m86Mf4frvkPvVdKyyijynSMNmoNS1jf38kPU16SzI7iwV
         sazXhhjEKnEYqXGQ9lxNWYBwZSJ7ESUCJAKn2ZjfsIHceaNhJkQuGmL/+Qq9+HLLWAkK
         9CeatbRgsT8f/Hp+O/dBu8VysrzeqwLz+6hGsp743FzySflgyAkGKq+a4fLZxCWTxLCK
         6/iejuiHvwFQBkVgnqdgVlPT72tyBiX3ax2G6Pl4SGpWmH3Y3e0raZcbrHr/Du4gsHLP
         gWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g0M58whjeevKdNXpdqVuYM9fLOXElDGn7qTZGQfCpLc=;
        b=O9HwCI7r2pnrQWva4qzgMrTFHcsyAlUHeNgQSym3wMOgUfrm6vI7VLMC7vQGlY9wOf
         Dzvbq8y2hPmweiRX4E3GyauHRpkEQi1+F0fsjnLB3W2qGk5D8lq9A+AkdOqIMoO+XOlU
         414vEcit2kbsHN0/3fgXLNg6izE10wrAIimu8akyrjVP0su3fb/713UigKSYCNzkXjV8
         oM/+6SMUxiR/YTeEZzagU28UidmF6X3xG+WXMyWy9Ww/UXGR41x6sVlRPt8byeS1CgUn
         j4SFV47Ao3TohV9jpukY1t35cFDaVrUVAKRgYfl3vD0QB6sDvJ0WgtSRVLvRwJqUTgYv
         lN3w==
X-Gm-Message-State: APjAAAU2p21+9XYConY+oPE3/e5IIgjqAaxfNmTjyIj9hqKwvyHzmUFF
        09Bl0UMP4QqbLtwYoCD2uRrhkQCzuYc7Cg==
X-Google-Smtp-Source: APXvYqyy8gMaaU2bOqh2gT3/oA8RPnAFi6lL6hpOxoO7r07XA6qTcXwJt4LDDJ6aUp0qQH9cG0lsfw==
X-Received: by 2002:a62:ce8b:: with SMTP id y133mr14256717pfg.172.1583081298859;
        Sun, 01 Mar 2020 08:48:18 -0800 (PST)
Received: from ?IPv6:240e:82:3:5b12:940:b7e:a31d:58eb? ([240e:82:3:5b12:940:b7e:a31d:58eb])
        by smtp.gmail.com with ESMTPSA id q11sm18054980pff.111.2020.03.01.08.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 08:48:18 -0800 (PST)
Subject: Re: [PATCH 5/6] block: remove unneeded argument from
 blk_alloc_flush_queue
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
 <20200228150518.10496-6-guoqing.jiang@cloud.ionos.com>
 <BYAPR04MB5749C18C7B3A998958A1A9F186E90@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <9889b6a4-928b-7ba0-54c5-ec2d0276ab81@cloud.ionos.com>
Date:   Sun, 1 Mar 2020 17:47:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5749C18C7B3A998958A1A9F186E90@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/1/20 12:19 AM, Chaitanya Kulkarni wrote:
> Looks good, except I did not count but please verify the
> patch subject length, otherwise looks good.
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> 

Thanks for your review, I assume it is fine since checkpatch didn't complain.

Thanks,
Guoqing
