Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2B1C169C4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 14:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1013E218A4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 14:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfBFOhr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:37:47 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:21215 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfBFOhr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Feb 2019 09:37:47 -0500
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x16Eba96029941;
        Wed, 6 Feb 2019 23:37:36 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Wed, 06 Feb 2019 23:37:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x16EbYln029932
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 6 Feb 2019 23:37:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] fs: ratelimit __find_get_block_slow() failure message.
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, Jan Kara <jack@suse.cz>
References: <1548078577-10353-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d4f41aae-ec33-e2fe-05a9-3ed15269ca68@i-love.sakura.ne.jp>
Date:   Wed, 6 Feb 2019 23:37:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1548078577-10353-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Jens. Can we apply this patch?

On 2019/01/21 22:49, Tetsuo Handa wrote:
> When something let __find_get_block_slow() hit all_mapped path, it calls
> printk() for 100+ times per a second. But there is no need to print same
> message with such high frequency; it is just asking for stall warning, or
> at least bloating log files.
> 
>   [  399.866302][T15342] __find_get_block_slow() failed. block=1, b_blocknr=8
>   [  399.873324][T15342] b_state=0x00000029, b_size=512
>   [  399.878403][T15342] device loop0 blocksize: 4096
>   [  399.883296][T15342] __find_get_block_slow() failed. block=1, b_blocknr=8
>   [  399.890400][T15342] b_state=0x00000029, b_size=512
>   [  399.895595][T15342] device loop0 blocksize: 4096
>   [  399.900556][T15342] __find_get_block_slow() failed. block=1, b_blocknr=8
>   [  399.907471][T15342] b_state=0x00000029, b_size=512
>   [  399.912506][T15342] device loop0 blocksize: 4096
> 
> This patch reduces frequency to up to once per a second, in addition to
> concatenating three lines into one.
> 
>   [  399.866302][T15342] __find_get_block_slow() failed. block=1, b_blocknr=8, b_state=0x00000029, b_size=512, device loop0 blocksize: 4096
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  fs/buffer.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 52d024b..48318fb 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -200,6 +200,7 @@ void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
>  	struct buffer_head *head;
>  	struct page *page;
>  	int all_mapped = 1;
> +	static DEFINE_RATELIMIT_STATE(last_warned, HZ, 1);
>  
>  	index = block >> (PAGE_SHIFT - bd_inode->i_blkbits);
>  	page = find_get_page_flags(bd_mapping, index, FGP_ACCESSED);
> @@ -227,15 +228,15 @@ void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
>  	 * file io on the block device and getblk.  It gets dealt with
>  	 * elsewhere, don't buffer_error if we had some unmapped buffers
>  	 */
> -	if (all_mapped) {
> -		printk("__find_get_block_slow() failed. "
> -			"block=%llu, b_blocknr=%llu\n",
> -			(unsigned long long)block,
> -			(unsigned long long)bh->b_blocknr);
> -		printk("b_state=0x%08lx, b_size=%zu\n",
> -			bh->b_state, bh->b_size);
> -		printk("device %pg blocksize: %d\n", bdev,
> -			1 << bd_inode->i_blkbits);
> +	ratelimit_set_flags(&last_warned, RATELIMIT_MSG_ON_RELEASE);
> +	if (all_mapped && __ratelimit(&last_warned)) {
> +		printk("__find_get_block_slow() failed. block=%llu, "
> +		       "b_blocknr=%llu, b_state=0x%08lx, b_size=%zu, "
> +		       "device %pg blocksize: %d\n",
> +		       (unsigned long long)block,
> +		       (unsigned long long)bh->b_blocknr,
> +		       bh->b_state, bh->b_size, bdev,
> +		       1 << bd_inode->i_blkbits);
>  	}
>  out_unlock:
>  	spin_unlock(&bd_mapping->private_lock);
> 

