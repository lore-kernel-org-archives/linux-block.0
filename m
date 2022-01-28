Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5E8C433EF
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 13:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiA1NO1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 08:14:27 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:60553 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiA1NOZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 08:14:25 -0500
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20SDDwII057872;
        Fri, 28 Jan 2022 22:13:58 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Fri, 28 Jan 2022 22:13:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20SDDwue057862
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 28 Jan 2022 22:13:58 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <397e50c7-ae46-8834-1632-7bac1ad7df99@I-love.SAKURA.ne.jp>
Date:   Fri, 28 Jan 2022 22:13:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/8] loop: only take lo_mutex for the first reference in
 lo_open
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
References: <20220128130022.1750906-1-hch@lst.de>
 <20220128130022.1750906-6-hch@lst.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220128130022.1750906-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/28 22:00, Christoph Hellwig wrote:
> +	if (atomic_inc_return(&lo->lo_refcnt) > 1)
> +		return 0;
> +
>  	err = mutex_lock_killable(&lo->lo_mutex);
>  	if (err)

You did not notice my diff here...

>  		return err;
> -	if (lo->lo_state == Lo_deleting)
> +	if (lo->lo_state == Lo_deleting) {
> +		atomic_dec(&lo->lo_refcnt);
>  		err = -ENXIO;
> -	else
> -		atomic_inc(&lo->lo_refcnt);
> +	}

Why do we need [PATCH 1/8] [PATCH 2/8] [PATCH 3/8] in this series?
Shouldn't we first make a clean revert, and keep the changes for
this release cycle as small as possible?
