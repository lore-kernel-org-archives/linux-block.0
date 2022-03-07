Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35CFC433F5
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 06:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiCGGke (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 01:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiCGGke (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 01:40:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB83122B3F
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 22:39:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A99041F38E;
        Mon,  7 Mar 2022 06:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646635178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t9EpyugG2TT39WsWw1zcuRbGFSjnjucSQp9oP2Z+wqY=;
        b=K8V1R7+YIruOwtKXu9GyMoDD8yuqTmSQoMzIYAXh3+BI/8GwOVtgQll/q5oM6IRsKfojYB
        soNk/Zw7YBzTmCJlllsQS/D1dpatiOhd48Cndo2s0NS1VHjPx49gqvUEEk0B9AegBeD7v7
        mt9ZP2f5tXrkQ5wgZTgS2NQoGDx0J5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646635178;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t9EpyugG2TT39WsWw1zcuRbGFSjnjucSQp9oP2Z+wqY=;
        b=7zoQKii9WmaUOOFefr4gjJFp4CmSQvL+XzxEPfr/eBU5qXPfISvPrvblx626Ud7VOGg2Z8
        hrIO3Ci9IEEQtoAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94A20132C1;
        Mon,  7 Mar 2022 06:39:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +ODzIKqoJWIbQwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 07 Mar 2022 06:39:38 +0000
Message-ID: <6f24cfc9-09b9-67bc-d15b-d3aff238d923@suse.de>
Date:   Mon, 7 Mar 2022 07:39:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] block: emit disk ro uevent in device_add_disk()
Content-Language: en-US
To:     Uday Shankar <ushankar@purestorage.com>,
        linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
References: <20220303175219.272938-1-ushankar@purestorage.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220303175219.272938-1-ushankar@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/3/22 18:52, Uday Shankar wrote:
> Userspace learns of disk ro state via the change event emitted by
> set_disk_ro_uevent. This function has cyclic dependency with
> device_add_disk: the latter performs kobject initialization that is
> necessary for uevents to go through, but we want to set up properties
> like ro state before exposing the disk to userspace via device_add_disk.
> 
> The usual workaround is to call set_disk_ro both before and after
> device_add_disk; the purpose of the "after" call is just to emit the
> uevent. Moreover, because set_disk_ro only emits a uevent when the ro
> state changes, set_disk_ro needs to be called twice in the "after"
> position to ensure that the ro state flips. See drivers/scsi/sd.c for an
> example of this pattern.
> 
> The nvme driver does not implement this pattern. It only calls
> set_disk_ro before device_add_disk, and so the ro uevent is never
> emitted. This breaks applications such as dm-multipath. To avoid
> introducing the messy pattern above into the nvme driver, emit the disk
> ro uevent immediately after announcing addition of the disk.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>   block/genhd.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 11c761afd64f..89a110f0b002 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -394,6 +394,16 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>   	return 0;
>   }
>   
> +static void set_disk_ro_uevent(struct gendisk *gd, int ro)
> +{
> +	char event[] = "DISK_RO=1";
> +	char *envp[] = { event, NULL };
> +
> +	if (!ro)
> +		event[8] = '0';
> +	kobject_uevent_env(&disk_to_dev(gd)->kobj, KOBJ_CHANGE, envp);
> +}
> +
>   /**
>    * device_add_disk - add disk information to kernel list
>    * @parent: parent device for the disk
> @@ -522,6 +532,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>   		 */
>   		dev_set_uevent_suppress(ddev, 0);
>   		disk_uevent(disk, KOBJ_ADD);
> +		set_disk_ro_uevent(disk, get_disk_ro(disk));
>   	}
>   
>   	disk_update_readahead(disk);
> @@ -1419,16 +1430,6 @@ void blk_cleanup_disk(struct gendisk *disk)
>   }
>   EXPORT_SYMBOL(blk_cleanup_disk);
>   
> -static void set_disk_ro_uevent(struct gendisk *gd, int ro)
> -{
> -	char event[] = "DISK_RO=1";
> -	char *envp[] = { event, NULL };
> -
> -	if (!ro)
> -		event[8] = '0';
> -	kobject_uevent_env(&disk_to_dev(gd)->kobj, KOBJ_CHANGE, envp);
> -}
> -
>   /**
>    * set_disk_ro - set a gendisk read-only
>    * @disk:	gendisk to operate on

How very odd.

Why not add the 'DISK_RO=1' setting directly to the 'add' event?
That would be the logical thing to do, no?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
