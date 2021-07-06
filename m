Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63070C07E96
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 05:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39BD261988
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 05:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhGFFtD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 01:49:03 -0400
Received: from verein.lst.de ([213.95.11.211]:59198 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230034AbhGFFtD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jul 2021 01:49:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2C48468BEB; Tue,  6 Jul 2021 07:46:23 +0200 (CEST)
Date:   Tue, 6 Jul 2021 07:46:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Vorel <pvorel@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: reintroduce global lock for safe
 loop_validate_file() traversal
Message-ID: <20210706054622.GE17027@lst.de>
References: <20210702153036.8089-1-penguin-kernel@I-love.SAKURA.ne.jp> <288edd89-a33f-2561-cee9-613704c3da20@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <288edd89-a33f-2561-cee9-613704c3da20@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static int loop_global_lock_killable(struct loop_device *lo, bool global)
> +{
> +	int err;
> +
> +	if (global) {
> +		err = mutex_lock_killable(&loop_validate_mutex);
> +		if (err)
> +			return err;
> +	}
> +	err = mutex_lock_killable(&lo->lo_mutex);
> +	if (err && global)
> +		mutex_unlock(&loop_validate_mutex);
> +	return err;
> +}
> +
> +static void loop_global_unlock(struct loop_device *lo, bool global)
> +{
> +	mutex_unlock(&lo->lo_mutex);
> +	if (global)
> +		mutex_unlock(&loop_validate_mutex);
> +}

Comments explaining these functions would be nice.

>  static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  			  unsigned int arg)
>  {
> -	struct file	*file = NULL, *old_file;
> +	struct file *file = fget(arg);
> +	struct file *old_file;
>  	int		error;
>  	bool		partscan;
> +	bool is_loop;

This doesn't match the existing formatting.  Either keep the existing
one or change the few other variables as well.

> +	is_loop = is_loop_device(file);
> +	error = loop_global_lock_killable(lo, is_loop);
> +	if (error) {
> +		fput(file);
>  		return error;
> +	}

Please use a goto label to share the fput with the other error handling.

> @@ -1143,6 +1167,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	loff_t		size;
>  	bool		partscan;
>  	unsigned short  bsize;
> +	bool is_loop;

Please follow the existing formatting.

Otherwise this looks reasonable to me.
