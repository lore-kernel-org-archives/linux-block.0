Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36775 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935440AbdACO6w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2017 09:58:52 -0500
Subject: Re: [PATCH v1 45/54] exofs: convert to bio_for_each_segment_all_sp()
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@fb.com>,
        linux-kernel@vger.kernel.org
References: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
 <1482854706-14128-14-git-send-email-tom.leiming@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Benny Halevy <bhalevy@primarydata.com>,
        "open list:OSD LIBRARY and FILESYSTEM" <osd-dev@open-osd.org>
From: Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <7a405d59-7d59-4db2-a511-4c109f7f8017@electrozaur.com>
Date: Tue, 3 Jan 2017 16:58:48 +0200
MIME-Version: 1.0
In-Reply-To: <1482854706-14128-14-git-send-email-tom.leiming@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/27/2016 06:04 PM, Ming Lei wrote:
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>

Cool
ACK-by: Boaz Harrosh <ooo@electrozaur.com>

> ---
>  fs/exofs/ore.c      | 3 ++-
>  fs/exofs/ore_raid.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/exofs/ore.c b/fs/exofs/ore.c
> index 8bb72807e70d..38a7d8bfdd4c 100644
> --- a/fs/exofs/ore.c
> +++ b/fs/exofs/ore.c
> @@ -406,8 +406,9 @@ static void _clear_bio(struct bio *bio)
>  {
>  	struct bio_vec *bv;
>  	unsigned i;
> +	struct bvec_iter_all bia;
>  
> -	bio_for_each_segment_all(bv, bio, i) {
> +	bio_for_each_segment_all_sp(bv, bio, i, bia) {
>  		unsigned this_count = bv->bv_len;
>  
>  		if (likely(PAGE_SIZE == this_count))
> diff --git a/fs/exofs/ore_raid.c b/fs/exofs/ore_raid.c
> index 27cbdb697649..37c0a9aa2ec2 100644
> --- a/fs/exofs/ore_raid.c
> +++ b/fs/exofs/ore_raid.c
> @@ -429,6 +429,7 @@ static void _mark_read4write_pages_uptodate(struct ore_io_state *ios, int ret)
>  {
>  	struct bio_vec *bv;
>  	unsigned i, d;
> +	struct bvec_iter_all bia;
>  
>  	/* loop on all devices all pages */
>  	for (d = 0; d < ios->numdevs; d++) {
> @@ -437,7 +438,7 @@ static void _mark_read4write_pages_uptodate(struct ore_io_state *ios, int ret)
>  		if (!bio)
>  			continue;
>  
> -		bio_for_each_segment_all(bv, bio, i) {
> +		bio_for_each_segment_all_sp(bv, bio, i, bia) {
>  			struct page *page = bv->bv_page;
>  
>  			SetPageUptodate(page);
> 

