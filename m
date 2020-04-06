Return-Path: <SRS0=Ayt2=5W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C00C2BA80
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 09:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDC820781
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 09:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDFJLH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:11:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:36872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgDFJLH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Apr 2020 05:11:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B8358AC40;
        Mon,  6 Apr 2020 09:11:03 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC 3/3] block: avoid deferral of blk_release_queue() work
References: <20200402000002.7442-1-mcgrof@kernel.org>
        <20200402000002.7442-4-mcgrof@kernel.org>
        <774a33e8-43ba-143f-f6fd-9cb0ae0862ac@acm.org>
        <87o8saj62m.fsf@suse.de>
Date:   Mon, 06 Apr 2020 11:11:01 +0200
In-Reply-To: <87o8saj62m.fsf@suse.de> (Nicolai Stange's message of "Thu, 02
        Apr 2020 16:49:37 +0200")
Message-ID: <87eet1j7x6.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Nicolai Stange <nstange@suse.de> writes:

> Bart Van Assche <bvanassche@acm.org> writes:
>
>> The description of this patch mentions a single blk_release_queue() call
>> that happened in the past from a context from which sleeping is not
>> allowed and from which sleeping is allowed today. Have all other
>> blk_release_queue() / blk_put_queue() calls been verified to see whether
>> none of these happens from a context from which sleeping is not allowed?
>
> I've just done this today and found the following potentially
> problematic call paths to blk_put_queue().
>
> 1.) mem_cgroup_throttle_swaprate() takes a spinlock and
>     calls blkcg_schedule_throttle()->blk_put_queue().
>
>     Also note that AFAICS mem_cgroup_try_charge_delay() can be called
>     with GFP_ATOMIC.
>
> 2.) scsi_unblock_requests() gets called from a lot of drivers and
>     invoke blk_put_queue() through
>     scsi_unblock_requests() -> scsi_run_host_queues() ->
>     scsi_starved_list_run() -> blk_put_queue().
>
>     Most call sites are fine, the ones which are not are:
>     a.) pmcraid_complete_ioa_reset(). This gets assigned
>         to struct pmcraid_cmd's ->cmd_done and later invoked
>         under a spinlock.
>
>     b.) qla82xx_fw_dump() and qla8044_fw_dump().
>         These can potentially block w/o this patch already,
>         because both invoke qla2x00_wait_for_chip_reset().
>
> 	However, they can get called from IRQ context. For example,
>         qla82xx_intr_handler(), qla82xx_msix_default() and
>         qla82xx_poll() call qla2x00_async_event(), which calls
>         ->fw_dump().
>
> 	The aforementioned functions can also reach ->fw_dump() through
>         qla24xx_process_response_queue()->qlt_handle_abts_recv()->qlt_response_pkt_all_vps()
>         ->qlt_response_pkt()->qlt_handle_abts_completion()->qlt_chk_unresolv_exchg()
>         -> ->fw_dump().
>
> 	But I'd consider this a problem with the driver -- either
> 	->fw_dump() can sleep and must not be called from IRQ context
>         or they must not invoke qla2x00_wait_for_hba_ready().
>
>
> (I can share the full analysis, but it's lengthy and contains nothing
>  interesting except for what is listed above).
>
>
> One final note though: If I'm not mistaken, then the final
> blk_put_queue() can in principle block even today, simply by virtue of
> the kernfs operations invoked through
> kobject_put()->kobject_release()->kobject_cleanup()->kobject_del()
> ->sysfs_remove_dir()->kernfs_remove()->mutex_lock()?\

That's wrong, I missed kobject_del() invocation issued from
blk_unregister_queue(). Thus, blk_put_queue() in its current
implementation won't ever block.

Thanks,

Nicolai

-- 
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg), GF: Felix Imendörffer
