Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD0FC433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 14:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350813AbiCXO0V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 10:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350754AbiCXO0U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 10:26:20 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DFD76E11
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 07:24:48 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22OEOkkF045918;
        Thu, 24 Mar 2022 23:24:46 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Thu, 24 Mar 2022 23:24:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22OEOjGM045915
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 24 Mar 2022 23:24:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <96a4e2e7-e16e-7e89-255d-8aa29ffca68b@I-love.SAKURA.ne.jp>
Date:   Thu, 24 Mar 2022 23:24:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 12/13] loop: remove lo_refcount and avoid lo_mutex in
 ->open / ->release
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
References: <20220324075119.1556334-1-hch@lst.de>
 <20220324075119.1556334-13-hch@lst.de>
 <20220324141321.pqesnshaswwk3svk@quack3.lan>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220324141321.pqesnshaswwk3svk@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/03/24 23:13, Jan Kara wrote:
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index b3170e8cdbe95..e1eb925d3f855 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -1244,7 +1244,7 @@ static int loop_clr_fd(struct loop_device *lo)
>>  	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
>>  	 * command to fail with EBUSY.
>>  	 */
>> -	if (atomic_read(&lo->lo_refcnt) > 1) {
>> +	if (disk_openers(lo->lo_disk) > 1) {

This is sometimes "if (0) {" due to not holding disk->open_mutex.

>>  		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
>>  		mutex_unlock(&lo->lo_mutex);
>>  		return 0;
