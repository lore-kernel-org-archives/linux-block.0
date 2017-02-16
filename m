Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35317 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbdBPNc1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2017 08:32:27 -0500
MIME-Version: 1.0
In-Reply-To: <4a700de4-8540-d5d8-8c58-3465c0a7a55a@suse.de>
References: <1487245547-24384-1-git-send-email-tom.leiming@gmail.com>
 <1487245547-24384-14-git-send-email-tom.leiming@gmail.com> <4a700de4-8540-d5d8-8c58-3465c0a7a55a@suse.de>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 16 Feb 2017 21:32:25 +0800
Message-ID: <CACVXFVOf=4yjNRfemcYEYCc7eeQeL9Esp_WM9ELgX77S1LT+1g@mail.gmail.com>
Subject: Re: [PATCH 13/17] md: raid1: use bio_segments_all()
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT"
        <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 16, 2017 at 8:35 PM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> On 02/16/2017 12:45 PM, Ming Lei wrote:
>> @@ -998,7 +998,8 @@ static void alloc_behind_pages(struct bio *bio, struct r1bio *r1_bio)
>>  {
>>       int i;
>>       struct bio_vec *bvec;
>> -     struct bio_vec *bvecs = kzalloc(bio->bi_vcnt * sizeof(struct bio_vec),
>> +     unsigned vcnt = bio_segments_all(bio);
>> +     struct bio_vec *bvecs = kzalloc(vcnt * sizeof(struct bio_vec),
>>                                       GFP_NOIO);
>
> Maybe use kcalloc() instead of kzalloc() with a multiplication.

That doesn't belong to this patch, which just wants to remove direct
access to .bi_vcnt.


Thanks,
Ming Lei
