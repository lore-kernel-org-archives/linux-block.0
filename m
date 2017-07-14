Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36140 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753599AbdGNNrb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2017 09:47:31 -0400
Received: by mail-vk0-f67.google.com with SMTP id y70so5786381vky.3
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2017 06:47:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170714134051.22756-1-dsterba@suse.com>
References: <20170714134051.22756-1-dsterba@suse.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 14 Jul 2017 21:47:30 +0800
Message-ID: <CACVXFVP_a5kofmW-Wfx1FT_kyqFKdatf57RfKLrh+Jte1J8ZmA@mail.gmail.com>
Subject: Re: [PATCH] block: note about cloned bios and bio_for_each_segment_all
To: David Sterba <dsterba@suse.com>
Cc: linux-block <linux-block@vger.kernel.org>,
        Liu Bo <bo.li.liu@oracle.com>, fdmanana@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 14, 2017 at 9:40 PM, David Sterba <dsterba@suse.com> wrote:
> We've switched to cloned bios in btrfs and hit a nasty bug leading to
> corruptions, when cloned bios are iterated by bio_for_each_segment_all.

No, you simply can't use bio_for_each_segment_all on cloned bio, and the
reason is obviously.

>
> Report and fix:
> https://patchwork.kernel.org/patch/9838535/
>
> As a matter of precaution, we've added assertions to btrfs code to catch
> the bad usage pattern:
>
> https://patchwork.kernel.org/patch/9839267/
>
> The cloned/bi_vcnt behaviour seems tobe implementation dependent and is
> not documented, so this patch at least warns about this one particular
> case but this might still be insufficient.
>
> CC: linux-block@vger.kernel.org
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  include/linux/bio.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 7b1cf4ba0902..f1ac84edcf39 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -156,6 +156,9 @@ static inline void *bio_data(struct bio *bio)
>  /*
>   * drivers should _never_ use the all version - the bio may have been split
>   * before it got to the driver and the driver won't own all of it
> + *
> + * Note that cloned bios must not use this as their bi_vcnt may be invalid and
> + * this could lead to silent corruptions.
>   */
>  #define bio_for_each_segment_all(bvl, bio, i)                          \
>         for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
> --
> 2.13.0
>

Maybe we can add a warning here if it is a cloned bio.


-- 
Ming Lei
