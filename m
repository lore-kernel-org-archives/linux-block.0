Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50477 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751554AbdCXQmP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2017 12:42:15 -0400
Subject: Re: [PATCH v3 08/14] block: introduce bio_copy_data_partial
To: Ming Lei <tom.leiming@gmail.com>, Shaohua Li <shli@kernel.org>,
        <linux-raid@vger.kernel.org>, <linux-block@vger.kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>
References: <20170316161235.27110-1-tom.leiming@gmail.com>
 <20170316161235.27110-9-tom.leiming@gmail.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <f41b054c-2307-a14a-bff4-3646f876c137@fb.com>
Date: Fri, 24 Mar 2017 10:41:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170316161235.27110-9-tom.leiming@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/16/2017 10:12 AM, Ming Lei wrote:
> Turns out we can use bio_copy_data in raid1's write behind,
> and we can make alloc_behind_pages() more clean/efficient,
> but we need to partial version of bio_copy_data().
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>

Reviewed-by: Jens Axboe <axboe@fb.com>

Shaohua, feel free to pull this through the md tree, that will be much
easier.

-- 
Jens Axboe
