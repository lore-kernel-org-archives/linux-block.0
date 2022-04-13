Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189BCC433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 12:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiDMM22 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 08:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiDMM20 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 08:28:26 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94FD5D66F
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 05:26:01 -0700 (PDT)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23DCPxd3028863;
        Wed, 13 Apr 2022 21:25:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Wed, 13 Apr 2022 21:25:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23DCPxSO028859
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Apr 2022 21:25:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f3757d4b-fc2a-b0e2-4117-d7a7fb3f0f53@I-love.SAKURA.ne.jp>
Date:   Wed, 13 Apr 2022 21:25:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] block/rnbd-clt: Avoid flush_workqueue(system_long_wq)
 usage
Content-Language: en-US
To:     Jack Wang <jinpu.wang@ionos.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com,
        Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
References: <20220413121315.63684-1-jinpu.wang@ionos.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220413121315.63684-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for a patch.

On 2022/04/13 21:13, Jack Wang wrote:
> @@ -1792,6 +1793,13 @@ static int __init rnbd_client_init(void)
>  		       err);
>  		unregister_blkdev(rnbd_client_major, "rnbd");

I think you want

		return err;

here so that alloc_workqueue() won't be called when
rnbd_clt_create_sysfs_files() returned an error.

>  	}
> +	rnbd_clt_wq = alloc_workqueue("rnbd_clt_wq", 0, 0);
> +	if (!rnbd_clt_wq) {
> +		pr_err("Failed to load module, alloc_workqueue failed.\n");
> +		rnbd_clt_destroy_sysfs_files();
> +		unregister_blkdev(rnbd_client_major, "rnbd");
> +		err = -ENOMEM;
> +	}
>  
>  	return err;
>  }
