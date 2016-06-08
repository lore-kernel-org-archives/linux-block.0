Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38724 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbcFHWrP (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 8 Jun 2016 18:47:15 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 8E06B20340
	for <linux-block@vger.kernel.org>; Wed,  8 Jun 2016 22:47:13 +0000 (UTC)
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com [209.85.213.49])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 4AAF8202E5
	for <linux-block@vger.kernel.org>; Wed,  8 Jun 2016 22:47:11 +0000 (UTC)
Received: by mail-vk0-f49.google.com with SMTP id d64so32052900vkb.0
        for <linux-block@vger.kernel.org>; Wed, 08 Jun 2016 15:47:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160608222557.GC1696@localhost.localdomain>
References: <1465415292-9416-1-git-send-email-mlin@kernel.org> <20160608222557.GC1696@localhost.localdomain>
From: Ming Lin <mlin@kernel.org>
Date: Wed, 8 Jun 2016 15:47:10 -0700
Message-ID: <CAF1ivSbEf-069LBRLRJKDd-e7JuF3jKrZr6yu-fANFajMGR_=w@mail.gmail.com>
Subject: Re: [PATCH 0/2] check the number of hw queues mapped to sw queues
To: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 8, 2016 at 3:25 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, Jun 08, 2016 at 03:48:10PM -0400, Ming Lin wrote:
>> Back to Jan 2016, I send a patch:
>> [PATCH] blk-mq: check if all HW queues are mapped to cpu
>> http://www.spinics.net/lists/linux-block/msg01038.html
>>
>> It adds check code to blk_mq_update_queue_map().
>> But it seems too aggresive because it's not an error that some hw queues
>> were not mapped to sw queues.
>>
>> So this series just add a new function blk_mq_hctx_mapped() to check
>> how many hw queues were mapped. And the driver(for example, nvme-rdma)
>> that cares about it will do the check.
>
> Wouldn't you prefer all 6 get assigned in this scenario instead of
> utilizing fewer resources than your controller provides? I would like
> blk-mq to use them all.

That's ideal.

But we'll always see corner case that there is hctx(s) not mapped.
So I want to at least prevent the crash and return an error in the driver.

Here is another example that I create 64 queues on a server with 72 cpus.

hctx index 0: 0, 36
hctx index 1: 1, 37
hctx index 3: 2, 38
hctx index 5: 3, 39
hctx index 7: 4, 40
hctx index 8: 5, 41
hctx index 10: 6, 42
hctx index 12: 7, 43
hctx index 14: 8, 44
hctx index 16: 9, 45
hctx index 17: 10, 46
hctx index 19: 11, 47
hctx index 21: 12, 48
hctx index 23: 13, 49
hctx index 24: 14, 50
hctx index 26: 15, 51
hctx index 28: 16, 52
hctx index 30: 17, 53
hctx index 32: 18, 54
hctx index 33: 19, 55
hctx index 35: 20, 56
hctx index 37: 21, 57
hctx index 39: 22, 58
hctx index 40: 23, 59
hctx index 42: 24, 60
hctx index 44: 25, 61
hctx index 46: 26, 62
hctx index 48: 27, 63
hctx index 49: 28, 64
hctx index 51: 29, 65
hctx index 53  30, 66
hctx index 55:  31, 67
hctx index 56:  32, 68
hctx index 58:  33, 69
hctx index 60:  34, 70
hctx index 62:  35, 71

Other hctxs are not mapped.


>
> I've been trying to change blk_mq_update_queue_map to do this, but it's
> not as easy as it sounds. The following is the simplest patch I came
> up with that gets a better mapping *most* of the time.

Not working for my case with 6 hw queues(8 cpus):

[  108.318247] nvme nvme0: 6 hw queues created, but only 5 were mapped
to sw queues

hctx_idx 0: 0 1 4 5
hctx_idx 1: None
hctx_idx 2: 2
hctx_idx 3: 3
hctx_idx 4: 6
hctx_idx 5: 7

>
> ---
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index d0634bc..941c406 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -75,11 +75,12 @@ int blk_mq_update_queue_map(unsigned int *map, unsigned int nr_queues,
>                 */
>                 first_sibling = get_first_sibling(i);
>                 if (first_sibling == i) {
> -                       map[i] = cpu_to_queue_index(nr_uniq_cpus, nr_queues,
> -                                                       queue);
> +                       map[i] = cpu_to_queue_index(max(nr_queues, (nr_cpus - queue)), nr_queues, queue);
>                         queue++;
> -               } else
> +               } else {
>                         map[i] = map[first_sibling];
> +                       --nr_cpus;
> +               }
>         }
>
>         free_cpumask_var(cpus);
> --
