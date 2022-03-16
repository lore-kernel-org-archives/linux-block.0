Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1DFC433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 13:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbiCPNQb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 09:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345521AbiCPNQa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 09:16:30 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBF1403FE
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 06:15:15 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22GDEsas050630;
        Wed, 16 Mar 2022 22:14:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Wed, 16 Mar 2022 22:14:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22GDEsWk050626
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 16 Mar 2022 22:14:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <26f0d3da-d45e-72aa-de2f-62ead4d2c25b@I-love.SAKURA.ne.jp>
Date:   Wed, 16 Mar 2022 22:14:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 7/8] loop: remove lo_refcount and avoid lo_mutex in ->open
 / ->release
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
References: <20220316084519.2850118-1-hch@lst.de>
 <20220316084519.2850118-8-hch@lst.de>
 <20220316112258.6hjksrv7yqiqcncu@quack3.lan>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220316112258.6hjksrv7yqiqcncu@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/03/16 20:22, Jan Kara wrote:
>> @@ -1244,7 +1244,7 @@ static int loop_clr_fd(struct loop_device *lo)
>>  	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
>>  	 * command to fail with EBUSY.
>>  	 */
>> -	if (atomic_read(&lo->lo_refcnt) > 1) {
>> +	if (lo->lo_disk->part0->bd_openers > 1) {
> 
> But bd_openers can be read safely only under disk->open_mutex. So for this
> to be safe against compiler playing nasty tricks with optimizations, we
> need to either make bd_openers atomic_t or use READ_ONCE / WRITE_ONCE when
> accessing it.

Use of READ_ONCE() / WRITE_ONCE() are not for avoiding races but for making
sure that memory access happens only once. It is data_race() which is needed
for tolerating and annotating races. For example, data_race(lo->lo_state) is
needed when accessing lo->lo_state without lo->lo_mutex held.

Use of atomic_t for lo->lo_disk->part0->bd_openers does not help, for currently
lo->lo_mutex is held in order to avoid races. That is, it is disk->open_mutex
which loop_clr_fd() needs to hold when accessing lo->lo_disk->part0->bd_openers.

