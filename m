Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E480C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 15:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiBPPcM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:32:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiBPPcK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 10:32:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7AEDD45A
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 07:31:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2E8F221114;
        Wed, 16 Feb 2022 15:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645025517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zbdy6hJHDF/2mJsn5QvJwk5ZRTiby8DvmOJZl2ko1y8=;
        b=lBZhU7lzds60u7O5YW7JsmfffYx1leYULjLRVd4jPFosK8T9tYrdcV/9TI9qSfnWwVL86W
        0o/DdwRve/nudORd4aMUn+FMdxd5/5F6GfGslvzQjUpPQ850IdOo8BiWxKP6Xu8+jpr5Vx
        vKNy3PC5B+8gGu+zboyBVEVcZD33f9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645025517;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zbdy6hJHDF/2mJsn5QvJwk5ZRTiby8DvmOJZl2ko1y8=;
        b=+TE5Bzno6bmi0gB8v7sswCZgm8pWItk4MSo5FWnVH658Cm5ds1/Nc5jN5tOYik3fTYqLBX
        NOGOrExHP5VyCPBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1AE1413B15;
        Wed, 16 Feb 2022 15:31:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0YLsBe0YDWJ8MwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 16 Feb 2022 15:31:57 +0000
Message-ID: <6328baac-fe6f-f3ef-ca4b-d8c91b4a83ee@suse.de>
Date:   Wed, 16 Feb 2022 16:31:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] block: skip the fsync_bdev call in del_gendisk for
 surprise removals
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, kbusch@kernel.org, markus.bloechl@ipetronik.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20220216150901.4166235-1-hch@lst.de>
 <20220216150901.4166235-2-hch@lst.de>
 <4f29d9a3-021c-f2f0-b452-e682fa1db459@suse.de>
 <20220216152019.GA19002@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220216152019.GA19002@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/16/22 16:20, Christoph Hellwig wrote:
> On Wed, Feb 16, 2022 at 04:18:43PM +0100, Hannes Reinecke wrote:
>> My turn to be picky:
>> In the previous patch you use 'set_bit()' for GD_DEAD, which to my
>> knowledge doesn't imply a memory barrier.
>> Yet here you rely on that for the 'test_bit()' to return the correct/most
>> recent value.
>> Don't we need a memory barrier here somewhere?
> 
> Well, we only do the test to skip useless work.  A race is not a
> problem here.

Ok.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
