Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB11C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 14:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6C6217F9
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 14:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XUgxn0yo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfC1OSF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:18:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43354 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfC1OSE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 10:18:04 -0400
Received: by mail-io1-f67.google.com with SMTP id x3so17355788iol.10
        for <linux-block@vger.kernel.org>; Thu, 28 Mar 2019 07:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b+Bw10x7fkQ4mUPP787LxbVWlDvqnskQwOPw1GIlIOY=;
        b=XUgxn0yoqB4lSEJVcLxtrdLHJMMSn91CHcofLIc0cU3xgwqvytZjnsRddmnPi3B8p2
         Ht8cTGcDTCYnIKbnuTNBtmFFxzvYb9dbxvtLiNIFrhcpLzXsRAbS2KZv80UrYd6m697J
         KIFBavfr49I6SvE43E41KwbalUa9MCJvXWAFfeYbA3rGymEOCDzdbnW8bAAhWdxqn1UU
         9ZlQazl1AEVLM69hImN+25wv8KP2rFF7+xx9xM6/ZzSG9G0Lv+W6jkbtGxVDGaAmmXZE
         J+7I6SXWoFjwNvCrtanr/19r4QnkCYiwNREQUwTKZjTt7a7rmPBc8A1+DwzLsDBQ3/h6
         NmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b+Bw10x7fkQ4mUPP787LxbVWlDvqnskQwOPw1GIlIOY=;
        b=IdJUSptJK8kCn2oQ0RWRoUT6irR+ikk88q3H0q7xtos5qYSk2IoKPDnQ13quGGRoA7
         VFvifNWR6R4w+OXMLQBPuIwFtvI+dsBWgGQgPzednI1U4TWK/kVuQNiB8tk7Jv9wU41w
         L8w+Cmtr3CPcQ/KjGEYwog+y9FD/YOicmm8VVfSPfOVnTjp6hzC1WFtVNWQewvQoc0Is
         MVwpEhd1A5Mbx6PuMo1R6LgILfWqgY6/XpLC+5qZrYN+5TAEx61RHaZqoZzFU6zonyiv
         vSnEXx8zAQWyc+3n6nBcF796dfDHvnoynibVXt4JuXqggw1IlVlFtHmhRDDfesMyzxet
         fCCA==
X-Gm-Message-State: APjAAAUkplC+rkKh0MhdG8mE0AV28N9o/luKiE47LojEbjoZrlvjwZhW
        ashz9YtdRbSJQug435OwO3G27Q==
X-Google-Smtp-Source: APXvYqy01IJR6FFlfoSXsHG0PybJ8ISGQIwfKb4MLXegGHZRm/SNxb2mUmSYWBgqR/gC2yf91GQbcA==
X-Received: by 2002:a6b:c84e:: with SMTP id y75mr31872300iof.107.1553782684118;
        Thu, 28 Mar 2019 07:18:04 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b102sm1963348itd.13.2019.03.28.07.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 07:18:03 -0700 (PDT)
Subject: Re: [PATCH] block: loop: mark bvec as ITER_BVEC_FLAG_NO_REF
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
References: <20190328030531.28279-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2ac9386c-4a4f-3d39-e0be-b597fa63d0f0@kernel.dk>
Date:   Thu, 28 Mar 2019 08:18:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328030531.28279-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/19 9:05 PM, Ming Lei wrote:
> loop is one block device, for any bio submitted to this device,
> the upper layer does guarantee that pages added to loop's bio won't
> go away when the bio is in-flight.
> 
> So mark loop's bvec as ITER_BVEC_FLAG_NO_REF then get_page/put_page
> can be saved for serving loop's IO.

Curious if this is a noticable win on loop? In any case, looks
fine to me, I'll queue it up for 5.2.

-- 
Jens Axboe

